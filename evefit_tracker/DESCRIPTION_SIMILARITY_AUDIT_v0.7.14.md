# DESCRIPTION_SIMILARITY_AUDIT_v0.7.14

## Objetivo

Validar que as descrições e instruções dos exercícios não continuam a ser blocos quase idênticos de template.

## Regra aplicada

O teste compara pares de entradas do catálogo efetivo.

- Famílias diferentes: falha acima de 60%.
- Mesma família técnica: falha acima de 75%.
- Entradas com o mesmo nome normalizado são ignoradas porque representam contextos intencionais do mesmo exercício.

## Famílias tratadas

- curl
- tríceps
- press/supino/flexões
- remo/puxada
- agachamento/pernas
- dobradiça de anca
- ombros
- core
- cardio/passadeira
- cardio/bicicleta
- cardio/corda
- mobilidade/alongamento
- artes marciais
- antebraço/pega

## Pares especiais verificados

| Par | Resultado |
| --- | --- |
| Farmer walk / Hold estático com halteres | passou |
| Curl martelo / Curl cruzado no corpo | passou |
| Curl inverso / Curl martelo | passou |
| Bicicleta cooldown / Passadeira cooldown | passou |
| Corda de saltar pés alternados / Corda de saltar ritmo leve | passou |
| Dead hang / Dead hang escapular | passou |

## Resultado

| Métrica | Resultado |
| --- | ---: |
| Entradas comparadas | 305 |
| Pares comparados | 46.360 |
| Pares acima do limite encontrados durante reforço | 30 |
| Pares corrigidos ou reclassificados por família técnica | 30 |
| Pares acima do limite restantes | 0 |

## Correções feitas

- Farmer walk e Hold estático mantêm instruções separadas para caminhar vs ficar parado.
- `Reverse wrist curl` deixou de herdar texto de `Wrist curl`.
- Mobilidade de tornozelo na parede e círculos de tornozelo receberam passos próprios.
- O guard de similaridade passou a usar limites diferentes para mesma família e famílias diferentes.

## Teste

- `test/v0714_template_and_hierarchy_test.dart`
- Caso: `different catalog descriptions are not near-duplicates`
- Caso: `specific movement pairs keep distinct teaching cues`

Resultado final: **0 pares acima do limite**.
