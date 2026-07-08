import 'package:evefit_tracker/services/catalog_quality/catalog_total_matrix_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('catalog axis inventory covers every visible app axis', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);
    final inventory = audit.axisInventory;

    expect(inventory.trainingTypes.length, greaterThanOrEqualTo(9));
    expect(inventory.locations, isNotEmpty);
    expect(inventory.equipment, isNotEmpty);
    expect(inventory.surfaces, isNotEmpty);
    expect(inventory.supports, isNotEmpty);
    expect(inventory.humanContexts, isNotEmpty);
    expect(inventory.bodyZones, isNotEmpty);
    expect(inventory.muscleGroups, isNotEmpty);
    expect(inventory.muscles, isNotEmpty);
    expect(inventory.joints, isNotEmpty);
    expect(inventory.modalities, isNotEmpty);
    expect(inventory.martialArts, contains('karate'));
    expect(inventory.technicalFocuses, contains('karate_complete'));
    expect(inventory.objectives, isNotEmpty);
    expect(inventory.levels, isNotEmpty);
    expect(inventory.contexts, isNotEmpty);
    expect(inventory.visibleFilters, isNotEmpty);
    expect(inventory.internalFilters, isNotEmpty);
    expect(inventory.exercises.length, 1178);
    expect(inventory.aliases, isNotEmpty);
  });

  test('visible axes are classified for diagnostic review', () {
    final audit = CatalogTotalMatrixAudit.run(writeReports: false);

    expect(audit.axisCoverage, isNotEmpty);
    expect(
      audit.axisCoverage.every((item) => item.notice.trim().isNotEmpty),
      isTrue,
    );
  });
}
