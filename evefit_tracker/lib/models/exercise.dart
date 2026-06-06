class Exercise {
  Exercise({
    this.id,
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
  });

  final int? id;
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

  factory Exercise.fromMap(Map<String, Object?> map) => Exercise(
    id: map['id'] as int?,
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
  );

  Map<String, Object?> toMap() => {
    'id': id,
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
  };
}
