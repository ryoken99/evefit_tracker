import 'package:evefit_tracker/services/catalog_quality/catalog_entry_quality_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.8 visible catalog has no D or E quality entries', () {
    final result = CatalogEntryQualityAudit.run();

    expect(
      result.entries.where(
        (entry) => entry.level == EntryQualityLevel.dTemplateFraco,
      ),
      isEmpty,
    );
    expect(
      result.entries.where(
        (entry) => entry.level == EntryQualityLevel.eIncompletoOuInseguro,
      ),
      isEmpty,
    );
    expect(result.routeSummary.failWrongResultsCount, 0);
    expect(result.routeSummary.unreachableExerciseCount, 0);
    expect(
      result.routeSummary.usableCleanExerciseCount,
      greaterThanOrEqualTo(1608),
    );
  });
}
