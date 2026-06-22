# Revisão manual de filtros — v0.8.0 build 82

Data: 2026-06-22

## Método

Cada linha é decidida manualmente a partir da anatomia principal, dos suportes físicos realmente necessários e do local/equipamento do perfil. Ferramentas apenas listam o resultado atual; não atribuem PASS/FAIL. Um PASS exige que as inclusões representativas apareçam e que as exclusões explícitas não apareçam.

Capacidades base da revisão:

- casa sem equipamento: `bodyweight`, `floor`, `wall`;
- apoios só existem quando selecionados: cadeira, degrau, mesa resistente ou banco;
- barra fixa, paralelas, pesos, cabos, máquinas e cardio mecânico nunca são inferidos numa casa vazia;
- exterior acrescenta espaço exterior, não equipamento de ginásio;
- dojo acrescenta tatami e contexto de artes marciais.

## Matriz — reprodução inicial

| ID | Perfil | Local | Equipamento disponível | Tipo | Região | Grupo | Subgrupo/foco | Deve aparecer | Não deve aparecer | Resultado atual antes da correção | Estado inicial | Correção aplicada |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| BW-CHEST-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Superior | Peito | Peito completo | Flexão clássica; Flexão com joelhos apoiados; Flexão aberta | Supino; cabo; máquina; halteres | Lista vazia com exercícios persistidos/enriquecidos | FAIL | `chest_complete` passou a agregar tags canónicas antes da rejeição muscular individual |
| BW-ARMS-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Superior | Braços | Braços completo | Flexão diamante; Flexões fechadas | Curls; cabo; halteres | Exercícios diretos de tríceps aparecem | PASS | Nenhuma; caso de controlo que não pode regredir |
| BW-CORE-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Core | Core | Core completo | Prancha; Crunch; Dead bug; Hollow hold | Pallof no cabo; crunch em máquina | Lista vazia com exercícios persistidos/enriquecidos | FAIL | Agregação canónica de `core_complete` aplicada antes da rejeição individual |
| BW-LEGS-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Inferior | Pernas | Pernas completo | Agachamento com peso corporal; Lunges; Ponte de glúteo; Gémeos em pé | Leg press; halteres; barra | Lista vazia com exercícios persistidos/enriquecidos | FAIL | Agregação canónica de `legs_complete` aplicada antes da rejeição individual |
| BW-BACK-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Superior | Costas | Costas completo | Superman; trabalho lombar sem carga | Pull-up; chin-up; cabo; máquina; halteres | Lista vazia com exercícios persistidos/enriquecidos | FAIL | Agregação canónica de `back_complete` aplicada antes da rejeição individual |
| BW-SHOULDERS-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Superior | Ombros | Ombros completo | Pike push-up; controlo escapular compatível | Press militar com barra/halteres; máquina | Lista vazia com exercícios persistidos/enriquecidos | FAIL | Agregação canónica de `shoulders_complete` aplicada antes da rejeição individual |

## Matriz — capacidades e apoios

| ID | Perfil | Local | Equipamento disponível | Tipo | Foco | Deve aparecer | Não deve aparecer | Resultado antes da correção | Estado inicial | Correção aplicada |
|---|---|---|---|---|---|---|---|---|---|---|
| BW-CHEST-002 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Peito completo | Flexões sem apoio | Flexão inclinada; Flexão declinada; dips | Inclinação/declinação passavam pela tag bodyweight | FAIL | Requisitos compostos exigem um apoio estável além de bodyweight |
| SUPPORT-CHEST-001 | Casa com apoio básico | Casa | bodyweight, floor, wall, chair_support | Musculação | Peito completo | Flexão inclinada | Dips em paralelas | O suporte não era tratado como alternativa canónica | FAIL | Grupo alternativo aceita cadeira/degrau/mesa/banco, mas não paralelas |
| BW-ARMS-002 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Braços completo | Flexão fechada; Flexão diamante | Fundos entre apoios; dips em paralelas | Fundos entre apoios passavam por bodyweight | FAIL | Fundos exigem apoio; dips exigem paralelas |
| SUPPORT-ARMS-001 | Casa com apoio básico | Casa | bodyweight, floor, wall, chair_support | Musculação | Braços completo | Fundos entre apoios | Dips em paralelas | Apoio e paralelas não eram distinguidos | FAIL | Requisitos separados para apoio doméstico e paralelas |
| BW-LEGS-002 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Pernas completo | Agachamento livre | Agachamento para cadeira; búlgaro com apoio | Cadeira/apoio passavam por bodyweight | FAIL | Cadeira/banco são capacidades obrigatórias nas variações apoiadas |
| BW-BACK-002 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Costas largura | Trabalho sem barra compatível | Pull-up; Scapular pull-up | Barra fixa já era respeitada | PASS | Caso de controlo |
| PULLUP-BACK-001 | Casa com barra fixa | Casa | bodyweight, floor, wall, pullup_bar | Musculação | Costas largura | Pull-up; Scapular pull-up | Puxada alta de máquina/cabo | Barra fixa já ativava puxadas próprias | PASS | Caso de controlo |

## Validação visual Android

Ainda não executada. O ambiente inicial não tinha dispositivo Android nem AVD instalado; apenas Chrome e Edge estavam disponíveis.
