import 'dart:io';

import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/training_flow.dart';

import 'full_catalog_inventory.dart' show difficultyLevel, movementPattern;

/// Catálogo mestre do EveFit Tracker: para cada músculo/foco (musculação),
/// modo (cardio), zona (mobilidade/flexibilidade), foco técnico (artes
/// marciais) e tipo (recuperação), lista TODOS os exercícios possíveis em
/// cada condição de local + equipamento, ordenados do mais simples para o
/// mais complexo, com a ficha de execução completa de cada exercício.
///
/// Gera docs/catalog/*.md a partir dos mesmos serviços que a app usa nos
/// filtros — o documento é regenerável com
/// `dart run tool/master_catalog.dart`.
void main() {
  final entries = ExerciseCatalogContextService.entries;
  final exercises = entries.map((entry) => entry.toExercise()).toList();
  final entryByKey = {
    for (final entry in entries) '${entry.name}__${entry.group}': entry,
  };

  // ------------------------------------------------------------------
  // Cenários de local + equipamento avaliados em todo o catálogo.
  // ------------------------------------------------------------------
  final allEquipment = EquipmentCatalogService.definitions.keys.toSet();
  final scenarios = <(String, String, Set<String>)>[
    ('Casa s/ equip.', 'Casa', const {}),
    ('Casa c/ equip.', 'Casa', allEquipment),
    ('Ginásio', 'Ginásio', const {}),
    ('Exterior', 'Exterior / parque', const {}),
    ('Dojo', 'Dojo / artes marciais', {'tatami', 'heavy_bag'}),
  ];

  // Disponibilidade por local (sem seleção anatómica) por exercício.
  final availabilityByKey = <String, Set<String>>{};
  for (final scenario in scenarios) {
    for (final item in ExerciseFilterService.getAvailableExercises(
      exercises: exercises,
      trainingLocation: scenario.$2,
      availableEquipmentKeys: scenario.$3,
      selection: const TrainingSelection(),
      showAllExercises: false,
    )) {
      availabilityByKey
          .putIfAbsent(
            '${item.exercise.name}__${item.exercise.muscleGroup}',
            () => {},
          )
          .add(scenario.$1);
    }
  }

  // União dos exercícios que respondem a uma seleção, em qualquer cenário.
  List<ExerciseCatalogEntry> matching(TrainingSelection selection) {
    final seenNames = <String>{};
    final result = <ExerciseCatalogEntry>[];
    for (final scenario in scenarios) {
      for (final item in ExerciseFilterService.getAvailableExercises(
        exercises: exercises,
        trainingLocation: scenario.$2,
        availableEquipmentKeys: scenario.$3,
        selection: selection,
        showAllExercises: false,
      )) {
        final entry =
            entryByKey['${item.exercise.name}__${item.exercise.muscleGroup}'];
        if (entry == null) continue;
        if (!seenNames.add(entry.name)) continue;
        result.add(entry);
      }
    }
    result.sort(_complexityCompare);
    return result;
  }

  String availabilityCells(ExerciseCatalogEntry entry) {
    final available =
        availabilityByKey['${entry.name}__${entry.group}'] ?? const {};
    return scenarios
        .map((scenario) => available.contains(scenario.$1) ? '✅' : '—')
        .join(' | ');
  }

  String tableFor(List<ExerciseCatalogEntry> list) {
    if (list.isEmpty) return '_(sem exercícios para esta seleção)_\n';
    final buffer = StringBuffer()
      ..writeln(
        '| # | Exercício (ficha) | Nível | Equipamento | '
        '${scenarios.map((scenario) => scenario.$1).join(' | ')} |',
      )
      ..writeln('|---|---|---|---|${'---|' * scenarios.length}');
    var order = 1;
    for (final entry in list) {
      buffer.writeln(
        '| $order | ${entry.name} (${entry.id}) '
        '| ${difficultyLevel(entry)} '
        '| ${entry.details.equipment} '
        '| ${availabilityCells(entry)} |',
      );
      order++;
    }
    return buffer.toString();
  }

  void ficha(StringBuffer buffer, ExerciseCatalogEntry entry) {
    final d = entry.details;
    buffer
      ..writeln('### ${entry.id} — ${entry.name}')
      ..writeln()
      ..writeln(
        '- **Nível**: ${difficultyLevel(entry)} | '
        '**Padrão**: ${movementPattern(entry)} | '
        '**Grupo**: ${entry.group}',
      )
      ..writeln('- **Equipamento**: ${d.equipment}')
      ..writeln(
        '- **Onde**: '
        '${(availabilityByKey['${entry.name}__${entry.group}'] ?? const {}).join(', ')}',
      )
      ..writeln('- **Músculos secundários**: ${d.secondaryGroups}')
      ..writeln()
      ..writeln('**Objetivo**: ${d.description}')
      ..writeln()
      ..writeln('**Como executar:**')
      ..writeln();
    for (final line in d.executionSteps.split('\n')) {
      buffer.writeln(line);
    }
    buffer
      ..writeln()
      ..writeln('**Erros comuns:**')
      ..writeln();
    for (final line in d.commonMistakes.split('\n')) {
      buffer.writeln('- $line');
    }
    buffer
      ..writeln()
      ..writeln('- **Versão mais fácil**: ${d.regression}')
      ..writeln('- **Versão mais difícil**: ${d.progression}')
      ..writeln('- **Segurança**: ${d.safetyNotes}')
      ..writeln('- **Respiração**: ${d.breathingTips}')
      ..writeln();
  }

  void fichasSection(StringBuffer buffer, List<ExerciseCatalogEntry> list) {
    buffer
      ..writeln('## Fichas completas (do mais simples ao mais complexo)')
      ..writeln();
    final sorted = [...list]..sort(_complexityCompare);
    for (final entry in sorted) {
      ficha(buffer, entry);
    }
  }

  const header =
      'Gerado por `tool/master_catalog.dart` a partir dos mesmos serviços '
      'de filtragem da app (anatomia × local × equipamento). Colunas de '
      'local: ✅ = executável nessa condição ("Casa c/ equip." assume que o '
      'utilizador selecionou o equipamento indicado). Em cada lista, os '
      'exercícios estão ordenados **do mais simples para o mais complexo** '
      '(nível estimado e, dentro do mesmo nível, do equipamento mais '
      'acessível para o mais exigente). O número entre parênteses é a ficha '
      'com a execução detalhada, na secção "Fichas completas" do mesmo '
      'documento.';

  Directory('docs/catalog').createSync(recursive: true);

  // ==================================================================
  // 1. MUSCULAÇÃO — músculo a músculo × condições.
  // ==================================================================
  {
    final buffer = StringBuffer()
      ..writeln('# Catálogo mestre — Musculação (por músculo × condições)')
      ..writeln()
      ..writeln(header)
      ..writeln();
    const groups = <String, (String, String, String)>{
      'chest': ('upper', 'chest', 'Peito'),
      'back': ('upper', 'back', 'Costas'),
      'shoulders': ('upper', 'shoulders', 'Ombros'),
      'traps_scapula': ('upper', 'traps_scapula', 'Trapézio e escápula'),
      'neck': ('upper', 'neck', 'Pescoço'),
      'arms': ('upper', 'arms', 'Braços'),
      'forearm_hand': ('upper', 'forearm_hand', 'Antebraço, punho e mão'),
      'core': ('core', '', 'Core'),
      'legs': ('lower', 'legs', 'Pernas, glúteos e anca'),
    };
    final fichasNames = <String>{};
    final fichasEntries = <ExerciseCatalogEntry>[];
    for (final group in groups.entries) {
      buffer.writeln('# ${group.value.$3}');
      buffer.writeln();
      for (final subzone in TrainingFlow.strengthSubzonesForGroup(group.key)) {
        final focuses = TrainingFlow.strengthSpecificOptions(
          group.key,
          subzone.key,
        );
        final subzoneSelection = TrainingFlow.toTrainingSelection(
          TrainingFlowSelection(
            typeKey: 'strength',
            regionKey: group.value.$1,
            groupKey: group.value.$2,
            subzoneKey: subzone.key,
          ),
        );
        final subzoneMatches = matching(subzoneSelection);
        buffer
          ..writeln('## ${group.value.$3} › ${subzone.value}')
          ..writeln()
          ..writeln(tableFor(subzoneMatches));
        for (final entry in subzoneMatches) {
          if (fichasNames.add('${entry.name}__${entry.group}')) {
            fichasEntries.add(entry);
          }
        }
        for (final focus in focuses) {
          if (focus.key == subzone.key) continue;
          final focusMatches = matching(
            TrainingFlow.toTrainingSelection(
              TrainingFlowSelection(
                typeKey: 'strength',
                regionKey: group.value.$1,
                groupKey: group.value.$2,
                subzoneKey: subzone.key,
                focusKey: focus.key,
              ),
            ),
          );
          buffer
            ..writeln('### Músculo específico: ${focus.value}')
            ..writeln()
            ..writeln(tableFor(focusMatches));
          for (final entry in focusMatches) {
            if (fichasNames.add('${entry.name}__${entry.group}')) {
              fichasEntries.add(entry);
            }
          }
        }
      }
    }
    fichasSection(buffer, fichasEntries);
    File(
      'docs/catalog/catalogo_musculacao.md',
    ).writeAsStringSync(buffer.toString());
    stdout.writeln(
      'musculacao: ${fichasEntries.length} fichas, '
      '${buffer.length ~/ 1024} KiB',
    );
  }

  // ==================================================================
  // 2. CARDIO — modo a modo (com e sem equipamento).
  // ==================================================================
  {
    final buffer = StringBuffer()
      ..writeln('# Catálogo mestre — Cardio (por modo × condições)')
      ..writeln()
      ..writeln(header)
      ..writeln()
      ..writeln(
        'O nível de impacto (baixo/médio/alto) está indicado no objetivo de '
        'cada ficha.',
      )
      ..writeln();
    final fichas = <ExerciseCatalogEntry>[];
    final seen = <String>{};
    for (final mode in TrainingFlow.cardioLabels.entries) {
      final matches = matching(
        TrainingFlow.toTrainingSelection(
          TrainingFlowSelection(typeKey: 'cardio', cardioFocusKey: mode.key),
        ),
      ).where((entry) => entry.group == 'Cardio').toList();
      buffer
        ..writeln('## Cardio › ${mode.value}')
        ..writeln()
        ..writeln(tableFor(matches));
      for (final entry in matches) {
        if (seen.add('${entry.name}__${entry.group}')) fichas.add(entry);
      }
    }
    // Garante que nenhum exercício de cardio fica fora das fichas.
    for (final entry in entries.where((entry) => entry.group == 'Cardio')) {
      if (seen.add('${entry.name}__${entry.group}')) fichas.add(entry);
    }
    fichasSection(buffer, fichas);
    File(
      'docs/catalog/catalogo_cardio.md',
    ).writeAsStringSync(buffer.toString());
    stdout.writeln('cardio: ${fichas.length} fichas');
  }

  // ==================================================================
  // 3. MOBILIDADE / FLEXIBILIDADE — zona a zona.
  // ==================================================================
  const recoveryNames = {
    'Respiração diafragmática',
    'Respiração nasal lenta',
    'Caminhada leve',
    'Relaxamento deitado',
    'Foam roller para pernas',
    'Foam roller para costas',
    'Bola de massagem para pés e glúteos',
    'Arrefecimento pós-treino de força',
    'Arrefecimento pós-artes marciais',
  };
  {
    final buffer = StringBuffer()
      ..writeln(
        '# Catálogo mestre — Mobilidade e flexibilidade (por zona × condições)',
      )
      ..writeln()
      ..writeln(header)
      ..writeln()
      ..writeln(
        'Tipo de trabalho por ficha: mobilidade dinâmica, alongamento '
        'estático ou alongamento PNF (contrai-relaxa) — indicado no campo '
        '"Padrão" e no nome.',
      )
      ..writeln();
    final fichas = <ExerciseCatalogEntry>[];
    final seen = <String>{};
    for (final zone in TrainingFlow.mobilityLabels.entries) {
      final matches = matching(
        TrainingFlow.toTrainingSelection(
          TrainingFlowSelection(typeKey: 'mobility', mobilityZoneKey: zone.key),
        ),
      ).where((entry) => !recoveryNames.contains(entry.name)).toList();
      buffer
        ..writeln('## Mobilidade › ${zone.value}')
        ..writeln()
        ..writeln(tableFor(matches));
      for (final entry in matches) {
        if (entry.group != 'Mobilidade') continue;
        if (seen.add('${entry.name}__${entry.group}')) fichas.add(entry);
      }
    }
    for (final entry in entries.where(
      (entry) =>
          entry.group == 'Mobilidade' && !recoveryNames.contains(entry.name),
    )) {
      if (seen.add('${entry.name}__${entry.group}')) fichas.add(entry);
    }
    fichasSection(buffer, fichas);
    File(
      'docs/catalog/catalogo_mobilidade_flexibilidade.md',
    ).writeAsStringSync(buffer.toString());
    stdout.writeln('mobilidade: ${fichas.length} fichas');
  }

  // ==================================================================
  // 4. ARTES MARCIAIS — arte › foco técnico.
  // ==================================================================
  {
    final buffer = StringBuffer()
      ..writeln(
        '# Catálogo mestre — Artes marciais (por foco técnico × condições)',
      )
      ..writeln()
      ..writeln(header)
      ..writeln()
      ..writeln(
        'Drills que exigem material próprio (saco de pancada, tatami ou '
        'tapete) estão marcados no equipamento e nas colunas de local.',
      )
      ..writeln();
    final fichas = <ExerciseCatalogEntry>[];
    final seen = <String>{};
    const arts = {'karate': 'Karate', 'jiu_jitsu': 'Jiu-Jitsu'};
    for (final art in arts.entries) {
      buffer
        ..writeln('# ${art.value}')
        ..writeln();
      for (final focus in TrainingFlow.martialFocusOptions(art.key)) {
        final matches = matching(
          TrainingFlow.toTrainingSelection(
            TrainingFlowSelection(
              typeKey: 'martial_arts',
              martialArtKey: art.key,
              focusKey: focus.key,
            ),
          ),
        );
        buffer
          ..writeln('## ${art.value} › ${focus.value}')
          ..writeln()
          ..writeln(tableFor(matches));
        for (final entry in matches) {
          if (entry.group != 'Karate' && entry.group != 'Jiu-Jitsu') continue;
          if (seen.add('${entry.name}__${entry.group}')) fichas.add(entry);
        }
      }
    }
    for (final entry in entries.where(
      (entry) => entry.group == 'Karate' || entry.group == 'Jiu-Jitsu',
    )) {
      if (seen.add('${entry.name}__${entry.group}')) fichas.add(entry);
    }
    fichasSection(buffer, fichas);
    File(
      'docs/catalog/catalogo_artes_marciais.md',
    ).writeAsStringSync(buffer.toString());
    stdout.writeln('artes marciais: ${fichas.length} fichas');
  }

  // ==================================================================
  // 5. RECUPERAÇÃO — tipo a tipo.
  // ==================================================================
  {
    final buffer = StringBuffer()
      ..writeln('# Catálogo mestre — Recuperação (por tipo × condições)')
      ..writeln()
      ..writeln(header)
      ..writeln();
    final fichas = <ExerciseCatalogEntry>[];
    final seen = <String>{};
    for (final type in TrainingFlow.recoveryLabels.entries) {
      final matches = matching(
        TrainingFlow.toTrainingSelection(
          TrainingFlowSelection(typeKey: 'recovery', recoveryKey: type.key),
        ),
      );
      buffer
        ..writeln('## Recuperação › ${type.value}')
        ..writeln()
        ..writeln(tableFor(matches));
      for (final entry in matches) {
        if (!recoveryNames.contains(entry.name)) continue;
        if (seen.add('${entry.name}__${entry.group}')) fichas.add(entry);
      }
    }
    for (final entry in entries.where(
      (entry) => recoveryNames.contains(entry.name),
    )) {
      if (seen.add('${entry.name}__${entry.group}')) fichas.add(entry);
    }
    fichasSection(buffer, fichas);
    File(
      'docs/catalog/catalogo_recuperacao.md',
    ).writeAsStringSync(buffer.toString());
    stdout.writeln('recuperacao: ${fichas.length} fichas');
  }

  // Índice.
  File('docs/catalog/README.md').writeAsStringSync('''
# Catálogo mestre de exercícios (EveFit Tracker v0.9.2)

Catálogo completo do que a app consegue oferecer, organizado por objetivo e
condições reais de treino (local × equipamento), do mais simples para o mais
complexo. Regenerável com `dart run tool/master_catalog.dart`.

| Documento | Conteúdo |
|---|---|
| [catalogo_musculacao.md](catalogo_musculacao.md) | Músculo a músculo (todas as subzonas e músculos específicos da app): todos os exercícios possíveis por condição, com fichas de execução |
| [catalogo_cardio.md](catalogo_cardio.md) | Todos os modos de cardio, com e sem equipamento, com impacto e fichas |
| [catalogo_mobilidade_flexibilidade.md](catalogo_mobilidade_flexibilidade.md) | Zona a zona: mobilidade dinâmica, alongamentos estáticos e PNF |
| [catalogo_artes_marciais.md](catalogo_artes_marciais.md) | Karate e Jiu-Jitsu por foco técnico, com material marcado |
| [catalogo_recuperacao.md](catalogo_recuperacao.md) | Respiração, libertação miofascial, arrefecimentos e recuperação ativa |

Condições avaliadas em todas as listas: **Casa sem equipamento**, **Casa com
o equipamento indicado**, **Ginásio**, **Exterior/parque** e **Dojo**
(tatami + saco). Ordenação: nível (iniciante → intermédio → avançado) e,
dentro do nível, equipamento do mais acessível ao mais exigente.
''');
  stdout.writeln('wrote docs/catalog/*.md');
}

/// Ordena do mais simples para o mais complexo: primeiro pelo nível
/// estimado, depois pelo equipamento (apoio/peso corporal → máquina →
/// elástico → cabo → halteres → barra → misto), depois pelo nome.
int _complexityCompare(ExerciseCatalogEntry a, ExerciseCatalogEntry b) {
  final levelDelta = _levelRank(a).compareTo(_levelRank(b));
  if (levelDelta != 0) return levelDelta;
  final equipDelta = _equipmentRank(a).compareTo(_equipmentRank(b));
  if (equipDelta != 0) return equipDelta;
  return a.name.compareTo(b.name);
}

int _levelRank(ExerciseCatalogEntry entry) => switch (difficultyLevel(entry)) {
  'iniciante' => 0,
  'intermédio' => 1,
  _ => 2,
};

int _equipmentRank(ExerciseCatalogEntry entry) {
  final equipment = entry.details.equipment.toLowerCase();
  if (equipment.contains('apoio') ||
      equipment.contains('cadeira') ||
      equipment.contains('parede')) {
    return 0;
  }
  if (equipment.startsWith('peso corporal') ||
      equipment.contains('tatami') ||
      equipment.contains('tapete')) {
    return 1;
  }
  if (equipment.contains('máquina') ||
      equipment.contains('passadeira') ||
      equipment.contains('bicicleta') ||
      equipment.contains('elíptica') ||
      equipment.contains('remo ergómetro') ||
      equipment.contains('stepper') ||
      equipment.contains('air bike')) {
    return 2;
  }
  if (equipment.contains('elástico')) return 3;
  if (equipment.contains('cabo') || equipment.contains('polia')) return 4;
  if (equipment.contains('halter') ||
      equipment.contains('disco') ||
      equipment.contains('mochila') ||
      equipment.contains('garrafão')) {
    return 5;
  }
  if (equipment.contains('barra')) return 6;
  return 7;
}
