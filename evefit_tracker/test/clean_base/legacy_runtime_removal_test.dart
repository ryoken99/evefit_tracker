import 'dart:io';

import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:evefit_tracker/services/clean_base_config.dart';
import 'package:evefit_tracker/services/startup_catalog_diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test(
    'clean schema has zero legacy exercises and no catalogue seed',
    () async {
      final db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      addTearDown(db.close);
      await AppDatabase.configureDatabaseConnection(db);

      final database = AppDatabase.forTesting(db);
      await database.initializeSchemaForTesting();

      expect(await _count(db, 'exercises'), 0);
      expect(await _count(db, 'profile_equipment'), 0);
      expect(await _tableExists(db, 'exercise_identity_aliases'), isFalse);
      expect(await _tableExists(db, 'body_regions'), isFalse);
      expect(await _tableExists(db, 'workout_focuses'), isFalse);
      expect(await _tableExists(db, 'equipment'), isFalse);
      expect(StartupCatalogDiagnostics.snapshot.legacySeedExecuted, isFalse);
      expect(StartupCatalogDiagnostics.snapshot.legacyEntriesProcessed, 0);
      expect(const CanonicalRegistry().approvedPillarValues, hasLength(12));
      expect(CleanBaseConfig.canonicalCatalogueHasActiveExercises, isFalse);
    },
  );

  test(
    'historical exercise references and personal data survive upgrade',
    () async {
      final db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      addTearDown(db.close);
      await AppDatabase.configureDatabaseConnection(db);
      final schema = AppDatabase.forTesting(db);
      await schema.initializeSchemaForTesting();

      final now = DateTime(2026, 7, 12).toIso8601String();
      await db.insert('profiles', {
        'id': 1,
        'name': 'Perfil histórico',
        'pin_hash': 'hash',
        'created_at': now,
        'updated_at': now,
        'is_active': 1,
        'initial_goals': 'Ganhar força',
      });
      await db.insert('exercises', {
        'id': 77,
        'name': 'Exercício legacy histórico',
        'muscle_group': 'Peito',
        'is_default': 1,
        'notes': 'preservar',
      });
      await db.insert('workouts', {
        'id': 9,
        'profile_id': 1,
        'date': now,
        'workout_type': 'Treino histórico',
        'notes': 'preservar treino',
      });
      await db.insert('workout_sets', {
        'id': 10,
        'profile_id': 1,
        'workout_id': 9,
        'exercise_id': 77,
        'set_number': 1,
        'reps': 12,
      });
      await db.insert('workout_exercises', {
        'id': 11,
        'profile_id': 1,
        'workout_id': 9,
        'exercise_id': 77,
        'notes': 'referência histórica',
      });
      await db.insert('body_measurements', {
        'id': 12,
        'profile_id': 1,
        'date': now,
        'weight_kg': 80.0,
      });
      await db.insert('goals', {
        'id': 13,
        'profile_id': 1,
        'title': 'Ganhar força',
        'phase': 'Base',
        'is_active': 1,
        'created_at': now,
      });

      final before = await _personalCounts(db);
      final database = AppDatabase.forTesting(
        db,
        activeProfile: Profile(
          id: 1,
          name: 'Perfil histórico',
          pinHash: 'hash',
          createdAt: DateTime(2026, 7, 12),
          updatedAt: DateTime(2026, 7, 12),
          isActive: true,
        ),
      );
      await database.upgradeSchemaForTesting(oldVersion: 21);
      await database.refreshCatalogExercises(db);

      expect(await _personalCounts(db), before);
      expect((await database.workouts()).single.exerciseCount, 1);
      expect((await database.workouts()).single.sets.single.exerciseId, 77);
      expect((await db.query('exercises')).single['notes'], 'preservar');
      expect(await db.rawQuery('PRAGMA foreign_key_check'), isEmpty);
      expect(StartupCatalogDiagnostics.snapshot.legacySeedExecuted, isFalse);
      expect(StartupCatalogDiagnostics.snapshot.legacyEntriesProcessed, 0);
    },
  );

  test(
    'production entrypoints have no legacy catalogue runtime dependency',
    () {
      final database = File(
        'lib/database/app_database.dart',
      ).readAsStringSync();
      final detail = File(
        'lib/screens/workout_detail_screen.dart',
      ).readAsStringSync();
      final workouts = File(
        'lib/screens/workouts_screen.dart',
      ).readAsStringSync();

      expect(
        database,
        isNot(contains('exercise_catalog_context_service.dart')),
      );
      expect(database, isNot(contains('_seedExercises')));
      expect(database, isNot(contains('_seedTrainingArchitecture')));
      expect(detail, isNot(contains('ExerciseFilterService')));
      expect(detail, isNot(contains('legacyCatalogueVisible')));
      expect(workouts, isNot(contains('legacyFiltersVisible')));
      expect(detail, contains('WorkoutExerciseSelectorScreen'));
    },
  );
}

Future<int> _count(Database db, String table) async {
  final rows = await db.rawQuery('SELECT COUNT(*) AS c FROM $table');
  return rows.single['c']! as int;
}

Future<bool> _tableExists(Database db, String table) async {
  final rows = await db.query(
    'sqlite_master',
    columns: ['name'],
    where: 'type = ? AND name = ?',
    whereArgs: ['table', table],
  );
  return rows.isNotEmpty;
}

Future<Map<String, int>> _personalCounts(Database db) async => {
  for (final table in const [
    'profiles',
    'body_measurements',
    'goals',
    'workouts',
    'workout_sets',
    'workout_exercises',
    'exercises',
  ])
    table: await _count(db, table),
};
