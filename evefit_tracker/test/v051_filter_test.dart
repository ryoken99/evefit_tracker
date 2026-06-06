import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/models/workout_type.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final exercises = [
    Exercise(
      name: 'Curl com barra',
      muscleGroup: 'Bíceps',
      equipment: 'Barra, Discos',
      isDefault: true,
    ),
    Exercise(
      name: 'Flexões',
      muscleGroup: 'Peito',
      equipment: 'Peso corporal',
      isDefault: true,
    ),
    Exercise(
      name: 'Passadeira',
      muscleGroup: 'Cardio',
      equipment: 'Passadeira',
      isDefault: true,
    ),
  ];

  test('filtra exercícios por equipamento disponível fora do ginásio', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Casa',
      availableEquipmentKeys: {'bodyweight'},
      workoutType: null,
    );

    expect(visible.map((item) => item.name), ['Flexões']);
  });

  test('ginásio mostra todos os exercícios mesmo sem equipamento marcado', () {
    final visible = ExerciseFilterService.filter(
      exercises: exercises,
      trainingLocation: 'Ginásio',
      availableEquipmentKeys: {},
      workoutType: null,
    );

    expect(visible.length, exercises.length);
  });

  test(
    'filtra exercícios pelo tipo de treino quando existe grupo associado',
    () {
      final visible = ExerciseFilterService.filter(
        exercises: exercises,
        trainingLocation: 'Ginásio',
        availableEquipmentKeys: {},
        workoutType: WorkoutType(
          name: 'Cardio',
          description: 'Treino cardiovascular',
          muscleGroups: 'Cardio',
          isDefault: true,
          createdAt: DateTime(2026, 6, 6),
          updatedAt: DateTime(2026, 6, 6),
        ),
      );

      expect(visible.map((item) => item.name), ['Passadeira']);
    },
  );
}
