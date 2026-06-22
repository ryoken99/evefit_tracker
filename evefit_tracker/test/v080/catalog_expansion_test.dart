import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/exercise_taxonomy_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const expectedNewExercises = {
    'Short foot / doming',
    'Flexão ativa dos dedos do pé',
    'Dorsiflexão do tornozelo com elástico',
    'Inversão do tornozelo com elástico',
    'Eversão do tornozelo com elástico',
    'Flexão da anca em pé com elástico',
    'Copenhagen plank com apoio',
    'Extensão terminal do joelho com elástico',
    'Abdução de anca deitada',
  };

  test('v0.8.0 adds realistic exercises for remaining lower-body gaps', () {
    final names = ExerciseCatalogContextService.entries
        .map((entry) => entry.name)
        .toSet();
    expect(names, containsAll(expectedNewExercises));
  });

  test('new exercises have explicit anatomy and equipment taxonomy', () {
    final byName = {
      for (final entry in ExerciseCatalogContextService.entries)
        entry.name: ExerciseTaxonomyService.forCatalogEntry(entry),
    };

    expect(byName['Short foot / doming']!.allMuscleKeys, contains('feet'));
    expect(
      byName['Dorsiflexão do tornozelo com elástico']!.allMuscleKeys,
      contains('tibialis_anterior'),
    );
    expect(
      byName['Flexão da anca em pé com elástico']!.allMuscleKeys,
      contains('hip_flexors'),
    );
    expect(
      byName['Copenhagen plank com apoio']!.allMuscleKeys,
      contains('adductors'),
    );
    expect(
      byName['Extensão terminal do joelho com elástico']!.allMuscleKeys,
      contains('vastus_medialis'),
    );
    for (final name in expectedNewExercises.where(
      (name) => name.contains('elástico'),
    )) {
      expect(byName[name]!.equipmentKeys, contains('bands'), reason: name);
    }
  });

  test('home without equipment only receives compatible additions', () {
    final exercises = ExerciseCatalogContextService.entries
        .map(ExerciseTaxonomyService.enrichCatalogExercise)
        .toList();
    final available = ExerciseFilterService.getAvailableExercises(
      exercises: exercises,
      trainingLocation: 'Casa',
      availableEquipmentKeys: {'bodyweight'},
      selection: const TrainingSelection(),
      showAllExercises: false,
    ).map((item) => item.exercise.name).toSet();

    expect(available, contains('Short foot / doming'));
    expect(available, contains('Flexão ativa dos dedos do pé'));
    expect(available, contains('Abdução de anca deitada'));
    expect(available, isNot(contains('Copenhagen plank com apoio')));
    expect(available, isNot(contains('Dorsiflexão do tornozelo com elástico')));
  });
}
