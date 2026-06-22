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
| BW-CHEST-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Superior | Peito | Peito completo | Flexão clássica; Flexão com joelhos apoiados; Flexão aberta | Supino; cabo; máquina; halteres | Lista vazia com exercícios persistidos/enriquecidos | FAIL | Pendente: agregação canónica de `chest_complete` |
| BW-ARMS-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Superior | Braços | Braços completo | Flexão diamante; Flexões fechadas | Curls; cabo; halteres | Exercícios diretos de tríceps aparecem | PASS | Nenhuma; caso de controlo que não pode regredir |
| BW-CORE-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Core | Core | Core completo | Prancha; Crunch; Dead bug; Hollow hold | Pallof no cabo; crunch em máquina | Lista vazia com exercícios persistidos/enriquecidos | FAIL | Pendente: agregação canónica de `core_complete` |
| BW-LEGS-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Inferior | Pernas | Pernas completo | Agachamento com peso corporal; Lunges; Ponte de glúteo; Gémeos em pé | Leg press; halteres; barra | Lista vazia com exercícios persistidos/enriquecidos | FAIL | Pendente: agregação canónica de `legs_complete` |
| BW-BACK-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Superior | Costas | Costas completo | Superman; trabalho lombar sem carga | Pull-up; chin-up; cabo; máquina; halteres | Lista vazia com exercícios persistidos/enriquecidos | FAIL | Pendente: agregação canónica de `back_complete` |
| BW-SHOULDERS-001 | Casa sem equipamento | Casa | bodyweight, floor, wall | Musculação | Superior | Ombros | Ombros completo | Pike push-up; controlo escapular compatível | Press militar com barra/halteres; máquina | Lista vazia com exercícios persistidos/enriquecidos | FAIL | Pendente: agregação canónica de `shoulders_complete` |

## Validação visual Android

Ainda não executada. O ambiente inicial não tinha dispositivo Android nem AVD instalado; apenas Chrome e Edge estavam disponíveis.

