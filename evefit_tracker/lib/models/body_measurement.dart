class BodyMeasurement {
  BodyMeasurement({
    this.id,
    this.profileId,
    required this.date,
    this.heightCm,
    this.weightKg,
    this.bmi,
    this.scaleBmi,
    this.calculatedBmi,
    this.bodyScore,
    this.bodyFatPercentage,
    this.fatMassKg,
    this.fatFreeBodyWeightKg,
    this.muscleMassKg,
    this.musclePercentage,
    this.skeletalMuscleMassKg,
    this.boneMassKg,
    this.bodyWaterPercentage,
    this.proteinPercentage,
    this.subcutaneousFatPercentage,
    this.visceralFat,
    this.basalMetabolismKcal,
    this.bodyAge,
    this.standardWeightKg,
    this.weightControlKg,
    this.fatControlKg,
    this.muscleControlKg,
    this.restingHeartRateBpm,
    this.bodyType = '',
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
    this.waistToHipRatio,
    this.waistToHeightRatio,
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
    this.bicepsSkinfoldMm,
    this.medialCalfSkinfoldMm,
    this.notes = '',
  });

  final int? id;
  final int? profileId;
  final DateTime date;
  final double? heightCm;
  final double? weightKg;
  final double? bmi;
  final double? scaleBmi;
  final double? calculatedBmi;
  final double? bodyScore;
  final double? bodyFatPercentage;
  final double? fatMassKg;
  final double? fatFreeBodyWeightKg;
  final double? muscleMassKg;
  final double? musclePercentage;
  final double? skeletalMuscleMassKg;
  final double? boneMassKg;
  final double? bodyWaterPercentage;
  final double? proteinPercentage;
  final double? subcutaneousFatPercentage;
  final double? visceralFat;
  final double? basalMetabolismKcal;
  final double? bodyAge;
  final double? standardWeightKg;
  final double? weightControlKg;
  final double? fatControlKg;
  final double? muscleControlKg;
  final double? restingHeartRateBpm;
  final String bodyType;
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
  final double? waistToHipRatio;
  final double? waistToHeightRatio;
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
  final double? bicepsSkinfoldMm;
  final double? medialCalfSkinfoldMm;
  final String notes;

  factory BodyMeasurement.fromMap(Map<String, Object?> map) => BodyMeasurement(
    id: map['id'] as int?,
    profileId: map['profile_id'] as int?,
    date: DateTime.parse(map['date'] as String),
    heightCm: _d(map['height_cm']),
    weightKg: _d(map['weight_kg']),
    bmi: _d(map['bmi']),
    scaleBmi: _d(map['scale_bmi']),
    calculatedBmi: _d(map['calculated_bmi']),
    bodyScore: _d(map['body_score']),
    bodyFatPercentage: _d(map['body_fat_percentage']),
    fatMassKg: _d(map['fat_mass_kg']),
    fatFreeBodyWeightKg: _d(map['fat_free_body_weight_kg']),
    muscleMassKg: _d(map['muscle_mass_kg']),
    musclePercentage: _d(map['muscle_percentage']),
    skeletalMuscleMassKg: _d(map['skeletal_muscle_mass_kg']),
    boneMassKg: _d(map['bone_mass_kg']),
    bodyWaterPercentage: _d(map['body_water_percentage']),
    proteinPercentage: _d(map['protein_percentage']),
    subcutaneousFatPercentage: _d(map['subcutaneous_fat_percentage']),
    visceralFat: _d(map['visceral_fat']),
    basalMetabolismKcal: _d(map['basal_metabolism_kcal']),
    bodyAge: _d(map['body_age']),
    standardWeightKg: _d(map['standard_weight_kg']),
    weightControlKg: _d(map['weight_control_kg']),
    fatControlKg: _d(map['fat_control_kg']),
    muscleControlKg: _d(map['muscle_control_kg']),
    restingHeartRateBpm: _d(map['resting_heart_rate_bpm']),
    bodyType: map['body_type'] as String? ?? '',
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
    chestCm: _d(map['chest_cm']) ?? _d(map['chest_total_cm']),
    upperChestCm: _d(map['upper_chest_cm']) ?? _d(map['chest_upper_cm']),
    midChestCm: _d(map['mid_chest_cm']) ?? _d(map['chest_middle_cm']),
    lowerChestCm: _d(map['lower_chest_cm']) ?? _d(map['chest_lower_cm']),
    backWidthCm: _d(map['back_width_cm']),
    waistCm: _d(map['waist_cm']),
    sideHipAreaCm: _d(map['side_hip_area_cm']),
    abdomenCm: _d(map['abdomen_cm']),
    hipsCm: _d(map['hips_cm']),
    glutesCm: _d(map['glutes_cm']),
    waistToHipRatio: _d(map['waist_to_hip_ratio']),
    waistToHeightRatio: _d(map['waist_to_height_ratio']),
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
    skinfoldChestMm:
        _d(map['chest_skinfold_mm']) ?? _d(map['skinfold_chest_mm']),
    skinfoldAbdominalMm:
        _d(map['abdominal_skinfold_mm']) ?? _d(map['skinfold_abdominal_mm']),
    skinfoldSuprailiacMm:
        _d(map['suprailiac_skinfold_mm']) ?? _d(map['skinfold_suprailiac_mm']),
    skinfoldSubscapularMm:
        _d(map['subscapular_skinfold_mm']) ??
        _d(map['skinfold_subscapular_mm']),
    skinfoldTricepsMm:
        _d(map['triceps_skinfold_mm']) ?? _d(map['skinfold_triceps_mm']),
    skinfoldMidaxillaryMm:
        _d(map['midaxillary_skinfold_mm']) ??
        _d(map['skinfold_midaxillary_mm']),
    skinfoldThighMm:
        _d(map['thigh_skinfold_mm']) ?? _d(map['skinfold_thigh_mm']),
    bicepsSkinfoldMm: _d(map['biceps_skinfold_mm']),
    medialCalfSkinfoldMm: _d(map['medial_calf_skinfold_mm']),
    notes: map['notes'] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'profile_id': profileId,
    'date': date.toIso8601String(),
    'height_cm': heightCm,
    'weight_kg': weightKg,
    'bmi': bmi ?? calculatedBmi ?? scaleBmi,
    'scale_bmi': scaleBmi,
    'calculated_bmi': calculatedBmi,
    'body_score': bodyScore,
    'body_fat_percentage': bodyFatPercentage,
    'fat_mass_kg': fatMassKg,
    'fat_free_body_weight_kg': fatFreeBodyWeightKg,
    'muscle_mass_kg': muscleMassKg,
    'muscle_percentage': musclePercentage,
    'skeletal_muscle_mass_kg': skeletalMuscleMassKg,
    'bone_mass_kg': boneMassKg,
    'body_water_percentage': bodyWaterPercentage,
    'protein_percentage': proteinPercentage,
    'subcutaneous_fat_percentage': subcutaneousFatPercentage,
    'visceral_fat': visceralFat,
    'basal_metabolism_kcal': basalMetabolismKcal,
    'body_age': bodyAge,
    'standard_weight_kg': standardWeightKg,
    'weight_control_kg': weightControlKg,
    'fat_control_kg': fatControlKg,
    'muscle_control_kg': muscleControlKg,
    'resting_heart_rate_bpm': restingHeartRateBpm,
    'body_type': bodyType,
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
    'chest_total_cm': chestCm,
    'upper_chest_cm': upperChestCm,
    'chest_upper_cm': upperChestCm,
    'mid_chest_cm': midChestCm,
    'chest_middle_cm': midChestCm,
    'lower_chest_cm': lowerChestCm,
    'chest_lower_cm': lowerChestCm,
    'back_width_cm': backWidthCm,
    'waist_cm': waistCm,
    'side_hip_area_cm': sideHipAreaCm,
    'abdomen_cm': abdomenCm,
    'hips_cm': hipsCm,
    'glutes_cm': glutesCm,
    'waist_to_hip_ratio': waistToHipRatio,
    'waist_to_height_ratio': waistToHeightRatio,
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
    'chest_skinfold_mm': skinfoldChestMm,
    'skinfold_abdominal_mm': skinfoldAbdominalMm,
    'abdominal_skinfold_mm': skinfoldAbdominalMm,
    'skinfold_suprailiac_mm': skinfoldSuprailiacMm,
    'suprailiac_skinfold_mm': skinfoldSuprailiacMm,
    'skinfold_subscapular_mm': skinfoldSubscapularMm,
    'subscapular_skinfold_mm': skinfoldSubscapularMm,
    'skinfold_triceps_mm': skinfoldTricepsMm,
    'triceps_skinfold_mm': skinfoldTricepsMm,
    'skinfold_midaxillary_mm': skinfoldMidaxillaryMm,
    'midaxillary_skinfold_mm': skinfoldMidaxillaryMm,
    'skinfold_thigh_mm': skinfoldThighMm,
    'thigh_skinfold_mm': skinfoldThighMm,
    'biceps_skinfold_mm': bicepsSkinfoldMm,
    'medial_calf_skinfold_mm': medialCalfSkinfoldMm,
    'notes': notes,
  };

  static double? _d(Object? value) =>
      value == null ? null : (value as num).toDouble();
}
