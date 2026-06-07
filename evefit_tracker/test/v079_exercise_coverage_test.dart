import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_catalog_detail_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.9 exercise coverage and complete filters', () {
    test(
      'arms complete with dumbbells covers biceps triceps forearm wrist and grip with a substantial list',
      () {
        final names = _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'dumbbells',
            regionKey: 'upper',
            groupKey: 'arms',
            subzoneKey: 'arms_complete',
          ),
          equipment: {'dumbbells', 'bench', 'incline_bench', 'free_space'},
        );

        expect(names.length, greaterThanOrEqualTo(30));
        expect(
          names,
          containsAll([
            'Curl com halteres',
            'Curl alternado',
            'Curl martelo',
            'Curl concentrado',
            'Curl inclinado com halteres',
            'Curl Zottman',
            'Curl inverso com halteres',
            'Curl cruzado no corpo',
            'Curl 21 com halteres',
            'Curl arrastado com halteres',
            'Extensão francesa com halter',
            'Extensão acima da cabeça com halter',
            'Extensão unilateral de tríceps',
            'Extensão de tríceps deitado com halteres',
            'Tríceps testa com halteres',
            'Press fechado com halteres',
            'Tate press',
            'Kickback de tríceps',
            'Wrist curl',
            'Reverse wrist curl',
            'Pronação com halter',
            'Supinação com halter',
            'Desvio radial com halter',
            'Desvio ulnar com halter',
            'Aperto isométrico',
            'Farmer hold',
            'Farmer walk',
            'Suitcase carry',
            'Hold estático com halteres',
            'Rotação controlada com halter leve',
          ]),
        );
        expect(names, isNot(contains('Supino com halteres')));
        expect(names, isNot(contains('Remo unilateral com halter')));
        expect(names, isNot(contains('Agachamento goblet')));
        expect(names, isNot(contains('Passadeira caminhada')));
      },
    );

    test('complete filters aggregate their direct and indirect children', () {
      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'upper',
            groupKey: 'chest',
            subzoneKey: 'chest_complete',
          ),
          equipment: {'bodyweight', 'chair_support'},
        ),
        containsAll([
          'Flexão clássica',
          'Flexão com joelhos apoiados',
          'Flexão inclinada',
          'Flexão declinada',
          'Flexão aberta',
          'Flexão arqueiro',
        ]),
      );

      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bands',
            regionKey: 'upper',
            groupKey: 'back',
            subzoneKey: 'back_complete',
          ),
          equipment: {'bands'},
        ),
        containsAll(['Remo com elástico', 'Face pull com elástico']),
      );

      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'lower',
            groupKey: 'legs',
            subzoneKey: 'legs_complete',
          ),
          equipment: {'bodyweight', 'chair_support'},
        ),
        containsAll([
          'Agachamento com peso corporal',
          'Agachamento para cadeira',
          'Wall sit',
          'Ponte de glúteo',
          'Gémeos em pé',
          'Elevação tibial',
        ]),
      );

      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'core',
            groupKey: 'core',
            subzoneKey: 'core_complete',
          ),
          equipment: {'bodyweight', 'mat'},
        ),
        containsAll([
          'Prancha',
          'Prancha lateral',
          'Dead bug',
          'Hollow hold',
          'Bird dog',
        ]),
      );
    });

    test('safe home alternatives appear only with matching equipment', () {
      final backpackLegs = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'weighted_backpack',
          regionKey: 'lower',
          groupKey: 'legs',
          subzoneKey: 'legs_complete',
        ),
        equipment: {'bodyweight', 'weighted_backpack'},
      );
      expect(backpackLegs, contains('Agachamento com mochila'));
      expect(backpackLegs, contains('Lunges com mochila'));

      final bodyweightOnly = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'bodyweight',
          regionKey: 'lower',
          groupKey: 'legs',
          subzoneKey: 'legs_complete',
        ),
        equipment: {'bodyweight'},
      );
      expect(bodyweightOnly, isNot(contains('Agachamento com mochila')));
      expect(bodyweightOnly, isNot(contains('Agachamento com garrafão')));

      final waterJug = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'water_jug',
          regionKey: 'lower',
          groupKey: 'legs',
          subzoneKey: 'legs_complete',
        ),
        equipment: {'bodyweight', 'water_jug'},
      );
      expect(waterJug, contains('Agachamento com garrafão'));
    });

    test('new seed catalog avoids ambiguous primary exercise names', () {
      final names = _seedExercises().map((exercise) => exercise.name).toSet();

      expect(names, isNot(contains('Flexões')));
      expect(names, isNot(contains('Flexões inclinadas')));
      expect(names, isNot(contains('Flexões declinadas')));
      expect(names, isNot(contains('Agachamento')));
      expect(names, isNot(contains('Agachamento peso corporal')));
      expect(names, isNot(contains('Curl 21')));
      expect(names, isNot(contains('Tríceps testa')));

      expect(names, contains('Flexão clássica'));
      expect(names, contains('Agachamento com peso corporal'));
      expect(names, contains('Curl 21 com halteres'));
      expect(names, contains('Tríceps testa com barra EZ'));
    });

    test('mobility has broad no-equipment coverage', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'mobility',
          mobilityZoneKey: 'general_mobility',
        ),
        equipment: {'bodyweight', 'mat'},
      );

      expect(names.length, greaterThanOrEqualTo(25));
      expect(
        names,
        containsAll([
          'Alongamento cervical leve',
          'Círculos de ombro',
          'Alongamento peitoral na parede',
          'Rotação torácica no chão',
          'Mobilidade 90/90',
          'Alongamento posterior sentado',
          'Alongamento glúteos',
          'Mobilidade de tornozelo na parede',
          'Mobilidade de punhos',
        ]),
      );
    });
  });
}

List<String> _names(
  TrainingFlowSelection flow, {
  String location = 'Casa',
  Set<String> equipment = const {'bodyweight'},
}) {
  return ExerciseFilterService.getAvailableExercises(
    exercises: _seedExercises(),
    trainingLocation: location,
    availableEquipmentKeys: equipment,
    selection: TrainingFlow.toTrainingSelection(flow),
    showAllExercises: false,
  ).map((item) => item.exercise.name).toList();
}

List<Exercise> _seedExercises() {
  final exercises = <Exercise>[];
  final seen = <String>{};
  for (final entry in SeedData.exercisesByGroup.entries) {
    for (final name in entry.value) {
      if (!seen.add(name)) continue;
      final detail = ExerciseCatalogDetailService.forExercise(
        name: name,
        group: entry.key,
      );
      exercises.add(
        Exercise(
          name: name,
          muscleGroup: entry.key,
          secondaryMuscleGroups: detail.secondaryGroups,
          equipment: detail.equipment,
          description: detail.description,
          executionSteps: detail.executionSteps,
          commonMistakes: detail.commonMistakes,
          safetyNotes: detail.safetyNotes,
          isDefault: true,
        ),
      );
    }
  }
  return exercises;
}
