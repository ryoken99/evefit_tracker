part of 'canonical_arm_exercises_registry.g.dart';

const generatedCanonicalArmExercises = <CanonicalArmExercise>[
  CanonicalArmExercise(
    id: "bench_dip",
    namePtPt: "Fundos no banco",
    nameEn: "Bench dip",
    familyId: "elbow_extension_compound",
    state: CanonicalArmPublicationState.approvedWithLimits,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Extensão do cotovelo com as mãos apoiadas atrás do tronco; opção pública com limites pela extensão do ombro.",
    technicalDescriptionPtPt:
        "Apoio posterior que combina extensão do cotovelo com extensão do ombro. A amplitude deve ser conservadora.",
    requiredEquipmentIds: <String>["bodyweight", "flat_bench"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Fixar o banco.",
      "Apoiar os pés de forma segura.",
      "Escolher amplitude conservadora.",
    ],
    startPositionPtPt:
        "Apoiar as mãos na borda de um banco estável, com o tronco próximo do apoio e cotovelos estendidos.",
    movementPtPt:
        "Descer através de flexão do cotovelo mantendo o ombro confortável; regressar estendendo o cotovelo.",
    endPositionPtPt:
        "Parar a descida antes de desconforto anterior no ombro ou perda de alinhamento.",
    trajectoryPtPt: "O tronco desloca-se verticalmente junto ao banco.",
    cuesPtPt: <String>[
      "Manter o tronco perto do banco.",
      "Usar amplitude curta e confortável.",
      "Apontar os cotovelos para trás.",
    ],
    commonErrorsPtPt: <String>[
      "Descer demasiado.",
      "Afastar o tronco do banco.",
      "Usar apoio instável.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Rever por especialista perante instabilidade, dor anterior do ombro, pós-lesão ou pós-cirurgia.",
    jointIds: <String>["elbow_joint", "glenohumeral_joint"],
    actionIds: <String>[
      "elbow_extension",
      "shoulder_extension",
      "shoulder_flexion",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_mckenzie_dips_2022",
      "src_vigotsky_semg_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "cable_triceps_pushdown",
    namePtPt: "Extensão de tríceps na polia",
    nameEn: "Cable triceps pushdown",
    familyId: "elbow_extension_local",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Extensão controlada do cotovelo contra resistência, sem prometer isolamento das cabeças do tricípite.",
    technicalDescriptionPtPt:
        "Exercício com o ombro neutro, com o braço junto ao tronco e resistência ao longo do cabo a partir de uma polia alta. A posição do ombro altera o comprimento da cabeça longa e pode mudar a contribuição relativa das cabeças.",
    requiredEquipmentIds: <String>[
      "cable_stack",
      "high_pulley",
      "straight_bar_attachment",
    ],
    optionalEquipmentIds: <String>["rope_attachment", "single_handle"],
    alternativeEquipmentIds: <String>["elastic_band"],
    setupPtPt: <String>[
      "Ajustar carga e apoio.",
      "Escolher uma pega confortável.",
      "Confirmar liberdade de movimento do cotovelo.",
    ],
    startPositionPtPt:
        "Começar com o cotovelo fletido, braço organizado e punho estável.",
    movementPtPt:
        "Estender o cotovelo contra a resistência e regressar sob controlo.",
    endPositionPtPt:
        "Terminar próximo da extensão confortável, sem bloquear agressivamente nem deslocar o ombro.",
    trajectoryPtPt:
        "A mão afasta-se do ombro em torno do cotovelo, alinhada com a resistência.",
    cuesPtPt: <String>[
      "Fixar a posição do braço.",
      "Manter o punho neutro.",
      "Controlar o regresso.",
    ],
    commonErrorsPtPt: <String>[
      "Abrir ou fechar excessivamente os cotovelos.",
      "Usar balanço do tronco.",
      "Perder o alinhamento do punho.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_extension"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_kholinne_triceps_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "close_grip_bench_press",
    namePtPt: "Supino com pega fechada",
    nameEn: "Close-grip bench press",
    familyId: "elbow_extension_compound",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Supino multiarticular com pega relativamente estreita, no qual a extensão do cotovelo tem papel relevante.",
    technicalDescriptionPtPt:
        "A largura de pega altera momentos e carga tolerada. Continua a ser um exercício de empurrar multiarticular.",
    requiredEquipmentIds: <String>["straight_barbell", "flat_bench"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar suportes.",
      "Usar banco estável.",
      "Definir pega que mantenha punhos sobre antebraços.",
    ],
    startPositionPtPt:
        "Deitado no banco, pés estáveis, barra segura com pega ligeiramente mais estreita do que a habitual.",
    movementPtPt:
        "Descer a barra ao tronco com controlo e empurrar por extensão do cotovelo e adução horizontal do ombro.",
    endPositionPtPt:
        "Aproximar do tronco sem perder posição do ombro; subir até extensão controlada.",
    trajectoryPtPt: "Barra desce e sobe numa trajetória controlada.",
    cuesPtPt: <String>[
      "Manter antebraços alinhados.",
      "Controlar a descida.",
      "Usar observador ou suportes de segurança.",
    ],
    commonErrorsPtPt: <String>[
      "Pega estreita ao ponto de colapsar o punho.",
      "Cotovelos sem controlo.",
      "Treinar sem suportes adequados.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "elbow_joint",
      "glenohumeral_joint",
      "scapulothoracic_articulation",
      "radiocarpal_joint",
    ],
    actionIds: <String>["elbow_extension", "shoulder_horizontal_adduction"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_saeterbakken_bench_2021",
      "src_vigotsky_semg_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "close_grip_push_up",
    namePtPt: "Flexão de braços com mãos próximas",
    nameEn: "Close-grip push-up",
    familyId: "elbow_extension_compound",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Flexão de braços multiarticular com mãos próximas, aumentando a exigência contextual de extensão do cotovelo.",
    technicalDescriptionPtPt:
        "Cadeia fechada com extensão do cotovelo e adução horizontal do ombro; não é isolamento de tríceps.",
    requiredEquipmentIds: <String>["bodyweight"],
    optionalEquipmentIds: <String>["dumbbell"],
    alternativeEquipmentIds: <String>["parallel_bars"],
    setupPtPt: <String>[
      "Escolher largura confortável.",
      "Usar superfície firme.",
      "Ajustar apoio dos joelhos ou altura se necessário.",
    ],
    startPositionPtPt:
        "Em prancha, mãos abaixo ou ligeiramente dentro da largura dos ombros, corpo alinhado.",
    movementPtPt:
        "Descer o corpo com controlo e empurrar o solo até regressar à prancha.",
    endPositionPtPt:
        "Terminar a descida antes de perder alinhamento; subir sem bloquear agressivamente os cotovelos.",
    trajectoryPtPt:
        "O tronco aproxima-se e afasta-se do solo como uma unidade.",
    cuesPtPt: <String>[
      "Manter corpo alinhado.",
      "Cotovelos orientados para trás.",
      "Empurrar o chão de forma uniforme.",
    ],
    commonErrorsPtPt: <String>[
      "Abrir excessivamente os cotovelos.",
      "Deixar a anca cair.",
      "Forçar uma posição estreita dolorosa.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "elbow_joint",
      "glenohumeral_joint",
      "scapulothoracic_articulation",
      "radiocarpal_joint",
    ],
    actionIds: <String>[
      "elbow_extension",
      "shoulder_horizontal_adduction",
      "scapular_protraction",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_cogley_pushup_2005",
      "src_vigotsky_semg_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "cross_body_cable_triceps_extension",
    namePtPt: "Extensão cruzada de tríceps no cabo",
    nameEn: "Cross-body cable triceps extension",
    familyId: "elbow_extension_local",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Extensão controlada do cotovelo contra resistência, sem prometer isolamento das cabeças do tricípite.",
    technicalDescriptionPtPt:
        "Exercício com o ombro à frente do corpo, com ligeira adução horizontal contextual e resistência oblíqua ao longo do cabo. A posição do ombro altera o comprimento da cabeça longa e pode mudar a contribuição relativa das cabeças.",
    requiredEquipmentIds: <String>[
      "cable_stack",
      "adjustable_pulley",
      "single_handle",
    ],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar carga e apoio.",
      "Escolher uma pega confortável.",
      "Confirmar liberdade de movimento do cotovelo.",
    ],
    startPositionPtPt:
        "Começar com o cotovelo fletido, braço organizado e punho estável.",
    movementPtPt:
        "Estender o cotovelo contra a resistência e regressar sob controlo.",
    endPositionPtPt:
        "Terminar próximo da extensão confortável, sem bloquear agressivamente nem deslocar o ombro.",
    trajectoryPtPt:
        "A mão afasta-se do ombro em torno do cotovelo, alinhada com a resistência.",
    cuesPtPt: <String>[
      "Fixar a posição do braço.",
      "Manter o punho neutro.",
      "Controlar o regresso.",
    ],
    commonErrorsPtPt: <String>[
      "Abrir ou fechar excessivamente os cotovelos.",
      "Usar balanço do tronco.",
      "Perder o alinhamento do punho.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_extension"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_kholinne_triceps_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "dead_hang",
    namePtPt: "Suspensão passiva controlada na barra",
    nameEn: "Dead hang",
    familyId: "suspension_support",
    state: CanonicalArmPublicationState.approvedWithLimits,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Suspender o peso corporal numa barra fixa mantendo a pega segura.",
    technicalDescriptionPtPt:
        "Tarefa de preensão ou suporte cuja limitação pode resultar da força digital, posição do punho, contacto, fricção, tolerância da pele e estabilidade proximal. Não identifica um músculo isolado.",
    requiredEquipmentIds: <String>["bodyweight", "pull_up_bar"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Verificar o estado do implemento.",
      "Remover obstáculos.",
      "Escolher carga e duração controláveis.",
    ],
    startPositionPtPt:
        "Organizar mão e punho em torno do implemento ou apoio, com contacto seguro.",
    movementPtPt:
        "Assumir suspensão controlada e manter o contacto; sair através de apoio seguro, sem largar em queda.",
    endPositionPtPt:
        "Terminar antes de perder o contacto, a posição do punho ou o controlo do corpo.",
    trajectoryPtPt:
        "Predominantemente isométrica na mão; quando existe transporte, o corpo desloca-se mantendo a preensão.",
    cuesPtPt: <String>[
      "Envolver o implemento com controlo.",
      "Manter o punho próximo de neutro.",
      "Terminar antes da abertura involuntária da mão.",
    ],
    commonErrorsPtPt: <String>[
      "Continuar depois de a pega começar a escapar.",
      "Compensar com flexão excessiva do punho.",
      "Usar superfície ou carga sem margem de segurança.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "glenohumeral_joint",
      "scapulothoracic_articulation",
      "elbow_joint",
      "radiocarpal_joint",
      "finger_metacarpophalangeal_joints",
      "finger_proximal_interphalangeal_joints",
      "finger_distal_interphalangeal_joints",
    ],
    actionIds: <String>[
      "finger_mcp_flexion",
      "finger_pip_flexion",
      "finger_dip_flexion",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_exel_finger_hang_2023",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "farmers_carry",
    namePtPt: "Passeio do agricultor",
    nameEn: "Farmer's carry",
    familyId: "loaded_carry",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Transportar cargas nas duas mãos mantendo preensão, postura e marcha controladas.",
    technicalDescriptionPtPt:
        "Tarefa de preensão ou suporte cuja limitação pode resultar da força digital, posição do punho, contacto, fricção, tolerância da pele e estabilidade proximal. Não identifica um músculo isolado.",
    requiredEquipmentIds: <String>["dumbbell"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Verificar o estado do implemento.",
      "Remover obstáculos.",
      "Escolher carga e duração controláveis.",
    ],
    startPositionPtPt:
        "Organizar mão e punho em torno do implemento ou apoio, com contacto seguro.",
    movementPtPt:
        "Elevar as cargas, caminhar em linha controlada e pousá-las sem perder a preensão.",
    endPositionPtPt:
        "Terminar antes de perder o contacto, a posição do punho ou o controlo do corpo.",
    trajectoryPtPt:
        "Predominantemente isométrica na mão; quando existe transporte, o corpo desloca-se mantendo a preensão.",
    cuesPtPt: <String>[
      "Envolver o implemento com controlo.",
      "Manter o punho próximo de neutro.",
      "Terminar antes da abertura involuntária da mão.",
    ],
    commonErrorsPtPt: <String>[
      "Continuar depois de a pega começar a escapar.",
      "Compensar com flexão excessiva do punho.",
      "Usar superfície ou carga sem margem de segurança.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "finger_metacarpophalangeal_joints",
      "finger_proximal_interphalangeal_joints",
      "finger_distal_interphalangeal_joints",
      "radiocarpal_joint",
    ],
    actionIds: <String>[
      "finger_mcp_flexion",
      "finger_pip_flexion",
      "finger_dip_flexion",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_winwood_farmer_2014",
      "src_ellestad_loaded_carry_2024",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "finger_curl",
    namePtPt: "Flexão resistida dos dedos",
    nameEn: "Resisted finger curl",
    familyId: "digital_flexion_extension",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Flexão dos dedos contra resistência, mantendo o punho controlado.",
    technicalDescriptionPtPt:
        "Carrega flexores superficiais e profundos dos dedos através das articulações MCP, PIP e DIP; a contribuição varia com a forma do objeto e posição do punho.",
    requiredEquipmentIds: <String>["straight_barbell"],
    optionalEquipmentIds: <String>["dumbbell"],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Usar barra leve ou ferramenta própria.",
      "Apoiar antebraços.",
      "Manter área livre abaixo.",
    ],
    startPositionPtPt:
        "Apoiar os antebraços e segurar o implemento nas falanges com dedos parcialmente estendidos.",
    movementPtPt:
        "Fechar os dedos para trazer o implemento para a palma; abrir de forma controlada sem o deixar cair.",
    endPositionPtPt:
        "Terminar com preensão segura, sem flexão excessiva do punho.",
    trajectoryPtPt: "O implemento rola ou desloca-se entre falanges e palma.",
    cuesPtPt: <String>[
      "Mover pelos dedos.",
      "Manter o punho estável.",
      "Usar carga pequena e segura.",
    ],
    commonErrorsPtPt: <String>[
      "Deixar a barra rolar sem controlo.",
      "Substituir o gesto por flexão do punho.",
      "Usar carga que ameaça cair.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "finger_metacarpophalangeal_joints",
      "finger_proximal_interphalangeal_joints",
      "finger_distal_interphalangeal_joints",
    ],
    actionIds: <String>[
      "finger_mcp_flexion",
      "finger_pip_flexion",
      "finger_dip_flexion",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "hammer_curl",
    namePtPt: "Curl martelo",
    nameEn: "Hammer curl",
    familyId: "elbow_flexion_neutral",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Flexão controlada do cotovelo com o antebraço neutro, mantendo o punho estável.",
    technicalDescriptionPtPt:
        "Exercício de cadeia aberta para flexão do cotovelo. O ombro fica neutro junto ao tronco e a resistência é vertical pela gravidade. A posição altera comprimentos e braços de momento, mas não permite alegar isolamento de uma cabeça muscular.",
    requiredEquipmentIds: <String>["dumbbell"],
    optionalEquipmentIds: <String>["rope_attachment", "cable_stack"],
    alternativeEquipmentIds: <String>["elastic_band"],
    setupPtPt: <String>[
      "Ajustar apoio e carga.",
      "Garantir espaço para a trajetória.",
      "Adotar a orientação de antebraço indicada.",
    ],
    startPositionPtPt:
        "Segurar o implemento com o cotovelo estendido sem o bloquear, braço controlado e tronco estável.",
    movementPtPt:
        "Fletir o cotovelo sem transformar o gesto numa elevação do ombro; regressar de forma controlada.",
    endPositionPtPt:
        "Terminar antes de perder a posição do punho ou deslocar o braço para retirar tensão ao cotovelo.",
    trajectoryPtPt:
        "A mão aproxima-se do ombro em torno do eixo do cotovelo, acompanhando a linha de resistência.",
    cuesPtPt: <String>[
      "Manter o punho neutro.",
      "Mover sobretudo pelo cotovelo.",
      "Controlar a descida.",
    ],
    commonErrorsPtPt: <String>[
      "Balançar o tronco.",
      "Projetar o cotovelo sem intenção técnica.",
      "Deixar o punho colapsar.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_flexion"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_murray_elbow_1995",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "lying_triceps_extension",
    namePtPt: "Extensão de tríceps deitado",
    nameEn: "Lying triceps extension",
    familyId: "elbow_extension_local",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Extensão controlada do cotovelo contra resistência, sem prometer isolamento das cabeças do tricípite.",
    technicalDescriptionPtPt:
        "Exercício com o ombro em flexão aproximada de 90 graus, estabilizado sobre banco e resistência vertical pela gravidade. A posição do ombro altera o comprimento da cabeça longa e pode mudar a contribuição relativa das cabeças.",
    requiredEquipmentIds: <String>["flat_bench", "ez_bar"],
    optionalEquipmentIds: <String>["dumbbell", "straight_barbell"],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar carga e apoio.",
      "Escolher uma pega confortável.",
      "Confirmar liberdade de movimento do cotovelo.",
    ],
    startPositionPtPt:
        "Começar com o cotovelo fletido, braço organizado e punho estável.",
    movementPtPt:
        "Estender o cotovelo contra a resistência e regressar sob controlo.",
    endPositionPtPt:
        "Terminar próximo da extensão confortável, sem bloquear agressivamente nem deslocar o ombro.",
    trajectoryPtPt:
        "A mão afasta-se do ombro em torno do cotovelo, alinhada com a resistência.",
    cuesPtPt: <String>[
      "Fixar a posição do braço.",
      "Manter o punho neutro.",
      "Controlar o regresso.",
    ],
    commonErrorsPtPt: <String>[
      "Abrir ou fechar excessivamente os cotovelos.",
      "Usar balanço do tronco.",
      "Perder o alinhamento do punho.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_extension"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_kholinne_triceps_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "machine_triceps_extension",
    namePtPt: "Extensão de tríceps na máquina",
    nameEn: "Machine triceps extension",
    familyId: "elbow_extension_local",
    state: CanonicalArmPublicationState.approvedWithLimits,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Extensão controlada do cotovelo contra resistência, sem prometer isolamento das cabeças do tricípite.",
    technicalDescriptionPtPt:
        "Exercício com o ombro definido pela máquina, geralmente com braço apoiado e resistência definida por came, cabo ou braço de alavanca. A posição do ombro altera o comprimento da cabeça longa e pode mudar a contribuição relativa das cabeças.",
    requiredEquipmentIds: <String>["selectorized_triceps_machine"],
    optionalEquipmentIds: <String>["plate_loaded_triceps_machine"],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar carga e apoio.",
      "Escolher uma pega confortável.",
      "Confirmar liberdade de movimento do cotovelo.",
    ],
    startPositionPtPt:
        "Começar com o cotovelo fletido, braço organizado e punho estável.",
    movementPtPt:
        "Estender o cotovelo contra a resistência e regressar sob controlo.",
    endPositionPtPt:
        "Terminar próximo da extensão confortável, sem bloquear agressivamente nem deslocar o ombro.",
    trajectoryPtPt:
        "A mão afasta-se do ombro em torno do cotovelo, alinhada com a resistência.",
    cuesPtPt: <String>[
      "Fixar a posição do braço.",
      "Manter o punho neutro.",
      "Controlar o regresso.",
    ],
    commonErrorsPtPt: <String>[
      "Abrir ou fechar excessivamente os cotovelos.",
      "Usar balanço do tronco.",
      "Perder o alinhamento do punho.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_extension"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_kholinne_triceps_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "overhead_triceps_extension",
    namePtPt: "Extensão de tríceps acima da cabeça",
    nameEn: "Overhead triceps extension",
    familyId: "elbow_extension_local",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Extensão controlada do cotovelo contra resistência, sem prometer isolamento das cabeças do tricípite.",
    technicalDescriptionPtPt:
        "Exercício com o ombro elevado acima da cabeça e resistência definida por cabo, peso livre ou banda. A posição do ombro altera o comprimento da cabeça longa e pode mudar a contribuição relativa das cabeças.",
    requiredEquipmentIds: <String>[
      "cable_stack",
      "adjustable_pulley",
      "rope_attachment",
    ],
    optionalEquipmentIds: <String>["dumbbell", "ez_bar", "elastic_band"],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar carga e apoio.",
      "Escolher uma pega confortável.",
      "Confirmar liberdade de movimento do cotovelo.",
    ],
    startPositionPtPt:
        "Começar com o cotovelo fletido, braço organizado e punho estável.",
    movementPtPt:
        "Estender o cotovelo contra a resistência e regressar sob controlo.",
    endPositionPtPt:
        "Terminar próximo da extensão confortável, sem bloquear agressivamente nem deslocar o ombro.",
    trajectoryPtPt:
        "A mão afasta-se do ombro em torno do cotovelo, alinhada com a resistência.",
    cuesPtPt: <String>[
      "Fixar a posição do braço.",
      "Manter o punho neutro.",
      "Controlar o regresso.",
    ],
    commonErrorsPtPt: <String>[
      "Abrir ou fechar excessivamente os cotovelos.",
      "Usar balanço do tronco.",
      "Perder o alinhamento do punho.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_extension"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_maeo_triceps_2023",
      "src_kholinne_triceps_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "parallel_bar_dip",
    namePtPt: "Fundos em paralelas",
    nameEn: "Parallel-bar dip",
    familyId: "elbow_extension_compound",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Exercício multiarticular em apoio nas paralelas, com extensão do cotovelo relevante e participação do ombro e peito.",
    technicalDescriptionPtPt:
        "Cadeia fechada. O tricípite é importante, mas o gesto também exige extensão/adução do ombro, depressão escapular e controlo do tronco.",
    requiredEquipmentIds: <String>["bodyweight", "parallel_bars"],
    optionalEquipmentIds: <String>["elastic_band"],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Confirmar estabilidade das paralelas.",
      "Garantir espaço livre.",
      "Usar assistência se necessário.",
    ],
    startPositionPtPt:
        "Apoiar o corpo nas paralelas com cotovelos estendidos, ombros organizados e pés sem apoio.",
    movementPtPt:
        "Descer por flexão controlada dos cotovelos e ombros; subir estendendo os cotovelos sem perder a posição escapular.",
    endPositionPtPt:
        "Terminar a descida antes de dor ou perda de controlo do ombro; subir até extensão confortável.",
    trajectoryPtPt: "O corpo desloca-se verticalmente entre as barras.",
    cuesPtPt: <String>[
      "Manter as barras firmemente seguras.",
      "Controlar a profundidade.",
      "Evitar encolher os ombros.",
    ],
    commonErrorsPtPt: <String>[
      "Descer além da amplitude tolerada.",
      "Balançar o corpo.",
      "Bloquear o cotovelo de forma agressiva.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "elbow_joint",
      "glenohumeral_joint",
      "scapulothoracic_articulation",
    ],
    actionIds: <String>[
      "elbow_extension",
      "shoulder_extension",
      "shoulder_flexion",
      "shoulder_adduction",
      "scapular_depression",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_mckenzie_dips_2022",
      "src_vigotsky_semg_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "parallel_bar_support_hold",
    namePtPt: "Apoio isométrico nas paralelas",
    nameEn: "Parallel-bar support hold",
    familyId: "upper_limb_support",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Sustentar o corpo com os braços estendidos nas paralelas, mantendo mãos, cotovelos e ombros estáveis.",
    technicalDescriptionPtPt:
        "Tarefa de preensão ou suporte cuja limitação pode resultar da força digital, posição do punho, contacto, fricção, tolerância da pele e estabilidade proximal. Não identifica um músculo isolado.",
    requiredEquipmentIds: <String>["bodyweight", "parallel_bars"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Verificar o estado do implemento.",
      "Remover obstáculos.",
      "Escolher carga e duração controláveis.",
    ],
    startPositionPtPt:
        "Organizar mão e punho em torno do implemento ou apoio, com contacto seguro.",
    movementPtPt:
        "Elevar-se para apoio, manter cotovelos estendidos e sair através de apoio controlado.",
    endPositionPtPt:
        "Terminar antes de perder o contacto, a posição do punho ou o controlo do corpo.",
    trajectoryPtPt:
        "Predominantemente isométrica na mão; quando existe transporte, o corpo desloca-se mantendo a preensão.",
    cuesPtPt: <String>[
      "Envolver o implemento com controlo.",
      "Manter o punho próximo de neutro.",
      "Terminar antes da abertura involuntária da mão.",
    ],
    commonErrorsPtPt: <String>[
      "Continuar depois de a pega começar a escapar.",
      "Compensar com flexão excessiva do punho.",
      "Usar superfície ou carga sem margem de segurança.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "elbow_joint",
      "radiocarpal_joint",
      "glenohumeral_joint",
      "scapulothoracic_articulation",
    ],
    actionIds: <String>["elbow_extension", "scapular_depression"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "plate_pinch_hold",
    namePtPt: "Pinça isométrica com discos",
    nameEn: "Plate pinch hold",
    familyId: "grip_isometric",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Sustentar discos por pinça entre o polegar e os dedos.",
    technicalDescriptionPtPt:
        "Tarefa de preensão ou suporte cuja limitação pode resultar da força digital, posição do punho, contacto, fricção, tolerância da pele e estabilidade proximal. Não identifica um músculo isolado.",
    requiredEquipmentIds: <String>["weight_plate"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Verificar o estado do implemento.",
      "Remover obstáculos.",
      "Escolher carga e duração controláveis.",
    ],
    startPositionPtPt:
        "Organizar mão e punho em torno do implemento ou apoio, com contacto seguro.",
    movementPtPt:
        "Elevar os discos apenas o suficiente para ficarem livres e manter a pinça sem deslocamento.",
    endPositionPtPt:
        "Terminar antes de perder o contacto, a posição do punho ou o controlo do corpo.",
    trajectoryPtPt:
        "Predominantemente isométrica na mão; quando existe transporte, o corpo desloca-se mantendo a preensão.",
    cuesPtPt: <String>[
      "Envolver o implemento com controlo.",
      "Manter o punho próximo de neutro.",
      "Terminar antes da abertura involuntária da mão.",
    ],
    commonErrorsPtPt: <String>[
      "Continuar depois de a pega começar a escapar.",
      "Compensar com flexão excessiva do punho.",
      "Usar superfície ou carga sem margem de segurança.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "thumb_carpometacarpal_joint",
      "thumb_metacarpophalangeal_joint",
      "finger_metacarpophalangeal_joints",
      "radiocarpal_joint",
    ],
    actionIds: <String>[
      "thumb_cmc_adduction",
      "thumb_mcp_flexion",
      "finger_mcp_flexion",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "preacher_curl",
    namePtPt: "Curl no banco Scott",
    nameEn: "Preacher curl",
    familyId: "elbow_flexion_supinated",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Flexão controlada do cotovelo com o antebraço supinado ou semissupinado conforme a barra, mantendo o punho estável.",
    technicalDescriptionPtPt:
        "Exercício de cadeia aberta para flexão do cotovelo. O ombro fica em flexão, com o braço apoiado no banco scott e a resistência é vertical pela gravidade ou definida pela máquina/cabo. A posição altera comprimentos e braços de momento, mas não permite alegar isolamento de uma cabeça muscular.",
    requiredEquipmentIds: <String>["preacher_bench", "ez_bar"],
    optionalEquipmentIds: <String>["dumbbell", "straight_barbell"],
    alternativeEquipmentIds: <String>[
      "selectorized_curl_machine",
      "cable_stack",
    ],
    setupPtPt: <String>[
      "Ajustar apoio e carga.",
      "Garantir espaço para a trajetória.",
      "Adotar a orientação de antebraço indicada.",
    ],
    startPositionPtPt:
        "Segurar o implemento com o cotovelo estendido sem o bloquear, braço controlado e tronco estável.",
    movementPtPt:
        "Fletir o cotovelo sem transformar o gesto numa elevação do ombro; regressar de forma controlada.",
    endPositionPtPt:
        "Terminar antes de perder a posição do punho ou deslocar o braço para retirar tensão ao cotovelo.",
    trajectoryPtPt:
        "A mão aproxima-se do ombro em torno do eixo do cotovelo, acompanhando a linha de resistência.",
    cuesPtPt: <String>[
      "Manter o punho neutro.",
      "Mover sobretudo pelo cotovelo.",
      "Controlar a descida.",
    ],
    commonErrorsPtPt: <String>[
      "Balançar o tronco.",
      "Projetar o cotovelo sem intenção técnica.",
      "Deixar o punho colapsar.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_flexion"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_oliveira_biceps_2009",
      "src_attarieh_curls_2025",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "resisted_finger_extension",
    namePtPt: "Extensão dos dedos com banda",
    nameEn: "Band-resisted finger extension",
    familyId: "digital_flexion_extension",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Abrir os dedos contra uma banda colocada à volta das falanges.",
    technicalDescriptionPtPt:
        "Exercício de resistência elástica para extensão MCP e contribuição através das expansões extensoras. A carga individual de cada dedo não é uniforme.",
    requiredEquipmentIds: <String>["elastic_band"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Inspecionar a banda.",
      "Escolher resistência baixa.",
      "Posicionar a banda fora das pregas articulares.",
    ],
    startPositionPtPt:
        "Colocar uma banda leve em torno dos dedos com a mão fechada de forma confortável.",
    movementPtPt: "Abrir os dedos contra a banda e regressar lentamente.",
    endPositionPtPt:
        "Terminar antes de a banda escorregar ou forçar as articulações.",
    trajectoryPtPt: "Os dedos afastam-se e estendem-se a partir da mão.",
    cuesPtPt: <String>[
      "Abrir de forma uniforme.",
      "Manter o punho neutro.",
      "Usar banda leve.",
    ],
    commonErrorsPtPt: <String>[
      "Usar banda demasiado forte.",
      "Deixar a banda enrolar nas articulações.",
      "Compensar com extensão do punho.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "finger_metacarpophalangeal_joints",
      "finger_proximal_interphalangeal_joints",
      "finger_distal_interphalangeal_joints",
    ],
    actionIds: <String>[
      "finger_mcp_extension",
      "finger_pip_extension",
      "finger_dip_extension",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "resisted_forearm_pronation",
    namePtPt: "Pronação resistida do antebraço",
    nameEn: "Resisted forearm pronation",
    familyId: "forearm_rotation",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Pronação do antebraço contra resistência com o antebraço controlado.",
    technicalDescriptionPtPt:
        "Exercício monoação destinado a carregar pronação do antebraço. A contribuição individual dos músculos depende da rotação do antebraço, do punho, do implemento e da amplitude.",
    requiredEquipmentIds: <String>["lever_hammer"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar apoio e alavanca.",
      "Usar carga leve o suficiente para controlo fino.",
      "Alinhar a resistência com a ação pretendida.",
    ],
    startPositionPtPt:
        "Apoiar ou estabilizar o antebraço e começar numa posição confortável, sem desvio compensatório.",
    movementPtPt:
        "Executar pronação do antebraço contra a resistência e regressar lentamente.",
    endPositionPtPt:
        "Terminar antes de perder o apoio, o alinhamento ou a amplitude confortável.",
    trajectoryPtPt:
        "O implemento descreve um arco curto em torno da articulação-alvo.",
    cuesPtPt: <String>[
      "Manter o antebraço imóvel.",
      "Usar amplitude controlada.",
      "Evitar movimento dos dedos para substituir o punho.",
    ],
    commonErrorsPtPt: <String>[
      "Mover o cotovelo ou ombro.",
      "Usar carga que força amplitude terminal.",
      "Perder o alinhamento da mão.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["proximal_radioulnar_joint", "distal_radioulnar_joint"],
    actionIds: <String>["forearm_pronation"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_ikeda_wrist_2025",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "resisted_forearm_supination",
    namePtPt: "Supinação resistida do antebraço",
    nameEn: "Resisted forearm supination",
    familyId: "forearm_rotation",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Supinação do antebraço contra resistência com o antebraço controlado.",
    technicalDescriptionPtPt:
        "Exercício monoação destinado a carregar supinação do antebraço. A contribuição individual dos músculos depende da rotação do antebraço, do punho, do implemento e da amplitude.",
    requiredEquipmentIds: <String>["lever_hammer"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar apoio e alavanca.",
      "Usar carga leve o suficiente para controlo fino.",
      "Alinhar a resistência com a ação pretendida.",
    ],
    startPositionPtPt:
        "Apoiar ou estabilizar o antebraço e começar numa posição confortável, sem desvio compensatório.",
    movementPtPt:
        "Executar supinação do antebraço contra a resistência e regressar lentamente.",
    endPositionPtPt:
        "Terminar antes de perder o apoio, o alinhamento ou a amplitude confortável.",
    trajectoryPtPt:
        "O implemento descreve um arco curto em torno da articulação-alvo.",
    cuesPtPt: <String>[
      "Manter o antebraço imóvel.",
      "Usar amplitude controlada.",
      "Evitar movimento dos dedos para substituir o punho.",
    ],
    commonErrorsPtPt: <String>[
      "Mover o cotovelo ou ombro.",
      "Usar carga que força amplitude terminal.",
      "Perder o alinhamento da mão.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["proximal_radioulnar_joint", "distal_radioulnar_joint"],
    actionIds: <String>["forearm_supination"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_ikeda_wrist_2025",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "resisted_hand_close",
    namePtPt: "Fecho resistido da mão",
    nameEn: "Resisted hand close",
    familyId: "grip_dynamic",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Fechar a mão contra resistência através de preensão de esmagamento controlada.",
    technicalDescriptionPtPt:
        "Tarefa de preensão ou suporte cuja limitação pode resultar da força digital, posição do punho, contacto, fricção, tolerância da pele e estabilidade proximal. Não identifica um músculo isolado.",
    requiredEquipmentIds: <String>["hand_gripper"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Verificar o estado do implemento.",
      "Remover obstáculos.",
      "Escolher carga e duração controláveis.",
    ],
    startPositionPtPt:
        "Organizar mão e punho em torno do implemento ou apoio, com contacto seguro.",
    movementPtPt:
        "Fechar as pegas com os dedos e polegar; regressar sem deixar a mola abrir bruscamente.",
    endPositionPtPt:
        "Terminar antes de perder o contacto, a posição do punho ou o controlo do corpo.",
    trajectoryPtPt:
        "Predominantemente isométrica na mão; quando existe transporte, o corpo desloca-se mantendo a preensão.",
    cuesPtPt: <String>[
      "Envolver o implemento com controlo.",
      "Manter o punho próximo de neutro.",
      "Terminar antes da abertura involuntária da mão.",
    ],
    commonErrorsPtPt: <String>[
      "Continuar depois de a pega começar a escapar.",
      "Compensar com flexão excessiva do punho.",
      "Usar superfície ou carga sem margem de segurança.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "finger_metacarpophalangeal_joints",
      "finger_proximal_interphalangeal_joints",
      "finger_distal_interphalangeal_joints",
      "radiocarpal_joint",
    ],
    actionIds: <String>[
      "finger_mcp_flexion",
      "finger_pip_flexion",
      "finger_dip_flexion",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_gerodimos_grip_2021",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "resisted_thumb_opposition",
    namePtPt: "Oposição resistida do polegar",
    nameEn: "Resisted thumb opposition",
    familyId: "thumb_specific",
    state: CanonicalArmPublicationState.specialistReview,
    isPublicEligible: false,
    shortDescriptionPtPt:
        "Oposição do polegar contra resistência leve, mantida fora da camada pública inicial.",
    technicalDescriptionPtPt:
        "Tarefa específica dos músculos tenares e do controlo carpometacárpico do polegar; fica em revisão especialista por proximidade a usos clínicos.",
    requiredEquipmentIds: <String>["manual_resistance"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Apoiar a mão.",
      "Aplicar resistência manual graduada.",
      "Não usar como prescrição clínica.",
    ],
    startPositionPtPt: "Mão apoiada e polegar numa posição confortável.",
    movementPtPt:
        "Levar a polpa do polegar em direção aos dedos contra resistência manual leve.",
    endPositionPtPt:
        "Terminar antes de dor, colapso da articulação ou compensação do punho.",
    trajectoryPtPt: "Movimento multiplanar de oposição.",
    cuesPtPt: <String>[
      "Usar resistência mínima.",
      "Mover sem dor.",
      "Manter o punho estável.",
    ],
    commonErrorsPtPt: <String>[
      "Forçar a base do polegar.",
      "Usar resistência alta.",
      "Aplicar em presença de dor sem avaliação.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Obrigatória antes de qualquer utilização clínica ou pós-lesão.",
    jointIds: <String>["thumb_carpometacarpal_joint"],
    actionIds: <String>["thumb_opposition"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "reverse_curl",
    namePtPt: "Curl inverso",
    nameEn: "Reverse curl",
    familyId: "elbow_flexion_pronated",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Flexão controlada do cotovelo com o antebraço pronado, mantendo o punho estável.",
    technicalDescriptionPtPt:
        "Exercício de cadeia aberta para flexão do cotovelo. O ombro fica neutro junto ao tronco e a resistência é vertical pela gravidade. A posição altera comprimentos e braços de momento, mas não permite alegar isolamento de uma cabeça muscular.",
    requiredEquipmentIds: <String>["ez_bar"],
    optionalEquipmentIds: <String>["straight_barbell", "dumbbell"],
    alternativeEquipmentIds: <String>["cable_stack"],
    setupPtPt: <String>[
      "Ajustar apoio e carga.",
      "Garantir espaço para a trajetória.",
      "Adotar a orientação de antebraço indicada.",
    ],
    startPositionPtPt:
        "Segurar o implemento com o cotovelo estendido sem o bloquear, braço controlado e tronco estável.",
    movementPtPt:
        "Fletir o cotovelo sem transformar o gesto numa elevação do ombro; regressar de forma controlada.",
    endPositionPtPt:
        "Terminar antes de perder a posição do punho ou deslocar o braço para retirar tensão ao cotovelo.",
    trajectoryPtPt:
        "A mão aproxima-se do ombro em torno do eixo do cotovelo, acompanhando a linha de resistência.",
    cuesPtPt: <String>[
      "Manter o punho neutro.",
      "Mover sobretudo pelo cotovelo.",
      "Controlar a descida.",
    ],
    commonErrorsPtPt: <String>[
      "Balançar o tronco.",
      "Projetar o cotovelo sem intenção técnica.",
      "Deixar o punho colapsar.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_flexion"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_murray_elbow_1995",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "shoulder_extended_supinated_curl",
    namePtPt: "Curl supinado com ombro em extensão",
    nameEn: "Shoulder-extended supinated curl",
    familyId: "elbow_flexion_supinated",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Flexão controlada do cotovelo com o antebraço supinado, mantendo o punho estável.",
    technicalDescriptionPtPt:
        "Exercício de cadeia aberta para flexão do cotovelo. O ombro fica em extensão relativa atrás do tronco, apoiado num banco inclinado e a resistência é vertical pela gravidade. A posição altera comprimentos e braços de momento, mas não permite alegar isolamento de uma cabeça muscular.",
    requiredEquipmentIds: <String>["dumbbell", "incline_bench"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar apoio e carga.",
      "Garantir espaço para a trajetória.",
      "Adotar a orientação de antebraço indicada.",
    ],
    startPositionPtPt:
        "Segurar o implemento com o cotovelo estendido sem o bloquear, braço controlado e tronco estável.",
    movementPtPt:
        "Fletir o cotovelo sem transformar o gesto numa elevação do ombro; regressar de forma controlada.",
    endPositionPtPt:
        "Terminar antes de perder a posição do punho ou deslocar o braço para retirar tensão ao cotovelo.",
    trajectoryPtPt:
        "A mão aproxima-se do ombro em torno do eixo do cotovelo, acompanhando a linha de resistência.",
    cuesPtPt: <String>[
      "Manter o punho neutro.",
      "Mover sobretudo pelo cotovelo.",
      "Controlar a descida.",
    ],
    commonErrorsPtPt: <String>[
      "Balançar o tronco.",
      "Projetar o cotovelo sem intenção técnica.",
      "Deixar o punho colapsar.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_flexion"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_murray_elbow_1995",
      "src_oliveira_biceps_2009",
      "src_attarieh_curls_2025",
      "src_vigotsky_semg_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "spider_curl",
    namePtPt: "Curl spider",
    nameEn: "Spider curl",
    familyId: "elbow_flexion_supinated",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Flexão controlada do cotovelo com o antebraço supinado, mantendo o punho estável.",
    technicalDescriptionPtPt:
        "Exercício de cadeia aberta para flexão do cotovelo. O ombro fica em flexão, com o peito apoiado num banco inclinado e braços pendentes e a resistência é vertical pela gravidade. A posição altera comprimentos e braços de momento, mas não permite alegar isolamento de uma cabeça muscular.",
    requiredEquipmentIds: <String>["dumbbell", "incline_bench"],
    optionalEquipmentIds: <String>["ez_bar"],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar apoio e carga.",
      "Garantir espaço para a trajetória.",
      "Adotar a orientação de antebraço indicada.",
    ],
    startPositionPtPt:
        "Segurar o implemento com o cotovelo estendido sem o bloquear, braço controlado e tronco estável.",
    movementPtPt:
        "Fletir o cotovelo sem transformar o gesto numa elevação do ombro; regressar de forma controlada.",
    endPositionPtPt:
        "Terminar antes de perder a posição do punho ou deslocar o braço para retirar tensão ao cotovelo.",
    trajectoryPtPt:
        "A mão aproxima-se do ombro em torno do eixo do cotovelo, acompanhando a linha de resistência.",
    cuesPtPt: <String>[
      "Manter o punho neutro.",
      "Mover sobretudo pelo cotovelo.",
      "Controlar a descida.",
    ],
    commonErrorsPtPt: <String>[
      "Balançar o tronco.",
      "Projetar o cotovelo sem intenção técnica.",
      "Deixar o punho colapsar.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_flexion"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_murray_elbow_1995",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "standing_supinated_curl",
    namePtPt: "Curl em pé com pega supinada",
    nameEn: "Standing supinated curl",
    familyId: "elbow_flexion_supinated",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Flexão controlada do cotovelo com o antebraço supinado, mantendo o punho estável.",
    technicalDescriptionPtPt:
        "Exercício de cadeia aberta para flexão do cotovelo. O ombro fica neutro junto ao tronco e a resistência é vertical pela gravidade. A posição altera comprimentos e braços de momento, mas não permite alegar isolamento de uma cabeça muscular.",
    requiredEquipmentIds: <String>["straight_barbell"],
    optionalEquipmentIds: <String>["ez_bar", "dumbbell"],
    alternativeEquipmentIds: <String>["cable_stack", "elastic_band"],
    setupPtPt: <String>[
      "Ajustar apoio e carga.",
      "Garantir espaço para a trajetória.",
      "Adotar a orientação de antebraço indicada.",
    ],
    startPositionPtPt:
        "Segurar o implemento com o cotovelo estendido sem o bloquear, braço controlado e tronco estável.",
    movementPtPt:
        "Fletir o cotovelo sem transformar o gesto numa elevação do ombro; regressar de forma controlada.",
    endPositionPtPt:
        "Terminar antes de perder a posição do punho ou deslocar o braço para retirar tensão ao cotovelo.",
    trajectoryPtPt:
        "A mão aproxima-se do ombro em torno do eixo do cotovelo, acompanhando a linha de resistência.",
    cuesPtPt: <String>[
      "Manter o punho neutro.",
      "Mover sobretudo pelo cotovelo.",
      "Controlar a descida.",
    ],
    commonErrorsPtPt: <String>[
      "Balançar o tronco.",
      "Projetar o cotovelo sem intenção técnica.",
      "Deixar o punho colapsar.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_flexion"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_murray_elbow_1995",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "suitcase_carry",
    namePtPt: "Transporte unilateral tipo mala",
    nameEn: "Suitcase carry",
    familyId: "loaded_carry",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Transportar uma carga numa só mão, mantendo preensão e controlo lateral do tronco.",
    technicalDescriptionPtPt:
        "Tarefa de preensão ou suporte cuja limitação pode resultar da força digital, posição do punho, contacto, fricção, tolerância da pele e estabilidade proximal. Não identifica um músculo isolado.",
    requiredEquipmentIds: <String>["dumbbell"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Verificar o estado do implemento.",
      "Remover obstáculos.",
      "Escolher carga e duração controláveis.",
    ],
    startPositionPtPt:
        "Organizar mão e punho em torno do implemento ou apoio, com contacto seguro.",
    movementPtPt:
        "Elevar a carga, caminhar sem inclinar o tronco e pousar de forma controlada.",
    endPositionPtPt:
        "Terminar antes de perder o contacto, a posição do punho ou o controlo do corpo.",
    trajectoryPtPt:
        "Predominantemente isométrica na mão; quando existe transporte, o corpo desloca-se mantendo a preensão.",
    cuesPtPt: <String>[
      "Envolver o implemento com controlo.",
      "Manter o punho próximo de neutro.",
      "Terminar antes da abertura involuntária da mão.",
    ],
    commonErrorsPtPt: <String>[
      "Continuar depois de a pega começar a escapar.",
      "Compensar com flexão excessiva do punho.",
      "Usar superfície ou carga sem margem de segurança.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "finger_metacarpophalangeal_joints",
      "finger_proximal_interphalangeal_joints",
      "finger_distal_interphalangeal_joints",
      "radiocarpal_joint",
    ],
    actionIds: <String>[
      "finger_mcp_flexion",
      "finger_pip_flexion",
      "finger_dip_flexion",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_bordelon_carry_2021",
      "src_ellestad_loaded_carry_2024",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "supinated_chin_up",
    namePtPt: "Elevação na barra com pega supinada",
    nameEn: "Supinated chin-up",
    familyId: "elbow_flexion_supinated",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Tração vertical multiarticular com pega supinada, na qual os flexores do cotovelo têm papel relevante mas não exclusivo.",
    technicalDescriptionPtPt:
        "Exercício de cadeia fechada para cotovelo e ombro. O bicípite e o braquial contribuem para a flexão do cotovelo, enquanto músculos das costas e cintura escapular também são determinantes.",
    requiredEquipmentIds: <String>["bodyweight", "pull_up_bar"],
    optionalEquipmentIds: <String>["elastic_band"],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Confirmar estabilidade da barra.",
      "Escolher largura de pega confortável.",
      "Garantir espaço livre por baixo.",
    ],
    startPositionPtPt:
        "Suspender-se numa barra fixa com pega supinada segura, cotovelos estendidos sem relaxamento descontrolado.",
    movementPtPt:
        "Puxar o corpo para cima através de flexão do cotovelo e movimento coordenado do ombro/escápula; descer sob controlo.",
    endPositionPtPt:
        "Terminar a subida sem projetar a cabeça ou perder o controlo escapular; regressar à suspensão controlada.",
    trajectoryPtPt:
        "O tronco aproxima-se da barra num percurso vertical ou ligeiramente arqueado.",
    cuesPtPt: <String>[
      "Iniciar com controlo escapular.",
      "Manter a pega fechada.",
      "Evitar balanço das pernas.",
    ],
    commonErrorsPtPt: <String>[
      "Usar impulso excessivo.",
      "Soltar bruscamente para a extensão.",
      "Forçar amplitude do ombro dolorosa.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "elbow_joint",
      "glenohumeral_joint",
      "scapulothoracic_articulation",
    ],
    actionIds: <String>[
      "elbow_flexion",
      "shoulder_extension",
      "shoulder_adduction",
      "scapular_depression",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_dickie_pullup_2017",
      "src_vigotsky_semg_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "support_grip_hold",
    namePtPt: "Sustentação estática com barra",
    nameEn: "Static support grip hold",
    familyId: "grip_isometric",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Manter uma barra ou halteres suspensos nas mãos sem deslocamento.",
    technicalDescriptionPtPt:
        "Tarefa de preensão ou suporte cuja limitação pode resultar da força digital, posição do punho, contacto, fricção, tolerância da pele e estabilidade proximal. Não identifica um músculo isolado.",
    requiredEquipmentIds: <String>["straight_barbell"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Verificar o estado do implemento.",
      "Remover obstáculos.",
      "Escolher carga e duração controláveis.",
    ],
    startPositionPtPt:
        "Organizar mão e punho em torno do implemento ou apoio, com contacto seguro.",
    movementPtPt:
        "Elevar o implemento para uma posição segura e manter a preensão antes de o pousar.",
    endPositionPtPt:
        "Terminar antes de perder o contacto, a posição do punho ou o controlo do corpo.",
    trajectoryPtPt:
        "Predominantemente isométrica na mão; quando existe transporte, o corpo desloca-se mantendo a preensão.",
    cuesPtPt: <String>[
      "Envolver o implemento com controlo.",
      "Manter o punho próximo de neutro.",
      "Terminar antes da abertura involuntária da mão.",
    ],
    commonErrorsPtPt: <String>[
      "Continuar depois de a pega começar a escapar.",
      "Compensar com flexão excessiva do punho.",
      "Usar superfície ou carga sem margem de segurança.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "finger_metacarpophalangeal_joints",
      "finger_proximal_interphalangeal_joints",
      "finger_distal_interphalangeal_joints",
      "radiocarpal_joint",
    ],
    actionIds: <String>[
      "finger_mcp_flexion",
      "finger_pip_flexion",
      "finger_dip_flexion",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_kong_handle_2005",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "supported_wrist_curl",
    namePtPt: "Flexão do punho com antebraço apoiado",
    nameEn: "Supported wrist curl",
    familyId: "wrist_flexion_extension",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Flexão do punho contra resistência com o antebraço controlado.",
    technicalDescriptionPtPt:
        "Exercício monoação destinado a carregar flexão do punho. A contribuição individual dos músculos depende da rotação do antebraço, do punho, do implemento e da amplitude.",
    requiredEquipmentIds: <String>["dumbbell", "flat_bench"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar apoio e alavanca.",
      "Usar carga leve o suficiente para controlo fino.",
      "Alinhar a resistência com a ação pretendida.",
    ],
    startPositionPtPt:
        "Apoiar ou estabilizar o antebraço e começar numa posição confortável, sem desvio compensatório.",
    movementPtPt:
        "Executar flexão do punho contra a resistência e regressar lentamente.",
    endPositionPtPt:
        "Terminar antes de perder o apoio, o alinhamento ou a amplitude confortável.",
    trajectoryPtPt:
        "O implemento descreve um arco curto em torno da articulação-alvo.",
    cuesPtPt: <String>[
      "Manter o antebraço imóvel.",
      "Usar amplitude controlada.",
      "Evitar movimento dos dedos para substituir o punho.",
    ],
    commonErrorsPtPt: <String>[
      "Mover o cotovelo ou ombro.",
      "Usar carga que força amplitude terminal.",
      "Perder o alinhamento da mão.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["radiocarpal_joint", "midcarpal_joint"],
    actionIds: <String>["wrist_flexion"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_ikeda_wrist_2025",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "supported_wrist_extension",
    namePtPt: "Extensão do punho com antebraço apoiado",
    nameEn: "Supported wrist extension",
    familyId: "wrist_flexion_extension",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Extensão do punho contra resistência com o antebraço controlado.",
    technicalDescriptionPtPt:
        "Exercício monoação destinado a carregar extensão do punho. A contribuição individual dos músculos depende da rotação do antebraço, do punho, do implemento e da amplitude.",
    requiredEquipmentIds: <String>["dumbbell", "flat_bench"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar apoio e alavanca.",
      "Usar carga leve o suficiente para controlo fino.",
      "Alinhar a resistência com a ação pretendida.",
    ],
    startPositionPtPt:
        "Apoiar ou estabilizar o antebraço e começar numa posição confortável, sem desvio compensatório.",
    movementPtPt:
        "Executar extensão do punho contra a resistência e regressar lentamente.",
    endPositionPtPt:
        "Terminar antes de perder o apoio, o alinhamento ou a amplitude confortável.",
    trajectoryPtPt:
        "O implemento descreve um arco curto em torno da articulação-alvo.",
    cuesPtPt: <String>[
      "Manter o antebraço imóvel.",
      "Usar amplitude controlada.",
      "Evitar movimento dos dedos para substituir o punho.",
    ],
    commonErrorsPtPt: <String>[
      "Mover o cotovelo ou ombro.",
      "Usar carga que força amplitude terminal.",
      "Perder o alinhamento da mão.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["radiocarpal_joint", "midcarpal_joint"],
    actionIds: <String>["wrist_extension"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_ikeda_wrist_2025",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "suspension_bodyweight_curl",
    namePtPt: "Curl em suspensão com peso corporal",
    nameEn: "Suspension bodyweight curl",
    familyId: "elbow_flexion_supinated",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Flexão do cotovelo em cadeia mista, aproximando o corpo das mãos através de pegas móveis num sistema de suspensão.",
    technicalDescriptionPtPt:
        "A resistência resulta da componente do peso corporal perpendicular à linha entre pés e mãos. A posição dos pés regula a dificuldade sem alterar a identidade.",
    requiredEquipmentIds: <String>["bodyweight", "suspension_trainer"],
    optionalEquipmentIds: <String>["rings"],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Fixar o sistema num ponto certificado.",
      "Ajustar o comprimento das fitas.",
      "Posicionar os pés para uma dificuldade controlável.",
    ],
    startPositionPtPt:
        "Segurar as pegas com o corpo alinhado e cotovelos estendidos, mantendo tensão no sistema.",
    movementPtPt:
        "Fletir os cotovelos para aproximar a testa ou ombros das mãos, sem perder o alinhamento corporal.",
    endPositionPtPt:
        "Terminar antes de os ombros avançarem ou o tronco perder rigidez; regressar sob controlo.",
    trajectoryPtPt:
        "O corpo roda em torno do apoio dos pés enquanto as mãos permanecem ligadas às fitas.",
    cuesPtPt: <String>[
      "Manter o corpo alinhado.",
      "Apontar as palmas para cima.",
      "Mover pelos cotovelos.",
    ],
    commonErrorsPtPt: <String>[
      "Dobrar a anca.",
      "Transformar o gesto numa remada.",
      "Usar ancoragem instável.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint", "glenohumeral_joint"],
    actionIds: <String>["elbow_flexion"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "suspension_triceps_extension",
    namePtPt: "Extensão de tríceps em suspensão",
    nameEn: "Suspension triceps extension",
    familyId: "elbow_extension_local",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Extensão do cotovelo em cadeia mista através de pegas móveis num sistema de suspensão.",
    technicalDescriptionPtPt:
        "A dificuldade muda com a inclinação corporal; os pés mantêm contacto com o solo, as pegas movem-se e ombro e tronco devem permanecer controlados.",
    requiredEquipmentIds: <String>["bodyweight", "suspension_trainer"],
    optionalEquipmentIds: <String>["rings"],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Certificar a ancoragem.",
      "Ajustar fitas simetricamente.",
      "Escolher inclinação adequada.",
    ],
    startPositionPtPt:
        "Segurar as pegas com braços à frente, corpo alinhado e tensão no sistema.",
    movementPtPt:
        "Fletir os cotovelos levando a cabeça entre as mãos e estendê-los para afastar o corpo.",
    endPositionPtPt:
        "Terminar antes de perder alinhamento do tronco ou posição do ombro.",
    trajectoryPtPt:
        "O corpo roda em torno dos pés enquanto as mãos permanecem ligadas às fitas.",
    cuesPtPt: <String>[
      "Manter cotovelos apontados em frente.",
      "Corpo alinhado.",
      "Controlar a descida.",
    ],
    commonErrorsPtPt: <String>[
      "Transformar o gesto num empurrar de ombro.",
      "Dobrar a anca.",
      "Usar ancoragem instável.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint", "glenohumeral_joint"],
    actionIds: <String>["elbow_extension"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "triceps_kickback",
    namePtPt: "Kickback de tríceps",
    nameEn: "Triceps kickback",
    familyId: "elbow_extension_local",
    state: CanonicalArmPublicationState.approvedPublic,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Extensão controlada do cotovelo contra resistência, sem prometer isolamento das cabeças do tricípite.",
    technicalDescriptionPtPt:
        "Exercício com o ombro em extensão atrás do tronco e resistência vertical pela gravidade ou ao longo do cabo. A posição do ombro altera o comprimento da cabeça longa e pode mudar a contribuição relativa das cabeças.",
    requiredEquipmentIds: <String>["dumbbell"],
    optionalEquipmentIds: <String>[
      "cable_stack",
      "low_pulley",
      "single_handle",
    ],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar carga e apoio.",
      "Escolher uma pega confortável.",
      "Confirmar liberdade de movimento do cotovelo.",
    ],
    startPositionPtPt:
        "Começar com o cotovelo fletido, braço organizado e punho estável.",
    movementPtPt:
        "Estender o cotovelo contra a resistência e regressar sob controlo.",
    endPositionPtPt:
        "Terminar próximo da extensão confortável, sem bloquear agressivamente nem deslocar o ombro.",
    trajectoryPtPt:
        "A mão afasta-se do ombro em torno do cotovelo, alinhada com a resistência.",
    cuesPtPt: <String>[
      "Fixar a posição do braço.",
      "Manter o punho neutro.",
      "Controlar o regresso.",
    ],
    commonErrorsPtPt: <String>[
      "Abrir ou fechar excessivamente os cotovelos.",
      "Usar balanço do tronco.",
      "Perder o alinhamento do punho.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["elbow_joint"],
    actionIds: <String>["elbow_extension"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_kholinne_triceps_2018",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "wrist_radial_deviation",
    namePtPt: "Desvio radial resistido do punho",
    nameEn: "Resisted wrist radial deviation",
    familyId: "wrist_deviation",
    state: CanonicalArmPublicationState.approvedWithLimits,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Desvio radial do punho contra resistência com o antebraço controlado.",
    technicalDescriptionPtPt:
        "Exercício monoação destinado a carregar desvio radial do punho. A contribuição individual dos músculos depende da rotação do antebraço, do punho, do implemento e da amplitude.",
    requiredEquipmentIds: <String>["dumbbell"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar apoio e alavanca.",
      "Usar carga leve o suficiente para controlo fino.",
      "Alinhar a resistência com a ação pretendida.",
    ],
    startPositionPtPt:
        "Apoiar ou estabilizar o antebraço e começar numa posição confortável, sem desvio compensatório.",
    movementPtPt:
        "Executar desvio radial do punho contra a resistência e regressar lentamente.",
    endPositionPtPt:
        "Terminar antes de perder o apoio, o alinhamento ou a amplitude confortável.",
    trajectoryPtPt:
        "O implemento descreve um arco curto em torno da articulação-alvo.",
    cuesPtPt: <String>[
      "Manter o antebraço imóvel.",
      "Usar amplitude controlada.",
      "Evitar movimento dos dedos para substituir o punho.",
    ],
    commonErrorsPtPt: <String>[
      "Mover o cotovelo ou ombro.",
      "Usar carga que força amplitude terminal.",
      "Perder o alinhamento da mão.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["radiocarpal_joint", "midcarpal_joint"],
    actionIds: <String>["wrist_radial_deviation"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_ikeda_wrist_2025",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "wrist_roller",
    namePtPt: "Rolo de punho",
    nameEn: "Wrist roller",
    familyId: "wrist_flexion_extension",
    state: CanonicalArmPublicationState.approvedWithLimits,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Enrolar e desenrolar uma carga através de flexão e extensão repetida do punho e dos dedos.",
    technicalDescriptionPtPt:
        "Tarefa cíclica bilateral que combina punho, dedos e preensão. O sentido de enrolamento determina a predominância relativa, pelo que ambas as direções ficam como variantes.",
    requiredEquipmentIds: <String>["wrist_roller"],
    optionalEquipmentIds: <String>["weight_plate"],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Verificar corda e fixação.",
      "Escolher carga leve.",
      "Garantir espaço livre sob a carga.",
    ],
    startPositionPtPt:
        "Segurar o rolo com os braços numa posição estável e o cabo totalmente desenrolado.",
    movementPtPt:
        "Rodar alternadamente os punhos para enrolar a carga; desenrolar de forma controlada.",
    endPositionPtPt:
        "Terminar antes de o punho perder alinhamento ou a carga cair.",
    trajectoryPtPt: "A carga sobe e desce verticalmente enquanto o rolo gira.",
    cuesPtPt: <String>[
      "Usar movimentos curtos do punho.",
      "Manter ombros relaxados.",
      "Controlar também a descida.",
    ],
    commonErrorsPtPt: <String>[
      "Rodar todo o braço.",
      "Deixar a carga cair.",
      "Usar carga que força compensação do ombro.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>[
      "radiocarpal_joint",
      "midcarpal_joint",
      "finger_metacarpophalangeal_joints",
      "finger_proximal_interphalangeal_joints",
    ],
    actionIds: <String>[
      "wrist_flexion",
      "wrist_extension",
      "finger_mcp_flexion",
      "finger_pip_flexion",
    ],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_technical_inference",
    ],
  ),
  CanonicalArmExercise(
    id: "wrist_ulnar_deviation",
    namePtPt: "Desvio ulnar resistido do punho",
    nameEn: "Resisted wrist ulnar deviation",
    familyId: "wrist_deviation",
    state: CanonicalArmPublicationState.approvedWithLimits,
    isPublicEligible: true,
    shortDescriptionPtPt:
        "Desvio ulnar do punho contra resistência com o antebraço controlado.",
    technicalDescriptionPtPt:
        "Exercício monoação destinado a carregar desvio ulnar do punho. A contribuição individual dos músculos depende da rotação do antebraço, do punho, do implemento e da amplitude.",
    requiredEquipmentIds: <String>["dumbbell"],
    optionalEquipmentIds: <String>[],
    alternativeEquipmentIds: <String>[],
    setupPtPt: <String>[
      "Ajustar apoio e alavanca.",
      "Usar carga leve o suficiente para controlo fino.",
      "Alinhar a resistência com a ação pretendida.",
    ],
    startPositionPtPt:
        "Apoiar ou estabilizar o antebraço e começar numa posição confortável, sem desvio compensatório.",
    movementPtPt:
        "Executar desvio ulnar do punho contra a resistência e regressar lentamente.",
    endPositionPtPt:
        "Terminar antes de perder o apoio, o alinhamento ou a amplitude confortável.",
    trajectoryPtPt:
        "O implemento descreve um arco curto em torno da articulação-alvo.",
    cuesPtPt: <String>[
      "Manter o antebraço imóvel.",
      "Usar amplitude controlada.",
      "Evitar movimento dos dedos para substituir o punho.",
    ],
    commonErrorsPtPt: <String>[
      "Mover o cotovelo ou ombro.",
      "Usar carga que força amplitude terminal.",
      "Perder o alinhamento da mão.",
    ],
    stopConditionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    generalCautionsPtPt: <String>[
      "Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.",
      "A carga e a amplitude devem permitir controlo sem balanço ou compensação relevante.",
      "Respirar continuamente e evitar prender a respiração durante retenções prolongadas.",
    ],
    specialistReviewPtPt:
        "Não exigida em treino geral assintomático; necessária perante dor, lesão ou cirurgia.",
    jointIds: <String>["radiocarpal_joint", "midcarpal_joint"],
    actionIds: <String>["wrist_ulnar_deviation"],
    sourceIds: <String>[
      "src_base_muscular_kb_v0_1_1",
      "src_ikeda_wrist_2025",
      "src_technical_inference",
    ],
  ),
];
