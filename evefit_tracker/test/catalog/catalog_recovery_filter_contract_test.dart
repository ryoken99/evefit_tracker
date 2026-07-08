import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.5 recovery paths stay in recovery-compatible intensity', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);
    final recoveryWrong = audit.failWrongResults
        .where((path) => path.typeKey == 'recovery')
        .toList(growable: false);

    expect(recoveryWrong, isEmpty, reason: _issueSummary(recoveryWrong));
  });

  test(
    'v0.9.5 recovery breathing paths do not include active walking drills',
    () {
      final audit = CatalogTotalMatrixAudit.run(writeReports: false);
      final breathingPaths = audit.menuPaths.where(
        (path) => path.typeKey == 'recovery' && path.focusKey == 'breathing',
      );

      for (final path in breathingPaths) {
        expect(
          path.exerciseKeys.any((key) => key.contains('caminhada')),
          isFalse,
          reason: '${path.id} should only return breathing/downshift content',
        );
      }
    },
  );
}

String _issueSummary(List<MenuPathAudit> paths) =>
    paths.take(10).map((path) => '${path.id}: ${path.issue}').join('\n');
