# Canonical Core Foundation v0.1 - Implementation Report

## Estado

- Branch: `canonical-core-foundation-v0.1`
- Commit base: `0388222fa541dea5ffcb0a185f0c335143ee4fe4`
- Versão preservada: `1.1.0+2`
- Schema do núcleo: `0.1`
- Namespace de pesquisa: `canonical_core_search/0.1`
- Base de dados: inalterada
- Catálogo canónico ativo: vazio
- Exercícios adicionados: zero

## Arquitetura anterior

`lib/features/canonical_search/` continha uma árvore tipada de 246 nós, com 12
entradas no topo, 45 grupos, 189 terminais, `parentId`, profundidade máxima 3,
queries locais e composição de condições por ancestrais. Ao entrar por uma
capacidade, o controller injetava ainda `usage_context = main_training`.

`WorkoutDetailScreen` abria diretamente `CanonicalSearchMenuScreen`. A feature
não dependia da base de dados nem do catálogo legacy, pelo que a substituição
pôde permanecer isolada.

## Decisão de escopo

Os 45 grupos, 189 terminais e respetivos eixos não eram taxonomia aprovada. O
runtime passa a conter apenas os quatro eixos conceptuais, oito raízes de
capacidade e quatro contextos explicitamente aprovados. Intenções, conceitos e
atributos permanecem vazios até aprovação de produto.

## Arquitetura final

`lib/features/canonical_core/` é a única implementação ativa:

- `models/`: contratos imutáveis de eixos, definições, atributos, query e resultado.
- `data/`: `CanonicalRegistry`, única fonte de valores aprovados.
- `validators/`: invariantes do registo e validação de queries.
- `repositories/`: contrato genérico e repositório vazio real.
- `services/`: estado local da navegação, sem persistence.
- `screens/` e `widgets/`: UI fina baseada no registry e no repository.

Fluxo:

```text
eixo selecionado
  -> valor aprovado
  -> CanonicalSearchCriterion
  -> CanonicalSearchQuery
  -> EmptyCanonicalExerciseSearchRepository
  -> CanonicalSearchResult(total: 0, items: [])
  -> estado vazio canónico
```

Não há simulação direta no widget, fallback, consulta à tabela `exercises`,
import legacy ou lista fixa de resultados.

## Fundação ativa

- Eixos conceptuais: 4.
- Raízes de capacidade: 8.
- Contextos de utilização: 4.
- Valores classificatórios ativos: 12.
- Intenções aprovadas: 0.
- Conceitos aprovados: 0.
- Atributos aprovados: 0.
- Filhos ou subníveis: 0.
- Profundidade taxonómica máxima: 1.
- Exercícios ativos: 0.

Os eixos são metadados de navegação e não são contados como valores.

## Query e repository

Cada query atual contém exatamente um `CanonicalSearchCriterion` com `axis` e
`valueId`. Apenas `capabilityRoot` e `usageContext` aceitam valores. O validator
rejeita valores desconhecidos, draft, pertencentes a outro eixo, IDs antigos,
resultados proprietários e o contexto escondido substituído.

`EmptyCanonicalExerciseSearchRepository<TItem>` valida a query e devolve um
resultado tipado vazio. Não consulta base de dados, legacy ou assets.

## Interface e navegação

O primeiro ecrã mostra “Como queres procurar?” e quatro cartões:

1. Por capacidade.
2. Por intenção.
3. Por conceito de treino.
4. Por contexto.

Capacidade mostra oito raízes. Contexto mostra quatro valores. Selecionar um
valor executa o repository e abre diretamente o estado vazio. Intenção e
conceito mostram mensagens de vocabulário em definição, sem sugestões ou
opções. Back volta um passo e Home limpa o estado.

## Remoção do runtime antigo

Foram retirados da implementação ativa:

- seis ficheiros de `lib/features/canonical_search/`;
- builders dos 234 subníveis;
- `parentId`, depth 2/3 e navegação por children;
- effective query por ancestrais;
- injeção de `main_training`;
- testes que promoviam as contagens 45/189/246;
- integration tests e scripts Android da árvore antiga.

Não foi mantido adapter porque todos os imports executáveis puderam ser
atualizados diretamente, evitando duas fontes de verdade.

## Preservação do rascunho

A estrutura completa anterior foi exportada antes da remoção para:

`docs/research/unapproved/Canonical_Search_Subtrees_v0.1_Unapproved_Draft.md`

O ficheiro regista commit, path, schema, contagens, IDs, parent IDs, depth,
eixos, nomes, ordem, icons e query conditions dos 246 nós. Está marcado como
**NÃO APROVADO**, não consta dos assets do `pubspec.yaml` e não é importado pelo
runtime ou pelos testes de produção.

## Identidade, variações, protocolos e prescrição

Os princípios aprovados estão em constantes de domínio e no Script Canónico.
Não foram criadas assinaturas finais, heurísticas de duplicação, variantes,
protocolos ativos, prescrições, tabelas ou exemplos de exercícios.

## Base de dados e legacy

Não houve migration, alteração da versão da base, tabela, foreign key, seed ou
dado histórico. O legacy permanece fora do runtime e os históricos continuam
passivos e preservados. `canonical_core` não importa loaders, serviços ou
arquivos legacy.

## Testes

Testes unitários cobrem registry, contagens, estados de aprovação, ausência de
hierarquia, IDs, ordem, query, validator, repository vazio, identidade, assets
e isolamento legacy/database. Widget tests cobrem os quatro eixos, oito raízes,
quatro contextos, estados pendentes, resultados vazios, repository call,
breadcrumbs, Back, Home, Semantics, ecrã estreito e ausência dos subníveis.

O full-app test usa `app.main()` no `EveFit_Test_Device`, cria perfil e treino,
abre a pesquisa pelo `WorkoutDetailScreen`, valida os quatro fluxos, captura
screenshots e regressa a Dashboard, Perfil/Definições, Objetivos e Treinos.

### Resultados

| Gate | Resultado |
|---|---|
| `flutter pub get` | Passou |
| `dart format --set-exit-if-changed .` | Passou, 273 ficheiros sem alterações |
| `flutter analyze` | Passou, zero issues |
| Testes focados core + Clean Base | 29 passaram |
| `flutter test -r compact` | 585 passaram |
| Full-app Android run 1 | Passou, exit code 0 |
| Full-app Android run 2 | Passou, exit code 0 |
| Full-app Android run 3 | Passou, exit code 0 |
| `flutter build apk --debug` | Passou |

A baseline tinha 574 testes. Foram removidos 9 testes que promoviam a árvore
antiga (5 unitários e 4 widget tests) e adicionados 20 testes do novo núcleo e
UI, resultando em **+11 testes** sem perda de cobertura.

### Full-app e artefactos

Ambiente: `EveFit_Test_Device`, Android 16/API 36, x86_64, debug mode. Cada run
produziu 13 screenshots, `flutter_drive.log`, `logcat.log` e `metadata.json`:

- `test_artifacts/canonical_core/full_app/2026-07-13T133423Z/`
- `test_artifacts/canonical_core/full_app/2026-07-13T133502Z/`
- `test_artifacts/canonical_core/full_app/2026-07-13T133535Z/`

Os três runs finais foram executados no commit de código
`23cc50a9e68c1e2a267a2bb7e69b5be7d0e6c5e0`.

O log completo da suíte está em
`test_artifacts/canonical_core/unit/20260713-140416/flutter_test_full.log`.
Todos estes artefactos estão ignorados pelo Git.

### Performance

As medições usam três instalações limpas no mesmo emulador e modo debug:

| Run | Primeiro ecrã utilizável | Explorar | Capacidade | Cardio vazio | Contexto | Aquecimento vazio |
|---|---:|---:|---:|---:|---:|---:|
| 1 | 1510 ms | 118 ms | 356 ms | 124 ms | 116 ms | 109 ms |
| 2 | 1365 ms | 117 ms | 339 ms | 118 ms | 116 ms | 123 ms |
| 3 | 1484 ms | 118 ms | 352 ms | 120 ms | 115 ms | 109 ms |
| Mediana | **1484 ms** | **118 ms** | **352 ms** | **120 ms** | **116 ms** | **109 ms** |
| Pior | **1510 ms** | **118 ms** | **356 ms** | **124 ms** | **116 ms** | **123 ms** |

A mediana de 1484 ms não reintroduz atraso material face à referência
aproximada de 1637 ms da v1.1.0.

### Incidentes de validação

O primeiro build Android perdeu transitoriamente a ligação ao descarregar o
asset nativo `libsqlite3.x64.android.so`; um retry sem alterações passou. As
primeiras execuções do novo teste Android também expuseram uma espera incompleta
na transição de retorno ao `IndexedStack`. O teste foi corrigido para aguardar o
`pumpAndSettle()` e selecionar o `NavigationDestination` real. Nenhuma alteração
de navegação de produção, Gradle ou configuração Android foi necessária.

## Ficheiros criados

- `lib/features/canonical_core/models/canonical_core_models.dart`
- `lib/features/canonical_core/data/canonical_registry.dart`
- `lib/features/canonical_core/repositories/canonical_exercise_search_repository.dart`
- `lib/features/canonical_core/validators/canonical_validator.dart`
- `lib/features/canonical_core/services/canonical_core_navigation_controller.dart`
- `lib/features/canonical_core/screens/canonical_core_search_screen.dart`
- `lib/features/canonical_core/widgets/canonical_core_empty_state.dart`
- `lib/features/canonical_core/widgets/canonical_core_icon_resolver.dart`
- `test/canonical_core/canonical_core_contract_test.dart`
- `test/canonical_core/canonical_core_search_screen_test.dart`
- `integration_test/canonical_core_search_full_app_test.dart`
- `tool/run_canonical_core_full_app_test.ps1`
- Os três documentos em `docs/canonical/` e o rascunho não aprovado.

## Ficheiros alterados

- `lib/screens/workout_detail_screen.dart`: apenas import e screen aberta.
- Testes Clean Base e upgrade: apontam para o núcleo ativo.

## Ficheiros removidos

- Implementação e testes ativos em `lib/features/canonical_search/` e
  `test/canonical_search/`.
- Integration tests e scripts Android exclusivos da árvore substituída.

## Riscos e limitações

- Não existe conteúdo canónico; todos os resultados são vazios por decisão.
- Intenções, conceitos e atributos dependem de aprovação futura.
- O contrato `0.1` é extensível, mas não é declarado schema final de exercício.
- O rascunho histórico não deve voltar a ser importado ou promovido.

## Rollback

Reverter os commits desta branch restaura a implementação anterior sem tocar na
base de dados. O rascunho pode permanecer como documentação histórica. Não é
necessário downgrade de schema, migration ou transformação de dados.

## Próximos passos não iniciados

Revisão humana do PR, aprovação futura dos vocabulários e desenho do primeiro
exercício canónico. Esta tarefa não inicia v1.2, subfiltros ou catálogo.
