import 'package:evefit_tracker/services/catalog_quality/catalog_entry_quality_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.8 visible entries have complete execution instructions', () {
    final result = CatalogEntryQualityAudit.run();

    expect(
      result.entries.where((entry) => entry.executionStepCount < 4),
      isEmpty,
    );
    expect(result.entries.where((entry) => !entry.hasCadenceOrRhythm), isEmpty);
    expect(
      result.entries.where((entry) => !entry.hasExpectedSensation),
      isEmpty,
    );
  });
}
