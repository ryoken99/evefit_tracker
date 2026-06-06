class Goal {
  Goal({
    this.id,
    required this.title,
    required this.description,
    required this.phase,
    required this.isActive,
    required this.createdAt,
    this.completedAt,
  });

  final int? id;
  final String title;
  final String description;
  final String phase;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? completedAt;

  factory Goal.fromMap(Map<String, Object?> map) => Goal(
    id: map['id'] as int?,
    title: map['title'] as String,
    description: map['description'] as String? ?? '',
    phase: map['phase'] as String,
    isActive: (map['is_active'] as int) == 1,
    createdAt: DateTime.parse(map['created_at'] as String),
    completedAt: map['completed_at'] == null
        ? null
        : DateTime.parse(map['completed_at'] as String),
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'phase': phase,
    'is_active': isActive ? 1 : 0,
    'created_at': createdAt.toIso8601String(),
    'completed_at': completedAt?.toIso8601String(),
  };
}
