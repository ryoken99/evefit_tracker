import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b5a_karate_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B5A adds general karate entries without Shukokai', () {
    final entriesByNameAndContext = {
      for (final entry in ExerciseCatalogContextService.entries)
        '${entry.name}__${entry.contextKey}': entry,
    };
    final registry = CatalogRouteRegistry.build();

    expect(v099b5aKarateDomainEntries, hasLength(72));

    for (final expected in v099b5aKarateDomainEntries) {
      expect(expected.name.toLowerCase(), isNot(contains('shukokai')));
      final entry = entriesByNameAndContext['${expected.name}__karate'];
      expect(entry, isNotNull, reason: '${expected.name} must exist');
      final exercise = entry!.toExercise();
      expect(exercise.primaryType, 'artes_marciais');
      expect(entry.contextKey, 'karate');

      final routes = registry.routesForExercise(entry.catalogEntryKey);
      expect(routes, isNotEmpty, reason: '${expected.name} must be reachable');
      expect(
        routes.any((route) => route.typeKey == 'martial_arts'),
        isTrue,
        reason: '${expected.name} must have a martial arts route',
      );
      expect(
        routes.any((route) => route.martialArtKey == 'karate'),
        isTrue,
        reason: '${expected.name} must be reachable under karate',
      );
    }
  });

  test('v0.9.9B5A covers kihon kata bunkai and kumite', () {
    final sections = v099b5aKarateDomainEntries
        .map((entry) => entry.section)
        .toList();

    expect(
      sections.where((section) => section == 'Karate geral e kihon'),
      hasLength(34),
    );
    expect(
      sections.where((section) => section == 'kata e bunkai geral'),
      hasLength(18),
    );
    expect(
      sections.where((section) => section == 'kumite tecnico'),
      hasLength(20),
    );
  });
}
