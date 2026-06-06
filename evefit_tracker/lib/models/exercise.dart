class Exercise {
  Exercise({
    this.id,
    required this.name,
    required this.muscleGroup,
    required this.isDefault,
    this.notes = '',
  });

  final int? id;
  final String name;
  final String muscleGroup;
  final bool isDefault;
  final String notes;

  factory Exercise.fromMap(Map<String, Object?> map) => Exercise(
    id: map['id'] as int?,
    name: map['name'] as String,
    muscleGroup: map['muscle_group'] as String,
    isDefault: (map['is_default'] as int) == 1,
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'muscle_group': muscleGroup,
    'is_default': isDefault ? 1 : 0,
    'notes': notes,
  };
}
