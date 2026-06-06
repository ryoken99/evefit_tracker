class DashboardWidgetConfig {
  DashboardWidgetConfig({
    this.id,
    required this.profileId,
    required this.metricKey,
    required this.title,
    required this.isVisible,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int profileId;
  final String metricKey;
  final String title;
  final bool isVisible;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory DashboardWidgetConfig.fromMap(Map<String, Object?> map) =>
      DashboardWidgetConfig(
        id: map['id'] as int?,
        profileId: map['profile_id'] as int,
        metricKey: map['metric_key'] as String,
        title: map['title'] as String,
        isVisible: (map['is_visible'] as int) == 1,
        sortOrder: map['sort_order'] as int,
        createdAt: DateTime.parse(map['created_at'] as String),
        updatedAt: DateTime.parse(map['updated_at'] as String),
      );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'metric_key': metricKey,
    'title': title,
    'is_visible': isVisible ? 1 : 0,
    'sort_order': sortOrder,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
