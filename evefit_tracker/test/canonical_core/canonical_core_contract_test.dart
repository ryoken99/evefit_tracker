import 'dart:io';

import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/repositories/canonical_exercise_search_repository.dart';
import 'package:evefit_tracker/features/canonical_core/validators/canonical_validator.dart';
import 'package:evefit_tracker/services/clean_base_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const registry = CanonicalRegistry();
  const validator = CanonicalValidator();

  test('registry exposes only the approved canonical foundation', () {
    validator.validateRegistryOrThrow();

    expect(CanonicalRegistry.axisDefinitions, hasLength(4));
    expect(CanonicalRegistry.approvedCapabilityRoots, hasLength(8));
    expect(CanonicalRegistry.approvedUsageContexts, hasLength(4));
    expect(CanonicalRegistry.approvedTrainingIntentions, isEmpty);
    expect(CanonicalRegistry.approvedTrainingConcepts, isEmpty);
    expect(CanonicalRegistry.approvedAttributeDefinitions, isEmpty);
    expect(registry.approvedPillarValues, hasLength(12));
    expect(
      CanonicalRegistry.axisDefinitions.map((definition) => definition.axis),
      CanonicalPillarAxis.values,
    );
  });

  test('approved root and context IDs remain exact and ordered', () {
    expect(CanonicalRegistry.approvedCapabilityRoots.map((value) => value.id), [
      'muscular_capacity',
      'cardio_conditioning',
      'speed_power',
      'mobility',
      'flexibility',
      'motor_control_coordination',
      'technique_skill',
      'breathing_regulation',
    ]);
    expect(CanonicalRegistry.approvedUsageContexts.map((value) => value.id), [
      'warmup',
      'activation',
      'recovery_cooldown',
      'prevention_adaptation_return',
    ]);
    expect(
      registry.approvedPillarValues.every(
        (value) =>
            value.status == CanonicalDefinitionStatus.approved &&
            value.displayNamePtPt.isNotEmpty &&
            value.descriptionPtPt.isNotEmpty &&
            value.schemaVersion == canonicalCoreSchemaVersion,
      ),
      isTrue,
    );
  });

  test('active domain model has no taxonomy hierarchy contract', () {
    final source = File(
      'lib/features/canonical_core/models/canonical_core_models.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('parentId')));
    expect(source, isNot(contains('children')));
    expect(source, isNot(contains('final int depth')));
    expect(
      registry.approvedPillarValues,
      everyElement(isA<CanonicalPillarDefinition>()),
    );
  });

  test(
    'capability and context queries contain exactly one valid criterion',
    () {
      for (final value in registry.approvedPillarValues) {
        final query = CanonicalSearchQuery(
          criteria: [
            CanonicalSearchCriterion(axis: value.axis, valueId: value.id),
          ],
        );
        expect(validator.queryErrors(query), isEmpty, reason: value.id);
        expect(query.criteria, hasLength(1));
        expect(query.criteria.single.axis, value.axis);
        expect(query.criteria.single.valueId, value.id);
        expect(query.toJson().toString(), isNot(contains('exercise_ids')));
        expect(query.toJson().toString(), isNot(contains('main_training')));
      }
    },
  );

  test(
    'validator rejects unknown, draft, mismatched, and old subtree values',
    () {
      const unknown = CanonicalSearchQuery(
        criteria: [
          CanonicalSearchCriterion(
            axis: CanonicalPillarAxis.capabilityRoot,
            valueId: 'cardio_conditioning_no_machines',
          ),
        ],
      );
      expect(validator.queryErrors(unknown), isNotEmpty);

      const draft = CanonicalPillarDefinition(
        id: 'future_intention',
        axis: CanonicalPillarAxis.trainingIntention,
        displayNamePtPt: 'Futuro',
        descriptionPtPt: 'Valor não aprovado para teste.',
        status: CanonicalDefinitionStatus.draft,
        displayOrder: 0,
        iconKey: CanonicalCoreIconKey.intentionAxis,
      );
      expect(
        validator.definitionErrorsForCriterion(
          draft,
          const CanonicalSearchCriterion(
            axis: CanonicalPillarAxis.trainingIntention,
            valueId: 'future_intention',
          ),
        ),
        isNotEmpty,
      );
      expect(
        validator.definitionErrorsForCriterion(
          CanonicalRegistry.approvedCapabilityRoots.first,
          const CanonicalSearchCriterion(
            axis: CanonicalPillarAxis.usageContext,
            valueId: 'muscular_capacity',
          ),
        ),
        isNotEmpty,
      );
    },
  );

  test(
    'raw query validation rejects owned results and hidden context tokens',
    () {
      expect(
        () => CanonicalValidator.validateRawQueryData({
          'exercise_ids': ['legacy-row'],
        }),
        throwsStateError,
      );
      expect(
        () => CanonicalValidator.validateRawQueryData({
          'criteria': [
            {'value_id': 'main_training'},
          ],
        }),
        throwsStateError,
      );
    },
  );

  test('empty repository validates and returns a typed empty result', () async {
    const repository = EmptyCanonicalExerciseSearchRepository<String>();
    const validQuery = CanonicalSearchQuery(
      criteria: [
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.capabilityRoot,
          valueId: 'cardio_conditioning',
        ),
      ],
    );
    final valid = await repository.search(validQuery);
    expect(valid.query, same(validQuery));
    expect(valid.total, 0);
    expect(valid.items, isEmpty);
    expect(valid.status, CanonicalSearchResultStatus.success);

    const invalidQuery = CanonicalSearchQuery(
      criteria: [
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingConcept,
          valueId: 'push',
        ),
      ],
    );
    final invalid = await repository.search(invalidQuery);
    expect(invalid.status, CanonicalSearchResultStatus.invalidQuery);
    expect(invalid.items, isEmpty);
  });

  test('canonical core has no database, legacy, or old feature imports', () {
    final files = Directory('lib/features/canonical_core')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));
    for (final file in files) {
      final source = file.readAsStringSync();
      expect(
        source,
        isNot(contains("features/canonical_search")),
        reason: file.path,
      );
      expect(
        source,
        isNot(contains("database/app_database")),
        reason: file.path,
      );
      expect(source, isNot(contains("services/exercise")), reason: file.path);
      if (!file.path.contains('validators')) {
        expect(source, isNot(contains('main_training')), reason: file.path);
      }
    }
  });

  test('registry is the sole active value list and draft is not bundled', () {
    final screen = File(
      'lib/features/canonical_core/screens/canonical_core_search_screen.dart',
    ).readAsStringSync();
    expect(screen, isNot(contains("'muscular_capacity'")));
    expect(screen, isNot(contains("'warmup'")));

    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, isNot(contains('docs/research/unapproved')));
    expect(
      File(
        'docs/research/unapproved/'
        'Canonical_Search_Subtrees_v0.1_Unapproved_Draft.md',
      ).existsSync(),
      isTrue,
    );
  });

  test('identity, variation, and protocol principles remain explicit', () {
    expect(CanonicalIdentityPrinciples.distinguishingFactors, hasLength(12));
    expect(CanonicalIdentityPrinciples.variationQuestion, isNotEmpty);
    expect(CanonicalIdentityPrinciples.protocolsAreNotExercises, isTrue);
    expect(CanonicalIdentityPrinciples.prescriptionDefinesIdentity, isFalse);
  });

  test('clean base keeps canonical core visible and legacy disabled', () {
    expect(CleanBaseConfig.canonicalSearchMenuVisible, isTrue);
    expect(CleanBaseConfig.canonicalCatalogueHasActiveExercises, isFalse);
    expect(CleanBaseConfig.legacySeedEnabled, isFalse);
    expect(CleanBaseConfig.legacyCatalogueVisible, isFalse);
    expect(CleanBaseConfig.legacyFiltersVisible, isFalse);
  });
}
