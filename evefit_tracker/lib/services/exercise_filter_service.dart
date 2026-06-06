import '../models/exercise.dart';
import '../models/workout_type.dart';

class ExerciseFilterService {
  const ExerciseFilterService._();

  static const _equipmentAliases = {
    'bodyweight': ['peso corporal', 'nenhum equipamento'],
    'barbell': ['barra'],
    'plates': ['discos'],
    'dumbbells': ['halteres', 'halter'],
    'bench': ['banco'],
    'machine': ['máquina', 'maquina', 'multifunções'],
    'high_cable': ['cabo alto'],
    'low_cable': ['cabo baixo', 'gancho de baixo'],
    'pullup_bar': ['barra fixa'],
    'bands': ['elásticos', 'elasticos'],
    'kettlebell': ['kettlebell'],
    'treadmill': ['passadeira'],
    'bike': ['bicicleta'],
    'elliptical': ['elíptica', 'eliptica'],
    'jump_rope': ['corda'],
    'heavy_bag': ['saco de pancada'],
    'tatami': ['tatami', 'dojo'],
  };

  static List<Exercise> filter({
    required List<Exercise> exercises,
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
    required WorkoutType? workoutType,
    bool showAllWithoutEquipment = false,
  }) {
    return exercises.where((exercise) {
      if (!showAllWithoutEquipment &&
          !_matchesEquipment(
            exercise,
            trainingLocation,
            availableEquipmentKeys,
          )) {
        return false;
      }
      return _matchesWorkoutType(exercise, workoutType);
    }).toList();
  }

  static bool _matchesEquipment(
    Exercise exercise,
    String trainingLocation,
    Set<String> availableEquipmentKeys,
  ) {
    final location = trainingLocation.toLowerCase();
    if (location.contains('ginásio') || location.contains('ginasio')) {
      return true;
    }
    if (location.contains('exterior')) {
      return _containsAny(exercise, ['peso corporal', 'passadeira', 'cardio']);
    }
    if (location.contains('dojo') || location.contains('marciais')) {
      return _containsAny(exercise, [
        'peso corporal',
        'tatami',
        'karate',
        'jiu-jitsu',
        'mobilidade',
      ]);
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

  static bool _matchesWorkoutType(Exercise exercise, WorkoutType? workoutType) {
    if (workoutType == null) return true;
    final groups = workoutType.muscleGroups
        .split(',')
        .map((item) => item.trim().toLowerCase())
        .where((item) => item.isNotEmpty)
        .toList();
    final typeName = workoutType.name.toLowerCase();
    if (groups.isEmpty) {
      groups.addAll(_groupsForTypeName(typeName));
    }
    if (groups.isEmpty) return true;
    final haystack =
        '${exercise.name} ${exercise.muscleGroup} ${exercise.secondaryMuscleGroups}'
            .toLowerCase();
    return groups.any(haystack.contains);
  }

  static List<String> _groupsForTypeName(String typeName) {
    if (typeName.contains('cardio') || typeName.contains('passadeira')) {
      return ['cardio', 'passadeira'];
    }
    if (typeName.contains('perna') || typeName.contains('legs')) {
      return ['pernas', 'glúteo', 'quadríceps', 'posterior', 'gémeos'];
    }
    if (typeName.contains('bíceps') || typeName.contains('bicep')) {
      return ['bíceps', 'braquial', 'braquiorradial'];
    }
    if (typeName.contains('tríceps') || typeName.contains('tricep')) {
      return ['tríceps'];
    }
    if (typeName.contains('core') || typeName.contains('abdominal')) {
      return ['core', 'abdominal', 'oblíquo', 'lombar'];
    }
    if (typeName.contains('push')) return ['peito', 'ombros', 'tríceps'];
    if (typeName.contains('pull')) return ['costas', 'bíceps', 'antebraço'];
    if (typeName.contains('ombro')) return ['ombros', 'deltoide'];
    if (typeName.contains('peito')) return ['peito'];
    if (typeName.contains('costas')) return ['costas', 'dorsal'];
    return [];
  }

  static bool _containsAny(Exercise exercise, List<String> values) {
    final haystack =
        '${exercise.name} ${exercise.muscleGroup} ${exercise.secondaryMuscleGroups} ${exercise.equipment}'
            .toLowerCase();
    return values.any((value) => haystack.contains(value.toLowerCase()));
  }
}
