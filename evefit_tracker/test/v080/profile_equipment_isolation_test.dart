import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/profile.dart';
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
      'CREATE TABLE profile_equipment(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, equipment_key TEXT NOT NULL, equipment_name TEXT NOT NULL, is_available INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE(profile_id, equipment_key))',
    );
  });

  tearDown(() => db.close());

  test(
    'bodyweight is available even when a home profile selected nothing',
    () async {
      final database = AppDatabase.forTesting(
        db,
        activeProfile: _profile(1, 'Casa'),
      );

      expect(await database.availableEquipmentKeys(), {
        'bodyweight',
        'floor',
        'wall',
      });
    },
  );

  test('profile A never receives profile B equipment', () async {
    final now = DateTime(2026, 6, 22).toIso8601String();
    await db.insert('profile_equipment', {
      'profile_id': 1,
      'equipment_key': 'dumbbells',
      'equipment_name': 'Halteres',
      'is_available': 1,
      'created_at': now,
      'updated_at': now,
    });
    await db.insert('profile_equipment', {
      'profile_id': 2,
      'equipment_key': 'barbell',
      'equipment_name': 'Barra',
      'is_available': 1,
      'created_at': now,
      'updated_at': now,
    });

    final profileA = AppDatabase.forTesting(
      db,
      activeProfile: _profile(1, 'Casa'),
    );
    final profileB = AppDatabase.forTesting(
      db,
      activeProfile: _profile(2, 'Casa'),
    );

    expect(await profileA.availableEquipmentKeys(), {
      'bodyweight',
      'floor',
      'wall',
      'dumbbells',
    });
    expect(await profileB.availableEquipmentKeys(), {
      'bodyweight',
      'floor',
      'wall',
      'barbell',
    });
  });

  test('equipment update uses the active profile real gym location', () async {
    final database = AppDatabase.forTesting(
      db,
      activeProfile: _profile(1, 'Ginásio'),
    );

    await database.updateProfileEquipment({});

    expect(
      await database.availableEquipmentKeys(),
      containsAll({
        'bodyweight',
        'dumbbells',
        'barbell',
        'plates',
        'machine',
        'high_cable',
        'low_cable',
        'adjustable_bench',
      }),
    );
  });

  test('home equipment update changes only the active profile', () async {
    final now = DateTime(2026, 6, 22).toIso8601String();
    await db.insert('profile_equipment', {
      'profile_id': 2,
      'equipment_key': 'barbell',
      'equipment_name': 'Barra',
      'is_available': 1,
      'created_at': now,
      'updated_at': now,
    });
    final profileA = AppDatabase.forTesting(
      db,
      activeProfile: _profile(1, 'Casa'),
    );
    final profileB = AppDatabase.forTesting(
      db,
      activeProfile: _profile(2, 'Casa'),
    );

    await profileA.updateProfileEquipment({'bands': 'Elásticos'});

    expect(await profileA.availableEquipmentKeys(), {
      'bodyweight',
      'floor',
      'wall',
      'bands',
    });
    expect(await profileB.availableEquipmentKeys(), {
      'bodyweight',
      'floor',
      'wall',
      'barbell',
    });
  });
}

Profile _profile(int id, String location) {
  final now = DateTime(2026, 6, 22);
  return Profile(
    id: id,
    name: 'Perfil $id',
    pinHash: 'hash-$id',
    createdAt: now,
    updatedAt: now,
    isActive: true,
    trainingLocation: location,
  );
}
