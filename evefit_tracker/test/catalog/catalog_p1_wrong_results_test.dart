import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.5 P1 matrix has no wrong-result menu paths', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);

    expect(
      audit.failWrongResults,
      isEmpty,
      reason: audit.failWrongResults
          .take(10)
          .map((path) => '${path.id}: ${path.issue}')
          .join('\n'),
    );
  });
}
