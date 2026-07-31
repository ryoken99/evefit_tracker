import 'dart:io';

import 'package:evefit_tracker/features/canonical_core/generated/arm_muscular_registry.g.dart';
import 'package:evefit_tracker/features/canonical_core/generated/exercises/canonical_exercises_registry.g.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_muscular_models.dart';
import 'package:evefit_tracker/features/canonical_core/repositories/canonical_muscular_repository.dart';
import 'package:evefit_tracker/features/canonical_core/repositories/generated_canonical_muscular_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = GeneratedCanonicalMuscularRepository();

  test('generated muscular and arm registry has the approved exact shape', () {
    expect(generatedCanonicalMuscleRegions, hasLength(16));
    expect(generatedCanonicalMuscleGroups, hasLength(45));
    expect(generatedCanonicalMuscles, hasLength(179));
    expect(generatedCanonicalMuscleComponents, hasLength(36));
    expect(generatedCanonicalMuscleJoints, hasLength(35));
    expect(generatedCanonicalMuscleActions, hasLength(94));
    expect(generatedCanonicalMuscleJointRelations, hasLength(365));
    expect(generatedCanonicalMuscleActionRelations, hasLength(484));
    expect(generatedCanonicalMuscleInteractionRelations, hasLength(394));
    expect(
      generatedCanonicalMuscleJointRelations.length +
          generatedCanonicalMuscleActionRelations.length +
          generatedCanonicalMuscleInteractionRelations.length,
      1243,
    );
    expect(generatedCanonicalMuscleTrainabilityProfiles, hasLength(179));

    expect(generatedCanonicalArmExerciseFamilies, hasLength(15));
    expect(generatedCanonicalArmEquipment, hasLength(33));
    expect(generatedCanonicalArmExercises, hasLength(36));
    expect(generatedCanonicalArmExercisePublicContents, hasLength(35));
    expect(generatedCanonicalArmExerciseVariants, hasLength(85));
    expect(generatedCanonicalArmExerciseMuscleRelations, hasLength(228));
    expect(generatedCanonicalArmExerciseJointRelations, hasLength(86));
    expect(generatedCanonicalArmExerciseActionRelations, hasLength(68));
    expect(generatedCanonicalArmExerciseEquipmentRelations, hasLength(91));
  });

  test('generated records have unique IDs and complete direct references', () {
    _expectUnique(generatedCanonicalMuscleRegions.map((item) => item.id));
    _expectUnique(generatedCanonicalMuscleGroups.map((item) => item.id));
    _expectUnique(generatedCanonicalMuscles.map((item) => item.id));
    _expectUnique(generatedCanonicalMuscleComponents.map((item) => item.id));
    _expectUnique(generatedCanonicalMuscleJoints.map((item) => item.id));
    _expectUnique(generatedCanonicalMuscleActions.map((item) => item.id));
    _expectUnique(generatedCanonicalArmExerciseFamilies.map((item) => item.id));
    _expectUnique(generatedCanonicalArmEquipment.map((item) => item.id));
    _expectUnique(generatedCanonicalArmExercises.map((item) => item.id));
    _expectUnique(generatedCanonicalArmExerciseVariants.map((item) => item.id));

    final regionIds = generatedCanonicalMuscleRegions
        .map((item) => item.id)
        .toSet();
    final groupIds = generatedCanonicalMuscleGroups
        .map((item) => item.id)
        .toSet();
    final muscleIds = generatedCanonicalMuscles.map((item) => item.id).toSet();
    final componentIds = generatedCanonicalMuscleComponents
        .map((item) => item.id)
        .toSet();
    final jointIds = generatedCanonicalMuscleJoints
        .map((item) => item.id)
        .toSet();
    final actionIds = generatedCanonicalMuscleActions
        .map((item) => item.id)
        .toSet();
    final familyIds = generatedCanonicalArmExerciseFamilies
        .map((item) => item.id)
        .toSet();
    final equipmentIds = generatedCanonicalArmEquipment
        .map((item) => item.id)
        .toSet();
    final exerciseIds = generatedCanonicalArmExercises
        .map((item) => item.id)
        .toSet();

    for (final group in generatedCanonicalMuscleGroups) {
      expect(regionIds, contains(group.regionId));
      expect(group.memberIds.every(muscleIds.contains), isTrue);
    }
    for (final muscle in generatedCanonicalMuscles) {
      expect(regionIds, contains(muscle.regionId));
      expect(groupIds, contains(muscle.groupId));
      expect(muscle.componentIds.every(componentIds.contains), isTrue);
      expect(muscle.jointIds.every(jointIds.contains), isTrue);
      expect(muscle.actionIds.every(actionIds.contains), isTrue);
    }
    for (final component in generatedCanonicalMuscleComponents) {
      expect(muscleIds, contains(component.muscleId));
    }
    for (final relation in generatedCanonicalArmExerciseMuscleRelations) {
      expect(exerciseIds, contains(relation.exerciseId));
      expect(muscleIds, contains(relation.muscleId));
      expect(
        relation.componentId == null ||
            componentIds.contains(relation.componentId),
        isTrue,
      );
    }
    for (final relation in generatedCanonicalArmExerciseJointRelations) {
      expect(exerciseIds, contains(relation.exerciseId));
      expect(jointIds, contains(relation.jointId));
    }
    for (final relation in generatedCanonicalArmExerciseActionRelations) {
      expect(exerciseIds, contains(relation.exerciseId));
      expect(actionIds, contains(relation.actionId));
    }
    for (final relation in generatedCanonicalArmExerciseEquipmentRelations) {
      expect(exerciseIds, contains(relation.exerciseId));
      expect(equipmentIds, contains(relation.equipmentId));
    }
    for (final exercise in generatedCanonicalArmExercises) {
      expect(familyIds, contains(exercise.familyId));
      expect(
        exercise.requiredEquipmentIds.every(equipmentIds.contains),
        isTrue,
      );
      expect(
        exercise.optionalEquipmentIds.every(equipmentIds.contains),
        isTrue,
      );
      expect(
        exercise.alternativeEquipmentIds.every(equipmentIds.contains),
        isTrue,
      );
    }
    for (final variant in generatedCanonicalArmExerciseVariants) {
      expect(exerciseIds, contains(variant.parentExerciseId));
      expect(variant.equipmentIds.every(equipmentIds.contains), isTrue);
    }
  });

  test(
    'public projection, publication states and source provenance are exact',
    () {
      expect(repository.publicRegions.map((item) => item.id).toSet(), <String>{
        'arm',
        'forearm',
      });
      expect(
        generatedCanonicalMuscleGroups.where((item) => item.isPublic),
        hasLength(7),
      );
      expect(
        generatedCanonicalMuscles.where((item) => item.isPublic),
        hasLength(23),
      );
      expect(
        _stateCount(generatedCanonicalArmExercises),
        <CanonicalArmPublicationState, int>{
          CanonicalArmPublicationState.approvedPublic: 29,
          CanonicalArmPublicationState.approvedWithLimits: 6,
          CanonicalArmPublicationState.specialistReview: 1,
        },
      );
      expect(
        generatedCanonicalArmExerciseVariants.where((item) => item.hasLimits),
        hasLength(21),
      );
      expect(generatedCanonicalArmMuscularProvenance.schemaVersion, '0.1');
      expect(generatedCanonicalArmMuscularProvenance.generatorVersion, '0.1.0');
      expect(
        generatedCanonicalArmMuscularProvenance.muscularBundleSha256,
        'a1876a1d4bc21ab54b3828774f66a99519a4953dc00191e69475d8c15b8b30b0',
      );
      expect(
        generatedCanonicalArmMuscularProvenance.armCatalogueBundleSha256,
        '247b9c6b36e3dd93d7b9c4fc4e6569c2b71eb9c710b8fb2b9ba62ebc86dfd71f',
      );
    },
  );

  test(
    'repository keeps specialist content hidden and preserves approved limits',
    () {
      expect(repository.exerciseById('resisted_thumb_opposition'), isNull);
      expect(
        repository.publicRegions
            .expand((region) => repository.groupsForRegion(region.id))
            .expand((group) => repository.exercisesForGroup(group.id))
            .map((result) => result.exercise.id),
        isNot(contains('resisted_thumb_opposition')),
      );

      const limitedIds = <String>{
        'bench_dip',
        'dead_hang',
        'machine_triceps_extension',
        'wrist_radial_deviation',
        'wrist_roller',
        'wrist_ulnar_deviation',
      };
      for (final id in limitedIds) {
        final result = repository.exerciseById(id);
        expect(result, isNotNull, reason: id);
        expect(result!.exercise.hasLimits, isTrue, reason: id);
        expect(result.content.limitReasonPtPt.trim(), isNotEmpty, reason: id);
        expect(result.content.cautionsPtPt, isNotEmpty, reason: id);
        expect(result.exercise.stopConditionsPtPt, isNotEmpty, reason: id);
      }
    },
  );

  test(
    'anatomical results dedupe exercises, retain strongest role and grip separately',
    () {
      final allResults = <CanonicalArmExerciseResult>[];
      for (final region in repository.publicRegions) {
        for (final group in repository.groupsForRegion(region.id)) {
          final results = repository.exercisesForGroup(group.id);
          allResults.addAll(results);
          _expectUnique(results.map((result) => result.exercise.id));
          for (final result in results) {
            final expected = _strongestSection(
              result.muscleRelations.map((relation) => relation.role),
            );
            expect(result.section, expected, reason: result.exercise.id);
          }
        }
      }
      expect(allResults, isNotEmpty);
      final gripResults = allResults
          .where(
            (result) => result.muscleRelations.any(
              (relation) => relation.role == CanonicalArmMuscleRole.gripLimiter,
            ),
          )
          .toList(growable: false);
      expect(gripResults, isNotEmpty);
      expect(
        gripResults.any(
          (result) => result.section == CanonicalArmExerciseSection.gripLimiter,
        ),
        isTrue,
      );
    },
  );

  test(
    'coracobrachialis is an honest empty state and towel hang stays a child',
    () {
      expect(repository.muscleById('coracobrachialis'), isNotNull);
      expect(repository.exercisesForMuscle('coracobrachialis'), isEmpty);
      final deadHang = repository.exerciseById('dead_hang');
      expect(deadHang, isNotNull);
      expect(
        deadHang!.variants.map((variant) => variant.id),
        contains('towel_hang'),
      );
      expect(
        generatedCanonicalArmExerciseVariants
            .singleWhere((variant) => variant.id == 'towel_hang')
            .parentExerciseId,
        'dead_hang',
      );
    },
  );

  test(
    'arm runtime is generated data only and does not read legacy, DB or claims',
    () {
      final root = Directory('lib/features/canonical_core/generated');
      final files = root
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .where(
            (file) =>
                file.path.contains(
                  '${Platform.pathSeparator}muscular${Platform.pathSeparator}',
                ) ||
                file.path.contains(
                  '${Platform.pathSeparator}arms${Platform.pathSeparator}',
                ) ||
                file.path.endsWith('arm_muscular_registry.g.dart'),
          )
          .toList(growable: false);
      expect(files, isNotEmpty);
      for (final file in files) {
        expect(
          file.lengthSync(),
          lessThanOrEqualTo(750 * 1024),
          reason: file.path,
        );
        final source = file.readAsStringSync();
        for (final forbidden in <RegExp>[
          RegExp(r'\bZipDecoder\b'),
          RegExp(r'\bFile\s*\('),
          RegExp(r'\b(?:App)?Database\b'),
          RegExp(r'\blegacy\b', caseSensitive: false),
          RegExp(r'\bclaims?\b', caseSensitive: false),
          RegExp(r'\bfour_pillar\b', caseSensitive: false),
          RegExp(r'\bexercise_ids\b', caseSensitive: false),
        ]) {
          expect(
            source,
            isNot(contains(forbidden)),
            reason: '${file.path}: ${forbidden.pattern}',
          );
        }
      }
      final armIds = generatedCanonicalArmExercises
          .map((item) => item.id)
          .toSet();
      final wave1Ids = generatedCanonicalWave1Exercises
          .map((item) => item.id)
          .toSet();
      expect(armIds.intersection(wave1Ids), isEmpty);
    },
  );
}

void _expectUnique(Iterable<String> ids) {
  final values = ids.toList(growable: false);
  expect(values.toSet(), hasLength(values.length));
}

Map<CanonicalArmPublicationState, int> _stateCount(
  Iterable<CanonicalArmExercise> exercises,
) => <CanonicalArmPublicationState, int>{
  for (final state in CanonicalArmPublicationState.values)
    state: exercises.where((exercise) => exercise.state == state).length,
};

CanonicalArmExerciseSection _strongestSection(
  Iterable<CanonicalArmMuscleRole> roles,
) {
  final sections = roles.map(_sectionForRole).toSet();
  return CanonicalArmExerciseSection.values.firstWhere(sections.contains);
}

CanonicalArmExerciseSection _sectionForRole(
  CanonicalArmMuscleRole role,
) => switch (role) {
  CanonicalArmMuscleRole.primary || CanonicalArmMuscleRole.primaryContextual =>
    CanonicalArmExerciseSection.primaryTarget,
  CanonicalArmMuscleRole.secondary || CanonicalArmMuscleRole.synergist =>
    CanonicalArmExerciseSection.relevantParticipation,
  CanonicalArmMuscleRole.stabilizer ||
  CanonicalArmMuscleRole.neutralizer ||
  CanonicalArmMuscleRole.antagonistControl =>
    CanonicalArmExerciseSection.stabilization,
  CanonicalArmMuscleRole.gripLimiter => CanonicalArmExerciseSection.gripLimiter,
  CanonicalArmMuscleRole.specialistReview => throw StateError(
    'Specialist roles are not public.',
  ),
};
