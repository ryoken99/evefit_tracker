class BodyMeasurement {
  BodyMeasurement({
    this.id,
    this.profileId,
    required this.date,
    this.weightKg,
    this.bodyFatPercentage,
    this.muscleMassKg,
    this.leftBicepRelaxedCm,
    this.leftBicepFlexedCm,
    this.rightBicepRelaxedCm,
    this.rightBicepFlexedCm,
    this.shouldersCm,
    this.chestCm,
    this.waistCm,
    this.sideHipAreaCm,
    this.abdomenCm,
    this.hipsCm,
    this.leftThighCm,
    this.rightThighCm,
    this.leftCalfCm,
    this.rightCalfCm,
    this.notes = '',
  });

  final int? id;
  final int? profileId;
  final DateTime date;
  final double? weightKg;
  final double? bodyFatPercentage;
  final double? muscleMassKg;
  final double? leftBicepRelaxedCm;
  final double? leftBicepFlexedCm;
  final double? rightBicepRelaxedCm;
  final double? rightBicepFlexedCm;
  final double? shouldersCm;
  final double? chestCm;
  final double? waistCm;
  final double? sideHipAreaCm;
  final double? abdomenCm;
  final double? hipsCm;
  final double? leftThighCm;
  final double? rightThighCm;
  final double? leftCalfCm;
  final double? rightCalfCm;
  final String notes;

  factory BodyMeasurement.fromMap(Map<String, Object?> map) => BodyMeasurement(
    id: map['id'] as int?,
    profileId: map['profile_id'] as int?,
    date: DateTime.parse(map['date'] as String),
    weightKg: _d(map['weight_kg']),
    bodyFatPercentage: _d(map['body_fat_percentage']),
    muscleMassKg: _d(map['muscle_mass_kg']),
    leftBicepRelaxedCm: _d(map['left_bicep_relaxed_cm']),
    leftBicepFlexedCm: _d(map['left_bicep_flexed_cm']),
    rightBicepRelaxedCm: _d(map['right_bicep_relaxed_cm']),
    rightBicepFlexedCm: _d(map['right_bicep_flexed_cm']),
    shouldersCm: _d(map['shoulders_cm']),
    chestCm: _d(map['chest_cm']),
    waistCm: _d(map['waist_cm']),
    sideHipAreaCm: _d(map['side_hip_area_cm']),
    abdomenCm: _d(map['abdomen_cm']),
    hipsCm: _d(map['hips_cm']),
    leftThighCm: _d(map['left_thigh_cm']),
    rightThighCm: _d(map['right_thigh_cm']),
    leftCalfCm: _d(map['left_calf_cm']),
    rightCalfCm: _d(map['right_calf_cm']),
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'date': date.toIso8601String(),
    'weight_kg': weightKg,
    'body_fat_percentage': bodyFatPercentage,
    'muscle_mass_kg': muscleMassKg,
    'left_bicep_relaxed_cm': leftBicepRelaxedCm,
    'left_bicep_flexed_cm': leftBicepFlexedCm,
    'right_bicep_relaxed_cm': rightBicepRelaxedCm,
    'right_bicep_flexed_cm': rightBicepFlexedCm,
    'shoulders_cm': shouldersCm,
    'chest_cm': chestCm,
    'waist_cm': waistCm,
    'side_hip_area_cm': sideHipAreaCm,
    'abdomen_cm': abdomenCm,
    'hips_cm': hipsCm,
    'left_thigh_cm': leftThighCm,
    'right_thigh_cm': rightThighCm,
    'left_calf_cm': leftCalfCm,
    'right_calf_cm': rightCalfCm,
    'notes': notes,
  };

  static double? _d(Object? value) =>
      value == null ? null : (value as num).toDouble();
}
