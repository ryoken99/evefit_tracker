import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_taxonomy_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'v099b1_strength_expected.dart';

void main() {
  test('v0.9.9B1 strength equipment and anatomy match the approved lot', () {
    final entriesByKey = {
      for (final entry in ExerciseCatalogContextService.entries)
        entry.exerciseKey: entry,
    };

    for (final expected in v099b1StrengthExpectedExercises) {
      final entry = entriesByKey[expected.key];
      expect(entry, isNotNull, reason: '${expected.key} must exist');

      final details = entry!.details;
      final enriched = ExerciseTaxonomyService.enrichCatalogExercise(entry);
      expect(details.equipment, contains(expected.equipmentCue));
      expect(enriched.equipmentKeys, contains(expected.equipmentKey));
      expect(entry.group, expected.group);
      expect(details.description.length, greaterThanOrEqualTo(80));
      expect(details.description.toLowerCase(), isNot(contains('generic')));
      expect(
        details.executionSteps.split('\n'),
        hasLength(greaterThanOrEqualTo(6)),
      );
      expect(details.breathingTips, isNotEmpty);
      expect(details.regression, isNotEmpty);
      expect(details.progression, isNotEmpty);
      expect(details.adaptationNotes, isNotEmpty);
    }
  });
}
