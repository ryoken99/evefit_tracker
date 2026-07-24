import 'package:evefit_tracker/features/canonical_core/generated/exercises/canonical_exercise_beginner_content.g.dart';
import 'package:evefit_tracker/features/canonical_core/generated/exercises/canonical_exercise_path_links.g.dart';
import 'package:evefit_tracker/features/canonical_core/generated/exercises/canonical_exercises_provenance.g.dart';
import 'package:evefit_tracker/features/canonical_core/generated/exercises/canonical_exercises_registry.g.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_exercise_models.dart';
import 'package:evefit_tracker/features/canonical_core/repositories/canonical_exercise_search_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../tool/canonical/generate_wave1_exercises_registry.dart'
    as generator;

void main() {
  const repository = GeneratedCanonicalExerciseSearchRepository();

  test(
    'runtime exposes exactly the approved Wave1 definitions and content',
    () {
      expect(generatedCanonicalWave1Exercises, hasLength(49));
      expect(generatedCanonicalWave1BeginnerContent, hasLength(49));
      expect(generatedCanonicalWave1PathLinks, hasLength(88));
      expect(generatedCanonicalWave1Counts, {
        'exercises': 49,
        'active_relations': 88,
        'deferred_relations': 66,
        'variants': 3,
      });
      expect(generatedCanonicalWave1RegistryVersion, '0.1');
      expect(generatedCanonicalWave1ContentVersion, '0.1.2');

      final definitionIds = generatedCanonicalWave1Exercises
          .map((item) => item.id)
          .toList();
      final contentIds = generatedCanonicalWave1BeginnerContent
          .map((item) => item.exerciseId)
          .toList();
      expect(definitionIds, orderedEquals([...definitionIds]..sort()));
      expect(contentIds, orderedEquals(definitionIds));
      expect(definitionIds.toSet(), hasLength(49));
    },
  );

  test('entity, risk and variant distributions are exact', () {
    expect(
      _distribution(
        generatedCanonicalWave1Exercises.map((item) => item.entityType),
      ),
      {
        CanonicalExerciseEntityType.canonicalExercise: 38,
        CanonicalExerciseEntityType.techniqueDrill: 8,
        CanonicalExerciseEntityType.exerciseVariant: 3,
      },
    );
    expect(
      _distribution(
        generatedCanonicalWave1Exercises.map(
          (item) => item.primaryCapabilityRootId,
        ),
      ),
      {
        'breathing_regulation': 4,
        'cardio_conditioning': 11,
        'flexibility': 9,
        'mobility': 5,
        'motor_control_coordination': 6,
        'speed_power': 9,
        'technique_skill': 5,
      },
    );
    expect(
      generatedCanonicalWave1Exercises.where(
        (item) => item.safety.clinicalReviewRequired,
      ),
      isEmpty,
    );
    expect(
      _distribution(
        generatedCanonicalWave1Exercises.map(
          (item) => item.safety.operationalRiskTier,
        ),
      ),
      {
        CanonicalExerciseRiskTier.low: 22,
        CanonicalExerciseRiskTier.moderate: 18,
        CanonicalExerciseRiskTier.high: 9,
      },
    );
    expect(
      {
        for (final item in generatedCanonicalWave1Exercises)
          if (item.identity.isVariant) item.id: item.identity.variantOf,
      },
      {
        'sled_resisted_sprint': 'linear_sprint',
        'supine_hamstring_strap_stretch':
            'supine_self_assisted_hamstring_stretch',
        'treadmill_walking': 'overground_walking',
      },
    );
  });

  test(
    'generated exercise and relation IDs match the approved sources',
    () async {
      final source = await generator.loadWave1ExerciseSourcesForTesting();
      expect(
        generatedCanonicalWave1Exercises.map((item) => item.id).toSet(),
        source.technicalExercises
            .map((item) => item['exercise_id']! as String)
            .toSet(),
      );
      expect(
        generatedCanonicalWave1PathLinks.map((item) => item.relationId).toSet(),
        source.readyRelations
            .map((item) => item['relation_id']! as String)
            .toSet(),
      );
      expect(
        generatedCanonicalWave1PathLinks
            .map((item) => item.pathKey.trainingIntentionId)
            .toSet(),
        hasLength(50),
      );
      expect(
        _distribution(
          generatedCanonicalWave1PathLinks.map((item) => item.role),
        ),
        {
          'principal_candidate': 34,
          'alternative_primary': 44,
          'complementary': 10,
        },
      );
    },
  );

  test('all public records are complete and never expose dose or media', () {
    for (final content in generatedCanonicalWave1BeginnerContent) {
      expect(content.shortDescriptionPtPt.trim(), isNotEmpty);
      expect(content.beginnerDefinitionPtPt.trim(), isNotEmpty);
      expect(content.whatYouWillDoPtPt.trim(), isNotEmpty);
      expect(content.executionStepsPtPt, isNotEmpty);
      expect(content.principalCuesPtPt, isNotEmpty);
      expect(content.commonErrorsPtPt, isNotEmpty);
      expect(content.safetyNotePtPt.trim(), isNotEmpty);
      expect(content.limitationsPtPt, isNotEmpty);
      final rendered = [
        content.shortDescriptionPtPt,
        content.beginnerDefinitionPtPt,
        content.whatYouWillDoPtPt,
        ...content.executionStepsPtPt,
      ].join(' ');
      expect(rendered, isNot(contains('series')));
      expect(rendered, isNot(contains('exercise_ids')));
    }
    expect(
      generatedCanonicalWave1Exercises,
      everyElement(
        predicate<CanonicalExerciseDefinition>(
          (item) => item.media.status == 'not_yet_approved',
        ),
      ),
    );
  });

  test('all 88 active links resolve on their exact four-part path', () async {
    final resultsByPath =
        <
          CanonicalExercisePathKey,
          CanonicalSearchResult<CanonicalResolvedExercise>
        >{};
    for (final link in generatedCanonicalWave1PathLinks) {
      final result = resultsByPath[link.pathKey] ??= await repository.search(
        _query(link.pathKey),
      );
      expect(result.status, CanonicalSearchResultStatus.success);
      expect(
        result.items.map((item) => item.definition.id),
        contains(link.exerciseId),
        reason: link.relationId,
      );
    }
    expect(resultsByPath, hasLength(54));
  });

  test(
    'repository preserves source order and deduplicates each path',
    () async {
      final linksByPath =
          <
            CanonicalExercisePathKey,
            List<CanonicalExercisePathCompatibility>
          >{};
      for (final link in generatedCanonicalWave1PathLinks) {
        linksByPath.putIfAbsent(link.pathKey, () => []).add(link);
      }
      for (final entry in linksByPath.entries) {
        final result = await repository.search(_query(entry.key));
        final expected = entry.value.map((item) => item.exerciseId).toList();
        final actual = result.items.map((item) => item.definition.id).toList();
        expect(actual, orderedEquals(expected));
        expect(actual.toSet(), hasLength(actual.length));
      }
    },
  );

  test('all 66 deferred relations are absent from public results', () async {
    final source = await generator.loadWave1ExerciseSourcesForTesting();
    final resultsByPath = <CanonicalExercisePathKey, Set<String>>{};
    for (final relation in source.deferredRelations) {
      final path = CanonicalExercisePathKey(
        usageContextId: relation['usage_context_id']! as String,
        capabilityRootId: relation['capability_root_id']! as String,
        trainingConceptId: relation['training_concept_id']! as String,
        trainingIntentionId: relation['training_intention_id']! as String,
      );
      final ids = resultsByPath[path] ??= (await repository.search(
        _query(path),
      )).items.map((item) => item.definition.id).toSet();
      expect(
        ids,
        isNot(contains(relation['exercise_id'])),
        reason: relation['relation_id']! as String,
      );
    }
    expect(source.deferredRelations, hasLength(66));
  });

  test('incomplete and reversed queries fail closed', () async {
    const incomplete = CanonicalSearchQuery(
      criteria: [
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.usageContext,
          valueId: 'main_training',
        ),
      ],
    );
    const reversed = CanonicalSearchQuery(
      criteria: [
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.capabilityRoot,
          valueId: 'cardio_conditioning',
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.usageContext,
          valueId: 'main_training',
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingConcept,
          valueId: 'cyclic_locomotion',
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingIntention,
          valueId: 'develop_aerobic_endurance',
        ),
      ],
    );

    expect(
      (await repository.search(incomplete)).status,
      CanonicalSearchResultStatus.invalidQuery,
    );
    expect(
      (await repository.search(reversed)).status,
      CanonicalSearchResultStatus.invalidQuery,
    );
  });
}

CanonicalSearchQuery _query(CanonicalExercisePathKey path) =>
    CanonicalSearchQuery(
      criteria: [
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.usageContext,
          valueId: path.usageContextId,
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.capabilityRoot,
          valueId: path.capabilityRootId,
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingConcept,
          valueId: path.trainingConceptId,
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingIntention,
          valueId: path.trainingIntentionId,
        ),
      ],
    );

Map<T, int> _distribution<T>(Iterable<T> values) {
  final result = <T, int>{};
  for (final value in values) {
    result[value] = (result[value] ?? 0) + 1;
  }
  return result;
}
