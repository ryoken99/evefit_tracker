import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.12 equipment filter matrix quality gate', () {
    test('profile equipment controls exercise availability', () {
      final failures = CatalogQualityGateService.equipmentFilterFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
      expect(
        CatalogQualityGateService.equipmentSimulationCount,
        greaterThan(10),
      );
    });
  });
}
