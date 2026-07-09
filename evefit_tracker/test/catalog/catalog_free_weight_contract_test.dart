import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

import 'v099b2_strength_expected.dart';

void main() {
  test('v0.9.9B2 free weight equipment contract matches each entry', () {
    final entriesByKey = {
      for (final entry in ExerciseCatalogContextService.entries)
        entry.exerciseKey: entry,
    };

    for (final expected in v099b2StrengthExpectedExercises) {
      final entry = entriesByKey[expected.key];
      expect(entry, isNotNull, reason: expected.key);
      final equipment = entry!.details.equipment;
      expect(equipment, contains(expected.equipmentCue), reason: entry.name);
      expect(
        TrainingArchitecture.equipmentKeysFor(equipment),
        contains(expected.equipmentKey),
        reason: entry.name,
      );
    }
  });
}
