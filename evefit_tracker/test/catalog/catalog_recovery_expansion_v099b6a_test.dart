import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b6a_cardio_warmup_recovery_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B6A adds 28 recovery entries from GOOD_V1', () {
    final recoveryEntries = v099b6aCardioWarmupRecoveryDomainEntries
        .where((entry) => entry.primaryType == 'recuperacao')
        .toList();

    expect(recoveryEntries, hasLength(28));

    final exercises = ExerciseCatalogContextService.entries
        .map((entry) => entry.toExercise())
        .where((exercise) => exercise.primaryType == 'recuperacao')
        .toList();

    expect(exercises, hasLength(147));
    for (final expected in recoveryEntries) {
      expect(
        exercises.any(
          (exercise) =>
              exercise.name == expected.name &&
              exercise.contextKey == expected.contextKey,
        ),
        isTrue,
        reason: '${expected.name} must be present as a recovery exercise',
      );
    }
  });
}
