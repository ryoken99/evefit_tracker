import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/exercise_taxonomy_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.8.0 manual filter review matrix', () {
    test(
      'BW-CHEST-001 persisted home bodyweight chest complete shows push-ups',
      () {
        final names = _visibleNames(
          const TrainingSelection(
            regionKey: 'upper',
            groupKey: 'chest',
            specificMuscleKey: 'chest_complete',
            equipmentKey: 'bodyweight',
          ),
        );

        expect(
          names,
          containsAll({
            'Flexão clássica',
            'Flexão com joelhos apoiados',
            'Flexão aberta',
          }),
        );
        expect(names.any((name) => name.contains('Supino')), isFalse);
        expect(names.any((name) => name.contains('cabo')), isFalse);
        expect(names.any((name) => name.contains('máquina')), isFalse);
      },
    );
  });
}

Set<String> _visibleNames(
  TrainingSelection selection, {
  String location = 'Casa',
  Set<String> equipment = const {'bodyweight', 'floor', 'wall'},
}) {
  final persistedExercises = ExerciseCatalogContextService.entries
      .map(ExerciseTaxonomyService.enrichCatalogExercise)
      .toList();
  return ExerciseFilterService.getAvailableExercises(
    exercises: persistedExercises,
    trainingLocation: location,
    availableEquipmentKeys: equipment,
    selection: selection,
    showAllExercises: false,
  ).map((item) => item.exercise.name).toSet();
}
