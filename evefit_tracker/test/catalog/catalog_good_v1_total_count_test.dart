import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GOOD_V1 final catalog total is within release target range', () {
    final audit = CatalogQualityAudit.run();

    expect(audit.totalExercises, inInclusiveRange(1750, 1800));
    expect(audit.totalExercises, 1762);
    expect(audit.uniqueCanonicalIds, greaterThanOrEqualTo(1700));
    expect(audit.criticalCount, 0);
    expect(audit.warningCount, 0);
  });
}
