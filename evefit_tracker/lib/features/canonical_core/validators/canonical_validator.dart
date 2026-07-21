import '../data/canonical_registry.dart';
import '../models/canonical_core_models.dart';
import '../models/training_intention_models.dart';

class CanonicalValidator {
  const CanonicalValidator({this.registry = const CanonicalRegistry()});

  final CanonicalRegistry registry;

  static const forbiddenQueryTokens = <String>{
    'equipment',
    'equipment_id',
    'equipment_ids',
    'exercise_id',
    'exercise_ids',
    'exercise',
    'environment',
    'environment_id',
    'environment_ids',
    'fixed_results',
    'legacy',
    'node_paths',
    'legacy_ids',
    'parent',
    'parent_id',
    'parent_ids',
    'subcategory_ids',
  };

  void validateRegistryOrThrow() {
    _expect(
      CanonicalRegistry.axisDefinitions.length == 4,
      'The canonical core requires exactly four pillar axes.',
    );
    _expect(
      CanonicalRegistry.approvedCapabilityRoots.length == 8,
      'The canonical core requires exactly eight capability roots.',
    );
    _expect(
      CanonicalRegistry.approvedUsageContexts.length == 7,
      'The canonical core requires exactly seven usage contexts.',
    );
    _expect(
      CanonicalRegistry.approvedTrainingIntentions.length == 591,
      'The canonical core requires exactly 591 training intentions.',
    );
    _expect(
      CanonicalRegistry.approvedTrainingConcepts.length == 35,
      'The canonical core requires exactly thirty-five training concepts.',
    );
    _expect(
      CanonicalRegistry.approvedAttributeDefinitions.isEmpty,
      'No canonical attributes are approved.',
    );
    _expect(
      CanonicalRegistry.capabilityConceptRelations.length == 40,
      'The canonical core requires exactly forty capability-concept relations.',
    );
    _expect(
      registry.approvedPillarValues.length == 641,
      'The canonical core requires exactly 641 approved values.',
    );
    _expect(
      CanonicalRegistry.trainingIntentionDefinitions.length == 591,
      'The training intention registry requires exactly 591 definitions.',
    );
    _expect(
      CanonicalRegistry.trainingPaths.length == 280,
      'The training intention registry requires exactly 280 paths.',
    );
    _expect(
      CanonicalRegistry.pathIntentionLinks.length == 771,
      'The training intention registry requires exactly 771 links.',
    );

    final axes = CanonicalRegistry.axisDefinitions;
    _expect(
      axes.map((definition) => definition.axis).toSet().length == 4,
      'Pillar axis definitions must be unique.',
    );
    _expect(
      axes.map((definition) => definition.displayOrder).toSet().length == 4,
      'Pillar axis display orders must be unique.',
    );
    for (final axis in axes) {
      _expect(
        axis.schemaVersion == canonicalCoreSchemaVersion,
        'Pillar axis ${axis.axis.name} has an unexpected schema version.',
      );
      _expect(
        axis.displayNamePtPt.trim().isNotEmpty &&
            axis.descriptionPtPt.trim().isNotEmpty,
        'Pillar axis ${axis.axis.name} requires PT-PT metadata.',
      );
    }

    final values = registry.approvedPillarValues;
    _expect(
      values.map((value) => value.id).toSet().length == values.length,
      'Canonical pillar IDs must be globally unique.',
    );
    for (final value in values) {
      _expect(
        RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(value.id),
        'Canonical pillar ID ${value.id} must be stable snake_case.',
      );
      _expect(
        value.schemaVersion == canonicalCoreSchemaVersion,
        'Canonical pillar ${value.id} has an unexpected schema version.',
      );
      _expect(
        value.status == CanonicalDefinitionStatus.approved,
        'Only approved values may be exposed by the active registry.',
      );
      _expect(
        value.displayNamePtPt.trim().isNotEmpty &&
            value.descriptionPtPt.trim().isNotEmpty,
        'Canonical pillar ${value.id} requires PT-PT metadata.',
      );
    }

    for (final axis in CanonicalPillarAxis.values) {
      final orders = registry
          .valuesForAxis(axis)
          .map((value) => value.displayOrder)
          .toList();
      _expect(
        orders.length == orders.toSet().length,
        'Display orders must be unique within ${axis.name}.',
      );
    }

    final capabilityRootIds = CanonicalRegistry.approvedCapabilityRoots
        .map((value) => value.id)
        .toSet();
    final trainingConceptIds = CanonicalRegistry.approvedTrainingConcepts
        .map((value) => value.id)
        .toSet();
    final relationPairs = CanonicalRegistry.capabilityConceptRelations
        .map(
          (relation) =>
              '${relation.capabilityRootId}/${relation.trainingConceptId}',
        )
        .toSet();
    _expect(
      relationPairs.length ==
          CanonicalRegistry.capabilityConceptRelations.length,
      'Capability-concept relations must be unique.',
    );
    for (final relation in CanonicalRegistry.capabilityConceptRelations) {
      _expect(
        capabilityRootIds.contains(relation.capabilityRootId),
        'Relation capability ${relation.capabilityRootId} is not approved.',
      );
      _expect(
        trainingConceptIds.contains(relation.trainingConceptId),
        'Relation concept ${relation.trainingConceptId} is not an approved training concept.',
      );
      _expect(
        relation.displayOrder > 0,
        'Capability-concept relations require a positive display order.',
      );
      _expect(
        relation.schemaVersion == canonicalCoreSchemaVersion,
        'Capability-concept relation has an unexpected schema version.',
      );
    }
    final relatedConceptIds = CanonicalRegistry.capabilityConceptRelations
        .map((relation) => relation.trainingConceptId)
        .toSet();
    _expect(
      relatedConceptIds.length == trainingConceptIds.length &&
          relatedConceptIds.containsAll(trainingConceptIds),
      'Every approved training concept must be related to a capability.',
    );
    for (final capabilityRootId in capabilityRootIds) {
      final relations = registry.relationsForCapability(capabilityRootId);
      final expectedOrders = List.generate(
        relations.length,
        (index) => index + 1,
      );
      _expect(
        relations.isNotEmpty,
        'Every approved capability must have training concepts.',
      );
      _expect(
        relations
                .map((relation) => relation.displayOrder)
                .toList()
                .toString() ==
            expectedOrders.toString(),
        'Capability $capabilityRootId requires contiguous relation display orders.',
      );
      final concepts = registry.trainingConceptsForCapability(capabilityRootId);
      _expect(
        concepts.length == relations.length,
        'Capability $capabilityRootId must resolve each relation.',
      );
      for (var index = 0; index < relations.length; index++) {
        _expect(
          identical(
            concepts[index],
            registry.valueById[relations[index].trainingConceptId],
          ),
          'Capability $capabilityRootId must resolve global concept identities.',
        );
      }
    }

    _validateTrainingIntentions();
  }

  void _validateTrainingIntentions() {
    final definitions = CanonicalRegistry.trainingIntentionDefinitions;
    final paths = CanonicalRegistry.trainingPaths;
    final links = CanonicalRegistry.pathIntentionLinks;
    final definitionIds = definitions
        .map((definition) => definition.pillar.id)
        .toSet();
    final pathNumbers = paths.map((path) => path.sourceNumber).toList();

    _expect(
      definitionIds.length == definitions.length,
      'Training intention IDs must be globally unique.',
    );
    _expect(
      definitions
              .map((definition) => definition.sourceOrder)
              .toList()
              .toString() ==
          List<int>.generate(
            definitions.length,
            (index) => index + 1,
          ).toString(),
      'Training intention source orders must be contiguous.',
    );
    _expect(
      pathNumbers.toString() ==
          List<int>.generate(paths.length, (index) => index + 1).toString(),
      'Training path source numbers must be contiguous.',
    );
    _expect(
      paths
              .where(
                (path) => path.status == CanonicalTrainingPathStatus.compatible,
              )
              .length ==
          261,
      'The training intention registry requires exactly 261 compatible paths.',
    );
    _expect(
      paths
              .where(
                (path) =>
                    path.status == CanonicalTrainingPathStatus.incompatible,
              )
              .length ==
          19,
      'The training intention registry requires exactly 19 incompatible paths.',
    );
    _expect(
      paths.map((path) => path.key).toSet().length == paths.length,
      'Training path keys must be unique.',
    );

    for (final definition in definitions) {
      final id = definition.pillar.id;
      _expect(
        identical(registry.valueById[id], definition.pillar),
        'Training intention $id must retain its pillar projection identity.',
      );
      _expect(
        definition.sourceRegistryVersion ==
                canonicalTrainingIntentionsRegistryVersion &&
            definition.runtimeProvenanceId.isNotEmpty,
        'Training intention $id has unexpected runtime provenance.',
      );
      _expect(
        definition.occurrenceCount > 0 && definition.possibleRoles.isNotEmpty,
        'Training intention $id requires occurrences and roles.',
      );
      _validateReferences(
        id,
        definition.globallyIncompatibleAlternativeIds,
        definitionIds,
        'incompatible alternative',
      );
      _validateReferences(
        id,
        definition.globallyCompatibleComplementaryIds,
        definitionIds,
        'compatible complementary',
      );
    }

    final linksByIntentionId = <String, List<CanonicalPathIntentionLink>>{};
    final roleCountsByIntentionId =
        <String, Map<CanonicalTrainingIntentionRole, int>>{};
    final linkKeys = <String>{};
    final contextualLabels = <String>{};
    for (final link in links) {
      final path =
          link.pathSourceNumber > 0 && link.pathSourceNumber <= paths.length
          ? paths[link.pathSourceNumber - 1]
          : null;
      if (path == null || path.sourceNumber != link.pathSourceNumber) {
        throw StateError('Training intention link references an unknown path.');
      }
      _expect(
        definitionIds.contains(link.intentionId),
        'Training intention link references an unknown intention.',
      );
      _expect(
        linkKeys.add('${link.pathSourceNumber}/${link.intentionId}'),
        'Training intention links must not duplicate a path and intention.',
      );
      _expect(
        link.sourceRegistryVersion ==
                canonicalTrainingIntentionsRegistryVersion &&
            link.runtimeProvenanceId.isNotEmpty,
        'Training intention link has unexpected runtime provenance.',
      );
      final definition =
          registry.trainingIntentionDefinitionById[link.intentionId]!;
      _expect(
        definition.declaredUsageContextIds.contains(path.key.usageContextId) &&
            definition.declaredCapabilityRootIds.contains(
              path.key.capabilityRootId,
            ) &&
            definition.declaredTrainingConceptIds.contains(
              path.key.trainingConceptId,
            ),
        'Training intention ${link.intentionId} is not declared for ${path.key.contractId}.',
      );
      _expect(
        definition.possibleRoles.contains(link.role),
        'Training intention link role is not declared by ${link.intentionId}.',
      );
      (linksByIntentionId[link.intentionId] ??= []).add(link);
      final roleCounts = roleCountsByIntentionId.putIfAbsent(
        link.intentionId,
        () => {},
      );
      roleCounts[link.role] = (roleCounts[link.role] ?? 0) + 1;
      contextualLabels.addAll(link.contextualLabelsPtPt);
    }
    _expect(
      contextualLabels.length == 59,
      'Training intention links require exactly 59 unique contextual labels.',
    );
    _expect(
      contextualLabels.every((label) => !label.contains('_')),
      'Training intention contextual labels must remain presentation text.',
    );

    for (final path in paths) {
      final resolved = registry.resolvedOptionsForPath(path.key);
      final pathLinks = registry.linksForPath(path.key);
      _expect(
        identical(registry.pathForKey(path.key), path) &&
            identical(registry.pathForContractId(path.key.contractId), path),
        'Training path ${path.key.contractId} must be indexed by key.',
      );
      _expect(
        path.sourceRegistryVersion ==
                canonicalTrainingIntentionsRegistryVersion &&
            path.runtimeProvenanceId.isNotEmpty,
        'Training path ${path.key.contractId} has unexpected runtime provenance.',
      );
      _expect(
        path.status != CanonicalTrainingPathStatus.incompatible ||
            pathLinks.isEmpty,
        'Incompatible path ${path.key.contractId} cannot expose intentions.',
      );
      _expect(
        pathLinks.map((link) => link.displayOrder).toList().toString() ==
            List<int>.generate(
              pathLinks.length,
              (index) => index + 1,
            ).toString(),
        'Path ${path.key.contractId} requires contiguous intention orders.',
      );
      _expect(
        resolved.length == pathLinks.length,
        'Path ${path.key.contractId} must resolve its ordered links.',
      );
      for (var index = 0; index < resolved.length; index++) {
        final option = resolved[index];
        _expect(
          identical(option.link, pathLinks[index]),
          'Path ${path.key.contractId} must preserve link order.',
        );
        _expect(
          option.effectiveOperationalRiskTier.index >=
              option.definition.operationalRiskTier.index,
          'Path ${path.key.contractId} cannot reduce operational risk.',
        );
        _expect(
          option.pathOperationalRiskModifierTextPtPt ==
                  path.operationalRiskModifierPtPt &&
              option.pathClinicalReviewModifierTextPtPt ==
                  path.clinicalReviewModifierPtPt,
          'Path ${path.key.contractId} must preserve modifier text separately.',
        );
      }
    }
    for (final definition in definitions) {
      final linked = linksByIntentionId[definition.pillar.id] ?? const [];
      final roleCounts =
          roleCountsByIntentionId[definition.pillar.id] ?? const {};
      _expect(
        linked.length == definition.occurrenceCount,
        'Training intention ${definition.pillar.id} occurrence count is invalid.',
      );
      _expect(
        definition.possibleRoles.length ==
                definition.possibleRoles.toSet().length &&
            roleCounts.length == definition.possibleRoles.length &&
            roleCounts.keys.every(definition.possibleRoles.contains) &&
            roleCounts.values.fold(0, (total, count) => total + count) ==
                definition.occurrenceCount,
        'Training intention ${definition.pillar.id} role counts do not match its declaration.',
      );
      _expect(
        registry.pathsForIntention(definition.pillar.id).length ==
            linked.length,
        'Training intention ${definition.pillar.id} must be covered by indexed paths.',
      );
    }

    _expect(
      _hasExactDistribution(
        _distribution(
          definitions.map((definition) => definition.type.contractId),
        ),
        const {
          'adaptation_outcome': 100,
          'acute_preparation': 89,
          'targeted_activation': 98,
          'recovery_activity': 56,
          'cooldown_regulation': 20,
          'prevention_capacity': 102,
          'functional_restoration': 92,
          'technical_learning': 25,
          'self_regulation': 9,
        },
      ),
      'Training intention type distribution is invalid.',
    );
    _expect(
      _hasExactDistribution(
        _distribution(
          definitions.map(
            (definition) => definition.operationalRiskTier.contractId,
          ),
        ),
        const {
          'low': 92,
          'moderate': 370,
          'high': 37,
          'clinically_restricted': 92,
        },
      ),
      'Training intention risk distribution is invalid.',
    );
    _expect(
      _hasExactDistribution(
        _distribution(
          definitions.map(
            (definition) => definition.clinicalReviewRequired.contractId,
          ),
        ),
        const {'yes': 100, 'no': 491},
      ),
      'Training intention clinical review distribution is invalid.',
    );
    _expect(
      _hasExactDistribution(
        _distribution(links.map((link) => link.role.contractId)),
        const {
          'principal_candidate': 238,
          'alternative_primary': 74,
          'complementary': 412,
          'conditional_complementary': 33,
          'hidden_advanced': 14,
        },
      ),
      'Training intention role distribution is invalid.',
    );
  }

  void _validateReferences(
    String sourceId,
    List<String> references,
    Set<String> definitionIds,
    String referenceKind,
  ) {
    _expect(
      references.length == references.toSet().length,
      'Training intention $sourceId has duplicate $referenceKind references.',
    );
    for (final referenceId in references) {
      _expect(
        referenceId != sourceId && definitionIds.contains(referenceId),
        'Training intention $sourceId has an invalid $referenceKind $referenceId.',
      );
    }
  }

  List<String> queryErrors(CanonicalSearchQuery query) {
    final errors = <String>[];
    if (query.schemaVersion != canonicalCoreSearchNamespace) {
      errors.add('Unexpected canonical query schema version.');
    }
    if (query.criteria.isEmpty || query.criteria.length > 4) {
      errors.add('A canonical query requires between one and four criteria.');
    }
    validateRawQueryData(query.toJson(), errors: errors);
    final axes = query.criteria.map((criterion) => criterion.axis).toList();
    if (axes.toSet().length != axes.length) {
      errors.add('Canonical query axes must be unique.');
    }
    const progressiveOrder = <CanonicalPillarAxis>[
      CanonicalPillarAxis.usageContext,
      CanonicalPillarAxis.capabilityRoot,
      CanonicalPillarAxis.trainingConcept,
      CanonicalPillarAxis.trainingIntention,
    ];
    final prefixLength = axes.length < progressiveOrder.length
        ? axes.length
        : progressiveOrder.length;
    for (var index = 0; index < prefixLength; index++) {
      if (axes[index] != progressiveOrder[index]) {
        errors.add(
          'Progressive canonical queries must follow usage context, capability root, training concept, and training intention order.',
        );
        break;
      }
    }
    for (final criterion in query.criteria) {
      final value = registry.valueById[criterion.valueId];
      if (value == null) {
        errors.add('Unknown canonical value ${criterion.valueId}.');
      } else {
        errors.addAll(definitionErrorsForCriterion(value, criterion));
      }
    }
    if (_hasProgressiveAxes(axes)) {
      _addPathAwareQueryErrors(query.criteria, errors);
    }
    return List.unmodifiable(errors);
  }

  bool _hasProgressiveAxes(List<CanonicalPillarAxis> axes) {
    const progressiveOrder = <CanonicalPillarAxis>[
      CanonicalPillarAxis.usageContext,
      CanonicalPillarAxis.capabilityRoot,
      CanonicalPillarAxis.trainingConcept,
      CanonicalPillarAxis.trainingIntention,
    ];
    return axes.length <= progressiveOrder.length &&
        axes.indexed.every((entry) => entry.$2 == progressiveOrder[entry.$1]);
  }

  void _addPathAwareQueryErrors(
    List<CanonicalSearchCriterion> criteria,
    List<String> errors,
  ) {
    if (criteria.length < 3) return;
    final key = CanonicalTrainingPathKey(
      usageContextId: criteria[0].valueId,
      capabilityRootId: criteria[1].valueId,
      trainingConceptId: criteria[2].valueId,
    );
    final path = registry.pathForKey(key);
    if (path == null) {
      errors.add('Unknown canonical training path ${key.contractId}.');
      return;
    }
    if (!registry.hasCompatibleResolvedOptions(key)) {
      errors.add(
        'Canonical training path ${key.contractId} is not compatible with intentions.',
      );
      return;
    }
    if (criteria.length == 4 &&
        !registry
            .resolvedOptionsForPath(key)
            .any(
              (option) => option.definition.pillar.id == criteria[3].valueId,
            )) {
      errors.add(
        'Training intention ${criteria[3].valueId} is not active for ${key.contractId}.',
      );
    }
  }

  void validateQueryOrThrow(CanonicalSearchQuery query) {
    final errors = queryErrors(query);
    if (errors.isNotEmpty) throw StateError(errors.join(' '));
  }

  List<String> definitionErrorsForCriterion(
    CanonicalPillarDefinition value,
    CanonicalSearchCriterion criterion,
  ) {
    final errors = <String>[];
    if (value.status != CanonicalDefinitionStatus.approved) {
      errors.add('Canonical value ${criterion.valueId} is not approved.');
    }
    if (value.axis != criterion.axis) {
      errors.add(
        'Canonical value ${criterion.valueId} does not belong to ${criterion.axis.name}.',
      );
    }
    return List.unmodifiable(errors);
  }

  static void validateRawQueryData(Object? value, {List<String>? errors}) {
    final output = errors ?? <String>[];
    if (value is Map) {
      for (final entry in value.entries) {
        final key = entry.key.toString().toLowerCase();
        if (forbiddenQueryTokens.contains(key)) {
          output.add('Forbidden canonical query property: $key.');
        }
        validateRawQueryData(entry.value, errors: output);
      }
    } else if (value is Iterable) {
      for (final item in value) {
        validateRawQueryData(item, errors: output);
      }
    } else if (value is String) {
      final lower = value.toLowerCase();
      for (final token in forbiddenQueryTokens) {
        if (lower.contains(token)) {
          output.add('Forbidden canonical query token: $token.');
        }
      }
    }
    if (errors == null && output.isNotEmpty) {
      throw StateError(output.join(' '));
    }
  }

  static void _expect(bool condition, String message) {
    if (!condition) throw StateError(message);
  }

  static Map<String, int> _distribution(Iterable<String> values) {
    final distribution = <String, int>{};
    for (final value in values) {
      distribution[value] = (distribution[value] ?? 0) + 1;
    }
    return distribution;
  }

  static bool _hasExactDistribution(
    Map<String, int> actual,
    Map<String, int> expected,
  ) =>
      actual.length == expected.length &&
      actual.entries.every((entry) => expected[entry.key] == entry.value);
}
