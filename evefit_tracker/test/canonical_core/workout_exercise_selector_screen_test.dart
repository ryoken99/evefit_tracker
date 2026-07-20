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
  Finder concept(String id) =>
      find.byKey(ValueKey('workout_exercise_selector_concept_$id'));

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
        home: WorkoutExerciseSelectorScreen(
          key: UniqueKey(),
          controller: controller,
        ),
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

  testWidgets('starts with exactly seven contexts and no capability shortcut', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(find.text('Adicionar exercício'), findsOneWidget);
    expect(
      find.text('Em que contexto vais utilizar o exercício?'),
      findsOneWidget,
    );
    expect(find.text('Como queres procurar?'), findsNothing);
    expect(CanonicalRegistry.approvedUsageContexts, hasLength(7));
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

  testWidgets('cardio concept order is identical in all seven contexts', (
    tester,
  ) async {
    const expectedIds = [
      'cyclic_locomotion',
      'cyclic_propulsion',
      'repetitive_rhythmic_movement',
      'repeated_multidirectional_displacement',
      'repeated_motor_sequence',
    ];

    for (final contextDefinition in CanonicalRegistry.approvedUsageContexts) {
      await pumpScreen(tester);
      await tester.tap(usageContext(contextDefinition.id));
      await tester.pumpAndSettle();
      await tester.tap(capability('cardio_conditioning'));
      await tester.pumpAndSettle();

      final renderedIds = find
          .byWidgetPredicate(
            (widget) =>
                widget.key is ValueKey<String> &&
                (widget.key! as ValueKey<String>).value.startsWith(
                  'workout_exercise_selector_concept_',
                ),
          )
          .evaluate()
          .map(
            (element) => (element.widget.key! as ValueKey<String>).value
                .replaceFirst('workout_exercise_selector_concept_', ''),
          )
          .toList(growable: false);
      expect(renderedIds, expectedIds);
    }
  });

  testWidgets(
    'context, capability and concept compose query then stop at intentions',
    (tester) async {
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
        find.text('Que tipo de trabalho funcional procuras?'),
        findsOneWidget,
      );
      expect(concept('cyclic_locomotion'), findsOneWidget);

      await tester.tap(concept('cyclic_locomotion'));
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
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingConcept,
          valueId: 'cyclic_locomotion',
        ),
      ]);
      expect(
        find.byKey(const ValueKey('workout_exercise_selector_intention_empty')),
        findsOneWidget,
      );
      expect(
        find.text('Ainda não existem intenções de treino aprovadas.'),
        findsOneWidget,
      );
      expect(
        find.text(
          'As intenções compatíveis com esta seleção serão adicionadas e validadas progressivamente.',
        ),
        findsOneWidget,
      );
      expect(find.text('Aquecimento'), findsWidgets);
      expect(find.text('Cardio e condicionamento'), findsWidgets);
      expect(find.textContaining('Aquecimento\n> Cardio'), findsOneWidget);
      expect(find.textContaining('> Locomoção cíclica'), findsOneWidget);
      expect(find.text('Resultados: 0'), findsNothing);
      expect(find.text('Exercício recomendado'), findsNothing);
      expect(find.text('Sem máquinas'), findsNothing);
    },
  );

  testWidgets('back preserves choices and changing context clears capability', (
    tester,
  ) async {
    final controller = await pumpScreen(tester);
    await tester.tap(usageContext('warmup'));
    await tester.pumpAndSettle();
    await tester.tap(capability('cardio_conditioning'));
    await tester.pumpAndSettle();
    await tester.tap(concept('cyclic_locomotion'));
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      find.text('Que tipo de trabalho funcional procuras?'),
      findsOneWidget,
    );
    expect(controller.path.trainingConceptId, 'cyclic_locomotion');

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
    await tester.tap(concept('overcome_resistance'));
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(
        const ValueKey('workout_exercise_selector_breadcrumb_concept'),
      ),
    );
    await tester.pumpAndSettle();
    expect(concept('overcome_resistance'), findsOneWidget);

    await tester.tap(
      find.byKey(
        const ValueKey('workout_exercise_selector_breadcrumb_capability'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(capability('mobility'));
    await tester.pumpAndSettle();
    expect(controller.path.capabilityRootId, 'mobility');
    expect(controller.path.trainingConceptId, isNull);
    expect(controller.currentQuery.criteria, hasLength(2));

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
      usageContext('return_to_function'),
      contextScroll,
    );
    expect(usageContext('return_to_function'), findsOneWidget);
    await tester.tap(usageContext('return_to_function'));
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
    await tester.tap(capability('breathing_regulation'));
    await tester.pumpAndSettle();
    final conceptScroll = find.descendant(
      of: find.byKey(const ValueKey('workout_exercise_selector_concepts')),
      matching: find.byType(Scrollable),
    );
    await _bringIntoPhoneViewport(
      tester,
      concept('interoceptive_monitoring_adjustment'),
      conceptScroll,
    );
    expect(concept('interoceptive_monitoring_adjustment'), findsOneWidget);
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
