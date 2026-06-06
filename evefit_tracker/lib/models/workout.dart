class Workout {
  Workout({
    this.id,
    this.profileId,
    required this.date,
    required this.workoutType,
    this.workoutTypeId,
    this.muscleGroups = '',
    this.durationMinutes,
    this.notes = '',
  });

  final int? id;
  final int? profileId;
  final DateTime date;
  final String workoutType;
  final int? workoutTypeId;
  final String muscleGroups;
  final int? durationMinutes;
  final String notes;

  factory Workout.fromMap(Map<String, Object?> map) => Workout(
    id: map['id'] as int?,
    profileId: map['profile_id'] as int?,
    date: DateTime.parse(map['date'] as String),
    workoutType: map['workout_type'] as String,
    workoutTypeId: map['workout_type_id'] as int?,
    muscleGroups: map['muscle_groups'] as String? ?? '',
    durationMinutes: map['duration_minutes'] as int?,
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'date': date.toIso8601String(),
    'workout_type': workoutType,
    'workout_type_id': workoutTypeId,
    'muscle_groups': muscleGroups,
    'duration_minutes': durationMinutes,
    'notes': notes,
  };
}
