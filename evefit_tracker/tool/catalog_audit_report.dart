// ignore_for_file: avoid_print

import 'dart:io';

import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';

void main(List<String> args) {
  final strict = args.contains('--strict');
  final result = CatalogQualityAudit.run(writeReports: true);

  print('Catalog audit');
  print('Catalog entries: ${result.totalExercises}');
  print('Unique canonical IDs: ${result.uniqueCanonicalIds}');
  print('Critical issues: ${result.criticalCount}');
  print('Warnings: ${result.warningCount}');
  print('Reports: build/reports/catalog_audit.md');
  print('Inventory: build/reports/catalog_inventory.md');
  print('Gap analysis: build/reports/catalog_gap_analysis.md');

  if (result.issues.isNotEmpty) {
    print('\nFirst issues:');
    for (final issue in result.issues.take(50)) {
      print('- $issue');
    }
  }

  if (strict && !result.passed) {
    stderr.writeln('Catalog quality gate failed.');
    exit(1);
  }
}
