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
      return _containsAny(exercise, [
        'peso corporal',
        'passadeira',
        'caminhada',
        'corrida',
        'cardio',
        'mobilidade',
      ]);
    }
    if (location.contains('dojo') || location.contains('marciais')) {
      return _containsAny(exercise, [
        'peso corporal',
        'tatami',
        'karate',
        'jiu-jitsu',
        'mobilidade',
        'core',
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
    final typeName = workoutType.name.toLowerCase();
    final specific = _specificMatchers(typeName);
    if (specific.isNotEmpty) return _containsAny(exercise, specific);

    final groups = workoutType.muscleGroups
        .split(',')
        .map((item) => item.trim().toLowerCase())
        .where((item) => item.isNotEmpty)
        .toList();
    if (groups.isEmpty) groups.addAll(_groupsForTypeName(typeName));
    if (groups.isEmpty) return true;
    return _containsAny(exercise, groups);
  }

  static List<String> _specificMatchers(String typeName) {
    if (typeName.contains('passadeira')) return ['passadeira'];
    if (typeName.contains('bicicleta')) return ['bicicleta'];
    if (typeName.contains('elíptica') || typeName.contains('eliptica')) {
      return ['elíptica', 'eliptica'];
    }
    if (typeName.contains('corda')) return ['corda de saltar'];
    if (typeName.contains('corrida exterior')) return ['corrida exterior'];
    if (typeName.contains('caminhada exterior')) return ['caminhada exterior'];
    if (typeName.contains('karate')) {
      return ['karate', 'kihon', 'kata', 'kumite', 'sombra de karate'];
    }
    if (typeName.contains('jiu-jitsu') || typeName.contains('jiu jitsu')) {
      return [
        'jiu-jitsu',
        'shrimp',
        'grappling',
        'guarda',
        'technical stand-up',
      ];
    }
    return [];
  }

  static List<String> _groupsForTypeName(String typeName) {
    if (typeName.contains('cardio') || typeName.contains('hiit')) {
      return [
        'cardio',
        'passadeira',
        'bicicleta',
        'elíptica',
        'eliptica',
        'corda',
        'caminhada',
        'corrida',
      ];
    }
    if (typeName.contains('perna') || typeName.contains('legs')) {
      return [
        'pernas',
        'glúteo',
        'gluteo',
        'quadríceps',
        'quadriceps',
        'posterior',
        'adutores',
        'abdutores',
        'gémeos',
        'gemeos',
        'tibial',
      ];
    }
    if (typeName.contains('bíceps') || typeName.contains('bicep')) {
      return ['bíceps', 'bicep', 'braquial', 'braquiorradial', 'curl'];
    }
    if (typeName.contains('tríceps') || typeName.contains('tricep')) {
      return ['tríceps', 'tricep'];
    }
    if (typeName.contains('core') || typeName.contains('abdominal')) {
      return ['core', 'abdominal', 'oblíquo', 'obliquo', 'lombar', 'prancha'];
    }
    if (typeName.contains('push')) {
      return ['peito', 'ombros', 'tríceps', 'tricep'];
    }
    if (typeName.contains('pull')) {
      return ['costas', 'bíceps', 'bicep', 'antebraço'];
    }
    if (typeName.contains('ombro')) return ['ombros', 'deltoide'];
    if (typeName.contains('peito')) return ['peito'];
    if (typeName.contains('costas')) {
      return ['costas', 'dorsal', 'remo', 'puxada'];
    }
    return [];
  }

  static bool _containsAny(Exercise exercise, List<String> values) {
    final haystack =
        '${exercise.name} ${exercise.muscleGroup} ${exercise.secondaryMuscleGroups} ${exercise.equipment}'
            .toLowerCase();
    return values.any((value) => haystack.contains(value.toLowerCase()));
  }
}
