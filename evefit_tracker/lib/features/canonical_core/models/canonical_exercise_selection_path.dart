import 'canonical_core_models.dart';

class CanonicalExerciseSelectionPath {
  const CanonicalExerciseSelectionPath({
    this.usageContextId,
    this.capabilityRootId,
    this.trainingConceptId,
    this.trainingIntentionId,
  });

  final String? usageContextId;
  final String? capabilityRootId;
  final String? trainingConceptId;
  final String? trainingIntentionId;

  CanonicalExerciseSelectionPath selectUsageContext(String id) {
    if (id == usageContextId) return this;
    return CanonicalExerciseSelectionPath(usageContextId: id);
  }

  CanonicalExerciseSelectionPath selectCapabilityRoot(String id) {
    if (usageContextId == null) {
      throw StateError('A usage context must be selected first.');
    }
    if (id == capabilityRootId) return this;
    return CanonicalExerciseSelectionPath(
      usageContextId: usageContextId,
      capabilityRootId: id,
    );
  }

  CanonicalExerciseSelectionPath selectTrainingConcept(String id) {
    if (capabilityRootId == null) {
      throw StateError('A capability root must be selected first.');
    }
    if (id == trainingConceptId) return this;
    return CanonicalExerciseSelectionPath(
      usageContextId: usageContextId,
      capabilityRootId: capabilityRootId,
      trainingConceptId: id,
    );
  }

  CanonicalExerciseSelectionPath selectTrainingIntention(String id) {
    if (trainingConceptId == null) {
      throw StateError('A training concept must be selected first.');
    }
    if (id == trainingIntentionId) return this;
    return CanonicalExerciseSelectionPath(
      usageContextId: usageContextId,
      capabilityRootId: capabilityRootId,
      trainingConceptId: trainingConceptId,
      trainingIntentionId: id,
    );
  }

  CanonicalSearchQuery toQuery() {
    final criteria = <CanonicalSearchCriterion>[];
    if (usageContextId case final id?) {
      criteria.add(
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.usageContext,
          valueId: id,
        ),
      );
    }
    if (capabilityRootId case final id?) {
      criteria.add(
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.capabilityRoot,
          valueId: id,
        ),
      );
    }
    if (trainingConceptId case final id?) {
      criteria.add(
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingConcept,
          valueId: id,
        ),
      );
    }
    if (trainingIntentionId case final id?) {
      criteria.add(
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingIntention,
          valueId: id,
        ),
      );
    }
    return CanonicalSearchQuery(criteria: List.unmodifiable(criteria));
  }
}
