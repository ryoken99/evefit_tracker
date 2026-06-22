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
    this.isHidden = false,
    this.createdAt,
    this.updatedAt,
    this.notes = '',
    this.exerciseKey = '',
    this.contextKey = '',
    this.catalogEntryKey = '',
    this.primaryMuscleNodes,
    this.secondaryMuscleNodes,
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
  final bool isHidden;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String notes;
  final String exerciseKey;
  final String contextKey;
  final String catalogEntryKey;
  final String? primaryMuscleNodes;
  final String? secondaryMuscleNodes;

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
    bool? isHidden,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    String? exerciseKey,
    String? contextKey,
    String? catalogEntryKey,
    String? primaryMuscleNodes,
    String? secondaryMuscleNodes,
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
      isHidden: isHidden ?? this.isHidden,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      exerciseKey: exerciseKey ?? this.exerciseKey,
      contextKey: contextKey ?? this.contextKey,
      catalogEntryKey: catalogEntryKey ?? this.catalogEntryKey,
      primaryMuscleNodes: primaryMuscleNodes ?? this.primaryMuscleNodes,
      secondaryMuscleNodes: secondaryMuscleNodes ?? this.secondaryMuscleNodes,
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
    isHidden: (map['is_hidden'] as int? ?? 0) == 1,
    createdAt: map['created_at'] == null
        ? null
        : DateTime.parse(map['created_at'] as String),
    updatedAt: map['updated_at'] == null
        ? null
        : DateTime.parse(map['updated_at'] as String),
    notes: map['notes'] as String? ?? '',
    exerciseKey: map['exercise_key'] as String? ?? '',
    contextKey: map['context_key'] as String? ?? '',
    catalogEntryKey: map['catalog_entry_key'] as String? ?? '',
    primaryMuscleNodes:
        map['primaryMuscleNodes'] as String? ??
        map['primary_muscle_nodes'] as String?,
    secondaryMuscleNodes:
        map['secondaryMuscleNodes'] as String? ??
        map['secondary_muscle_nodes'] as String?,
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
    'is_default': isDefault ? 1 : 0,
    'is_hidden': isHidden ? 1 : 0,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'notes': notes,
    'exercise_key': exerciseKey,
    'context_key': contextKey,
    'catalog_entry_key': catalogEntryKey,
    'primaryMuscleNodes': primaryMuscleNodes,
    'secondaryMuscleNodes': secondaryMuscleNodes,
  };
}
