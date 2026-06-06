import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../models/body_measurement.dart';
import '../models/exercise.dart';
import '../models/goal.dart';
import '../models/progress_photo.dart';
import '../models/user_profile.dart';
import '../models/workout.dart';
import '../models/workout_exercise.dart';
import '../models/workout_set.dart';
import 'seed_data.dart';

class WorkoutEntry {
  WorkoutEntry({
    required this.workout,
    required this.sets,
    this.exercises = const [],
  });
  final Workout workout;
  final List<WorkoutSet> sets;
  final List<WorkoutExercise> exercises;

  int get exerciseCount {
    final ids = {
      ...exercises.map((exercise) => exercise.exerciseId),
      ...sets.map((set) => set.exerciseId),
    };
    return ids.length;
  }

  int get totalSetCount => sets.length;
}

class AppDatabase {
  AppDatabase._();
  static final instance = AppDatabase._();
  Database? _database;

  Future<Database> get database async => _database ??= await _open();

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      p.join(dbPath, 'evefit_tracker.db'),
      version: 2,
      onCreate: (db, version) async {
        await _createTables(db);
        await _seed(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _createWorkoutExercisesTable(db);
        }
      },
    );
  }

  Future<void> _createTables(Database db) async {
    await db.execute(
      'CREATE TABLE user_profile(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, height_cm REAL NOT NULL, start_date TEXT NOT NULL, main_goal TEXT NOT NULL, notes TEXT)',
    );
    await db.execute(
      'CREATE TABLE body_measurements(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, weight_kg REAL, body_fat_percentage REAL, muscle_mass_kg REAL, left_bicep_relaxed_cm REAL, left_bicep_flexed_cm REAL, right_bicep_relaxed_cm REAL, right_bicep_flexed_cm REAL, shoulders_cm REAL, chest_cm REAL, waist_cm REAL, side_hip_area_cm REAL, abdomen_cm REAL, hips_cm REAL, left_thigh_cm REAL, right_thigh_cm REAL, left_calf_cm REAL, right_calf_cm REAL, notes TEXT)',
    );
    await db.execute(
      'CREATE TABLE workouts(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, workout_type TEXT NOT NULL, duration_minutes INTEGER, notes TEXT)',
    );
    await db.execute(
      'CREATE TABLE exercises(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, muscle_group TEXT NOT NULL, is_default INTEGER NOT NULL, notes TEXT)',
    );
    await db.execute(
      'CREATE TABLE workout_sets(id INTEGER PRIMARY KEY AUTOINCREMENT, workout_id INTEGER NOT NULL, exercise_id INTEGER NOT NULL, set_number INTEGER NOT NULL, weight_kg REAL, reps INTEGER NOT NULL, rpe REAL, notes TEXT, FOREIGN KEY(workout_id) REFERENCES workouts(id) ON DELETE CASCADE, FOREIGN KEY(exercise_id) REFERENCES exercises(id))',
    );
    await _createWorkoutExercisesTable(db);
    await db.execute(
      'CREATE TABLE progress_photos(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, photo_type TEXT NOT NULL, file_path TEXT NOT NULL, weight_kg REAL, notes TEXT)',
    );
    await db.execute(
      'CREATE TABLE goals(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT, phase TEXT NOT NULL, is_active INTEGER NOT NULL, created_at TEXT NOT NULL, completed_at TEXT)',
    );
  }

  Future<void> _createWorkoutExercisesTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS workout_exercises(id INTEGER PRIMARY KEY AUTOINCREMENT, workout_id INTEGER NOT NULL, exercise_id INTEGER NOT NULL, notes TEXT, UNIQUE(workout_id, exercise_id), FOREIGN KEY(workout_id) REFERENCES workouts(id) ON DELETE CASCADE, FOREIGN KEY(exercise_id) REFERENCES exercises(id))',
    );
  }

  Future<void> _seed(Database db) async {
    await db.insert('user_profile', SeedData.profile.toMap());
    await db.insert('body_measurements', SeedData.initialMeasurement.toMap());
    for (final entry in SeedData.exercisesByGroup.entries) {
      for (final name in entry.value) {
        await db.insert(
          'exercises',
          Exercise(name: name, muscleGroup: entry.key, isDefault: true).toMap(),
        );
      }
    }
    for (final goal in SeedData.goals) {
      await db.insert('goals', goal.toMap());
    }
  }

  Future<UserProfile> profile() async => UserProfile.fromMap(
    (await (await database).query('user_profile', limit: 1)).first,
  );

  Future<List<BodyMeasurement>> measurements() async {
    final rows = await (await database).query(
      'body_measurements',
      orderBy: 'date DESC',
    );
    return rows.map(BodyMeasurement.fromMap).toList();
  }

  Future<void> insertMeasurement(BodyMeasurement measurement) async {
    await (await database).insert(
      'body_measurements',
      measurement.toMap()..remove('id'),
    );
  }

  Future<void> updateMeasurement(BodyMeasurement measurement) async {
    await (await database).update(
      'body_measurements',
      measurement.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [measurement.id],
    );
  }

  Future<void> deleteMeasurement(int id) async {
    await (await database).delete(
      'body_measurements',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Exercise>> exercises() async {
    final rows = await (await database).query(
      'exercises',
      orderBy: 'muscle_group, name',
    );
    return rows.map(Exercise.fromMap).toList();
  }

  Future<int> insertWorkout(Workout workout) async {
    return (await database).insert('workouts', workout.toMap()..remove('id'));
  }

  Future<void> updateWorkout(Workout workout) async {
    await (await database).update(
      'workouts',
      workout.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [workout.id],
    );
  }

  Future<void> deleteWorkout(int id) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(
        'workout_sets',
        where: 'workout_id = ?',
        whereArgs: [id],
      );
      await txn.delete(
        'workout_exercises',
        where: 'workout_id = ?',
        whereArgs: [id],
      );
      await txn.delete('workouts', where: 'id = ?', whereArgs: [id]);
    });
  }

  Future<int> insertWorkoutFromTemplate({
    required Workout workout,
    required List<String> exerciseNames,
  }) async {
    final db = await database;
    return db.transaction((txn) async {
      final workoutId = await txn.insert(
        'workouts',
        workout.toMap()..remove('id'),
      );
      for (final name in exerciseNames) {
        final rows = await txn.query(
          'exercises',
          columns: ['id'],
          where: 'name = ?',
          whereArgs: [name],
          limit: 1,
        );
        if (rows.isNotEmpty) {
          await txn.insert('workout_exercises', {
            'workout_id': workoutId,
            'exercise_id': rows.first['id'],
            'notes': '',
          }, conflictAlgorithm: ConflictAlgorithm.ignore);
        }
      }
      return workoutId;
    });
  }

  Future<void> insertWorkoutExercise(WorkoutExercise exercise) async {
    await (await database).insert(
      'workout_exercises',
      exercise.toMap()..remove('id'),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> insertWorkoutSet(WorkoutSet set) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.insert('workout_exercises', {
        'workout_id': set.workoutId,
        'exercise_id': set.exerciseId,
        'notes': '',
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      await txn.insert('workout_sets', set.toMap()..remove('id'));
    });
  }

  Future<void> updateWorkoutSet(WorkoutSet set) async {
    await (await database).update(
      'workout_sets',
      set.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [set.id],
    );
  }

  Future<void> deleteWorkoutSet(int id) async {
    await (await database).delete(
      'workout_sets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertWorkoutWithSet(Workout workout, WorkoutSet set) async {
    final db = await database;
    await db.transaction((txn) async {
      final workoutId = await txn.insert(
        'workouts',
        workout.toMap()..remove('id'),
      );
      await txn.insert(
        'workout_sets',
        (set.toMap()..remove('id'))..['workout_id'] = workoutId,
      );
    });
  }

  Future<List<WorkoutEntry>> workouts() async {
    final db = await database;
    final workoutRows = await db.query('workouts', orderBy: 'date DESC');
    final entries = <WorkoutEntry>[];
    for (final row in workoutRows) {
      final workout = Workout.fromMap(row);
      final setRows = await db.rawQuery(
        'SELECT workout_sets.*, exercises.name AS exercise_name FROM workout_sets JOIN exercises ON exercises.id = workout_sets.exercise_id WHERE workout_id = ? ORDER BY set_number',
        [workout.id],
      );
      final exerciseRows = await db.rawQuery(
        'SELECT workout_exercises.*, exercises.name AS exercise_name, exercises.muscle_group AS muscle_group FROM workout_exercises JOIN exercises ON exercises.id = workout_exercises.exercise_id WHERE workout_id = ? ORDER BY workout_exercises.id',
        [workout.id],
      );
      entries.add(
        WorkoutEntry(
          workout: workout,
          sets: setRows.map(WorkoutSet.fromMap).toList(),
          exercises: exerciseRows.map(WorkoutExercise.fromMap).toList(),
        ),
      );
    }
    return entries;
  }

  Future<int> workoutsThisWeek() async {
    final now = DateTime.now();
    final start = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
    final rows = await (await database).rawQuery(
      'SELECT COUNT(*) AS total FROM workouts WHERE date >= ?',
      [start.toIso8601String()],
    );
    return rows.first['total'] as int;
  }

  Future<void> insertPhoto(ProgressPhoto photo) async {
    await (await database).insert(
      'progress_photos',
      photo.toMap()..remove('id'),
    );
  }

  Future<void> updatePhoto(ProgressPhoto photo) async {
    await (await database).update(
      'progress_photos',
      photo.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [photo.id],
    );
  }

  Future<void> deletePhoto(int id) async {
    await (await database).delete(
      'progress_photos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ProgressPhoto>> photos() async {
    final rows = await (await database).query(
      'progress_photos',
      orderBy: 'date DESC',
    );
    return rows.map(ProgressPhoto.fromMap).toList();
  }

  Future<List<Goal>> goals() async {
    final rows = await (await database).query('goals', orderBy: 'phase, id');
    return rows.map(Goal.fromMap).toList();
  }

  Future<void> setGoalCompleted(Goal goal, bool completed) async {
    await (await database).update(
      'goals',
      {
        'is_active': completed ? 0 : 1,
        'completed_at': completed ? DateTime.now().toIso8601String() : null,
      },
      where: 'id = ?',
      whereArgs: [goal.id],
    );
  }

  Future<Map<String, List<Map<String, Object?>>>> exportData() async {
    final db = await database;
    return {
      'medidas': await db.query('body_measurements', orderBy: 'date'),
      'treinos': await db.query('workouts', orderBy: 'date'),
      'exercicios_treino': await db.rawQuery(
        'SELECT workout_exercises.id, workout_exercises.workout_id, workout_exercises.exercise_id, exercises.name AS exercise_name, exercises.muscle_group, workout_exercises.notes FROM workout_exercises JOIN exercises ON exercises.id = workout_exercises.exercise_id ORDER BY workout_id, workout_exercises.id',
      ),
      'series': await db.query(
        'workout_sets',
        orderBy: 'workout_id, set_number',
      ),
      'objetivos': await db.query('goals', orderBy: 'phase, id'),
    };
  }
}
