import 'package:evefit_tracker/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// FASE 8 da revisão v0.9.1: a migração de conteúdo atualiza apenas os
/// exercícios de catálogo (is_default = 1) e preserva exercícios
/// personalizados e histórico de treinos.
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
    await db.insert('exercises', {
      'id': 10,
      'name': 'Flexão diamante',
      'muscle_group': 'Tríceps',
      'is_default': 1,
      'equipment': 'Peso corporal',
      'description': 'Texto antigo demasiado longo e genérico.',
      'execution_steps':
          '1. Segura Peso corporal. 2. Desce a carga com controlo.',
      'catalog_entry_key': 'flexao_diamante__triceps',
    });
    await db.insert('exercises', {
      'id': 11,
      'name': 'Flexão diamante do utilizador',
      'muscle_group': 'Tríceps',
      'is_default': 0,
      'profile_id': 1,
      'equipment': 'Peso corporal',
      'description': 'Notas pessoais do utilizador.',
      'execution_steps': 'A minha forma preferida de fazer.',
      'notes': 'não mexer',
    });
    await db.insert('workouts', {
      'id': 5,
      'profile_id': 1,
      'date': DateTime(2026, 7, 1).toIso8601String(),
      'workout_type': 'Braços',
    });
    await db.insert('workout_sets', {
      'id': 7,
      'profile_id': 1,
      'workout_id': 5,
      'exercise_id': 10,
      'set_number': 1,
      'reps': 12,
    });
  });

  tearDown(() => db.close());

  test('v0.9.1 refresh updates catalog rows and preserves user data', () async {
    final database = AppDatabase.forTesting(db);
    await database.refreshCatalogExercises(db);

    final catalog = (await db.query('exercises', where: 'id = 10')).single;
    final description = catalog['description']! as String;
    final steps = catalog['execution_steps']! as String;
    expect(description.length, inInclusiveRange(60, 280));
    expect(description, isNot(contains('Texto antigo')));
    expect(steps, contains('\n'));
    expect(steps.toLowerCase(), contains('diamante'));
    expect(steps.toLowerCase(), isNot(contains('desce a carga')));
    expect(steps.toLowerCase(), isNot(contains('segura peso corporal')));

    final custom = (await db.query('exercises', where: 'id = 11')).single;
    expect(custom['description'], 'Notas pessoais do utilizador.');
    expect(custom['execution_steps'], 'A minha forma preferida de fazer.');
    expect(custom['notes'], 'não mexer');
    expect(custom['is_default'], 0);

    final sets = await db.query('workout_sets');
    expect(sets, hasLength(1));
    expect(sets.single['reps'], 12);

    // Instalações novas e antigas convergem: todos os 398 exercícios de
    // catálogo ficam presentes após o refresh.
    final total = await db.rawQuery(
      'SELECT COUNT(*) AS c FROM exercises WHERE is_default = 1',
    );
    expect(total.single['c'], 398);
  });
}
