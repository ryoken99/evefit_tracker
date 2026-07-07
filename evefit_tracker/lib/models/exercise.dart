import 'exercise_taxonomy.dart';

class Exercise {
  Exercise({
    this.id,
    this.profileId,
    required this.name,
    required this.muscleGroup,
    required this.isDefault,
    this.secondaryMuscleGroups = '',
    this.equipment = '',
    this.description = '',
    this.executionSteps = '',
    this.commonMistakes = '',
    this.safetyNotes = '',
    this.regression = '',
    this.progression = '',
    this.breathingTips = '',
    this.postureTips = '',
    this.adaptationNotes = '',
    this.isHidden = false,
    this.createdAt,
    this.updatedAt,
    this.notes = '',
    this.canonicalId = '',
    this.aliases = const {},
    this.primaryType = '',
    this.secondaryTypes = const {},
    this.exerciseKey = '',
    this.contextKey = '',
    this.catalogEntryKey = '',
    this.primaryMuscleNodes,
    this.secondaryMuscleNodes,
    this.regionKeys = const {},
    this.groupKeys = const {},
    this.subgroupKeys = const {},
    this.primaryMuscleKey = '',
    this.secondaryMuscleKeys = const {},
    this.equipmentKeys = const {},
    this.movementPattern = '',
    this.difficulty = '',
    this.forceType = '',
    this.laterality = '',
    this.goalTags = const {},
  });

  final int? id;
  final int? profileId;
  final String name;
  final String muscleGroup;
  final bool isDefault;
  final String secondaryMuscleGroups;
  final String equipment;
  final String description;
  final String executionSteps;
  final String commonMistakes;
  final String safetyNotes;
  final String regression;
  final String progression;
  final String breathingTips;
  final String postureTips;
  final String adaptationNotes;
  final bool isHidden;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String notes;
  final String canonicalId;
  final Set<String> aliases;
  final String primaryType;
  final Set<String> secondaryTypes;
  final String exerciseKey;
  final String contextKey;
  final String catalogEntryKey;
  final String? primaryMuscleNodes;
  final String? secondaryMuscleNodes;
  final Set<String> regionKeys;
  final Set<String> groupKeys;
  final Set<String> subgroupKeys;
  final String primaryMuscleKey;
  final Set<String> secondaryMuscleKeys;
  final Set<String> equipmentKeys;
  final String movementPattern;
  final String difficulty;
  final String forceType;
  final String laterality;
  final Set<String> goalTags;

  String get primaryDisplayMuscles {
    final value = primaryMuscleNodes?.trim();
    if (value != null && value.isNotEmpty) return value;
    return muscleGroup;
  }

  Exercise copyWith({
    int? id,
    int? profileId,
    String? name,
    String? muscleGroup,
    bool? isDefault,
    String? secondaryMuscleGroups,
    String? equipment,
    String? description,
    String? executionSteps,
    String? commonMistakes,
    String? safetyNotes,
    String? regression,
    String? progression,
    String? breathingTips,
    String? postureTips,
    String? adaptationNotes,
    bool? isHidden,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    String? canonicalId,
    Set<String>? aliases,
    String? primaryType,
    Set<String>? secondaryTypes,
    String? exerciseKey,
    String? contextKey,
    String? catalogEntryKey,
    String? primaryMuscleNodes,
    String? secondaryMuscleNodes,
    Set<String>? regionKeys,
    Set<String>? groupKeys,
    Set<String>? subgroupKeys,
    String? primaryMuscleKey,
    Set<String>? secondaryMuscleKeys,
    Set<String>? equipmentKeys,
    String? movementPattern,
    String? difficulty,
    String? forceType,
    String? laterality,
    Set<String>? goalTags,
  }) {
    return Exercise(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      isDefault: isDefault ?? this.isDefault,
      secondaryMuscleGroups:
          secondaryMuscleGroups ?? this.secondaryMuscleGroups,
      equipment: equipment ?? this.equipment,
      description: description ?? this.description,
      executionSteps: executionSteps ?? this.executionSteps,
      commonMistakes: commonMistakes ?? this.commonMistakes,
      safetyNotes: safetyNotes ?? this.safetyNotes,
      regression: regression ?? this.regression,
      progression: progression ?? this.progression,
      breathingTips: breathingTips ?? this.breathingTips,
      postureTips: postureTips ?? this.postureTips,
      adaptationNotes: adaptationNotes ?? this.adaptationNotes,
      isHidden: isHidden ?? this.isHidden,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      canonicalId: canonicalId ?? this.canonicalId,
      aliases: aliases ?? this.aliases,
      primaryType: primaryType ?? this.primaryType,
      secondaryTypes: secondaryTypes ?? this.secondaryTypes,
      exerciseKey: exerciseKey ?? this.exerciseKey,
      contextKey: contextKey ?? this.contextKey,
      catalogEntryKey: catalogEntryKey ?? this.catalogEntryKey,
      primaryMuscleNodes: primaryMuscleNodes ?? this.primaryMuscleNodes,
      secondaryMuscleNodes: secondaryMuscleNodes ?? this.secondaryMuscleNodes,
      regionKeys: regionKeys ?? this.regionKeys,
      groupKeys: groupKeys ?? this.groupKeys,
      subgroupKeys: subgroupKeys ?? this.subgroupKeys,
      primaryMuscleKey: primaryMuscleKey ?? this.primaryMuscleKey,
      secondaryMuscleKeys: secondaryMuscleKeys ?? this.secondaryMuscleKeys,
      equipmentKeys: equipmentKeys ?? this.equipmentKeys,
      movementPattern: movementPattern ?? this.movementPattern,
      difficulty: difficulty ?? this.difficulty,
      forceType: forceType ?? this.forceType,
      laterality: laterality ?? this.laterality,
      goalTags: goalTags ?? this.goalTags,
    );
  }

  factory Exercise.fromMap(Map<String, Object?> map) => Exercise(
    id: map['id'] as int?,
    profileId: map['profile_id'] as int?,
    name: map['name'] as String,
    muscleGroup:
        map['primary_muscle_group'] as String? ??
        map['muscle_group'] as String? ??
        'Outro',
    isDefault: (map['is_default'] as int) == 1,
    secondaryMuscleGroups: map['secondary_muscle_groups'] as String? ?? '',
    equipment: map['equipment'] as String? ?? '',
    description: map['description'] as String? ?? '',
    executionSteps: map['execution_steps'] as String? ?? '',
    commonMistakes: map['common_mistakes'] as String? ?? '',
    safetyNotes: map['safety_notes'] as String? ?? '',
    regression: map['regression'] as String? ?? '',
    progression: map['progression'] as String? ?? '',
    breathingTips: map['breathing_tips'] as String? ?? '',
    postureTips: map['posture_tips'] as String? ?? '',
    adaptationNotes: map['adaptation_notes'] as String? ?? '',
    isHidden: (map['is_hidden'] as int? ?? 0) == 1,
    createdAt: map['created_at'] == null
        ? null
        : DateTime.parse(map['created_at'] as String),
    updatedAt: map['updated_at'] == null
        ? null
        : DateTime.parse(map['updated_at'] as String),
    notes: map['notes'] as String? ?? '',
    canonicalId: map['canonical_id'] as String? ?? '',
    aliases: ExerciseTaxonomy.parseKeys(map['aliases']),
    primaryType: map['primary_type'] as String? ?? '',
    secondaryTypes: ExerciseTaxonomy.parseKeys(map['secondary_types']),
    exerciseKey: map['exercise_key'] as String? ?? '',
    contextKey: map['context_key'] as String? ?? '',
    catalogEntryKey: map['catalog_entry_key'] as String? ?? '',
    primaryMuscleNodes:
        map['primaryMuscleNodes'] as String? ??
        map['primary_muscle_nodes'] as String?,
    secondaryMuscleNodes:
        map['secondaryMuscleNodes'] as String? ??
        map['secondary_muscle_nodes'] as String?,
    regionKeys: ExerciseTaxonomy.parseKeys(map['region_keys']),
    groupKeys: ExerciseTaxonomy.parseKeys(map['group_keys']),
    subgroupKeys: ExerciseTaxonomy.parseKeys(map['subgroup_keys']),
    primaryMuscleKey: map['primary_muscle_key'] as String? ?? '',
    secondaryMuscleKeys: ExerciseTaxonomy.parseKeys(
      map['secondary_muscle_keys'],
    ),
    equipmentKeys: ExerciseTaxonomy.parseKeys(map['equipment_keys']),
    movementPattern: map['movement_pattern'] as String? ?? '',
    difficulty: map['difficulty'] as String? ?? '',
    forceType: map['force_type'] as String? ?? '',
    laterality: map['laterality'] as String? ?? '',
    goalTags: ExerciseTaxonomy.parseKeys(map['goal_tags']),
  );

  Map<String, Object?> toMap() => {
    'id': id,
    if (profileId != null) 'profile_id': profileId,
    'name': name,
    'muscle_group': muscleGroup,
    'primary_muscle_group': muscleGroup,
    'secondary_muscle_groups': secondaryMuscleGroups,
    'equipment': equipment,
    'description': description,
    'execution_steps': executionSteps,
    'common_mistakes': commonMistakes,
    'safety_notes': safetyNotes,
    if (regression.isNotEmpty) 'regression': regression,
    if (progression.isNotEmpty) 'progression': progression,
    if (breathingTips.isNotEmpty) 'breathing_tips': breathingTips,
    if (postureTips.isNotEmpty) 'posture_tips': postureTips,
    if (adaptationNotes.isNotEmpty) 'adaptation_notes': adaptationNotes,
    'is_default': isDefault ? 1 : 0,
    'is_hidden': isHidden ? 1 : 0,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'notes': notes,
    if (canonicalId.isNotEmpty) 'canonical_id': canonicalId,
    if (aliases.isNotEmpty) 'aliases': ExerciseTaxonomy.serializeKeys(aliases),
    if (primaryType.isNotEmpty) 'primary_type': primaryType,
    if (secondaryTypes.isNotEmpty)
      'secondary_types': ExerciseTaxonomy.serializeKeys(secondaryTypes),
    'exercise_key': exerciseKey,
    'context_key': contextKey,
    'catalog_entry_key': catalogEntryKey,
    'primaryMuscleNodes': primaryMuscleNodes,
    'secondaryMuscleNodes': secondaryMuscleNodes,
    if (regionKeys.isNotEmpty)
      'region_keys': ExerciseTaxonomy.serializeKeys(regionKeys),
    if (groupKeys.isNotEmpty)
      'group_keys': ExerciseTaxonomy.serializeKeys(groupKeys),
    if (subgroupKeys.isNotEmpty)
      'subgroup_keys': ExerciseTaxonomy.serializeKeys(subgroupKeys),
    if (primaryMuscleKey.isNotEmpty) 'primary_muscle_key': primaryMuscleKey,
    if (secondaryMuscleKeys.isNotEmpty)
      'secondary_muscle_keys': ExerciseTaxonomy.serializeKeys(
        secondaryMuscleKeys,
      ),
    if (equipmentKeys.isNotEmpty)
      'equipment_keys': ExerciseTaxonomy.serializeKeys(equipmentKeys),
    if (movementPattern.isNotEmpty) 'movement_pattern': movementPattern,
    if (difficulty.isNotEmpty) 'difficulty': difficulty,
    if (forceType.isNotEmpty) 'force_type': forceType,
    if (laterality.isNotEmpty) 'laterality': laterality,
    if (goalTags.isNotEmpty)
      'goal_tags': ExerciseTaxonomy.serializeKeys(goalTags),
  };
}
