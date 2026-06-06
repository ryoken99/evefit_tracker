class Profile {
  Profile({
    this.id,
    required this.name,
    required this.pinHash,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    this.heightCm,
    this.birthDate,
    this.sex = '',
    this.trainingLocation = '',
    this.initialGoals = '',
    this.notes = '',
  });

  final int? id;
  final String name;
  final String pinHash;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final double? heightCm;
  final DateTime? birthDate;
  final String sex;
  final String trainingLocation;
  final String initialGoals;
  final String notes;

  factory Profile.fromMap(Map<String, Object?> map) => Profile(
    id: map['id'] as int?,
    name: map['name'] as String,
    pinHash: map['pin_hash'] as String,
    createdAt: DateTime.parse(map['created_at'] as String),
    updatedAt: DateTime.parse(map['updated_at'] as String),
    isActive: (map['is_active'] as int? ?? 0) == 1,
    heightCm: map['height_cm'] == null
        ? null
        : (map['height_cm'] as num).toDouble(),
    birthDate: map['birth_date'] == null
        ? null
        : DateTime.parse(map['birth_date'] as String),
    sex: map['sex'] as String? ?? '',
    trainingLocation: map['training_location'] as String? ?? '',
    initialGoals: map['initial_goals'] as String? ?? '',
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'pin_hash': pinHash,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'is_active': isActive ? 1 : 0,
    'height_cm': heightCm,
    'birth_date': birthDate?.toIso8601String(),
    'sex': sex,
    'training_location': trainingLocation,
    'initial_goals': initialGoals,
    'notes': notes,
  };

  Profile copyWith({
    int? id,
    String? name,
    String? pinHash,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    double? heightCm,
    DateTime? birthDate,
    String? sex,
    String? trainingLocation,
    String? initialGoals,
    String? notes,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      pinHash: pinHash ?? this.pinHash,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      heightCm: heightCm ?? this.heightCm,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
      trainingLocation: trainingLocation ?? this.trainingLocation,
      initialGoals: initialGoals ?? this.initialGoals,
      notes: notes ?? this.notes,
    );
  }
}
