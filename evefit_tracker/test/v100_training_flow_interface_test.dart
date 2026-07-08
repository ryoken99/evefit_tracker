import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/screens/workouts_screen.dart';
import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v1.0.0 progressive training flow interface', () {
    test('objective menu exposes the required progressive entry points', () {
      expect(
        TrainingFlow.objectiveLabels.keys,
        containsAll({
          'muscle_gain',
          'strength',
          'endurance',
          'cardio',
          'mobility',
          'elasticity',
          'recovery',
          'martial_arts',
          'warmup',
          'activation',
          'prevention',
        }),
      );
    });

    test('location menu exposes canonical Fase 2 places', () {
      expect(
        TrainingFlow.locationLabels.keys,
        containsAll({
          EquipmentCatalogService.placeHomeNoEquipment,
          EquipmentCatalogService.placeHomeEquipped,
          EquipmentCatalogService.placeGym,
          EquipmentCatalogService.placeDojo,
          EquipmentCatalogService.placeTatami,
          EquipmentCatalogService.placeOutdoor,
          EquipmentCatalogService.placeWorkTravel,
        }),
      );
    });

    test('location controls compatible equipment options progressively', () {
      final home = TrainingFlow.availableEquipmentForLocation(
        EquipmentCatalogService.placeHomeNoEquipment,
        selectedEquipmentKeys: const {},
      ).map((item) => item.key).toSet();

      expect(home, containsAll({'bodyweight', 'floor', 'wall'}));
      expect(home, isNot(contains('machine')));
      expect(home, isNot(contains('high_cable')));
      expect(home, isNot(contains('treadmill')));

      final gym = TrainingFlow.availableEquipmentForLocation(
        EquipmentCatalogService.placeGym,
        selectedEquipmentKeys: const {},
      ).map((item) => item.key).toSet();

      expect(
        gym,
        containsAll({
          'dumbbells',
          'barbell',
          'machine',
          'high_cable',
          'bench',
          'treadmill',
        }),
      );
    });

    test(
      'clearFilters returns a stable default without losing the objective',
      () {
        const flow = TrainingFlowSelection(
          typeKey: 'cardio',
          locationKey: EquipmentCatalogService.placeOutdoor,
          equipmentKey: 'jump_rope',
          cardioFocusKey: 'hiit',
        );

        final cleared = TrainingFlow.clearFilters(flow);

        expect(cleared.typeKey, 'cardio');
        expect(
          cleared.locationKey,
          EquipmentCatalogService.placeHomeNoEquipment,
        );
        expect(cleared.equipmentKey, 'bodyweight');
        expect(cleared.cardioFocusKey, 'no_equipment');
      },
    );

    test('exercise search matches name, alias and canonical identity', () {
      final exercise = Exercise(
        name: 'Flexão clássica',
        muscleGroup: 'Peito',
        isDefault: true,
        canonicalId: 'push_up',
        aliases: const {'pushup', 'flexao_bracos'},
        catalogEntryKey: 'flexao_classica__peito',
      );

      expect(
        ExerciseFilterService.matchesSearchQuery(exercise, 'flexao'),
        isTrue,
      );
      expect(
        ExerciseFilterService.matchesSearchQuery(exercise, 'pushup'),
        isTrue,
      );
      expect(
        ExerciseFilterService.matchesSearchQuery(exercise, 'push_up'),
        isTrue,
      );
      expect(
        ExerciseFilterService.matchesSearchQuery(exercise, 'agachamento'),
        isFalse,
      );
    });

    test('WorkoutsScreen can be constructed for smoke coverage', () {
      expect(
        WorkoutsScreen(database: AppDatabase.instance),
        isA<WorkoutsScreen>(),
      );
    });
  });
}
