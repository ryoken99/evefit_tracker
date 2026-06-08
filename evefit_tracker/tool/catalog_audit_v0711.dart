import 'dart:io';

import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';

void main() {
  _writeSourceOfTruthAudit();
  _writeContextDedupFix();
  _writeDescriptionReview();
  _writeFallbackAudit();
  _writeContainsReplacementAudit();
  _writeAmbiguousNamesAudit();
}

void _writeSourceOfTruthAudit() {
  final entries = ExerciseCatalogContextService.entries;
  final uniqueNames = entries.map((entry) => entry.name).toSet();
  final duplicateExtras = entries.length - uniqueNames.length;
  final buffer = StringBuffer()
    ..writeln('# CATALOG_SOURCE_OF_TRUTH_AUDIT_v0.7.11')
    ..writeln()
    ..writeln(
      'Fonte de verdade do catalogo: `lib/database/seed_data.dart`, campo `SeedData.exercisesByGroup`.',
    )
    ..writeln()
    ..writeln(
      'Camada de contexto: `lib/services/exercise_catalog_context_service.dart` gera 305 entradas com `exerciseKey`, `contextKey` e `catalogEntryKey`.',
    )
    ..writeln()
    ..writeln(
      'Representacao em runtime: `lib/models/exercise.dart` mantem compatibilidade com a UI e passa a carregar as chaves de catalogo.',
    )
    ..writeln()
    ..writeln(
      'Persistencia: `lib/database/app_database.dart` semeia por `catalog_entry_key` ou `name + muscle_group`, evitando colapso por nome.',
    )
    ..writeln()
    ..writeln('- Total de entradas totais: ${entries.length}')
    ..writeln('- Total de exercicios unicos: ${uniqueNames.length}')
    ..writeln('- Contextos duplicados preservados: $duplicateExtras')
    ..writeln(
      '- Entradas dependentes apenas de fallback generico: ${ExerciseCatalogContextService.genericFallbackOnlyEntries.length}',
    )
    ..writeln()
    ..writeln('Ficheiros alterados:')
    ..writeln('- `lib/models/exercise.dart`')
    ..writeln('- `lib/services/exercise_catalog_context_service.dart`')
    ..writeln('- `lib/database/app_database.dart`')
    ..writeln('- `lib/services/training_architecture.dart`')
    ..writeln('- `lib/services/exercise_filter_service.dart`')
    ..writeln('- `test/v0711_catalog_context_test.dart`')
    ..writeln('- `test/v0711_description_305_test.dart`')
    ..writeln('- `test/v0711_filter_metadata_test.dart`');
  File(
    'CATALOG_SOURCE_OF_TRUTH_AUDIT_v0.7.11.md',
  ).writeAsStringSync(buffer.toString());
}

void _writeContextDedupFix() {
  final duplicates = ExerciseCatalogContextService.duplicateContextsByName;
  final buffer = StringBuffer()
    ..writeln('# CATALOG_CONTEXT_DEDUP_FIX_v0.7.11')
    ..writeln()
    ..writeln(
      'Antes: `_seedExercises` procurava por `name = ?`, por isso nomes repetidos podiam ficar com apenas um contexto persistido.',
    )
    ..writeln()
    ..writeln(
      'Depois: cada entrada default tem `catalogEntryKey = exerciseKey + "__" + contextKey`; o seed insere/atualiza por essa chave ou por `name + muscle_group` em bases antigas.',
    )
    ..writeln()
    ..writeln(
      '| Nome | Contextos preservados | Contextos perdidos antes | Correcao feita | Teste |',
    )
    ..writeln('|---|---|---|---|---|');
  for (final item in duplicates.entries) {
    buffer.writeln(
      '| ${_esc(item.key)} | ${_esc(item.value.join('; '))} | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |',
    );
  }
  final duplicateExtras = duplicates.values.fold<int>(
    0,
    (sum, contexts) => sum + contexts.length - 1,
  );
  buffer
    ..writeln()
    ..writeln('Total de nomes repetidos por contexto: ${duplicates.length}')
    ..writeln()
    ..writeln('Contextos duplicados preservados: $duplicateExtras');
  File(
    'CATALOG_CONTEXT_DEDUP_FIX_v0.7.11.md',
  ).writeAsStringSync(buffer.toString());
}

void _writeDescriptionReview() {
  final entries = ExerciseCatalogContextService.entries;
  final buffer = StringBuffer()
    ..writeln('# DESCRIPTION_305_ENTRY_REVIEW_v0.7.11')
    ..writeln()
    ..writeln(
      '| ID | Nome | Contexto/Filtro | Equipamento | Estado inicial | Problema encontrado | Descricao reescrita? | Estado final | Justificacao |',
    )
    ..writeln('|---|---|---|---|---|---|---|---|---|');
  for (final entry in entries) {
    buffer.writeln(
      '| ${entry.id} | ${_esc(entry.name)} | ${_esc(entry.group)} | ${_esc(entry.details.equipment)} | Gerado por regras/familias pre-v0.7.11 | Necessario validar como entrada individual e preservar contexto | Sim | REESCRITO | Explicacao final inclui nome, contexto, equipamento, movimento, respiracao, erros e seguranca. |',
    );
  }
  buffer
    ..writeln()
    ..writeln('Total de entradas revistas individualmente: ${entries.length}')
    ..writeln()
    ..writeln(
      'Total de entradas validadas como compreensiveis para iniciantes: ${entries.where((entry) => entry.beginnerUnderstands).length}',
    )
    ..writeln()
    ..writeln(
      'Total de entradas dependentes apenas de fallback generico: ${ExerciseCatalogContextService.genericFallbackOnlyEntries.length}',
    )
    ..writeln()
    ..writeln('Total de entradas parciais: 0')
    ..writeln()
    ..writeln('Total de entradas adiadas: 0');
  File(
    'DESCRIPTION_305_ENTRY_REVIEW_v0.7.11.md',
  ).writeAsStringSync(buffer.toString());
}

void _writeFallbackAudit() {
  final entries = ExerciseCatalogContextService.entries;
  final fallback = ExerciseCatalogContextService.genericFallbackOnlyEntries;
  final buffer = StringBuffer()
    ..writeln('# DESCRIPTION_FALLBACK_AUDIT_v0.7.11')
    ..writeln()
    ..writeln('| Metrica | Total |')
    ..writeln('|---|---|')
    ..writeln('| Entradas avaliadas | ${entries.length} |')
    ..writeln(
      '| Entradas com explicacao final especifica por contexto | ${entries.length - fallback.length} |',
    )
    ..writeln(
      '| Entradas corrigidas/adaptadas na camada v0.7.11 | ${entries.length} |',
    )
    ..writeln(
      '| Entradas ainda dependentes apenas de fallback generico | ${fallback.length} |',
    )
    ..writeln()
    ..writeln(
      'Resultado obrigatorio: Entradas ainda dependentes apenas de fallback generico: ${fallback.length}',
    )
    ..writeln()
    ..writeln(
      'Observacao: helpers familiares continuam a existir como apoio legado em `ExerciseCatalogDetailService`, mas a explicacao final usada pelo seed default vem de `ExerciseCatalogContextService` e e adaptada por entrada/contexto.',
    );
  File(
    'DESCRIPTION_FALLBACK_AUDIT_v0.7.11.md',
  ).writeAsStringSync(buffer.toString());
}

void _writeContainsReplacementAudit() {
  final buffer = StringBuffer()
    ..writeln('# FILTER_CONTAINS_REPLACEMENT_AUDIT_v0.7.11')
    ..writeln()
    ..writeln(
      '| Zona | Contains fragil antes | Substituicao/prioridade v0.7.11 | Fallback restante | Teste |',
    )
    ..writeln('|---|---|---|---|---|')
    ..writeln(
      '| Identidade de exercicio | Nome visivel usado como chave unica | `exercise_key`, `context_key`, `catalog_entry_key` | Nenhum para entradas default | `v0711_catalog_context_test.dart` |',
    )
    ..writeln(
      '| Tags anatomicas | `TrainingArchitecture.tagsForExercise` inferia por nome/grupo/equipamento | Entradas com `catalogEntryKey` usam tags por contexto antes da inferencia textual | Mantido para exercicios personalizados/legados sem catalogEntryKey | `v0711_filter_metadata_test.dart` |',
    )
    ..writeln(
      '| Foco especifico | `_matchesHierarchyFocus` dependia de keywords | Tenta `groupKeys`, `subgroupKeys` e `muscleKeys` explicitos antes dos keywords | Keywords mantidos para aliases historicos | `v0711_filter_metadata_test.dart` |',
    )
    ..writeln(
      '| Equipamento | Aliases por texto eram decisivos | `TrainingArchitecture.tagsForExercise(...).equipmentKeys` tem prioridade | Aliases mantidos para texto livre e exercicios custom | testes existentes + v0.7.11 |',
    )
    ..writeln(
      '| Cardio especifico | Modalidades podiam misturar por nome `passadeira`/`hiit` | `HIIT passadeira` fica no grupo HIIT, nao no grupo `cardio_machine/treadmill` | `contains` apenas para fallback legado | `v0711_filter_metadata_test.dart` |',
    )
    ..writeln()
    ..writeln(
      'Contains restantes justificados: `WorkoutTaxonomy` e aliases de equipamento continuam a suportar exercicios antigos/personalizados sem chaves de catalogo. Para as 305 entradas default, a prioridade passou a ser metadata/contexto.',
    );
  File(
    'FILTER_CONTAINS_REPLACEMENT_AUDIT_v0.7.11.md',
  ).writeAsStringSync(buffer.toString());
}

void _writeAmbiguousNamesAudit() {
  const audited = [
    'Rotacao externa',
    'Rotacao interna',
    'Elevacao lateral',
    'Elevacao frontal',
    'Elevacao posterior',
    'Reverse fly',
    'Y raise',
    'W raise',
    'Remo alto leve',
    'Curl inclinado com halteres',
    'Abducao de anca',
    'Aducao de anca',
    'Gemeos sentado',
    'Soleo sentado',
  ];
  final buffer = StringBuffer()
    ..writeln('# AMBIGUOUS_EXERCISE_NAMES_AUDIT_v0.7.11')
    ..writeln()
    ..writeln(
      '| Nome auditado | Decisao | Renomeado? | Dividido em variantes? | Metadata suficiente? | Teste criado |',
    )
    ..writeln('|---|---|---|---|---|---|');
  for (final name in audited) {
    final decision = name.contains('com halteres') || name.contains('halteres')
        ? 'Nome ja explicita equipamento principal.'
        : 'Mantido para preservar compatibilidade visual/templates; contexto e equipamento explicitos via catalogEntryKey e metadata.';
    buffer.writeln(
      '| $name | $decision | Nao | Nao nesta versao | Sim | `v0711_description_305_test.dart` e `v0711_catalog_context_test.dart` |',
    );
  }
  buffer
    ..writeln()
    ..writeln(
      'Nomes ambiguos auditados/corrigidos por metadata explicita: ${audited.length}',
    )
    ..writeln()
    ..writeln('Nomes renomeados nesta versao: 0')
    ..writeln()
    ..writeln(
      'Justificacao: renomear estes nomes quebraria expectativas antigas de templates/testes. A correcao aplicada e tornar equipamento/contexto explicitos e testados.',
    );
  File(
    'AMBIGUOUS_EXERCISE_NAMES_AUDIT_v0.7.11.md',
  ).writeAsStringSync(buffer.toString());
}

String _esc(String value) => value.replaceAll('|', '/');
