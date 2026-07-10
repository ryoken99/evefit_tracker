import 'body_measurement.dart';
import 'dashboard_widget_config.dart';
import 'user_profile.dart';

class DashboardDataSnapshot {
  const DashboardDataSnapshot({
    required this.profile,
    required this.selectedGoals,
    required this.measurements,
    required this.workoutsThisWeek,
    required this.dashboardPreferences,
  });

  final UserProfile profile;
  final List<String> selectedGoals;
  final List<BodyMeasurement> measurements;
  final int workoutsThisWeek;
  final List<DashboardWidgetConfig> dashboardPreferences;

  BodyMeasurement? get latestMeasurement =>
      measurements.isEmpty ? null : measurements.first;
  int get daysSinceStart => DateTime.now().difference(profile.startDate).inDays;
}
