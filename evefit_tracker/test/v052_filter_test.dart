import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/models/workout_type.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final exercises = [
    Exercise(
      name: 'Passadeira caminhada',
      muscleGroup: 'Cardio',
      equipment: 'Passadeira',
      isDefault: true,
    ),
    Exercise(
      name: 'Passadeira corrida intervalada',
      muscleGroup: 'Cardio',
      equipment: 'Passadeira',
      isDefault: true,
    ),
    Exercise(
      name: 'Bicicleta',
      muscleGroup: 'Cardio',
      equipment: 'Bicicleta',
      isDefault: true,
    ),
    Exercise(
      name: 'Elíptica',
      muscleGroup: 'Cardio',
      equipment: 'Elíptica',
      isDefault: true,
    ),
    Exercise(
      name: 'Corda de saltar',
      muscleGroup: 'Cardio',
      equipment: 'Corda de saltar',
      isDefault: true,
    ),
    Exercise(
      name: 'Curl com halteres',
      muscleGroup: 'Bíceps',
      secondaryMuscleGroups: 'Braquial, Braquiorradial',
      equipment: 'Halteres',
      isDefault: true,
    ),
    Exercise(
      name: 'Agachamento goblet',
      muscleGroup: 'Pernas',
      secondaryMuscleGroups: 'Quadríceps, Glúteo máximo',
      equipment: 'Halteres',
      isDefault: true,
    ),
    Exercise(
      name: 'Drill técnico de deslocamentos',
      muscleGroup: 'Karate',
      equipment: 'Peso corporal',
      isDefault: true,
    ),
    Exercise(
      name: 'Shrimp / fuga de anca',
      muscleGroup: 'Jiu-Jitsu',
      equipment: 'Tatami / espaço de artes marciais',
      isDefault: true,
    ),
  ];

  test('treino Passadeira mostra apenas exercícios de passadeira', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Ginásio',
      availableEquipmentKeys: {},
      workoutType: _type('Passadeira'),
    );

    expect(visible.map((item) => item.name), [
      'Passadeira caminhada',
      'Passadeira corrida intervalada',
    ]);
  });

  test('treino Cardio mostra vários exercícios de cardio', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Ginásio',
      availableEquipmentKeys: {},
      workoutType: _type('Cardio geral'),
    );

    expect(
      visible.map((item) => item.name),
      containsAll([
        'Passadeira caminhada',
        'Bicicleta',
        'Elíptica',
        'Corda de saltar',
      ]),
    );
  });

  test('treino Bicicleta mostra apenas bicicleta', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Ginásio',
      availableEquipmentKeys: {},
      workoutType: _type('Bicicleta'),
    );

    expect(visible.map((item) => item.name), ['Bicicleta']);
  });

  test('treino Pernas não mostra bíceps', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Ginásio',
      availableEquipmentKeys: {},
      workoutType: _type('Pernas'),
    );

    expect(visible.map((item) => item.name), contains('Agachamento goblet'));
    expect(
      visible.map((item) => item.name),
      isNot(contains('Curl com halteres')),
    );
  });

  test('treino Bíceps não mostra pernas', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Ginásio',
      availableEquipmentKeys: {},
      workoutType: _type('Bíceps'),
    );

    expect(visible.map((item) => item.name), contains('Curl com halteres'));
    expect(
      visible.map((item) => item.name),
      isNot(contains('Agachamento goblet')),
    );
  });

  test('Karate não mostra exercícios exclusivos de Jiu-Jitsu', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Dojo / Artes marciais',
      availableEquipmentKeys: {'bodyweight', 'tatami'},
      workoutType: _type('Karate'),
    );

    expect(
      visible.map((item) => item.name),
      contains('Drill técnico de deslocamentos'),
    );
    expect(
      visible.map((item) => item.name),
      isNot(contains('Shrimp / fuga de anca')),
    );
  });

  test('Jiu-Jitsu não mostra exercícios exclusivos de Karate', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Dojo / Artes marciais',
      availableEquipmentKeys: {'bodyweight', 'tatami'},
      workoutType: _type('Jiu-Jitsu'),
    );

    expect(visible.map((item) => item.name), contains('Shrimp / fuga de anca'));
    expect(
      visible.map((item) => item.name),
      isNot(contains('Drill técnico de deslocamentos')),
    );
  });

  test('mostrar todos ignora tipo e equipamento', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Casa',
      availableEquipmentKeys: {'bodyweight'},
      workoutType: _type('Passadeira'),
      showAllWithoutEquipment: true,
    );

    expect(visible.length, exercises.length);
  });

  test('ginásio respeita tipo de treino mesmo com todos os equipamentos', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Ginásio',
      availableEquipmentKeys: {},
      workoutType: _type('Passadeira'),
    );

    expect(
      visible.map((item) => item.name),
      isNot(contains('Curl com halteres')),
    );
  });
}

WorkoutType _type(String name) => WorkoutType(
  name: name,
  isDefault: true,
  createdAt: DateTime(2026, 6, 6),
  updatedAt: DateTime(2026, 6, 6),
);
