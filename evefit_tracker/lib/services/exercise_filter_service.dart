import '../models/exercise.dart';
import '../models/workout_type.dart';
import 'training_architecture.dart';
import 'exercise_capability_service.dart';
import 'workout_taxonomy.dart';

class ExerciseFilterService {
  const ExerciseFilterService._();

  static final Map<String, List<ExerciseAvailability>> _availabilityCache = {};

  static const emptyStateMessage =
      'Não há exercícios disponíveis para este foco com as capacidades atuais. '
      'Ativa Mostrar todos para ver o equipamento/local em falta.';

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

    if (!showAll && selection.subgroupKey == 'arms_complete') {
      return _orderedContextualPredicateFilters(visible, {
        'Bíceps': (exercise) => _isBicepsDominantExercise(exercise),
        'Braquial': (exercise) => _isBrachialisExercise(exercise),
        'Braquiorradial': (exercise) => _isBrachioradialisExercise(exercise),
        'Tríceps': (exercise) => _isTricepsExercise(exercise),
        'Flexores do antebraço': (exercise) =>
            _isForearmHandExercise(exercise, 'forearm_flexors'),
        'Extensores do antebraço': (exercise) =>
            _isForearmHandExercise(exercise, 'forearm_extensors'),
        'Pronadores': (exercise) =>
            _isForearmHandExercise(exercise, 'pronators'),
        'Supinadores': (exercise) =>
            _isForearmHandExercise(exercise, 'supinators'),
        'Punho': (exercise) => _isForearmHandExercise(exercise, 'wrist'),
        'Mão e dedos': (exercise) =>
            _isForearmHandExercise(exercise, 'fingers'),
        'Força de pega': (exercise) =>
            _isForearmHandExercise(exercise, 'general_grip'),
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

  static bool matchesSearchQuery(Exercise exercise, String query) {
    final normalizedQuery = _searchNormalize(query);
    if (normalizedQuery.isEmpty) return true;
    final equipmentLabels = exercise.equipmentKeys
        .map(TrainingArchitecture.equipmentNameFor)
        .join(' ');
    final haystack = _searchNormalize(
      '${exercise.name} ${exercise.canonicalId} ${exercise.aliases.join(' ')} '
      '${exercise.exerciseKey} ${exercise.catalogEntryKey} '
      '${exercise.muscleGroup} ${exercise.secondaryMuscleGroups} '
      '${exercise.primaryMuscleNodes ?? ''} ${exercise.secondaryMuscleNodes ?? ''} '
      '${exercise.primaryMuscleKey} ${exercise.secondaryMuscleKeys.join(' ')} '
      '${exercise.equipment} ${exercise.equipmentKeys.join(' ')} $equipmentLabels '
      '${exercise.regionKeys.join(' ')} ${exercise.groupKeys.join(' ')} '
      '${exercise.subgroupKeys.join(' ')} ${exercise.primaryType} '
      '${exercise.secondaryTypes.join(' ')}',
    );
    return haystack.contains(normalizedQuery);
  }

  static List<ExerciseAvailability> getAvailableExercises({
    required List<Exercise> exercises,
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
    required TrainingSelection selection,
    required bool showAllExercises,
  }) {
    final cacheKey = _availabilityCacheKey(
      exercises: exercises,
      trainingLocation: trainingLocation,
      availableEquipmentKeys: availableEquipmentKeys,
      selection: selection,
      showAllExercises: showAllExercises,
    );
    final cached = _availabilityCache[cacheKey];
    if (cached != null) return List.of(cached, growable: false);

    final availability = exercises.map((exercise) {
      final matchesPreparation = _matchesPreparationSelection(
        exercise,
        selection,
      );
      final matchesSelection =
          (matchesPreparation ||
              (TrainingArchitecture.matchesSelection(
                    exercise,
                    _baseSelectionForHierarchy(
                      selection,
                    ).copyWith(equipmentKey: ''),
                  ) &&
                  _matchesHierarchyFocus(exercise, selection))) &&
          _matchesVisibilityRules(exercise, selection);
      final matchesEquipment = _matchesEquipment(
        exercise,
        trainingLocation,
        availableEquipmentKeys,
        selectedEquipmentKey: selection.equipmentKey,
      );
      final isAvailable = matchesSelection && matchesEquipment;
      final equipmentReason = matchesSelection && !matchesEquipment
          ? _equipmentUnavailableReason(
              exercise: exercise,
              trainingLocation: trainingLocation,
              availableEquipmentKeys: availableEquipmentKeys,
            )
          : '';
      return ExerciseAvailability(
        exercise: exercise,
        isAvailable: isAvailable,
        unavailableReason: isAvailable
            ? ''
            : !matchesSelection
            ? 'Indisponível pelo filtro anatómico selecionado.'
            : equipmentReason,
      );
    }).toList();
    final result = showAllExercises
        ? availability
        : availability.where((item) => item.isAvailable).toList();
    if (_availabilityCache.length > 80) _availabilityCache.clear();
    _availabilityCache[cacheKey] = List.unmodifiable(result);
    return List.of(result, growable: false);
  }

  static String _availabilityCacheKey({
    required List<Exercise> exercises,
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
    required TrainingSelection selection,
    required bool showAllExercises,
  }) {
    final equipment = availableEquipmentKeys.toList()..sort();
    return [
      _exerciseListSignature(exercises),
      exercises.length,
      trainingLocation,
      equipment.join(','),
      selection.regionKey,
      selection.groupKey,
      selection.subgroupKey,
      selection.specificMuscleKey,
      selection.equipmentKey,
      showAllExercises,
    ].join('|');
  }

  static String _exerciseListSignature(List<Exercise> exercises) =>
      exercises.map(_exerciseSignature).join('>');

  static String _exerciseSignature(Exercise exercise) => [
    exercise.id ?? '',
    exercise.catalogEntryKey,
    exercise.exerciseKey,
    exercise.contextKey,
    exercise.name,
    exercise.primaryType,
    exercise.primaryMuscleKey,
    exercise.equipmentKeys.join(','),
    exercise.updatedAt?.toIso8601String() ?? '',
  ].join(':');

  static String _equipmentUnavailableReason({
    required Exercise exercise,
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
  }) {
    final missing = ExerciseCapabilityService.missingCapabilityNames(
      exercise: exercise,
      trainingLocation: trainingLocation,
      availableEquipmentKeys: availableEquipmentKeys,
    );
    if (missing.isEmpty) {
      return 'Indisponível com o teu equipamento/local atual.';
    }
    return 'Indisponível: requer ${missing.join(' e ')}.';
  }

  static bool _matchesWorkoutType(Exercise exercise, WorkoutType? workoutType) {
    if (workoutType == null) return true;
    if (WorkoutTaxonomy.groupsFor(workoutType.name).isEmpty &&
        workoutType.muscleGroups.trim().isNotEmpty) {
      final haystack = WorkoutTaxonomy.normalize(
        '${exercise.name} ${exercise.muscleGroup} '
        '${exercise.primaryMuscleNodes ?? ''} '
        '${exercise.secondaryMuscleNodes ?? ''} '
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
    Set<String> availableEquipmentKeys, {
    String selectedEquipmentKey = '',
  }) {
    return ExerciseCapabilityService.isAvailable(
      exercise: exercise,
      trainingLocation: trainingLocation,
      availableEquipmentKeys: availableEquipmentKeys,
      selectedEquipmentKey: selectedEquipmentKey,
    );
  }

  static bool _matchesVisibilityRules(
    Exercise exercise,
    TrainingSelection selection,
  ) {
    final domain = _domainForSelection(selection);
    if (!_matchesCanonicalDomain(exercise, domain)) return false;
    if (_isRecoverySelection(selection) &&
        _isHighIntensityOrContact(exercise)) {
      return false;
    }
    if (_isActiveMobilitySelection(selection) && _isPassiveStretch(exercise)) {
      return false;
    }
    if (_isStretchingSelection(selection) && _isActiveConditioning(exercise)) {
      return false;
    }
    if (_isMartialSelection(selection) && _isSparringOrContact(exercise)) {
      return false;
    }
    return true;
  }

  static bool _matchesPreparationSelection(
    Exercise exercise,
    TrainingSelection selection,
  ) {
    final type = _preparationTypeForSelection(selection);
    if (type.isEmpty) return false;
    return exercise.primaryType == type ||
        exercise.secondaryTypes.contains(type) ||
        exercise.contextKey == type;
  }

  static String _preparationTypeForSelection(TrainingSelection selection) {
    return switch (selection.regionKey) {
      'elasticity' => 'elasticidade',
      'recovery' => 'recuperacao',
      'warmup' => 'aquecimento',
      'activation' => 'ativacao',
      'prevention' => 'prevencao',
      _ => '',
    };
  }

  static String _domainForSelection(TrainingSelection selection) {
    final preparationType = _preparationTypeForSelection(selection);
    if (preparationType.isNotEmpty) return preparationType;
    if (selection.regionKey == 'cardio') return 'cardio';
    if (selection.regionKey == 'martial_arts') return 'artes_marciais';
    if (selection.regionKey == 'mobility_recovery') {
      if (_isRecoverySelection(selection)) return 'recuperacao';
      if (_isStretchingSelection(selection)) return 'elasticidade';
      return 'mobilidade';
    }
    if (selection.regionKey == 'upper' ||
        selection.regionKey == 'lower' ||
        selection.regionKey == 'core' ||
        selection.regionKey == 'full_body') {
      return 'musculacao';
    }
    return '';
  }

  static bool _matchesCanonicalDomain(Exercise exercise, String domain) {
    if (domain.isEmpty || exercise.primaryType.isEmpty) return true;
    if (exercise.primaryType == domain ||
        exercise.secondaryTypes.contains(domain)) {
      return true;
    }
    final tags = TrainingArchitecture.tagsForExercise(exercise);
    if (domain == 'cardio' && tags.regionKeys.contains('cardio')) return true;
    if (domain == 'artes_marciais' &&
        tags.regionKeys.contains('martial_arts')) {
      return true;
    }
    if (domain == 'mobilidade' && exercise.primaryType == 'elasticidade') {
      return false;
    }
    if (domain == 'musculacao') return false;
    if (domain == 'cardio' || domain == 'artes_marciais') return false;
    if (const {'aquecimento', 'ativacao', 'prevencao'}.contains(domain)) {
      return false;
    }
    return true;
  }

  static bool _isRecoverySelection(TrainingSelection selection) =>
      selection.groupKey == 'active_recovery' ||
      selection.groupKey == 'breathing' ||
      selection.specificMuscleKey == 'recovery' ||
      selection.subgroupKey == 'recovery';

  static bool _isActiveMobilitySelection(TrainingSelection selection) =>
      selection.regionKey == 'mobility_recovery' &&
      (selection.groupKey.isEmpty ||
          selection.groupKey == 'general_mobility' ||
          selection.groupKey.endsWith('_mobility'));

  static bool _isStretchingSelection(TrainingSelection selection) =>
      selection.groupKey == 'stretching' ||
      selection.specificMuscleKey == 'stretching' ||
      selection.subgroupKey == 'stretching';

  static bool _isMartialSelection(TrainingSelection selection) =>
      selection.regionKey == 'martial_arts';

  static bool _isPassiveStretch(Exercise exercise) {
    if (exercise.primaryType == 'elasticidade') return true;
    if (exercise.secondaryTypes.contains('elasticidade') &&
        !exercise.secondaryTypes.contains('mobilidade')) {
      return true;
    }
    final text = _visibilityText(exercise);
    if (_textHas(text, ['mobilidade dinamica', 'aquecimento dinamico'])) {
      return false;
    }
    return false;
  }

  static bool _isActiveConditioning(Exercise exercise) {
    final text = _visibilityText(exercise);
    return _textHas(text, [
      'hiit',
      'sprint',
      'mountain climbers',
      'burpee',
      'sparring',
      'kumite',
      'maquina',
      'cabo',
      'supino',
      'curl',
    ]);
  }

  static bool _isHighIntensityOrContact(Exercise exercise) {
    final text = _visibilityText(exercise);
    return _textHas(text, [
      'hiit',
      'sprint',
      'intervalado',
      'double unders',
      'sparring',
      'kumite',
      'saco',
      'carga alta',
      'pesado',
    ]);
  }

  static bool _isSparringOrContact(Exercise exercise) {
    final text = _visibilityText(exercise);
    final equipment = {
      ...exercise.equipmentKeys,
      ...TrainingArchitecture.tagsForExercise(exercise).equipmentKeys,
    };
    if (equipment.contains('partner')) return true;
    return _textHas(text, ['sparring', 'combate com contacto']);
  }

  static String _visibilityText(Exercise exercise) => WorkoutTaxonomy.normalize(
    '${exercise.name} ${exercise.muscleGroup} ${exercise.secondaryMuscleGroups} '
    '${exercise.equipment} ${exercise.primaryType} ${exercise.secondaryTypes.join(' ')} '
    '${exercise.contextKey} ${exercise.catalogEntryKey}',
  );

  static bool _isKnownFocusKey(String key) =>
      key.isNotEmpty &&
      (_hierarchyFocusKeywords.containsKey(key) ||
          _completeFocusTagAliases.containsKey(key) ||
          _focusTagAliases.containsKey(key));

  static TrainingSelection _baseSelectionForHierarchy(
    TrainingSelection selection,
  ) {
    if (selection.regionKey == 'core') {
      return TrainingSelection(
        regionKey: selection.regionKey,
        equipmentKey: selection.equipmentKey,
      );
    }
    if (!_isKnownFocusKey(selection.subgroupKey) &&
        !_isKnownFocusKey(selection.specificMuscleKey)) {
      return selection;
    }
    // A focus key stored in the subgroup slot is not a real anatomical
    // subgroup tag, so subgroup matching must be delegated to the focus
    // matcher instead of the raw tag comparison.
    return TrainingSelection(
      regionKey: selection.regionKey,
      groupKey: selection.groupKey,
      subgroupKey: _isKnownFocusKey(selection.subgroupKey)
          ? ''
          : selection.subgroupKey,
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

    final tags = TrainingArchitecture.tagsForExercise(exercise);

    // Complete options must aggregate their explicit children instead of
    // depending on broad text matching.
    final completeMatch = _matchesCompleteFocus(tags, focus);
    if (completeMatch != null) return completeMatch;
    if (focus == 'upper_arm') {
      return tags.subgroupKeys.contains('anterior_arm') ||
          tags.subgroupKeys.contains('posterior_arm');
    }
    if (focus == 'forearm_hand' || focus == 'forearm_complete') {
      return tags.groupKeys.contains('forearm_hand') ||
          tags.subgroupKeys.contains('grip_strength');
    }

    // Canonical architecture tags are the source of truth; text predicates
    // and keywords below only rescue exercises without curated tags.
    if (_matchesExplicitFocusTags(exercise, focus)) return true;

    if (exercise.primaryMuscleKey.isNotEmpty) {
      final canonicalMuscles = {
        exercise.primaryMuscleKey,
        ...exercise.secondaryMuscleKeys,
      };
      if (canonicalMuscles.contains(focus) ||
          tags.subgroupKeys.contains(focus) ||
          tags.groupKeys.contains(focus)) {
        return true;
      }
      if ((focus == 'biceps_brachii' && canonicalMuscles.contains('biceps')) ||
          (focus == 'triceps' &&
              canonicalMuscles.any((key) => key.startsWith('triceps_'))) ||
          (focus == 'support_grip' &&
              canonicalMuscles.contains('grip_support'))) {
        return true;
      }
      return false;
    }

    // Specific muscles must not inherit siblings from the same broad group.
    if (focus == 'brachialis') return _isBrachialisExercise(exercise);
    if (focus == 'brachioradialis') return _isBrachioradialisExercise(exercise);
    if (focus == 'biceps' || focus == 'biceps_brachii') {
      return _isBicepsDominantExercise(exercise);
    }
    if (focus == 'triceps' ||
        focus == 'triceps_long' ||
        focus == 'triceps_lateral' ||
        focus == 'triceps_medial') {
      return _isTricepsExercise(exercise);
    }
    if (focus == 'forearm_flexors' ||
        focus == 'forearm_extensors' ||
        focus == 'pronators' ||
        focus == 'supinators' ||
        focus == 'wrist' ||
        focus == 'fingers' ||
        focus == 'support_grip' ||
        focus == 'pinch_grip' ||
        focus == 'general_grip') {
      return _isForearmHandExercise(exercise, focus);
    }

    final keywords = _hierarchyFocusKeywords[focus];
    // An unknown or tag-only focus must not silently accept every exercise:
    // that showed whole regions under muscles the exercise never trains.
    if (keywords == null || keywords.isEmpty) return false;
    // Martial-arts technique focuses are identified by the drill name; a
    // broader text match pulls drills into focuses their description merely
    // mentions (e.g. bag work under "guarda").
    if (_isMartialFocusKey(focus)) {
      return _textHas(WorkoutTaxonomy.normalize(exercise.name), keywords);
    }
    if (_primaryOnlyHierarchyFocuses.contains(focus)) {
      return _containsAnyPrimary(exercise, keywords);
    }
    return _containsAny(exercise, keywords);
  }

  static bool _isBicepsDominantExercise(Exercise exercise) {
    final text = _normalizedPrimaryText(exercise);
    return _textHas(text, [
          'curl com barra',
          'curl com halteres',
          'curl alternado',
          'curl martelo',
          'curl concentrado',
          'curl inclinado',
          'curl spider',
          'curl no cabo',
          'curl com elastico',
          'curl 21',
          'curl arrastado',
          'curl isometrico',
          'chin-up',
        ]) &&
        !_textHas(text, ['wrist', 'finger', 'pronacao', 'supinacao']);
  }

  static bool _isBrachialisExercise(Exercise exercise) {
    final name = WorkoutTaxonomy.normalize(exercise.name);
    if (_textHas(name, [
      'wrist',
      'finger',
      'pronacao',
      'supinacao',
      'desvio radial',
      'desvio ulnar',
      'farmer',
      'hold',
      'aperto',
    ])) {
      return false;
    }
    final text = _normalizedPrimaryText(exercise);
    final primaryGroup = WorkoutTaxonomy.normalize(exercise.muscleGroup);
    if (primaryGroup.contains('antebraco') &&
        !_textHas(name, ['curl inverso'])) {
      return false;
    }
    return _textHas(text, [
      'curl martelo',
      'curl cruzado',
      'curl inverso',
      'curl zottman',
      'curl alternado',
      'curl com halteres',
      'curl 21',
      'curl arrastado',
      'curl isometrico',
      'curl inclinado',
      'curl spider',
      'braquial',
    ]);
  }

  static bool _isBrachioradialisExercise(Exercise exercise) {
    final text = _normalizedPrimaryText(exercise);
    return _textHas(text, [
      'curl martelo',
      'curl cruzado',
      'curl inverso',
      'curl zottman',
      'braquiorradial',
    ]);
  }

  static bool _isTricepsExercise(Exercise exercise) {
    final text = _normalizedPrimaryText(exercise);
    return _textHas(text, [
      'triceps',
      'tricep',
      'extensao francesa',
      'extensao de triceps',
      'kickback',
      'tate press',
      'press fechado',
      'supino fechado',
      'flexao fechada',
      'flexao diamante',
      'fundos entre apoios',
      'dips para triceps',
    ]);
  }

  static bool _isForearmHandExercise(Exercise exercise, String focus) {
    final text = _normalizedPrimaryText(exercise);
    final isForearm = _textHas(text, [
      'antebraco',
      'antebraço',
      'punho',
      'pega',
      'wrist',
      'farmer',
      'suitcase',
      'hold',
      'dead hang',
      'aperto',
      'pronacao',
      'supinacao',
      'finger',
      'pinch',
      'plate',
      'towel',
      'desvio radial',
      'desvio ulnar',
    ]);
    if (!isForearm) return false;
    if (focus == 'forearm_flexors') {
      return _textHas(text, ['wrist curl', 'finger']);
    }
    if (focus == 'forearm_extensors') {
      return _textHas(text, ['reverse wrist', 'extensao de dedos']);
    }
    if (focus == 'pronators') return _textHas(text, ['pronacao']);
    if (focus == 'supinators') return _textHas(text, ['supinacao']);
    if (focus == 'wrist') {
      return _textHas(text, [
        'wrist',
        'punho',
        'desvio radial',
        'desvio ulnar',
        'rotacao controlada',
      ]);
    }
    if (focus == 'fingers') return _textHas(text, ['finger', 'dedos']);
    if (focus == 'support_grip') {
      return _textHas(text, ['farmer', 'dead hang', 'suitcase', 'hold']);
    }
    if (focus == 'pinch_grip') return _textHas(text, ['pinch', 'plate']);
    return true;
  }

  static String _normalizedPrimaryText(Exercise exercise) =>
      WorkoutTaxonomy.normalize(
        '${exercise.name} ${exercise.muscleGroup} ${exercise.equipment} '
        '${exercise.primaryMuscleNodes ?? ''} '
        '${exercise.secondaryMuscleNodes ?? ''}',
      );

  static bool _textHas(String text, List<String> values) =>
      values.any((value) => text.contains(WorkoutTaxonomy.normalize(value)));

  static String _searchNormalize(String value) {
    var text = value.toLowerCase();
    const replacements = {
      'á': 'a',
      'à': 'a',
      'ã': 'a',
      'â': 'a',
      'ä': 'a',
      'é': 'e',
      'ê': 'e',
      'è': 'e',
      'í': 'i',
      'ó': 'o',
      'õ': 'o',
      'ô': 'o',
      'ú': 'u',
      'ç': 'c',
      'Ã¡': 'a',
      'Ã ': 'a',
      'Ã£': 'a',
      'Ã¢': 'a',
      'Ã©': 'e',
      'Ãª': 'e',
      'Ã­': 'i',
      'Ã³': 'o',
      'Ãµ': 'o',
      'Ã´': 'o',
      'Ãº': 'u',
      'Ã§': 'c',
    };
    for (final entry in replacements.entries) {
      text = text.replaceAll(entry.key, entry.value);
    }
    return text
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static bool _isMartialFocusKey(String focus) =>
      focus.startsWith('karate_') ||
      focus.startsWith('jiu_jitsu_') ||
      const {
        'kihon',
        'kata',
        'kumite_technical',
        'shrimp',
        'grappling_bridge',
        'technical_stand_up',
        'guard_passing',
      }.contains(focus);

  static const _primaryOnlyHierarchyFocuses = {
    'biceps_brachii',
    'biceps',
    'brachialis',
    'brachioradialis',
    'coracobrachialis',
    'hamstrings_complete',
    'glutes_complete',
  };

  static bool _matchesExplicitFocusTags(Exercise exercise, String focus) {
    final tags = TrainingArchitecture.tagsForExercise(exercise);
    if (tags.groupKeys.contains(focus) ||
        tags.subgroupKeys.contains(focus) ||
        tags.muscleKeys.contains(focus)) {
      return true;
    }
    final aliases = _focusTagAliases[focus];
    if (aliases == null) return false;
    return aliases.any(
      (alias) =>
          tags.groupKeys.contains(alias) ||
          tags.subgroupKeys.contains(alias) ||
          tags.muscleKeys.contains(alias),
    );
  }

  static bool? _matchesCompleteFocus(
    ExerciseArchitectureTags tags,
    String focus,
  ) {
    final aliases = _completeFocusTagAliases[focus];
    if (aliases == null) return null;
    return aliases.any(
      (alias) =>
          tags.groupKeys.contains(alias) ||
          tags.subgroupKeys.contains(alias) ||
          tags.muscleKeys.contains(alias),
    );
  }

  static const _completeFocusTagAliases = {
    'arms_complete': {
      'arms',
      'forearm_hand',
      'anterior_arm',
      'posterior_arm',
      'grip_strength',
    },
    'forearm_complete': {'forearm_hand', 'grip_strength'},
    'chest_complete': {'chest', 'chest_primary'},
    'back_complete': {'back', 'back_width', 'back_thickness', 'low_back'},
    'shoulders_complete': {'shoulders', 'deltoids'},
    'traps_complete': {'traps_scapula', 'traps'},
    'neck_complete': {'neck'},
    'core_complete': {'core', 'core_stability', 'core_general', 'low_back'},
    'abs_complete': {'core', 'core_stability', 'core_general'},
    'abdominal_zone': {'core', 'core_stability', 'core_general'},
    'lumbar_zone': {'low_back'},
    'core_stability_zone': {'core', 'core_stability', 'core_general'},
    'legs_complete': {
      'legs',
      'quadriceps',
      'hamstrings',
      'hips_glutes',
      'adductors',
      'abductors',
      'calves',
      'tibialis',
      'feet_ankle',
    },
    'upper_leg_hip': {
      'quadriceps',
      'hamstrings',
      'hips_glutes',
      'adductors',
      'abductors',
    },
    'lower_leg_foot': {'calves', 'tibialis', 'feet_ankle'},
    'thigh_complete': {
      'quadriceps',
      'hamstrings',
      'hips_glutes',
      'adductors',
      'abductors',
    },
    'quadriceps_complete': {'quadriceps'},
    'hamstrings_complete': {'hamstrings'},
    'glutes_complete': {'hips_glutes', 'glutes'},
    'lower_leg_complete': {'calves', 'tibialis', 'feet_ankle'},
    'karate_complete': {'karate'},
    'jiu_jitsu_complete': {'jiu_jitsu'},
  };

  static const _focusTagAliases = {
    'karate_conditioning': ['martial_conditioning'],
    'jiu_jitsu_conditioning': ['martial_conditioning'],
    'karate_mobility': ['martial_mobility'],
    'jiu_jitsu_mobility': ['martial_mobility'],
    'jiu_jitsu_core': ['martial_core'],
    'jiu_jitsu_grip': ['grappling_grip'],
    'upper_arm': ['anterior_arm', 'posterior_arm'],
    'forearm_hand': ['forearm_hand', 'grip_strength'],
    'biceps': ['biceps'],
    'biceps_brachii': ['biceps'],
    'brachialis': ['brachialis'],
    'brachioradialis': ['brachioradialis'],
    'triceps': ['triceps_long', 'triceps_lateral', 'triceps_medial'],
    'triceps_long': ['triceps_long'],
    'triceps_lateral': ['triceps_lateral'],
    'triceps_medial': ['triceps_medial'],
    'forearm_flexors': ['forearm_flexors'],
    'forearm_extensors': ['forearm_extensors'],
    'pronators': ['pronators'],
    'supinators': ['supinators'],
    'wrist': ['wrist'],
    'fingers': ['fingers'],
    'support_grip': ['grip_support'],
    'pinch_grip': ['pinch_grip'],
    'general_grip': ['grip_support', 'pinch_grip', 'general_grip'],
    'anti_rotation': ['anti_rotation'],
    'anti_extension': ['anti_extension'],
    'anti_lateral_flexion': ['anti_lateral_flexion'],
    'deep_stability': ['deep_stability'],
    'rectus_abdominis': ['rectus_abdominis'],
    'external_obliques': ['external_obliques'],
    'internal_obliques': ['internal_obliques'],
    'transverse_abdominis': ['transverse_abdominis'],
    'back_upper': [
      'upper_traps',
      'mid_traps',
      'lower_traps',
      'rhomboids',
      'posterior_deltoid',
      'scapular_stabilizers',
    ],
    'back_mid': [
      'rhomboids',
      'mid_traps',
      'lats',
      'teres_major',
      'horizontal_rows',
    ],
    'anterior_deltoid': ['anterior_deltoid'],
    'lateral_deltoid': ['lateral_deltoid', 'deltoid_lateral'],
    'posterior_deltoid': ['posterior_deltoid'],
    'rotator_cuff': ['external_rotators', 'internal_rotators'],
    'external_rotators': ['external_rotators'],
    'internal_rotators': ['internal_rotators'],
    'scapular_stability': ['scapular_stabilizers'],
    'scapular_stabilizers': ['scapular_stabilizers'],
    'upper_traps': ['upper_traps'],
    'mid_traps': ['mid_traps'],
    'lower_traps': ['lower_traps'],
    'rhomboids': ['rhomboids'],
    'teres_major': ['teres_major'],
    'teres_minor': ['teres_minor'],
    'latissimus_dorsi': ['lats'],
    'vertical_pulls': ['vertical_pulls'],
    'horizontal_rows': ['horizontal_rows'],
    'erectors': ['erectors'],
    'lumbar': ['erectors', 'quadratus_lumborum', 'low_back'],
    'quadratus_lumborum': ['quadratus_lumborum'],
    'lumbar_stability': ['erectors', 'quadratus_lumborum', 'low_back'],
    'anterior_neck': ['anterior_neck'],
    'posterior_neck': ['posterior_neck'],
    'lateral_neck': ['lateral_neck'],
    'cervical_stabilizers': ['cervical_stabilizers'],
    'pectoralis_minor': ['pectoralis_minor'],
    'serratus_anterior': ['serratus_anterior'],
    'upper_chest': ['upper_chest'],
    'mid_chest': ['mid_chest'],
    'lower_chest': ['lower_chest'],
    'rectus_femoris': ['rectus_femoris'],
    'vastus_lateralis': ['vastus_lateralis'],
    'vastus_medialis': ['vastus_medialis'],
    'vastus_intermedius': ['vastus_intermedius'],
    'biceps_femoris': ['biceps_femoris'],
    'semitendinosus': ['semitendinosus'],
    'semimembranosus': ['semimembranosus'],
    'glute_max': ['glute_max'],
    'glute_med': ['glute_med'],
    'glute_min': ['glute_min'],
    'hip_flexors': ['hip_flexors'],
    'adductors': ['adductors'],
    'abductors': ['abductors'],
    'calves': ['calves'],
    'soleus': ['soleus'],
    'tibialis_anterior': ['tibialis_anterior'],
    'ankle': ['ankle'],
    'feet': ['feet'],
    'ankle_stability': ['ankle_stability', 'ankle'],
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
    'upper_arm': <String>[],
    'forearm_hand': <String>[],
    'forearm_complete': [
      'antebraco',
      'wrist',
      'farmer',
      'suitcase',
      'hold estatico',
      'hold estático',
      'dead hang',
      'aperto',
      'pronacao',
      'supinacao',
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
    'karate_stances': ['bases', 'dachi'],
    'karate_blocks': ['bloqueio', 'bloqueios', 'uke'],
    'karate_evasions': ['esquiva', 'esquivas', 'tai-sabaki', 'tai sabaki'],
    'karate_knees': ['joelhada', 'joelhadas'],
    'karate_bag': ['saco'],
    'karate_guard': ['guarda'],
    'karate_punches': ['socos', 'soco'],
    'karate_kicks': ['pontapés', 'pontapes', 'pontapé', 'pontape'],
    'karate_mobility': ['mobilidade', 'anca', 'ombro'],
    'karate_conditioning': ['condicionamento'],
    'shrimp': ['shrimp', 'fuga de anca'],
    'grappling_bridge': ['ponte de grappling'],
    'technical_stand_up': ['technical stand-up'],
    'jiu_jitsu_rolls': ['rolamento', 'rolamentos'],
    'jiu_jitsu_breakfalls': ['breakfall', 'breakfalls', 'ukemi'],
    'jiu_jitsu_inversions': ['inversão', 'inversao', 'granby'],
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
    'back_lower': ['lombar', 'eretores', 'hiperextensão', 'hiperextensao'],
    'back_width': ['puxada', 'dorsal', 'latíssimo', 'latissimo'],
    'back_thickness': ['remo', 'romboides', 'trapézio médio', 'trapezio medio'],
    'lower_abs': [
      'reverse crunch',
      'elevação de pernas',
      'elevacao de pernas',
      'elevação de joelhos',
      'elevacao de joelhos',
      'flutter',
      'inferior',
    ],
    'lateral_abs': [
      'prancha lateral',
      'russian twist',
      'bicycle crunch',
      'oblíquos',
      'obliquos',
    ],
    'upper_abs': ['crunch', 'toe touches', 'superior'],
    'mid_abs': ['crunch', 'abdominal médio', 'abdominal medio'],
  };

  static bool _containsAny(Exercise exercise, List<String> values) {
    final haystack = WorkoutTaxonomy.normalize(
      '${exercise.name} ${exercise.muscleGroup} '
      '${exercise.primaryMuscleNodes ?? ''} '
      '${exercise.secondaryMuscleNodes ?? ''} '
      '${exercise.secondaryMuscleGroups} ${exercise.equipment}',
    );
    return values.any(
      (value) => haystack.contains(WorkoutTaxonomy.normalize(value)),
    );
  }

  static bool _containsAnyPrimary(Exercise exercise, List<String> values) {
    final haystack = WorkoutTaxonomy.normalize(
      '${exercise.name} ${exercise.muscleGroup} ${exercise.equipment} '
      '${exercise.primaryMuscleNodes ?? ''}',
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

  static List<String> _orderedContextualPredicateFilters(
    List<Exercise> exercises,
    Map<String, bool Function(Exercise exercise)> rules,
  ) {
    final labels = <String>['Todos'];
    for (final entry in rules.entries) {
      if (exercises.any(entry.value)) labels.add(entry.key);
    }
    return labels;
  }
}
