import 'package:evefit_tracker/services/catalog_quality/catalog_menu_axis_contract.dart';
import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.7 menu axis decision summary covers all empty paths and axes', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);
    final summary = CatalogMenuAxisContractPolicy.summarize(audit);

    expect(summary.emptyPathCount, audit.okEmptyWithExplicitNotice.length);
    expect(summary.genericNoticeCount, 0);
    expect(summary.visibleAxisWithoutDecisionCount, 0);
    expect(summary.failWrongResultsCount, 0);
    expect(summary.unreachableExerciseCount, 0);
    expect(
      summary.emptyPathDecisionCounts.values.reduce((a, b) => a + b),
      summary.emptyPathCount,
    );
  });
}
