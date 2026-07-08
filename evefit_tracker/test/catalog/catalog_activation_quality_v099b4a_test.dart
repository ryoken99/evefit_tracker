import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b4a_activation_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B4A reaches activation target with clean quality audit', () {
    final audit = CatalogQualityAudit.run();
    final activationEntries = ExerciseCatalogContextService.entries
        .map((entry) => entry.toExercise())
        .where((exercise) => exercise.primaryType == 'ativacao')
        .toList();

    expect(v099b4aActivationDomainEntries, hasLength(58));
    expect(activationEntries, hasLength(110));
    expect(audit.totalExercises, greaterThanOrEqualTo(1552));
    expect(audit.criticalCount, 0);
    expect(audit.warningCount, 0);
  });

  test('v0.9.9B4A covers approved activation focus areas', () {
    final sections = v099b4aActivationDomainEntries
        .map((entry) => entry.section)
        .join('; ');
    final muscles = v099b4aActivationDomainEntries
        .expand(
          (entry) => [entry.primaryMuscle, entry.secondaryMuscles, entry.joint],
        )
        .join('; ');

    expect(sections, contains('gluteos e anca'));
    expect(sections, contains('core, ombros e escapulas'));
    expect(sections, contains('tornozelo e pe'));
    expect(muscles, contains('gluteo medio'));
    expect(muscles, contains('transverso abdominal'));
    expect(muscles, contains('serratil anterior'));
    expect(muscles, contains('tibial anterior'));
    expect(muscles, contains('musculos intrinsecos do pe'));
    expect(muscles, contains('tibial posterior'));
  });
}
