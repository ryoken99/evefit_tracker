import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'v0.9.5 mobility paths do not expose martial drills as general mobility',
    () {
      final audit = CatalogTotalMatrixAudit.run(writeReports: false);
      final mobilityWrong = audit.failWrongResults
          .where((path) => path.typeKey == 'mobility')
          .toList(growable: false);

      expect(mobilityWrong, isEmpty, reason: _issueSummary(mobilityWrong));

      final generalMobility = audit.menuPaths.where(
        (path) =>
            path.typeKey == 'mobility' && path.focusKey == 'general_mobility',
      );
      for (final path in generalMobility) {
        expect(
          path.exerciseKeys,
          isNot(contains('technical_stand_up_lento__solo')),
          reason: '${path.id} should not expose technical stand-up generally',
        );
      }
    },
  );
}

String _issueSummary(List<MenuPathAudit> paths) =>
    paths.take(10).map((path) => '${path.id}: ${path.issue}').join('\n');
