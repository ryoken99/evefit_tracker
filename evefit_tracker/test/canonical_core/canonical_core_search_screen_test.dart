import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/repositories/canonical_exercise_search_repository.dart';
import 'package:evefit_tracker/features/canonical_core/screens/canonical_core_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Finder axis(CanonicalPillarAxis value) =>
      find.byKey(ValueKey('canonical_core_axis_${value.contractId}'));
  Finder value(String id) => find.byKey(ValueKey('canonical_core_value_$id'));

  Future<void> pumpScreen(
    WidgetTester tester, {
    CanonicalExerciseSearchRepository<Object?> repository =
        const EmptyCanonicalExerciseSearchRepository<Object?>(),
  }) => tester.pumpWidget(
    MaterialApp(home: CanonicalCoreSearchScreen(repository: repository)),
  );

  testWidgets('root presents the four approved search axes', (tester) async {
    await pumpScreen(tester);
    expect(find.text('Explorar exercícios'), findsWidgets);
    expect(find.text('Como queres procurar?'), findsOneWidget);
    expect(axis(CanonicalPillarAxis.capabilityRoot), findsOneWidget);
    expect(axis(CanonicalPillarAxis.trainingIntention), findsOneWidget);
    expect(axis(CanonicalPillarAxis.trainingConcept), findsOneWidget);
    expect(axis(CanonicalPillarAxis.usageContext), findsOneWidget);
    expect(find.text('Sem máquinas'), findsNothing);
    expect(find.text('Calejamento progressivo'), findsNothing);
    expect(find.text('Mostrar todos'), findsNothing);
    expect(find.bySemanticsLabel('Por capacidade'), findsOneWidget);
  });

  testWidgets('capability axis shows exactly the eight approved roots', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(axis(CanonicalPillarAxis.capabilityRoot));
    await tester.pumpAndSettle();
    for (final id in const [
      'muscular_capacity',
      'cardio_conditioning',
      'speed_power',
      'mobility',
      'flexibility',
      'motor_control_coordination',
      'technique_skill',
      'breathing_regulation',
    ]) {
      await tester.scrollUntilVisible(value(id), 220);
      expect(value(id), findsOneWidget);
    }
    expect(find.text('Sem máquinas'), findsNothing);
  });

  testWidgets('context axis shows exactly the five approved contexts', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(axis(CanonicalPillarAxis.usageContext));
    await tester.pumpAndSettle();
    final valuesScroll = find.descendant(
      of: find.byKey(
        const ValueKey('canonical_core_axis_values_usage_context'),
      ),
      matching: find.byType(Scrollable),
    );
    for (final id in const [
      'main_training',
      'warmup',
      'activation',
      'recovery_cooldown',
      'prevention_adaptation_return',
    ]) {
      await tester.scrollUntilVisible(value(id), 220, scrollable: valuesScroll);
      expect(value(id), findsOneWidget);
    }
    await tester.scrollUntilVisible(
      value('main_training'),
      -220,
      scrollable: valuesScroll,
    );
    expect(find.text('Treino principal'), findsOneWidget);
  });

  testWidgets('capability selection executes one criterion and goes empty', (
    tester,
  ) async {
    final repository = _RecordingRepository();
    await pumpScreen(tester, repository: repository);
    await tester.tap(axis(CanonicalPillarAxis.capabilityRoot));
    await tester.pumpAndSettle();
    await tester.tap(value('cardio_conditioning'));
    await tester.pumpAndSettle();

    expect(repository.queries, hasLength(1));
    expect(repository.queries.single.criteria, hasLength(1));
    expect(
      repository.queries.single.criteria.single,
      const CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.capabilityRoot,
        valueId: 'cardio_conditioning',
      ),
    );
    expect(
      find.byKey(const ValueKey('canonical_core_empty_state')),
      findsOneWidget,
    );
    expect(find.text('Raiz de capacidade'), findsOneWidget);
    expect(find.text('Resultados: 0'), findsOneWidget);
    expect(find.text('Sem máquinas'), findsNothing);
  });

  testWidgets('context selection uses the same repository flow', (
    tester,
  ) async {
    final repository = _RecordingRepository();
    await pumpScreen(tester, repository: repository);
    await tester.tap(axis(CanonicalPillarAxis.usageContext));
    await tester.pumpAndSettle();
    await tester.tap(value('warmup'));
    await tester.pumpAndSettle();
    expect(
      repository.queries.single.criteria.single,
      const CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.usageContext,
        valueId: 'warmup',
      ),
    );
    expect(find.text('Contexto de utilização'), findsOneWidget);
    expect(find.text('Aquecimento'), findsWidgets);
  });

  testWidgets('intention remains pending and concept axis shows approvals', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(axis(CanonicalPillarAxis.trainingIntention));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_core_intentions_pending')),
      findsOneWidget,
    );
    expect(
      find.text('O vocabulário canónico de intenções ainda está em definição.'),
      findsOneWidget,
    );
    expect(find.text('Hipertrofia'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('canonical_core_home')));
    await tester.pumpAndSettle();
    await tester.tap(axis(CanonicalPillarAxis.trainingConcept));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_core_concepts_pending')),
      findsNothing,
    );
    expect(CanonicalRegistry.approvedTrainingConcepts, hasLength(35));
    expect(value('overcome_resistance'), findsOneWidget);
    expect(find.text('Vencer resistência'), findsOneWidget);
    expect(
      find.text(
        'Produzir força suficiente para deslocar o corpo, uma carga ou um implemento contra uma resistência.',
      ),
      findsOneWidget,
    );
    final conceptsScroll = find.descendant(
      of: find.byKey(
        const ValueKey('canonical_core_axis_values_training_concept'),
      ),
      matching: find.byType(Scrollable),
    );
    await tester.scrollUntilVisible(
      value('interoceptive_monitoring_adjustment'),
      260,
      scrollable: conceptsScroll,
    );
    expect(value('interoceptive_monitoring_adjustment'), findsOneWidget);
    expect(find.text('Empurrar'), findsNothing);
  });

  testWidgets('breadcrumbs, back, home, and system back keep state coherent', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(axis(CanonicalPillarAxis.capabilityRoot));
    await tester.pumpAndSettle();
    expect(find.text('Por capacidade'), findsWidgets);
    await tester.tap(value('muscular_capacity'));
    await tester.pumpAndSettle();
    expect(find.text('Força e capacidade muscular'), findsWidgets);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(value('muscular_capacity'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('canonical_core_home')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_core_root_screen')),
      findsOneWidget,
    );
  });

  testWidgets('narrow PT-PT layout has no overflow or Flutter exception', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpScreen(tester);
    await tester.tap(axis(CanonicalPillarAxis.capabilityRoot));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(value('breathing_regulation'), 220);
    expect(tester.takeException(), isNull);
  });

  testWidgets('invalid repository result is not replaced by fake content', (
    tester,
  ) async {
    await pumpScreen(tester, repository: _RecordingRepository(invalid: true));
    await tester.tap(axis(CanonicalPillarAxis.usageContext));
    await tester.pumpAndSettle();
    await tester.tap(value('activation'));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_core_search_error')),
      findsOneWidget,
    );
    expect(find.text('Mostrar todos'), findsNothing);
  });
}

class _RecordingRepository
    implements CanonicalExerciseSearchRepository<Object?> {
  _RecordingRepository({this.invalid = false});

  final bool invalid;
  final queries = <CanonicalSearchQuery>[];

  @override
  Future<CanonicalSearchResult<Object?>> search(
    CanonicalSearchQuery query,
  ) async {
    queries.add(query);
    return CanonicalSearchResult<Object?>(
      query: query,
      total: 0,
      items: const [],
      status: invalid
          ? CanonicalSearchResultStatus.invalidQuery
          : CanonicalSearchResultStatus.success,
    );
  }
}
