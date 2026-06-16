import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_display_service.dart';
import 'package:evefit_tracker/services/exercise_muscle_node_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every catalog exercise has primaryMuscleNodes', () {
    final missing = ExerciseCatalogContextService.entries.where((entry) {
      return ExerciseMuscleNodeService.nodesForCatalogEntry(
        entry,
      ).primary.trim().isEmpty;
    }).toList();

    expect(missing, isEmpty);
  });

  test('arm catalog entries do not use only broad groups as primary nodes', () {
    final failures = ExerciseCatalogContextService.entries.where((entry) {
      final primary = ExerciseMuscleNodeService.nodesForCatalogEntry(
        entry,
      ).primary.trim();
      return (entry.group == 'Bíceps' && primary == 'Bíceps') ||
          (entry.group == 'Tríceps' && primary == 'Tríceps') ||
          (entry.group == 'Antebraço/Pega' && primary == 'Antebraço/Pega');
    }).toList();

    expect(failures, isEmpty);
  });

  test('exercise list subtitle prefers granular primary nodes', () {
    final hammer = _exercise('Curl martelo', 'Bíceps');
    final wrist = _exercise('Wrist curl', 'Antebraço/Pega');
    final zottman = _exercise('Curl Zottman', 'Bíceps');

    expect(
      ExerciseDisplayService.subtitleForList(hammer),
      'Braquial · Braquiorradial · Halteres',
    );
    expect(
      ExerciseDisplayService.subtitleForList(wrist),
      'Flexores do antebraço · Punho · Halteres',
    );
    expect(
      ExerciseDisplayService.subtitleForList(zottman),
      'Bíceps cabeça longa · Bíceps cabeça curta · +2 · Halteres',
    );
  });
}

dynamic _exercise(String name, String group) {
  final entry = ExerciseCatalogContextService.entryFor(
    name: name,
    group: group,
  );
  final nodes = ExerciseMuscleNodeService.nodesForCatalogEntry(entry);
  return entry.toExercise().copyWith(
    primaryMuscleNodes: nodes.primary,
    secondaryMuscleNodes: nodes.secondary,
  );
}
