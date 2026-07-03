import 'dart:io';

import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';

void main() {
  final byDesc = <String, List<String>>{};
  final bySteps = <String, List<String>>{};
  for (final entry in ExerciseCatalogContextService.entries) {
    byDesc
        .putIfAbsent(entry.details.description, () => [])
        .add('${entry.name} [${entry.group}]');
    bySteps
        .putIfAbsent(entry.details.executionSteps, () => [])
        .add('${entry.name} [${entry.group}]');
  }
  final out = StringBuffer('# DESC CLUSTERS\n');
  for (final item in byDesc.entries) {
    final unique = item.value.map((v) => v.split(' [').first).toSet();
    if (unique.length > 1) {
      out.writeln('- (${item.value.length}) ${item.value.join(' | ')}');
    }
  }
  out.writeln('\n# STEP CLUSTERS\n');
  for (final item in bySteps.entries) {
    final unique = item.value.map((v) => v.split(' [').first).toSet();
    if (unique.length > 1) {
      out.writeln('- (${item.value.length}) ${item.value.join(' | ')}');
    }
  }
  File('tool/dup_clusters.txt').writeAsStringSync(out.toString());
  stdout.writeln('wrote tool/dup_clusters.txt');
}
