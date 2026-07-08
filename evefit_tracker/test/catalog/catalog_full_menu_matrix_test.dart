import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('full visible menu matrix classifies every generated path', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);

    expect(audit.menuPaths.length, greaterThan(100));
    expect(audit.okWithResults.length, greaterThan(50));
    expect(
      audit.menuPaths.every(
        (path) => path.notice.isNotEmpty || path.issue.isNotEmpty,
      ),
      isTrue,
    );
  });

  test('dojo karate complete is covered by results or explicit fallback', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);
    final path = audit.menuPaths.singleWhere(
      (item) =>
          item.typeKey == 'martial_arts' &&
          item.locationKey == 'place_dojo' &&
          item.martialArtKey == 'karate' &&
          item.focusKey == 'karate_complete',
    );

    expect({
      MenuMatrixStatus.okWithResults,
      MenuMatrixStatus.okWithFallback,
      MenuMatrixStatus.okEmptyWithExplicitNotice,
    }, contains(path.status));
    expect(path.notice, isNotEmpty);
  });
}
