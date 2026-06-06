class Profile {
  Profile({
    this.id,
    required this.name,
    required this.pinHash,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    this.notes = '',
  });

  final int? id;
  final String name;
  final String pinHash;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final String notes;

  bool get usesDefaultPin => notes.contains('PIN_PADRAO_1234');

  factory Profile.fromMap(Map<String, Object?> map) => Profile(
    id: map['id'] as int?,
    name: map['name'] as String,
    pinHash: map['pin_hash'] as String,
    createdAt: DateTime.parse(map['created_at'] as String),
    updatedAt: DateTime.parse(map['updated_at'] as String),
    isActive: (map['is_active'] as int? ?? 0) == 1,
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'pin_hash': pinHash,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'is_active': isActive ? 1 : 0,
    'notes': notes,
  };

  Profile copyWith({
    int? id,
    String? name,
    String? pinHash,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    String? notes,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      pinHash: pinHash ?? this.pinHash,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
    );
  }
}
