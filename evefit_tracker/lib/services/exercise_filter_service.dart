import '../models/exercise.dart';
import '../models/workout_type.dart';
import 'workout_taxonomy.dart';

class ExerciseFilterService {
  const ExerciseFilterService._();

  static const _equipmentAliases = {
    'bodyweight': ['peso corporal', 'nenhum equipamento'],
    'barbell': ['barra'],
    'plates': ['discos'],
    'dumbbells': ['halteres', 'halter'],
    'bench': ['banco'],
    'machine': ['máquina', 'maquina', 'multifunções'],
    'high_cable': ['cabo alto', 'cabo', 'corda no cabo'],
    'low_cable': ['cabo baixo', 'gancho de baixo', 'cabo'],
    'pullup_bar': ['barra fixa', 'chin-up'],
    'bands': ['elásticos', 'elasticos'],
    'kettlebell': ['kettlebell'],
    'treadmill': ['passadeira'],
    'bike': ['bicicleta'],
    'elliptical': ['elíptica', 'eliptica'],
    'jump_rope': ['corda de saltar', 'corda'],
    'heavy_bag': ['saco de pancada'],
    'tatami': ['tatami', 'dojo', 'jiu-jitsu', 'karate'],
    'none': ['nenhum equipamento'],
  };

  static List<Exercise> filter({
    required List<Exercise> exercises,
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
    required WorkoutType? workoutType,
    bool showAllWithoutEquipment = false,
  }) {
    if (showAllWithoutEquipment) return exercises;
    return exercises.where((exercise) {
      if (!_matchesWorkoutType(exercise, workoutType)) return false;
      return _matchesEquipment(
        exercise,
        trainingLocation,
        availableEquipmentKeys,
      );
    }).toList();
  }

  static List<String> contextualGroups({
    required List<Exercise> exercises,
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
    required WorkoutType? workoutType,
    required bool showAll,
  }) {
    final visible = filter(
      exercises: exercises,
      trainingLocation: trainingLocation,
      availableEquipmentKeys: availableEquipmentKeys,
      workoutType: workoutType,
      showAllWithoutEquipment: showAll,
    );
    final groups = visible.map((item) => item.muscleGroup).toSet().toList()
      ..sort();
    return ['Todos', ...groups];
  }

  static bool _matchesWorkoutType(Exercise exercise, WorkoutType? workoutType) {
    if (workoutType == null) return true;
    if (WorkoutTaxonomy.groupsFor(workoutType.name).isEmpty &&
        workoutType.muscleGroups.trim().isNotEmpty) {
      final haystack = WorkoutTaxonomy.normalize(
        '${exercise.name} ${exercise.muscleGroup} '
        '${exercise.secondaryMuscleGroups} ${exercise.equipment}',
      );
      return workoutType.muscleGroups
          .split(',')
          .map((item) => WorkoutTaxonomy.normalize(item))
          .where((item) => item.isNotEmpty)
          .any(haystack.contains);
    }
    return WorkoutTaxonomy.allowsExercise(
      workoutType: workoutType.name,
      exerciseName: exercise.name,
      primaryGroup: exercise.muscleGroup,
      secondaryGroups: exercise.secondaryMuscleGroups,
      equipment: exercise.equipment,
    );
  }

  static bool _matchesEquipment(
    Exercise exercise,
    String trainingLocation,
    Set<String> availableEquipmentKeys,
  ) {
    final location = WorkoutTaxonomy.normalize(trainingLocation);
    if (location.contains('ginasio')) return true;

    if (location.contains('exterior') &&
        _containsAny(exercise, [
          'peso corporal',
          'caminhada exterior',
          'corrida exterior',
          'sprints exterior',
          'hiit',
          'mobilidade',
          'alongamento',
        ])) {
      return true;
    }

    if ((location.contains('dojo') || location.contains('marciais')) &&
        _containsAny(exercise, [
          'peso corporal',
          'tatami',
          'karate',
          'jiu-jitsu',
          'jiu jitsu',
          'grappling',
          'mobilidade',
          'core',
          'abdominal',
        ])) {
      return true;
    }

    if (availableEquipmentKeys.isEmpty) {
      return _containsAny(exercise, ['peso corporal', 'nenhum equipamento']);
    }
    for (final key in availableEquipmentKeys) {
      final aliases = _equipmentAliases[key] ?? [key];
      if (_containsAny(exercise, aliases)) return true;
    }
    return false;
  }

  static bool _containsAny(Exercise exercise, List<String> values) {
    final haystack = WorkoutTaxonomy.normalize(
      '${exercise.name} ${exercise.muscleGroup} '
      '${exercise.secondaryMuscleGroups} ${exercise.equipment}',
    );
    return values.any(
      (value) => haystack.contains(WorkoutTaxonomy.normalize(value)),
    );
  }
}
