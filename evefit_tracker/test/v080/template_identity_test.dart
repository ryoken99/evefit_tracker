import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:evefit_tracker/models/workout.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/workout_template_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;
  late AppDatabase database;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(
      'CREATE TABLE workouts(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, date TEXT NOT NULL, workout_type TEXT NOT NULL, workout_type_id INTEGER, muscle_groups TEXT, duration_minutes INTEGER, notes TEXT, workout_region_key TEXT, workout_group_key TEXT, workout_subgroup_key TEXT, workout_specific_muscle_key TEXT, workout_equipment_key TEXT)',
    );
    await db.execute(
      'CREATE TABLE exercises(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, exercise_key TEXT, context_key TEXT, catalog_entry_key TEXT)',
    );
    await db.execute(
      'CREATE TABLE workout_exercises(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, workout_id INTEGER NOT NULL, exercise_id INTEGER NOT NULL, notes TEXT, UNIQUE(workout_id, exercise_id))',
    );
    await db.insert('exercises', {
      'id': 11,
      'name': 'Remada duplicada',
      'exercise_key': 'remada_duplicada',
      'context_key': 'back_width',
      'catalog_entry_key': 'remada_duplicada__back_width',
    });
    await db.insert('exercises', {
      'id': 22,
      'name': 'Remada duplicada',
      'exercise_key': 'remada_duplicada',
      'context_key': 'back_thickness',
      'catalog_entry_key': 'remada_duplicada__back_thickness',
    });
    database = AppDatabase.forTesting(db, activeProfile: _profile(1));
  });

  tearDown(() => db.close());

  test(
    'template resolves the exact catalog entry key before display name',
    () async {
      final workoutId = await database.insertWorkoutFromTemplate(
        workout: _workout(),
        exerciseReferences: const [
          WorkoutTemplateExerciseRef(
            catalogEntryKey: 'remada_duplicada__back_thickness',
            exerciseKey: 'remada_duplicada',
            contextKey: 'back_thickness',
            legacyName: 'Remada duplicada',
          ),
        ],
      );

      final rows = await db.query(
        'workout_exercises',
        where: 'workout_id = ?',
        whereArgs: [workoutId],
      );
      expect(rows, hasLength(1));
      expect(rows.single['exercise_id'], 22);
    },
  );

  test('ambiguous legacy name never selects the first exercise', () async {
    final workoutId = await database.insertWorkoutFromTemplate(
      workout: _workout(),
      exerciseReferences: const [
        WorkoutTemplateExerciseRef(legacyName: 'Remada duplicada'),
      ],
    );

    final rows = await db.query(
      'workout_exercises',
      where: 'workout_id = ?',
      whereArgs: [workoutId],
    );
    expect(rows, isEmpty);
  });

  test(
    'every built-in template points to an existing stable catalog entry',
    () {
      final catalogKeys = ExerciseCatalogContextService.entries
          .map((entry) => entry.catalogEntryKey)
          .toSet();

      for (final template in WorkoutTemplateService.templates) {
        for (final reference in template.exercises) {
          expect(
            catalogKeys,
            contains(reference.catalogEntryKey),
            reason: '${template.name}: ${reference.legacyName}',
          );
        }
      }
    },
  );
}

Workout _workout() =>
    Workout(profileId: 1, date: DateTime(2026, 6, 22), workoutType: 'Costas');

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
