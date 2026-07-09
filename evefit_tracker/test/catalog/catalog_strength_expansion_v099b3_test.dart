import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/v099b3_strength_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B3 completes the approved strength lot with valid routes', () {
    final entriesByKey = {
      for (final entry in ExerciseCatalogContextService.entries)
        entry.exerciseKey: entry,
    };
    final registry = CatalogRouteRegistry.build();

    expect(v099b3StrengthDomainEntries, hasLength(71));

    for (final expected in v099b3StrengthDomainEntries) {
      final expectedKey = ExerciseCatalogContextService.stableKey(
        expected.name,
      );
      final entry = entriesByKey[expectedKey];
      expect(entry, isNotNull, reason: '$expectedKey must exist in B3 lot');
      expect(
        TrainingArchitecture.equipmentKeysFor(entry!.details.equipment),
        isNotEmpty,
        reason: entry.name,
      );

      final exercise = entry.toExercise();
      expect(exercise.primaryType, 'musculacao', reason: entry.name);
      expect(exercise.canonicalId, expectedKey, reason: entry.name);

      final routes = registry.routesForExercise(entry.catalogEntryKey);
      expect(routes, isNotEmpty, reason: '${entry.name} must be reachable');
      expect(
        routes.any((route) => route.typeKey == 'strength'),
        isTrue,
        reason: '${entry.name} must have a strength route',
      );
      expect(
        routes.any((route) => route.groupKey == 'custom_workout'),
        isFalse,
        reason: '${entry.name} must not fall back to custom workout routes',
      );
    }
  });
}
