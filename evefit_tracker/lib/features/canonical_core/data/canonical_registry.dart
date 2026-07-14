import '../models/canonical_core_models.dart';

class CanonicalRegistry {
  const CanonicalRegistry();

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

  static const approvedTrainingIntentions = <CanonicalPillarDefinition>[];
  static const approvedTrainingConcepts = <CanonicalPillarDefinition>[];

  static const approvedUsageContexts = <CanonicalPillarDefinition>[
    CanonicalPillarDefinition(
      id: 'warmup',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Aquecimento',
      descriptionPtPt:
          'Preparação gradual do corpo, movimento ou técnica para uma atividade posterior.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 0,
      iconKey: CanonicalCoreIconKey.warmup,
    ),
    CanonicalPillarDefinition(
      id: 'activation',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Ativação',
      descriptionPtPt:
          'Preparação específica de músculos, articulações, padrões ou controlo neuromotor.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 1,
      iconKey: CanonicalCoreIconKey.activation,
    ),
    CanonicalPillarDefinition(
      id: 'recovery_cooldown',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Recuperação e retorno à calma',
      descriptionPtPt:
          'Redução progressiva da intensidade e apoio à recuperação após esforço.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 2,
      iconKey: CanonicalCoreIconKey.recoveryCooldown,
    ),
    CanonicalPillarDefinition(
      id: 'prevention_adaptation_return',
      axis: CanonicalPillarAxis.usageContext,
      displayNamePtPt: 'Prevenção, adaptação e retorno à função',
      descriptionPtPt:
          'Desenvolvimento gradual de controlo, tolerância e capacidade de retorno a uma atividade.',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 3,
      iconKey: CanonicalCoreIconKey.preventionAdaptationReturn,
    ),
  ];

  static const approvedAttributeDefinitions = <CanonicalAttributeDefinition>[];

  List<CanonicalPillarDefinition> get approvedPillarValues =>
      List.unmodifiable([
        ...approvedCapabilityRoots,
        ...approvedTrainingIntentions,
        ...approvedTrainingConcepts,
        ...approvedUsageContexts,
      ]);

  Map<String, CanonicalPillarDefinition> get valueById => {
    for (final value in approvedPillarValues) value.id: value,
  };

  List<CanonicalPillarDefinition> valuesForAxis(CanonicalPillarAxis axis) =>
      List.unmodifiable(
        approvedPillarValues.where((value) => value.axis == axis).toList()
          ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder)),
      );

  bool isApprovedValue(String id) =>
      valueById[id]?.status == CanonicalDefinitionStatus.approved;

  String get schemaVersion => canonicalCoreSchemaVersion;
}
