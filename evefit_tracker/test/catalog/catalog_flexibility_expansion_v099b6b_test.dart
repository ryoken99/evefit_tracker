import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b6b_mobility_flexibility_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B6B adds 38 flexibility entries with routes', () {
    final flexibilityEntries = v099b6bMobilityFlexibilityDomainEntries
        .where((entry) => entry.primaryType == 'elasticidade')
        .toList();
    final entriesByNameAndContext = {
      for (final entry in ExerciseCatalogContextService.entries)
        '${entry.name}__${entry.contextKey}': entry,
    };
    final registry = CatalogRouteRegistry.build();

    expect(flexibilityEntries, hasLength(38));
    for (final expected in flexibilityEntries) {
      final entry =
          entriesByNameAndContext['${expected.name}__${expected.contextKey}'];
      expect(entry, isNotNull, reason: '${expected.name} must exist');
      expect(
        registry.routesForExercise(entry!.catalogEntryKey),
        isNotEmpty,
        reason: '${expected.name} must be reachable',
      );
    }

    final exercises = ExerciseCatalogContextService.entries
        .map((entry) => entry.toExercise())
        .where((exercise) => exercise.primaryType == 'elasticidade')
        .toList();
    expect(exercises, hasLength(170));
  });
}
