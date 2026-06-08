import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.12 catalog integrity quality gate', () {
    test('all catalog entries have stable identity and complete fields', () {
      final failures = CatalogQualityGateService.catalogIntegrityFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
      expect(CatalogQualityGateService.catalogEntryCount, 305);
      expect(CatalogQualityGateService.uniqueExerciseCount, 294);
    });
  });
}
