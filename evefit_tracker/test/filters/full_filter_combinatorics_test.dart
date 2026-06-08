import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.12 full filter combinatorics quality gate', () {
    test('all generated valid filter combinations are classified', () {
      final failures = CatalogQualityGateService.fullCombinatoricsFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
      expect(CatalogQualityGateService.filterCombinationCount, greaterThan(50));
    });
  });
}
