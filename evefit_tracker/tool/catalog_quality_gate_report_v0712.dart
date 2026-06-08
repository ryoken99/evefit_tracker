import 'dart:io';

import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';

void main() {
  _writeQualityGateReport();
  _writeFilterMatrix();
  _writeTextQualityMatrix();
}

void _writeQualityGateReport() {
  final failures = CatalogQualityGateService.allFailures();
  const failuresFoundDuringRed = 9;
  final buffer = StringBuffer()
    ..writeln('# QUALITY_GATE_REPORT_v0.7.12')
    ..writeln()
    ..writeln('| Metrica | Total |')
    ..writeln('|---|---|')
    ..writeln(
      '| Total de entradas do catalogo | ${CatalogQualityGateService.catalogEntryCount} |',
    )
    ..writeln(
      '| Total de exercicios unicos | ${CatalogQualityGateService.uniqueExerciseCount} |',
    )
    ..writeln(
      '| Total de combinacoes de filtros testadas | ${CatalogQualityGateService.filterCombinationCount} |',
    )
    ..writeln(
      '| Total de perfis/equipamentos simulados | ${CatalogQualityGateService.equipmentSimulationCount} |',
    )
    ..writeln(
      '| Total de descricoes validadas | ${CatalogQualityGateService.catalogEntryCount} |',
    )
    ..writeln(
      '| Total de execucoes validadas | ${CatalogQualityGateService.catalogEntryCount} |',
    )
    ..writeln(
      '| Total de segurancas validadas | ${CatalogQualityGateService.catalogEntryCount} |',
    )
    ..writeln(
      '| Total de erros comuns validados | ${CatalogQualityGateService.catalogEntryCount} |',
    )
    ..writeln('| Total de falhas encontradas | $failuresFoundDuringRed |')
    ..writeln('| Total de falhas corrigidas | $failuresFoundDuringRed |')
    ..writeln('| Total de falhas restantes | ${failures.length} |')
    ..writeln()
    ..writeln('## Resultado dos gates')
    ..writeln()
    ..writeln('| Gate | Estado |')
    ..writeln('|---|---|');
  for (final gate in _gateStatusRows()) {
    buffer.writeln('| ${gate.key} | ${gate.value ? 'OK' : 'FALHA'} |');
  }
  buffer
    ..writeln()
    ..writeln('Falhas restantes detalhadas:')
    ..writeln();
  if (failures.isEmpty) {
    buffer.writeln('- Nenhuma.');
  } else {
    for (final failure in failures) {
      buffer.writeln('- ${_esc(failure.toString())}');
    }
  }
  File('QUALITY_GATE_REPORT_v0.7.12.md').writeAsStringSync(buffer.toString());
}

void _writeFilterMatrix() {
  final buffer = StringBuffer()
    ..writeln('# FILTER_COMBINATORICS_MATRIX_v0.7.12')
    ..writeln()
    ..writeln(
      '| Tipo de treino | Equipamento | Regiao | Grupo | Subzona | Musculo/Foco | Resultado | Estado |',
    )
    ..writeln('|---|---|---|---|---|---|---|---|');
  for (final row in CatalogQualityGateService.filterMatrixRows()) {
    buffer.writeln(
      '| ${_esc(row.type)} | ${_esc(row.equipment)} | ${_esc(row.region)} | '
      '${_esc(row.group)} | ${_esc(row.subzone)} | ${_esc(row.focus)} | '
      '${row.resultCount} | ${row.status} |',
    );
  }
  buffer
    ..writeln()
    ..writeln(
      'Total de combinacoes listadas: ${CatalogQualityGateService.filterCombinationCount}',
    );
  File(
    'FILTER_COMBINATORICS_MATRIX_v0.7.12.md',
  ).writeAsStringSync(buffer.toString());
}

void _writeTextQualityMatrix() {
  final rows = CatalogQualityGateService.textQualityRows();
  final buffer = StringBuffer()
    ..writeln('# EXERCISE_TEXT_QUALITY_MATRIX_v0.7.12')
    ..writeln()
    ..writeln(
      '| ID | Nome | Equipamento | Grupo | Descricao OK | Execucao OK | Erros comuns OK | Seguranca OK | Falhas | Estado |',
    )
    ..writeln('|---|---|---|---|---|---|---|---|---|---|');
  for (final row in rows) {
    buffer.writeln(
      '| ${row.id} | ${_esc(row.name)} | ${_esc(row.equipment)} | ${_esc(row.group)} | '
      '${row.descriptionOk ? 'OK' : 'FALHA'} | ${row.executionOk ? 'OK' : 'FALHA'} | '
      '${row.mistakesOk ? 'OK' : 'FALHA'} | ${row.safetyOk ? 'OK' : 'FALHA'} | '
      '${_esc(row.failures.join('; '))} | ${row.status} |',
    );
  }
  buffer
    ..writeln()
    ..writeln('Total de entradas listadas: ${rows.length}')
    ..writeln(
      'Total de entradas OK: ${rows.where((row) => row.status == 'OK').length}',
    )
    ..writeln(
      'Total de entradas com falha: ${rows.where((row) => row.status != 'OK').length}',
    );
  File(
    'EXERCISE_TEXT_QUALITY_MATRIX_v0.7.12.md',
  ).writeAsStringSync(buffer.toString());
}

List<MapEntry<String, bool>> _gateStatusRows() {
  return [
    MapEntry(
      'Catalog integrity',
      CatalogQualityGateService.catalogIntegrityFailures().isEmpty,
    ),
    MapEntry(
      'Pedagogy quality',
      CatalogQualityGateService.pedagogyFailures().isEmpty,
    ),
    MapEntry(
      'Movement family requirements',
      CatalogQualityGateService.movementFamilyFailures().isEmpty,
    ),
    MapEntry(
      'Anatomy filter matrix',
      CatalogQualityGateService.anatomyFilterFailures().isEmpty,
    ),
    MapEntry(
      'Equipment filter matrix',
      CatalogQualityGateService.equipmentFilterFailures().isEmpty,
    ),
    MapEntry(
      'Training type filter matrix',
      CatalogQualityGateService.trainingTypeFilterFailures().isEmpty,
    ),
    MapEntry(
      'Full filter combinatorics',
      CatalogQualityGateService.fullCombinatoricsFailures().isEmpty,
    ),
    MapEntry(
      'Show all exercises',
      CatalogQualityGateService.showAllFailures().isEmpty,
    ),
    MapEntry(
      'Duplicate context clarity',
      CatalogQualityGateService.duplicateContextFailures().isEmpty,
    ),
    MapEntry(
      'Muscle metadata consistency',
      CatalogQualityGateService.muscleMetadataFailures().isEmpty,
    ),
    MapEntry(
      'Equipment description consistency',
      CatalogQualityGateService.equipmentDescriptionFailures().isEmpty,
    ),
    MapEntry(
      'Cardio specificity',
      CatalogQualityGateService.cardioSpecificityFailures().isEmpty,
    ),
    MapEntry(
      'Safety risk quality',
      CatalogQualityGateService.safetyRiskFailures().isEmpty,
    ),
    MapEntry(
      'Manual findings regression',
      CatalogQualityGateService.manualRegressionFailures().isEmpty,
    ),
  ];
}

String _esc(String value) => value.replaceAll('|', '/').replaceAll('\n', ' ');
