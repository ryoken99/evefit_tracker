import 'package:evefit_tracker/main.dart' as app;
import 'package:evefit_tracker/app.dart' as evefit_app;
import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/body_measurement.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:flutter/material.dart' show FocusManager, UniqueKey, ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

const _weightGoal = 'Ganhar peso';
const _pin = '1234';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Dashboard respects explicit metric preferences across profiles',
    (tester) async {
      final database = AppDatabase.instance;
      await database.database;

      final firstProfile = await database.createProfile(
        name: 'Dashboard integration A',
        pin: _pin,
        trainingLocations: const ['Ginásio'],
      );
      final secondProfile = await database.createProfile(
        name: 'Dashboard integration B',
        pin: _pin,
        trainingLocations: const ['Ginásio'],
      );
      await database.setActiveProfile(firstProfile);
      await database.insertMeasurement(
        BodyMeasurement(
          profileId: firstProfile.id,
          date: DateTime.utc(2026, 7, 11),
          weightKg: 72.4,
        ),
      );

      app.main();
      await _unlockProfile(tester, firstProfile);
      await binding.convertFlutterSurfaceToImage();

      _logScenario('dashboard_no_goals');
      expect(
        find.byKey(const ValueKey('dashboard_empty_no_goals')),
        findsOneWidget,
      );
      expect(_dashboardItemsWithPrefix('dashboard_card_'), findsNothing);
      expect(_dashboardItemsWithPrefix('dashboard_chart_'), findsNothing);
      await tester.tap(find.byKey(const ValueKey('dashboard_edit_button')));
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('dashboard_editor_cancel')),
      );
      expect(
        find.byKey(const ValueKey('dashboard_metric_switch_weight')),
        findsNothing,
      );
      await tester.tap(find.byKey(const ValueKey('dashboard_editor_cancel')));
      await tester.pumpAndSettle();
      await _screenshot(binding, tester, 'dashboard_no_goals');

      final firstWithGoal = firstProfile.copyWith(initialGoals: _weightGoal);
      await database.updateProfile(firstWithGoal);
      await _restartAndUnlock(tester, firstWithGoal);
      _logScenario('dashboard_no_active_metrics');
      expect(
        find.byKey(const ValueKey('dashboard_empty_no_metrics')),
        findsOneWidget,
      );
      expect(_dashboardItemsWithPrefix('dashboard_card_'), findsNothing);
      expect(_dashboardItemsWithPrefix('dashboard_chart_'), findsNothing);
      expect(
        find.byKey(const ValueKey('dashboard_edit_button')),
        findsOneWidget,
      );
      await _screenshot(binding, tester, 'dashboard_no_active_metrics');

      await tester.tap(find.byKey(const ValueKey('dashboard_edit_button')));
      _logScenario('dashboard_enable_weight');
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('dashboard_metric_switch_weight')),
      );
      await tester.tap(
        find.byKey(const ValueKey('dashboard_metric_switch_weight')),
      );
      await _saveDashboardEditor(tester);
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('dashboard_card_weight')),
      );
      expect(
        find.byKey(const ValueKey('dashboard_chart_weight')),
        findsOneWidget,
      );
      expect(_dashboardItemsWithPrefix('dashboard_card_').evaluate().length, 1);
      await _screenshot(binding, tester, 'dashboard_editor_weight_enabled');
      await _screenshot(binding, tester, 'dashboard_after_save_weight');

      await _restartAndUnlock(tester, firstWithGoal);
      _logScenario('dashboard_after_restart');
      expect(
        find.byKey(const ValueKey('dashboard_card_weight')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('dashboard_chart_weight')),
        findsOneWidget,
      );
      expect(_dashboardItemsWithPrefix('dashboard_card_').evaluate().length, 1);
      await _screenshot(binding, tester, 'dashboard_after_restart');

      await tester.tap(find.byKey(const ValueKey('dashboard_edit_button')));
      _logScenario('dashboard_disable_weight');
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('dashboard_metric_switch_weight')),
      );
      await tester.tap(
        find.byKey(const ValueKey('dashboard_metric_switch_weight')),
      );
      await _saveDashboardEditor(tester);
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('dashboard_empty_no_metrics')),
      );
      expect(find.byKey(const ValueKey('dashboard_card_weight')), findsNothing);
      expect(
        find.byKey(const ValueKey('dashboard_chart_weight')),
        findsNothing,
      );
      expect((await database.measurements()).length, 1);
      await _screenshot(binding, tester, 'dashboard_after_disable');

      await tester.tap(find.byKey(const ValueKey('dashboard_edit_button')));
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('dashboard_metric_switch_weight')),
      );
      await tester.tap(
        find.byKey(const ValueKey('dashboard_metric_switch_weight')),
      );
      await _saveDashboardEditor(tester);
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('dashboard_card_weight')),
      );

      final firstWithoutGoal = firstWithGoal.copyWith(initialGoals: '');
      await database.updateProfile(firstWithoutGoal);
      await _restartAndUnlock(tester, firstWithoutGoal);
      _logScenario('dashboard_goal_removed');
      expect(
        find.byKey(const ValueKey('dashboard_empty_no_goals')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('dashboard_card_weight')), findsNothing);
      final hiddenPreference = (await database.dashboardWidgets()).singleWhere(
        (widget) => widget.metricKey == 'weight',
      );
      expect(hiddenPreference.isVisible, isTrue);
      expect(hiddenPreference.explicitlyConfiguredAt, isNotNull);
      await _screenshot(binding, tester, 'dashboard_goal_removed');

      await database.updateProfile(firstWithGoal);
      await _restartAndUnlock(tester, firstWithGoal);
      _logScenario('dashboard_goal_readded');
      expect(
        find.byKey(const ValueKey('dashboard_card_weight')),
        findsOneWidget,
      );
      expect(_dashboardItemsWithPrefix('dashboard_card_').evaluate().length, 1);
      await _screenshot(binding, tester, 'dashboard_goal_readded');

      await database.setActiveProfile(secondProfile);
      await _restartAndUnlock(tester, secondProfile);
      _logScenario('dashboard_second_profile');
      expect(
        find.byKey(const ValueKey('dashboard_empty_no_goals')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('dashboard_card_weight')), findsNothing);
      expect(
        find.byKey(const ValueKey('dashboard_chart_weight')),
        findsNothing,
      );
      await _screenshot(binding, tester, 'dashboard_second_profile');
    },
  );
}

Finder _dashboardItemsWithPrefix(String prefix) => find.byWidgetPredicate(
  (widget) =>
      widget.key is ValueKey<String> &&
      (widget.key! as ValueKey<String>).value.startsWith(prefix),
);

Future<void> _unlockProfile(WidgetTester tester, Profile profile) async {
  await _pumpUntilFound(
    tester,
    find.byKey(ValueKey('profile_option_${profile.id}')),
  );
  await tester.tap(find.byKey(ValueKey('profile_option_${profile.id}')));
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('profile_unlock_pin')),
  );
  await tester.enterText(
    find.byKey(const ValueKey('profile_unlock_pin')),
    _pin,
  );
  await tester.tap(find.byKey(const ValueKey('profile_unlock_submit')));
  FocusManager.instance.primaryFocus?.unfocus();
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('dashboard_edit_button')),
  );
}

Future<void> _restartAndUnlock(WidgetTester tester, Profile profile) async {
  await tester.pumpWidget(evefit_app.EveFitApp(key: UniqueKey()));
  await tester.pumpAndSettle();
  await _unlockProfile(tester, profile);
}

Future<void> _saveDashboardEditor(WidgetTester tester) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  final save = find.byKey(const ValueKey('dashboard_editor_save'));
  await tester.ensureVisible(save);
  await tester.tap(save);
  await tester.pump();
}

Future<void> _pumpUntilFound(WidgetTester tester, Finder finder) async {
  final deadline = DateTime.now().add(const Duration(seconds: 20));
  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) return;
  }
  expect(finder, findsOneWidget);
}

Future<void> _screenshot(
  IntegrationTestWidgetsFlutterBinding binding,
  WidgetTester tester,
  String name,
) async {
  await tester.pump();
  final image = await binding.takeScreenshot(name);
  expect(image, isNotEmpty);
}

void _logScenario(String name) {
  // Keeps scenario boundaries in the device and driver logs.
  // ignore: avoid_print
  print('DASHBOARD_INTEGRATION_SCENARIO=$name');
}
