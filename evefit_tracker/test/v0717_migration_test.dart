import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/services/exercise_v717_migration.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(
      'CREATE TABLE exercises(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, muscle_group TEXT NOT NULL, is_default INTEGER NOT NULL, notes TEXT, equipment TEXT, catalog_entry_key TEXT)',
    );
    await db.execute(
      'CREATE TABLE workouts(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, date TEXT NOT NULL, workout_type TEXT NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE workout_sets(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, workout_id INTEGER NOT NULL, exercise_id INTEGER NOT NULL, set_number INTEGER NOT NULL, reps INTEGER NOT NULL)',
    );
    await db.insert('exercises', {
      'name': 'Curl martelo',
      'muscle_group': 'Bíceps',
      'is_default': 1,
      'equipment': 'Halteres',
      'catalog_entry_key': 'curl_martelo__biceps',
    });
    await db.insert('exercises', {
      'name': 'Wrist curl',
      'muscle_group': 'Antebraço/Pega',
      'is_default': 1,
      'equipment': 'Halteres',
      'catalog_entry_key': 'wrist_curl__antebraco_pega',
    });
    await db.insert('exercises', {
      'name': 'Farmer walk',
      'muscle_group': 'Antebraço/Pega',
      'is_default': 1,
      'equipment': 'Halteres',
      'catalog_entry_key': 'farmer_walk__antebraco_pega',
    });
    await db.insert('workouts', {
      'id': 99,
      'profile_id': 1,
      'date': DateTime(2026, 6, 16).toIso8601String(),
      'workout_type': 'Braço completo',
    });
    await db.insert('workout_sets', {
      'profile_id': 1,
      'workout_id': 99,
      'exercise_id': 1,
      'set_number': 1,
      'reps': 10,
    });
  });

  tearDown(() => db.close());

  test('v717 migration adds and backfills muscle node columns', () async {
    await ExerciseV717Migration.migrate(db);

    final columns = await db.rawQuery('PRAGMA table_info(exercises)');
    final names = columns.map((row) => row['name']).toSet();
    expect(names, containsAll(['primaryMuscleNodes', 'secondaryMuscleNodes']));

    final hammer = await _exercise(db, 'Curl martelo');
    expect(hammer['primaryMuscleNodes'], contains('Braquial'));
    expect(hammer['primaryMuscleNodes'], contains('Braquiorradial'));

    final wrist = await _exercise(db, 'Wrist curl');
    expect(wrist['primaryMuscleNodes'], contains('Flexores do antebraço'));
    expect(wrist['primaryMuscleNodes'], contains('Punho'));

    final farmer = await _exercise(db, 'Farmer walk');
    expect(farmer['primaryMuscleNodes'], contains('Força de pega'));
  });

  test(
    'v717 migration inserts missing Lombar exercises without deleting history',
    () async {
      await ExerciseV717Migration.migrate(db);

      final lombarRows = await db.query(
        'exercises',
        where: 'muscle_group = ?',
        whereArgs: ['Lombar'],
      );
      expect(lombarRows.length, SeedData.exercisesByGroup['Lombar']!.length);

      final workoutCount = await db.rawQuery(
        'SELECT COUNT(*) AS total FROM workouts',
      );
      final setCount = await db.rawQuery(
        'SELECT COUNT(*) AS total FROM workout_sets',
      );
      expect(workoutCount.first['total'], 1);
      expect(setCount.first['total'], 1);
    },
  );

  test('v717 migration does not insert non-Lombar catalog exercises', () async {
    await ExerciseV717Migration.migrate(db);

    final rows = await db.query(
      'exercises',
      where: 'name = ? AND muscle_group = ?',
      whereArgs: ['Supino reto', 'Peito'],
    );

    expect(rows, isEmpty);
  });
}

Future<Map<String, Object?>> _exercise(Database db, String name) async {
  final rows = await db.query(
    'exercises',
    where: 'name = ?',
    whereArgs: [name],
    limit: 1,
  );
  return rows.single;
}
