const canonicalCoreSchemaVersion = '0.1';
const canonicalCoreSearchNamespace = 'canonical_core_search/0.1';

enum CanonicalPillarAxis {
  capabilityRoot,
  trainingIntention,
  trainingConcept,
  usageContext,
}

extension CanonicalPillarAxisContract on CanonicalPillarAxis {
  String get contractId => switch (this) {
    CanonicalPillarAxis.capabilityRoot => 'capability_root',
    CanonicalPillarAxis.trainingIntention => 'training_intention',
    CanonicalPillarAxis.trainingConcept => 'training_concept',
    CanonicalPillarAxis.usageContext => 'usage_context',
  };
}

enum CanonicalDefinitionStatus { draft, approved, deprecated }

enum CanonicalCoreIconKey {
  capabilityAxis,
  intentionAxis,
  conceptAxis,
  contextAxis,
  muscularCapacity,
  cardioConditioning,
  speedPower,
  mobility,
  flexibility,
  motorControlCoordination,
  techniqueSkill,
  breathingRegulation,
  mainTraining,
  warmup,
  activation,
  recoveryCooldown,
  preventionAdaptationReturn,
  emptySearch,
}

class CanonicalPillarAxisDefinition {
  const CanonicalPillarAxisDefinition({
    required this.axis,
    required this.displayNamePtPt,
    required this.descriptionPtPt,
    required this.displayOrder,
    required this.iconKey,
    this.schemaVersion = canonicalCoreSchemaVersion,
  });

  final CanonicalPillarAxis axis;
  final String displayNamePtPt;
  final String descriptionPtPt;
  final int displayOrder;
  final CanonicalCoreIconKey iconKey;
  final String schemaVersion;
}

class CanonicalPillarDefinition {
  const CanonicalPillarDefinition({
    required this.id,
    required this.axis,
    required this.displayNamePtPt,
    required this.descriptionPtPt,
    required this.status,
    required this.displayOrder,
    required this.iconKey,
    this.schemaVersion = canonicalCoreSchemaVersion,
  });

  const CanonicalPillarDefinition.trainingConcept({
    required this.id,
    required this.displayNamePtPt,
    required this.descriptionPtPt,
    required this.displayOrder,
    this.schemaVersion = canonicalCoreSchemaVersion,
  }) : axis = CanonicalPillarAxis.trainingConcept,
       status = CanonicalDefinitionStatus.approved,
       iconKey = CanonicalCoreIconKey.conceptAxis;

  final String id;
  final CanonicalPillarAxis axis;
  final String displayNamePtPt;
  final String descriptionPtPt;
  final CanonicalDefinitionStatus status;
  final int displayOrder;
  final CanonicalCoreIconKey iconKey;
  final String schemaVersion;
}

class CanonicalCapabilityConceptRelation {
  const CanonicalCapabilityConceptRelation({
    required this.capabilityRootId,
    required this.trainingConceptId,
    required this.displayOrder,
    this.schemaVersion = canonicalCoreSchemaVersion,
  }) : assert(displayOrder > 0);

  final String capabilityRootId;
  final String trainingConceptId;
  final int displayOrder;
  final String schemaVersion;
}

class CanonicalAttributeDefinition {
  const CanonicalAttributeDefinition({
    required this.id,
    required this.displayNamePtPt,
    required this.descriptionPtPt,
    required this.group,
    required this.cardinality,
    required this.valueType,
    required this.status,
    this.schemaVersion = canonicalCoreSchemaVersion,
  });

  final String id;
  final String displayNamePtPt;
  final String descriptionPtPt;
  final String group;
  final String cardinality;
  final String valueType;
  final CanonicalDefinitionStatus status;
  final String schemaVersion;
}

class CanonicalSearchCriterion {
  const CanonicalSearchCriterion({required this.axis, required this.valueId});

  final CanonicalPillarAxis axis;
  final String valueId;

  Map<String, String> toJson() => {
    'axis': axis.contractId,
    'value_id': valueId,
  };

  @override
  bool operator ==(Object other) =>
      other is CanonicalSearchCriterion &&
      other.axis == axis &&
      other.valueId == valueId;

  @override
  int get hashCode => Object.hash(axis, valueId);
}

class CanonicalSearchQuery {
  const CanonicalSearchQuery({
    required this.criteria,
    this.schemaVersion = canonicalCoreSearchNamespace,
  });

  final List<CanonicalSearchCriterion> criteria;
  final String schemaVersion;

  Map<String, Object> toJson() => {
    'schema_version': schemaVersion,
    'criteria': criteria.map((criterion) => criterion.toJson()).toList(),
  };
}

enum CanonicalSearchResultStatus { success, invalidQuery }

class CanonicalSearchResult<TItem> {
  const CanonicalSearchResult({
    required this.query,
    required this.total,
    required this.items,
    required this.status,
  });

  final CanonicalSearchQuery query;
  final int total;
  final List<TItem> items;
  final CanonicalSearchResultStatus status;
}

/// A canonical exercise is a concrete, recognisable and technically distinct
/// action. Identity changes only when its essential technique or mechanics do.
abstract final class CanonicalIdentityPrinciples {
  static const distinguishingFactors = <String>[
    'essential_technique',
    'mechanics',
    'trajectory',
    'body_position',
    'active_joints',
    'dominant_joint_action',
    'force_application',
    'support',
    'contact',
    'primary_functional_target',
    'technical_purpose',
    'object_or_partner_relationship',
  ];

  static const variationQuestion =
      'A técnica e a mecânica fundamentais permanecem essencialmente iguais?';
  static const protocolsAreNotExercises = true;
  static const prescriptionDefinesIdentity = false;
}
