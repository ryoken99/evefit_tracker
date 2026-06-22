import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:evefit_tracker/services/pin_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;
  late Profile profile;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(
      'CREATE TABLE profile_security(profile_id INTEGER PRIMARY KEY, failed_attempts INTEGER NOT NULL DEFAULT 0, locked_until TEXT)',
    );
    final now = DateTime(2026, 6, 22);
    profile = Profile(
      id: 1,
      name: 'A',
      pinHash: PinService.hashPin('1234'),
      createdAt: now,
      updatedAt: now,
      isActive: true,
    );
  });

  tearDown(() => db.close());

  test('failed attempts and lock survive AppDatabase recreation', () async {
    var app = AppDatabase.forTesting(db, activeProfile: profile);
    expect(await app.verifyProfilePin(profile, '0000'), isFalse);
    expect(await app.verifyProfilePin(profile, '0000'), isFalse);

    app = AppDatabase.forTesting(db, activeProfile: profile);
    expect(await app.verifyProfilePin(profile, '0000'), isFalse);
    expect(await app.verifyProfilePin(profile, '0000'), isFalse);
    expect(await app.verifyProfilePin(profile, '0000'), isFalse);

    app = AppDatabase.forTesting(db, activeProfile: profile);
    expect(await app.isPinLocked(profile), isTrue);
    expect(await app.verifyProfilePin(profile, '1234'), isFalse);
  });
}
