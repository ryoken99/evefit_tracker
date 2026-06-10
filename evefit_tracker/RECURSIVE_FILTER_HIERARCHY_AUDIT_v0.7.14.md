# RECURSIVE_FILTER_HIERARCHY_AUDIT_v0.7.14

## Objetivo

Validar que filtros `completo` agregam os filhos diretos e indiretos do ramo anatómico antes de aplicar equipamento.

## Filtros auditados

| Filtro | Estado |
| --- | --- |
| Braços completo | corrigido e validado |
| Braquial | corrigido e validado |
| Pernas completo | validado |
| Costas completo | validado |
| Ombros completo | validado |
| Peito completo | corrigido e validado |
| Core completo | validado |

## Correções feitas

- `Braços completo` no modal de adicionar exercício agora expõe filtros contextuais para bíceps, braquial, braquiorradial, tríceps, flexores/extensores do antebraço, punho, mão/dedos e força de pega.
- `Braquial` com halteres exclui finger curls, wrist curl, reverse wrist curl, tríceps, peito e ombros.
- `Peito completo` recebeu metadata explícita para `Serrátil anterior` via `Scapular push-up`.
- O equipamento é aplicado depois da seleção anatómica no teste de regressão.

## Resultado

| Métrica | Resultado |
| --- | --- |
| Lógica recursiva/árvore explícita validada | sim |
| Listas hardcoded incompletas substituídas para Braços completo | sim |
| Testes de hierarquia criados/reforçados | sim |
| Testes de hierarquia passados | sim |

## Exemplos validados

- Braços completo + Halteres inclui curls, extensões de tríceps, wrist curl, reverse wrist curl, pronação, supinação, desvios do punho, farmer walk e hold estático.
- Braços completo + Halteres não inclui supino, aberturas, elevação lateral, agachamento, passadeira ou bicicleta.
- Pernas completo inclui quadríceps, posterior de coxa, glúteos, adutores, abdutores, gémeos, sóleo e tibial anterior.
- Costas completo inclui puxadas, remadas e lombar sem misturar curls ou supinos.
- Core completo inclui abdominal, oblíquos, transverso/lombar/estabilidade sem misturar tríceps.

## Teste

- `test/v0714_template_and_hierarchy_test.dart`

Resultado final: **todos os testes de hierarquia passaram**.
