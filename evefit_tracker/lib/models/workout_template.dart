class CustomWorkoutTemplate {
  CustomWorkoutTemplate({
    this.id,
    required this.profileId,
    required this.name,
    this.description = '',
    this.workoutTypeId,
    this.muscleGroups = '',
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int profileId;
  final String name;
  final String description;
  final int? workoutTypeId;
  final String muscleGroups;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory CustomWorkoutTemplate.fromMap(Map<String, Object?> map) =>
      CustomWorkoutTemplate(
        id: map['id'] as int?,
        profileId: map['profile_id'] as int,
        name: map['name'] as String,
        description: map['description'] as String? ?? '',
        workoutTypeId: map['workout_type_id'] as int?,
        muscleGroups: map['muscle_groups'] as String? ?? '',
        createdAt: DateTime.parse(map['created_at'] as String),
        updatedAt: DateTime.parse(map['updated_at'] as String),
      );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'name': name,
    'description': description,
    'workout_type_id': workoutTypeId,
    'muscle_groups': muscleGroups,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
