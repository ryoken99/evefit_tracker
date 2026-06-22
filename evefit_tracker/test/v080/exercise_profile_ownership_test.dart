import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;
  late AppDatabase profileA;
  late AppDatabase profileB;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(
      'CREATE TABLE exercises(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, name TEXT NOT NULL, muscle_group TEXT NOT NULL, primary_muscle_group TEXT, secondary_muscle_groups TEXT, equipment TEXT, description TEXT, execution_steps TEXT, common_mistakes TEXT, safety_notes TEXT, is_default INTEGER NOT NULL, is_hidden INTEGER NOT NULL DEFAULT 0, created_at TEXT, updated_at TEXT, notes TEXT, exercise_key TEXT, context_key TEXT, catalog_entry_key TEXT, primaryMuscleNodes TEXT, secondaryMuscleNodes TEXT)',
    );
    await db.execute(
      'CREATE TABLE profile_hidden_exercises(profile_id INTEGER NOT NULL, exercise_id INTEGER NOT NULL, created_at TEXT NOT NULL, PRIMARY KEY(profile_id, exercise_id))',
    );
    await db.insert('exercises', {
      'id': 1,
      'profile_id': null,
      'name': 'Flexão global',
      'muscle_group': 'Peito',
      'is_default': 1,
    });
    await db.insert('exercises', {
      'id': 2,
      'profile_id': 1,
      'name': 'Custom A',
      'muscle_group': 'Outro',
      'is_default': 0,
    });
    await db.insert('exercises', {
      'id': 3,
      'profile_id': 2,
      'name': 'Custom B',
      'muscle_group': 'Outro',
      'is_default': 0,
    });
    profileA = AppDatabase.forTesting(db, activeProfile: _profile(1));
    profileB = AppDatabase.forTesting(db, activeProfile: _profile(2));
  });

  tearDown(() => db.close());

  test(
    'profile sees global defaults and only its own custom exercises',
    () async {
      expect(
        (await profileA.exercises()).map((item) => item.id),
        unorderedEquals([1, 2]),
      );
      expect(
        (await profileB.exercises()).map((item) => item.id),
        unorderedEquals([1, 3]),
      );
    },
  );

  test('inserted custom exercise always belongs to active profile', () async {
    await profileA.insertExercise(
      Exercise(
        profileId: 2,
        name: 'Novo custom A',
        muscleGroup: 'Outro',
        isDefault: false,
      ),
    );

    final row = (await db.query(
      'exercises',
      where: 'name = ?',
      whereArgs: ['Novo custom A'],
    )).single;
    expect(row['profile_id'], 1);
  });

  test('profile A cannot update or hide profile B custom exercise', () async {
    await profileA.updateExercise(
      Exercise(
        id: 3,
        profileId: 2,
        name: 'Alterado por A',
        muscleGroup: 'Outro',
        isDefault: false,
      ),
    );
    await profileA.deleteExercise(3);

    final row = (await db.query(
      'exercises',
      where: 'id = ?',
      whereArgs: [3],
    )).single;
    expect(row['name'], 'Custom B');
    expect(row['is_hidden'], 0);
  });

  test('hiding a default affects only the active profile', () async {
    await profileA.deleteExercise(1);

    expect((await profileA.exercises()).map((item) => item.id), [2]);
    expect(
      (await profileB.exercises()).map((item) => item.id),
      unorderedEquals([1, 3]),
    );
    final hidden = await db.query('profile_hidden_exercises');
    expect(hidden.single['profile_id'], 1);
    expect(hidden.single['exercise_id'], 1);
  });
}

Profile _profile(int id) {
  final now = DateTime(2026, 6, 22);
  return Profile(
    id: id,
    name: 'Perfil $id',
    pinHash: 'hash-$id',
    createdAt: now,
    updatedAt: now,
    isActive: true,
  );
}
