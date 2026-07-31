import '../models/canonical_muscular_models.dart';

enum CanonicalArmExerciseSection {
  primaryTarget,
  relevantParticipation,
  stabilization,
  gripLimiter,
}

class CanonicalArmExerciseResult {
  const CanonicalArmExerciseResult({
    required this.exercise,
    required this.content,
    required this.section,
    required this.muscleRelations,
    required this.variants,
  });

  final CanonicalArmExercise exercise;
  final CanonicalArmExercisePublicContent content;
  final CanonicalArmExerciseSection section;
  final List<CanonicalArmExerciseMuscleRelation> muscleRelations;
  final List<CanonicalArmExerciseVariant> variants;
}

abstract interface class CanonicalMuscularRepository {
  List<CanonicalMuscleRegion> get publicRegions;

  List<CanonicalMuscleGroup> groupsForRegion(String regionId);

  List<CanonicalMuscle> musclesForGroup(String groupId);

  CanonicalMuscle? muscleById(String muscleId);

  List<CanonicalMuscleComponent> componentsForMuscle(String muscleId);

  List<CanonicalMuscleJoint> jointsForMuscle(String muscleId);

  List<CanonicalMuscleAction> actionsForMuscle(String muscleId);

  List<CanonicalArmExerciseResult> exercisesForGroup(String groupId);

  List<CanonicalArmExerciseResult> exercisesForMuscle(String muscleId);

  CanonicalArmExerciseResult? exerciseById(String exerciseId);

  CanonicalArmExerciseFamily? familyById(String familyId);

  CanonicalArmEquipment? equipmentById(String equipmentId);

  CanonicalMuscleJoint? jointById(String jointId);

  CanonicalMuscleAction? actionById(String actionId);
}

class InMemoryCanonicalMuscularRepository
    implements CanonicalMuscularRepository {
  InMemoryCanonicalMuscularRepository({
    required List<CanonicalMuscleRegion> regions,
    required List<CanonicalMuscleGroup> groups,
    required List<CanonicalMuscle> muscles,
    required List<CanonicalMuscleComponent> components,
    required List<CanonicalMuscleJoint> joints,
    required List<CanonicalMuscleAction> actions,
    required List<CanonicalArmExerciseFamily> families,
    required List<CanonicalArmEquipment> equipment,
    required List<CanonicalArmExercise> exercises,
    required List<CanonicalArmExercisePublicContent> publicContents,
    required List<CanonicalArmExerciseVariant> variants,
    required List<CanonicalArmExerciseMuscleRelation> muscleRelations,
  }) : _regions = List.unmodifiable(regions),
       _groups = List.unmodifiable(groups),
       _muscles = List.unmodifiable(muscles),
       _components = List.unmodifiable(components),
       _joints = List.unmodifiable(joints),
       _actions = List.unmodifiable(actions),
       _families = List.unmodifiable(families),
       _equipment = List.unmodifiable(equipment),
       _exercises = List.unmodifiable(exercises),
       _publicContents = List.unmodifiable(publicContents),
       _variants = List.unmodifiable(variants),
       _muscleRelations = List.unmodifiable(muscleRelations) {
    _validate();
  }

  final List<CanonicalMuscleRegion> _regions;
  final List<CanonicalMuscleGroup> _groups;
  final List<CanonicalMuscle> _muscles;
  final List<CanonicalMuscleComponent> _components;
  final List<CanonicalMuscleJoint> _joints;
  final List<CanonicalMuscleAction> _actions;
  final List<CanonicalArmExerciseFamily> _families;
  final List<CanonicalArmEquipment> _equipment;
  final List<CanonicalArmExercise> _exercises;
  final List<CanonicalArmExercisePublicContent> _publicContents;
  final List<CanonicalArmExerciseVariant> _variants;
  final List<CanonicalArmExerciseMuscleRelation> _muscleRelations;

  late final Map<String, CanonicalMuscle> _muscleById = {
    for (final muscle in _muscles) muscle.id: muscle,
  };
  late final Map<String, CanonicalArmExercise> _exerciseById = {
    for (final exercise in _exercises) exercise.id: exercise,
  };
  late final Map<String, CanonicalArmExercisePublicContent> _contentById = {
    for (final content in _publicContents) content.exerciseId: content,
  };
  late final Map<String, CanonicalArmExerciseFamily> _familyById = {
    for (final family in _families) family.id: family,
  };
  late final Map<String, CanonicalArmEquipment> _equipmentById = {
    for (final value in _equipment) value.id: value,
  };
  late final Map<String, CanonicalMuscleJoint> _jointById = {
    for (final value in _joints) value.id: value,
  };
  late final Map<String, CanonicalMuscleAction> _actionById = {
    for (final value in _actions) value.id: value,
  };

  @override
  List<CanonicalMuscleRegion> get publicRegions => _sortedByName(
    _regions.where(
      (region) =>
          region.isPublic &&
          region.bodyArea == 'upper_body' &&
          (region.id == 'arm' || region.id == 'forearm'),
    ),
    (region) => region.namePtPt,
  );

  @override
  List<CanonicalMuscleGroup> groupsForRegion(String regionId) => _sortedByName(
    _groups.where((group) => group.isPublic && group.regionId == regionId),
    (group) => group.namePtPt,
  );

  @override
  List<CanonicalMuscle> musclesForGroup(String groupId) => _sortedByName(
    _muscles.where((muscle) => muscle.isPublic && muscle.groupId == groupId),
    (muscle) => muscle.namePtPt,
  );

  @override
  CanonicalMuscle? muscleById(String muscleId) {
    final muscle = _muscleById[muscleId];
    return muscle?.isPublic == true ? muscle : null;
  }

  @override
  List<CanonicalMuscleComponent> componentsForMuscle(String muscleId) =>
      List.unmodifiable(
        _components.where((component) => component.muscleId == muscleId),
      );

  @override
  List<CanonicalMuscleJoint> jointsForMuscle(String muscleId) {
    final ids = muscleById(muscleId)?.jointIds.toSet() ?? const <String>{};
    return _sortedByName(
      _joints.where((joint) => ids.contains(joint.id)),
      (joint) => joint.namePtPt,
    );
  }

  @override
  List<CanonicalMuscleAction> actionsForMuscle(String muscleId) {
    final ids = muscleById(muscleId)?.actionIds.toSet() ?? const <String>{};
    return _sortedByName(
      _actions.where((action) => ids.contains(action.id)),
      (action) => action.namePtPt,
    );
  }

  @override
  List<CanonicalArmExerciseResult> exercisesForGroup(String groupId) {
    final muscleIds = musclesForGroup(
      groupId,
    ).map((muscle) => muscle.id).toSet();
    return _resultsForMuscles(muscleIds);
  }

  @override
  List<CanonicalArmExerciseResult> exercisesForMuscle(String muscleId) {
    if (muscleById(muscleId) == null) return const [];
    return _resultsForMuscles({muscleId});
  }

  @override
  CanonicalArmExerciseResult? exerciseById(String exerciseId) {
    final exercise = _publicExercise(exerciseId);
    final content = _contentById[exerciseId];
    if (exercise == null || content == null) return null;
    final relations = _muscleRelations
        .where((relation) => relation.exerciseId == exerciseId)
        .where(
          (relation) =>
              relation.role != CanonicalArmMuscleRole.specialistReview,
        )
        .toList(growable: false);
    return CanonicalArmExerciseResult(
      exercise: exercise,
      content: content,
      section: _strongestSection(relations.map((relation) => relation.role)),
      muscleRelations: List.unmodifiable(relations),
      variants: _variantsFor(exerciseId),
    );
  }

  @override
  CanonicalArmExerciseFamily? familyById(String familyId) =>
      _familyById[familyId];

  @override
  CanonicalArmEquipment? equipmentById(String equipmentId) =>
      _equipmentById[equipmentId];

  @override
  CanonicalMuscleJoint? jointById(String jointId) => _jointById[jointId];

  @override
  CanonicalMuscleAction? actionById(String actionId) => _actionById[actionId];

  List<CanonicalArmExerciseResult> _resultsForMuscles(Set<String> muscleIds) {
    final relevant = _muscleRelations
        .where((relation) => muscleIds.contains(relation.muscleId))
        .where(
          (relation) =>
              relation.role != CanonicalArmMuscleRole.specialistReview,
        )
        .toList(growable: false);
    final exerciseIds = relevant.map((relation) => relation.exerciseId).toSet();
    final results = <CanonicalArmExerciseResult>[];
    for (final exerciseId in exerciseIds) {
      final exercise = _publicExercise(exerciseId);
      final content = _contentById[exerciseId];
      if (exercise == null || content == null) continue;
      final relations = relevant
          .where((relation) => relation.exerciseId == exerciseId)
          .toList(growable: false);
      results.add(
        CanonicalArmExerciseResult(
          exercise: exercise,
          content: content,
          section: _strongestSection(
            relations.map((relation) => relation.role),
          ),
          muscleRelations: List.unmodifiable(relations),
          variants: _variantsFor(exerciseId),
        ),
      );
    }
    results.sort((left, right) {
      final section = left.section.index.compareTo(right.section.index);
      return section != 0
          ? section
          : left.exercise.namePtPt.compareTo(right.exercise.namePtPt);
    });
    return List.unmodifiable(results);
  }

  CanonicalArmExercise? _publicExercise(String exerciseId) {
    final exercise = _exerciseById[exerciseId];
    if (exercise == null ||
        !exercise.isPublicEligible ||
        exercise.state == CanonicalArmPublicationState.specialistReview) {
      return null;
    }
    return exercise;
  }

  List<CanonicalArmExerciseVariant> _variantsFor(String exerciseId) =>
      List.unmodifiable(
        _variants.where(
          (variant) =>
              variant.parentExerciseId == exerciseId &&
              variant.state != CanonicalArmPublicationState.specialistReview,
        ),
      );

  CanonicalArmExerciseSection _strongestSection(
    Iterable<CanonicalArmMuscleRole> roles,
  ) {
    final sections = roles.map(_sectionForRole).toSet();
    for (final section in CanonicalArmExerciseSection.values) {
      if (sections.contains(section)) return section;
    }
    throw StateError('Exercise result has no public muscle role.');
  }

  CanonicalArmExerciseSection _sectionForRole(CanonicalArmMuscleRole role) =>
      switch (role) {
        CanonicalArmMuscleRole.primary ||
        CanonicalArmMuscleRole.primaryContextual =>
          CanonicalArmExerciseSection.primaryTarget,
        CanonicalArmMuscleRole.secondary || CanonicalArmMuscleRole.synergist =>
          CanonicalArmExerciseSection.relevantParticipation,
        CanonicalArmMuscleRole.stabilizer ||
        CanonicalArmMuscleRole.neutralizer ||
        CanonicalArmMuscleRole.antagonistControl =>
          CanonicalArmExerciseSection.stabilization,
        CanonicalArmMuscleRole.gripLimiter =>
          CanonicalArmExerciseSection.gripLimiter,
        CanonicalArmMuscleRole.specialistReview => throw StateError(
          'Specialist roles are not public.',
        ),
      };

  void _validate() {
    _requireUnique(_regions.map((value) => value.id), 'region');
    _requireUnique(_groups.map((value) => value.id), 'group');
    _requireUnique(_muscles.map((value) => value.id), 'muscle');
    _requireUnique(_exercises.map((value) => value.id), 'exercise');
    _requireUnique(_variants.map((value) => value.id), 'variant');
    _requireUnique(
      _publicContents.map((value) => value.exerciseId),
      'public exercise content',
    );
    final publicIds = _exercises
        .where(
          (exercise) =>
              exercise.isPublicEligible &&
              exercise.state != CanonicalArmPublicationState.specialistReview,
        )
        .map((exercise) => exercise.id)
        .toSet();
    if (publicIds.length != 35 ||
        _contentById.keys.toSet().difference(publicIds).isNotEmpty ||
        publicIds.difference(_contentById.keys.toSet()).isNotEmpty) {
      throw StateError(
        'Arm catalogue must expose exactly 35 complete exercises.',
      );
    }
    if (_publicExercise('resisted_thumb_opposition') != null) {
      throw StateError('Specialist thumb opposition must remain internal.');
    }
    if (publicRegions.length != 2 ||
        _groups.where((group) => group.isPublic).length != 7 ||
        _muscles.where((muscle) => muscle.isPublic).length != 23) {
      throw StateError('Public muscular projection must remain 2/7/23.');
    }
    for (final variant in _variants) {
      if (!_exerciseById.containsKey(variant.parentExerciseId)) {
        throw StateError('Variant ${variant.id} has no parent exercise.');
      }
    }
  }
}

void _requireUnique(Iterable<String> values, String label) {
  final list = values.toList(growable: false);
  if (list.toSet().length != list.length) {
    throw StateError('Duplicate $label id.');
  }
}

List<T> _sortedByName<T>(Iterable<T> values, String Function(T) name) {
  final result = values.toList(growable: false)
    ..sort((left, right) => name(left).compareTo(name(right)));
  return List.unmodifiable(result);
}
