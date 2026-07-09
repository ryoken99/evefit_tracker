import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('recovery catalog does not expose high intensity cardio entries', () {
    final recoveryExercises = ExerciseCatalogContextService.entries
        .map((entry) => entry.toExercise())
        .where((exercise) => exercise.primaryType == 'recuperacao')
        .toList();

    for (final exercise in recoveryExercises) {
      final text = [
        exercise.name,
        exercise.description,
        exercise.executionSteps,
        exercise.commonMistakes,
        exercise.progression,
      ].join(' ').toLowerCase();

      expect(
        text.contains('hiit'),
        isFalse,
        reason: '${exercise.name} must not expose HIIT in recovery',
      );
      expect(
        text.contains('sprint'),
        isFalse,
        reason: '${exercise.name} must not expose sprinting in recovery',
      );
    }
  });
}
