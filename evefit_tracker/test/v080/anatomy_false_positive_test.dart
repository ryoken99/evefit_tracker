import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('canonical arm keys override misleading visible names', () {
    final exercises = [
      _exercise(
        id: 1,
        name: 'Extensão com nome enganador',
        subgroup: 'anterior_arm',
        primary: 'biceps',
      ),
      _exercise(
        id: 2,
        name: 'Curl com nome enganador',
        subgroup: 'posterior_arm',
        primary: 'triceps_long',
      ),
    ];

    expect(_ids(exercises, 'biceps'), [1]);
    expect(_ids(exercises, 'triceps_long'), [2]);
  });

  test('canonical chest and back keys prevent branch leakage', () {
    final exercises = [
      _exercise(
        id: 10,
        name: 'Remada chamada supino',
        group: 'back',
        subgroup: 'back_width',
        primary: 'lats',
      ),
      _exercise(
        id: 20,
        name: 'Supino chamado remada',
        group: 'chest',
        subgroup: 'chest_primary',
        primary: 'upper_chest',
      ),
    ];

    expect(_ids(exercises, 'lats', group: 'back'), [10]);
    expect(_ids(exercises, 'upper_chest', group: 'chest'), [20]);
  });
}

List<int?> _ids(
  List<Exercise> exercises,
  String muscle, {
  String group = 'arms',
}) {
  return ExerciseFilterService.getAvailableExercises(
    exercises: exercises,
    trainingLocation: 'Ginásio',
    availableEquipmentKeys: const {'bodyweight'},
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: group,
      specificMuscleKey: muscle,
    ),
    showAllExercises: false,
  ).map((item) => item.exercise.id).toList();
}

Exercise _exercise({
  required int id,
  required String name,
  String group = 'arms',
  required String subgroup,
  required String primary,
}) {
  return Exercise(
    id: id,
    name: name,
    muscleGroup: 'Texto livre enganador',
    isDefault: true,
    equipment: 'Peso corporal',
    regionKeys: const {'upper'},
    groupKeys: {group},
    subgroupKeys: {subgroup},
    primaryMuscleKey: primary,
    equipmentKeys: const {'bodyweight'},
    movementPattern: 'isolation_control',
    difficulty: 'beginner',
    goalTags: {group, primary},
  );
}
