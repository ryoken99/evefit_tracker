# Workout Exercise Selector Roots v0.1

## Resumo

O fluxo `Detalhe do treino > Adicionar exercicio` deixou de abrir primeiro o explorador generico dos quatro eixos. Abre agora um seletor fino, especifico do treino, cuja lista principal e composta pelas oito raizes de capacidade aprovadas no `CanonicalRegistry`.

Os quatro contextos de utilizacao permanecem opcionais e separados pela acao `Procurar por contexto`. Tanto uma capacidade como um contexto produzem exatamente um criterio canonico, executado pelo repository vazio real. Nao foram adicionados exercicios, subniveis, resultados simulados ou dependencias legacy.

## Estado Git

- Branch: `workout-exercise-selector-roots-v0.1`
- Commit base: `ae567d5c9ee9aabf9278d6a97cf2a9b05b4c8bce`
- Base remota: `origin/main` no mesmo commit durante a preparacao
- Versao preservada: `1.1.1+3`
- Main alterada: nao
- Merge, tag ou release: nao

## Inspecao e ponto de integracao

Antes da alteracao, `_addExercise()` em `lib/screens/workout_detail_screen.dart` abria `CanonicalCoreSearchScreen`, obrigando a escolher um dos quatro eixos. O ponto de integracao ficou limitado a esse metodo e ao respetivo import.

Foram reutilizados sem duplicacao:

- `CanonicalRegistry.approvedCapabilityRoots`
- `CanonicalRegistry.approvedUsageContexts`
- `CanonicalCoreNavigationController`
- `CanonicalSearchCriterion` e `CanonicalSearchQuery`
- `CanonicalExerciseSearchRepository`
- `EmptyCanonicalExerciseSearchRepository`
- `CanonicalCoreEmptyState`
- `CanonicalCoreIconResolver`

O explorador generico continua inalterado para entradas independentes.

## Arquitetura implementada

Foi criado `WorkoutExerciseSelectorScreen`, um ecrã especializado e fino dentro do Canonical Core. O ecrã nao possui listas locais de IDs, modelos alternativos ou acesso a base de dados.

Fluxo de capacidade:

```text
approvedCapabilityRoots
  -> selecao de uma raiz
  -> CanonicalSearchCriterion(capabilityRoot, rootId)
  -> CanonicalSearchQuery com 1 criterio
  -> EmptyCanonicalExerciseSearchRepository
  -> CanonicalSearchResult(total: 0, items: [])
  -> estado vazio canonico
```

Fluxo de contexto:

```text
Procurar por contexto
  -> approvedUsageContexts
  -> CanonicalSearchCriterion(usageContext, contextId)
  -> CanonicalSearchQuery com 1 criterio
  -> EmptyCanonicalExerciseSearchRepository
  -> CanonicalSearchResult(total: 0, items: [])
  -> estado vazio canonico
```

Nao existe combinacao de criterios, `main_training`, `exercise_ids` ou fallback.

## Interface e navegacao

- Titulo: `Adicionar exercicio`
- Pergunta principal: `Que capacidade queres trabalhar?`
- Oito cards de capacidade, na ordem do registry
- Nome, descricao e icon key provenientes do registry
- `Semantics` e `ValueKey` estaveis por ID
- Contextos acessiveis apenas pela acao secundaria `Procurar por contexto`
- Back: resultado de capacidade volta às capacidades; resultado de contexto volta aos contextos; contextos voltam às capacidades
- Home: regressa diretamente às oito capacidades
- System Back segue o mesmo estado

O estado vazio mostra o pilar, a selecao, o criterio ativo e `Resultados: 0`, alimentado pelo resultado real do repository.

## Ausencias confirmadas

- Exercicios ativos ou novos: zero
- Subniveis: zero
- Arvore antiga: nao visivel e nao consultada
- `Sem maquinas` e `Caminhada e corrida`: nao visiveis
- Intencoes, conceitos e atributos: nao visiveis
- Catalogo e filtros legacy: nao visiveis
- Imports de `ExerciseFilterService` ou `TrainingFlow`: zero
- `main_training`: ausente
- `exercise_ids`: ausente
- Consultas a `exercises`, assets ou arquivo legacy: zero

As flags Clean Base continuam desligadas para seed, catalogo e filtros legacy.

## Ficheiros criados

- `lib/features/canonical_core/screens/workout_exercise_selector_screen.dart`
- `test/canonical_core/workout_exercise_selector_screen_test.dart`
- `integration_test/workout_exercise_selector_roots_full_app_test.dart`
- `tool/run_workout_exercise_selector_roots_test.ps1`
- `docs/canonical/Workout_Exercise_Selector_Roots_v0.1_Implementation_Report.md`

## Ficheiros alterados

- `lib/screens/workout_detail_screen.dart`: troca apenas o destino de `Adicionar exercicio`; hero tag e restantes acoes preservadas
- `lib/features/canonical_core/widgets/canonical_core_empty_state.dart`: keys opcionais com defaults retrocompativeis
- `test/clean_base/clean_base_catalog_visibility_test.dart`: contrato estrutural atualizado para o seletor especializado
- `test/clean_base/legacy_runtime_removal_test.dart`: contrato estrutural atualizado sem reduzir as assercoes legacy-free

## Ficheiros explicitamente nao alterados

- Dashboard e testes do Dashboard
- Perfil, objetivos, medicoes e fotografias
- Base de dados, schema e migrations
- Catalogo, exercicios e historicos
- Arquivo legacy
- `pubspec.yaml`, workflows de release e signing Android

## Testes

### Unitarios e widget

- Seletor focado: 7 testes, todos passaram
- Canonical Core: 27 testes, todos passaram
- Clean Base: 9 testes, todos passaram
- Cobertura: 8 raizes exatas, registry como fonte, contextos separados, query unica, repository vazio, navegacao, layout estreito/texto grande, erro sem resultados falsos e ausencia de legacy/tokens proibidos

### Suite completa

- Comando: `flutter test -r compact`
- Resultado: 592 testes passaram
- Duracao: 12m04s
- Log local ignorado pelo Git: `test_artifacts/workout_exercise_selector_roots/full_suite.log`
- A maior duracao pertence ao teste legado de descricoes quase duplicadas; concluiu sem falhas.

### Full-app Android

- Entrypoint real: `app.main()`
- Dispositivo: `EveFit_Test_Device`
- Modelo: `sdk_gphone64_x86_64` configurado como laboratorio Pixel 8 Pro
- Android: 16, API 36, x86_64
- Runner: `flutter test ... -d emulator-5554 --no-uninstall`
- Exit code nas execucoes validadas: 0
- Fluxo coberto: perfil, treino, detalhe, seletor, capacidade, contexto, Dashboard, Definicoes, Objetivos e regresso a Treinos
- Excecoes Flutter/Hero: zero

Execucao final com screenshots:

- Diretorio: `test_artifacts/workout_exercise_selector_roots/full_app/2026-07-14T222757Z/`
- Log Flutter: `flutter_drive.log`
- Log Android: `logcat.log`
- Metadata: `metadata.json`
- Screenshots: 10 PNG validos em `screenshots/`

O script usa armazenamento temporario privado da app e `adb run-as` para copiar os PNGs antes do cleanup. O primeiro ensaio com `flutter drive` concluiu funcionalmente, mas ficou preso no protocolo `request_data`; foi substituido pelo runner nativo que devolve o exit code real.

## Performance

Build mode: debug. Ambiente, AVD e commit base iguais nas tres medicoes.

| Run | Abertura do seletor | Capacidade ate vazio | Contexto ate vazio |
| --- | ---: | ---: | ---: |
| `2026-07-14T220925Z` | 125 ms | 113 ms | 121 ms |
| `2026-07-14T221008Z` | 125 ms | 115 ms | 117 ms |
| `2026-07-14T221043Z` | 131 ms | 118 ms | 115 ms |

- Mediana de abertura: 125 ms
- Pior abertura: 131 ms
- Mediana capacidade ate vazio: 115 ms
- Pior capacidade ate vazio: 118 ms
- Mediana contexto ate vazio: 117 ms
- Pior contexto ate vazio: 121 ms

Uma execucao adicional para validar a exportacao das screenshots registou 127 ms, 129 ms e 116 ms, respetivamente.

## Validacao

- `flutter pub get`: passou
- `dart format --set-exit-if-changed .`: passou, 276 ficheiros e zero alteracoes pendentes
- `flutter analyze`: passou, zero issues
- Testes focados: passaram
- Testes Canonical Core: passaram
- Testes Clean Base: passaram
- Suite completa: passou, 592 testes
- Full-app Android: passou, incluindo tres runs de performance e uma run final com screenshots
- `flutter build apk --debug`: passou
- Build release: nao executada por proibicao de escopo

## Multiagente

Atualizacao de orquestracao multiagente recebida e aplicada.

Foram usados cinco subagentes read-only em tarefas curtas e auditaveis. Os quatro primeiros usaram Luna Low; a revisao final usou Luna Medium:

1. Auditor de arquitetura: mapeou o ponto de entrada, contratos e alternativas. O mapa factual foi aceite; a recomendacao de modo no ecrã generico foi rejeitada porque a screen fina especializada corresponde melhor à UX vinculativa sem duplicar dados.
2. Analista de testes: inventariou cobertura existente e lacunas. Resultado aceite.
3. Auditor de escopo e legacy: confirmou registry 8/4/0, repository vazio, flags Clean Base e ausencia de tokens escondidos. Resultado aceite.
4. Analista de logs full-app: demonstrou que o fluxo tinha passado e que o bloqueio estava no `request_data` do Flutter Driver. Resultado aceite e usado para trocar apenas o runner.
5. Revisor final do diff: confirmou 8 raizes, 4 contextos separados, uma query com um criterio, repository vazio e isolamento funcional. A conclusao foi aceite. A recomendacao de remover ou relocalizar os untracked conhecidos foi rejeitada porque a ordem manda preserva-los fora do stage.

Os agentes nao editaram ficheiros, nao criaram branches, commits, pushes, PRs, merges, tags ou releases. A implementacao, integracao e validacao final permaneceram sob responsabilidade exclusiva do Sol.

## Riscos e limitacoes

- O repository continua intencionalmente vazio; nenhuma selecao pode ainda adicionar um exercicio ao treino.
- O seletor depende dos IDs aprovados no registry; futuras alteracoes devem preservar a validacao de um unico criterio.
- Os artefactos Android sao locais e ignorados pelo Git.
- O teste completo permanece lento devido a uma verificacao antiga de descricoes, fora do escopo desta feature.

## Rollback

Reverter os commits desta branch restaura `CanonicalCoreSearchScreen` como destino de `_addExercise()`. Nao ha migration, schema, dados persistidos ou versao a reverter. O ecrã generico nunca foi removido.

## Recomendacao

Recomendar merge apenas depois da quality gate do Draft Pull Request passar e da revisao funcional do Sandro. O escopo esta isolado, a versao e os dados permanecem inalterados e todos os gates locais exigidos passaram.
