import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.12 exercise pedagogy quality gate', () {
    test('every catalog entry is readable enough for a beginner', () {
      final failures = CatalogQualityGateService.pedagogyFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
    });
  });
}
