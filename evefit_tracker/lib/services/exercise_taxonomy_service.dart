import '../models/exercise.dart';
import '../models/exercise_taxonomy.dart';
import 'exercise_catalog_context_service.dart';
import 'training_architecture.dart';

class ExerciseTaxonomyService {
  const ExerciseTaxonomyService._();

  static ExerciseTaxonomy forCatalogEntry(ExerciseCatalogEntry entry) {
    final exercise = entry.toExercise();
    final architecture = TrainingArchitecture.tagsForExercise(exercise);
    final name = entry.exerciseKey;
    final context = entry.contextKey;
    final muscles = <String>{...architecture.muscleKeys};

    _addAnatomicalSpecificity(muscles: muscles, name: name, context: context);
    if (muscles.isEmpty) {
      muscles.add(switch (context) {
        'cardio' => 'cardiovascular',
        'mobilidade' => 'mobility',
        'karate' => 'karate_technical',
        'jiu_jitsu' => 'jiu_jitsu_technical',
        _ => context,
      });
    }

    final primary = _primaryMuscle(
      name: name,
      context: context,
      muscles: muscles,
    );
    final equipment = _canonicalEquipment(architecture.equipmentKeys, name);
    final movement = _movementPattern(name, context);
    final regions = architecture.regionKeys.isEmpty
        ? <String>{'custom'}
        : architecture.regionKeys;
    final groups = architecture.groupKeys.isEmpty
        ? <String>{'custom_workout'}
        : architecture.groupKeys;

    return ExerciseTaxonomy(
      regionKeys: regions,
      groupKeys: groups,
      subgroupKeys: architecture.subgroupKeys,
      primaryMuscleKey: primary,
      secondaryMuscleKeys: {...muscles}..remove(primary),
      equipmentKeys: equipment,
      movementPattern: movement,
      difficulty: _difficulty(name, context),
      forceType: _forceType(movement),
      laterality: _laterality(name),
      goalTags: {...regions, ...groups, primary, movement},
    );
  }

  static Exercise enrichCatalogExercise(ExerciseCatalogEntry entry) {
    final taxonomy = forCatalogEntry(entry);
    return entry.toExercise().copyWith(
      regionKeys: taxonomy.regionKeys,
      groupKeys: taxonomy.groupKeys,
      subgroupKeys: taxonomy.subgroupKeys,
      primaryMuscleKey: taxonomy.primaryMuscleKey,
      secondaryMuscleKeys: taxonomy.secondaryMuscleKeys,
      equipmentKeys: taxonomy.equipmentKeys,
      movementPattern: taxonomy.movementPattern,
      difficulty: taxonomy.difficulty,
      forceType: taxonomy.forceType,
      laterality: taxonomy.laterality,
      goalTags: taxonomy.goalTags,
    );
  }

  static void _addAnatomicalSpecificity({
    required Set<String> muscles,
    required String name,
    required String context,
  }) {
    bool hasAny(Iterable<String> keys) => keys.any(name.contains);

    if (context == 'peito') muscles.add('pectoralis_minor');
    if (context == 'costas') {
      muscles.add('teres_major');
      if (hasAny(['face_pull', 'remo', 'pull_up'])) muscles.add('teres_minor');
    }
    if (context == 'ombros' &&
        hasAny(['reverse_fly', 'face_pull', 'rotacao_externa'])) {
      muscles.add('teres_minor');
    }
    if (context == 'antebraco_pega') {
      muscles.add('general_grip');
      if (hasAny(['wrist_curl', 'finger_curls'])) {
        muscles.addAll({'forearm_flexors', 'wrist'});
      }
      if (hasAny(['reverse_wrist', 'extensao_de_dedos'])) {
        muscles.addAll({'forearm_extensors', 'wrist'});
      }
      if (name.contains('pronacao')) muscles.add('pronators');
      if (name.contains('supinacao')) muscles.add('supinators');
      if (hasAny(['finger', 'dedos', 'pinch', 'plate_hold'])) {
        muscles.add('fingers');
      }
      if (hasAny(['desvio_radial', 'desvio_ulnar', 'rotacao_controlada'])) {
        muscles.add('wrist');
      }
    }
    if (context == 'core') {
      if (hasAny(['crunch', 'toe_touches'])) muscles.add('upper_abs');
      if (hasAny(['prancha', 'dead_bug', 'bird_dog'])) muscles.add('mid_abs');
      if (hasAny(['reverse_crunch', 'elevacao_de_pernas', 'flutter_kicks'])) {
        muscles.add('lower_abs');
      }
      if (hasAny(['prancha_lateral', 'side_bend'])) {
        muscles.add('anti_lateral_flexion');
      }
      if (hasAny(['elevacao_de_pernas', 'elevacao_de_joelhos', 'mountain'])) {
        muscles.add('hip_flexors');
      }
    }
    if (context == 'pernas') {
      if (hasAny([
        'agachamento',
        'leg_press',
        'extensao_de_perna',
        'lunge',
        'step_up',
        'wall_sit',
      ])) {
        muscles.addAll({
          'rectus_femoris',
          'vastus_lateralis',
          'vastus_medialis',
          'vastus_intermedius',
        });
      }
      if (hasAny([
        'posterior',
        'peso_morto',
        'curl_de_perna',
        'good_morning',
      ])) {
        muscles.addAll({'biceps_femoris', 'semitendinosus', 'semimembranosus'});
      }
      if (hasAny(['aducao', 'adutor', 'agachamento_sumo'])) {
        muscles.add('adductors');
      }
      if (hasAny(['abducao', 'abdutor'])) {
        muscles.addAll({'abductors', 'glute_med', 'glute_min'});
      }
      if (hasAny(['elevacao_de_pernas', 'joelhos'])) muscles.add('hip_flexors');
      if (hasAny(['gemeos', 'soleo', 'tibial', 'saltos'])) {
        muscles.addAll({'ankle', 'feet'});
      }
    }
    if (context == 'cardio') {
      muscles.add('cardiovascular');
      if (hasAny(['high_knees', 'mountain'])) muscles.add('hip_flexors');
      if (hasAny(['corrida', 'caminhada', 'sprints', 'corda'])) {
        muscles.addAll({'ankle', 'feet'});
      }
    }
    if (context == 'mobilidade') {
      muscles.add('mobility');
      if (hasAny(['tornozelo', 'gemeos'])) muscles.add('ankle');
      if (hasAny(['pes', 'dedos'])) muscles.add('feet');
      if (name.contains('anca')) muscles.add('hip_flexors');
    }
    if (context == 'karate') muscles.add('karate_technical');
    if (context == 'jiu_jitsu') muscles.add('jiu_jitsu_technical');
  }

  static String _primaryMuscle({
    required String name,
    required String context,
    required Set<String> muscles,
  }) {
    const priorityByContext = <String, List<String>>{
      'pescoco': ['cervical_stabilizers'],
      'trapezio': ['upper_traps', 'mid_traps', 'lower_traps'],
      'peito': ['upper_chest', 'mid_chest', 'lower_chest'],
      'costas': ['lats', 'rhomboids'],
      'lombar': ['erectors', 'quadratus_lumborum'],
      'biceps': ['biceps', 'brachialis', 'brachioradialis'],
      'triceps': ['triceps_long', 'triceps_lateral', 'triceps_medial'],
      'antebraco_pega': [
        'forearm_flexors',
        'forearm_extensors',
        'general_grip',
      ],
      'core': ['anti_rotation', 'anti_extension', 'rectus_abdominis'],
      'pernas': ['glute_max', 'rectus_femoris', 'biceps_femoris', 'calves'],
      'cardio': ['cardiovascular'],
      'mobilidade': ['mobility'],
      'karate': ['karate_technical'],
      'jiu_jitsu': ['jiu_jitsu_technical'],
    };
    if (name.contains('lateral') && muscles.contains('deltoid_lateral')) {
      return 'deltoid_lateral';
    }
    if (name.contains('posterior') && muscles.contains('posterior_deltoid')) {
      return 'posterior_deltoid';
    }
    for (final key in priorityByContext[context] ?? const <String>[]) {
      if (muscles.contains(key)) return key;
    }
    return muscles.first;
  }

  static Set<String> _canonicalEquipment(Set<String> values, String name) {
    final result = <String>{...values};
    if (result.remove('gym_machines')) result.add('machine');
    if (result.remove('bench')) {
      if (name.contains('inclinado')) {
        result.add('incline_bench');
      } else if (name.contains('declinado')) {
        result.add('decline_bench');
      } else {
        result.add('flat_bench');
      }
    }
    if (result.isEmpty) {
      result.add('bodyweight');
    }
    return result;
  }

  static String _movementPattern(String name, String context) {
    if (context == 'cardio') return 'cardio_locomotion';
    if (context == 'mobilidade') return 'mobility_control';
    if (context == 'karate' || context == 'jiu_jitsu') return 'martial_drill';
    if (name.contains('puxada') ||
        name.contains('pull_up') ||
        name.contains('chin_up')) {
      return 'vertical_pull';
    }
    if (name.contains('remo')) return 'horizontal_pull';
    if (name.contains('supino') || name.contains('flexao')) {
      return 'horizontal_push';
    }
    if (name.contains('press') || name.contains('pike')) return 'vertical_push';
    if (name.contains('curl')) return 'elbow_flexion';
    if (context == 'triceps') return 'elbow_extension';
    if (name.contains('agachamento') || name.contains('leg_press')) {
      return 'squat';
    }
    if (name.contains('lunge') || name.contains('step_up')) return 'lunge';
    if (name.contains('peso_morto') || name.contains('good_morning')) {
      return 'hip_hinge';
    }
    if (context == 'core') return 'core_control';
    if (context == 'antebraco_pega') return 'grip_wrist_control';
    if (context == 'pescoco') return 'neck_control';
    return 'isolation_control';
  }

  static String _difficulty(String name, String context) {
    if (context == 'mobilidade' ||
        name.contains('leve') ||
        name.contains('apoiad')) {
      return 'beginner';
    }
    if (name.contains('sprint') ||
        name.contains('double_unders') ||
        name.contains('arqueiro')) {
      return 'advanced';
    }
    return 'intermediate';
  }

  static String _forceType(String movement) {
    if (movement.contains('push') || movement == 'elbow_extension') {
      return 'push';
    }
    if (movement.contains('pull') || movement == 'elbow_flexion') return 'pull';
    return 'stabilization';
  }

  static String _laterality(String name) {
    if (name.contains('unilateral') ||
        name.contains('alternado') ||
        name.contains('suitcase')) {
      return 'unilateral';
    }
    return 'bilateral';
  }
}
