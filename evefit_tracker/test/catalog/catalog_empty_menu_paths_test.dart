import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty menu paths are separated from paths with results', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);

    for (final path in audit.okEmptyWithExplicitNotice) {
      expect(path.notice, isNotEmpty);
    }
    expect(
      audit.menuPaths.length,
      audit.okWithResults.length +
          audit.okWithFallback.length +
          audit.okEmptyWithExplicitNotice.length +
          audit.failEmptySilent.length +
          audit.failWrongResults.length +
          audit.failIncompatibleMenu.length,
    );
  });
}
