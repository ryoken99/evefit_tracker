# CATALOG_SOURCE_OF_TRUTH_AUDIT_v0.7.11

Fonte de verdade do catalogo: `lib/database/seed_data.dart`, campo `SeedData.exercisesByGroup`.

Camada de contexto: `lib/services/exercise_catalog_context_service.dart` gera 305 entradas com `exerciseKey`, `contextKey` e `catalogEntryKey`.

Representacao em runtime: `lib/models/exercise.dart` mantem compatibilidade com a UI e passa a carregar as chaves de catalogo.

Persistencia: `lib/database/app_database.dart` semeia por `catalog_entry_key` ou `name + muscle_group`, evitando colapso por nome.

- Total de entradas totais: 305
- Total de exercicios unicos: 294
- Contextos duplicados preservados: 11
- Entradas dependentes apenas de fallback generico: 0

Ficheiros alterados:
- `lib/models/exercise.dart`
- `lib/services/exercise_catalog_context_service.dart`
- `lib/database/app_database.dart`
- `lib/services/training_architecture.dart`
- `lib/services/exercise_filter_service.dart`
- `test/v0711_catalog_context_test.dart`
- `test/v0711_description_305_test.dart`
- `test/v0711_filter_metadata_test.dart`
