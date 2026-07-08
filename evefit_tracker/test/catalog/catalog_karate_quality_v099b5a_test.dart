import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b5a_karate_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B5A keeps audit clean after karate expansion', () {
    final audit = CatalogQualityAudit.run();
    final karateEntries = ExerciseCatalogContextService.entries
        .where((entry) => entry.contextKey == 'karate')
        .toList();

    expect(v099b5aKarateDomainEntries, hasLength(72));
    expect(karateEntries.length, greaterThanOrEqualTo(72));
    expect(audit.totalExercises, greaterThanOrEqualTo(1608));
    expect(audit.criticalCount, 0);
    expect(audit.warningCount, 0);
  });

  test('v0.9.9B5A names stay generic karate and not style-specific', () {
    for (final entry in v099b5aKarateDomainEntries) {
      final text = '${entry.name} ${entry.section} ${entry.goal}'.toLowerCase();
      expect(text, isNot(contains('shukokai')));
      expect(text, isNot(contains('sandro')));
    }
  });
}
