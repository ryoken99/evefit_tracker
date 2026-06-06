import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../models/body_measurement.dart';
import '../models/dashboard_widget_config.dart';
import '../models/exercise.dart';
import '../models/goal.dart';
import '../models/muscle_group.dart';
import '../models/profile.dart';
import '../models/progress_photo.dart';
import '../models/user_profile.dart';
import '../models/workout.dart';
import '../models/workout_exercise.dart';
import '../models/workout_set.dart';
import '../models/workout_template.dart';
import '../models/workout_type.dart';
import '../services/dashboard_metric_service.dart';
import '../services/pin_service.dart';
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
      version: 4,
      onCreate: (db, version) async {
        await _createTables(db);
        await _migrateV5(db);
        await _seedExercises(db);
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
      'CREATE TABLE workouts(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, date TEXT NOT NULL, workout_type TEXT NOT NULL, duration_minutes INTEGER, notes TEXT)',
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
      'CREATE TABLE IF NOT EXISTS profiles(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, pin_hash TEXT NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, is_active INTEGER NOT NULL DEFAULT 0, notes TEXT)',
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
        await db.insert(
          'exercises',
          Exercise(
            name: name,
            muscleGroup: entry.key,
            isDefault: true,
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

  Future<void> _createDashboardWidgetsTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS dashboard_widgets(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, metric_key TEXT NOT NULL, title TEXT NOT NULL, is_visible INTEGER NOT NULL, sort_order INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE(profile_id, metric_key))',
    );
  }

  Future<void> _createWorkoutTypesTable(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS workout_types(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, name TEXT NOT NULL, description TEXT, is_default INTEGER NOT NULL, is_hidden INTEGER NOT NULL DEFAULT 0, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE(profile_id, name))',
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
    const defaultProfileId = 1;
    final now = DateTime.now().toIso8601String();
    final existing = await db.query('profiles', limit: 1);
    if (existing.isEmpty) {
      await db.insert('profiles', {
        'id': defaultProfileId,
        'name': 'Sandro',
        'pin_hash': PinService.hashPin('1234'),
        'created_at': now,
        'updated_at': now,
        'is_active': 1,
        'notes': 'PIN_PADRAO_1234',
      });
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
      await db.update(table, {
        'profile_id': defaultProfileId,
      }, where: 'profile_id IS NULL');
    }
    await db.update(
      'goals',
      {'category': 'Outro'},
      where: 'category IS NULL OR category = ?',
      whereArgs: [''],
    );
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
      await db.insert(
        'workout_types',
        WorkoutType(
          name: name,
          description: 'Tipo de treino predefinido.',
          isDefault: true,
          createdAt: now,
          updatedAt: now,
        ).toMap()..remove('id'),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
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
    final lower = name.toLowerCase();
    if (lower.contains('halter')) return 'Halteres';
    if (lower.contains('barra')) return 'Barra';
    if (lower.contains('máquina') || lower.contains('cabo')) {
      return 'Máquina/cabo';
    }
    if (lower.contains('passadeira')) return 'Passadeira';
    return 'Peso corporal ou equipamento simples';
  }

  String _descriptionFor(String name, String group) =>
      '$name trabalha principalmente $group com foco em controlo, amplitude e progressão.';

  String _stepsFor(String name) =>
      '1. Prepara a posição inicial. 2. Faz $name com movimento controlado. 3. Mantém a respiração e a postura. 4. Regressa devagar à posição inicial.';

  Future<void> _addColumnIfMissing(
    Database db,
    String table,
    String column,
    String type,
  ) async {
    final info = await db.rawQuery('PRAGMA table_info($table)');
    final exists = info.any((row) => row['name'] == column);
    if (!exists) {
      await db.execute('ALTER TABLE $table ADD COLUMN $column $type');
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
    String notes = '',
  }) async {
    final db = await database;
    final now = DateTime.now();
    final profile = Profile(
      name: name.trim(),
      pinHash: PinService.hashPin(pin),
      createdAt: now,
      updatedAt: now,
      isActive: true,
      notes: notes.trim(),
    );
    final id = await db.transaction((txn) async {
      await txn.update('profiles', {'is_active': 0});
      final profileId = await txn.insert(
        'profiles',
        profile.toMap()..remove('id'),
      );
      await _insertDefaultGoals(txn, profileId);
      await _insertDefaultDashboardWidgets(txn, profileId);
      return profileId;
    });
    _activeProfile = profile.copyWith(id: id);
    return _activeProfile!;
  }

  Future<void> updateProfile(Profile profile) async {
    await (await database).update(
      'profiles',
      profile.copyWith(updatedAt: DateTime.now()).toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [profile.id],
    );
    _activeProfile = profile.copyWith(updatedAt: DateTime.now());
  }

  Future<void> _insertDefaultGoals(Transaction txn, int profileId) async {
    for (final goal in SeedData.goals) {
      await txn.insert(
        'goals',
        goal.toMap()
          ..remove('id')
          ..['profile_id'] = profileId,
      );
    }
  }

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
      heightCm: 0,
      startDate: active?.createdAt ?? DateTime.now(),
      mainGoal: 'V-shape',
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
    return existing.map(DashboardWidgetConfig.fromMap).toList();
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

  Future<int> insertWorkoutType(String name, {String description = ''}) async {
    final now = DateTime.now();
    return (await database).insert(
      'workout_types',
      WorkoutType(
        profileId: _requireProfileId(),
        name: name.trim(),
        description: description.trim(),
        isDefault: false,
        createdAt: now,
        updatedAt: now,
      ).toMap()..remove('id'),
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

  Future<void> insertGoal(Goal goal) async {
    await (await database).insert(
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
