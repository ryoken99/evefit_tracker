class Goal {
  Goal({
    this.id,
    this.profileId,
    required this.title,
    required this.description,
    required this.phase,
    this.category = 'Outro',
    this.metricKey = 'manual',
    this.initialValue,
    this.targetValue,
    this.unit = '',
    this.startDate,
    this.targetDate,
    this.manualProgress,
    this.notes = '',
    required this.isActive,
    required this.createdAt,
    this.completedAt,
  });

  final int? id;
  final int? profileId;
  final String title;
  final String description;
  final String phase;
  final String category;
  final String metricKey;
  final double? initialValue;
  final double? targetValue;
  final String unit;
  final DateTime? startDate;
  final DateTime? targetDate;
  final double? manualProgress;
  final String notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? completedAt;

  factory Goal.fromMap(Map<String, Object?> map) => Goal(
    id: map['id'] as int?,
    profileId: map['profile_id'] as int?,
    title: map['title'] as String,
    description: map['description'] as String? ?? '',
    phase: map['phase'] as String,
    category: map['category'] as String? ?? 'Outro',
    metricKey: map['metric_key'] as String? ?? 'manual',
    initialValue: map['initial_value'] == null
        ? null
        : (map['initial_value'] as num).toDouble(),
    targetValue: map['target_value'] == null
        ? null
        : (map['target_value'] as num).toDouble(),
    unit: map['unit'] as String? ?? '',
    startDate: map['start_date'] == null
        ? null
        : DateTime.parse(map['start_date'] as String),
    targetDate: map['target_date'] == null
        ? null
        : DateTime.parse(map['target_date'] as String),
    manualProgress: map['manual_progress'] == null
        ? null
        : (map['manual_progress'] as num).toDouble(),
    notes: map['notes'] as String? ?? '',
    isActive: (map['is_active'] as int) == 1,
    createdAt: DateTime.parse(map['created_at'] as String),
    completedAt: map['completed_at'] == null
        ? null
        : DateTime.parse(map['completed_at'] as String),
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'title': title,
    'description': description,
    'phase': phase,
    'category': category,
    'metric_key': metricKey,
    'initial_value': initialValue,
    'target_value': targetValue,
    'unit': unit,
    'start_date': startDate?.toIso8601String(),
    'target_date': targetDate?.toIso8601String(),
    'manual_progress': manualProgress,
    'notes': notes,
    'is_active': isActive ? 1 : 0,
    'created_at': createdAt.toIso8601String(),
    'completed_at': completedAt?.toIso8601String(),
  };
}
