import 'dart:io';

import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/training_flow.dart';

/// Matriz de cobertura músculo × classe de equipamento: para cada foco da UI
/// de musculação, conta quantos exercícios existem por classe de equipamento.
/// Revela células vazias (músculo sem exercício para um equipamento da app).
void main() {
  final entries = ExerciseCatalogContextService.entries;
  final exercises = entries.map((entry) => entry.toExercise()).toList();
  final entryByKey = {
    for (final entry in entries) '${entry.name}__${entry.group}': entry,
  };
  final allEquipment = EquipmentCatalogService.definitions.keys.toSet();

  const equipClasses = [
    'peso corporal',
    'halteres',
    'barra',
    'kettlebell',
    'cabo',
    'máquina',
    'elástico',
  ];

  String classOf(String equipment) {
    final e = equipment.toLowerCase();
    if (e.contains('kettlebell')) return 'kettlebell';
    if (e.contains('elástico') || e.contains('elastico')) return 'elástico';
    if (e.contains('cabo') && !e.contains('vassoura') || e.contains('polia')) {
      return 'cabo';
    }
    if (e.contains('máquina') ||
        e.contains('maquina') ||
        e.contains('romano')) {
      return 'máquina';
    }
    if (e.contains('halter') ||
        e.contains('disco') ||
        e.contains('garraf') ||
        e.contains('mochila')) {
      return 'halteres';
    }
    if (e.contains('barra fixa') || e.contains('paralelas')) {
      return 'peso corporal';
    }
    if (e.contains('barra')) return 'barra';
    return 'peso corporal';
  }

  List<ExerciseCatalogEntry> matching(TrainingSelection selection) {
    final seen = <String>{};
    final result = <ExerciseCatalogEntry>[];
    for (final scenario in [
      ('Ginásio', const <String>{}),
      ('Casa', allEquipment),
      ('Exterior / parque', const <String>{}),
      ('Dojo / artes marciais', {'tatami', 'heavy_bag'}),
    ]) {
      for (final item in ExerciseFilterService.getAvailableExercises(
        exercises: exercises,
        trainingLocation: scenario.$1,
        availableEquipmentKeys: scenario.$2,
        selection: selection,
        showAllExercises: false,
      )) {
        final entry =
            entryByKey['${item.exercise.name}__${item.exercise.muscleGroup}'];
        if (entry == null || !seen.add(entry.name)) continue;
        result.add(entry);
      }
    }
    return result;
  }

  const groups = <String, (String, String, String)>{
    'chest': ('upper', 'chest', 'Peito'),
    'back': ('upper', 'back', 'Costas'),
    'shoulders': ('upper', 'shoulders', 'Ombros'),
    'traps_scapula': ('upper', 'traps_scapula', 'Trapézio'),
    'neck': ('upper', 'neck', 'Pescoço'),
    'arms': ('upper', 'arms', 'Braços'),
    'forearm_hand': ('upper', 'forearm_hand', 'Antebraço'),
    'core': ('core', '', 'Core'),
    'legs': ('lower', 'legs', 'Pernas'),
  };

  final buffer = StringBuffer()
    ..writeln('# Matriz de cobertura: músculo × classe de equipamento')
    ..writeln()
    ..writeln('Contagem de exercícios por foco da UI e classe de equipamento.')
    ..writeln('`·` = zero exercícios para essa combinação.')
    ..writeln()
    ..writeln('| Foco | ${equipClasses.join(' | ')} | total |')
    ..writeln('|---|${'---|' * (equipClasses.length + 1)}');

  void row(String label, List<ExerciseCatalogEntry> list) {
    final counts = {for (final c in equipClasses) c: 0};
    for (final entry in list) {
      counts[classOf(entry.details.equipment)] =
          (counts[classOf(entry.details.equipment)] ?? 0) + 1;
    }
    final cells = equipClasses
        .map((c) => counts[c] == 0 ? '·' : '${counts[c]}')
        .join(' | ');
    buffer.writeln('| $label | $cells | ${list.length} |');
  }

  for (final group in groups.entries) {
    for (final subzone in TrainingFlow.strengthSubzonesForGroup(group.key)) {
      row(
        '**${group.value.$3} › ${subzone.value}**',
        matching(
          TrainingFlow.toTrainingSelection(
            TrainingFlowSelection(
              typeKey: 'strength',
              regionKey: group.value.$1,
              groupKey: group.value.$2,
              subzoneKey: subzone.key,
            ),
          ),
        ),
      );
      for (final focus in TrainingFlow.strengthSpecificOptions(
        group.key,
        subzone.key,
      )) {
        if (focus.key == subzone.key) continue;
        row(
          '${group.value.$3} › ${subzone.value} › ${focus.value}',
          matching(
            TrainingFlow.toTrainingSelection(
              TrainingFlowSelection(
                typeKey: 'strength',
                regionKey: group.value.$1,
                groupKey: group.value.$2,
                subzoneKey: subzone.key,
                focusKey: focus.key,
              ),
            ),
          ),
        );
      }
    }
  }

  File('tool/coverage_matrix.md').writeAsStringSync(buffer.toString());
  stdout.writeln('wrote tool/coverage_matrix.md');
}
