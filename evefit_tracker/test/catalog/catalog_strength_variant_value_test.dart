import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'v099b2_strength_expected.dart';

void main() {
  test(
    'v0.9.9B2 variants have explicit value and no duplicate canonical IDs',
    () {
      final entriesByKey = {
        for (final entry in ExerciseCatalogContextService.entries)
          entry.exerciseKey: entry,
      };
      final seen = <String>{};

      for (final expected in v099b2StrengthExpectedExercises) {
        expect(seen.add(expected.key), isTrue, reason: expected.key);
        final entry = entriesByKey[expected.key];
        expect(entry, isNotNull, reason: expected.key);
        final text =
            '${entry!.details.description}\n${entry.details.executionSteps}\n'
                    '${entry.details.regression}\n${entry.details.progression}'
                .toLowerCase();
        expect(
          text,
          anyOf([
            contains('pausa'),
            contains('lento'),
            contains('control'),
            contains('unilateral'),
            contains('regress'),
            contains('barra'),
            contains('halter'),
            contains('cabo'),
            contains('inclinado'),
            contains('declinado'),
            contains('suspensao'),
            contains('anti-rotacao'),
          ]),
          reason: '${entry.name} must explain its useful variation',
        );
      }
    },
  );
}
