class ProgressPhoto {
  ProgressPhoto({
    this.id,
    this.profileId,
    required this.date,
    required this.photoType,
    required this.filePath,
    this.weightKg,
    this.notes = '',
  });

  final int? id;
  final int? profileId;
  final DateTime date;
  final String photoType;
  final String filePath;
  final double? weightKg;
  final String notes;

  factory ProgressPhoto.fromMap(Map<String, Object?> map) => ProgressPhoto(
    id: map['id'] as int?,
    profileId: map['profile_id'] as int?,
    date: DateTime.parse(map['date'] as String),
    photoType: map['photo_type'] as String,
    filePath: map['file_path'] as String,
    weightKg: map['weight_kg'] == null
        ? null
        : (map['weight_kg'] as num).toDouble(),
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'date': date.toIso8601String(),
    'photo_type': photoType,
    'file_path': filePath,
    'weight_kg': weightKg,
    'notes': notes,
  };
}
