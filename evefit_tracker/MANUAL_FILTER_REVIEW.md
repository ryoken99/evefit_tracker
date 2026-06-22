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

## Perfis simulados

| Código | Perfil | Local | Capacidades usadas |
|---|---|---|---|
| P1 | Casa sem equipamento | Casa | bodyweight, floor, wall |
| P2 | Casa com apoio básico | Casa | P1 + chair_support; stable_step/bench validados como alternativas equivalentes |
| P3 | Casa com halteres | Casa | P1 + dumbbells |
| P4 | Casa com barra/discos | Casa | P1 + barbell, plates |
| P5 | Casa com elásticos | Casa | P1 + bands |
| P6 | Casa com barra fixa | Casa | P1 + pullup_bar |
| P7 | Ginásio completo | Ginásio | bodyweight, floor, wall, pesos, bancos, máquinas, cabos, cardio, barra fixa e paralelas |
| P8 | Exterior | Exterior | bodyweight, floor, outdoor_space |
| P9 | Dojo/Tatami | Dojo / Artes marciais | bodyweight, floor, wall, tatami |

Correções referenciadas na matriz final:

- C1: opções “completo” agregam grupos canónicos antes da validação muscular específica;
- C2: requisitos compostos exigem todas as capacidades físicas necessárias e aceitam alternativas explícitas;
- C3: taxonomia canónica corrigida (músculo principal/secundário, grupo e subgrupo);
- C4: hierarquia de cardio exterior e artes marciais corrigida;
- C5: “Mostrar todos” apresenta a capacidade concreta em falta e a lista vazia explica como a consultar;
- C6: `Sprawl` adicionado como exercício real de condicionamento marcial, elevando o catálogo para 315 entradas;
- C0: caso de controlo ou expectativa manual confirmada sem alteração funcional.

## Matriz final — fonte de verdade

Todas as 93 linhas abaixo têm um teste com o mesmo ID em `test/v080/manual_filter_matrix_test.dart`. “PASS” significa que as inclusões e exclusões nomeadas foram verificadas, não apenas que a lista é não vazia.

### Completos, perfis e capacidades

| ID | Perfil | Local/equipamento | Tipo | Região → grupo → subgrupo/foco | Deve aparecer | Não deve aparecer | Resultado atual | Estado | Correção |
|---|---|---|---|---|---|---|---|---|---|
| BW-CHEST-001 | P1 | Casa / bodyweight | Musculação | Superior → Peito → Peito completo | Flexão clássica; joelhos apoiados; aberta | Supino; cabo; máquina | Lista correta; antes estava vazia | PASS | C1 |
| BW-ARMS-001 | P1 | Casa / bodyweight | Musculação | Superior → Braços → Braços completo | Flexão fechada; diamante | Curl com halter; cabo | Mantido sem regressão | PASS | C0 |
| BW-CORE-001 | P1 | Casa / bodyweight | Musculação | Core → Core completo | Prancha; Crunch; Dead bug; Hollow hold | Pallof no cabo | Lista correta; antes estava vazia | PASS | C1 |
| BW-LEGS-001 | P1 | Casa / bodyweight | Musculação | Inferior → Pernas completo | Agachamento; Lunges; Ponte; Gémeos | Leg press; barra | Lista correta; antes estava vazia | PASS | C1 |
| BW-BACK-001 | P1 | Casa / bodyweight | Musculação | Superior → Costas completo | Good morning sem carga; Superman | Pull-up; remo com halter | Lista correta; antes estava vazia | PASS | C1 |
| BW-SHOULDERS-001 | P1 | Casa / bodyweight | Musculação | Superior → Ombros completo | Pike push-up; Scapular push-up | Press militar com pesos | Lista correta; antes estava vazia | PASS | C1 |
| GYM-CHEST-001 | P7 | Ginásio completo | Musculação | Superior → Peito completo | Flexão; supino barra/halteres; crossover | Remo com barra | Corpo livre e ginásio combinados | PASS | C1 |
| BW-CHEST-002 | P1 | Casa / sem apoio | Musculação | Superior → Peito completo | Flexões no chão | Flexão inclinada/declinada; dips | Apoios indevidos removidos | PASS | C2 |
| SUPPORT-CHEST-001 | P2 | Casa / cadeira | Musculação | Superior → Peito completo | Flexão inclinada | Dips em paralelas | Só o apoio disponível é aceite | PASS | C2 |
| BW-ARMS-002 | P1 | Casa / sem apoio | Musculação | Superior → Braços completo | Flexão fechada; diamante | Fundos; dips | Apoios indevidos removidos | PASS | C2 |
| SUPPORT-ARMS-001 | P2 | Casa / cadeira | Musculação | Superior → Braços completo | Fundos entre apoios | Dips em paralelas | Cadeira não equivale a paralelas | PASS | C2 |
| BW-LEGS-002 | P1 | Casa / sem cadeira | Musculação | Inferior → Pernas completo | Agachamento livre | Agachamento para cadeira; búlgaro apoiado | Apoio obrigatório respeitado | PASS | C2 |
| SUPPORT-LEGS-001 | P2 | Casa / stable_step | Musculação | Inferior → Pernas completo | Step-up | Leg press | Alternativas banco/cadeira/degrau corrigidas | PASS | C2 |
| BW-BACK-002 | P1 | Casa / sem barra fixa | Musculação | Superior → Costas largura | Trabalho compatível sem barra | Pull-up; Scapular pull-up | Barra fixa não é inferida | PASS | C0 |
| PULLUP-BACK-001 | P6 | Casa / barra fixa | Musculação | Superior → Costas largura | Pull-up; Scapular pull-up | Puxada alta | Barra fixa ativa só exercícios compatíveis | PASS | C2 |

### Peito, costas e ombros

| ID | Perfil | Local/equipamento | Tipo | Região → grupo → subgrupo/foco | Deve aparecer | Não deve aparecer | Resultado atual | Estado | Correção |
|---|---|---|---|---|---|---|---|---|---|
| GYM-CHEST-UPPER-001 | P7 | Ginásio | Musculação | Superior → Peito → superior | Supino inclinado barra/halteres | Remo com barra | Foco superior correto | PASS | C0 |
| GYM-CHEST-MID-001 | P7 | Ginásio | Musculação | Superior → Peito → médio | Supino com barra; Flexão clássica | Remo sentado | Foco médio correto | PASS | C0 |
| GYM-CHEST-LOWER-001 | P7 | Ginásio | Musculação | Superior → Peito → inferior | Supino declinado; dips peito | Curl com barra | Foco inferior correto | PASS | C0 |
| BW-CHEST-SERRATUS-001 | P1 | Casa / bodyweight | Musculação | Superior → Peito → serrátil | Scapular push-up | Supino com barra | Serrátil isolado de presses | PASS | C0 |
| GYM-BACK-WIDTH-001 | P7 | Ginásio | Musculação | Superior → Costas → largura | Pull-up; Puxada alta | Remo com barra | Puxadas sem remadas | PASS | C0 |
| GYM-BACK-THICKNESS-001 | P7 | Ginásio | Musculação | Superior → Costas → espessura | Remo barra/halter | Pull-up | Remadas sem puxadas verticais | PASS | C0 |
| GYM-BACK-LATS-001 | P7 | Ginásio | Musculação | Superior → Costas → dorsal | Puxada alta; Pull-up | Tríceps no cabo | Dorsal correto | PASS | C0 |
| GYM-BACK-RHOMBOIDS-001 | P7 | Ginásio | Musculação | Superior → Costas → romboides | Remo sentado; reverse fly | Supino com barra | Retração escapular correta | PASS | C0 |
| BW-BACK-LOWER-001 | P1 | Casa / bodyweight | Musculação | Superior → Costas → lombar | Superman isométrico | Banco romano | Banco romano deixou de ser bodyweight | PASS | C2/C3 |
| GYM-SHOULDER-ANTERIOR-001 | P7 | Ginásio | Musculação | Superior → Ombros → deltoide anterior | Press militar; elevação frontal | Reverse fly | Deltoide anterior correto | PASS | C0 |
| GYM-SHOULDER-LATERAL-001 | P7 | Ginásio | Musculação | Superior → Ombros → deltoide lateral | Elevação lateral | Curl com barra | Deltoide lateral correto | PASS | C0 |
| GYM-SHOULDER-POSTERIOR-001 | P7 | Ginásio | Musculação | Superior → Ombros → deltoide posterior | Reverse fly; face pull | Elevação frontal | Deltoide posterior correto | PASS | C0 |
| GYM-SHOULDER-CUFF-001 | P7 | Ginásio | Musculação | Superior → Ombros → manguito externo | Rotação externa/cabo | Elevação lateral | Rotadores externos corretos | PASS | C0 |
| BW-SHOULDER-SCAPULA-001 | P1 | Casa / parede | Musculação | Superior → Ombros → controlo escapular | Scapular push-up; Wall slides | Press militar barra | Parede e peso corporal respeitados | PASS | C2 |

### Braços, antebraço, punho e mão

| ID | Perfil | Local/equipamento | Tipo | Região → grupo → subgrupo/foco | Deve aparecer | Não deve aparecer | Resultado atual | Estado | Correção |
|---|---|---|---|---|---|---|---|---|---|
| DB-ARMS-BICEPS-001 | P3 | Casa / halteres | Musculação | Superior → Braços → bíceps | Curl halteres; alternado | Curl no cabo | Halteres isolados do cabo | PASS | C2 |
| DB-ARMS-BRACHIALIS-001 | P3 | Casa / halteres | Musculação | Superior → Braços → braquial | Curl martelo | Extensão de tríceps | Braquial correto | PASS | C0 |
| DB-ARMS-BRACHIORADIALIS-001 | P3 | Casa / halteres | Musculação | Superior → Braços → braquiorradial | Curl martelo; inverso | Tríceps testa | Braquiorradial correto | PASS | C0 |
| GYM-TRICEPS-COMPLETE-001 | P7 | Ginásio | Musculação | Superior → Braços → tríceps completo | Francesa; cabo; corda | Curl barra | Três padrões de extensão | PASS | C1 |
| GYM-TRICEPS-LONG-001 | P7 | Ginásio | Musculação | Superior → Braços → cabeça longa | Extensão acima da cabeça | Curl barra | Cabeça longa correta | PASS | C0 |
| GYM-TRICEPS-LATERAL-001 | P7 | Ginásio | Musculação | Superior → Braços → cabeça lateral | Extensão no cabo | Curl barra | Cabeça lateral correta | PASS | C0 |
| GYM-TRICEPS-MEDIAL-001 | P7 | Ginásio | Musculação | Superior → Braços → cabeça medial | Pressdown controlado | Curl barra | Cabeça medial correta | PASS | C0 |
| GYM-FOREARM-COMPLETE-001 | P7 | Ginásio | Musculação | Superior → Antebraço → completo | Wrist/reverse curl; pronação; supinação; Farmer hold | Tríceps cabo | Conjunto completo sem tríceps | PASS | C1 |
| GYM-FOREARM-FLEXORS-001 | P7 | Ginásio | Musculação | Superior → Antebraço → flexores | Wrist curl | Reverse wrist curl | Reverse curl deixou de herdar flexores | PASS | C3 |
| GYM-FOREARM-EXTENSORS-001 | P7 | Ginásio | Musculação | Superior → Antebraço → extensores | Reverse wrist curl | Wrist curl | Extensores corretos | PASS | C3 |
| GYM-FOREARM-PRONATION-001 | P7 | Ginásio | Musculação | Superior → Antebraço → pronação | Pronação com halter | Supinação | Movimento correto | PASS | C0 |
| GYM-FOREARM-SUPINATION-001 | P7 | Ginásio | Musculação | Superior → Antebraço → supinação | Supinação com halter | Pronação | Movimento correto | PASS | C0 |
| GYM-FOREARM-WRIST-001 | P7 | Ginásio | Musculação | Superior → Antebraço → punho | Wrist curl; desvio radial | Tríceps | Punho correto | PASS | C0 |
| GYM-FOREARM-FINGERS-001 | P7 | Ginásio | Musculação | Superior → Antebraço → dedos | Finger curls; pinch grip | Supino | Dedos corretos | PASS | C0 |
| GYM-GRIP-001 | P7 | Ginásio | Musculação | Superior → Antebraço → força de pega | Farmer hold; plate pinch | Tríceps cabo | Pega correta | PASS | C0 |

### Core e membros inferiores

| ID | Perfil | Local/equipamento | Tipo | Região → grupo → subgrupo/foco | Deve aparecer | Não deve aparecer | Resultado atual | Estado | Correção |
|---|---|---|---|---|---|---|---|---|---|
| BW-CORE-ABS-001 | P1 | Casa / bodyweight | Musculação | Core → abdominal | Crunch | Crunch no cabo | Abdominal sem equipamento | PASS | C0 |
| BW-CORE-OBLIQUES-001 | P1 | Casa / bodyweight | Musculação | Core → oblíquos | Prancha lateral; Russian twist | Pallof cabo | Prancha lateral recuperada | PASS | C3 |
| BW-CORE-TRANSVERSE-001 | P1 | Casa / bodyweight | Musculação | Core → transverso | Vacuum abdominal | Side bend | Transverso correto | PASS | C0 |
| BANDS-CORE-ANTIROTATION-001 | P5 | Casa / elásticos | Musculação | Core → anti-rotação | Pallof com elástico | Pallof cabo | Elástico não equivale a cabo | PASS | C2 |
| BW-CORE-ANTIEXTENSION-001 | P1 | Casa / bodyweight | Musculação | Core → anti-extensão | Prancha; Hollow hold | Pallof | Anti-extensão correta | PASS | C0 |
| BW-CORE-STABILITY-001 | P1 | Casa / bodyweight | Musculação | Core → estabilidade profunda | Dead bug; Bird dog | Side bend | Bird dog reclassificado | PASS | C3 |
| BW-CORE-LOWERBACK-001 | P1 | Casa / bodyweight | Musculação | Core → lombar | Hiperextensão chão; Superman | Banco romano | Região core/lombar corrigida | PASS | C2/C3 |
| BW-CORE-ANTILATERAL-001 | P1 | Casa / bodyweight | Musculação | Core → anti-flexão lateral | Prancha lateral | Side bend | Movimento ativo removido do foco anti | PASS | C3 |
| BW-LEGS-GLUTES-COMPLETE-001 | P1 | Casa / bodyweight | Musculação | Inferior → Glúteos completo | Ponte; abdução deitada | Leg press | Glúteos completos corretos | PASS | C1/C3 |
| BW-LEGS-GLUTEMAX-001 | P1 | Casa / bodyweight | Musculação | Inferior → glúteo máximo | Ponte de glúteo | Abdução máquina | Glúteo máximo correto | PASS | C0 |
| BW-LEGS-GLUTEMED-001 | P1 | Casa / bodyweight | Musculação | Inferior → glúteo médio/mínimo | Abdução deitada | Leg press | Relação abdutores/glúteos corrigida | PASS | C3 |
| BW-LEGS-QUADS-001 | P1 | Casa / bodyweight | Musculação | Inferior → quadríceps | Agachamento | Curl de perna | Quadríceps correto | PASS | C0 |
| BB-LEGS-QUADS-001 | P4 | Casa / barra e discos | Musculação | Inferior → quadríceps | Agachamento com barra | Leg press | Barra sem máquina | PASS | C2 |
| DB-LEGS-QUADS-001 | P3 | Casa / halteres | Musculação | Inferior → quadríceps | Agachamento goblet | Leg press | Halteres sem máquina | PASS | C2 |
| BW-LEGS-HAMSTRINGS-001 | P1 | Casa / bodyweight | Musculação | Inferior → posterior de coxa | Good morning sem carga | Curl máquina | Posterior sem máquina | PASS | C0 |
| GYM-LEGS-ADDUCTORS-001 | P7 | Ginásio | Musculação | Inferior → adutores | Adução de anca | Abdução de anca | Adução/abdução separadas | PASS | C0 |
| BW-LEGS-ABDUCTORS-001 | P1 | Casa / bodyweight | Musculação | Inferior → abdutores | Abdução deitada | Adução máquina | Opção doméstica recuperada | PASS | C3 |
| BANDS-LEGS-HIPFLEXORS-001 | P5 | Casa / elásticos | Musculação | Inferior → flexores da anca | Flexão da anca com elástico | Leg press | Grupo/subgrupo criado | PASS | C3 |
| BW-LEGS-CALVES-001 | P1 | Casa / bodyweight | Musculação | Inferior → gémeos | Gémeos em pé | Gémeos sentado máquina | Gémeos corretos | PASS | C0 |
| GYM-LEGS-SOLEUS-001 | P7 | Ginásio | Musculação | Inferior → sóleo | Sóleo sentado | Agachamento barra | Sóleo correto | PASS | C0 |
| BW-LEGS-TIBIAL-001 | P1 | Casa / parede | Musculação | Inferior → tibial anterior | Elevação tibial | Gémeos sentado | Parede obrigatória e grupo corrigido | PASS | C2/C3 |
| BW-LEGS-FEET-001 | P1 | Casa / bodyweight | Musculação | Inferior → pés/dedos | Short foot; flexão dos dedos | Leg press | Grupo de pés criado | PASS | C3 |
| BANDS-LEGS-ANKLE-001 | P5 | Casa / elásticos | Musculação | Inferior → tornozelo | Inversão; eversão com elástico | Leg press | Grupo de tornozelo criado | PASS | C3 |

### Cardio, mobilidade e artes marciais

| ID | Perfil | Local/equipamento | Tipo | Região → grupo → subgrupo/foco | Deve aparecer | Não deve aparecer | Resultado atual | Estado | Correção |
|---|---|---|---|---|---|---|---|---|---|
| GYM-CARDIO-COMPLETE-001 | P7 | Ginásio completo | Cardio | Cardio → completo | Passadeira; bicicleta; elíptica; HIIT | Supino | Modalidades instaladas combinadas | PASS | C0 |
| GYM-CARDIO-TREADMILL-001 | P7 | Ginásio / passadeira | Cardio | Cardio → passadeira | Caminhada; corrida; intervalos | Bicicleta | Modalidade isolada | PASS | C0 |
| GYM-CARDIO-BIKE-001 | P7 | Ginásio / bicicleta | Cardio | Cardio → bicicleta | Ritmo leve/moderado | Passadeira | Modalidade isolada | PASS | C0 |
| GYM-CARDIO-ELLIPTICAL-001 | P7 | Ginásio / elíptica | Cardio | Cardio → elíptica | Ritmo leve/resistência | Bicicleta | Modalidade isolada | PASS | C0 |
| ROPE-CARDIO-001 | P1 + corda | Casa / jump_rope | Cardio | Cardio → corda | Ritmo leve; intervalos | Passadeira | Corda canónica selecionada | PASS | C2 |
| OUT-CARDIO-WALK-001 | P8 | Exterior | Cardio | Cardio → caminhada exterior | Caminhada leve | Passadeira | Caminhada separada da corrida | PASS | C4 |
| OUT-CARDIO-RUN-001 | P8 | Exterior | Cardio | Cardio → corrida exterior | Corrida leve | Passadeira | Corrida exterior correta | PASS | C4 |
| OUT-CARDIO-SPRINT-001 | P8 | Exterior | Cardio | Cardio → sprints | Sprints exterior | Passadeira intervalos | Subgrupo de sprints criado | PASS | C4 |
| BW-CARDIO-HIIT-001 | P1 | Casa / bodyweight | Cardio | Cardio → HIIT | HIIT simples; Jumping jacks | Passadeira | HIIT sem máquinas | PASS | C0 |
| BW-MOBILITY-COMPLETE-001 | P1 | Casa / bodyweight | Mobilidade | Mobilidade → completa | Ombro; 90/90; tornozelo; punhos | Supino | Várias regiões sem equipamento | PASS | C0 |
| BW-MOBILITY-SHOULDER-001 | P1 | Casa | Mobilidade | Mobilidade → ombro | Mobilidade de ombro | Press militar | Mobilidade correta | PASS | C0 |
| BW-MOBILITY-THORACIC-001 | P1 | Casa | Mobilidade | Mobilidade → torácica | Open book; Cat-cow | Remo barra | Mobilidade correta | PASS | C0 |
| BW-MOBILITY-HIP-001 | P1 | Casa | Mobilidade | Mobilidade → anca | Mobilidade 90/90 | Leg press | Mobilidade correta | PASS | C0 |
| BW-MOBILITY-ANKLE-001 | P1 | Casa / parede | Mobilidade | Mobilidade → tornozelo | Mobilidade na parede | Leg press | Mobilidade correta | PASS | C0 |
| BW-MOBILITY-WRIST-001 | P1 | Casa | Mobilidade | Mobilidade → punho | Mobilidade de punhos | Wrist curl pesado | Mobilidade correta | PASS | C0 |
| BW-MOBILITY-NECK-001 | P1 | Casa | Mobilidade | Mobilidade → pescoço | Alongamento cervical leve | Encolhimento barra | Mobilidade correta | PASS | C0 |
| BW-MOBILITY-RECOVERY-001 | P1 | Casa | Mobilidade | Mobilidade → alongamento/recuperação | Alongamento peitoral | Supino | Alongamento sem equipamento | PASS | C0 |
| DOJO-KARATE-001 | P9 | Dojo / tatami | Artes marciais | Artes marciais → Karate | Kihon; Sombra de Karate | Supino | Karate correto | PASS | C0 |
| DOJO-JIUJITSU-001 | P9 | Dojo / tatami | Artes marciais | Artes marciais → Jiu-Jitsu | Shrimp; Technical stand-up | Leg press | Jiu-Jitsu correto | PASS | C0 |
| DOJO-CONDITIONING-001 | P9 | Dojo / tatami | Artes marciais | Artes marciais → condicionamento | Condicionamento Karate; Sprawl | Supino | `Sprawl` e grupo corrigidos | PASS | C4/C6 |
| DOJO-MOBILITY-001 | P9 | Dojo / tatami | Artes marciais | Artes marciais → mobilidade | Mobilidade anca Karate/Jiu-Jitsu | Supino | Grupo marcial correto | PASS | C4 |
| DOJO-CORE-001 | P9 | Dojo / tatami | Artes marciais | Artes marciais → core | Core para Jiu-Jitsu | Crunch no cabo | Grupo marcial criado | PASS | C4 |
| DOJO-GRIP-001 | P9 | Dojo / tatami | Artes marciais | Artes marciais → pega/grappling | Força de pega Jiu-Jitsu | Wrist curl | Pega marcial separada | PASS | C4 |
| SHOWALL-BACK-001 | P1 | Casa / sem barra | Musculação | Superior → Costas largura → Mostrar todos | Pull-up indisponível com “Barra fixa” | Aviso genérico | Razão concreta apresentada | PASS | C5 |
| SHOWALL-ANATOMY-001 | P1 | Casa | Musculação | Superior → Costas largura → Mostrar todos | Flexão marcada como incompatível anatomicamente | Razão de equipamento | Causa anatómica preservada | PASS | C0 |
| EMPTY-STATE-001 | Todos | Qualquer | Todos | Lista sem resultados | Instrução para ativar Mostrar todos e ver capacidade em falta | Mensagem vaga | Mensagem acionável | PASS | C5 |

## Resultado quantitativo

- combinações revistas manualmente e convertidas em testes: **93**;
- combinações que revelaram defeito funcional antes da correção: **30**;
- casos em que o primeiro texto esperado usava um nome inexato do catálogo, sem defeito funcional: **9**;
- estado final: **93 PASS, 0 FAIL**;
- catálogo final: **315 entradas / 309 nomes únicos**.

## Validação visual Android

Executada num Pixel 7 virtual, Android API 36 (`google_apis`, x86_64), com a app instalada em modo debug e base SQLite real.

- Criado o perfil `CasaPixel` com local `Casa` e `Nenhum equipamento`; o catálogo manteve apenas capacidades domésticas implícitas (`bodyweight`, chão e parede).
- Criado um treino `Peito completo`; a lista real de adição mostrou `Scapular push-up`, `Flexão aberta`, `Flexão arqueiro`, `Flexão clássica` e `Flexão com joelhos apoiados`, sem máquinas, cabos, halteres ou barras.
- `Flexão clássica` foi adicionada e o detalhe atualizou para 1 exercício sem falha de refresh.
- Criado um treino `Braços completos`; a lista doméstica manteve `Flexão diamante` e `Flexão fechada`, confirmando que o agregado não fica vazio quando não existe equipamento de puxada.
- Reinício e desbloqueio por PIN foram repetidos; o perfil, equipamento e treinos persistiram.
- A revisão visual revelou dois defeitos de ciclo de vida que os testes de filtro não expunham: callbacks de `setState` que devolviam `Future` e descarte prematuro do controlador do PIN. Ambos foram corrigidos e receberam testes de regressão.
- Após recompilar, desbloqueio, criação, gravação, refresh e adição de exercício decorreram sem exceções Flutter.

As capturas representativas `BW-CHEST-001.png` e `BW-ARMS-001.png` foram produzidas localmente em `build/visual-validation/`; a matriz automatizada acima cobre adicionalmente core, pernas, costas, ombros, ginásio, cardio, mobilidade e dojo.
