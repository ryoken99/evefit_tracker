import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b3_strength_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B3 reaches the GOOD_V1 strength target without regressions', () {
    final audit = CatalogQualityAudit.run();
    final strengthEntries = ExerciseCatalogContextService.entries
        .map((entry) => entry.toExercise())
        .where((exercise) => exercise.primaryType == 'musculacao')
        .toList();

    expect(strengthEntries, hasLength(400));
    expect(audit.totalExercises, greaterThanOrEqualTo(1687));
    expect(audit.criticalCount, 0);
    expect(audit.warningCount, 0);
    expect(v099b3StrengthDomainEntries, hasLength(71));
  });
}
