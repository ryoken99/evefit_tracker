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
      key: 'avg_biceps_flexed',
      title: 'Braço contraído',
      unit: 'cm',
    ),
    DashboardMetricDefinition(key: 'shoulders', title: 'Ombros', unit: 'cm'),
    DashboardMetricDefinition(
      key: 'side_hip_area',
      title: 'Zona lateral acima da anca',
      unit: 'cm',
    ),
    DashboardMetricDefinition(key: 'waist', title: 'Cintura', unit: 'cm'),
    DashboardMetricDefinition(key: 'abdomen', title: 'Abdómen', unit: 'cm'),
    DashboardMetricDefinition(key: 'hips', title: 'Anca', unit: 'cm'),
    DashboardMetricDefinition(key: 'chest', title: 'Peito', unit: 'cm'),
    DashboardMetricDefinition(
      key: 'workouts_week',
      title: 'Treinos esta semana',
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
    int? daysSinceStart,
  }) {
    if (key == 'workouts_week') return '${workoutsThisWeek ?? 0}';
    if (key == 'days_since_start') return '${daysSinceStart ?? 0}';
    final value = numericValueFor(key, measurement);
    if (value == null) return '-';
    final unit = definitionFor(key).unit;
    return unit.isEmpty
        ? value.toStringAsFixed(0)
        : '${value.toStringAsFixed(1)} $unit';
  }

  static double? numericValueFor(String key, BodyMeasurement? measurement) {
    if (measurement == null) return null;
    return switch (key) {
      'weight' => measurement.weightKg,
      'body_fat' => measurement.bodyFatPercentage,
      'muscle_mass' => measurement.muscleMassKg,
      'avg_biceps_flexed' => DashboardStatsService.flexedArmCm(measurement),
      'shoulders' => measurement.shouldersCm,
      'side_hip_area' => measurement.sideHipAreaCm,
      'waist' => measurement.waistCm,
      'abdomen' => measurement.abdomenCm,
      'hips' => measurement.hipsCm,
      'chest' => measurement.chestCm,
      'bmi' => measurement.bmi,
      'visceral_fat' => measurement.visceralFat,
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
