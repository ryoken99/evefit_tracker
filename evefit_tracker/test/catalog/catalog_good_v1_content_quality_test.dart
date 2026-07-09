import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GOOD_V1 catalog has no critical, warning or D/E quality findings', () {
    final audit = CatalogQualityAudit.run();
    final issueCodes = audit.issues.map((issue) => issue.code).toList();

    expect(audit.criticalCount, 0);
    expect(audit.warningCount, 0);
    expect(
      issueCodes.where((code) => code.contains('quality_d')).toList(),
      isEmpty,
    );
    expect(
      issueCodes.where((code) => code.contains('quality_e')).toList(),
      isEmpty,
    );
  });
}
