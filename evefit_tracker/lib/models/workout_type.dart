class WorkoutType {
  WorkoutType({
    this.id,
    this.profileId,
    required this.name,
    this.description = '',
    this.muscleGroups = '',
    required this.isDefault,
    this.isHidden = false,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? profileId;
  final String name;
  final String description;
  final String muscleGroups;
  final bool isDefault;
  final bool isHidden;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory WorkoutType.fromMap(Map<String, Object?> map) => WorkoutType(
    id: map['id'] as int?,
    profileId: map['profile_id'] as int?,
    name: map['name'] as String,
    description: map['description'] as String? ?? '',
    muscleGroups: map['muscle_groups'] as String? ?? '',
    isDefault: (map['is_default'] as int? ?? 0) == 1,
    isHidden: (map['is_hidden'] as int? ?? 0) == 1,
    createdAt: DateTime.parse(map['created_at'] as String),
    updatedAt: DateTime.parse(map['updated_at'] as String),
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'name': name,
    'description': description,
    'muscle_groups': muscleGroups,
    'is_default': isDefault ? 1 : 0,
    'is_hidden': isHidden ? 1 : 0,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
