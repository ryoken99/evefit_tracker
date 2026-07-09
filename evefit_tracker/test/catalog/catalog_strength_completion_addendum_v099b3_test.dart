import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b3_strength_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

const _addendumNames = <String>{
  'Hack squat na maquina',
  'Agachamento frontal com barra',
  'Remo Meadows com barra',
  'Pullover no cabo em pe',
  'Elevacao lateral na maquina',
  'Crucifixo inverso com halteres no banco inclinado',
  'Extensao de triceps na corda acima da cabeca',
};

void main() {
  test('v0.9.9B3 addendum adds seven unique reachable strength exercises', () {
    final addendumEntries = v099b3StrengthDomainEntries
        .where((entry) => entry.source == 'GOOD_V1_ADDENDUM')
        .toList();
    final registry = CatalogRouteRegistry.build();
    final catalogEntries = {
      for (final entry in ExerciseCatalogContextService.entries)
        entry.exerciseKey: entry,
    };
    final seenCanonicalIds = <String>{};

    expect(addendumEntries, hasLength(7));
    expect(addendumEntries.map((entry) => entry.name).toSet(), _addendumNames);

    for (final addendum in addendumEntries) {
      final key = ExerciseCatalogContextService.stableKey(addendum.name);
      expect(seenCanonicalIds.add(key), isTrue, reason: addendum.name);
      final entry = catalogEntries[key];
      expect(entry, isNotNull, reason: addendum.name);
      expect(entry!.toExercise().primaryType, 'musculacao');
      expect(entry.details.description.length, greaterThanOrEqualTo(80));
      expect(entry.details.executionSteps, hasLength(greaterThanOrEqualTo(5)));

      final routes = registry.routesForExercise(entry.catalogEntryKey);
      expect(routes, isNotEmpty, reason: addendum.name);
      expect(routes.any((route) => route.typeKey == 'strength'), isTrue);
      expect(routes.any((route) => route.typeKey != 'strength'), isFalse);
      expect(
        routes.any((route) => route.groupKey == 'custom_workout'),
        isFalse,
      );
    }
  });

  test('v0.9.9B3 addendum closes strength at 400 without wrong results', () {
    final strengthCount = ExerciseCatalogContextService.entries
        .map((entry) => entry.toExercise())
        .where((exercise) => exercise.primaryType == 'musculacao')
        .length;

    expect(strengthCount, 400);
  });
}
