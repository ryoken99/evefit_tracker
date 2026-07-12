import '../models/canonical_search_models.dart';

class CanonicalSearchMenuValidator {
  const CanonicalSearchMenuValidator(this.nodes);

  final List<CanonicalSearchFilterNode> nodes;

  static const forbiddenQueryTokens = <String>{
    'exercise_id',
    'exercise_ids',
    'owned_exercises',
    'hardcoded_results',
    'catalogue_rows',
    'legacy_ids',
    'manual_membership',
    'result_list',
  };

  void validateOrThrow() {
    _expect(nodes.length == 246, 'Expected 246 nodes, found ${nodes.length}.');
    final byId = {for (final node in nodes) node.id: node};
    _expect(byId.length == nodes.length, 'Node IDs must be globally unique.');

    final roots = nodes.where((node) => node.depth == 1).toList();
    final capabilities = roots
        .where((node) => node.axis == CanonicalSearchAxis.capabilityRoot)
        .toList();
    final contexts = roots
        .where((node) => node.axis == CanonicalSearchAxis.usageContext)
        .toList();
    _expect(capabilities.length == 8, 'Expected eight capability roots.');
    _expect(contexts.length == 4, 'Expected four usage contexts.');
    _expect(roots.length == 12, 'Expected twelve visible roots.');
    _expect(
      capabilities.map((node) => node.id).toList().join(',') ==
          'muscular_capacity,cardio_conditioning,speed_power,mobility,flexibility,motor_control_coordination,technique_skill,breathing_regulation',
      'Capability root IDs or order are incorrect.',
    );
    _expect(
      contexts.map((node) => node.id).toList().join(',') ==
          'warmup,activation,recovery_cooldown,prevention_adaptation_return',
      'Usage context root IDs or order are incorrect.',
    );

    final levelTwo = nodes.where((node) => node.depth == 2).toList();
    final terminals = nodes.where((node) => node.depth == 3).toList();
    _expect(levelTwo.length == 45, 'Expected 45 level-two nodes.');
    _expect(terminals.length == 189, 'Expected 189 terminal nodes.');
    _expect(
      levelTwo
              .where(
                (node) =>
                    _rootFor(node, byId).axis ==
                    CanonicalSearchAxis.capabilityRoot,
              )
              .length ==
          30,
      'Expected 30 capability level-two nodes.',
    );
    _expect(
      levelTwo
              .where(
                (node) =>
                    _rootFor(node, byId).axis ==
                    CanonicalSearchAxis.usageContext,
              )
              .length ==
          15,
      'Expected 15 context level-two nodes.',
    );
    _expect(
      terminals
              .where(
                (node) =>
                    _rootFor(node, byId).axis ==
                    CanonicalSearchAxis.capabilityRoot,
              )
              .length ==
          127,
      'Expected 127 capability terminals.',
    );
    _expect(
      terminals
              .where(
                (node) =>
                    _rootFor(node, byId).axis ==
                    CanonicalSearchAxis.usageContext,
              )
              .length ==
          62,
      'Expected 62 context terminals.',
    );

    for (final node in nodes) {
      _expect(
        node.id == node.id.toLowerCase(),
        'ID ${node.id} must be lowercase.',
      );
      _expect(
        RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(node.id),
        'ID ${node.id} must be stable snake_case.',
      );
      _expect(
        !RegExp(r'^(node|item|menu|proposal)_?\d+$').hasMatch(node.id),
        'ID ${node.id} must not depend on an index.',
      );
      _expect(
        node.schemaVersion == canonicalSearchMenuSchemaVersion,
        'Node ${node.id} has an unexpected schema version.',
      );
      _expect(
        node.displayNamePtPt.trim().isNotEmpty,
        'Node ${node.id} has no PT-PT name.',
      );
      _expect(
        node.descriptionPtPt.trim().isNotEmpty,
        'Node ${node.id} has no PT-PT description.',
      );
      _expect(
        node.descriptionPtPt.trim() != node.displayNamePtPt.trim(),
        'Node ${node.id} repeats its name as its description.',
      );
      _expect(
        CanonicalSearchIconKey.values.contains(node.iconKey),
        'Node ${node.id} has an invalid icon key.',
      );
      _expect(
        node.queryContract.conditions.isNotEmpty,
        'Node ${node.id} has no query conditions.',
      );
      _expect(
        node.queryContract.namespace == canonicalSearchQueryNamespace,
        'Node ${node.id} has an unexpected query namespace.',
      );
      validateRawQueryData(node.queryContract.toJson());

      if (node.depth == 1) {
        _expect(node.parentId == null, 'Root ${node.id} must have no parent.');
        _expect(!node.isTerminal, 'Root ${node.id} must not be terminal.');
      } else {
        final parent = byId[node.parentId];
        _expect(
          parent != null,
          'Node ${node.id} references a missing parent ${node.parentId}.',
        );
        _expect(
          parent!.depth == node.depth - 1,
          'Node ${node.id} has incoherent depth.',
        );
        _expect(
          !node.isTerminal || node.depth == 3,
          'Only level three nodes may be terminal.',
        );
        if (node.depth == 2) {
          _expect(
            !node.isTerminal,
            'Level two node ${node.id} must not be terminal.',
          );
        }
      }
    }

    _expect(
      nodes.every((node) => node.depth <= 3),
      'The current tree may not exceed depth three.',
    );
    _expect(
      nodes.any((node) => node.depth == 3),
      'The tree requires terminal nodes.',
    );
    _expect(_hasNoCycles(byId), 'The tree contains a parent cycle.');
    _expect(
      nodes.map((node) => node.descriptionPtPt).toSet().length == nodes.length,
      'Node descriptions must be specific and unique.',
    );

    for (final parentId in <String?>{
      null,
      ...nodes.map((node) => node.parentId),
    }) {
      final orders = nodes
          .where((node) => node.parentId == parentId)
          .map((node) => node.displayOrder)
          .toList();
      _expect(
        orders.length == orders.toSet().length,
        'Sibling display orders must be unique for $parentId.',
      );
    }
  }

  static void validateRawQueryData(Object? value) {
    if (value is Map) {
      for (final entry in value.entries) {
        final key = entry.key.toString().toLowerCase();
        _expect(
          !forbiddenQueryTokens.contains(key),
          'Forbidden query property: $key.',
        );
        validateRawQueryData(entry.value);
      }
      return;
    }
    if (value is Iterable) {
      for (final item in value) {
        validateRawQueryData(item);
      }
      return;
    }
    if (value is String) {
      final lower = value.toLowerCase();
      for (final token in forbiddenQueryTokens) {
        _expect(!lower.contains(token), 'Forbidden query token: $token.');
      }
    }
  }

  CanonicalSearchFilterNode _rootFor(
    CanonicalSearchFilterNode node,
    Map<String, CanonicalSearchFilterNode> byId,
  ) {
    var current = node;
    while (current.parentId != null) {
      current = byId[current.parentId]!;
    }
    return current;
  }

  bool _hasNoCycles(Map<String, CanonicalSearchFilterNode> byId) {
    for (final node in byId.values) {
      final seen = <String>{};
      CanonicalSearchFilterNode? current = node;
      while (current != null) {
        if (!seen.add(current.id)) return false;
        current = current.parentId == null ? null : byId[current.parentId];
      }
    }
    return true;
  }

  static void _expect(bool condition, String message) {
    if (!condition) throw StateError(message);
  }
}
