import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/v099b4b_prevention_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B4B adds 51 GOOD_V1 prevention exercises with routes', () {
    final entriesByNameAndContext = {
      for (final entry in ExerciseCatalogContextService.entries)
        '${entry.name}__${entry.contextKey}': entry,
    };
    final registry = CatalogRouteRegistry.build();

    expect(v099b4bPreventionDomainEntries, hasLength(51));

    for (final expected in v099b4bPreventionDomainEntries) {
      final entry = entriesByNameAndContext['${expected.name}__prevencao'];
      expect(entry, isNotNull, reason: '${expected.name} must exist');
      final exercise = entry!.toExercise();
      expect(exercise.primaryType, 'prevencao', reason: expected.name);

      final routes = registry.routesForExercise(entry.catalogEntryKey);
      expect(routes, isNotEmpty, reason: '${expected.name} must be reachable');
      expect(
        routes.any((route) => route.typeKey == 'prevention'),
        isTrue,
        reason: '${expected.name} must have a prevention route',
      );
    }
  });

  test('v0.9.9B4B uses safe prevention language', () {
    for (final entry in v099b4bPreventionDomainEntries) {
      final text = [
        entry.name,
        entry.goal,
        entry.safety,
      ].join(' ').toLowerCase();
      expect(text, isNot(contains('garante')));
      expect(text, isNot(contains('cura')));
      expect(text, isNot(contains('evita les')));
      expect(text, isNot(contains('previne les')));
    }
  });
}
