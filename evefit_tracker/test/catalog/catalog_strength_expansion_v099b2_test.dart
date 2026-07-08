import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'v099b2_strength_expected.dart';

void main() {
  test('v0.9.9B2 adds the approved second strength lot with valid routes', () {
    final entriesByKey = {
      for (final entry in ExerciseCatalogContextService.entries)
        entry.exerciseKey: entry,
    };
    final registry = CatalogRouteRegistry.build();

    expect(v099b2StrengthExpectedExercises, hasLength(65));

    for (final expected in v099b2StrengthExpectedExercises) {
      final entry = entriesByKey[expected.key];
      expect(entry, isNotNull, reason: '${expected.key} must exist in B2 lot');
      expect(entry!.group, expected.group, reason: entry.name);

      final exercise = entry.toExercise();
      expect(exercise.primaryType, 'musculacao', reason: entry.name);
      expect(exercise.canonicalId, expected.key, reason: entry.name);

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
