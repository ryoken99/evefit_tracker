import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b6a_cardio_warmup_recovery_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B6A adds 35 cardio entries from GOOD_V1', () {
    final cardioEntries = v099b6aCardioWarmupRecoveryDomainEntries
        .where((entry) => entry.primaryType == 'cardio')
        .toList();

    expect(cardioEntries, hasLength(35));

    final entriesByNameAndContext = {
      for (final entry in ExerciseCatalogContextService.entries)
        '${entry.name}__${entry.contextKey}': entry,
    };

    for (final expected in cardioEntries) {
      expect(
        entriesByNameAndContext['${expected.name}__${expected.contextKey}'],
        isNotNull,
        reason: '${expected.name} must be present in cardio routes',
      );
    }
  });
}
