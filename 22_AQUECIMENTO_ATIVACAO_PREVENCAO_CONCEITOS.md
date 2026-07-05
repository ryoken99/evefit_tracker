# 22 - Aquecimento, ativação e prevenção: conceitos

## Objetivo

Este ficheiro separa três domínios que muitas apps misturam:

```text
Aquecimento = preparar o corpo para o treino que vem a seguir.
Ativação = acordar músculos, articulações ou padrões específicos sem fadiga.
Prevenção = aumentar tolerância, controlo e qualidade de movimento ao longo do tempo.
```

A regra base é:

```text
Um exercício pode aparecer em aquecimento, mobilidade, recuperação, musculação, cardio ou artes marciais.
A identidade canónica não duplica.
O que muda é o objetivo, a intensidade e o contexto.
```

## Diferença prática

```text
Caminhada leve antes do treino = aquecimento.
Caminhada leve depois do treino = recuperação.
Caminhada rápida como sessão principal = cardio.

Glute bridge antes do agachamento = ativação.
Glute bridge com carga e progressão = musculação.

Rotação externa leve antes do press = ativação.
Rotação externa como bloco regular para ombro = prevenção.
```

## Modelo conceptual

```text
Contexto do treino
  > Necessidade de preparação
    > Sistema ou zona alvo
      > Método
        > Intensidade
          > Duração
            > Exercícios derivados
```

## Campos futuros para exercícios derivados

```text
concept_id
exercício
domínio principal
domínios secundários
zona ou sistema alvo
método
intensidade
duração
nível
equipamento
local
contextos
filtros
cuidados
```

## Intensidade por domínio

```text
Aquecimento: muito leve a moderada, progressivo.
Ativação: leve, técnica, sem fadiga relevante.
Prevenção: leve a moderada controlada, com progressão a longo prazo.
```

---

# Aquecimento geral cardiovascular

## Sistemas ou zonas alvo

```text
sistema cardiovascular
temperatura corporal
respiração
circulação periférica
coordenação geral
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `warmup_general_low_intensity_cardio` | Cardio leve de aquecimento geral | Elevar temperatura corporal e circulação sem criar fadiga. |
| `warmup_general_walk` | Caminhada de aquecimento | Usar caminhada leve para transição de repouso para treino. |
| `warmup_general_bike` | Bicicleta leve de aquecimento | Preparar pernas e sistema cardiovascular com baixo impacto. |
| `warmup_general_treadmill` | Passadeira como aquecimento | Usar caminhada ou corrida muito leve antes de treino. |
| `warmup_general_jump_rope_easy` | Corda leve de aquecimento | Preparar tornozelos, pés, ritmo e coordenação. |
| `warmup_general_martial_shadow_easy` | Sombra leve de aquecimento | Preparar corpo e técnica de forma leve antes de artes marciais. |
| `warmup_general_breathing_ramp` | Respiração em rampa de aquecimento | Aumentar gradualmente ritmo respiratório sem ansiedade ou esforço alto. |

## Métodos derivados prováveis

```text
caminhada leve
bicicleta leve
passadeira leve
corda leve
sombra leve
marcha no lugar
mobilidade dinâmica leve
```

## Notas de modelação

O aquecimento geral deve preparar, não cansar. Se a pessoa fica pesada antes do treino, passou do ponto.

---

# Preparação articular geral

## Sistemas ou zonas alvo

```text
articulações principais
líquido sinovial
controlo articular
amplitude confortável
coordenação suave
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `warmup_joint_cars_general` | CARs gerais de aquecimento | Mover articulações principais com controlo antes do treino. |
| `warmup_joint_neck_safe` | Preparação cervical segura | Acordar pescoço com movimentos pequenos e controlados. |
| `warmup_joint_shoulders` | Preparação articular dos ombros | Preparar ombros e escápulas para empurrar, puxar e guarda. |
| `warmup_joint_wrists_hands` | Preparação de punhos e mãos | Preparar punhos, dedos e antebraços para apoios, pega e grappling. |
| `warmup_joint_spine` | Preparação da coluna | Mover torácica, lombar e pélvis de forma leve. |
| `warmup_joint_hips` | Preparação articular da anca | Acordar flexão, extensão e rotação da anca. |
| `warmup_joint_knees` | Preparação articular do joelho | Preparar flexão, extensão e alinhamento joelho-pé. |
| `warmup_joint_ankles_feet` | Preparação de tornozelos e pés | Preparar dorsiflexão, arco plantar, equilíbrio e contacto com o chão. |

## Métodos derivados prováveis

```text
círculos articulares
CARs leves
rocking articular
mobilidade ativa
amplitude progressiva
movimentos sem carga
```

## Notas de modelação

Preparação articular cruza mobilidade, mas o objetivo aqui é preparar o treino que vem a seguir.

---

# Mobilidade dinâmica de aquecimento

## Sistemas ou zonas alvo

```text
anca
torácica
ombros
tornozelos
posterior de coxa
adutores
cadeia anterior
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `warmup_dynamic_mobility_general` | Mobilidade dinâmica geral | Usar movimento ativo e progressivo para preparar amplitude. |
| `warmup_dynamic_hip_flow` | Flow dinâmico de anca | Preparar anca para agachamento, corrida, pontapés e BJJ. |
| `warmup_dynamic_thoracic_rotation` | Rotação torácica dinâmica | Preparar tronco para golpes, remadas, press e respiração. |
| `warmup_dynamic_ankle_dorsiflexion` | Dorsiflexão dinâmica do tornozelo | Preparar tornozelo para agachamento, corrida e footwork. |
| `warmup_dynamic_hamstring` | Posterior de coxa dinâmico | Preparar cadeia posterior sem alongar passivamente demais. |
| `warmup_dynamic_adductors` | Adutores dinâmicos | Preparar virilha para pernas, pontapés e guarda. |
| `warmup_dynamic_shoulders_overhead` | Ombros overhead dinâmicos | Preparar braços acima da cabeça sem compensar lombar. |
| `warmup_dynamic_full_body_flow` | Flow dinâmico de corpo inteiro | Ligar articulações principais numa sequência curta. |

## Métodos derivados prováveis

```text
world greatest stretch dinâmico
leg swings controlados
rock back de adutores
open book dinâmico
wall slides
knee to wall dinâmico
shin box switches
agachamento assistido dinâmico
```

## Notas de modelação

Mobilidade dinâmica de aquecimento não deve procurar máxima amplitude. O foco é preparar movimento útil.

---

# Ativação de glúteos e anca

## Sistemas ou zonas alvo

```text
glúteo máximo
glúteo médio
glúteo mínimo
rotadores externos da anca
flexores da anca
adutores como estabilizadores
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `activation_glute_max_bridge` | Ativação de glúteo máximo | Acordar extensão da anca antes de agachamentos, peso morto, corrida e pontapés. |
| `activation_glute_med_abduction` | Ativação de glúteo médio | Preparar estabilidade lateral da anca e controlo do joelho. |
| `activation_hip_external_rotators` | Ativação de rotadores externos da anca | Preparar anca para bases, agachamento, guarda e pontapés. |
| `activation_hip_flexors_active` | Ativação de flexores da anca | Preparar elevação de joelho, corrida e pontapés. |
| `activation_adductors_light` | Ativação leve de adutores | Preparar virilha para agachamento, Cossack, BJJ e pontapés. |
| `activation_hip_stability_single_leg` | Estabilidade de anca em apoio unilateral | Preparar corrida, lunges, pontapés e mudanças de direção. |
| `activation_hip_for_squat` | Ativação de anca para agachamento | Acordar glúteos, adutores e rotação externa antes de squat. |
| `activation_hip_for_martial_kicks` | Ativação de anca para pontapés | Preparar câmara, equilíbrio, rotação e recolha da perna. |

## Métodos derivados prováveis

```text
glute bridge
clam shell
monster walk
lateral band walk
hip airplane assistido
marchas de joelho alto controladas
adductor squeeze leve
câmara de pontapé ativa
```

## Notas de modelação

Ativação não é treino pesado. A pessoa deve sentir melhor controlo, não fadiga de glúteos antes do treino principal.

---

# Ativação de core e tronco

## Sistemas ou zonas alvo

```text
transverso abdominal
oblíquos
reto abdominal
multífidos
diafragma
quadrado lombar
core anti-extensão
core anti-rotação
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `activation_core_bracing` | Ativação de bracing | Preparar core para estabilidade em cargas e movimentos. |
| `activation_core_anti_extension` | Ativação anti-extensão | Preparar corpo para evitar lombar arquear em press, prancha e agachamento. |
| `activation_core_anti_rotation` | Ativação anti-rotação | Preparar tronco para golpes, carries, remadas e grappling. |
| `activation_core_dead_bug` | Dead bug de ativação | Unir lombar, pélvis e respiração antes do treino. |
| `activation_core_bird_dog` | Bird dog de ativação | Preparar estabilidade cruzada de tronco, anca e ombro. |
| `activation_core_side_plank` | Ativação lateral de core | Preparar oblíquos e estabilidade lateral. |
| `activation_core_for_heavy_lifts` | Core para cargas pesadas | Preparar bracing antes de squat, peso morto, remadas e overhead. |
| `activation_core_for_martial_arts` | Core para artes marciais | Preparar rotação, anti-rotação e transferência de força. |

## Métodos derivados prováveis

```text
dead bug
bird dog
prancha curta
side plank curta
Pallof press leve
respiração com bracing
hollow hold leve
carry leve
```

## Notas de modelação

Core de ativação deve ser curto. Não cansar o core antes de cargas, grappling ou golpes.

---

# Ativação de escápulas, serrátil e costas altas

## Sistemas ou zonas alvo

```text
serrátil anterior
trapézio inferior
trapézio médio
romboides
escápulas
deltoide posterior
manguito rotador como auxiliar
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `activation_scapular_protraction` | Ativação de protração escapular | Preparar serrátil para flexões, press e golpes. |
| `activation_scapular_retraction` | Ativação de retração escapular | Preparar costas altas para remadas e postura. |
| `activation_scapular_depression` | Ativação de depressão escapular | Preparar ombros para puxadas e barras. |
| `activation_scapular_upward_rotation` | Ativação de rotação superior escapular | Preparar braços acima da cabeça. |
| `activation_lower_trap` | Ativação de trapézio inferior | Melhorar controlo escapular em overhead e puxadas. |
| `activation_serratus_wall` | Ativação de serrátil na parede | Preparar escápulas para empurrar e estabilizar. |
| `activation_upper_back_for_posture` | Ativação de costas altas para postura | Preparar ombros e torácica para treino superior. |
| `activation_scapular_for_martial_guard` | Ativação escapular para guarda | Preparar ombros e escápulas para mãos altas e golpes. |

## Métodos derivados prováveis

```text
scapular push-up
wall slides
serratus reach
band pull-apart leve
face pull leve
Y raise leve
scapular pull-up
prancha com protração
```

## Notas de modelação

Ativação escapular ajuda ombros, costas, peito e artes marciais. Deve ser técnica e leve.

---

# Ativação do manguito rotador e ombro

## Sistemas ou zonas alvo

```text
supraespinhoso
infraespinhoso
redondo menor
subescapular
deltoide
cápsula do ombro
escápulas
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `activation_rotator_cuff_external_rotation` | Ativação de rotação externa | Preparar ombro para press, puxadas, saco e guarda. |
| `activation_rotator_cuff_internal_rotation` | Ativação de rotação interna | Preparar ombro para golpes, estabilidade e controlo. |
| `activation_rotator_cuff_isometrics` | Isometrias leves de manguito | Acordar estabilidade do ombro sem fadiga. |
| `activation_shoulder_overhead_stability` | Estabilidade overhead de ombro | Preparar ombro para press acima da cabeça e posições elevadas. |
| `activation_shoulder_press_prep` | Ativação de ombro para press | Preparar deltoide, manguito e escápula para empurrar. |
| `activation_shoulder_pull_prep` | Ativação de ombro para puxadas | Preparar manguito, depressão escapular e costas altas. |
| `activation_shoulder_striking_prep` | Ativação de ombro para striking | Preparar ombros para jab, direto, guarda e saco. |
| `activation_shoulder_grappling_prep` | Ativação de ombro para grappling | Preparar frames, apoio no chão e estabilidade. |

## Métodos derivados prováveis

```text
rotação externa com elástico leve
rotação interna com elástico leve
isometria de rotação externa
wall slides
Y T W leve
band pull-aparts
scapular push-up
shoulder CARs leves
```

## Notas de modelação

Manguito rotador não é para falhar no aquecimento. Carga leve e controlo.

---

# Preparação de punhos, mãos, antebraços e pega

## Sistemas ou zonas alvo

```text
punhos
mãos
dedos
flexores do punho
extensores do punho
pronadores
supinadores
tendões da mão
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `warmup_wrists_support` | Punhos para apoio | Preparar extensão de punho para flexões, prancha, quedas e solo. |
| `warmup_wrists_grappling` | Punhos para grappling | Preparar punhos e dedos para frames, pegadas e controlo. |
| `warmup_grip_bjj_judo` | Aquecimento de pega para BJJ e Judo | Preparar dedos, antebraços e punhos para kimono e pegadas. |
| `warmup_grip_strength` | Aquecimento de pega para musculação | Preparar antebraços para barras, remadas, farmer walks e deadlifts. |
| `warmup_finger_extensors` | Ativação de extensores dos dedos | Equilibrar trabalho de pega e preparar dedos. |
| `warmup_forearm_rotation` | Rotação de antebraço de aquecimento | Preparar pronação e supinação para golpes, pega e cargas. |
| `warmup_punching_wrists` | Punhos para socos | Preparar alinhamento de punho antes de saco ou striking. |
| `warmup_hand_contact_safety` | Segurança de mãos antes de contacto | Verificar punhos, dedos, ligaduras e impacto progressivo. |

## Métodos derivados prováveis

```text
círculos de punho
rocking de punho
abrir e fechar dedos
extensão de dedos com elástico leve
pronação e supinação
shake out
pegas leves em toalha
alinhamento de punho em parede
```

## Notas de modelação

Dedos e tendões precisam de progressão. O aquecimento de pega não deve cansar antebraços antes do treino.

---

# Preparação de pés, tornozelos e perna inferior

## Sistemas ou zonas alvo

```text
tornozelos
pés
arco plantar
dedos do pé
tibial anterior
gémeos
sóleo
tendão de Aquiles
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `warmup_feet_arch` | Ativação do arco plantar | Preparar pé para suporte, equilíbrio, corrida e footwork. |
| `warmup_toes_control` | Controlo de dedos do pé | Preparar dedos para estabilidade e contacto com o chão. |
| `warmup_ankle_dorsiflexion` | Dorsiflexão de tornozelo para treino | Preparar agachamento, corrida, saltos e bases. |
| `warmup_ankle_stability` | Estabilidade de tornozelo | Preparar apoio unilateral e mudanças de direção. |
| `warmup_tibialis_anterior` | Ativação de tibial anterior | Preparar canela para corrida, caminhada inclinada e aterragem. |
| `warmup_calves_achilles` | Aquecimento de gémeos e Aquiles | Preparar propulsão, corda, corrida e footwork. |
| `warmup_pogo_prep` | Preparação elástica leve do tornozelo | Preparar saltos, corda e corrida com volume baixo. |
| `warmup_martial_footwork_feet` | Pés e tornozelos para footwork marcial | Preparar pivots, bases, deslocamentos e pontapés. |

## Métodos derivados prováveis

```text
short foot
toe yoga
knee to wall dinâmico
elevação de tibial
calf raises leves
pogo prep
equilíbrio unipodal
pivots controlados
```

## Notas de modelação

Tornozelos e pés ligam cardio, pernas, artes marciais e prevenção. Começar sempre com baixo volume.

---

# Prevenção de ombro e cotovelo

## Sistemas ou zonas alvo

```text
ombro
manguito rotador
escápulas
cotovelo
tendões do cotovelo
antebraço
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `prehab_shoulder_general` | Prevenção geral de ombro | Construir tolerância e controlo de ombro para treino recorrente. |
| `prehab_rotator_cuff_capacity` | Capacidade do manguito rotador | Fortalecer estabilidade leve do ombro ao longo do tempo. |
| `prehab_scapular_control` | Controlo escapular preventivo | Melhorar qualidade de movimento em empurrar, puxar e guarda. |
| `prehab_elbow_tendon_capacity` | Capacidade tendinosa do cotovelo | Preparar cotovelos para puxadas, empurrar e grappling. |
| `prehab_wrist_elbow_chain` | Cadeia punho-cotovelo | Reduzir sobrecarga de punhos e cotovelos com preparação integrada. |
| `prehab_striking_shoulders_elbows` | Prevenção para striking | Preparar ombros, cotovelos e punhos para impacto progressivo. |
| `prehab_grappling_shoulders_elbows` | Prevenção para grappling | Preparar ombros, cotovelos e frames para pressão. |
| `prehab_overhead_shoulder` | Prevenção para overhead | Aumentar tolerância a press e braços acima da cabeça. |

## Métodos derivados prováveis

```text
rotação externa leve
face pulls leves
scapular push-ups
Y T W
isometrias de cotovelo
extensão de dedos
wrist prep
volume progressivo
```

## Notas de modelação

Prevenção não garante ausência de lesões. Serve para melhorar tolerância, controlo e progressão.

---

# Prevenção de lombar, anca e joelho

## Sistemas ou zonas alvo

```text
lombar
core
anca
glúteos
adutores
joelhos
posterior de coxa
pélvis
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `prehab_low_back_control` | Prevenção lombar por controlo | Melhorar bracing, pélvis e dobradiça para reduzir sobrecarga. |
| `prehab_hip_control` | Prevenção de anca por controlo | Aumentar estabilidade e amplitude ativa da anca. |
| `prehab_knee_tracking` | Prevenção de joelho por alinhamento | Treinar joelho a acompanhar pé em agachamentos, lunges e saltos. |
| `prehab_adductor_capacity` | Capacidade de adutores | Preparar virilha para BJJ, pontapés, Cossack e mudanças de direção. |
| `prehab_hamstring_capacity` | Capacidade de posterior de coxa | Preparar sprint, dobradiça de anca e pontapés. |
| `prehab_glute_med_knee` | Glúteo médio para joelho | Melhorar estabilidade lateral para corrida, lunges e bases. |
| `prehab_single_leg_control` | Controlo unilateral preventivo | Preparar equilíbrio, aterragem e mudança de direção. |
| `prehab_lumbopelvic_for_grappling` | Prevenção lombo-pélvica para grappling | Preparar lombar, anca e core para solo e pressão. |

## Métodos derivados prováveis

```text
dead bug
bird dog
hinge drill
glute bridge
side plank
Copenhagen regressão
split squat controlado
step down controlado
```

## Notas de modelação

Prevenção de lombar e joelho depende muito de progressão, técnica e carga total.

---

# Prevenção de tornozelo, pé e tendão de Aquiles

## Sistemas ou zonas alvo

```text
tornozelo
pé
arco plantar
gémeos
sóleo
tibial anterior
peroneais
tendão de Aquiles
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `prehab_ankle_stability` | Prevenção de tornozelo por estabilidade | Melhorar controlo de tornozelo em apoio e mudanças de direção. |
| `prehab_foot_intrinsics` | Capacidade dos músculos intrínsecos do pé | Preparar arco e dedos para suporte. |
| `prehab_tibialis_capacity` | Capacidade do tibial anterior | Preparar canela para corrida, passadeira e travagens. |
| `prehab_calf_capacity` | Capacidade de gémeos e sóleo | Preparar propulsão, saltos, corrida e corda. |
| `prehab_achilles_progression` | Progressão de tolerância do Aquiles | Aumentar tolerância de forma gradual e sem agressividade. |
| `prehab_landing_mechanics` | Mecânica de aterragem | Preparar tornozelo, joelho e anca para saltos e mudanças de direção. |
| `prehab_running_lower_leg` | Prevenção para corrida | Preparar pés, gémeos, tibial e anca para impacto repetido. |
| `prehab_martial_footwork_lower_leg` | Prevenção para footwork marcial | Preparar tornozelos e pés para pivots, bases e deslocamentos. |

## Métodos derivados prováveis

```text
equilíbrio unipodal
short foot
toe yoga
elevação de tibial
calf raise controlado
soleus raise controlado
pogo prep
aterragem suave
```

## Notas de modelação

Tendões precisam de carga progressiva, não de pancadas de volume. Dor no Aquiles muda o plano.

---

# Aquecimento por padrão de movimento

## Sistemas ou zonas alvo

```text
agachamento
dobradiça de anca
empurrar
puxar
lunge
carry
rotação
corrida
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `warmup_pattern_squat` | Aquecimento para agachamento | Preparar tornozelo, anca, core e padrão de descida. |
| `warmup_pattern_hinge` | Aquecimento para dobradiça de anca | Preparar posterior, glúteos, core e lombar neutra. |
| `warmup_pattern_push` | Aquecimento para empurrar | Preparar ombro, escápula, peito, tríceps e punhos. |
| `warmup_pattern_pull` | Aquecimento para puxar | Preparar escápulas, costas, bíceps e pega. |
| `warmup_pattern_lunge` | Aquecimento para lunge e split squat | Preparar anca, joelho e equilíbrio unilateral. |
| `warmup_pattern_carry` | Aquecimento para carries | Preparar pega, core, escápulas e postura. |
| `warmup_pattern_rotation` | Aquecimento para rotação | Preparar torácica, anca e core para golpes e mudanças de direção. |
| `warmup_pattern_jump_land` | Aquecimento para saltos e aterragem | Preparar pé, tornozelo, joelho, anca e rigidez elástica. |

## Métodos derivados prováveis

```text
séries de aproximação
padrão sem carga
mobilidade específica
ativação leve
isometrias curtas
repetições técnicas lentas
regressões do movimento
progressão de amplitude
```

## Notas de modelação

Padrão de movimento é mais útil do que aquecer músculos soltos sem relação com o treino.

---

# Aquecimento específico para musculação

## Sistemas ou zonas alvo

```text
músculo alvo
padrão de treino
articulações envolvidas
sistema nervoso
técnica
séries de aproximação
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `warmup_strength_ramp_sets` | Séries de aproximação | Subir carga progressivamente antes da série principal. |
| `warmup_strength_upper_push` | Aquecimento para treino de empurrar superior | Preparar peito, ombros, tríceps, escápulas e punhos. |
| `warmup_strength_upper_pull` | Aquecimento para treino de puxar superior | Preparar costas, escápulas, bíceps e pega. |
| `warmup_strength_shoulders` | Aquecimento para ombros | Preparar manguito, escápulas e deltoides. |
| `warmup_strength_arms` | Aquecimento para braços | Preparar cotovelos, punhos, bíceps e tríceps. |
| `warmup_strength_squat_day` | Aquecimento para dia de agachamento | Preparar tornozelo, anca, joelho, core e padrão. |
| `warmup_strength_hinge_day` | Aquecimento para dia de peso morto ou hinge | Preparar posterior, glúteos, core e pega. |
| `warmup_strength_core_day` | Aquecimento para core | Preparar respiração, pélvis e estabilidade sem fadiga. |

## Métodos derivados prováveis

```text
cardio leve curto
mobilidade específica
ativação do músculo alvo
séries técnicas
séries de aproximação
tempo controlado
pausas curtas
carga progressiva
```

## Notas de modelação

Aquecimento de musculação deve chegar ao exercício principal melhor, não cansado. Séries de aproximação são essenciais.

---

# Aquecimento específico para cardio, corrida e HIIT

## Sistemas ou zonas alvo

```text
sistema cardiovascular
pés
tornozelos
gémeos
joelhos
anca
coordenação
rigidez elástica
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `warmup_cardio_easy_start` | Entrada progressiva no cardio | Começar leve e subir ritmo aos poucos. |
| `warmup_running_general` | Aquecimento para corrida | Preparar pés, tornozelos, gémeos, anca e respiração. |
| `warmup_treadmill_running` | Aquecimento para passadeira | Preparar ritmo e passada antes de aumentar velocidade ou inclinação. |
| `warmup_jump_rope` | Aquecimento para corda | Preparar pés, tornozelos, gémeos, ombros e ritmo. |
| `warmup_hiit_progressive` | Aquecimento para HIIT | Preparar intensidade alta com progressão de movimento e respiração. |
| `warmup_sprints_progressive` | Aquecimento para sprints | Preparar cadeia posterior, tornozelos e sistema nervoso. |
| `warmup_agility_cod` | Aquecimento para mudanças de direção | Preparar travagem, joelho, anca e pés. |
| `warmup_low_impact_cardio` | Aquecimento para cardio de baixo impacto | Preparar corpo para bicicleta, elíptica, remo e air bike. |

## Métodos derivados prováveis

```text
caminhada progressiva
jog leve
mobilidade de tornozelo
leg swings
skips leves
pogo prep
acelerações progressivas
drills de mudança de direção
```

## Notas de modelação

HIIT e sprints precisam de aquecimento real. Entrar direto em intensidade máxima aumenta risco e piora performance.

---

# Aquecimento específico para artes marciais

## Sistemas ou zonas alvo

```text
pescoço
ombros
punhos
anca
joelhos
tornozelos
core
sistema nervoso
técnica
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `warmup_martial_general` | Aquecimento geral marcial | Preparar corpo para técnica, impacto, solo e deslocamentos. |
| `warmup_karate` | Aquecimento para Karate | Preparar bases, anca, joelhos, tornozelos, ombros e técnica. |
| `warmup_bjj` | Aquecimento para Jiu-Jitsu / BJJ | Preparar pescoço, ombros, punhos, anca, solo e pega. |
| `warmup_boxing` | Aquecimento para Boxe | Preparar ombros, punhos, escápulas, footwork e defesa. |
| `warmup_kickboxing_muaythai` | Aquecimento para Kickboxing e Muay Thai | Preparar pontapés, checks, ombros, punhos, clinch e respiração. |
| `warmup_judo` | Aquecimento para Judo | Preparar ukemi, pegada, anca, postura e quedas. |
| `warmup_taekwondo` | Aquecimento para Taekwondo | Preparar anca, posterior, adutores, equilíbrio e pontapés. |
| `warmup_self_defense` | Aquecimento para defesa pessoal funcional | Preparar guarda, distância, levantar do chão e saída. |

## Métodos derivados prováveis

```text
sombra leve
footwork leve
mobilidade de anca
punhos e pega
technical stand-up lento
shrimp lento
sprawl lento
câmaras de pontapé
ukemi progressivo
respiração
```

## Notas de modelação

Aquecimento marcial deve ser específico. Striking, grappling e quedas não têm as mesmas necessidades.

---

# Primer neural, coordenação e técnica

## Sistemas ou zonas alvo

```text
sistema nervoso
coordenação
timing
equilíbrio
velocidade submáxima
padrões técnicos
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `warmup_neural_primer_general` | Primer neural geral | Preparar coordenação e resposta sem fadiga. |
| `warmup_neural_speed_submax` | Velocidade submáxima | Praticar rápido mas controlado antes de intensidade total. |
| `warmup_neural_balance` | Equilíbrio como primer | Preparar apoio unilateral, pontapés, corrida e bases. |
| `warmup_neural_reaction` | Reação leve | Preparar timing e resposta em treino técnico. |
| `warmup_neural_technique_rehearsal` | Ensaio técnico | Repetir padrão do treino com baixa intensidade. |
| `warmup_neural_potentiation_strength` | Potenciação leve para força | Preparar sistema nervoso para cargas sem fadiga. |
| `warmup_neural_martial_timing` | Timing marcial leve | Preparar entradas, saídas, golpes e defesa. |
| `warmup_neural_agility` | Agilidade progressiva | Preparar mudanças de direção com controlo. |

## Métodos derivados prováveis

```text
repetições técnicas lentas
acelerações progressivas
saltos leves
equilíbrio unipodal
footwork com comandos
sombra técnica
séries de aproximação
drills de reação leves
```

## Notas de modelação

Primer neural não deve ser treino até à exaustão. O objetivo é sentir o corpo mais pronto e coordenado.

---

# Prevenção e preparação por contexto de dor ou rigidez

## Sistemas ou zonas alvo

```text
zonas rígidas
histórico de desconforto
articulações sensíveis
tendões
postura
qualidade de movimento
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `prehab_context_stiff_shoulders` | Preparação para ombros rígidos | Usar mobilidade leve e ativação antes de treino superior. |
| `prehab_context_low_back_stiffness` | Preparação para lombar rígida | Usar respiração, pélvis, anca e core leve antes de carga. |
| `prehab_context_knee_sensitivity` | Preparação para joelho sensível | Aquecer tornozelo, anca e alinhamento antes de pernas. |
| `prehab_context_tight_hips` | Preparação para anca rígida | Combinar mobilidade, glúteos e padrões leves. |
| `prehab_context_tight_calves` | Preparação para gémeos tensos | Preparar tornozelo, sóleo, gémeos e pés antes de corrida ou corda. |
| `prehab_context_grip_fatigue` | Preparação quando a pega está cansada | Reduzir agressividade e aquecer tendões antes de puxar ou grappling. |
| `prehab_context_post_computer_training` | Preparação pós-computador antes de treinar | Soltar pescoço, peito, torácica, anca e punhos. |
| `prehab_context_hot_weather` | Aquecimento em dias de calor | Reduzir duração e intensidade do aquecimento quando o corpo já está quente. |

## Métodos derivados prováveis

```text
check-in rápido
mobilidade leve da zona
ativação específica
séries técnicas
reduzir volume de aquecimento
aumentar progressão
trocar exercício se houver dor
monitorizar resposta
```

## Notas de modelação

Prevenção contextual depende do estado do dia. Não é uma lista fixa igual para todos os treinos.

---

# Checklists de prontidão e segurança

## Sistemas ou zonas alvo

```text
sono
energia
dor
rigidez
performance
motivação
risco de sobrecarga
data do último treino
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `readiness_check_general` | Check-in geral antes do treino | Avaliar energia, dor, sono e objetivo do dia. |
| `readiness_check_joint_pain` | Check de dor articular | Identificar dor que exige regressão ou pausa. |
| `readiness_check_tendon` | Check de tendões | Avaliar sinais de irritação antes de carga repetida. |
| `readiness_check_martial_contact` | Check antes de contacto marcial | Verificar cabeça, pescoço, mãos, joelhos e fadiga antes de contacto. |
| `readiness_check_sprint_hiit` | Check antes de HIIT ou sprints | Confirmar que o corpo está pronto para alta intensidade. |
| `readiness_check_heavy_strength` | Check antes de força pesada | Confirmar técnica, aquecimento e prontidão antes de cargas altas. |
| `readiness_check_last_training_date` | Check de intervalo desde o último treino | Comparar data atual com data do último treino registado antes de avaliar carga. |
| `readiness_check_adjust_plan` | Ajuste do plano pelo estado do dia | Escolher progressão, regressão ou treino leve conforme sinais. |

## Métodos derivados prováveis

```text
escala de energia
escala de dor
sono da noite anterior
sensação de rigidez
série técnica teste
comparar último treino
reduzir carga se necessário
trocar por recuperação
```

## Notas de modelação

Este bloco deve ligar ao diário de treino. Para o Sandro, sempre que houver registo de treino, verificar data atual e data do último treino antes de avaliar carga, recuperação ou sobrecarga.

---

# Mapa de cruzamentos

| Exercício ou método | Domínio principal provável | Também aparece em | Regra de decisão |
|---|---|---|---|
| Caminhada leve | Cardio | Aquecimento, Recuperação | Antes do treino é aquecimento. Depois do treino é recuperação. Como sessão longa é cardio. |
| Glute bridge | Musculação | Ativação, Prevenção | Leve antes do treino é ativação. Com carga e progressão é musculação. |
| Dead bug | Core / Musculação | Ativação, Prevenção, Recuperação | Leve e técnico antes de carga é ativação. Regular para controlo é prevenção. |
| Wall slides | Mobilidade | Aquecimento, Ativação, Prevenção | Antes de press é aquecimento. Como bloco de ombro é prevenção. |
| Rotação externa com elástico | Prevenção | Ativação, Ombro, Musculação acessória | Leve antes de treino é ativação. Progressiva é prevenção. |
| 90/90 switches | Mobilidade | Aquecimento, BJJ | Dinâmico antes do treino é aquecimento. Controlado como sessão é mobilidade. |
| Sprawl lento | Artes marciais | Aquecimento, Mobilidade, Prevenção | Lento por fases prepara grappling. Por tempo intenso vira cardio. |
| Sombra leve | Artes marciais | Aquecimento, Cardio, Recuperação | Leve antes do treino é aquecimento. Por rounds intensos é cardio técnico. |
| Copenhagen regressão | Prevenção | Musculação, Adutores | Leve e técnica para tolerância é prevenção. Progressiva como força é musculação. |
| Pogo prep | Prevenção | Aquecimento, Cardio, Pliometria | Baixo volume prepara tornozelos. Volume alto vira treino pliométrico. |

# Filtros recomendados para a app

## Por domínio

```text
Aquecimento / Ativação / Prevenção
  > Aquecimento geral
  > Preparação articular
  > Mobilidade dinâmica
  > Ativação
  > Prevenção
  > Check de prontidão
```

## Por zona

```text
Aquecimento / Ativação / Prevenção
  > Pescoço
  > Ombros
  > Escápulas
  > Manguito rotador
  > Cotovelos
  > Punhos e mãos
  > Core
  > Lombar
  > Anca
  > Glúteos
  > Adutores
  > Joelhos
  > Tornozelos
  > Pés
  > Pega
```

## Por treino alvo

```text
Aquecimento / Ativação / Prevenção
  > Musculação
  > Cardio
  > Corrida
  > Corda
  > HIIT
  > Sprints
  > Karate
  > Jiu-Jitsu / BJJ
  > Boxe
  > Kickboxing
  > Muay Thai
  > Judo
  > Taekwondo
  > Defesa pessoal funcional
```

## Por padrão

```text
Aquecimento / Ativação / Prevenção
  > Agachamento
  > Dobradiça de anca
  > Empurrar
  > Puxar
  > Lunge
  > Carry
  > Rotação
  > Saltos
  > Mudanças de direção
  > Pontapés
  > Guarda
  > Solo
  > Quedas
```

# Regras de descrição

Cada exercício deve explicar:

```text
objetivo
domínio principal
zona ou sistema alvo
treino que prepara
posição inicial
como fazer passo a passo
intensidade
duração ou séries
como saber que está bem doseado
erros comuns
versão mais fácil
versão mais difícil
cuidados
quando não usar
```

## Descrição errada

```text
Faz este exercício para aquecer.
```

## Descrição correta

```text
Objetivo:
Ativar glúteos e preparar extensão da anca antes de agachamentos ou peso morto.

Como fazer:
1. Deita-te de costas com joelhos fletidos.
2. Mantém costelas controladas e pés firmes no chão.
3. Sobe a anca contraindo glúteos sem arquear a lombar.
4. Mantém um segundo no topo e desce devagar.
5. Termina com sensação de controlo, não de fadiga.

Erros comuns:
- Empurrar com a lombar.
- Fazer até queimar antes do treino principal.
- Deixar joelhos colapsarem para dentro.
```

# Testes obrigatórios

```text
todo exercício tem concept_id
todo exercício tem domínio principal
todo exercício tem zona ou sistema alvo
todo exercício tem método
todo exercício tem intensidade
todo exercício tem contexto de uso
todo exercício tem cuidados
todo exercício de ativação evita fadiga relevante
todo exercício de aquecimento é progressivo
todo exercício de prevenção não promete evitar lesões
todo exercício de contacto marcial tem progressão
todo exercício de HIIT ou sprints tem aquecimento específico
todo exercício cruzado mantém identidade única
todo registo de treino compara data atual com data do último treino antes de avaliar recuperação ou sobrecarga
```

# Contagem

Este ficheiro define `151` conceitos de aquecimento, ativação e prevenção.

# Próximo ficheiro

O próximo ficheiro deve ser:

```text
23_AQUECIMENTO_ATIVACAO_PREVENCAO_EXERCICIOS_DERIVADOS.md
```

Esse ficheiro deve transformar estes conceitos em exercícios concretos, com:

```text
concept_id
exercício
domínio principal
domínios secundários
zona alvo
método
intensidade
duração
nível
equipamento
local
contextos
filtros
cuidados
```