import '../models/exercise.dart';
import '../models/workout_type.dart';
import 'training_architecture.dart';
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
    if (workoutType != null &&
        TrainingArchitecture.legacySelectionFor(workoutType.name).regionKey ==
            'custom' &&
        workoutType.muscleGroups.trim().isNotEmpty) {
      return exercises.where((exercise) {
        if (!_matchesWorkoutType(exercise, workoutType)) return false;
        return _matchesEquipment(
          exercise,
          trainingLocation,
          availableEquipmentKeys,
        );
      }).toList();
    }
    final selection = _selectionForWorkoutType(workoutType);
    return getAvailableExercises(
      exercises: exercises,
      trainingLocation: trainingLocation,
      availableEquipmentKeys: availableEquipmentKeys,
      selection: selection,
      showAllExercises: showAllWithoutEquipment,
    ).map((item) => item.exercise).toList();
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

  static List<ExerciseAvailability> getAvailableExercises({
    required List<Exercise> exercises,
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
    required TrainingSelection selection,
    required bool showAllExercises,
  }) {
    final availability = exercises.map((exercise) {
      final matchesSelection = TrainingArchitecture.matchesSelection(
        exercise,
        selection,
      );
      final matchesEquipment = _matchesEquipment(
        exercise,
        trainingLocation,
        availableEquipmentKeys,
      );
      final isAvailable = matchesSelection && matchesEquipment;
      return ExerciseAvailability(
        exercise: exercise,
        isAvailable: isAvailable,
        unavailableReason: isAvailable
            ? ''
            : !matchesSelection
            ? 'Indisponível pelo filtro anatómico selecionado.'
            : 'Indisponível com o teu equipamento/local atual.',
      );
    }).toList();
    if (showAllExercises) return availability;
    return availability.where((item) => item.isAvailable).toList();
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

  static TrainingSelection _selectionForWorkoutType(WorkoutType? workoutType) {
    if (workoutType == null) return const TrainingSelection();
    final selection = TrainingArchitecture.legacySelectionFor(workoutType.name);
    if (selection.regionKey != 'custom' || workoutType.muscleGroups.isEmpty) {
      return selection;
    }
    return const TrainingSelection();
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
    final effectiveEquipmentKeys = {
      'bodyweight',
      'none',
      ...availableEquipmentKeys,
    };
    final exerciseEquipment = TrainingArchitecture.tagsForExercise(
      exercise,
    ).equipmentKeys;
    if (exerciseEquipment.any(effectiveEquipmentKeys.contains)) return true;
    for (final key in effectiveEquipmentKeys) {
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
