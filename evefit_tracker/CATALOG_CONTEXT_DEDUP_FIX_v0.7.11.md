# CATALOG_CONTEXT_DEDUP_FIX_v0.7.11

Antes: `_seedExercises` procurava por `name = ?`, por isso nomes repetidos podiam ficar com apenas um contexto persistido.

Depois: cada entrada default tem `catalogEntryKey = exerciseKey + "__" + contextKey`; o seed insere/atualiza por essa chave ou por `name + muscle_group` em bases antigas.

| Nome | Contextos preservados | Contextos perdidos antes | Correcao feita | Teste |
|---|---|---|---|---|
| Chin tuck | Pescoço; Mobilidade | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |
| Rotação cervical controlada | Pescoço; Mobilidade | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |
| Inclinação lateral do pescoço | Pescoço; Mobilidade | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |
| Face pull no cabo | Trapézio; Ombros; Costas | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |
| Wall slides | Ombros; Mobilidade | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |
| Pullover com halter | Peito; Costas | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |
| Good morning sem carga | Costas; Pernas | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |
| Curl inverso | Bíceps; Antebraço/Pega | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |
| Superman | Core; Pernas | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |
| Drills de guarda | Karate; Jiu-Jitsu | Possivel colapso para um unico nome visivel | Preservado com catalogEntryKey por contexto | `v0711_catalog_context_test.dart` |

Total de nomes repetidos por contexto: 10

Contextos duplicados preservados: 11
