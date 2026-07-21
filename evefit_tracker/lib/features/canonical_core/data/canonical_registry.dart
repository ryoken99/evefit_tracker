import '../models/canonical_core_models.dart';
import '../generated/training_intentions/training_intentions_registry.g.dart';
import '../generated/training_intentions/training_path_intention_links.g.dart';
import '../generated/training_intentions/training_paths_registry.g.dart';
import '../models/training_intention_models.dart';

class CanonicalRegistry {
  const CanonicalRegistry();

  static const trainingIntentionDefinitions =
      generatedCanonicalTrainingIntentionDefinitions;
  static const trainingPaths = generatedCanonicalTrainingPaths;
  static const pathIntentionLinks = generatedCanonicalPathIntentionLinks;

  static const axisDefinitions = <CanonicalPillarAxisDefinition>[
    CanonicalPillarAxisDefinition(
      axis: CanonicalPillarAxis.capabilityRoot,
      displayNamePtPt: 'Por capacidade',
      descriptionPtPt:
          'Escolhe a grande capacidade ou habilidade que queres desenvolver.',
      displayOrder: 0,
      iconKey: CanonicalCoreIconKey.capabilityAxis,
    ),
    CanonicalPillarAxisDefinition(
      axis: CanonicalPillarAxis.trainingIntention,
      displayNamePtPt: 'Por intenção',
      descriptionPtPt:
          'Escolhe a adaptação ou resultado específico que procuras.',
      displayOrder: 1,
      iconKey: CanonicalCoreIconKey.intentionAxis,
    ),
    CanonicalPillarAxisDefinition(
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Por conceito de treino',
      descriptionPtPt: 'Escolhe a ação funcional ou ideia de treino.',
      displayOrder: 2,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarAxisDefinition(
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Por contexto',
      descriptionPtPt:
          'Escolhe o momento ou finalidade em que o exercício será utilizado.',
      displayOrder: 3,
      iconKey: CanonicalCoreIconKey.contextAxis,
    ),
  ];

  static const approvedCapabilityRoots = <CanonicalPillarDefinition>[
    CanonicalPillarDefinition(
      id: 'muscular_capacity',
      axis: CanonicalPillarAxis.capabilityRoot,
      displayNamePtPt: 'Força e capacidade muscular',
      descriptionPtPt:
          'Capacidade de produzir, sustentar, controlar ou tolerar força muscular.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 0,
      iconKey: CanonicalCoreIconKey.muscularCapacity,
    ),
    CanonicalPillarDefinition(
      id: 'cardio_conditioning',
      axis: CanonicalPillarAxis.capabilityRoot,
      displayNamePtPt: 'Cardio e condicionamento',
      descriptionPtPt:
          'Capacidade cardiorrespiratória, resistência geral e capacidade de sustentar ou recuperar de esforço.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 1,
      iconKey: CanonicalCoreIconKey.cardioConditioning,
    ),
    CanonicalPillarDefinition(
      id: 'speed_power',
      axis: CanonicalPillarAxis.capabilityRoot,
      displayNamePtPt: 'Velocidade e potência',
      descriptionPtPt: 'Capacidade de produzir movimento ou força rapidamente.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 2,
      iconKey: CanonicalCoreIconKey.speedPower,
    ),
    CanonicalPillarDefinition(
      id: 'mobility',
      axis: CanonicalPillarAxis.capabilityRoot,
      displayNamePtPt: 'Mobilidade',
      descriptionPtPt:
          'Amplitude ativa, controlo articular e acesso controlado a posições.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 3,
      iconKey: CanonicalCoreIconKey.mobility,
    ),
    CanonicalPillarDefinition(
      id: 'flexibility',
      axis: CanonicalPillarAxis.capabilityRoot,
      displayNamePtPt: 'Flexibilidade',
      descriptionPtPt:
          'Amplitude passiva e tolerância ao alongamento dos tecidos.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 4,
      iconKey: CanonicalCoreIconKey.flexibility,
    ),
    CanonicalPillarDefinition(
      id: 'motor_control_coordination',
      axis: CanonicalPillarAxis.capabilityRoot,
      displayNamePtPt: 'Controlo motor e coordenação',
      descriptionPtPt:
          'Organização, precisão, equilíbrio, estabilidade, reação e controlo do movimento.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 5,
      iconKey: CanonicalCoreIconKey.motorControlCoordination,
    ),
    CanonicalPillarDefinition(
      id: 'technique_skill',
      axis: CanonicalPillarAxis.capabilityRoot,
      displayNamePtPt: 'Técnica e habilidade',
      descriptionPtPt:
          'Aprendizagem ou aperfeiçoamento de uma técnica, gesto ou habilidade concreta.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 6,
      iconKey: CanonicalCoreIconKey.techniqueSkill,
    ),
    CanonicalPillarDefinition(
      id: 'breathing_regulation',
      axis: CanonicalPillarAxis.capabilityRoot,
      displayNamePtPt: 'Respiração e regulação corporal',
      descriptionPtPt:
          'Mecânica respiratória, controlo da respiração, consciência e regulação corporal.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 7,
      iconKey: CanonicalCoreIconKey.breathingRegulation,
    ),
  ];

  static final List<CanonicalPillarDefinition> approvedTrainingIntentions =
      _runtime.trainingIntentionPillars;
  static const approvedTrainingConcepts = <CanonicalPillarDefinition>[
    CanonicalPillarDefinition(
      id: 'overcome_resistance',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Vencer resistência',
      descriptionPtPt:
          'Produzir força suficiente para deslocar o corpo, uma carga ou um implemento contra uma resistência.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 0,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'control_resistance',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Controlar resistência',
      descriptionPtPt:
          'Regular, desacelerar ou travar o movimento enquanto uma resistência atua.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 1,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'sustain_resistance',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Sustentar resistência',
      descriptionPtPt:
          'Manter uma posição, carga ou tensão contra uma força, sem deslocamento relevante.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 2,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'loaded_carry',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Transportar carga',
      descriptionPtPt:
          'Deslocar o corpo enquanto se suporta e controla uma carga.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 3,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'cyclic_locomotion',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Locomoção cíclica',
      descriptionPtPt:
          'Deslocar o corpo através da repetição regular de um padrão locomotor.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 4,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'cyclic_propulsion',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Propulsão cíclica',
      descriptionPtPt:
          'Produzir repetidamente força para deslocar o corpo, um veículo ou um implemento através de ciclos sucessivos.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 5,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'repetitive_rhythmic_movement',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Movimento rítmico repetitivo',
      descriptionPtPt:
          'Repetir regularmente um movimento corporal simples para sustentar esforço.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 6,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'repeated_multidirectional_displacement',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Deslocamento multidirecional repetido',
      descriptionPtPt:
          'Deslocar-se repetidamente em várias direções, mudando sentido, trajetória ou orientação.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 7,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'repeated_motor_sequence',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Sequência motora repetida',
      descriptionPtPt:
          'Encadear várias ações diferentes numa sequência que se repete continuamente.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 8,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'explosive_acceleration',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Aceleração explosiva',
      descriptionPtPt:
          'Aumentar rapidamente a velocidade do corpo, de um segmento corporal ou de um implemento.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 9,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'ballistic_projection',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Projeção explosiva',
      descriptionPtPt:
          'Produzir impulso suficiente para lançar o corpo ou um implemento numa trajetória livre.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 10,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'elastic_reactive_action',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Ação elástico-reativa',
      descriptionPtPt:
          'Absorver rapidamente energia mecânica e reutilizá-la numa ação imediata de propulsão.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 11,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'braking_redirection',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Travagem e redirecionamento',
      descriptionPtPt:
          'Reduzir ou interromper rapidamente o movimento e produzir uma nova aceleração noutra direção.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 12,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'active_joint_exploration',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Exploração articular ativa',
      descriptionPtPt:
          'Mover voluntariamente uma articulação através da amplitude disponível, com controlo.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 13,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'range_transition',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Transição em amplitude',
      descriptionPtPt:
          'Passar entre posições que exigem diferentes amplitudes articulares.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 14,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'integrated_chain_mobility',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Mobilidade integrada em cadeia',
      descriptionPtPt:
          'Combinar o movimento de várias articulações numa ação contínua e coordenada.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 15,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'supported_loaded_mobility',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Mobilidade sob suporte ou carga',
      descriptionPtPt:
          'Expressar amplitude enquanto o corpo suporta peso ou controla uma resistência.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 16,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'segmental_dissociation',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Dissociação segmentar',
      descriptionPtPt:
          'Mover uma região corporal mantendo outras regiões relativamente estáveis ou independentes.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 17,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'sustained_lengthening',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Alongamento sustentado',
      descriptionPtPt:
          'Manter um tecido ou região corporal numa posição alongada durante determinado período.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 18,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'dynamic_lengthening',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Alongamento dinâmico',
      descriptionPtPt:
          'Entrar e sair repetidamente de uma amplitude que alonga os tecidos envolvidos.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 19,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'assisted_lengthening',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Alongamento assistido',
      descriptionPtPt:
          'Utilizar uma força externa para posicionar ou aprofundar uma região corporal em alongamento.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 20,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'postural_stabilization',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Estabilização postural',
      descriptionPtPt:
          'Manter ou recuperar uma organização corporal estável durante uma posição ou movimento.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 21,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'base_of_support_control',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Controlo da base de apoio',
      descriptionPtPt:
          'Gerir a relação entre o centro de massa e a base de apoio para conservar ou recuperar equilíbrio.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 22,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'rhythm_synchronization',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Ritmo e sincronização',
      descriptionPtPt:
          'Organizar movimentos segundo uma sequência temporal, cadência ou relação coordenada.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 23,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'reactive_adjustment',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Ajuste reativo',
      descriptionPtPt:
          'Modificar rapidamente a ação corporal em resposta a uma alteração, perturbação ou estímulo.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 24,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'isolated_technical_practice',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Prática técnica isolada',
      descriptionPtPt:
          'Praticar uma ação técnica ou uma parte específica dela fora da situação completa.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 25,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'contextual_technical_application',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Aplicação técnica contextualizada',
      descriptionPtPt:
          'Executar uma técnica dentro das condições, relações ou exigências em que deverá ser utilizada.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 26,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'target_oriented_precision',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Precisão orientada a alvo',
      descriptionPtPt:
          'Executar uma ação procurando atingir um alvo espacial, temporal ou mecânico definido.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 27,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'stimulus_response_decision',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Resposta a estímulo e decisão',
      descriptionPtPt:
          'Escolher e executar uma ação adequada em resposta a informação ou estímulos relevantes.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 28,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'technical_variability_adaptation',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Adaptação técnica à variabilidade',
      descriptionPtPt:
          'Preservar a função essencial de uma técnica enquanto se ajusta a mudanças nas condições de execução.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 29,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'voluntary_breath_cycle_control',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Controlo voluntário do ciclo respiratório',
      descriptionPtPt:
          'Regular conscientemente a inspiração, expiração, pausas e ritmo respiratório.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 30,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'breath_movement_synchronization',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Sincronização entre respiração e movimento',
      descriptionPtPt:
          'Coordenar as fases da respiração com posições, movimentos ou momentos de produção de esforço.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 31,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'internal_pressure_management',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Gestão da pressão interna',
      descriptionPtPt:
          'Criar, manter ou libertar pressão interna para apoiar estabilidade, transferência de força ou controlo corporal.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 32,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'autonomic_modulation',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Modulação autonómica',
      descriptionPtPt:
          'Utilizar ações respiratórias e corporais para alterar o estado de ativação ou recuperação do organismo.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 33,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
    CanonicalPillarDefinition(
      id: 'interoceptive_monitoring_adjustment',
      axis: CanonicalPillarAxis.trainingConcept,
      displayNamePtPt: 'Monitorização e ajuste interoceptivo',
      descriptionPtPt:
          'Perceber sinais internos do corpo e ajustar conscientemente respiração, tensão, posição ou ritmo.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 34,
      iconKey: CanonicalCoreIconKey.conceptAxis,
    ),
  ];

  static const capabilityConceptRelations =
      <CanonicalCapabilityConceptRelation>[
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'muscular_capacity',
          trainingConceptId: 'overcome_resistance',
          displayOrder: 1,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'muscular_capacity',
          trainingConceptId: 'control_resistance',
          displayOrder: 2,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'muscular_capacity',
          trainingConceptId: 'sustain_resistance',
          displayOrder: 3,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'muscular_capacity',
          trainingConceptId: 'loaded_carry',
          displayOrder: 4,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'cardio_conditioning',
          trainingConceptId: 'cyclic_locomotion',
          displayOrder: 1,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'cardio_conditioning',
          trainingConceptId: 'cyclic_propulsion',
          displayOrder: 2,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'cardio_conditioning',
          trainingConceptId: 'repetitive_rhythmic_movement',
          displayOrder: 3,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'cardio_conditioning',
          trainingConceptId: 'repeated_multidirectional_displacement',
          displayOrder: 4,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'cardio_conditioning',
          trainingConceptId: 'repeated_motor_sequence',
          displayOrder: 5,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'speed_power',
          trainingConceptId: 'explosive_acceleration',
          displayOrder: 1,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'speed_power',
          trainingConceptId: 'ballistic_projection',
          displayOrder: 2,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'speed_power',
          trainingConceptId: 'elastic_reactive_action',
          displayOrder: 3,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'speed_power',
          trainingConceptId: 'braking_redirection',
          displayOrder: 4,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'speed_power',
          trainingConceptId: 'cyclic_locomotion',
          displayOrder: 5,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'speed_power',
          trainingConceptId: 'repeated_multidirectional_displacement',
          displayOrder: 6,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'mobility',
          trainingConceptId: 'active_joint_exploration',
          displayOrder: 1,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'mobility',
          trainingConceptId: 'range_transition',
          displayOrder: 2,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'mobility',
          trainingConceptId: 'integrated_chain_mobility',
          displayOrder: 3,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'mobility',
          trainingConceptId: 'supported_loaded_mobility',
          displayOrder: 4,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'mobility',
          trainingConceptId: 'segmental_dissociation',
          displayOrder: 5,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'flexibility',
          trainingConceptId: 'sustained_lengthening',
          displayOrder: 1,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'flexibility',
          trainingConceptId: 'dynamic_lengthening',
          displayOrder: 2,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'flexibility',
          trainingConceptId: 'assisted_lengthening',
          displayOrder: 3,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'motor_control_coordination',
          trainingConceptId: 'postural_stabilization',
          displayOrder: 1,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'motor_control_coordination',
          trainingConceptId: 'base_of_support_control',
          displayOrder: 2,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'motor_control_coordination',
          trainingConceptId: 'rhythm_synchronization',
          displayOrder: 3,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'motor_control_coordination',
          trainingConceptId: 'reactive_adjustment',
          displayOrder: 4,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'motor_control_coordination',
          trainingConceptId: 'segmental_dissociation',
          displayOrder: 5,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'motor_control_coordination',
          trainingConceptId: 'repeated_motor_sequence',
          displayOrder: 6,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'technique_skill',
          trainingConceptId: 'isolated_technical_practice',
          displayOrder: 1,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'technique_skill',
          trainingConceptId: 'contextual_technical_application',
          displayOrder: 2,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'technique_skill',
          trainingConceptId: 'target_oriented_precision',
          displayOrder: 3,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'technique_skill',
          trainingConceptId: 'stimulus_response_decision',
          displayOrder: 4,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'technique_skill',
          trainingConceptId: 'technical_variability_adaptation',
          displayOrder: 5,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'technique_skill',
          trainingConceptId: 'repeated_motor_sequence',
          displayOrder: 6,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'breathing_regulation',
          trainingConceptId: 'voluntary_breath_cycle_control',
          displayOrder: 1,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'breathing_regulation',
          trainingConceptId: 'breath_movement_synchronization',
          displayOrder: 2,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'breathing_regulation',
          trainingConceptId: 'internal_pressure_management',
          displayOrder: 3,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'breathing_regulation',
          trainingConceptId: 'autonomic_modulation',
          displayOrder: 4,
        ),
        CanonicalCapabilityConceptRelation(
          capabilityRootId: 'breathing_regulation',
          trainingConceptId: 'interoceptive_monitoring_adjustment',
          displayOrder: 5,
        ),
      ];

  static const approvedUsageContexts = <CanonicalPillarDefinition>[
    CanonicalPillarDefinition(
      id: 'main_training',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Treino principal',
      descriptionPtPt:
          'O exercício constitui o estímulo central da sessão para desenvolver uma capacidade ou adaptação.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 0,
      iconKey: CanonicalCoreIconKey.mainTraining,
    ),
    CanonicalPillarDefinition(
      id: 'warmup',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Aquecimento',
      descriptionPtPt:
          'O exercício prepara progressivamente o corpo ou a técnica para uma tarefa posterior mais exigente.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 1,
      iconKey: CanonicalCoreIconKey.warmup,
    ),
    CanonicalPillarDefinition(
      id: 'activation',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Ativação',
      descriptionPtPt:
          'O exercício prepara de forma focalizada músculos, articulações, padrões ou controlo neuromotor antes da tarefa principal.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 2,
      iconKey: CanonicalCoreIconKey.activation,
    ),
    CanonicalPillarDefinition(
      id: 'recovery',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Recuperação',
      descriptionPtPt:
          'Atividade deliberadamente leve numa sessão posterior ou mais tarde no mesmo dia, sem prometer acelerar a recuperação fisiológica ou o desempenho futuro.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 3,
      iconKey: CanonicalCoreIconKey.recovery,
    ),
    CanonicalPillarDefinition(
      id: 'cooldown',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Retorno à calma',
      descriptionPtPt:
          'Transição imediata após o esforço para reduzir a exigência e regressar a maior conforto.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 4,
      iconKey: CanonicalCoreIconKey.cooldown,
    ),
    CanonicalPillarDefinition(
      id: 'prevention',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Prevenção',
      descriptionPtPt:
          'Desenvolvimento de capacidade, controlo ou tolerância perante exigências previsíveis numa pessoa funcional, sem garantir prevenção de lesão.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 5,
      iconKey: CanonicalCoreIconKey.prevention,
    ),
    CanonicalPillarDefinition(
      id: 'return_to_function',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Retorno à função',
      descriptionPtPt:
          'Recuperação ou reintrodução de uma função reduzida ou interrompida, dependente de critérios de elegibilidade e sem equivaler a reabilitação ou autorização de retorno.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 6,
      iconKey: CanonicalCoreIconKey.returnToFunction,
    ),
  ];

  static const approvedAttributeDefinitions = <CanonicalAttributeDefinition>[];

  static final _CanonicalRegistryRuntime _runtime = _CanonicalRegistryRuntime(
    definitions: trainingIntentionDefinitions,
    paths: trainingPaths,
    links: pathIntentionLinks,
    capabilityRoots: approvedCapabilityRoots,
    trainingConcepts: approvedTrainingConcepts,
    usageContexts: approvedUsageContexts,
    capabilityConceptRelations: capabilityConceptRelations,
  );

  List<CanonicalPillarDefinition> get approvedPillarValues =>
      _runtime.approvedPillarValues;

  Map<String, CanonicalPillarDefinition> get valueById => _runtime.valueById;

  Map<String, CanonicalTrainingIntentionDefinition>
  get trainingIntentionDefinitionById =>
      _runtime.trainingIntentionDefinitionById;

  Map<CanonicalTrainingPathKey, CanonicalTrainingPathDefinition>
  get pathByKey => _runtime.pathByKey;

  Map<String, CanonicalTrainingPathDefinition> get pathByContractId =>
      _runtime.pathByContractId;

  Map<CanonicalTrainingPathKey, List<CanonicalPathIntentionLink>>
  get linksByPathKey => _runtime.linksByPathKey;

  Map<String, List<CanonicalTrainingPathDefinition>> get pathsByIntentionId =>
      _runtime.pathsByIntentionId;

  List<CanonicalPillarDefinition> valuesForAxis(CanonicalPillarAxis axis) =>
      _runtime.valuesByAxis[axis] ?? const <CanonicalPillarDefinition>[];

  bool isApprovedValue(String id) =>
      valueById[id]?.status == CanonicalDefinitionStatus.approved;

  List<CanonicalCapabilityConceptRelation> relationsForCapability(
    String capabilityRootId,
  ) =>
      _runtime.relationsByCapability[capabilityRootId] ??
      const <CanonicalCapabilityConceptRelation>[];

  List<CanonicalPillarDefinition> trainingConceptsForCapability(
    String capabilityRootId,
  ) =>
      _runtime.trainingConceptsByCapability[capabilityRootId] ??
      const <CanonicalPillarDefinition>[];

  List<CanonicalPillarDefinition> trainingConceptsForPath(
    String usageContextId,
    String capabilityRootId,
  ) =>
      _runtime
          .compatibleConceptsByContextCapability[_contextCapabilityContractId(
        usageContextId,
        capabilityRootId,
      )] ??
      const <CanonicalPillarDefinition>[];

  CanonicalTrainingPathDefinition? pathForKey(CanonicalTrainingPathKey key) =>
      pathByKey[key];

  CanonicalTrainingPathDefinition? pathForContractId(String contractId) =>
      pathByContractId[contractId];

  List<CanonicalTrainingPathDefinition> pathsForIntention(String intentionId) =>
      pathsByIntentionId[intentionId] ??
      const <CanonicalTrainingPathDefinition>[];

  List<CanonicalTrainingPathDefinition> pathsForContextAndCapability(
    String usageContextId,
    String capabilityRootId,
  ) =>
      _runtime.pathsByContextCapability[_contextCapabilityContractId(
        usageContextId,
        capabilityRootId,
      )] ??
      const <CanonicalTrainingPathDefinition>[];

  List<CanonicalPathIntentionLink> linksForPath(CanonicalTrainingPathKey key) =>
      linksByPathKey[key] ?? const <CanonicalPathIntentionLink>[];

  List<CanonicalResolvedPathIntention> resolvedOptionsForPath(
    CanonicalTrainingPathKey key,
  ) =>
      _runtime.resolvedOptionsByPathKey[key] ??
      const <CanonicalResolvedPathIntention>[];

  bool hasCompatibleResolvedOptions(CanonicalTrainingPathKey key) {
    final path = pathByKey[key];
    return path != null &&
        path.status == CanonicalTrainingPathStatus.compatible &&
        resolvedOptionsForPath(key).isNotEmpty;
  }

  String get schemaVersion => canonicalCoreSchemaVersion;
}

class _CanonicalRegistryRuntime {
  _CanonicalRegistryRuntime({
    required List<CanonicalTrainingIntentionDefinition> definitions,
    required List<CanonicalTrainingPathDefinition> paths,
    required List<CanonicalPathIntentionLink> links,
    required List<CanonicalPillarDefinition> capabilityRoots,
    required List<CanonicalPillarDefinition> trainingConcepts,
    required List<CanonicalPillarDefinition> usageContexts,
    required List<CanonicalCapabilityConceptRelation>
    capabilityConceptRelations,
  }) {
    trainingIntentionDefinitions = List.unmodifiable(definitions);
    trainingPaths = List.unmodifiable(paths);
    pathIntentionLinks = List.unmodifiable(links);
    trainingIntentionPillars = List<CanonicalPillarDefinition>.unmodifiable(
      trainingIntentionDefinitions.map((definition) => definition.pillar),
    );
    approvedPillarValues = List<CanonicalPillarDefinition>.unmodifiable([
      ...capabilityRoots,
      ...trainingIntentionPillars,
      ...trainingConcepts,
      ...usageContexts,
    ]);
    valueById = Map<String, CanonicalPillarDefinition>.unmodifiable({
      for (final value in approvedPillarValues) value.id: value,
    });
    trainingIntentionDefinitionById =
        Map<String, CanonicalTrainingIntentionDefinition>.unmodifiable({
          for (final definition in trainingIntentionDefinitions)
            definition.pillar.id: definition,
        });
    valuesByAxis =
        Map<CanonicalPillarAxis, List<CanonicalPillarDefinition>>.unmodifiable({
          for (final axis in CanonicalPillarAxis.values)
            axis: List<CanonicalPillarDefinition>.unmodifiable(
              approvedPillarValues
                  .where((value) => value.axis == axis)
                  .toList(growable: false)
                ..sort(
                  (left, right) =>
                      left.displayOrder.compareTo(right.displayOrder),
                ),
            ),
        });

    final mutableRelationsByCapability =
        <String, List<CanonicalCapabilityConceptRelation>>{};
    for (final relation in capabilityConceptRelations) {
      (mutableRelationsByCapability[relation.capabilityRootId] ??= []).add(
        relation,
      );
    }
    relationsByCapability =
        Map<String, List<CanonicalCapabilityConceptRelation>>.unmodifiable({
          for (final entry in mutableRelationsByCapability.entries)
            entry.key: List<CanonicalCapabilityConceptRelation>.unmodifiable(
              [...entry.value]..sort(
                (left, right) =>
                    left.displayOrder.compareTo(right.displayOrder),
              ),
            ),
        });
    trainingConceptsByCapability =
        Map<String, List<CanonicalPillarDefinition>>.unmodifiable({
          for (final entry in relationsByCapability.entries)
            entry.key: List<CanonicalPillarDefinition>.unmodifiable(
              entry.value
                  .map((relation) => valueById[relation.trainingConceptId]!)
                  .toList(growable: false),
            ),
        });

    pathByKey =
        Map<
          CanonicalTrainingPathKey,
          CanonicalTrainingPathDefinition
        >.unmodifiable({for (final path in trainingPaths) path.key: path});
    pathByContractId =
        Map<String, CanonicalTrainingPathDefinition>.unmodifiable({
          for (final path in trainingPaths) path.key.contractId: path,
        });
    final mutablePathsByContextCapability =
        <String, List<CanonicalTrainingPathDefinition>>{};
    for (final path in trainingPaths) {
      (mutablePathsByContextCapability[_contextCapabilityContractId(
                path.key.usageContextId,
                path.key.capabilityRootId,
              )] ??=
              [])
          .add(path);
    }
    pathsByContextCapability =
        Map<String, List<CanonicalTrainingPathDefinition>>.unmodifiable({
          for (final entry in mutablePathsByContextCapability.entries)
            entry.key: List<CanonicalTrainingPathDefinition>.unmodifiable(
              [...entry.value]..sort(
                (left, right) =>
                    left.sourceNumber.compareTo(right.sourceNumber),
              ),
            ),
        });

    final mutableLinksByPathKey =
        <CanonicalTrainingPathKey, List<CanonicalPathIntentionLink>>{};
    final mutablePathsByIntention =
        <String, List<CanonicalTrainingPathDefinition>>{};
    for (final link in pathIntentionLinks) {
      final path = trainingPaths[link.pathSourceNumber - 1];
      (mutableLinksByPathKey[path.key] ??= []).add(link);
      (mutablePathsByIntention[link.intentionId] ??= []).add(path);
    }
    linksByPathKey =
        Map<
          CanonicalTrainingPathKey,
          List<CanonicalPathIntentionLink>
        >.unmodifiable({
          for (final entry in mutableLinksByPathKey.entries)
            entry.key: List<CanonicalPathIntentionLink>.unmodifiable(
              [...entry.value]..sort(
                (left, right) =>
                    left.displayOrder.compareTo(right.displayOrder),
              ),
            ),
        });
    pathsByIntentionId =
        Map<String, List<CanonicalTrainingPathDefinition>>.unmodifiable({
          for (final entry in mutablePathsByIntention.entries)
            entry.key: List<CanonicalTrainingPathDefinition>.unmodifiable(
              [...entry.value]..sort(
                (left, right) =>
                    left.sourceNumber.compareTo(right.sourceNumber),
              ),
            ),
        });

    resolvedOptionsByPathKey =
        Map<
          CanonicalTrainingPathKey,
          List<CanonicalResolvedPathIntention>
        >.unmodifiable({
          for (final path in trainingPaths)
            path.key: List<CanonicalResolvedPathIntention>.unmodifiable([
              for (final link
                  in linksByPathKey[path.key] ??
                      const <CanonicalPathIntentionLink>[])
                CanonicalResolvedPathIntention(
                  definition:
                      trainingIntentionDefinitionById[link.intentionId]!,
                  path: path,
                  link: link,
                ),
            ]),
        });
    compatibleConceptsByContextCapability =
        Map<String, List<CanonicalPillarDefinition>>.unmodifiable({
          for (final entry in pathsByContextCapability.entries)
            entry.key: List<CanonicalPillarDefinition>.unmodifiable([
              for (final concept
                  in trainingConceptsByCapability[entry
                          .value
                          .first
                          .key
                          .capabilityRootId] ??
                      const <CanonicalPillarDefinition>[])
                if (entry.value.any(
                  (path) =>
                      path.key.trainingConceptId == concept.id &&
                      path.status == CanonicalTrainingPathStatus.compatible &&
                      (resolvedOptionsByPathKey[path.key] ??
                              const <CanonicalResolvedPathIntention>[])
                          .isNotEmpty,
                ))
                  concept,
            ]),
        });
  }

  late final List<CanonicalTrainingIntentionDefinition>
  trainingIntentionDefinitions;
  late final List<CanonicalTrainingPathDefinition> trainingPaths;
  late final List<CanonicalPathIntentionLink> pathIntentionLinks;
  late final List<CanonicalPillarDefinition> trainingIntentionPillars;
  late final List<CanonicalPillarDefinition> approvedPillarValues;
  late final Map<String, CanonicalPillarDefinition> valueById;
  late final Map<String, CanonicalTrainingIntentionDefinition>
  trainingIntentionDefinitionById;
  late final Map<CanonicalPillarAxis, List<CanonicalPillarDefinition>>
  valuesByAxis;
  late final Map<String, List<CanonicalCapabilityConceptRelation>>
  relationsByCapability;
  late final Map<String, List<CanonicalPillarDefinition>>
  trainingConceptsByCapability;
  late final Map<CanonicalTrainingPathKey, CanonicalTrainingPathDefinition>
  pathByKey;
  late final Map<String, CanonicalTrainingPathDefinition> pathByContractId;
  late final Map<String, List<CanonicalTrainingPathDefinition>>
  pathsByContextCapability;
  late final Map<CanonicalTrainingPathKey, List<CanonicalPathIntentionLink>>
  linksByPathKey;
  late final Map<String, List<CanonicalTrainingPathDefinition>>
  pathsByIntentionId;
  late final Map<CanonicalTrainingPathKey, List<CanonicalResolvedPathIntention>>
  resolvedOptionsByPathKey;
  late final Map<String, List<CanonicalPillarDefinition>>
  compatibleConceptsByContextCapability;
}

String _contextCapabilityContractId(
  String usageContextId,
  String capabilityRootId,
) => '$usageContextId/$capabilityRootId';
