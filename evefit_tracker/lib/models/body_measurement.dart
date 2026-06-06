class BodyMeasurement {
  BodyMeasurement({
    this.id,
    this.profileId,
    required this.date,
    this.weightKg,
    this.bmi,
    this.bodyFatPercentage,
    this.muscleMassKg,
    this.musclePercentage,
    this.bodyWaterPercentage,
    this.proteinPercentage,
    this.subcutaneousFatPercentage,
    this.visceralFat,
    this.boneMassKg,
    this.basalMetabolismKcal,
    this.bodyAge,
    this.neckCm,
    this.leftBicepRelaxedCm,
    this.leftBicepFlexedCm,
    this.rightBicepRelaxedCm,
    this.rightBicepFlexedCm,
    this.leftTricepCm,
    this.rightTricepCm,
    this.leftForearmCm,
    this.rightForearmCm,
    this.leftWristCm,
    this.rightWristCm,
    this.leftHandCm,
    this.rightHandCm,
    this.shouldersCm,
    this.chestCm,
    this.upperChestCm,
    this.midChestCm,
    this.lowerChestCm,
    this.backWidthCm,
    this.waistCm,
    this.sideHipAreaCm,
    this.abdomenCm,
    this.hipsCm,
    this.glutesCm,
    this.leftThighCm,
    this.rightThighCm,
    this.leftUpperThighCm,
    this.leftMidThighCm,
    this.rightUpperThighCm,
    this.rightMidThighCm,
    this.leftCalfCm,
    this.rightCalfCm,
    this.leftAnkleCm,
    this.rightAnkleCm,
    this.skinfoldChestMm,
    this.skinfoldAbdominalMm,
    this.skinfoldSuprailiacMm,
    this.skinfoldSubscapularMm,
    this.skinfoldTricepsMm,
    this.skinfoldMidaxillaryMm,
    this.skinfoldThighMm,
    this.notes = '',
  });

  final int? id;
  final int? profileId;
  final DateTime date;
  final double? weightKg;
  final double? bmi;
  final double? bodyFatPercentage;
  final double? muscleMassKg;
  final double? musclePercentage;
  final double? bodyWaterPercentage;
  final double? proteinPercentage;
  final double? subcutaneousFatPercentage;
  final double? visceralFat;
  final double? boneMassKg;
  final double? basalMetabolismKcal;
  final double? bodyAge;
  final double? neckCm;
  final double? leftBicepRelaxedCm;
  final double? leftBicepFlexedCm;
  final double? rightBicepRelaxedCm;
  final double? rightBicepFlexedCm;
  final double? leftTricepCm;
  final double? rightTricepCm;
  final double? leftForearmCm;
  final double? rightForearmCm;
  final double? leftWristCm;
  final double? rightWristCm;
  final double? leftHandCm;
  final double? rightHandCm;
  final double? shouldersCm;
  final double? chestCm;
  final double? upperChestCm;
  final double? midChestCm;
  final double? lowerChestCm;
  final double? backWidthCm;
  final double? waistCm;
  final double? sideHipAreaCm;
  final double? abdomenCm;
  final double? hipsCm;
  final double? glutesCm;
  final double? leftThighCm;
  final double? rightThighCm;
  final double? leftUpperThighCm;
  final double? leftMidThighCm;
  final double? rightUpperThighCm;
  final double? rightMidThighCm;
  final double? leftCalfCm;
  final double? rightCalfCm;
  final double? leftAnkleCm;
  final double? rightAnkleCm;
  final double? skinfoldChestMm;
  final double? skinfoldAbdominalMm;
  final double? skinfoldSuprailiacMm;
  final double? skinfoldSubscapularMm;
  final double? skinfoldTricepsMm;
  final double? skinfoldMidaxillaryMm;
  final double? skinfoldThighMm;
  final String notes;

  factory BodyMeasurement.fromMap(Map<String, Object?> map) => BodyMeasurement(
    id: map['id'] as int?,
    profileId: map['profile_id'] as int?,
    date: DateTime.parse(map['date'] as String),
    weightKg: _d(map['weight_kg']),
    bmi: _d(map['bmi']),
    bodyFatPercentage: _d(map['body_fat_percentage']),
    muscleMassKg: _d(map['muscle_mass_kg']),
    musclePercentage: _d(map['muscle_percentage']),
    bodyWaterPercentage: _d(map['body_water_percentage']),
    proteinPercentage: _d(map['protein_percentage']),
    subcutaneousFatPercentage: _d(map['subcutaneous_fat_percentage']),
    visceralFat: _d(map['visceral_fat']),
    boneMassKg: _d(map['bone_mass_kg']),
    basalMetabolismKcal: _d(map['basal_metabolism_kcal']),
    bodyAge: _d(map['body_age']),
    neckCm: _d(map['neck_cm']),
    leftBicepRelaxedCm: _d(map['left_bicep_relaxed_cm']),
    leftBicepFlexedCm: _d(map['left_bicep_flexed_cm']),
    rightBicepRelaxedCm: _d(map['right_bicep_relaxed_cm']),
    rightBicepFlexedCm: _d(map['right_bicep_flexed_cm']),
    leftTricepCm: _d(map['left_tricep_cm']),
    rightTricepCm: _d(map['right_tricep_cm']),
    leftForearmCm: _d(map['left_forearm_cm']),
    rightForearmCm: _d(map['right_forearm_cm']),
    leftWristCm: _d(map['left_wrist_cm']),
    rightWristCm: _d(map['right_wrist_cm']),
    leftHandCm: _d(map['left_hand_cm']),
    rightHandCm: _d(map['right_hand_cm']),
    shouldersCm: _d(map['shoulders_cm']),
    chestCm: _d(map['chest_cm']),
    upperChestCm: _d(map['upper_chest_cm']),
    midChestCm: _d(map['mid_chest_cm']),
    lowerChestCm: _d(map['lower_chest_cm']),
    backWidthCm: _d(map['back_width_cm']),
    waistCm: _d(map['waist_cm']),
    sideHipAreaCm: _d(map['side_hip_area_cm']),
    abdomenCm: _d(map['abdomen_cm']),
    hipsCm: _d(map['hips_cm']),
    glutesCm: _d(map['glutes_cm']),
    leftThighCm: _d(map['left_thigh_cm']),
    rightThighCm: _d(map['right_thigh_cm']),
    leftUpperThighCm: _d(map['left_upper_thigh_cm']),
    leftMidThighCm: _d(map['left_mid_thigh_cm']),
    rightUpperThighCm: _d(map['right_upper_thigh_cm']),
    rightMidThighCm: _d(map['right_mid_thigh_cm']),
    leftCalfCm: _d(map['left_calf_cm']),
    rightCalfCm: _d(map['right_calf_cm']),
    leftAnkleCm: _d(map['left_ankle_cm']),
    rightAnkleCm: _d(map['right_ankle_cm']),
    skinfoldChestMm: _d(map['skinfold_chest_mm']),
    skinfoldAbdominalMm: _d(map['skinfold_abdominal_mm']),
    skinfoldSuprailiacMm: _d(map['skinfold_suprailiac_mm']),
    skinfoldSubscapularMm: _d(map['skinfold_subscapular_mm']),
    skinfoldTricepsMm: _d(map['skinfold_triceps_mm']),
    skinfoldMidaxillaryMm: _d(map['skinfold_midaxillary_mm']),
    skinfoldThighMm: _d(map['skinfold_thigh_mm']),
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'date': date.toIso8601String(),
    'weight_kg': weightKg,
    'bmi': bmi,
    'body_fat_percentage': bodyFatPercentage,
    'muscle_mass_kg': muscleMassKg,
    'muscle_percentage': musclePercentage,
    'body_water_percentage': bodyWaterPercentage,
    'protein_percentage': proteinPercentage,
    'subcutaneous_fat_percentage': subcutaneousFatPercentage,
    'visceral_fat': visceralFat,
    'bone_mass_kg': boneMassKg,
    'basal_metabolism_kcal': basalMetabolismKcal,
    'body_age': bodyAge,
    'neck_cm': neckCm,
    'left_bicep_relaxed_cm': leftBicepRelaxedCm,
    'left_bicep_flexed_cm': leftBicepFlexedCm,
    'right_bicep_relaxed_cm': rightBicepRelaxedCm,
    'right_bicep_flexed_cm': rightBicepFlexedCm,
    'left_tricep_cm': leftTricepCm,
    'right_tricep_cm': rightTricepCm,
    'left_forearm_cm': leftForearmCm,
    'right_forearm_cm': rightForearmCm,
    'left_wrist_cm': leftWristCm,
    'right_wrist_cm': rightWristCm,
    'left_hand_cm': leftHandCm,
    'right_hand_cm': rightHandCm,
    'shoulders_cm': shouldersCm,
    'chest_cm': chestCm,
    'upper_chest_cm': upperChestCm,
    'mid_chest_cm': midChestCm,
    'lower_chest_cm': lowerChestCm,
    'back_width_cm': backWidthCm,
    'waist_cm': waistCm,
    'side_hip_area_cm': sideHipAreaCm,
    'abdomen_cm': abdomenCm,
    'hips_cm': hipsCm,
    'glutes_cm': glutesCm,
    'left_thigh_cm': leftThighCm,
    'right_thigh_cm': rightThighCm,
    'left_upper_thigh_cm': leftUpperThighCm,
    'left_mid_thigh_cm': leftMidThighCm,
    'right_upper_thigh_cm': rightUpperThighCm,
    'right_mid_thigh_cm': rightMidThighCm,
    'left_calf_cm': leftCalfCm,
    'right_calf_cm': rightCalfCm,
    'left_ankle_cm': leftAnkleCm,
    'right_ankle_cm': rightAnkleCm,
    'skinfold_chest_mm': skinfoldChestMm,
    'skinfold_abdominal_mm': skinfoldAbdominalMm,
    'skinfold_suprailiac_mm': skinfoldSuprailiacMm,
    'skinfold_subscapular_mm': skinfoldSubscapularMm,
    'skinfold_triceps_mm': skinfoldTricepsMm,
    'skinfold_midaxillary_mm': skinfoldMidaxillaryMm,
    'skinfold_thigh_mm': skinfoldThighMm,
    'notes': notes,
  };

  static double? _d(Object? value) =>
      value == null ? null : (value as num).toDouble();
}
