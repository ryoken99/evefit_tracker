import 'dart:io';

import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/training_flow.dart';

/// FASE 15: gera a ficha completa de cada exercício adicionado na expansão
/// v0.9.2 (nome, motivo, lacuna, área, grupo, músculos, equipamento, locais,
/// filtros, objetivo, execução e testes) para o relatório de expansão.
const Map<String, (String, String, String)> added = {
  // nome: (área, lacuna, motivo)
  'Isometria cervical posterior leve': (
    'Musculação',
    'PES-02 extensão cervical',
    'O catálogo tinha isometria frontal e lateral mas nenhum exercício para os extensores do pescoço.',
  ),
  'Elevação no plano da omoplata': (
    'Musculação',
    'OMB-04 supraespinhoso',
    'Único músculo da coifa dos rotadores sem exercício dedicado.',
  ),
  'Lenhador no cabo': (
    'Musculação',
    'COR-05 rotação com carga',
    'Não existia rotação do tronco em pé com carga no ginásio.',
  ),
  'Prancha com toque no ombro': (
    'Musculação',
    'COR-02 anti-rotação sem equipamento',
    'A anti-rotação dependia de cabo/elástico (pallof); faltava opção pura de peso corporal.',
  ),
  'Clamshell': (
    'Musculação',
    'GLU-03 rotadores externos da anca',
    'Zona pedida na checklist sem exercício de força; importante para joelho e anca saudáveis.',
  ),
  'Curl nórdico assistido': (
    'Musculação',
    'PER-04 flexão de joelho sem máquina',
    'Trabalho excêntrico de isquiotibiais sem máquina, com valor de prevenção de lesões.',
  ),
  'Peso morto unilateral com halteres': (
    'Musculação',
    'PER-05 dobradiça unilateral',
    'Não existia dobradiça de anca unilateral/equilíbrio no catálogo.',
  ),
  'Remo ergómetro ritmo contínuo': (
    'Cardio',
    'CAR-05 remo ergómetro',
    'A app já listava o equipamento `rower` sem nenhum exercício que o usasse.',
  ),
  'Remo ergómetro intervalos': (
    'Cardio',
    'CAR-05 remo ergómetro',
    'Variante intervalada do remo, pedida na especificação de cardio.',
  ),
  'Stepper / escadas ritmo contínuo': (
    'Cardio',
    'CAR-06 escadas/stepper',
    'Equipamento `stepper` existia sem exercícios.',
  ),
  'Stepper / escadas intervalos': (
    'Cardio',
    'CAR-06 escadas/stepper',
    'Variante intervalada do stepper.',
  ),
  'Subida de escadas no exterior': (
    'Cardio',
    'CAR-06 escadas (exterior)',
    'Versão sem máquina do trabalho de escadas, pedida na especificação.',
  ),
  'Air bike ritmo contínuo': (
    'Cardio',
    'CAR-07 air bike',
    'Equipamento `air_bike` existia sem exercícios.',
  ),
  'Air bike intervalos': (
    'Cardio',
    'CAR-07 air bike',
    'Variante intervalada da air bike.',
  ),
  'Shadow boxing leve': (
    'Cardio',
    'CAR-10 shadow boxing',
    'Pedido explícito da especificação: cardio de coordenação sem equipamento.',
  ),
  'Shuttle runs / corrida vaivém': (
    'Cardio',
    'CAR-11 shuttle runs',
    'Pedido explícito da especificação: mudança de direção e travagem.',
  ),
  'Treino de bases (dachi)': (
    'Artes marciais',
    'KAR-04 bases',
    'Checklist de Karate: posições base (zenkutsu, kiba, kokutsu).',
  ),
  'Bloqueios técnicos (uke)': (
    'Artes marciais',
    'KAR-09 bloqueios',
    'Checklist de Karate: age-uke, soto-uke e gedan-barai.',
  ),
  'Esquivas e tai-sabaki': (
    'Artes marciais',
    'KAR-10 esquivas',
    'Checklist de Karate: saída da linha de ataque.',
  ),
  'Joelhadas técnicas': (
    'Artes marciais',
    'KAR-11 joelhadas',
    'Checklist de Karate: hiza-geri.',
  ),
  'Trabalho leve ao saco': (
    'Artes marciais',
    'KAR-13 trabalho ao saco',
    'Drill ao saco marcado como tal: usa o equipamento `heavy_bag` já existente na app.',
  ),
  'Rolamentos de solo': (
    'Artes marciais',
    'JJ-05 rolamentos',
    'Checklist de Jiu-Jitsu: rolls para a frente e para trás.',
  ),
  'Breakfalls (ukemi)': (
    'Artes marciais',
    'JJ-06 breakfalls',
    'Checklist de Jiu-Jitsu: quedas amortecidas; marcado como exigindo tatami/colchão.',
  ),
  'Inversão granby com apoio': (
    'Artes marciais',
    'JJ-07 inversões',
    'Checklist de Jiu-Jitsu: inversões com regressão apoiada.',
  ),
  'Alongamento PNF de isquiotibiais': (
    'Elasticidade',
    'ELA-03 PNF',
    'Não existia nenhum alongamento contrai-relaxa no catálogo.',
  ),
  'Alongamento PNF de peitoral na parede': (
    'Elasticidade',
    'ELA-03 PNF',
    'PNF de membro superior, complementa o de isquiotibiais.',
  ),
  'Alongamento de flexores da anca em afundo': (
    'Mobilidade',
    'MOB-07 flexores da anca',
    'Zona muito treinada (agachamentos, corrida) sem alongamento dedicado.',
  ),
  'Alongamento borboleta de adutores': (
    'Mobilidade',
    'MOB-08 adutores',
    'Adutores treinados em força (sumo, Copenhagen) sem alongamento dedicado.',
  ),
  'Alongamento dinâmico global': (
    'Mobilidade',
    'MOB-13 global dinâmico',
    'Sequência de aquecimento completa (anca, coluna, isquiotibiais) em falta.',
  ),
  'Alongamento de tríceps atrás da cabeça': (
    'Elasticidade',
    'ELA-04 tríceps/ombro',
    'Tríceps com 20 exercícios de força e nenhum alongamento.',
  ),
  'Cobra suave no chão': (
    'Mobilidade',
    'MOB-05 extensão de coluna',
    'Toda a mobilidade de coluna era em flexão/rotação; faltava extensão suave.',
  ),
  'Respiração nasal lenta': (
    'Recuperação',
    'REC-02 respiração nasal',
    'Pedido explícito da especificação de recuperação.',
  ),
  'Foam roller para pernas': (
    'Recuperação',
    'REC-03 libertação miofascial',
    'Equipamento `foam_roller` existia na app sem exercícios.',
  ),
  'Foam roller para costas': (
    'Recuperação',
    'REC-04 libertação miofascial',
    'Zona dorsal com rolo, com exclusões de segurança (lombar e pescoço).',
  ),
  'Bola de massagem para pés e glúteos': (
    'Recuperação',
    'REC-05 libertação miofascial',
    'Equipamento `massage_ball` existia sem exercícios.',
  ),
  'Arrefecimento pós-treino de força': (
    'Recuperação',
    'REC-08 arrefecimento por modalidade',
    'Só existiam cooldowns de máquinas de cardio; faltava rotina pós-força.',
  ),
  'Arrefecimento pós-artes marciais': (
    'Recuperação',
    'REC-09 arrefecimento por modalidade',
    'Rotina de arrefecimento específica de artes marciais em falta.',
  ),
  'Aquecimento dinâmico geral': (
    'Aquecimento',
    'AQU-02 aquecimento geral',
    'Rotina guiada de aquecimento sem equipamento em falta.',
  ),
};

void main() {
  final entries = ExerciseCatalogContextService.entries;
  final exercises = entries.map((entry) => entry.toExercise()).toList();

  // Seleções da UI (mesma matriz da FASE 1) para listar filtros por exercício.
  final selections = <String, TrainingSelection>{};
  const strengthGroups = <String, (String, String)>{
    'chest': ('upper', 'chest'),
    'back': ('upper', 'back'),
    'shoulders': ('upper', 'shoulders'),
    'arms': ('upper', 'arms'),
    'forearm_hand': ('upper', 'forearm_hand'),
    'traps_scapula': ('upper', 'traps_scapula'),
    'neck': ('upper', 'neck'),
    'core': ('core', ''),
    'legs': ('lower', 'legs'),
  };
  for (final groupEntry in strengthGroups.entries) {
    for (final subzone in TrainingFlow.strengthSubzonesForGroup(
      groupEntry.key,
    )) {
      selections['Musculação > ${groupEntry.key} > ${subzone.key}'] =
          TrainingFlow.toTrainingSelection(
            TrainingFlowSelection(
              typeKey: 'strength',
              regionKey: groupEntry.value.$1,
              groupKey: groupEntry.value.$2,
              subzoneKey: subzone.key,
            ),
          );
      for (final focus in TrainingFlow.strengthSpecificOptions(
        groupEntry.key,
        subzone.key,
      )) {
        selections['Musculação > ${groupEntry.key} > ${subzone.key} > '
            '${focus.key}'] = TrainingFlow.toTrainingSelection(
          TrainingFlowSelection(
            typeKey: 'strength',
            regionKey: groupEntry.value.$1,
            groupKey: groupEntry.value.$2,
            subzoneKey: subzone.key,
            focusKey: focus.key,
          ),
        );
      }
    }
  }
  for (final mode in TrainingFlow.cardioLabels.keys) {
    selections['Cardio > $mode'] = TrainingFlow.toTrainingSelection(
      TrainingFlowSelection(typeKey: 'cardio', cardioFocusKey: mode),
    );
  }
  for (final art in const ['karate', 'jiu_jitsu']) {
    for (final focus in TrainingFlow.martialFocusOptions(art)) {
      selections['Artes marciais > $art > ${focus.key}'] =
          TrainingFlow.toTrainingSelection(
            TrainingFlowSelection(
              typeKey: 'martial_arts',
              martialArtKey: art,
              focusKey: focus.key,
            ),
          );
    }
  }
  for (final zone in TrainingFlow.mobilityLabels.keys) {
    selections['Mobilidade > $zone'] = TrainingFlow.toTrainingSelection(
      TrainingFlowSelection(typeKey: 'mobility', mobilityZoneKey: zone),
    );
  }
  for (final key in TrainingFlow.recoveryLabels.keys) {
    selections['Recuperação > $key'] = TrainingFlow.toTrainingSelection(
      TrainingFlowSelection(typeKey: 'recovery', recoveryKey: key),
    );
  }

  final allEquipmentKeys = EquipmentCatalogService.definitions.keys.toSet();
  final scenarios = <(String, Set<String>)>[
    ('Ginásio', const {}),
    ('Casa', allEquipmentKeys),
    ('Exterior / parque', const {}),
    ('Dojo / artes marciais', {'tatami', 'heavy_bag'}),
  ];
  final filtersByExercise = <String, Set<String>>{};
  for (final selection in selections.entries) {
    for (final scenario in scenarios) {
      for (final item in ExerciseFilterService.getAvailableExercises(
        exercises: exercises,
        trainingLocation: scenario.$1,
        availableEquipmentKeys: scenario.$2,
        selection: selection.value,
        showAllExercises: false,
      )) {
        filtersByExercise
            .putIfAbsent(
              '${item.exercise.name}__${item.exercise.muscleGroup}',
              () => {},
            )
            .add(selection.key);
      }
    }
  }
  final locationScenarios = <String, (String, Set<String>)>{
    'Casa sem equipamento': ('Casa', const {}),
    'Casa equipada': ('Casa', allEquipmentKeys),
    'Exterior / parque': ('Exterior / parque', const {}),
    'Dojo / tatami': ('Dojo / artes marciais', {'tatami', 'heavy_bag'}),
    'Ginásio': ('Ginásio', const {}),
  };
  final locationsByExercise = <String, List<String>>{};
  for (final scenario in locationScenarios.entries) {
    for (final item in ExerciseFilterService.getAvailableExercises(
      exercises: exercises,
      trainingLocation: scenario.value.$1,
      availableEquipmentKeys: scenario.value.$2,
      selection: const TrainingSelection(),
      showAllExercises: false,
    )) {
      locationsByExercise
          .putIfAbsent(
            '${item.exercise.name}__${item.exercise.muscleGroup}',
            () => [],
          )
          .add(scenario.key);
    }
  }

  final buffer = StringBuffer();
  for (final entry in entries) {
    final meta = added[entry.name];
    if (meta == null) continue;
    final key = '${entry.name}__${entry.group}';
    final tags = TrainingArchitecture.tagsForExercise(entry.toExercise());
    buffer
      ..writeln('### ${entry.id} — ${entry.name}')
      ..writeln()
      ..writeln('- **Motivo da adição**: ${meta.$3}')
      ..writeln(
        '- **Lacuna que resolve**: ${meta.$2} '
        '(ver `exercise_catalog_gap_analysis.md`)',
      )
      ..writeln('- **Área**: ${meta.$1}')
      ..writeln('- **Grupo muscular**: ${entry.group}')
      ..writeln(
        '- **Músculos principais (tags)**: '
        '${tags.muscleKeys.isEmpty ? '(zona de mobilidade/recuperação)' : tags.muscleKeys.join(', ')}',
      )
      ..writeln('- **Músculos secundários**: ${entry.details.secondaryGroups}')
      ..writeln('- **Equipamento**: ${entry.details.equipment}')
      ..writeln(
        '- **Locais**: '
        '${(locationsByExercise[key] ?? const []).join(' | ')}',
      )
      ..writeln(
        '- **Filtros onde aparece**: '
        '${(filtersByExercise[key] ?? const {}).join(' | ')}',
      )
      ..writeln('- **Objetivo**: ${entry.details.description}')
      ..writeln('- **Execução**:');
    for (final line in entry.details.executionSteps.split('\n')) {
      buffer.writeln('  - $line');
    }
    buffer
      ..writeln(
        '- **Testes que validam este exercício**: '
        '`test/v092_catalog_expansion_test.dart` (testes 01-28, incl. '
        'presença em filtros, locais e "mostrar todos"), '
        '`test/catalog/*` (quality gates de pedagogia, família de '
        'movimento, equipamento e segurança), '
        '`test/v091_content_review_test.dart` (modelo canónico), '
        '`test/v091_migration_test.dart` + testes 25-26 (seeds/migração).',
      )
      ..writeln();
  }
  File('tool/expansion_report_records.md').writeAsStringSync(buffer.toString());
  stdout.writeln(
    'wrote tool/expansion_report_records.md '
    '(${added.length} fichas)',
  );
}
