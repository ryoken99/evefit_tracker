import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GOOD_V1 visible menu matrix has no wrong results', () {
    final matrix = CatalogTotalMatrixAudit.run();

    expect(matrix.failWrongResults, isEmpty);
    expect(matrix.failEmptySilent, isEmpty);
    expect(matrix.failIncompatibleMenu, isEmpty);
  });
}
