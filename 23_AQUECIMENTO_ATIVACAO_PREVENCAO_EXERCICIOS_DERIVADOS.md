# 23 - Aquecimento, ativação e prevenção: exercícios derivados

## Objetivo

Este ficheiro transforma os conceitos do ficheiro `22_AQUECIMENTO_ATIVACAO_PREVENCAO_CONCEITOS.md` em exercícios, protocolos e checklists canónicos.

A regra principal é:

```text
Aquecimento prepara o treino.
Ativação acorda músculos, articulações ou padrões sem fadiga.
Prevenção aumenta tolerância e controlo ao longo do tempo, sem prometer evitar lesões.
```

## Campos usados

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
locais
contextos
filtros prováveis
cuidados
```

## Regra de identidade única

```text
O mesmo exercício não deve ser duplicado por aparecer em aquecimento, mobilidade, recuperação, musculação, cardio ou artes marciais.
A entidade é a mesma. O que muda é objetivo, contexto, intensidade e prescrição.
```

## Regra de dose

```text
Aquecimento deve deixar a pessoa mais pronta.
Ativação deve melhorar controlo sem fadiga.
Prevenção pode ser progressiva, mas deve respeitar dor e recuperação.
```

---

# Aquecimento geral cardiovascular

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `warmup_general_low_intensity_cardio` | Cardio leve geral | aquecimento | cardio, recuperação | sistema cardiovascular | cardio leve progressivo | muito leve a leve | 5 a 10 min | iniciante | passadeira, bicicleta, elíptica ou sem equipamento | ginásio, casa, exterior | antes de musculação, cardio ou artes marciais | Aquecimento > Geral; Cardio > Leve | Deve preparar sem cansar. |
| `warmup_general_low_intensity_cardio` | Marcha no lugar progressiva | aquecimento | cardio | cardiovascular, pernas | marcha leve | muito leve | 2 a 5 min | iniciante | sem equipamento | casa, ginásio, dojo | antes de treino em casa | Aquecimento > Geral; Casa sem equipamento | Subir ritmo devagar. |
| `warmup_general_walk` | Caminhada leve pré-treino | aquecimento | cardio | cardiovascular, pernas | caminhada leve | muito leve a leve | 5 a 10 min | iniciante | sem equipamento | exterior, passadeira | antes de musculação ou cardio | Aquecimento > Geral; Cardio > Caminhada | Não transformar em treino de zona 2. |
| `warmup_general_bike` | Bicicleta leve pré-treino | aquecimento | cardio | cardiovascular, joelhos, pernas | bicicleta leve | muito leve a leve | 5 a 8 min | iniciante | bicicleta | ginásio, casa equipada | antes de pernas, cardio ou recuperação ativa | Aquecimento > Geral; Cardio > Bicicleta | Resistência baixa. |
| `warmup_general_treadmill` | Passadeira caminhada progressiva | aquecimento | cardio | cardiovascular, pernas | passadeira leve | muito leve a leve | 5 a 10 min | iniciante | passadeira | ginásio, casa equipada | antes de treino de ginásio | Aquecimento > Geral; Cardio > Passadeira | Aumentar velocidade de forma gradual. |
| `warmup_general_treadmill` | Passadeira corrida muito leve | aquecimento | cardio | cardiovascular, corrida | corrida leve | leve | 3 a 8 min | intermédio | passadeira | ginásio, casa equipada | antes de corrida ou HIIT leve | Aquecimento > Corrida; Cardio > Passadeira | Só usar se a corrida leve for confortável. |
| `warmup_general_jump_rope_easy` | Corda leve de aquecimento | aquecimento | cardio, coordenação | pés, tornozelos, gémeos, ritmo | corda leve | leve | 2 a 5 min | intermédio | corda | casa, ginásio, dojo, exterior | antes de striking, corrida ou cardio | Aquecimento > Corda; Cardio > Corda | Baixo volume no início. |
| `warmup_general_jump_rope_easy` | Corda boxer step leve | aquecimento | cardio, artes marciais | pés, tornozelos, coordenação | corda técnica leve | leve | 2 a 4 min | intermédio | corda | ginásio, dojo, exterior | antes de boxe ou kickboxing | Aquecimento > Corda; Artes marciais > Footwork | Sem double unders no aquecimento inicial. |
| `warmup_general_martial_shadow_easy` | Sombra leve geral | aquecimento | artes marciais, cardio | corpo inteiro, técnica | sombra técnica leve | muito leve a leve | 3 a 6 min | iniciante | sem equipamento | casa, dojo, ginásio | antes de Karate, Boxe, Kickboxing ou Muay Thai | Aquecimento > Artes marciais; Artes marciais > Sombra | Sem potência e sem pressa. |
| `warmup_general_martial_shadow_easy` | Sombra com guarda e passos curtos | aquecimento | artes marciais | ombros, pés, coordenação | sombra leve com footwork | leve | 3 a 5 min | iniciante | sem equipamento | casa, dojo, ginásio | antes de striking | Aquecimento > Artes marciais > Striking | Manter mãos altas sem rigidez. |
| `warmup_general_breathing_ramp` | Respiração em rampa leve | aquecimento | respiração | respiração, sistema nervoso | respiração progressiva | muito leve | 1 a 3 min | iniciante | sem equipamento | qualquer local | antes de treino se estiver frio ou parado | Aquecimento > Respiração | Não hiperventilar. |
| `warmup_general_breathing_ramp` | Caminhada com respiração progressiva | aquecimento | cardio, respiração | cardiovascular, respiração | caminhada e respiração | muito leve a leve | 3 a 8 min | iniciante | sem equipamento | exterior, passadeira | antes de cardio ou musculação | Aquecimento > Geral; Recuperação > Respiração | Subir ritmo sem ficar ofegante. |

---

# Preparação articular geral

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `warmup_joint_cars_general` | CARs gerais de corpo inteiro | aquecimento | mobilidade | articulações principais | CARs leves | muito leve | 5 a 8 min | iniciante | sem equipamento | casa, ginásio, dojo | antes de treino geral | Aquecimento > Preparação articular; Mobilidade > CARs | Amplitude confortável. |
| `warmup_joint_cars_general` | Sequência pescoço, ombros, anca e tornozelos | aquecimento | mobilidade | articulações principais | mobilidade articular | muito leve | 4 a 7 min | iniciante | sem equipamento | casa, ginásio, dojo | antes de musculação, cardio ou artes marciais | Aquecimento > Preparação articular | Pescoço sempre suave. |
| `warmup_joint_neck_safe` | Pescoço suave de aquecimento | aquecimento | mobilidade | pescoço | rotações e inclinações leves | muito leve | 1 a 2 min | iniciante | sem equipamento | casa, ginásio, dojo | antes de artes marciais ou treino superior | Aquecimento > Pescoço; Mobilidade > Pescoço | Sem círculos agressivos. |
| `warmup_joint_shoulders` | Círculos de ombros | aquecimento | mobilidade | ombros, escápulas | círculos articulares | muito leve | 1 a 2 min | iniciante | sem equipamento | casa, ginásio, dojo | antes de treino superior ou striking | Aquecimento > Ombros | Não encolher pescoço. |
| `warmup_joint_shoulders` | Shoulder CARs leves | aquecimento | mobilidade | ombros | CARs de ombro | muito leve a leve | 1 a 3 min | intermédio | sem equipamento | casa, ginásio | antes de press, puxadas ou saco | Aquecimento > Ombros; Mobilidade > Ombros | Sem pinçamento. |
| `warmup_joint_wrists_hands` | Círculos de punho e abrir dedos | aquecimento | mobilidade | punhos, mãos, dedos | mobilidade ativa | muito leve | 1 a 3 min | iniciante | sem equipamento | casa, ginásio, dojo | antes de flexões, BJJ, Judo ou saco | Aquecimento > Punhos e mãos | Não forçar punhos frios. |
| `warmup_joint_wrists_hands` | Rocking leve de punhos | aquecimento | mobilidade | punhos, mãos | rocking em apoio | leve | 1 a 3 min | iniciante | tapete opcional | casa, ginásio, dojo | antes de apoios, solo ou flexões | Aquecimento > Punhos; Mobilidade > Punhos | Aumentar carga devagar. |
| `warmup_joint_spine` | Cat cow leve pré-treino | aquecimento | mobilidade | coluna | mobilidade de coluna | muito leve | 1 a 3 min | iniciante | tapete opcional | casa, ginásio | antes de treino geral, pernas ou BJJ | Aquecimento > Coluna; Mobilidade > Coluna | Sem extremos de amplitude. |
| `warmup_joint_spine` | Rotação torácica em quadrupedia | aquecimento | mobilidade | torácica | rotação ativa | leve | 1 a 3 min | iniciante | tapete opcional | casa, ginásio | antes de golpes, remadas ou press | Aquecimento > Torácica; Mobilidade > Torácica | Manter anca estável. |
| `warmup_joint_hips` | Círculos de anca com apoio | aquecimento | mobilidade | anca | círculos articulares | muito leve a leve | 1 a 3 min | iniciante | apoio opcional | casa, ginásio, dojo | antes de pernas, corrida ou pontapés | Aquecimento > Anca; Mobilidade > Anca | Não rodar lombar para compensar. |
| `warmup_joint_knees` | Flexão e extensão leve do joelho | aquecimento | mobilidade | joelhos | mobilidade articular | muito leve | 1 a 2 min | iniciante | sem equipamento | casa, ginásio, dojo | antes de pernas, corrida ou footwork | Aquecimento > Joelhos | Joelho acompanha pé. |
| `warmup_joint_ankles_feet` | Círculos de tornozelo e dedos | aquecimento | mobilidade | tornozelos, pés | mobilidade articular | muito leve | 1 a 3 min | iniciante | sem equipamento | casa, ginásio, dojo | antes de corrida, corda, pernas ou artes marciais | Aquecimento > Tornozelos e pés | Movimento controlado. |

---

# Mobilidade dinâmica de aquecimento

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `warmup_dynamic_mobility_general` | World greatest stretch dinâmico | aquecimento | mobilidade | anca, torácica, posterior, flexores da anca | mobilidade dinâmica | leve a moderada | 3 a 6 min | intermédio | sem equipamento | casa, ginásio | antes de pernas, corrida ou treino geral | Aquecimento > Mobilidade dinâmica; Mobilidade > Flow | Não procurar máxima amplitude. |
| `warmup_dynamic_mobility_general` | Flow dinâmico curto | aquecimento | mobilidade | corpo inteiro | flow dinâmico | leve | 4 a 8 min | iniciante | tapete opcional | casa, ginásio, dojo | antes de treino geral | Aquecimento > Mobilidade dinâmica | Deve aquecer, não cansar. |
| `warmup_dynamic_hip_flow` | Shin box switches dinâmicos | aquecimento | mobilidade, artes marciais | anca | transição dinâmica | leve | 2 a 4 min | iniciante | tapete opcional | casa, ginásio, dojo | antes de BJJ, pernas ou pontapés | Aquecimento > Anca; Mobilidade > Anca | Sem dor no joelho. |
| `warmup_dynamic_hip_flow` | 90/90 switches leves | aquecimento | mobilidade | anca | rotação dinâmica | leve | 2 a 4 min | iniciante | tapete opcional | casa, ginásio, dojo | antes de pernas ou BJJ | Aquecimento > Anca; Mobilidade > 90/90 | Não forçar a perna. |
| `warmup_dynamic_thoracic_rotation` | Open book dinâmico | aquecimento | mobilidade | coluna torácica | rotação dinâmica | leve | 1 a 3 min | iniciante | tapete opcional | casa, ginásio | antes de costas, peito ou golpes | Aquecimento > Torácica; Mobilidade > Rotação | Rodar sem puxar o ombro. |
| `warmup_dynamic_thoracic_rotation` | Rotação torácica com alcance | aquecimento | mobilidade, artes marciais | torácica, ombros | rotação ativa | leve | 1 a 3 min | iniciante | sem equipamento | casa, dojo, ginásio | antes de striking, remadas ou press | Aquecimento > Torácica | Movimento controlado. |
| `warmup_dynamic_ankle_dorsiflexion` | Knee to wall dinâmico | aquecimento | mobilidade | tornozelo | dorsiflexão dinâmica | leve | 1 a 3 min | iniciante | parede opcional | casa, ginásio | antes de agachamento, corrida ou footwork | Aquecimento > Tornozelos; Mobilidade > Dorsiflexão | Calcanhar no chão. |
| `warmup_dynamic_ankle_dorsiflexion` | Rocking de tornozelo em avanço | aquecimento | mobilidade | tornozelo, joelho | mobilidade dinâmica | leve | 1 a 3 min | iniciante | sem equipamento | casa, ginásio, dojo | antes de pernas, corrida ou pontapés | Aquecimento > Tornozelos | Joelho acompanha pé. |
| `warmup_dynamic_hamstring` | Leg swings frontais controlados | aquecimento | elasticidade dinâmica, mobilidade | posterior de coxa, flexores da anca | balanço controlado | leve a moderada | 1 a 3 min | iniciante | apoio opcional | casa, ginásio, dojo | antes de corrida ou pontapés | Aquecimento > Posterior; Elasticidade > Dinâmico | Sem balançar até dor. |
| `warmup_dynamic_hamstring` | Walkouts de posterior leves | aquecimento | mobilidade, core | posterior, core, ombros | dinâmico | leve | 2 a 4 min | intermédio | sem equipamento | casa, ginásio | antes de pernas ou treino geral | Aquecimento > Posterior; Core > Dinâmico | Não forçar lombar. |
| `warmup_dynamic_adductors` | Rock back de adutores dinâmico | aquecimento | mobilidade, elasticidade | adutores, anca | dinâmico | leve | 1 a 3 min | iniciante | tapete opcional | casa, ginásio, dojo | antes de BJJ, pontapés ou pernas | Aquecimento > Adutores; Mobilidade > Anca | Abrir só até controlo. |
| `warmup_dynamic_adductors` | Cossack parcial dinâmico | aquecimento | mobilidade | adutores, anca, joelho | dinâmico controlado | leve a moderada | 2 a 4 min | intermédio | apoio opcional | casa, ginásio | antes de pernas ou artes marciais | Aquecimento > Adutores; Mobilidade > Agachamento | Joelho estável. |
| `warmup_dynamic_shoulders_overhead` | Wall slides dinâmicos | aquecimento | mobilidade, ativação | ombros, escápulas, torácica | mobilidade dinâmica | leve | 1 a 3 min | iniciante | parede | casa, ginásio | antes de press ou guarda | Aquecimento > Ombros; Mobilidade > Overhead | Costelas controladas. |
| `warmup_dynamic_full_body_flow` | Agachamento assistido dinâmico | aquecimento | mobilidade | anca, joelho, tornozelo | mobilidade dinâmica | leve | 2 a 4 min | iniciante | apoio opcional | casa, ginásio | antes de pernas | Aquecimento > Agachamento; Mobilidade > Anca | Não ficar a alongar passivamente. |

---

# Ativação de glúteos e anca

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `activation_glute_max_bridge` | Glute bridge de ativação | ativação | musculação, prevenção | glúteo máximo | ativação leve | leve | 1 a 2 séries de 8 a 12 | iniciante | tapete opcional | casa, ginásio | antes de agachamento, peso morto ou corrida | Ativação > Glúteos; Musculação > Glúteos | Parar antes de fadiga. |
| `activation_glute_max_bridge` | Glute bridge com pausa no topo | ativação | prevenção | glúteo máximo, core | isometria curta | leve | 1 a 2 séries de 6 a 10 | iniciante | tapete opcional | casa, ginásio | antes de pernas ou hinge | Ativação > Glúteos | Não arquear lombar. |
| `activation_glute_med_abduction` | Clam shell leve | ativação | prevenção | glúteo médio, rotadores externos | abdução leve | leve | 1 a 2 séries de 10 a 15 por lado | iniciante | mini band opcional | casa, ginásio | antes de pernas, corrida ou BJJ | Ativação > Glúteo médio; Prevenção > Joelho | Sentir lateral da anca, não lombar. |
| `activation_glute_med_abduction` | Lateral band walk | ativação | prevenção | glúteo médio, anca | abdução dinâmica | leve | 1 a 2 séries de 8 a 12 passos | intermédio | mini band | casa, ginásio | antes de agachamento, lunges ou corrida | Ativação > Glúteo médio; Prevenção > Anca | Não deixar joelhos colapsarem. |
| `activation_glute_med_abduction` | Monster walk leve | ativação | prevenção | glúteos, anca | abdução com deslocamento | leve | 1 a 2 séries de 8 a 12 passos | intermédio | mini band | casa, ginásio | antes de pernas ou mudanças de direção | Ativação > Glúteos; Prevenção > Joelhos | Passos controlados. |
| `activation_hip_external_rotators` | Rotação externa de anca com mini band | ativação | prevenção | rotadores externos da anca | rotação leve | leve | 1 a 2 séries de 10 a 15 | iniciante | mini band | casa, ginásio | antes de squat, bases ou guarda | Ativação > Anca; Prevenção > Anca | Não compensar com lombar. |
| `activation_hip_external_rotators` | Hip airplane assistido | ativação | mobilidade, prevenção | anca, glúteos, equilíbrio | controlo unilateral | leve | 1 a 2 séries de 4 a 6 por lado | intermédio | apoio opcional | casa, ginásio | antes de pernas, corrida ou pontapés | Ativação > Anca; Mobilidade > Anca | Amplitude pequena no início. |
| `activation_hip_flexors_active` | Marcha de joelho alto controlada | ativação | aquecimento | flexores da anca, core | elevação ativa | leve | 1 a 2 séries de 8 a 12 por lado | iniciante | sem equipamento | casa, ginásio, dojo | antes de corrida, pontapés ou escadas | Ativação > Flexores da anca; Aquecimento > Corrida | Não inclinar tronco para trás. |
| `activation_hip_flexors_active` | Câmara de pontapé frontal ativa | ativação | artes marciais, mobilidade | flexores da anca, equilíbrio | câmara de pontapé | leve | 1 a 2 séries de 5 a 8 por lado | iniciante | apoio opcional | casa, dojo, ginásio | antes de Karate, Taekwondo ou Kickboxing | Ativação > Pontapés; Artes marciais > Pontapés | Altura baixa e controlada. |
| `activation_adductors_light` | Adductor squeeze leve | ativação | prevenção | adutores | isometria leve | leve | 1 a 2 séries de 8 a 12 segundos | iniciante | bola, almofada ou toalha | casa, ginásio | antes de pernas, BJJ ou pontapés | Ativação > Adutores; Prevenção > Virilha | Contração leve, não máxima. |
| `activation_adductors_light` | Copenhagen regressão curta | prevenção | ativação, musculação | adutores, core lateral | isometria regressiva | leve a moderada | 1 a 2 séries de 8 a 15 segundos | intermédio | banco ou apoio | ginásio, casa equipada | prevenção de virilha, BJJ, mudanças de direção | Prevenção > Adutores; Musculação > Adutores | Não fazer até falhar. |
| `activation_hip_stability_single_leg` | Equilíbrio unipodal com joelho alto | ativação | prevenção | anca, pé, core | estabilidade unilateral | leve | 1 a 2 séries de 15 a 30 segundos | iniciante | sem equipamento | casa, ginásio, dojo | antes de corrida, pontapés ou lunges | Ativação > Anca; Prevenção > Equilíbrio | Usar apoio se necessário. |
| `activation_hip_for_squat` | Agachamento com pausa leve | ativação | aquecimento, musculação | anca, glúteos, adutores | padrão técnico leve | leve | 1 a 2 séries de 5 a 8 | iniciante | sem equipamento | casa, ginásio | antes de squat ou pernas | Aquecimento > Agachamento; Ativação > Anca | Pausa curta, sem fadiga. |
| `activation_hip_for_squat` | Squat to stand leve | aquecimento | mobilidade, ativação | anca, posterior, tornozelo | dinâmico | leve | 1 a 2 séries de 5 a 8 | intermédio | sem equipamento | casa, ginásio | antes de pernas | Aquecimento > Agachamento; Mobilidade > Anca | Não puxar posterior agressivamente. |
| `activation_hip_for_martial_kicks` | Câmara de pontapé circular ativa | ativação | artes marciais, mobilidade | anca, glúteo médio, rotadores | câmara técnica | leve | 1 a 2 séries de 4 a 8 por lado | intermédio | apoio opcional | dojo, casa, ginásio | antes de pontapés circulares | Ativação > Pontapés; Artes marciais > Karate; Artes marciais > Kickboxing | Não torcer joelho. |

---

# Ativação de core e tronco

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `activation_core_bracing` | Respiração com bracing leve | ativação | core, prevenção | core profundo, pélvis | bracing leve | leve | 3 a 6 respirações | iniciante | sem equipamento | casa, ginásio | antes de cargas ou treino de core | Ativação > Core > Bracing | Não fazer força máxima. |
| `activation_core_bracing` | Brace em pé antes de carga | ativação | musculação | core, lombar | ensaio técnico | leve | 3 a 5 repetições | iniciante | sem equipamento | ginásio, casa | antes de squat, deadlift ou overhead | Ativação > Core; Aquecimento > Força | Respirar sem perder pressão. |
| `activation_core_anti_extension` | Prancha curta de ativação | ativação | core, prevenção | core anti-extensão | isometria curta | leve | 1 a 2 séries de 10 a 20 segundos | iniciante | tapete opcional | casa, ginásio | antes de treino geral ou core | Ativação > Core > Anti-extensão | Terminar antes de tremer muito. |
| `activation_core_anti_extension` | Hollow hold leve | ativação | core | core anterior | isometria leve | leve | 1 a 2 séries de 8 a 15 segundos | intermédio | tapete opcional | casa, ginásio | antes de ginástica, core ou artes marciais | Ativação > Core | Lombar controlada. |
| `activation_core_anti_rotation` | Pallof press leve | ativação | prevenção, musculação | core anti-rotação | press anti-rotação | leve | 1 a 2 séries de 6 a 10 por lado | intermédio | elástico ou cabo | ginásio, casa equipada | antes de remadas, carries, golpes ou grappling | Ativação > Core > Anti-rotação | Não rodar tronco. |
| `activation_core_dead_bug` | Dead bug de ativação | ativação | mobilidade, core | core, pélvis, lombar | coordenação | leve | 1 a 2 séries de 6 a 10 por lado | iniciante | tapete opcional | casa, ginásio | antes de pernas, core ou treino geral | Ativação > Core; Mobilidade > Lombar e pélvis | Lombar não arqueia. |
| `activation_core_dead_bug` | Dead bug com expiração | ativação | respiração, core | core profundo, respiração | coordenação respiração-core | leve | 1 a 2 séries de 4 a 6 por lado | iniciante | tapete opcional | casa, ginásio | antes de força ou pós-sentado | Ativação > Core; Recuperação > Respiração | Expirar sem prender ar. |
| `activation_core_bird_dog` | Bird dog de ativação | ativação | prevenção | core, lombar, anca, ombro | estabilidade cruzada | leve | 1 a 2 séries de 5 a 8 por lado | iniciante | tapete opcional | casa, ginásio | antes de pernas, costas ou BJJ | Ativação > Core; Prevenção > Lombar | Não rodar pélvis. |
| `activation_core_side_plank` | Side plank curta | ativação | prevenção | oblíquos, quadrado lombar, anca | isometria lateral | leve | 1 a 2 séries de 10 a 20 segundos por lado | iniciante | tapete opcional | casa, ginásio | antes de carries, grappling ou corrida | Ativação > Core lateral | Sem dor no ombro. |
| `activation_core_side_plank` | Side plank com joelhos apoiados | ativação | prevenção | core lateral | isometria regressiva | leve | 1 a 2 séries de 10 a 20 segundos por lado | iniciante | tapete opcional | casa, ginásio | antes de treino geral | Ativação > Core lateral; Prevenção > Lombar | Regressão segura. |
| `activation_core_for_heavy_lifts` | McGill curl-up leve | ativação | prevenção | core anterior, lombar | isometria leve | leve | 1 a 2 séries de 5 a 8 | intermédio | tapete opcional | casa, ginásio | antes de cargas | Ativação > Core; Prevenção > Lombar | Sem flexão lombar agressiva. |
| `activation_core_for_martial_arts` | Rotação torácica com core ativo | ativação | artes marciais, mobilidade | torácica, core, anca | rotação controlada | leve | 1 a 2 séries de 6 a 10 por lado | iniciante | sem equipamento | casa, dojo, ginásio | antes de striking ou grappling | Ativação > Core; Artes marciais > Rotação | Rodar torácica, não lombar. |
| `activation_core_for_martial_arts` | Bear hold curto | ativação | prevenção, artes marciais | core, ombros, anca | isometria em quadrupedia | leve | 1 a 2 séries de 10 a 20 segundos | intermédio | tapete opcional | casa, ginásio, dojo | antes de BJJ, crawling ou treino geral | Ativação > Core; Artes marciais > Grappling | Não cansar ombros antes do treino. |

---

# Escápulas, serrátil e costas altas

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `activation_scapular_protraction` | Scapular push-up leve | ativação | mobilidade, prevenção | serrátil, escápulas | protração ativa | leve | 1 a 2 séries de 8 a 12 | iniciante | tapete opcional | casa, ginásio | antes de flexões, press ou striking | Ativação > Escápulas; Prevenção > Ombros | Cotovelos estendidos sem bloquear agressivamente. |
| `activation_scapular_protraction` | Prancha com protração escapular | ativação | core, prevenção | serrátil, core | estabilidade em apoio | leve | 1 a 2 séries de 10 a 20 segundos | iniciante | tapete opcional | casa, ginásio | antes de empurrar ou grappling | Ativação > Serrátil; Core > Estabilidade | Não deixar lombar cair. |
| `activation_scapular_retraction` | Band pull-apart leve | ativação | prevenção | costas altas, deltoide posterior | retração escapular | leve | 1 a 2 séries de 10 a 15 | iniciante | elástico | casa equipada, ginásio | antes de costas, peito ou postura | Ativação > Costas altas; Prevenção > Ombros | Elástico leve. |
| `activation_scapular_retraction` | Retração escapular em pé | ativação | mobilidade | escápulas, romboides | retração ativa | muito leve | 1 a 2 séries de 8 a 12 | iniciante | sem equipamento | casa, ginásio | antes de treino superior | Ativação > Escápulas | Não arquear lombar. |
| `activation_scapular_depression` | Scapular pull-up leve | ativação | mobilidade, musculação | escápulas, dorsal, trapézio inferior | depressão em suspensão | leve | 1 a 2 séries de 5 a 8 | intermédio | barra fixa | ginásio, exterior, casa equipada | antes de barras, puxadas ou remadas | Ativação > Escápulas; Musculação > Costas | Não usar se ombro doer. |
| `activation_scapular_depression` | Depressão escapular com elástico | ativação | prevenção | trapézio inferior, dorsal | depressão leve | leve | 1 a 2 séries de 8 a 12 | iniciante | elástico | casa equipada, ginásio | antes de puxadas | Ativação > Escápulas | Movimento pequeno. |
| `activation_scapular_upward_rotation` | Wall slides com foco em escápula | ativação | mobilidade, prevenção | escápulas, ombros | rotação superior | leve | 1 a 2 séries de 8 a 12 | iniciante | parede | casa, ginásio | antes de overhead, press ou guarda | Ativação > Escápulas; Mobilidade > Ombros | Costelas baixas. |
| `activation_lower_trap` | Y raise leve | ativação | prevenção | trapézio inferior | elevação em Y | leve | 1 a 2 séries de 8 a 12 | intermédio | sem equipamento ou halteres leves | casa, ginásio | antes de ombros ou costas | Ativação > Trapézio inferior | Peso mínimo. |
| `activation_lower_trap` | Prone Y T W leve | ativação | prevenção | trapézio inferior, costas altas, manguito | ativação postural | leve | 1 série de 4 a 8 cada letra | intermédio | tapete ou banco | casa, ginásio | antes de treino superior | Ativação > Costas altas; Prevenção > Ombros | Qualidade acima de volume. |
| `activation_serratus_wall` | Serratus wall slide | ativação | prevenção | serrátil, escápulas | slide na parede | leve | 1 a 2 séries de 8 a 12 | iniciante | parede, mini band opcional | casa, ginásio | antes de press ou striking | Ativação > Serrátil | Não encolher ombros. |
| `activation_upper_back_for_posture` | Face pull leve de ativação | ativação | prevenção, musculação acessória | costas altas, deltoide posterior, manguito | puxada leve | leve | 1 a 2 séries de 10 a 15 | intermédio | elástico ou cabo | ginásio, casa equipada | antes de treino superior | Ativação > Costas altas; Prevenção > Ombros | Não fazer pesado. |
| `activation_scapular_for_martial_guard` | Guarda alta com serrátil ativo | ativação | artes marciais | ombros, escápulas, serrátil | isometria técnica | leve | 1 a 2 séries de 20 a 40 segundos | iniciante | sem equipamento | casa, dojo, ginásio | antes de Boxe, Karate, Kickboxing ou Muay Thai | Ativação > Guarda; Artes marciais > Guarda | Mãos altas sem tensão excessiva. |

---

# Manguito rotador e ombro

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `activation_rotator_cuff_external_rotation` | Rotação externa com elástico leve | ativação | prevenção | manguito rotador | rotação externa | leve | 1 a 2 séries de 10 a 15 | iniciante | elástico | casa equipada, ginásio | antes de press, puxadas, saco ou guarda | Ativação > Manguito rotador; Prevenção > Ombros | Carga muito leve. |
| `activation_rotator_cuff_external_rotation` | Rotação externa deitado de lado leve | ativação | prevenção | manguito rotador | rotação externa | leve | 1 a 2 séries de 8 a 12 | iniciante | halter muito leve opcional | casa, ginásio | antes de treino superior | Ativação > Manguito rotador | Sem fadiga no ombro. |
| `activation_rotator_cuff_internal_rotation` | Rotação interna com elástico leve | ativação | prevenção | subescapular, ombro | rotação interna | leve | 1 a 2 séries de 10 a 15 | iniciante | elástico | casa equipada, ginásio | antes de striking ou treino superior | Ativação > Manguito rotador | Cotovelo junto ao tronco. |
| `activation_rotator_cuff_isometrics` | Isometria de rotação externa na parede | ativação | prevenção | manguito rotador | isometria leve | muito leve a leve | 2 a 4 holds de 5 a 10 segundos | iniciante | parede | casa, ginásio | antes de press ou saco | Ativação > Manguito rotador > Isometria | Pressão leve. |
| `activation_rotator_cuff_isometrics` | Isometria de rotação interna na parede | ativação | prevenção | manguito rotador | isometria leve | muito leve a leve | 2 a 4 holds de 5 a 10 segundos | iniciante | parede | casa, ginásio | antes de treino superior | Ativação > Manguito rotador > Isometria | Sem dor articular. |
| `activation_shoulder_overhead_stability` | Overhead hold leve | ativação | mobilidade, prevenção | ombros, escápulas, core | estabilidade overhead | leve | 1 a 2 séries de 15 a 30 segundos | iniciante | sem equipamento ou bastão | casa, ginásio | antes de press vertical | Ativação > Ombros > Overhead | Costelas controladas. |
| `activation_shoulder_overhead_stability` | Bottoms-up carry leve | ativação | prevenção, musculação | ombro, punho, core | estabilidade carregada leve | leve | 1 a 2 séries de 10 a 20 metros | avançado | kettlebell leve | ginásio | antes de overhead ou carries | Ativação > Ombros; Prevenção > Ombro | Só com técnica e carga leve. |
| `activation_shoulder_press_prep` | Push-up plus regressivo | ativação | prevenção | serrátil, ombro, core | empurrar leve | leve | 1 a 2 séries de 6 a 10 | iniciante | parede ou banco | casa, ginásio | antes de press, flexões ou supino | Ativação > Ombros; Aquecimento > Empurrar | Escolher regressão fácil. |
| `activation_shoulder_pull_prep` | Straight arm pulldown leve | ativação | costas, prevenção | dorsal, escápulas | puxada de braço estendido | leve | 1 a 2 séries de 10 a 15 | intermédio | elástico ou cabo | ginásio, casa equipada | antes de puxadas, remadas ou barras | Ativação > Costas; Aquecimento > Puxar | Não cansar dorsal. |
| `activation_shoulder_striking_prep` | Jab leve no ar com guarda | ativação | artes marciais | ombros, serrátil, punho | ensaio técnico | leve | 1 a 2 séries de 20 a 40 segundos | iniciante | sem equipamento | casa, dojo, ginásio | antes de striking ou saco | Ativação > Ombros; Artes marciais > Striking | Sem potência. |
| `activation_shoulder_striking_prep` | Sombra só de mãos leve | ativação | artes marciais, cardio | ombros, punhos, escápulas | sombra técnica | leve | 2 a 4 min | iniciante | sem equipamento | casa, dojo, ginásio | antes de Boxe, Karate, Kickboxing | Aquecimento > Artes marciais; Ativação > Ombros | Mãos voltam à guarda. |
| `activation_shoulder_grappling_prep` | Frames leves em quadrupedia | ativação | artes marciais, prevenção | ombros, cotovelos, core | apoio técnico leve | leve | 1 a 2 séries de 20 a 40 segundos | iniciante | tapete opcional | casa, dojo, ginásio | antes de BJJ ou defesa pessoal | Ativação > Ombros; Artes marciais > Frames | Não bloquear cotovelos com força. |

---

# Punhos, mãos, antebraços e pega

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `warmup_wrists_support` | Rocking de punhos para apoio | aquecimento | mobilidade, prevenção | punhos, mãos | extensão em apoio | leve | 1 a 3 min | iniciante | tapete opcional | casa, ginásio, dojo | antes de flexões, prancha, BJJ ou quedas | Aquecimento > Punhos; Mobilidade > Punhos | Progressão de carga gradual. |
| `warmup_wrists_support` | Punhos para flexões na parede | aquecimento | prevenção | punhos, dedos | apoio regressivo | muito leve a leve | 1 a 2 min | iniciante | parede | casa, ginásio | antes de flexões | Aquecimento > Punhos; Musculação > Flexões | Boa regressão se punhos estão rígidos. |
| `warmup_wrists_grappling` | Punhos e dedos para grappling | aquecimento | artes marciais, prevenção | punhos, dedos, antebraços | mobilidade e descarga | leve | 2 a 4 min | iniciante | sem equipamento | dojo, casa, ginásio | antes de BJJ ou Judo | Aquecimento > Pega; Artes marciais > BJJ | Sem puxar dedos com força. |
| `warmup_grip_bjj_judo` | Aquecimento de pega com kimono | aquecimento | artes marciais | dedos, antebraços, pega | pegas leves | leve | 2 a 4 min | iniciante | kimono ou toalha | dojo, casa | antes de BJJ ou Judo | Aquecimento > Pega; Artes marciais > Judo; Artes marciais > BJJ | Não cansar antebraço. |
| `warmup_grip_bjj_judo` | Pega leve em toalha | aquecimento | prevenção, musculação | dedos, antebraços | isometria leve | leve | 1 a 2 séries de 10 a 20 segundos | iniciante | toalha | casa, ginásio, dojo | antes de puxadas, BJJ ou Judo | Aquecimento > Pega; Musculação > Antebraço | Sem falha de pega. |
| `warmup_grip_strength` | Aquecimento de pega para barras | aquecimento | musculação, prevenção | antebraços, mãos | pegas progressivas | leve | 2 a 5 min | iniciante | barra, halteres ou toalha | ginásio, casa equipada | antes de deadlift, remadas, barras ou farmer walks | Aquecimento > Pega; Musculação > Puxar | Subir carga progressivamente. |
| `warmup_finger_extensors` | Extensão de dedos com elástico leve | ativação | prevenção | extensores dos dedos | ativação leve | muito leve a leve | 1 a 2 séries de 10 a 20 | iniciante | elástico pequeno | casa, ginásio | antes ou depois de muita pega | Ativação > Dedos; Prevenção > Pega | Não levar até falha. |
| `warmup_forearm_rotation` | Pronação e supinação ativa | aquecimento | mobilidade | antebraço, cotovelo, punho | rotação ativa | muito leve | 1 a 2 min | iniciante | sem equipamento | casa, ginásio, dojo | antes de strikes, pega ou cargas | Aquecimento > Antebraço; Mobilidade > Cotovelo | Cotovelo junto ao corpo. |
| `warmup_forearm_rotation` | Pronação e supinação com halter leve | aquecimento | prevenção | antebraço | rotação resistida leve | leve | 1 a 2 séries de 8 a 12 | intermédio | halter leve | casa equipada, ginásio | antes de braços, pega ou striking | Aquecimento > Antebraço; Prevenção > Cotovelo | Carga muito leve. |
| `warmup_punching_wrists` | Alinhamento de punho na parede | aquecimento | artes marciais, prevenção | punho, mão, antebraço | alinhamento técnico | muito leve | 1 a 2 min | iniciante | parede | casa, dojo, ginásio | antes de saco ou striking | Aquecimento > Punhos; Artes marciais > Striking | Sem impacto forte. |
| `warmup_punching_wrists` | Toques leves no saco para punhos | aquecimento | artes marciais | punhos, mãos, ombros | impacto progressivo | leve | 1 a 3 min | intermédio | saco, ligaduras, luvas | ginásio, dojo | antes de saco | Aquecimento > Saco; Artes marciais > Striking | Começar muito leve. |
| `warmup_hand_contact_safety` | Checklist de mãos antes de contacto | prevenção | artes marciais | mãos, punhos, dedos | checklist de segurança | não aplicável | 1 a 2 min | iniciante | ligaduras e luvas opcionais | dojo, ginásio | antes de saco, pads ou sparring técnico | Prevenção > Mãos; Artes marciais > Segurança | Não bater se houver dor aguda no punho ou dedo. |

---

# Pés, tornozelos e perna inferior

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `warmup_feet_arch` | Short foot de aquecimento | ativação | prevenção, mobilidade | arco plantar | ativação do pé | leve | 1 a 2 séries de 6 a 10 | iniciante | sem equipamento | casa, ginásio, dojo | antes de corrida, pernas ou artes marciais | Ativação > Pés; Prevenção > Pé | Não enrolar dedos. |
| `warmup_feet_arch` | Doming do pé | ativação | prevenção | arco plantar, intrínsecos do pé | ativação do arco | leve | 1 a 2 séries de 8 a 12 | iniciante | sem equipamento | casa, ginásio | antes de corrida, saltos ou footwork | Ativação > Pés | Manter dedo grande no chão. |
| `warmup_toes_control` | Toe yoga | ativação | mobilidade, prevenção | dedos do pé | controlo de dedos | leve | 1 a 2 min | iniciante | sem equipamento | casa, ginásio | antes de corrida, equilíbrio ou artes marciais | Ativação > Dedos do pé; Mobilidade > Pés | Movimento pequeno e controlado. |
| `warmup_ankle_dorsiflexion` | Knee to wall pré-agachamento | aquecimento | mobilidade | tornozelo | dorsiflexão dinâmica | leve | 1 a 3 min | iniciante | parede | casa, ginásio | antes de squat, lunge ou corrida | Aquecimento > Tornozelo; Mobilidade > Dorsiflexão | Calcanhar no chão. |
| `warmup_ankle_stability` | Equilíbrio unipodal | ativação | prevenção | tornozelo, pé, anca | estabilidade | leve | 1 a 2 séries de 15 a 30 segundos | iniciante | sem equipamento | casa, ginásio, dojo | antes de corrida, pontapés ou mudanças de direção | Ativação > Tornozelos; Prevenção > Equilíbrio | Usar apoio se necessário. |
| `warmup_tibialis_anterior` | Elevação de tibial na parede | ativação | prevenção | tibial anterior | dorsiflexão resistida pelo corpo | leve | 1 a 2 séries de 10 a 20 | iniciante | parede | casa, ginásio | antes de corrida, passadeira ou caminhada inclinada | Ativação > Tibial anterior; Prevenção > Canela | Não levar até queimar demasiado. |
| `warmup_tibialis_anterior` | Toe raises em pé | ativação | prevenção | tibial anterior | elevação dos dedos | leve | 1 a 2 séries de 10 a 20 | iniciante | apoio opcional | casa, ginásio | antes de corrida ou footwork | Ativação > Tibial anterior | Movimento controlado. |
| `warmup_calves_achilles` | Calf raises leves | aquecimento | prevenção, musculação | gémeos, Aquiles | elevação de gémeos leve | leve | 1 a 2 séries de 10 a 15 | iniciante | apoio opcional | casa, ginásio, exterior | antes de corrida, corda ou saltos | Aquecimento > Gémeos; Prevenção > Aquiles | Não saltar para amplitude máxima. |
| `warmup_calves_achilles` | Soleus raises leves | aquecimento | prevenção | sóleo, Aquiles | elevação com joelho fletido | leve | 1 a 2 séries de 10 a 15 | intermédio | apoio opcional | casa, ginásio | antes de corrida, agachamento ou footwork | Aquecimento > Sóleo; Prevenção > Aquiles | Amplitude confortável. |
| `warmup_pogo_prep` | Pogo prep baixo | aquecimento | prevenção, pliometria | tornozelos, pés, gémeos | saltitos leves | leve | 1 a 3 séries de 10 a 20 segundos | intermédio | sem equipamento | casa, ginásio, exterior | antes de corda, corrida, saltos ou sprints | Aquecimento > Saltos; Prevenção > Tornozelo | Baixo volume. |
| `warmup_martial_footwork_feet` | Pivots controlados | aquecimento | artes marciais, mobilidade | pés, tornozelos, anca | pivot técnico | leve | 1 a 3 min | iniciante | sem equipamento | casa, dojo, ginásio | antes de Karate, Boxe, Kickboxing ou Taekwondo | Aquecimento > Footwork; Artes marciais > Footwork | Rodar o pé, não torcer o joelho. |
| `warmup_martial_footwork_feet` | Base marcial com troca de peso | aquecimento | artes marciais | pés, tornozelos, joelhos, anca | troca de peso | leve | 1 a 3 min | iniciante | sem equipamento | casa, dojo | antes de striking ou Karate | Aquecimento > Artes marciais > Bases | Joelhos alinhados. |

---

# Prevenção de ombro e cotovelo

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `prehab_shoulder_general` | Circuito leve de ombro preventivo | prevenção | ativação, mobilidade | ombro, escápulas, manguito | circuito preventivo | leve | 6 a 12 min | intermédio | elástico, parede opcional | casa, ginásio | dias de treino superior ou manutenção | Prevenção > Ombros | Não promete evitar lesões. |
| `prehab_rotator_cuff_capacity` | Rotação externa progressiva leve | prevenção | ativação | manguito rotador | força leve progressiva | leve a moderada controlada | 2 a 3 séries de 10 a 15 | intermédio | elástico ou halter leve | casa equipada, ginásio | manutenção de ombro | Prevenção > Manguito rotador | Progressão lenta, sem falha. |
| `prehab_scapular_control` | Face pull preventivo leve | prevenção | musculação acessória | costas altas, escápulas, manguito | puxada leve | leve a moderada | 2 a 3 séries de 12 a 20 | intermédio | elástico ou cabo | ginásio, casa equipada | prevenção ombro, treino superior | Prevenção > Escápulas; Musculação > Costas altas | Técnica limpa. |
| `prehab_scapular_control` | Y T W preventivo | prevenção | ativação | trapézio inferior, costas altas, ombro | controle escapular | leve | 2 a 3 séries de 5 a 10 cada | intermédio | sem equipamento ou halter leve | casa, ginásio | manutenção de ombro | Prevenção > Ombros; Prevenção > Escápulas | Não fazer pesado. |
| `prehab_elbow_tendon_capacity` | Isometria leve de flexão do cotovelo | prevenção | ativação | cotovelo, bíceps, tendões | isometria leve | leve | 2 a 4 holds de 10 a 20 segundos | iniciante | parede, toalha ou halter leve | casa, ginásio | prevenção cotovelo, puxadas | Prevenção > Cotovelos | Sem dor tendinosa crescente. |
| `prehab_elbow_tendon_capacity` | Isometria leve de extensão do cotovelo | prevenção | ativação | cotovelo, tríceps, tendões | isometria leve | leve | 2 a 4 holds de 10 a 20 segundos | iniciante | parede ou elástico | casa, ginásio | prevenção cotovelo, empurrar | Prevenção > Cotovelos | Não bloquear agressivamente. |
| `prehab_wrist_elbow_chain` | Circuito punho-cotovelo leve | prevenção | aquecimento | punho, antebraço, cotovelo | mobilidade e ativação | leve | 4 a 8 min | iniciante | elástico opcional | casa, ginásio, dojo | antes de pega, flexões ou grappling | Prevenção > Punho-cotovelo | Dedos e tendões com baixa carga. |
| `prehab_striking_shoulders_elbows` | Sequência preventiva para striking | prevenção | artes marciais, ativação | ombros, cotovelos, punhos | ativação leve e técnica | leve | 6 a 10 min | iniciante | elástico, parede opcional | dojo, casa, ginásio | antes de saco, Boxe, Karate ou Kickboxing | Prevenção > Striking; Artes marciais > Segurança | Impacto só depois da preparação. |
| `prehab_grappling_shoulders_elbows` | Sequência preventiva para grappling | prevenção | artes marciais, ativação | ombros, cotovelos, punhos, pega | apoios e isometrias leves | leve | 6 a 10 min | iniciante | tapete opcional | dojo, casa, ginásio | antes de BJJ ou Judo | Prevenção > Grappling; Artes marciais > BJJ | Não bloquear articulações contra pressão. |
| `prehab_overhead_shoulder` | Wall slide e rotação externa | prevenção | aquecimento, ativação | ombro overhead, escápulas | mobilidade e manguito | leve | 4 a 8 min | iniciante | parede, elástico opcional | casa, ginásio | antes de overhead press | Prevenção > Overhead; Aquecimento > Ombros | Sem pinçamento. |
| `prehab_shoulder_general` | Scapular push-up preventivo | prevenção | ativação | serrátil, escápulas | protração controlada | leve a moderada | 2 a 3 séries de 8 a 15 | iniciante | tapete opcional | casa, ginásio | manutenção de ombro, empurrar | Prevenção > Ombros; Ativação > Serrátil | Não cansar antes do treino principal. |
| `prehab_rotator_cuff_capacity` | Rotação externa isométrica semanal | prevenção | ativação | manguito rotador | isometria | leve a moderada controlada | 2 a 3 séries de 10 a 20 segundos | iniciante | parede ou elástico | casa, ginásio | manutenção de ombro | Prevenção > Manguito rotador | Sem dor articular. |

---

# Prevenção de lombar, anca e joelho

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `prehab_low_back_control` | Hinge drill com cabo de vassoura | prevenção | aquecimento, mobilidade | lombar, anca, posterior | padrão técnico | leve | 1 a 3 séries de 6 a 10 | iniciante | cabo de vassoura opcional | casa, ginásio | antes de peso morto ou trabalho físico | Prevenção > Lombar; Aquecimento > Dobradiça | Coluna neutra. |
| `prehab_low_back_control` | Dead bug preventivo | prevenção | ativação, core | core, lombar, pélvis | controlo anti-extensão | leve | 2 a 3 séries de 6 a 10 por lado | iniciante | tapete opcional | casa, ginásio | manutenção lombar, treino geral | Prevenção > Lombar; Core > Estabilidade | Sem arquear lombar. |
| `prehab_hip_control` | Hip airplane assistido preventivo | prevenção | mobilidade, ativação | anca, glúteos, equilíbrio | controlo de anca | leve a moderada | 2 a 3 séries de 3 a 6 por lado | intermédio | apoio opcional | casa, ginásio | corrida, pernas, pontapés | Prevenção > Anca | Usar apoio. |
| `prehab_knee_tracking` | Step down controlado | prevenção | musculação, mobilidade | joelho, anca, tornozelo | controlo excêntrico | leve a moderada | 2 a 3 séries de 5 a 8 por lado | intermédio | degrau | casa, ginásio | prevenção joelho, corrida, pernas | Prevenção > Joelho; Musculação > Pernas | Joelho acompanha pé. |
| `prehab_knee_tracking` | Agachamento para caixa controlado | prevenção | aquecimento, musculação | joelho, anca | padrão controlado | leve | 2 a 3 séries de 6 a 10 | iniciante | caixa, banco ou cadeira | casa, ginásio | prevenção joelho, squat | Prevenção > Joelho; Aquecimento > Agachamento | Não colapsar joelhos. |
| `prehab_adductor_capacity` | Copenhagen regressão de joelho apoiado | prevenção | musculação | adutores, core lateral | isometria regressiva | leve a moderada | 2 a 3 séries de 8 a 20 segundos | intermédio | banco | ginásio, casa equipada | BJJ, pontapés, mudanças de direção | Prevenção > Adutores | Progressão lenta. |
| `prehab_adductor_capacity` | Adductor squeeze preventivo | prevenção | ativação | adutores | isometria leve | leve | 2 a 3 séries de 10 a 20 segundos | iniciante | bola ou almofada | casa, ginásio | virilha sensível, BJJ, pernas | Prevenção > Adutores | Contração controlada. |
| `prehab_hamstring_capacity` | Hip hinge unilateral assistido | prevenção | musculação, mobilidade | posterior de coxa, glúteos | controlo unilateral | leve | 2 a 3 séries de 5 a 8 por lado | intermédio | apoio opcional | casa, ginásio | corrida, sprints, peso morto | Prevenção > Posterior de coxa | Sem arredondar lombar. |
| `prehab_hamstring_capacity` | Nordic regressão isométrica | prevenção | musculação | posterior de coxa | isometria excêntrica regressiva | moderada controlada | 2 a 3 séries de 5 a 10 segundos | avançado | apoio para pés ou parceiro | ginásio | prevenção posterior, corrida | Prevenção > Posterior de coxa | Avançado. Não fazer frio. |
| `prehab_glute_med_knee` | Monster walk preventivo | prevenção | ativação | glúteo médio, joelho | abdução dinâmica | leve a moderada | 2 a 3 séries de 8 a 12 passos | intermédio | mini band | casa, ginásio | prevenção joelho, corrida, pernas | Prevenção > Joelho; Ativação > Glúteo médio | Joelhos alinhados. |
| `prehab_single_leg_control` | Split squat controlado | prevenção | musculação | joelho, anca, equilíbrio | controlo unilateral | leve a moderada | 2 a 3 séries de 6 a 10 por lado | iniciante | sem equipamento | casa, ginásio | prevenção joelho, lunge | Prevenção > Unilateral; Musculação > Pernas | Amplitude confortável. |
| `prehab_lumbopelvic_for_grappling` | Bird dog e shrimp leve | prevenção | artes marciais, mobilidade | lombar, anca, core | controlo lombo-pélvico | leve | 5 a 8 min | iniciante | tapete opcional | dojo, casa, ginásio | antes de BJJ ou treino de solo | Prevenção > Grappling; Artes marciais > BJJ | Movimento técnico, sem pressa. |

---

# Prevenção de tornozelo, pé e Aquiles

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `prehab_ankle_stability` | Equilíbrio unipodal preventivo | prevenção | ativação | tornozelo, pé, anca | estabilidade | leve | 2 a 3 séries de 20 a 40 segundos | iniciante | sem equipamento | casa, ginásio, dojo | corrida, footwork, pernas | Prevenção > Tornozelo; Prevenção > Equilíbrio | Usar apoio se necessário. |
| `prehab_foot_intrinsics` | Short foot preventivo | prevenção | ativação | arco plantar, pé | controlo do arco | leve | 2 a 3 séries de 6 a 12 | iniciante | sem equipamento | casa, ginásio | corrida, trabalho em pé, artes marciais | Prevenção > Pé | Não enrolar dedos. |
| `prehab_foot_intrinsics` | Toe yoga preventivo | prevenção | mobilidade | dedos do pé, arco | controlo de dedos | leve | 2 a 4 min | iniciante | sem equipamento | casa | prevenção do pé, equilíbrio | Prevenção > Pé; Mobilidade > Dedos | Controlo antes de velocidade. |
| `prehab_tibialis_capacity` | Elevação de tibial progressiva | prevenção | musculação leve | tibial anterior | força leve | leve a moderada | 2 a 3 séries de 12 a 20 | iniciante | parede ou tib bar opcional | casa, ginásio | corrida, passadeira, canelas | Prevenção > Tibial anterior | Progressão lenta. |
| `prehab_calf_capacity` | Calf raise controlado | prevenção | musculação | gémeos, Aquiles | elevação de gémeos | leve a moderada | 2 a 3 séries de 8 a 15 | iniciante | apoio opcional | casa, ginásio | corrida, corda, saltos | Prevenção > Gémeos; Musculação > Perna inferior | Não fazer com dor no Aquiles. |
| `prehab_calf_capacity` | Soleus raise controlado | prevenção | musculação | sóleo, Aquiles | elevação com joelho fletido | leve a moderada | 2 a 3 séries de 10 a 20 | intermédio | cadeira ou máquina | casa, ginásio | corrida, agachamento, footwork | Prevenção > Sóleo | Carga progressiva. |
| `prehab_achilles_progression` | Isometria de gémeos em meia ponta | prevenção | tendão, musculação | Aquiles, gémeos | isometria | leve a moderada controlada | 2 a 4 holds de 10 a 30 segundos | intermédio | apoio opcional | casa, ginásio | tolerância do Aquiles | Prevenção > Aquiles | Sem dor crescente. |
| `prehab_landing_mechanics` | Aterragem suave de baixa altura | prevenção | pliometria, aquecimento | pé, tornozelo, joelho, anca | aterragem técnica | leve a moderada | 2 a 3 séries de 3 a 5 | intermédio | degrau baixo opcional | ginásio, exterior | saltos, mudanças de direção | Prevenção > Aterragem | Joelho alinhado e aterragem silenciosa. |
| `prehab_running_lower_leg` | Circuito perna inferior para corrida | prevenção | aquecimento | pé, tibial, gémeos, tornozelo | ativação e mobilidade | leve | 6 a 10 min | iniciante | sem equipamento | casa, ginásio, exterior | antes de corrida | Prevenção > Corrida; Aquecimento > Corrida | Baixo volume. |
| `prehab_martial_footwork_lower_leg` | Circuito tornozelo para footwork marcial | prevenção | artes marciais, aquecimento | pés, tornozelos, joelhos | pivots, equilíbrio e saltitos leves | leve | 5 a 8 min | iniciante | sem equipamento | dojo, casa, ginásio | antes de Karate, Boxe, Kickboxing ou Taekwondo | Prevenção > Footwork; Artes marciais > Footwork | Não torcer joelho. |

---

# Aquecimento por padrão de movimento

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `warmup_pattern_squat` | Aquecimento específico para agachamento | aquecimento | mobilidade, ativação, musculação | tornozelo, anca, joelho, core | mobilidade, ativação e séries técnicas | leve a moderada | 8 a 15 min | iniciante | opcional | ginásio, casa | antes de agachamento | Aquecimento > Padrão > Agachamento | Preparar padrão, não cansar pernas. |
| `warmup_pattern_squat` | Squat sem carga com pausa | aquecimento | musculação | anca, joelho, tornozelo | padrão técnico | leve | 1 a 3 séries de 5 a 8 | iniciante | sem equipamento | casa, ginásio | antes de squat ou leg day | Aquecimento > Agachamento | Joelhos acompanham pés. |
| `warmup_pattern_hinge` | Aquecimento específico para hinge | aquecimento | mobilidade, ativação, musculação | posterior, glúteos, lombar, core | hinge técnico | leve a moderada | 8 a 15 min | iniciante | cabo de vassoura opcional | ginásio, casa | antes de peso morto, RDL ou good morning | Aquecimento > Padrão > Dobradiça | Coluna neutra. |
| `warmup_pattern_hinge` | Good morning sem carga | aquecimento | musculação | posterior, glúteos, lombar | padrão técnico | leve | 1 a 2 séries de 8 a 12 | iniciante | sem equipamento ou cabo de vassoura | casa, ginásio | antes de hinge | Aquecimento > Dobradiça | Amplitude pequena no início. |
| `warmup_pattern_push` | Aquecimento específico para empurrar | aquecimento | ativação, musculação | peito, ombros, tríceps, escápulas, punhos | ativação e séries técnicas | leve a moderada | 8 a 12 min | iniciante | elástico, parede opcional | ginásio, casa | antes de supino, flexões ou press | Aquecimento > Padrão > Empurrar | Ombros sem pinçamento. |
| `warmup_pattern_push` | Flexão inclinada leve | aquecimento | musculação, ativação | peito, ombros, tríceps, core | padrão técnico regressivo | leve | 1 a 2 séries de 5 a 10 | iniciante | parede, banco ou apoio | casa, ginásio | antes de flexões, supino ou dips | Aquecimento > Empurrar | Não chegar perto da falha. |
| `warmup_pattern_pull` | Aquecimento específico para puxar | aquecimento | ativação, musculação | costas, escápulas, bíceps, pega | ativação e séries técnicas | leve a moderada | 8 a 12 min | iniciante | elástico, barra opcional | ginásio, casa equipada | antes de remadas, puxadas ou barras | Aquecimento > Padrão > Puxar | Não cansar pega. |
| `warmup_pattern_pull` | Remada elástico leve | aquecimento | musculação, ativação | costas, escápulas, bíceps | puxada leve | leve | 1 a 2 séries de 10 a 15 | iniciante | elástico | casa equipada, ginásio | antes de treino de costas | Aquecimento > Puxar; Ativação > Costas | Foco em escápulas. |
| `warmup_pattern_lunge` | Aquecimento específico para lunge | aquecimento | prevenção, musculação | anca, joelho, tornozelo, equilíbrio | padrão unilateral | leve | 1 a 3 séries de 5 a 8 por lado | iniciante | sem equipamento | casa, ginásio | antes de lunges ou split squat | Aquecimento > Padrão > Lunge | Passo estável. |
| `warmup_pattern_carry` | Aquecimento específico para carries | aquecimento | ativação, musculação | pega, core, escápulas, postura | carry leve | leve | 2 a 4 séries curtas | intermédio | halteres ou kettlebells leves | ginásio, casa equipada | antes de farmer walks ou carries | Aquecimento > Padrão > Carry | Cargas leves. |
| `warmup_pattern_rotation` | Aquecimento específico para rotação | aquecimento | core, artes marciais | torácica, anca, core | rotação técnica | leve | 3 a 6 min | iniciante | sem equipamento ou elástico leve | casa, ginásio, dojo | antes de golpes, remadas ou mudanças de direção | Aquecimento > Padrão > Rotação | Rodar anca e torácica, não torcer lombar. |
| `warmup_pattern_jump_land` | Aterragem e pogo prep | aquecimento | prevenção, pliometria | pés, tornozelos, joelhos, anca | preparação elástica | leve a moderada | 4 a 8 min | intermédio | sem equipamento | ginásio, exterior, dojo | antes de saltos, sprints ou HIIT | Aquecimento > Saltos; Prevenção > Aterragem | Baixo volume e progressivo. |

---

# Aquecimento específico para musculação

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `warmup_strength_ramp_sets` | Séries de aproximação | aquecimento | musculação | padrão e músculo alvo | carga progressiva | leve a moderada | 3 a 6 séries progressivas | iniciante | equipamento do exercício | ginásio, casa equipada | antes de séries principais | Aquecimento > Musculação > Séries de aproximação | Não falhar séries de aquecimento. |
| `warmup_strength_ramp_sets` | Série técnica com 40 a 60 por cento da carga | aquecimento | musculação | padrão do exercício | série técnica | leve a moderada | 1 a 3 séries de 3 a 8 | intermédio | equipamento do exercício | ginásio, casa equipada | antes de força ou hipertrofia | Aquecimento > Musculação | Técnica perfeita. |
| `warmup_strength_upper_push` | Aquecimento para supino | aquecimento | musculação, ativação | peito, ombros, tríceps, escápulas | cardio leve, ombro, séries de aproximação | leve a moderada | 8 a 15 min | iniciante | barra, halteres ou máquina | ginásio, casa equipada | antes de supino | Aquecimento > Musculação > Peito | Ombros estáveis. |
| `warmup_strength_upper_push` | Aquecimento para flexões | aquecimento | musculação, ativação | peito, ombros, tríceps, core, punhos | punhos, escápulas e flexões regressivas | leve | 5 a 10 min | iniciante | parede ou banco opcional | casa, ginásio | antes de flexões | Aquecimento > Musculação > Flexões | Punhos preparados. |
| `warmup_strength_upper_pull` | Aquecimento para remadas | aquecimento | musculação, ativação | costas, escápulas, bíceps, pega | ativação escapular e puxadas leves | leve a moderada | 8 a 12 min | iniciante | elástico, halteres ou máquina | ginásio, casa equipada | antes de remadas | Aquecimento > Musculação > Costas | Não cansar lombar ou pega. |
| `warmup_strength_upper_pull` | Aquecimento para barras | aquecimento | musculação, ativação | dorsal, escápulas, bíceps, pega | depressão escapular e progressões | leve a moderada | 8 a 12 min | intermédio | barra fixa, elástico opcional | ginásio, exterior, casa equipada | antes de pull-ups | Aquecimento > Musculação > Barras | Evitar saltar direto para esforço máximo. |
| `warmup_strength_shoulders` | Aquecimento para ombro | aquecimento | ativação, prevenção | manguito, escápulas, deltoides | mobilidade e ativação leve | leve | 8 a 12 min | iniciante | elástico, parede opcional | casa, ginásio | antes de shoulder press ou laterais | Aquecimento > Musculação > Ombros | Manguito sem fadiga. |
| `warmup_strength_arms` | Aquecimento para braços | aquecimento | musculação, prevenção | bíceps, tríceps, cotovelos, punhos | mobilidade e séries leves | leve | 5 a 10 min | iniciante | halteres leves, elástico opcional | casa, ginásio | antes de bíceps ou tríceps | Aquecimento > Musculação > Braços | Cotovelo sem dor. |
| `warmup_strength_squat_day` | Aquecimento para dia de squat | aquecimento | musculação, mobilidade, ativação | tornozelo, anca, joelho, core | mobilidade, glúteos e séries de aproximação | leve a moderada | 10 a 18 min | iniciante | barra ou equipamento do exercício | ginásio, casa equipada | antes de squat | Aquecimento > Musculação > Pernas > Squat | Não cansar pernas antes da carga. |
| `warmup_strength_hinge_day` | Aquecimento para dia de deadlift | aquecimento | musculação, ativação | posterior, glúteos, lombar, core, pega | hinge, core e séries de aproximação | leve a moderada | 10 a 18 min | intermédio | barra, halteres ou cabo de vassoura | ginásio, casa equipada | antes de deadlift ou RDL | Aquecimento > Musculação > Dobradiça | Coluna neutra e pega preparada. |
| `warmup_strength_core_day` | Aquecimento para treino de core | aquecimento | ativação | core, pélvis, respiração | respiração, dead bug, prancha curta | leve | 5 a 8 min | iniciante | tapete opcional | casa, ginásio | antes de core | Aquecimento > Core | Não fatigar antes dos exercícios principais. |
| `warmup_strength_upper_push` | Ramp-up para press vertical | aquecimento | musculação, prevenção | ombros, tríceps, escápulas, core | overhead prep e séries leves | leve a moderada | 8 a 12 min | intermédio | barra, halteres ou elástico | ginásio, casa equipada | antes de overhead press | Aquecimento > Musculação > Ombros > Press | Costelas controladas. |

---

# Aquecimento específico para cardio, corrida e HIIT

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `warmup_cardio_easy_start` | Entrada progressiva no cardio | aquecimento | cardio | cardiovascular | progressão de ritmo | muito leve a moderada | 5 a 10 min | iniciante | opcional | ginásio, exterior, casa | antes de cardio contínuo | Aquecimento > Cardio | Subir ritmo aos poucos. |
| `warmup_running_general` | Aquecimento para corrida exterior | aquecimento | cardio, prevenção | pés, tornozelos, gémeos, anca, respiração | caminhada, mobilidade e jog leve | leve a moderada | 8 a 15 min | iniciante | sem equipamento | exterior | antes de corrida | Aquecimento > Corrida | Não começar a correr forte a frio. |
| `warmup_treadmill_running` | Aquecimento para passadeira | aquecimento | cardio | cardiovascular, pernas | caminhada e corrida progressiva | leve a moderada | 5 a 12 min | iniciante | passadeira | ginásio, casa equipada | antes de passadeira | Aquecimento > Passadeira | Aumentar velocidade de forma gradual. |
| `warmup_jump_rope` | Aquecimento para corda | aquecimento | cardio, prevenção | pés, tornozelos, gémeos, ombros | pés, gémeos e corda leve | leve | 5 a 10 min | intermédio | corda | casa, ginásio, dojo, exterior | antes de saltar à corda | Aquecimento > Corda | Baixo volume inicial. |
| `warmup_jump_rope` | Corda progressiva por blocos | aquecimento | cardio | tornozelos, ritmo | blocos progressivos | leve a moderada | 4 a 8 min | intermédio | corda | ginásio, exterior, dojo | antes de sessão de corda | Aquecimento > Corda; Cardio > Corda | Sem double unders frios. |
| `warmup_hiit_progressive` | Aquecimento para HIIT peso corporal | aquecimento | cardio, prevenção | cardiovascular, articulações, core | mobilidade, técnica e ramp-up | leve a moderada | 8 a 15 min | intermédio | sem equipamento | casa, ginásio, exterior | antes de HIIT | Aquecimento > HIIT | Não saltar para intensidade máxima. |
| `warmup_hiit_progressive` | Ramp-up de HIIT em máquina | aquecimento | cardio | cardiovascular, pernas | intervalos leves progressivos | leve a moderada | 6 a 12 min | intermédio | bicicleta, remo ou air bike | ginásio | antes de HIIT em máquina | Aquecimento > HIIT; Cardio > Intervalado | Primeiros intervalos não são máximos. |
| `warmup_sprints_progressive` | Aquecimento para sprints | aquecimento | prevenção, cardio | posterior, gémeos, anca, sistema nervoso | mobilidade, skips e acelerações progressivas | leve a moderada | 12 a 20 min | avançado | sem equipamento | exterior, pista, ginásio | antes de sprints | Aquecimento > Sprints | Obrigatório aquecer bem. |
| `warmup_sprints_progressive` | Acelerações progressivas | aquecimento | cardio, prevenção | corrida, sistema nervoso | aceleração submáxima | moderada controlada | 3 a 6 repetições curtas | intermédio | sem equipamento | exterior, pista | antes de sprints ou corrida rápida | Aquecimento > Sprints; Primer neural | Nunca começar na velocidade máxima. |
| `warmup_agility_cod` | Aquecimento para mudanças de direção | aquecimento | prevenção, cardio | joelho, anca, tornozelo, travagem | drills progressivos | leve a moderada | 8 a 15 min | intermédio | cones opcionais | exterior, ginásio, dojo | antes de shuttle runs ou artes marciais | Aquecimento > Mudanças de direção | Travagens controladas. |
| `warmup_low_impact_cardio` | Aquecimento para bicicleta ou elíptica | aquecimento | cardio | cardiovascular, pernas | entrada progressiva | muito leve a leve | 5 a 8 min | iniciante | bicicleta ou elíptica | ginásio, casa equipada | antes de cardio baixo impacto | Aquecimento > Cardio baixo impacto | Começar com resistência baixa. |
| `warmup_low_impact_cardio` | Aquecimento para remo ergómetro | aquecimento | cardio, técnica | pernas, costas, core | técnica leve progressiva | leve | 5 a 8 min | intermédio | remo ergómetro | ginásio | antes de remo | Aquecimento > Remo | Técnica antes de ritmo. |

---

# Aquecimento específico para artes marciais

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `warmup_martial_general` | Aquecimento marcial geral | aquecimento | artes marciais, mobilidade, ativação | corpo inteiro | cardio leve, mobilidade e técnica | leve a moderada | 10 a 18 min | iniciante | sem equipamento | dojo, casa, ginásio | antes de qualquer arte marcial | Aquecimento > Artes marciais | Preparar a arte do dia. |
| `warmup_karate` | Aquecimento para Karate | aquecimento | artes marciais | anca, joelhos, tornozelos, ombros, core | bases, footwork, sombra leve | leve a moderada | 10 a 15 min | iniciante | sem equipamento | dojo, casa | antes de Karate | Aquecimento > Artes marciais > Karate | Técnica antes de velocidade. |
| `warmup_karate` | Bases de Karate progressivas | aquecimento | artes marciais, prevenção | anca, joelhos, pés | bases e deslocamentos leves | leve | 3 a 6 min | iniciante | sem equipamento | dojo, casa | antes de kihon ou kumite técnico | Aquecimento > Karate > Bases | Joelhos alinhados. |
| `warmup_bjj` | Aquecimento para BJJ | aquecimento | artes marciais, mobilidade, prevenção | pescoço, ombros, punhos, anca, core | solo, mobilidade, pega leve | leve a moderada | 10 a 18 min | iniciante | tapete opcional | dojo, casa | antes de Jiu-Jitsu / BJJ | Aquecimento > Artes marciais > BJJ | Pescoço e dedos com cuidado. |
| `warmup_bjj` | Solo leve de BJJ | aquecimento | artes marciais, mobilidade | anca, core, ombros | shrimp, ponte, technical stand-up | leve | 5 a 10 min | iniciante | tatami ou tapete | dojo, casa | antes de BJJ ou defesa pessoal | Aquecimento > BJJ > Solo | Movimento técnico. |
| `warmup_boxing` | Aquecimento para Boxe | aquecimento | artes marciais, cardio | ombros, punhos, escápulas, pés | footwork, sombra leve, punhos | leve a moderada | 8 a 15 min | iniciante | sem equipamento, corda opcional | dojo, ginásio, casa | antes de Boxe | Aquecimento > Artes marciais > Boxe | Mãos voltam à guarda. |
| `warmup_boxing` | Footwork de Boxe progressivo | aquecimento | artes marciais, cardio | pés, tornozelos, anca | passos e pivots leves | leve | 3 a 6 min | iniciante | sem equipamento | casa, dojo, ginásio | antes de Boxe ou saco | Aquecimento > Boxe > Footwork | Não cruzar pés. |
| `warmup_kickboxing_muaythai` | Aquecimento para Kickboxing e Muay Thai | aquecimento | artes marciais | anca, tornozelos, ombros, punhos, gémeos | sombra, checks, câmaras e footwork | leve a moderada | 10 a 18 min | iniciante | sem equipamento | dojo, ginásio, casa | antes de Kickboxing ou Muay Thai | Aquecimento > Artes marciais > Kickboxing; Aquecimento > Muay Thai | Pontapés progressivos. |
| `warmup_kickboxing_muaythai` | Checks e teeps leves | aquecimento | artes marciais | anca, tornozelo, core | técnica leve | leve | 3 a 6 min | iniciante | apoio opcional | dojo, ginásio | antes de Muay Thai ou Kickboxing | Aquecimento > Muay Thai; Artes marciais > Pontapés | Equilíbrio primeiro. |
| `warmup_judo` | Aquecimento para Judo | aquecimento | artes marciais, prevenção | pescoço, ombros, anca, pegada, queda | ukemi, pegada e entradas leves | leve a moderada | 12 a 20 min | iniciante | tatami, kimono opcional | dojo, tatami | antes de Judo | Aquecimento > Artes marciais > Judo | Ukemi progressivo obrigatório. |
| `warmup_judo` | Ukemi progressivo | aquecimento | artes marciais, prevenção | corpo inteiro, quedas | queda segura progressiva | leve a moderada | 5 a 10 min | iniciante | tatami | dojo, tatami | antes de quedas ou projeções | Aquecimento > Judo > Ukemi | Superfície segura. |
| `warmup_taekwondo` | Aquecimento para Taekwondo | aquecimento | artes marciais, mobilidade | anca, posterior, adutores, equilíbrio | mobilidade dinâmica e pontapés leves | leve a moderada | 10 a 18 min | iniciante | apoio opcional | dojo, casa, ginásio | antes de Taekwondo | Aquecimento > Artes marciais > Taekwondo | Altura dos pontapés progressiva. |
| `warmup_taekwondo` | Câmaras de pontapé progressivas | aquecimento | artes marciais, ativação | anca, flexores da anca, equilíbrio | câmara ativa | leve | 3 a 6 min | iniciante | apoio opcional | dojo, casa | antes de pontapés | Aquecimento > Pontapés; Ativação > Flexores da anca | Não forçar altura. |
| `warmup_self_defense` | Aquecimento para defesa pessoal funcional | aquecimento | artes marciais, prevenção | guarda, pés, anca, chão | guarda, saída, technical stand-up | leve | 8 a 12 min | iniciante | sem equipamento | casa, dojo, ginásio | antes de defesa pessoal | Aquecimento > Defesa pessoal funcional | Objetivo é segurança e saída. |
| `warmup_self_defense` | Guarda, saída e levantar do chão | aquecimento | artes marciais, mobilidade | global, anca, punhos, core | sequência técnica leve | leve | 5 a 8 min | iniciante | tapete opcional | casa, dojo | antes de defesa pessoal ou BJJ | Aquecimento > Defesa pessoal > Technical stand-up | Sem simular luta intensa. |

---

# Primer neural, coordenação e técnica

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `warmup_neural_primer_general` | Primer neural geral curto | aquecimento | coordenação | sistema nervoso, corpo inteiro | repetições técnicas rápidas submáximas | leve a moderada | 3 a 6 min | intermédio | opcional | ginásio, dojo, exterior | antes de força, sprints ou artes marciais | Aquecimento > Primer neural | Sem fadiga. |
| `warmup_neural_speed_submax` | Repetições rápidas submáximas | aquecimento | técnica | sistema nervoso, padrão alvo | velocidade controlada | moderada controlada | 2 a 5 séries curtas | intermédio | depende do exercício | ginásio, dojo, exterior | antes de movimentos explosivos | Aquecimento > Velocidade submáxima | Rápido mas limpo. |
| `warmup_neural_balance` | Equilíbrio unilateral como primer | ativação | prevenção | pé, tornozelo, anca, core | equilíbrio | leve | 1 a 2 séries de 15 a 30 segundos | iniciante | sem equipamento | casa, ginásio, dojo | antes de pontapés, corrida ou lunges | Ativação > Equilíbrio; Primer neural | Usar apoio se necessário. |
| `warmup_neural_reaction` | Reação leve com comandos | aquecimento | artes marciais, coordenação | sistema nervoso, footwork | drill de reação | leve a moderada | 2 a 5 min | intermédio | parceiro opcional | dojo, ginásio | antes de artes marciais ou agilidade | Aquecimento > Reação; Artes marciais > Timing | Sem contacto forte. |
| `warmup_neural_technique_rehearsal` | Ensaio técnico do exercício principal | aquecimento | musculação, artes marciais | padrão alvo | repetição técnica | leve | 2 a 5 séries leves | iniciante | equipamento do exercício | ginásio, casa, dojo | antes de exercício principal | Aquecimento > Ensaio técnico | Técnica perfeita. |
| `warmup_neural_potentiation_strength` | Potenciação leve para força | aquecimento | musculação | sistema nervoso, padrão pesado | ramp-up técnico | moderada controlada | 2 a 4 séries curtas | avançado | barra, halteres ou máquina | ginásio | antes de força pesada | Aquecimento > Força > Potenciação | Não cansar antes da série principal. |
| `warmup_neural_martial_timing` | Timing marcial leve | aquecimento | artes marciais | timing, distância, footwork | drill técnico | leve | 3 a 6 min | intermédio | parceiro opcional | dojo, ginásio | antes de kumite, sparring técnico ou pads | Aquecimento > Artes marciais > Timing | Controlo obrigatório. |
| `warmup_neural_agility` | Agilidade progressiva com cones | aquecimento | cardio, prevenção | tornozelos, joelhos, anca, sistema nervoso | drill de agilidade | leve a moderada | 5 a 10 min | intermédio | cones opcionais | ginásio, exterior, dojo | antes de mudanças de direção | Aquecimento > Agilidade | Travagem progressiva. |
| `warmup_neural_agility` | Passos laterais progressivos | aquecimento | prevenção, artes marciais | anca, joelhos, tornozelos | lateralidade | leve | 2 a 5 min | iniciante | sem equipamento | casa, dojo, ginásio | antes de footwork ou agilidade | Aquecimento > Lateralidade | Não deixar joelhos colapsarem. |
| `warmup_neural_speed_submax` | Aceleração técnica curta | aquecimento | cardio, prevenção | corrida, sistema nervoso | aceleração submáxima | moderada controlada | 3 a 5 repetições curtas | intermédio | sem equipamento | exterior, pista | antes de corrida rápida ou sprints | Aquecimento > Sprints; Primer neural | Nunca começar máximo. |

---

# Prevenção e preparação contextual

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `prehab_context_stiff_shoulders` | Preparação para ombros rígidos | prevenção | aquecimento, mobilidade | ombros, escápulas, torácica | mobilidade e ativação leve | muito leve a leve | 6 a 10 min | iniciante | parede, elástico opcional | casa, ginásio | antes de treino superior com rigidez | Prevenção contextual > Ombros rígidos | Sem pinçamento. |
| `prehab_context_low_back_stiffness` | Preparação para lombar rígida | prevenção | aquecimento, recuperação | lombar, pélvis, anca, core | respiração, mobilidade e core leve | muito leve a leve | 6 a 12 min | iniciante | tapete opcional | casa, ginásio | antes de treino com lombar rígida | Prevenção contextual > Lombar rígida | Dor irradiada muda o plano. |
| `prehab_context_knee_sensitivity` | Preparação para joelho sensível | prevenção | aquecimento | joelho, anca, tornozelo | mobilidade, ativação e padrão regressivo | leve | 8 a 12 min | iniciante | apoio opcional | casa, ginásio | antes de pernas com joelho sensível | Prevenção contextual > Joelho | Sem treinar por cima de dor forte. |
| `prehab_context_tight_hips` | Preparação para anca rígida | prevenção | mobilidade, ativação | anca, glúteos, adutores | mobilidade e ativação de anca | leve | 6 a 12 min | iniciante | tapete opcional | casa, ginásio, dojo | antes de pernas, BJJ ou pontapés | Prevenção contextual > Anca rígida | Joelhos protegidos. |
| `prehab_context_tight_calves` | Preparação para gémeos tensos | prevenção | aquecimento, mobilidade | gémeos, sóleo, tornozelo, Aquiles | mobilidade e ativação leve | leve | 5 a 10 min | iniciante | parede opcional | casa, ginásio, exterior | antes de corrida, corda ou footwork | Prevenção contextual > Gémeos tensos | Evitar saltos fortes a frio. |
| `prehab_context_grip_fatigue` | Preparação quando a pega está cansada | prevenção | recuperação, aquecimento | mãos, punhos, antebraços | descarga e aquecimento leve | muito leve a leve | 4 a 8 min | iniciante | elástico opcional | casa, ginásio, dojo | antes de puxadas ou grappling com pega cansada | Prevenção contextual > Pega | Reduzir carga se pega falhar. |
| `prehab_context_post_computer_training` | Preparação pós-computador antes de treinar | aquecimento | recuperação, mobilidade | pescoço, peito, torácica, anca, punhos | reset postural e ativação leve | leve | 8 a 12 min | iniciante | parede opcional | casa, ginásio | antes de treinar depois de horas sentado | Aquecimento > Pós-computador | Não ir direto para cargas pesadas. |
| `prehab_context_hot_weather` | Aquecimento adaptado a dias de calor | aquecimento | segurança | cardiovascular, hidratação, temperatura | aquecimento reduzido e progressivo | muito leve a leve | 3 a 8 min | iniciante | opcional | casa, ginásio, exterior | treino em calor | Aquecimento > Calor; Segurança | Reduzir duração e controlar sinais de sobreaquecimento. |
| `prehab_context_stiff_shoulders` | Wall slides pós-computador pré-treino | aquecimento | mobilidade, prevenção | ombros, torácica, escápulas | mobilidade leve | leve | 2 a 4 min | iniciante | parede | casa, ginásio | antes de treino superior depois de PC | Aquecimento > Ombros; Pós-computador | Costelas controladas. |
| `prehab_context_low_back_stiffness` | Respiração e pelvic tilts pré-treino | aquecimento | recuperação, core | lombar, pélvis, respiração | reset lombo-pélvico | muito leve | 3 a 6 min | iniciante | tapete opcional | casa, ginásio | antes de treinar com lombar rígida | Aquecimento > Lombar; Recuperação > Lombar | Sem forçar amplitude. |

---

# Checklists de prontidão e segurança

| Concept ID | Exercício | Domínio principal | Domínios secundários | Zona ou sistema alvo | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `readiness_check_general` | Check-in geral antes do treino | prevenção | gestão de carga | energia, sono, dor, objetivo | checklist | não aplicável | 1 a 2 min | iniciante | sem equipamento | qualquer local | antes de qualquer treino | Prevenção > Check de prontidão | Não é exercício físico. |
| `readiness_check_joint_pain` | Check de dor articular | prevenção | segurança | articulações | triagem | não aplicável | 1 a 2 min | iniciante | sem equipamento | qualquer local | antes de treinar com dor | Prevenção > Segurança > Dor articular | Dor articular forte exige regressão ou pausa. |
| `readiness_check_tendon` | Check de tendões | prevenção | segurança | tendões | triagem | não aplicável | 1 a 2 min | iniciante | sem equipamento | qualquer local | antes de carga repetida | Prevenção > Segurança > Tendões | Tendão irritado não gosta de agressividade. |
| `readiness_check_martial_contact` | Check antes de contacto marcial | prevenção | artes marciais, segurança | cabeça, pescoço, mãos, joelhos, fadiga | checklist | não aplicável | 2 a 4 min | iniciante | sem equipamento | dojo, ginásio | antes de sparring, saco ou quedas | Prevenção > Artes marciais > Segurança | Tontura, dor forte ou pancada recente mudam o treino. |
| `readiness_check_sprint_hiit` | Check antes de HIIT ou sprints | prevenção | cardio, segurança | posterior, gémeos, energia, articulações | checklist | não aplicável | 1 a 3 min | intermédio | sem equipamento | ginásio, exterior | antes de HIIT ou sprints | Prevenção > HIIT; Prevenção > Sprints | Alta intensidade exige prontidão. |
| `readiness_check_heavy_strength` | Check antes de força pesada | prevenção | musculação, segurança | técnica, energia, articulações, aquecimento | checklist | não aplicável | 1 a 3 min | intermédio | sem equipamento | ginásio, casa equipada | antes de cargas altas | Prevenção > Força pesada | Não ignorar técnica degradada. |
| `readiness_check_last_training_date` | Check do intervalo desde o último treino | prevenção | recuperação, gestão de carga | histórico de treino | comparação de datas | não aplicável | 1 min | iniciante | app ou diário de treino | qualquer local | antes de avaliar recuperação ou sobrecarga | Prevenção > Gestão de carga; Recuperação > Entre treinos | Comparar data atual com último treino registado. |
| `readiness_check_adjust_plan` | Ajuste do plano pelo estado do dia | prevenção | gestão de carga | energia, dor, sono, performance | decisão de treino | não aplicável | 2 a 5 min | iniciante | app ou diário de treino | qualquer local | antes de escolher treino | Prevenção > Autoregulação | Escolher progressão, regressão ou recuperação. |

---

# Contagem

Este ficheiro contém `227` exercícios, protocolos e checklists derivados de aquecimento, ativação e prevenção.

# Protocolos compostos recomendados

## Antes de musculação superior

```text
1. Cardio leve geral: 3 a 5 min
2. Ombros, escápulas e punhos: 3 a 5 min
3. Manguito rotador leve: 2 a 4 min
4. Séries de aproximação do exercício principal: 3 a 6 séries
```

## Antes de treino de pernas

```text
1. Cardio leve geral: 3 a 6 min
2. Tornozelo, anca e joelho: 4 a 8 min
3. Glúteos, adutores e core leve: 3 a 6 min
4. Padrão específico, squat ou hinge: 3 a 6 séries leves
```

## Antes de corrida

```text
1. Caminhada ou jog muito leve: 5 a 8 min
2. Tornozelo, pé, tibial e gémeos: 3 a 6 min
3. Leg swings e anca dinâmica: 2 a 4 min
4. Aceleração progressiva, se houver corrida rápida: 3 a 5 repetições
```

## Antes de Karate ou striking

```text
1. Cardio leve ou sombra leve: 3 a 6 min
2. Pescoço, ombros, punhos e tornozelos: 3 a 6 min
3. Anca e câmaras de pontapé: 3 a 6 min
4. Footwork e técnica leve: 3 a 6 min
```

## Antes de BJJ

```text
1. Cardio leve ou flow leve: 3 a 6 min
2. Pescoço, ombros, punhos e pega: 3 a 6 min
3. Anca, lombar e core: 3 a 6 min
4. Shrimp, ponte, technical stand-up e sprawl lento: 5 a 10 min
```

# Regras de duplicação

## Aquecimento versus recuperação

```text
Caminhada leve antes do treino é aquecimento.
Caminhada leve depois do treino é recuperação.
A entidade deve ser única.
```

## Ativação versus musculação

```text
Glute bridge leve antes do treino é ativação.
Glute bridge com carga, séries difíceis e progressão é musculação.
```

## Prevenção versus promessa de proteção

```text
Prevenção melhora tolerância, controlo e progressão.
A app nunca deve prometer que evita lesões.
```

## Artes marciais

```text
Sombra leve, footwork, sprawl lento e technical stand-up podem aquecer.
Quando há objetivo técnico principal, ficam como artes marciais.
Quando há intensidade por rounds, podem cruzar cardio.
```

# Filtros recomendados para a app

```text
Aquecimento / Ativação / Prevenção
  > Aquecimento geral
  > Preparação articular
  > Mobilidade dinâmica
  > Ativação de glúteos
  > Ativação de core
  > Escápulas e serrátil
  > Manguito rotador
  > Punhos e pega
  > Pés e tornozelos
  > Prevenção de ombro
  > Prevenção de cotovelo
  > Prevenção de lombar
  > Prevenção de joelho
  > Prevenção de tornozelo
  > Padrões de movimento
  > Musculação
  > Cardio
  > Corrida
  > HIIT
  > Sprints
  > Artes marciais
  > Check de prontidão
```

# Regras para descrições futuras

Cada exercício ou protocolo deve receber uma ficha com:

```text
Objetivo
Domínio principal
Domínios secundários
Zona ou sistema alvo
Treino que prepara
Intensidade
Duração ou séries
Como fazer passo a passo
Como saber se está bem doseado
Erros comuns
Versão mais fácil
Versão mais difícil
Cuidados
Quando não usar
```

# Testes obrigatórios

```text
todo exercício tem concept_id
todo exercício tem domínio principal
todo exercício tem zona ou sistema alvo
todo exercício tem método
todo exercício tem intensidade
todo exercício tem duração ou séries
todo exercício tem nível
todo exercício tem equipamento ou sem equipamento
todo exercício tem local
todo exercício tem contexto
todo exercício tem filtro provável
todo exercício tem cuidados
todo exercício de ativação evita fadiga relevante
todo exercício de aquecimento é progressivo
todo exercício de prevenção não promete evitar lesões
todo exercício de contacto marcial tem progressão
todo exercício de HIIT ou sprints tem aquecimento específico
todo checklist não aparece como exercício físico
todo exercício cruzado mantém identidade única
todo registo de treino compara data atual com data do último treino antes de avaliar recuperação ou sobrecarga
```

# Próximo ficheiro

O próximo ficheiro deve ser:

```text
24_LOCAIS_E_EQUIPAMENTOS_MAPA_GLOBAL.md
```

Esse ficheiro deve consolidar locais, equipamentos, filtros e regras de compatibilidade para todos os domínios já criados.