import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../models/body_measurement.dart';
import '../models/dashboard_widget_config.dart';
import '../models/exercise.dart';
import '../models/goal.dart';
import '../models/goal_milestone.dart';
import '../models/muscle_group.dart';
import '../models/profile.dart';
import '../models/profile_equipment.dart';
import '../models/progress_photo.dart';
import '../models/user_profile.dart';
import '../models/workout.dart';
import '../models/workout_exercise.dart';
import '../models/workout_set.dart';
import '../models/workout_template.dart';
import '../models/workout_type.dart';
import '../services/dashboard_metric_service.dart';
import '../services/pin_service.dart';
import '../services/profile_preferences_service.dart';
import '../services/training_architecture.dart';
import '../services/training_location_service.dart';
import '../services/workout_taxonomy.dart';
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
  Profile? _activeProfile;

  int? get activeProfileId => _activeProfile?.id;
  Profile? get activeProfile => _activeProfile;

  Future<Database> get database async => _database ??= await _open();

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      p.join(dbPath, 'evefit_tracker.db'),
      version: 10,
      onCreate: (db, version) async {
        await _createTables(db);
        await _migrateV5(db);
        await _migrateV51(db);
        await _migrateV52(db);
        await _migrateV53(db);
        await _migrateV60(db);
        await _migrateV70(db);
        await _migrateV75(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _createWorkoutExercisesTable(db);
        }
        if (oldVersion < 3) {
          await _migrateProfiles(db);
        }
        if (oldVersion < 4) {
          await _migrateV5(db);
        }
        if (oldVersion < 5) {
          await _migrateV51(db);
        }
        if (oldVersion < 6) {
          await _migrateV52(db);
        }
        if (oldVersion < 7) {
          await _migrateV53(db);
        }
        if (oldVersion < 8) {
          await _migrateV60(db);
        }
        if (oldVersion < 9) {
          await _migrateV70(db);
        }
        if (oldVersion < 10) {
          await _migrateV75(db);
        }
      },
    );
  }

  Future<void> _createTables(Database db) async {
    await _createProfilesTable(db);
    await db.execute(
      'CREATE TABLE user_profile(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, name TEXT NOT NULL, height_cm REAL NOT NULL, start_date TEXT NOT NULL, main_goal TEXT NOT NULL, notes TEXT)',
    );
    await db.execute(
      'CREATE TABLE body_measurements(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, date TEXT NOT NULL, weight_kg REAL, body_fat_percentage REAL, muscle_mass_kg REAL, left_bicep_relaxed_cm REAL, left_bicep_flexed_cm REAL, right_bicep_relaxed_cm REAL, right_bicep_flexed_cm REAL, shoulders_cm REAL, chest_cm REAL, waist_cm REAL, side_hip_area_cm REAL, abdomen_cm REAL, hips_cm REAL, left_thigh_cm REAL, right_thigh_cm REAL, left_calf_cm REAL, right_calf_cm REAL, notes TEXT)',
    );
    await db.execute(
      'CREATE TABLE workouts(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, date TEXT NOT NULL, workout_type TEXT NOT NULL, duration_minutes INTEGER, notes TEXT, workout_region_key TEXT, workout_group_key TEXT, workout_subgroup_key TEXT, workout_specific_muscle_key TEXT, workout_equipment_key TEXT)',
    );
    await db.execute(
      'CREATE TABLE exercises(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, muscle_group TEXT NOT NULL, is_default INTEGER NOT NULL, notes TEXT)',
    );
    await db.execute(
      'CREATE TABLE workout_sets(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, workout_id INTEGER NOT NULL, exercise_id INTEGER NOT NULL, set_number INTEGER NOT NULL, weight_kg REAL, reps INTEGER NOT NULL, rpe REAL, notes TEXT, FOREIGN KEY(workout_id) REFERENCES workouts(id) ON DELETE CASCADE, FOREIGN KEY(exercise_id) REFERENCES exercises(id))',
    );
    await _createWorkoutExercisesTable(db);
    await db.execute(
      'CREATE TABLE progress_photos(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, date TEXT NOT NULL, photo_type TEXT NOT NULL, file_path TEXT NOT NULL, weight_kg REAL, notes TEXT)',
    );
    await db.execute(
      'CREATE TABLE goals(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, title TEXT NOT NULL, description TEXT, phase TEXT NOT NULL, category TEXT, is_active INTEGER NOT NULL, created_at TEXT NOT NULL, completed_at TEXT)',
    );
  }

  Future<void> _createProfilesTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS profiles(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, pin_hash TEXT NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, is_active INTEGER NOT NULL DEFAULT 0, height_cm REAL, birth_date TEXT, sex TEXT, training_location TEXT, initial_goals TEXT, notes TEXT)',
    );
  }

  Future<void> _createWorkoutExercisesTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS workout_exercises(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, workout_id INTEGER NOT NULL, exercise_id INTEGER NOT NULL, notes TEXT, UNIQUE(workout_id, exercise_id), FOREIGN KEY(workout_id) REFERENCES workouts(id) ON DELETE CASCADE, FOREIGN KEY(exercise_id) REFERENCES exercises(id))',
    );
  }

  Future<void> _seedExercises(Database db) async {
    final now = DateTime.now().toIso8601String();
    for (final entry in SeedData.exercisesByGroup.entries) {
      for (final name in entry.value) {
        final existing = await db.query(
          'exercises',
          columns: ['id'],
          where: 'name = ?',
          whereArgs: [name],
          limit: 1,
        );
        if (existing.isNotEmpty) continue;
        await db.insert(
          'exercises',
          Exercise(
            name: name,
            muscleGroup: entry.key,
            isDefault: true,
            secondaryMuscleGroups: _secondaryGroupsFor(name, entry.key),
            equipment: _equipmentFor(name),
            description: _descriptionFor(name, entry.key),
            executionSteps: _stepsFor(name),
            commonMistakes:
                'Evitar balanço excessivo, amplitude incompleta e carga que obrigue a perder a postura.',
            safetyNotes:
                'Começa leve, controla a fase excêntrica e pára se houver dor articular.',
            createdAt: DateTime.parse(now),
            updatedAt: DateTime.parse(now),
          ).toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    }
  }

  Future<void> _migrateV5(Database db) async {
    await _createDashboardWidgetsTable(db);
    await _createWorkoutTypesTable(db);
    await _createMuscleGroupsTable(db);
    await _createWorkoutTemplatesTables(db);

    for (final column in _bodyMeasurementExtraColumns.entries) {
      await _addColumnIfMissing(
        db,
        'body_measurements',
        column.key,
        column.value,
      );
    }
    for (final column in _exerciseExtraColumns.entries) {
      await _addColumnIfMissing(db, 'exercises', column.key, column.value);
    }
    await _addColumnIfMissing(db, 'workouts', 'workout_type_id', 'INTEGER');
    await _addColumnIfMissing(db, 'workouts', 'muscle_groups', 'TEXT');
    for (final column in _goalExtraColumns.entries) {
      await _addColumnIfMissing(db, 'goals', column.key, column.value);
    }
    await _seedMuscleGroups(db);
    await _seedWorkoutTypes(db);
    await _backfillExerciseDetails(db);
  }

  Future<void> _migrateV51(Database db) async {
    await _createProfileEquipmentTable(db);
    await _createGoalMilestonesTable(db);
    await _addColumnIfMissing(db, 'profiles', 'height_cm', 'REAL');
    await _addColumnIfMissing(db, 'profiles', 'birth_date', 'TEXT');
    await _addColumnIfMissing(db, 'profiles', 'sex', 'TEXT');
    await _addColumnIfMissing(db, 'profiles', 'training_location', 'TEXT');
    await _addColumnIfMissing(db, 'profiles', 'initial_goals', 'TEXT');
    await _addColumnIfMissing(db, 'workout_types', 'muscle_groups', 'TEXT');
    await _addColumnIfMissing(db, 'goals', 'current_value', 'REAL');
    await _addColumnIfMissing(db, 'goals', 'periodicity', 'TEXT');
    await _addColumnIfMissing(db, 'goals', 'frequency_target', 'INTEGER');
    await _seedMuscleGroups(db);
    await _seedExpandedMuscleGroups(db);
    await _seedWorkoutTypes(db);
    await _seedExercises(db);
    await _backfillExerciseDetails(db);
  }

  Future<void> _migrateV52(Database db) async {
    await _createProfileTrainingLocationsTable(db);
    await _seedExercises(db);
    await _seedWorkoutTypes(db);
    await _backfillSpecificWorkoutTypes(db);
    final profiles = await db.query('profiles');
    for (final row in profiles) {
      final profileId = row['id'] as int;
      final locations = TrainingLocationService.parse(
        row['training_location'] as String? ?? '',
      );
      await _insertProfileTrainingLocations(
        db,
        profileId: profileId,
        selectedLocations: locations,
      );
    }
  }

  Future<void> _migrateV53(Database db) async {
    for (final column in _bodyDataV53Columns.entries) {
      await _addColumnIfMissing(
        db,
        'body_measurements',
        column.key,
        column.value,
      );
    }
    await _addColumnIfMissing(db, 'profiles', 'activity_level', 'TEXT');
    final profiles = await db.query('profiles', columns: ['id']);
    for (final row in profiles) {
      await _insertDefaultDashboardWidgets(db, row['id'] as int);
    }
  }

  Future<void> _migrateV60(Database db) async {
    await _seedWorkoutTypes(db);
    await _seedExercises(db);
    await _backfillSpecificWorkoutTypes(db);
    await _refreshDefaultWorkoutTypes(db);
    await _refreshDefaultExerciseDetails(db);
  }

  Future<void> _migrateV70(Database db) async {
    await _addColumnIfMissing(db, 'workouts', 'workout_region_key', 'TEXT');
    await _addColumnIfMissing(db, 'workouts', 'workout_group_key', 'TEXT');
    await _addColumnIfMissing(db, 'workouts', 'workout_subgroup_key', 'TEXT');
    await _addColumnIfMissing(
      db,
      'workouts',
      'workout_specific_muscle_key',
      'TEXT',
    );
    await _addColumnIfMissing(db, 'workouts', 'workout_equipment_key', 'TEXT');
    await _createTrainingArchitectureTables(db);
    await _seedTrainingArchitecture(db);
    await _seedExercises(db);
    await _refreshDefaultExerciseDetails(db);
    await _backfillWorkoutArchitecture(db);
  }

  Future<void> _migrateV75(Database db) async {
    await _seedExercises(db);
    await _refreshDefaultExerciseDetails(db);
    await db.update(
      'exercises',
      {'is_hidden': 1, 'updated_at': DateTime.now().toIso8601String()},
      where: 'is_default = 1 AND name = ?',
      whereArgs: ['Face pull'],
    );
  }

  Future<void> _createTrainingArchitectureTables(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS body_regions(id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT NOT NULL UNIQUE, name TEXT NOT NULL, description TEXT, sort_order INTEGER NOT NULL, is_default INTEGER NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS workout_focuses(id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT NOT NULL UNIQUE, region_key TEXT, group_key TEXT, subgroup_key TEXT, specific_muscle_key TEXT, name TEXT NOT NULL, description TEXT, is_specific INTEGER NOT NULL, sort_order INTEGER NOT NULL, is_default INTEGER NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS equipment(id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT NOT NULL UNIQUE, name TEXT NOT NULL, category TEXT, description TEXT, is_default INTEGER NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS exercise_equipment(exercise_id INTEGER NOT NULL, equipment_key TEXT NOT NULL, is_required INTEGER NOT NULL, is_optional INTEGER NOT NULL, UNIQUE(exercise_id, equipment_key))',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS exercise_muscles(exercise_id INTEGER NOT NULL, muscle_key TEXT NOT NULL, role TEXT NOT NULL, UNIQUE(exercise_id, muscle_key, role))',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS exercise_focus_map(exercise_id INTEGER NOT NULL, focus_key TEXT NOT NULL, match_strength TEXT NOT NULL, UNIQUE(exercise_id, focus_key))',
    );
  }

  Future<void> _seedTrainingArchitecture(Database db) async {
    for (final region in TrainingArchitecture.regions) {
      await db.insert('body_regions', {
        'key': region.key,
        'name': region.name,
        'description': region.description,
        'sort_order': region.sortOrder,
        'is_default': 1,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (final equipment in TrainingArchitecture.equipment) {
      await db.insert('equipment', {
        'key': equipment.key,
        'name': equipment.name,
        'category': equipment.category,
        'description': equipment.description,
        'is_default': 1,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (final group in TrainingArchitecture.groups) {
      await db.insert('workout_focuses', {
        'key': group.key,
        'region_key': group.regionKey,
        'group_key': group.key,
        'subgroup_key': '',
        'specific_muscle_key': '',
        'name': group.name,
        'description': group.description,
        'is_specific': 0,
        'sort_order': group.sortOrder,
        'is_default': 1,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (final subgroup in TrainingArchitecture.subgroups) {
      await db.insert('workout_focuses', {
        'key': subgroup.key,
        'region_key': subgroup.regionKey,
        'group_key': subgroup.groupKey,
        'subgroup_key': subgroup.key,
        'specific_muscle_key': '',
        'name': subgroup.name,
        'description': subgroup.description,
        'is_specific': 1,
        'sort_order': subgroup.sortOrder,
        'is_default': 1,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (final muscle in TrainingArchitecture.muscles) {
      await db.insert('workout_focuses', {
        'key': muscle.key,
        'region_key': muscle.regionKey,
        'group_key': muscle.groupKey,
        'subgroup_key': muscle.subgroupKey,
        'specific_muscle_key': muscle.key,
        'name': muscle.name,
        'description': muscle.description,
        'is_specific': 1,
        'sort_order': muscle.sortOrder,
        'is_default': 1,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> _backfillWorkoutArchitecture(Database db) async {
    final rows = await db.query(
      'workouts',
      columns: ['id', 'workout_type'],
      where: 'workout_region_key IS NULL OR workout_region_key = ""',
    );
    for (final row in rows) {
      final selection = TrainingArchitecture.legacySelectionFor(
        row['workout_type'] as String? ?? '',
      );
      await db.update(
        'workouts',
        {
          'workout_region_key': selection.regionKey,
          'workout_group_key': selection.groupKey,
          'workout_subgroup_key': selection.subgroupKey,
          'workout_specific_muscle_key': selection.specificMuscleKey,
          'workout_equipment_key': selection.equipmentKey,
        },
        where: 'id = ?',
        whereArgs: [row['id']],
      );
    }
  }

  Future<void> _createProfileTrainingLocationsTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS profile_training_locations(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, location_key TEXT NOT NULL, location_name TEXT NOT NULL, is_selected INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE(profile_id, location_key))',
    );
  }

  Future<void> _backfillSpecificWorkoutTypes(Database db) async {
    for (final name in SeedData.workoutTypes) {
      await db.update(
        'workout_types',
        {'muscle_groups': _defaultGroupsForWorkoutType(name)},
        where: 'name = ?',
        whereArgs: [name],
      );
    }
  }

  Future<void> _refreshDefaultWorkoutTypes(Database db) async {
    final now = DateTime.now().toIso8601String();
    final validNames = SeedData.workoutTypes.toSet();
    for (final name in validNames) {
      await db.update(
        'workout_types',
        {
          'description': 'Tipo de treino predefinido v0.6.0.',
          'muscle_groups': _defaultGroupsForWorkoutType(name),
          'is_hidden': 0,
          'updated_at': now,
        },
        where: 'profile_id IS NULL AND name = ?',
        whereArgs: [name],
      );
    }
    await db.update(
      'workout_types',
      {'is_hidden': 1, 'updated_at': now},
      where:
          'profile_id IS NULL AND is_default = 1 AND name NOT IN (${List.filled(validNames.length, '?').join(',')})',
      whereArgs: validNames.toList(),
    );
  }

  Future<void> _refreshDefaultExerciseDetails(Database db) async {
    final now = DateTime.now().toIso8601String();
    for (final entry in SeedData.exercisesByGroup.entries) {
      for (final name in entry.value) {
        await db.update(
          'exercises',
          {
            'muscle_group': entry.key,
            'primary_muscle_group': entry.key,
            'secondary_muscle_groups': _secondaryGroupsFor(name, entry.key),
            'equipment': _equipmentFor(name),
            'description': _descriptionFor(name, entry.key),
            'execution_steps': _stepsFor(name),
            'common_mistakes': _commonMistakesFor(name),
            'safety_notes': _safetyNotesFor(name),
            'updated_at': now,
          },
          where: 'is_default = 1 AND name = ?',
          whereArgs: [name],
        );
      }
    }
  }

  Future<void> _createProfileEquipmentTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS profile_equipment(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, equipment_key TEXT NOT NULL, equipment_name TEXT NOT NULL, is_available INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE(profile_id, equipment_key))',
    );
  }

  Future<void> _createGoalMilestonesTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS goal_milestones(id INTEGER PRIMARY KEY AUTOINCREMENT, goal_id INTEGER NOT NULL, title TEXT NOT NULL, target_value REAL, unit TEXT, status TEXT NOT NULL, sort_order INTEGER NOT NULL, created_at TEXT NOT NULL, completed_at TEXT, FOREIGN KEY(goal_id) REFERENCES goals(id) ON DELETE CASCADE)',
    );
  }

  Future<void> _createDashboardWidgetsTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS dashboard_widgets(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, metric_key TEXT NOT NULL, title TEXT NOT NULL, is_visible INTEGER NOT NULL, sort_order INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE(profile_id, metric_key))',
    );
  }

  Future<void> _createWorkoutTypesTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS workout_types(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, name TEXT NOT NULL, description TEXT, muscle_groups TEXT, is_default INTEGER NOT NULL, is_hidden INTEGER NOT NULL DEFAULT 0, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE(profile_id, name))',
    );
  }

  Future<void> _createMuscleGroupsTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS muscle_groups(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE, parent_group TEXT, description TEXT, is_default INTEGER NOT NULL)',
    );
  }

  Future<void> _createWorkoutTemplatesTables(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS workout_templates(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, name TEXT NOT NULL, description TEXT, workout_type_id INTEGER, muscle_groups TEXT, created_at TEXT NOT NULL, updated_at TEXT NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS workout_template_exercises(id INTEGER PRIMARY KEY AUTOINCREMENT, template_id INTEGER NOT NULL, exercise_id INTEGER NOT NULL, sort_order INTEGER NOT NULL, default_sets INTEGER, default_reps INTEGER, default_weight_kg REAL, notes TEXT, FOREIGN KEY(template_id) REFERENCES workout_templates(id) ON DELETE CASCADE, FOREIGN KEY(exercise_id) REFERENCES exercises(id))',
    );
  }

  Future<void> _migrateProfiles(Database db) async {
    await _createProfilesTable(db);
    await _createWorkoutExercisesTable(db);
    final now = DateTime.now().toIso8601String();
    final existing = await db.query('profiles', limit: 1);
    if (existing.isEmpty) {
      final hasLegacyData = await _hasLegacyUserData(db);
      if (hasLegacyData) {
        await db.insert('profiles', {
          'id': 1,
          'name': 'Perfil importado',
          'pin_hash': PinService.hashPin('0000'),
          'created_at': now,
          'updated_at': now,
          'is_active': 1,
          'notes': 'Perfil migrado de uma versão antiga. Altera o PIN.',
        });
      }
    }

    await _addColumnIfMissing(db, 'user_profile', 'profile_id', 'INTEGER');
    await _addColumnIfMissing(db, 'body_measurements', 'profile_id', 'INTEGER');
    await _addColumnIfMissing(db, 'workouts', 'profile_id', 'INTEGER');
    await _addColumnIfMissing(db, 'workout_sets', 'profile_id', 'INTEGER');
    await _addColumnIfMissing(db, 'workout_exercises', 'profile_id', 'INTEGER');
    await _addColumnIfMissing(db, 'progress_photos', 'profile_id', 'INTEGER');
    await _addColumnIfMissing(db, 'goals', 'profile_id', 'INTEGER');
    await _addColumnIfMissing(db, 'goals', 'category', 'TEXT');

    for (final table in [
      'user_profile',
      'body_measurements',
      'workouts',
      'workout_sets',
      'workout_exercises',
      'progress_photos',
      'goals',
    ]) {
      await db.update(table, {'profile_id': 1}, where: 'profile_id IS NULL');
    }
    await db.update(
      'goals',
      {'category': 'Outro'},
      where: 'category IS NULL OR category = ?',
      whereArgs: [''],
    );
  }

  Future<bool> _hasLegacyUserData(Database db) async {
    for (final table in [
      'user_profile',
      'body_measurements',
      'workouts',
      'progress_photos',
      'goals',
    ]) {
      final rows = await db.rawQuery('SELECT COUNT(*) AS total FROM $table');
      if ((rows.first['total'] as int) > 0) return true;
    }
    return false;
  }

  static const _bodyMeasurementExtraColumns = {
    'bmi': 'REAL',
    'muscle_percentage': 'REAL',
    'body_water_percentage': 'REAL',
    'protein_percentage': 'REAL',
    'subcutaneous_fat_percentage': 'REAL',
    'visceral_fat': 'REAL',
    'bone_mass_kg': 'REAL',
    'basal_metabolism_kcal': 'REAL',
    'body_age': 'REAL',
    'neck_cm': 'REAL',
    'left_tricep_cm': 'REAL',
    'right_tricep_cm': 'REAL',
    'left_forearm_cm': 'REAL',
    'right_forearm_cm': 'REAL',
    'left_wrist_cm': 'REAL',
    'right_wrist_cm': 'REAL',
    'left_hand_cm': 'REAL',
    'right_hand_cm': 'REAL',
    'upper_chest_cm': 'REAL',
    'mid_chest_cm': 'REAL',
    'lower_chest_cm': 'REAL',
    'back_width_cm': 'REAL',
    'glutes_cm': 'REAL',
    'left_upper_thigh_cm': 'REAL',
    'left_mid_thigh_cm': 'REAL',
    'right_upper_thigh_cm': 'REAL',
    'right_mid_thigh_cm': 'REAL',
    'left_ankle_cm': 'REAL',
    'right_ankle_cm': 'REAL',
    'skinfold_chest_mm': 'REAL',
    'skinfold_abdominal_mm': 'REAL',
    'skinfold_suprailiac_mm': 'REAL',
    'skinfold_subscapular_mm': 'REAL',
    'skinfold_triceps_mm': 'REAL',
    'skinfold_midaxillary_mm': 'REAL',
    'skinfold_thigh_mm': 'REAL',
  };

  static const _bodyDataV53Columns = {
    'height_cm': 'REAL',
    'scale_bmi': 'REAL',
    'calculated_bmi': 'REAL',
    'body_score': 'REAL',
    'fat_mass_kg': 'REAL',
    'fat_free_body_weight_kg': 'REAL',
    'skeletal_muscle_mass_kg': 'REAL',
    'standard_weight_kg': 'REAL',
    'weight_control_kg': 'REAL',
    'fat_control_kg': 'REAL',
    'muscle_control_kg': 'REAL',
    'resting_heart_rate_bpm': 'REAL',
    'body_type': 'TEXT',
    'chest_upper_cm': 'REAL',
    'chest_middle_cm': 'REAL',
    'chest_lower_cm': 'REAL',
    'chest_total_cm': 'REAL',
    'waist_to_hip_ratio': 'REAL',
    'waist_to_height_ratio': 'REAL',
    'biceps_skinfold_mm': 'REAL',
    'triceps_skinfold_mm': 'REAL',
    'chest_skinfold_mm': 'REAL',
    'abdominal_skinfold_mm': 'REAL',
    'suprailiac_skinfold_mm': 'REAL',
    'subscapular_skinfold_mm': 'REAL',
    'midaxillary_skinfold_mm': 'REAL',
    'thigh_skinfold_mm': 'REAL',
    'medial_calf_skinfold_mm': 'REAL',
  };

  static const _exerciseExtraColumns = {
    'primary_muscle_group': 'TEXT',
    'secondary_muscle_groups': 'TEXT',
    'equipment': 'TEXT',
    'description': 'TEXT',
    'execution_steps': 'TEXT',
    'common_mistakes': 'TEXT',
    'safety_notes': 'TEXT',
    'is_hidden': 'INTEGER NOT NULL DEFAULT 0',
    'created_at': 'TEXT',
    'updated_at': 'TEXT',
  };

  static const _goalExtraColumns = {
    'metric_key': 'TEXT',
    'initial_value': 'REAL',
    'target_value': 'REAL',
    'unit': 'TEXT',
    'start_date': 'TEXT',
    'target_date': 'TEXT',
    'manual_progress': 'REAL',
    'notes': 'TEXT',
  };

  Future<void> _seedMuscleGroups(Database db) async {
    const groups = {
      'Costas': 'Dorsal, romboides, trapézio e lombar.',
      'Ombros':
          'Deltoide anterior, lateral, posterior e estabilidade escapular.',
      'Peito': 'Peitoral superior, médio e inferior.',
      'Bíceps e braquial': 'Bíceps, braquial e braquiorradial.',
      'Tríceps': 'Cabeça longa, lateral e medial do tríceps.',
      'Antebraço, punho, mão e pega':
          'Flexores/extensores do punho e força de pega.',
      'Core e abdominal': 'Abdómen, oblíquos, transverso e lombar.',
      'Pernas': 'Quadricípite, posterior, glúteos, adutores e gémeos.',
      'Cardio': 'Condicionamento e resistência.',
    };
    for (final entry in groups.entries) {
      await db.insert(
        'muscle_groups',
        MuscleGroup(
          name: entry.key,
          parentGroup: '',
          description: entry.value,
          isDefault: true,
        ).toMap()..remove('id'),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<void> _seedWorkoutTypes(Database db) async {
    final now = DateTime.now();
    for (final name in SeedData.workoutTypes) {
      final existing = await db.query(
        'workout_types',
        columns: ['id'],
        where: 'profile_id IS NULL AND name = ?',
        whereArgs: [name],
        limit: 1,
      );
      if (existing.isNotEmpty) continue;
      await db.insert(
        'workout_types',
        WorkoutType(
          name: name,
          description: 'Tipo de treino predefinido.',
          muscleGroups: _defaultGroupsForWorkoutType(name),
          isDefault: true,
          createdAt: now,
          updatedAt: now,
        ).toMap()..remove('id'),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<void> _seedExpandedMuscleGroups(Database db) async {
    const groups = {
      'Pescoço': 'Musculatura cervical. Usar cargas leves e controlo.',
      'Trapézio superior': 'Elevação e estabilização escapular.',
      'Trapézio médio': 'Retração escapular.',
      'Trapézio inferior': 'Depressão e rotação escapular.',
      'Deltoide anterior': 'Elevação e press à frente.',
      'Deltoide lateral': 'Largura visual dos ombros.',
      'Deltoide posterior': 'Parte posterior do ombro.',
      'Manguito rotador': 'Estabilidade e rotação do ombro.',
      'Peito superior': 'Porção clavicular do peitoral.',
      'Peito médio': 'Porção média do peitoral.',
      'Peito inferior': 'Porção inferior do peitoral.',
      'Serrátil anterior': 'Estabilidade escapular e caixa torácica.',
      'Dorsal / latíssimo do dorso': 'Largura das costas.',
      'Romboides': 'Retração escapular.',
      'Redondo maior': 'Auxiliar da puxada.',
      'Redondo menor': 'Estabilidade posterior do ombro.',
      'Eretores da espinha / lombar': 'Extensão e estabilidade lombar.',
      'Braços': 'Braço completo.',
      'Bíceps': 'Flexão do cotovelo e supinação.',
      'Braquial': 'Flexor profundo do cotovelo.',
      'Braquiorradial': 'Flexor do cotovelo no antebraço.',
      'Tríceps cabeça longa': 'Extensão do cotovelo e ombro.',
      'Tríceps cabeça lateral': 'Extensão do cotovelo.',
      'Tríceps cabeça medial': 'Extensão controlada do cotovelo.',
      'Antebraço e mão': 'Punho, mãos, dedos e pega.',
      'Flexores do antebraço': 'Flexão do punho e dedos.',
      'Extensores do antebraço': 'Extensão do punho e dedos.',
      'Pronação': 'Rotação interna do antebraço.',
      'Supinação': 'Rotação externa do antebraço.',
      'Punho': 'Estabilidade do punho.',
      'Mãos': 'Força geral da mão.',
      'Dedos': 'Pega fina e pinça.',
      'Força de pega': 'Capacidade de agarrar e sustentar carga.',
      'Reto abdominal': 'Flexão do tronco.',
      'Oblíquos': 'Rotação e inclinação lateral.',
      'Transverso abdominal': 'Estabilidade profunda.',
      'Lombar': 'Estabilidade posterior do tronco.',
      'Estabilidade do core': 'Controlo global do tronco.',
      'Glúteo máximo': 'Extensão da anca.',
      'Glúteo médio': 'Estabilidade lateral da anca.',
      'Glúteo mínimo': 'Estabilização profunda da anca.',
      'Quadríceps': 'Extensão do joelho.',
      'Reto femoral': 'Quadríceps e flexão da anca.',
      'Vasto lateral': 'Porção externa do quadríceps.',
      'Vasto medial': 'Porção interna do quadríceps.',
      'Vasto intermédio': 'Porção profunda do quadríceps.',
      'Posterior de coxa': 'Flexão do joelho e extensão da anca.',
      'Bíceps femoral': 'Posterior lateral da coxa.',
      'Semitendinoso': 'Posterior medial da coxa.',
      'Semimembranoso': 'Posterior medial profundo.',
      'Adutores': 'Adução da anca.',
      'Abdutores': 'Abdução da anca.',
      'Gémeos': 'Flexão plantar.',
      'Sóleo': 'Flexão plantar com joelho fletido.',
      'Tibial anterior': 'Dorsiflexão.',
      'Karate': 'Condicionamento e drills técnicos genéricos.',
      'Jiu-Jitsu': 'Mobilidade, base e condicionamento genérico.',
      'Mobilidade': 'Amplitude e controlo articular.',
      'Alongamento': 'Flexibilidade e recuperação.',
      'Outro': 'Grupo livre.',
    };
    for (final entry in groups.entries) {
      await db.insert(
        'muscle_groups',
        MuscleGroup(
          name: entry.key,
          parentGroup: '',
          description: entry.value,
          isDefault: true,
        ).toMap()..remove('id'),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  String _defaultGroupsForWorkoutType(String name) {
    return WorkoutTaxonomy.groupsFor(name).join(', ');
  }

  Future<void> _backfillExerciseDetails(Database db) async {
    await db.rawUpdate(
      'UPDATE exercises SET primary_muscle_group = muscle_group WHERE primary_muscle_group IS NULL OR primary_muscle_group = ""',
    );
    await db.rawUpdate(
      'UPDATE exercises SET description = "Exercício de força para desenvolver o grupo muscular principal com técnica controlada." WHERE description IS NULL OR description = ""',
    );
    await db.rawUpdate(
      'UPDATE exercises SET execution_steps = "1. Ajusta a posição inicial. 2. Mantém o tronco estável. 3. Executa a repetição com controlo. 4. Regressa sem perder tensão." WHERE execution_steps IS NULL OR execution_steps = ""',
    );
    await db.rawUpdate(
      'UPDATE exercises SET common_mistakes = "Carga excessiva, balanço do corpo e amplitude incompleta." WHERE common_mistakes IS NULL OR common_mistakes = ""',
    );
    await db.rawUpdate(
      'UPDATE exercises SET safety_notes = "Usa carga progressiva e interrompe se surgir dor articular." WHERE safety_notes IS NULL OR safety_notes = ""',
    );
  }

  String _equipmentFor(String name) {
    final lower = WorkoutTaxonomy.normalize(name);
    if (lower.contains('passadeira')) return 'Passadeira';
    if (lower.contains('bicicleta')) return 'Bicicleta';
    if (lower.contains('eliptica')) return 'Elíptica';
    if (lower.contains('corda de saltar') || lower.contains('hiit corda')) {
      return 'Corda de saltar';
    }
    if (lower.contains('elastico') ||
        lower.contains('rotacao externa') ||
        lower.contains('rotacao interna') ||
        lower.contains('pull-apart') ||
        lower.contains('com elastico')) {
      return 'Elásticos';
    }
    if (lower.contains('cabo') ||
        lower.contains('crossover') ||
        lower.contains('face pull') ||
        lower.contains('puxada') ||
        lower.contains('remo baixo') ||
        lower.contains('remo sentado') ||
        lower.contains('chest press')) {
      return 'Cabo ou máquina';
    }
    if (lower.contains('maquina') ||
        lower.contains('leg press') ||
        lower.contains('extensao de perna') ||
        lower.contains('curl de perna') ||
        lower.contains('adutor') ||
        lower.contains('abdutor') ||
        lower.contains('puxada alta') ||
        lower.contains('remo sentado')) {
      return 'Máquina';
    }
    if (lower.contains('halter') ||
        lower.contains('goblet') ||
        lower.contains('arnold') ||
        lower.contains('kickback') ||
        lower.contains('peso morto romeno com halteres') ||
        lower.contains('extensao unilateral') ||
        lower.contains('extensao francesa') ||
        lower.contains('aperto isometrico')) {
      return 'Halteres';
    }
    if (lower.contains('barra') ||
        lower.contains('supino fechado') ||
        lower.contains('agachamento com barra') ||
        lower.contains('good morning') ||
        lower.contains('triceps testa')) {
      return 'Barra, banco';
    }
    if (lower.contains('plate') || lower.contains('pinch')) {
      return 'Discos';
    }
    if (lower.contains('chin-up') ||
        lower.contains('pull-up') ||
        lower.contains('dead hang') ||
        lower.contains('elevacao de joelhos suspenso') ||
        lower.contains('remo invertido') ||
        lower.contains('towel grip')) {
      return 'Barra fixa';
    }
    if (lower.contains('jiu-jitsu') ||
        lower.contains('grappling') ||
        lower.contains('shrimp') ||
        lower.contains('guarda')) {
      return 'Tatami';
    }
    return 'Peso corporal';
  }

  String _secondaryGroupsFor(String name, String group) {
    final lower = WorkoutTaxonomy.normalize(name);
    if (lower.contains('supino') || lower.contains('flex')) {
      return 'Ombros, tríceps';
    }
    if (lower.contains('remo') || lower.contains('puxada')) {
      return 'Bíceps, antebraço, trapézio';
    }
    if (lower.contains('curl')) return 'Braquial, braquiorradial, antebraço';
    if (lower.contains('triceps') || lower.contains('dips')) return 'Ombros';
    if (lower.contains('agachamento') || lower.contains('lunges')) {
      return 'Glúteos, posterior de coxa, core';
    }
    if (lower.contains('peso morto') || lower.contains('hip thrust')) {
      return 'Glúteos, lombar, posterior de coxa';
    }
    if (group == 'Cardio') return 'Core, pernas, sistema cardiovascular';
    if (group == 'Karate') return 'Core, ancas, ombros';
    if (group == 'Jiu-Jitsu') return 'Core, ancas, pega';
    return '';
  }

  String _descriptionFor(String name, String group) {
    final lower = WorkoutTaxonomy.normalize(name);
    if (lower.contains('passadeira')) {
      return '$name é uma opção de cardio em passadeira para trabalhar resistência, ritmo e controlo da passada sem misturar outras máquinas.';
    }
    if (lower.contains('bicicleta')) {
      return '$name trabalha o sistema cardiovascular e as pernas usando bicicleta, com intensidade ajustada pela cadência e resistência.';
    }
    if (lower.contains('eliptica')) {
      return '$name é cardio de baixo impacto na elíptica, útil para elevar a frequência cardíaca com menor stress articular.';
    }
    if (lower.contains('corda')) {
      return '$name desenvolve coordenação, ritmo, capacidade cardiovascular e elasticidade dos tornozelos com corda de saltar.';
    }
    if (group == 'Karate') {
      return '$name é um drill de Karate para técnica, deslocamento, postura e condicionamento específico sem incluir drills exclusivos de Jiu-Jitsu.';
    }
    if (group == 'Jiu-Jitsu') {
      return '$name é um drill de Jiu-Jitsu para mobilidade no solo, base, core e pega sem incluir conteúdo exclusivo de Karate.';
    }
    return '$name trabalha principalmente $group, com atenção à postura, amplitude útil, respiração e progressão adequada ao nível atual.';
  }

  String _stepsFor(String name) {
    final lower = WorkoutTaxonomy.normalize(name);
    if (lower.contains('passadeira')) {
      return '1. Ajusta velocidade e inclinação antes de começar. 2. Mantém o tronco alto e olha em frente. 3. Pisa com cadência regular sem agarrar o corrimão. 4. Reduz gradualmente a intensidade no final.';
    }
    if (lower.contains('curl')) {
      return '1. Segura a carga com punhos neutros e abdómen ativo. 2. Sobe dobrando os cotovelos sem balançar o tronco. 3. Contrai no topo. 4. Desce controlando até quase estender os braços.';
    }
    if (lower.contains('agachamento')) {
      return '1. Coloca os pés firmes à largura adequada. 2. Desce levando a anca para trás e joelhos alinhados. 3. Mantém o tronco estável. 4. Sobe empurrando o chão sem colapsar os joelhos.';
    }
    if (lower.contains('peso morto')) {
      return '1. Aproxima a carga do corpo. 2. Dobra a anca mantendo coluna neutra. 3. Sobe contraindo glúteos e posteriores. 4. Desce a carga junto às pernas sem arredondar a lombar.';
    }
    return '1. Prepara a posição inicial e confirma que o equipamento está estável. 2. Executa $name com amplitude controlada. 3. Mantém respiração regular e tronco firme. 4. Regressa devagar sem perder alinhamento.';
  }

  String _commonMistakesFor(String name) {
    final lower = WorkoutTaxonomy.normalize(name);
    if (lower.contains('passadeira') ||
        lower.contains('corrida') ||
        lower.contains('sprint')) {
      return 'Aumentar a velocidade cedo demais, agarrar o corrimão, encurtar a passada ou ignorar aquecimento.';
    }
    if (lower.contains('curl')) {
      return 'Balançar o tronco, afastar os cotovelos do corpo, subir só meia amplitude ou deixar a carga cair.';
    }
    if (lower.contains('agachamento') || lower.contains('peso morto')) {
      return 'Perder coluna neutra, deixar joelhos colapsarem, usar carga excessiva ou cortar amplitude por falta de controlo.';
    }
    return 'Usar pressa, perder alinhamento, reduzir amplitude útil ou escolher resistência acima da técnica disponível.';
  }

  String _safetyNotesFor(String name) {
    final lower = WorkoutTaxonomy.normalize(name);
    if (lower.contains('pescoco') || lower.contains('cervical')) {
      return 'Usa força muito leve e progressiva. Para imediatamente se houver dor aguda, formigueiro, tontura ou pressão na cabeça.';
    }
    if (lower.contains('lombar') ||
        lower.contains('peso morto') ||
        lower.contains('agachamento')) {
      return 'Mantém coluna neutra e carga conservadora. Para se sentires dor lombar aguda, perda de controlo ou dor articular.';
    }
    if (lower.contains('hiit') ||
        lower.contains('sprint') ||
        lower.contains('karate') ||
        lower.contains('jiu-jitsu')) {
      return 'Aquece antes, controla a intensidade e para se houver tontura, falta de ar anormal, dor articular ou impacto mal controlado.';
    }
    return 'Começa leve, progride gradualmente e interrompe o exercício se surgir dor aguda, tontura ou perda de controlo técnico.';
  }

  Future<void> _addColumnIfMissing(
    Database db,
    String table,
    String column,
    String type,
  ) async {
    final info = await db.rawQuery('PRAGMA table_info($table)');
    final exists = info.any((row) => row['name'] == column);
    if (!exists) {
      try {
        await db.execute('ALTER TABLE $table ADD COLUMN $column $type');
      } on DatabaseException {
        // Some older installs may already have received a column through a
        // partially completed migration. Re-reading PRAGMA on the next launch is
        // enough; the migration must never drop user data.
      }
    }
  }

  Future<List<Profile>> profiles() async {
    final rows = await (await database).query('profiles', orderBy: 'name');
    return rows.map(Profile.fromMap).toList();
  }

  Future<Profile?> loadActiveProfile() async {
    final rows = await (await database).query(
      'profiles',
      where: 'is_active = 1',
      limit: 1,
    );
    if (rows.isEmpty) return null;
    _activeProfile = Profile.fromMap(rows.first);
    return _activeProfile;
  }

  Future<void> setActiveProfile(Profile profile) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.update('profiles', {'is_active': 0});
      await txn.update(
        'profiles',
        {'is_active': 1, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [profile.id],
      );
    });
    _activeProfile = profile.copyWith(isActive: true);
  }

  Future<bool> verifyProfilePin(Profile profile, String pin) async {
    return PinService.verifyPin(pin: pin, hash: profile.pinHash);
  }

  Future<Profile> createProfile({
    required String name,
    required String pin,
    double? heightCm,
    DateTime? birthDate,
    String sex = '',
    String activityLevel = '',
    String trainingLocation = '',
    List<String> trainingLocations = const [],
    List<String> initialGoals = const [],
    Map<String, String> availableEquipment = const {},
    String notes = '',
  }) async {
    final db = await database;
    final now = DateTime.now();
    final selectedLocations = trainingLocations.isEmpty
        ? TrainingLocationService.parse(trainingLocation)
        : trainingLocations.toSet();
    final serializedLocations = TrainingLocationService.serialize(
      selectedLocations,
    );
    final profile = Profile(
      name: name.trim(),
      pinHash: PinService.hashPin(pin),
      createdAt: now,
      updatedAt: now,
      isActive: true,
      heightCm: heightCm,
      birthDate: birthDate,
      sex: sex.trim(),
      activityLevel: activityLevel.trim(),
      trainingLocation: serializedLocations,
      initialGoals: initialGoals.join(', '),
      notes: notes.trim(),
    );
    final id = await db.transaction((txn) async {
      await txn.update('profiles', {'is_active': 0});
      final profileId = await txn.insert(
        'profiles',
        profile.toMap()..remove('id'),
      );
      await txn.insert('user_profile', {
        'profile_id': profileId,
        'name': profile.name,
        'height_cm': heightCm ?? 0,
        'start_date': now.toIso8601String(),
        'main_goal': initialGoals.isEmpty
            ? 'Objetivo livre'
            : initialGoals.first,
        'notes': notes.trim(),
      });
      await _insertDefaultGoals(txn, profileId, selectedGoals: initialGoals);
      await _insertDefaultDashboardWidgets(txn, profileId);
      await _insertProfileEquipment(
        txn,
        profileId: profileId,
        trainingLocation: serializedLocations,
        availableEquipment: availableEquipment,
      );
      await _insertProfileTrainingLocations(
        txn,
        profileId: profileId,
        selectedLocations: selectedLocations,
      );
      return profileId;
    });
    _activeProfile = profile.copyWith(id: id);
    return _activeProfile!;
  }

  Future<void> updateProfile(Profile profile) async {
    final updated = profile.copyWith(updatedAt: DateTime.now());
    final db = await database;
    await db.transaction((txn) async {
      await txn.update(
        'profiles',
        updated.toMap()..remove('id'),
        where: 'id = ?',
        whereArgs: [profile.id],
      );
      await _insertProfileTrainingLocations(
        txn,
        profileId: profile.id!,
        selectedLocations: TrainingLocationService.parse(
          updated.trainingLocation,
        ),
      );
    });
    _activeProfile = updated;
  }

  Future<void> _insertDefaultGoals(
    Transaction txn,
    int profileId, {
    List<String> selectedGoals = const [],
  }) async {
    final goals = selectedGoals.isEmpty
        ? SeedData.goals.take(4)
        : SeedData.goals.where((goal) => selectedGoals.contains(goal.title));
    for (final goal in goals) {
      await txn.insert(
        'goals',
        goal.toMap()
          ..remove('id')
          ..['profile_id'] = profileId,
      );
    }
  }

  Future<void> _insertProfileEquipment(
    DatabaseExecutor db, {
    required int profileId,
    required String trainingLocation,
    required Map<String, String> availableEquipment,
  }) async {
    final now = DateTime.now();
    final isGym = trainingLocation.toLowerCase().contains('gin');
    final equipment = isGym ? defaultEquipment : availableEquipment;
    for (final entry in defaultEquipment.entries) {
      await db.insert(
        'profile_equipment',
        ProfileEquipment(
          profileId: profileId,
          equipmentKey: entry.key,
          equipmentName: entry.value,
          isAvailable: isGym || equipment.containsKey(entry.key),
          createdAt: now,
          updatedAt: now,
        ).toMap()..remove('id'),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> _insertProfileTrainingLocations(
    DatabaseExecutor db, {
    required int profileId,
    required Set<String> selectedLocations,
  }) async {
    final now = DateTime.now();
    for (final option in TrainingLocationService.options) {
      await db.insert('profile_training_locations', {
        'profile_id': profileId,
        'location_key': option.toLowerCase().replaceAll(' ', '_'),
        'location_name': option,
        'is_selected': selectedLocations.contains(option) ? 1 : 0,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  static Map<String, String> get defaultEquipment =>
      ProfilePreferencesService.equipmentMap;

  Future<void> _insertDefaultDashboardWidgets(
    DatabaseExecutor db,
    int profileId,
  ) async {
    final now = DateTime.now();
    for (var i = 0; i < DashboardMetricService.definitions.length; i++) {
      final definition = DashboardMetricService.definitions[i];
      await db.insert(
        'dashboard_widgets',
        DashboardWidgetConfig(
          profileId: profileId,
          metricKey: definition.key,
          title: definition.title,
          isVisible: DashboardMetricService.defaultKeys.contains(
            definition.key,
          ),
          sortOrder: i,
          createdAt: now,
          updatedAt: now,
        ).toMap()..remove('id'),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  int _requireProfileId() {
    final id = activeProfileId;
    if (id == null) {
      throw StateError('Nenhum perfil ativo.');
    }
    return id;
  }

  Future<UserProfile> profile() async {
    final id = _requireProfileId();
    final rows = await (await database).query(
      'user_profile',
      where: 'profile_id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isNotEmpty) return UserProfile.fromMap(rows.first);
    final active = _activeProfile;
    return UserProfile(
      name: active?.name ?? 'Perfil',
      heightCm: active?.heightCm ?? 0,
      startDate: active?.createdAt ?? DateTime.now(),
      mainGoal: active?.initialGoals.isNotEmpty == true
          ? active!.initialGoals
          : 'Objetivo livre',
      notes: active?.notes ?? '',
    );
  }

  Future<List<BodyMeasurement>> measurements() async {
    final rows = await (await database).query(
      'body_measurements',
      where: 'profile_id = ?',
      whereArgs: [_requireProfileId()],
      orderBy: 'date DESC',
    );
    return rows.map(BodyMeasurement.fromMap).toList();
  }

  Future<void> insertMeasurement(BodyMeasurement measurement) async {
    await (await database).insert(
      'body_measurements',
      (measurement.toMap()..remove('id'))
        ..['profile_id'] = measurement.profileId ?? _requireProfileId(),
    );
  }

  Future<void> updateMeasurement(BodyMeasurement measurement) async {
    await (await database).update(
      'body_measurements',
      (measurement.toMap()..remove('id'))..['profile_id'] = _requireProfileId(),
      where: 'id = ? AND profile_id = ?',
      whereArgs: [measurement.id, _requireProfileId()],
    );
  }

  Future<void> deleteMeasurement(int id) async {
    await (await database).delete(
      'body_measurements',
      where: 'id = ? AND profile_id = ?',
      whereArgs: [id, _requireProfileId()],
    );
  }

  Future<List<ProfileEquipment>> profileEquipment() async {
    final rows = await (await database).query(
      'profile_equipment',
      where: 'profile_id = ?',
      whereArgs: [_requireProfileId()],
      orderBy: 'equipment_name',
    );
    return rows.map(ProfileEquipment.fromMap).toList();
  }

  Future<Set<String>> availableEquipmentKeys() async {
    final items = await profileEquipment();
    return items
        .where((item) => item.isAvailable)
        .map((item) => item.equipmentKey)
        .toSet();
  }

  Future<void> updateProfileEquipment(
    Map<String, String> availableEquipment,
  ) async {
    await _insertProfileEquipment(
      await database,
      profileId: _requireProfileId(),
      trainingLocation: '',
      availableEquipment: availableEquipment,
    );
  }

  Future<List<DashboardWidgetConfig>> dashboardWidgets() async {
    final db = await database;
    final profileId = _requireProfileId();
    final existing = await db.query(
      'dashboard_widgets',
      where: 'profile_id = ?',
      whereArgs: [profileId],
      orderBy: 'sort_order',
    );
    if (existing.isEmpty) {
      await _insertDefaultDashboardWidgets(db, profileId);
      final rows = await db.query(
        'dashboard_widgets',
        where: 'profile_id = ?',
        whereArgs: [profileId],
        orderBy: 'sort_order',
      );
      return rows.map(DashboardWidgetConfig.fromMap).toList();
    }
    final existingKeys = existing.map((row) => row['metric_key']).toSet();
    if (existingKeys.length < DashboardMetricService.definitions.length) {
      await _insertMissingDashboardWidgets(db, profileId, existingKeys);
      final rows = await db.query(
        'dashboard_widgets',
        where: 'profile_id = ?',
        whereArgs: [profileId],
        orderBy: 'sort_order',
      );
      return rows.map(DashboardWidgetConfig.fromMap).toList();
    }
    return existing.map(DashboardWidgetConfig.fromMap).toList();
  }

  Future<void> _insertMissingDashboardWidgets(
    DatabaseExecutor db,
    int profileId,
    Set<Object?> existingKeys,
  ) async {
    final now = DateTime.now();
    for (var i = 0; i < DashboardMetricService.definitions.length; i++) {
      final definition = DashboardMetricService.definitions[i];
      if (existingKeys.contains(definition.key)) continue;
      await db.insert(
        'dashboard_widgets',
        DashboardWidgetConfig(
          profileId: profileId,
          metricKey: definition.key,
          title: definition.title,
          isVisible: false,
          sortOrder: i,
          createdAt: now,
          updatedAt: now,
        ).toMap()..remove('id'),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<void> updateDashboardWidget(DashboardWidgetConfig widget) async {
    await (await database).update(
      'dashboard_widgets',
      widget.toMap()
        ..remove('id')
        ..['profile_id'] = _requireProfileId()
        ..['updated_at'] = DateTime.now().toIso8601String(),
      where: 'id = ? AND profile_id = ?',
      whereArgs: [widget.id, _requireProfileId()],
    );
  }

  Future<void> resetDashboardWidgets() async {
    final db = await database;
    final profileId = _requireProfileId();
    await db.delete(
      'dashboard_widgets',
      where: 'profile_id = ?',
      whereArgs: [profileId],
    );
    await _insertDefaultDashboardWidgets(db, profileId);
  }

  Future<List<Exercise>> exercises() async {
    final rows = await (await database).query(
      'exercises',
      where: 'is_hidden = 0 OR is_hidden IS NULL',
      orderBy: 'muscle_group, name',
    );
    return rows.map(Exercise.fromMap).toList();
  }

  Future<void> insertExercise(Exercise exercise) async {
    final now = DateTime.now();
    await (await database).insert(
      'exercises',
      (exercise.toMap()
        ..remove('id')
        ..['created_at'] = (exercise.createdAt ?? now).toIso8601String()
        ..['updated_at'] = (exercise.updatedAt ?? now).toIso8601String()),
    );
  }

  Future<void> updateExercise(Exercise exercise) async {
    await (await database).update(
      'exercises',
      (exercise.toMap()..remove('id'))
        ..['updated_at'] = DateTime.now().toIso8601String(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  Future<void> deleteExercise(int id) async {
    await (await database).update(
      'exercises',
      {'is_hidden': 1, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<WorkoutType>> workoutTypes() async {
    final profileId = _requireProfileId();
    final rows = await (await database).query(
      'workout_types',
      where: '(profile_id IS NULL OR profile_id = ?) AND is_hidden = 0',
      whereArgs: [profileId],
      orderBy: 'is_default DESC, name',
    );
    return rows.map(WorkoutType.fromMap).toList();
  }

  Future<int> insertWorkoutType(
    String name, {
    String description = '',
    String muscleGroups = '',
  }) async {
    final now = DateTime.now();
    return (await database).insert(
      'workout_types',
      WorkoutType(
        profileId: _requireProfileId(),
        name: name.trim(),
        description: description.trim(),
        muscleGroups: muscleGroups.trim(),
        isDefault: false,
        createdAt: now,
        updatedAt: now,
      ).toMap()..remove('id'),
    );
  }

  Future<void> updateWorkoutType(WorkoutType type) async {
    await (await database).update(
      'workout_types',
      (type.toMap()..remove('id'))
        ..['profile_id'] = type.isDefault ? null : _requireProfileId()
        ..['updated_at'] = DateTime.now().toIso8601String(),
      where: 'id = ?',
      whereArgs: [type.id],
    );
  }

  Future<void> hideWorkoutType(WorkoutType type) async {
    await (await database).update(
      'workout_types',
      {'is_hidden': 1, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [type.id],
    );
  }

  Future<List<MuscleGroup>> muscleGroups() async {
    final rows = await (await database).query('muscle_groups', orderBy: 'name');
    return rows.map(MuscleGroup.fromMap).toList();
  }

  Future<int> insertWorkout(Workout workout) async {
    return (await database).insert(
      'workouts',
      (workout.toMap()..remove('id'))
        ..['profile_id'] = workout.profileId ?? _requireProfileId(),
    );
  }

  Future<void> updateWorkout(Workout workout) async {
    await (await database).update(
      'workouts',
      (workout.toMap()..remove('id'))..['profile_id'] = _requireProfileId(),
      where: 'id = ? AND profile_id = ?',
      whereArgs: [workout.id, _requireProfileId()],
    );
  }

  Future<void> deleteWorkout(int id) async {
    final db = await database;
    final profileId = _requireProfileId();
    await db.transaction((txn) async {
      await txn.delete(
        'workout_sets',
        where: 'workout_id = ? AND profile_id = ?',
        whereArgs: [id, profileId],
      );
      await txn.delete(
        'workout_exercises',
        where: 'workout_id = ? AND profile_id = ?',
        whereArgs: [id, profileId],
      );
      await txn.delete(
        'workouts',
        where: 'id = ? AND profile_id = ?',
        whereArgs: [id, profileId],
      );
    });
  }

  Future<int> insertWorkoutFromTemplate({
    required Workout workout,
    required List<String> exerciseNames,
  }) async {
    final db = await database;
    final profileId = _requireProfileId();
    return db.transaction((txn) async {
      final workoutId = await txn.insert(
        'workouts',
        (workout.toMap()..remove('id'))..['profile_id'] = profileId,
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
            'profile_id': profileId,
            'workout_id': workoutId,
            'exercise_id': rows.first['id'],
            'notes': '',
          }, conflictAlgorithm: ConflictAlgorithm.ignore);
        }
      }
      return workoutId;
    });
  }

  Future<List<CustomWorkoutTemplate>> workoutTemplates() async {
    final rows = await (await database).query(
      'workout_templates',
      where: 'profile_id = ?',
      whereArgs: [_requireProfileId()],
      orderBy: 'name',
    );
    return rows.map(CustomWorkoutTemplate.fromMap).toList();
  }

  Future<int> insertWorkoutTemplate(CustomWorkoutTemplate template) async {
    return (await database).insert(
      'workout_templates',
      (template.toMap()..remove('id'))..['profile_id'] = _requireProfileId(),
    );
  }

  Future<void> insertWorkoutExercise(WorkoutExercise exercise) async {
    await (await database).insert(
      'workout_exercises',
      (exercise.toMap()..remove('id'))..['profile_id'] = _requireProfileId(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> insertWorkoutSet(WorkoutSet set) async {
    final db = await database;
    final profileId = _requireProfileId();
    await db.transaction((txn) async {
      await txn.insert('workout_exercises', {
        'profile_id': profileId,
        'workout_id': set.workoutId,
        'exercise_id': set.exerciseId,
        'notes': '',
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      await txn.insert(
        'workout_sets',
        (set.toMap()..remove('id'))..['profile_id'] = profileId,
      );
    });
  }

  Future<void> updateWorkoutSet(WorkoutSet set) async {
    await (await database).update(
      'workout_sets',
      (set.toMap()..remove('id'))..['profile_id'] = _requireProfileId(),
      where: 'id = ? AND profile_id = ?',
      whereArgs: [set.id, _requireProfileId()],
    );
  }

  Future<void> deleteWorkoutSet(int id) async {
    await (await database).delete(
      'workout_sets',
      where: 'id = ? AND profile_id = ?',
      whereArgs: [id, _requireProfileId()],
    );
  }

  Future<List<WorkoutEntry>> workouts() async {
    final db = await database;
    final profileId = _requireProfileId();
    final workoutRows = await db.query(
      'workouts',
      where: 'profile_id = ?',
      whereArgs: [profileId],
      orderBy: 'date DESC',
    );
    final entries = <WorkoutEntry>[];
    for (final row in workoutRows) {
      final workout = Workout.fromMap(row);
      final setRows = await db.rawQuery(
        'SELECT workout_sets.*, exercises.name AS exercise_name FROM workout_sets JOIN exercises ON exercises.id = workout_sets.exercise_id WHERE workout_id = ? AND workout_sets.profile_id = ? ORDER BY set_number',
        [workout.id, profileId],
      );
      final exerciseRows = await db.rawQuery(
        'SELECT workout_exercises.*, exercises.name AS exercise_name, exercises.primary_muscle_group AS muscle_group FROM workout_exercises JOIN exercises ON exercises.id = workout_exercises.exercise_id WHERE workout_id = ? AND workout_exercises.profile_id = ? ORDER BY workout_exercises.id',
        [workout.id, profileId],
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
      'SELECT COUNT(*) AS total FROM workouts WHERE date >= ? AND profile_id = ?',
      [start.toIso8601String(), _requireProfileId()],
    );
    return rows.first['total'] as int;
  }

  Future<void> insertPhoto(ProgressPhoto photo) async {
    await (await database).insert(
      'progress_photos',
      (photo.toMap()..remove('id'))
        ..['profile_id'] = photo.profileId ?? _requireProfileId(),
    );
  }

  Future<void> updatePhoto(ProgressPhoto photo) async {
    await (await database).update(
      'progress_photos',
      (photo.toMap()..remove('id'))..['profile_id'] = _requireProfileId(),
      where: 'id = ? AND profile_id = ?',
      whereArgs: [photo.id, _requireProfileId()],
    );
  }

  Future<void> deletePhoto(int id) async {
    await (await database).delete(
      'progress_photos',
      where: 'id = ? AND profile_id = ?',
      whereArgs: [id, _requireProfileId()],
    );
  }

  Future<List<ProgressPhoto>> photos() async {
    final rows = await (await database).query(
      'progress_photos',
      where: 'profile_id = ?',
      whereArgs: [_requireProfileId()],
      orderBy: 'date DESC',
    );
    return rows.map(ProgressPhoto.fromMap).toList();
  }

  Future<List<Goal>> goals() async {
    final rows = await (await database).query(
      'goals',
      where: 'profile_id = ?',
      whereArgs: [_requireProfileId()],
      orderBy: 'phase, id',
    );
    return rows.map(Goal.fromMap).toList();
  }

  Future<int> insertGoal(Goal goal) async {
    return (await database).insert(
      'goals',
      (goal.toMap()..remove('id'))
        ..['profile_id'] = goal.profileId ?? _requireProfileId(),
    );
  }

  Future<void> updateGoal(Goal goal) async {
    await (await database).update(
      'goals',
      (goal.toMap()..remove('id'))..['profile_id'] = _requireProfileId(),
      where: 'id = ? AND profile_id = ?',
      whereArgs: [goal.id, _requireProfileId()],
    );
  }

  Future<void> deleteGoal(int id) async {
    await (await database).delete(
      'goals',
      where: 'id = ? AND profile_id = ?',
      whereArgs: [id, _requireProfileId()],
    );
  }

  Future<List<GoalMilestone>> goalMilestones(int goalId) async {
    final rows = await (await database).query(
      'goal_milestones',
      where: 'goal_id = ?',
      whereArgs: [goalId],
      orderBy: 'sort_order',
    );
    return rows.map(GoalMilestone.fromMap).toList();
  }

  Future<void> insertGoalMilestone(GoalMilestone milestone) async {
    await (await database).insert(
      'goal_milestones',
      milestone.toMap()..remove('id'),
    );
  }

  Future<void> updateGoalMilestone(GoalMilestone milestone) async {
    await (await database).update(
      'goal_milestones',
      milestone.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [milestone.id],
    );
  }

  Future<void> setGoalCompleted(Goal goal, bool completed) async {
    await (await database).update(
      'goals',
      {
        'is_active': completed ? 0 : 1,
        'completed_at': completed ? DateTime.now().toIso8601String() : null,
      },
      where: 'id = ? AND profile_id = ?',
      whereArgs: [goal.id, _requireProfileId()],
    );
  }

  Future<Map<String, List<Map<String, Object?>>>> exportData() async {
    final db = await database;
    final profileId = _requireProfileId();
    return {
      'medidas': await db.query(
        'body_measurements',
        where: 'profile_id = ?',
        whereArgs: [profileId],
        orderBy: 'date',
      ),
      'treinos': await db.query(
        'workouts',
        where: 'profile_id = ?',
        whereArgs: [profileId],
        orderBy: 'date',
      ),
      'exercicios_treino': await db.rawQuery(
        'SELECT workout_exercises.id, workout_exercises.workout_id, workout_exercises.exercise_id, exercises.name AS exercise_name, exercises.muscle_group, workout_exercises.notes FROM workout_exercises JOIN exercises ON exercises.id = workout_exercises.exercise_id WHERE workout_exercises.profile_id = ? ORDER BY workout_id, workout_exercises.id',
        [profileId],
      ),
      'series': await db.query(
        'workout_sets',
        where: 'profile_id = ?',
        whereArgs: [profileId],
        orderBy: 'workout_id, set_number',
      ),
      'objetivos': await db.query(
        'goals',
        where: 'profile_id = ?',
        whereArgs: [profileId],
        orderBy: 'phase, id',
      ),
    };
  }
}
