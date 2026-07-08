import 'package:evefit_tracker/services/catalog_quality/catalog_menu_axis_contract.dart';
import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.7 every zero-coverage visible axis has an approved decision', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);
    final zeroCoverageAxes = audit.axisCoverage
        .where((axis) => axis.count == 0)
        .toList(growable: false);

    expect(zeroCoverageAxes, isNotEmpty);
    expect(
      zeroCoverageAxes.every(CatalogMenuAxisContractPolicy.hasAxisDecision),
      isTrue,
    );
    expect(
      zeroCoverageAxes.where(
        CatalogMenuAxisContractPolicy.isVisibleWithoutDecision,
      ),
      isEmpty,
    );
  });
}
