import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  ExerciseCatalogEntry entryByName(String name) {
    return ExerciseCatalogContextService.entries.firstWhere(
      (entry) => entry.name == name,
      orElse: () => throw StateError('Missing catalog entry: $name'),
    );
  }

  test('canonical identity is separate from catalog entry identity', () {
    final pushUp = entryByName('Flexão clássica').toExercise();
    final gluteBridge = entryByName('Ponte de glúteo').toExercise();
    final technicalStandUp = entryByName('Technical stand-up').toExercise();

    expect(pushUp.canonicalId, 'push_up');
    expect(pushUp.catalogEntryKey, isNot(pushUp.canonicalId));
    expect(pushUp.aliases, contains('flexao_classica'));
    expect(pushUp.primaryType, 'musculacao');

    expect(gluteBridge.canonicalId, 'glute_bridge');
    expect(gluteBridge.catalogEntryKey, isNot(gluteBridge.canonicalId));
    expect(gluteBridge.aliases, contains('ponte_de_gluteo'));
    expect(gluteBridge.primaryType, 'musculacao');

    expect(technicalStandUp.canonicalId, 'technical_stand_up_lento');
    expect(
      technicalStandUp.catalogEntryKey,
      isNot(technicalStandUp.canonicalId),
    );
    expect(technicalStandUp.aliases, contains('technical_stand_up'));
    expect(technicalStandUp.primaryType, 'artes_marciais');
    expect(technicalStandUp.secondaryTypes, contains('mobilidade'));
    expect(technicalStandUp.secondaryTypes, contains('defesa_pessoal'));
  });

  test(
    'catalog refresh backfills canonical identity without changing history',
    () async {
      final db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      addTearDown(db.close);

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
        'primaryMuscleNodes TEXT, secondaryMuscleNodes TEXT, profile_id INTEGER)',
      );
      await db.execute(
        'CREATE TABLE workouts(id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'profile_id INTEGER, date TEXT NOT NULL, workout_type TEXT NOT NULL)',
      );
      await db.execute(
        'CREATE TABLE workout_sets(id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'profile_id INTEGER, workout_id INTEGER NOT NULL, '
        'exercise_id INTEGER NOT NULL, set_number INTEGER NOT NULL, '
        'reps INTEGER NOT NULL)',
      );

      final legacyEntry = entryByName('Flexão clássica');
      await db.insert('exercises', {
        'id': 10,
        'name': legacyEntry.name,
        'muscle_group': legacyEntry.group,
        'is_default': 1,
        'catalog_entry_key': legacyEntry.catalogEntryKey,
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

      await AppDatabase.forTesting(db).refreshCatalogExercises(db);

      final catalog = (await db.query('exercises', where: 'id = 10')).single;
      expect(catalog['catalog_entry_key'], legacyEntry.catalogEntryKey);
      expect(catalog['canonical_id'], 'push_up');
      expect(catalog['primary_type'], 'musculacao');

      final sets = await db.query('workout_sets');
      expect(sets, hasLength(1));
      expect(sets.single['exercise_id'], 10);
      expect(sets.single['reps'], 12);
    },
  );
}
