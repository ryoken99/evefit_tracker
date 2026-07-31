import 'package:evefit_tracker/features/canonical_core/repositories/generated_canonical_muscular_repository.dart';
import 'package:evefit_tracker/features/canonical_core/screens/workout_exercise_selector_screen.dart';
import 'package:evefit_tracker/features/canonical_core/services/hierarchical_canonical_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'anatomy callout appears only after an explicit muscular capacity selection',
    (tester) async {
      final nonMuscular = _controllerAt('warmup', 'cardio_conditioning');
      await _pump(tester, nonMuscular);

      expect(
        find.byKey(const ValueKey('workout_exercise_selector_explore_anatomy')),
        findsNothing,
      );

      final muscular = _controllerAt('main_training', 'muscular_capacity');
      await _pump(tester, muscular);

      expect(
        find.byKey(const ValueKey('workout_exercise_selector_explore_anatomy')),
        findsOneWidget,
      );
      expect(muscular.currentQuery.criteria, hasLength(2));
      expect(
        muscular.currentQuery.criteria.map((criterion) => criterion.valueId),
        ['main_training', 'muscular_capacity'],
      );
    },
  );

  testWidgets(
    'opening anatomy and returning preserves the canonical selector path',
    (tester) async {
      final controller = _controllerAt('warmup', 'muscular_capacity');
      await _pump(tester, controller);

      await tester.tap(
        find.byKey(const ValueKey('workout_exercise_selector_explore_anatomy')),
      );
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('muscular_anatomy_browser_root')),
        findsOneWidget,
      );
      expect(controller.currentQuery.criteria, hasLength(2));

      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('workout_exercise_selector_root')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('workout_exercise_selector_explore_anatomy')),
        findsOneWidget,
      );
      expect(controller.path.usageContextId, 'warmup');
      expect(controller.path.capabilityRootId, 'muscular_capacity');
      expect(controller.currentQuery.criteria, hasLength(2));
      expect(tester.takeException(), isNull);
    },
  );
}

HierarchicalCanonicalSearchController _controllerAt(
  String usageContextId,
  String capabilityRootId,
) => HierarchicalCanonicalSearchController()
  ..selectUsageContext(usageContextId)
  ..selectCapabilityRoot(capabilityRootId);

Future<void> _pump(
  WidgetTester tester,
  HierarchicalCanonicalSearchController controller,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: WorkoutExerciseSelectorScreen(
        key: ValueKey(
          'selector_${controller.path.usageContextId}_${controller.path.capabilityRootId}',
        ),
        controller: controller,
        muscularRepository: GeneratedCanonicalMuscularRepository(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
