import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/v099b3_strength_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B3 equipment and variants have explicit training value', () {
    final entriesByKey = {
      for (final entry in ExerciseCatalogContextService.entries)
        entry.exerciseKey: entry,
    };
    final seen = <String>{};

    for (final expected in v099b3StrengthDomainEntries) {
      final expectedKey = ExerciseCatalogContextService.stableKey(
        expected.name,
      );
      expect(seen.add(expectedKey), isTrue, reason: expectedKey);
      final entry = entriesByKey[expectedKey];
      expect(entry, isNotNull, reason: expectedKey);

      final equipment = entry!.details.equipment;
      expect(
        TrainingArchitecture.equipmentKeysFor(equipment),
        isNotEmpty,
        reason: entry.name,
      );

      final text =
          '${entry.details.description}\n${entry.details.executionSteps}\n'
                  '${entry.details.regression}\n${entry.details.progression}'
              .toLowerCase();
      expect(
        text,
        anyOf([
          contains('pausa'),
          contains('lento'),
          contains('control'),
          contains('regress'),
          contains('unilateral'),
          contains('cabo'),
          contains('maquina'),
          contains('smith'),
          contains('barra'),
          contains('halter'),
          contains('anti-rotacao'),
        ]),
        reason: '${entry.name} must explain its useful variation',
      );
    }
  });
}
