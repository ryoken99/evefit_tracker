import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_exercise_selection_path.dart';
import 'package:evefit_tracker/features/canonical_core/services/hierarchical_canonical_search_controller.dart';
import 'package:evefit_tracker/features/canonical_core/validators/canonical_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validator = CanonicalValidator();

  test('approved hierarchy inputs remain flat independent pillar values', () {
    expect(CanonicalRegistry.approvedUsageContexts, hasLength(7));
    expect(CanonicalRegistry.approvedCapabilityRoots, hasLength(8));
    expect(CanonicalRegistry.approvedTrainingConcepts, hasLength(35));
    expect(CanonicalRegistry.approvedTrainingIntentions, isEmpty);
    expect(CanonicalRegistry.approvedAttributeDefinitions, isEmpty);
    expect(
      const CanonicalRegistry().approvedPillarValues
          .map((value) => value.id)
          .toSet(),
      hasLength(50),
    );
  });

  test('context selection creates exactly one explicit criterion', () {
    final controller = HierarchicalCanonicalSearchController();

    expect(controller.currentQuery.criteria, isEmpty);
    expect(
      controller.currentQuery.toJson().toString(),
      isNot(contains('main_training')),
    );

    controller.selectUsageContext('warmup');

    expect(controller.step, HierarchicalCanonicalSearchStep.capabilityRoot);
    expect(controller.currentQuery.criteria, const [
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.usageContext,
        valueId: 'warmup',
      ),
    ]);
    expect(validator.queryErrors(controller.currentQuery), isEmpty);
  });

  test('main training only enters a query through explicit selection', () {
    final controller = HierarchicalCanonicalSearchController();

    controller.selectUsageContext('main_training');

    expect(controller.currentQuery.criteria, hasLength(1));
    expect(
      controller.currentQuery.criteria.single,
      const CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.usageContext,
        valueId: 'main_training',
      ),
    );
  });

  test('capability adds the second criterion in binding order', () {
    final controller = HierarchicalCanonicalSearchController()
      ..selectUsageContext('warmup')
      ..selectCapabilityRoot('cardio_conditioning');

    expect(controller.step, HierarchicalCanonicalSearchStep.trainingConcept);
    expect(controller.currentQuery.criteria, const [
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.usageContext,
        valueId: 'warmup',
      ),
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.capabilityRoot,
        valueId: 'cardio_conditioning',
      ),
    ]);
    expect(validator.queryErrors(controller.currentQuery), isEmpty);
    final raw = controller.currentQuery.toJson().toString();
    expect(raw, isNot(contains('exercise_ids')));
    expect(raw, isNot(contains('legacy_ids')));
    expect(raw, isNot(contains('parent_id')));
  });

  test(
    'validator rejects reversed progressive criteria and duplicate axes',
    () {
      const reversed = CanonicalSearchQuery(
        criteria: [
          CanonicalSearchCriterion(
            axis: CanonicalPillarAxis.capabilityRoot,
            valueId: 'cardio_conditioning',
          ),
          CanonicalSearchCriterion(
            axis: CanonicalPillarAxis.usageContext,
            valueId: 'warmup',
          ),
        ],
      );
      const duplicate = CanonicalSearchQuery(
        criteria: [
          CanonicalSearchCriterion(
            axis: CanonicalPillarAxis.usageContext,
            valueId: 'warmup',
          ),
          CanonicalSearchCriterion(
            axis: CanonicalPillarAxis.usageContext,
            valueId: 'activation',
          ),
        ],
      );

      expect(validator.queryErrors(reversed), isNotEmpty);
      expect(validator.queryErrors(duplicate), isNotEmpty);
    },
  );

  test('changing an earlier selection clears all later selections', () {
    const complete = CanonicalExerciseSelectionPath(
      usageContextId: 'warmup',
      capabilityRootId: 'cardio_conditioning',
      trainingConceptId: 'future_concept',
      trainingIntentionId: 'future_intention',
    );

    final changedContext = complete.selectUsageContext('activation');
    expect(changedContext.usageContextId, 'activation');
    expect(changedContext.capabilityRootId, isNull);
    expect(changedContext.trainingConceptId, isNull);
    expect(changedContext.trainingIntentionId, isNull);

    final changedCapability = complete.selectCapabilityRoot('mobility');
    expect(changedCapability.usageContextId, 'warmup');
    expect(changedCapability.capabilityRootId, 'mobility');
    expect(changedCapability.trainingConceptId, isNull);
    expect(changedCapability.trainingIntentionId, isNull);

    final changedConcept = complete.selectTrainingConcept('other_concept');
    expect(changedConcept.trainingIntentionId, isNull);
  });

  test('selection path enforces prerequisite order directly', () {
    expect(
      () => const CanonicalExerciseSelectionPath().selectCapabilityRoot(
        'cardio_conditioning',
      ),
      throwsStateError,
    );
    expect(
      () => const CanonicalExerciseSelectionPath(
        usageContextId: 'warmup',
      ).selectTrainingConcept('future_concept'),
      throwsStateError,
    );
    expect(
      () => const CanonicalExerciseSelectionPath(
        usageContextId: 'warmup',
        capabilityRootId: 'cardio_conditioning',
      ).selectTrainingIntention('future_intention'),
      throwsStateError,
    );
  });

  test('validator reports oversized queries without throwing RangeError', () {
    const oversized = CanonicalSearchQuery(
      criteria: [
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.usageContext,
          valueId: 'warmup',
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.capabilityRoot,
          valueId: 'cardio_conditioning',
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingConcept,
          valueId: 'concept_a',
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingIntention,
          valueId: 'intention_a',
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.usageContext,
          valueId: 'activation',
        ),
      ],
    );

    expect(validator.queryErrors(oversized), isNotEmpty);
  });

  test('concept selection creates the third criterion in binding order', () {
    final controller = HierarchicalCanonicalSearchController()
      ..selectUsageContext('activation')
      ..selectCapabilityRoot('cardio_conditioning');

    expect(controller.compatibleTrainingConcepts, isNotEmpty);
    controller.selectTrainingConcept('cyclic_locomotion');

    expect(controller.step, HierarchicalCanonicalSearchStep.trainingIntention);
    expect(controller.currentQuery.criteria, const [
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.usageContext,
        valueId: 'activation',
      ),
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.capabilityRoot,
        valueId: 'cardio_conditioning',
      ),
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.trainingConcept,
        valueId: 'cyclic_locomotion',
      ),
    ]);
    expect(controller.compatibleTrainingIntentions, isEmpty);
    expect(
      () => controller.selectTrainingIntention('invented_intention'),
      throwsStateError,
    );
    expect(validator.queryErrors(controller.currentQuery), isEmpty);
  });

  test('back preserves valid choices and home clears the path', () {
    final controller = HierarchicalCanonicalSearchController()
      ..selectUsageContext('warmup')
      ..selectCapabilityRoot('cardio_conditioning')
      ..selectTrainingConcept('cyclic_locomotion');

    expect(controller.goBack(), isTrue);
    expect(controller.step, HierarchicalCanonicalSearchStep.trainingConcept);
    expect(controller.path.usageContextId, 'warmup');
    expect(controller.path.capabilityRootId, 'cardio_conditioning');
    expect(controller.path.trainingConceptId, 'cyclic_locomotion');

    expect(controller.goBack(), isTrue);
    expect(controller.step, HierarchicalCanonicalSearchStep.capabilityRoot);
    expect(controller.path.usageContextId, 'warmup');

    controller.goToRoot();
    expect(controller.currentQuery.criteria, isEmpty);
    expect(controller.path.usageContextId, isNull);
  });
}
