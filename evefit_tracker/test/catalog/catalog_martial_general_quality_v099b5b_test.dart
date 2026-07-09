import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:evefit_tracker/services/v099b5b_martial_general_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B5B keeps audit clean after martial expansion', () {
    final audit = CatalogQualityAudit.run();

    expect(v099b5bMartialGeneralDomainEntries, hasLength(56));
    expect(audit.totalExercises, greaterThanOrEqualTo(1762));
    expect(audit.criticalCount, 0);
    expect(audit.warningCount, 0);
  });
}
