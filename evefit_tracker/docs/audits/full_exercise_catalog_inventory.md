# Inventário completo do catálogo de exercícios

Gerado por `tool/full_catalog_inventory.dart` (FASE 1 da
revisão/expansão do catálogo). Fonte dos exercícios:
`SeedData.exercisesByGroup` → `ExerciseCatalogContextService`;
tags anatómicas: `TrainingArchitecture.tagsForExercise`;
visibilidade por filtro/local: `ExerciseFilterService`.

## Totais

- Total de exercícios: **353**
- Nomes únicos: 347
- Seleções de UI avaliadas: 189

### Por área (tipo de treino)

- peso_corporal: 66
- cardio: 58
- halteres: 57
- mobilidade: 34
- artes_marciais: 30
- alongamento: 24
- cabo: 19
- elastico: 19
- barra: 18
- isometria: 15
- maquina: 13

### Por grupo do catálogo

- Pescoço: 5
- Trapézio: 5
- Ombros: 22
- Peito: 23
- Costas: 19
- Lombar: 8
- Bíceps: 17
- Tríceps: 20
- Antebraço/Pega: 19
- Core: 21
- Pernas: 48
- Cardio: 58
- Karate: 16
- Jiu-Jitsu: 14
- Mobilidade: 58

### Por padrão de movimento

- cardio contínuo: 41
- outro / técnico: 40
- mobilidade dinâmica: 32
- técnica marcial: 30
- empurrar horizontal: 29
- alongamento estático: 24
- flexão de cotovelo: 20
- extensão de cotovelo: 15
- dobradiça de anca: 14
- puxar horizontal: 13
- agachamento / joelho dominante: 13
- cardio intervalado: 10
- anti-movimento de core: 9
- puxar vertical: 8
- cardio de coordenação: 7
- afundo: 6
- flexão/extensão de pescoço: 5
- empurrar vertical: 5
- flexão plantar/dorsal: 5
- pega / punho: 4
- flexão de tronco: 4
- elevação escapular: 3
- elevação de ombro (isolamento): 3
- transporte: 3
- rotação de tronco: 2
- flexão de joelho: 2
- abdução de anca/ombro: 2
- respiração / recuperação: 2
- flexão lateral: 1
- adução de anca: 1

### Por nível estimado

- intermédio: 246
- iniciante: 101
- avançado: 6

### Por equipamento

- Peso corporal: 137
- Halteres: 47
- Elásticos: 19
- Cabo / polia: 16
- Barra: 13
- Passadeira: 11
- Máquina: 10
- Tatami ou tapete / colchonete: 9
- Espaço exterior: 9
- Barra fixa: 7
- Bicicleta: 7
- Banco / cadeira / apoio: 6
- Halteres, banco ou chão estável: 6
- Elíptica: 6
- Corda de saltar: 6
- Peso corporal, banco / cadeira / apoio: 3
- Cabo alto / polia: 3
- Banco romano / máquina: 2
- Halteres, banco inclinado ou apoio estável: 2
- Barra ou barra EZ: 2
- Barra EZ: 2
- Discos: 2
- Mochila com peso: 2
- Paralelas: 2
- Remo ergómetro: 2
- Stepper / escadas: 2
- Air bike: 2
- Rolo de espuma (foam roller): 2
- Mesa resistente: 1
- Máquina assistida de dips: 1
- Barra fixa, toalha: 1
- Halteres, espaço livre: 1
- Garrafão de água: 1
- Banco / cadeira / apoio estável: 1
- Bola de massagem: 1
- Barra, banco declinado: 1
- Halteres, banco inclinado: 1
- Peso corporal, tapete / colchonete: 1
- Espaço exterior com escadas: 1
- Peso corporal, espaço livre: 1
- Saco de pancada: 1
- Halteres, banco declinado: 1
- Cabo de vassoura: 1
- Peso corporal, apoio para os pés: 1

### Disponíveis por local (sem seleção de músculo)

- Casa sem equipamento: 138
- Casa equipada: 353
- Exterior / parque: 145
- Dojo / tatami: 147
- Ginásio: 335

## Problemas detetados

### Sem descrição (0)

- (nenhum)

### Sem passos de execução (0)

- (nenhum)

### Descrição genérica / de template (0)

- (nenhum)

### Linguagem errada de equipamento / frases proibidas (0)

- (nenhum)

### Sem dica de postura (0)

- (nenhum)

### Sem dica de respiração (0)

- (nenhum)

### Filtros incompletos: inalcançáveis por qualquer filtro da UI (só via "mostrar todos") (0)

- (nenhum)

### Possivelmente mal categorizados (nunca aparecem em filtros da própria área) (0)

- (nenhum)

### Duplicados exatos (nome normalizado igual no mesmo grupo) (0)

- (nenhum)

### Quase-duplicados (mesmo movimento, variação de equipamento ou posição) (30)

- `encolhimento ombros`: E006 Encolhimento de ombros com halteres [Trapézio] | E007 Encolhimento de ombros com barra [Trapézio] | E008 Encolhimento de ombros na máquina [Trapézio]
- `face pull`: E010 Face pull no cabo [Trapézio] | E019 Face pull no cabo [Ombros] | E020 Face pull com elástico [Ombros] | E069 Face pull no cabo [Costas]
- `press militar`: E011 Press militar com barra em pé [Ombros] | E012 Press militar com halteres [Ombros] | E013 Press militar com barra [Ombros]
- `mobilidade ombro`: E022 Mobilidade de ombro com elástico [Ombros] | E297 Mobilidade de ombro [Mobilidade] | E301 Mobilidade de ombro com toalha [Mobilidade]
- `rotacao externa`: E024 Rotação externa [Ombros] | E025 Rotação externa com elástico [Ombros]
- `rotacao interna`: E026 Rotação interna [Ombros] | E027 Rotação interna com elástico [Ombros]
- `flexao`: E035 Flexão inclinada [Peito] | E036 Flexão declinada [Peito]
- `supino`: E039 Supino com barra [Peito] | E040 Supino com halteres [Peito] | E041 Supino inclinado com halteres [Peito] | E042 Supino inclinado com barra [Peito] | E043 Supino declinado com halteres [Peito] | E044 Supino declinado com barra [Peito] | E045 Supino declinado na máquina [Peito]
- `aberturas inclinadas`: E047 Aberturas inclinadas com halteres [Peito] | E048 Aberturas inclinadas no cabo [Peito] | E049 Aberturas inclinadas com elástico [Peito]
- `pullover`: E055 Pullover com halter [Peito] | E070 Pullover no cabo [Costas] | E071 Pullover com halter [Costas]
- `remo`: E061 Remo sentado [Costas] | E062 Remo unilateral com halter [Costas] | E063 Remo com barra [Costas] | E074 Remo com elástico [Costas]
- `good morning sem carga`: E072 Good morning sem carga [Costas] | E183 Good morning sem carga [Pernas]
- `hiperextensao`: E076 Hiperextensão no chão [Lombar] | E077 Hiperextensão no banco romano [Lombar]
- `curl`: E083 Curl com barra [Bíceps] | E084 Curl com halteres [Bíceps] | E085 Curl alternado [Bíceps] | E088 Curl inclinado com halteres [Bíceps] | E094 Curl no cabo [Bíceps] | E095 Curl com elástico [Bíceps]
- `curl inverso`: E089 Curl inverso [Bíceps] | E090 Curl inverso com halteres [Bíceps] | E126 Curl inverso [Antebraço/Pega]
- `extensao triceps`: E100 Extensão de tríceps no cabo [Tríceps] | E104 Extensão de tríceps deitado com halteres [Tríceps] | E113 Extensão unilateral de tríceps [Tríceps]
- `triceps testa`: E102 Tríceps testa com barra EZ [Tríceps] | E103 Tríceps testa com halteres [Tríceps]
- `extensao francesa`: E114 Extensão francesa com halter [Tríceps] | E115 Extensão francesa com barra EZ [Tríceps] | E116 Extensão francesa no cabo [Tríceps]
- `triceps`: E118 Tríceps no cabo com corda [Tríceps] | E119 Tríceps com elástico [Tríceps]
- `pallof press`: E148 Pallof press no cabo [Core] | E149 Pallof press com elástico [Core]
- `agachamento`: E164 Agachamento com barra [Pernas] | E165 Agachamento com mochila [Pernas] | E166 Agachamento com garrafão [Pernas] | E168 Agachamento na máquina Smith [Pernas]
- `agachamento bulgaro`: E169 Agachamento búlgaro [Pernas] | E170 Agachamento búlgaro com apoio [Pernas]
- `lunges`: E175 Lunges [Pernas] | E176 Lunges com halteres [Pernas] | E177 Lunges com mochila [Pernas]
- `hip thrust`: E185 Hip thrust [Pernas] | E186 Hip thrust com apoio [Pernas]
- `gemeos`: E190 Gémeos em pé [Pernas] | E191 Gémeos sentado [Pernas]
- `drills guarda`: E271 Drills de guarda [Karate] | E286 Drills de guarda [Jiu-Jitsu]
- `alongamento peitoral`: E303 Alongamento peitoral [Mobilidade] | E304 Alongamento peitoral na parede [Mobilidade]
- `alongamento posterior`: E311 Alongamento posterior sentado [Mobilidade] | E312 Alongamento posterior em pé [Mobilidade]
- `tocar nos pes`: E313 Tocar nos pés sentado [Mobilidade] | E314 Tocar nos pés em pé [Mobilidade]
- `alongamento gemeos`: E327 Alongamento gémeos [Mobilidade] | E328 Alongamento gémeos na parede [Mobilidade]

## Lista completa (um registo por exercício)

### E001 — Isometria cervical frontal leve

- Grupo: Pescoço | Área: isometria
- Padrão de movimento: flexão/extensão de pescoço
- Nível estimado: iniciante
- Articulações principais: coluna cervical
- Músculos (tags): anterior_neck, cervical_stabilizers
- Músculos secundários: Trapézio superior, escalenos e estabilizadores cervicais
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Musculação > neck > neck_complete | Musculação > neck > anterior_neck | Musculação > neck > cervical_stabilizers
- Objetivo (134 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E002 — Isometria cervical lateral leve

- Grupo: Pescoço | Área: isometria
- Padrão de movimento: flexão/extensão de pescoço
- Nível estimado: iniciante
- Articulações principais: coluna cervical
- Músculos (tags): lateral_neck, cervical_stabilizers
- Músculos secundários: Trapézio superior, escalenos e estabilizadores cervicais
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Musculação > neck > neck_complete | Musculação > neck > lateral_neck | Musculação > neck > cervical_stabilizers
- Objetivo (86 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E003 — Chin tuck

- Grupo: Pescoço | Área: peso_corporal
- Padrão de movimento: flexão/extensão de pescoço
- Nível estimado: intermédio
- Articulações principais: coluna cervical
- Músculos (tags): anterior_neck, posterior_neck, cervical_stabilizers
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Musculação > neck > neck_complete | Musculação > neck > anterior_neck | Musculação > neck > posterior_neck | Musculação > neck > cervical_stabilizers
- Objetivo (123 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E004 — Rotação cervical controlada

- Grupo: Pescoço | Área: peso_corporal
- Padrão de movimento: flexão/extensão de pescoço
- Nível estimado: intermédio
- Articulações principais: coluna cervical
- Músculos (tags): posterior_neck, lateral_neck, cervical_stabilizers
- Músculos secundários: Trapézio superior, escalenos e estabilizadores cervicais
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Musculação > neck > neck_complete | Musculação > neck > posterior_neck | Musculação > neck > lateral_neck | Musculação > neck > cervical_stabilizers
- Objetivo (108 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E005 — Isometria cervical posterior leve

- Grupo: Pescoço | Área: isometria
- Padrão de movimento: flexão/extensão de pescoço
- Nível estimado: iniciante
- Articulações principais: coluna cervical
- Músculos (tags): posterior_neck, cervical_stabilizers
- Músculos secundários: Trapézio superior, escalenos e estabilizadores cervicais
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Musculação > neck > neck_complete | Musculação > neck > posterior_neck | Musculação > neck > cervical_stabilizers
- Objetivo (178 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E006 — Encolhimento de ombros com halteres

- Grupo: Trapézio | Área: halteres
- Padrão de movimento: elevação escapular
- Nível estimado: intermédio
- Articulações principais: escápula
- Músculos (tags): upper_traps
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (5): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > upper_traps | Musculação > traps_scapula > traps_complete | Musculação > traps_scapula > upper_traps
- Objetivo (92 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E007 — Encolhimento de ombros com barra

- Grupo: Trapézio | Área: barra
- Padrão de movimento: elevação escapular
- Nível estimado: intermédio
- Articulações principais: escápula
- Músculos (tags): upper_traps
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (5): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > upper_traps | Musculação > traps_scapula > traps_complete | Musculação > traps_scapula > upper_traps
- Objetivo (130 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E008 — Encolhimento de ombros na máquina

- Grupo: Trapézio | Área: maquina
- Padrão de movimento: elevação escapular
- Nível estimado: intermédio
- Articulações principais: escápula
- Músculos (tags): upper_traps
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (5): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > upper_traps | Musculação > traps_scapula > traps_complete | Musculação > traps_scapula > upper_traps
- Objetivo (122 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E009 — Remo alto leve

- Grupo: Trapézio | Área: halteres
- Padrão de movimento: puxar horizontal
- Nível estimado: iniciante
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): upper_traps, mid_traps, lateral_deltoid
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (11): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > upper_traps | Musculação > back > back_upper > mid_traps | Musculação > back > back_mid | Musculação > back > back_mid > mid_traps | Musculação > back > back_thickness | Musculação > back > back_thickness > mid_traps | Musculação > traps_scapula > traps_complete | Musculação > traps_scapula > upper_traps | Musculação > traps_scapula > mid_traps
- Objetivo (157 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E010 — Face pull no cabo

- Grupo: Trapézio | Área: cabo
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_traps, lower_traps, rhomboids, posterior_deltoid
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Cabo alto / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (16): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > lower_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_upper > posterior_deltoid | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps | Musculação > back > back_thickness > lower_traps | Musculação > traps_scapula > traps_complete | Musculação > traps_scapula > mid_traps | Musculação > traps_scapula > lower_traps
- Objetivo (208 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E011 — Press militar com barra em pé

- Grupo: Ombros | Área: barra
- Padrão de movimento: empurrar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): anterior_deltoid, lateral_deltoid, deltoid_lateral
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > shoulders > shoulders_complete | Musculação > shoulders > anterior_deltoid | Musculação > shoulders > lateral_deltoid
- Objetivo (158 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E012 — Press militar com halteres

- Grupo: Ombros | Área: halteres
- Padrão de movimento: empurrar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): anterior_deltoid, lateral_deltoid, deltoid_lateral
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > shoulders > shoulders_complete | Musculação > shoulders > anterior_deltoid | Musculação > shoulders > lateral_deltoid
- Objetivo (143 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E013 — Press militar com barra

- Grupo: Ombros | Área: barra
- Padrão de movimento: empurrar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): anterior_deltoid, lateral_deltoid, deltoid_lateral
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > shoulders > shoulders_complete | Musculação > shoulders > anterior_deltoid | Musculação > shoulders > lateral_deltoid
- Objetivo (138 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E014 — Arnold press

- Grupo: Ombros | Área: halteres
- Padrão de movimento: empurrar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): anterior_deltoid, lateral_deltoid, deltoid_lateral
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > shoulders > shoulders_complete | Musculação > shoulders > anterior_deltoid | Musculação > shoulders > lateral_deltoid
- Objetivo (127 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E015 — Elevação lateral

- Grupo: Ombros | Área: halteres
- Padrão de movimento: elevação de ombro (isolamento)
- Nível estimado: intermédio
- Articulações principais: ombro
- Músculos (tags): lateral_deltoid, deltoid_lateral
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (2): Musculação > shoulders > shoulders_complete | Musculação > shoulders > lateral_deltoid
- Objetivo (94 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E016 — Elevação frontal

- Grupo: Ombros | Área: halteres
- Padrão de movimento: elevação de ombro (isolamento)
- Nível estimado: intermédio
- Articulações principais: ombro
- Músculos (tags): anterior_deltoid
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (2): Musculação > shoulders > shoulders_complete | Musculação > shoulders > anterior_deltoid
- Objetivo (126 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E017 — Elevação posterior

- Grupo: Ombros | Área: halteres
- Padrão de movimento: elevação de ombro (isolamento)
- Nível estimado: intermédio
- Articulações principais: ombro
- Músculos (tags): posterior_deltoid, scapular_stabilizers, mid_traps
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > shoulders > shoulders_complete | Musculação > shoulders > posterior_deltoid | Musculação > shoulders > scapular_stability
- Objetivo (144 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E018 — Reverse fly

- Grupo: Ombros | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): posterior_deltoid, scapular_stabilizers, mid_traps
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > shoulders > shoulders_complete | Musculação > shoulders > posterior_deltoid | Musculação > shoulders > scapular_stability
- Objetivo (130 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E019 — Face pull no cabo

- Grupo: Ombros | Área: cabo
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): posterior_deltoid, scapular_stabilizers, mid_traps, rhomboids
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Cabo alto / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (18): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_upper > posterior_deltoid | Musculação > back > back_upper > scapular_stabilizers | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps | Musculação > shoulders > shoulders_complete | Musculação > shoulders > posterior_deltoid | Musculação > shoulders > scapular_stability | Musculação > traps_scapula > traps_complete | Musculação > traps_scapula > mid_traps | Musculação > traps_scapula > scapular_stability
- Objetivo (206 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E020 — Face pull com elástico

- Grupo: Ombros | Área: elastico
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): posterior_deltoid, scapular_stabilizers, mid_traps, rhomboids
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (18): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_upper > posterior_deltoid | Musculação > back > back_upper > scapular_stabilizers | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps | Musculação > shoulders > shoulders_complete | Musculação > shoulders > posterior_deltoid | Musculação > shoulders > scapular_stability | Musculação > traps_scapula > traps_complete | Musculação > traps_scapula > mid_traps | Musculação > traps_scapula > scapular_stability
- Objetivo (162 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E021 — Pull-apart

- Grupo: Ombros | Área: elastico
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): posterior_deltoid, scapular_stabilizers, mid_traps
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > shoulders > shoulders_complete | Musculação > shoulders > posterior_deltoid | Musculação > shoulders > scapular_stability | Musculação > traps_scapula > traps_complete | Musculação > traps_scapula > mid_traps | Musculação > traps_scapula > scapular_stability
- Objetivo (146 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E022 — Mobilidade de ombro com elástico

- Grupo: Ombros | Área: elastico
- Padrão de movimento: outro / técnico
- Nível estimado: iniciante
- Articulações principais: várias
- Músculos (tags): scapular_stabilizers, external_rotators
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > shoulders > shoulders_complete | Musculação > shoulders > rotator_cuff | Musculação > shoulders > external_rotators | Musculação > shoulders > scapular_stability
- Objetivo (129 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E023 — Wall slides

- Grupo: Ombros | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): scapular_stabilizers, serratus_anterior, lower_traps
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Musculação > shoulders > shoulders_complete | Musculação > shoulders > scapular_stability
- Objetivo (155 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E024 — Rotação externa

- Grupo: Ombros | Área: elastico
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): external_rotators, teres_minor, scapular_stabilizers
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > shoulders > shoulders_complete | Musculação > shoulders > rotator_cuff | Musculação > shoulders > external_rotators | Musculação > shoulders > scapular_stability
- Objetivo (135 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E025 — Rotação externa com elástico

- Grupo: Ombros | Área: elastico
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): external_rotators, teres_minor, scapular_stabilizers
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > shoulders > shoulders_complete | Musculação > shoulders > rotator_cuff | Musculação > shoulders > external_rotators | Musculação > shoulders > scapular_stability
- Objetivo (128 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E026 — Rotação interna

- Grupo: Ombros | Área: elastico
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): internal_rotators, scapular_stabilizers
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > shoulders > shoulders_complete | Musculação > shoulders > rotator_cuff | Musculação > shoulders > internal_rotators | Musculação > shoulders > scapular_stability
- Objetivo (149 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E027 — Rotação interna com elástico

- Grupo: Ombros | Área: elastico
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): internal_rotators, scapular_stabilizers
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > shoulders > shoulders_complete | Musculação > shoulders > rotator_cuff | Musculação > shoulders > internal_rotators | Musculação > shoulders > scapular_stability
- Objetivo (137 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E028 — Y raise

- Grupo: Ombros | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): lower_traps, scapular_stabilizers
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (5): Musculação > shoulders > shoulders_complete | Musculação > shoulders > scapular_stability | Musculação > traps_scapula > traps_complete | Musculação > traps_scapula > lower_traps | Musculação > traps_scapula > scapular_stability
- Objetivo (145 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E029 — W raise

- Grupo: Ombros | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): mid_traps, external_rotators, scapular_stabilizers
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (7): Musculação > shoulders > shoulders_complete | Musculação > shoulders > rotator_cuff | Musculação > shoulders > external_rotators | Musculação > shoulders > scapular_stability | Musculação > traps_scapula > traps_complete | Musculação > traps_scapula > mid_traps | Musculação > traps_scapula > scapular_stability
- Objetivo (151 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E030 — Scapular push-up

- Grupo: Ombros | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): serratus_anterior, scapular_stabilizers
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > serratus_anterior | Musculação > shoulders > shoulders_complete | Musculação > shoulders > scapular_stability
- Objetivo (147 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E031 — Pike push-up

- Grupo: Ombros | Área: peso_corporal
- Padrão de movimento: empurrar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): anterior_deltoid, lateral_deltoid, serratus_anterior
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Musculação > shoulders > shoulders_complete | Musculação > shoulders > anterior_deltoid | Musculação > shoulders > lateral_deltoid
- Objetivo (83 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E032 — Elevação no plano da omoplata

- Grupo: Ombros | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): lateral_deltoid, deltoid_lateral, external_rotators, scapular_stabilizers
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (5): Musculação > shoulders > shoulders_complete | Musculação > shoulders > lateral_deltoid | Musculação > shoulders > rotator_cuff | Musculação > shoulders > external_rotators | Musculação > shoulders > scapular_stability
- Objetivo (182 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E033 — Flexão clássica

- Grupo: Peito | Área: peso_corporal
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_chest, upper_chest, lower_chest, serratus_anterior
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (5): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest | Musculação > chest > serratus_anterior
- Objetivo (127 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E034 — Flexão com joelhos apoiados

- Grupo: Peito | Área: peso_corporal
- Padrão de movimento: empurrar horizontal
- Nível estimado: iniciante
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_chest, upper_chest, lower_chest, serratus_anterior
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Peso corporal, tapete / colchonete
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (5): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest | Musculação > chest > serratus_anterior
- Objetivo (115 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E035 — Flexão inclinada

- Grupo: Peito | Área: peso_corporal
- Padrão de movimento: empurrar horizontal
- Nível estimado: iniciante
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lower_chest, mid_chest, serratus_anterior
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Peso corporal, banco / cadeira / apoio
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > mid_chest | Musculação > chest > lower_chest | Musculação > chest > serratus_anterior
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E036 — Flexão declinada

- Grupo: Peito | Área: peso_corporal
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): upper_chest, serratus_anterior
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Peso corporal, banco / cadeira / apoio
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > serratus_anterior
- Objetivo (114 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E037 — Flexão aberta

- Grupo: Peito | Área: peso_corporal
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_chest, upper_chest, lower_chest, serratus_anterior
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (5): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest | Musculação > chest > serratus_anterior
- Objetivo (79 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E038 — Flexão arqueiro

- Grupo: Peito | Área: peso_corporal
- Padrão de movimento: empurrar horizontal
- Nível estimado: avançado
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_chest, upper_chest, lower_chest, serratus_anterior
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (5): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest | Musculação > chest > serratus_anterior
- Objetivo (141 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E039 — Supino com barra

- Grupo: Peito | Área: barra
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_chest, upper_chest, lower_chest
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest
- Objetivo (121 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E040 — Supino com halteres

- Grupo: Peito | Área: halteres
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_chest, upper_chest, lower_chest
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Halteres, banco ou chão estável
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest
- Objetivo (136 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E041 — Supino inclinado com halteres

- Grupo: Peito | Área: halteres
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): upper_chest, serratus_anterior
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > serratus_anterior
- Objetivo (118 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E042 — Supino inclinado com barra

- Grupo: Peito | Área: barra
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): upper_chest, serratus_anterior
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > serratus_anterior
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E043 — Supino declinado com halteres

- Grupo: Peito | Área: halteres
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lower_chest
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Halteres, banco declinado
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (2): Musculação > chest > chest_complete | Musculação > chest > lower_chest
- Objetivo (99 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E044 — Supino declinado com barra

- Grupo: Peito | Área: barra
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lower_chest
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Barra, banco declinado
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (2): Musculação > chest > chest_complete | Musculação > chest > lower_chest
- Objetivo (91 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E045 — Supino declinado na máquina

- Grupo: Peito | Área: maquina
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lower_chest
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (2): Musculação > chest > chest_complete | Musculação > chest > lower_chest
- Objetivo (124 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E046 — Aberturas com halteres

- Grupo: Peito | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): mid_chest, upper_chest, lower_chest
- Músculos secundários: Deltoide anterior, bíceps como estabilizador e escápulas
- Equipamento: Halteres, banco ou chão estável
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest
- Objetivo (118 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E047 — Aberturas inclinadas com halteres

- Grupo: Peito | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: iniciante
- Articulações principais: várias
- Músculos (tags): mid_chest, upper_chest, lower_chest
- Músculos secundários: Deltoide anterior, bíceps como estabilizador e escápulas
- Equipamento: Halteres, banco inclinado
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest
- Objetivo (113 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E048 — Aberturas inclinadas no cabo

- Grupo: Peito | Área: cabo
- Padrão de movimento: outro / técnico
- Nível estimado: iniciante
- Articulações principais: várias
- Músculos (tags): mid_chest, upper_chest, lower_chest
- Músculos secundários: Deltoide anterior, bíceps como estabilizador e escápulas
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest
- Objetivo (120 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E049 — Aberturas inclinadas com elástico

- Grupo: Peito | Área: elastico
- Padrão de movimento: outro / técnico
- Nível estimado: iniciante
- Articulações principais: várias
- Músculos (tags): mid_chest, upper_chest, lower_chest
- Músculos secundários: Deltoide anterior, bíceps como estabilizador e escápulas
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest
- Objetivo (95 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E050 — Squeeze press

- Grupo: Peito | Área: halteres
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_chest, upper_chest, lower_chest
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest
- Objetivo (86 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E051 — Chest press

- Grupo: Peito | Área: maquina
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_chest, upper_chest, lower_chest
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > upper_chest | Musculação > chest > mid_chest | Musculação > chest > lower_chest
- Objetivo (111 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E052 — Dips para peito em paralelas

- Grupo: Peito | Área: peso_corporal
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lower_chest, pectoralis_minor
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Paralelas
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > chest > chest_complete | Musculação > chest > lower_chest | Musculação > chest > pectoralis_minor
- Objetivo (75 chars) ✓ | Execução (5 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E053 — Dips assistidos para peito na máquina

- Grupo: Peito | Área: maquina
- Padrão de movimento: empurrar horizontal
- Nível estimado: iniciante
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lower_chest, pectoralis_minor
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Máquina assistida de dips
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > chest > chest_complete | Musculação > chest > lower_chest | Musculação > chest > pectoralis_minor
- Objetivo (133 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E054 — Crossover no cabo

- Grupo: Peito | Área: cabo
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_chest, lower_chest, pectoralis_minor
- Músculos secundários: Deltoide anterior, bíceps como estabilizador e escápulas
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > chest > chest_complete | Musculação > chest > mid_chest | Musculação > chest > lower_chest | Musculação > chest > pectoralis_minor
- Objetivo (84 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E055 — Pullover com halter

- Grupo: Peito | Área: halteres
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): mid_chest, serratus_anterior
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Musculação > chest > chest_complete | Musculação > chest > mid_chest | Musculação > chest > serratus_anterior
- Objetivo (186 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E056 — Puxada alta

- Grupo: Costas | Área: cabo
- Padrão de movimento: puxar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lats, teres_major, vertical_pulls, rhomboids
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > teres_major | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_width > teres_major | Musculação > back > back_width > vertical_pulls | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids
- Objetivo (149 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E057 — Puxada alta pega aberta

- Grupo: Costas | Área: cabo
- Padrão de movimento: puxar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lats, teres_major, vertical_pulls, rhomboids
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > teres_major | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_width > teres_major | Musculação > back > back_width > vertical_pulls | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids
- Objetivo (97 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E058 — Puxada alta pega neutra

- Grupo: Costas | Área: cabo
- Padrão de movimento: puxar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lats, teres_major, vertical_pulls, rhomboids
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > teres_major | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_width > teres_major | Musculação > back > back_width > vertical_pulls | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E059 — Puxada alta pega fechada

- Grupo: Costas | Área: cabo
- Padrão de movimento: puxar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lats, teres_major, vertical_pulls, rhomboids
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > teres_major | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_width > teres_major | Musculação > back > back_width > vertical_pulls | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids
- Objetivo (134 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E060 — Remo baixo no cabo

- Grupo: Costas | Área: cabo
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): rhomboids, mid_traps, lats, horizontal_rows
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps | Musculação > back > back_thickness > horizontal_rows
- Objetivo (147 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E061 — Remo sentado

- Grupo: Costas | Área: maquina
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): rhomboids, mid_traps, lats, horizontal_rows
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps | Musculação > back > back_thickness > horizontal_rows
- Objetivo (144 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E062 — Remo unilateral com halter

- Grupo: Costas | Área: halteres
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): rhomboids, mid_traps, lats, horizontal_rows
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps | Musculação > back > back_thickness > horizontal_rows
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E063 — Remo com barra

- Grupo: Costas | Área: barra
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): rhomboids, mid_traps, lats, horizontal_rows
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps | Musculação > back > back_thickness > horizontal_rows
- Objetivo (130 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E064 — Remo invertido

- Grupo: Costas | Área: peso_corporal
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): rhomboids, mid_traps, lats, horizontal_rows
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Barra fixa
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps | Musculação > back > back_thickness > horizontal_rows
- Objetivo (128 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E065 — Remo invertido em mesa resistente

- Grupo: Costas | Área: peso_corporal
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): rhomboids, mid_traps, lats, horizontal_rows
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Mesa resistente
- Locais possíveis: Casa equipada
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps | Musculação > back > back_thickness > horizontal_rows
- Objetivo (130 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E066 — Pull-up

- Grupo: Costas | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): lats, teres_major, vertical_pulls, rhomboids
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Barra fixa
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > teres_major | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_width > teres_major | Musculação > back > back_width > vertical_pulls | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids
- Objetivo (148 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E067 — Scapular pull-up

- Grupo: Costas | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): scapular_stabilizers, lower_traps, lats
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Barra fixa
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > lower_traps | Musculação > back > back_upper > scapular_stabilizers | Musculação > back > back_mid | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_thickness | Musculação > back > back_thickness > lower_traps
- Objetivo (150 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E068 — Dead hang escapular

- Grupo: Costas | Área: isometria
- Padrão de movimento: puxar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): scapular_stabilizers, lower_traps, lats
- Músculos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Equipamento: Barra fixa
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (9): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > lower_traps | Musculação > back > back_upper > scapular_stabilizers | Musculação > back > back_mid | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_thickness | Musculação > back > back_thickness > lower_traps
- Objetivo (153 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E069 — Face pull no cabo

- Grupo: Costas | Área: cabo
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): rhomboids, mid_traps, posterior_deltoid, teres_minor
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Cabo alto / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_upper > posterior_deltoid | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_mid > teres_minor | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps
- Objetivo (206 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E070 — Pullover no cabo

- Grupo: Costas | Área: cabo
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lats, teres_major
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > back > back_complete | Musculação > back > back_mid | Musculação > back > back_mid > teres_major | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_width > teres_major | Musculação > back > back_thickness
- Objetivo (143 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E071 — Pullover com halter

- Grupo: Costas | Área: halteres
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lats, teres_major
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > back > back_complete | Musculação > back > back_mid | Musculação > back > back_mid > teres_major | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_width > teres_major | Musculação > back > back_thickness
- Objetivo (187 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E072 — Good morning sem carga

- Grupo: Costas | Área: peso_corporal
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): erectors
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (10): Musculação > back > back_complete | Musculação > back > back_lower | Musculação > back > back_lower > erectors | Musculação > back > back_lower > lumbar | Musculação > back > back_lower > lumbar_stability | Musculação > back > back_thickness | Musculação > core > core_complete | Musculação > core > lumbar_zone | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors
- Objetivo (205 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E073 — Puxada com braços esticados

- Grupo: Costas | Área: cabo
- Padrão de movimento: puxar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): lats, teres_major
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > back > back_complete | Musculação > back > back_mid | Musculação > back > back_mid > teres_major | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_width > teres_major | Musculação > back > back_thickness
- Objetivo (159 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E074 — Remo com elástico

- Grupo: Costas | Área: elastico
- Padrão de movimento: puxar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): rhomboids, mid_traps, lats, horizontal_rows
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (13): Musculação > back > back_complete | Musculação > back > back_upper | Musculação > back > back_upper > mid_traps | Musculação > back > back_upper > rhomboids | Musculação > back > back_mid | Musculação > back > back_mid > rhomboids | Musculação > back > back_mid > mid_traps | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_thickness | Musculação > back > back_thickness > rhomboids | Musculação > back > back_thickness > mid_traps | Musculação > back > back_thickness > horizontal_rows
- Objetivo (130 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E075 — Hiperextensão lombar

- Grupo: Lombar | Área: maquina
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): erectors, quadratus_lumborum
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Banco romano / máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > back > back_complete | Musculação > back > back_lower | Musculação > back > back_lower > erectors | Musculação > back > back_lower > lumbar | Musculação > back > back_lower > quadratus_lumborum | Musculação > back > back_lower > lumbar_stability | Musculação > back > back_thickness | Musculação > core > core_complete | Musculação > core > lumbar_zone | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors | Musculação > core > lumbar_zone > quadratus_lumborum
- Objetivo (159 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E076 — Hiperextensão no chão

- Grupo: Lombar | Área: peso_corporal
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): erectors, quadratus_lumborum
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (12): Musculação > back > back_complete | Musculação > back > back_lower | Musculação > back > back_lower > erectors | Musculação > back > back_lower > lumbar | Musculação > back > back_lower > quadratus_lumborum | Musculação > back > back_lower > lumbar_stability | Musculação > back > back_thickness | Musculação > core > core_complete | Musculação > core > lumbar_zone | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors | Musculação > core > lumbar_zone > quadratus_lumborum
- Objetivo (156 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E077 — Hiperextensão no banco romano

- Grupo: Lombar | Área: maquina
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): erectors, quadratus_lumborum
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Banco romano / máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > back > back_complete | Musculação > back > back_lower | Musculação > back > back_lower > erectors | Musculação > back > back_lower > lumbar | Musculação > back > back_lower > quadratus_lumborum | Musculação > back > back_lower > lumbar_stability | Musculação > back > back_thickness | Musculação > core > core_complete | Musculação > core > lumbar_zone | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors | Musculação > core > lumbar_zone > quadratus_lumborum
- Objetivo (156 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E078 — Superman isométrico

- Grupo: Lombar | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: iniciante
- Articulações principais: várias
- Músculos (tags): erectors, quadratus_lumborum
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (12): Musculação > back > back_complete | Musculação > back > back_lower | Musculação > back > back_lower > erectors | Musculação > back > back_lower > lumbar | Musculação > back > back_lower > quadratus_lumborum | Musculação > back > back_lower > lumbar_stability | Musculação > back > back_thickness | Musculação > core > core_complete | Musculação > core > lumbar_zone | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors | Musculação > core > lumbar_zone > quadratus_lumborum
- Objetivo (152 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E079 — Extensão lombar quadrupede

- Grupo: Lombar | Área: peso_corporal
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): erectors, quadratus_lumborum
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (12): Musculação > back > back_complete | Musculação > back > back_lower | Musculação > back > back_lower > erectors | Musculação > back > back_lower > lumbar | Musculação > back > back_lower > quadratus_lumborum | Musculação > back > back_lower > lumbar_stability | Musculação > back > back_thickness | Musculação > core > core_complete | Musculação > core > lumbar_zone | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors | Musculação > core > lumbar_zone > quadratus_lumborum
- Objetivo (123 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E080 — Good morning com barra

- Grupo: Lombar | Área: barra
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): erectors, quadratus_lumborum
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > back > back_complete | Musculação > back > back_lower | Musculação > back > back_lower > erectors | Musculação > back > back_lower > lumbar | Musculação > back > back_lower > quadratus_lumborum | Musculação > back > back_lower > lumbar_stability | Musculação > back > back_thickness | Musculação > core > core_complete | Musculação > core > lumbar_zone | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors | Musculação > core > lumbar_zone > quadratus_lumborum
- Objetivo (162 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E081 — Good morning leve isométrico

- Grupo: Lombar | Área: barra
- Padrão de movimento: dobradiça de anca
- Nível estimado: iniciante
- Articulações principais: anca, joelho
- Músculos (tags): erectors, quadratus_lumborum
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > back > back_complete | Musculação > back > back_lower | Musculação > back > back_lower > erectors | Musculação > back > back_lower > lumbar | Musculação > back > back_lower > quadratus_lumborum | Musculação > back > back_lower > lumbar_stability | Musculação > back > back_thickness | Musculação > core > core_complete | Musculação > core > lumbar_zone | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors | Musculação > core > lumbar_zone > quadratus_lumborum
- Objetivo (100 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E082 — Extensão lombar com elástico

- Grupo: Lombar | Área: elastico
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): erectors, quadratus_lumborum
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > back > back_complete | Musculação > back > back_lower | Musculação > back > back_lower > erectors | Musculação > back > back_lower > lumbar | Musculação > back > back_lower > quadratus_lumborum | Musculação > back > back_lower > lumbar_stability | Musculação > back > back_thickness | Musculação > core > core_complete | Musculação > core > lumbar_zone | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors | Musculação > core > lumbar_zone > quadratus_lumborum
- Objetivo (125 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E083 — Curl com barra

- Grupo: Bíceps | Área: barra
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E084 — Curl com halteres

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (148 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E085 — Curl alternado

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (148 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E086 — Curl martelo

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis, brachioradialis
- Músculos secundários: Braquial, braquiorradial, antebraço, punho e pega
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (5): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis | Musculação > arms > upper_arm > brachioradialis
- Objetivo (110 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E087 — Curl concentrado

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (137 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E088 — Curl inclinado com halteres

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Halteres, banco inclinado ou apoio estável
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (80 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E089 — Curl inverso

- Grupo: Bíceps | Área: barra
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): brachialis, brachioradialis
- Músculos secundários: Braquial, braquiorradial, extensores do antebraço, punho e pega
- Equipamento: Barra ou barra EZ
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > brachialis | Musculação > arms > upper_arm > brachioradialis
- Objetivo (137 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E090 — Curl inverso com halteres

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): brachialis, brachioradialis
- Músculos secundários: Braquial, braquiorradial, extensores do antebraço, punho e pega
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > brachialis | Musculação > arms > upper_arm > brachioradialis
- Objetivo (93 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E091 — Curl Zottman

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis, brachioradialis
- Músculos secundários: Braquial, braquiorradial, antebraço, punho e pega
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (5): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis | Musculação > arms > upper_arm > brachioradialis
- Objetivo (94 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E092 — Curl cruzado no corpo

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis, brachioradialis
- Músculos secundários: Braquial, braquiorradial, antebraço, punho e pega
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (5): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis | Musculação > arms > upper_arm > brachioradialis
- Objetivo (147 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E093 — Curl spider

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Halteres, banco inclinado ou apoio estável
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (135 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E094 — Curl no cabo

- Grupo: Bíceps | Área: cabo
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E095 — Curl com elástico

- Grupo: Bíceps | Área: elastico
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (163 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E096 — Curl 21 com halteres

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (149 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E097 — Curl arrastado com halteres

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (146 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E098 — Curl isométrico

- Grupo: Bíceps | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: iniciante
- Articulações principais: cotovelo
- Músculos (tags): biceps, brachialis
- Músculos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E099 — Chin-up

- Grupo: Bíceps | Área: peso_corporal
- Padrão de movimento: puxar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): biceps, brachialis, lats, vertical_pulls
- Músculos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Equipamento: Barra fixa
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (11): Musculação > back > back_complete | Musculação > back > back_mid | Musculação > back > back_mid > latissimus_dorsi | Musculação > back > back_width | Musculação > back > back_width > latissimus_dorsi | Musculação > back > back_width > vertical_pulls | Musculação > back > back_thickness | Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > biceps_brachii | Musculação > arms > upper_arm > brachialis
- Objetivo (137 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E100 — Extensão de tríceps no cabo

- Grupo: Tríceps | Área: cabo
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (131 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E101 — Extensão acima da cabeça com halter

- Grupo: Tríceps | Área: halteres
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_long, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (114 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E102 — Tríceps testa com barra EZ

- Grupo: Tríceps | Área: barra
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_long, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Barra EZ
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (128 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E103 — Tríceps testa com halteres

- Grupo: Tríceps | Área: halteres
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_long, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Halteres, banco ou chão estável
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E104 — Extensão de tríceps deitado com halteres

- Grupo: Tríceps | Área: halteres
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_long, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Halteres, banco ou chão estável
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (90 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E105 — Supino fechado

- Grupo: Tríceps | Área: barra
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): triceps_long, triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (128 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E106 — Press fechado com halteres

- Grupo: Tríceps | Área: halteres
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): triceps_long, triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Halteres, banco ou chão estável
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (122 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E107 — Tate press

- Grupo: Tríceps | Área: halteres
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): triceps_long, triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Halteres, banco ou chão estável
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (100 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E108 — Fundos entre apoios

- Grupo: Tríceps | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): triceps_long, triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Banco / cadeira / apoio
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (120 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E109 — Flexão fechada

- Grupo: Tríceps | Área: peso_corporal
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): triceps_long, triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (131 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E110 — Flexão diamante

- Grupo: Tríceps | Área: peso_corporal
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): triceps_long, triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (106 chars) ✓ | Execução (5 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E111 — Kickback de tríceps

- Grupo: Tríceps | Área: halteres
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (100 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E112 — Kickback no cabo

- Grupo: Tríceps | Área: cabo
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (117 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E113 — Extensão unilateral de tríceps

- Grupo: Tríceps | Área: halteres
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_long, triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (114 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E114 — Extensão francesa com halter

- Grupo: Tríceps | Área: halteres
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_long, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (123 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E115 — Extensão francesa com barra EZ

- Grupo: Tríceps | Área: barra
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_long, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Barra EZ
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (126 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E116 — Extensão francesa no cabo

- Grupo: Tríceps | Área: cabo
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): triceps_long, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (116 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E117 — Dips para tríceps

- Grupo: Tríceps | Área: peso_corporal
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): triceps_long, triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Paralelas
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (100 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E118 — Tríceps no cabo com corda

- Grupo: Tríceps | Área: cabo
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (124 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E119 — Tríceps com elástico

- Grupo: Tríceps | Área: elastico
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): triceps_lateral, triceps_medial
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > arms > arms_complete | Musculação > arms > upper_arm | Musculação > arms > upper_arm > triceps | Musculação > arms > upper_arm > triceps_long | Musculação > arms > upper_arm > triceps_lateral | Musculação > arms > upper_arm > triceps_medial
- Objetivo (117 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E120 — Wrist curl

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): forearm_flexors, wrist
- Músculos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_flexors | Musculação > arms > forearm_hand > wrist | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_flexors | Musculação > forearm_hand > wrist | Musculação > forearm_hand > general_grip
- Objetivo (152 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E121 — Reverse wrist curl

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): forearm_extensors, wrist
- Músculos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_flexors | Musculação > arms > forearm_hand > forearm_extensors | Musculação > arms > forearm_hand > wrist | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_flexors | Musculação > forearm_hand > forearm_extensors | Musculação > forearm_hand > wrist | Musculação > forearm_hand > general_grip
- Objetivo (144 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E122 — Farmer walk

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: transporte
- Nível estimado: intermédio
- Articulações principais: punho, ombro, anca
- Músculos (tags): grip_support, forearm_flexors
- Músculos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_flexors | Musculação > arms > forearm_hand > support_grip | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_flexors | Musculação > forearm_hand > support_grip | Musculação > forearm_hand > general_grip
- Objetivo (188 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E123 — Farmer hold

- Grupo: Antebraço/Pega | Área: isometria
- Padrão de movimento: transporte
- Nível estimado: intermédio
- Articulações principais: punho, ombro, anca
- Músculos (tags): grip_support, forearm_flexors
- Músculos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_flexors | Musculação > arms > forearm_hand > support_grip | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_flexors | Musculação > forearm_hand > support_grip | Musculação > forearm_hand > general_grip
- Objetivo (155 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E124 — Dead hang

- Grupo: Antebraço/Pega | Área: isometria
- Padrão de movimento: puxar vertical
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): grip_support, forearm_flexors
- Músculos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Equipamento: Barra fixa
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_flexors | Musculação > arms > forearm_hand > support_grip | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_flexors | Musculação > forearm_hand > support_grip | Musculação > forearm_hand > general_grip
- Objetivo (144 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E125 — Aperto isométrico

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: pega / punho
- Nível estimado: iniciante
- Articulações principais: punho, dedos
- Músculos (tags): grip_support, fingers, forearm_flexors
- Músculos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_flexors | Musculação > arms > forearm_hand > fingers | Musculação > arms > forearm_hand > support_grip | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_flexors | Musculação > forearm_hand > fingers | Musculação > forearm_hand > support_grip | Musculação > forearm_hand > general_grip
- Objetivo (83 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E126 — Curl inverso

- Grupo: Antebraço/Pega | Área: barra
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): brachioradialis, forearm_extensors, wrist
- Músculos secundários: Braquial, braquiorradial, extensores do antebraço, punho e pega
- Equipamento: Barra ou barra EZ
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > arms > arms_complete | Musculação > arms > upper_arm > brachialis | Musculação > arms > upper_arm > brachioradialis | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_extensors | Musculação > arms > forearm_hand > wrist | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_extensors | Musculação > forearm_hand > wrist | Musculação > forearm_hand > general_grip
- Objetivo (147 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E127 — Pronação com halter

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): pronators, wrist
- Músculos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > pronators | Musculação > arms > forearm_hand > wrist | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > pronators | Musculação > forearm_hand > wrist | Musculação > forearm_hand > general_grip
- Objetivo (131 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E128 — Supinação com halter

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): supinators, wrist
- Músculos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > supinators | Musculação > arms > forearm_hand > wrist | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > supinators | Musculação > forearm_hand > wrist | Musculação > forearm_hand > general_grip
- Objetivo (131 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E129 — Pinch grip

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: pega / punho
- Nível estimado: intermédio
- Articulações principais: punho, dedos
- Músculos (tags): pinch_grip, fingers
- Músculos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Equipamento: Discos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > fingers | Musculação > arms > forearm_hand > pinch_grip | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > fingers | Musculação > forearm_hand > pinch_grip | Musculação > forearm_hand > general_grip
- Objetivo (152 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E130 — Plate hold

- Grupo: Antebraço/Pega | Área: isometria
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): pinch_grip, fingers
- Músculos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Equipamento: Discos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > fingers | Musculação > arms > forearm_hand > support_grip | Musculação > arms > forearm_hand > pinch_grip | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > fingers | Musculação > forearm_hand > support_grip | Musculação > forearm_hand > pinch_grip | Musculação > forearm_hand > general_grip
- Objetivo (136 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E131 — Towel grip hold

- Grupo: Antebraço/Pega | Área: isometria
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): grip_support, fingers, forearm_flexors
- Músculos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Equipamento: Barra fixa, toalha
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (12): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_flexors | Musculação > arms > forearm_hand > fingers | Musculação > arms > forearm_hand > support_grip | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_flexors | Musculação > forearm_hand > fingers | Musculação > forearm_hand > support_grip | Musculação > forearm_hand > general_grip
- Objetivo (151 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E132 — Finger curls

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: flexão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): fingers, forearm_flexors
- Músculos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_flexors | Musculação > arms > forearm_hand > fingers | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_flexors | Musculação > forearm_hand > fingers | Musculação > forearm_hand > general_grip
- Objetivo (131 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E133 — Extensão de dedos com elástico

- Grupo: Antebraço/Pega | Área: elastico
- Padrão de movimento: pega / punho
- Nível estimado: intermédio
- Articulações principais: punho, dedos
- Músculos (tags): fingers, forearm_extensors
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_extensors | Musculação > arms > forearm_hand > fingers | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_extensors | Musculação > forearm_hand > fingers | Musculação > forearm_hand > general_grip
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E134 — Desvio radial com halter

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): wrist
- Músculos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > wrist | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > wrist | Musculação > forearm_hand > general_grip
- Objetivo (74 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E135 — Desvio ulnar com halter

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): wrist
- Músculos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > wrist | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > wrist | Musculação > forearm_hand > general_grip
- Objetivo (101 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E136 — Suitcase carry

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: transporte
- Nível estimado: intermédio
- Articulações principais: punho, ombro, anca
- Músculos (tags): grip_support, forearm_flexors, anti_lateral_flexion, deep_stability
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Halteres, espaço livre
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (16): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_flexors | Musculação > arms > forearm_hand > support_grip | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_flexors | Musculação > forearm_hand > support_grip | Musculação > forearm_hand > general_grip | Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_lateral_flexion | Musculação > core > core_stability_zone > deep_stability
- Objetivo (130 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E137 — Hold estático com halteres

- Grupo: Antebraço/Pega | Área: isometria
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): grip_support, forearm_flexors
- Músculos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > forearm_flexors | Musculação > arms > forearm_hand > support_grip | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > forearm_flexors | Musculação > forearm_hand > support_grip | Musculação > forearm_hand > general_grip
- Objetivo (155 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E138 — Rotação controlada com halter leve

- Grupo: Antebraço/Pega | Área: halteres
- Padrão de movimento: outro / técnico
- Nível estimado: iniciante
- Articulações principais: várias
- Músculos (tags): wrist
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > arms > arms_complete | Musculação > arms > forearm_hand | Musculação > arms > forearm_hand > forearm_complete | Musculação > arms > forearm_hand > wrist | Musculação > arms > forearm_hand > general_grip | Musculação > forearm_hand > forearm_complete | Musculação > forearm_hand > wrist | Musculação > forearm_hand > general_grip
- Objetivo (91 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E139 — Prancha

- Grupo: Core | Área: isometria
- Padrão de movimento: anti-movimento de core
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): anti_extension, deep_stability, transverse_abdominis
- Músculos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (8): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_extension | Musculação > core > core_stability_zone > deep_stability
- Objetivo (118 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E140 — Prancha lateral

- Grupo: Core | Área: isometria
- Padrão de movimento: anti-movimento de core
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): external_obliques, internal_obliques, anti_lateral_flexion, deep_stability
- Músculos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (9): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > abdominal_zone > external_obliques | Musculação > core > abdominal_zone > internal_obliques | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_lateral_flexion | Musculação > core > core_stability_zone > deep_stability
- Objetivo (135 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E141 — Crunch

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: flexão de tronco
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): rectus_abdominis, transverse_abdominis
- Músculos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (9): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > upper_abs | Musculação > core > abdominal_zone > mid_abs | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > abdominal_zone > rectus_abdominis | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E142 — Reverse crunch

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: flexão de tronco
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): rectus_abdominis, transverse_abdominis
- Músculos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (10): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > upper_abs | Musculação > core > abdominal_zone > mid_abs | Musculação > core > abdominal_zone > lower_abs | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > abdominal_zone > rectus_abdominis | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E143 — Elevação de pernas

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: flexão de tronco
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): rectus_abdominis, transverse_abdominis
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lower_abs | Musculação > core > abdominal_zone > rectus_abdominis | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E144 — Elevação de joelhos suspenso

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): rectus_abdominis, transverse_abdominis
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Barra fixa
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (7): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lower_abs | Musculação > core > abdominal_zone > rectus_abdominis | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E145 — Dead bug

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: anti-movimento de core
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): anti_extension, deep_stability, transverse_abdominis
- Músculos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (8): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_extension | Musculação > core > core_stability_zone > deep_stability
- Objetivo (128 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E146 — Hollow hold

- Grupo: Core | Área: isometria
- Padrão de movimento: anti-movimento de core
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): anti_extension, deep_stability, transverse_abdominis
- Músculos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_extension | Musculação > core > core_stability_zone > deep_stability
- Objetivo (140 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E147 — Mountain climbers

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): rectus_abdominis, transverse_abdominis
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (10): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > rectus_abdominis | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone | Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (120 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E148 — Pallof press no cabo

- Grupo: Core | Área: cabo
- Padrão de movimento: anti-movimento de core
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): anti_rotation, deep_stability
- Músculos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (7): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_rotation | Musculação > core > core_stability_zone > deep_stability
- Objetivo (151 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E149 — Pallof press com elástico

- Grupo: Core | Área: elastico
- Padrão de movimento: anti-movimento de core
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): anti_rotation, deep_stability
- Músculos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (7): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_rotation | Musculação > core > core_stability_zone > deep_stability
- Objetivo (149 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E150 — Russian twist

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: rotação de tronco
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): external_obliques, internal_obliques, rectus_abdominis
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (8): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > abdominal_zone > rectus_abdominis | Musculação > core > abdominal_zone > external_obliques | Musculação > core > abdominal_zone > internal_obliques | Musculação > core > core_stability_zone
- Objetivo (157 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E151 — Bicycle crunch

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: flexão de tronco
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): external_obliques, internal_obliques, rectus_abdominis
- Músculos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (10): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > upper_abs | Musculação > core > abdominal_zone > mid_abs | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > abdominal_zone > rectus_abdominis | Musculação > core > abdominal_zone > external_obliques | Musculação > core > abdominal_zone > internal_obliques | Musculação > core > core_stability_zone
- Objetivo (145 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E152 — Bird dog

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: anti-movimento de core
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): erectors, deep_stability
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > deep_stability
- Objetivo (127 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E153 — Side bend

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: flexão lateral
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): external_obliques, internal_obliques
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > external_obliques | Musculação > core > abdominal_zone > internal_obliques | Musculação > core > core_stability_zone
- Objetivo (150 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E154 — Vacuum abdominal

- Grupo: Core | Área: isometria
- Padrão de movimento: anti-movimento de core
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): transverse_abdominis, deep_stability
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > deep_stability
- Objetivo (137 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E155 — Flutter kicks

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): rectus_abdominis, transverse_abdominis
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lower_abs | Musculação > core > abdominal_zone > rectus_abdominis | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone
- Objetivo (145 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E156 — Toe touches

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): rectus_abdominis, transverse_abdominis
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > upper_abs | Musculação > core > abdominal_zone > rectus_abdominis | Musculação > core > abdominal_zone > transverse_abdominis | Musculação > core > core_stability_zone
- Objetivo (143 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E157 — Superman

- Grupo: Core | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): erectors
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > lumbar_zone > lumbar | Musculação > core > lumbar_zone > erectors | Musculação > core > core_stability_zone
- Objetivo (158 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E158 — Lenhador no cabo

- Grupo: Core | Área: cabo
- Padrão de movimento: rotação de tronco
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): external_obliques, internal_obliques, anti_rotation
- Músculos secundários: Oblíquos, glúteos, ombros e estabilidade da anca
- Equipamento: Cabo / polia
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > abdominal_zone > external_obliques | Musculação > core > abdominal_zone > internal_obliques | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_rotation
- Objetivo (191 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E159 — Prancha com toque no ombro

- Grupo: Core | Área: isometria
- Padrão de movimento: anti-movimento de core
- Nível estimado: intermédio
- Articulações principais: coluna, anca
- Músculos (tags): anti_rotation, anti_extension, deep_stability
- Músculos secundários: Ombros, serrátil anterior, glúteos e estabilidade do punho
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_rotation | Musculação > core > core_stability_zone > anti_extension | Musculação > core > core_stability_zone > deep_stability
- Objetivo (117 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E160 — Agachamento com peso corporal

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (149 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E161 — Agachamento para cadeira

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Peso corporal, banco / cadeira / apoio
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (159 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E162 — Agachamento goblet

- Grupo: Pernas | Área: halteres
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (161 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E163 — Agachamento com halteres ao lado

- Grupo: Pernas | Área: halteres
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (143 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E164 — Agachamento com barra

- Grupo: Pernas | Área: barra
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (156 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E165 — Agachamento com mochila

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Mochila com peso
- Locais possíveis: Casa equipada
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (134 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E166 — Agachamento com garrafão

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Garrafão de água
- Locais possíveis: Casa equipada
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (150 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E167 — Agachamento sumo

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, adductors
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (10): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > adductors
- Objetivo (199 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E168 — Agachamento na máquina Smith

- Grupo: Pernas | Área: maquina
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (149 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E169 — Agachamento búlgaro

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: afundo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Banco / cadeira / apoio
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (169 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E170 — Agachamento búlgaro com apoio

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: afundo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Banco / cadeira / apoio
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (154 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E171 — Extensão de perna

- Grupo: Pernas | Área: maquina
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Estabilizadores do joelho e controlo da anca
- Equipamento: Máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (132 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E172 — Leg press

- Grupo: Pernas | Área: maquina
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Glúteos, posterior de coxa, adutores e gémeos
- Equipamento: Máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (168 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E173 — Step-up

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Banco / cadeira / apoio
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E174 — Wall sit

- Grupo: Pernas | Área: isometria
- Padrão de movimento: agachamento / joelho dominante
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (9): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (151 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E175 — Lunges

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: afundo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (10): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (153 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E176 — Lunges com halteres

- Grupo: Pernas | Área: halteres
- Padrão de movimento: afundo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (10): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (140 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E177 — Lunges com mochila

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: afundo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Mochila com peso
- Locais possíveis: Casa equipada
- Filtros onde aparece (10): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (144 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E178 — Walking lunges

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: afundo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Músculos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (10): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_lateralis | Musculação > legs > upper_leg_hip > vastus_medialis | Musculação > legs > upper_leg_hip > vastus_intermedius | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (147 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E179 — Peso morto tradicional

- Grupo: Pernas | Área: barra
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > hamstrings_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > semitendinosus | Musculação > legs > upper_leg_hip > semimembranosus | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (152 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E180 — Peso morto romeno com halteres

- Grupo: Pernas | Área: halteres
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > hamstrings_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > semitendinosus | Musculação > legs > upper_leg_hip > semimembranosus | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (86 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E181 — Curl de perna

- Grupo: Pernas | Área: maquina
- Padrão de movimento: flexão de joelho
- Nível estimado: intermédio
- Articulações principais: joelho
- Músculos (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Músculos secundários: Glúteos, gémeos e estabilizadores do joelho
- Equipamento: Máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > hamstrings_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > semitendinosus | Musculação > legs > upper_leg_hip > semimembranosus | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (112 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E182 — Good morning leve

- Grupo: Pernas | Área: barra
- Padrão de movimento: dobradiça de anca
- Nível estimado: iniciante
- Articulações principais: anca, joelho
- Músculos (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Barra
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > hamstrings_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > semitendinosus | Musculação > legs > upper_leg_hip > semimembranosus | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (168 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E183 — Good morning sem carga

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (8): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > hamstrings_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > semitendinosus | Musculação > legs > upper_leg_hip > semimembranosus | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (205 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E184 — Ponte de glúteo

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): glute_max, glute_med, biceps_femoris
- Músculos secundários: Posterior de coxa, lombar leve, core e adutores
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > glutes_complete | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (182 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E185 — Hip thrust

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): glute_max, glute_med, biceps_femoris
- Músculos secundários: Posterior de coxa, lombar leve, core e adutores
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > glutes_complete | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (177 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E186 — Hip thrust com apoio

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: dobradiça de anca
- Nível estimado: iniciante
- Articulações principais: anca, joelho
- Músculos (tags): glute_max, glute_med, biceps_femoris
- Músculos secundários: Posterior de coxa, lombar leve, core e adutores
- Equipamento: Peso corporal
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (7): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > glutes_complete | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (187 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E187 — Abdução de anca

- Grupo: Pernas | Área: maquina
- Padrão de movimento: abdução de anca/ombro
- Nível estimado: intermédio
- Articulações principais: anca
- Músculos (tags): abductors, glute_med, glute_min
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > glute_med | Musculação > legs > upper_leg_hip > glute_min | Musculação > legs > upper_leg_hip > abductors
- Objetivo (130 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E188 — Adução de anca

- Grupo: Pernas | Área: maquina
- Padrão de movimento: adução de anca
- Nível estimado: intermédio
- Articulações principais: anca
- Músculos (tags): adductors
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Máquina
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (4): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > adductors
- Objetivo (126 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E189 — Kickback de glúteo

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): glute_max, glute_med, biceps_femoris
- Músculos secundários: Posterior de coxa, lombar leve, core e adutores
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > glutes_complete | Musculação > legs > upper_leg_hip > glute_max | Musculação > legs > upper_leg_hip > glute_med
- Objetivo (172 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E190 — Gémeos em pé

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: flexão plantar/dorsal
- Nível estimado: intermédio
- Articulações principais: tornozelo
- Músculos (tags): calves, ankle
- Músculos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > calves | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (81 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E191 — Gémeos sentado

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: flexão plantar/dorsal
- Nível estimado: intermédio
- Articulações principais: tornozelo
- Músculos (tags): calves, soleus, ankle
- Músculos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Equipamento: Banco / cadeira / apoio
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (7): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > calves | Musculação > legs > lower_leg_foot > soleus | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (129 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E192 — Elevação de gémeos unilateral

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: flexão plantar/dorsal
- Nível estimado: intermédio
- Articulações principais: tornozelo
- Músculos (tags): calves, ankle
- Músculos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > calves | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (139 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E193 — Sóleo sentado

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: flexão plantar/dorsal
- Nível estimado: intermédio
- Articulações principais: tornozelo
- Músculos (tags): soleus, calves, ankle
- Músculos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Equipamento: Banco / cadeira / apoio
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (7): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > calves | Musculação > legs > lower_leg_foot > soleus | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (115 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E194 — Saltos leves

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: avançado
- Articulações principais: várias
- Músculos (tags): calves, soleus, ankle, ankle_stability
- Músculos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > calves | Musculação > legs > lower_leg_foot > soleus | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (109 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E195 — Elevação tibial

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: flexão plantar/dorsal
- Nível estimado: intermédio
- Articulações principais: tornozelo
- Músculos (tags): tibialis_anterior, ankle, feet
- Músculos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (7): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > tibialis_anterior | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > feet | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (100 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E196 — Short foot / doming

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): feet, ankle
- Músculos secundários: Arco plantar, dedos, tornozelo, tibial posterior e equilíbrio
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > feet | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (162 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E197 — Flexão ativa dos dedos do pé

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: pega / punho
- Nível estimado: intermédio
- Articulações principais: punho, dedos
- Músculos (tags): feet, ankle
- Músculos secundários: Arco plantar, dedos, tornozelo, tibial posterior e equilíbrio
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > feet | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (196 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E198 — Dorsiflexão do tornozelo com elástico

- Grupo: Pernas | Área: elastico
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): tibialis_anterior, ankle, feet
- Músculos secundários: Tornozelo, músculos do pé, perónio/fibulares, tibial posterior e equilíbrio
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (7): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > tibialis_anterior | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > feet | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (166 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E199 — Inversão do tornozelo com elástico

- Grupo: Pernas | Área: elastico
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): ankle, feet, ankle_stability
- Músculos secundários: Tornozelo, músculos do pé, perónio/fibulares, tibial posterior e equilíbrio
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > feet | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (171 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E200 — Eversão do tornozelo com elástico

- Grupo: Pernas | Área: elastico
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): ankle, feet, ankle_stability
- Músculos secundários: Tornozelo, músculos do pé, perónio/fibulares, tibial posterior e equilíbrio
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > lower_leg_foot | Musculação > legs > lower_leg_foot > lower_leg_complete | Musculação > legs > lower_leg_foot > ankle | Musculação > legs > lower_leg_foot > feet | Musculação > legs > lower_leg_foot > ankle_stability
- Objetivo (173 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E201 — Flexão da anca em pé com elástico

- Grupo: Pernas | Área: elastico
- Padrão de movimento: empurrar horizontal
- Nível estimado: intermédio
- Articulações principais: ombro, cotovelo, escápula
- Músculos (tags): hip_flexors, rectus_femoris
- Músculos secundários: Reto femoral, core, glúteo médio da perna de apoio e equilíbrio
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > glutes_complete | Musculação > legs > upper_leg_hip > hip_flexors
- Objetivo (154 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E202 — Copenhagen plank com apoio

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: iniciante
- Articulações principais: várias
- Músculos (tags): adductors, anti_lateral_flexion, deep_stability
- Músculos secundários: Adutores, oblíquos, glúteo médio, ombro de apoio e core
- Equipamento: Banco / cadeira / apoio estável
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (11): Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_lateral_flexion | Musculação > core > core_stability_zone > deep_stability | Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > adductors
- Objetivo (169 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E203 — Extensão terminal do joelho com elástico

- Grupo: Pernas | Área: elastico
- Padrão de movimento: extensão de cotovelo
- Nível estimado: intermédio
- Articulações principais: cotovelo
- Músculos (tags): vastus_medialis, rectus_femoris
- Músculos secundários: Quadríceps, vasto medial, glúteos e estabilidade do joelho
- Equipamento: Elásticos
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > quadriceps_complete | Musculação > legs > upper_leg_hip > rectus_femoris | Musculação > legs > upper_leg_hip > vastus_medialis
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E204 — Abdução de anca deitada

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: abdução de anca/ombro
- Nível estimado: intermédio
- Articulações principais: anca
- Músculos (tags): abductors, glute_med, glute_min
- Músculos secundários: Glúteo médio, glúteo mínimo, abdutores da anca e core lateral
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > glute_med | Musculação > legs > upper_leg_hip > glute_min | Musculação > legs > upper_leg_hip > abductors
- Objetivo (163 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E205 — Clamshell

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: outro / técnico
- Nível estimado: intermédio
- Articulações principais: várias
- Músculos (tags): abductors, glute_med, glute_min, hip_external_rotators
- Músculos secundários: Glúteo médio, glúteo mínimo, rotadores externos da anca e core lateral
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > glute_med | Musculação > legs > upper_leg_hip > glute_min | Musculação > legs > upper_leg_hip > abductors
- Objetivo (140 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E206 — Curl nórdico assistido

- Grupo: Pernas | Área: peso_corporal
- Padrão de movimento: flexão de joelho
- Nível estimado: avançado
- Articulações principais: joelho
- Músculos (tags): biceps_femoris, semitendinosus, semimembranosus
- Músculos secundários: Isquiotibiais, gémeos, glúteos e core
- Equipamento: Peso corporal, apoio para os pés
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (7): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > hamstrings_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > semitendinosus | Musculação > legs > upper_leg_hip > semimembranosus
- Objetivo (214 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E207 — Peso morto unilateral com halteres

- Grupo: Pernas | Área: halteres
- Padrão de movimento: dobradiça de anca
- Nível estimado: intermédio
- Articulações principais: anca, joelho
- Músculos (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Músculos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Equipamento: Halteres
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (8): Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > hamstrings_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > semitendinosus | Musculação > legs > upper_leg_hip > semimembranosus | Musculação > legs > upper_leg_hip > glute_max
- Objetivo (173 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E208 — Marcha no lugar

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (136 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E209 — Jumping jacks

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio de coordenação
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (135 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E210 — Burpees

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio intervalado
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (162 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E211 — Skaters

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (125 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E212 — High knees

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (131 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E213 — Circuito cardio peso corporal

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (145 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E214 — Passadeira caminhada

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (145 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E215 — Passadeira caminhada rápida

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (143 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E216 — Passadeira corrida leve

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (120 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E217 — Passadeira corrida intervalada

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (140 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E218 — Passadeira inclinação

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (144 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E219 — Passadeira inclinação moderada

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (141 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E220 — Passadeira sprints

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio intervalado
- Nível estimado: avançado
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (140 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E221 — Passadeira sprints intervalados

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio intervalado
- Nível estimado: avançado
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (134 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E222 — Passadeira aquecimento

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (149 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E223 — Passadeira cooldown

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (148 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E224 — Bicicleta ritmo leve

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Bicicleta
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (109 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E225 — Bicicleta ritmo moderado

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Bicicleta
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (117 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E226 — Bicicleta intervalos

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Bicicleta
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (120 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E227 — Bicicleta resistência

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Bicicleta
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (87 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E228 — Bicicleta aquecimento

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Bicicleta
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (131 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E229 — Bicicleta cooldown

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Bicicleta
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (121 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E230 — Elíptica ritmo leve

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Elíptica
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > elliptical | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (142 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E231 — Elíptica ritmo moderado

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Elíptica
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > elliptical | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E232 — Elíptica intervalos

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Elíptica
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > elliptical | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (140 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E233 — Elíptica resistência

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Elíptica
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > elliptical | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (88 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E234 — Elíptica aquecimento

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Elíptica
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > elliptical | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (148 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E235 — Elíptica cooldown

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Elíptica
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > elliptical | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (140 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E236 — Corda de saltar ritmo leve

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio de coordenação
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Corda de saltar
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > jump_rope | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (123 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E237 — Corda de saltar intervalos

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio de coordenação
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Corda de saltar
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > jump_rope | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (138 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E238 — Corda de saltar pés alternados

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio de coordenação
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Corda de saltar
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > jump_rope | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (136 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E239 — Corda de saltar joelhos altos

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio de coordenação
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Corda de saltar
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > jump_rope | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E240 — Corda de saltar double unders

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio de coordenação
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Corda de saltar
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > jump_rope | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (143 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E241 — Caminhada exterior leve

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Espaço exterior
- Locais possíveis: Casa equipada | Exterior / parque
- Filtros onde aparece (3): Cardio > outdoor_walk | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (140 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E242 — Caminhada exterior moderada

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Espaço exterior
- Locais possíveis: Casa equipada | Exterior / parque
- Filtros onde aparece (3): Cardio > outdoor_walk | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (150 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E243 — Caminhada exterior rápida

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Espaço exterior
- Locais possíveis: Casa equipada | Exterior / parque
- Filtros onde aparece (3): Cardio > outdoor_walk | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (134 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E244 — Caminhada exterior em subida

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Espaço exterior
- Locais possíveis: Casa equipada | Exterior / parque
- Filtros onde aparece (3): Cardio > outdoor_walk | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (135 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E245 — Corrida exterior leve

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Espaço exterior
- Locais possíveis: Casa equipada | Exterior / parque
- Filtros onde aparece (3): Cardio > outdoor_run | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (136 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E246 — Corrida exterior moderada

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Espaço exterior
- Locais possíveis: Casa equipada | Exterior / parque
- Filtros onde aparece (3): Cardio > outdoor_run | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (149 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E247 — Corrida exterior intervalada

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Espaço exterior
- Locais possíveis: Casa equipada | Exterior / parque
- Filtros onde aparece (3): Cardio > outdoor_run | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (142 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E248 — Sprints exterior

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio intervalado
- Nível estimado: avançado
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Espaço exterior
- Locais possíveis: Casa equipada | Exterior / parque
- Filtros onde aparece (2): Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (131 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E249 — Corrida em subida

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Espaço exterior
- Locais possíveis: Casa equipada | Exterior / parque
- Filtros onde aparece (2): Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (141 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E250 — HIIT peso corporal

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio intervalado
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (141 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E251 — HIIT cardio

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio intervalado
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (138 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E252 — HIIT passadeira

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio intervalado
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Passadeira
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > treadmill | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (148 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E253 — HIIT bicicleta

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio intervalado
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Bicicleta
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (152 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E254 — HIIT corda

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio intervalado
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Corda de saltar
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > jump_rope | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (143 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E255 — HIIT simples

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio intervalado
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (151 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E256 — Circuito cardio leve

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E257 — Remo ergómetro ritmo contínuo

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Pernas, costas, braços e core em sequência
- Equipamento: Remo ergómetro
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > rower | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (219 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E258 — Remo ergómetro intervalos

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Pernas, costas, braços e core em sequência
- Equipamento: Remo ergómetro
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > rower | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (183 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E259 — Stepper / escadas ritmo contínuo

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Glúteos, quadríceps, gémeos e fôlego
- Equipamento: Stepper / escadas
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > stairs | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (168 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E260 — Stepper / escadas intervalos

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Glúteos, quadríceps, gémeos e fôlego
- Equipamento: Stepper / escadas
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > stairs | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (179 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E261 — Subida de escadas no exterior

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Espaço exterior com escadas
- Locais possíveis: Casa equipada | Exterior / parque
- Filtros onde aparece (3): Cardio > outdoor_run | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (172 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E262 — Air bike ritmo contínuo

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Pernas, braços, ombros e fôlego
- Equipamento: Air bike
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > air_bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (183 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E263 — Air bike intervalos

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Pernas, braços, ombros e fôlego
- Equipamento: Air bike
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Cardio > air_bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (157 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E264 — Shadow boxing leve

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio de coordenação
- Nível estimado: iniciante
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (166 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E265 — Shuttle runs / corrida vaivém

- Grupo: Cardio | Área: cardio
- Padrão de movimento: cardio contínuo
- Nível estimado: intermédio
- Articulações principais: anca, joelho, tornozelo
- Músculos (tags): 
- Músculos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Equipamento: Peso corporal, espaço livre
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- Objetivo (168 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E266 — Kihon

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > kihon
- Objetivo (116 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E267 — Kata

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > kata
- Objetivo (113 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E268 — Kumite técnico

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > kumite_technical
- Objetivo (126 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E269 — Sombra de Karate

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_shadow
- Objetivo (119 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E270 — Drills de deslocamento

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_footwork
- Objetivo (144 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E271 — Drills de guarda

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_guard
- Objetivo (195 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E272 — Pontapés técnicos

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_kicks
- Objetivo (126 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E273 — Socos técnicos

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_punches
- Objetivo (122 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E274 — Mobilidade de anca para Karate

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: iniciante
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_mobility
- Objetivo (134 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E275 — Mobilidade de ombro para Karate

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: iniciante
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_mobility
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E276 — Condicionamento leve para Karate

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: iniciante
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_conditioning
- Objetivo (147 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E277 — Treino de bases (dachi)

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_stances
- Objetivo (181 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E278 — Bloqueios técnicos (uke)

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_blocks
- Objetivo (185 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E279 — Esquivas e tai-sabaki

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_evasions
- Objetivo (170 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E280 — Joelhadas técnicas

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_knees
- Objetivo (182 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E281 — Trabalho leve ao saco

- Grupo: Karate | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: iniciante
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): karate_technical
- Músculos secundários: Base, anca, core, ombros, guarda e coordenação
- Equipamento: Saco de pancada
- Locais possíveis: Casa equipada
- Filtros onde aparece (2): Artes marciais > karate > karate_complete | Artes marciais > karate > karate_bag
- Objetivo (174 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E282 — Shrimp / fuga de anca

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Tatami ou tapete / colchonete
- Locais possíveis: Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > shrimp
- Objetivo (129 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E283 — Ponte de grappling

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Tatami ou tapete / colchonete
- Locais possíveis: Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > grappling_bridge
- Objetivo (132 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E284 — Technical stand-up

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Tatami ou tapete / colchonete
- Locais possíveis: Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > technical_stand_up
- Objetivo (137 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E285 — Sprawl

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Tatami ou tapete / colchonete
- Locais possíveis: Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_conditioning
- Objetivo (177 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E286 — Drills de guarda

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Tatami ou tapete / colchonete
- Locais possíveis: Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_guard
- Objetivo (175 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E287 — Drills de passagem de guarda

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Tatami ou tapete / colchonete
- Locais possíveis: Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_guard | Artes marciais > jiu_jitsu > guard_passing
- Objetivo (151 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E288 — Mobilidade de anca para Jiu-Jitsu

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: iniciante
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_mobility
- Objetivo (141 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E289 — Mobilidade de ombro para Jiu-Jitsu

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: iniciante
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_mobility
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E290 — Força de pega para Jiu-Jitsu

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_grip
- Objetivo (139 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E291 — Core para Jiu-Jitsu

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_core
- Objetivo (143 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E292 — Condicionamento leve para Jiu-Jitsu

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: iniciante
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_conditioning
- Objetivo (154 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E293 — Rolamentos de solo

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Tatami ou tapete / colchonete
- Locais possíveis: Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_rolls
- Objetivo (192 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E294 — Breakfalls (ukemi)

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: intermédio
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Tatami ou tapete / colchonete
- Locais possíveis: Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_breakfalls
- Objetivo (191 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E295 — Inversão granby com apoio

- Grupo: Jiu-Jitsu | Área: artes_marciais
- Padrão de movimento: técnica marcial
- Nível estimado: iniciante
- Articulações principais: anca, joelho, ombro, coluna
- Músculos (tags): jiu_jitsu_technical
- Músculos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Equipamento: Tatami ou tapete / colchonete
- Locais possíveis: Casa equipada | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_inversions
- Objetivo (201 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E296 — Mobilidade torácica

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > thoracic_mobility | Recuperação > light_mobility
- Objetivo (135 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E297 — Mobilidade de ombro

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > shoulder_mobility | Recuperação > light_mobility
- Objetivo (158 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E298 — Mobilidade de anca

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > hip_mobility | Recuperação > light_mobility
- Objetivo (137 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E299 — Círculos de ombro

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > shoulder_mobility | Recuperação > light_mobility
- Objetivo (149 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E300 — Alongamento posterior do ombro

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (5): Mobilidade > general_mobility | Mobilidade > shoulder_mobility | Mobilidade > hamstring_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (145 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E301 — Mobilidade de ombro com toalha

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > shoulder_mobility | Recuperação > light_mobility
- Objetivo (119 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E302 — Mobilidade de ombro com cabo de vassoura

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Cabo de vassoura
- Locais possíveis: Casa equipada | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > shoulder_mobility | Recuperação > light_mobility
- Objetivo (106 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E303 — Alongamento peitoral

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > chest_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (136 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E304 — Alongamento peitoral na parede

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > chest_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (138 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E305 — Alongamento peitoral no canto

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > chest_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (133 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E306 — Alongamento dorsal

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > back_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (131 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E307 — Rotação torácica no chão

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > thoracic_mobility | Recuperação > light_mobility
- Objetivo (156 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E308 — Cat-cow

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > thoracic_mobility | Recuperação > light_mobility
- Objetivo (150 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E309 — Open book

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > thoracic_mobility | Recuperação > light_mobility
- Objetivo (154 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E310 — Alongamento posterior de coxa

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > hamstring_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (128 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E311 — Alongamento posterior sentado

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > hamstring_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (142 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E312 — Alongamento posterior em pé

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > hamstring_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (137 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E313 — Tocar nos pés sentado

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Mobilidade > general_mobility | Recuperação > light_mobility
- Objetivo (142 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E314 — Tocar nos pés em pé

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (2): Mobilidade > general_mobility | Recuperação > light_mobility
- Objetivo (147 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E315 — Alongamento posterior com perna elevada

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > hamstring_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (147 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E316 — Mobilidade dinâmica de posterior

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > hamstring_mobility | Recuperação > light_mobility
- Objetivo (147 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E317 — Alongamento glúteos

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: anca, piriforme, rotadores externos da anca e lombar
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > glute_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (152 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E318 — Alongamento de glúteo sentado

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: anca, piriforme, rotadores externos da anca e lombar
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > glute_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (154 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E319 — Alongamento figura 4

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: anca, piriforme, rotadores externos da anca e lombar
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > glute_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (147 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E320 — Pigeon stretch

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: anca, piriforme, rotadores externos da anca e lombar
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > glute_mobility | Recuperação > light_mobility
- Objetivo (132 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E321 — Alongamento piriforme

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: anca, piriforme, rotadores externos da anca e lombar
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > glute_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (150 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E322 — Rotação externa da anca no chão

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > hip_mobility | Recuperação > light_mobility
- Objetivo (158 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E323 — Mobilidade 90/90

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: anca, piriforme, rotadores externos da anca e lombar
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > hip_mobility | Mobilidade > glute_mobility | Recuperação > light_mobility
- Objetivo (130 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E324 — Mobilidade dinâmica de anca

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > hip_mobility | Recuperação > light_mobility
- Objetivo (141 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E325 — Alongamento quadríceps em pé

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > quadriceps_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (154 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E326 — Alongamento quadríceps de lado

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > quadriceps_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (146 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E327 — Alongamento gémeos

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > calf_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (139 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E328 — Alongamento gémeos na parede

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > calf_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (115 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E329 — Mobilidade de tornozelo na parede

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: gémeos, sóleo, pé e equilíbrio
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > ankle_mobility | Recuperação > light_mobility
- Objetivo (147 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E330 — Círculos de tornozelo

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: gémeos, sóleo, pé e equilíbrio
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > ankle_mobility | Recuperação > light_mobility
- Objetivo (141 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E331 — Mobilidade de punhos

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: antebraço, dedos e cotovelo
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > wrist_mobility | Recuperação > light_mobility
- Objetivo (149 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E332 — Extensão de punhos no chão

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: antebraço, dedos e cotovelo
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > wrist_mobility | Recuperação > light_mobility
- Objetivo (144 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E333 — Flexão de punhos no chão

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (3): Mobilidade > general_mobility | Mobilidade > wrist_mobility | Recuperação > light_mobility
- Objetivo (118 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E334 — Alongamento cervical leve

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: trapézio superior, estabilizadores cervicais e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > neck_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (142 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E335 — Mobilidade leve de ombros

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > shoulder_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (132 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E336 — Mobilidade leve de anca

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > hip_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (142 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E337 — Respiração diafragmática

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: respiração / recuperação
- Nível estimado: iniciante
- Articulações principais: costelas / diafragma
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Mobilidade > general_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > light_stretching | Recuperação > breathing | Recuperação > active_recovery
- Objetivo (131 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E338 — Caminhada leve

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (5): Mobilidade > general_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > breathing | Recuperação > active_recovery
- Objetivo (113 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E339 — Relaxamento deitado

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (5): Mobilidade > general_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > breathing | Recuperação > active_recovery
- Objetivo (131 chars) ✓ | Execução (7 passos) ✓ | Erros comuns (5) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E340 — Alongamento PNF de isquiotibiais

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > hamstring_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (192 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E341 — Alongamento PNF de peitoral na parede

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > chest_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (169 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E342 — Alongamento de flexores da anca em afundo

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (5): Mobilidade > general_mobility | Mobilidade > hip_mobility | Mobilidade > quadriceps_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (156 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E343 — Alongamento borboleta de adutores

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > hip_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (164 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E344 — Alongamento dinâmico global

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (6): Mobilidade > general_mobility | Mobilidade > thoracic_mobility | Mobilidade > hip_mobility | Mobilidade > hamstring_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (187 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E345 — Alongamento de tríceps atrás da cabeça

- Grupo: Mobilidade | Área: alongamento
- Padrão de movimento: alongamento estático
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: Ombros e peito como apoio, com estabilização do tronco
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > shoulder_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- Objetivo (121 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E346 — Cobra suave no chão

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > back_mobility | Mobilidade > thoracic_mobility | Recuperação > light_mobility
- Objetivo (172 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E347 — Respiração nasal lenta

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: respiração / recuperação
- Nível estimado: iniciante
- Articulações principais: costelas / diafragma
- Músculos (tags): 
- Músculos secundários: Diafragma, músculos respiratórios e sistema nervoso calmo
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (5): Mobilidade > general_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > breathing | Recuperação > active_recovery
- Objetivo (173 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E348 — Foam roller para pernas

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: Quadríceps, parte de trás das coxas e gémeos
- Equipamento: Rolo de espuma (foam roller)
- Locais possíveis: Casa equipada
- Filtros onde aparece (7): Mobilidade > general_mobility | Mobilidade > hamstring_mobility | Mobilidade > quadriceps_mobility | Mobilidade > calf_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > active_recovery
- Objetivo (181 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E349 — Foam roller para costas

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: Coluna torácica e músculos das costas
- Equipamento: Rolo de espuma (foam roller)
- Locais possíveis: Casa equipada
- Filtros onde aparece (5): Mobilidade > general_mobility | Mobilidade > back_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > active_recovery
- Objetivo (190 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E350 — Bola de massagem para pés e glúteos

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: Planta do pé, glúteos e mobilidade geral
- Equipamento: Bola de massagem
- Locais possíveis: Casa equipada
- Filtros onde aparece (5): Mobilidade > general_mobility | Mobilidade > glute_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > active_recovery
- Objetivo (163 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E351 — Arrefecimento pós-treino de força

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > active_recovery
- Objetivo (169 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E352 — Arrefecimento pós-artes marciais

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > active_recovery
- Objetivo (172 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

### E353 — Aquecimento dinâmico geral

- Grupo: Mobilidade | Área: mobilidade
- Padrão de movimento: mobilidade dinâmica
- Nível estimado: iniciante
- Articulações principais: articulação alvo do alongamento
- Músculos (tags): 
- Músculos secundários: respiração, postura, controlo articular e consciência corporal
- Equipamento: Peso corporal
- Locais possíveis: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- Filtros onde aparece (4): Mobilidade > general_mobility | Mobilidade > shoulder_mobility | Mobilidade > hip_mobility | Recuperação > light_mobility
- Objetivo (184 chars) ✓ | Execução (6 passos) ✓ | Erros comuns (4) ✓ | Regressão/Progressão ✓ | Respiração ✓ | Postura ✓

