import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.12 anatomy filter matrix quality gate', () {
    test('valid anatomy combinations do not leak outside their branch', () {
      final failures = CatalogQualityGateService.anatomyFilterFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
      expect(CatalogQualityGateService.filterCombinationCount, greaterThan(20));
    });
  });
}
