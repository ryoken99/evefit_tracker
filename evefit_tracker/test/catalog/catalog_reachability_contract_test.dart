import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.6 visible catalog reachability has release-scale coverage', () {
    final registry = CatalogRouteRegistry.build();

    expect(
      registry.visibleReachableExerciseKeys.length,
      greaterThanOrEqualTo(800),
    );
    expect(registry.unreachableExercises.length, lessThan(150));
  });
}
