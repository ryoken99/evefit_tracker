# Hierarchical Canonical Exercise Search v0.1

## Estado de execução

- Branch: `hierarchical-canonical-exercise-search-v0.1`
- Commit base: `cdb3a0203397572762560998ccf2d95c637e9ac6`
- Versão pública preservada: `1.1.1+3`
- Main alterada: não
- Schema ou migrations alterados: não
- Exercícios adicionados: 0
- Conceitos ativos: 0
- Intenções ativas: 0
- Atributos oficiais ativos: 0
- Subníveis taxonómicos ativos: 0

## Arquitetura

O seletor aberto por **Adicionar exercício** no detalhe do treino passou a usar um percurso hierárquico de interface:

`Contexto -> Capacidade -> Conceito de treino -> Intenção -> Resultados`

Os pilares continuam independentes no domínio. Não foram criados `parent_id`, relações de propriedade, subárvores, listas de `exercise_ids` ou associações a IDs legacy.

O núcleo é composto por:

1. `CanonicalRegistry`: fonte única dos valores aprovados e planos.
2. `CanonicalExerciseSelectionPath`: estado imutável e progressivo das quatro escolhas.
3. `CanonicalSelectionCompatibilityProvider`: contrato tipado para opções compatíveis, sem propriedade hierárquica.
4. `HierarchicalCanonicalSearchController`: controla o passo, preserva escolhas ao voltar e limpa escolhas posteriores quando uma anterior muda.
5. `WorkoutExerciseSelectorScreen`: UI fina que renderiza o passo atual e não executa pesquisa final antes de existir um percurso completo.

O ecrã genérico `CanonicalCoreSearchScreen` permanece passivo para compatibilidade e testes, mas não tem ponto de entrada de produção. O detalhe do treino possui apenas um fluxo ativo para adicionar exercícios: `WorkoutExerciseSelectorScreen`.

## Definições canónicas

### Contextos ativos

Existem exatamente cinco contextos visíveis, pela ordem aprovada:

1. `main_training` - Treino principal
2. `warmup` - Aquecimento
3. `activation` - Ativação
4. `recovery_cooldown` - Recuperação e retorno à calma
5. `prevention_adaptation_return` - Prevenção, adaptação e retorno à função

`main_training` é explícito, visível e selecionado manualmente. Não é injetado ao escolher uma capacidade e não existe na query inicial.

### Capacidades ativas

As oito capacidades existentes foram preservadas sem alterar IDs, nomes, descrições ou ordem:

1. `muscular_capacity`
2. `cardio_conditioning`
3. `speed_power`
4. `mobility`
5. `flexibility`
6. `motor_control_coordination`
7. `technique_skill`
8. `breathing_regulation`

## Query progressiva

Antes de qualquer seleção:

```text
criteria = []
```

Depois de escolher Aquecimento:

```text
usageContext = warmup
```

Depois de escolher Cardio e condicionamento:

```text
usageContext = warmup
AND capabilityRoot = cardio_conditioning
```

A ordem contratual é sempre:

1. `usage_context`
2. `capability_root`
3. `training_concept`
4. `training_intention`

O validador rejeita eixos duplicados, ordem progressiva invertida, mais de quatro critérios e propriedades proibidas, incluindo `exercise_ids`, `legacy_ids` e `parent_id`.

## Comportamento atual

O passo Contexto apresenta cinco cartões. Uma seleção explícita cria exatamente um critério e abre as oito capacidades. A escolha de uma capacidade cria exatamente dois critérios e abre o passo Conceito.

Como não existem conceitos aprovados, o fluxo termina intencionalmente com:

> Ainda não existem conceitos de treino aprovados.

> Os conceitos compatíveis com esta seleção serão adicionados e validados progressivamente.

O percurso Contexto > Capacidade é mostrado no breadcrumb e no estado vazio. O fluxo não avança para Intenção, não chama o repository final, não mostra exercícios e não apresenta resultados fictícios.

Voltar preserva escolhas anteriores válidas. Regressar ao início limpa todo o percurso. Alterar uma escolha anterior limpa as escolhas posteriores; voltar a escolher o mesmo valor preserva o estado posterior já válido.

## Ficheiros criados

- `lib/features/canonical_core/models/canonical_exercise_selection_path.dart`
- `lib/features/canonical_core/services/canonical_selection_compatibility_provider.dart`
- `lib/features/canonical_core/services/hierarchical_canonical_search_controller.dart`
- `test/canonical_core/hierarchical_canonical_search_controller_test.dart`
- `docs/canonical/Hierarchical_Canonical_Exercise_Search_v0.1_Implementation_Report.md`

## Ficheiros alterados

- `lib/features/canonical_core/data/canonical_registry.dart`
- `lib/features/canonical_core/models/canonical_core_models.dart`
- `lib/features/canonical_core/screens/workout_exercise_selector_screen.dart`
- `lib/features/canonical_core/validators/canonical_validator.dart`
- `lib/features/canonical_core/widgets/canonical_core_icon_resolver.dart`
- `test/canonical_core/canonical_core_contract_test.dart`
- `test/canonical_core/canonical_core_search_screen_test.dart`
- `test/canonical_core/workout_exercise_selector_screen_test.dart`
- `test/clean_base/legacy_runtime_removal_test.dart`
- `integration_test/canonical_core_search_full_app_test.dart`
- `integration_test/workout_exercise_selector_roots_full_app_test.dart`

## Testes

### Unitários e widget

Os testes focados cobrem:

- 5 contextos, com `main_training` único e primeiro;
- 8 capacidades inalteradas;
- zero conceitos, intenções e atributos ativos;
- seleção explícita de `main_training`;
- ausência de injeção implícita;
- query com 1 e 2 critérios;
- ordem `usageContext + capabilityRoot`;
- validação de queries excessivas sem `RangeError`;
- pré-requisitos do modelo de seleção;
- limpeza de escolhas posteriores;
- back, home e breadcrumb;
- estado vazio aprovado de Conceito;
- ausência de repository search, exercícios, subníveis e legacy;
- layout estreito e texto ampliado.

Resultado focado final: 41 testes passaram.

### Full-app Android

Teste: `integration_test/workout_exercise_selector_roots_full_app_test.dart`

Dispositivo: `EveFit_Test_Device` (`emulator-5554`)

Cada execução usou `-ClearAppData`, `app.main()`, criou um perfil e treino reais, abriu o seletor pelo detalhe do treino, validou os percursos Aquecimento > Cardio e Treino principal > Força, regressou à navegação principal e abriu Dashboard, Perfil/Definições e Objetivos.

As três execuções terminaram com exit code 0 e zero exceções Flutter/Hero.

## Performance

Valores em milissegundos:

| Medição | Run 1 | Run 2 | Run 3 | Mediana | Pior |
| --- | ---: | ---: | ---: | ---: | ---: |
| Abrir seletor | 123 | 123 | 128 | 123 | 128 |
| Contexto -> Capacidade | 115 | 113 | 118 | 115 | 118 |
| Capacidade -> Conceito vazio | 118 | 117 | 115 | 117 | 118 |

Referência indicativa do seletor anterior, em três runs do mesmo laboratório: abertura `125/125/131 ms`, mediana `125 ms`, pior `131 ms`. A nova abertura não apresenta regressão grande ou reproduzível. As restantes transições mudaram semanticamente e são apresentadas como tempos absolutos.

## Screenshots e logs

Artefactos runtime, ignorados pelo Git:

- `test_artifacts/workout_exercise_selector_roots/full_app/2026-07-16T011015Z/`
- `test_artifacts/workout_exercise_selector_roots/full_app/2026-07-16T011824Z/`
- `test_artifacts/workout_exercise_selector_roots/full_app/2026-07-16T012145Z/`

Cada diretório contém:

- 11 screenshots PNG válidos;
- `flutter_drive.log`;
- `logcat.log`;
- `metadata.json`;
- logs stdout/stderr do runner.

Foram capturados a configuração inicial, Dashboard, detalhe do treino, cinco contextos, oito capacidades, os dois estados vazios aprovados, regresso ao treino, Perfil/Definições e Objetivos.

## Validação

- `flutter pub get`: passou
- `dart format --set-exit-if-changed .`: passou, 280 ficheiros verificados, 0 alterados
- `flutter analyze`: passou, 0 issues
- testes focados: passaram, 41 testes
- suíte completa: passou na repetição final com 603 testes; log em `test_artifacts/hierarchical_canonical_search/full_suite/20260716-031218/flutter_test.log`
- full-app Android: passou em 3/3 runs
- `flutter build apk --debug`: passou no código final; `build/app/outputs/flutter-apk/app-debug.apk`
- build release: não executado, fora do escopo desta ordem

## Preservação de escopo

Confirmado:

- catálogo legacy visível: não
- filtros legacy visíveis: não
- seed legacy ativo: não
- catálogo canónico com exercícios ativos: não
- árvore antiga visível: não
- exercícios adicionados: não
- resultados fictícios adicionados: não
- Dashboard alterado: não
- goals alterados: não
- medições alteradas: não
- treinos ou históricos alterados: não
- base de dados ou migrations alteradas: não
- versão alterada: não
- tag ou release criada: não

Os dois ficheiros untracked conhecidos permaneceram fora de qualquer stage:

- `../15_ARTES_MARCIAIS_EXERCICIOS_DERIVADOS.md`
- `docs/catalog_reports/v0.9.4/menu_matrix_review_pack.zip`

## Orquestração multiagente

O agente principal GPT-5.6-Sol, raciocínio xhigh, manteve a integração, implementação, validação, commits e PR.

Agentes read-only usados:

| Agente | Thread | Modelo / raciocínio | Papel | Resultado |
| --- | --- | --- | --- | --- |
| Ohm | `019f6866-669d-7212-827d-33885f39109b` | GPT-5.6-Luna / high | Auditoria de arquitetura | Aceite: fluxo ativo único, registry plano e necessidade de estado tipado. Rejeitada a remoção do explorer genérico passivo. |
| Zeno | `019f6866-7ac2-7620-af03-c2fbe823a7ac` | GPT-5.6-Luna / medium | Estratégia de testes Android | Aceite: cobertura de query, empty state e back. Rejeitada a ordem sugerida `capabilityRoot + usageContext`; foi aplicada a ordem vinculativa inversa. |
| Peirce | `019f6866-8fad-7912-aa72-545677e863f4` | GPT-5.6-Luna / medium | Auditoria de contratos e escopo | Aceite: ausência de necessidade de schema, migration ou relações ontológicas. |
| Banach | `019f68ac-44f4-7241-ad68-e69621baaf94` | GPT-5.6-Luna / high | Revisão final read-only | Sem bugs funcionais. Confirmou contratos, escopo e alertou para excluir os dois untracked conhecidos. |

Os agentes correram investigação paralela sem editar ficheiros. Não existiram conflitos de código. Apenas o agente principal integrou decisões e executou alterações.

## Riscos e limitações

- Conceitos e intenções permanecem vazios por decisão de produto; o fluxo termina corretamente no terceiro passo.
- O contrato para passos futuros existe, mas não há valores fictícios nem execução de pesquisa final nesta fase.
- O ecrã genérico passivo continua no código para compatibilidade, sem ser um segundo ponto ativo de Adicionar exercício.
- A suíte histórica contém um teste quadrático de near-duplicates que domina o tempo total; não foi alterado nem ignorado.

## Rollback

O trabalho é reversível através de `git revert` dos commits desta branch. Não existe migration, escrita de dados, alteração de versão ou transformação de históricos a reverter.

## Recomendação

Recomendar merge apenas se a quality gate do Draft PR ficar verde. A repetição final da suíte e o rebuild debug passaram. Não iniciar a definição de conceitos nesta fase.
