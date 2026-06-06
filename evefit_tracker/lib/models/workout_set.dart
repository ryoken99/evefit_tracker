class WorkoutSet {
  WorkoutSet({
    this.id,
    this.workoutId,
    required this.exerciseId,
    required this.setNumber,
    this.weightKg,
    required this.reps,
    this.rpe,
    this.notes = '',
    this.exerciseName,
  });

  final int? id;
  final int? workoutId;
  final int exerciseId;
  final int setNumber;
  final double? weightKg;
  final int reps;
  final double? rpe;
  final String notes;
  final String? exerciseName;

  factory WorkoutSet.fromMap(Map<String, Object?> map) => WorkoutSet(
    id: map['id'] as int?,
    workoutId: map['workout_id'] as int?,
    exerciseId: map['exercise_id'] as int,
    setNumber: map['set_number'] as int,
    weightKg: map['weight_kg'] == null
        ? null
        : (map['weight_kg'] as num).toDouble(),
    reps: map['reps'] as int,
    rpe: map['rpe'] == null ? null : (map['rpe'] as num).toDouble(),
    notes: map['notes'] as String? ?? '',
    exerciseName: map['exercise_name'] as String?,
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'workout_id': workoutId,
    'exercise_id': exerciseId,
    'set_number': setNumber,
    'weight_kg': weightKg,
    'reps': reps,
    'rpe': rpe,
    'notes': notes,
  };
}
