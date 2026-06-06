class UserProfile {
  UserProfile({
    this.id,
    required this.name,
    required this.heightCm,
    required this.startDate,
    required this.mainGoal,
    required this.notes,
  });

  final int? id;
  final String name;
  final double heightCm;
  final DateTime startDate;
  final String mainGoal;
  final String notes;

  factory UserProfile.fromMap(Map<String, Object?> map) => UserProfile(
    id: map['id'] as int?,
    name: map['name'] as String,
    heightCm: (map['height_cm'] as num).toDouble(),
    startDate: DateTime.parse(map['start_date'] as String),
    mainGoal: map['main_goal'] as String,
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'height_cm': heightCm,
    'start_date': startDate.toIso8601String(),
    'main_goal': mainGoal,
    'notes': notes,
  };
}
