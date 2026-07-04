import 'dart:io';

import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';

/// Gera a secção programática do relatório final (lista completa dos 315
/// exercícios revistos, agrupados por grupo muscular).
void main() {
  final buffer = StringBuffer();
  String? group;
  for (final entry in ExerciseCatalogContextService.entries) {
    if (entry.group != group) {
      group = entry.group;
      buffer.writeln('\n### $group\n');
    }
    buffer.writeln(
      '- ${entry.id} ${entry.name} — objetivo '
      '${entry.details.description.length} chars, '
      '${entry.details.executionSteps.split('\n').length} passos, '
      '${entry.details.commonMistakes.split('\n').length} erros comuns',
    );
  }
  File('tool/rewrite_report_list.md').writeAsStringSync(buffer.toString());
  stdout.writeln('wrote tool/rewrite_report_list.md');
}
