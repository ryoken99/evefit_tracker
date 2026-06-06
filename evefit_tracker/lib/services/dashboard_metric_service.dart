import '../models/body_measurement.dart';
import 'dashboard_stats_service.dart';

class DashboardMetricDefinition {
  const DashboardMetricDefinition({
    required this.key,
    required this.title,
    required this.unit,
  });

  final String key;
  final String title;
  final String unit;
}

class DashboardMetricService {
  const DashboardMetricService._();

  static const definitions = [
    DashboardMetricDefinition(key: 'weight', title: 'Peso atual', unit: 'kg'),
    DashboardMetricDefinition(key: 'bmi', title: 'IMC', unit: ''),
    DashboardMetricDefinition(
      key: 'scale_bmi',
      title: 'IMC da balança',
      unit: '',
    ),
    DashboardMetricDefinition(
      key: 'body_score',
      title: 'Pontuação corporal',
      unit: '',
    ),
    DashboardMetricDefinition(
      key: 'body_fat',
      title: 'Gordura corporal',
      unit: '%',
    ),
    DashboardMetricDefinition(
      key: 'muscle_mass',
      title: 'Massa muscular',
      unit: 'kg',
    ),
    DashboardMetricDefinition(
      key: 'fat_mass',
      title: 'Massa gorda',
      unit: 'kg',
    ),
    DashboardMetricDefinition(
      key: 'fat_free_body_weight',
      title: 'Peso sem gordura',
      unit: 'kg',
    ),
    DashboardMetricDefinition(
      key: 'muscle_percentage',
      title: 'Percentagem muscular',
      unit: '%',
    ),
    DashboardMetricDefinition(
      key: 'body_water',
      title: 'Água corporal',
      unit: '%',
    ),
    DashboardMetricDefinition(
      key: 'protein',
      title: 'Proteína corporal',
      unit: '%',
    ),
    DashboardMetricDefinition(
      key: 'subcutaneous_fat',
      title: 'Gordura subcutânea',
      unit: '%',
    ),
    DashboardMetricDefinition(
      key: 'visceral_fat',
      title: 'Gordura visceral',
      unit: '',
    ),
    DashboardMetricDefinition(
      key: 'bone_mass',
      title: 'Massa óssea',
      unit: 'kg',
    ),
    DashboardMetricDefinition(
      key: 'basal_metabolism',
      title: 'Metabolismo basal',
      unit: 'kcal',
    ),
    DashboardMetricDefinition(
      key: 'skeletal_muscle_mass',
      title: 'Massa muscular esquelética',
      unit: 'kg',
    ),
    DashboardMetricDefinition(
      key: 'body_age',
      title: 'Idade corporal',
      unit: 'anos',
    ),
    DashboardMetricDefinition(
      key: 'resting_heart_rate',
      title: 'Frequência cardíaca em repouso',
      unit: 'bpm',
    ),
    DashboardMetricDefinition(key: 'neck', title: 'Pescoço', unit: 'cm'),
    DashboardMetricDefinition(key: 'shoulders', title: 'Ombros', unit: 'cm'),
    DashboardMetricDefinition(
      key: 'upper_chest',
      title: 'Peito alto',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'mid_chest',
      title: 'Peito médio',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'lower_chest',
      title: 'Peito baixo',
      unit: 'cm',
    ),
    DashboardMetricDefinition(key: 'chest', title: 'Peito total', unit: 'cm'),
    DashboardMetricDefinition(
      key: 'back_width',
      title: 'Costas / largura dorsal',
      unit: 'cm',
    ),
    DashboardMetricDefinition(key: 'waist', title: 'Cintura', unit: 'cm'),
    DashboardMetricDefinition(
      key: 'abdomen',
      title: 'Abdómen ao nível do umbigo',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'side_hip_area',
      title: 'Zona lateral acima da anca',
      unit: 'cm',
    ),
    DashboardMetricDefinition(key: 'hips', title: 'Anca', unit: 'cm'),
    DashboardMetricDefinition(key: 'glutes', title: 'Glúteos', unit: 'cm'),
    DashboardMetricDefinition(
      key: 'waist_to_hip_ratio',
      title: 'Relação cintura/anca',
      unit: '',
    ),
    DashboardMetricDefinition(
      key: 'waist_to_height_ratio',
      title: 'Relação cintura/altura',
      unit: '',
    ),
    DashboardMetricDefinition(
      key: 'left_bicep_relaxed',
      title: 'Bíceps esquerdo relaxado',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'left_bicep_flexed',
      title: 'Bíceps esquerdo contraído',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'right_bicep_relaxed',
      title: 'Bíceps direito relaxado',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'right_bicep_flexed',
      title: 'Bíceps direito contraído',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'avg_biceps_flexed',
      title: 'Média dos bíceps contraídos',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'left_forearm',
      title: 'Antebraço esquerdo',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'right_forearm',
      title: 'Antebraço direito',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'left_wrist',
      title: 'Punho esquerdo',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'right_wrist',
      title: 'Punho direito',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'left_hand',
      title: 'Mão esquerda',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'right_hand',
      title: 'Mão direita',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'left_upper_thigh',
      title: 'Coxa esquerda alta',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'left_mid_thigh',
      title: 'Coxa esquerda média',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'right_upper_thigh',
      title: 'Coxa direita alta',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'right_mid_thigh',
      title: 'Coxa direita média',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'left_calf',
      title: 'Gémeo esquerdo',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'right_calf',
      title: 'Gémeo direito',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'left_ankle',
      title: 'Tornozelo esquerdo',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'right_ankle',
      title: 'Tornozelo direito',
      unit: 'cm',
    ),
    DashboardMetricDefinition(
      key: 'workouts_week',
      title: 'Treinos esta semana',
      unit: '',
    ),
    DashboardMetricDefinition(
      key: 'workouts_month',
      title: 'Treinos este mês',
      unit: '',
    ),
    DashboardMetricDefinition(
      key: 'sets_week',
      title: 'Número de séries esta semana',
      unit: '',
    ),
    DashboardMetricDefinition(
      key: 'exercises_week',
      title: 'Número de exercícios esta semana',
      unit: '',
    ),
    DashboardMetricDefinition(
      key: 'days_since_start',
      title: 'Dias desde início',
      unit: '',
    ),
  ];

  static const defaultKeys = [
    'weight',
    'avg_biceps_flexed',
    'shoulders',
    'side_hip_area',
    'workouts_week',
    'days_since_start',
  ];

  static DashboardMetricDefinition definitionFor(String key) => definitions
      .firstWhere((item) => item.key == key, orElse: () => definitions.first);

  static String valueFor(
    String key,
    BodyMeasurement? measurement, {
    int? workoutsThisWeek,
    int? workoutsThisMonth,
    int? setsThisWeek,
    int? exercisesThisWeek,
    int? daysSinceStart,
  }) {
    if (key == 'workouts_week') return '${workoutsThisWeek ?? 0}';
    if (key == 'workouts_month') return '${workoutsThisMonth ?? 0}';
    if (key == 'sets_week') return '${setsThisWeek ?? 0}';
    if (key == 'exercises_week') return '${exercisesThisWeek ?? 0}';
    if (key == 'days_since_start') return '${daysSinceStart ?? 0}';
    final value = numericValueFor(key, measurement);
    if (value == null) return '-';
    final unit = definitionFor(key).unit;
    return unit.isEmpty
        ? value.toStringAsFixed(1)
        : '${value.toStringAsFixed(1)} $unit';
  }

  static double? numericValueFor(String key, BodyMeasurement? measurement) {
    if (measurement == null) return null;
    return switch (key) {
      'weight' => measurement.weightKg,
      'bmi' =>
        measurement.calculatedBmi ?? measurement.bmi ?? measurement.scaleBmi,
      'scale_bmi' => measurement.scaleBmi,
      'body_score' => measurement.bodyScore,
      'body_fat' => measurement.bodyFatPercentage,
      'muscle_mass' => measurement.muscleMassKg,
      'fat_mass' => measurement.fatMassKg,
      'fat_free_body_weight' => measurement.fatFreeBodyWeightKg,
      'muscle_percentage' => measurement.musclePercentage,
      'body_water' => measurement.bodyWaterPercentage,
      'protein' => measurement.proteinPercentage,
      'subcutaneous_fat' => measurement.subcutaneousFatPercentage,
      'visceral_fat' => measurement.visceralFat,
      'bone_mass' => measurement.boneMassKg,
      'skeletal_muscle_mass' => measurement.skeletalMuscleMassKg,
      'basal_metabolism' => measurement.basalMetabolismKcal,
      'body_age' => measurement.bodyAge,
      'resting_heart_rate' => measurement.restingHeartRateBpm,
      'neck' => measurement.neckCm,
      'shoulders' => measurement.shouldersCm,
      'upper_chest' => measurement.upperChestCm,
      'mid_chest' => measurement.midChestCm,
      'lower_chest' => measurement.lowerChestCm,
      'chest' => measurement.chestCm,
      'back_width' => measurement.backWidthCm,
      'waist' => measurement.waistCm,
      'abdomen' => measurement.abdomenCm,
      'side_hip_area' => measurement.sideHipAreaCm,
      'hips' => measurement.hipsCm,
      'glutes' => measurement.glutesCm,
      'waist_to_hip_ratio' => measurement.waistToHipRatio,
      'waist_to_height_ratio' => measurement.waistToHeightRatio,
      'left_bicep_relaxed' => measurement.leftBicepRelaxedCm,
      'left_bicep_flexed' => measurement.leftBicepFlexedCm,
      'right_bicep_relaxed' => measurement.rightBicepRelaxedCm,
      'right_bicep_flexed' => measurement.rightBicepFlexedCm,
      'avg_biceps_flexed' => DashboardStatsService.flexedArmCm(measurement),
      'left_forearm' => measurement.leftForearmCm,
      'right_forearm' => measurement.rightForearmCm,
      'left_wrist' => measurement.leftWristCm,
      'right_wrist' => measurement.rightWristCm,
      'left_hand' => measurement.leftHandCm,
      'right_hand' => measurement.rightHandCm,
      'left_upper_thigh' =>
        measurement.leftUpperThighCm ?? measurement.leftThighCm,
      'left_mid_thigh' => measurement.leftMidThighCm,
      'right_upper_thigh' =>
        measurement.rightUpperThighCm ?? measurement.rightThighCm,
      'right_mid_thigh' => measurement.rightMidThighCm,
      'left_calf' => measurement.leftCalfCm,
      'right_calf' => measurement.rightCalfCm,
      'left_ankle' => measurement.leftAnkleCm,
      'right_ankle' => measurement.rightAnkleCm,
      _ => null,
    };
  }

  static List<double?> valuesFor(
    String key,
    List<BodyMeasurement> measurements,
  ) => measurements
      .map((measurement) => numericValueFor(key, measurement))
      .toList();
}
