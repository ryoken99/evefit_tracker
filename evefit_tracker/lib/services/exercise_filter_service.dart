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
    'chair_support': ['banco', 'cadeira', 'apoio'],
    'weighted_backpack': ['mochila'],
    'water_bottles': ['garrafas de água', 'garrafas de agua'],
    'water_jug': ['garrafão', 'garrafao'],
    'stable_step': ['degrau', 'escada estável', 'escada estavel'],
    'sturdy_table': ['mesa resistente'],
    'broomstick': ['cabo de vassoura'],
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

  static List<String> contextualFiltersForSelection({
    required List<Exercise> exercises,
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
    required TrainingSelection selection,
    required bool showAll,
  }) {
    final effectiveSelection = selection.regionKey == 'core'
        ? selection.copyWith(groupKey: '')
        : selection;
    final visible = getAvailableExercises(
      exercises: exercises,
      trainingLocation: trainingLocation,
      availableEquipmentKeys: availableEquipmentKeys,
      selection: effectiveSelection,
      showAllExercises: showAll,
    ).map((item) => item.exercise).toList();

    if (!showAll && selection.regionKey == 'core') {
      return _orderedContextualFilters(visible, const {
        'Reto abdominal': ['reto abdominal', 'crunch', 'toe touches'],
        'Oblíquos': ['obliquos', 'oblíquos', 'russian twist', 'lateral'],
        'Transverso abdominal': ['transverso', 'vacuum'],
        'Anti-rotação': ['anti-rotacao', 'anti-rotação', 'pallof'],
        'Anti-extensão': [
          'anti-extensao',
          'anti-extensão',
          'hollow',
          'prancha',
        ],
        'Lombar': ['lombar', 'hiperextensao', 'hiperextensão'],
        'Estabilidade do core': ['estabilidade', 'dead bug', 'bird dog'],
      });
    }

    if (!showAll && selection.subgroupKey == 'treadmill') {
      return _orderedContextualFilters(visible, const {
        'Aquecimento': ['aquecimento'],
        'Caminhada': ['caminhada'],
        'Corrida leve': ['corrida leve'],
        'Intervalos': ['interval', 'sprint'],
        'Inclinação': ['inclinacao', 'inclinação'],
        'Cooldown': ['cooldown', 'arrefecimento'],
      });
    }

    if (!showAll && selection.specificMuscleKey == 'biceps') {
      return _orderedContextualFilters(visible, const {
        'Bíceps': ['biceps', 'bíceps'],
        'Braquial': ['braquial'],
        'Braquiorradial': ['braquiorradial'],
        'Antebraço relacionado': ['antebraco', 'antebraço', 'pega'],
      });
    }

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
      final matchesSelection =
          TrainingArchitecture.matchesSelection(
            exercise,
            _baseSelectionForHierarchy(selection),
          ) &&
          _matchesHierarchyFocus(exercise, selection);
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

  static TrainingSelection _baseSelectionForHierarchy(
    TrainingSelection selection,
  ) {
    if (selection.regionKey == 'core') {
      return TrainingSelection(
        regionKey: selection.regionKey,
        equipmentKey: selection.equipmentKey,
      );
    }
    if (!_hierarchyFocusKeywords.containsKey(selection.subgroupKey) &&
        !_hierarchyFocusKeywords.containsKey(selection.specificMuscleKey)) {
      return selection;
    }
    return TrainingSelection(
      regionKey: selection.regionKey,
      groupKey: selection.groupKey,
      equipmentKey: selection.equipmentKey,
    );
  }

  static bool _matchesHierarchyFocus(
    Exercise exercise,
    TrainingSelection selection,
  ) {
    final focus = selection.specificMuscleKey.isNotEmpty
        ? selection.specificMuscleKey
        : selection.subgroupKey;
    if (focus.isEmpty) return true;
    final keywords = _hierarchyFocusKeywords[focus];
    if (keywords == null || keywords.isEmpty) return true;
    if (_primaryOnlyHierarchyFocuses.contains(focus)) {
      return _containsAnyPrimary(exercise, keywords);
    }
    return _containsAny(exercise, keywords);
  }

  static const _primaryOnlyHierarchyFocuses = {
    'hamstrings_complete',
    'glutes_complete',
  };

  static const _hierarchyFocusKeywords = {
    'arms_complete': <String>[],
    'chest_complete': <String>[],
    'back_complete': <String>[],
    'shoulders_complete': <String>[],
    'traps_complete': <String>[],
    'neck_complete': <String>[],
    'core_complete': <String>[],
    'legs_complete': <String>[],
    'forearm_complete': [
      'antebraco',
      'antebraÃ§o',
      'wrist',
      'farmer',
      'suitcase',
      'hold estatico',
      'hold estático',
      'dead hang',
      'aperto',
      'pronacao',
      'pronaÃ§Ã£o',
      'supinacao',
      'supinaÃ§Ã£o',
      'desvio radial',
      'desvio ulnar',
      'rotacao controlada',
      'rotação controlada',
      'finger curls',
      'pega',
      'punho',
      'pinch',
      'plate hold',
      'towel',
    ],
    'abs_complete': [
      'abdominal',
      'crunch',
      'prancha',
      'russian twist',
      'bicycle crunch',
      'reverse crunch',
      'elevaÃ§Ã£o de pernas',
      'elevacao de pernas',
      'vacuum',
      'flutter',
      'toe touches',
    ],
    'biceps_brachii': ['bíceps', 'biceps', 'curl', 'chin-up'],
    'biceps': ['bíceps', 'biceps', 'curl', 'chin-up'],
    'brachialis': ['braquial', 'martelo'],
    'brachioradialis': ['braquiorradial', 'martelo', 'inverso'],
    'coracobrachialis': ['coracobraquial'],
    'triceps': [
      'tríceps',
      'triceps',
      'flexões fechadas',
      'flexao fechada',
      'flexão fechada',
      'flexões diamante',
      'flexao diamante',
      'flexão diamante',
      'fundos',
      'tate press',
      'press fechado',
    ],
    'triceps_long': ['tríceps', 'triceps', 'acima da cabeça', 'francesa'],
    'triceps_lateral': ['tríceps', 'triceps', 'corda', 'cabo'],
    'triceps_medial': ['tríceps', 'triceps', 'fechadas', 'press fechado'],
    'forearm_flexors': ['wrist curl', 'flexores', 'finger curls'],
    'forearm_extensors': ['reverse wrist', 'extensores', 'extensão de dedos'],
    'pronators': ['pronação', 'pronacao', 'pronadores'],
    'supinators': ['supinação', 'supinacao', 'supinadores'],
    'wrist': ['punho', 'wrist', 'desvio radial', 'desvio ulnar'],
    'fingers': ['dedos', 'finger'],
    'support_grip': ['farmer', 'dead hang', 'suporte'],
    'pinch_grip': ['pinça', 'pinca', 'pinch', 'plate hold'],
    'general_grip': ['pega', 'grip', 'dead hang', 'farmer'],
    'treadmill_aerobic': [
      'passadeira caminhada',
      'caminhada rápida',
      'caminhada rapida',
      'corrida leve',
      'inclinação',
      'inclinacao',
      'aquecimento',
      'cooldown',
      'arrefecimento',
    ],
    'treadmill_intervals': [
      'corrida intervalada',
      'sprints',
      'sprint',
      'hiit passadeira',
      'intervalados',
      'intervalada',
    ],
    'kihon': ['kihon'],
    'kata': ['kata'],
    'kumite_technical': ['kumite'],
    'karate_shadow': ['sombra de karate'],
    'karate_footwork': ['deslocamento', 'deslocamentos'],
    'karate_guard': ['guarda'],
    'karate_punches': ['socos', 'soco'],
    'karate_kicks': ['pontapés', 'pontapes', 'pontapé', 'pontape'],
    'karate_mobility': ['mobilidade', 'anca', 'ombro'],
    'karate_conditioning': ['condicionamento'],
    'shrimp': ['shrimp', 'fuga de anca'],
    'grappling_bridge': ['ponte de grappling'],
    'technical_stand_up': ['technical stand-up'],
    'jiu_jitsu_guard': ['guarda'],
    'guard_passing': ['passagem de guarda'],
    'jiu_jitsu_grip': ['força de pega', 'forca de pega', 'grip'],
    'jiu_jitsu_core': ['core'],
    'jiu_jitsu_mobility': ['mobilidade'],
    'jiu_jitsu_conditioning': ['condicionamento'],
    'light_stretching': [
      'alongamento',
      'mobilidade leve',
      'respiração diafragmática',
      'respiracao diafragmatica',
    ],
    'upper_chest': ['inclinado', 'declinadas', 'declinada', 'superior'],
    'mid_chest': [
      'supino',
      'flexões',
      'flexao',
      'flexão',
      'aberturas',
      'chest press',
    ],
    'lower_chest': [
      'declinado',
      'declinada',
      'dips',
      'inferior',
      'flexões inclinadas',
      'flexao inclinada',
      'flexão inclinada',
    ],
    'serratus_anterior': ['serrátil', 'serratil', 'scapular', 'wall slide'],
    'back_upper': [
      'trapézio',
      'trapezio',
      'romboides',
      'face pull',
      'escapular',
    ],
    'back_mid': ['romboides', 'remo', 'redondo', 'dorsal'],
    'back_lower': ['lombar', 'eretores', 'hiperextensão', 'hiperextensao'],
    'back_width': ['puxada', 'dorsal', 'latíssimo', 'latissimo'],
    'back_thickness': ['remo', 'romboides', 'trapézio médio', 'trapezio medio'],
    'lower_abs': [
      'reverse crunch',
      'elevação de pernas',
      'elevacao de pernas',
      'inferior',
    ],
    'lateral_abs': [
      'prancha lateral',
      'russian twist',
      'bicycle crunch',
      'oblíquos',
      'obliquos',
    ],
    'upper_abs': ['crunch', 'superior'],
    'mid_abs': ['crunch', 'abdominal médio', 'abdominal medio'],
    'rectus_abdominis': ['reto abdominal', 'crunch'],
    'external_obliques': ['oblíquos', 'obliquos', 'russian twist'],
    'internal_obliques': ['oblíquos', 'obliquos', 'bicycle crunch'],
    'transverse_abdominis': ['transverso', 'vacuum'],
    'anti_rotation': ['anti-rotação', 'anti-rotacao', 'pallof'],
    'anti_extension': ['anti-extensão', 'anti-extensao', 'prancha', 'hollow'],
    'anti_lateral_flexion': [
      'anti-flexão lateral',
      'anti-flexao lateral',
      'side bend',
    ],
    'deep_stability': ['estabilidade', 'dead bug', 'bird dog'],
    'quadriceps_complete': [
      'quadríceps',
      'quadriceps',
      'agachamento',
      'leg press',
      'wall sit',
      'step-up',
      'lunges',
      'cadeira',
      'mochila',
      'garrafao',
      'garrafão',
      'sumo',
      'smith',
    ],
    'hamstrings_complete': [
      'posterior',
      'romeno',
      'curl de perna',
      'good morning',
    ],
    'glutes_complete': ['glúteo', 'gluteo', 'hip thrust', 'ponte'],
    'thigh_complete': [
      'quadrÃ­ceps',
      'quadriceps',
      'agachamento',
      'leg press',
      'cadeira',
      'mochila',
      'garrafao',
      'garrafão',
      'sumo',
      'smith',
      'posterior',
      'romeno',
      'curl de perna',
      'glÃºteo',
      'gluteo',
      'hip thrust',
      'ponte',
      'adutor',
      'abdutor',
      'lunges',
      'step-up',
    ],
    'adductors': ['adutor', 'adutores'],
    'abductors': ['abdutor', 'abdutores', 'abdução', 'abducao'],
    'calves': ['gémeos', 'gemeos', 'calf'],
    'soleus': ['sóleo', 'soleo'],
    'tibialis_anterior': ['tibial anterior'],
    'lower_leg_complete': [
      'gÃ©meos',
      'gemeos',
      'sÃ³leo',
      'soleo',
      'tibial anterior',
      'tornozelo',
      'saltos',
    ],
    'ankle': ['tornozelo'],
    'ankle_stability': ['tornozelo', 'estabilidade'],
  };

  static bool _containsAny(Exercise exercise, List<String> values) {
    final haystack = WorkoutTaxonomy.normalize(
      '${exercise.name} ${exercise.muscleGroup} '
      '${exercise.secondaryMuscleGroups} ${exercise.equipment}',
    );
    return values.any(
      (value) => haystack.contains(WorkoutTaxonomy.normalize(value)),
    );
  }

  static bool _containsAnyPrimary(Exercise exercise, List<String> values) {
    final haystack = WorkoutTaxonomy.normalize(
      '${exercise.name} ${exercise.muscleGroup} ${exercise.equipment}',
    );
    return values.any(
      (value) => haystack.contains(WorkoutTaxonomy.normalize(value)),
    );
  }

  static List<String> _orderedContextualFilters(
    List<Exercise> exercises,
    Map<String, List<String>> rules,
  ) {
    final labels = <String>['Todos'];
    for (final entry in rules.entries) {
      if (exercises.any((exercise) => _containsAny(exercise, entry.value))) {
        labels.add(entry.key);
      }
    }
    return labels;
  }
}
