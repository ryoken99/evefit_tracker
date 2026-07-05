# 11 - Musculação: exercícios derivados dos conceitos

## Objetivo

Este ficheiro transforma o mapa conceptual de musculação em exercícios derivados.

A lógica é:

```text
conceito treinável
  -> família de exercício
    -> exercício canónico
      -> variação real
        -> filtros, equipamento e locais
```

Este documento ainda não é a versão final com descrições completas. É a primeira tabela canónica para impedir duplicados, separar variações reais e preparar o mapeamento para a app.

## Regra usada

```text
Um exercício pode aparecer em vários filtros.
Mas só deve existir uma vez como entidade canónica.
```

Exemplo:

```text
Face pull no cabo
  primary_type: musculação
  filtros:
    - Ombros > Deltoide posterior
    - Costas > Espessura alta
    - Trapézio > Médio
    - Manguito rotador / prevenção
```

Não deve existir como quatro exercícios diferentes.

## Colunas

```text
concept_id: conceito treinável que gera o exercício
exercício: nome visível ao utilizador
família: família técnica
variação: diferença relevante que justifica a entrada
principais: estruturas principais
secundários: estruturas auxiliares
equipamento: equipamento necessário ou possível
locais: onde pode ser feito
filtros: filtros prováveis na app
nota: decisão de modelação ou risco de duplicação
```


# Pescoço
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| cervical_front_isometric_stability | Isometria cervical frontal leve | isometria cervical | frontal | flexores cervicais profundos | esternocleidomastoideu, escalenos | mão, parede, sem equipamento | casa, ginásio, dojo | Musculação > Pescoço > Anterior; Prevenção > Cervical | Manter carga leve e foco em controlo. |
| cervical_posterior_isometric_stability | Isometria cervical posterior leve | isometria cervical | posterior | extensores cervicais | trapézio superior | mão, parede, sem equipamento | casa, ginásio, dojo | Musculação > Pescoço > Posterior; Prevenção > Cervical | Não usar como treino pesado inicial. |
| cervical_lateral_isometric_stability | Isometria cervical lateral leve | isometria cervical | lateral | estabilizadores cervicais laterais | escalenos, trapézio superior | mão, parede, sem equipamento | casa, ginásio, dojo | Musculação > Pescoço > Lateral; Prevenção > Cervical | Útil para artes marciais de forma conservadora. |
| cervical_rotation_control | Rotação cervical controlada | mobilização ativa de força leve | rotação | rotadores cervicais | estabilizadores cervicais | sem equipamento | casa, ginásio, dojo | Pescoço > Rotação; Mobilidade > Pescoço | É mais controlo e mobilidade do que força pesada. |
| deep_neck_flexor_control | Chin tuck | controlo cervical | queixo para dentro | flexores cervicais profundos | estabilizadores cervicais | sem equipamento, parede opcional | casa, ginásio, dojo | Pescoço > Controlo profundo; Postura > Cervical | Muito importante para postura e prevenção. |
| cervical_neutral_postural_endurance | Estabilização cervical em postura neutra | isometria postural | neutra | estabilizadores cervicais | core alto, trapézio | sem equipamento | casa, ginásio, exterior, dojo | Pescoço > Postura; Prevenção > Postura | Pode ser usada em aquecimento e recuperação. |
| cervical_quadruped_stability | Estabilização cervical em quadrupedia | isometria cervical | quadrupedia | estabilizadores cervicais | core, escápulas | sem equipamento, tapete | casa, ginásio, dojo | Pescoço > Estabilidade; Core > Controlo | Cruza com core e postura. |
| cervical_multidirectional_light_resistance | Resistência cervical multidirecional leve | isometria cervical | múltiplas direções | estabilizadores cervicais | flexores, extensores, laterais | mão, elástico leve opcional | casa, ginásio, dojo | Pescoço > Completo; Prevenção > Cervical | Versão avançada só com elástico leve. |

# Trapézio e cintura escapular
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| scapular_elevation_resistance | Encolhimento de ombros com halteres | encolhimento | halteres | trapézio superior | elevador da escápula, antebraço | halteres | casa equipada, ginásio | Musculação > Trapézio > Superior; Equipamento > Halteres | Variação canónica de carga livre. |
| scapular_elevation_resistance | Encolhimento de ombros com barra | encolhimento | barra | trapézio superior | antebraço, core | barra, discos | casa equipada, ginásio | Musculação > Trapézio > Superior; Equipamento > Barra | Separado dos halteres pela linha e equipamento. |
| scapular_elevation_guided_resistance | Encolhimento de ombros na máquina | encolhimento | máquina | trapézio superior | antebraço | máquina | ginásio | Musculação > Trapézio > Superior; Equipamento > Máquina | Só ginásio. |
| scapular_retraction_external_rotation | Face pull no cabo | face pull | cabo | trapézio médio, deltoide posterior | manguito rotador, romboides | cabo alto, corda | ginásio | Costas > Espessura alta; Ombros > Posterior; Trapézio > Médio | Entidade única, não duplicar em ombros e costas. |
| scapular_retraction_external_rotation | Face pull com elástico | face pull | elástico | trapézio médio, deltoide posterior | manguito rotador, romboides | elástico | casa equipada, ginásio, dojo | Ombros > Posterior; Trapézio > Médio; Prevenção > Ombro | Variação separada por equipamento. |
| scapular_upper_pull_pattern | Remo alto leve | remo alto | leve | trapézio superior, deltoide lateral | bíceps, antebraço | barra, halteres, cabo | casa equipada, ginásio | Trapézio > Superior; Ombros > Deltoide lateral | Atenção a desconforto no ombro. |
| scapular_depression_suspension | Scapular pull-up | controlo escapular | suspensão | trapézio inferior, dorsal | antebraço, core | barra fixa | casa equipada, ginásio, exterior | Costas > Puxada vertical; Trapézio > Inferior; Calistenia | Não é pull-up completo. |
| scapular_protraction_support | Scapular push-up | controlo escapular | apoio | serrátil anterior | trapézio, core, peitoral menor | sem equipamento, tapete | casa, ginásio, dojo | Ombros > Estabilidade escapular; Prevenção > Ombro | Cruza aquecimento e prevenção. |
| lower_trap_raise_control | Y raise | elevação escapular | Y | trapézio inferior | deltoide posterior, manguito | halteres leves, banco, sem equipamento | casa equipada, ginásio | Trapézio > Inferior; Ombros > Estabilidade | Carga deve ser leve. |
| mid_trap_external_rotation_control | W raise | elevação escapular | W | trapézio médio, manguito rotador | deltoide posterior | halteres leves, sem equipamento | casa equipada, ginásio | Trapézio > Médio; Manguito rotador | Aquecimento/prevenção. |
| loaded_postural_carry | Farmer walk | transporte | bilateral | trapézio superior, antebraço | core, pernas, lombar | halteres, kettlebell, garrafões | casa equipada, ginásio, exterior | Força prática > Transporte; Trapézio; Pega | Também é força prática e pega. |
| scapular_depression_hang | Dead hang escapular | suspensão | escapular | trapézio inferior, dorsal | antebraço, ombros | barra fixa | casa equipada, ginásio, exterior | Costas > Escápula; Pega > Suporte; Calistenia | Diferenciar de dead hang passivo. |

# Peito
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| horizontal_push_bilateral_free_weight | Supino com barra | supino | barra horizontal | peitoral maior porção esternal | tríceps, deltoide anterior | barra, banco, discos | casa equipada, ginásio | Peito > Médio; Empurrar horizontal; Barra | Movimento composto principal. |
| horizontal_push_bilateral_free_weight | Supino com halteres | supino | halteres horizontal | peitoral maior porção esternal | tríceps, deltoide anterior, estabilizadores | halteres, banco | casa equipada, ginásio | Peito > Médio; Empurrar horizontal; Halteres | Mais estabilidade que barra. |
| incline_push_upper_chest | Supino inclinado com halteres | supino | inclinado halteres | peitoral maior porção clavicular | deltoide anterior, tríceps | halteres, banco inclinado | casa equipada, ginásio | Peito > Superior; Empurrar inclinado | Separado pelo ângulo. |
| incline_push_upper_chest | Supino inclinado com barra | supino | inclinado barra | peitoral maior porção clavicular | deltoide anterior, tríceps | barra, banco inclinado, discos | casa equipada, ginásio | Peito > Superior; Barra | Separado por equipamento. |
| decline_push_lower_chest | Supino declinado com halteres | supino | declinado halteres | peitoral maior porção inferior | tríceps, deltoide anterior | halteres, banco declinado | ginásio, casa equipada | Peito > Inferior; Halteres | Ângulo muda foco e filtro. |
| decline_push_lower_chest | Supino declinado com barra | supino | declinado barra | peitoral maior porção inferior | tríceps, deltoide anterior | barra, banco declinado, discos | ginásio, casa equipada | Peito > Inferior; Barra | Variação própria. |
| horizontal_push_machine | Chest press | press de peito | máquina | peitoral maior | tríceps, deltoide anterior | máquina chest press | ginásio | Peito > Médio; Equipamento > Máquina | Máquina guiada. |
| bodyweight_horizontal_push | Flexão clássica | flexão | clássica | peitoral maior | tríceps, deltoide anterior, core | peso corporal | casa, ginásio, exterior, dojo | Peito > Peso corporal; Sem equipamento | Entidade base para flexões. |
| bodyweight_horizontal_push_regressed | Flexão com joelhos apoiados | flexão | joelhos apoiados | peitoral maior | tríceps, deltoide anterior, core | peso corporal, tapete | casa, ginásio, dojo | Peito > Regressão; Sem equipamento | Variação separada por nível. |
| bodyweight_incline_push | Flexão inclinada | flexão | mãos elevadas | peitoral maior | tríceps, ombro anterior | peso corporal, banco, parede | casa, ginásio, exterior | Peito > Iniciante; Sem equipamento | Mais fácil que flexão no chão. |
| bodyweight_decline_push | Flexão declinada | flexão | pés elevados | peitoral superior, deltoide anterior | tríceps, core | peso corporal, banco | casa, ginásio, exterior | Peito > Superior; Peso corporal | Mais difícil e mais ombro. |
| bodyweight_wide_push | Flexão aberta | flexão | mãos abertas | peitoral maior | tríceps, deltoide anterior | peso corporal | casa, ginásio, dojo | Peito > Adução horizontal; Peso corporal | Não duplicar com flexão clássica. |
| bodyweight_unilateral_push_progression | Flexão arqueiro | flexão | arqueiro | peitoral maior unilateral | tríceps, ombro, core | peso corporal | casa, ginásio, dojo | Peito > Unilateral; Avançado | Progressão para força unilateral. |
| dip_chest_focus | Dips para peito em paralelas | dips | foco peito | peitoral inferior | tríceps, deltoide anterior | paralelas | ginásio, exterior, casa equipada | Peito > Inferior; Calistenia | Diferenciar de dips para tríceps. |
| dip_chest_assisted | Dips assistidos para peito na máquina | dips | assistido máquina | peitoral inferior | tríceps, ombro anterior | máquina de dips assistidos | ginásio | Peito > Inferior; Máquina; Regressão | Variação de ginásio. |
| horizontal_adduction_dumbbell | Aberturas com halteres | aberturas | halteres horizontal | peitoral maior | deltoide anterior, estabilizadores | halteres, banco | casa equipada, ginásio | Peito > Isolamento; Adução horizontal | Isolamento, não empurrar. |
| incline_horizontal_adduction_dumbbell | Aberturas inclinadas com halteres | aberturas | inclinado halteres | peitoral superior | deltoide anterior | halteres, banco inclinado | casa equipada, ginásio | Peito > Superior > Isolamento | Ângulo muda foco. |
| incline_horizontal_adduction_cable | Aberturas inclinadas no cabo | aberturas | inclinado cabo | peitoral superior | deltoide anterior | cabos, polias | ginásio | Peito > Superior; Cabo | Cabo mantém tensão. |
| horizontal_adduction_elastic | Aberturas com elástico | aberturas | elástico | peitoral maior | deltoide anterior | elástico | casa equipada, ginásio, dojo | Peito > Isolamento; Elástico | Variação doméstica. |
| cable_horizontal_adduction | Crossover no cabo | crossover | cabo | peitoral maior | deltoide anterior | cabo, polias | ginásio | Peito > Isolamento; Cabo | Não duplicar com aberturas no cabo se descrição for igual. |
| compression_press_chest | Squeeze press | press compressivo | halteres juntos | peitoral maior | tríceps, deltoide anterior | halteres, banco | casa equipada, ginásio | Peito > Tensão interna; Halteres | Conceito de compressão/addução ativa. |
| shoulder_extension_pullover_chest | Pullover com halter, foco peito | pullover | halter | peitoral maior, serrátil | dorsal, tríceps | halter, banco | casa equipada, ginásio | Peito > Pullover; Costas > Pullover | Entidade única com foco selecionável. |

# Costas largura
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| vertical_pull_open_grip | Puxada alta pega aberta | puxada alta | pega aberta | latíssimo do dorso | redondo maior, bíceps, antebraço | lat pulldown, cabo | ginásio | Costas > Largura; Puxada vertical | Só ginásio. |
| vertical_pull_neutral_grip | Puxada alta pega neutra | puxada alta | pega neutra | latíssimo do dorso | bíceps, braquial, antebraço | lat pulldown, pega neutra | ginásio | Costas > Largura; Pega neutra | Variação própria de pega. |
| vertical_pull_close_grip | Puxada alta pega fechada | puxada alta | pega fechada | latíssimo do dorso | bíceps, romboides | lat pulldown, cabo | ginásio | Costas > Largura; Pega fechada | Maior amplitude para alguns utilizadores. |
| vertical_pull_bodyweight | Pull-up | pull-up | peso corporal pronado | latíssimo do dorso | bíceps, trapézio inferior, antebraço | barra fixa | casa equipada, ginásio, exterior | Costas > Largura; Calistenia; Pega | Movimento composto. |
| vertical_pull_supinated_elbow_flexion | Chin-up | chin-up | supinado | latíssimo do dorso, bíceps | braquial, antebraço, core | barra fixa | casa equipada, ginásio, exterior | Costas > Puxada vertical; Bíceps; Calistenia | Cruza bíceps e costas. |
| scapular_depression_suspension | Scapular pull-up | pull-up escapular | escapular | trapézio inferior, dorsal | antebraço, core | barra fixa | casa equipada, ginásio, exterior | Costas > Escápula; Trapézio inferior | Mesmo exercício já listado em trapézio, manter id único. |
| straight_arm_shoulder_extension_cable | Puxada com braços esticados | puxada braços esticados | cabo | latíssimo do dorso | tríceps longo, core | cabo alto | ginásio | Costas > Dorsal; Cabo | Isola dorsal sem flexão de cotovelo. |
| straight_arm_shoulder_extension_cable | Pullover no cabo | pullover | cabo | latíssimo do dorso | peitoral, tríceps longo | cabo alto | ginásio | Costas > Dorsal; Cabo; Pullover | Pode ser sinónimo de puxada braços esticados, rever duplicado. |
| shoulder_extension_pullover_dumbbell | Pullover com halter, foco dorsal | pullover | halter | latíssimo do dorso | peitoral, serrátil, tríceps longo | halter, banco | casa equipada, ginásio | Costas > Dorsal; Peito > Pullover | Entidade única com foco selecionável. |
| unilateral_lat_row | Remo unilateral com foco em dorsal | remo unilateral | cotovelo junto ao corpo | latíssimo do dorso | bíceps, romboides | halter, cabo | casa equipada, ginásio | Costas > Dorsal; Remo unilateral | Diferenciar do remo para espessura pela trajetória. |
| elastic_vertical_pull | Puxada alta com elástico | puxada alta | elástico | latíssimo do dorso | bíceps, trapézio inferior | elástico, ponto alto | casa equipada, ginásio, dojo | Costas > Largura; Elástico | Útil para casa. |
| assisted_pull_up | Pull-up assistido | pull-up | assistido | latíssimo do dorso | bíceps, antebraço | elástico ou máquina assistida | ginásio, casa equipada, exterior | Costas > Largura; Regressão | Variação por nível e assistência. |

# Costas espessura
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| horizontal_pull_barbell | Remo com barra | remo | barra | romboides, trapézio médio, dorsal | lombar, bíceps, antebraço | barra, discos | casa equipada, ginásio | Costas > Espessura; Barra | Requer estabilização lombar. |
| horizontal_pull_dumbbell_unilateral | Remo unilateral com halter | remo | halter unilateral | dorsal, romboides | trapézio médio, bíceps, antebraço | halter, banco opcional | casa equipada, ginásio | Costas > Espessura; Unilateral; Halter | Pode ter foco dorsal ou romboides. |
| horizontal_pull_low_cable | Remo baixo no cabo | remo | cabo baixo | romboides, trapézio médio, dorsal | bíceps, antebraço | cabo baixo | ginásio | Costas > Espessura; Cabo | Cabo guiado. |
| horizontal_pull_machine_seated | Remo sentado | remo | máquina sentado | romboides, trapézio médio, dorsal | bíceps, antebraço | máquina remo sentado | ginásio | Costas > Espessura; Máquina | Pode ser máquina ou cabo, rever nomenclatura. |
| horizontal_pull_bodyweight | Remo invertido | remo invertido | barra | romboides, dorsal | bíceps, core, antebraço | barra baixa, argolas, TRX | ginásio, exterior, casa equipada | Costas > Espessura; Calistenia | Peso corporal. |
| horizontal_pull_bodyweight_table | Remo invertido em mesa resistente | remo invertido | mesa | romboides, dorsal | bíceps, core | mesa resistente | casa | Costas > Espessura; Casa sem equipamento | Só se mesa for segura. |
| horizontal_pull_elastic | Remo com elástico | remo | elástico | romboides, dorsal | bíceps, antebraço | elástico | casa equipada, ginásio, dojo | Costas > Espessura; Elástico | Boa variação doméstica. |
| rear_delt_upper_back_fly | Reverse fly | abertura posterior | halteres | deltoide posterior, romboides | trapézio médio, manguito | halteres, banco opcional | casa equipada, ginásio | Ombros > Posterior; Costas > Espessura alta | Entidade única com múltiplos filtros. |
| scapular_retraction_external_rotation | Face pull no cabo | face pull | cabo | deltoide posterior, trapézio médio | romboides, manguito | cabo alto, corda | ginásio | Costas > Espessura alta; Ombros > Posterior | Mesmo id da secção trapézio. |
| chest_supported_row | Remo com apoio no peito | remo | apoio no peito | romboides, dorsal | bíceps, antebraço | halteres, banco inclinado, máquina | ginásio, casa equipada | Costas > Espessura; Lombar poupada | Variação útil por poupar lombar. |
| wide_row_upper_back | Remo aberto para costas altas | remo | cotovelos abertos | trapézio médio, romboides, deltoide posterior | dorsal, bíceps | halteres, cabo, máquina | ginásio, casa equipada | Costas > Espessura alta; Ombros posterior | Conceito diferente do remo junto ao corpo. |
| single_arm_cable_row | Remo unilateral no cabo | remo | cabo unilateral | dorsal, romboides | bíceps, antebraço, core | cabo baixo ou ajustável | ginásio | Costas > Unilateral; Cabo | Linha de resistência diferente. |
| trx_row | Remo em suspensão TRX | remo invertido | TRX | romboides, dorsal | core, bíceps | TRX, argolas | ginásio, exterior, casa equipada | Costas > Peso corporal; Suspensão | Se houver TRX/argolas. |
| prone_scapular_retraction | Retração escapular deitado | controlo escapular | deitado | romboides, trapézio médio | deltoide posterior | sem equipamento, banco | casa, ginásio | Costas > Controlo escapular; Prevenção | Leve, técnico. |
| seal_row | Seal row | remo | banco alto | romboides, dorsal | bíceps, antebraço | barra ou halteres, banco alto | ginásio | Costas > Espessura; Lombar poupada | Avançado pela montagem. |

# Lombar e cadeia posterior baixa
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| lumbar_extension_controlled | Hiperextensão lombar | hiperextensão | banco romano | eretores da espinha | glúteos, posterior de coxa | banco romano | ginásio | Lombar > Extensão; Cadeia posterior | Controlar amplitude. |
| floor_lumbar_extension | Hiperextensão no chão | hiperextensão | chão | eretores da espinha | glúteos, posterior de coxa | sem equipamento, tapete | casa, ginásio, dojo | Lombar > Extensão; Sem equipamento | Variação acessível. |
| roman_chair_back_extension | Hiperextensão no banco romano | hiperextensão | banco romano | eretores da espinha | glúteos, posterior de coxa | banco romano | ginásio | Lombar > Extensão; Ginásio | Possível duplicado com hiperextensão lombar, rever nome final. |
| lumbar_isometric_extension | Superman isométrico | superman | isométrico | eretores da espinha | glúteos, ombros | sem equipamento, tapete | casa, ginásio, dojo | Lombar > Isometria; Sem equipamento | Evitar hiperextensão excessiva. |
| quadruped_lumbar_control | Extensão lombar quadrupede | controlo lombar | quadrupedia | multífidos, eretores | core, glúteos | sem equipamento, tapete | casa, ginásio, dojo | Lombar > Controlo; Prevenção | Leve. |
| contralateral_lumbar_stability | Bird dog | bird dog | contralateral | core profundo, lombar | glúteos, ombros | sem equipamento, tapete | casa, ginásio, dojo | Core > Estabilidade; Lombar > Controlo | Entidade única, aparece também em core. |
| hip_hinge_light | Good morning sem carga | good morning | sem carga | eretores, posterior de coxa | glúteos, core | sem equipamento | casa, ginásio, dojo | Lombar > Dobradiça; Pernas > Posterior | Técnico, aprender hinge. |
| hip_hinge_loaded_barbell | Good morning com barra | good morning | barra | posterior de coxa, eretores | glúteos, core | barra | ginásio, casa equipada | Posterior de coxa; Lombar; Barra | Avançado, técnica exigente. |
| hip_hinge_loaded_dumbbell | Peso morto romeno com halteres | peso morto romeno | halteres | posterior de coxa, glúteos | eretores, antebraço | halteres | casa equipada, ginásio | Posterior de coxa; Glúteos; Lombar | Composto. |
| deadlift_conventional | Peso morto tradicional | peso morto | tradicional | glúteos, posterior, eretores | trapézio, antebraço, quadríceps | barra, discos | ginásio, casa equipada | Força prática; Dobradiça; Corpo inteiro | Composto de alta exigência. |

# Ombros
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| vertical_push_barbell | Press militar com barra em pé | press militar | barra em pé | deltoide anterior, deltoide lateral | tríceps, trapézio, core | barra, discos | ginásio, casa equipada | Ombros > Press vertical; Barra | Composto. |
| vertical_push_dumbbell | Press militar com halteres | press militar | halteres | deltoide anterior, lateral | tríceps, core | halteres | casa equipada, ginásio | Ombros > Press vertical; Halteres | Mais estabilização unilateral. |
| vertical_push_machine | Shoulder press machine | press ombro | máquina | deltoide anterior, lateral | tríceps | máquina shoulder press | ginásio | Ombros > Press vertical; Máquina | Máquina guiada. |
| rotational_dumbbell_press | Arnold press | press ombro | arnold | deltoide anterior, lateral | tríceps, manguito | halteres | casa equipada, ginásio | Ombros > Press; Halteres | Mais rotação e amplitude. |
| bodyweight_vertical_push | Pike push-up | flexão vertical | pike | deltoide anterior, lateral | tríceps, core | peso corporal | casa, ginásio, dojo | Ombros > Peso corporal; Press vertical | Progressão para handstand push-up. |
| shoulder_abduction_resistance | Elevação lateral | elevação lateral | halteres | deltoide lateral | trapézio superior | halteres | casa equipada, ginásio | Ombros > Deltoide lateral | Base de isolamento. |
| shoulder_abduction_cable | Elevação lateral no cabo | elevação lateral | cabo | deltoide lateral | trapézio superior | cabo baixo ou polia | ginásio | Ombros > Deltoide lateral; Cabo | Adicionar ao catálogo. |
| shoulder_abduction_elastic | Elevação lateral com elástico | elevação lateral | elástico | deltoide lateral | trapézio superior | elástico | casa equipada, ginásio, dojo | Ombros > Deltoide lateral; Elástico | Adicionar ao catálogo. |
| shoulder_flexion_resistance | Elevação frontal | elevação frontal | halteres | deltoide anterior | peitoral superior | halteres, disco, cabo | casa equipada, ginásio | Ombros > Deltoide anterior | Isolamento. |
| shoulder_horizontal_extension_resistance | Elevação posterior | elevação posterior | halteres | deltoide posterior | romboides, trapézio médio | halteres | casa equipada, ginásio | Ombros > Deltoide posterior | Pode duplicar com reverse fly, padronizar. |
| rear_delt_upper_back_fly | Reverse fly | reverse fly | halteres | deltoide posterior | romboides, trapézio médio | halteres, banco | casa equipada, ginásio | Ombros > Posterior; Costas > Espessura alta | Mesmo exercício do bloco costas. |
| scapular_plane_raise | Elevação no plano da omoplata | elevação escapular | scaption | deltoide lateral, supraespinhoso | trapézio, serrátil | halteres leves | casa equipada, ginásio | Ombros > Plano escapular; Prevenção | Boa para ombro saudável. |
| band_pull_apart | Pull-apart | pull-apart | elástico | deltoide posterior, romboides | trapézio médio, manguito | elástico | casa equipada, ginásio, dojo | Ombros > Posterior; Costas altas; Prevenção | Aquecimento/prevenção. |
| wall_slide_shoulder_control | Wall slides | wall slide | parede | serrátil anterior, trapézio inferior | manguito, deltoide | parede | casa, ginásio, dojo | Ombros > Mobilidade ativa; Prevenção | Cruza mobilidade e ativação. |
| external_rotation_control | Rotação externa com elástico | rotação externa | elástico | infraespinhoso, redondo menor | deltoide posterior | elástico | casa equipada, ginásio, dojo | Manguito rotador; Ombro > Prevenção | Não é hipertrofia pesada. |
| internal_rotation_control | Rotação interna com elástico | rotação interna | elástico | subescapular | peitoral, dorsal | elástico | casa equipada, ginásio, dojo | Manguito rotador; Ombro > Prevenção | Leve e controlado. |

# Bíceps e braquial
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| elbow_flexion_supinated_resistance | Curl com barra | curl | barra supinada | bíceps braquial | braquial, antebraço | barra, discos | casa equipada, ginásio | Braços > Bíceps; Barra | Base supinada bilateral. |
| elbow_flexion_supinated_resistance | Curl com halteres | curl | halteres supinado | bíceps braquial | braquial, antebraço | halteres | casa equipada, ginásio | Braços > Bíceps; Halteres | Variação por equipamento. |
| elbow_flexion_supination_dynamic | Curl alternado com supinação | curl | alternado com supinação | bíceps braquial | braquial, antebraço | halteres | casa equipada, ginásio | Bíceps > Supinação; Halteres | Conceito de supinar durante a subida. |
| elbow_flexion_shoulder_extension_lengthened | Curl inclinado com halteres | curl | banco inclinado | bíceps cabeça longa | braquial, antebraço | halteres, banco inclinado | casa equipada, ginásio | Bíceps > Amplitude alongada | Ombro atrás do tronco. |
| elbow_flexion_shoulder_flexion_shortened | Curl spider | curl | banco inclinado peito apoiado | bíceps em posição encurtada | braquial | halteres, banco inclinado | ginásio, casa equipada | Bíceps > Amplitude encurtada | Ombro à frente do tronco. |
| elbow_flexion_supported_arm | Curl concentrado | curl | braço apoiado | bíceps braquial | braquial | halter | casa equipada, ginásio | Bíceps > Apoiado; Halter | Isolamento e controlo. |
| elbow_flexion_cable_low | Curl no cabo | curl | cabo baixo | bíceps braquial | braquial, antebraço | cabo baixo | ginásio | Bíceps > Cabo | Tensão constante. |
| elbow_flexion_elastic | Curl com elástico | curl | elástico | bíceps braquial | braquial | elástico | casa equipada, ginásio, dojo | Bíceps > Elástico | Útil para casa. |
| elbow_flexion_partial_ranges | Curl 21 com halteres | curl 21 | halteres | bíceps braquial | braquial | halteres | casa equipada, ginásio | Bíceps > Resistência muscular | Modificador de amplitude, mas pode ser exercício por protocolo. |
| elbow_flexion_drag_pattern | Curl arrastado com halteres | curl | drag curl | bíceps braquial | braquial, deltoide posterior leve | halteres | casa equipada, ginásio | Bíceps > Cotovelo para trás | Posição muda conceito. |
| elbow_flexion_isometric | Curl isométrico | curl | isométrico | bíceps braquial, braquial | antebraço | halteres, barra, elástico | casa equipada, ginásio | Bíceps > Isometria | Contexto de força isométrica. |
| elbow_flexion_neutral_grip_resistance | Curl martelo com halteres | curl martelo | halteres | braquial, braquiorradial | bíceps, antebraço | halteres | casa equipada, ginásio | Braços > Braquial; Antebraço > Braquiorradial | Pega neutra. |
| elbow_flexion_neutral_cross_body | Curl martelo cruzado | curl martelo | cruzado | braquial, braquiorradial | bíceps | halteres | casa equipada, ginásio | Braquial; Braquiorradial | Trajetória muda foco. |
| elbow_flexion_pronated_resistance | Curl inverso | curl inverso | barra pronada | braquiorradial, braquial | bíceps, extensores antebraço | barra, halteres | casa equipada, ginásio | Antebraço > Braquiorradial; Bíceps > Pronado | Cruza antebraço. |
| vertical_pull_supinated_elbow_flexion | Chin-up | chin-up | supinado | bíceps braquial, dorsal | braquial, antebraço | barra fixa | casa equipada, ginásio, exterior | Bíceps; Costas > Puxada vertical | Mesmo exercício do bloco costas. |

# Antebraço, punho e pega
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| wrist_flexion_resistance | Wrist curl | curl punho | flexão | flexores do antebraço | músculos dos dedos | halteres, barra | casa equipada, ginásio | Antebraço > Flexores; Punho | Isolamento do punho. |
| wrist_extension_resistance | Reverse wrist curl | curl punho | extensão | extensores do antebraço | braquiorradial | halteres, barra | casa equipada, ginásio | Antebraço > Extensores; Punho | Importante para equilíbrio do antebraço. |
| forearm_pronation_resistance | Pronação com halter | rotação antebraço | pronação | pronadores | punho, cotovelo | halter leve | casa equipada, ginásio | Antebraço > Pronadores | Usar carga leve. |
| forearm_supination_resistance | Supinação com halter | rotação antebraço | supinação | supinadores | bíceps, punho | halter leve | casa equipada, ginásio | Antebraço > Supinadores | Usar carga leve. |
| radial_deviation_resistance | Desvio radial com halter | desvio punho | radial | músculos radiais do antebraço | punho | halter leve | casa equipada, ginásio | Antebraço > Punho > Desvio radial | Adicionar ao catálogo. |
| ulnar_deviation_resistance | Desvio ulnar com halter | desvio punho | ulnar | músculos ulnares do antebraço | punho | halter leve | casa equipada, ginásio | Antebraço > Punho > Desvio ulnar | Adicionar ao catálogo. |
| support_grip_loaded_carry | Farmer walk | transporte | bilateral | pega de suporte, antebraço | trapézio, core, pernas | halteres, kettlebells, garrafões | casa equipada, ginásio, exterior | Pega > Suporte; Força prática > Transporte | Mesmo exercício do bloco força prática. |
| support_grip_static_hold | Farmer hold | hold | bilateral estático | pega de suporte, antebraço | trapézio, core | halteres, barra, garrafões | casa equipada, ginásio | Pega > Suporte; Isometria | Versão estática. |
| support_grip_hang | Dead hang | suspensão | passiva ou ativa | pega de suporte | dorsal, ombros | barra fixa | casa equipada, ginásio, exterior | Pega > Suporte; Calistenia | Distinguir passivo e escapular. |
| towel_grip_support | Towel grip hold | hold | toalha | dedos, flexores do antebraço | dorsal, ombros | toalha, barra | casa equipada, ginásio, exterior | Pega > Toalha; Grappling | Muito útil para Jiu-Jitsu. |
| pinch_grip_strength | Pinch grip | pinça | pinça | polegar, dedos, antebraço | punho | discos, objetos planos | casa equipada, ginásio | Pega > Pinça | Conceito diferente de suporte. |
| plate_hold_pinch | Plate hold | hold | disco | pega de pinça | antebraço | discos | casa equipada, ginásio | Pega > Pinça; Discos | Variação específica. |
| finger_flexion_resistance | Finger curls | curl dedos | barra ou halteres | flexores dos dedos | flexores do antebraço | barra, halteres | casa equipada, ginásio | Mão > Dedos; Antebraço | Força dos dedos. |
| finger_extension_resistance | Extensão de dedos com elástico | extensão dedos | elástico | extensores dos dedos | punho | mini elástico | casa equipada, ginásio | Mão > Dedos; Equilíbrio antebraço | Importante para equilíbrio. |
| suitcase_carry_unilateral | Suitcase carry | transporte | unilateral | pega, oblíquos, quadrado lombar | trapézio, pernas | halter, kettlebell, garrafão | casa equipada, ginásio, exterior | Força prática; Core > Anti-flexão lateral; Pega | Cruza core. |
| static_dumbbell_hold | Hold estático com halteres | hold | halteres | pega de suporte | trapézio, antebraço | halteres | casa equipada, ginásio | Pega > Isometria; Halteres | Alternativa ao farmer hold. |
| forearm_rotation_control_light | Rotação controlada com halter leve | rotação antebraço | controlada | pronadores, supinadores | punho, cotovelo | halter leve | casa equipada, ginásio | Antebraço > Controlo; Prevenção | Mais controlo que força. |
| grappling_grip_strength | Grip trainer para grappling | grip trainer | aperto | flexores dos dedos, antebraço | punho | grip trainer | casa equipada, ginásio | Pega > Grappling; Jiu-Jitsu > Pegada | Equipamento opcional. |

# Tríceps
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| elbow_extension_cable_down | Extensão de tríceps no cabo | extensão tríceps | cabo barra | tríceps lateral e medial | cabeça longa | cabo alto, barra | ginásio | Tríceps > Cabo; Extensão cotovelo | Base em cabo. |
| elbow_extension_cable_rope | Tríceps no cabo com corda | extensão tríceps | corda | tríceps lateral e medial | cabeça longa | cabo alto, corda | ginásio | Tríceps > Cabo; Corda | Variação por pega. |
| overhead_elbow_extension_dumbbell | Extensão acima da cabeça com halter | extensão tríceps | halter overhead | tríceps cabeça longa | cabeça medial, lateral | halter | casa equipada, ginásio | Tríceps > Cabeça longa; Overhead | Braço acima alonga cabeça longa. |
| overhead_elbow_extension_cable | Extensão francesa no cabo | extensão tríceps | cabo overhead | tríceps cabeça longa | cabeça medial, lateral | cabo | ginásio | Tríceps > Cabeça longa; Cabo | Tensão constante. |
| lying_elbow_extension_ez | Tríceps testa com barra EZ | tríceps testa | barra EZ | tríceps cabeça longa | cabeça medial, lateral | barra EZ, banco | ginásio, casa equipada | Tríceps > Deitado; Barra | Separar de halteres. |
| lying_elbow_extension_dumbbells | Tríceps testa com halteres | tríceps testa | halteres | tríceps cabeça longa | cabeça medial, lateral | halteres, banco | casa equipada, ginásio | Tríceps > Deitado; Halteres | Variação por equipamento. |
| lying_elbow_extension_dumbbells | Extensão de tríceps deitado com halteres | extensão tríceps | deitado halteres | tríceps cabeça longa | cabeça medial, lateral | halteres, banco | casa equipada, ginásio | Tríceps > Deitado; Halteres | Possível sinónimo de tríceps testa com halteres. |
| french_press_dumbbell | Extensão francesa com halter | extensão francesa | halter | tríceps cabeça longa | cabeça medial | halter | casa equipada, ginásio | Tríceps > Overhead; Halter | Padronizar com extensão acima da cabeça. |
| french_press_ez | Extensão francesa com barra EZ | extensão francesa | barra EZ | tríceps cabeça longa | cabeça medial | barra EZ | ginásio, casa equipada | Tríceps > Overhead; Barra | Variação de barra. |
| triceps_kickback_dumbbell | Kickback de tríceps | kickback | halter | tríceps lateral | cabeça longa, core | halter | casa equipada, ginásio | Tríceps > Kickback; Halter | Amplitude encurtada. |
| triceps_kickback_cable | Kickback no cabo | kickback | cabo | tríceps lateral | cabeça longa | cabo baixo | ginásio | Tríceps > Kickback; Cabo | Tensão diferente. |
| unilateral_elbow_extension | Extensão unilateral de tríceps | extensão tríceps | unilateral | tríceps | estabilizadores do ombro | halter, cabo, elástico | casa equipada, ginásio | Tríceps > Unilateral | Usar equipamento como variação. |
| close_grip_horizontal_push | Supino fechado | supino | pega fechada | tríceps | peito, deltoide anterior | barra, banco | ginásio, casa equipada | Tríceps > Composto; Peito > Supino | Primary pode ser tríceps. |
| close_grip_dumbbell_press | Press fechado com halteres | press | halteres juntos | tríceps, peito interno | deltoide anterior | halteres, banco | casa equipada, ginásio | Tríceps > Composto; Peito | Variação por halteres. |
| bodyweight_triceps_dip | Fundos entre apoios | dips | banco | tríceps | deltoide anterior, peito | banco, cadeira | casa, ginásio, exterior | Tríceps > Peso corporal | Cuidado com ombros. |
| dip_triceps_focus | Dips para tríceps | dips | vertical | tríceps | peito, deltoide anterior | paralelas | ginásio, exterior, casa equipada | Tríceps > Calistenia | Diferenciar de dips para peito. |
| close_grip_pushup | Flexão fechada | flexão | mãos próximas | tríceps | peito, deltoide anterior, core | peso corporal | casa, ginásio, dojo | Tríceps > Peso corporal | Composto. |
| diamond_pushup | Flexão diamante | flexão | diamante | tríceps | peito, ombro anterior, core | peso corporal | casa, ginásio, dojo | Tríceps > Peso corporal; Avançado | Variação mais exigente. |
| tate_press | Tate press | press tríceps | halteres | tríceps | peito, ombros | halteres, banco | casa equipada, ginásio | Tríceps > Halteres | Exercício menos comum, manter como avançado. |
| elbow_extension_elastic | Tríceps com elástico | extensão tríceps | elástico | tríceps | ombro, core | elástico | casa equipada, ginásio, dojo | Tríceps > Elástico | Boa opção doméstica. |

# Core
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| trunk_flexion_floor | Crunch | crunch | solo | reto abdominal | oblíquos | sem equipamento, tapete | casa, ginásio, dojo | Core > Abdominal > Flexão | Base. |
| posterior_pelvic_curl | Reverse crunch | crunch inverso | solo | reto abdominal inferior, transverso | flexores da anca | sem equipamento, tapete | casa, ginásio, dojo | Core > Abdominal inferior | Explicar participação dos flexores da anca. |
| hip_flexion_leg_raise_core | Elevação de pernas | leg raise | solo | reto abdominal, flexores da anca | transverso, lombar | sem equipamento, tapete | casa, ginásio, dojo | Core > Abdominal inferior; Flexores da anca | Requer controlo lombar. |
| hanging_knee_raise | Elevação de joelhos suspenso | leg raise | suspenso joelhos | reto abdominal, flexores da anca | antebraço, dorsal | barra fixa | casa equipada, ginásio, exterior | Core > Suspenso; Flexores da anca | Cruza pega. |
| trunk_flexion_toe_reach | Toe touches | crunch | toque pés | reto abdominal | flexores da anca | sem equipamento, tapete | casa, ginásio | Core > Abdominal superior | Variação de crunch. |
| rotational_flexion_bodyweight | Bicycle crunch | crunch | bicicleta | reto abdominal, oblíquos | flexores da anca | sem equipamento, tapete | casa, ginásio | Core > Oblíquos; Abdominal | Rotação + flexão. |
| dynamic_lower_ab_flutter | Flutter kicks | flutter kicks | solo | reto abdominal, flexores da anca | transverso | sem equipamento, tapete | casa, ginásio, dojo | Core > Abdominal inferior; Resistência | Controlar lombar. |
| anti_extension_plank | Prancha | prancha | frontal | transverso abdominal, reto abdominal | glúteos, ombros | sem equipamento, tapete | casa, ginásio, dojo | Core > Anti-extensão; Isometria | Entidade base. |
| anti_lateral_flexion_side_plank | Prancha lateral | prancha | lateral | oblíquos, quadrado lombar | glúteo médio, ombro | sem equipamento, tapete | casa, ginásio, dojo | Core > Anti-flexão lateral; Oblíquos | Estabilidade lateral. |
| anti_extension_hollow | Hollow hold | hollow | isométrico | reto abdominal, transverso | flexores da anca | sem equipamento, tapete | casa, ginásio, dojo | Core > Anti-extensão; Ginástica | Mais difícil que prancha para alguns. |
| contralateral_core_control | Dead bug | dead bug | solo | transverso abdominal | flexores da anca, ombros | sem equipamento, tapete | casa, ginásio, dojo | Core > Estabilidade profunda; Prevenção | Excelente iniciante. |
| contralateral_lumbar_stability | Bird dog | bird dog | quadrupedia | core profundo, lombar | glúteos, ombros | sem equipamento, tapete | casa, ginásio, dojo | Core > Estabilidade; Lombar | Mesmo id do bloco lombar. |
| anti_rotation_cable | Pallof press no cabo | pallof press | cabo | oblíquos, transverso | glúteos, ombros | cabo ajustável | ginásio | Core > Anti-rotação; Cabo | Cabo. |
| anti_rotation_elastic | Pallof press com elástico | pallof press | elástico | oblíquos, transverso | glúteos, ombros | elástico | casa equipada, ginásio, dojo | Core > Anti-rotação; Elástico | Variação doméstica. |
| trunk_rotation_loaded | Russian twist | rotação tronco | solo | oblíquos | reto abdominal, flexores da anca | peso corporal, disco, halter | casa equipada, ginásio | Core > Rotação; Oblíquos | Cuidado com lombar. |
| lateral_flexion_resistance | Side bend | inclinação lateral | halter | oblíquos, quadrado lombar | antebraço | halter, cabo | casa equipada, ginásio | Core > Flexão lateral | Pode ser questionável para alguns objetivos. |
| deep_core_vacuum | Vacuum abdominal | vacuum | respiratório | transverso abdominal | diafragma, pavimento pélvico | sem equipamento | casa, ginásio, dojo | Core > Transverso; Respiração | Cruza recuperação e postura. |
| dynamic_cardio_core | Mountain climbers | mountain climbers | dinâmico | core, flexores da anca | ombros, cardio | sem equipamento | casa, ginásio, dojo | Core > Dinâmico; Cardio > Sem equipamento | Primary pode ser cardio em certos treinos. |
| cable_woodchop_rotation | Lenhador no cabo | woodchop | cabo | oblíquos | ombros, glúteos | cabo | ginásio | Core > Rotação; Cabo | Rotação diagonal. |
| plank_shoulder_tap | Prancha com toque no ombro | prancha | toque ombro | transverso, oblíquos | ombros, serrátil | sem equipamento, tapete | casa, ginásio, dojo | Core > Anti-rotação; Ombros estabilidade | Cruza ombro. |
| loaded_unilateral_carry_core | Suitcase carry | transporte | unilateral | oblíquos, quadrado lombar | pega, trapézio, pernas | halter, kettlebell, garrafão | casa equipada, ginásio, exterior | Core > Anti-flexão lateral; Pega | Mesmo exercício da pega. |
| ab_rollout_concept | Roda abdominal | ab rollout | roda | reto abdominal, transverso | ombros, dorsal | roda abdominal | casa equipada, ginásio | Core > Anti-extensão; Avançado | Adicionar como exercício relevante. |

# Glúteos
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| hip_extension_bridge | Ponte de glúteo | ponte | solo | glúteo máximo | posterior de coxa, core | sem equipamento, tapete | casa, ginásio, dojo | Glúteos > Ponte; Sem equipamento | Base. |
| hip_thrust_loaded | Hip thrust | hip thrust | carregado | glúteo máximo | posterior, core | barra, banco, halter | ginásio, casa equipada | Glúteos > Hip thrust | Com carga. |
| hip_thrust_supported | Hip thrust com apoio | hip thrust | apoio | glúteo máximo | posterior, core | banco, peso opcional | casa equipada, ginásio | Glúteos > Hip thrust; Regressão | Variação apoiada. |
| hip_extension_kickback | Kickback de glúteo | kickback | perna atrás | glúteo máximo | posterior, core | cabo, elástico, tornozeleira | casa equipada, ginásio | Glúteos > Extensão da anca | Equipamento altera variação. |
| hip_abduction_open_chain | Abdução de anca | abdução | em pé ou máquina | glúteo médio, mínimo | tensor fáscia lata | elástico, máquina, cabo | casa equipada, ginásio | Glúteos > Glúteo médio; Abdutores | Cruza abdutores. |
| side_lying_hip_abduction | Abdução de anca deitada | abdução | deitada | glúteo médio | glúteo mínimo | sem equipamento, elástico | casa, ginásio, dojo | Abdutores; Glúteos > Médio | Sem equipamento. |
| hip_external_rotation_clamshell | Clamshell | clamshell | deitado lateral | glúteo médio, rotadores externos | glúteo mínimo | mini band opcional | casa, ginásio, dojo | Glúteos > Rotadores externos; Prevenção | Ativação. |
| hip_hinge_loaded_dumbbell | Peso morto romeno com halteres | peso morto romeno | halteres | posterior de coxa, glúteos | eretores, antebraço | halteres | casa equipada, ginásio | Glúteos; Posterior; Lombar | Mesmo exercício da cadeia posterior. |
| single_leg_hip_hinge | Peso morto unilateral com halteres | peso morto unilateral | halteres | glúteo máximo, posterior | glúteo médio, core | halteres | casa equipada, ginásio | Glúteos > Unilateral; Posterior | Estabilidade unilateral. |
| split_squat_glute_quad | Agachamento búlgaro | split squat | pé atrás elevado | quadríceps, glúteos | adutores, core | peso corporal, halteres, banco | casa, ginásio | Pernas > Unilateral; Glúteos; Quadríceps | Composto. |
| lunge_pattern | Lunges | lunge | base | quadríceps, glúteos | adutores, core | peso corporal, halteres | casa, ginásio, exterior | Pernas > Afundo; Glúteos; Quadríceps | Base. |
| lateral_band_walk | Lateral band walk | caminhada lateral | mini band | glúteo médio | abdutores, core | mini band | casa equipada, ginásio, dojo | Glúteos > Médio; Prevenção joelho | Adicionar. |

# Quadríceps
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| squat_bodyweight | Agachamento com peso corporal | agachamento | peso corporal | quadríceps, glúteos | adutores, core | sem equipamento | casa, ginásio, exterior, dojo | Pernas > Agachamento; Sem equipamento | Base. |
| chair_squat_regression | Agachamento para cadeira | agachamento | cadeira | quadríceps, glúteos | core | cadeira | casa, ginásio | Pernas > Agachamento; Regressão | Iniciante. |
| goblet_squat | Agachamento goblet | agachamento | goblet | quadríceps, glúteos | adutores, core | halter, kettlebell, garrafão | casa equipada, ginásio | Pernas > Agachamento; Halter | Bom para técnica. |
| barbell_squat | Agachamento com barra | agachamento | barra | quadríceps, glúteos | adutores, core, lombar | barra, discos, rack | ginásio, casa equipada | Pernas > Agachamento; Barra | Composto principal. |
| dumbbell_squat_side | Agachamento com halteres ao lado | agachamento | halteres ao lado | quadríceps, glúteos | antebraço, core | halteres | casa equipada, ginásio | Pernas > Agachamento; Halteres | Também pega. |
| backpack_squat | Agachamento com mochila | agachamento | mochila | quadríceps, glúteos | core | mochila com peso | casa, exterior | Pernas > Agachamento; Casa equipada | Útil para casa. |
| water_jug_squat | Agachamento com garrafão | agachamento | garrafão | quadríceps, glúteos | core, antebraço | garrafão | casa, exterior | Pernas > Agachamento; Improvisado | Equipamento caseiro. |
| sumo_squat | Agachamento sumo | agachamento | sumo | adutores, glúteos, quadríceps | core | peso corporal, halter, barra | casa, ginásio | Pernas > Adutores; Glúteos; Agachamento | Foco misto. |
| smith_machine_squat | Agachamento na máquina Smith | agachamento | Smith | quadríceps, glúteos | core | Smith machine | ginásio | Pernas > Agachamento; Máquina | Guiado. |
| bulgarian_split_squat | Agachamento búlgaro com apoio | split squat | assistido | quadríceps, glúteos | adutores, core | banco, apoio | casa, ginásio | Pernas > Unilateral; Regressão | Separar assistido se necessário. |
| leg_extension_isolation | Extensão de perna | extensão joelho | máquina | quadríceps | reto femoral | máquina extensão de perna | ginásio | Quadríceps > Isolamento; Máquina | Isolamento. |
| leg_press | Leg press | press pernas | máquina | quadríceps, glúteos | adutores | leg press | ginásio | Pernas > Press; Máquina | Composto guiado. |
| step_up | Step-up | subida | caixa ou degrau | quadríceps, glúteos | gémeos, core | degrau, banco, halteres opcionais | casa, ginásio, exterior | Pernas > Unilateral; Funcional | Prático. |
| wall_sit_isometric | Wall sit | isometria | parede | quadríceps | glúteos, core | parede | casa, ginásio, dojo | Quadríceps > Isometria | Resistência muscular. |
| lunge_pattern | Lunges com halteres | lunge | halteres | quadríceps, glúteos | adutores, core, antebraço | halteres | casa equipada, ginásio | Pernas > Afundo; Halteres | Variação carregada. |
| walking_lunges | Walking lunges | lunge | caminhada | quadríceps, glúteos | core, gémeos | peso corporal, halteres | ginásio, exterior, casa | Pernas > Afundo; Locomoção | Mais dinâmico. |
| terminal_knee_extension | Extensão terminal do joelho com elástico | extensão joelho | elástico | vasto medial, quadríceps | tendão patelar | elástico | casa equipada, ginásio | Quadríceps > Prevenção joelho; Elástico | Prehab. |
| light_jump_absorption | Saltos leves | salto | leve | quadríceps, gémeos, glúteos | core | sem equipamento | casa, ginásio, exterior, dojo | Pernas > Potência; Cardio leve | Primary pode ser cardio/potência. |

# Posterior de coxa
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| knee_flexion_machine | Curl de perna | curl perna | máquina | posterior de coxa | gémeos | máquina curl de perna | ginásio | Posterior de coxa > Flexão joelho; Máquina | Isolamento. |
| hip_hinge_loaded_dumbbell | Peso morto romeno com halteres | peso morto romeno | halteres | posterior de coxa, glúteos | eretores, antebraço | halteres | casa equipada, ginásio | Posterior > Dobradiça; Halteres | Mesmo exercício transversal. |
| deadlift_conventional | Peso morto tradicional | peso morto | barra | glúteos, posterior, eretores | quadríceps, trapézio, antebraço | barra, discos | ginásio, casa equipada | Dobradiça; Força prática; Corpo inteiro | Composto. |
| single_leg_hip_hinge | Peso morto unilateral com halteres | peso morto unilateral | halteres | posterior, glúteo | glúteo médio, core | halteres | casa equipada, ginásio | Posterior > Unilateral | Equilíbrio e estabilidade. |
| hip_hinge_light | Good morning leve | good morning | leve | posterior de coxa, eretores | glúteos, core | barra leve, cabo de vassoura | casa, ginásio | Posterior > Dobradiça; Técnica | Aprendizagem. |
| nordic_curl_assisted | Curl nórdico assistido | curl nórdico | assistido | posterior de coxa | gémeos, glúteos | apoio para pés, elástico opcional | ginásio, casa equipada, dojo | Posterior > Excêntrico; Avançado | Muito exigente. |
| hamstring_bridge | Ponte de glúteo com foco posterior | ponte | calcanhares longe | posterior de coxa, glúteos | core | sem equipamento, tapete | casa, ginásio | Posterior > Ponte; Sem equipamento | Variação pela posição dos pés. |
| sliding_leg_curl | Curl de perna deslizante | curl perna | toalha ou sliders | posterior de coxa | glúteos, core | toalha, sliders, chão liso | casa, ginásio | Posterior > Flexão joelho; Casa | Adicionar. |
| isometric_hamstring_hold | Isometria de posterior de coxa | isometria | ponte calcanhares | posterior de coxa | glúteos, core | sem equipamento | casa, ginásio | Posterior > Isometria | Bom para robustez. |
| good_morning_barbell | Good morning com barra | good morning | barra | posterior de coxa, eretores | glúteos, core | barra | ginásio, casa equipada | Posterior > Dobradiça; Barra | Avançado. |

# Adutores, abdutores e flexores da anca
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| hip_adduction_resistance | Adução de anca | adução | máquina, cabo ou elástico | adutores | core | máquina, cabo, elástico | casa equipada, ginásio | Adutores > Adução | Equipamento define variação. |
| adductor_machine | Máquina adutora | adução | máquina | adutores | core | máquina adutora | ginásio | Adutores > Máquina | Ginásio. |
| copenhagen_plank_supported | Copenhagen plank com apoio | prancha copenhagen | assistida | adutores, oblíquos | ombro, core | banco | casa equipada, ginásio | Adutores > Isometria; Core > Lateral | Cruza core. |
| ball_squeeze_adduction | Aperto de bola entre joelhos | adução isométrica | bola | adutores | core | bola, almofada | casa, ginásio | Adutores > Isometria; Prevenção | Adicionar. |
| lateral_lunge | Lunge lateral | lunge | lateral | adutores, glúteos, quadríceps | core | peso corporal, halteres | casa, ginásio, exterior | Adutores; Pernas > Lateral | Adicionar. |
| hip_abduction_resistance | Abdução de anca | abdução | máquina, cabo ou elástico | glúteo médio, mínimo | tensor fáscia lata | máquina, cabo, elástico | casa equipada, ginásio | Abdutores; Glúteos médio | Já listado em glúteos. |
| side_lying_hip_abduction | Abdução de anca deitada | abdução | deitada | glúteo médio | glúteo mínimo | sem equipamento, elástico | casa, ginásio, dojo | Abdutores > Sem equipamento | Base. |
| clamshell_external_rotation | Clamshell | rotação externa | deitado | glúteo médio, rotadores externos | glúteo mínimo | mini band opcional | casa, ginásio, dojo | Abdutores; Rotadores da anca; Prevenção | Ativação. |
| monster_walk_band | Monster walk | caminhada com elástico | frente diagonal | glúteo médio, abdutores | glúteos, quadríceps | mini band | casa equipada, ginásio, dojo | Abdutores > Resistência; Prevenção | Adicionar. |
| lateral_band_walk | Lateral band walk | caminhada lateral | mini band | glúteo médio | abdutores, core | mini band | casa equipada, ginásio, dojo | Abdutores > Lateral; Glúteos médio | Adicionar. |
| standing_hip_flexion_band | Flexão da anca em pé com elástico | flexão anca | elástico | iliopsoas, reto femoral | core | elástico | casa equipada, ginásio, dojo | Flexores da anca; Karate > Pontapés | Útil para artes marciais. |
| hanging_knee_raise | Elevação de joelhos suspenso | elevação joelhos | suspenso | flexores da anca, reto abdominal | antebraço, dorsal | barra fixa | casa equipada, ginásio, exterior | Flexores da anca; Core | Mesmo exercício do core. |
| resisted_march | Marcha resistida | marcha | elástico | flexores da anca | core, glúteos | elástico | casa equipada, ginásio, dojo | Flexores da anca; Aquecimento | Adicionar. |
| high_knees_strength_context | High knees, foco flexores da anca | high knees | técnico | flexores da anca | core, cardio | sem equipamento | casa, ginásio, exterior, dojo | Flexores da anca; Cardio; Artes marciais | Primary pode ser cardio. |
| hip_flexor_isometric_hold | Isometria de flexão da anca | isometria anca | joelho alto | iliopsoas, reto femoral | core | sem equipamento, parede opcional | casa, ginásio, dojo | Flexores da anca > Isometria; Pontapés | Adicionar. |

# Perna inferior, tornozelo e pé
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| standing_plantar_flexion | Gémeos em pé | elevação gémeos | em pé | gastrocnémio | sóleo, pé | peso corporal, halteres, máquina | casa, ginásio | Gémeos > Joelho estendido | Base. |
| seated_plantar_flexion | Gémeos sentado | elevação gémeos | sentado | sóleo | gastrocnémio | halter, máquina | casa equipada, ginásio | Sóleo > Joelho fletido | Sóleo enfatizado. |
| single_leg_calf_raise | Elevação de gémeos unilateral | elevação gémeos | unilateral | gastrocnémio, sóleo | pé, tornozelo | peso corporal, halter | casa, ginásio, exterior | Gémeos > Unilateral | Progressão. |
| seated_soleus_raise | Sóleo sentado | elevação sóleo | sentado | sóleo | gastrocnémio | halter, máquina | casa equipada, ginásio | Sóleo > Isolamento | Pode duplicar com gémeos sentado, padronizar. |
| calf_isometric_hold | Isometria de gémeos | isometria | ponta do pé | gémeos, sóleo | pé, tornozelo | sem equipamento, halteres | casa, ginásio | Gémeos > Isometria | Robustez do tendão. |
| eccentric_calf_raise | Elevação excêntrica de gémeos | elevação gémeos | excêntrica | gémeos, tendão de Aquiles | sóleo | degrau, peso opcional | casa, ginásio | Gémeos > Excêntrico; Tendão Aquiles | Adicionar. |
| pogo_jumps | Pogo jumps | salto tornozelo | reativo | gémeos, sóleo, tendão Aquiles | quadríceps, glúteos | sem equipamento | casa, ginásio, exterior | Perna inferior > Potência elástica | Avançar com cuidado. |
| tibialis_raise | Elevação tibial | elevação tibial | parede | tibial anterior | extensores dedos | parede, sem equipamento | casa, ginásio | Tibial anterior; Tornozelo | Base. |
| ankle_dorsiflexion_band | Dorsiflexão do tornozelo com elástico | dorsiflexão | elástico | tibial anterior | extensores dedos | elástico | casa equipada, ginásio | Tibial anterior; Tornozelo | Reabilitação/prevenção. |
| heel_walk | Caminhada nos calcanhares | marcha | calcanhares | tibial anterior | pé, tornozelo | sem equipamento | casa, ginásio, exterior | Tibial anterior > Resistência | Adicionar. |
| short_foot_doming | Short foot / doming | pé intrínseco | arco plantar | músculos intrínsecos do pé | tibial posterior | sem equipamento | casa, ginásio, dojo | Pé > Arco plantar; Prevenção | Controlo fino. |
| toe_flexion_active | Flexão ativa dos dedos do pé | dedos pé | flexão | flexores dos dedos do pé | intrínsecos do pé | sem equipamento, toalha opcional | casa, ginásio | Pé > Dedos | Base. |
| toe_towel_curl | Toalha com os dedos | dedos pé | toalha | flexores dos dedos, intrínsecos do pé | arco plantar | toalha | casa, ginásio | Pé > Dedos; Casa | Adicionar. |
| ankle_inversion_band | Inversão do tornozelo com elástico | tornozelo | inversão | tibial posterior | estabilizadores tornozelo | elástico | casa equipada, ginásio | Tornozelo > Inversão; Prevenção | Controlo. |
| ankle_eversion_band | Eversão do tornozelo com elástico | tornozelo | eversão | peroneais | estabilizadores tornozelo | elástico | casa equipada, ginásio | Tornozelo > Eversão; Prevenção | Controlo. |
| single_leg_balance | Equilíbrio unipodal | equilíbrio | uma perna | estabilizadores do tornozelo, pé | glúteo médio, core | sem equipamento | casa, ginásio, dojo | Tornozelo > Propriocepção; Prevenção | Pode ser mobilidade/prevenção. |
| ankle_stability_reaches | Alcances em apoio unipodal | equilíbrio | alcances | tornozelo, pé, glúteo médio | core, quadríceps | sem equipamento | casa, ginásio, dojo | Tornozelo > Estabilidade; Prevenção | Adicionar. |
| loaded_carry_foot_stability | Transporte carregado com foco em pé estável | transporte | postura pé | pé, tornozelo, pega | core, trapézio, pernas | halteres, garrafões | casa equipada, ginásio, exterior | Força prática; Pé > Estabilidade | Conceito transversal. |

# Compostos e força prática
| concept_id | exercício | família | variação | principais | secundários | equipamento | locais | filtros | nota |
|---|---|---|---|---|---|---|---|---|---|
| loaded_postural_carry | Farmer walk | transporte | bilateral | pega, trapézio, core | pernas, lombar | halteres, kettlebells, garrafões | casa equipada, ginásio, exterior | Força prática > Transporte; Pega; Trapézio | Entidade transversal. |
| suitcase_carry_unilateral | Suitcase carry | transporte | unilateral | oblíquos, pega | trapézio, pernas | halter, kettlebell, garrafão | casa equipada, ginásio, exterior | Força prática; Core anti-flexão; Pega | Entidade transversal. |
| front_loaded_carry | Front carry | transporte | à frente | core, braços, lombar | pernas, pega | saco areia, garrafão, mochila | casa, ginásio, exterior | Força prática > Carregar à frente | Adicionar. |
| sandbag_bear_hug_carry | Sandbag bear hug carry | transporte | abraçado | core, lombar, pernas | bíceps isométrico, pega | saco areia, mochila pesada | casa equipada, ginásio, exterior | Força prática > Trabalho; Corpo inteiro | Muito transferível para trabalho físico. |
| overhead_carry | Overhead carry | transporte | acima da cabeça | ombros, trapézio, core | tríceps, pega | halteres, kettlebell | ginásio, casa equipada | Força prática; Ombros estabilidade; Core | Avançado. |
| loaded_pickup_from_floor | Levantar carga do chão | levantamento prático | carga irregular | glúteos, posterior, lombar | pega, core, pernas | mochila, garrafão, saco | casa, exterior, trabalho | Força prática > Levantar; Dobradiça | Conceito prático separado do peso morto técnico. |
| push_pattern_general | Empurrar carga horizontal | empurrar prático | horizontal | peito, ombros, tríceps | core, pernas | trenó, parede, objeto | ginásio, exterior, trabalho | Força prática > Empurrar | Conceito funcional, equipamento variável. |
| pull_pattern_general | Puxar carga horizontal | puxar prático | horizontal | costas, bíceps, antebraço | core, pernas | corda, cabo, objeto | ginásio, exterior, trabalho | Força prática > Puxar | Conceito funcional, equipamento variável. |
| loaded_step_carry | Subir degrau com carga | step-up carregado | carga | quadríceps, glúteos, core | pega, gémeos | halteres, garrafões, mochila | casa, ginásio, exterior, trabalho | Força prática; Pernas; Transporte | Muito útil para trabalho. |
| crawl_pattern | Bear crawl | locomoção | quadrupedia | core, ombros, quadríceps | punhos, glúteos | sem equipamento | casa, ginásio, dojo | Força prática; Core; Ombros; Cardio leve | Cruza cardio e aquecimento. |
| loaded_get_up_concept | Levantar do chão com carga leve | get-up | carga leve | core, ombros, pernas | pega, glúteos | halter, kettlebell, objeto leve | casa equipada, ginásio | Força prática; Core; Mobilidade | Adicionar como conceito avançável. |
| anti_rotation_loaded_carry | Transporte assimétrico | transporte | assimétrico | core anti-rotação, pega | trapézio, pernas | halteres com cargas diferentes | casa equipada, ginásio | Força prática; Core anti-rotação | Progressão de carries. |


---

# Totais desta versão

```text
Total de exercícios derivados listados: 255
Total de secções: 17
```

## Observações importantes

Esta tabela inclui exercícios que já existem no catálogo atual e exercícios que devem ser considerados para expansão.

Os itens marcados como "Adicionar" são conceitos/exercícios úteis que não devem ser ignorados quando a app for refeita.

Os itens marcados como "Possível duplicado", "Mesmo exercício" ou "Padronizar" precisam de decisão no ficheiro de duplicados.

## Próximo ficheiro

O próximo ficheiro deve ser:

```text
12_CARDIO_CONCEITOS_E_MODALIDADES.md
```

Ele deve mapear cardio pela mesma lógica conceptual:

```text
capacidade cardiovascular
  -> sistema energético
    -> intensidade
      -> modalidade
        -> exercício derivado
          -> uso no treino
```
