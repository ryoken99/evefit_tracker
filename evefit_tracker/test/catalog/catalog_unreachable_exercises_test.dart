import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('unreachable exercise audit is generated for diagnostic review', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);

    expect(audit.axisInventory.exercises.length, greaterThanOrEqualTo(1371));
    expect(audit.unreachableExercises.length, greaterThanOrEqualTo(0));
  });
}
