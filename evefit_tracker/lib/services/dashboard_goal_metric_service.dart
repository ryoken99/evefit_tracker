import 'dashboard_metric_service.dart';

/// Selects dashboard metrics from the goals actively chosen by the user.
class DashboardGoalMetricService {
  const DashboardGoalMetricService._();

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

  static List<DashboardMetricDefinition> metricsForGoals(
    Iterable<String> selectedGoals,
  ) {
    final metricKeys = <String>{};
    for (final goal in selectedGoals) {
      metricKeys.addAll(_metricKeysByGoal[goal.trim()] ?? const []);
    }

    return DashboardMetricService.definitions
        .where((definition) => metricKeys.contains(definition.key))
        .toList(growable: false);
  }
}
