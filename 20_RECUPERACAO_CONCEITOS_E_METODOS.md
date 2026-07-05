# 20 - Recuperação: conceitos e métodos

## Objetivo

Este ficheiro reconstrói o domínio de recuperação da EveFit a partir de sistemas, métodos, contextos e regras de segurança.

A regra base é:

```text
Recuperação não é ausência de treino.
Recuperação é gerir fadiga, rigidez, tensão, dor leve, sistema nervoso e prontidão para o próximo estímulo.
```

Um exercício ou método de recuperação deve responder a:

```text
Que sistema está a recuperar?
Que tipo de fadiga ou tensão existe?
O objetivo é circulação, relaxamento, mobilidade leve, descarga, respiração, sono ou gestão de carga?
A intensidade é baixa o suficiente para recuperar?
Há sinais de alerta que impedem este método?
```

## Diferença entre recuperação, mobilidade, elasticidade, cardio e treino

```text
Recuperação = baixar fadiga, tensão, rigidez ou ativação.
Mobilidade = controlar amplitude ativa.
Elasticidade = tolerar posição alongada.
Cardio = treinar sistema cardiovascular ou energético.
Musculação = criar estímulo de força, massa, resistência ou potência.
```

O mesmo movimento pode mudar de domínio conforme o objetivo.

Exemplo:

```text
Caminhada leve como cooldown = recuperação.
Caminhada rápida 40 minutos em zona 2 = cardio.
90/90 leve com respiração pós-treino = recuperação.
90/90 lift-off = mobilidade.
90/90 passivo mantido = elasticidade.
```

## Modelo conceptual

```text
Sistema
  > Problema de recuperação
    > Método
      > Intensidade
        > Contexto
          > Segurança
            > Exercícios ou protocolos derivados
```

## Capacidades e objetivos de recuperação

```text
reduzir fadiga residual
aumentar circulação leve
baixar tensão muscular
reduzir rigidez articular
baixar ativação do sistema nervoso
melhorar prontidão para o próximo treino
recuperar pega
recuperar pés e pernas
recuperar costas e postura
descarregar após artes marciais
melhorar rotina pré-sono
gerir carga e deload
identificar sinais de alerta
```

## Intensidades

```text
muito leve
leve
moderada controlada
não aplicável
```

Recuperação raramente deve ser alta intensidade.

---

# Recuperação ativa cardiovascular

## Sistema alvo

```text
sistema cardiovascular
circulação periférica
respiração
pernas
sistema nervoso autónomo
```

## Métodos úteis

```text
caminhada leve
bicicleta muito leve
elíptica muito leve
passadeira cooldown
remo muito leve
air bike muito leve
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_active_low_intensity_walk` | Caminhada leve de recuperação | Usar movimento fácil para aumentar circulação sem criar fadiga. |
| `recovery_active_low_impact_bike` | Bicicleta leve de recuperação | Recuperar com baixo impacto em dias de pernas, corrida ou fadiga geral. |
| `recovery_active_low_impact_machine` | Máquina leve de baixo impacto | Usar elíptica, remo leve ou air bike leve para mover sem sobrecarregar articulações. |
| `recovery_active_zone_1_cardio` | Cardio zona 1 | Manter esforço muito leve para recuperar entre treinos. |
| `recovery_active_post_leg_flush` | Flush pós-pernas | Reduzir sensação de peso nas pernas depois de treino inferior ou corrida. |
| `recovery_active_martial_light_rounds` | Rounds técnicos leves de recuperação | Usar sombra leve ou movimentação técnica para recuperar sem impacto. |

## Notas de modelação

Recuperação ativa tem intensidade baixa. Se a pessoa fica ofegante ou cansada, deixou de ser recuperação e passou a treino.

---

# Cooldown pós-treino

## Sistema alvo

```text
frequência cardíaca
respiração
temperatura corporal
sistema nervoso
músculos treinados
```

## Métodos úteis

```text
cardio muito leve
respiração
mobilidade leve
alongamento leve
descompressão progressiva
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_cooldown_cardio_general` | Cooldown cardiovascular geral | Reduzir gradualmente intensidade após treino. |
| `recovery_cooldown_strength_session` | Cooldown após musculação | Baixar tensão e reorganizar respiração depois de treino de força. |
| `recovery_cooldown_cardio_session` | Cooldown após cardio | Desacelerar ritmo para evitar paragem brusca. |
| `recovery_cooldown_martial_session` | Cooldown após artes marciais | Baixar ativação depois de Karate, BJJ, saco ou sparring técnico. |
| `recovery_cooldown_breathing_reset` | Reset respiratório pós-treino | Usar respiração lenta para voltar a estado calmo. |
| `recovery_cooldown_joint_reset` | Reset articular leve | Mover articulações principais sem carga para reduzir rigidez. |

## Notas de modelação

Cooldown não deve ser intenso. A intenção é transição de esforço para repouso.

---

# Respiração e downregulation

## Sistema alvo

```text
sistema nervoso autónomo
diafragma
caixa torácica
core profundo
ritmo cardíaco
estado mental
```

## Métodos úteis

```text
respiração nasal
expiração longa
respiração 90/90
respiração costal
body scan
relaxamento guiado
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_breathing_long_exhale` | Respiração com expiração longa | Ajudar o corpo a sair de estado de alerta após treino ou stress. |
| `recovery_breathing_90_90` | Respiração 90/90 de recuperação | Unir respiração, costelas e pélvis para reduzir tensão. |
| `recovery_breathing_box_light` | Box breathing leve | Criar ritmo respiratório simples para acalmar. |
| `recovery_breathing_nasal_walk` | Caminhada com respiração nasal | Combinar movimento leve com controlo respiratório. |
| `recovery_breathing_ribcage_relax` | Respiração costal para relaxar tronco | Reduzir rigidez de costas, pescoço e caixa torácica. |
| `recovery_nervous_system_downshift` | Desligar progressivo pós-treino | Criar uma sequência curta para baixar ativação física e mental. |

## Notas de modelação

Respiração não substitui tratamento médico. Tontura, falta de ar anormal ou dor no peito exigem parar e avaliar.

---

# Mobilidade leve como recuperação

## Sistema alvo

```text
articulações
líquido sinovial
tecidos moles
coordenação leve
sensação de rigidez
```

## Métodos úteis

```text
CARs suaves
mobilidade articular leve
flows lentos
transições simples
movimento sem carga
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_light_joint_cars` | CARs leves de recuperação | Mover articulações com amplitude confortável para reduzir rigidez. |
| `recovery_light_mobility_flow` | Flow leve de mobilidade | Unir movimentos suaves sem gerar fadiga. |
| `recovery_morning_joint_reset` | Reset articular matinal | Acordar articulações e corpo com intensidade baixa. |
| `recovery_evening_mobility_reset` | Reset articular ao fim do dia | Baixar rigidez acumulada de treino, trabalho ou computador. |
| `recovery_spine_hip_light_flow` | Flow leve coluna e anca | Soltar lombar, torácica e anca sem alongar agressivamente. |
| `recovery_shoulders_light_flow` | Flow leve de ombros e escápulas | Reduzir sensação de tensão após empurrar, puxar ou striking. |

## Notas de modelação

Mobilidade de recuperação deve ficar longe de dor e de fadiga. Não é sessão de mobilidade intensa.

---

# Elasticidade leve como recuperação

## Sistema alvo

```text
músculos
tendões
fáscia
sistema nervoso
tolerância a posição alongada
```

## Métodos úteis

```text
alongamento estático leve
respiração em alongamento
posições de relaxamento
alongamento pós-treino
sequências curtas
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_light_static_stretching` | Alongamento estático leve de recuperação | Reduzir tensão sem tentar ganhar máxima amplitude. |
| `recovery_post_training_stretch_sequence` | Sequência leve pós-treino | Alongar zonas treinadas com baixa intensidade. |
| `recovery_evening_stretch_relax` | Alongamentos leves à noite | Ajudar corpo a relaxar depois do dia. |
| `recovery_neck_chest_stretch_computer` | Alongamento pescoço e peito pós-computador | Baixar tensão de postura sentada e ombros à frente. |
| `recovery_hips_hamstrings_light` | Alongamento leve de anca e posterior | Reduzir rigidez de pernas e lombar. |
| `recovery_martial_kicks_stretch_light` | Alongamento leve pós-pontapés | Baixar tensão de adutores, flexores da anca e posterior. |

## Notas de modelação

Recuperação por alongamento deve ser confortável. Dor, formigueiro ou sensação nervosa não são objetivo.

---

# Foam roller

## Sistema alvo

```text
tecidos moles
fáscia superficial
sensação de tensão
perceção corporal
circulação local leve
```

## Métodos úteis

```text
pressão leve
rolamento lento
pausas em pontos tensos
respiração
zonas musculares grandes
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_foam_roller_quads` | Foam roller nos quadríceps | Reduzir sensação de tensão na frente da coxa. |
| `recovery_foam_roller_calves` | Foam roller nos gémeos | Relaxar barriga da perna após corrida, corda ou footwork. |
| `recovery_foam_roller_glutes` | Foam roller nos glúteos | Baixar rigidez de glúteos e lateral da anca. |
| `recovery_foam_roller_lats` | Foam roller no dorsal | Reduzir tensão na lateral das costas. |
| `recovery_foam_roller_upper_back` | Foam roller na parte alta das costas | Relaxar torácica e costas altas sem rolar lombar. |
| `recovery_foam_roller_adductors` | Foam roller nos adutores | Trabalhar virilha e coxa interna com pressão moderada. |
| `recovery_foam_roller_post_leg_day` | Foam roller pós-treino de pernas | Sequência curta para quadríceps, glúteos, adutores e gémeos. |
| `recovery_foam_roller_post_martial` | Foam roller pós-artes marciais | Baixar tensão de pernas, costas e ombros após treino técnico. |

## Notas de modelação

Foam roller não deve esmagar articulações, lombar, pescoço ou zonas de dor aguda. Pressão moderada chega.

---

# Bola de massagem

## Sistema alvo

```text
pontos de tensão local
planta do pé
glúteos
peitoral
trapézio
antebraço
```

## Métodos úteis

```text
pressão localizada
movimento pequeno
respiração
descarga de peso controlada
curta duração
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_massage_ball_feet` | Bola de massagem na planta do pé | Reduzir rigidez do pé após corrida, trabalho em pé ou treino. |
| `recovery_massage_ball_glutes` | Bola de massagem nos glúteos | Trabalhar pontos de tensão na anca posterior. |
| `recovery_massage_ball_pecs` | Bola de massagem no peitoral | Relaxar peito e ombro anterior junto à parede. |
| `recovery_massage_ball_traps` | Bola de massagem no trapézio contra parede | Baixar tensão de ombro e pescoço com pressão controlada. |
| `recovery_massage_ball_forearms` | Bola de massagem no antebraço | Recuperar antebraços após pega, BJJ, barras ou trabalho manual. |
| `recovery_massage_ball_upper_back` | Bola de massagem nas costas altas | Aliviar pontos entre omoplatas sem pressionar coluna diretamente. |

## Notas de modelação

Bola de massagem é mais intensa que foam roller. Evitar nervos, articulações, garganta, zona lombar direta e dor aguda.

---

# Pistola de massagem

## Sistema alvo

```text
músculos grandes
sensação de tensão
circulação local
relaxamento periférico
recuperação subjetiva
```

## Métodos úteis

```text
percussão leve
tempo curto
zonas musculares grandes
evitar ossos e articulações
usar antes ou depois do treino conforme objetivo
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_massage_gun_quads` | Pistola de massagem nos quadríceps | Reduzir sensação de tensão em músculo grande da frente da coxa. |
| `recovery_massage_gun_glutes` | Pistola de massagem nos glúteos | Relaxar glúteos e anca posterior. |
| `recovery_massage_gun_calves` | Pistola de massagem nos gémeos | Baixar rigidez após corrida, corda ou trabalho em pé. |
| `recovery_massage_gun_lats` | Pistola de massagem no dorsal | Relaxar lateral das costas com cuidado no ombro. |
| `recovery_massage_gun_shoulders_safe` | Pistola de massagem no ombro com segurança | Usar em zonas musculares, evitando articulações e pescoço. |
| `recovery_massage_gun_general_rules` | Regras gerais da pistola de massagem | Usar baixa intensidade, pouco tempo e evitar zonas sensíveis. |

## Notas de modelação

Não usar pistola de massagem no pescoço anterior, cabeça, coluna direta, articulações, varizes, feridas ou dor aguda.

---

# Calor, frio e contraste

## Sistema alvo

```text
temperatura local
perceção de dor
relaxamento muscular
inflamação aguda
sensação de recuperação
```

## Métodos úteis

```text
calor leve
duche quente
frio local
contraste simples
banho morno
gestão subjetiva
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_heat_relaxation` | Calor leve para relaxamento | Usar calor para sensação de relaxamento muscular e conforto. |
| `recovery_warm_shower_post_training` | Duche quente pós-treino leve | Ajudar a baixar tensão e preparar descanso. |
| `recovery_cold_local_acute_soreness` | Frio local em desconforto agudo | Usar frio de forma curta quando há sensação de irritação recente. |
| `recovery_contrast_simple` | Contraste simples quente e frio | Alternar temperatura de forma leve para sensação de recuperação. |
| `recovery_heat_for_stiffness` | Calor para rigidez | Usar calor quando a sensação principal é rigidez não aguda. |
| `recovery_temperature_method_safety` | Regras de segurança para temperatura | Evitar extremos, queimaduras, dormência e exposição longa. |

## Notas de modelação

Métodos de temperatura não substituem avaliação médica. Dor forte, inchaço relevante, trauma ou perda de função exigem cuidado profissional.

---

# Recuperação de mãos, punhos e pega

## Sistema alvo

```text
dedos
punhos
antebraços
tendões flexores
tendões extensores
sistema de pega
```

## Métodos úteis

```text
shake out
mobilidade leve
alongamento leve
bola de massagem
extensão dos dedos
descarga de pega
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_grip_shake_out` | Shake out de mãos e antebraços | Descarregar tensão de pega entre rondas ou pós-treino. |
| `recovery_grip_forearm_stretch_light` | Alongamento leve de antebraço pós-pega | Baixar tensão sem irritar tendões. |
| `recovery_grip_extensor_balance` | Extensão leve dos dedos pós-pega | Equilibrar muito trabalho de flexão dos dedos. |
| `recovery_grip_bjj_judo_sequence` | Sequência pós-BJJ ou Judo para pega | Recuperar dedos, punhos e antebraços depois de kimono. |
| `recovery_grip_barbell_sequence` | Sequência pós-barras e farmer walks | Baixar tensão de antebraço depois de cargas e holds. |
| `recovery_wrist_support_reset` | Reset leve de punhos após apoios | Recuperar punhos após flexões, prancha, quedas ou solo. |

## Notas de modelação

Dedos e tendões não gostam de agressividade. Dor pontual forte, inchaço ou perda de força não devem ser ignorados.

---

# Recuperação de pés, tornozelos e pernas

## Sistema alvo

```text
pés
arco plantar
tibial anterior
gémeos
sóleo
joelhos
anca
```

## Métodos úteis

```text
caminhada leve
elevação de pernas
mobilidade de tornozelo
bola na planta do pé
alongamento leve de gémeos
respiração e descanso
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_feet_after_standing_day` | Recuperação dos pés após dia em pé | Baixar tensão de pés e pernas depois de muitas horas de trabalho. |
| `recovery_feet_ball_release` | Libertação leve da planta do pé | Usar bola para relaxar planta do pé. |
| `recovery_ankle_light_mobility` | Mobilidade leve de tornozelo pós-treino | Reduzir rigidez de tornozelo sem carregar muito. |
| `recovery_calves_after_running` | Recuperação de gémeos pós-corrida | Combinar caminhada leve, alongamento leve e massagem suave. |
| `recovery_tibialis_after_treadmill` | Recuperação de tibial anterior pós-passadeira | Reduzir tensão na canela após caminhada inclinada ou corrida. |
| `recovery_leg_elevation_relax` | Elevação leve de pernas | Usar posição confortável para sensação de descanso nas pernas. |
| `recovery_lower_body_after_fairs_work` | Recuperação de pernas após trabalho físico | Soltar pés, gémeos, lombar e anca depois de muitas horas em pé. |

## Notas de modelação

Recuperação de pernas deve distinguir fadiga normal de dor articular ou lesão. Dor localizada forte muda o plano.

---

# Recuperação de costas, lombar e postura

## Sistema alvo

```text
lombar
torácica
anca
pescoço
escápulas
respiração
core
```

## Métodos úteis

```text
respiração
mobilidade leve
posições de descarga
cat cow leve
child pose
caminhada leve
reset postural
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_low_back_decompression_position` | Posição de descarga lombar | Reduzir tensão lombar com posição confortável e respiração. |
| `recovery_low_back_child_pose_light` | Child pose leve para lombar | Usar flexão suave para relaxar costas, se tolerado. |
| `recovery_low_back_cat_cow_light` | Cat cow leve de recuperação | Mover coluna com suavidade para reduzir rigidez. |
| `recovery_post_computer_spine_reset` | Reset coluna pós-computador | Soltar pescoço, torácica, peito e anca após horas sentado. |
| `recovery_upper_back_posture_reset` | Reset de costas altas e escápulas | Baixar tensão entre omoplatas e ombros. |
| `recovery_low_back_after_hinge` | Recuperação lombar pós-dobradiça | Descarregar lombar depois de peso morto, good morning ou trabalho físico. |
| `recovery_low_back_red_flags` | Regras de alerta para lombar | Identificar quando não é treino e precisa de avaliação. |

## Notas de modelação

Dormência, formigueiro, perda de força, dor irradiada forte ou dor após trauma não devem ser tratados como simples recuperação.

---

# Recuperação específica de artes marciais

## Sistema alvo

```text
pescoço
ombros
antebraços
anca
adutores
joelhos
tornozelos
sistema nervoso
```

## Métodos úteis

```text
cooldown técnico leve
respiração
mobilidade de anca
alongamento leve de adutores
recuperação de pega
foam roller
descompressão mental
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_karate_post_class` | Recuperação pós-Karate | Baixar tensão de pernas, anca, ombros e sistema nervoso. |
| `recovery_bjj_post_class` | Recuperação pós-Jiu-Jitsu / BJJ | Recuperar pega, pescoço, lombar, anca e respiração. |
| `recovery_striking_post_bag` | Recuperação pós-saco | Reduzir tensão de ombros, punhos, gémeos e respiração. |
| `recovery_grappling_neck_shoulders` | Recuperação de pescoço e ombros pós-grappling | Baixar tensão de frames, pressão e pegadas. |
| `recovery_martial_adductors_hips` | Recuperação de adutores e anca pós-artes marciais | Soltar virilha e anca após pontapés, guarda e bases. |
| `recovery_martial_downregulation` | Desligar sistema nervoso pós-treino marcial | Usar respiração e movimento leve depois de treino intenso. |
| `recovery_sparring_light_reset` | Reset leve pós-sparring técnico | Baixar ativação e verificar zonas sensíveis. |

## Notas de modelação

Após contacto, quedas ou sparring, distinguir fadiga normal de pancada, torção, concussão ou dor persistente.

---

# Gestão de carga, deload e recuperação entre treinos

## Sistema alvo

```text
fadiga sistémica
músculos
tendões
articulações
sono
stress
performance
```

## Métodos úteis

```text
reduzir volume
reduzir intensidade
trocar por sessão leve
descanso ativo
deload
monitorizar sintomas
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_load_management_basic` | Gestão básica de carga | Ajustar treino quando fadiga, dor ou queda de performance aumentam. |
| `recovery_deload_week` | Semana de deload | Reduzir volume ou intensidade para recuperar e voltar melhor. |
| `recovery_session_swap_light` | Trocar sessão pesada por leve | Manter hábito sem acumular fadiga. |
| `recovery_between_strength_sessions` | Recuperação entre treinos de força | Gerir intervalo entre estímulos do mesmo músculo. |
| `recovery_between_martial_sessions` | Recuperação entre treinos de artes marciais | Gerir impacto, pega, pescoço, lombar e fadiga nervosa. |
| `recovery_autoregulation_readiness` | Autoregulação por prontidão | Adaptar treino ao sono, dor, energia e performance do dia. |
| `recovery_overload_warning_signs` | Sinais de sobrecarga | Identificar quando insistir pode piorar recuperação. |

## Notas de modelação

Este bloco deve ligar ao diário de treino. Antes de avaliar sobrecarga, comparar data atual com data do último treino registado.

---

# Sono, rotina e recuperação geral

## Sistema alvo

```text
sono
stress
sistema nervoso
hormonas
energia diária
recuperação muscular
```

## Métodos úteis

```text
rotina pré-sono
luz baixa
respiração
alongamento leve
redução de estímulo
consistência
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_sleep_routine_basic` | Rotina básica pré-sono | Criar sequência simples para preparar descanso. |
| `recovery_evening_downshift` | Desaceleração ao fim do dia | Reduzir ativação mental e física antes de dormir. |
| `recovery_sleep_mobility_light` | Mobilidade leve antes de dormir | Soltar rigidez sem aumentar energia. |
| `recovery_sleep_breathing` | Respiração para pré-sono | Usar expiração lenta para relaxar. |
| `recovery_sleep_post_late_training` | Recuperação após treino tardio | Baixar ativação depois de treinar à noite. |
| `recovery_general_rest_day` | Dia de descanso estruturado | Descansar sem cair em inatividade total se o corpo beneficiar de movimento leve. |

## Notas de modelação

Sono é pilar de recuperação. A app pode sugerir rotinas leves, não soluções médicas.

---

# Dor, desconforto e regras de segurança

## Sistema alvo

```text
dor muscular tardia
dor articular
tendões
nervos
trauma
sinais sistémicos
```

## Métodos úteis

```text
triagem simples
reduzir intensidade
evitar dor aguda
regressão
descanso
encaminhamento quando necessário
```

## Conceitos treináveis

| Concept ID | Conceito | Explicação |
|---|---|---|
| `recovery_soreness_normal_dom` | Dor muscular tardia normal | Distinguir desconforto muscular esperado de sinal de problema. |
| `recovery_joint_pain_rule` | Regra para dor articular | Dor articular não deve ser tratada como treino produtivo. |
| `recovery_tendon_irritation_rule` | Regra para irritação tendinosa | Reduzir carga e evitar alongamento agressivo quando tendão está irritado. |
| `recovery_nerve_symptom_rule` | Regra para sintomas nervosos | Formigueiro, dormência ou choque elétrico não são alvo de alongamento forte. |
| `recovery_acute_injury_stop_rule` | Regra de parar em lesão aguda | Parar se houver trauma, estalido doloroso, inchaço ou perda de função. |
| `recovery_medical_referral_flags` | Sinais para avaliação profissional | Definir alertas que a app não deve tentar resolver com exercícios. |

## Notas de modelação

Este bloco é obrigatório para evitar que a app recomende recuperação errada para dor que precisa de avaliação.

---

# Mapa de métodos

| Método | Melhor uso | Não usar como | Cuidados |
|---|---|---|---|
| Caminhada leve | recuperação ativa, cooldown, dia leve | HIIT ou treino de zona 2 se a intenção for recuperar | respiração controlada e baixa fadiga |
| Bicicleta leve | baixo impacto, pernas cansadas, cooldown | sprints ou intervalos | manter resistência baixa |
| Respiração | downregulation, pré-sono, pós-treino | solução para sintomas graves | parar com tontura ou falta de ar anormal |
| Mobilidade leve | rigidez articular, manhã, pós-computador | sessão intensa de mobilidade | amplitude confortável |
| Alongamento leve | cooldown, relaxamento, pós-treino | progressão agressiva de flexibilidade | sem dor, sem formigueiro |
| Foam roller | tensão muscular em zonas grandes | tratamento de lesão aguda | evitar ossos, articulações e lombar direta |
| Bola de massagem | pontos de tensão locais | pressão agressiva em nervos ou articulações | pressão moderada |
| Pistola de massagem | músculos grandes e tensão local | uso em pescoço, cabeça, articulações ou dor aguda | tempo curto e baixa intensidade |
| Calor | rigidez e relaxamento | trauma agudo com inchaço sem avaliação | evitar queimaduras |
| Frio | desconforto agudo localizado | exposição longa ou dormência | proteger pele |
| Deload | fadiga acumulada e queda de performance | desistir do treino | reduzir carga ou volume de forma planeada |

# Mapa de cruzamentos

| Conceito | Domínio principal | Também aparece em | Motivo |
|---|---|---|---|
| Caminhada leve | Cardio | Recuperação, Aquecimento | É recuperação quando a intensidade é baixa e o objetivo é circulação sem fadiga. |
| Passadeira cooldown | Recuperação | Cardio | Usa equipamento de cardio, mas o objetivo é baixar intensidade. |
| 90/90 leve com respiração | Recuperação | Mobilidade, Elasticidade | Pode baixar rigidez da anca sem procurar máxima amplitude. |
| Foam roller nos quadríceps | Recuperação | Elasticidade auxiliar | Reduz tensão subjetiva, não treina força nem mobilidade ativa. |
| Bola na planta do pé | Recuperação | Elasticidade dos pés | Pode relaxar fáscia plantar e melhorar sensação do pé. |
| Technical stand-up lento | Mobilidade | Recuperação, Artes marciais | Pode ser recuperação se feito leve como flow, técnica se usado em defesa pessoal. |
| Sombra leve | Artes marciais | Cardio, Recuperação | É recuperação quando feita muito leve e técnica, sem fadiga. |
| Deload | Recuperação | Planeamento de treino | Não é exercício, é estratégia de gestão de carga. |

# Filtros recomendados para a app

## Por objetivo

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
  > Pós-musculação
  > Pós-cardio
  > Pós-artes marciais
  > Pega e antebraço
  > Pés e pernas
  > Costas e postura
  > Sono
  > Deload
  > Segurança
```

## Por zona

```text
Recuperação
  > Pescoço
  > Ombros
  > Peito
  > Costas
  > Lombar
  > Anca
  > Adutores
  > Pernas
  > Gémeos
  > Pés
  > Punhos e mãos
  > Sistema nervoso
```

## Por contexto

```text
Recuperação
  > Pós-treino
  > Dia de descanso
  > Pré-sono
  > Pós-computador
  > Pós-trabalho em pé
  > Entre treinos
  > Depois de BJJ
  > Depois de Karate
  > Depois de corrida
  > Depois de pernas
```

# Regras de descrição

Cada protocolo ou exercício de recuperação deve explicar:

```text
objetivo
sistema ou zona alvo
quando usar
intensidade esperada
duração típica
como fazer passo a passo
como saber se está leve o suficiente
erros comuns
versão mais fácil
versão mais completa
cuidados
sinais de alerta
```

## Descrição errada

```text
Faz isto para recuperar mais rápido.
```

## Descrição correta

```text
Objetivo:
Aumentar circulação leve nas pernas sem criar nova fadiga.

Como fazer:
1. Caminha a ritmo confortável.
2. Mantém respiração controlada, idealmente nasal se for confortável.
3. Não transformes isto em treino intenso.
4. Termina com sensação melhor ou igual à do início.

Erros comuns:
- Ir depressa demais.
- Transformar recuperação em cardio forte.
- Continuar se aparecer dor articular.
```

# Regras de segurança obrigatórias

```text
dor muscular leve pode ser gerida com recuperação simples
dor articular forte não é alvo de alongamento agressivo
dor aguda após trauma exige parar
formigueiro, dormência ou choque elétrico exigem cautela
perda de força não deve ser ignorada
inchaço relevante muda o plano
dor no peito, falta de ar anormal ou tontura forte não são treino
pistola de massagem não deve ser usada no pescoço anterior, cabeça, coluna direta ou articulações
foam roller não deve rolar diretamente sobre lombar, joelhos, cotovelos ou coluna cervical
PNF não é recuperação leve
HIIT nunca é recuperação
```

# Testes obrigatórios

```text
todo método de recuperação tem objetivo
todo método de recuperação tem sistema ou zona alvo
todo método de recuperação tem intensidade
todo método de recuperação tem contexto de uso
todo método de recuperação tem cuidados
todo método com dor tem regra de segurança
todo exercício cruzado mantém identidade única
todo cardio de recuperação mantém intensidade baixa
todo alongamento de recuperação é leve
todo foam roller evita articulações e coluna sensível
todo método de pistola de massagem tem contraindicações básicas
todo bloco de gestão de carga considera data do último treino
```

# Contagem

Este ficheiro define `102` conceitos de recuperação.

# Próximo ficheiro

O próximo ficheiro deve ser:

```text
21_RECUPERACAO_EXERCICIOS_DERIVADOS.md
```

Esse ficheiro deve transformar estes conceitos em protocolos e exercícios concretos, com:

```text
concept_id
exercício ou protocolo
sistema ou zona
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