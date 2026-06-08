import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.12 training type filter matrix quality gate', () {
    test('training types keep their domains separated', () {
      final failures = CatalogQualityGateService.trainingTypeFilterFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
    });
  });
}
