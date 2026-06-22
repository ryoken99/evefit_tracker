import 'package:evefit_tracker/database/migrations/v080_integrity_migration.dart';
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
      'CREATE TABLE profiles(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE exercises(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, muscle_group TEXT NOT NULL, is_default INTEGER NOT NULL, notes TEXT, secondary_muscle_groups TEXT, equipment TEXT, description TEXT, execution_steps TEXT, common_mistakes TEXT, safety_notes TEXT, exercise_key TEXT, context_key TEXT, catalog_entry_key TEXT)',
    );
    await db.execute(
      'CREATE TABLE workouts(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, date TEXT NOT NULL, workout_type TEXT NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE workout_sets(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, workout_id INTEGER NOT NULL, exercise_id INTEGER NOT NULL, set_number INTEGER NOT NULL, reps INTEGER NOT NULL)',
    );
    await db.insert('profiles', {'id': 1, 'name': 'Perfil A'});
    await db.insert('profiles', {'id': 2, 'name': 'Perfil B'});
    await db.insert('exercises', {
      'id': 41,
      'name': 'ExtensÃ£o de trÃ­ceps',
      'muscle_group': 'TrÃ­ceps',
      'is_default': 1,
      'equipment': 'Cabo',
      'description': 'Trabalha o trÃ­ceps sem mover o ombro.',
      'execution_steps': 'Mantém a mÃ£o alinhada.',
      'catalog_entry_key': 'extensao_triceps__triceps',
    });
    await db.insert('workouts', {
      'id': 77,
      'profile_id': 1,
      'date': DateTime(2026, 6, 22).toIso8601String(),
      'workout_type': 'Braços',
    });
    await db.insert('workout_sets', {
      'id': 91,
      'profile_id': 1,
      'workout_id': 77,
      'exercise_id': 41,
      'set_number': 1,
      'reps': 10,
    });
  });

  tearDown(() => db.close());

  test('adds v0.8.0 ownership taxonomy and security schema', () async {
    await V080IntegrityMigration.migrate(db);

    final columns = await db.rawQuery('PRAGMA table_info(exercises)');
    final columnNames = columns.map((row) => row['name']).toSet();
    expect(
      columnNames,
      containsAll({
        'profile_id',
        'region_keys',
        'group_keys',
        'subgroup_keys',
        'primary_muscle_key',
        'secondary_muscle_keys',
        'equipment_keys',
        'movement_pattern',
        'difficulty',
        'force_type',
        'laterality',
        'goal_tags',
      }),
    );

    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'table'",
    );
    final tableNames = tables.map((row) => row['name']).toSet();
    expect(
      tableNames,
      containsAll({'profile_hidden_exercises', 'profile_security'}),
    );
  });

  test('normalizes known mojibake without deleting or rekeying data', () async {
    await V080IntegrityMigration.migrate(db);

    final exercise = (await db.query(
      'exercises',
      where: 'id = ?',
      whereArgs: [41],
    )).single;
    expect(exercise['name'], 'Extensão de tríceps');
    expect(exercise['muscle_group'], 'Tríceps');
    expect(exercise['execution_steps'], 'Mantém a mão alinhada.');
    expect(exercise['catalog_entry_key'], 'extensao_triceps__triceps');
    expect(await _count(db, 'workouts'), 1);
    expect(await _count(db, 'workout_sets'), 1);
    expect(await _count(db, 'exercises'), 1);
  });

  test('migration is safe to run more than once', () async {
    await V080IntegrityMigration.migrate(db);
    await V080IntegrityMigration.migrate(db);

    expect(await _count(db, 'workouts'), 1);
    expect(await _count(db, 'workout_sets'), 1);
    expect(await _count(db, 'exercises'), 1);
    expect(await _count(db, 'profile_hidden_exercises'), 0);
    expect(await _count(db, 'profile_security'), 0);
  });
}

Future<int> _count(Database db, String table) async {
  final rows = await db.rawQuery('SELECT COUNT(*) AS total FROM $table');
  return rows.single['total'] as int;
}
