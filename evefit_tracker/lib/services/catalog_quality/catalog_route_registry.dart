import 'dart:convert';
import 'dart:io';

import '../../models/exercise.dart';
import '../equipment_catalog_service.dart';
import '../exercise_catalog_context_service.dart';
import '../exercise_taxonomy_service.dart';
import '../training_architecture.dart';

class CatalogRoute {
  const CatalogRoute({
    required this.id,
    required this.typeKey,
    required this.locationKey,
    required this.equipmentKey,
    this.regionKey = '',
    this.groupKey = '',
    this.subzoneKey = '',
    this.focusKey = '',
    this.cardioFocusKey = '',
    this.martialArtKey = '',
    this.mobilityZoneKey = '',
    this.recoveryKey = '',
    this.reason = '',
  });

  final String id;
  final String typeKey;
  final String locationKey;
  final String equipmentKey;
  final String regionKey;
  final String groupKey;
  final String subzoneKey;
  final String focusKey;
  final String cardioFocusKey;
  final String martialArtKey;
  final String mobilityZoneKey;
  final String recoveryKey;
  final String reason;

  Map<String, Object?> toJson() => {
    'id': id,
    'type_key': typeKey,
    'location_key': locationKey,
    'equipment_key': equipmentKey,
    'region_key': regionKey,
    'group_key': groupKey,
    'subzone_key': subzoneKey,
    'focus_key': focusKey,
    'cardio_focus_key': cardioFocusKey,
    'martial_art_key': martialArtKey,
    'mobility_zone_key': mobilityZoneKey,
    'recovery_key': recoveryKey,
    'reason': reason,
  };
}

class CatalogRouteRegistry {
  const CatalogRouteRegistry({
    required this.exerciseRoutes,
    required this.routeExercises,
    required this.unreachableExercises,
    required this.internalExerciseKeys,
    required this.lookupAliases,
  });

  final Map<String, List<CatalogRoute>> exerciseRoutes;
  final Map<String, List<String>> routeExercises;
  final List<Exercise> unreachableExercises;
  final Set<String> internalExerciseKeys;
  final Map<String, String> lookupAliases;

  Set<String> get visibleReachableExerciseKeys => exerciseRoutes.keys.toSet();

  int get usableCleanExerciseCount => visibleReachableExerciseKeys.length;

  List<CatalogRoute> routesForExercise(String key) {
    final canonicalKey = lookupAliases[key] ?? key;
    return exerciseRoutes[canonicalKey] ?? const [];
  }

  static CatalogRouteRegistry build({List<Exercise>? exercises}) {
    final allExercises =
        exercises ??
        ExerciseCatalogContextService.entries
            .map(ExerciseTaxonomyService.enrichCatalogExercise)
            .toList(growable: false);

    final exerciseRoutes = <String, List<CatalogRoute>>{};
    final routeExercises = <String, List<String>>{};
    final aliases = <String, String>{};
    final internal = <String>{};

    for (final exercise in allExercises) {
      final key = exercise.catalogEntryKey;
      aliases[key] = key;
      if (exercise.exerciseKey.isNotEmpty) aliases[exercise.exerciseKey] = key;
      if (exercise.canonicalId.isNotEmpty) aliases[exercise.canonicalId] = key;
      for (final alias in exercise.aliases) {
        aliases[alias] = key;
      }

      if (exercise.isHidden) {
        internal.add(key);
        continue;
      }

      final routes = _routesFor(exercise);
      if (routes.isEmpty) continue;
      exerciseRoutes[key] = List.unmodifiable(routes);
      for (final route in routes) {
        routeExercises.putIfAbsent(route.id, () => <String>[]).add(key);
      }
    }

    final unreachable = allExercises
        .where(
          (exercise) =>
              !exercise.isHidden &&
              !exerciseRoutes.containsKey(exercise.catalogEntryKey),
        )
        .toList(growable: false);

    return CatalogRouteRegistry(
      exerciseRoutes: Map.unmodifiable(exerciseRoutes),
      routeExercises: Map<String, List<String>>.unmodifiable(
        routeExercises.map(
          (key, value) => MapEntry(key, List<String>.unmodifiable(value)),
        ),
      ),
      unreachableExercises: List.unmodifiable(unreachable),
      internalExerciseKeys: Set.unmodifiable(internal),
      lookupAliases: Map.unmodifiable(aliases),
    );
  }

  static List<CatalogRoute> _routesFor(Exercise exercise) {
    final routeTypes = <String>{
      _typeForExercise(exercise.primaryType),
      for (final type in exercise.secondaryTypes) _typeForExercise(type),
    }..removeWhere((type) => type.isEmpty || type == 'custom');

    if (routeTypes.isEmpty) return const [];
    final routes = <CatalogRoute>[];
    for (final typeKey in routeTypes) {
      routes.add(_routeForType(exercise, typeKey));
    }
    return routes;
  }

  static CatalogRoute _routeForType(Exercise exercise, String typeKey) {
    final tags = TrainingArchitecture.tagsForExercise(exercise);
    final equipment = _primaryEquipment(exercise, typeKey);
    final location = _locationFor(exercise, typeKey, equipment);
    final region = _firstUsable(
      tags.regionKeys,
      fallback: typeKey == 'strength' ? 'full_body' : '',
      excluded: const {'custom'},
    );
    final group = _firstUsable(tags.groupKeys);
    final subzone = _firstUsable(tags.subgroupKeys);
    final focus = _focusFor(exercise, typeKey, tags);

    final route = switch (typeKey) {
      'cardio' => CatalogRoute(
        id: _join([
          'cardio',
          location,
          equipment,
          _cardioFocusFor(exercise, equipment),
        ]),
        typeKey: 'cardio',
        locationKey: location,
        equipmentKey: equipment,
        regionKey: region,
        cardioFocusKey: _cardioFocusFor(exercise, equipment),
        reason: 'cardio route inferred from equipment and focus tags',
      ),
      'martial_arts' => CatalogRoute(
        id: _join(['martial_arts', location, _martialArtFor(exercise), focus]),
        typeKey: 'martial_arts',
        locationKey: location,
        equipmentKey: equipment,
        regionKey: 'martial_arts',
        focusKey: focus,
        martialArtKey: _martialArtFor(exercise),
        reason: 'martial route inferred from context and technical focus',
      ),
      'mobility' => CatalogRoute(
        id: _join(['mobility', location, equipment, focus]),
        typeKey: 'mobility',
        locationKey: location,
        equipmentKey: equipment,
        regionKey: region,
        groupKey: group,
        subzoneKey: subzone,
        focusKey: focus,
        mobilityZoneKey: focus.isEmpty ? 'general_mobility' : focus,
        reason: 'mobility route inferred from anatomy and context tags',
      ),
      'recovery' => CatalogRoute(
        id: _join(['recovery', location, equipment, _recoveryFocus(exercise)]),
        typeKey: 'recovery',
        locationKey: location,
        equipmentKey: equipment,
        regionKey: region,
        focusKey: _recoveryFocus(exercise),
        recoveryKey: _recoveryFocus(exercise),
        reason: 'recovery route inferred from recovery focus cues',
      ),
      'elasticity' || 'warmup' || 'activation' || 'prevention' => CatalogRoute(
        id: _join([
          typeKey,
          location,
          equipment,
          region,
          group,
          subzone,
          focus,
        ]),
        typeKey: typeKey,
        locationKey: location,
        equipmentKey: equipment,
        regionKey: region,
        groupKey: group,
        subzoneKey: subzone,
        focusKey: focus,
        reason: 'simple domain route inferred from taxonomy tags',
      ),
      _ => CatalogRoute(
        id: _join([
          'strength',
          location,
          equipment,
          region,
          group,
          subzone,
          focus,
        ]),
        typeKey: 'strength',
        locationKey: location,
        equipmentKey: equipment,
        regionKey: region,
        groupKey: group,
        subzoneKey: subzone,
        focusKey: focus,
        reason: 'strength route inferred from equipment and anatomy tags',
      ),
    };
    return route;
  }

  static void writeReachabilityReports({
    required Directory directory,
    required List<Exercise> beforeUnreachable,
    required CatalogRouteRegistry afterRegistry,
  }) {
    directory.createSync(recursive: true);
    _writeReachabilityTriage(directory, beforeUnreachable, afterRegistry);
    _writeReachabilityAfter(directory, beforeUnreachable, afterRegistry);
  }

  static void _writeReachabilityTriage(
    Directory directory,
    List<Exercise> beforeUnreachable,
    CatalogRouteRegistry afterRegistry,
  ) {
    final rows = beforeUnreachable
        .map((exercise) {
          final routes = afterRegistry.routesForExercise(
            exercise.catalogEntryKey,
          );
          final classification = routes.isNotEmpty
              ? 'A. falso positivo da matriz'
              : 'B. exercicio real sem rota';
          return {
            'name': exercise.name,
            'catalog_entry_key': exercise.catalogEntryKey,
            'primary_type': exercise.primaryType,
            'classification': classification,
            'route_count': routes.length,
            'routes': routes.map((route) => route.id).join('; '),
          };
        })
        .toList(growable: false);

    File(
      '${directory.path}/reachability_triage.json',
    ).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(rows));
    File('${directory.path}/reachability_triage.csv').writeAsStringSync(
      _csv([
        'name',
        'catalog_entry_key',
        'primary_type',
        'classification',
        'route_count',
        'routes',
      ], rows),
    );
    final buffer = StringBuffer()
      ..writeln('# v0.9.6 Reachability Triage')
      ..writeln()
      ..writeln('- Before inaccessible exercises: ${beforeUnreachable.length}')
      ..writeln(
        '- Reclassified as matrix false positives: ${rows.where((row) => row['classification'] == 'A. falso positivo da matriz').length}',
      )
      ..writeln(
        '- Still without route: ${rows.where((row) => row['classification'] != 'A. falso positivo da matriz').length}',
      )
      ..writeln()
      ..writeln('| Exercise | Catalog entry | Type | Classification | Route |')
      ..writeln('|---|---|---|---|---|');
    for (final row in rows) {
      buffer.writeln(
        '| ${row['name']} | `${row['catalog_entry_key']}` | ${row['primary_type']} | ${row['classification']} | ${row['routes']} |',
      );
    }
    File(
      '${directory.path}/reachability_triage.md',
    ).writeAsStringSync(buffer.toString());
  }

  static void _writeReachabilityAfter(
    Directory directory,
    List<Exercise> beforeUnreachable,
    CatalogRouteRegistry afterRegistry,
  ) {
    final afterUnreachable = afterRegistry.unreachableExercises;
    final byType = <String, int>{};
    for (final exercise in afterUnreachable) {
      byType.update(
        exercise.primaryType,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }
    final summary = {
      'before_unreachable': beforeUnreachable.length,
      'after_unreachable': afterUnreachable.length,
      'after_usable_clean': afterRegistry.usableCleanExerciseCount,
      'after_unreachable_by_type': byType,
      'remaining_unreachable': afterUnreachable
          .map(
            (exercise) => {
              'name': exercise.name,
              'catalog_entry_key': exercise.catalogEntryKey,
              'primary_type': exercise.primaryType,
            },
          )
          .toList(),
    };

    File(
      '${directory.path}/reachability_after.json',
    ).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(summary));
    File('${directory.path}/reachability_after.csv').writeAsStringSync(
      _csv(
        ['name', 'catalog_entry_key', 'primary_type'],
        afterUnreachable
            .map(
              (exercise) => {
                'name': exercise.name,
                'catalog_entry_key': exercise.catalogEntryKey,
                'primary_type': exercise.primaryType,
              },
            )
            .toList(),
      ),
    );
    final buffer = StringBuffer()
      ..writeln('# v0.9.6 Reachability After')
      ..writeln()
      ..writeln('- Before inaccessible exercises: ${beforeUnreachable.length}')
      ..writeln('- After inaccessible exercises: ${afterUnreachable.length}')
      ..writeln(
        '- After usable clean exercises: ${afterRegistry.usableCleanExerciseCount}',
      )
      ..writeln()
      ..writeln('## Remaining Inaccessible')
      ..writeln();
    if (afterUnreachable.isEmpty) {
      buffer.writeln('No remaining inaccessible visible exercises.');
    } else {
      for (final exercise in afterUnreachable) {
        buffer.writeln(
          '- ${exercise.name} `${exercise.catalogEntryKey}` (${exercise.primaryType})',
        );
      }
    }
    File(
      '${directory.path}/reachability_after.md',
    ).writeAsStringSync(buffer.toString());
  }

  static String _typeForExercise(String type) {
    return switch (type) {
      'musculacao' => 'strength',
      'artes_marciais' => 'martial_arts',
      'mobilidade' => 'mobility',
      'elasticidade' => 'elasticity',
      'recuperacao' => 'recovery',
      'aquecimento' => 'warmup',
      'ativacao' => 'activation',
      'prevencao' => 'prevention',
      _ => type,
    };
  }

  static String _primaryEquipment(Exercise exercise, String typeKey) {
    final equipment = TrainingArchitecture.tagsForExercise(
      exercise,
    ).equipmentKeys;
    if (typeKey == 'martial_arts') {
      if (equipment.contains('tatami')) return 'tatami';
      if (equipment.contains('mat')) return 'mat';
      return 'bodyweight';
    }
    if (equipment.contains('treadmill')) return 'treadmill';
    if (equipment.contains('stationary_bike')) return 'stationary_bike';
    if (equipment.contains('jump_rope')) return 'jump_rope';
    if (equipment.contains('outdoor_space')) return 'outdoor_space';
    for (final preferred in const [
      'barbell',
      'dumbbells',
      'cable_machine',
      'machine',
      'bench',
      'resistance_band',
      'kettlebell',
      'medicine_ball',
      'pull_up_bar',
      'chair_support',
      'wall',
      'floor',
      'mat',
      'bodyweight',
    ]) {
      if (equipment.contains(preferred)) return preferred;
    }
    return equipment.isEmpty ? 'bodyweight' : equipment.first;
  }

  static String _locationFor(
    Exercise exercise,
    String typeKey,
    String equipment,
  ) {
    if (typeKey == 'martial_arts') {
      if (exercise.contextKey == 'karate') {
        return EquipmentCatalogService.placeDojo;
      }
      if (equipment == 'tatami' || exercise.contextKey == 'jiu_jitsu') {
        return EquipmentCatalogService.placeTatami;
      }
      return EquipmentCatalogService.placeDojo;
    }
    if (typeKey == 'recovery') return EquipmentCatalogService.placeClinic;
    if (equipment == 'outdoor_space') {
      return EquipmentCatalogService.placeOutdoor;
    }
    if (_gymEquipment.contains(equipment)) {
      return EquipmentCatalogService.placeGym;
    }
    if (_homeEquipped.contains(equipment)) {
      return EquipmentCatalogService.placeHomeEquipped;
    }
    return EquipmentCatalogService.placeHomeNoEquipment;
  }

  static String _focusFor(
    Exercise exercise,
    String typeKey,
    ExerciseArchitectureTags tags,
  ) {
    final text = _text(exercise);
    if (typeKey == 'martial_arts') {
      if (_hasAny(text, const ['kihon'])) return 'kihon';
      if (_hasAny(text, const ['kata'])) return 'kata';
      if (_hasAny(text, const ['kumite'])) return 'kumite';
      if (_hasAny(text, const ['technical stand up', 'levantamento tecnico'])) {
        return 'technical_stand_up';
      }
      return 'karate_complete';
    }
    if (typeKey == 'mobility') {
      if (_hasAny(text, const ['anca', 'hip'])) return 'hips';
      if (_hasAny(text, const ['tornozelo', 'ankle'])) return 'ankles';
      if (_hasAny(text, const ['ombro', 'shoulder'])) return 'shoulders';
      if (_hasAny(text, const ['coluna', 'spine'])) return 'spine';
      return 'general_mobility';
    }
    if (tags.muscleKeys.isNotEmpty) return tags.muscleKeys.first;
    if (tags.subgroupKeys.isNotEmpty) return tags.subgroupKeys.first;
    if (tags.groupKeys.isNotEmpty) return tags.groupKeys.first;
    return '';
  }

  static String _cardioFocusFor(Exercise exercise, String equipment) {
    final text = _text(exercise);
    if (equipment == 'treadmill') {
      if (_hasAny(text, const ['interval', 'sprint', 'hiit'])) {
        return 'treadmill_intervals';
      }
      if (_hasAny(text, const ['aquecimento', 'warmup'])) {
        return 'treadmill_warmup';
      }
      if (_hasAny(text, const ['moderado', 'moderate'])) {
        return 'treadmill_moderate_pace';
      }
      if (_hasAny(text, const ['leve', 'caminhada', 'walk', 'cooldown'])) {
        return 'treadmill_easy_pace';
      }
      return 'aerobic_endurance';
    }
    if (_hasAny(text, const ['hiit', 'interval', 'sprint'])) return 'hiit';
    if (equipment == 'bodyweight') return 'no_equipment';
    return 'aerobic_endurance';
  }

  static String _martialArtFor(Exercise exercise) {
    final text = _text(exercise);
    if (exercise.contextKey == 'karate' || _hasAny(text, const ['karate'])) {
      return 'karate';
    }
    if (exercise.contextKey == 'jiu_jitsu' ||
        _hasAny(text, const ['jiu jitsu', 'bjj'])) {
      return 'jiu_jitsu';
    }
    if (exercise.contextKey == 'defesa_pessoal') return 'defesa_pessoal';
    return 'karate';
  }

  static String _recoveryFocus(Exercise exercise) {
    final text = _text(exercise);
    if (_hasAny(text, const ['respiracao', 'respira', 'breathing'])) {
      return 'breathing';
    }
    if (_hasAny(text, const ['caminhada', 'walk'])) return 'easy_walk';
    if (exercise.primaryType == 'elasticidade' ||
        _hasAny(text, const ['alongamento', 'stretch'])) {
      return 'light_stretching';
    }
    if (exercise.primaryType == 'mobilidade' ||
        _hasAny(text, const ['mobilidade', 'mobility'])) {
      return 'light_mobility';
    }
    return 'active_recovery';
  }

  static String _firstUsable(
    Set<String> values, {
    String fallback = '',
    Set<String> excluded = const {},
  }) {
    for (final value in values) {
      if (value.isNotEmpty && !excluded.contains(value)) return value;
    }
    return fallback;
  }

  static String _join(List<String> parts) =>
      parts.where((part) => part.isNotEmpty).join('>');

  static String _text(Exercise exercise) {
    return ExerciseCatalogContextService.stableKey(
      '${exercise.name} ${exercise.description} ${exercise.muscleGroup} '
      '${exercise.secondaryMuscleGroups} ${exercise.equipment} '
      '${exercise.primaryType} ${exercise.secondaryTypes.join(' ')} '
      '${exercise.contextKey} ${exercise.catalogEntryKey} '
      '${exercise.primaryMuscleKey} ${exercise.secondaryMuscleKeys.join(' ')}',
    ).replaceAll('_', ' ');
  }

  static bool _hasAny(String text, List<String> needles) =>
      needles.any((needle) => text.contains(needle));

  static String _csv(List<String> headers, List<Map<String, Object?>> rows) {
    final buffer = StringBuffer()..writeln(headers.map(_escape).join(','));
    for (final row in rows) {
      buffer.writeln(
        headers.map((header) => _escape('${row[header] ?? ''}')).join(','),
      );
    }
    return buffer.toString();
  }

  static String _escape(Object? value) {
    final text = '${value ?? ''}'.replaceAll('"', '""');
    return '"$text"';
  }

  static const _gymEquipment = {
    'barbell',
    'dumbbells',
    'cable_machine',
    'machine',
    'bench',
    'plates',
    'treadmill',
    'stationary_bike',
    'pull_up_bar',
  };

  static const _homeEquipped = {
    'resistance_band',
    'kettlebell',
    'medicine_ball',
    'chair_support',
    'weighted_backpack',
    'water_bottles',
    'water_jug',
    'stable_step',
    'broomstick',
    'towel',
  };
}
