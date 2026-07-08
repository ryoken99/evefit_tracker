import 'package:evefit_tracker/services/catalog_quality/catalog_menu_axis_contract.dart';
import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'v0.9.7 fallback decisions do not regress wrong results or reachability',
    () {
      final audit = CatalogTotalMatrixAudit.run(writeReports: false);
      final registry = CatalogRouteRegistry.build();

      expect(audit.failWrongResults, isEmpty);
      expect(audit.failEmptySilent, isEmpty);
      expect(audit.failIncompatibleMenu, isEmpty);
      expect(audit.unreachableExercises, isEmpty);
      expect(registry.usableCleanExerciseCount, greaterThanOrEqualTo(1371));
      expect(
        audit.okWithFallback.every(
          CatalogMenuAxisContractPolicy.hasApprovedFallbackNotice,
        ),
        isTrue,
      );
    },
  );
}
