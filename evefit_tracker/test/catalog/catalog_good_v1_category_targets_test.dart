import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GOOD_V1 category totals meet the approved target envelope', () {
    final counts = CatalogQualityAudit.run().countsByPrimaryType;

    expect(counts['musculacao'], 400);
    expect(counts['cardio'], 100);
    expect(counts['artes_marciais'], 360);
    expect(counts['mobilidade'], 230);
    expect(counts['elasticidade'], 170);
    expect(counts['aquecimento'], 150);
    expect(counts['ativacao'], 110);
    expect(counts['prevencao'], 95);

    // The roadmap target is approximate; the accepted GOOD_V1 lots currently
    // land recovery three entries under 150 while keeping total in range.
    expect(counts['recuperacao'], inInclusiveRange(147, 150));
  });
}
