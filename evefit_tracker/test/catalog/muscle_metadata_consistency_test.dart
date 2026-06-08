import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.12 muscle metadata consistency quality gate', () {
    test('primary context and returned filters stay coherent', () {
      final failures = CatalogQualityGateService.muscleMetadataFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
    });
  });
}
