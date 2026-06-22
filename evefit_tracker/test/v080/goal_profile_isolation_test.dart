import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/goal.dart';
import 'package:evefit_tracker/models/goal_milestone.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;
  late AppDatabase profileADatabase;
  late AppDatabase profileBDatabase;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(
      'CREATE TABLE goals(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER, title TEXT NOT NULL, description TEXT, phase TEXT NOT NULL, category TEXT, metric_key TEXT, initial_value REAL, current_value REAL, target_value REAL, unit TEXT, start_date TEXT, target_date TEXT, periodicity TEXT, frequency_target INTEGER, manual_progress REAL, notes TEXT, is_active INTEGER NOT NULL, created_at TEXT NOT NULL, completed_at TEXT)',
    );
    await db.execute(
      'CREATE TABLE goal_milestones(id INTEGER PRIMARY KEY AUTOINCREMENT, goal_id INTEGER NOT NULL, title TEXT NOT NULL, target_value REAL, unit TEXT, status TEXT NOT NULL, sort_order INTEGER NOT NULL, created_at TEXT NOT NULL, completed_at TEXT)',
    );
    await db.execute(
      'CREATE TABLE body_measurements(id INTEGER PRIMARY KEY, profile_id INTEGER, date TEXT)',
    );
    await db.execute(
      'CREATE TABLE workouts(id INTEGER PRIMARY KEY, profile_id INTEGER, date TEXT)',
    );
    await db.execute(
      'CREATE TABLE exercises(id INTEGER PRIMARY KEY, name TEXT, muscle_group TEXT)',
    );
    await db.execute(
      'CREATE TABLE workout_exercises(id INTEGER PRIMARY KEY, profile_id INTEGER, workout_id INTEGER, exercise_id INTEGER, notes TEXT)',
    );
    await db.execute(
      'CREATE TABLE workout_sets(id INTEGER PRIMARY KEY, profile_id INTEGER, workout_id INTEGER, exercise_id INTEGER, set_number INTEGER)',
    );
    final now = DateTime(2026, 6, 22).toIso8601String();
    await db.insert('goals', {
      'id': 10,
      'profile_id': 1,
      'title': 'Objetivo A',
      'phase': 'Ativo',
      'is_active': 1,
      'created_at': now,
    });
    await db.insert('goals', {
      'id': 20,
      'profile_id': 2,
      'title': 'Objetivo B',
      'phase': 'Ativo',
      'is_active': 1,
      'created_at': now,
    });
    await db.insert('goal_milestones', {
      'id': 101,
      'goal_id': 10,
      'title': 'Milestone A',
      'status': 'active',
      'sort_order': 0,
      'created_at': now,
    });
    await db.insert('goal_milestones', {
      'id': 201,
      'goal_id': 20,
      'title': 'Milestone B',
      'status': 'active',
      'sort_order': 0,
      'created_at': now,
    });

    profileADatabase = AppDatabase.forTesting(
      db,
      activeProfile: _profile(1, 'Perfil A'),
    );
    profileBDatabase = AppDatabase.forTesting(
      db,
      activeProfile: _profile(2, 'Perfil B'),
    );
  });

  tearDown(() => db.close());

  test('profile A sees only goals owned by profile A', () async {
    expect((await profileADatabase.goals()).map((goal) => goal.id), [10]);
    expect((await profileBDatabase.goals()).map((goal) => goal.id), [20]);
  });

  test('profile A cannot read milestones through profile B goal', () async {
    expect(await profileADatabase.goalMilestones(20), isEmpty);
    expect(
      (await profileBDatabase.goalMilestones(20)).map((item) => item.id),
      [201],
    );
  });

  test('profile A cannot update complete or delete profile B goal', () async {
    final foreignGoal = (await profileBDatabase.goals()).single;

    await profileADatabase.updateGoal(
      Goal(
        id: foreignGoal.id,
        profileId: foreignGoal.profileId,
        title: 'Alterado por A',
        description: foreignGoal.description,
        phase: foreignGoal.phase,
        isActive: foreignGoal.isActive,
        createdAt: foreignGoal.createdAt,
      ),
    );
    await profileADatabase.setGoalCompleted(foreignGoal, true);
    await profileADatabase.deleteGoal(foreignGoal.id!);

    final row = (await db.query(
      'goals',
      where: 'id = ?',
      whereArgs: [20],
    )).single;
    expect(row['title'], 'Objetivo B');
    expect(row['is_active'], 1);
    expect(row['completed_at'], isNull);
  });

  test('profile A cannot insert update or delete profile B milestone', () async {
    final foreign = (await profileBDatabase.goalMilestones(20)).single;

    await expectLater(
      profileADatabase.insertGoalMilestone(
        GoalMilestone(
          goalId: 20,
          title: 'Intrusão A',
          sortOrder: 1,
          createdAt: DateTime(2026, 6, 22),
        ),
      ),
      throwsStateError,
    );
    await profileADatabase.updateGoalMilestone(
      GoalMilestone(
        id: foreign.id,
        goalId: foreign.goalId,
        title: 'Alterado por A',
        sortOrder: foreign.sortOrder,
        createdAt: foreign.createdAt,
      ),
    );
    await profileADatabase.deleteGoalMilestone(foreign.id!);

    final rows = await db.query(
      'goal_milestones',
      where: 'goal_id = ?',
      whereArgs: [20],
    );
    expect(rows, hasLength(1));
    expect(rows.single['title'], 'Milestone B');
  });

  test('profile export contains only its goals and milestones', () async {
    final exportA = await profileADatabase.exportData();
    final exportB = await profileBDatabase.exportData();

    expect(exportA['objetivos']!.map((row) => row['id']), [10]);
    expect(exportA['milestones']!.map((row) => row['id']), [101]);
    expect(exportB['objetivos']!.map((row) => row['id']), [20]);
    expect(exportB['milestones']!.map((row) => row['id']), [201]);
  });
}

Profile _profile(int id, String name) {
  final now = DateTime(2026, 6, 22);
  return Profile(
    id: id,
    name: name,
    pinHash: 'hash-$id',
    createdAt: now,
    updatedAt: now,
    isActive: true,
  );
}
