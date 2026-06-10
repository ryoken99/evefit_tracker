# TEMPLATE_STRING_AUDIT_v0.7.14

## Objetivo

Validar que o catálogo efetivo da EveFit Tracker v0.7.14 não apresenta textos de template/fallback genérico nas descrições, passos de execução, erros comuns ou notas de segurança.

## Fonte verificada

- `lib/services/exercise_catalog_context_service.dart`
- `lib/services/exercise_catalog_detail_service.dart`
- `test/v0714_template_and_hierarchy_test.dart`
- Catálogo efetivo: `ExerciseCatalogContextService.entries`

## Strings proibidas pesquisadas

- `é um exercício ou drill para treinar`
- `Serve para praticar mover a articulação principal`
- `mover a articulação principal de forma controlada no contexto`
- `com o equipamento indicado:`
- `Usa esta amplitude: até onde controlas a ida e o regresso`
- `conforme a articulação principal`
- `Inicia o movimento: mover a articulação principal`
- `Mantém punhos, cotovelos, joelhos ou anca alinhados com a direção do exercício, conforme`
- `desde que mantenhas controlo da zona alvo e pares antes de dor ou perda clara de coordenação`
- `Coloca-te numa base estável para`
- `Segura os halteres com a mão fechada, punhos alinhados e carga perto da linha do movimento`
- `Organiza peito, costelas e bacia para a coluna ficar neutra`
- `Inspira na fase de preparação ou descida e expira na fase de maior esforço`
- `Regressa devagar ao início, mantendo a carga ou o corpo sob controlo até a repetição terminar`
- `Se fores iniciante, reduz carga, alcance ou inclinação até conseguires repetir sem dor e sem balanço`
- `Descrição ainda incompleta`
- `Será melhorado numa próxima versão`
- `Ajusta pés, mãos e carga`
- `Faz o movimento principal`
- `Mantém boa postura`
- `Executa com boa técnica`
- `Amplitude controlada`
- `Movimento lento e previsível`
- `no contexto`
- `articulação principal`
- `equipamento indicado`

## Resultado

| Métrica | Resultado |
| --- | ---: |
| Entradas efetivas verificadas | 305 |
| Exercícios únicos no catálogo | 294 |
| Ocorrências confirmadas antes | 5 |
| Ocorrências corrigidas | 5 |
| Ocorrências restantes no catálogo efetivo | 0 |

## Correções feitas

- Substituída a geração antiga de descrição genérica por descrições pedagógicas específicas por movimento.
- Corrigido o fallback antigo em `exercise_catalog_detail_service.dart` para remover `equipamento indicado` e `articulação principal`.
- Reforçado o teste automático para bloquear as strings curtas `no contexto`, `articulação principal` e `equipamento indicado`.
- Corrigida a ordem de deteção de `Reverse wrist curl` para não herdar texto de `Wrist curl`.

## Teste

- `test/v0714_template_and_hierarchy_test.dart`
- Caso: `catalog has no v0.7.14 prohibited template strings`

Resultado final: **0 ocorrências restantes**.
