import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.1 workout flow filters', () {
    test('strength dumbbells arms biceps shows dumbbell curls', () {
      final flow = const TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'dumbbells',
        regionKey: 'upper',
        groupKey: 'arms',
        focusKey: 'biceps',
      );

      expect(_names(flow, equipment: {'dumbbells'}), [
        'Curl com halteres',
        'Curl alternado',
        'Curl martelo',
        'Curl concentrado',
        'Curl isométrico',
      ]);
    });

    test(
      'strength bodyweight arms biceps does not show push-ups as biceps',
      () {
        final flow = const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'bodyweight',
          regionKey: 'upper',
          groupKey: 'arms',
          focusKey: 'biceps',
        );

        final names = _names(flow, equipment: {'bodyweight'});
        expect(names, isNot(contains('Flexões')));
        expect(names, isNot(contains('Flexões fechadas')));
      },
    );

    test('strength bodyweight chest shows push-ups', () {
      final flow = const TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'upper',
        groupKey: 'chest',
      );

      expect(_names(flow, equipment: {'bodyweight'}), contains('Flexões'));
    });

    test('strength bodyweight triceps shows close push-ups', () {
      final flow = const TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'upper',
        groupKey: 'arms',
        focusKey: 'triceps',
      );

      expect(
        _names(flow, equipment: {'bodyweight'}),
        contains('Flexões fechadas'),
      );
    });

    test('cardio treadmill only shows treadmill and not bike', () {
      final flow = const TrainingFlowSelection(
        typeKey: 'cardio',
        equipmentKey: 'treadmill',
        cardioFocusKey: 'treadmill',
      );
      final names = _names(flow, location: 'Ginásio');

      expect(
        names,
        containsAll([
          'Passadeira aquecimento',
          'Passadeira caminhada',
          'Passadeira caminhada rápida',
          'Passadeira corrida leve',
          'Passadeira corrida intervalada',
          'Passadeira inclinação',
          'Passadeira cooldown',
        ]),
      );
      expect(names, isNot(contains('Bicicleta ritmo leve')));
    });

    test('cardio without equipment shows no-equipment cardio', () {
      final flow = const TrainingFlowSelection(
        typeKey: 'cardio',
        equipmentKey: 'bodyweight',
        cardioFocusKey: 'no_equipment',
      );

      expect(
        _names(flow, location: 'Casa', equipment: {}),
        contains('HIIT peso corporal'),
      );
    });

    test('martial arts karate does not show exclusive jiu-jitsu', () {
      final flow = const TrainingFlowSelection(
        typeKey: 'martial_arts',
        martialArtKey: 'karate',
      );
      final names = _names(flow, location: 'Dojo / Artes marciais');

      expect(names, contains('Kihon'));
      expect(names, isNot(contains('Shrimp / fuga de anca')));
    });

    test('martial arts jiu-jitsu does not show exclusive karate', () {
      final flow = const TrainingFlowSelection(
        typeKey: 'martial_arts',
        martialArtKey: 'jiu_jitsu',
      );
      final names = _names(flow, location: 'Dojo / Artes marciais');

      expect(names, contains('Shrimp / fuga de anca'));
      expect(names, isNot(contains('Kihon')));
    });

    test('mobility hip shows hip mobility', () {
      final flow = const TrainingFlowSelection(
        typeKey: 'mobility',
        mobilityZoneKey: 'hip_mobility',
      );

      expect(_names(flow, location: 'Casa'), contains('Mobilidade de anca'));
    });

    test('abdominal core shows bodyweight core exercises', () {
      final flow = const TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'core',
        groupKey: 'abdominal',
      );
      final names = _names(flow, location: 'Casa', equipment: {});

      expect(
        names,
        containsAll([
          'Prancha',
          'Prancha lateral',
          'Crunch',
          'Reverse crunch',
          'Elevação de pernas',
          'Dead bug',
          'Hollow hold',
          'Mountain climbers',
          'Russian twist',
          'Bicycle crunch',
          'Bird dog',
          'Vacuum abdominal',
          'Flutter kicks',
          'Toe touches',
        ]),
      );
    });

    test('bodyweight is available by default', () {
      final flow = const TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'upper',
        groupKey: 'chest',
      );

      expect(
        _names(flow, location: 'Casa', equipment: {}),
        contains('Flexões'),
      );
    });
  });

  group('v0.7.1 workout flow labels and names', () {
    test('automatic name includes type and focus, not only the last field', () {
      expect(
        TrainingFlow.suggestedWorkoutName(
          const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'dumbbells',
            regionKey: 'upper',
            groupKey: 'arms',
            focusKey: 'biceps',
          ),
        ),
        'Musculação - Bíceps',
      );

      expect(
        TrainingFlow.suggestedWorkoutName(
          const TrainingFlowSelection(
            typeKey: 'cardio',
            equipmentKey: 'treadmill',
            cardioFocusKey: 'aerobic_endurance',
          ),
        ),
        'Cardio - Passadeira - Resistência aeróbia',
      );
    });

    test('final label changes by workout type', () {
      expect(TrainingFlow.finalFocusLabel('strength'), 'Músculo específico');
      expect(TrainingFlow.finalFocusLabel('cardio'), 'Foco cardio');
      expect(TrainingFlow.finalFocusLabel('martial_arts'), 'Foco técnico');
      expect(TrainingFlow.finalFocusLabel('mobility'), 'Zona/foco');
      expect(TrainingFlow.finalFocusLabel('recovery'), 'Tipo de recuperação');
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
  _exercise('Curl com halteres', 'Bíceps', 'Halteres', 'Bíceps'),
  _exercise('Curl alternado', 'Bíceps', 'Halteres', 'Bíceps'),
  _exercise('Curl martelo', 'Bíceps', 'Halteres', 'Braquial, braquiorradial'),
  _exercise('Curl concentrado', 'Bíceps', 'Halteres', 'Bíceps'),
  _exercise('Curl isométrico', 'Bíceps', 'Halteres', 'Bíceps'),
  _exercise('Flexões', 'Peito', 'Peso corporal', 'Peito, ombros'),
  _exercise('Flexões fechadas', 'Tríceps', 'Peso corporal', 'Tríceps'),
  _exercise('Prancha', 'Core', 'Peso corporal', 'Abdominal, anti-extensão'),
  _exercise('Prancha lateral', 'Core', 'Peso corporal', 'Oblíquos'),
  _exercise('Crunch', 'Core', 'Peso corporal', 'Reto abdominal'),
  _exercise('Reverse crunch', 'Core', 'Peso corporal', 'Reto abdominal'),
  _exercise('Elevação de pernas', 'Core', 'Peso corporal', 'Reto abdominal'),
  _exercise('Dead bug', 'Core', 'Peso corporal', 'Estabilidade do core'),
  _exercise('Hollow hold', 'Core', 'Peso corporal', 'Anti-extensão'),
  _exercise('Mountain climbers', 'Core', 'Peso corporal', 'Core'),
  _exercise('Russian twist', 'Core', 'Peso corporal', 'Oblíquos'),
  _exercise('Bicycle crunch', 'Core', 'Peso corporal', 'Oblíquos'),
  _exercise('Bird dog', 'Core', 'Peso corporal', 'Estabilidade do core'),
  _exercise(
    'Vacuum abdominal',
    'Core',
    'Peso corporal',
    'Transverso abdominal',
  ),
  _exercise('Flutter kicks', 'Core', 'Peso corporal', 'Reto abdominal'),
  _exercise('Toe touches', 'Core', 'Peso corporal', 'Reto abdominal'),
  _exercise('Passadeira aquecimento', 'Cardio', 'Passadeira', 'Passadeira'),
  _exercise('Passadeira caminhada', 'Cardio', 'Passadeira', 'Passadeira'),
  _exercise(
    'Passadeira caminhada rápida',
    'Cardio',
    'Passadeira',
    'Passadeira',
  ),
  _exercise('Passadeira corrida leve', 'Cardio', 'Passadeira', 'Passadeira'),
  _exercise(
    'Passadeira corrida intervalada',
    'Cardio',
    'Passadeira',
    'Passadeira',
  ),
  _exercise('Passadeira inclinação', 'Cardio', 'Passadeira', 'Passadeira'),
  _exercise('Passadeira cooldown', 'Cardio', 'Passadeira', 'Passadeira'),
  _exercise('Bicicleta ritmo leve', 'Cardio', 'Bicicleta', 'Bicicleta'),
  _exercise('HIIT peso corporal', 'Cardio', 'Peso corporal', 'HIIT'),
  _exercise('Kihon', 'Karate', 'Peso corporal', 'Karate técnico'),
  _exercise('Shrimp / fuga de anca', 'Jiu-Jitsu', 'Tatami', 'Jiu-Jitsu'),
  _exercise('Mobilidade de anca', 'Mobilidade', 'Peso corporal', 'Anca'),
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
    commonMistakes: 'Evitar pressa e compensações.',
    safetyNotes: 'Para se houver dor aguda.',
    isDefault: true,
  );
}
