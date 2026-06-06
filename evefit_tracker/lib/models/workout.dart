class Workout {
  Workout({
    this.id,
    this.profileId,
    required this.date,
    required this.workoutType,
    this.workoutTypeId,
    this.muscleGroups = '',
    this.regionKey = '',
    this.groupKey = '',
    this.subgroupKey = '',
    this.specificMuscleKey = '',
    this.equipmentKey = '',
    this.durationMinutes,
    this.notes = '',
  });

  final int? id;
  final int? profileId;
  final DateTime date;
  final String workoutType;
  final int? workoutTypeId;
  final String muscleGroups;
  final String regionKey;
  final String groupKey;
  final String subgroupKey;
  final String specificMuscleKey;
  final String equipmentKey;
  final int? durationMinutes;
  final String notes;

  factory Workout.fromMap(Map<String, Object?> map) => Workout(
    id: map['id'] as int?,
    profileId: map['profile_id'] as int?,
    date: DateTime.parse(map['date'] as String),
    workoutType: map['workout_type'] as String,
    workoutTypeId: map['workout_type_id'] as int?,
    muscleGroups: map['muscle_groups'] as String? ?? '',
    regionKey: map['workout_region_key'] as String? ?? '',
    groupKey: map['workout_group_key'] as String? ?? '',
    subgroupKey: map['workout_subgroup_key'] as String? ?? '',
    specificMuscleKey: map['workout_specific_muscle_key'] as String? ?? '',
    equipmentKey: map['workout_equipment_key'] as String? ?? '',
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
    'workout_region_key': regionKey,
    'workout_group_key': groupKey,
    'workout_subgroup_key': subgroupKey,
    'workout_specific_muscle_key': specificMuscleKey,
    'workout_equipment_key': equipmentKey,
    'duration_minutes': durationMinutes,
    'notes': notes,
  };
}
