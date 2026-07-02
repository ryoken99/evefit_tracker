import 'dart:io';

import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';

void main(List<String> args) {
  final needle = args.join(' ').toLowerCase();
  for (final entry in ExerciseCatalogContextService.entries) {
    if (!entry.name.toLowerCase().contains(needle)) continue;
    stdout
      ..writeln('=== ${entry.id} ${entry.name} [${entry.group}]')
      ..writeln('EQUIP: ${entry.details.equipment}')
      ..writeln('SEC: ${entry.details.secondaryGroups}')
      ..writeln('DESC: ${entry.details.description}')
      ..writeln('STEPS: ${entry.details.executionSteps}')
      ..writeln('MISTAKES: ${entry.details.commonMistakes}')
      ..writeln('SAFETY: ${entry.details.safetyNotes}')
      ..writeln();
  }
}
