import 'canonical_core_models.dart';

const canonicalTrainingIntentionsRegistryVersion = '0.4.1';

enum CanonicalTrainingIntentionType {
  adaptationOutcome,
  acutePreparation,
  targetedActivation,
  recoveryActivity,
  cooldownRegulation,
  preventionCapacity,
  functionalRestoration,
  technicalLearning,
  selfRegulation,
}

extension CanonicalTrainingIntentionTypeContract
    on CanonicalTrainingIntentionType {
  String get contractId => switch (this) {
    CanonicalTrainingIntentionType.adaptationOutcome => 'adaptation_outcome',
    CanonicalTrainingIntentionType.acutePreparation => 'acute_preparation',
    CanonicalTrainingIntentionType.targetedActivation => 'targeted_activation',
    CanonicalTrainingIntentionType.recoveryActivity => 'recovery_activity',
    CanonicalTrainingIntentionType.cooldownRegulation => 'cooldown_regulation',
    CanonicalTrainingIntentionType.preventionCapacity => 'prevention_capacity',
    CanonicalTrainingIntentionType.functionalRestoration =>
      'functional_restoration',
    CanonicalTrainingIntentionType.technicalLearning => 'technical_learning',
    CanonicalTrainingIntentionType.selfRegulation => 'self_regulation',
  };

  String get displayNamePtPt => switch (this) {
    CanonicalTrainingIntentionType.adaptationOutcome =>
      'Resultado de adapta\u00e7\u00e3o',
    CanonicalTrainingIntentionType.acutePreparation =>
      'Prepara\u00e7\u00e3o aguda',
    CanonicalTrainingIntentionType.targetedActivation =>
      'Ativa\u00e7\u00e3o direcionada',
    CanonicalTrainingIntentionType.recoveryActivity =>
      'Atividade de recupera\u00e7\u00e3o',
    CanonicalTrainingIntentionType.cooldownRegulation =>
      'Regula\u00e7\u00e3o do retorno \u00e0 calma',
    CanonicalTrainingIntentionType.preventionCapacity =>
      'Capacidade preventiva',
    CanonicalTrainingIntentionType.functionalRestoration =>
      'Restaura\u00e7\u00e3o funcional',
    CanonicalTrainingIntentionType.technicalLearning =>
      'Aprendizagem t\u00e9cnica',
    CanonicalTrainingIntentionType.selfRegulation => 'Autorregula\u00e7\u00e3o',
  };
}

enum CanonicalTrainingIntentionRole {
  principalCandidate,
  alternativePrimary,
  complementary,
  conditionalComplementary,
  hiddenAdvanced,
}

extension CanonicalTrainingIntentionRoleContract
    on CanonicalTrainingIntentionRole {
  String get contractId => switch (this) {
    CanonicalTrainingIntentionRole.principalCandidate => 'principal_candidate',
    CanonicalTrainingIntentionRole.alternativePrimary => 'alternative_primary',
    CanonicalTrainingIntentionRole.complementary => 'complementary',
    CanonicalTrainingIntentionRole.conditionalComplementary =>
      'conditional_complementary',
    CanonicalTrainingIntentionRole.hiddenAdvanced => 'hidden_advanced',
  };
}

enum CanonicalOperationalRiskTier { low, moderate, high, clinicallyRestricted }

extension CanonicalOperationalRiskTierContract on CanonicalOperationalRiskTier {
  String get contractId => switch (this) {
    CanonicalOperationalRiskTier.low => 'low',
    CanonicalOperationalRiskTier.moderate => 'moderate',
    CanonicalOperationalRiskTier.high => 'high',
    CanonicalOperationalRiskTier.clinicallyRestricted =>
      'clinically_restricted',
  };
}

enum CanonicalEvidenceBasis {
  strongFamilyEvidence,
  moderateFamilyEvidence,
  limitedFamilyEvidence,
  professionalConsensus,
  productOntologyInference,
}

extension CanonicalEvidenceBasisContract on CanonicalEvidenceBasis {
  String get contractId => switch (this) {
    CanonicalEvidenceBasis.strongFamilyEvidence => 'strong_family_evidence',
    CanonicalEvidenceBasis.moderateFamilyEvidence => 'moderate_family_evidence',
    CanonicalEvidenceBasis.limitedFamilyEvidence => 'limited_family_evidence',
    CanonicalEvidenceBasis.professionalConsensus => 'professional_consensus',
    CanonicalEvidenceBasis.productOntologyInference =>
      'product_ontology_inference',
  };
}

enum CanonicalTrainingHorizon {
  acute,
  chronic,
  acuteAndChronic,
  functionalReturnPhase,
}

extension CanonicalTrainingHorizonContract on CanonicalTrainingHorizon {
  String get contractId => switch (this) {
    CanonicalTrainingHorizon.acute => 'agudo',
    CanonicalTrainingHorizon.chronic => 'cr\u00f3nico',
    CanonicalTrainingHorizon.acuteAndChronic => 'agudo e cr\u00f3nico',
    CanonicalTrainingHorizon.functionalReturnPhase =>
      'fase de retorno funcional',
  };
}

enum CanonicalClinicalReviewRequirement { yes, no }

extension CanonicalClinicalReviewRequirementContract
    on CanonicalClinicalReviewRequirement {
  String get contractId => switch (this) {
    CanonicalClinicalReviewRequirement.yes => 'yes',
    CanonicalClinicalReviewRequirement.no => 'no',
  };
}

enum CanonicalTrainingPathStatus { compatible, incompatible }

extension CanonicalTrainingPathStatusContract on CanonicalTrainingPathStatus {
  String get contractId => switch (this) {
    CanonicalTrainingPathStatus.compatible => 'compatible',
    CanonicalTrainingPathStatus.incompatible => 'incompatible',
  };
}

enum CanonicalPathOperationalRiskModifier {
  inheritOnly,
  mayEscalateToHigh,
  clinicallyRestricted,
  notApplicable,
}

extension CanonicalPathOperationalRiskModifierContract
    on CanonicalPathOperationalRiskModifier {
  String get contractId => switch (this) {
    CanonicalPathOperationalRiskModifier.inheritOnly => 'inherit_only',
    CanonicalPathOperationalRiskModifier.mayEscalateToHigh =>
      'may_escalate_to_high',
    CanonicalPathOperationalRiskModifier.clinicallyRestricted =>
      'clinically_restricted',
    CanonicalPathOperationalRiskModifier.notApplicable => 'not_applicable',
  };
}

enum CanonicalPathClinicalReviewModifier {
  inheritOnly,
  required,
  notApplicable,
}

extension CanonicalPathClinicalReviewModifierContract
    on CanonicalPathClinicalReviewModifier {
  String get contractId => switch (this) {
    CanonicalPathClinicalReviewModifier.inheritOnly => 'inherit_only',
    CanonicalPathClinicalReviewModifier.required => 'required',
    CanonicalPathClinicalReviewModifier.notApplicable => 'not_applicable',
  };
}

class CanonicalTrainingPathKey {
  const CanonicalTrainingPathKey({
    required this.usageContextId,
    required this.capabilityRootId,
    required this.trainingConceptId,
  });

  final String usageContextId;
  final String capabilityRootId;
  final String trainingConceptId;

  String get contractId =>
      '$usageContextId/$capabilityRootId/$trainingConceptId';
}

class CanonicalTrainingIntentionDefinition {
  const CanonicalTrainingIntentionDefinition({
    required this.pillar,
    required this.type,
    required this.effectPtPt,
    required this.primaryTargetPtPt,
    required this.horizon,
    required this.declaredUsageContextIds,
    required this.declaredCapabilityRootIds,
    required this.declaredTrainingConceptIds,
    required this.occurrenceCount,
    required this.possibleRoles,
    required this.globallyIncompatibleAlternativeIds,
    required this.globallyCompatibleComplementaryIds,
    required this.relevantPopulationPtPt,
    required this.evidenceBasis,
    required this.sourceCodes,
    required this.evidenceLimitPtPt,
    required this.reviewState,
    required this.clinicalReviewRequired,
    required this.operationalRiskTier,
    required this.generalSafetyNotePtPt,
    required this.sourceOrder,
    required this.sourceRegistryVersion,
    required this.runtimeProvenanceId,
  });

  final CanonicalPillarDefinition pillar;
  final CanonicalTrainingIntentionType type;
  final String effectPtPt;
  final String primaryTargetPtPt;
  final CanonicalTrainingHorizon horizon;
  final List<String> declaredUsageContextIds;
  final List<String> declaredCapabilityRootIds;
  final List<String> declaredTrainingConceptIds;
  final int occurrenceCount;
  final List<CanonicalTrainingIntentionRole> possibleRoles;
  final List<String> globallyIncompatibleAlternativeIds;
  final List<String> globallyCompatibleComplementaryIds;
  final List<String> relevantPopulationPtPt;
  final CanonicalEvidenceBasis evidenceBasis;
  final List<String> sourceCodes;
  final String evidenceLimitPtPt;
  final String reviewState;
  final CanonicalClinicalReviewRequirement clinicalReviewRequired;
  final CanonicalOperationalRiskTier operationalRiskTier;
  final String generalSafetyNotePtPt;
  final int sourceOrder;
  final String sourceRegistryVersion;
  final String runtimeProvenanceId;
}

class CanonicalTrainingPathDefinition {
  const CanonicalTrainingPathDefinition({
    required this.sourceNumber,
    required this.key,
    required this.status,
    required this.rationalePtPt,
    required this.contextNotesPtPt,
    required this.alternativesAndComplementariesPtPt,
    required this.limitsPtPt,
    required this.progressionPtPt,
    required this.intensityAndPrescriptionPtPt,
    required this.eligibilityAndSafetyPtPt,
    required this.operationalRiskModifier,
    required this.operationalRiskModifierPtPt,
    required this.clinicalReviewModifier,
    required this.clinicalReviewModifierPtPt,
    required this.sourceRegistryVersion,
    required this.runtimeProvenanceId,
  });

  final int sourceNumber;
  final CanonicalTrainingPathKey key;
  final CanonicalTrainingPathStatus status;
  final String rationalePtPt;
  final String contextNotesPtPt;
  final String alternativesAndComplementariesPtPt;
  final String limitsPtPt;
  final String progressionPtPt;
  final String intensityAndPrescriptionPtPt;
  final String eligibilityAndSafetyPtPt;
  final CanonicalPathOperationalRiskModifier operationalRiskModifier;
  final String operationalRiskModifierPtPt;
  final CanonicalPathClinicalReviewModifier clinicalReviewModifier;
  final String clinicalReviewModifierPtPt;
  final String sourceRegistryVersion;
  final String runtimeProvenanceId;
}

class CanonicalPathIntentionLink {
  const CanonicalPathIntentionLink({
    required this.pathSourceNumber,
    required this.intentionId,
    required this.role,
    required this.displayOrder,
    required this.contextualLabelsPtPt,
    required this.sourceRegistryVersion,
    required this.runtimeProvenanceId,
  });

  final int pathSourceNumber;
  final String intentionId;
  final CanonicalTrainingIntentionRole role;
  final int displayOrder;
  final List<String> contextualLabelsPtPt;
  final String sourceRegistryVersion;
  final String runtimeProvenanceId;
}

class CanonicalResolvedPathIntention {
  const CanonicalResolvedPathIntention({
    required this.definition,
    required this.path,
    required this.link,
  });

  final CanonicalTrainingIntentionDefinition definition;
  final CanonicalTrainingPathDefinition path;
  final CanonicalPathIntentionLink link;
}
