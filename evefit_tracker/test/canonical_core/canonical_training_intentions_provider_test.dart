import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_exercise_selection_path.dart';
import 'package:evefit_tracker/features/canonical_core/models/training_intention_models.dart';
import 'package:evefit_tracker/features/canonical_core/services/canonical_selection_compatibility_provider.dart';
import 'package:evefit_tracker/features/canonical_core/validators/canonical_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const registry = CanonicalRegistry();
  const provider = RegistryCanonicalSelectionCompatibilityProvider();
  const validator = CanonicalValidator();

  test('intentions are the exact ordered options for the selected path', () {
    final path = CanonicalRegistry.trainingPaths.firstWhere(
      (value) =>
          value.status == CanonicalTrainingPathStatus.compatible &&
          registry.linksForPath(value.key).length > 1,
    );
    final selection = CanonicalExerciseSelectionPath(
      usageContextId: path.key.usageContextId,
      capabilityRootId: path.key.capabilityRootId,
      trainingConceptId: path.key.trainingConceptId,
    );
    final resolved = registry.resolvedOptionsForPath(path.key);
    final options = provider.compatibleTrainingIntentions(selection);
    final incompatibleKnownId = CanonicalRegistry.approvedTrainingIntentions
        .firstWhere((value) => !options.contains(value))
        .id;

    expect(options.map((value) => value.id), [
      for (final option in resolved) option.definition.pillar.id,
    ]);
    expect(
      resolved.map((option) => option.link.displayOrder),
      List<int>.generate(resolved.length, (index) => index + 1),
    );
    expect(
      () => validator.validateQueryOrThrow(
        selection.selectTrainingIntention(incompatibleKnownId).toQuery(),
      ),
      throwsStateError,
    );
    for (final option in options) {
      final query = selection.selectTrainingIntention(option.id).toQuery();
      expect(validator.queryErrors(query), isEmpty, reason: option.id);
    }
  });

  test('queries accept only the exact progressive path prefix', () {
    final path = CanonicalRegistry.trainingPaths.firstWhere(
      (value) =>
          value.status == CanonicalTrainingPathStatus.compatible &&
          registry.linksForPath(value.key).isNotEmpty,
    );
    final context = CanonicalExerciseSelectionPath(
      usageContextId: path.key.usageContextId,
    );
    final capability = context.selectCapabilityRoot(path.key.capabilityRootId);
    final concept = capability.selectTrainingConcept(
      path.key.trainingConceptId,
    );

    expect(validator.queryErrors(context.toQuery()), isEmpty);
    expect(validator.queryErrors(capability.toQuery()), isEmpty);
    expect(validator.queryErrors(concept.toQuery()), isEmpty);
    expect(
      validator.queryErrors(
        const CanonicalSearchQuery(
          criteria: [
            CanonicalSearchCriterion(
              axis: CanonicalPillarAxis.capabilityRoot,
              valueId: 'cardio_conditioning',
            ),
          ],
        ),
      ),
      isNotEmpty,
    );
  });

  test(
    'runtime factories retain immutable snapshots while generated data stay const',
    () {
      final seed = CanonicalRegistry.trainingIntentionDefinitions.first;
      final usageContexts = [...seed.declaredUsageContextIds];
      final labels = ['runtime label'];
      final runtimeDefinition = CanonicalTrainingIntentionDefinition.runtime(
        pillar: seed.pillar,
        type: seed.type,
        effectPtPt: seed.effectPtPt,
        primaryTargetPtPt: seed.primaryTargetPtPt,
        horizon: seed.horizon,
        declaredUsageContextIds: usageContexts,
        declaredCapabilityRootIds: seed.declaredCapabilityRootIds,
        declaredTrainingConceptIds: seed.declaredTrainingConceptIds,
        occurrenceCount: seed.occurrenceCount,
        possibleRoles: seed.possibleRoles,
        globallyIncompatibleAlternativeIds:
            seed.globallyIncompatibleAlternativeIds,
        globallyCompatibleComplementaryIds:
            seed.globallyCompatibleComplementaryIds,
        relevantPopulationPtPt: seed.relevantPopulationPtPt,
        evidenceBasis: seed.evidenceBasis,
        sourceCodes: seed.sourceCodes,
        evidenceLimitPtPt: seed.evidenceLimitPtPt,
        reviewState: seed.reviewState,
        clinicalReviewRequired: seed.clinicalReviewRequired,
        operationalRiskTier: seed.operationalRiskTier,
        generalSafetyNotePtPt: seed.generalSafetyNotePtPt,
        sourceOrder: seed.sourceOrder,
        sourceRegistryVersion: seed.sourceRegistryVersion,
        runtimeProvenanceId: seed.runtimeProvenanceId,
      );
      final runtimeLink = CanonicalPathIntentionLink.runtime(
        pathSourceNumber: 1,
        intentionId: seed.pillar.id,
        role: seed.possibleRoles.first,
        displayOrder: 1,
        contextualLabelsPtPt: labels,
        sourceRegistryVersion: seed.sourceRegistryVersion,
        runtimeProvenanceId: seed.runtimeProvenanceId,
      );

      usageContexts.add('mutated');
      labels.add('mutated');
      expect(
        runtimeDefinition.declaredUsageContextIds,
        seed.declaredUsageContextIds,
      );
      expect(runtimeLink.contextualLabelsPtPt, ['runtime label']);
      expect(
        () => runtimeDefinition.declaredUsageContextIds.add('mutated'),
        throwsUnsupportedError,
      );
      expect(
        () => runtimeLink.contextualLabelsPtPt.add('mutated'),
        throwsUnsupportedError,
      );
      expect(
        () => seed.declaredUsageContextIds.add('mutated'),
        throwsUnsupportedError,
      );
    },
  );

  test('effective safety only preserves or escalates base risk', () {
    final lowRiskDefinition = CanonicalRegistry.trainingIntentionDefinitions
        .firstWhere(
          (value) =>
              value.operationalRiskTier == CanonicalOperationalRiskTier.low,
        );
    final highRiskDefinition = CanonicalRegistry.trainingIntentionDefinitions
        .firstWhere(
          (value) =>
              value.operationalRiskTier == CanonicalOperationalRiskTier.high,
        );
    final clinicallyReviewedDefinition = CanonicalRegistry
        .trainingIntentionDefinitions
        .firstWhere(
          (value) =>
              value.clinicalReviewRequired ==
              CanonicalClinicalReviewRequirement.yes,
        );
    final escalate = _resolved(
      lowRiskDefinition,
      CanonicalPathOperationalRiskModifier.mayEscalateToHigh,
      CanonicalPathClinicalReviewModifier.inheritOnly,
    );
    final preserveHigh = _resolved(
      highRiskDefinition,
      CanonicalPathOperationalRiskModifier.mayEscalateToHigh,
      CanonicalPathClinicalReviewModifier.inheritOnly,
    );
    final restricted = _resolved(
      lowRiskDefinition,
      CanonicalPathOperationalRiskModifier.clinicallyRestricted,
      CanonicalPathClinicalReviewModifier.required,
    );
    final inheritedReview = _resolved(
      clinicallyReviewedDefinition,
      CanonicalPathOperationalRiskModifier.inheritOnly,
      CanonicalPathClinicalReviewModifier.inheritOnly,
    );

    expect(escalate.effectiveRiskTier, CanonicalOperationalRiskTier.high);
    expect(preserveHigh.effectiveRiskTier, CanonicalOperationalRiskTier.high);
    expect(
      restricted.effectiveRiskTier,
      CanonicalOperationalRiskTier.clinicallyRestricted,
    );
    expect(restricted.effectiveClinicalReviewRequired, isTrue);
    expect(inheritedReview.effectiveClinicalReviewRequired, isTrue);
    expect(restricted.pathOperationalRiskModifierTextPtPt, 'risk modifier');
    expect(restricted.pathClinicalReviewModifierTextPtPt, 'review modifier');
  });
}

CanonicalResolvedPathIntention _resolved(
  CanonicalTrainingIntentionDefinition definition,
  CanonicalPathOperationalRiskModifier riskModifier,
  CanonicalPathClinicalReviewModifier reviewModifier,
) {
  const key = CanonicalTrainingPathKey(
    usageContextId: 'main_training',
    capabilityRootId: 'muscular_capacity',
    trainingConceptId: 'overcome_resistance',
  );
  final path = CanonicalTrainingPathDefinition(
    sourceNumber: 1,
    key: key,
    status: CanonicalTrainingPathStatus.compatible,
    rationalePtPt: 'rationale',
    contextNotesPtPt: 'context',
    alternativesAndComplementariesPtPt: 'alternatives',
    limitsPtPt: 'limits',
    progressionPtPt: 'progression',
    intensityAndPrescriptionPtPt: 'intensity',
    eligibilityAndSafetyPtPt: 'safety',
    operationalRiskModifier: riskModifier,
    operationalRiskModifierPtPt: 'risk modifier',
    clinicalReviewModifier: reviewModifier,
    clinicalReviewModifierPtPt: 'review modifier',
    sourceRegistryVersion: definition.sourceRegistryVersion,
    runtimeProvenanceId: definition.runtimeProvenanceId,
  );
  return CanonicalResolvedPathIntention(
    definition: definition,
    path: path,
    link: CanonicalPathIntentionLink.runtime(
      pathSourceNumber: path.sourceNumber,
      intentionId: definition.pillar.id,
      role: definition.possibleRoles.first,
      displayOrder: 1,
      contextualLabelsPtPt: const [],
      sourceRegistryVersion: definition.sourceRegistryVersion,
      runtimeProvenanceId: definition.runtimeProvenanceId,
    ),
  );
}
