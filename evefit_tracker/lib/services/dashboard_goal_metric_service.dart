import 'dashboard_metric_registry.dart';
import 'dashboard_metric_service.dart';

/// Compatibility adapter. Dashboard visibility is composed by
/// [DashboardCompositionService], not by this legacy API.
@Deprecated('Use DashboardMetricRegistry.allowedMetricKeysFor instead.')
class DashboardGoalMetricService {
  const DashboardGoalMetricService._();

  static List<DashboardMetricDefinition> metricsForGoals(
    Iterable<String> selectedGoals,
  ) => DashboardMetricRegistry.allowedMetricKeysFor(
    selectedGoals,
  ).map(DashboardMetricService.definitionFor).toList(growable: false);
}
