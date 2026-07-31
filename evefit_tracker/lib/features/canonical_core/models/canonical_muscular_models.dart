enum CanonicalArmPublicationState {
  approvedPublic,
  approvedWithLimits,
  specialistReview,
}

enum CanonicalArmMuscleRole {
  primary,
  primaryContextual,
  secondary,
  synergist,
  stabilizer,
  neutralizer,
  antagonistControl,
  gripLimiter,
  specialistReview,
}

enum CanonicalArmEquipmentRelationType { required, optional, alternative }

class CanonicalMuscleRegion {
  const CanonicalMuscleRegion({
    required this.id,
    required this.namePtPt,
    required this.bodyArea,
    required this.regionType,
    required this.isPublic,
  });

  final String id;
  final String namePtPt;
  final String bodyArea;
  final String regionType;
  final bool isPublic;
}

class CanonicalMuscleGroup {
  const CanonicalMuscleGroup({
    required this.id,
    required this.regionId,
    required this.namePtPt,
    required this.groupType,
    required this.memberIds,
    required this.isPublic,
  });

  final String id;
  final String regionId;
  final String namePtPt;
  final String groupType;
  final List<String> memberIds;
  final bool isPublic;
}

class CanonicalMuscle {
  const CanonicalMuscle({
    required this.id,
    required this.namePtPt,
    required this.nameEn,
    required this.nameLatin,
    required this.regionId,
    required this.groupId,
    required this.descriptionPtPt,
    required this.originPtPt,
    required this.insertionPtPt,
    required this.innervationPtPt,
    required this.architecture,
    required this.componentIds,
    required this.jointIds,
    required this.actionIds,
    required this.practicalEmphasis,
    required this.trainabilitySummaryPtPt,
    required this.limitationsPtPt,
    required this.confidence,
    required this.isPublic,
  });

  final String id;
  final String namePtPt;
  final String nameEn;
  final String nameLatin;
  final String regionId;
  final String groupId;
  final String descriptionPtPt;
  final String originPtPt;
  final String insertionPtPt;
  final String innervationPtPt;
  final String architecture;
  final List<String> componentIds;
  final List<String> jointIds;
  final List<String> actionIds;
  final String practicalEmphasis;
  final String trainabilitySummaryPtPt;
  final String limitationsPtPt;
  final String confidence;
  final bool isPublic;
}

class CanonicalMuscleComponent {
  const CanonicalMuscleComponent({
    required this.id,
    required this.muscleId,
    required this.namePtPt,
    required this.descriptionPtPt,
  });

  final String id;
  final String muscleId;
  final String namePtPt;
  final String descriptionPtPt;
}

class CanonicalMuscleJoint {
  const CanonicalMuscleJoint({required this.id, required this.namePtPt});

  final String id;
  final String namePtPt;
}

class CanonicalMuscleAction {
  const CanonicalMuscleAction({
    required this.id,
    required this.namePtPt,
    required this.descriptionPtPt,
  });

  final String id;
  final String namePtPt;
  final String descriptionPtPt;
}

class CanonicalMuscleJointRelation {
  const CanonicalMuscleJointRelation({
    required this.muscleId,
    required this.parentMuscleId,
    required this.jointId,
    required this.relationType,
    required this.segmentConditionPtPt,
    required this.confidence,
  });

  final String muscleId;
  final String? parentMuscleId;
  final String jointId;
  final String relationType;
  final String segmentConditionPtPt;
  final String confidence;
}

class CanonicalMuscleActionRelation {
  const CanonicalMuscleActionRelation({
    required this.muscleId,
    required this.parentMuscleId,
    required this.jointId,
    required this.actionId,
    required this.role,
    required this.plane,
    required this.chainContext,
    required this.confidence,
  });

  final String muscleId;
  final String? parentMuscleId;
  final String jointId;
  final String actionId;
  final String role;
  final String plane;
  final String chainContext;
  final String confidence;
}

class CanonicalMuscleInteractionRelation {
  const CanonicalMuscleInteractionRelation({
    required this.id,
    required this.muscleAId,
    required this.muscleBId,
    required this.relationType,
    required this.taskContextPtPt,
    required this.actionContext,
    required this.limitationsPtPt,
    required this.confidence,
  });

  final String id;
  final String muscleAId;
  final String muscleBId;
  final String relationType;
  final String taskContextPtPt;
  final String actionContext;
  final String limitationsPtPt;
  final String confidence;
}

class CanonicalMuscleTrainabilityProfile {
  const CanonicalMuscleTrainabilityProfile({
    required this.muscleId,
    required this.practicalEmphasis,
    required this.trainingTargetStatus,
    required this.positionDependencePtPt,
    required this.evidenceBoundaryPtPt,
    required this.limitingJointIds,
    required this.stabilityMuscleIds,
    required this.synergistMuscleIds,
    required this.riskClass,
    required this.confidence,
  });

  final String muscleId;
  final String practicalEmphasis;
  final String trainingTargetStatus;
  final String positionDependencePtPt;
  final String evidenceBoundaryPtPt;
  final List<String> limitingJointIds;
  final List<String> stabilityMuscleIds;
  final List<String> synergistMuscleIds;
  final String riskClass;
  final String confidence;
}

class CanonicalArmExerciseFamily {
  const CanonicalArmExerciseFamily({
    required this.id,
    required this.namePtPt,
    required this.domain,
  });

  final String id;
  final String namePtPt;
  final String domain;
}

class CanonicalArmEquipment {
  const CanonicalArmEquipment({
    required this.id,
    required this.namePtPt,
    required this.type,
  });

  final String id;
  final String namePtPt;
  final String type;
}

class CanonicalArmExercise {
  const CanonicalArmExercise({
    required this.id,
    required this.namePtPt,
    required this.nameEn,
    required this.familyId,
    required this.state,
    required this.isPublicEligible,
    required this.shortDescriptionPtPt,
    required this.technicalDescriptionPtPt,
    required this.requiredEquipmentIds,
    required this.optionalEquipmentIds,
    required this.alternativeEquipmentIds,
    required this.setupPtPt,
    required this.startPositionPtPt,
    required this.movementPtPt,
    required this.endPositionPtPt,
    required this.trajectoryPtPt,
    required this.cuesPtPt,
    required this.commonErrorsPtPt,
    required this.stopConditionsPtPt,
    required this.generalCautionsPtPt,
    required this.specialistReviewPtPt,
    required this.jointIds,
    required this.actionIds,
    required this.sourceIds,
  });

  final String id;
  final String namePtPt;
  final String nameEn;
  final String familyId;
  final CanonicalArmPublicationState state;
  final bool isPublicEligible;
  final String shortDescriptionPtPt;
  final String technicalDescriptionPtPt;
  final List<String> requiredEquipmentIds;
  final List<String> optionalEquipmentIds;
  final List<String> alternativeEquipmentIds;
  final List<String> setupPtPt;
  final String startPositionPtPt;
  final String movementPtPt;
  final String endPositionPtPt;
  final String trajectoryPtPt;
  final List<String> cuesPtPt;
  final List<String> commonErrorsPtPt;
  final List<String> stopConditionsPtPt;
  final List<String> generalCautionsPtPt;
  final String specialistReviewPtPt;
  final List<String> jointIds;
  final List<String> actionIds;
  final List<String> sourceIds;

  bool get hasLimits =>
      state == CanonicalArmPublicationState.approvedWithLimits;
}

class CanonicalArmExercisePublicContent {
  const CanonicalArmExercisePublicContent({
    required this.exerciseId,
    required this.namePtPt,
    required this.objectivePtPt,
    required this.instructionsPtPt,
    required this.equipmentPtPt,
    required this.primaryMusclesPtPt,
    required this.secondaryMusclesPtPt,
    required this.potentialGripLimitersPtPt,
    required this.commonErrorsPtPt,
    required this.cautionsPtPt,
    required this.environmentalControlsPtPt,
    required this.simpleAlternativesPtPt,
    required this.limitReasonPtPt,
    required this.state,
  });

  final String exerciseId;
  final String namePtPt;
  final String objectivePtPt;
  final List<String> instructionsPtPt;
  final List<String> equipmentPtPt;
  final List<String> primaryMusclesPtPt;
  final List<String> secondaryMusclesPtPt;
  final List<String> potentialGripLimitersPtPt;
  final List<String> commonErrorsPtPt;
  final List<String> cautionsPtPt;
  final List<String> environmentalControlsPtPt;
  final List<String> simpleAlternativesPtPt;
  final String limitReasonPtPt;
  final CanonicalArmPublicationState state;
}

class CanonicalArmExerciseVariant {
  const CanonicalArmExerciseVariant({
    required this.id,
    required this.parentExerciseId,
    required this.namePtPt,
    required this.classification,
    required this.changesPtPt,
    required this.mechanicalJustificationPtPt,
    required this.equipmentIds,
    required this.state,
    required this.sourceIds,
  });

  final String id;
  final String parentExerciseId;
  final String namePtPt;
  final String classification;
  final String changesPtPt;
  final String mechanicalJustificationPtPt;
  final List<String> equipmentIds;
  final CanonicalArmPublicationState state;
  final List<String> sourceIds;

  bool get hasLimits =>
      state == CanonicalArmPublicationState.approvedWithLimits;
}

class CanonicalArmExerciseMuscleRelation {
  const CanonicalArmExerciseMuscleRelation({
    required this.id,
    required this.exerciseId,
    required this.muscleId,
    required this.componentId,
    required this.role,
    required this.contextPtPt,
    required this.limitationsPtPt,
    required this.confidence,
  });

  final String id;
  final String exerciseId;
  final String muscleId;
  final String? componentId;
  final CanonicalArmMuscleRole role;
  final String contextPtPt;
  final String limitationsPtPt;
  final String confidence;
}

class CanonicalArmExerciseJointRelation {
  const CanonicalArmExerciseJointRelation({
    required this.id,
    required this.exerciseId,
    required this.jointId,
    required this.role,
    required this.contextPtPt,
  });

  final String id;
  final String exerciseId;
  final String jointId;
  final String role;
  final String contextPtPt;
}

class CanonicalArmExerciseActionRelation {
  const CanonicalArmExerciseActionRelation({
    required this.id,
    required this.exerciseId,
    required this.actionId,
    required this.role,
    required this.contractionMode,
    required this.contextPtPt,
  });

  final String id;
  final String exerciseId;
  final String actionId;
  final String role;
  final String contractionMode;
  final String contextPtPt;
}

class CanonicalArmExerciseEquipmentRelation {
  const CanonicalArmExerciseEquipmentRelation({
    required this.id,
    required this.exerciseId,
    required this.equipmentId,
    required this.type,
    required this.contextPtPt,
  });

  final String id;
  final String exerciseId;
  final String equipmentId;
  final CanonicalArmEquipmentRelationType type;
  final String contextPtPt;
}

class CanonicalArmMuscularProvenance {
  const CanonicalArmMuscularProvenance({
    required this.schemaVersion,
    required this.generatorVersion,
    required this.muscularBundleSha256,
    required this.armCatalogueBundleSha256,
  });

  final String schemaVersion;
  final String generatorVersion;
  final String muscularBundleSha256;
  final String armCatalogueBundleSha256;
}
