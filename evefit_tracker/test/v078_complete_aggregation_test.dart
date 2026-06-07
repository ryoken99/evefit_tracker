import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_catalog_detail_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.8 complete filter aggregation', () {
    test(
      'arms complete with dumbbells aggregates biceps triceps forearm wrist and grip',
      () {
        final names = _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'dumbbells',
            regionKey: 'upper',
            groupKey: 'arms',
            subzoneKey: 'arms_complete',
          ),
          equipment: {'dumbbells', 'bench'},
        );

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
            'Curl isométrico',
            'Extensão francesa com halter',
            'Extensão unilateral de tríceps',
            'Kickback de tríceps',
            'Tríceps testa com halteres',
            'Extensão de tríceps deitado com halteres',
            'Wrist curl',
            'Reverse wrist curl',
            'Pronação com halter',
            'Supinação com halter',
            'Desvio radial com halter',
            'Desvio ulnar com halter',
            'Aperto isométrico',
            'Farmer hold',
            'Farmer walk',
          ]),
        );
        expect(names, isNot(contains('Supino com halteres')));
        expect(names, isNot(contains('Remo unilateral com halter')));
        expect(names, isNot(contains('Agachamento goblet')));
        expect(names, isNot(contains('Passadeira caminhada')));
      },
    );

    test('complete strength branches aggregate representative children', () {
      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'upper',
            groupKey: 'chest',
            subzoneKey: 'chest_complete',
          ),
          equipment: {'bodyweight'},
        ),
        containsAll([
          'Flexão clássica',
          'Flexão inclinada',
          'Flexão declinada',
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
          equipment: {'bodyweight'},
        ),
        containsAll([
          'Prancha',
          'Crunch',
          'Reverse crunch',
          'Prancha lateral',
          'Dead bug',
          'Superman',
        ]),
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
          equipment: {'bodyweight', 'bench'},
        ),
        containsAll([
          'Agachamento com peso corporal',
          'Lunges',
          'Ponte de glúteo',
          'Gémeos em pé',
          'Elevação tibial',
        ]),
      );
    });

    test('back complete and treadmill complete aggregate their children', () {
      final back = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'dumbbells',
          regionKey: 'upper',
          groupKey: 'back',
          subzoneKey: 'back_complete',
        ),
        equipment: {'dumbbells'},
      );
      expect(back, contains('Remo unilateral com halter'));
      expect(back, contains('Pullover com halter'));
      expect(back, isNot(contains('Curl com halteres')));

      final treadmill = _names(
        const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
        ),
        location: 'Ginásio',
      );
      expect(
        treadmill,
        containsAll([
          'Passadeira aquecimento',
          'Passadeira caminhada',
          'Passadeira corrida leve',
          'Passadeira inclinação moderada',
          'Passadeira corrida intervalada',
          'Passadeira cooldown',
        ]),
      );
      expect(treadmill, isNot(contains('Bicicleta ritmo leve')));
    });

    test('upper body complete branches aggregate only their own families', () {
      final shoulders = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'dumbbells',
          regionKey: 'upper',
          groupKey: 'shoulders',
          subzoneKey: 'shoulders_complete',
        ),
        equipment: {'dumbbells'},
      );
      expect(
        shoulders,
        containsAll([
          'Press militar com halteres',
          'Arnold press',
          'Elevação lateral',
          'Elevação posterior',
        ]),
      );
      expect(shoulders, isNot(contains('Curl com halteres')));

      final forearm = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'dumbbells',
          regionKey: 'upper',
          groupKey: 'forearm_hand',
          subzoneKey: 'forearm_complete',
        ),
        equipment: {'dumbbells'},
      );
      expect(
        forearm,
        containsAll([
          'Wrist curl',
          'Reverse wrist curl',
          'Pronação com halter',
          'Supinação com halter',
          'Farmer hold',
        ]),
      );
      expect(forearm, isNot(contains('Supino com halteres')));

      final traps = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'dumbbells',
          regionKey: 'upper',
          groupKey: 'traps_scapula',
          subzoneKey: 'traps_complete',
        ),
        equipment: {'dumbbells'},
      );
      expect(traps, contains('Encolhimento de ombros com halteres'));
      expect(traps, isNot(contains('Curl com halteres')));

      final neck = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'bodyweight',
          regionKey: 'upper',
          groupKey: 'neck',
          subzoneKey: 'neck_complete',
        ),
        equipment: {'bodyweight'},
      );
      expect(neck, containsAll(['Chin tuck', 'Rotação cervical controlada']));
      expect(neck, isNot(contains('Prancha')));
    });

    test('core and lower body nested complete branches aggregate children', () {
      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'core',
            groupKey: 'core',
            subzoneKey: 'abdominal_zone',
            focusKey: 'abs_complete',
          ),
          equipment: {'bodyweight'},
        ),
        containsAll(['Crunch', 'Reverse crunch', 'Bicycle crunch']),
      );

      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'lower',
            groupKey: 'legs',
            subzoneKey: 'upper_leg_hip',
            focusKey: 'quadriceps_complete',
          ),
          equipment: {'bodyweight', 'bench'},
        ),
        containsAll(['Agachamento com peso corporal', 'Wall sit', 'Lunges']),
      );

      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bench',
            regionKey: 'lower',
            groupKey: 'legs',
            subzoneKey: 'upper_leg_hip',
            focusKey: 'quadriceps_complete',
          ),
          equipment: {'bodyweight', 'bench'},
        ),
        contains('Step-up'),
      );

      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'lower',
            groupKey: 'legs',
            subzoneKey: 'upper_leg_hip',
            focusKey: 'hamstrings_complete',
          ),
          equipment: {'bodyweight'},
        ),
        containsAll(['Good morning sem carga']),
      );

      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'lower',
            groupKey: 'legs',
            subzoneKey: 'upper_leg_hip',
            focusKey: 'glutes_complete',
          ),
          equipment: {'bodyweight', 'bench'},
        ),
        containsAll(['Ponte de glúteo', 'Hip thrust com apoio']),
      );

      expect(
        _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'lower',
            groupKey: 'legs',
            subzoneKey: 'lower_leg_foot',
            focusKey: 'lower_leg_complete',
          ),
          equipment: {'bodyweight'},
        ),
        containsAll(['Gémeos em pé', 'Elevação tibial']),
      );
    });

    test(
      'cardio and recovery complete-style branches stay modality scoped',
      () {
        final bike = _names(
          const TrainingFlowSelection(typeKey: 'cardio', equipmentKey: 'bike'),
          location: 'Ginásio',
        );
        expect(
          bike,
          containsAll([
            'Bicicleta ritmo leve',
            'Bicicleta ritmo moderado',
            'Bicicleta intervalos',
          ]),
        );
        expect(bike, isNot(contains('Passadeira caminhada')));

        final elliptical = _names(
          const TrainingFlowSelection(
            typeKey: 'cardio',
            equipmentKey: 'elliptical',
          ),
          location: 'Ginásio',
        );
        expect(elliptical, contains('Elíptica ritmo leve'));
        expect(elliptical, isNot(contains('Bicicleta ritmo leve')));

        final noEquipment = _names(
          const TrainingFlowSelection(
            typeKey: 'cardio',
            equipmentKey: 'no_equipment',
          ),
          equipment: {'bodyweight'},
        );
        expect(
          noEquipment,
          containsAll(['Jumping jacks', 'Mountain climbers']),
        );
        expect(noEquipment, isNot(contains('Passadeira caminhada')));

        final recovery = _names(
          const TrainingFlowSelection(
            typeKey: 'recovery',
            recoveryKey: 'light_stretching',
          ),
          equipment: {'bodyweight'},
        );
        expect(
          recovery,
          containsAll([
            'Alongamento cervical leve',
            'Alongamento posterior de coxa',
            'Respiração diafragmática',
          ]),
        );
      },
    );

    test(
      'martial complete and mobility general aggregate expected children',
      () {
        expect(
          _names(
            const TrainingFlowSelection(
              typeKey: 'martial_arts',
              martialArtKey: 'karate',
              focusKey: 'karate_complete',
            ),
            location: 'Dojo / Artes marciais',
            equipment: {'tatami'},
          ),
          containsAll([
            'Kihon',
            'Kata',
            'Kumite técnico',
            'Drills de deslocamento',
            'Condicionamento leve para Karate',
          ]),
        );

        expect(
          _names(
            const TrainingFlowSelection(
              typeKey: 'martial_arts',
              martialArtKey: 'jiu_jitsu',
              focusKey: 'jiu_jitsu_complete',
            ),
            location: 'Dojo / Artes marciais',
            equipment: {'tatami'},
          ),
          containsAll([
            'Shrimp / fuga de anca',
            'Ponte de grappling',
            'Technical stand-up',
            'Drills de passagem de guarda',
            'Força de pega para Jiu-Jitsu',
            'Core para Jiu-Jitsu',
          ]),
        );

        expect(
          _names(
            const TrainingFlowSelection(
              typeKey: 'mobility',
              mobilityZoneKey: 'general_mobility',
            ),
            equipment: {'bodyweight'},
          ),
          containsAll([
            'Mobilidade de ombro',
            'Mobilidade de anca',
            'Alongamento posterior de coxa',
            'Alongamento glúteos',
            'Mobilidade de tornozelo na parede',
            'Alongamento cervical leve',
          ]),
        );
      },
    );
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
