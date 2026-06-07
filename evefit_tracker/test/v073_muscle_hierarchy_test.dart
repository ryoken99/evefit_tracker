import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.3 strength hierarchy options', () {
    test('complete options do not require another specific muscle choice', () {
      expect(
        TrainingFlow.requiresStrengthSpecificFocus('arms', 'arms_complete'),
        isFalse,
      );
      expect(
        TrainingFlow.requiresStrengthSpecificFocus('back', 'back_complete'),
        isFalse,
      );
      expect(
        TrainingFlow.requiresStrengthSpecificFocus('core', 'core_complete'),
        isFalse,
      );
      expect(
        TrainingFlow.requiresStrengthSpecificFocus('legs', 'legs_complete'),
        isFalse,
      );
      expect(
        TrainingFlow.requiresStrengthSpecificFocus('chest', 'chest_complete'),
        isFalse,
      );
      expect(
        TrainingFlow.requiresStrengthSpecificFocus(
          'shoulders',
          'shoulders_complete',
        ),
        isFalse,
      );
    });

    test('arms opens arm and forearm anatomical zones', () {
      expect(
        TrainingFlow.strengthSubzonesForGroup(
          'arms',
        ).map((item) => '${item.key}:${item.value}'),
        [
          'arms_complete:Braços completo',
          'upper_arm:Braço',
          'forearm_hand:Antebraço / punho / mão',
        ],
      );
    });

    test(
      'upper arm opens biceps brachialis brachioradialis coracobrachialis and triceps',
      () {
        expect(
          TrainingFlow.strengthSpecificOptions(
            'arms',
            'upper_arm',
          ).map((item) => item.value),
          [
            'Bíceps braquial',
            'Braquial',
            'Braquiorradial',
            'Coracobraquial',
            'Tríceps completo',
            'Tríceps cabeça longa',
            'Tríceps cabeça lateral',
            'Tríceps cabeça medial',
          ],
        );
      },
    );

    test(
      'forearm opens flexors extensors pronators supinators wrist fingers and grip',
      () {
        expect(
          TrainingFlow.strengthSpecificOptions(
            'arms',
            'forearm_hand',
          ).map((item) => item.value),
          [
            'Antebraço completo',
            'Flexores do antebraço',
            'Extensores do antebraço',
            'Pronadores',
            'Supinadores',
            'Punho',
            'Dedos',
            'Pega de suporte',
            'Pega de pinça',
            'Força de pega geral',
          ],
        );
      },
    );

    test('chest opens upper middle lower and serratus options', () {
      expect(
        TrainingFlow.strengthSubzonesForGroup(
          'chest',
        ).map((item) => item.value),
        [
          'Peito completo',
          'Peito superior',
          'Peito médio',
          'Peito inferior',
          'Peitoral menor',
          'Serrátil anterior',
        ],
      );
    });

    test(
      'back hierarchy includes complete upper lower width and thickness',
      () {
        expect(
          TrainingFlow.strengthSubzonesForGroup(
            'back',
          ).map((item) => item.value),
          [
            'Costas completo',
            'Costas superior',
            'Costas média',
            'Costas inferior / lombar',
            'Costas largura',
            'Costas espessura',
          ],
        );
        expect(
          TrainingFlow.strengthSpecificOptions(
            'back',
            'back_upper',
          ).map((item) => item.value),
          containsAll([
            'Trapézio superior',
            'Romboides',
            'Estabilizadores escapulares',
          ]),
        );
        expect(
          TrainingFlow.strengthSpecificOptions(
            'back',
            'back_lower',
          ).map((item) => item.value),
          containsAll(['Eretores da espinha', 'Lombar']),
        );
      },
    );

    test(
      'core abdominal and lower body hierarchies expose requested divisions',
      () {
        expect(
          TrainingFlow.strengthSubzonesForGroup(
            'core',
          ).map((item) => item.value),
          ['Core completo', 'Abdominal', 'Lombar', 'Estabilidade do core'],
        );
        expect(
          TrainingFlow.strengthSpecificOptions(
            'core',
            'abdominal_zone',
          ).map((item) => item.value),
          containsAll([
            'Abdominal superior',
            'Abdominal médio',
            'Abdominal inferior',
            'Abdominais laterais / oblíquos',
          ]),
        );
        expect(
          TrainingFlow.strengthSubzonesForGroup(
            'legs',
          ).map((item) => item.value),
          [
            'Pernas completo',
            'Acima do joelho / coxa e anca',
            'Abaixo do joelho / perna inferior e pé',
          ],
        );
        expect(
          TrainingFlow.strengthSpecificOptions(
            'legs',
            'upper_leg_hip',
          ).map((item) => item.value),
          containsAll([
            'Quadríceps completo',
            'Posterior de coxa completo',
            'Glúteos completo',
            'Adutores',
            'Abdutores',
          ]),
        );
        expect(
          TrainingFlow.strengthSpecificOptions(
            'legs',
            'lower_leg_foot',
          ).map((item) => item.value),
          containsAll(['Gémeos', 'Sóleo', 'Tibial anterior', 'Tornozelo']),
        );
      },
    );
  });

  group('v0.7.3 strength hierarchy filtering', () {
    test(
      'biceps brachii with dumbbells shows dumbbell curls and not push-ups',
      () {
        final names = _names(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'dumbbells',
            regionKey: 'upper',
            groupKey: 'arms',
            subzoneKey: 'upper_arm',
            focusKey: 'biceps_brachii',
          ),
          equipment: {'dumbbells'},
        );

        expect(
          names,
          containsAll([
            'Curl com halteres',
            'Curl alternado',
            'Curl concentrado',
          ]),
        );
        expect(names, isNot(contains('Flexões')));
        expect(names, isNot(contains('Tríceps testa')));
      },
    );

    test('bodyweight biceps without pull-up bar does not show push-ups', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'bodyweight',
          regionKey: 'upper',
          groupKey: 'arms',
          subzoneKey: 'upper_arm',
          focusKey: 'biceps_brachii',
        ),
        location: 'Casa',
        equipment: {},
      );

      expect(names, isNot(contains('Flexões')));
      expect(names, isNot(contains('Flexões fechadas')));
    });

    test('triceps bodyweight shows close push-ups and dips with support', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'bodyweight',
          regionKey: 'upper',
          groupKey: 'arms',
          subzoneKey: 'upper_arm',
          focusKey: 'triceps',
        ),
        location: 'Casa',
        equipment: {'bodyweight', 'chair_support'},
      );

      expect(names, containsAll(['Flexões fechadas', 'Fundos entre apoios']));
    });

    test(
      'abdominal lower and lateral options show matching core exercises',
      () {
        expect(
          _names(
            const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'bodyweight',
              regionKey: 'core',
              groupKey: 'core',
              subzoneKey: 'abdominal_zone',
              focusKey: 'lower_abs',
            ),
            location: 'Casa',
            equipment: {},
          ),
          containsAll(['Reverse crunch', 'Elevação de pernas']),
        );

        expect(
          _names(
            const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'bodyweight',
              regionKey: 'core',
              groupKey: 'core',
              subzoneKey: 'abdominal_zone',
              focusKey: 'lateral_abs',
            ),
            location: 'Casa',
            equipment: {},
          ),
          containsAll(['Prancha lateral', 'Russian twist', 'Bicycle crunch']),
        );
      },
    );

    test(
      'core complete bodyweight shows plank crunch dead bug and hollow hold',
      () {
        expect(
          _names(
            const TrainingFlowSelection(
              typeKey: 'strength',
              equipmentKey: 'bodyweight',
              regionKey: 'core',
              groupKey: 'core',
              subzoneKey: 'core_complete',
            ),
            location: 'Casa',
            equipment: {},
          ),
          containsAll(['Prancha', 'Crunch', 'Dead bug', 'Hollow hold']),
        );
      },
    );
  });
}

List<String> _names(
  TrainingFlowSelection flow, {
  String location = 'Ginásio',
  Set<String> equipment = const {},
}) {
  return ExerciseFilterService.getAvailableExercises(
    exercises: _fixtureExercises,
    trainingLocation: location,
    availableEquipmentKeys: equipment,
    selection: TrainingFlow.toTrainingSelection(flow),
    showAllExercises: false,
  ).map((item) => item.exercise.name).toList();
}

final _fixtureExercises = [
  _exercise('Curl com halteres', 'Bíceps', 'Halteres', 'Bíceps braquial'),
  _exercise('Curl alternado', 'Bíceps', 'Halteres', 'Bíceps braquial'),
  _exercise('Curl concentrado', 'Bíceps', 'Halteres', 'Bíceps braquial'),
  _exercise('Curl martelo', 'Bíceps', 'Halteres', 'Braquial, braquiorradial'),
  _exercise('Flexões', 'Peito', 'Peso corporal', 'Peito, ombros'),
  _exercise('Flexões fechadas', 'Tríceps', 'Peso corporal', 'Tríceps'),
  _exercise(
    'Fundos entre apoios',
    'Tríceps',
    'Peso corporal, Banco / cadeira / apoio',
    'Tríceps',
  ),
  _exercise('Tríceps testa', 'Tríceps', 'Barra', 'Tríceps'),
  _exercise(
    'Remo unilateral com halter',
    'Costas',
    'Halteres',
    'Costas, romboides',
  ),
  _exercise(
    'Hiperextensão lombar',
    'Costas',
    'Peso corporal',
    'Lombar, eretores da espinha',
  ),
  _exercise('Agachamento', 'Pernas', 'Peso corporal', 'Quadríceps, glúteos'),
  _exercise(
    'Elevação de pernas',
    'Core',
    'Peso corporal',
    'Abdominal inferior',
  ),
  _exercise('Reverse crunch', 'Core', 'Peso corporal', 'Abdominal inferior'),
  _exercise(
    'Prancha lateral',
    'Core',
    'Peso corporal',
    'Oblíquos, abdominais laterais',
  ),
  _exercise(
    'Russian twist',
    'Core',
    'Peso corporal',
    'Oblíquos, abdominais laterais',
  ),
  _exercise(
    'Bicycle crunch',
    'Core',
    'Peso corporal',
    'Oblíquos, abdominais laterais',
  ),
  _exercise('Prancha', 'Core', 'Peso corporal', 'Anti-extensão'),
  _exercise('Crunch', 'Core', 'Peso corporal', 'Abdominal'),
  _exercise('Dead bug', 'Core', 'Peso corporal', 'Estabilidade do core'),
  _exercise('Hollow hold', 'Core', 'Peso corporal', 'Anti-extensão'),
];

Exercise _exercise(
  String name,
  String group,
  String equipment,
  String secondary,
) {
  return Exercise(
    name: name,
    muscleGroup: group,
    secondaryMuscleGroups: secondary,
    equipment: equipment,
    description: '$name trabalha $group com foco específico.',
    executionSteps: 'Executa $name com controlo e regressa devagar.',
    commonMistakes: 'Evitar compensações e amplitude incompleta.',
    safetyNotes: 'Para se houver dor aguda.',
    isDefault: true,
  );
}
