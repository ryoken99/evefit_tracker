import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.5 lower body hierarchy', () {
    test('lower body exposes leg subzones before specific muscles', () {
      expect(
        TrainingFlow.strengthSubzonesForGroup(
          'lower',
        ).map((item) => item.value),
        [
          'Pernas completo',
          'Acima do joelho / coxa e anca',
          'Abaixo do joelho / perna inferior e pé',
        ],
      );
    });

    test('legs complete skips specific muscle choice', () {
      expect(
        TrainingFlow.requiresStrengthSpecificFocus('legs', 'legs_complete'),
        isFalse,
      );
      expect(TrainingFlow.strengthSpecificOptions('legs', 'legs_complete'), []);
    });

    test('above and below knee subzones expose required muscles', () {
      expect(
        TrainingFlow.strengthSpecificOptions(
          'legs',
          'upper_leg_hip',
        ).map((item) => item.value),
        containsAll([
          'Quadríceps completo',
          'Reto femoral',
          'Vasto lateral',
          'Vasto medial',
          'Vasto intermédio',
          'Posterior de coxa completo',
          'Bíceps femoral',
          'Semitendinoso',
          'Semimembranoso',
          'Glúteo máximo',
          'Glúteo médio',
          'Glúteo mínimo',
          'Adutores',
          'Abdutores',
          'Flexores da anca',
          'Rotadores externos da anca',
        ]),
      );

      expect(
        TrainingFlow.strengthSpecificOptions(
          'legs',
          'lower_leg_foot',
        ).map((item) => item.value),
        containsAll([
          'Gémeos',
          'Sóleo',
          'Tibial anterior',
          'Tornozelo',
          'Pés',
          'Estabilidade do tornozelo',
        ]),
      );
    });
  });

  group('v0.7.5 cardio filters', () {
    test('treadmill aerobic endurance excludes HIIT intervals and sprints', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
          cardioFocusKey: 'aerobic_endurance',
        ),
        location: 'Ginásio',
      );

      expect(
        names,
        containsAll([
          'Passadeira aquecimento',
          'Passadeira caminhada',
          'Passadeira caminhada rápida',
          'Passadeira corrida leve',
          'Passadeira inclinação',
          'Passadeira cooldown',
        ]),
      );
      expect(names, isNot(contains('Passadeira corrida intervalada')));
      expect(names, isNot(contains('Passadeira sprints intervalados')));
      expect(names, isNot(contains('HIIT passadeira')));
      expect(names, isNot(contains('Bicicleta ritmo leve')));
    });

    test(
      'treadmill interval focus excludes bike and includes treadmill HIIT',
      () {
        final names = _names(
          const TrainingFlowSelection(
            typeKey: 'cardio',
            equipmentKey: 'treadmill',
            cardioFocusKey: 'treadmill_intervals',
          ),
          location: 'Ginásio',
        );

        expect(
          names,
          containsAll([
            'Passadeira corrida intervalada',
            'Passadeira sprints intervalados',
            'HIIT passadeira',
          ]),
        );
        expect(names, isNot(contains('Bicicleta ritmo leve')));
      },
    );
  });

  group('v0.7.5 martial arts flow', () {
    test('automatic name includes martial art and technical focus', () {
      expect(
        TrainingFlow.suggestedWorkoutName(
          const TrainingFlowSelection(
            typeKey: 'martial_arts',
            martialArtKey: 'karate',
            focusKey: 'kihon',
          ),
        ),
        'Artes marciais - Karate - Kihon',
      );

      expect(
        TrainingFlow.suggestedWorkoutName(
          const TrainingFlowSelection(
            typeKey: 'martial_arts',
            martialArtKey: 'jiu_jitsu',
            focusKey: 'guard_passing',
          ),
        ),
        'Artes marciais - Jiu-Jitsu - Passagem de guarda',
      );
    });

    test('karate focus shows requested drills and not jiu-jitsu exclusive', () {
      final complete = _names(
        const TrainingFlowSelection(
          typeKey: 'martial_arts',
          martialArtKey: 'karate',
          focusKey: 'karate_complete',
        ),
        location: 'Dojo / Artes marciais',
        equipment: {'tatami'},
      );
      expect(complete, containsAll(['Kihon', 'Kata', 'Kumite técnico']));
      expect(complete, isNot(contains('Shrimp / fuga de anca')));

      final kihon = _names(
        const TrainingFlowSelection(
          typeKey: 'martial_arts',
          martialArtKey: 'karate',
          focusKey: 'kihon',
        ),
        location: 'Dojo / Artes marciais',
        equipment: {'tatami'},
      );
      expect(kihon, contains('Kihon'));
      expect(kihon, isNot(contains('Kata')));
      expect(kihon, isNot(contains('Shrimp / fuga de anca')));
    });

    test('jiu-jitsu focus does not show karate exclusive drills', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'martial_arts',
          martialArtKey: 'jiu_jitsu',
          focusKey: 'guard_passing',
        ),
        location: 'Dojo / Artes marciais',
        equipment: {'tatami'},
      );

      expect(names, contains('Drills de passagem de guarda'));
      expect(names, isNot(contains('Kihon')));
      expect(names, isNot(contains('Kata')));
      expect(names, isNot(contains('Kumite técnico')));
    });
  });

  group('v0.7.5 recovery and custom filters', () {
    test('recovery light stretching shows bodyweight stretches', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'recovery',
          recoveryKey: 'light_stretching',
        ),
        location: 'Casa',
        equipment: {},
      );

      expect(
        names,
        containsAll([
          'Alongamento peitoral',
          'Alongamento dorsal',
          'Alongamento posterior de coxa',
          'Alongamento glúteos',
          'Alongamento gémeos',
          'Alongamento cervical leve',
          'Mobilidade leve de ombros',
          'Mobilidade leve de anca',
          'Respiração diafragmática',
        ]),
      );
    });

    test(
      'custom flow without optional filters respects available equipment',
      () {
        final names = _names(
          const TrainingFlowSelection(typeKey: 'custom'),
          location: 'Casa',
          equipment: {'dumbbells'},
        );

        expect(names, contains('Curl com halteres'));
        expect(names, contains('Flexões'));
        expect(names, isNot(contains('Crossover no cabo')));
        expect(names, isNot(contains('Passadeira caminhada')));
      },
    );
  });

  group('v0.7.5 exercise catalog metadata', () {
    test('face pull catalog separates cable and elastic variants', () {
      final names = SeedData.exercisesByGroup.values.expand((items) => items);

      expect(names, contains('Face pull com elástico'));
      expect(names, contains('Face pull no cabo'));
      expect(names, isNot(contains('Face pull')));
    });

    test('shrugs have explicit equipment variants', () {
      final names = SeedData.exercisesByGroup.values.expand((items) => items);

      expect(names, contains('Encolhimento de ombros com halteres'));
      expect(names, contains('Encolhimento de ombros com barra'));
      expect(names, isNot(contains('Encolhimento de ombros')));
    });
  });

  group('v0.7.5 labels and visible exercise data', () {
    test('automatic workout names do not expose internal keys', () {
      const forbidden = {
        'lower',
        'upper',
        'arms',
        'back',
        'chest',
        'legs',
        'treadmill',
        'bodyweight',
        'strength',
        'mobility',
        'core',
        'shoulders',
      };

      final names = [
        TrainingFlow.suggestedWorkoutName(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'lower',
            groupKey: 'legs',
            subzoneKey: 'upper_leg_hip',
            focusKey: 'rectus_femoris',
          ),
        ),
        TrainingFlow.suggestedWorkoutName(
          const TrainingFlowSelection(
            typeKey: 'cardio',
            equipmentKey: 'treadmill',
            cardioFocusKey: 'aerobic_endurance',
          ),
        ),
        TrainingFlow.suggestedWorkoutName(
          const TrainingFlowSelection(
            typeKey: 'martial_arts',
            martialArtKey: 'karate',
            focusKey: 'kihon',
          ),
        ),
      ];

      for (final name in names) {
        final lower = name.toLowerCase();
        for (final key in forbidden) {
          expect(lower.split(RegExp(r'\s+')), isNot(contains(key)));
        }
      }
    });

    test('all visible exercises have description steps and equipment', () {
      final visible = ExerciseFilterService.getAvailableExercises(
        exercises: _fixtureExercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: {'dumbbells', 'treadmill', 'tatami'},
        selection: const TrainingFlowSelection(
          typeKey: 'custom',
        ).let(TrainingFlow.toTrainingSelection),
        showAllExercises: false,
      );

      for (final item in visible) {
        expect(item.exercise.description.trim(), isNotEmpty);
        expect(item.exercise.executionSteps.trim(), isNotEmpty);
        expect(item.exercise.equipment.trim(), isNotEmpty);
      }
    });
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
  _exercise('Flexões', 'Peito', 'Peso corporal', 'Peito médio'),
  _exercise('Crossover no cabo', 'Peito', 'Cabo alto', 'Peito médio'),
  _exercise('Passadeira aquecimento', 'Cardio', 'Passadeira', 'Aquecimento'),
  _exercise('Passadeira caminhada', 'Cardio', 'Passadeira', 'Caminhada'),
  _exercise(
    'Passadeira caminhada rápida',
    'Cardio',
    'Passadeira',
    'Caminhada rápida',
  ),
  _exercise('Passadeira corrida leve', 'Cardio', 'Passadeira', 'Corrida leve'),
  _exercise(
    'Passadeira corrida intervalada',
    'Cardio',
    'Passadeira',
    'Intervalos',
  ),
  _exercise('Passadeira inclinação', 'Cardio', 'Passadeira', 'Inclinação'),
  _exercise(
    'Passadeira sprints intervalados',
    'Cardio',
    'Passadeira',
    'Sprints',
  ),
  _exercise('Passadeira cooldown', 'Cardio', 'Passadeira', 'Cooldown'),
  _exercise('HIIT passadeira', 'Cardio', 'Passadeira', 'HIIT'),
  _exercise('Bicicleta ritmo leve', 'Cardio', 'Bicicleta', 'Bicicleta'),
  _exercise('Kihon', 'Karate', 'Tatami', 'Karate, Kihon'),
  _exercise('Kata', 'Karate', 'Tatami', 'Karate, Kata'),
  _exercise('Kumite técnico', 'Karate', 'Tatami', 'Karate, Kumite técnico'),
  _exercise('Sombra de Karate', 'Karate', 'Peso corporal', 'Karate'),
  _exercise(
    'Shrimp / fuga de anca',
    'Jiu-Jitsu',
    'Tatami',
    'Jiu-Jitsu, shrimp',
  ),
  _exercise(
    'Drills de passagem de guarda',
    'Jiu-Jitsu',
    'Tatami',
    'Jiu-Jitsu, passagem de guarda',
  ),
  _exercise('Alongamento peitoral', 'Mobilidade', 'Peso corporal', 'Peitoral'),
  _exercise('Alongamento dorsal', 'Mobilidade', 'Peso corporal', 'Dorsal'),
  _exercise(
    'Alongamento posterior de coxa',
    'Mobilidade',
    'Peso corporal',
    'Posterior de coxa',
  ),
  _exercise('Alongamento glúteos', 'Mobilidade', 'Peso corporal', 'Glúteos'),
  _exercise('Alongamento gémeos', 'Mobilidade', 'Peso corporal', 'Gémeos'),
  _exercise(
    'Alongamento cervical leve',
    'Mobilidade',
    'Peso corporal',
    'Pescoço',
  ),
  _exercise(
    'Mobilidade leve de ombros',
    'Mobilidade',
    'Peso corporal',
    'Ombros',
  ),
  _exercise('Mobilidade leve de anca', 'Mobilidade', 'Peso corporal', 'Anca'),
  _exercise(
    'Respiração diafragmática',
    'Mobilidade',
    'Peso corporal',
    'Respiração',
  ),
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
    executionSteps:
        'Prepara a posição, executa $name com controlo e regressa de forma gradual.',
    commonMistakes: 'Evitar pressa, compensações e amplitude incompleta.',
    safetyNotes: 'Para se houver dor aguda, tontura ou perda de técnica.',
    isDefault: true,
  );
}

extension _Let<T> on T {
  R let<R>(R Function(T value) convert) => convert(this);
}
