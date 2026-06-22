import 'package:sqflite/sqflite.dart';

import '../../services/legacy_text_normalizer.dart';

class V080IntegrityMigration {
  const V080IntegrityMigration._();

  static const exerciseColumns = <String, String>{
    'profile_id': 'INTEGER',
    'region_keys': 'TEXT',
    'group_keys': 'TEXT',
    'subgroup_keys': 'TEXT',
    'primary_muscle_key': 'TEXT',
    'secondary_muscle_keys': 'TEXT',
    'equipment_keys': 'TEXT',
    'movement_pattern': 'TEXT',
    'difficulty': 'TEXT',
    'force_type': 'TEXT',
    'laterality': 'TEXT',
    'goal_tags': 'TEXT',
    'regression': 'TEXT',
    'progression': 'TEXT',
    'breathing_tips': 'TEXT',
    'posture_tips': 'TEXT',
    'adaptation_notes': 'TEXT',
  };

  static const _textColumns = <String, List<String>>{
    'profiles': ['name', 'training_location', 'initial_goals', 'notes'],
    'user_profile': ['name', 'main_goal', 'notes'],
    'goals': ['title', 'description', 'category', 'unit', 'notes'],
    'goal_milestones': ['title', 'unit'],
    'profile_equipment': ['equipment_name'],
    'profile_training_locations': ['location_name'],
    'workout_types': ['name', 'description', 'muscle_groups'],
    'muscle_groups': ['name', 'parent_group', 'description'],
    'exercises': [
      'name',
      'muscle_group',
      'primary_muscle_group',
      'secondary_muscle_groups',
      'equipment',
      'description',
      'execution_steps',
      'common_mistakes',
      'safety_notes',
      'regression',
      'progression',
      'breathing_tips',
      'posture_tips',
      'adaptation_notes',
      'notes',
    ],
  };

  static Future<void> migrate(Database db) async {
    for (final column in exerciseColumns.entries) {
      await _addColumnIfMissing(
        db,
        table: 'exercises',
        column: column.key,
        type: column.value,
      );
    }
    await db.execute(
      'CREATE TABLE IF NOT EXISTS profile_hidden_exercises('
      'profile_id INTEGER NOT NULL, '
      'exercise_id INTEGER NOT NULL, '
      'created_at TEXT NOT NULL, '
      'PRIMARY KEY(profile_id, exercise_id))',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS profile_security('
      'profile_id INTEGER PRIMARY KEY, '
      'failed_attempts INTEGER NOT NULL DEFAULT 0, '
      'locked_until TEXT)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_exercises_profile_id '
      'ON exercises(profile_id)',
    );
    if (await _tableExists(db, 'goal_milestones')) {
      await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_goal_milestones_goal_id '
        'ON goal_milestones(goal_id)',
      );
    }
    await _normalizeKnownText(db);
  }

  static Future<void> _normalizeKnownText(Database db) async {
    for (final tableEntry in _textColumns.entries) {
      if (!await _tableExists(db, tableEntry.key)) continue;
      final availableColumns = await _columnNames(db, tableEntry.key);
      final columns = tableEntry.value
          .where(availableColumns.contains)
          .toList(growable: false);
      if (columns.isEmpty) continue;
      final rows = await db.query(tableEntry.key, columns: ['id', ...columns]);
      for (final row in rows) {
        final update = <String, Object?>{};
        for (final column in columns) {
          final value = row[column];
          if (value is! String || value.isEmpty) continue;
          final normalized = LegacyTextNormalizer.normalize(value);
          if (normalized != value) update[column] = normalized;
        }
        if (update.isNotEmpty) {
          await db.update(
            tableEntry.key,
            update,
            where: 'id = ?',
            whereArgs: [row['id']],
          );
        }
      }
    }
  }

  static Future<void> _addColumnIfMissing(
    Database db, {
    required String table,
    required String column,
    required String type,
  }) async {
    if (!await _tableExists(db, table)) return;
    final columns = await _columnNames(db, table);
    if (!columns.contains(column)) {
      await db.execute('ALTER TABLE $table ADD COLUMN $column $type');
    }
  }

  static Future<bool> _tableExists(Database db, String table) async {
    final rows = await db.query(
      'sqlite_master',
      columns: ['name'],
      where: 'type = ? AND name = ?',
      whereArgs: ['table', table],
      limit: 1,
    );
    return rows.isNotEmpty;
  }

  static Future<Set<String>> _columnNames(Database db, String table) async {
    final rows = await db.rawQuery('PRAGMA table_info($table)');
    return rows.map((row) => row['name'] as String).toSet();
  }
}
