import 'package:evefit_tracker/services/catalog_quality/catalog_entry_quality_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'v0.9.8 visible entries include breathing safety and scaling fields',
    () {
      final result = CatalogEntryQualityAudit.run();

      expect(result.entries.where((entry) => !entry.hasBreathing), isEmpty);
      expect(
        result.entries.where((entry) => !entry.hasCommonMistakes),
        isEmpty,
      );
      expect(result.entries.where((entry) => !entry.hasSafety), isEmpty);
      expect(result.entries.where((entry) => !entry.hasRegression), isEmpty);
      expect(result.entries.where((entry) => !entry.hasProgression), isEmpty);
      expect(
        result.entries.where((entry) => entry.hasMedicalOverclaim),
        isEmpty,
      );
    },
  );
}
