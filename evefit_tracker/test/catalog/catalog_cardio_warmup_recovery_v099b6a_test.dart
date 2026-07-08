import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b6a_cardio_warmup_recovery_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B6A adds cardio warmup and recovery entries with routes', () {
    final entriesByNameAndContext = {
      for (final entry in ExerciseCatalogContextService.entries)
        '${entry.name}__${entry.contextKey}': entry,
    };
    final registry = CatalogRouteRegistry.build();

    expect(v099b6aCardioWarmupRecoveryDomainEntries, hasLength(82));
    expect(
      v099b6aCardioWarmupRecoveryDomainEntries.where(
        (entry) => entry.primaryType == 'cardio',
      ),
      hasLength(35),
    );
    expect(
      v099b6aCardioWarmupRecoveryDomainEntries.where(
        (entry) => entry.primaryType == 'aquecimento',
      ),
      hasLength(19),
    );
    expect(
      v099b6aCardioWarmupRecoveryDomainEntries.where(
        (entry) => entry.primaryType == 'recuperacao',
      ),
      hasLength(28),
    );

    for (final expected in v099b6aCardioWarmupRecoveryDomainEntries) {
      final entry =
          entriesByNameAndContext['${expected.name}__${expected.contextKey}'];
      expect(entry, isNotNull, reason: '${expected.name} must exist');
      final routes = registry.routesForExercise(entry!.catalogEntryKey);
      expect(routes, isNotEmpty, reason: '${expected.name} must be reachable');
    }
  });

  test('v0.9.9B6A reaches cardio warmup recovery targets cleanly', () {
    final audit = CatalogQualityAudit.run();
    final exercises = ExerciseCatalogContextService.entries.map(
      (entry) => entry.toExercise(),
    );

    expect(
      exercises.where((exercise) => exercise.primaryType == 'cardio'),
      hasLength(100),
    );
    expect(
      exercises.where((exercise) => exercise.primaryType == 'aquecimento'),
      hasLength(150),
    );
    expect(
      exercises.where((exercise) => exercise.primaryType == 'recuperacao'),
      hasLength(147),
    );
    expect(audit.totalExercises, greaterThanOrEqualTo(1687));
    expect(audit.criticalCount, 0);
    expect(audit.warningCount, 0);
  });
}
