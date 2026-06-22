import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.8.0 canonical equipment registry', () {
    test('every equipment key has one canonical identity', () {
      final keys = EquipmentCatalogService.definitions.keys.toList();

      expect(keys.toSet(), hasLength(keys.length));
      expect(keys.where((key) => key == 'jump_rope'), hasLength(1));
      expect(
        EquipmentCatalogService.definitions['jump_rope']!.name,
        'Corda de saltar',
      );
    });
  });

  group('v0.8.0 location and equipment capabilities', () {
    test('home without equipment exposes only base movement capabilities', () {
      expect(_available({'Casa'}, {}), {'bodyweight', 'floor', 'wall'});
    });

    test('home exposes only each selected portable equipment family', () {
      expect(_available({'Casa'}, {'dumbbells'}), {
        'bodyweight',
        'floor',
        'wall',
        'dumbbells',
      });
      expect(_available({'Casa'}, {'barbell', 'plates'}), {
        'bodyweight',
        'floor',
        'wall',
        'barbell',
        'plates',
      });
      expect(_available({'Casa'}, {'bands'}), {
        'bodyweight',
        'floor',
        'wall',
        'bands',
      });
    });

    test('gym exposes machines cables free weights racks and benches', () {
      expect(
        _available({'Ginásio'}, {}),
        containsAll({
          'bodyweight',
          'machine',
          'high_cable',
          'low_cable',
          'adjustable_cable',
          'dumbbells',
          'barbell',
          'plates',
          'squat_rack',
          'adjustable_bench',
          'flat_bench',
          'incline_bench',
          'decline_bench',
        }),
      );
    });

    test('outdoor and dojo add only their location capabilities', () {
      expect(_available({'Exterior'}, {}), {
        'bodyweight',
        'floor',
        'outdoor_space',
      });
      expect(_available({'Dojo / Artes marciais'}, {}), {
        'bodyweight',
        'floor',
        'wall',
        'tatami',
      });
    });
  });
}

Set<String> _available(Set<String> locations, Set<String> selected) {
  return EquipmentCatalogService.availableKeys(
    trainingLocations: locations,
    selectedEquipmentKeys: selected,
  );
}
