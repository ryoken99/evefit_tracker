import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v1.0.0 beginner educational content', () {
    test(
      'every catalog entry has complete beginner-readable teaching fields',
      () {
        final rows = CatalogQualityGateService.textQualityRows();
        final incomplete = rows.where((row) {
          return !row.descriptionOk ||
              !row.executionOk ||
              !row.mistakesOk ||
              !row.safetyOk ||
              row.failures.isNotEmpty;
        }).toList();

        expect(rows.length, greaterThan(353));
        expect(
          incomplete,
          isEmpty,
          reason: incomplete
              .take(40)
              .map((row) => '${row.id} ${row.name}: ${row.failures.join("; ")}')
              .join('\n'),
        );
      },
    );
  });
}
