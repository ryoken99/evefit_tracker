import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.12 equipment-description quality gate', () {
    test('equipment metadata agrees with execution text', () {
      final failures = CatalogQualityGateService.equipmentDescriptionFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
    });
  });
}
