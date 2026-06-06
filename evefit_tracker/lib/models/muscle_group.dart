class MuscleGroup {
  MuscleGroup({
    this.id,
    required this.name,
    this.parentGroup = '',
    this.description = '',
    required this.isDefault,
  });

  final int? id;
  final String name;
  final String parentGroup;
  final String description;
  final bool isDefault;

  factory MuscleGroup.fromMap(Map<String, Object?> map) => MuscleGroup(
    id: map['id'] as int?,
    name: map['name'] as String,
    parentGroup: map['parent_group'] as String? ?? '',
    description: map['description'] as String? ?? '',
    isDefault: (map['is_default'] as int? ?? 0) == 1,
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'parent_group': parentGroup,
    'description': description,
    'is_default': isDefault ? 1 : 0,
  };
}
