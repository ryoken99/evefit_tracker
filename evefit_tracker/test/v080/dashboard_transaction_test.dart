import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/dashboard_widget_config.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;
  late AppDatabase appDatabase;
  final created = DateTime(2026, 6, 22);

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(
      'CREATE TABLE dashboard_widgets(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, metric_key TEXT NOT NULL, title TEXT NOT NULL, is_visible INTEGER NOT NULL, sort_order INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL)',
    );
    for (var i = 0; i < 2; i++) {
      await db.insert('dashboard_widgets', {
        'profile_id': 1,
        'metric_key': 'metric_$i',
        'title': 'Metric $i',
        'is_visible': 1,
        'sort_order': i,
        'created_at': created.toIso8601String(),
        'updated_at': created.toIso8601String(),
      });
    }
    appDatabase = AppDatabase.forTesting(
      db,
      activeProfile: Profile(
        id: 1,
        name: 'A',
        pinHash: 'hash',
        createdAt: created,
        updatedAt: created,
        isActive: true,
      ),
    );
  });

  tearDown(() => db.close());

  test('dashboard batch rolls back when one widget is invalid', () async {
    final rows = await db.query('dashboard_widgets', orderBy: 'id');
    final first = DashboardWidgetConfig.fromMap(
      rows.first,
    ).copyWithVisible(false);
    final invalid = DashboardWidgetConfig(
      id: 999,
      profileId: 1,
      metricKey: 'invalid',
      title: 'Invalid',
      isVisible: false,
      sortOrder: 2,
      createdAt: created,
      updatedAt: created,
    );

    await expectLater(
      appDatabase.updateDashboardWidgets([first, invalid]),
      throwsStateError,
    );
    final after = await db.query('dashboard_widgets', orderBy: 'id');
    expect(after.first['is_visible'], 1);
  });
}

extension on DashboardWidgetConfig {
  DashboardWidgetConfig copyWithVisible(bool value) => DashboardWidgetConfig(
    id: id,
    profileId: profileId,
    metricKey: metricKey,
    title: title,
    isVisible: value,
    sortOrder: sortOrder,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
