import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/dashboard_widget_config.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test(
    'dashboard marker migration preserves legacy rows and explicit saves are profile scoped',
    () async {
      final db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      addTearDown(db.close);
      await db.execute(
        'CREATE TABLE dashboard_widgets(id INTEGER PRIMARY KEY AUTOINCREMENT, profile_id INTEGER NOT NULL, metric_key TEXT NOT NULL, title TEXT NOT NULL, is_visible INTEGER NOT NULL, sort_order INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE(profile_id, metric_key))',
      );
      final timestamp = DateTime(2026, 1, 1).toIso8601String();
      await db.insert('dashboard_widgets', {
        'profile_id': 1,
        'metric_key': 'weight',
        'title': 'Peso antigo',
        'is_visible': 1,
        'sort_order': 0,
        'created_at': timestamp,
        'updated_at': timestamp,
      });
      await db.insert('dashboard_widgets', {
        'profile_id': 2,
        'metric_key': 'weight',
        'title': 'Outro perfil',
        'is_visible': 1,
        'sort_order': 0,
        'created_at': timestamp,
        'updated_at': timestamp,
      });
      final appDatabase = AppDatabase.forTesting(
        db,
        activeProfile: Profile(
          id: 1,
          name: 'Sandro',
          pinHash: 'hash',
          createdAt: DateTime(2026, 1, 1),
          updatedAt: DateTime(2026, 1, 1),
          isActive: true,
        ),
      );

      await appDatabase.migrateDashboardWidgetExplicitPreferenceMarker();
      final legacy = (await db.query(
        'dashboard_widgets',
        where: 'profile_id = 1',
      )).single;
      expect(legacy['explicitly_configured_at'], isNull);
      expect(legacy['is_visible'], 1);

      await appDatabase.saveExplicitDashboardWidgets([
        DashboardWidgetConfig(
          profileId: 1,
          metricKey: 'weight',
          title: 'Peso atual',
          isVisible: false,
          sortOrder: 3,
          createdAt: DateTime(2026, 1, 1),
          updatedAt: DateTime(2026, 1, 1),
        ),
      ]);
      final explicit = (await db.query(
        'dashboard_widgets',
        where: 'profile_id = 1',
      )).single;
      expect(explicit['explicitly_configured_at'], isNotNull);
      expect(explicit['is_visible'], 0);
      expect(explicit['sort_order'], 3);
      final otherProfile = (await db.query(
        'dashboard_widgets',
        where: 'profile_id = 2',
      )).single;
      expect(otherProfile['explicitly_configured_at'], isNull);
      expect(otherProfile['is_visible'], 1);
    },
  );
}
