import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.12 duplicate context clarity quality gate', () {
    test('same visible names keep explicit different contexts', () {
      final failures = CatalogQualityGateService.duplicateContextFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
    });
  });
}
