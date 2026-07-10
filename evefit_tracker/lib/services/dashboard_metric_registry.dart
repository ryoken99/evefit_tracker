import '../models/body_measurement.dart';
import 'dashboard_metric_service.dart';

class DashboardMetricRegistryEntry {
  const DashboardMetricRegistryEntry({
    required this.key,
    required this.title,
    required this.unit,
    required this.supportsCard,
    required this.supportsChart,
    required this.stableOrder,
    required this.chartTitle,
  });

  final String key;
  final String title;
  final String unit;
  final bool supportsCard;
  final bool supportsChart;
  final int stableOrder;
  final String chartTitle;

  String currentValueFor(
    BodyMeasurement? measurement, {
    required int workoutsThisWeek,
    required int daysSinceStart,
  }) => DashboardMetricService.valueFor(
    key,
    measurement,
    workoutsThisWeek: workoutsThisWeek,
    daysSinceStart: daysSinceStart,
  );

  List<double?> historyFor(List<BodyMeasurement> measurements) =>
      DashboardMetricService.valuesFor(key, measurements);
}

class DashboardMetricRegistry {
  const DashboardMetricRegistry._();

  static const _chartKeys = <String>{
    'weight',
    'bmi',
    'body_fat',
    'muscle_mass',
    'waist',
    'chest',
    'visceral_fat',
    'basal_metabolism',
    'avg_biceps_flexed',
    'side_hip_area',
    'shoulders',
  };

  static const _metricKeysByGoal = <String, List<String>>{
    'Ganhar massa muscular': ['weight', 'muscle_mass'],
    'Aumentar massa muscular': ['weight', 'muscle_mass'],
    'Perder gordura': ['weight', 'body_fat'],
    'Recomposição corporal': ['weight', 'muscle_mass', 'body_fat'],
    'Manutenção': ['weight'],
    'Ganhar peso': ['weight'],
    'Perder peso': ['weight'],
    'Definir abdominal': ['body_fat', 'waist', 'abdomen'],
    'Reduzir cintura': ['waist'],
    'Melhorar percentagem de gordura': ['body_fat'],
    'Construir V-shape': ['shoulders', 'back_width', 'waist'],
    'Aumentar costas': ['back_width'],
    'Aumentar ombros': ['shoulders'],
    'Aumentar peito': ['chest'],
    'Aumentar braços': ['avg_biceps_flexed'],
    'Aumentar glúteos': ['glutes'],
    'Aumentar pernas': ['left_upper_thigh', 'right_upper_thigh'],
    'Melhorar postura': ['shoulders', 'back_width'],
    'Ficar mais atlético': ['muscle_mass', 'body_fat'],
    'Ganhar força geral': ['sets_week', 'workouts_week'],
    'Melhorar força no supino': ['sets_week'],
    'Melhorar força no agachamento': ['sets_week'],
    'Melhorar força no peso morto': ['sets_week'],
    'Melhorar força de pega': ['sets_week'],
    'Melhorar força de core': ['sets_week'],
    'Melhorar resistência muscular': ['sets_week', 'workouts_week'],
    'Melhorar cardio': ['workouts_week', 'resting_heart_rate'],
    'Caminhar mais': ['workouts_week', 'days_since_start'],
    'Correr mais tempo': ['workouts_week', 'resting_heart_rate'],
    'Melhorar resistência aeróbia': ['workouts_week', 'resting_heart_rate'],
    'Melhorar velocidade': ['workouts_week'],
    'Melhorar recuperação': ['resting_heart_rate'],
    'Melhorar saúde geral': ['workouts_week', 'resting_heart_rate'],
    'Melhorar mobilidade': ['workouts_week'],
    'Melhorar elasticidade': ['workouts_week'],
    'Melhorar mobilidade de ombros': ['shoulders'],
    'Melhorar mobilidade de anca': ['hips'],
    'Melhorar mobilidade de tornozelos': ['left_ankle', 'right_ankle'],
    'Reduzir dores': ['workouts_week'],
    'Recuperar melhor': ['resting_heart_rate'],
    'Melhorar performance no Karate': ['workouts_week', 'sets_week'],
    'Melhorar performance no Jiu-Jitsu': ['workouts_week', 'sets_week'],
    'Melhorar explosão': ['sets_week'],
    'Melhorar deslocamento': ['workouts_week'],
    'Melhorar core para artes marciais': ['sets_week'],
    'Melhorar força de pega para grappling': ['sets_week'],
    'Melhorar mobilidade para pontapés': ['hips', 'left_ankle', 'right_ankle'],
    'Melhorar condicionamento para combate': [
      'workouts_week',
      'resting_heart_rate',
    ],
    'Treinar com consistência': ['workouts_week'],
    'Treinar 2 vezes por semana': ['workouts_week'],
    'Treinar 3 vezes por semana': ['workouts_week'],
    'Treinar 4 vezes por semana': ['workouts_week'],
    'Treinar 5 vezes por semana': ['workouts_week'],
    'Criar rotina de treino': ['workouts_week'],
    'Voltar a treinar depois de pausa': ['workouts_week'],
    'Outro': ['workouts_week'],
  };

  static final entries = List<DashboardMetricRegistryEntry>.unmodifiable([
    for (
      var index = 0;
      index < DashboardMetricService.definitions.length;
      index++
    )
      DashboardMetricRegistryEntry(
        key: DashboardMetricService.definitions[index].key,
        title: DashboardMetricService.definitions[index].title,
        unit: DashboardMetricService.definitions[index].unit,
        supportsCard: true,
        supportsChart: _chartKeys.contains(
          DashboardMetricService.definitions[index].key,
        ),
        stableOrder: index,
        chartTitle:
            '${DashboardMetricService.definitions[index].title} ao longo do tempo',
      ),
  ]);

  static DashboardMetricRegistryEntry? entryFor(String key) {
    for (final entry in entries) {
      if (entry.key == key) return entry;
    }
    return null;
  }

  static List<String> allowedMetricKeysFor(Iterable<String> selectedGoals) {
    final keys = <String>{};
    for (final goal in selectedGoals) {
      keys.addAll(_metricKeysByGoal[goal.trim()] ?? const []);
    }
    return entries
        .where((entry) => keys.contains(entry.key))
        .map((entry) => entry.key)
        .toList();
  }
}
