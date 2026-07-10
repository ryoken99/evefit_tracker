import '../models/dashboard_data_snapshot.dart';
import '../models/dashboard_view_model.dart';
import 'dashboard_metric_registry.dart';

class DashboardCompositionService {
  const DashboardCompositionService._();

  static DashboardViewModel compose(DashboardDataSnapshot snapshot) {
    final allowed = DashboardMetricRegistry.allowedMetricKeysFor(
      snapshot.selectedGoals,
    );
    final warnings = <String>[];
    final preferencesByKey = {
      for (final item in snapshot.dashboardPreferences) item.metricKey: item,
    };
    for (final preference in snapshot.dashboardPreferences) {
      if (DashboardMetricRegistry.entryFor(preference.metricKey) == null) {
        warnings.add(
          'Métrica desconhecida preservada: ${preference.metricKey}',
        );
      }
    }
    final explicitEnabled =
        snapshot.dashboardPreferences
            .where(
              (item) =>
                  item.explicitlyConfiguredAt != null &&
                  item.isVisible &&
                  DashboardMetricRegistry.entryFor(item.metricKey) != null,
            )
            .toList()
          ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final enabledKeys = explicitEnabled.map((item) => item.metricKey).toList();
    final visibleKeys = enabledKeys.where(allowed.contains).toList();
    final visibleItems = <DashboardMetricItem>[
      for (final key in visibleKeys)
        if (DashboardMetricRegistry.entryFor(key) case final entry?)
          DashboardMetricItem(
            metricKey: key,
            title: entry.title,
            unit: entry.unit,
            formattedCurrentValue:
                entry.currentValueFor(
                      snapshot.latestMeasurement,
                      workoutsThisWeek: snapshot.workoutsThisWeek,
                      daysSinceStart: snapshot.daysSinceStart,
                    ) ==
                    '-'
                ? 'Sem dados'
                : entry.currentValueFor(
                    snapshot.latestMeasurement,
                    workoutsThisWeek: snapshot.workoutsThisWeek,
                    daysSinceStart: snapshot.daysSinceStart,
                  ),
            chartTitle: entry.chartTitle,
            chartValues: entry.historyFor(snapshot.measurements),
            supportsCard: entry.supportsCard,
            supportsChart: entry.supportsChart,
            sortOrder: preferencesByKey[key]?.sortOrder ?? entry.stableOrder,
            hasCurrentValue:
                entry.currentValueFor(
                  snapshot.latestMeasurement,
                  workoutsThisWeek: snapshot.workoutsThisWeek,
                  daysSinceStart: snapshot.daysSinceStart,
                ) !=
                '-',
            hasHistory:
                entry
                    .historyFor(snapshot.measurements)
                    .whereType<double>()
                    .length >=
                2,
          ),
    ];
    final options = <DashboardEditorMetricOption>[
      for (final key in allowed)
        if (DashboardMetricRegistry.entryFor(key) case final entry?)
          DashboardEditorMetricOption(
            metricKey: key,
            title: entry.title,
            isEnabled:
                preferencesByKey[key]?.explicitlyConfiguredAt != null &&
                preferencesByKey[key]!.isVisible,
            sortOrder: preferencesByKey[key]?.sortOrder ?? entry.stableOrder,
          ),
    ]..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final emptyState = snapshot.selectedGoals.isEmpty
        ? DashboardEmptyState.noGoals
        : visibleItems.isEmpty
        ? DashboardEmptyState.noEnabledMetrics
        : DashboardEmptyState.none;
    return DashboardViewModel(
      selectedGoals: List.unmodifiable(snapshot.selectedGoals),
      goalAllowedMetricKeys: List.unmodifiable(allowed),
      userEnabledMetricKeys: List.unmodifiable(enabledKeys),
      visibleMetricKeys: List.unmodifiable(visibleKeys),
      visibleMetricItems: List.unmodifiable(visibleItems),
      editorMetricOptions: List.unmodifiable(options),
      emptyState: emptyState,
      warnings: List.unmodifiable(warnings),
    );
  }
}
