import 'dart:io';

import 'package:evefit_tracker/app.dart';
import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:evefit_tracker/models/progress_photo.dart';
import 'package:evefit_tracker/models/workout.dart';
import 'package:evefit_tracker/screens/profile_gate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('iOS declares camera and gallery permission reasons in PT-PT', () {
    final plist = File('ios/Runner/Info.plist').readAsStringSync();

    expect(plist, contains('NSCameraUsageDescription'));
    expect(plist, contains('NSPhotoLibraryUsageDescription'));
    expect(plist, contains('NSPhotoLibraryAddUsageDescription'));
    expect(plist, contains('fotos de progresso'));
  });

  test(
    'database configure hook enables foreign keys and reports orphans',
    () async {
      final db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      addTearDown(db.close);
      await db.execute(
        'CREATE TABLE workouts(id INTEGER PRIMARY KEY, profile_id INTEGER)',
      );
      await db.execute(
        'CREATE TABLE exercises(id INTEGER PRIMARY KEY, profile_id INTEGER)',
      );
      await db.execute(
        'CREATE TABLE workout_sets('
        'id INTEGER PRIMARY KEY, workout_id INTEGER, exercise_id INTEGER, '
        'profile_id INTEGER)',
      );
      await db.insert('workout_sets', {
        'id': 1,
        'workout_id': 404,
        'exercise_id': 505,
        'profile_id': 1,
      });

      final issues = await AppDatabase.configureDatabaseConnection(db);
      final pragma = await db.rawQuery('PRAGMA foreign_keys');

      expect(pragma.single['foreign_keys'], 1);
      expect(issues.map((issue) => issue.table), contains('workout_sets'));
      expect(
        issues.map((issue) => issue.description),
        containsAll({
          'workout_id -> workouts.id',
          'exercise_id -> exercises.id',
        }),
      );
    },
  );

  test('workout and photo maps can omit immutable ids for updates', () {
    final workout = Workout(
      id: 7,
      profileId: 3,
      date: DateTime(2026, 7, 8),
      workoutType: 'Musculação',
    );
    final photo = ProgressPhoto(
      id: 8,
      profileId: 3,
      date: DateTime(2026, 7, 8),
      photoType: 'Frente',
      filePath: '/tmp/photo.jpg',
    );

    expect(workout.toMap(forUpdate: true), isNot(contains('id')));
    expect(photo.toMap(forUpdate: true), isNot(contains('id')));
    expect(workout.toMap(), containsPair('id', 7));
    expect(photo.toMap(), containsPair('id', 8));
  });

  testWidgets('profile gate shows retryable error when profiles fail to load', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProfileGateScreen(
          database: AppDatabase.instance,
          onUnlocked: (_) {},
          profilesLoader: () => Future<List<Profile>>.error(StateError('boom')),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Não foi possível carregar os perfis.'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);
  });

  testWidgets('main navigation preserves tab state with IndexedStack', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EveFitHome(
          database: AppDatabase.instance,
          onProfileLocked: () {},
        ),
      ),
    );

    expect(find.byType(IndexedStack), findsOneWidget);
  });

  test('APK build artifacts are not tracked by Git', () async {
    final result = await Process.run('git', [
      'ls-files',
      '*.apk',
      '*.apk.sha1',
      'build/app/outputs/flutter-apk/app-release.apk',
      'build/app/outputs/flutter-apk/app-debug.apk',
    ]);

    expect(result.exitCode, 0);
    expect((result.stdout as String).trim(), isEmpty);
  });
}
