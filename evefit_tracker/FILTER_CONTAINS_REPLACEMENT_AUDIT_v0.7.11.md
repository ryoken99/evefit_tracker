# FILTER_CONTAINS_REPLACEMENT_AUDIT_v0.7.11

| Zona | Contains fragil antes | Substituicao/prioridade v0.7.11 | Fallback restante | Teste |
|---|---|---|---|---|
| Identidade de exercicio | Nome visivel usado como chave unica | `exercise_key`, `context_key`, `catalog_entry_key` | Nenhum para entradas default | `v0711_catalog_context_test.dart` |
| Tags anatomicas | `TrainingArchitecture.tagsForExercise` inferia por nome/grupo/equipamento | Entradas com `catalogEntryKey` usam tags por contexto antes da inferencia textual | Mantido para exercicios personalizados/legados sem catalogEntryKey | `v0711_filter_metadata_test.dart` |
| Foco especifico | `_matchesHierarchyFocus` dependia de keywords | Tenta `groupKeys`, `subgroupKeys` e `muscleKeys` explicitos antes dos keywords | Keywords mantidos para aliases historicos | `v0711_filter_metadata_test.dart` |
| Equipamento | Aliases por texto eram decisivos | `TrainingArchitecture.tagsForExercise(...).equipmentKeys` tem prioridade | Aliases mantidos para texto livre e exercicios custom | testes existentes + v0.7.11 |
| Cardio especifico | Modalidades podiam misturar por nome `passadeira`/`hiit` | `HIIT passadeira` fica no grupo HIIT, nao no grupo `cardio_machine/treadmill` | `contains` apenas para fallback legado | `v0711_filter_metadata_test.dart` |

Contains restantes justificados: `WorkoutTaxonomy` e aliases de equipamento continuam a suportar exercicios antigos/personalizados sem chaves de catalogo. Para as 305 entradas default, a prioridade passou a ser metadata/contexto.
