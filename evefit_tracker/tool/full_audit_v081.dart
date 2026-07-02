import 'dart:io';

import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/training_flow.dart';

/// Dumps the full muscle -> exercise matrix for every UI-reachable strength
/// selection and per-location equipment scenario, plus text-quality flags,
/// so the whole catalog can be reviewed entry by entry.
void main() {
  final exercises = ExerciseCatalogContextService.entries
      .map((entry) => entry.toExercise())
      .toList();

  final buffer = StringBuffer();

  buffer.writeln('# ANATOMY MATRIX (Ginásio, todos os equipamentos)');
  final seenInStrength = <String>{};
  for (final groupEntry in _strengthGroups.entries) {
    final regionKey = groupEntry.value.$1;
    final groupKey = groupEntry.value.$2;
    for (final subzone in TrainingFlow.strengthSubzonesForGroup(
      groupEntry.key,
    )) {
      final focuses = TrainingFlow.strengthSpecificOptions(
        groupEntry.key,
        subzone.key,
      );
      final selections = <String, TrainingFlowSelection>{
        subzone.key: TrainingFlowSelection(
          typeKey: 'strength',
          regionKey: regionKey,
          groupKey: groupKey,
          subzoneKey: subzone.key,
        ),
        for (final focus in focuses)
          '${subzone.key} > ${focus.key}': TrainingFlowSelection(
            typeKey: 'strength',
            regionKey: regionKey,
            groupKey: groupKey,
            subzoneKey: subzone.key,
            focusKey: focus.key,
          ),
      };
      for (final entry in selections.entries) {
        final selection = TrainingFlow.toTrainingSelection(entry.value);
        final visible = ExerciseFilterService.getAvailableExercises(
          exercises: exercises,
          trainingLocation: 'Ginásio',
          availableEquipmentKeys: const {},
          selection: selection,
          showAllExercises: false,
        );
        buffer.writeln(
          '\n## ${groupEntry.key} :: ${entry.key} (${visible.length})',
        );
        for (final item in visible) {
          seenInStrength.add('${item.exercise.name}__${item.exercise.muscleGroup}');
          buffer.writeln('- ${item.exercise.name} [${item.exercise.muscleGroup}]');
        }
      }
    }
  }

  buffer.writeln('\n# EQUIPMENT SCENARIOS');
  final scenarios = <String, (String, Set<String>)>{
    'Casa sem equipamento': ('Casa', <String>{}),
    'Casa básica (halteres, elásticos, tapete, mochila, cadeira)': (
      'Casa',
      {'dumbbells', 'bands', 'mat', 'weighted_backpack', 'chair_support'},
    ),
    'Casa com barra fixa': ('Casa', {'pullup_bar', 'mat'}),
    'Exterior': ('Exterior / parque', <String>{}),
    'Dojo': ('Dojo / artes marciais', {'tatami'}),
    'Ginásio': ('Ginásio', <String>{}),
  };
  for (final scenario in scenarios.entries) {
    final available = <String>[];
    final unavailable = <String>[];
    for (final exercise in exercises) {
      final ok = ExerciseFilterService.getAvailableExercises(
        exercises: [exercise],
        trainingLocation: scenario.value.$1,
        availableEquipmentKeys: scenario.value.$2,
        selection: const TrainingSelection(),
        showAllExercises: false,
      ).isNotEmpty;
      (ok ? available : unavailable)
          .add('${exercise.name} [${exercise.muscleGroup}] {${exercise.equipment}}');
    }
    buffer.writeln(
      '\n## ${scenario.key}: ${available.length} disponíveis / ${unavailable.length} indisponíveis',
    );
    buffer.writeln('### Disponíveis');
    for (final line in available) {
      buffer.writeln('- $line');
    }
    buffer.writeln('### Indisponíveis');
    for (final line in unavailable) {
      buffer.writeln('- $line');
    }
  }

  // Text quality: flag generic/templated wording that a beginner could not
  // follow, plus steps shared verbatim between different exercises.
  buffer.writeln('\n# TEXT QUALITY FLAGS');
  final stepsByText = <String, List<String>>{};
  for (final entry in ExerciseCatalogContextService.entries) {
    stepsByText
        .putIfAbsent(_stepCore(entry.details.executionSteps), () => [])
        .add('${entry.name} [${entry.group}]');
  }
  const genericCues = [
    'conforme a variação',
    'conforme a variacao',
    'indicada pela variação',
    'indicado pela variação',
    'na direção indicada pela variação',
    'adequada ao',
    'a trajetória específica desta variação',
    'indicada pelo nome',
    'indicado pelo nome',
    'com movimento específico de',
    'trabalha o padrão principal de',
    'pela trajetória do',
    'posição inicial do',
    'de acordo com',
    'define se o foco é',
    'define se o exercício exige',
    'variação escolhida',
    'segundo a variação',
  ];
  for (final entry in ExerciseCatalogContextService.entries) {
    final text =
        '${entry.details.description} ||| ${entry.details.executionSteps}';
    final lower = text.toLowerCase();
    final hits = genericCues.where(lower.contains).toList();
    if (hits.isNotEmpty) {
      buffer.writeln('- ${entry.id} ${entry.name} [${entry.group}]: $hits');
    }
  }
  buffer.writeln('\n# SHARED EXECUTION STEPS (mesmos passos, exercícios diferentes)');
  for (final entry in stepsByText.entries) {
    final uniqueNames = entry.value.toSet();
    if (uniqueNames.length > 1) {
      buffer.writeln('- ${uniqueNames.length}x: ${uniqueNames.join(' | ')}');
    }
  }

  buffer.writeln('\n# TAGS POR EXERCÍCIO');
  for (final entry in ExerciseCatalogContextService.entries) {
    final tags = TrainingArchitecture.tagsForExercise(entry.toExercise());
    buffer.writeln(
      '- ${entry.id} ${entry.name} [${entry.group}] '
      'regions=${tags.regionKeys} groups=${tags.groupKeys} '
      'subgroups=${tags.subgroupKeys} muscles=${tags.muscleKeys} '
      'equip=${tags.equipmentKeys} {${entry.details.equipment}}',
    );
  }

  File('tool/full_audit_v081_output.md').writeAsStringSync(buffer.toString());
  stdout.writeln('wrote tool/full_audit_v081_output.md');
}

String _stepCore(String steps) =>
    steps.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), ' ').trim();

const _strengthGroups = <String, (String, String)>{
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
