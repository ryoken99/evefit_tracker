class GoalMilestone {
  GoalMilestone({
    this.id,
    required this.goalId,
    required this.title,
    this.targetValue,
    this.unit = '',
    this.status = 'locked',
    required this.sortOrder,
    required this.createdAt,
    this.completedAt,
  });

  final int? id;
  final int goalId;
  final String title;
  final double? targetValue;
  final String unit;
  final String status;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime? completedAt;

  factory GoalMilestone.fromMap(Map<String, Object?> map) => GoalMilestone(
    id: map['id'] as int?,
    goalId: map['goal_id'] as int,
    title: map['title'] as String,
    targetValue: map['target_value'] == null
        ? null
        : (map['target_value'] as num).toDouble(),
    unit: map['unit'] as String? ?? '',
    status: map['status'] as String? ?? 'locked',
    sortOrder: map['sort_order'] as int? ?? 0,
    createdAt: DateTime.parse(map['created_at'] as String),
    completedAt: map['completed_at'] == null
        ? null
        : DateTime.parse(map['completed_at'] as String),
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'goal_id': goalId,
    'title': title,
    'target_value': targetValue,
    'unit': unit,
    'status': status,
    'sort_order': sortOrder,
    'created_at': createdAt.toIso8601String(),
    'completed_at': completedAt?.toIso8601String(),
  };
}
