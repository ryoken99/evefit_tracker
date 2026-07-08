import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b4b_prevention_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B4B reaches prevention target with clean quality audit', () {
    final audit = CatalogQualityAudit.run();
    final preventionEntries = ExerciseCatalogContextService.entries
        .map((entry) => entry.toExercise())
        .where((exercise) => exercise.primaryType == 'prevencao')
        .toList();

    expect(v099b4bPreventionDomainEntries, hasLength(51));
    expect(preventionEntries, hasLength(95));
    expect(audit.totalExercises, greaterThanOrEqualTo(1552));
    expect(audit.criticalCount, 0);
    expect(audit.warningCount, 0);
  });

  test('v0.9.9B4B covers approved prevention focus areas', () {
    final sections = v099b4bPreventionDomainEntries
        .map((entry) => entry.section)
        .join('; ');
    final anatomy = v099b4bPreventionDomainEntries
        .expand(
          (entry) => [entry.primaryMuscle, entry.secondaryMuscles, entry.joint],
        )
        .join('; ');

    expect(sections, contains('joelho, anca e lombar'));
    expect(sections, contains('ombro, escapulas e articulacoes pequenas'));
    expect(anatomy, contains('quadriceps'));
    expect(anatomy, contains('gluteo maximo'));
    expect(anatomy, contains('rotadores externos do ombro'));
    expect(anatomy, contains('rotadores internos do ombro'));
    expect(anatomy, contains('serratil anterior'));
    expect(anatomy, contains('trapezio inferior'));
  });
}
