import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_catalog_detail_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.10 complete filter entry audit', () {
    test(
      'arms complete with dumbbells includes arm children and excludes external branches',
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
            'Extensão francesa com halter',
            'Extensão acima da cabeça com halter',
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
            'Suitcase carry',
          ]),
        );
        expect(
          names,
          isNot(
            containsAll([
              'Supino com halteres',
              'Aberturas com halteres',
              'Remo unilateral com halter',
              'Elevação lateral',
              'Agachamento goblet',
              'Passadeira caminhada',
            ]),
          ),
        );
        for (final forbidden in [
          'Supino com halteres',
          'Aberturas com halteres',
          'Remo unilateral com halter',
          'Elevação lateral',
          'Agachamento goblet',
          'Passadeira caminhada',
        ]) {
          expect(names, isNot(contains(forbidden)), reason: forbidden);
        }
      },
    );

    test(
      'required complete filters aggregate children without crossing branches',
      () {
        final cases = <_CompleteCase>[
          _CompleteCase(
            label: 'Peito completo',
            flow: const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'bodyweight',
              regionKey: 'upper',
              groupKey: 'chest',
              subzoneKey: 'chest_complete',
            ),
            equipment: {'bodyweight', 'chair_support'},
            expected: ['Flexão clássica', 'Flexão inclinada'],
            forbidden: ['Curl com halteres', 'Agachamento com peso corporal'],
          ),
          _CompleteCase(
            label: 'Costas completo',
            flow: const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'dumbbells',
              regionKey: 'upper',
              groupKey: 'back',
              subzoneKey: 'back_complete',
            ),
            equipment: {'dumbbells'},
            expected: ['Remo unilateral com halter', 'Pullover com halter'],
            forbidden: ['Curl com halteres', 'Supino com halteres'],
          ),
          _CompleteCase(
            label: 'Ombros completo',
            flow: const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'dumbbells',
              regionKey: 'upper',
              groupKey: 'shoulders',
              subzoneKey: 'shoulders_complete',
            ),
            equipment: {'dumbbells'},
            expected: ['Press militar com halteres', 'Elevação lateral'],
            forbidden: ['Curl com halteres', 'Supino com halteres'],
          ),
          _CompleteCase(
            label: 'Antebraço completo',
            flow: const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'dumbbells',
              regionKey: 'upper',
              groupKey: 'forearm_hand',
              subzoneKey: 'forearm_complete',
            ),
            equipment: {'dumbbells'},
            expected: ['Wrist curl', 'Farmer hold'],
            forbidden: ['Supino com halteres', 'Agachamento goblet'],
          ),
          _CompleteCase(
            label: 'Core completo',
            flow: const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'bodyweight',
              regionKey: 'core',
              groupKey: 'core',
              subzoneKey: 'core_complete',
            ),
            equipment: {'bodyweight', 'mat'},
            expected: ['Prancha', 'Dead bug', 'Bird dog'],
            forbidden: ['Supino com halteres', 'Passadeira caminhada'],
          ),
          _CompleteCase(
            label: 'Pernas completo',
            flow: const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'bodyweight',
              regionKey: 'lower',
              groupKey: 'legs',
              subzoneKey: 'legs_complete',
            ),
            equipment: {'bodyweight', 'chair_support'},
            expected: [
              'Agachamento com peso corporal',
              'Wall sit',
              'Gémeos em pé',
            ],
            forbidden: ['Curl com halteres', 'Supino com halteres'],
          ),
          _CompleteCase(
            label: 'Posterior de coxa completo',
            flow: const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'bodyweight',
              regionKey: 'lower',
              groupKey: 'legs',
              subzoneKey: 'upper_leg_hip',
              focusKey: 'hamstrings_complete',
            ),
            equipment: {'bodyweight'},
            expected: ['Good morning sem carga'],
            forbidden: [
              'Agachamento com peso corporal',
              'Wall sit',
              'Lunges',
              'Ponte de glúteo',
            ],
          ),
          _CompleteCase(
            label: 'Glúteos completo',
            flow: const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'bodyweight',
              regionKey: 'lower',
              groupKey: 'legs',
              subzoneKey: 'upper_leg_hip',
              focusKey: 'glutes_complete',
            ),
            equipment: {'bodyweight', 'chair_support'},
            expected: ['Ponte de glúteo', 'Hip thrust com apoio'],
            forbidden: [
              'Good morning sem carga',
              'Agachamento com peso corporal',
              'Wall sit',
            ],
          ),
          _CompleteCase(
            label: 'Passadeira completo',
            flow: const TrainingFlowSelection(
              typeKey: 'cardio',
              equipmentKey: 'treadmill',
            ),
            location: 'Ginásio',
            equipment: {'treadmill'},
            expected: ['Passadeira caminhada', 'Passadeira cooldown'],
            forbidden: ['Bicicleta ritmo leve', 'Elíptica ritmo leve'],
          ),
          _CompleteCase(
            label: 'Mobilidade geral',
            flow: const TrainingFlowSelection(
              typeKey: 'mobility',
              mobilityZoneKey: 'general_mobility',
            ),
            equipment: {'bodyweight', 'mat'},
            expected: ['Alongamento cervical leve', 'Mobilidade de anca'],
            forbidden: ['Supino com halteres', 'Passadeira caminhada'],
          ),
          _CompleteCase(
            label: 'Karate completo',
            flow: const TrainingFlowSelection(
              typeKey: 'martial_arts',
              martialArtKey: 'karate',
              focusKey: 'karate_complete',
            ),
            location: 'Dojo / Artes marciais',
            equipment: {'tatami'},
            expected: ['Kihon', 'Kata', 'Kumite técnico'],
            forbidden: ['Shrimp / fuga de anca'],
          ),
          _CompleteCase(
            label: 'Jiu-Jitsu completo',
            flow: const TrainingFlowSelection(
              typeKey: 'martial_arts',
              martialArtKey: 'jiu_jitsu',
              focusKey: 'jiu_jitsu_complete',
            ),
            location: 'Dojo / Artes marciais',
            equipment: {'tatami'},
            expected: ['Shrimp / fuga de anca', 'Ponte de grappling'],
            forbidden: ['Kihon', 'Kata'],
          ),
        ];

        for (final completeCase in cases) {
          final names = _names(
            completeCase.flow,
            location: completeCase.location,
            equipment: completeCase.equipment,
          );
          expect(
            names,
            containsAll(completeCase.expected),
            reason: completeCase.label,
          );
          for (final forbidden in completeCase.forbidden) {
            expect(
              names,
              isNot(contains(forbidden)),
              reason: '${completeCase.label}: $forbidden',
            );
          }
        }
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

class _CompleteCase {
  const _CompleteCase({
    required this.label,
    required this.flow,
    required this.expected,
    required this.forbidden,
    this.location = 'Casa',
    this.equipment = const {'bodyweight'},
  });

  final String label;
  final TrainingFlowSelection flow;
  final List<String> expected;
  final List<String> forbidden;
  final String location;
  final Set<String> equipment;
}
