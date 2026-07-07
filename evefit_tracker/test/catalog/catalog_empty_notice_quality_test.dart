import 'package:evefit_tracker/services/catalog_quality/catalog_menu_axis_contract.dart';
import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.7 empty visible paths use approved specific notices', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);
    final emptyPaths = audit.okEmptyWithExplicitNotice;

    expect(emptyPaths, isNotEmpty);
    expect(
      emptyPaths.where(CatalogMenuAxisContractPolicy.hasGenericNotice),
      isEmpty,
    );
    expect(
      emptyPaths.every(
        CatalogMenuAxisContractPolicy.hasApprovedEmptyPathDecision,
      ),
      isTrue,
    );
  });
}
