import 'dart:convert';
import 'dart:io';

import '../../models/exercise.dart';
import '../equipment_catalog_service.dart';
import '../exercise_catalog_context_service.dart';
import '../exercise_filter_service.dart';
import '../exercise_taxonomy_service.dart';
import '../training_architecture.dart';
import '../training_flow.dart';
import 'catalog_quality_models.dart';

enum MenuMatrixStatus {
  okWithResults,
  okWithFallback,
  okEmptyWithExplicitNotice,
  failEmptySilent,
  failWrongResults,
  failIncompatibleMenu,
  failUnreachableContent,
  failAxisWithoutCoverage,
}

class CatalogAxisInventory {
  const CatalogAxisInventory({
    required this.trainingTypes,
    required this.locations,
    required this.equipment,
    required this.surfaces,
    required this.supports,
    required this.humanContexts,
    required this.bodyZones,
    required this.muscleGroups,
    required this.muscles,
    required this.joints,
    required this.modalities,
    required this.martialArts,
    required this.technicalFocuses,
    required this.objectives,
    required this.levels,
    required this.contexts,
    required this.visibleFilters,
    required this.internalFilters,
    required this.exercises,
    required this.aliases,
  });

  final Map<String, String> trainingTypes;
  final Map<String, String> locations;
  final Map<String, String> equipment;
  final Map<String, String> surfaces;
  final Map<String, String> supports;
  final Map<String, String> humanContexts;
  final Map<String, String> bodyZones;
  final Map<String, String> muscleGroups;
  final Map<String, String> muscles;
  final Map<String, String> joints;
  final Map<String, String> modalities;
  final Map<String, String> martialArts;
  final Map<String, String> technicalFocuses;
  final Map<String, String> objectives;
  final Map<String, String> levels;
  final Map<String, String> contexts;
  final Map<String, String> visibleFilters;
  final Map<String, String> internalFilters;
  final Map<String, String> exercises;
  final Map<String, String> aliases;

  Map<String, Object?> toJson() => {
    'training_types': trainingTypes,
    'locations': locations,
    'equipment': equipment,
    'surfaces': surfaces,
    'supports': supports,
    'human_contexts': humanContexts,
    'body_zones': bodyZones,
    'muscle_groups': muscleGroups,
    'muscles': muscles,
    'joints': joints,
    'modalities': modalities,
    'martial_arts': martialArts,
    'technical_focuses': technicalFocuses,
    'objectives': objectives,
    'levels': levels,
    'contexts': contexts,
    'visible_filters': visibleFilters,
    'internal_filters': internalFilters,
    'exercises': exercises,
    'aliases': aliases,
  };
}

class MenuPathAudit {
  const MenuPathAudit({
    required this.id,
    required this.typeKey,
    required this.locationKey,
    required this.equipmentKey,
    required this.regionKey,
    required this.groupKey,
    required this.subzoneKey,
    required this.focusKey,
    required this.cardioFocusKey,
    required this.martialArtKey,
    required this.status,
    required this.resultCount,
    required this.fallbackCount,
    required this.notice,
    required this.exerciseKeys,
    this.issue = '',
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
  final MenuMatrixStatus status;
  final int resultCount;
  final int fallbackCount;
  final String notice;
  final List<String> exerciseKeys;
  final String issue;

  bool get isCritical =>
      status == MenuMatrixStatus.failEmptySilent ||
      status == MenuMatrixStatus.failWrongResults ||
      status == MenuMatrixStatus.failIncompatibleMenu ||
      status == MenuMatrixStatus.failUnreachableContent ||
      status == MenuMatrixStatus.failAxisWithoutCoverage;

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
    'status': status.name,
    'result_count': resultCount,
    'fallback_count': fallbackCount,
    'notice': notice,
    'issue': issue,
    'exercise_keys': exerciseKeys,
  };
}

class AxisCoverageAudit {
  const AxisCoverageAudit({
    required this.axis,
    required this.key,
    required this.label,
    required this.count,
    required this.status,
    required this.notice,
  });

  final String axis;
  final String key;
  final String label;
  final int count;
  final MenuMatrixStatus status;
  final String notice;

  bool get isCritical => status == MenuMatrixStatus.failAxisWithoutCoverage;

  Map<String, Object?> toJson() => {
    'axis': axis,
    'key': key,
    'label': label,
    'count': count,
    'status': status.name,
    'notice': notice,
  };
}

class CatalogTotalMatrixResult {
  const CatalogTotalMatrixResult({
    required this.axisInventory,
    required this.menuPaths,
    required this.axisCoverage,
    required this.unreachableExercises,
  });

  final CatalogAxisInventory axisInventory;
  final List<MenuPathAudit> menuPaths;
  final List<AxisCoverageAudit> axisCoverage;
  final List<Exercise> unreachableExercises;

  List<MenuPathAudit> get okWithResults => _by(MenuMatrixStatus.okWithResults);
  List<MenuPathAudit> get okWithFallback =>
      _by(MenuMatrixStatus.okWithFallback);
  List<MenuPathAudit> get okEmptyWithExplicitNotice =>
      _by(MenuMatrixStatus.okEmptyWithExplicitNotice);
  List<MenuPathAudit> get failEmptySilent =>
      _by(MenuMatrixStatus.failEmptySilent);
  List<MenuPathAudit> get failWrongResults =>
      _by(MenuMatrixStatus.failWrongResults);
  List<MenuPathAudit> get failIncompatibleMenu =>
      _by(MenuMatrixStatus.failIncompatibleMenu);
  List<AxisCoverageAudit> get axisCoverageFailures =>
      axisCoverage.where((item) => item.isCritical).toList(growable: false);

  bool get passed =>
      failEmptySilent.isEmpty &&
      failWrongResults.isEmpty &&
      failIncompatibleMenu.isEmpty &&
      unreachableExercises.isEmpty &&
      axisCoverageFailures.isEmpty;

  List<CatalogIssue> toIssues() {
    final issues = <CatalogIssue>[];
    for (final path in menuPaths.where((path) => path.isCritical)) {
      issues.add(
        CatalogIssue(
          severity: CatalogIssueSeverity.critical,
          code: path.status.name,
          message: '${path.id}: ${path.issue}',
        ),
      );
    }
    for (final axis in axisCoverageFailures) {
      issues.add(
        CatalogIssue(
          severity: CatalogIssueSeverity.critical,
          code: 'fail_axis_without_coverage',
          message: '${axis.axis}.${axis.key}: ${axis.notice}',
        ),
      );
    }
    for (final exercise in unreachableExercises) {
      issues.add(
        CatalogIssue(
          severity: CatalogIssueSeverity.critical,
          code: 'fail_unreachable_content',
          message: 'Exercicio sem caminho visivel de menu.',
          exercise: exercise,
        ),
      );
    }
    return issues;
  }

  Map<String, Object?> toJson() => {
    'passed': passed,
    'axis_inventory': axisInventory.toJson(),
    'menu_paths': menuPaths.map((path) => path.toJson()).toList(),
    'axis_coverage': axisCoverage.map((axis) => axis.toJson()).toList(),
    'unreachable_exercises': unreachableExercises
        .map(
          (exercise) => {
            'name': exercise.name,
            'catalog_entry_key': exercise.catalogEntryKey,
            'primary_type': exercise.primaryType,
          },
        )
        .toList(),
  };

  List<MenuPathAudit> _by(MenuMatrixStatus status) =>
      menuPaths.where((path) => path.status == status).toList(growable: false);
}

class CatalogTotalMatrixAudit {
  const CatalogTotalMatrixAudit._();

  static CatalogTotalMatrixResult run({bool writeReports = false}) {
    final exercises = ExerciseCatalogContextService.entries
        .map(ExerciseTaxonomyService.enrichCatalogExercise)
        .toList(growable: false);
    final inventory = _axisInventory(exercises);
    final menuPaths = _menuPaths(exercises);
    final reachableKeys = <String>{
      for (final path in menuPaths)
        if (path.status == MenuMatrixStatus.okWithResults ||
            path.status == MenuMatrixStatus.okWithFallback)
          ...path.exerciseKeys,
    };
    final unreachable = exercises
        .where((exercise) => !reachableKeys.contains(exercise.catalogEntryKey))
        .toList(growable: false);
    final axisCoverage = _axisCoverage(exercises, inventory, menuPaths);
    final result = CatalogTotalMatrixResult(
      axisInventory: inventory,
      menuPaths: menuPaths,
      axisCoverage: axisCoverage,
      unreachableExercises: unreachable,
    );
    if (writeReports) writeReportsFor(result);
    return result;
  }

  static void writeReportsFor(CatalogTotalMatrixResult result) {
    final dirs = [
      Directory('build/reports'),
      Directory('docs/catalog_reports/v0.9.4'),
    ];
    for (final dir in dirs) {
      dir.createSync(recursive: true);
      _writeAxisInventory(dir, result.axisInventory);
      _writeMatrix(dir, result.menuPaths);
      _writeAxisCoverage(dir, result.axisCoverage);
      _writeUnreachable(dir, result.unreachableExercises);
      _writeEmptyPaths(dir, result.menuPaths);
    }
  }

  static CatalogAxisInventory _axisInventory(List<Exercise> exercises) {
    final equipment = Map<String, String>.fromEntries(
      EquipmentCatalogService.definitions.entries.map(
        (entry) => MapEntry(entry.key, entry.value.name),
      ),
    );
    final surfaces = _subset(equipment, EquipmentCatalogService.surfaceKeys);
    final supports = _subset(equipment, EquipmentCatalogService.supportKeys);
    final human = {
      ..._subset(equipment, EquipmentCatalogService.humanKeys),
      'partner': 'Parceiro',
    };
    final muscles = <String, String>{};
    final contexts = <String, String>{};
    final aliases = <String, String>{};
    final exercisesByKey = <String, String>{};
    for (final exercise in exercises) {
      exercisesByKey[exercise.catalogEntryKey] = exercise.name;
      contexts[exercise.contextKey] = exercise.contextKey;
      for (final muscle in {
        exercise.primaryMuscleKey,
        ...exercise.secondaryMuscleKeys,
      }) {
        if (muscle.isNotEmpty) muscles[muscle] = _label(muscle);
      }
      for (final alias in exercise.aliases) {
        aliases[alias] = exercise.canonicalId;
      }
    }
    final groups = {
      for (final group in TrainingArchitecture.groups) group.key: group.name,
    };
    final bodyZones = {
      for (final region in TrainingArchitecture.regions)
        if (region.key != 'custom') region.key: region.name,
    };
    final joints = Map<String, String>.fromEntries(
      muscles.entries.where((entry) => _jointKeys.contains(entry.key)),
    );
    final modalities = <String, String>{
      'strength': 'Musculacao',
      'cardio': 'Cardio',
      'martial_arts': 'Artes marciais',
      'mobility': 'Mobilidade',
      'elasticity': 'Elasticidade',
      'recovery': 'Recuperacao',
      'warmup': 'Aquecimento',
      'activation': 'Ativacao',
      'prevention': 'Prevencao',
    };
    return CatalogAxisInventory(
      trainingTypes: Map.fromEntries(
        TrainingFlow.types.entries.where((entry) => entry.key != 'custom'),
      ),
      locations: TrainingFlow.locationLabels,
      equipment: equipment,
      surfaces: surfaces,
      supports: supports,
      humanContexts: human,
      bodyZones: bodyZones,
      muscleGroups: groups,
      muscles: muscles,
      joints: joints,
      modalities: modalities,
      martialArts: TrainingFlow.martialLabels,
      technicalFocuses: {
        ...TrainingFlow.strengthFocusLabels,
        ...TrainingFlow.cardioLabels,
        ...TrainingFlow.martialFocusLabels,
        ...TrainingFlow.mobilityLabels,
        ...TrainingFlow.recoveryLabels,
      },
      objectives: TrainingFlow.objectiveLabels,
      levels: const {
        'beginner': 'Iniciante',
        'intermediate': 'Intermedio',
        'advanced': 'Avancado',
      },
      contexts: contexts,
      visibleFilters: {
        ...TrainingFlow.strengthFocusLabels,
        ...TrainingFlow.cardioLabels,
        ...TrainingFlow.martialLabels,
        ...TrainingFlow.martialFocusLabels,
        ...TrainingFlow.mobilityLabels,
        ...TrainingFlow.recoveryLabels,
      },
      internalFilters: {
        ...bodyZones,
        ...groups,
        ...muscles,
        ...equipment,
        ...contexts,
      },
      exercises: exercisesByKey,
      aliases: aliases,
    );
  }

  static List<MenuPathAudit> _menuPaths(List<Exercise> exercises) {
    final flows = <TrainingFlowSelection>[];
    flows.addAll(_strengthFlows());
    flows.addAll(_cardioFlows());
    flows.addAll(_martialFlows());
    flows.addAll(_simpleTypeFlows('mobility', TrainingFlow.mobilityLabels));
    flows.addAll(_simpleTypeFlows('elasticity', const {'': 'Elasticidade'}));
    flows.addAll(_simpleTypeFlows('recovery', TrainingFlow.recoveryLabels));
    flows.addAll(_simpleTypeFlows('warmup', const {'': 'Aquecimento'}));
    flows.addAll(_simpleTypeFlows('activation', const {'': 'Ativacao'}));
    flows.addAll(_simpleTypeFlows('prevention', const {'': 'Prevencao'}));

    final paths = <MenuPathAudit>[];
    final seen = <String>{};
    for (final flow in flows) {
      final id = _pathId(flow);
      if (!seen.add(id)) continue;
      paths.add(_classifyPath(exercises, flow, id));
    }
    return paths;
  }

  static Iterable<TrainingFlowSelection> _strengthFlows() sync* {
    final locations = TrainingFlow.locationLabels.keys;
    for (final location in locations) {
      final equipmentKeys = _visibleEquipmentForLocation(location);
      final anatomyEquipment = equipmentKeys.contains('bodyweight')
          ? 'bodyweight'
          : equipmentKeys.first;
      for (final equipment in equipmentKeys) {
        yield TrainingFlowSelection(
          typeKey: 'strength',
          locationKey: location,
          equipmentKey: equipment,
          regionKey: 'full_body',
        );
      }
      for (final region in TrainingArchitecture.regions) {
        if (region.key == 'custom' ||
            region.key == 'cardio' ||
            region.key == 'martial_arts' ||
            region.key == 'mobility_recovery') {
          continue;
        }
        yield TrainingFlowSelection(
          typeKey: 'strength',
          locationKey: location,
          equipmentKey: anatomyEquipment,
          regionKey: region.key,
        );
        for (final group in TrainingArchitecture.groups.where(
          (group) => group.regionKey == region.key,
        )) {
          yield TrainingFlowSelection(
            typeKey: 'strength',
            locationKey: location,
            equipmentKey: anatomyEquipment,
            regionKey: region.key,
            groupKey: group.key,
          );
          for (final subzone in TrainingFlow.strengthSubzonesForGroup(
            group.key,
          )) {
            yield TrainingFlowSelection(
              typeKey: 'strength',
              locationKey: location,
              equipmentKey: anatomyEquipment,
              regionKey: region.key,
              groupKey: group.key,
              subzoneKey: subzone.key,
            );
            final specifics = TrainingFlow.strengthSpecificOptions(
              group.key,
              subzone.key,
            );
            for (final focus in specifics) {
              yield TrainingFlowSelection(
                typeKey: 'strength',
                locationKey: location,
                equipmentKey: anatomyEquipment,
                regionKey: region.key,
                groupKey: group.key,
                subzoneKey: subzone.key,
                focusKey: focus.key,
              );
            }
          }
        }
      }
    }
  }

  static Iterable<TrainingFlowSelection> _cardioFlows() sync* {
    for (final location in TrainingFlow.locationLabels.keys) {
      final selectedEquipment = _selectedEquipmentForLocation(location);
      final modes = TrainingFlow.availableCardioModes(
        trainingLocation: TrainingFlow.locationLabels[location] ?? location,
        availableEquipmentKeys: selectedEquipment,
      );
      for (final mode in modes) {
        final equipment = mode.key == 'no_equipment' ? 'bodyweight' : mode.key;
        for (final focus in TrainingFlow.cardioFocusOptionsForEquipment(
          equipment,
        )) {
          yield TrainingFlowSelection(
            typeKey: 'cardio',
            locationKey: location,
            equipmentKey: equipment,
            cardioFocusKey: focus.key,
          );
        }
      }
    }
  }

  static Iterable<TrainingFlowSelection> _martialFlows() sync* {
    for (final location in const [
      EquipmentCatalogService.placeDojo,
      EquipmentCatalogService.placeTatami,
      EquipmentCatalogService.placeGym,
      EquipmentCatalogService.placeHomeEquipped,
    ]) {
      for (final art in TrainingFlow.martialLabels.keys) {
        final focuses = TrainingFlow.martialFocusOptions(art);
        for (final focus in focuses) {
          yield TrainingFlowSelection(
            typeKey: 'martial_arts',
            locationKey: location,
            martialArtKey: art,
            focusKey: focus.key,
          );
        }
      }
    }
  }

  static Iterable<TrainingFlowSelection> _simpleTypeFlows(
    String type,
    Map<String, String> focuses,
  ) sync* {
    for (final location in TrainingFlow.locationLabels.keys) {
      for (final equipment in const ['bodyweight', 'floor', 'wall', 'mat']) {
        if (focuses.keys.length == 1 && focuses.keys.first.isEmpty) {
          yield TrainingFlowSelection(
            typeKey: type,
            locationKey: location,
            equipmentKey: equipment,
          );
        } else {
          for (final focus in focuses.keys) {
            yield TrainingFlowSelection(
              typeKey: type,
              locationKey: location,
              equipmentKey: equipment,
              focusKey: focus,
              mobilityZoneKey: type == 'mobility' ? focus : '',
              recoveryKey: type == 'recovery' ? focus : '',
            );
          }
        }
      }
    }
  }

  static MenuPathAudit _classifyPath(
    List<Exercise> exercises,
    TrainingFlowSelection flow,
    String id,
  ) {
    final selection = TrainingFlow.toTrainingSelection(flow);
    final selectedEquipment = _selectedEquipmentForLocation(flow.locationKey)
      ..addAll(
        {
          if (flow.equipmentKey.isNotEmpty) flow.equipmentKey,
          selection.equipmentKey,
        }.where((item) => item.isNotEmpty),
      );
    final available = _availableExercisesFor(
      exercises: exercises,
      availableEquipmentKeys: selectedEquipment,
      selection: selection,
    );
    final exerciseKeys = available
        .map((exercise) => exercise.catalogEntryKey)
        .toList(growable: false);
    final wrong = available
        .where((exercise) => !_matchesFlowType(exercise, flow.typeKey))
        .toList(growable: false);
    if (wrong.isNotEmpty) {
      return _path(
        id,
        flow,
        MenuMatrixStatus.failWrongResults,
        exerciseKeys,
        issue:
            'Resultado fora do tipo esperado: ${wrong.map((exercise) => exercise.name).take(5).join(', ')}',
      );
    }
    if (available.isNotEmpty) {
      return _path(
        id,
        flow,
        MenuMatrixStatus.okWithResults,
        exerciseKeys,
        notice: 'Mostra exercicios compativeis.',
      );
    }
    final fallback =
        _availableExercisesFor(
              exercises: exercises,
              availableEquipmentKeys:
                  _selectedEquipmentForLocation(flow.locationKey)
                    ..add('bodyweight')
                    ..add('floor')
                    ..add('wall'),
              selection: selection.copyWith(equipmentKey: ''),
            )
            .where((exercise) => _matchesFlowType(exercise, flow.typeKey))
            .toList(growable: false);
    if (fallback.isNotEmpty) {
      return _path(
        id,
        flow,
        MenuMatrixStatus.okWithFallback,
        fallback.map((exercise) => exercise.catalogEntryKey).toList(),
        fallbackCount: fallback.length,
        notice:
            'Sem conteudo exato para esta capacidade; mostra alternativa segura do mesmo tipo.',
      );
    }
    return _path(
      id,
      flow,
      MenuMatrixStatus.okEmptyWithExplicitNotice,
      const [],
      notice: ExerciseFilterService.emptyStateMessage,
    );
  }

  static MenuPathAudit _path(
    String id,
    TrainingFlowSelection flow,
    MenuMatrixStatus status,
    List<String> exerciseKeys, {
    int fallbackCount = 0,
    String notice = '',
    String issue = '',
  }) {
    return MenuPathAudit(
      id: id,
      typeKey: flow.typeKey,
      locationKey: flow.locationKey,
      equipmentKey: flow.equipmentKey,
      regionKey: flow.regionKey,
      groupKey: flow.groupKey,
      subzoneKey: flow.subzoneKey,
      focusKey: flow.focusKey,
      cardioFocusKey: flow.cardioFocusKey,
      martialArtKey: flow.martialArtKey,
      status: status,
      resultCount: status == MenuMatrixStatus.okWithResults
          ? exerciseKeys.length
          : 0,
      fallbackCount: fallbackCount,
      notice: notice,
      exerciseKeys: exerciseKeys,
      issue: issue,
    );
  }

  static List<Exercise> _availableExercisesFor({
    required List<Exercise> exercises,
    required Set<String> availableEquipmentKeys,
    required TrainingSelection selection,
  }) {
    final selectionWithoutEquipment = selection.copyWith(equipmentKey: '');
    return exercises
        .where((exercise) {
          if (!TrainingArchitecture.matchesSelection(
            exercise,
            selectionWithoutEquipment,
          )) {
            return false;
          }
          final tags = TrainingArchitecture.tagsForExercise(exercise);
          if (selection.equipmentKey.isNotEmpty &&
              !tags.equipmentKeys.contains(selection.equipmentKey)) {
            return false;
          }
          return tags.equipmentKeys.every(availableEquipmentKeys.contains);
        })
        .toList(growable: false);
  }

  static List<AxisCoverageAudit> _axisCoverage(
    List<Exercise> exercises,
    CatalogAxisInventory inventory,
    List<MenuPathAudit> paths,
  ) {
    final result = <AxisCoverageAudit>[];
    void addAxis(
      String axis,
      Map<String, String> items,
      int Function(String) c,
    ) {
      for (final entry in items.entries) {
        final count = c(entry.key);
        result.add(
          AxisCoverageAudit(
            axis: axis,
            key: entry.key,
            label: entry.value,
            count: count,
            status: count > 0
                ? MenuMatrixStatus.okWithResults
                : MenuMatrixStatus.okEmptyWithExplicitNotice,
            notice: count > 0
                ? 'Eixo coberto por exercicios.'
                : 'Sem conteudo especifico; a UI deve mostrar aviso/fallback.',
          ),
        );
      }
    }

    addAxis(
      'training_type',
      inventory.trainingTypes,
      (key) => exercises
          .where((exercise) => _typeForExercise(exercise) == key)
          .length,
    );
    addAxis(
      'location',
      inventory.locations,
      (key) => paths
          .where(
            (path) =>
                path.locationKey == key &&
                (path.status == MenuMatrixStatus.okWithResults ||
                    path.status == MenuMatrixStatus.okWithFallback),
          )
          .length,
    );
    addAxis(
      'equipment',
      inventory.equipment,
      (key) => exercises
          .where((exercise) => exercise.equipmentKeys.contains(key))
          .length,
    );
    addAxis(
      'muscle',
      inventory.muscles,
      (key) => exercises
          .where(
            (exercise) =>
                exercise.primaryMuscleKey == key ||
                exercise.secondaryMuscleKeys.contains(key),
          )
          .length,
    );
    addAxis(
      'joint',
      inventory.joints,
      (key) => exercises
          .where(
            (exercise) =>
                exercise.primaryMuscleKey == key ||
                exercise.secondaryMuscleKeys.contains(key),
          )
          .length,
    );
    addAxis(
      'modality',
      inventory.modalities,
      (key) => exercises
          .where((exercise) => _typeForExercise(exercise) == key)
          .length,
    );
    addAxis(
      'martial_art',
      inventory.martialArts,
      (key) => exercises.where((exercise) => exercise.contextKey == key).length,
    );
    return result;
  }

  static bool _matchesFlowType(Exercise exercise, String typeKey) =>
      _typeForExercise(exercise) == typeKey ||
      (typeKey == 'martial_arts' && exercise.primaryType == 'artes_marciais');

  static String _typeForExercise(Exercise exercise) {
    return switch (exercise.primaryType) {
      'musculacao' => 'strength',
      'artes_marciais' => 'martial_arts',
      'mobilidade' => 'mobility',
      'elasticidade' => 'elasticity',
      'recuperacao' => 'recovery',
      'aquecimento' => 'warmup',
      'ativacao' => 'activation',
      'prevencao' => 'prevention',
      _ => exercise.primaryType,
    };
  }

  static Set<String> _selectedEquipmentForLocation(String locationKey) {
    return EquipmentCatalogService.availableKeys(
      trainingLocations: {TrainingFlow.locationLabels[locationKey] ?? ''},
      selectedEquipmentKeys: const {},
    );
  }

  static Set<String> _visibleEquipmentForLocation(String locationKey) {
    final available = EquipmentCatalogService.availableKeys(
      trainingLocations: {TrainingFlow.locationLabels[locationKey] ?? ''},
      selectedEquipmentKeys: const {},
    );
    if (locationKey == EquipmentCatalogService.placeGym) {
      return available
          .where(
            (key) =>
                EquipmentCatalogService.definitions.containsKey(key) &&
                !{'none', 'other'}.contains(key) &&
                EquipmentCatalogService.kindFor(key) != CapabilityKind.human,
          )
          .toSet();
    }
    return available
        .where(
          (key) =>
              EquipmentCatalogService.definitions.containsKey(key) &&
              {
                'bodyweight',
                'floor',
                'wall',
                'mat',
                'tatami',
                'outdoor_space',
              }.contains(key),
        )
        .toSet();
  }

  static Map<String, String> _subset(
    Map<String, String> all,
    Set<String> keys,
  ) {
    return {
      for (final key in keys)
        if (all.containsKey(key)) key: all[key]!,
    };
  }

  static String _pathId(TrainingFlowSelection flow) {
    return [
      flow.typeKey,
      flow.locationKey,
      flow.equipmentKey,
      flow.regionKey,
      flow.groupKey,
      flow.subzoneKey,
      flow.focusKey,
      flow.cardioFocusKey,
      flow.martialArtKey,
      flow.mobilityZoneKey,
      flow.recoveryKey,
    ].where((item) => item.isNotEmpty).join('>');
  }

  static String _label(String key) => key.replaceAll('_', ' ');

  static const _jointKeys = {
    'neck',
    'cervical_stabilizers',
    'shoulder',
    'scapular_stability',
    'wrist',
    'fingers',
    'hip_flexors',
    'hip_external_rotators',
    'knee',
    'ankle',
    'feet',
  };

  static void _writeAxisInventory(Directory dir, CatalogAxisInventory item) {
    File('${dir.path}/catalog_axis_inventory.json').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(item.toJson()),
    );
    File(
      '${dir.path}/catalog_axis_inventory.csv',
    ).writeAsStringSync(_mapCsv(item.toJson()));
    final buffer = StringBuffer()
      ..writeln('# Catalog axis inventory')
      ..writeln();
    for (final entry in item.toJson().entries) {
      final values = entry.value as Map<String, Object?>;
      buffer
        ..writeln('## ${entry.key}')
        ..writeln('- Total: ${values.length}');
      for (final value in values.entries) {
        buffer.writeln('- `${value.key}`: ${value.value}');
      }
      buffer.writeln();
    }
    File(
      '${dir.path}/catalog_axis_inventory.md',
    ).writeAsStringSync(buffer.toString());
  }

  static void _writeMatrix(Directory dir, List<MenuPathAudit> paths) {
    File('${dir.path}/full_menu_matrix_audit.json').writeAsStringSync(
      const JsonEncoder.withIndent(
        '  ',
      ).convert(paths.map((path) => path.toJson()).toList()),
    );
    File(
      '${dir.path}/full_menu_matrix_audit.csv',
    ).writeAsStringSync(_pathsCsv(paths));
    File(
      '${dir.path}/full_menu_matrix_audit.md',
    ).writeAsStringSync(_pathsMarkdown('Full menu matrix audit', paths));
  }

  static void _writeAxisCoverage(Directory dir, List<AxisCoverageAudit> axes) {
    File('${dir.path}/axis_coverage_audit.json').writeAsStringSync(
      const JsonEncoder.withIndent(
        '  ',
      ).convert(axes.map((axis) => axis.toJson()).toList()),
    );
    File(
      '${dir.path}/axis_coverage_audit.csv',
    ).writeAsStringSync(_axisCsv(axes));
    final buffer = StringBuffer()
      ..writeln('# Axis coverage audit')
      ..writeln();
    for (final axis in axes) {
      buffer.writeln(
        '- ${axis.axis}.${axis.key}: ${axis.status.name} (${axis.count}) ${axis.notice}',
      );
    }
    File(
      '${dir.path}/axis_coverage_audit.md',
    ).writeAsStringSync(buffer.toString());
  }

  static void _writeUnreachable(Directory dir, List<Exercise> exercises) {
    File('${dir.path}/unreachable_exercises_audit.json').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(
        exercises
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
    final csv = StringBuffer()..writeln('name,catalog_entry_key,primary_type');
    for (final exercise in exercises) {
      csv.writeln(
        [
          exercise.name,
          exercise.catalogEntryKey,
          exercise.primaryType,
        ].map(_csv).join(','),
      );
    }
    File(
      '${dir.path}/unreachable_exercises_audit.csv',
    ).writeAsStringSync(csv.toString());
    final md = StringBuffer()
      ..writeln('# Unreachable exercises audit')
      ..writeln()
      ..writeln('- Total: ${exercises.length}');
    for (final exercise in exercises) {
      md.writeln('- ${exercise.name} `${exercise.catalogEntryKey}`');
    }
    File(
      '${dir.path}/unreachable_exercises_audit.md',
    ).writeAsStringSync(md.toString());
  }

  static void _writeEmptyPaths(Directory dir, List<MenuPathAudit> paths) {
    final empty = paths
        .where(
          (path) =>
              path.status == MenuMatrixStatus.okEmptyWithExplicitNotice ||
              path.status == MenuMatrixStatus.failEmptySilent,
        )
        .toList(growable: false);
    File('${dir.path}/empty_menu_paths_audit.json').writeAsStringSync(
      const JsonEncoder.withIndent(
        '  ',
      ).convert(empty.map((path) => path.toJson()).toList()),
    );
    File(
      '${dir.path}/empty_menu_paths_audit.csv',
    ).writeAsStringSync(_pathsCsv(empty));
    File(
      '${dir.path}/empty_menu_paths_audit.md',
    ).writeAsStringSync(_pathsMarkdown('Empty menu paths audit', empty));
  }

  static String _pathsMarkdown(String title, List<MenuPathAudit> paths) {
    final counts = <String, int>{};
    for (final path in paths) {
      counts.update(path.status.name, (value) => value + 1, ifAbsent: () => 1);
    }
    final buffer = StringBuffer()
      ..writeln('# $title')
      ..writeln()
      ..writeln('- Total: ${paths.length}');
    for (final entry in counts.entries) {
      buffer.writeln('- ${entry.key}: ${entry.value}');
    }
    buffer.writeln();
    for (final path in paths) {
      buffer.writeln(
        '- ${path.status.name} `${path.id}` results=${path.resultCount} fallback=${path.fallbackCount} notice="${path.notice}"',
      );
    }
    return buffer.toString();
  }

  static String _pathsCsv(List<MenuPathAudit> paths) {
    final buffer = StringBuffer()
      ..writeln(
        'id,type_key,location_key,equipment_key,region_key,group_key,subzone_key,focus_key,cardio_focus_key,martial_art_key,status,result_count,fallback_count,notice,issue',
      );
    for (final path in paths) {
      buffer.writeln(
        [
          path.id,
          path.typeKey,
          path.locationKey,
          path.equipmentKey,
          path.regionKey,
          path.groupKey,
          path.subzoneKey,
          path.focusKey,
          path.cardioFocusKey,
          path.martialArtKey,
          path.status.name,
          path.resultCount.toString(),
          path.fallbackCount.toString(),
          path.notice,
          path.issue,
        ].map(_csv).join(','),
      );
    }
    return buffer.toString();
  }

  static String _axisCsv(List<AxisCoverageAudit> axes) {
    final buffer = StringBuffer()
      ..writeln('axis,key,label,count,status,notice');
    for (final axis in axes) {
      buffer.writeln(
        [
          axis.axis,
          axis.key,
          axis.label,
          axis.count.toString(),
          axis.status.name,
          axis.notice,
        ].map(_csv).join(','),
      );
    }
    return buffer.toString();
  }

  static String _mapCsv(Map<String, Object?> sections) {
    final buffer = StringBuffer()..writeln('axis,key,label');
    for (final section in sections.entries) {
      final values = section.value as Map<String, Object?>;
      for (final entry in values.entries) {
        buffer.writeln(
          [section.key, entry.key, '${entry.value}'].map(_csv).join(','),
        );
      }
    }
    return buffer.toString();
  }

  static String _csv(String value) => '"${value.replaceAll('"', '""')}"';
}
