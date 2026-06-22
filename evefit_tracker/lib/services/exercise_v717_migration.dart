import 'package:sqflite/sqflite.dart';

import 'exercise_catalog_context_service.dart';
import 'exercise_muscle_node_service.dart';

class ExerciseV717Migration {
  const ExerciseV717Migration._();

  static Future<void> migrate(DatabaseExecutor db) async {
    await _addColumnIfMissing(db, 'exercises', 'primaryMuscleNodes', 'TEXT');
    await _addColumnIfMissing(db, 'exercises', 'secondaryMuscleNodes', 'TEXT');
    await _upsertCatalogMuscleNodes(db);
  }

  static Future<void> _upsertCatalogMuscleNodes(DatabaseExecutor db) async {
    final columns = await _columnsFor(db, 'exercises');
    final now = DateTime.now().toIso8601String();
    for (final entry in ExerciseCatalogContextService.entries) {
      final nodes = ExerciseMuscleNodeService.nodesForCatalogEntry(entry);
      final rows = await db.query(
        'exercises',
        columns: ['id'],
        where:
            'is_default = 1 AND (catalog_entry_key = ? OR (name = ? AND muscle_group = ?))',
        whereArgs: [entry.catalogEntryKey, entry.name, entry.group],
        limit: 1,
      );
      final data = <String, Object?>{
        ...entry.toExercise().toMap(),
        'primaryMuscleNodes': nodes.primary,
        'secondaryMuscleNodes': nodes.secondary,
        'updated_at': now,
      }..remove('id');
      if (rows.isNotEmpty) {
        await db.update(
          'exercises',
          _filterColumns(data, columns),
          where: 'id = ?',
          whereArgs: [rows.first['id']],
        );
      } else if (entry.group == 'Lombar') {
        await db.insert(
          'exercises',
          _filterColumns({...data, 'created_at': now}, columns),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    }
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

  static Map<String, Object?> _filterColumns(
    Map<String, Object?> values,
    Set<String> columns,
  ) {
    return {
      for (final entry in values.entries)
        if (columns.contains(entry.key)) entry.key: entry.value,
    };
  }
}
