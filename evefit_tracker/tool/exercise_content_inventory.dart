import 'dart:io';

import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';

/// FASE 1/2 da revisão de conteúdo v0.9.1: inventário programático de todos
/// os exercícios do catálogo, com classificação por tipo e deteção de
/// problemas de texto. Gera docs/audits/exercise_content_inventory.md.
void main(List<String> args) {
  final entries = ExerciseCatalogContextService.entries;
  final buffer = StringBuffer()
    ..writeln('# Inventário de conteúdo dos exercícios (v0.9.1)')
    ..writeln()
    ..writeln('Gerado por `tool/exercise_content_inventory.dart`.')
    ..writeln()
    ..writeln(
      'Origem dos dados: os exercícios são definidos em '
      '`lib/database/seed_data.dart` (`SeedData.exercisesByGroup`), '
      'materializados por `lib/services/exercise_catalog_context_service.dart` '
      '(`ExerciseCatalogContextService._buildEntries`, textos em '
      '`_entrySpecificDetails`) com equipamento/músculos secundários base em '
      '`lib/services/exercise_catalog_detail_service.dart`. As tags '
      'anatómicas vêm de `lib/services/training_architecture.dart` '
      '(`tagsForExercise`).',
    )
    ..writeln();

  final byType = <String, int>{};
  final byGroup = <String, int>{};
  final byEquipment = <String, int>{};
  final noDescription = <String>[];
  final longDescription = <String>[];
  final forbidden = <String>[];
  final badStepFormat = <String>[];
  final tooManySteps = <String>[];
  final tooFewSteps = <String>[];
  final longSteps = <String>[];
  final repeated = <String>[];
  final needsManualReview = <String>[];
  final needsFullRewrite = <String>[];
  final seenDescriptions = <String, String>{};
  final seenSteps = <String, String>{};

  for (final entry in entries) {
    final type = classify(entry);
    byType[type] = (byType[type] ?? 0) + 1;
    byGroup[entry.group] = (byGroup[entry.group] ?? 0) + 1;
    byEquipment[entry.details.equipment] =
        (byEquipment[entry.details.equipment] ?? 0) + 1;

    final label = '${entry.id} ${entry.name} [${entry.group}]';
    final description = entry.details.description.trim();
    final steps = entry.details.executionSteps;
    final stepLines = splitSteps(steps);

    if (description.isEmpty) noDescription.add(label);
    if (description.length > 280) {
      longDescription.add('$label (${description.length} chars)');
    }
    final hits = forbiddenHits(entry);
    if (hits.isNotEmpty) forbidden.add('$label: ${hits.join('; ')}');
    if (!steps.contains('\n') && RegExp(r'\d+\.\s').hasMatch(steps)) {
      badStepFormat.add(label);
    }
    if (stepLines.length > 7) {
      tooManySteps.add('$label (${stepLines.length} passos)');
    }
    if (stepLines.length < 4) {
      tooFewSteps.add('$label (${stepLines.length} passos)');
    }
    for (final line in stepLines) {
      if (line.length > 180) {
        longSteps.add('$label: "${line.substring(0, 60)}…" (${line.length})');
      }
    }
    final descKey = description.toLowerCase();
    if (seenDescriptions.containsKey(descKey) &&
        seenDescriptions[descKey] != entry.name) {
      repeated.add('$label repete descrição de ${seenDescriptions[descKey]}');
    }
    seenDescriptions[descKey] = entry.name;
    final stepsKey = steps.toLowerCase();
    if (seenSteps.containsKey(stepsKey) && seenSteps[stepsKey] != entry.name) {
      repeated.add('$label repete execução de ${seenSteps[stepsKey]}');
    }
    seenSteps[stepsKey] = entry.name;
    if (type == 'outro') needsManualReview.add(label);
    if (hits.isNotEmpty ||
        description.length > 280 ||
        stepLines.length > 7 ||
        (!steps.contains('\n') && RegExp(r'\d+\.\s').hasMatch(steps))) {
      needsFullRewrite.add(label);
    }
  }

  buffer
    ..writeln('## Totais')
    ..writeln()
    ..writeln('- Total de exercícios encontrados: **${entries.length}**')
    ..writeln('- Nomes únicos: ${entries.map((e) => e.name).toSet().length}')
    ..writeln()
    ..writeln('### Por tipo (FASE 2)')
    ..writeln();
  for (final item
      in byType.entries.toList()..sort((a, b) => b.value.compareTo(a.value))) {
    buffer.writeln('- ${item.key}: ${item.value}');
  }
  buffer
    ..writeln()
    ..writeln('### Por grupo muscular')
    ..writeln();
  for (final item in byGroup.entries) {
    buffer.writeln('- ${item.key}: ${item.value}');
  }
  buffer
    ..writeln()
    ..writeln('### Por equipamento')
    ..writeln();
  for (final item
      in byEquipment.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value))) {
    buffer.writeln('- ${item.key}: ${item.value}');
  }

  void section(String title, List<String> items) {
    buffer
      ..writeln()
      ..writeln('### $title (${items.length})')
      ..writeln();
    if (items.isEmpty) {
      buffer.writeln('- (nenhum)');
    } else {
      for (final item in items) {
        buffer.writeln('- $item');
      }
    }
  }

  section('Exercícios sem descrição', noDescription);
  section('Descrições acima de 280 caracteres', longDescription);
  section('Linguagem proibida', forbidden);
  section('Execução mal formatada (parágrafo numerado colado)', badStepFormat);
  section('Execução com mais de 7 passos', tooManySteps);
  section('Execução com menos de 4 passos', tooFewSteps);
  section('Passos acima de 180 caracteres', longSteps);
  section('Textos repetidos entre exercícios', repeated);
  section('Marcados para revisão manual (tipo ambíguo)', needsManualReview);
  section('Precisam de revisão completa', needsFullRewrite);

  buffer
    ..writeln()
    ..writeln('## Lista completa de exercícios')
    ..writeln();
  for (final entry in entries) {
    final tags = TrainingArchitecture.tagsForExercise(entry.toExercise());
    final d = entry.details;
    buffer
      ..writeln('### ${entry.id} — ${entry.name}')
      ..writeln()
      ..writeln('- Chave estável: `${entry.catalogEntryKey}`')
      ..writeln('- Grupo principal: ${entry.group}')
      ..writeln('- Grupos secundários: ${d.secondaryGroups}')
      ..writeln('- Músculos principais (tags): ${tags.muscleKeys.join(', ')}')
      ..writeln('- Equipamento: ${d.equipment}')
      ..writeln('- Tipo (FASE 2): ${classify(entry)}')
      ..writeln(
        '- Origem: seed `SeedData.exercisesByGroup["${entry.group}"]` '
        '→ `ExerciseCatalogContextService._entrySpecificDetails`',
      )
      ..writeln(
        '- Objetivo/descrição (${d.description.length} chars): '
        '${d.description}',
      )
      ..writeln('- Execução (${splitSteps(d.executionSteps).length} passos):');
    for (final line in splitSteps(d.executionSteps)) {
      buffer.writeln('  - $line');
    }
    buffer
      ..writeln('- Erros comuns: ${d.commonMistakes.replaceAll('\n', ' | ')}')
      ..writeln('- Versão mais fácil: ${d.regression}')
      ..writeln('- Versão mais difícil: ${d.progression}')
      ..writeln('- Segurança: ${d.safetyNotes}')
      ..writeln();
  }

  final out = File('docs/audits/exercise_content_inventory.md')
    ..createSync(recursive: true);
  out.writeAsStringSync(buffer.toString());
  stdout.writeln(
    'wrote docs/audits/exercise_content_inventory.md '
    '(${entries.length} exercícios)',
  );
}

List<String> splitSteps(String steps) {
  if (steps.contains('\n')) {
    return steps
        .split('\n')
        .map(
          (line) => line.replaceFirst(RegExp(r'^\s*\d{1,2}\.\s*'), '').trim(),
        )
        .where((line) => line.isNotEmpty)
        .toList();
  }
  return steps
      .split(RegExp(r'\s*(?=\d{1,2}\.\s)'))
      .map((line) => line.replaceFirst(RegExp(r'^\s*\d{1,2}\.\s*'), '').trim())
      .where((line) => line.isNotEmpty)
      .toList();
}

String classify(ExerciseCatalogEntry entry) {
  final name = entry.name.toLowerCase();
  final equipment = entry.details.equipment.toLowerCase();
  if (entry.group == 'Cardio') return 'cardio';
  if (entry.group == 'Karate' || entry.group == 'Jiu-Jitsu') {
    return 'artes_marciais';
  }
  if (entry.group == 'Mobilidade') {
    return name.contains('alongamento') ? 'alongamento' : 'mobilidade';
  }
  if (name.contains('isometr') ||
      name.contains('prancha') ||
      name.contains('hold') ||
      name.contains('wall sit') ||
      name.contains('dead hang') ||
      name.contains('vacuum')) {
    return 'isometria';
  }
  if (equipment.contains('kettlebell')) return 'kettlebell';
  if (equipment.contains('elástico')) return 'elastico';
  if (equipment.contains('cabo') && !equipment.contains('vassoura') ||
      equipment.contains('polia')) {
    return 'cabo';
  }
  if (equipment.contains('máquina') || equipment.contains('maquina')) {
    return 'maquina';
  }
  if (equipment.contains('halter')) return 'halteres';
  if (equipment.contains('barra fixa') || equipment.contains('paralelas')) {
    return 'peso_corporal';
  }
  if (equipment.contains('barra')) return 'barra';
  if (equipment.contains('banco romano')) return 'maquina';
  if (equipment.contains('disco')) return 'halteres';
  if (equipment.contains('peso corporal') ||
      equipment.contains('mochila') ||
      equipment.contains('garrafão') ||
      equipment.contains('mesa') ||
      equipment.contains('tatami') ||
      equipment.contains('toalha') ||
      equipment.contains('espaço exterior') ||
      equipment.contains('cadeira') ||
      equipment.contains('apoio')) {
    return 'peso_corporal';
  }
  if (equipment.contains('passadeira') ||
      equipment.contains('bicicleta') ||
      equipment.contains('elíptica') ||
      equipment.contains('corda de saltar')) {
    return 'cardio';
  }
  if (equipment.contains('vassoura')) return 'mobilidade';
  return 'outro';
}

List<String> forbiddenHits(ExerciseCatalogEntry entry) {
  final text =
      '${entry.details.description} ${entry.details.executionSteps} '
              '${entry.details.commonMistakes} ${entry.details.safetyNotes} '
              '${entry.details.regression} ${entry.details.progression}'
          .toLowerCase();
  final equipment = entry.details.equipment.toLowerCase();
  final isBodyweight =
      classify(entry) == 'peso_corporal' &&
      !equipment.contains('mochila') &&
      !equipment.contains('garrafão');
  const global = [
    'segura peso corporal',
    'usa peso corporal',
    'afastar a carga',
    'desce a carga',
    'não deixar a carga cair',
    'a carga cair',
    'o peso deve permitir punhos',
    'como apoio e core',
    'em flexão diamante',
    'todo',
    'lorem',
    'n/a',
  ];
  final hits = <String>[
    for (final phrase in global)
      if (phrase == 'todo'
          ? RegExp(r'\btodo\b(?!s)').hasMatch(text) && text.contains('todo:')
          : text.contains(phrase))
        '"$phrase"',
  ];
  if (isBodyweight &&
      RegExp(r'\bcarga\b').hasMatch(text) &&
      !text.contains('sem carga') &&
      !text.contains('carga externa')) {
    hits.add('linguagem de carga em exercício de peso corporal');
  }
  if (!equipment.contains('halter') && text.contains('usa halteres')) {
    hits.add('"usa halteres" sem halteres no equipamento');
  }
  return hits;
}
