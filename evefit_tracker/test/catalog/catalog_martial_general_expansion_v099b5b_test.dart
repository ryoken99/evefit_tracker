import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b5b_martial_general_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B5B adds BJJ and defense entries with martial routes', () {
    final entriesByNameAndContext = {
      for (final entry in ExerciseCatalogContextService.entries)
        '${entry.name}__${entry.contextKey}': entry,
    };
    final registry = CatalogRouteRegistry.build();

    expect(v099b5bMartialGeneralDomainEntries, hasLength(56));
    expect(
      v099b5bMartialGeneralDomainEntries.where(
        (entry) => entry.contextKey == 'jiu_jitsu',
      ),
      hasLength(32),
    );
    expect(
      v099b5bMartialGeneralDomainEntries.where(
        (entry) => entry.contextKey == 'defesa_pessoal',
      ),
      hasLength(24),
    );

    for (final expected in v099b5bMartialGeneralDomainEntries) {
      final key = '${expected.name}__${expected.contextKey}';
      final entry = entriesByNameAndContext[key];
      expect(entry, isNotNull, reason: '${expected.name} must exist');
      final exercise = entry!.toExercise();
      expect(exercise.primaryType, 'artes_marciais');

      final routes = registry.routesForExercise(entry.catalogEntryKey);
      expect(routes, isNotEmpty, reason: '${expected.name} must be reachable');
      expect(
        routes.any((route) => route.typeKey == 'martial_arts'),
        isTrue,
        reason: '${expected.name} must have a martial arts route',
      );
    }
  });

  test('v0.9.9B5B does not add Shukokai or Karate-specific entries', () {
    for (final entry in v099b5bMartialGeneralDomainEntries) {
      final text = '${entry.name} ${entry.section} ${entry.goal}'.toLowerCase();
      expect(text, isNot(contains('shukokai')));
      expect(entry.contextKey, isNot('karate'));
    }
  });
}
