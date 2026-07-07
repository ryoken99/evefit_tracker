import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'v0.9.5 cardio paths do not mix focus and equipment as wrong results',
    () {
      final audit = CatalogTotalMatrixAudit.run(writeReports: false);
      final cardioWrong = audit.failWrongResults
          .where((path) => path.typeKey == 'cardio')
          .toList(growable: false);

      expect(cardioWrong, isEmpty, reason: _issueSummary(cardioWrong));
    },
  );

  test('v0.9.5 required cardio scenarios resolve without wrong results', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);
    final paths = {for (final path in audit.menuPaths) path.id: path};

    for (final id in const {
      'cardio>place_home_no_equipment>bodyweight>hiit',
      'cardio>place_home_equipped>bodyweight>hiit',
      'cardio>place_gym>bodyweight>hiit',
      'cardio>place_gym>treadmill>aerobic_endurance',
      'cardio>place_gym>treadmill>treadmill_intervals',
      'cardio>place_gym>bike>aerobic_endurance',
    }) {
      final path = paths[id];
      expect(path, isNotNull, reason: 'Missing cardio matrix path $id');
      expect(path!.status, isNot(MenuMatrixStatus.failWrongResults));
    }
  });
}

String _issueSummary(List<MenuPathAudit> paths) =>
    paths.take(10).map((path) => '${path.id}: ${path.issue}').join('\n');
