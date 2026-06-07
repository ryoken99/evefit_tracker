# EveFit Tracker - Filter Mapping Audit v0.7.6

Data: 2026-06-07

## Objetivo

Garantir que cada exercício aparece apenas onde faz sentido para:

1. tipo de treino;
2. equipamento escolhido;
3. região;
4. grupo;
5. subzona;
6. músculo/foco;
7. equipamento/local disponível no perfil.

## Causa raiz corrigida

Em v0.7.5, `TrainingArchitecture.tagsForExercise` montava a inferência anatómica com:

- nome do exercício;
- grupo principal;
- músculos secundários;
- equipamento.

Isto fazia com que exercícios principais de peito, como `Supino com halteres`, ganhassem tag de braços porque os secundários continham `tríceps`.

Na v0.7.6 a lógica foi separada:

- `primaryHaystack`: nome + grupo principal + equipamento;
- `detailHaystack`: nome + grupo principal + secundários + equipamento.

Musculação, cardio e artes marciais usam `primaryHaystack` para tags estruturais.
Mobilidade usa `detailHaystack` porque o campo de secundários descreve a zona/foco do alongamento.

## Regras finais

| Área | Regra final | Ficheiro |
|---|---|---|
| Musculação | Filtro anatómico usa foco primário, não secundário | `lib/services/training_architecture.dart` |
| Braços completo | Mostra bíceps, tríceps e antebraço primários; não mostra peito por tríceps secundário | `training_architecture.dart`, `exercise_filter_service.dart` |
| Bíceps peso corporal | Não mostra flexões sem barra fixa/elásticos/halteres | `exercise_filter_service.dart` |
| Tríceps peso corporal | Mostra flexões fechadas e variações de tríceps | `training_architecture.dart` |
| Peito | Exclui `supino fechado`, `flexões fechadas` e `flexões diamante` do grupo peito por defeito | `training_architecture.dart` |
| Mobilidade | Glúteos/posterior/peitoral/dorsal/pescoço/etc. têm tags por zona | `training_architecture.dart`, `training_flow.dart` |
| Cardio passadeira | Resistência aeróbia exclui HIIT/sprints; intervalos inclui HIIT/corrida intervalada/sprints | `exercise_filter_service.dart`, `training_flow.dart` |
| Equipamento | Face pull elástico e cabo são variantes separadas | `app_database.dart`, `seed_data.dart` |
| Recuperação | Alongamentos leves mostram exercícios sem equipamento por foco `light_stretching` | `training_flow.dart`, `exercise_filter_service.dart` |

## Exemplos testados

| ID | Caminho | Resultado esperado | Estado |
|---|---|---|---|
| MAP-001 | Musculação -> Halteres -> Parte superior -> Braços -> Braços completo | Mostra curls, tríceps e antebraço; não mostra supino | PASSOU |
| MAP-002 | Musculação -> Peso corporal -> Braços -> Bíceps braquial | Não mostra flexões | PASSOU |
| MAP-003 | Musculação -> Peso corporal -> Braços -> Tríceps | Mostra flexões fechadas | PASSOU |
| MAP-004 | Mobilidade -> Glúteos | Mostra alongamento glúteos, figura 4 e mobilidade 90/90 | PASSOU |
| MAP-005 | Mobilidade -> Posterior de coxa | Mostra alongamento posterior e mobilidade dinâmica de posterior | PASSOU |
| MAP-006 | Cardio -> Passadeira -> Resistência aeróbia | Mostra caminhada/inclinação leve; não mostra HIIT | PASSOU |
| MAP-007 | Cardio -> Passadeira -> Intervalos | Mostra corrida intervalada, sprints e HIIT passadeira | PASSOU |
| MAP-008 | Face pull com elástico | Usa equipamento `Elásticos` / key `bands` | PASSOU |
| MAP-009 | Face pull no cabo | Usa equipamento `Cabo alto / polia` / key `high_cable` | PASSOU |
| MAP-010 | Encolhimentos | Variações com halteres, barra e máquina | PASSOU |

## Alterações de código

- `lib/services/training_architecture.dart`
  - separação entre mapeamento primário e detalhe;
  - exceções para não classificar supino fechado/flexões fechadas/flexões diamante como peito;
  - tags de mobilidade por glúteos, posterior de coxa, quadríceps, peitoral, dorsal, gémeos, pescoço, punhos e recuperação ativa;
  - tags para cardio sem equipamento.

- `lib/services/training_flow.dart`
  - labels adicionadas para `Quadríceps` e `Punhos` em mobilidade.

- `lib/database/seed_data.dart`
  - catálogo expandido em mobilidade, cardio sem equipamento, variações de ombro/trapézio/pescoço;
  - `Encolhimento de ombros na máquina` adicionado;
  - `Passadeira inclinação moderada` e `Passadeira sprints` adicionados.

- `lib/database/app_database.dart`
  - migração v11/v0.7.6;
  - metadata e descrições atualizadas para exercícios padrão;
  - equipamento de `Face pull no cabo` separado de `Face pull com elástico`.

- `lib/screens/workout_detail_screen.dart`
  - placeholder visual removido.

## Testes criados

Ficheiro: `test/v076_exercise_catalog_quality_test.dart`

Testes incluídos:

- Supino com halteres não aparece em Braços completo.
- Braços completo mostra bíceps, tríceps e antebraço.
- Bíceps com peso corporal sem barra fixa não mostra flexões.
- Tríceps com peso corporal mostra flexões fechadas.
- Mobilidade Glúteos mostra alongamentos de glúteos.
- Mobilidade Posterior de coxa mostra alongamentos de posterior.
- Cardio Passadeira Resistência não mostra HIIT.
- Cardio Passadeira Intervalos mostra HIIT/corrida intervalada.
- Face pull com elástico usa `Elásticos`.
- Face pull no cabo usa cabo/polia.
- Shrugs têm equipamento explícito.
- Nenhum placeholder proibido permanece nos ficheiros de produção testados.

## Resultado da validação

- `flutter pub get`: OK
- `flutter analyze`: OK, sem issues
- `flutter test`: OK, 130 testes passados
- `flutter build apk --release`: OK
- APK confirmado: `build/app/outputs/flutter-apk/app-release.apk`

## Limitações conhecidas

- Os filtros continuam baseados em regras de texto normalizado e metadata textual. Isto é compatível com a arquitetura atual, mas a solução ideal de longo prazo seria preencher `exercise_focus_map` e `exercise_muscles` com dados estruturados por exercício.
- A v0.7.6 não altera o fluxo de criação de treino, apenas corrige catálogo, mapeamento e explicações.
