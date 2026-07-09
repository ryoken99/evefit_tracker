import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b6a_cardio_warmup_recovery_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B6A adds 19 warmup entries from GOOD_V1', () {
    final warmupEntries = v099b6aCardioWarmupRecoveryDomainEntries
        .where((entry) => entry.primaryType == 'aquecimento')
        .toList();

    expect(warmupEntries, hasLength(19));

    final exercises = ExerciseCatalogContextService.entries
        .map((entry) => entry.toExercise())
        .where((exercise) => exercise.primaryType == 'aquecimento')
        .toList();

    expect(exercises, hasLength(150));
    for (final expected in warmupEntries) {
      expect(
        exercises.any(
          (exercise) =>
              exercise.name == expected.name &&
              exercise.contextKey == expected.contextKey,
        ),
        isTrue,
        reason: '${expected.name} must be present as a warmup exercise',
      );
    }
  });
}
