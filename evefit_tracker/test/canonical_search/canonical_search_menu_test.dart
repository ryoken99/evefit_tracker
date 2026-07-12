import 'package:evefit_tracker/features/canonical_search/data/canonical_search_menu_data.dart';
import 'package:evefit_tracker/features/canonical_search/models/canonical_search_models.dart';
import 'package:evefit_tracker/features/canonical_search/services/canonical_search_menu_validator.dart';
import 'package:evefit_tracker/features/canonical_search/services/canonical_search_navigation_controller.dart';
import 'package:evefit_tracker/services/clean_base_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final nodes = CanonicalSearchMenuData.nodes;

  test('canonical menu structure is complete and valid', () {
    CanonicalSearchMenuValidator(nodes).validateOrThrow();

    expect(
      nodes.where((node) => node.axis == CanonicalSearchAxis.capabilityRoot),
      hasLength(8),
    );
    expect(
      nodes.where((node) => node.axis == CanonicalSearchAxis.usageContext),
      hasLength(4),
    );
    expect(nodes.where((node) => node.depth == 1), hasLength(12));
    expect(nodes.where((node) => node.depth == 2), hasLength(45));
    expect(nodes.where((node) => node.depth == 3), hasLength(189));
    expect(nodes, hasLength(246));
    expect(nodes.map((node) => node.depth).reduce((a, b) => a > b ? a : b), 3);
  });

  test('root IDs and approved per-root terminal counts stay stable', () {
    final roots = nodes.where((node) => node.depth == 1).toList()
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    expect(roots.map((node) => node.id), [
      'muscular_capacity',
      'cardio_conditioning',
      'speed_power',
      'mobility',
      'flexibility',
      'motor_control_coordination',
      'technique_skill',
      'breathing_regulation',
      'warmup',
      'activation',
      'recovery_cooldown',
      'prevention_adaptation_return',
    ]);
    final expectedTerminalCounts = {
      'muscular_capacity': 17,
      'cardio_conditioning': 19,
      'speed_power': 17,
      'mobility': 10,
      'flexibility': 14,
      'motor_control_coordination': 17,
      'technique_skill': 17,
      'breathing_regulation': 16,
      'warmup': 11,
      'activation': 19,
      'recovery_cooldown': 14,
      'prevention_adaptation_return': 18,
    };
    for (final entry in expectedTerminalCounts.entries) {
      final rootChildren = nodes
          .where((node) => node.parentId == entry.key)
          .map((node) => node.id)
          .toSet();
      final terminalCount = nodes
          .where((node) => rootChildren.contains(node.parentId))
          .length;
      expect(terminalCount, entry.value, reason: entry.key);
    }
  });

  test('query contracts are structured and reject owned result properties', () {
    for (final node in nodes) {
      expect(node.queryContract.conditions, isNotEmpty);
      expect(node.queryContract.namespace, canonicalSearchQueryNamespace);
      expect(
        node.queryContract.conditions.every(
          (condition) =>
              CanonicalSearchQueryField.values.contains(condition.field) &&
              CanonicalSearchQueryOperator.values.contains(condition.operator),
        ),
        isTrue,
      );
    }
    expect(
      () => CanonicalSearchMenuValidator.validateRawQueryData({
        'exercise_ids': ['legacy-row'],
      }),
      throwsA(isA<StateError>()),
    );
    expect(
      () => CanonicalSearchMenuValidator.validateRawQueryData({
        'conditions': [
          {'value': 'manual_membership'},
        ],
      }),
      throwsA(isA<StateError>()),
    );
  });

  test(
    'capabilities gain implicit main training while contexts remain visible four',
    () {
      final controller = CanonicalSearchNavigationController();
      controller.selectNode('cardio_conditioning');
      controller.selectNode('cardio_conditioning_no_machines');
      controller.selectNode('cardio_conditioning_no_machines_walk_run');
      expect(controller.isTerminal, isTrue);
      expect(
        controller.effectiveQueryConditions.any(
          (condition) =>
              condition.field == CanonicalSearchQueryField.usageContext &&
              condition.value == 'main_training',
        ),
        isTrue,
      );

      controller.goToRoot();
      controller.selectNode('warmup');
      expect(
        controller.effectiveQueryConditions.any(
          (condition) =>
              condition.field == CanonicalSearchQueryField.usageContext &&
              condition.value == 'main_training',
        ),
        isFalse,
      );
      expect(
        nodes.where((node) => node.axis == CanonicalSearchAxis.usageContext),
        hasLength(4),
      );
    },
  );

  test(
    'canonical visibility never reactivates legacy catalogue or filters',
    () {
      expect(CleanBaseConfig.canonicalSearchMenuVisible, isTrue);
      expect(CleanBaseConfig.legacyCatalogueVisible, isFalse);
      expect(CleanBaseConfig.legacyFiltersVisible, isFalse);
    },
  );
}
