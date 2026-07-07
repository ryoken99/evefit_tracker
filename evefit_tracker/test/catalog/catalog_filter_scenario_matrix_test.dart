import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:evefit_tracker/services/catalog_quality/scenario_matrix_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('required catalog filter scenarios stay reachable', () {
    final exercises = CatalogQualityAudit.currentExercises();
    final scenarios = const ScenarioMatrixValidator().run(exercises);

    for (final scenario in scenarios) {
      expect(
        scenario.passed,
        isTrue,
        reason:
            '${scenario.name} failed with ${scenario.count}: ${scenario.exerciseNames}',
      );
    }
  });
}
