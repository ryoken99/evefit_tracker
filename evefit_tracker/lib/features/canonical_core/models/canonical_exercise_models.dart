import 'canonical_core_models.dart';

const canonicalWave1ExerciseRegistryVersion = '0.1';
const canonicalWave1BeginnerContentVersion = '0.1.2';

enum CanonicalExerciseEntityType {
  canonicalExercise,
  techniqueDrill,
  exerciseVariant,
}

enum CanonicalExerciseRiskTier { low, moderate, high }

class CanonicalExerciseIdentity {
  const CanonicalExerciseIdentity({
    required this.canonicalDefinitionPtPt,
    required this.identitySummaryPtPt,
    required this.technicalPurposeImmediatePtPt,
    required this.exerciseFamilyId,
    required this.baseExerciseId,
    required this.variantOf,
    required this.synonymsPtPt,
    required this.commonEnglishNames,
    required this.siblingExerciseIds,
    required this.commonlyConfusedWith,
    required this.distinctionNotesPtPt,
  });

  final String canonicalDefinitionPtPt;
  final String identitySummaryPtPt;
  final String technicalPurposeImmediatePtPt;
  final String exerciseFamilyId;
  final String? baseExerciseId;
  final String? variantOf;
  final List<String> synonymsPtPt;
  final List<String> commonEnglishNames;
  final List<String> siblingExerciseIds;
  final List<String> commonlyConfusedWith;
  final String distinctionNotesPtPt;

  bool get isVariant => variantOf != null;
}

class CanonicalExerciseMechanics {
  const CanonicalExerciseMechanics({required this.values});

  final Map<String, Object?> values;
}

class CanonicalExerciseAnatomy {
  const CanonicalExerciseAnatomy({
    required this.primaryBodyRegions,
    required this.secondaryBodyRegions,
    required this.wholeBody,
    required this.primaryGroups,
    required this.secondaryGroups,
    required this.stabilizerGroups,
    required this.primaryTargetMuscles,
    required this.secondaryMuscles,
    required this.stabilizerMuscles,
    required this.isolatedTargetSupported,
  });

  final List<String> primaryBodyRegions;
  final List<String> secondaryBodyRegions;
  final bool wholeBody;
  final List<String> primaryGroups;
  final List<String> secondaryGroups;
  final List<String> stabilizerGroups;
  final List<String> primaryTargetMuscles;
  final List<String> secondaryMuscles;
  final List<String> stabilizerMuscles;
  final bool isolatedTargetSupported;
}

class CanonicalExerciseMaterialRequirements {
  const CanonicalExerciseMaterialRequirements({
    required this.requiredEquipment,
    required this.optionalEquipment,
    required this.alternativeEquipmentGroups,
    required this.noEquipmentSupported,
    required this.personalGearRequirements,
    required this.partnerRequired,
    required this.targetRequired,
    required this.spotterRequired,
    required this.supervisionRequirement,
  });

  final List<String> requiredEquipment;
  final List<String> optionalEquipment;
  final List<List<String>> alternativeEquipmentGroups;
  final bool noEquipmentSupported;
  final List<String> personalGearRequirements;
  final bool partnerRequired;
  final bool targetRequired;
  final bool spotterRequired;
  final String supervisionRequirement;
}

class CanonicalExerciseEnvironmentRequirements {
  const CanonicalExerciseEnvironmentRequirements({
    required this.indoorCompatible,
    required this.outdoorCompatible,
    required this.aquatic,
    required this.spaceRequirements,
    required this.minimumSpaceClass,
    required this.surfaceRequirements,
    required this.unsuitableSurfaces,
    required this.obstacleFreePathRequired,
    required this.genericLocationTypes,
    required this.requiredLocationFeatures,
    required this.prohibitedLocationFeatures,
  });

  final bool indoorCompatible;
  final bool outdoorCompatible;
  final bool aquatic;
  final Map<String, Object?> spaceRequirements;
  final String minimumSpaceClass;
  final List<String> surfaceRequirements;
  final List<String> unsuitableSurfaces;
  final bool obstacleFreePathRequired;
  final List<String> genericLocationTypes;
  final List<String> requiredLocationFeatures;
  final List<String> prohibitedLocationFeatures;
}

class CanonicalExerciseTechnicalDemand {
  const CanonicalExerciseTechnicalDemand({required this.values});

  final Map<String, Object?> values;
}

class CanonicalExerciseSafety {
  const CanonicalExerciseSafety({
    required this.operationalRiskTier,
    required this.principalRiskFactors,
    required this.contextualRiskModifiers,
    required this.environmentalRiskModifiers,
    required this.equipmentRiskModifiers,
    required this.clinicalReviewRequired,
    required this.eligibilityPrerequisites,
    required this.stopOrReduceSigns,
    required this.populationsRequiringAdaptation,
    required this.populationsRequiringReview,
    required this.supervisionTriggers,
  });

  final CanonicalExerciseRiskTier operationalRiskTier;
  final List<String> principalRiskFactors;
  final List<String> contextualRiskModifiers;
  final List<String> environmentalRiskModifiers;
  final List<String> equipmentRiskModifiers;
  final bool clinicalReviewRequired;
  final List<String> eligibilityPrerequisites;
  final List<String> stopOrReduceSigns;
  final List<String> populationsRequiringAdaptation;
  final List<String> populationsRequiringReview;
  final List<String> supervisionTriggers;
}

class CanonicalExerciseEvidence {
  const CanonicalExerciseEvidence({
    required this.evidenceBasis,
    required this.sourceCodes,
    required this.evidenceLimitPtPt,
  });

  final String evidenceBasis;
  final List<String> sourceCodes;
  final String evidenceLimitPtPt;
}

class CanonicalExerciseMediaState {
  const CanonicalExerciseMediaState({
    required this.imageRequired,
    required this.videoRequired,
    required this.status,
  });

  final bool imageRequired;
  final bool videoRequired;
  final String status;
}

class CanonicalExerciseRuntimeProvenance {
  const CanonicalExerciseRuntimeProvenance({
    required this.technicalBundleSha256,
    required this.beginnerContentBundleSha256,
    required this.classificationSpecSha256,
    required this.sourcePackageSha256,
    required this.sourceRegistry,
    required this.sourceCodes,
    required this.decisionLogReference,
    required this.generatorVersion,
  });

  final String technicalBundleSha256;
  final String beginnerContentBundleSha256;
  final String classificationSpecSha256;
  final String sourcePackageSha256;
  final String sourceRegistry;
  final List<String> sourceCodes;
  final String decisionLogReference;
  final String generatorVersion;
}

class CanonicalExerciseDefinition {
  const CanonicalExerciseDefinition({
    required this.id,
    required this.namePtPt,
    required this.entityType,
    required this.recordStatus,
    required this.catalogVersion,
    required this.primaryCapabilityRootId,
    required this.secondaryCapabilityRootIds,
    required this.identity,
    required this.mechanics,
    required this.anatomy,
    required this.material,
    required this.environment,
    required this.technicalDemand,
    required this.safety,
    required this.evidence,
    required this.prescriptionCapabilities,
    required this.media,
    required this.provenance,
  });

  final String id;
  final String namePtPt;
  final CanonicalExerciseEntityType entityType;
  final String recordStatus;
  final String catalogVersion;
  final String primaryCapabilityRootId;
  final List<String> secondaryCapabilityRootIds;
  final CanonicalExerciseIdentity identity;
  final CanonicalExerciseMechanics mechanics;
  final CanonicalExerciseAnatomy anatomy;
  final CanonicalExerciseMaterialRequirements material;
  final CanonicalExerciseEnvironmentRequirements environment;
  final CanonicalExerciseTechnicalDemand technicalDemand;
  final CanonicalExerciseSafety safety;
  final CanonicalExerciseEvidence evidence;
  final Map<String, Object?> prescriptionCapabilities;
  final CanonicalExerciseMediaState media;
  final CanonicalExerciseRuntimeProvenance provenance;
}

class CanonicalExerciseMovementPhase {
  const CanonicalExerciseMovementPhase({
    required this.namePtPt,
    required this.descriptionPtPt,
  });

  final String namePtPt;
  final String descriptionPtPt;
}

class CanonicalExerciseCommonError {
  const CanonicalExerciseCommonError({
    required this.errorPtPt,
    required this.howToRecognisePtPt,
    required this.correctionPtPt,
  });

  final String errorPtPt;
  final String howToRecognisePtPt;
  final String correctionPtPt;
}

class CanonicalExerciseVariantExplanation {
  const CanonicalExerciseVariantExplanation({
    required this.baseExerciseId,
    required this.whatChangesPtPt,
    required this.whatStaysTheSamePtPt,
    required this.whySeparatePtPt,
    required this.additionalEquipmentPtPt,
    required this.additionalSetupPtPt,
    required this.additionalRisksPtPt,
    required this.variantSpecificErrorsPtPt,
  });

  final String baseExerciseId;
  final String whatChangesPtPt;
  final String whatStaysTheSamePtPt;
  final String whySeparatePtPt;
  final String additionalEquipmentPtPt;
  final String additionalSetupPtPt;
  final String additionalRisksPtPt;
  final List<String> variantSpecificErrorsPtPt;
}

class CanonicalExerciseBeginnerContent {
  const CanonicalExerciseBeginnerContent({
    required this.exerciseId,
    required this.shortDescriptionPtPt,
    required this.beginnerDefinitionPtPt,
    required this.whatYouWillDoPtPt,
    required this.whyThisMovementExistsPtPt,
    required this.beforeYouStartPtPt,
    required this.equipmentSetupPtPt,
    required this.environmentSetupPtPt,
    required this.bodyReadinessCheckPtPt,
    required this.startingPositionPtPt,
    required this.startingPositionChecklistPtPt,
    required this.executionStepsPtPt,
    required this.movementPhasesPtPt,
    required this.breathingGuidancePtPt,
    required this.expectedSensationsPtPt,
    required this.unexpectedOrWarningSensationsPtPt,
    required this.principalCuesPtPt,
    required this.commonErrorsPtPt,
    required this.beginnerSimplificationsPtPt,
    required this.supervisionGuidancePtPt,
    required this.endingTheExercisePtPt,
    required this.safetyNotePtPt,
    required this.stopOrReduceSignsPtPt,
    required this.equipmentSafetyPtPt,
    required this.environmentSafetyPtPt,
    required this.confidencePtPt,
    required this.limitationsPtPt,
    required this.variantExplanation,
  });

  final String exerciseId;
  final String shortDescriptionPtPt;
  final String beginnerDefinitionPtPt;
  final String whatYouWillDoPtPt;
  final String whyThisMovementExistsPtPt;
  final List<String> beforeYouStartPtPt;
  final List<String> equipmentSetupPtPt;
  final List<String> environmentSetupPtPt;
  final List<String> bodyReadinessCheckPtPt;
  final String startingPositionPtPt;
  final List<String> startingPositionChecklistPtPt;
  final List<String> executionStepsPtPt;
  final List<CanonicalExerciseMovementPhase> movementPhasesPtPt;
  final String breathingGuidancePtPt;
  final List<String> expectedSensationsPtPt;
  final List<String> unexpectedOrWarningSensationsPtPt;
  final List<String> principalCuesPtPt;
  final List<CanonicalExerciseCommonError> commonErrorsPtPt;
  final List<String> beginnerSimplificationsPtPt;
  final String supervisionGuidancePtPt;
  final String endingTheExercisePtPt;
  final String safetyNotePtPt;
  final List<String> stopOrReduceSignsPtPt;
  final String equipmentSafetyPtPt;
  final String environmentSafetyPtPt;
  final String confidencePtPt;
  final List<String> limitationsPtPt;
  final CanonicalExerciseVariantExplanation? variantExplanation;
}

class CanonicalExercisePathKey {
  const CanonicalExercisePathKey({
    required this.usageContextId,
    required this.capabilityRootId,
    required this.trainingConceptId,
    required this.trainingIntentionId,
  });

  factory CanonicalExercisePathKey.fromQuery(CanonicalSearchQuery query) {
    if (query.criteria.length != 4) {
      throw ArgumentError.value(query, 'query', 'Four criteria are required.');
    }
    return CanonicalExercisePathKey(
      usageContextId: query.criteria[0].valueId,
      capabilityRootId: query.criteria[1].valueId,
      trainingConceptId: query.criteria[2].valueId,
      trainingIntentionId: query.criteria[3].valueId,
    );
  }

  final String usageContextId;
  final String capabilityRootId;
  final String trainingConceptId;
  final String trainingIntentionId;

  String get contractId =>
      '$usageContextId/$capabilityRootId/$trainingConceptId/'
      '$trainingIntentionId';

  @override
  bool operator ==(Object other) =>
      other is CanonicalExercisePathKey &&
      other.usageContextId == usageContextId &&
      other.capabilityRootId == capabilityRootId &&
      other.trainingConceptId == trainingConceptId &&
      other.trainingIntentionId == trainingIntentionId;

  @override
  int get hashCode => Object.hash(
    usageContextId,
    capabilityRootId,
    trainingConceptId,
    trainingIntentionId,
  );
}

class CanonicalExercisePathCompatibility {
  const CanonicalExercisePathCompatibility({
    required this.relationId,
    required this.exerciseId,
    required this.pathKey,
    required this.role,
    required this.rationalePtPt,
    required this.limitsPtPt,
    required this.contextualRiskModifier,
    required this.clinicalReviewModifier,
    required this.variantRequired,
    required this.variantBaseExerciseId,
    required this.equipmentCondition,
    required this.environmentCondition,
    required this.supervisionCondition,
    required this.eligibilityCondition,
    required this.canonicalPathNumber,
    required this.sourceOrder,
  });

  final String relationId;
  final String exerciseId;
  final CanonicalExercisePathKey pathKey;
  final String role;
  final String rationalePtPt;
  final String limitsPtPt;
  final String contextualRiskModifier;
  final String clinicalReviewModifier;
  final bool variantRequired;
  final String? variantBaseExerciseId;
  final Map<String, Object?> equipmentCondition;
  final Map<String, Object?> environmentCondition;
  final Map<String, Object?> supervisionCondition;
  final Map<String, Object?> eligibilityCondition;
  final int canonicalPathNumber;
  final int sourceOrder;
}

class CanonicalResolvedExercise {
  const CanonicalResolvedExercise({
    required this.definition,
    required this.content,
    required this.compatibility,
  });

  final CanonicalExerciseDefinition definition;
  final CanonicalExerciseBeginnerContent content;
  final CanonicalExercisePathCompatibility compatibility;
}
