class WorkoutTemplateExercise {
  WorkoutTemplateExercise({
    this.id,
    required this.templateId,
    required this.exerciseId,
    required this.sortOrder,
    this.defaultSets,
    this.defaultReps,
    this.defaultWeightKg,
    this.notes = '',
  });

  final int? id;
  final int templateId;
  final int exerciseId;
  final int sortOrder;
  final int? defaultSets;
  final int? defaultReps;
  final double? defaultWeightKg;
  final String notes;

  factory WorkoutTemplateExercise.fromMap(Map<String, Object?> map) =>
      WorkoutTemplateExercise(
        id: map['id'] as int?,
        templateId: map['template_id'] as int,
        exerciseId: map['exercise_id'] as int,
        sortOrder: map['sort_order'] as int? ?? 0,
        defaultSets: map['default_sets'] as int?,
        defaultReps: map['default_reps'] as int?,
        defaultWeightKg: map['default_weight_kg'] == null
            ? null
            : (map['default_weight_kg'] as num).toDouble(),
        notes: map['notes'] as String? ?? '',
      );

  Map<String, Object?> toMap() => {
    'id': id,
    'template_id': templateId,
    'exercise_id': exerciseId,
    'sort_order': sortOrder,
    'default_sets': defaultSets,
    'default_reps': defaultReps,
    'default_weight_kg': defaultWeightKg,
    'notes': notes,
  };
}
