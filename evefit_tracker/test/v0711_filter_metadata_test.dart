import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.11 metadata-first filtering', () {
    test(
      'face pull contexts are available in shoulders, back and trapezius',
      () {
        final exercises = ExerciseCatalogContextService.entries
            .map((entry) => entry.toExercise())
            .toList();

        final shoulders = ExerciseFilterService.getAvailableExercises(
          exercises: exercises,
          trainingLocation: 'Ginásio',
          availableEquipmentKeys: {'high_cable'},
          selection: const TrainingSelection(
            regionKey: 'upper',
            groupKey: 'shoulders',
          ),
          showAllExercises: false,
        ).map((item) => item.exercise.catalogEntryKey);

        final back = ExerciseFilterService.getAvailableExercises(
          exercises: exercises,
          trainingLocation: 'Ginásio',
          availableEquipmentKeys: {'high_cable'},
          selection: const TrainingSelection(
            regionKey: 'upper',
            groupKey: 'back',
          ),
          showAllExercises: false,
        ).map((item) => item.exercise.catalogEntryKey);

        final traps = ExerciseFilterService.getAvailableExercises(
          exercises: exercises,
          trainingLocation: 'Ginásio',
          availableEquipmentKeys: {'high_cable'},
          selection: const TrainingSelection(
            regionKey: 'upper',
            groupKey: 'traps_scapula',
          ),
          showAllExercises: false,
        ).map((item) => item.exercise.catalogEntryKey);

        expect(shoulders, contains('face_pull_no_cabo__ombros'));
        expect(back, contains('face_pull_no_cabo__costas'));
        expect(traps, contains('face_pull_no_cabo__trapezio'));
      },
    );

    test(
      'arms complete with dumbbells keeps arm branches and excludes chest',
      () {
        final exercises = ExerciseCatalogContextService.entries
            .map((entry) => entry.toExercise())
            .toList();
        final visible = ExerciseFilterService.getAvailableExercises(
          exercises: exercises,
          trainingLocation: 'Casa',
          availableEquipmentKeys: {'dumbbells'},
          selection: const TrainingSelection(
            regionKey: 'upper',
            groupKey: 'arms',
            subgroupKey: 'arms_complete',
            equipmentKey: 'dumbbells',
          ),
          showAllExercises: false,
        ).map((item) => item.exercise.name).toSet();

        expect(visible, contains('Curl com halteres'));
        expect(visible, contains('Extensão francesa com halter'));
        expect(visible, contains('Wrist curl'));
        expect(visible, contains('Suitcase carry'));
        expect(visible.any((name) => name.contains('Supino')), isFalse);
        expect(visible.any((name) => name.contains('Aberturas')), isFalse);
      },
    );

    test('cardio treadmill focus does not mix bike or elliptical', () {
      final exercises = ExerciseCatalogContextService.entries
          .map((entry) => entry.toExercise())
          .toList();
      final visible = ExerciseFilterService.getAvailableExercises(
        exercises: exercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: {'treadmill'},
        selection: const TrainingSelection(
          regionKey: 'cardio',
          groupKey: 'cardio_machine',
          subgroupKey: 'treadmill',
          equipmentKey: 'treadmill',
        ),
        showAllExercises: false,
      ).map((item) => item.exercise.name).toSet();

      expect(visible, isNotEmpty);
      expect(
        visible.every((name) => name.toLowerCase().contains('passadeira')),
        isTrue,
      );
      expect(visible.any((name) => name.contains('Bicicleta')), isFalse);
      expect(visible.any((name) => name.contains('Elíptica')), isFalse);
    });
  });
}
