import 'dart:io';

import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/training_flow.dart';

import 'exercise_content_inventory.dart' show classify, forbiddenHits;

/// FASE 1 da revisão/expansão do catálogo: inventário completo de todos os
/// exercícios com área, grupo, músculos, articulações, padrão de movimento,
/// nível, equipamento, locais possíveis e filtros onde cada um aparece.
/// Gera docs/audits/full_exercise_catalog_inventory.md.
void main() {
  final entries = ExerciseCatalogContextService.entries;
  final exercises = entries.map((entry) => entry.toExercise()).toList();

  // ---- 1. Matriz completa de seleções alcançáveis pela UI. ----
  final selections = <String, TrainingSelection>{};

  const strengthGroups = <String, (String, String)>{
    'chest': ('upper', 'chest'),
    'back': ('upper', 'back'),
    'shoulders': ('upper', 'shoulders'),
    'arms': ('upper', 'arms'),
    'forearm_hand': ('upper', 'forearm_hand'),
    'traps_scapula': ('upper', 'traps_scapula'),
    'neck': ('upper', 'neck'),
    'core': ('core', ''),
    'legs': ('lower', 'legs'),
  };
  for (final groupEntry in strengthGroups.entries) {
    for (final subzone in TrainingFlow.strengthSubzonesForGroup(
      groupEntry.key,
    )) {
      selections['Musculação > ${groupEntry.key} > ${subzone.key}'] =
          TrainingFlow.toTrainingSelection(
            TrainingFlowSelection(
              typeKey: 'strength',
              regionKey: groupEntry.value.$1,
              groupKey: groupEntry.value.$2,
              subzoneKey: subzone.key,
            ),
          );
      for (final focus in TrainingFlow.strengthSpecificOptions(
        groupEntry.key,
        subzone.key,
      )) {
        selections['Musculação > ${groupEntry.key} > ${subzone.key} > '
            '${focus.key}'] = TrainingFlow.toTrainingSelection(
          TrainingFlowSelection(
            typeKey: 'strength',
            regionKey: groupEntry.value.$1,
            groupKey: groupEntry.value.$2,
            subzoneKey: subzone.key,
            focusKey: focus.key,
          ),
        );
      }
    }
  }
  for (final mode in TrainingFlow.cardioLabels.keys) {
    selections['Cardio > $mode'] = TrainingFlow.toTrainingSelection(
      TrainingFlowSelection(typeKey: 'cardio', cardioFocusKey: mode),
    );
  }
  const martialFocusByArt = <String, List<String>>{
    'karate': [
      'karate_complete',
      'kihon',
      'kata',
      'kumite_technical',
      'karate_shadow',
      'karate_footwork',
      'karate_stances',
      'karate_guard',
      'karate_punches',
      'karate_kicks',
      'karate_blocks',
      'karate_evasions',
      'karate_knees',
      'karate_bag',
      'karate_mobility',
      'karate_conditioning',
    ],
    'jiu_jitsu': [
      'jiu_jitsu_complete',
      'shrimp',
      'grappling_bridge',
      'technical_stand_up',
      'jiu_jitsu_rolls',
      'jiu_jitsu_breakfalls',
      'jiu_jitsu_inversions',
      'jiu_jitsu_guard',
      'guard_passing',
      'jiu_jitsu_grip',
      'jiu_jitsu_core',
      'jiu_jitsu_mobility',
      'jiu_jitsu_conditioning',
    ],
  };
  for (final art in martialFocusByArt.entries) {
    for (final focus in art.value) {
      selections['Artes marciais > ${art.key} > $focus'] =
          TrainingFlow.toTrainingSelection(
            TrainingFlowSelection(
              typeKey: 'martial_arts',
              martialArtKey: art.key,
              focusKey: focus,
            ),
          );
    }
  }
  for (final zone in TrainingFlow.mobilityLabels.keys) {
    selections['Mobilidade > $zone'] = TrainingFlow.toTrainingSelection(
      TrainingFlowSelection(typeKey: 'mobility', mobilityZoneKey: zone),
    );
  }
  for (final key in TrainingFlow.recoveryLabels.keys) {
    selections['Recuperação > $key'] = TrainingFlow.toTrainingSelection(
      TrainingFlowSelection(typeKey: 'recovery', recoveryKey: key),
    );
  }

  // Filtros onde cada exercício aparece: união de vários cenários de local /
  // equipamento, para que exercícios exclusivos de casa/exterior/dojo não
  // sejam marcados como inalcançáveis só por não existirem no ginásio.
  final allEquipmentKeys = EquipmentCatalogService.definitions.keys.toSet();
  final reachabilityScenarios = <(String, Set<String>)>[
    ('Ginásio', const {}),
    ('Casa', allEquipmentKeys),
    ('Exterior / parque', const {}),
    ('Dojo / artes marciais', {'tatami'}),
  ];
  final filtersByExercise = <String, Set<String>>{};
  for (final selection in selections.entries) {
    for (final scenario in reachabilityScenarios) {
      final visible = ExerciseFilterService.getAvailableExercises(
        exercises: exercises,
        trainingLocation: scenario.$1,
        availableEquipmentKeys: scenario.$2,
        selection: selection.value,
        showAllExercises: false,
      );
      for (final item in visible) {
        filtersByExercise
            .putIfAbsent(
              '${item.exercise.name}__${item.exercise.muscleGroup}',
              () => {},
            )
            .add(selection.key);
      }
    }
  }

  // ---- 2. Locais possíveis por exercício. ----
  final allEquipment = EquipmentCatalogService.definitions.keys.toSet();
  final scenarios = <String, (String, Set<String>)>{
    'Casa sem equipamento': ('Casa', <String>{}),
    'Casa equipada': ('Casa', allEquipment),
    'Exterior / parque': ('Exterior / parque', <String>{}),
    'Dojo / tatami': ('Dojo / artes marciais', {'tatami'}),
    'Ginásio': ('Ginásio', <String>{}),
  };
  final locationsByExercise = <String, List<String>>{};
  final countByLocation = <String, int>{};
  for (final scenario in scenarios.entries) {
    final visible = ExerciseFilterService.getAvailableExercises(
      exercises: exercises,
      trainingLocation: scenario.value.$1,
      availableEquipmentKeys: scenario.value.$2,
      selection: const TrainingSelection(),
      showAllExercises: false,
    );
    countByLocation[scenario.key] = visible.length;
    for (final item in visible) {
      locationsByExercise
          .putIfAbsent(
            '${item.exercise.name}__${item.exercise.muscleGroup}',
            () => [],
          )
          .add(scenario.key);
    }
  }

  // ---- 3. Agregados e problemas. ----
  final byArea = <String, int>{};
  final byGroup = <String, int>{};
  final byEquipment = <String, int>{};
  final byPattern = <String, int>{};
  final byLevel = <String, int>{};
  final noDescription = <String>[];
  final noSteps = <String>[];
  final genericText = <String>[];
  final wrongEquipmentLanguage = <String>[];
  final noPosture = <String>[];
  final noBreathing = <String>[];
  final unreachable = <String>[];
  final onlyForeignFilters = <String>[];
  final nearDuplicates = <String>[];
  final exactDuplicates = <String>[];

  const genericCues = [
    'conforme a variação',
    'indicada pela variação',
    'indicado pela variação',
    'a trajetória específica desta variação',
    'indicada pelo nome',
    'indicado pelo nome',
    'exercício genérico',
    'descrição genérica',
    'variação escolhida',
    'segundo a variação',
  ];

  final seenNormalizedNames = <String, String>{};
  final compactNames = <String, List<String>>{};
  for (final entry in entries) {
    final label = '${entry.id} ${entry.name} [${entry.group}]';
    final key = '${entry.name}__${entry.group}';
    final pattern = movementPattern(entry);
    final level = difficultyLevel(entry);
    byArea[classify(entry)] = (byArea[classify(entry)] ?? 0) + 1;
    byGroup[entry.group] = (byGroup[entry.group] ?? 0) + 1;
    byEquipment[entry.details.equipment] =
        (byEquipment[entry.details.equipment] ?? 0) + 1;
    byPattern[pattern] = (byPattern[pattern] ?? 0) + 1;
    byLevel[level] = (byLevel[level] ?? 0) + 1;

    if (entry.details.description.trim().isEmpty) noDescription.add(label);
    if (entry.details.executionSteps.trim().isEmpty) noSteps.add(label);
    final lower = '${entry.details.description} ${entry.details.executionSteps}'
        .toLowerCase();
    final generic = genericCues.where(lower.contains).toList();
    if (generic.isNotEmpty) genericText.add('$label: $generic');
    final forbidden = forbiddenHits(entry);
    if (forbidden.isNotEmpty) {
      wrongEquipmentLanguage.add('$label: ${forbidden.join('; ')}');
    }
    if (entry.details.postureTips.trim().isEmpty) noPosture.add(label);
    if (entry.details.breathingTips.trim().isEmpty) noBreathing.add(label);

    final filters = (filtersByExercise[key] ?? const <String>{}).toList();
    if (filters.isEmpty) {
      unreachable.add(label);
    } else if (!_hasHomeFilter(entry.group, filters)) {
      onlyForeignFilters.add('$label → só em: ${filters.take(4).join(' | ')}');
    }

    // Duplicados exatos por nome normalizado dentro do mesmo grupo.
    final normalized = ExerciseCatalogContextService.stableKey(entry.name);
    final dupKey = '$normalized@${entry.group}';
    if (seenNormalizedNames.containsKey(dupKey)) {
      exactDuplicates.add('$label = ${seenNormalizedNames[dupKey]}');
    }
    seenNormalizedNames[dupKey] = label;
    // Quase-duplicados: mesmo nome sem palavras de equipamento/posição.
    final compact = _compactName(normalized);
    compactNames.putIfAbsent(compact, () => []).add(label);
  }
  for (final group in compactNames.entries) {
    if (group.value.length > 1) {
      nearDuplicates.add('`${group.key}`: ${group.value.join(' | ')}');
    }
  }

  // ---- 4. Escrita do relatório. ----
  final buffer = StringBuffer()
    ..writeln('# Inventário completo do catálogo de exercícios')
    ..writeln()
    ..writeln('Gerado por `tool/full_catalog_inventory.dart` (FASE 1 da')
    ..writeln('revisão/expansão do catálogo). Fonte dos exercícios:')
    ..writeln('`SeedData.exercisesByGroup` → `ExerciseCatalogContextService`;')
    ..writeln('tags anatómicas: `TrainingArchitecture.tagsForExercise`;')
    ..writeln('visibilidade por filtro/local: `ExerciseFilterService`.')
    ..writeln()
    ..writeln('## Totais')
    ..writeln()
    ..writeln('- Total de exercícios: **${entries.length}**')
    ..writeln('- Nomes únicos: ${entries.map((e) => e.name).toSet().length}')
    ..writeln('- Seleções de UI avaliadas: ${selections.length}');

  void countSection(String title, Map<String, int> data, {bool sort = true}) {
    buffer
      ..writeln()
      ..writeln('### $title')
      ..writeln();
    final items = data.entries.toList();
    if (sort) items.sort((a, b) => b.value.compareTo(a.value));
    for (final item in items) {
      buffer.writeln('- ${item.key}: ${item.value}');
    }
  }

  countSection('Por área (tipo de treino)', byArea);
  countSection('Por grupo do catálogo', byGroup, sort: false);
  countSection('Por padrão de movimento', byPattern);
  countSection('Por nível estimado', byLevel);
  countSection('Por equipamento', byEquipment);
  countSection(
    'Disponíveis por local (sem seleção de músculo)',
    countByLocation,
    sort: false,
  );

  void listSection(String title, List<String> items) {
    buffer
      ..writeln()
      ..writeln('### $title (${items.length})')
      ..writeln();
    if (items.isEmpty) {
      buffer.writeln('- (nenhum)');
    } else {
      for (final item in items) {
        buffer.writeln('- $item');
      }
    }
  }

  buffer
    ..writeln()
    ..writeln('## Problemas detetados');
  listSection('Sem descrição', noDescription);
  listSection('Sem passos de execução', noSteps);
  listSection('Descrição genérica / de template', genericText);
  listSection(
    'Linguagem errada de equipamento / frases proibidas',
    wrongEquipmentLanguage,
  );
  listSection('Sem dica de postura', noPosture);
  listSection('Sem dica de respiração', noBreathing);
  listSection(
    'Filtros incompletos: inalcançáveis por qualquer filtro da UI '
    '(só via "mostrar todos")',
    unreachable,
  );
  listSection(
    'Possivelmente mal categorizados (nunca aparecem em filtros da '
    'própria área)',
    onlyForeignFilters,
  );
  listSection(
    'Duplicados exatos (nome normalizado igual no mesmo grupo)',
    exactDuplicates,
  );
  listSection(
    'Quase-duplicados (mesmo movimento, variação de equipamento '
    'ou posição)',
    nearDuplicates,
  );

  buffer
    ..writeln()
    ..writeln('## Lista completa (um registo por exercício)')
    ..writeln();
  for (final entry in entries) {
    final key = '${entry.name}__${entry.group}';
    final tags = TrainingArchitecture.tagsForExercise(entry.toExercise());
    final filters = (filtersByExercise[key] ?? const <String>{}).toList();
    final locations = locationsByExercise[key] ?? const [];
    buffer
      ..writeln('### ${entry.id} — ${entry.name}')
      ..writeln()
      ..writeln('- Grupo: ${entry.group} | Área: ${classify(entry)}')
      ..writeln('- Padrão de movimento: ${movementPattern(entry)}')
      ..writeln('- Nível estimado: ${difficultyLevel(entry)}')
      ..writeln('- Articulações principais: ${joints(entry).join(', ')}')
      ..writeln('- Músculos (tags): ${tags.muscleKeys.join(', ')}')
      ..writeln('- Músculos secundários: ${entry.details.secondaryGroups}')
      ..writeln('- Equipamento: ${entry.details.equipment}')
      ..writeln(
        '- Locais possíveis: '
        '${locations.isEmpty ? 'NENHUM' : locations.join(' | ')}',
      )
      ..writeln(
        '- Filtros onde aparece (${filters.length}): '
        '${filters.isEmpty ? 'NENHUM' : filters.join(' | ')}',
      )
      ..writeln(
        '- Objetivo (${entry.details.description.length} chars) ✓ | '
        'Execução '
        '(${entry.details.executionSteps.split('\n').length} passos) ✓ | '
        'Erros comuns '
        '(${entry.details.commonMistakes.split('\n').length}) ✓ | '
        'Regressão/Progressão '
        '${entry.details.regression.isNotEmpty && entry.details.progression.isNotEmpty ? '✓' : '✗'} | '
        'Respiração ${entry.details.breathingTips.isNotEmpty ? '✓' : '✗'} | '
        'Postura ${entry.details.postureTips.isNotEmpty ? '✓' : '✗'}',
      )
      ..writeln();
  }

  File('docs/audits/full_exercise_catalog_inventory.md')
    ..createSync(recursive: true)
    ..writeAsStringSync(buffer.toString());
  stdout.writeln(
    'wrote docs/audits/full_exercise_catalog_inventory.md '
    '(${entries.length} exercícios, ${selections.length} seleções, '
    'inalcançáveis=${unreachable.length}, '
    'quase-duplicados=${nearDuplicates.length})',
  );
}

/// True se pelo menos um dos filtros pertence à área natural do grupo.
bool _hasHomeFilter(String group, List<String> filters) {
  final expected = switch (group) {
    'Pescoço' => 'neck',
    'Trapézio' => 'traps_scapula',
    'Ombros' => 'shoulders',
    'Peito' => 'chest',
    'Costas' => 'back',
    'Lombar' => 'core',
    'Bíceps' || 'Tríceps' => 'arms',
    'Antebraço/Pega' => 'forearm_hand',
    'Core' => 'core',
    'Pernas' => 'legs',
    'Cardio' => 'Cardio >',
    'Karate' => 'karate',
    'Jiu-Jitsu' => 'jiu_jitsu',
    'Mobilidade' => 'Mobilidade >',
    _ => '',
  };
  if (expected.isEmpty) return true;
  return filters.any((filter) => filter.contains(expected)) ||
      // Mobilidade/recuperação partilham seleções.
      (group == 'Mobilidade' &&
          filters.any((filter) => filter.startsWith('Recuperação')));
}

/// Remove palavras de equipamento/posição para agrupar quase-duplicados.
String _compactName(String normalized) {
  const noise = {
    'com',
    'halteres',
    'halter',
    'barra',
    'cabo',
    'polia',
    'maquina',
    'elastico',
    'elasticos',
    'kettlebell',
    'mochila',
    'garrafao',
    'disco',
    'toalha',
    'na',
    'no',
    'de',
    'em',
    'pe',
    'sentado',
    'sentada',
    'deitado',
    'inclinado',
    'inclinada',
    'declinado',
    'declinada',
    'unilateral',
    'alternado',
    'alternada',
    'apoio',
    'parede',
    'banco',
    'chao',
    'smith',
    'fixa',
    'guiada',
    'romano',
    'ez',
    'w',
    'v',
    'corda',
  };
  final words = normalized
      .split('_')
      .where((word) => word.isNotEmpty && !noise.contains(word))
      .toList();
  return words.isEmpty ? normalized : words.join(' ');
}

/// Padrão de movimento dominante, inferido do nome/grupo.
String movementPattern(ExerciseCatalogEntry entry) {
  final n = ExerciseCatalogContextService.stableKey(
    entry.name,
  ).replaceAll('_', ' ');
  bool has(List<String> tokens) => tokens.any(n.contains);

  if (entry.group == 'Karate' || entry.group == 'Jiu-Jitsu') {
    return 'técnica marcial';
  }
  if (entry.group == 'Mobilidade') {
    if (has(['alongamento'])) return 'alongamento estático';
    if (has(['respiracao', 'respiração'])) return 'respiração / recuperação';
    return 'mobilidade dinâmica';
  }
  if (entry.group == 'Cardio') {
    if (has(['sprint', 'hiit', 'burpee', 'intervalado', 'tiro'])) {
      return 'cardio intervalado';
    }
    if (has(['corda', 'jumping', 'polichinelo', 'skipping', 'shadow'])) {
      return 'cardio de coordenação';
    }
    return 'cardio contínuo';
  }
  if (entry.group == 'Pescoço') return 'flexão/extensão de pescoço';
  if (has(['farmer', 'suitcase', 'caminhada com'])) return 'transporte';
  if (has(['prancha', 'pallof', 'dead bug', 'bird dog', 'hollow', 'vacuum'])) {
    return 'anti-movimento de core';
  }
  if (has(['crunch', 'sit up', 'situp', 'elevacao de pernas', 'canivete'])) {
    return 'flexão de tronco';
  }
  if (has(['russian twist', 'rotacao de tronco', 'woodchop', 'lenhador'])) {
    return 'rotação de tronco';
  }
  if (has(['side bend', 'inclinacao lateral'])) return 'flexão lateral';
  if (has(['encolhimento'])) return 'elevação escapular';
  if (has(['gemeos', 'tibial', 'soleo', 'panturrilha'])) {
    return 'flexão plantar/dorsal';
  }
  if (has(['punho', 'pinca', 'pinch', 'gripper', 'aperto', 'dedos', 'maos'])) {
    return 'pega / punho';
  }
  if (has(['curl de perna', 'nordic'])) return 'flexão de joelho';
  if (has([
    'peso morto',
    'good morning',
    'hip thrust',
    'ponte',
    'hiperextensao',
    'swing',
    'romeno',
    'stiff',
  ])) {
    return 'dobradiça de anca';
  }
  if (has(['afundo', 'lunge', 'bulgaro', 'cossack', 'passada'])) {
    return 'afundo';
  }
  if (has([
    'agachamento',
    'leg press',
    'extensao de perna',
    'step up',
    'step-up',
    'wall sit',
    'pistol',
    'sissy',
  ])) {
    return 'agachamento / joelho dominante';
  }
  if (has(['abducao'])) return 'abdução de anca/ombro';
  if (has(['aducao'])) return 'adução de anca';
  if (has([
    'elevacoes',
    'puxada',
    'pulldown',
    'pull down',
    'dead hang',
    'chin',
  ])) {
    return 'puxar vertical';
  }
  if (has(['remada', 'face pull', 'pull apart', 'remo'])) {
    return 'puxar horizontal';
  }
  if (has(['press militar', 'press de ombros', 'arnold', 'pike', 'landmine'])) {
    return 'empurrar vertical';
  }
  if (has([
    'flexao',
    'supino',
    'press',
    'dips',
    'crossover',
    'crucifixo',
    'pullover',
    'peck deck',
    'pec deck',
  ])) {
    return 'empurrar horizontal';
  }
  if (has(['curl', 'rosca'])) return 'flexão de cotovelo';
  if (has(['extensao', 'kickback', 'tate', 'frances', 'testa', 'coice'])) {
    return 'extensão de cotovelo';
  }
  if (has(['elevacao lateral', 'elevacao frontal', 'elevacao posterior'])) {
    return 'elevação de ombro (isolamento)';
  }
  return 'outro / técnico';
}

/// Nível estimado a partir de sinais no nome (heurística de inventário).
String difficultyLevel(ExerciseCatalogEntry entry) {
  final n = ExerciseCatalogContextService.stableKey(
    entry.name,
  ).replaceAll('_', ' ');
  bool has(List<String> tokens) => tokens.any(n.contains);
  if (has([
    'pistol',
    'dragon flag',
    'nordic',
    'arqueiro',
    'um braco',
    'uma mao',
    'archer',
    'sprint',
    'pliometric',
    'salto',
    'explosiv',
    'muscle up',
  ])) {
    return 'avançado';
  }
  if (has([
        'com apoio',
        'na parede',
        'flexao inclinada',
        'assistid',
        'iniciante',
        'leve',
        'caminhada',
        'marcha',
        'alongamento',
        'mobilidade',
        'respiracao',
        'isometric',
        'wall sit',
        'joelhos apoiados',
      ]) ||
      entry.group == 'Mobilidade') {
    return 'iniciante';
  }
  return 'intermédio';
}

/// Articulações principais por padrão/grupo (melhor esforço, para inventário).
List<String> joints(ExerciseCatalogEntry entry) {
  final pattern = movementPattern(entry);
  return switch (pattern) {
    'empurrar horizontal' ||
    'empurrar vertical' => ['ombro', 'cotovelo', 'escápula'],
    'puxar vertical' || 'puxar horizontal' => ['ombro', 'cotovelo', 'escápula'],
    'flexão de cotovelo' || 'extensão de cotovelo' => ['cotovelo'],
    'elevação de ombro (isolamento)' ||
    'abdução de anca/ombro' when entry.group == 'Ombros' => ['ombro'],
    'elevação escapular' => ['escápula'],
    'pega / punho' => ['punho', 'dedos'],
    'agachamento / joelho dominante' ||
    'afundo' => ['anca', 'joelho', 'tornozelo'],
    'dobradiça de anca' => ['anca', 'joelho'],
    'flexão de joelho' => ['joelho'],
    'flexão plantar/dorsal' => ['tornozelo'],
    'abdução de anca/ombro' || 'adução de anca' => ['anca'],
    'flexão de tronco' ||
    'rotação de tronco' ||
    'flexão lateral' ||
    'anti-movimento de core' => ['coluna', 'anca'],
    'flexão/extensão de pescoço' => ['coluna cervical'],
    'transporte' => ['punho', 'ombro', 'anca'],
    'técnica marcial' => ['anca', 'joelho', 'ombro', 'coluna'],
    'respiração / recuperação' => ['costelas / diafragma'],
    'alongamento estático' ||
    'mobilidade dinâmica' => ['articulação alvo do alongamento'],
    'cardio contínuo' ||
    'cardio intervalado' ||
    'cardio de coordenação' => ['anca', 'joelho', 'tornozelo'],
    _ => ['várias'],
  };
}
