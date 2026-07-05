# 21 - Recuperação: exercícios e protocolos derivados

## Objetivo

Este ficheiro transforma os conceitos do ficheiro `20_RECUPERACAO_CONCEITOS_E_METODOS.md` em exercícios, protocolos e checklists canónicos.

A regra principal é:

```text
Recuperação tem de reduzir fadiga, tensão, rigidez ou ativação.
Se cria fadiga relevante, deixou de ser recuperação.
```

## Campos usados

```text
concept_id
exercício ou protocolo
sistema ou zona
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
Caminhada leve, 90/90, child pose, foam roller e sombra leve podem aparecer em vários filtros.
Mas a app deve manter uma entidade canónica única e mudar apenas contexto, objetivo e intensidade.
```

## Regra de segurança

Recuperação não deve tentar resolver lesão aguda, dor articular forte, dormência, formigueiro, perda de força, dor no peito, falta de ar anormal ou tontura forte.

---

# Recuperação ativa cardiovascular

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_active_low_intensity_walk` | Caminhada leve de recuperação | cardiovascular, pernas | caminhada leve | muito leve a leve | 10 a 30 min | iniciante | sem equipamento | exterior, casa, ginásio | dia de descanso, cooldown, recuperação ativa | Recuperação > Recuperação ativa; Cardio > Caminhada leve | Deve terminar com sensação igual ou melhor. Não transformar em treino. |
| `recovery_active_low_intensity_walk` | Caminhada nasal leve | cardiovascular, respiração | caminhada com respiração nasal | muito leve | 5 a 20 min | iniciante | sem equipamento | exterior, passadeira | downregulation, recuperação ativa | Recuperação > Respiração; Cardio > Muito leve | Respiração nasal só se for confortável. |
| `recovery_active_low_intensity_walk` | Passeio leve pós-refeição | cardiovascular, digestivo, pernas | caminhada leve | muito leve | 5 a 15 min | iniciante | sem equipamento | exterior, casa | recuperação geral, rotina diária | Recuperação > Recuperação ativa | Ritmo confortável, sem objetivo de performance. |
| `recovery_active_low_impact_bike` | Bicicleta muito leve de recuperação | cardiovascular, pernas | bicicleta leve | muito leve a leve | 8 a 25 min | iniciante | bicicleta | ginásio, casa equipada | dia leve, pós-pernas, cooldown | Recuperação > Recuperação ativa; Cardio > Bicicleta | Resistência baixa. Não fazer intervalos. |
| `recovery_active_low_impact_bike` | Bicicleta leve pós-treino de pernas | pernas, circulação | bicicleta leve | muito leve | 5 a 12 min | iniciante | bicicleta | ginásio, casa equipada | cooldown, pós-pernas | Recuperação > Pós-musculação > Pernas | Deve soltar, não queimar. |
| `recovery_active_low_impact_machine` | Elíptica muito leve de recuperação | cardiovascular, articulações | máquina baixo impacto | muito leve a leve | 8 a 20 min | iniciante | elíptica | ginásio | recuperação ativa, cooldown | Recuperação > Recuperação ativa; Cardio > Elíptica | Manter resistência baixa. |
| `recovery_active_low_impact_machine` | Air bike muito leve de recuperação | cardiovascular, corpo inteiro | máquina baixo impacto | muito leve | 5 a 15 min | iniciante | air bike | ginásio | cooldown, recuperação ativa | Recuperação > Recuperação ativa; Cardio > Air bike | Não virar sprint. |
| `recovery_active_low_impact_machine` | Remo ergómetro muito leve | cardiovascular, costas, pernas | remo leve | muito leve | 5 a 12 min | intermédio | remo ergómetro | ginásio | cooldown, recuperação ativa | Recuperação > Recuperação ativa; Cardio > Remo | Só usar se técnica de remo for confortável. |
| `recovery_active_zone_1_cardio` | Cardio zona 1 em máquina | cardiovascular | cardio muito leve | muito leve | 10 a 30 min | iniciante | bicicleta, elíptica, passadeira ou air bike | ginásio, casa equipada | dia de descanso, recuperação ativa | Recuperação > Cardio zona 1 | Conseguir conversar facilmente. |
| `recovery_active_post_leg_flush` | Flush pós-pernas | pernas, circulação | cardio leve mais mobilidade leve | muito leve a leve | 8 a 15 min | iniciante | bicicleta ou caminhada | ginásio, exterior, casa | pós-agachamento, pós-lunges, pós-corrida | Recuperação > Pós-musculação > Pernas | Não adicionar fadiga às pernas. |
| `recovery_active_martial_light_rounds` | Sombra técnica muito leve | cardiovascular, artes marciais | round técnico leve | muito leve | 3 a 10 min | iniciante | sem equipamento | casa, dojo, ginásio | pós-artes marciais, recuperação ativa | Recuperação > Pós-artes marciais; Artes marciais > Sombra | Sem potência, sem impacto, sem pressa. |
| `recovery_active_martial_light_rounds` | Footwork leve de recuperação | pernas, tornozelos, sistema nervoso | movimento técnico leve | muito leve | 3 a 8 min | iniciante | sem equipamento | casa, dojo, ginásio | pós-striking, cooldown | Recuperação > Pós-artes marciais; Artes marciais > Footwork | Passos pequenos e respiração calma. |

---

# Cooldown pós-treino

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_cooldown_cardio_general` | Cooldown na passadeira | cardiovascular | caminhada muito leve | muito leve | 5 a 10 min | iniciante | passadeira | ginásio, casa equipada | pós-treino, pós-cardio | Recuperação > Cooldown; Cardio > Passadeira | Baixar velocidade gradualmente. |
| `recovery_cooldown_cardio_general` | Cooldown caminhada exterior | cardiovascular, pernas | caminhada leve | muito leve | 5 a 15 min | iniciante | sem equipamento | exterior | pós-corrida, pós-treino | Recuperação > Cooldown; Cardio > Caminhada | Sem objetivo de ritmo. |
| `recovery_cooldown_strength_session` | Cooldown pós-musculação geral | músculos treinados, respiração | cardio leve, mobilidade leve, respiração | muito leve a leve | 8 a 15 min | iniciante | opcional | ginásio, casa | pós-musculação | Recuperação > Pós-musculação | Não acrescentar séries difíceis. |
| `recovery_cooldown_strength_session` | Cooldown pós-treino superior | ombros, peito, costas, braços | mobilidade leve e alongamento leve | leve | 6 a 12 min | iniciante | sem equipamento ou parede | ginásio, casa | pós-peito, pós-costas, pós-braços | Recuperação > Pós-musculação > Superior | Evitar alongar agressivamente ombro ou cotovelo. |
| `recovery_cooldown_strength_session` | Cooldown pós-treino inferior | pernas, anca, tornozelos | caminhada leve, mobilidade leve, alongamento leve | muito leve a leve | 8 a 15 min | iniciante | sem equipamento | ginásio, casa, exterior | pós-pernas | Recuperação > Pós-musculação > Pernas | Amplitude confortável. |
| `recovery_cooldown_cardio_session` | Cooldown pós-corrida | cardiovascular, pernas | caminhada e respiração | muito leve | 5 a 12 min | iniciante | sem equipamento | exterior, passadeira | pós-corrida | Recuperação > Pós-cardio > Corrida | Não parar bruscamente depois de esforço alto. |
| `recovery_cooldown_cardio_session` | Cooldown pós-HIIT | cardiovascular, sistema nervoso | caminhada leve mais respiração | muito leve | 8 a 15 min | intermédio | opcional | ginásio, casa, exterior | pós-HIIT | Recuperação > Pós-cardio > HIIT | Baixar ativação gradualmente. |
| `recovery_cooldown_martial_session` | Cooldown pós-Karate | pernas, anca, ombros, respiração | sombra leve, mobilidade, respiração | muito leve a leve | 8 a 15 min | iniciante | sem equipamento | dojo, casa | pós-Karate | Recuperação > Pós-artes marciais > Karate | Sem impacto forte. |
| `recovery_cooldown_martial_session` | Cooldown pós-BJJ | pescoço, lombar, pega, anca | respiração, mobilidade leve, descarga de pega | leve | 8 a 15 min | iniciante | tapete opcional | dojo, casa | pós-BJJ | Recuperação > Pós-artes marciais > BJJ | Atenção a dor no pescoço ou articulações. |
| `recovery_cooldown_martial_session` | Cooldown pós-saco | ombros, punhos, gémeos, respiração | caminhada leve, ombros leves, antebraço leve | leve | 6 a 12 min | iniciante | sem equipamento | ginásio, dojo, casa | pós-saco, pós-striking | Recuperação > Pós-artes marciais > Striking | Verificar punhos e mãos. |
| `recovery_cooldown_breathing_reset` | Reset respiratório sentado | respiração, sistema nervoso | expiração longa | muito leve | 2 a 5 min | iniciante | sem equipamento | qualquer local | pós-treino, pré-sono | Recuperação > Respiração | Parar se houver tontura. |
| `recovery_cooldown_joint_reset` | Reset articular pós-treino | articulações principais | mobilidade leve | muito leve | 4 a 8 min | iniciante | sem equipamento | casa, ginásio, dojo | cooldown, pós-treino | Recuperação > Mobilidade leve | Movimento sem dor e sem carga. |

---

# Respiração e downregulation

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_breathing_long_exhale` | Respiração com expiração longa deitado | sistema nervoso, respiração | expiração longa | muito leve | 2 a 6 min | iniciante | tapete opcional | casa, ginásio | pós-treino, pré-sono, stress | Recuperação > Respiração > Expiração longa | Respirar sem forçar. Parar com tontura. |
| `recovery_breathing_long_exhale` | Respiração 4 entra, 6 sai | respiração, sistema nervoso | expiração longa ritmada | muito leve | 2 a 5 min | iniciante | sem equipamento | casa, ginásio, dojo | downregulation, pré-sono | Recuperação > Respiração | Contagem ajustável ao conforto. |
| `recovery_breathing_90_90` | Respiração 90/90 na parede | costelas, pélvis, respiração | respiração posicional | muito leve | 3 a 6 min | iniciante | parede opcional | casa, ginásio | pós-treino, lombar, postura | Recuperação > Respiração; Mobilidade > Lombar e pélvis | Não pressionar lombar com força. |
| `recovery_breathing_90_90` | Respiração 90/90 com pés no sofá | costelas, pélvis | respiração de relaxamento | muito leve | 3 a 8 min | iniciante | sofá ou cadeira | casa | pré-sono, recuperação lombar | Recuperação > Pré-sono; Recuperação > Lombar | Posição confortável. |
| `recovery_breathing_box_light` | Box breathing leve | respiração, foco | respiração ritmada | muito leve | 2 a 5 min | iniciante | sem equipamento | qualquer local | stress, pós-treino, pré-sono | Recuperação > Respiração | Não prender a respiração se criar ansiedade. |
| `recovery_breathing_nasal_walk` | Caminhada leve com respiração nasal | cardiovascular, respiração | caminhada e respiração | muito leve | 5 a 20 min | iniciante | sem equipamento | exterior, passadeira | recuperação ativa, downregulation | Recuperação > Respiração; Recuperação > Recuperação ativa | Voltar a respirar normalmente se faltar ar. |
| `recovery_breathing_ribcage_relax` | Respiração costal lateral | costelas, torácica | respiração costal | muito leve | 2 a 6 min | iniciante | tapete opcional | casa, ginásio | costas altas, postura, relaxamento | Recuperação > Respiração; Mobilidade > Torácica | Respiração suave. |
| `recovery_nervous_system_downshift` | Sequência desligar pós-treino | sistema nervoso | respiração, caminhada leve, alongamento leve | muito leve | 8 a 15 min | iniciante | opcional | casa, ginásio, dojo | pós-treino intenso, pós-artes marciais | Recuperação > Sistema nervoso | Objetivo é acalmar, não treinar mais. |

---

# Mobilidade leve como recuperação

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_light_joint_cars` | CARs leves de corpo inteiro | articulações principais | mobilidade leve | muito leve | 5 a 10 min | iniciante | sem equipamento | casa, ginásio | manhã, dia de descanso | Recuperação > Mobilidade leve; Mobilidade > CARs | Amplitude confortável. |
| `recovery_light_joint_cars` | CARs leves de ombros e anca | ombros, anca | mobilidade leve | muito leve | 3 a 8 min | iniciante | sem equipamento | casa, ginásio, dojo | recuperação, aquecimento leve | Recuperação > Mobilidade leve | Sem pinçamento. |
| `recovery_light_mobility_flow` | Flow leve de mobilidade | global | flow suave | muito leve a leve | 5 a 12 min | iniciante | tapete opcional | casa, ginásio, dojo | dia de descanso, recuperação ativa | Recuperação > Mobilidade leve; Mobilidade > Flow | Não deve cansar. |
| `recovery_morning_joint_reset` | Reset articular matinal | global | mobilidade leve | muito leve | 4 a 8 min | iniciante | sem equipamento | casa | manhã, rigidez | Recuperação > Manhã; Mobilidade > Global | Começar com amplitude pequena. |
| `recovery_evening_mobility_reset` | Reset articular ao fim do dia | global, postura | mobilidade leve | muito leve | 5 a 10 min | iniciante | tapete opcional | casa | fim do dia, pós-computador | Recuperação > Pré-sono; Recuperação > Pós-computador | Não fazer movimentos estimulantes demais. |
| `recovery_spine_hip_light_flow` | Flow leve coluna e anca | coluna, anca | mobilidade suave | muito leve | 5 a 10 min | iniciante | tapete opcional | casa, ginásio | lombar, anca, pós-sentado | Recuperação > Costas e postura; Mobilidade > Anca | Sem dor lombar. |
| `recovery_spine_hip_light_flow` | Cat cow e 90/90 leve | coluna, anca | mobilidade suave | muito leve | 4 a 8 min | iniciante | tapete opcional | casa, ginásio | recuperação, pós-computador | Recuperação > Mobilidade leve | 90/90 sem forçar joelhos. |
| `recovery_shoulders_light_flow` | Flow leve de ombros | ombros, escápulas | mobilidade leve | muito leve | 4 a 8 min | iniciante | parede opcional | casa, ginásio | pós-saco, pós-costas, pós-peito | Recuperação > Ombros; Mobilidade > Ombros | Evitar pinçamento. |

---

# Elasticidade leve como recuperação

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_light_static_stretching` | Alongamento estático leve geral | zonas treinadas | alongamento leve | leve | 5 a 12 min | iniciante | opcional | casa, ginásio | pós-treino, cooldown | Recuperação > Alongamento leve; Elasticidade > Pós-treino | Sem dor, sem máxima amplitude. |
| `recovery_post_training_stretch_sequence` | Sequência leve pós-treino superior | peito, dorsal, ombros, braços | alongamento leve | leve | 6 a 12 min | iniciante | parede opcional | casa, ginásio | pós-superior | Recuperação > Pós-musculação > Superior | Ombros sem pinçamento. |
| `recovery_post_training_stretch_sequence` | Sequência leve pós-treino inferior | anca, quadríceps, posterior, gémeos | alongamento leve | leve | 6 a 12 min | iniciante | tapete opcional | casa, ginásio | pós-pernas | Recuperação > Pós-musculação > Pernas | Não forçar adutores ou joelhos. |
| `recovery_evening_stretch_relax` | Alongamentos leves à noite | global, sistema nervoso | alongamento leve com respiração | muito leve a leve | 5 a 15 min | iniciante | tapete opcional | casa | pré-sono, relaxamento | Recuperação > Pré-sono; Elasticidade > Relaxamento | Manter tudo confortável. |
| `recovery_neck_chest_stretch_computer` | Pescoço e peito pós-computador | pescoço, peito, ombros | alongamento leve | muito leve a leve | 4 a 8 min | iniciante | parede opcional | casa, trabalho | pós-computador, postura | Recuperação > Pós-computador; Elasticidade > Pescoço | Pescoço sempre suave. |
| `recovery_hips_hamstrings_light` | Anca e posterior leve | anca, posterior de coxa | alongamento leve | leve | 5 a 10 min | iniciante | tapete opcional | casa, ginásio | pós-sentado, pós-pernas | Recuperação > Anca; Elasticidade > Posterior | Evitar sensação nervosa. |
| `recovery_martial_kicks_stretch_light` | Alongamento leve pós-pontapés | adutores, flexores da anca, posterior | alongamento leve | leve | 6 a 12 min | iniciante | tapete opcional | dojo, casa | pós-Karate, pós-kickboxing, pós-Taekwondo | Recuperação > Pós-artes marciais; Elasticidade > Pontapés | Não tentar abrir mais depois de fadiga. |

---

# Foam roller

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_foam_roller_quads` | Foam roller nos quadríceps | quadríceps | foam roller | leve a moderada | 1 a 2 min por zona | iniciante | foam roller | casa, ginásio | pós-pernas, corrida | Recuperação > Foam roller > Quadríceps | Não rolar sobre joelho ou anca. |
| `recovery_foam_roller_calves` | Foam roller nos gémeos | gémeos, sóleo | foam roller | leve a moderada | 1 a 2 min por lado | iniciante | foam roller | casa, ginásio | pós-corrida, pós-corda | Recuperação > Foam roller > Gémeos | Pressão progressiva. |
| `recovery_foam_roller_glutes` | Foam roller nos glúteos | glúteos, lateral da anca | foam roller | leve a moderada | 1 a 2 min por lado | iniciante | foam roller | casa, ginásio | pós-pernas, pós-BJJ | Recuperação > Foam roller > Glúteos | Evitar compressão agressiva em pontos nervosos. |
| `recovery_foam_roller_lats` | Foam roller no dorsal | dorsal, lateral das costas | foam roller | leve | 1 a 2 min por lado | intermédio | foam roller | casa, ginásio | pós-costas, pós-saco | Recuperação > Foam roller > Dorsal | Não comprimir ombro ou costelas com dor. |
| `recovery_foam_roller_upper_back` | Foam roller na parte alta das costas | torácica, costas altas | foam roller | leve a moderada | 1 a 3 min | iniciante | foam roller | casa, ginásio | pós-computador, postura | Recuperação > Foam roller > Costas altas | Não rolar lombar ou pescoço. |
| `recovery_foam_roller_adductors` | Foam roller nos adutores | adutores | foam roller | leve a moderada | 1 a 2 min por lado | intermédio | foam roller | casa, ginásio | pós-pernas, pós-BJJ, pós-pontapés | Recuperação > Foam roller > Adutores | Pressão moderada. Zona sensível. |
| `recovery_foam_roller_post_leg_day` | Sequência foam roller pós-pernas | quadríceps, glúteos, adutores, gémeos | foam roller | leve a moderada | 6 a 10 min | iniciante | foam roller | casa, ginásio | pós-treino de pernas | Recuperação > Foam roller > Pernas | Não exceder por zona se irritar tecido. |
| `recovery_foam_roller_post_martial` | Foam roller pós-artes marciais | pernas, costas, ombros | foam roller | leve a moderada | 6 a 12 min | intermédio | foam roller | dojo, casa, ginásio | pós-Karate, pós-BJJ, pós-saco | Recuperação > Pós-artes marciais; Recuperação > Foam roller | Evitar zonas com pancada aguda. |

---

# Bola de massagem

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_massage_ball_feet` | Bola de massagem na planta do pé | planta do pé | bola de massagem | leve a moderada | 1 a 3 min por pé | iniciante | bola de massagem | casa, ginásio | pós-trabalho em pé, pós-corrida | Recuperação > Pés; Recuperação > Bola de massagem | Não esmagar zonas muito doloridas. |
| `recovery_massage_ball_glutes` | Bola de massagem nos glúteos | glúteos | bola de massagem | leve a moderada | 1 a 2 min por lado | intermédio | bola de massagem | casa, ginásio | pós-pernas, pós-BJJ | Recuperação > Glúteos; Recuperação > Bola de massagem | Evitar formigueiro ou dor nervosa. |
| `recovery_massage_ball_pecs` | Bola de massagem no peitoral contra parede | peitoral | bola de massagem | leve | 1 a 2 min por lado | iniciante | bola de massagem, parede | casa, ginásio | pós-saco, postura, pós-peito | Recuperação > Peito; Recuperação > Bola de massagem | Evitar pressão direta sobre axila ou articulação. |
| `recovery_massage_ball_traps` | Bola no trapézio contra parede | trapézio superior, costas altas | bola de massagem | leve | 1 a 2 min por lado | iniciante | bola de massagem, parede | casa, ginásio | pós-computador, pós-striking | Recuperação > Pescoço e ombros; Recuperação > Bola de massagem | Não usar na frente do pescoço. |
| `recovery_massage_ball_forearms` | Bola de massagem no antebraço | antebraço, pega | bola de massagem | leve a moderada | 1 a 2 min por lado | iniciante | bola de massagem | casa, ginásio, dojo | pós-BJJ, pós-Judo, pós-barras | Recuperação > Pega e antebraço | Evitar pressão agressiva nos tendões. |
| `recovery_massage_ball_upper_back` | Bola nas costas altas contra parede | romboides, trapézio médio | bola de massagem | leve a moderada | 1 a 3 min | intermédio | bola de massagem, parede | casa, ginásio | postura, pós-costas | Recuperação > Costas altas; Recuperação > Bola de massagem | Não pressionar diretamente a coluna. |

---

# Pistola de massagem

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_massage_gun_quads` | Pistola de massagem nos quadríceps | quadríceps | pistola de massagem | leve | 30 a 90 s por zona | intermédio | pistola de massagem | casa, ginásio | pós-pernas | Recuperação > Pistola de massagem > Quadríceps | Evitar joelho, anca e dor aguda. |
| `recovery_massage_gun_glutes` | Pistola de massagem nos glúteos | glúteos | pistola de massagem | leve | 30 a 90 s por lado | intermédio | pistola de massagem | casa, ginásio | pós-pernas, pós-BJJ | Recuperação > Pistola de massagem > Glúteos | Evitar pressão se causar formigueiro. |
| `recovery_massage_gun_calves` | Pistola de massagem nos gémeos | gémeos, sóleo | pistola de massagem | leve | 30 a 60 s por lado | intermédio | pistola de massagem | casa, ginásio | pós-corrida, pós-corda | Recuperação > Pistola de massagem > Gémeos | Não usar sobre tendão de Aquiles irritado. |
| `recovery_massage_gun_lats` | Pistola de massagem no dorsal | dorsal | pistola de massagem | leve | 30 a 60 s por lado | intermédio | pistola de massagem | casa, ginásio | pós-costas, pós-saco | Recuperação > Pistola de massagem > Costas | Evitar costelas doloridas e articulação do ombro. |
| `recovery_massage_gun_shoulders_safe` | Pistola de massagem no deltoide | ombro muscular | pistola de massagem | muito leve a leve | 20 a 45 s por zona | intermédio | pistola de massagem | casa, ginásio | pós-ombros, pós-striking | Recuperação > Pistola de massagem > Ombros | Não usar na articulação, pescoço anterior ou coluna. |
| `recovery_massage_gun_general_rules` | Protocolo seguro de pistola de massagem | músculos grandes | pistola de massagem | leve | 5 a 8 min total | intermédio | pistola de massagem | casa, ginásio | recuperação geral | Recuperação > Pistola de massagem > Segurança | Baixa intensidade, tempo curto, evitar zonas sensíveis. |

---

# Calor, frio e contraste

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_heat_relaxation` | Calor leve para relaxamento muscular | músculos tensos | calor local | leve | 10 a 20 min | iniciante | saco térmico ou banho quente | casa | rigidez, relaxamento | Recuperação > Calor | Evitar queimaduras e pele sem sensibilidade. |
| `recovery_warm_shower_post_training` | Duche quente pós-treino leve | sistema nervoso, músculos | calor geral | leve | 5 a 15 min | iniciante | duche | casa, ginásio | pós-treino, pré-sono | Recuperação > Calor; Recuperação > Pré-sono | Não usar temperatura extrema. |
| `recovery_cold_local_acute_soreness` | Frio local curto | zona irritada | frio local | leve | 5 a 10 min | iniciante | gelo envolto em pano | casa | desconforto agudo leve | Recuperação > Frio | Não aplicar gelo direto na pele. |
| `recovery_contrast_simple` | Contraste simples no duche | pernas ou corpo geral | quente e frio leve | leve | 3 a 8 min | intermédio | duche | casa, ginásio | recuperação subjetiva | Recuperação > Calor e frio | Evitar extremos e tontura. |
| `recovery_heat_for_stiffness` | Calor para rigidez matinal | zona rígida | calor local | leve | 10 a 15 min | iniciante | saco térmico | casa | rigidez, manhã | Recuperação > Calor; Recuperação > Manhã | Não usar em inchaço agudo sem avaliação. |
| `recovery_temperature_method_safety` | Checklist de segurança para temperatura | segurança geral | educação | não aplicável | 1 a 3 min | iniciante | sem equipamento | qualquer local | segurança, recuperação | Recuperação > Segurança > Calor e frio | Parar com dormência, queimadura, dor forte ou tontura. |

---

# Mãos, punhos e pega

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_grip_shake_out` | Shake out de mãos entre rounds | mãos, antebraços | descarga dinâmica | muito leve | 20 a 60 s | iniciante | sem equipamento | dojo, ginásio, casa | entre rounds, pós-pega | Recuperação > Pega e antebraço | Relaxar, não sacudir agressivamente. |
| `recovery_grip_shake_out` | Shake out pós-barras | antebraços, mãos | descarga dinâmica | muito leve | 30 a 90 s | iniciante | sem equipamento | ginásio, casa | pós-barras, pós-farmer walk | Recuperação > Pega e antebraço | Sem dor nos dedos. |
| `recovery_grip_forearm_stretch_light` | Alongamento leve de flexores do punho | antebraço anterior | alongamento leve | leve | 30 a 60 s por lado | iniciante | sem equipamento | casa, ginásio, dojo | pós-pega, pós-BJJ | Recuperação > Pega; Elasticidade > Antebraço | Baixa intensidade. |
| `recovery_grip_forearm_stretch_light` | Alongamento leve de extensores do punho | antebraço posterior | alongamento leve | leve | 30 a 60 s por lado | iniciante | sem equipamento | casa, ginásio, dojo | pós-pega, pós-teclado | Recuperação > Pega; Elasticidade > Antebraço | Não puxar dedos com força. |
| `recovery_grip_extensor_balance` | Extensão dos dedos com elástico leve | dedos, extensores | ativação leve | muito leve a leve | 1 a 2 séries leves | iniciante | elástico pequeno | casa, ginásio | pós-pega, prevenção | Recuperação > Pega; Musculação > Antebraço leve | Não levar até falha. |
| `recovery_grip_bjj_judo_sequence` | Sequência pós-BJJ para pega | dedos, punhos, antebraços | shake out, mobilidade, alongamento leve | leve | 5 a 8 min | iniciante | sem equipamento | dojo, casa | pós-BJJ, pós-Judo | Recuperação > Pós-artes marciais > Pega | Cuidado com dedos doridos ou inchados. |
| `recovery_grip_barbell_sequence` | Sequência pós-barras e farmer walks | antebraços, punhos | descarga, alongamento leve, bola opcional | leve | 4 a 8 min | iniciante | bola opcional | ginásio, casa | pós-musculação, pega | Recuperação > Pega e antebraço | Não esmagar tendões. |
| `recovery_wrist_support_reset` | Reset de punhos após apoios | punhos, mãos | mobilidade leve | muito leve a leve | 2 a 5 min | iniciante | sem equipamento | casa, ginásio, dojo | pós-flexões, pós-prancha, pós-quedas | Recuperação > Punhos e mãos | Sem dor em extensão. |

---

# Pés, tornozelos e pernas

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_feet_after_standing_day` | Recuperação dos pés após dia em pé | pés, gémeos | bola, alongamento leve, elevação | leve | 8 a 15 min | iniciante | bola opcional | casa | pós-trabalho em pé, feiras | Recuperação > Pés; Recuperação > Pós-trabalho em pé | Não massajar dor aguda. |
| `recovery_feet_ball_release` | Libertação leve da planta do pé | planta do pé | bola de massagem | leve | 1 a 3 min por pé | iniciante | bola de massagem | casa, ginásio | pós-trabalho, pós-corrida | Recuperação > Pés | Pressão controlada. |
| `recovery_ankle_light_mobility` | Mobilidade leve de tornozelo pós-treino | tornozelo | mobilidade leve | muito leve | 2 a 5 min | iniciante | sem equipamento | casa, ginásio, exterior | pós-corrida, pós-pernas | Recuperação > Tornozelos; Mobilidade > Tornozelos | Amplitude confortável. |
| `recovery_calves_after_running` | Recuperação de gémeos pós-corrida | gémeos, sóleo | caminhada, alongamento leve, massagem opcional | leve | 8 a 15 min | iniciante | parede, foam roller opcional | casa, exterior, ginásio | pós-corrida, pós-corda | Recuperação > Pós-cardio > Corrida | Distinguir fadiga normal de dor no tendão. |
| `recovery_tibialis_after_treadmill` | Recuperação de tibial anterior pós-passadeira | tibial anterior, canela | mobilidade leve, alongamento leve | leve | 4 a 8 min | iniciante | sem equipamento | casa, ginásio | pós-passadeira, caminhada inclinada | Recuperação > Pernas > Tibial anterior | Dor forte na canela exige reduzir carga. |
| `recovery_leg_elevation_relax` | Elevação leve de pernas | pernas, circulação | posição de descanso | muito leve | 5 a 15 min | iniciante | parede ou sofá | casa | pós-dia em pé, recuperação geral | Recuperação > Pernas | Posição confortável. Não prender respiração. |
| `recovery_lower_body_after_fairs_work` | Sequência pós-trabalho físico de pernas | pés, gémeos, anca, lombar | caminhada leve, mobilidade, alongamento leve | leve | 10 a 18 min | iniciante | tapete opcional | casa | pós-feiras, pós-dia em pé | Recuperação > Pós-trabalho em pé; Recuperação > Pernas | Baixar tensão, não criar novo treino. |

---

# Costas, lombar e postura

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_low_back_decompression_position` | Posição de descarga lombar com pernas elevadas | lombar, pélvis | posição de descanso e respiração | muito leve | 5 a 12 min | iniciante | cadeira ou sofá | casa | lombar, pós-treino, pós-trabalho | Recuperação > Lombar | Parar se aumentar dor ou sintomas na perna. |
| `recovery_low_back_child_pose_light` | Child pose leve para lombar | lombar, costas | alongamento leve | muito leve a leve | 1 a 3 min | iniciante | tapete opcional | casa, ginásio | recuperação lombar, cooldown | Recuperação > Lombar; Elasticidade > Costas | Só usar se for confortável. |
| `recovery_low_back_cat_cow_light` | Cat cow leve de recuperação | coluna | mobilidade leve | muito leve | 1 a 3 min | iniciante | tapete opcional | casa, ginásio | rigidez, pós-sentado | Recuperação > Costas; Mobilidade > Coluna | Sem extremos de amplitude. |
| `recovery_post_computer_spine_reset` | Reset coluna pós-computador | pescoço, torácica, peito, anca | mobilidade e alongamento leve | leve | 5 a 10 min | iniciante | parede opcional | casa, trabalho | pós-computador, postura | Recuperação > Pós-computador | Pescoço suave. |
| `recovery_upper_back_posture_reset` | Reset de costas altas e escápulas | torácica, escápulas | mobilidade leve, foam roller opcional | leve | 4 a 8 min | iniciante | parede ou foam roller opcional | casa, ginásio | postura, pós-costas, pós-striking | Recuperação > Costas altas | Não rolar pescoço. |
| `recovery_low_back_after_hinge` | Recuperação lombar pós-dobradiça | lombar, anca, posterior | descarga, respiração, mobilidade leve | leve | 6 a 12 min | iniciante | tapete opcional | ginásio, casa | pós-peso morto, pós-good morning, pós-trabalho físico | Recuperação > Lombar; Recuperação > Pós-musculação | Dormência, dor irradiada ou perda de força exigem parar. |
| `recovery_low_back_red_flags` | Checklist de alerta para lombar | lombar, nervos | educação e segurança | não aplicável | 1 a 3 min | iniciante | sem equipamento | qualquer local | segurança, dor | Recuperação > Segurança > Lombar | Não é exercício. Serve para decidir quando não treinar. |

---

# Recuperação específica de artes marciais

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_karate_post_class` | Sequência pós-Karate | anca, adutores, gémeos, ombros | cooldown técnico, alongamento leve, respiração | leve | 8 a 15 min | iniciante | tapete opcional | dojo, casa | pós-Karate | Recuperação > Pós-artes marciais > Karate | Sem alongamentos máximos depois de fadiga. |
| `recovery_bjj_post_class` | Sequência pós-BJJ | pescoço, pega, lombar, anca | respiração, mobilidade leve, descarga de pega | leve | 10 a 18 min | iniciante | tapete opcional | dojo, casa | pós-BJJ | Recuperação > Pós-artes marciais > BJJ | Verificar pescoço, dedos e lombar. |
| `recovery_striking_post_bag` | Sequência pós-saco | ombros, punhos, gémeos, respiração | cooldown, punhos, ombros leves | leve | 6 a 12 min | iniciante | parede opcional | ginásio, dojo, casa | pós-saco, pós-striking | Recuperação > Pós-artes marciais > Striking | Verificar punhos antes de alongar. |
| `recovery_grappling_neck_shoulders` | Pescoço e ombros pós-grappling | pescoço, trapézio, escápulas | mobilidade e alongamento muito leve | muito leve a leve | 4 a 8 min | iniciante | sem equipamento | dojo, casa | pós-BJJ, pós-grappling | Recuperação > Pós-artes marciais > Pescoço e ombros | Pescoço sem puxar forte. |
| `recovery_martial_adductors_hips` | Adutores e anca pós-artes marciais | adutores, anca, flexores da anca | alongamento leve, mobilidade leve | leve | 6 a 12 min | iniciante | tapete opcional | dojo, casa | pós-pontapés, pós-guarda, pós-bases | Recuperação > Pós-artes marciais > Anca | Não forçar joelhos. |
| `recovery_martial_downregulation` | Desligar sistema nervoso pós-treino marcial | sistema nervoso, respiração | respiração, caminhada leve, relaxamento | muito leve | 5 a 12 min | iniciante | sem equipamento | dojo, casa | pós-Karate, pós-BJJ, pós-sparring | Recuperação > Pós-artes marciais > Sistema nervoso | Acalmar, não continuar a competir. |
| `recovery_sparring_light_reset` | Reset leve pós-sparring técnico | global, sistema nervoso | triagem, respiração, mobilidade leve | muito leve | 6 a 12 min | intermédio | sem equipamento | dojo, ginásio | pós-sparring técnico | Recuperação > Pós-artes marciais > Sparring | Verificar pancadas, tontura, dor ou lesões antes de seguir. |

---

# Gestão de carga, deload e recuperação entre treinos

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_load_management_basic` | Check-in de carga do dia | fadiga sistémica | autoregulação | não aplicável | 1 a 3 min | iniciante | sem equipamento | qualquer local | antes do treino, planeamento | Recuperação > Gestão de carga | Avaliar sono, dor, energia e treino anterior. |
| `recovery_deload_week` | Semana de deload por volume | fadiga muscular e sistémica | redução de volume | leve a moderada | 5 a 7 dias | intermédio | não aplicável | planeamento | sobrecarga, fadiga acumulada | Recuperação > Deload | Não é pausa total obrigatória. |
| `recovery_deload_week` | Semana de deload por intensidade | fadiga neural e articular | redução de carga/intensidade | leve a moderada | 5 a 7 dias | intermédio | não aplicável | planeamento | força, artes marciais, dor articular leve | Recuperação > Deload | Manter técnica limpa. |
| `recovery_session_swap_light` | Trocar sessão pesada por sessão leve | fadiga diária | ajuste de plano | leve | 1 sessão | iniciante | opcional | casa, ginásio, dojo | baixa prontidão, sono mau | Recuperação > Gestão de carga | Manter hábito sem forçar. |
| `recovery_between_strength_sessions` | Regra entre treinos do mesmo músculo | músculos, tendões | planeamento de recuperação | não aplicável | 1 a 3 min | iniciante | sem equipamento | planeamento | musculação | Recuperação > Entre treinos > Musculação | Comparar data atual com último treino registado. |
| `recovery_between_martial_sessions` | Regra entre treinos de artes marciais | sistema nervoso, articulações, pega | planeamento de recuperação | não aplicável | 1 a 3 min | iniciante | sem equipamento | planeamento | Karate, BJJ, sparring | Recuperação > Entre treinos > Artes marciais | Considerar impacto, quedas, pega e pescoço. |
| `recovery_autoregulation_readiness` | Escala simples de prontidão | energia, dor, sono, performance | autoregulação | não aplicável | 1 a 2 min | iniciante | sem equipamento | qualquer local | pré-treino, planeamento | Recuperação > Autoregulação | Não ignorar dor articular. |
| `recovery_overload_warning_signs` | Checklist de sinais de sobrecarga | fadiga sistémica | triagem | não aplicável | 2 a 4 min | iniciante | sem equipamento | qualquer local | sobrecarga, deload | Recuperação > Segurança > Sobrecarga | Queda persistente de performance e dor crescente pedem ajuste. |

---

# Sono, rotina e recuperação geral

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_sleep_routine_basic` | Rotina básica pré-sono | sono, sistema nervoso | rotina de relaxamento | muito leve | 15 a 30 min | iniciante | opcional | casa | pré-sono, recuperação geral | Recuperação > Sono | Sem ecrã intenso e sem treino duro no fim. |
| `recovery_evening_downshift` | Desaceleração ao fim do dia | sistema nervoso | luz baixa, respiração, alongamento leve | muito leve | 10 a 20 min | iniciante | opcional | casa | fim do dia, pré-sono | Recuperação > Pré-sono | Objetivo é baixar ativação. |
| `recovery_sleep_mobility_light` | Mobilidade leve antes de dormir | articulações, sistema nervoso | mobilidade leve | muito leve | 5 a 10 min | iniciante | tapete opcional | casa | pré-sono, rigidez | Recuperação > Sono; Mobilidade > Leve | Sem movimentos intensos. |
| `recovery_sleep_breathing` | Respiração para pré-sono | respiração, sistema nervoso | expiração longa | muito leve | 3 a 8 min | iniciante | sem equipamento | casa | pré-sono | Recuperação > Sono; Recuperação > Respiração | Não prender respiração se incomodar. |
| `recovery_sleep_post_late_training` | Recuperação após treino tardio | sistema nervoso, temperatura, respiração | cooldown, duche, respiração | muito leve | 15 a 30 min | iniciante | opcional | casa, ginásio | pós-treino à noite | Recuperação > Sono; Recuperação > Pós-treino | Evitar estímulo extra. |
| `recovery_general_rest_day` | Dia de descanso estruturado | recuperação geral | movimento leve, sono, alimentação, descarga mental | muito leve a leve | dia inteiro | iniciante | opcional | qualquer local | dia de descanso | Recuperação > Dia de descanso | Não transformar descanso em treino escondido. |

---

# Dor, desconforto e segurança

| Concept ID | Exercício ou protocolo | Sistema ou zona | Método | Intensidade | Duração | Nível | Equipamento | Locais | Contextos | Filtros prováveis | Cuidados |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `recovery_soreness_normal_dom` | Triagem de dor muscular tardia | músculos | educação e decisão | não aplicável | 1 a 3 min | iniciante | sem equipamento | qualquer local | dor muscular pós-treino | Recuperação > Segurança > Dor muscular | Dor muscular leve é diferente de dor articular. |
| `recovery_joint_pain_rule` | Regra para dor articular | articulações | triagem de segurança | não aplicável | 1 a 3 min | iniciante | sem equipamento | qualquer local | dor, segurança | Recuperação > Segurança > Dor articular | Dor articular crescente não deve ser treinada por cima. |
| `recovery_tendon_irritation_rule` | Regra para tendão irritado | tendões | triagem de segurança | não aplicável | 1 a 3 min | iniciante | sem equipamento | qualquer local | dor tendinosa, recuperação | Recuperação > Segurança > Tendões | Evitar alongamento agressivo e carga alta. |
| `recovery_nerve_symptom_rule` | Regra para formigueiro ou dormência | nervos | triagem de segurança | não aplicável | 1 a 3 min | iniciante | sem equipamento | qualquer local | segurança, sintomas nervosos | Recuperação > Segurança > Nervos | Não alongar forte sintomas nervosos. |
| `recovery_acute_injury_stop_rule` | Regra de parar em lesão aguda | trauma, articulações, músculos | triagem de segurança | não aplicável | 1 a 3 min | iniciante | sem equipamento | qualquer local | lesão aguda, segurança | Recuperação > Segurança > Lesão aguda | Estalido doloroso, inchaço ou perda de função exigem parar. |
| `recovery_medical_referral_flags` | Sinais para avaliação profissional | segurança geral | triagem | não aplicável | 1 a 3 min | iniciante | sem equipamento | qualquer local | segurança, dor forte | Recuperação > Segurança > Avaliação | Dor no peito, falta de ar anormal, tontura forte, dormência ou perda de força não são treino. |

---

# Contagem

Este ficheiro contém `122` exercícios, protocolos e checklists derivados de recuperação.

# Protocolos compostos recomendados

## Pós-musculação superior

```text
1. Caminhada leve ou bicicleta leve: 3 a 5 min
2. Flow leve de ombros e escápulas: 2 a 4 min
3. Alongamento leve de peito ou dorsal: 2 a 4 min
4. Respiração com expiração longa: 2 min
```

## Pós-pernas

```text
1. Caminhada leve ou bicicleta muito leve: 5 a 8 min
2. Mobilidade leve de tornozelo e anca: 3 a 5 min
3. Alongamento leve de quadríceps, posterior ou gémeos: 4 a 8 min
4. Elevação leve de pernas, se fizer sentido: 5 a 10 min
```

## Pós-BJJ

```text
1. Respiração lenta: 2 a 4 min
2. Shake out de mãos e antebraços: 1 min
3. Pescoço e ombros muito leves: 2 a 4 min
4. Anca e lombar com mobilidade leve: 3 a 6 min
5. Alongamento leve de adutores ou glúteos: 2 a 5 min
```

## Pós-Karate ou striking

```text
1. Sombra muito leve ou caminhada: 3 a 5 min
2. Respiração lenta: 2 min
3. Ombros, punhos e pescoço suaves: 2 a 4 min
4. Adutores, flexores da anca e gémeos leves: 4 a 8 min
```

## Pós-computador

```text
1. Levantar e caminhar: 2 a 5 min
2. Peito e pescoço suaves: 2 a 4 min
3. Torácica e escápulas leves: 2 a 4 min
4. Respiração costal: 1 a 3 min
```

# Regras de duplicação

## Cardio leve

```text
Caminhada leve é cardio quando o objetivo é treinar resistência.
Caminhada leve é recuperação quando o objetivo é circulação e baixa fadiga.
A entidade deve ser única e o contexto muda.
```

## Mobilidade leve

```text
CARs leves e flows suaves são recuperação quando reduzem rigidez.
São mobilidade quando o objetivo é melhorar controlo articular.
```

## Alongamento leve

```text
Alongamento leve é recuperação quando baixa tensão.
É elasticidade quando o objetivo é ganhar tolerância de amplitude.
```

## Artes marciais leves

```text
Sombra leve e footwork leve podem recuperar se forem muito leves.
Passam a cardio ou treino técnico quando há intensidade, rounds exigentes ou objetivo de performance.
```

# Filtros recomendados para a app

```text
Recuperação
  > Recuperação ativa
  > Cooldown
  > Respiração
  > Mobilidade leve
  > Alongamento leve
  > Foam roller
  > Bola de massagem
  > Pistola de massagem
  > Calor e frio
  > Pega e antebraço
  > Pés e pernas
  > Costas e postura
  > Pós-musculação
  > Pós-cardio
  > Pós-artes marciais
  > Pós-computador
  > Pré-sono
  > Gestão de carga
  > Segurança
```

# Regras para descrições futuras

Cada exercício ou protocolo de recuperação deve receber uma ficha com:

```text
Objetivo
Sistema ou zona alvo
Quando usar
Intensidade esperada
Duração típica
Como fazer passo a passo
Como saber se está leve o suficiente
Erros comuns
Versão mais fácil
Versão mais completa
Cuidados
Sinais de alerta
```

# Testes obrigatórios

```text
todo exercício ou protocolo tem concept_id
todo exercício ou protocolo tem sistema ou zona alvo
todo exercício ou protocolo tem método
todo exercício ou protocolo tem intensidade
todo exercício ou protocolo tem duração
todo exercício ou protocolo tem nível
todo exercício ou protocolo tem equipamento ou sem equipamento
todo exercício ou protocolo tem local
todo exercício ou protocolo tem contexto
todo exercício ou protocolo tem filtro provável
todo exercício ou protocolo tem cuidados
todo método de segurança não aparece como exercício físico
todo protocolo com dor tem regra de alerta
todo cardio de recuperação mantém intensidade baixa
todo alongamento de recuperação é leve
toda pistola de massagem tem contraindicações básicas
todo foam roller evita articulações e coluna sensível
todo bloco de gestão de carga compara data atual com data do último treino registado
todo exercício cruzado mantém identidade única
```

# Próximo ficheiro

O próximo ficheiro deve ser:

```text
22_AQUECIMENTO_ATIVACAO_PREVENCAO_CONCEITOS.md
```

Esse ficheiro deve separar aquecimento, ativação e prevenção, porque estes conceitos cruzam musculação, cardio, mobilidade, recuperação e artes marciais.