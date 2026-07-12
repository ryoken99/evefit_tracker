import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
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
      'CREATE TABLE exercises('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'name TEXT NOT NULL, muscle_group TEXT NOT NULL, '
      'primary_muscle_group TEXT, secondary_muscle_groups TEXT, '
      'equipment TEXT, description TEXT, execution_steps TEXT, '
      'common_mistakes TEXT, safety_notes TEXT, regression TEXT, '
      'progression TEXT, breathing_tips TEXT, posture_tips TEXT, '
      'adaptation_notes TEXT, is_default INTEGER NOT NULL, '
      'is_hidden INTEGER, created_at TEXT, updated_at TEXT, notes TEXT, '
      'exercise_key TEXT, context_key TEXT, catalog_entry_key TEXT, '
      'primaryMuscleNodes TEXT, secondaryMuscleNodes TEXT, '
      'profile_id INTEGER)',
    );
    await db.execute(
      'CREATE TABLE workouts('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, '
      'date TEXT NOT NULL, workout_type TEXT NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE workout_sets('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, '
      'workout_id INTEGER NOT NULL, exercise_id INTEGER NOT NULL, '
      'set_number INTEGER NOT NULL, reps INTEGER NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE workout_templates('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, '
      'name TEXT NOT NULL, description TEXT, workout_type_id INTEGER, '
      'muscle_groups TEXT, created_at TEXT NOT NULL, updated_at TEXT NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE exercise_identity_aliases('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, alias_key TEXT NOT NULL, '
      'canonical_id TEXT NOT NULL, catalog_entry_key TEXT NOT NULL)',
    );
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'v1.0 migration preserves history, templates and alias mappings',
    () async {
      final legacyEntry = ExerciseCatalogContextService.entries.firstWhere(
        (entry) => entry.exerciseKey == 'flexao_classica',
      );
      await db.insert('exercises', {
        'id': 10,
        'name': legacyEntry.name,
        'muscle_group': legacyEntry.group,
        'is_default': 1,
        'catalog_entry_key': legacyEntry.catalogEntryKey,
      });
      await db.insert('exercises', {
        'id': 11,
        'name': 'Movimento pessoal sem mapeamento',
        'muscle_group': 'Personalizado',
        'is_default': 0,
        'notes': 'nao apagar',
      });
      await db.insert('workouts', {
        'id': 5,
        'profile_id': 1,
        'date': DateTime(2026, 7, 1).toIso8601String(),
        'workout_type': 'Peito',
      });
      await db.insert('workout_sets', {
        'id': 7,
        'profile_id': 1,
        'workout_id': 5,
        'exercise_id': 10,
        'set_number': 1,
        'reps': 12,
      });
      await db.insert('workout_templates', {
        'id': 3,
        'profile_id': 1,
        'name': 'Template antigo',
        'description': 'mantem referencia conceptual antiga',
        'muscle_groups': 'Peito',
        'created_at': DateTime(2026, 7, 1).toIso8601String(),
        'updated_at': DateTime(2026, 7, 1).toIso8601String(),
      });
      await db.insert('exercise_identity_aliases', {
        'alias_key': 'flexao_bracos',
        'canonical_id': 'push_up',
        'catalog_entry_key': legacyEntry.catalogEntryKey,
      });

      final database = AppDatabase.forTesting(db);
      await database.refreshCatalogExercises(db);
      final aliasCount = await _aliasCount(db);
      await database.refreshCatalogExercises(db);

      final catalog = (await db.query('exercises', where: 'id = 10')).single;
      expect(catalog['catalog_entry_key'], legacyEntry.catalogEntryKey);
      expect(catalog['canonical_id'], isNull);
      expect(catalog['exercise_key'], isNull);

      final sets = await db.query('workout_sets');
      expect(sets.single['exercise_id'], 10);
      expect(sets.single['reps'], 12);

      final custom = (await db.query('exercises', where: 'id = 11')).single;
      expect(custom['is_default'], 0);
      expect(custom['notes'], 'nao apagar');

      final templates = await db.query('workout_templates');
      expect(templates.single['name'], 'Template antigo');

      expect(await _aliasCount(db), aliasCount);
      final aliasRows = await db.query(
        'exercise_identity_aliases',
        where: 'alias_key = ? AND canonical_id = ?',
        whereArgs: ['flexao_bracos', 'push_up'],
      );
      expect(aliasRows, isNotEmpty);
      expect(
        aliasRows.map((row) => row['catalog_entry_key']),
        contains(legacyEntry.catalogEntryKey),
      );

      final defaultRows = await db.rawQuery(
        'SELECT COUNT(*) AS c FROM exercises WHERE is_default = 1',
      );
      expect(defaultRows.single['c'], 1);
    },
  );
}

Future<int> _aliasCount(Database db) async {
  final rows = await db.rawQuery(
    'SELECT COUNT(*) AS c FROM exercise_identity_aliases',
  );
  return rows.single['c']! as int;
}
