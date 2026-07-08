import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GOOD_V1 catalog has no unreachable visible exercises', () {
    final matrix = CatalogTotalMatrixAudit.run();
    final registry = CatalogRouteRegistry.build();

    expect(matrix.unreachableExercises, isEmpty);
    expect(registry.unreachableExercises, isEmpty);
    expect(registry.usableCleanExerciseCount, 1762);
  });
}
