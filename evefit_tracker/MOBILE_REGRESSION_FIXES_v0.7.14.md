# MOBILE_REGRESSION_FIXES_v0.7.14

## Regressões confirmadas no telemóvel

| Regressão | Estado |
| --- | --- |
| Farmer walk com texto template | corrigido |
| Hold estático com halteres com texto quase igual ao Farmer walk | corrigido |
| Braço completo sem Braquial/Braquiorradial/pega/punho/mão | corrigido |
| Braquial com halteres misturava antebraço ou tríceps em filtros errados | corrigido |

## Farmer walk

Validação:

- menciona caminhar
- menciona passos
- menciona cargas/halteres ao lado do corpo
- menciona não deixar a carga bater/balançar
- diferencia a ação de carregar em deslocamento

Estado final: **corrigido**.

## Hold estático com halteres

Validação:

- menciona ficar parado
- menciona posição imóvel
- menciona tempo de hold
- não é tratado como caminhada

Estado final: **corrigido**.

## Braços completo

Validação:

- inclui bíceps
- inclui braquial
- inclui braquiorradial
- inclui tríceps
- inclui flexores/extensores do antebraço
- inclui punho
- inclui mão/dedos
- inclui força de pega
- exclui supino, aberturas, elevação lateral, agachamento, passadeira e bicicleta

Estado final: **corrigido**.

## Braquial

Validação:

- inclui Curl martelo
- inclui Curl inverso com halteres
- inclui Curl Zottman
- inclui Curl cruzado no corpo
- exclui Finger curls, Wrist curl, Reverse wrist curl, Extensão francesa, Kickback de tríceps, Supino, Aberturas e Elevação lateral

Estado final: **corrigido**.

## Teste

- `test/v0714_template_and_hierarchy_test.dart`

Resultado final: **regressões do telemóvel cobertas por teste automático**.
