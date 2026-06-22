# AUDIT_REPORT — v0.8.0

Data inicial: 2026-06-22  
Repositório: `ryoken99/evefit_tracker`  
Remote: `https://github.com/ryoken99/evefit_tracker.git`  
Branch: `feature/v0.8.0-profile-equipment-catalog-integrity`  
Base funcional: `444ec98` — v0.7.17 anatomical muscle nodes  
Estado: auditoria inicial, antes das correções funcionais

## Linha de base

### Verificação do repositório

- `git remote get-url origin`: `https://github.com/ryoken99/evefit_tracker.git`.
- `git branch --show-current`: `feature/v0.8.0-profile-equipment-catalog-integrity`.
- A branch não é `main` e parte da v0.7.17, preservando a migração e os testes de nós musculares.

### flutter analyze

Primeira tentativa:

- Comando: `flutter analyze`.
- Resultado: falhou antes de executar o analisador.
- Erro: `flutter : The term 'flutter' is not recognized as the name of a cmdlet, function, script file, or operable program.`
- Motivo provável: `C:\tools\flutter\bin` não está no `PATH` do processo Codex.
- Classificação: ambiente, não código.

Repetição com a instalação local descoberta:

- Comando: `C:\tools\flutter\bin\flutter.bat analyze`.
- Resultado: `No issues found! (ran in 40.9s)`.
- Classificação: linha de base de código aprovada.

### flutter test

- Comando: `C:\tools\flutter\bin\flutter.bat test`.
- Resultado: `All tests passed!`.
- Total: 208 testes aprovados, zero falhas.
- Duração observada: 37,4 segundos.
- Classificação: linha de base de código aprovada.

## Bugs encontrados

| ID | Estado inicial | Problema | Evidência inicial | Risco |
|---|---|---|---|---|
| V080-01 | OPEN | `goal_milestones` é lida e alterada apenas por `goal_id`/`id`, sem validar `goals.profile_id`. | `AppDatabase.goalMilestones`, `insertGoalMilestone`, `updateGoalMilestone`. | Exposição e alteração entre perfis. |
| V080-02 | OPEN | A exportação não inclui milestones. | `AppDatabase.exportData`. | Backup incompleto e impossível de validar por perfil. |
| V080-03 | OPEN | `updateProfileEquipment` passa `trainingLocation: ''`. | `AppDatabase.updateProfileEquipment`. | Equipamento de ginásio/local deixa de refletir o perfil. |
| V080-04 | OPEN | `bodyweight` não é garantido no conjunto devolvido. | `availableEquipmentKeys`. | Exercícios sem equipamento podem desaparecer. |
| V080-05 | OPEN | `jump_rope` aparece em duas secções que também funcionam como fonte de identidade. | `ProfilePreferencesService.equipmentSections`. | Identidade interna duplicada. |
| V080-06 | OPEN | Parte do filtro anatómico ainda usa texto livre e `contains`. | `ExerciseFilterService`, `TrainingArchitecture`. | Falsos positivos/negativos por tradução e nomes. |
| V080-07 | OPEN | O modelo persistido não contém toda a taxonomia canónica pedida. | `Exercise`, schema `exercises`. | Filtros dependem de inferência em tempo de execução. |
| V080-08 | OPEN | Templates resolvem exercícios por `name = ? LIMIT 1`. | `insertWorkoutFromTemplate`. | Exercício errado quando o nome é ambíguo. |
| V080-09 | OPEN | Exercícios personalizados não têm `profile_id`; ocultação é global. | `exercises`, `deleteExercise`. | Um perfil pode ver/ocultar dados de outro. |
| V080-10 | OPEN | Existem textos mojibake em serviços, UI e catálogo. | Exemplos `ExtensÃ£o`, `BÃ­ceps`, `mÃ£o`, `glÃºteos`. | Texto ilegível e chaves derivadas instáveis. |
| V080-11 | OPEN | Tentativas de PIN e `locked_until` vivem apenas em mapas de memória. | `_pinFailedAttempts`, `_pinLockedUntil`. | Reiniciar a app remove o bloqueio. |
| V080-12 | OPEN | `workouts()` executa duas queries por treino. | Ciclo em `AppDatabase.workouts`. | N+1 e degradação com histórico grande. |
| V080-13 | OPEN | Dashboard apresenta altura com `toStringAsFixed` mesmo quando o fallback do perfil é 0. | `dashboard_screen.dart`, `profile()`. | `0 cm` apresentado como dado real. |
| V080-14 | OPEN | Widgets do dashboard são guardados individualmente. | `_editDashboard` chama `updateDashboardWidget` num ciclo. | Estado parcial se uma atualização falhar. |
| V080-15 | OPEN | Chaves desconhecidas devolvem o primeiro item de várias listas. | lookups em `workouts_screen.dart` e `DashboardMetricService`. | Informação antiga é apresentada como opção válida diferente. |
| V080-16 | OPEN | Versão pública atual é v0.7.16/v0.7.17 e `pubspec` usa `0.7.17+25`. | `pubspec.yaml`, Settings, README, workflow. | Release inconsistente. |
| V080-17 | OPEN | Qualidade do catálogo precisa de validação v0.8.0 para os 15 campos pedagógicos e cobertura completa requerida. | Serviços atuais têm quatro campos principais e fallbacks de família. | Instruções insuficientes para iniciantes e lacunas anatómicas. |

## Bugs corrigidos

Nenhum nesta fase. Esta secção será atualizada apenas após teste RED, implementação e teste GREEN.

## Bugs adiados

Nenhum nesta fase. Persistência do PIN e batching de `workouts()` serão implementados se a migração aditiva e os testes SQLite confirmarem segurança. Qualquer adiamento final terá comando, risco e justificação concreta.

## Riscos de regressão

- Migração de exercícios pode quebrar IDs usados por treinos/templates; os IDs existentes não serão recriados.
- Normalização indiscriminada pode alterar texto livre do utilizador; apenas sequências conhecidas e conteúdo de catálogo serão alterados.
- Tornar equipamento estrito pode esconder resultados anteriormente mostrados incorretamente; “Mostrar todos” manterá acesso com razão explícita de indisponibilidade.
- A separação entre exercícios globais e personalizados precisa preservar customs antigos cuja propriedade não possa ser inferida com segurança.
- Alterar taxonomia pode afetar os 208 testes históricos; cada bloco executará os testes antigos relevantes.

## Dívida técnica

`AppDatabase` acumula schema, migrações, seed, perfis, segurança, catálogo, treinos, objetivos, dashboard e exportação. A v0.8.0 não fará refactor total. Serão extraídos apenas a migração v0.8.0 e serviços canónicos necessários para equipamento, taxonomia e normalização.

## Plano futuro de extração

1. Extrair migrações antigas para classes versionadas e testadas isoladamente.
2. Extrair repositórios `ProfileRepository`, `GoalRepository`, `WorkoutRepository` e `ExerciseRepository` mantendo uma transação/facade comum.
3. Introduzir um contexto explícito de perfil ativo em vez de estado mutável dentro da base de dados.
4. Separar seed global de migração de dados do utilizador.
5. Medir queries e tempos com bases grandes antes de novas otimizações.

## Regras de preservação

- Nenhuma tabela de utilizador será apagada.
- Nenhum exercício antigo será removido sem migração/compatibilidade.
- Migrações serão aditivas e idempotentes quando possível.
- Exercícios e templates usarão identidades estáveis.
- Alterações funcionais serão precedidas por teste que falha pelo motivo esperado.
