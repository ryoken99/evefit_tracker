import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'v099b1_strength_expected.dart';

void main() {
  test('v0.9.9B1 strength lot keeps canonical and entry identities unique', () {
    final expectedKeys = v099b1StrengthExpectedExercises
        .map((exercise) => exercise.key)
        .toSet();
    expect(expectedKeys, hasLength(v099b1StrengthExpectedExercises.length));

    final matchingEntries = ExerciseCatalogContextService.entries
        .where((entry) => expectedKeys.contains(entry.exerciseKey))
        .toList();

    expect(matchingEntries, hasLength(v099b1StrengthExpectedExercises.length));
    expect(
      matchingEntries.map((entry) => entry.catalogEntryKey).toSet(),
      hasLength(matchingEntries.length),
    );
    expect(
      matchingEntries.map((entry) => entry.toExercise().canonicalId).toSet(),
      hasLength(matchingEntries.length),
    );
  });
}
