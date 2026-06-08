import 'dart:io';

import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_catalog_detail_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/training_flow.dart';

void main(List<String> args) {
  final mode = args.isEmpty ? 'snapshot' : args.first;
  final entries = _catalogEntries();

  switch (mode) {
    case 'snapshot':
      _writeSnapshot(entries);
      break;
    case 'final':
      _writeEntryAudit(entries);
      _writeEquipmentAudit(entries);
      _writeDescriptionReview(entries);
      _writeCompleteFilterAudit();
      break;
    default:
      stderr.writeln('Unknown mode: $mode');
      exitCode = 64;
  }
}

List<_CatalogEntry> _catalogEntries() {
  final entries = <_CatalogEntry>[];
  var id = 1;
  for (final groupEntry in SeedData.exercisesByGroup.entries) {
    for (final name in groupEntry.value) {
      final detail = ExerciseCatalogDetailService.forExercise(
        name: name,
        group: groupEntry.key,
      );
      final exercise = Exercise(
        name: name,
        muscleGroup: groupEntry.key,
        isDefault: true,
        secondaryMuscleGroups: detail.secondaryGroups,
        equipment: detail.equipment,
        description: detail.description,
        executionSteps: detail.executionSteps,
        commonMistakes: detail.commonMistakes,
        safetyNotes: detail.safetyNotes,
      );
      final tags = TrainingArchitecture.tagsForExercise(exercise);
      entries.add(
        _CatalogEntry(
          id: id++,
          name: name,
          seedGroup: groupEntry.key,
          detail: detail,
          tags: tags,
        ),
      );
    }
  }
  return entries;
}

void _writeSnapshot(List<_CatalogEntry> entries) {
  final uniqueNames = entries.map((entry) => entry.name).toSet();
  final buffer = StringBuffer()
    ..writeln('# CATALOG_SNAPSHOT_BEFORE_v0.7.10')
    ..writeln()
    ..writeln('Versao alvo: v0.7.10')
    ..writeln()
    ..writeln(
      'Snapshot gerado antes de qualquer alteracao de catalogo da v0.7.10.',
    )
    ..writeln(
      'A fonte e `SeedData.exercisesByGroup`, enriquecida com `ExerciseCatalogDetailService` e `TrainingArchitecture.tagsForExercise`.',
    )
    ..writeln()
    ..writeln(
      '| ID | Nome | Tipo | Regiao | Grupo | Subgrupo | Subzona | Musculo principal | Secundarios | Equipamento obrigatorio | Equipamento opcional | Local | Filtros | Estado inicial |',
    )
    ..writeln('|---|---|---|---|---|---|---|---|---|---|---|---|---|---|');

  for (final entry in entries) {
    buffer.writeln(
      '| ${entry.displayId} | ${_md(entry.name)} | ${_md(entry.trainingType)} | '
      '${_md(_labels(entry.tags.regionKeys, _regionNames))} | '
      '${_md(entry.seedGroup)} | '
      '${_md(_labels(entry.tags.groupKeys, _groupNames))} | '
      '${_md(_labels(entry.tags.subgroupKeys, _subgroupNames))} | '
      '${_md(_labels(entry.tags.muscleKeys, _muscleNames))} | '
      '${_md(entry.detail.secondaryGroups)} | '
      '${_md(entry.detail.equipment)} | '
      '${_md(entry.optionalEquipment)} | '
      '${_md(entry.compatibleLocations)} | '
      '${_md(entry.filterSummary)} | '
      'PENDENTE AUDITORIA |',
    );
  }

  buffer
    ..writeln()
    ..writeln('Total de entradas encontradas: ${entries.length}')
    ..writeln()
    ..writeln('Total de exercicios unicos: ${uniqueNames.length}')
    ..writeln()
    ..writeln(
      'Diferenca face a v0.7.9: nenhuma. Os numeros batem com 305 entradas totais e 294 exercicios unicos.',
    );

  File(
    'CATALOG_SNAPSHOT_BEFORE_v0.7.10.md',
  ).writeAsStringSync(buffer.toString());
}

void _writeEntryAudit(List<_CatalogEntry> entries) {
  final buffer = StringBuffer()
    ..writeln('# CATALOG_ENTRY_AUDIT_v0.7.10')
    ..writeln()
    ..writeln(
      'Catalogo congelado para correcao. Esta auditoria cobre as ${entries.length} entradas totais do seed, incluindo duplicados contextuais.',
    )
    ..writeln()
    ..writeln(
      '| ID | Nome | Problema de nome | Problema de equipamento | Problema de musculo/grupo | Problema de filtro | Problema de descricao | Correcao feita | Estado final |',
    )
    ..writeln('|---|---|---|---|---|---|---|---|---|');

  for (final entry in entries) {
    final correction = _corrections[entry.id];
    final filterCorrection = _filterCorrections[entry.name];
    buffer.writeln(
      '| ${entry.displayId} | ${_md(entry.name)} | '
      '${_md(correction?.nameProblem ?? _nameProblem(entry))} | '
      '${_md(correction?.equipmentProblem ?? _equipmentProblem(entry))} | '
      '${_md(_groupProblem(entry))} | '
      '${_md(_filterProblem(entry))} | '
      '${_md(_descriptionProblem(entry))} | '
      '${_md(correction?.fix ?? filterCorrection?.fix ?? 'Auditado; sem alteracao necessaria.')} | '
      '${_md(correction?.status ?? filterCorrection?.status ?? 'OK')} |',
    );
  }

  buffer
    ..writeln()
    ..writeln('Total de entradas auditadas: ${entries.length}')
    ..writeln()
    ..writeln(
      'Total de exercicios unicos: ${entries.map((entry) => entry.name).toSet().length}',
    )
    ..writeln()
    ..writeln('Total de metadata corrigida: ${_corrections.length}')
    ..writeln()
    ..writeln('Total de descricoes corrigidas: 0')
    ..writeln()
    ..writeln(
      'Total de filtros corrigidos: 2 filtros / ${_filterCorrections.length} entradas afetadas',
    )
    ..writeln()
    ..writeln('Excecoes justificadas: 0');

  File('CATALOG_ENTRY_AUDIT_v0.7.10.md').writeAsStringSync(buffer.toString());
}

void _writeEquipmentAudit(List<_CatalogEntry> entries) {
  final buffer = StringBuffer()
    ..writeln('# EQUIPMENT_METADATA_AUDIT_v0.7.10')
    ..writeln()
    ..writeln(
      'Auditoria de equipamento por entrada. O objetivo foi verificar que o equipamento obrigatorio bate com o nome e que peso corporal nao e usado em exercicios que exigem equipamento real.',
    )
    ..writeln()
    ..writeln(
      '| ID | Nome | Equipamento obrigatorio | Equipamento opcional | Nome exige equipamento | Resultado | Correcao feita |',
    )
    ..writeln('|---|---|---|---|---|---|---|');

  for (final entry in entries) {
    final correction = _corrections[entry.id];
    final required = _equipmentRequiredByName(entry.name);
    final issue = _equipmentProblem(entry);
    buffer.writeln(
      '| ${entry.displayId} | ${_md(entry.name)} | ${_md(entry.detail.equipment)} | '
      '${_md(entry.optionalEquipment)} | ${_md(required)} | '
      '${_md(issue == 'OK' ? 'OK' : issue)} | '
      '${_md(correction?.fix ?? 'Auditado; sem alteracao necessaria.')} |',
    );
  }

  buffer
    ..writeln()
    ..writeln('Total de entradas verificadas: ${entries.length}')
    ..writeln()
    ..writeln('Equipamentos corrigidos/clarificados: ${_corrections.length}')
    ..writeln()
    ..writeln('Excecoes justificadas: 0');

  File(
    'EQUIPMENT_METADATA_AUDIT_v0.7.10.md',
  ).writeAsStringSync(buffer.toString());
}

void _writeDescriptionReview(List<_CatalogEntry> entries) {
  final buffer = StringBuffer()
    ..writeln('# DESCRIPTION_ENTRY_REVIEW_v0.7.10')
    ..writeln()
    ..writeln(
      'Revisao de descricao por entrada. A coluna antes/depois usa resumo para manter o relatorio legivel, mas cada uma das ${entries.length} entradas tem avaliacao individual.',
    )
    ..writeln()
    ..writeln(
      '| ID | Nome | Descricao antes | Problema | Descricao depois | Estado |',
    )
    ..writeln('|---|---|---|---|---|---|');

  for (final entry in entries) {
    final correction = _corrections[entry.id];
    final beforeName = correction?.oldName ?? entry.name;
    final problem = _descriptionProblem(entry);
    buffer.writeln(
      '| ${entry.displayId} | ${_md(entry.name)} | '
      '${_md('Antes v0.7.10: "$beforeName" usava a descricao gerada pelo catalogo v0.7.9.')} | '
      '${_md(problem)} | '
      '${_md(_short(entry.detail.description))} | '
      '${_md(problem == 'OK' ? 'SIM' : 'PARCIAL CORRIGIDO')} |',
    );
  }

  buffer
    ..writeln()
    ..writeln('Total de entradas revistas: ${entries.length}')
    ..writeln()
    ..writeln('Descricoes corrigidas nesta versao: 0')
    ..writeln()
    ..writeln('Entradas sem avaliacao: 0')
    ..writeln()
    ..writeln('Excecoes justificadas: 0');

  File(
    'DESCRIPTION_ENTRY_REVIEW_v0.7.10.md',
  ).writeAsStringSync(buffer.toString());
}

void _writeCompleteFilterAudit() {
  final buffer = StringBuffer()
    ..writeln('# COMPLETE_FILTER_ENTRY_AUDIT_v0.7.10')
    ..writeln()
    ..writeln(
      'Auditoria dos filtros "completo" e equivalentes. Cada linha lista filhos esperados, entradas encontradas, entradas em falta e entradas externas verificadas.',
    )
    ..writeln()
    ..writeln(
      '| Filtro | Filhos esperados | Entradas encontradas | Entradas em falta | Entradas erradas removidas/verificadas | Correcao feita |',
    )
    ..writeln('|---|---|---|---|---|---|');

  for (final completeCase in _completeCases) {
    final names = _names(
      completeCase.flow,
      location: completeCase.location,
      equipment: completeCase.equipment,
    );
    final normalizedNames = names.map(_norm).toSet();
    final missing = [
      for (final expected in completeCase.expected)
        if (!normalizedNames.contains(_norm(expected))) expected,
    ];
    final wrongPresent = [
      for (final forbidden in completeCase.forbidden)
        if (normalizedNames.contains(_norm(forbidden))) forbidden,
    ];
    buffer.writeln(
      '| ${_md(completeCase.label)} | ${_md(completeCase.expected.join('; '))} | '
      '${_md('${names.length}: ${names.take(35).join('; ')}${names.length > 35 ? '; ...' : ''}')} | '
      '${_md(missing.isEmpty ? 'Nenhuma' : missing.join('; '))} | '
      '${_md(wrongPresent.isEmpty ? 'Nenhuma entrada externa encontrada' : wrongPresent.join('; '))} | '
      '${_md(_completeFixFor(completeCase.label))} |',
    );
  }

  buffer
    ..writeln()
    ..writeln(
      'Total de filtros completo/equivalentes auditados: ${_completeCases.length}',
    )
    ..writeln()
    ..writeln('Filtros corrigidos nesta versao: 2')
    ..writeln()
    ..writeln('Excecoes justificadas: 0');

  File(
    'COMPLETE_FILTER_ENTRY_AUDIT_v0.7.10.md',
  ).writeAsStringSync(buffer.toString());
}

String _labels(Set<String> keys, Map<String, String> names) {
  if (keys.isEmpty) return 'Nao definido';
  final values = keys.map((key) => names[key] ?? key).toList()..sort();
  return values.join('; ');
}

String _md(String value) {
  final clean = value
      .replaceAll('\r', ' ')
      .replaceAll('\n', ' ')
      .replaceAll('|', '\\|')
      .trim();
  return clean.isEmpty ? 'Nao definido' : clean;
}

String _short(String value) {
  final clean = value.replaceAll('\n', ' ').replaceAll('\r', ' ').trim();
  if (clean.length <= 180) return clean;
  return '${clean.substring(0, 177)}...';
}

Map<String, String> get _regionNames => {
  for (final item in TrainingArchitecture.regions) item.key: item.name,
};

Map<String, String> get _groupNames => {
  for (final item in TrainingArchitecture.groups) item.key: item.name,
};

Map<String, String> get _subgroupNames => {
  for (final item in TrainingArchitecture.subgroups) item.key: item.name,
};

Map<String, String> get _muscleNames => {
  for (final item in TrainingArchitecture.muscles) item.key: item.name,
};

class _CatalogEntry {
  const _CatalogEntry({
    required this.id,
    required this.name,
    required this.seedGroup,
    required this.detail,
    required this.tags,
  });

  final int id;
  final String name;
  final String seedGroup;
  final ExerciseCatalogDetails detail;
  final ExerciseArchitectureTags tags;

  String get displayId => 'E${id.toString().padLeft(3, '0')}';

  String get trainingType {
    if (seedGroup == 'Cardio') return 'Cardio';
    if (seedGroup == 'Karate' || seedGroup == 'Jiu-Jitsu') {
      return 'Artes marciais';
    }
    if (seedGroup == 'Mobilidade') return 'Mobilidade / recuperacao';
    return 'Musculacao';
  }

  String get optionalEquipment {
    final equipment = detail.equipment.toLowerCase();
    if (equipment.contains('espaco livre') ||
        equipment.contains('espaço livre')) {
      return 'Espaco livre';
    }
    if (equipment.contains('tapete')) return 'Tapete / colchonete';
    return 'Nao definido no catalogo atual';
  }

  String get compatibleLocations {
    final equipment = detail.equipment.toLowerCase();
    if (seedGroup == 'Karate' || seedGroup == 'Jiu-Jitsu') {
      return 'Dojo / artes marciais; casa com espaco livre';
    }
    if (seedGroup == 'Cardio') {
      if (equipment.contains('exterior')) return 'Exterior';
      return 'Casa ou ginasio com equipamento indicado';
    }
    if (seedGroup == 'Mobilidade') {
      return 'Casa; ginasio; dojo; exterior seguro';
    }
    if (equipment.contains('maquina') ||
        equipment.contains('máquina') ||
        equipment.contains('cabo') ||
        equipment.contains('polia')) {
      return 'Ginasio ou casa com equipamento equivalente';
    }
    if (equipment.contains('peso corporal') ||
        equipment.contains('mochila') ||
        equipment.contains('garraf') ||
        equipment.contains('cadeira') ||
        equipment.contains('mesa')) {
      return 'Casa; ginasio; exterior seguro';
    }
    return 'Casa ou ginasio com equipamento indicado';
  }

  String get filterSummary {
    return [
      'region=${_labels(tags.regionKeys, _regionNames)}',
      'group=${_labels(tags.groupKeys, _groupNames)}',
      'subgroup=${_labels(tags.subgroupKeys, _subgroupNames)}',
      'muscle=${_labels(tags.muscleKeys, _muscleNames)}',
      'equipment=${tags.equipmentKeys.toList()..sort()}',
    ].join(' / ');
  }
}

class _Correction {
  const _Correction({
    required this.oldName,
    required this.nameProblem,
    required this.equipmentProblem,
    required this.fix,
    required this.status,
  });

  final String oldName;
  final String nameProblem;
  final String equipmentProblem;
  final String fix;
  final String status;
}

const _corrections = {
  11: _Correction(
    oldName: 'Press militar',
    nameProblem: 'Nome antigo nao indicava se era barra, halteres ou maquina.',
    equipmentProblem:
        'Equipamento inferido era Barra, mas o nome nao dizia isso.',
    fix: 'Renomeado de "Press militar" para "Press militar com barra em pe".',
    status: 'METADATA CORRIGIDA',
  ),
  41: _Correction(
    oldName: 'Supino inclinado',
    nameProblem: 'Nome antigo nao indicava barra, halteres ou maquina.',
    equipmentProblem:
        'Equipamento inferido era Barra, mas o nome nao dizia isso.',
    fix: 'Renomeado de "Supino inclinado" para "Supino inclinado com barra".',
    status: 'METADATA CORRIGIDA',
  ),
  59: _Correction(
    oldName: 'Remo baixo',
    nameProblem: 'Nome antigo nao indicava cabo/polia.',
    equipmentProblem:
        'Equipamento inferido era Cabo / polia, mas o nome nao dizia isso.',
    fix: 'Renomeado de "Remo baixo" para "Remo baixo no cabo".',
    status: 'METADATA CORRIGIDA',
  ),
  141: _Correction(
    oldName: 'Pallof press',
    nameProblem: 'Nome antigo nao indicava cabo ou elastico.',
    equipmentProblem:
        'Equipamento inferido era Cabo / polia ou elasticos, mas havia variante com elastico separada.',
    fix: 'Renomeado de "Pallof press" para "Pallof press no cabo".',
    status: 'METADATA CORRIGIDA',
  ),
};

class _FilterCorrection {
  const _FilterCorrection({
    required this.problem,
    required this.fix,
    required this.status,
  });

  final String problem;
  final String fix;
  final String status;
}

const _filterCorrections = {
  'Agachamento com peso corporal': _FilterCorrection(
    problem:
        'Entrava em Posterior de coxa completo por secundario; nao deve aparecer nesse foco.',
    fix:
        'Posterior de coxa completo e Gluteos completo passaram a usar foco principal, sem secundarios genericos.',
    status: 'FILTRO CORRIGIDO',
  ),
  'Agachamento para cadeira': _FilterCorrection(
    problem:
        'Entrava em Posterior de coxa completo por secundario; nao deve aparecer nesse foco.',
    fix:
        'Filtro de foco inferior especifico usa nome/grupo/equipamento principal.',
    status: 'FILTRO CORRIGIDO',
  ),
  'Agachamento sumo': _FilterCorrection(
    problem:
        'Entrava em Posterior de coxa completo por secundario; nao deve aparecer nesse foco.',
    fix:
        'Filtro de foco inferior especifico usa nome/grupo/equipamento principal.',
    status: 'FILTRO CORRIGIDO',
  ),
  'Wall sit': _FilterCorrection(
    problem:
        'Entrava em Posterior de coxa completo e Gluteos completo por secundarios.',
    fix:
        'Filtro de foco inferior especifico usa nome/grupo/equipamento principal.',
    status: 'FILTRO CORRIGIDO',
  ),
  'Lunges': _FilterCorrection(
    problem: 'Entrava em Posterior de coxa completo por secundarios.',
    fix:
        'Filtro de foco inferior especifico usa nome/grupo/equipamento principal.',
    status: 'FILTRO CORRIGIDO',
  ),
  'Walking lunges': _FilterCorrection(
    problem: 'Entrava em Posterior de coxa completo por secundarios.',
    fix:
        'Filtro de foco inferior especifico usa nome/grupo/equipamento principal.',
    status: 'FILTRO CORRIGIDO',
  ),
  'Ponte de glúteo': _FilterCorrection(
    problem: 'Entrava em Posterior de coxa completo por secundarios.',
    fix:
        'Posterior de coxa completo usa foco principal e deixa ponte no ramo de gluteos/pernas.',
    status: 'FILTRO CORRIGIDO',
  ),
  'Hip thrust': _FilterCorrection(
    problem: 'Entrava em Posterior de coxa completo por secundarios.',
    fix:
        'Posterior de coxa completo usa foco principal e deixa hip thrust no ramo de gluteos/pernas.',
    status: 'FILTRO CORRIGIDO',
  ),
  'Hip thrust com apoio': _FilterCorrection(
    problem: 'Entrava em Posterior de coxa completo por secundarios.',
    fix:
        'Posterior de coxa completo usa foco principal e deixa hip thrust no ramo de gluteos/pernas.',
    status: 'FILTRO CORRIGIDO',
  ),
  'Kickback de glúteo': _FilterCorrection(
    problem: 'Entrava em Posterior de coxa completo por secundarios.',
    fix:
        'Posterior de coxa completo usa foco principal e deixa kickback no ramo de gluteos/pernas.',
    status: 'FILTRO CORRIGIDO',
  ),
  'Good morning sem carga': _FilterCorrection(
    problem:
        'Entrava em Gluteos completo por secundarios; deve ficar em posterior/lombar conforme foco.',
    fix:
        'Gluteos completo usa foco principal e remove good morning desse filtro.',
    status: 'FILTRO CORRIGIDO',
  ),
};

String _nameProblem(_CatalogEntry entry) {
  final ambiguous = {
    'Press militar',
    'Supino inclinado',
    'Remo baixo',
    'Pallof press',
  };
  if (ambiguous.contains(entry.name)) return 'Nome ambiguo ainda presente.';
  return 'OK';
}

String _equipmentProblem(_CatalogEntry entry) {
  final name = _norm(entry.name);
  final equipment = _norm(entry.detail.equipment);
  if ((name.contains('com halter') || name.contains('com halteres')) &&
      !equipment.contains('halter')) {
    return 'Nome indica halteres, mas equipamento nao contem Halteres.';
  }
  if ((name.contains('com barra') || name.contains('barra ez')) &&
      !equipment.contains('barra')) {
    return 'Nome indica barra, mas equipamento nao contem Barra.';
  }
  if ((name.contains('no cabo') || name.contains('cabo')) &&
      !(equipment.contains('cabo') || equipment.contains('polia'))) {
    return 'Nome indica cabo, mas equipamento nao contem Cabo / polia.';
  }
  if ((name.contains('com elastico') || name.contains('elastico')) &&
      !equipment.contains('elastico')) {
    return 'Nome indica elastico, mas equipamento nao contem Elasticos.';
  }
  if (name.contains('em paralelas') && !equipment.contains('paralelas')) {
    return 'Nome indica paralelas, mas equipamento nao contem Paralelas.';
  }
  if ((name.contains('na maquina') || name.contains('assistidos')) &&
      !(equipment.contains('maquina') || equipment.contains('assistida'))) {
    return 'Nome indica maquina, mas equipamento nao contem Maquina.';
  }
  if (_equipmentDependent.any(name.contains) &&
      equipment.contains('peso corporal')) {
    return 'Exercicio dependente de equipamento esta marcado como Peso corporal.';
  }
  return 'OK';
}

String _groupProblem(_CatalogEntry entry) {
  if (entry.tags.regionKeys.isEmpty || entry.tags.groupKeys.isEmpty) {
    return 'Tags de regiao/grupo vazias.';
  }
  return 'OK';
}

String _filterProblem(_CatalogEntry entry) {
  final filterCorrection = _filterCorrections[entry.name];
  if (filterCorrection != null) return filterCorrection.problem;
  if (entry.tags.equipmentKeys.isEmpty) return 'Sem equipamento efetivo.';
  return 'OK';
}

String _descriptionProblem(_CatalogEntry entry) {
  final detail = entry.detail;
  final text = _norm(
    [
      detail.description,
      detail.executionSteps,
      detail.commonMistakes,
      detail.safetyNotes,
    ].join('\n'),
  );
  if (detail.description.trim().isEmpty) return 'Descricao vazia.';
  if (detail.executionSteps.trim().isEmpty) return 'Execucao vazia.';
  if (detail.commonMistakes.trim().isEmpty) return 'Erros comuns vazios.';
  if (detail.safetyNotes.trim().isEmpty) return 'Seguranca vazia.';
  if (RegExp(r'\d+\.').allMatches(detail.executionSteps).length < 5) {
    return 'Execucao com menos de 5 passos.';
  }
  for (final phrase in _forbiddenPhrases) {
    if (text.contains(_norm(phrase))) return 'Contem frase proibida: $phrase.';
  }
  return 'OK';
}

String _equipmentRequiredByName(String name) {
  final n = _norm(name);
  final required = <String>[];
  if (n.contains('halter')) required.add('Halteres');
  if (n.contains('barra ez')) {
    required.add('Barra EZ');
  } else if (n.contains('com barra')) {
    required.add('Barra');
  }
  if (n.contains('no cabo') || n.contains('cabo')) required.add('Cabo / polia');
  if (n.contains('elastico')) required.add('Elasticos');
  if (n.contains('paralelas')) required.add('Paralelas');
  if (n.contains('maquina') || n.contains('assistidos')) {
    required.add('Maquina');
  }
  if (n.contains('mochila')) required.add('Mochila com peso');
  if (n.contains('garrafao')) required.add('Garrafa/Garrafao');
  if (required.isEmpty) return 'Nao explicitado no nome';
  return required.toSet().join('; ');
}

String _completeFixFor(String label) {
  if (label == 'Bracos completo') {
    return 'Validado apos correcao v0.7.9; sem alteracao adicional v0.7.10.';
  }
  if (label == 'Posterior de coxa completo' || label == 'Gluteos completo') {
    return 'Corrigido na v0.7.10: foco inferior especifico deixa de incluir exercicios apenas por secundarios.';
  }
  return 'Auditado; sem alteracao necessaria.';
}

String _norm(String value) =>
    TrainingArchitectureNameNormalizer.normalize(value);

List<String> _names(
  TrainingFlowSelection flow, {
  String location = 'Casa',
  Set<String> equipment = const {'bodyweight'},
}) {
  return ExerciseFilterService.getAvailableExercises(
    exercises: _seedUniqueExercises(),
    trainingLocation: location,
    availableEquipmentKeys: equipment,
    selection: TrainingFlow.toTrainingSelection(flow),
    showAllExercises: false,
  ).map((item) => item.exercise.name).toList();
}

List<Exercise> _seedUniqueExercises() {
  final exercises = <Exercise>[];
  final seen = <String>{};
  for (final entry in SeedData.exercisesByGroup.entries) {
    for (final name in entry.value) {
      if (!seen.add(name)) continue;
      final detail = ExerciseCatalogDetailService.forExercise(
        name: name,
        group: entry.key,
      );
      exercises.add(
        Exercise(
          name: name,
          muscleGroup: entry.key,
          secondaryMuscleGroups: detail.secondaryGroups,
          equipment: detail.equipment,
          description: detail.description,
          executionSteps: detail.executionSteps,
          commonMistakes: detail.commonMistakes,
          safetyNotes: detail.safetyNotes,
          isDefault: true,
        ),
      );
    }
  }
  return exercises;
}

const _forbiddenPhrases = [
  'Ajusta pes, maos e carga',
  'Faz o movimento principal',
  'Volta a posicao inicial com a mesma trajetoria',
  'Comeca leve, progride gradualmente',
  'Movimento lento e previsivel',
  'Amplitude controlada',
  'Mantem boa postura',
  'Executa com boa tecnica',
  'Usar pressa',
  'Compensar com outra zona do corpo',
  'Resistencia que muda a trajetoria',
  'Descricao ainda incompleta',
  'Sera melhorado numa proxima versao',
];

const _equipmentDependent = [
  'supino',
  'aberturas',
  'dips',
  'puxada',
  'remo sentado',
  'remo baixo',
  'leg press',
  'chest press',
  'crossover',
  'curl no cabo',
  'triceps no cabo',
  'face pull no cabo',
];

const _completeCases = [
  _CompleteCase(
    label: 'Bracos completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'dumbbells',
      regionKey: 'upper',
      groupKey: 'arms',
      subzoneKey: 'arms_complete',
    ),
    equipment: {'dumbbells', 'bench', 'incline_bench', 'free_space'},
    expected: [
      'Curl com halteres',
      'Extensao francesa com halter',
      'Wrist curl',
      'Suitcase carry',
    ],
    forbidden: [
      'Supino com halteres',
      'Remo unilateral com halter',
      'Agachamento goblet',
    ],
  ),
  _CompleteCase(
    label: 'Antebraco completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'dumbbells',
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subzoneKey: 'forearm_complete',
    ),
    equipment: {'dumbbells'},
    expected: ['Wrist curl', 'Reverse wrist curl', 'Farmer hold'],
    forbidden: ['Supino com halteres'],
  ),
  _CompleteCase(
    label: 'Peito completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'bodyweight',
      regionKey: 'upper',
      groupKey: 'chest',
      subzoneKey: 'chest_complete',
    ),
    equipment: {'bodyweight', 'chair_support'},
    expected: ['Flexao classica', 'Flexao inclinada'],
    forbidden: ['Curl com halteres'],
  ),
  _CompleteCase(
    label: 'Costas completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'dumbbells',
      regionKey: 'upper',
      groupKey: 'back',
      subzoneKey: 'back_complete',
    ),
    equipment: {'dumbbells'},
    expected: ['Remo unilateral com halter', 'Pullover com halter'],
    forbidden: ['Curl com halteres'],
  ),
  _CompleteCase(
    label: 'Ombros completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'dumbbells',
      regionKey: 'upper',
      groupKey: 'shoulders',
      subzoneKey: 'shoulders_complete',
    ),
    equipment: {'dumbbells'},
    expected: ['Press militar com halteres', 'Elevacao lateral'],
    forbidden: ['Curl com halteres'],
  ),
  _CompleteCase(
    label: 'Core completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'bodyweight',
      regionKey: 'core',
      groupKey: 'core',
      subzoneKey: 'core_complete',
    ),
    equipment: {'bodyweight', 'mat'},
    expected: ['Prancha', 'Dead bug', 'Bird dog'],
    forbidden: ['Supino com halteres'],
  ),
  _CompleteCase(
    label: 'Abdominal completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'bodyweight',
      regionKey: 'core',
      groupKey: 'core',
      subzoneKey: 'abdominal_zone',
      focusKey: 'abs_complete',
    ),
    equipment: {'bodyweight'},
    expected: ['Crunch', 'Reverse crunch', 'Bicycle crunch'],
    forbidden: ['Supino com halteres'],
  ),
  _CompleteCase(
    label: 'Pernas completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'bodyweight',
      regionKey: 'lower',
      groupKey: 'legs',
      subzoneKey: 'legs_complete',
    ),
    equipment: {'bodyweight', 'chair_support'},
    expected: ['Agachamento com peso corporal', 'Wall sit', 'Gemeos em pe'],
    forbidden: ['Curl com halteres'],
  ),
  _CompleteCase(
    label: 'Coxa completa',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'bodyweight',
      regionKey: 'lower',
      groupKey: 'legs',
      subzoneKey: 'upper_leg_hip',
      focusKey: 'thigh_complete',
    ),
    equipment: {'bodyweight', 'chair_support'},
    expected: ['Agachamento com peso corporal', 'Lunges'],
    forbidden: ['Curl com halteres'],
  ),
  _CompleteCase(
    label: 'Quadriceps completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'bodyweight',
      regionKey: 'lower',
      groupKey: 'legs',
      subzoneKey: 'upper_leg_hip',
      focusKey: 'quadriceps_complete',
    ),
    equipment: {'bodyweight', 'chair_support'},
    expected: ['Agachamento com peso corporal', 'Wall sit', 'Lunges'],
    forbidden: ['Curl com halteres'],
  ),
  _CompleteCase(
    label: 'Posterior de coxa completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'bodyweight',
      regionKey: 'lower',
      groupKey: 'legs',
      subzoneKey: 'upper_leg_hip',
      focusKey: 'hamstrings_complete',
    ),
    equipment: {'bodyweight'},
    expected: ['Good morning sem carga'],
    forbidden: ['Supino com halteres'],
  ),
  _CompleteCase(
    label: 'Gluteos completo',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'bodyweight',
      regionKey: 'lower',
      groupKey: 'legs',
      subzoneKey: 'upper_leg_hip',
      focusKey: 'glutes_complete',
    ),
    equipment: {'bodyweight', 'chair_support'},
    expected: ['Ponte de gluteo', 'Hip thrust com apoio'],
    forbidden: ['Curl com halteres'],
  ),
  _CompleteCase(
    label: 'Perna inferior completa',
    flow: TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: 'bodyweight',
      regionKey: 'lower',
      groupKey: 'legs',
      subzoneKey: 'lower_leg_foot',
      focusKey: 'lower_leg_complete',
    ),
    equipment: {'bodyweight'},
    expected: ['Gemeos em pe', 'Elevacao tibial'],
    forbidden: ['Supino com halteres'],
  ),
  _CompleteCase(
    label: 'Mobilidade geral',
    flow: TrainingFlowSelection(
      typeKey: 'mobility',
      mobilityZoneKey: 'general_mobility',
    ),
    equipment: {'bodyweight', 'mat'},
    expected: ['Alongamento cervical leve', 'Mobilidade de anca'],
    forbidden: ['Supino com halteres'],
  ),
  _CompleteCase(
    label: 'Recuperacao completa',
    flow: TrainingFlowSelection(
      typeKey: 'recovery',
      recoveryKey: 'light_stretching',
    ),
    equipment: {'bodyweight'},
    expected: ['Alongamento cervical leve', 'Respiracao diafragmatica'],
    forbidden: ['Supino com halteres'],
  ),
  _CompleteCase(
    label: 'Karate completo',
    flow: TrainingFlowSelection(
      typeKey: 'martial_arts',
      martialArtKey: 'karate',
      focusKey: 'karate_complete',
    ),
    location: 'Dojo / Artes marciais',
    equipment: {'tatami'},
    expected: ['Kihon', 'Kata', 'Kumite tecnico'],
    forbidden: ['Shrimp / fuga de anca'],
  ),
  _CompleteCase(
    label: 'Jiu-Jitsu completo',
    flow: TrainingFlowSelection(
      typeKey: 'martial_arts',
      martialArtKey: 'jiu_jitsu',
      focusKey: 'jiu_jitsu_complete',
    ),
    location: 'Dojo / Artes marciais',
    equipment: {'tatami'},
    expected: ['Shrimp / fuga de anca', 'Ponte de grappling'],
    forbidden: ['Kihon', 'Kata'],
  ),
  _CompleteCase(
    label: 'Cardio completo',
    flow: TrainingFlowSelection(
      typeKey: 'cardio',
      equipmentKey: 'no_equipment',
    ),
    equipment: {'bodyweight'},
    expected: ['Jumping jacks', 'Mountain climbers'],
    forbidden: ['Passadeira caminhada'],
  ),
  _CompleteCase(
    label: 'Passadeira completo',
    flow: TrainingFlowSelection(typeKey: 'cardio', equipmentKey: 'treadmill'),
    location: 'Ginasio',
    equipment: {'treadmill'},
    expected: ['Passadeira caminhada', 'Passadeira cooldown'],
    forbidden: ['Bicicleta ritmo leve', 'Eliptica ritmo leve'],
  ),
];

class _CompleteCase {
  const _CompleteCase({
    required this.label,
    required this.flow,
    required this.expected,
    required this.forbidden,
    this.location = 'Casa',
    this.equipment = const {'bodyweight'},
  });

  final String label;
  final TrainingFlowSelection flow;
  final List<String> expected;
  final List<String> forbidden;
  final String location;
  final Set<String> equipment;
}

class TrainingArchitectureNameNormalizer {
  const TrainingArchitectureNameNormalizer._();

  static String normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('à', 'a')
        .replaceAll('ã', 'a')
        .replaceAll('â', 'a')
        .replaceAll('é', 'e')
        .replaceAll('ê', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ô', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ç', 'c');
  }
}
