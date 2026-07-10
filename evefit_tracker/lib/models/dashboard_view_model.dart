class DashboardMetricItem {
  const DashboardMetricItem({
    required this.metricKey,
    required this.title,
    required this.unit,
    required this.formattedCurrentValue,
    required this.chartTitle,
    required this.chartValues,
    required this.supportsCard,
    required this.supportsChart,
    required this.sortOrder,
    required this.hasCurrentValue,
    required this.hasHistory,
  });

  final String metricKey;
  final String title;
  final String unit;
  final String formattedCurrentValue;
  final String chartTitle;
  final List<double?> chartValues;
  final bool supportsCard;
  final bool supportsChart;
  final int sortOrder;
  final bool hasCurrentValue;
  final bool hasHistory;
}

class DashboardEditorMetricOption {
  const DashboardEditorMetricOption({
    required this.metricKey,
    required this.title,
    required this.isEnabled,
    required this.sortOrder,
  });

  final String metricKey;
  final String title;
  final bool isEnabled;
  final int sortOrder;

  DashboardEditorMetricOption copyWith({bool? isEnabled}) =>
      DashboardEditorMetricOption(
        metricKey: metricKey,
        title: title,
        isEnabled: isEnabled ?? this.isEnabled,
        sortOrder: sortOrder,
      );
}

enum DashboardEmptyState { none, noGoals, noEnabledMetrics }

class DashboardViewModel {
  const DashboardViewModel({
    required this.selectedGoals,
    required this.goalAllowedMetricKeys,
    required this.userEnabledMetricKeys,
    required this.visibleMetricKeys,
    required this.visibleMetricItems,
    required this.editorMetricOptions,
    required this.emptyState,
    required this.warnings,
  });

  final List<String> selectedGoals;
  final List<String> goalAllowedMetricKeys;
  final List<String> userEnabledMetricKeys;
  final List<String> visibleMetricKeys;
  final List<DashboardMetricItem> visibleMetricItems;
  final List<DashboardEditorMetricOption> editorMetricOptions;
  final DashboardEmptyState emptyState;
  final List<String> warnings;
}
