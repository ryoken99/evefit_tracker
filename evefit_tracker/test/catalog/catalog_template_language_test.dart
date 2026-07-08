import 'package:evefit_tracker/services/catalog_quality/catalog_entry_quality_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.8 visible content avoids weak templates and internal tokens', () {
    final result = CatalogEntryQualityAudit.run();

    expect(result.entries.where((entry) => entry.hasInternalToken), isEmpty);
    expect(
      result.entries.where((entry) => entry.hasForbiddenLanguage),
      isEmpty,
    );
    expect(result.visibleEntriesWithWeakTemplate, isEmpty);
  });
}
