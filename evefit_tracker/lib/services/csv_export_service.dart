import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

import '../database/app_database.dart';

class CsvExportService {
  Future<String> exportAll(AppDatabase database) async {
    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/exports');
    await folder.create(recursive: true);
    final data = await database.exportData();
    final buffer = StringBuffer();
    for (final entry in data.entries) {
      buffer.writeln(entry.key);
      if (entry.value.isEmpty) {
        buffer.writeln();
        continue;
      }
      final headers = entry.value.first.keys.toList();
      buffer.writeln(csv.encode([headers]));
      buffer.writeln(
        csv.encode(
          entry.value
              .map((row) => headers.map((header) => row[header]).toList())
              .toList(),
        ),
      );
      buffer.writeln();
    }
    final file = File('${folder.path}/evefit_export.csv');
    await file.writeAsString(buffer.toString());
    return file.path;
  }
}
