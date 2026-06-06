class ProfileEquipment {
  ProfileEquipment({
    this.id,
    required this.profileId,
    required this.equipmentKey,
    required this.equipmentName,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int profileId;
  final String equipmentKey;
  final String equipmentName;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ProfileEquipment.fromMap(Map<String, Object?> map) =>
      ProfileEquipment(
        id: map['id'] as int?,
        profileId: map['profile_id'] as int,
        equipmentKey: map['equipment_key'] as String,
        equipmentName: map['equipment_name'] as String,
        isAvailable: (map['is_available'] as int? ?? 0) == 1,
        createdAt: DateTime.parse(map['created_at'] as String),
        updatedAt: DateTime.parse(map['updated_at'] as String),
      );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'equipment_key': equipmentKey,
    'equipment_name': equipmentName,
    'is_available': isAvailable ? 1 : 0,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
