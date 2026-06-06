class WorkoutExercise {
  WorkoutExercise({
    this.id,
    this.profileId,
    required this.workoutId,
    required this.exerciseId,
    this.exerciseName,
    this.muscleGroup,
    this.notes = '',
  });

  final int? id;
  final int? profileId;
  final int workoutId;
  final int exerciseId;
  final String? exerciseName;
  final String? muscleGroup;
  final String notes;

  factory WorkoutExercise.fromMap(Map<String, Object?> map) => WorkoutExercise(
    id: map['id'] as int?,
    profileId: map['profile_id'] as int?,
    workoutId: map['workout_id'] as int,
    exerciseId: map['exercise_id'] as int,
    exerciseName: map['exercise_name'] as String?,
    muscleGroup: map['muscle_group'] as String?,
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'workout_id': workoutId,
    'exercise_id': exerciseId,
    'notes': notes,
  };
}
