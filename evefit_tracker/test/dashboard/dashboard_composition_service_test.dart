import 'package:evefit_tracker/models/body_measurement.dart';
import 'package:evefit_tracker/models/dashboard_data_snapshot.dart';
import 'package:evefit_tracker/models/dashboard_widget_config.dart';
import 'package:evefit_tracker/models/user_profile.dart';
import 'package:evefit_tracker/models/dashboard_view_model.dart';
import 'package:evefit_tracker/services/dashboard_composition_service.dart';
import 'package:evefit_tracker/services/dashboard_metric_registry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DashboardDataSnapshot snapshot({
    List<String> goals = const [],
    List<DashboardWidgetConfig> preferences = const [],
    List<BodyMeasurement> measurements = const [],
  }) => DashboardDataSnapshot(
    profile: UserProfile(
      name: 'Sandro',
      heightCm: 180,
      startDate: DateTime(2026, 1, 1),
      mainGoal: goals.join(', '),
      notes: '',
    ),
    selectedGoals: goals,
    measurements: measurements,
    workoutsThisWeek: 2,
    dashboardPreferences: preferences,
  );

  DashboardWidgetConfig preference(
    String key, {
    bool enabled = true,
    DateTime? explicit,
    int order = 0,
  }) => DashboardWidgetConfig(
    id: order + 1,
    profileId: 1,
    metricKey: key,
    title: 'Legacy title',
    isVisible: enabled,
    sortOrder: order,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
    explicitlyConfiguredAt: explicit,
  );

  test('registry keys are unique and every allowed key is known', () {
    final keys = DashboardMetricRegistry.entries
        .map((entry) => entry.key)
        .toList();
    expect(keys.toSet().length, keys.length);
    for (final key in DashboardMetricRegistry.allowedMetricKeysFor(const [
      'Construir V-shape',
    ])) {
      expect(DashboardMetricRegistry.entryFor(key), isNotNull);
    }
  });

  test('no goals produces no allowed or visible metrics', () {
    final model = DashboardCompositionService.compose(snapshot());
    expect(model.goalAllowedMetricKeys, isEmpty);
    expect(model.visibleMetricItems, isEmpty);
    expect(model.emptyState, DashboardEmptyState.noGoals);
  });

  test('legacy visibility is preserved but ignored', () {
    final model = DashboardCompositionService.compose(
      snapshot(
        goals: const ['Perder gordura'],
        preferences: [preference('weight')],
      ),
    );
    expect(model.userEnabledMetricKeys, isEmpty);
    expect(model.visibleMetricKeys, isEmpty);
    expect(model.emptyState, DashboardEmptyState.noEnabledMetrics);
  });

  test(
    'visible metrics are the exact allowed explicit intersection in user order',
    () {
      final explicit = DateTime(2026, 7, 10);
      final model = DashboardCompositionService.compose(
        snapshot(
          goals: const ['Perder gordura'],
          preferences: [
            preference('workouts_week', explicit: explicit, order: 0),
            preference('body_fat', explicit: explicit, order: 2),
            preference('weight', explicit: explicit, order: 3),
          ],
        ),
      );
      expect(model.goalAllowedMetricKeys, ['weight', 'body_fat']);
      expect(model.userEnabledMetricKeys, [
        'workouts_week',
        'body_fat',
        'weight',
      ]);
      expect(model.visibleMetricKeys, ['body_fat', 'weight']);
    },
  );

  test(
    'removed and re-added goals preserve explicit preferences without rendering while inactive',
    () {
      final explicit = DateTime(2026, 7, 10);
      final preferences = [preference('shoulders', explicit: explicit)];
      expect(
        DashboardCompositionService.compose(
          snapshot(goals: const ['Melhorar cardio'], preferences: preferences),
        ).visibleMetricKeys,
        isEmpty,
      );
      expect(
        DashboardCompositionService.compose(
          snapshot(
            goals: const ['Construir V-shape'],
            preferences: preferences,
          ),
        ).visibleMetricKeys,
        ['shoulders'],
      );
    },
  );

  test('unknown preference is not rendered and remains a warning', () {
    final model = DashboardCompositionService.compose(
      snapshot(
        goals: const ['Perder gordura'],
        preferences: [
          preference('unknown_metric', explicit: DateTime(2026, 7, 10)),
        ],
      ),
    );
    expect(model.visibleMetricKeys, isEmpty);
    expect(model.warnings, contains(contains('unknown_metric')));
  });

  test(
    'history does not decide visibility and missing data has an explicit label',
    () {
      final model = DashboardCompositionService.compose(
        snapshot(
          goals: const ['Perder gordura'],
          preferences: [preference('weight', explicit: DateTime(2026, 7, 10))],
        ),
      );
      expect(
        model.visibleMetricItems.single.formattedCurrentValue,
        'Sem dados',
      );
      expect(model.visibleMetricItems.single.hasHistory, isFalse);
    },
  );
}
