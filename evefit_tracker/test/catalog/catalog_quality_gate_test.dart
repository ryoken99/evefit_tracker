import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('catalog strict quality gate has no critical issues', () {
    final result = CatalogQualityAudit.run();
    final critical = result.issues.where((issue) => issue.isCritical).toList();

    expect(
      critical,
      isEmpty,
      reason: critical.take(50).map((issue) => issue.toString()).join('\n'),
    );
    expect(
      result.scenarios.where((scenario) => !scenario.passed),
      isEmpty,
      reason: result.scenarios
          .where((scenario) => !scenario.passed)
          .map((scenario) => '${scenario.name}: ${scenario.exerciseNames}')
          .join('\n'),
    );
  });
}
