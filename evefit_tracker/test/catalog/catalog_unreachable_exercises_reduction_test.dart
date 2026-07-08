import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'v0.9.6 total matrix reduces visible unreachable exercises below target',
    () {
      final audit = CatalogTotalMatrixAudit.run(writeReports: false);

      expect(audit.failWrongResults, isEmpty);
      expect(audit.unreachableExercises.length, lessThan(150));
    },
  );
}
