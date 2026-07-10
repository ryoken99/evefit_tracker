import 'package:evefit_tracker/services/dashboard_goal_metric_service.dart';
import 'package:evefit_tracker/services/dashboard_metric_service.dart';
import 'package:evefit_tracker/services/profile_preferences_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<String> metricKeysFor(Iterable<String> goals) =>
      DashboardGoalMetricService.metricsForGoals(
        goals,
      ).map((metric) => metric.key).toList();

  test('no selected goals produces no dashboard metric cards', () {
    expect(metricKeysFor(const []), isEmpty);
  });

  test('one selected goal produces only its metrics', () {
    expect(metricKeysFor(const ['Construir V-shape']), [
      'shoulders',
      'back_width',
      'waist',
    ]);
  });

  test('multiple goals produce their exact metric union', () {
    expect(metricKeysFor(const ['Perder gordura', 'Melhorar cardio']), [
      'weight',
      'body_fat',
      'resting_heart_rate',
      'workouts_week',
    ]);
  });

  test('shared metrics are not duplicated', () {
    final metricKeys = metricKeysFor(const [
      'Ganhar força geral',
      'Melhorar força no supino',
    ]);

    expect(metricKeys, ['workouts_week', 'sets_week']);
    expect(metricKeys.toSet().length, metricKeys.length);
  });

  test('removing a goal removes its metric cards immediately', () {
    expect(
      metricKeysFor(const ['Perder gordura', 'Melhorar cardio']),
      contains('resting_heart_rate'),
    );
    expect(
      metricKeysFor(const ['Perder gordura']),
      isNot(contains('resting_heart_rate')),
    );
  });

  test('adding a goal adds its metric cards immediately', () {
    expect(
      metricKeysFor(const ['Perder gordura']),
      isNot(contains('resting_heart_rate')),
    );
    expect(
      metricKeysFor(const ['Perder gordura', 'Melhorar cardio']),
      contains('resting_heart_rate'),
    );
  });

  test('historical metrics do not become visible without active goals', () {
    const persistedHistoricalMetricKeys = ['weight', 'body_fat'];

    expect(persistedHistoricalMetricKeys, isNotEmpty);
    expect(metricKeysFor(const []), isEmpty);
  });

  test('an unselected V-shape never exposes its exclusive metrics', () {
    final metricKeys = metricKeysFor(const ['Melhorar cardio']);

    expect(metricKeys, isNot(contains('shoulders')));
    expect(metricKeys, isNot(contains('back_width')));
  });

  test('available goals do not influence displayed dashboard cards', () {
    final availableGoals = ProfilePreferencesService.generalGoalSections
        .expand((section) => section.options)
        .toList();

    expect(availableGoals, contains('Construir V-shape'));
    expect(metricKeysFor(const ['Melhorar cardio']), [
      'resting_heart_rate',
      'workouts_week',
    ]);
  });

  test('default metrics are not used as a fallback', () {
    expect(DashboardMetricService.defaultKeys, isNotEmpty);
    expect(metricKeysFor(const []), isEmpty);
  });
}
