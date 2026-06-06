class Workout {
  Workout({
    this.id,
    required this.date,
    required this.workoutType,
    this.durationMinutes,
    this.notes = '',
  });

  final int? id;
  final DateTime date;
  final String workoutType;
  final int? durationMinutes;
  final String notes;

  factory Workout.fromMap(Map<String, Object?> map) => Workout(
    id: map['id'] as int?,
    date: DateTime.parse(map['date'] as String),
    workoutType: map['workout_type'] as String,
    durationMinutes: map['duration_minutes'] as int?,
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'date': date.toIso8601String(),
    'workout_type': workoutType,
    'duration_minutes': durationMinutes,
    'notes': notes,
  };
}
