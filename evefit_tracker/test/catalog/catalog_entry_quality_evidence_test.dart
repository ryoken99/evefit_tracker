import 'package:evefit_tracker/services/catalog_quality/catalog_entry_quality_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.8 evidence covers every visible catalog entry', () {
    final result = CatalogEntryQualityAudit.run();

    expect(result.entries.length, greaterThanOrEqualTo(1307));
    expect(
      result.entries.map((entry) => entry.catalogEntryKey).toSet().length,
      result.entries.length,
    );
    expect(
      result.levelCounts.values.reduce((a, b) => a + b),
      result.entries.length,
    );
  });
}
