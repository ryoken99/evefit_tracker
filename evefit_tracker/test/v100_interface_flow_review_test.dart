import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/exercise_taxonomy_service.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v1.0.0 final interface flow review', () {
    test('main type menu exposes every phase-10 creation flow', () {
      expect(
        TrainingFlow.types.keys,
        containsAll({
          'strength',
          'cardio',
          'martial_arts',
          'mobility',
          'elasticity',
          'recovery',
          'warmup',
          'activation',
          'prevention',
        }),
      );
      expect(TrainingFlow.types['mobility'], 'Mobilidade');
      expect(TrainingFlow.types['elasticity'], 'Elasticidade');
    });

    test('creation flows produce visible, readable exercises', () {
      final cases = <_FlowCase>[
        _FlowCase(
          label: 'home bodyweight',
          flow: const TrainingFlowSelection(
            typeKey: 'strength',
            locationKey: EquipmentCatalogService.placeHomeNoEquipment,
            equipmentKey: 'bodyweight',
            regionKey: 'upper',
            groupKey: 'chest',
            subzoneKey: 'chest_complete',
          ),
          expectedCanonical: 'push_up',
        ),
        _FlowCase(
          label: 'home dumbbells',
          flow: const TrainingFlowSelection(
            typeKey: 'strength',
            locationKey: EquipmentCatalogService.placeHomeEquipped,
            equipmentKey: 'dumbbells',
            regionKey: 'upper',
            groupKey: 'chest',
            subzoneKey: 'chest_complete',
          ),
          selectedEquipment: {'dumbbells'},
          expectedEquipment: 'dumbbells',
        ),
        _FlowCase(
          label: 'gym',
          flow: const TrainingFlowSelection(
            typeKey: 'strength',
            locationKey: EquipmentCatalogService.placeGym,
            equipmentKey: 'machine',
            regionKey: 'upper',
            groupKey: 'chest',
            subzoneKey: 'chest_complete',
          ),
          expectedEquipment: 'machine',
        ),
        _FlowCase(
          label: 'mobility',
          flow: const TrainingFlowSelection(
            typeKey: 'mobility',
            locationKey: EquipmentCatalogService.placeHomeNoEquipment,
            equipmentKey: 'bodyweight',
            mobilityZoneKey: 'general_mobility',
          ),
          expectedType: 'mobilidade',
        ),
        _FlowCase(
          label: 'elasticity',
          flow: const TrainingFlowSelection(
            typeKey: 'elasticity',
            locationKey: EquipmentCatalogService.placeHomeNoEquipment,
            equipmentKey: 'bodyweight',
          ),
          expectedType: 'elasticidade',
        ),
        _FlowCase(
          label: 'recovery',
          flow: const TrainingFlowSelection(
            typeKey: 'recovery',
            locationKey: EquipmentCatalogService.placeHomeNoEquipment,
            equipmentKey: 'bodyweight',
            recoveryKey: 'easy_walk',
          ),
        ),
        _FlowCase(
          label: 'warmup',
          flow: const TrainingFlowSelection(
            typeKey: 'warmup',
            locationKey: EquipmentCatalogService.placeHomeNoEquipment,
            equipmentKey: 'bodyweight',
          ),
          expectedType: 'aquecimento',
        ),
        _FlowCase(
          label: 'activation',
          flow: const TrainingFlowSelection(
            typeKey: 'activation',
            locationKey: EquipmentCatalogService.placeHomeNoEquipment,
            equipmentKey: 'bodyweight',
          ),
          expectedType: 'ativacao',
        ),
        _FlowCase(
          label: 'prevention',
          flow: const TrainingFlowSelection(
            typeKey: 'prevention',
            locationKey: EquipmentCatalogService.placeHomeNoEquipment,
            equipmentKey: 'bodyweight',
          ),
          expectedType: 'prevencao',
        ),
        _FlowCase(
          label: 'karate',
          flow: const TrainingFlowSelection(
            typeKey: 'martial_arts',
            locationKey: EquipmentCatalogService.placeDojo,
            martialArtKey: 'karate',
            focusKey: 'karate_complete',
          ),
          expectedContext: 'karate',
        ),
        _FlowCase(
          label: 'bjj',
          flow: const TrainingFlowSelection(
            typeKey: 'martial_arts',
            locationKey: EquipmentCatalogService.placeDojo,
            martialArtKey: 'jiu_jitsu',
            focusKey: 'jiu_jitsu_complete',
          ),
          expectedContext: 'jiu_jitsu',
        ),
      ];

      for (final flowCase in cases) {
        final visible = _visibleExercises(flowCase);
        expect(visible, isNotEmpty, reason: flowCase.label);
        expect(
          visible.any(flowCase.matchesExpectedDomain),
          isTrue,
          reason: flowCase.label,
        );
        expect(
          visible
              .take(5)
              .every(
                (item) =>
                    item.description.trim().length >= 130 &&
                    item.executionSteps.contains('1.'),
              ),
          isTrue,
          reason: flowCase.label,
        );
        expect(
          TrainingFlow.suggestedWorkoutName(flowCase.flow).trim(),
          isNotEmpty,
          reason: flowCase.label,
        );
      }
    });

    test('alias search and exercise opening data stay connected', () {
      final visible = _visibleExercises(
        _FlowCase(
          label: 'push alias',
          flow: const TrainingFlowSelection(
            typeKey: 'strength',
            locationKey: EquipmentCatalogService.placeHomeNoEquipment,
            equipmentKey: 'bodyweight',
            regionKey: 'upper',
            groupKey: 'chest',
            subzoneKey: 'chest_complete',
          ),
          expectedCanonical: 'push_up',
        ),
      );

      final result = visible.singleWhere(
        (item) =>
            ExerciseFilterService.matchesSearchQuery(item, 'flexao_bracos'),
      );

      expect(result.canonicalId, 'push_up');
      expect(result.catalogEntryKey, isNotEmpty);
      expect(result.description.length, greaterThanOrEqualTo(130));
      expect(result.executionSteps, contains('1.'));
      expect(result.safetyNotes, isNotEmpty);
    });
  });
}

List<Exercise> _visibleExercises(_FlowCase flowCase) {
  final flow = flowCase.flow;
  final selectedEquipment = {
    if (flow.equipmentKey.isNotEmpty) flow.equipmentKey,
    ...flowCase.selectedEquipment,
  };
  final available = EquipmentCatalogService.availableKeys(
    trainingLocations: {flow.locationKey},
    selectedEquipmentKeys: selectedEquipment,
  );
  return ExerciseFilterService.getAvailableExercises(
    exercises: _catalogExercises(),
    trainingLocation: flow.locationKey,
    availableEquipmentKeys: available,
    selection: TrainingFlow.toTrainingSelection(flow),
    showAllExercises: false,
  ).map((item) => item.exercise).toList();
}

List<Exercise> _catalogExercises() => ExerciseCatalogContextService.entries
    .map(ExerciseTaxonomyService.enrichCatalogExercise)
    .toList();

class _FlowCase {
  const _FlowCase({
    required this.label,
    required this.flow,
    this.selectedEquipment = const {},
    this.expectedCanonical = '',
    this.expectedType = '',
    this.expectedContext = '',
    this.expectedEquipment = '',
  });

  final String label;
  final TrainingFlowSelection flow;
  final Set<String> selectedEquipment;
  final String expectedCanonical;
  final String expectedType;
  final String expectedContext;
  final String expectedEquipment;

  bool matchesExpectedDomain(Exercise item) {
    if (expectedCanonical.isNotEmpty) {
      return item.canonicalId == expectedCanonical;
    }
    if (expectedType.isNotEmpty) return item.primaryType == expectedType;
    if (expectedContext.isNotEmpty) return item.contextKey == expectedContext;
    if (expectedEquipment.isNotEmpty) {
      return item.equipmentKeys.contains(expectedEquipment);
    }
    return true;
  }
}
