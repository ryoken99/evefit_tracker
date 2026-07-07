import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:evefit_tracker/services/exercise_capability_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v1.0.0 equipment and location compatibility', () {
    test('normalizes aliases and resolves ambiguous tokens by context', () {
      expect(EquipmentCatalogService.normalizeEquipmentToken('halteres'), 'dumbbells');
      expect(EquipmentCatalogService.normalizeEquipmentToken('dumbbell'), 'dumbbells');
      expect(EquipmentCatalogService.normalizeEquipmentToken('barra livre'), 'barbell');
      expect(EquipmentCatalogService.normalizeEquipmentToken('barra fixa'), 'pullup_bar');
      expect(
        EquipmentCatalogService.normalizeEquipmentToken('barra de cabo'),
        'adjustable_cable',
      );
      expect(
        EquipmentCatalogService.normalizeEquipmentToken('barra de maquina'),
        'machine',
      );
      expect(EquipmentCatalogService.normalizeEquipmentToken('saco de pancada'), 'heavy_bag');
      expect(EquipmentCatalogService.normalizeEquipmentToken('saco de areia'), 'sandbag');
      expect(EquipmentCatalogService.normalizeEquipmentToken('banco inclinado'), 'incline_bench');
      expect(EquipmentCatalogService.normalizeEquipmentToken('cadeira'), 'chair_support');
    });

    test('separates equipment, surfaces and supports', () {
      expect(EquipmentCatalogService.kindFor('dumbbells'), CapabilityKind.equipment);
      expect(EquipmentCatalogService.kindFor('floor'), CapabilityKind.surface);
      expect(EquipmentCatalogService.kindFor('tatami'), CapabilityKind.surface);
      expect(EquipmentCatalogService.kindFor('wall'), CapabilityKind.support);
      expect(EquipmentCatalogService.kindFor('chair_support'), CapabilityKind.support);
      expect(EquipmentCatalogService.kindFor('bench'), CapabilityKind.support);
    });

    test('home without equipment exposes only basic compatible capabilities', () {
      final available = EquipmentCatalogService.availableKeys(
        trainingLocations: {'Casa sem equipamento'},
        selectedEquipmentKeys: const {},
      );

      expect(available, containsAll({'bodyweight', 'floor', 'wall'}));
      expect(available, isNot(contains('chair_support')));
      expect(available, isNot(contains('towel')));
      expect(available, isNot(contains('machine')));
      expect(available, isNot(contains('high_cable')));
      expect(available, isNot(contains('low_cable')));
      expect(available, isNot(contains('heavy_bag')));
      expect(available, isNot(contains('treadmill')));
      expect(available, isNot(contains('pullup_bar')));
      expect(available, isNot(contains('tatami')));
      expect(available, isNot(contains('partner')));
    });

    test('gym and dojo expose only their default compatible capabilities', () {
      final gym = EquipmentCatalogService.availableKeys(
        trainingLocations: {'Ginásio'},
        selectedEquipmentKeys: const {},
      );
      expect(gym, containsAll({'machine', 'high_cable', 'dumbbells', 'barbell', 'treadmill', 'rower'}));

      final dojo = EquipmentCatalogService.availableKeys(
        trainingLocations: {'Dojo / Artes marciais'},
        selectedEquipmentKeys: const {},
      );
      expect(dojo, containsAll({'bodyweight', 'floor', 'wall', 'tatami'}));
      expect(dojo, isNot(contains('machine')));
      expect(dojo, isNot(contains('heavy_bag')));
      expect(dojo, isNot(contains('partner')));

      final dojoWithBag = EquipmentCatalogService.availableKeys(
        trainingLocations: {'Dojo / Artes marciais'},
        selectedEquipmentKeys: {'heavy_bag'},
      );
      expect(dojoWithBag, contains('heavy_bag'));
    });

    test('exercise availability respects required equipment and surfaces', () {
      final noEquipment = Exercise(
        name: 'Flexão simples',
        muscleGroup: 'Peito',
        isDefault: true,
        equipment: 'Peso corporal',
      );
      final machine = Exercise(
        name: 'Leg press',
        muscleGroup: 'Pernas',
        isDefault: true,
        equipment: 'Máquina multifunções',
      );
      final cable = Exercise(
        name: 'Tríceps no cabo',
        muscleGroup: 'Tríceps',
        isDefault: true,
        equipment: 'Cabo alto',
      );
      final bag = Exercise(
        name: 'Trabalho leve ao saco',
        muscleGroup: 'Karate',
        isDefault: true,
        equipment: 'Saco de pancada',
      );
      final ukemi = Exercise(
        name: 'Breakfalls (ukemi)',
        muscleGroup: 'Jiu-Jitsu',
        isDefault: true,
        equipment: 'Tatami',
      );

      expect(
        ExerciseCapabilityService.isAvailable(
          exercise: noEquipment,
          trainingLocation: 'Casa sem equipamento',
          availableEquipmentKeys: const {},
        ),
        isTrue,
      );
      expect(
        ExerciseCapabilityService.isAvailable(
          exercise: machine,
          trainingLocation: 'Casa sem equipamento',
          availableEquipmentKeys: const {},
        ),
        isFalse,
      );
      expect(
        ExerciseCapabilityService.isAvailable(
          exercise: cable,
          trainingLocation: 'Casa sem equipamento',
          availableEquipmentKeys: const {},
        ),
        isFalse,
      );
      expect(
        ExerciseCapabilityService.isAvailable(
          exercise: bag,
          trainingLocation: 'Dojo / Artes marciais',
          availableEquipmentKeys: const {},
        ),
        isFalse,
      );
      expect(
        ExerciseCapabilityService.isAvailable(
          exercise: bag,
          trainingLocation: 'Dojo / Artes marciais',
          availableEquipmentKeys: {'heavy_bag'},
        ),
        isTrue,
      );
      expect(
        ExerciseCapabilityService.isAvailable(
          exercise: ukemi,
          trainingLocation: 'Casa sem equipamento',
          availableEquipmentKeys: const {},
        ),
        isFalse,
      );
      expect(
        ExerciseCapabilityService.isAvailable(
          exercise: ukemi,
          trainingLocation: 'Dojo / Artes marciais',
          availableEquipmentKeys: const {},
        ),
        isTrue,
      );
    });
  });
}
