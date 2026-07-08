import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.6 route generation covers every major training domain', () {
    final registry = CatalogRouteRegistry.build();

    for (final type in const {
      'strength',
      'cardio',
      'martial_arts',
      'mobility',
      'elasticity',
      'recovery',
      'warmup',
      'activation',
      'prevention',
    }) {
      expect(
        registry.routeExercises.keys.where((route) => route.startsWith(type)),
        isNotEmpty,
        reason: '$type should have generated menu routes',
      );
    }
  });
}
