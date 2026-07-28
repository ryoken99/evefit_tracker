import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/main.dart' as app;
import 'package:evefit_tracker/models/body_measurement.dart';
import 'package:evefit_tracker/models/goal.dart';
import 'package:evefit_tracker/models/workout.dart';
import 'package:evefit_tracker/models/workout_exercise.dart';
import 'package:evefit_tracker/models/workout_set.dart';
import 'package:flutter/material.dart' show FocusManager, TextField;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/eft_landing_test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('creates a representative legacy database for upgrade', (
    tester,
  ) async {
    app.main();
    await dismissEftLanding(tester);
    await _pumpUntilFound(
      tester,
      find.text('Configura\u00e7\u00e3o inicial'),
      timeout: const Duration(minutes: 12),
    );
    await tester.tap(find.text('Come\u00e7ar'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextField);
    expect(fields, findsNWidgets(5));
    await tester.enterText(fields.at(0), 'Upgrade laboratory');
    await tester.enterText(fields.at(1), '1234');
    await tester.enterText(fields.at(2), '1234');
    FocusManager.instance.primaryFocus?.unfocus();
    await _tapProfileAction(tester, 'Continuar');
    await _tapProfileAction(tester, 'Continuar');
    await _tapProfileAction(tester, 'Continuar');
    await _tapProfileAction(tester, 'Criar perfil');
    await _pumpUntilFound(tester, find.text('Dashboard'));

    final database = AppDatabase.instance;
    final legacyExercises = await database.exercises();
    expect(legacyExercises, isNotEmpty);
    final legacyExercise = legacyExercises.firstWhere(
      (exercise) => exercise.isDefault,
    );
    await database.insertMeasurement(
      BodyMeasurement(
        date: DateTime(2026, 7, 12),
        weightKg: 80,
        notes: 'upgrade-preserve-measurement',
      ),
    );
    await database.insertGoal(
      Goal(
        title: 'Upgrade preserve goal',
        description: 'must survive',
        phase: 'Base',
        isActive: true,
        createdAt: DateTime(2026, 7, 12),
      ),
    );
    final workoutId = await database.insertWorkout(
      Workout(
        date: DateTime(2026, 7, 12),
        workoutType: 'Treino hist\u00f3rico upgrade',
        notes: 'upgrade-preserve-workout',
      ),
    );
    await database.insertWorkoutExercise(
      WorkoutExercise(
        workoutId: workoutId,
        exerciseId: legacyExercise.id!,
        notes: 'upgrade-preserve-exercise',
      ),
    );
    await database.insertWorkoutSet(
      WorkoutSet(
        workoutId: workoutId,
        exerciseId: legacyExercise.id!,
        setNumber: 1,
        reps: 12,
        notes: 'upgrade-preserve-set',
      ),
    );

    final db = await database.database;
    final counts = await _counts(db);
    expect(counts['profiles'], 1);
    expect(counts['body_measurements'], 1);
    expect(counts['goals']!, greaterThanOrEqualTo(1));
    expect(counts['workouts'], 1);
    expect(counts['workout_sets'], 1);
    expect(counts['workout_exercises'], 1);
    expect(counts['exercises']!, greaterThan(0));
    for (final entry in counts.entries) {
      // ignore: avoid_print
      print('EVEFIT_UPGRADE_BEFORE_${entry.key.toUpperCase()}=${entry.value}');
    }
    // ignore: avoid_print
    print('EVEFIT_UPGRADE_LEGACY_EXERCISE_ID=${legacyExercise.id}');
    // ignore: avoid_print
    print('EVEFIT_UPGRADE_LEGACY_EXERCISE_NAME=${legacyExercise.name}');
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

Future<void> _tapProfileAction(WidgetTester tester, String label) async {
  final target = find.text(label);
  for (var attempt = 0; attempt <= 10; attempt++) {
    if (target.evaluate().isNotEmpty) {
      final center = tester.getCenter(target.last);
      if (center.dy > 24 && center.dy < 950) {
        await tester.tap(target.last);
        await tester.pumpAndSettle();
        return;
      }
    }
    await tester.dragFrom(const Offset(224, 760), const Offset(0, -520));
    await tester.pumpAndSettle();
  }
  expect(target, findsOneWidget);
}

Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 30),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) return;
  }
  expect(finder, findsOneWidget);
}
