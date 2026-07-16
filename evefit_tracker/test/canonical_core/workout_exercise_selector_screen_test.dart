import 'dart:io';

import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/screens/workout_exercise_selector_screen.dart';
import 'package:evefit_tracker/features/canonical_core/services/hierarchical_canonical_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Finder capability(String id) =>
      find.byKey(ValueKey('workout_exercise_selector_capability_$id'));
  Finder usageContext(String id) =>
      find.byKey(ValueKey('workout_exercise_selector_context_$id'));

  Future<HierarchicalCanonicalSearchController> pumpScreen(
    WidgetTester tester, {
    Size size = const Size(800, 1600),
    double textScale = 1,
  }) async {
    final controller = HierarchicalCanonicalSearchController();
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
        home: WorkoutExerciseSelectorScreen(controller: controller),
      ),
    );
    await tester.pumpAndSettle();
    return controller;
  }

  test('selector is isolated and the workout uses only this active flow', () {
    final source = File(
      'lib/features/canonical_core/screens/'
      'workout_exercise_selector_screen.dart',
    ).readAsStringSync();
    final workoutDetail = File(
      'lib/screens/workout_detail_screen.dart',
    ).readAsStringSync();

    expect(source, contains('HierarchicalCanonicalSearchController'));
    expect(source, isNot(contains('CanonicalExerciseSearchRepository')));
    expect(source, isNot(contains('ExerciseFilterService')));
    expect(source, isNot(contains('TrainingFlow')));
    expect(source, isNot(contains('main_training')));
    expect(source, isNot(contains('exercise_ids')));
    expect(source, isNot(contains("'cardio_conditioning'")));
    expect(source, isNot(contains("'warmup'")));
    expect(workoutDetail, contains('WorkoutExerciseSelectorScreen'));
    expect(workoutDetail, isNot(contains('CanonicalCoreSearchScreen')));
  });

  testWidgets('starts with exactly five contexts and no capability shortcut', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(find.text('Adicionar exercício'), findsOneWidget);
    expect(
      find.text('Em que contexto vais utilizar o exercício?'),
      findsOneWidget,
    );
    expect(find.text('Como queres procurar?'), findsNothing);
    expect(CanonicalRegistry.approvedUsageContexts, hasLength(5));
    for (final definition in CanonicalRegistry.approvedUsageContexts) {
      expect(usageContext(definition.id), findsOneWidget);
      expect(find.text(definition.displayNamePtPt), findsOneWidget);
      expect(find.text(definition.descriptionPtPt), findsOneWidget);
    }
    expect(CanonicalRegistry.approvedUsageContexts.first.id, 'main_training');
    for (final definition in CanonicalRegistry.approvedCapabilityRoots) {
      expect(capability(definition.id), findsNothing);
    }
    expect(find.text('Por intenção'), findsNothing);
    expect(find.text('Por conceito de treino'), findsNothing);
    expect(find.text('Mostrar todos'), findsNothing);
  });

  testWidgets('main training is explicit and then exposes eight capabilities', (
    tester,
  ) async {
    final controller = await pumpScreen(tester);

    expect(controller.currentQuery.criteria, isEmpty);
    await tester.tap(usageContext('main_training'));
    await tester.pumpAndSettle();

    expect(controller.currentQuery.criteria, hasLength(1));
    expect(
      controller.currentQuery.criteria.single,
      const CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.usageContext,
        valueId: 'main_training',
      ),
    );
    expect(find.text('Que capacidade queres trabalhar?'), findsOneWidget);
    expect(CanonicalRegistry.approvedCapabilityRoots, hasLength(8));
    for (final definition in CanonicalRegistry.approvedCapabilityRoots) {
      expect(capability(definition.id), findsOneWidget);
    }
  });

  testWidgets('context and capability compose query then stop at concepts', (
    tester,
  ) async {
    final controller = await pumpScreen(tester);

    await tester.tap(usageContext('warmup'));
    await tester.pumpAndSettle();
    expect(controller.currentQuery.criteria, const [
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.usageContext,
        valueId: 'warmup',
      ),
    ]);

    await tester.tap(capability('cardio_conditioning'));
    await tester.pumpAndSettle();

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
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_concept_empty')),
      findsOneWidget,
    );
    expect(
      find.text('Ainda não existem conceitos de treino aprovados.'),
      findsOneWidget,
    );
    expect(
      find.text(
        'Os conceitos compatíveis com esta seleção serão adicionados e validados progressivamente.',
      ),
      findsOneWidget,
    );
    expect(find.text('Aquecimento'), findsWidgets);
    expect(find.text('Cardio e condicionamento'), findsWidgets);
    expect(find.textContaining('Aquecimento\n> Cardio'), findsOneWidget);
    expect(find.text('Intenção'), findsNothing);
    expect(find.text('Resultados: 0'), findsNothing);
    expect(find.text('Exercício recomendado'), findsNothing);
    expect(find.text('Sem máquinas'), findsNothing);
  });

  testWidgets('back preserves choices and changing context clears capability', (
    tester,
  ) async {
    final controller = await pumpScreen(tester);
    await tester.tap(usageContext('warmup'));
    await tester.pumpAndSettle();
    await tester.tap(capability('cardio_conditioning'));
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Que capacidade queres trabalhar?'), findsOneWidget);
    expect(controller.path.usageContextId, 'warmup');
    expect(controller.path.capabilityRootId, 'cardio_conditioning');
    final selectedSemantics = tester.widget<Semantics>(
      find
          .descendant(
            of: capability('cardio_conditioning'),
            matching: find.byType(Semantics),
          )
          .first,
    );
    expect(selectedSemantics.properties.selected, isTrue);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      find.text('Em que contexto vais utilizar o exercício?'),
      findsOneWidget,
    );
    expect(controller.path.usageContextId, 'warmup');

    await tester.tap(usageContext('activation'));
    await tester.pumpAndSettle();
    expect(controller.path.usageContextId, 'activation');
    expect(controller.path.capabilityRootId, isNull);
    expect(controller.currentQuery.criteria, hasLength(1));
  });

  testWidgets('breadcrumb changes ancestors and home clears all choices', (
    tester,
  ) async {
    final controller = await pumpScreen(tester);
    await tester.tap(usageContext('activation'));
    await tester.pumpAndSettle();
    await tester.tap(capability('muscular_capacity'));
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(
        const ValueKey('workout_exercise_selector_breadcrumb_context'),
      ),
    );
    await tester.pumpAndSettle();
    expect(usageContext('activation'), findsOneWidget);

    await tester.tap(usageContext('main_training'));
    await tester.pumpAndSettle();
    expect(controller.path.capabilityRootId, isNull);

    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_home')),
    );
    await tester.pumpAndSettle();
    expect(controller.currentQuery.criteria, isEmpty);
    expect(usageContext('main_training'), findsOneWidget);
  });

  testWidgets('narrow large-text layout remains scrollable without overflow', (
    tester,
  ) async {
    await pumpScreen(tester, size: const Size(320, 568), textScale: 1.6);

    final contextScroll = find.descendant(
      of: find.byKey(const ValueKey('workout_exercise_selector_contexts')),
      matching: find.byType(Scrollable),
    );
    await _bringIntoPhoneViewport(
      tester,
      usageContext('prevention_adaptation_return'),
      contextScroll,
    );
    expect(usageContext('prevention_adaptation_return'), findsOneWidget);
    await tester.tap(usageContext('prevention_adaptation_return'));
    await tester.pumpAndSettle();
    final capabilityScroll = find.descendant(
      of: find.byKey(const ValueKey('workout_exercise_selector_capabilities')),
      matching: find.byType(Scrollable),
    );
    await _bringIntoPhoneViewport(
      tester,
      capability('breathing_regulation'),
      capabilityScroll,
    );
    expect(capability('breathing_regulation'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _bringIntoPhoneViewport(
  WidgetTester tester,
  Finder target,
  Finder scrollable,
) async {
  for (var attempt = 0; attempt < 20; attempt++) {
    if (target.evaluate().isNotEmpty) {
      final center = tester.getCenter(target);
      if (center.dy >= 140 && center.dy <= 520) return;
    }
    await tester.drag(scrollable, const Offset(0, -260));
    await tester.pumpAndSettle();
  }
  expect(target, findsOneWidget);
}
