import '../data/canonical_registry.dart';
import '../models/canonical_core_models.dart';

class CanonicalValidator {
  const CanonicalValidator({this.registry = const CanonicalRegistry()});

  final CanonicalRegistry registry;

  static const forbiddenQueryTokens = <String>{
    'exercise_id',
    'exercise_ids',
    'fixed_results',
    'node_paths',
    'legacy_ids',
    'parent_ids',
    'subcategory_ids',
    'main_training',
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
      CanonicalRegistry.approvedUsageContexts.length == 4,
      'The canonical core requires exactly four usage contexts.',
    );
    _expect(
      CanonicalRegistry.approvedTrainingIntentions.isEmpty,
      'No training intentions are approved.',
    );
    _expect(
      CanonicalRegistry.approvedTrainingConcepts.isEmpty,
      'No training concepts are approved.',
    );
    _expect(
      CanonicalRegistry.approvedAttributeDefinitions.isEmpty,
      'No canonical attributes are approved.',
    );
    _expect(
      registry.approvedPillarValues.length == 12,
      'The canonical core requires exactly twelve approved values.',
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
  }

  List<String> queryErrors(CanonicalSearchQuery query) {
    final errors = <String>[];
    if (query.schemaVersion != canonicalCoreSearchNamespace) {
      errors.add('Unexpected canonical query schema version.');
    }
    if (query.criteria.length != 1) {
      errors.add('The current UI requires exactly one criterion.');
    }
    validateRawQueryData(query.toJson(), errors: errors);
    for (final criterion in query.criteria) {
      if (criterion.axis != CanonicalPillarAxis.capabilityRoot &&
          criterion.axis != CanonicalPillarAxis.usageContext) {
        errors.add('Axis ${criterion.axis.name} has no approved query values.');
        continue;
      }
      final value = registry.valueById[criterion.valueId];
      if (value == null) {
        errors.add('Unknown canonical value ${criterion.valueId}.');
      } else {
        errors.addAll(definitionErrorsForCriterion(value, criterion));
      }
    }
    return List.unmodifiable(errors);
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
}
