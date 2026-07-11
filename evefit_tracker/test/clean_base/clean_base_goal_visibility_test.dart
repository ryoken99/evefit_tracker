import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:evefit_tracker/services/profile_preferences_service.dart';
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
    await _createCleanBaseTables(db);
  });

  tearDown(() => db.close());

  test('user with no selected goals sees zero displayed goals', () async {
    final database = AppDatabase.forTesting(db);
    await database.createProfile(name: 'Sandro', pin: '1234');

    expect((await database.profile()).mainGoal, isEmpty);
    expect(await database.goals(), isEmpty);
  });

  test('user selecting V-shape sees V-shape', () async {
    final database = AppDatabase.forTesting(db);
    await database.createProfile(
      name: 'Sandro',
      pin: '1234',
      initialGoals: const ['Construir V-shape'],
    );

    expect((await database.profile()).mainGoal, 'Construir V-shape');
    expect((await database.goals()).map((goal) => goal.title), [
      'Construir V-shape',
    ]);
  });

  test('user not selecting V-shape does not see V-shape', () async {
    final database = AppDatabase.forTesting(db);
    await database.createProfile(
      name: 'Sandro',
      pin: '1234',
      initialGoals: const ['Ganhar massa muscular', 'Melhorar cardio'],
    );

    final displayedGoals = (await database.profile()).mainGoal;

    expect(displayedGoals, contains('Ganhar massa muscular'));
    expect(displayedGoals, contains('Melhorar cardio'));
    expect(displayedGoals, isNot(contains('Construir V-shape')));
    expect((await database.goals()).map((goal) => goal.title), [
      'Ganhar massa muscular',
      'Melhorar cardio',
    ]);
  });

  test('dashboard and profile use the same selected goal source', () async {
    final activeProfile = _profile(
      initialGoals: 'Ganhar massa muscular, Melhorar cardio',
    );
    await db.insert('profiles', activeProfile.toMap()..remove('id'));
    await db.insert('user_profile', {
      'profile_id': 1,
      'name': 'Sandro',
      'height_cm': 181,
      'start_date': activeProfile.createdAt.toIso8601String(),
      'main_goal': 'Construir V-shape',
      'notes': '',
    });
    final database = AppDatabase.forTesting(db, activeProfile: activeProfile);

    final profile = await database.profile();
    final displayedGoals = ProfilePreferencesService.parseGeneralGoals(
      database.activeProfile?.initialGoals ?? profile.mainGoal,
    );

    expect(displayedGoals, ['Ganhar massa muscular', 'Melhorar cardio']);
    expect(displayedGoals, isNot(contains('Construir V-shape')));
  });
}

Future<void> _createCleanBaseTables(Database db) async {
  await db.execute(
    'CREATE TABLE profiles(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, pin_hash TEXT NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, is_active INTEGER NOT NULL, height_cm REAL, birth_date TEXT, sex TEXT, activity_level TEXT, training_location TEXT, initial_goals TEXT, notes TEXT)',
  );
  await db.execute(
    'CREATE TABLE user_profile(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, name TEXT NOT NULL, height_cm REAL NOT NULL, start_date TEXT NOT NULL, main_goal TEXT NOT NULL, notes TEXT)',
  );
  await db.execute(
    'CREATE TABLE goals(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, title TEXT NOT NULL, description TEXT, phase TEXT NOT NULL, category TEXT, metric_key TEXT, initial_value REAL, current_value REAL, target_value REAL, unit TEXT, start_date TEXT, target_date TEXT, periodicity TEXT, frequency_target INTEGER, manual_progress REAL, notes TEXT, is_active INTEGER NOT NULL, created_at TEXT NOT NULL, completed_at TEXT)',
  );
  await db.execute(
    'CREATE TABLE dashboard_widgets(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, metric_key TEXT NOT NULL, title TEXT NOT NULL, is_visible INTEGER NOT NULL, sort_order INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, explicitly_configured_at TEXT, UNIQUE(profile_id, metric_key))',
  );
  await db.execute(
    'CREATE TABLE profile_equipment(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, equipment_key TEXT NOT NULL, equipment_name TEXT NOT NULL, is_available INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL)',
  );
  await db.execute(
    'CREATE TABLE profile_training_locations(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, location_key TEXT NOT NULL, location_name TEXT NOT NULL, is_selected INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL)',
  );
  await db.execute(
    'CREATE TABLE body_measurements(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, date TEXT, weight REAL, body_fat REAL, muscle_mass REAL, visceral_fat REAL, body_water REAL, bone_mass REAL, basal_metabolism REAL, metabolic_age REAL, bmi REAL, waist REAL, abdomen REAL, hip REAL, chest REAL, neck REAL, shoulders REAL, arm_left_relaxed REAL, arm_right_relaxed REAL, arm_left_flexed REAL, arm_right_flexed REAL, forearm_left REAL, forearm_right REAL, thigh_left REAL, thigh_right REAL, calf_left REAL, calf_right REAL, waist_hip_ratio REAL, waist_height_ratio REAL, side_hip_area REAL, suprailiac_fold REAL, subscapular_fold REAL, abdominal_fold REAL, thigh_fold REAL, triceps_fold REAL, chest_fold REAL, axillary_fold REAL, notes TEXT)',
  );
  await db.execute(
    'CREATE TABLE workouts(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, date TEXT NOT NULL, workout_type TEXT NOT NULL, workout_type_id INTEGER, muscle_groups TEXT, region_key TEXT, group_key TEXT, subgroup_key TEXT, specific_muscle_key TEXT, equipment_key TEXT, duration_minutes INTEGER, notes TEXT)',
  );
}

Profile _profile({String initialGoals = ''}) {
  final now = DateTime(2026, 7, 9);
  return Profile(
    id: 1,
    name: 'Sandro',
    pinHash: 'hash',
    createdAt: now,
    updatedAt: now,
    isActive: true,
    heightCm: 181,
    initialGoals: initialGoals,
  );
}
