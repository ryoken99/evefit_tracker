import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/main.dart' as app;
import 'package:evefit_tracker/services/startup_catalog_diagnostics.dart';
import 'package:flutter/material.dart' show TextField, ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/eft_landing_test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('upgrade preserves personal data and historical exercise joins', (
    tester,
  ) async {
    app.main();
    await dismissEftLanding(tester);
    await _pumpUntilFound(tester, find.text('Entrar'));
    final pin = find.byType(TextField);
    expect(pin, findsOneWidget);
    await tester.enterText(pin, '1234');
    await tester.tap(find.text('Entrar'));
    await _pumpUntilFound(tester, find.text('Dashboard'));

    final database = AppDatabase.instance;
    final db = await database.database;
    final counts = await _counts(db);
    expect(counts['profiles'], 1);
    expect(counts['body_measurements'], 1);
    expect(counts['goals']!, greaterThanOrEqualTo(1));
    expect(counts['workouts'], 1);
    expect(counts['workout_sets'], 1);
    expect(counts['workout_exercises'], 1);
    expect(counts['exercises']!, greaterThan(0));
    expect(await db.rawQuery('PRAGMA foreign_key_check'), isEmpty);

    final workouts = await database.workouts();
    expect(workouts, hasLength(1));
    expect(workouts.single.workout.notes, 'upgrade-preserve-workout');
    expect(workouts.single.sets.single.notes, 'upgrade-preserve-set');
    expect(workouts.single.exercises.single.notes, 'upgrade-preserve-exercise');
    expect(workouts.single.exerciseCount, 1);

    final diagnostics = StartupCatalogDiagnostics.snapshot;
    expect(diagnostics.legacySeedExecuted, isFalse);
    expect(diagnostics.legacyEntriesProcessed, 0);

    await tester.tap(find.text('Treinos'));
    await _pumpUntilFound(tester, find.text('Treino hist\u00f3rico upgrade'));
    await tester.tap(find.text('Treino hist\u00f3rico upgrade'));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_detail_add_exercise')),
    );
    await tester.tap(find.byKey(const ValueKey('workout_detail_add_exercise')));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('canonical_core_root_screen')),
    );
    expect(find.text('Mostrar todos'), findsNothing);
    expect(find.text('Exerc\u00edcio legacy hist\u00f3rico'), findsNothing);

    for (final entry in counts.entries) {
      // ignore: avoid_print
      print('EVEFIT_UPGRADE_AFTER_${entry.key.toUpperCase()}=${entry.value}');
    }
    // ignore: avoid_print
    print('EVEFIT_UPGRADE_LEGACY_SEED_EXECUTED=false');
    // ignore: avoid_print
    print('EVEFIT_UPGRADE_LEGACY_ENTRIES_PROCESSED=0');
  });
}

Future<Map<String, int>> _counts(dynamic db) async => {
  for (final table in const [
    'profiles',
    'body_measurements',
    'goals',
    'workouts',
    'workout_sets',
    'workout_exercises',
    'exercises',
  ])
    table:
        ((await db.rawQuery('SELECT COUNT(*) AS c FROM $table')).single['c']
            as int),
};

Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 45),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) return;
  }
  expect(finder, findsOneWidget);
}
