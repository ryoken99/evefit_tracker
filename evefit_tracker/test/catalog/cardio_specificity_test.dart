import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.12 cardio specificity quality gate', () {
    test('cardio descriptions do not mix modalities', () {
      final failures = CatalogQualityGateService.cardioSpecificityFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
    });
  });
}
