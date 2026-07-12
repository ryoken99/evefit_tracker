import 'package:sqflite/sqflite.dart';

class ExerciseV717Migration {
  const ExerciseV717Migration._();

  static Future<void> migrate(DatabaseExecutor db) async {
    await _addColumnIfMissing(db, 'exercises', 'primaryMuscleNodes', 'TEXT');
    await _addColumnIfMissing(db, 'exercises', 'secondaryMuscleNodes', 'TEXT');
  }

  static Future<void> _addColumnIfMissing(
    DatabaseExecutor db,
    String table,
    String column,
    String type,
  ) async {
    final columns = await _columnsFor(db, table);
    if (columns.contains(column)) return;
    try {
      await db.execute('ALTER TABLE $table ADD COLUMN $column $type');
    } on DatabaseException {
      // Older installs may have received the column through a partial upgrade.
    }
  }

  static Future<Set<String>> _columnsFor(
    DatabaseExecutor db,
    String table,
  ) async {
    final info = await db.rawQuery('PRAGMA table_info($table)');
    return info.map((row) => row['name'] as String).toSet();
  }
}
