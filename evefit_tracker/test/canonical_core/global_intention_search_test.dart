import 'dart:async';

import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/models/training_intention_models.dart';
import 'package:evefit_tracker/features/canonical_core/repositories/canonical_exercise_search_repository.dart';
import 'package:evefit_tracker/features/canonical_core/screens/canonical_core_search_screen.dart';
import 'package:evefit_tracker/features/canonical_core/services/canonical_core_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const registry = CanonicalRegistry();

  Finder axis() =>
      find.byKey(const ValueKey('canonical_core_axis_training_intention'));
  Finder intention(String id) =>
      find.byKey(ValueKey('canonical_core_intention_$id'));
  Finder path(CanonicalTrainingPathDefinition value) =>
      find.byKey(ValueKey('canonical_core_path_${value.key.contractId}'));
  Finder globalIntentionsScroll() => find.descendant(
    of: find.byKey(const ValueKey('canonical_core_global_intentions')),
    matching: find.byType(Scrollable),
  );

  Future<void> pumpScreen(
    WidgetTester tester, {
    CanonicalExerciseSearchRepository<Object?> repository =
        const EmptyCanonicalExerciseSearchRepository<Object?>(),
    TextScaler textScaler = TextScaler.noScaling,
  }) => tester.pumpWidget(
    MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(textScaler: textScaler),
        child: CanonicalCoreSearchScreen(repository: repository),
      ),
    ),
  );

  CanonicalPillarDefinition compatibleIntention() =>
      CanonicalRegistry.approvedTrainingIntentions.firstWhere(
        (value) => registry
            .pathsForIntention(value.id)
            .any(
              (path) => path.status == CanonicalTrainingPathStatus.compatible,
            ),
      );

  CanonicalTrainingPathDefinition firstCompatiblePath(
    CanonicalPillarDefinition value,
  ) => registry
      .pathsForIntention(value.id)
      .firstWhere(
        (path) => path.status == CanonicalTrainingPathStatus.compatible,
      );

  String pathDisplayName(CanonicalTrainingPathDefinition value) => [
    registry.valueById[value.key.usageContextId]!.displayNamePtPt,
    registry.valueById[value.key.capabilityRootId]!.displayNamePtPt,
    registry.valueById[value.key.trainingConceptId]!.displayNamePtPt,
  ].join(' > ');

  int comparePathOrder(
    CanonicalTrainingPathDefinition left,
    CanonicalTrainingPathDefinition right,
  ) {
    final leftIds = [
      left.key.usageContextId,
      left.key.capabilityRootId,
      left.key.trainingConceptId,
    ];
    final rightIds = [
      right.key.usageContextId,
      right.key.capabilityRootId,
      right.key.trainingConceptId,
    ];
    for (var index = 0; index < leftIds.length; index++) {
      final comparison = registry.valueById[leftIds[index]]!.displayOrder
          .compareTo(registry.valueById[rightIds[index]]!.displayOrder);
      if (comparison != 0) return comparison;
    }
    return left.sourceNumber.compareTo(right.sourceNumber);
  }

  test(
    'pathsForIntention has deterministic context-capability-concept order',
    () {
      final controller = CanonicalCoreNavigationController();
      for (final selectedIntention
          in CanonicalRegistry.approvedTrainingIntentions) {
        final actual = controller.compatiblePathsForGlobalIntention(
          selectedIntention.id,
        );
        final expected = registry
            .pathsForIntention(selectedIntention.id)
            .where(
              (path) => path.status == CanonicalTrainingPathStatus.compatible,
            )
            .toList(growable: false);
        expected.sort(comparePathOrder);
        expect(
          actual.map((path) => path.key.contractId),
          expected.map((path) => path.key.contractId),
          reason: selectedIntention.id,
        );
      }
    },
  );

  testWidgets('global intentions use the ordered registry and a lazy builder', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(axis());
    await tester.pumpAndSettle();

    final list = tester.widget<ListView>(
      find.byKey(const ValueKey('canonical_core_global_intentions')),
    );
    expect(CanonicalRegistry.approvedTrainingIntentions, hasLength(591));
    expect(list.childrenDelegate, isA<SliverChildBuilderDelegate>());
    expect(list.semanticChildCount, 593);

    final first = CanonicalRegistry.approvedTrainingIntentions.first;
    final last = CanonicalRegistry.approvedTrainingIntentions.last;
    expect(intention(first.id), findsOneWidget);
    expect(find.text(first.displayNamePtPt), findsOneWidget);
    expect(intention(last.id), findsNothing);

    await tester.scrollUntilVisible(
      intention(last.id),
      2000,
      scrollable: globalIntentionsScroll(),
      maxScrolls: 100,
    );
    expect(intention(last.id), findsOneWidget);
    expect(find.text(last.displayNamePtPt), findsOneWidget);
  });

  testWidgets('an intention opens only compatible paths without a query', (
    tester,
  ) async {
    final repository = _RecordingRepository();
    final selectedIntention = compatibleIntention();
    final paths = registry
        .pathsForIntention(selectedIntention.id)
        .where((path) => path.status == CanonicalTrainingPathStatus.compatible)
        .toList(growable: false);

    await pumpScreen(tester, repository: repository);
    await tester.tap(axis());
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      intention(selectedIntention.id),
      320,
      scrollable: globalIntentionsScroll(),
    );
    await tester.tap(intention(selectedIntention.id));
    await tester.pumpAndSettle();

    expect(repository.queries, isEmpty);
    expect(
      find.byKey(const ValueKey('canonical_core_global_intention_paths')),
      findsOneWidget,
    );
    expect(paths, isNotEmpty);
    for (final compatiblePath in paths) {
      await tester.scrollUntilVisible(path(compatiblePath), 320);
      expect(path(compatiblePath), findsOneWidget);
      expect(find.text(pathDisplayName(compatiblePath)), findsOneWidget);
    }
    for (final possiblePath in CanonicalRegistry.trainingPaths) {
      if (possiblePath.status == CanonicalTrainingPathStatus.incompatible) {
        expect(path(possiblePath), findsNothing);
      }
    }
  });

  testWidgets('a compatible path executes the exact four-criterion query', (
    tester,
  ) async {
    final repository = _RecordingRepository();
    final selectedIntention = compatibleIntention();
    final selectedPath = firstCompatiblePath(selectedIntention);

    await pumpScreen(tester, repository: repository);
    await tester.tap(axis());
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      intention(selectedIntention.id),
      320,
      scrollable: globalIntentionsScroll(),
    );
    await tester.tap(intention(selectedIntention.id));
    await tester.pumpAndSettle();
    await tester.tap(path(selectedPath));
    await tester.pumpAndSettle();

    expect(repository.queries, hasLength(1));
    expect(repository.queries.single.criteria, [
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.usageContext,
        valueId: selectedPath.key.usageContextId,
      ),
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.capabilityRoot,
        valueId: selectedPath.key.capabilityRootId,
      ),
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.trainingConcept,
        valueId: selectedPath.key.trainingConceptId,
      ),
      CanonicalSearchCriterion(
        axis: CanonicalPillarAxis.trainingIntention,
        valueId: selectedIntention.id,
      ),
    ]);
    expect(
      find.byKey(const ValueKey('canonical_core_global_intention_empty_state')),
      findsOneWidget,
    );
    expect(
      find.text('Ainda não existem exercícios aprovados para este percurso.'),
      findsOneWidget,
    );
    expect(
      find.text(
        'Os exercícios compatíveis serão adicionados e validados progressivamente.',
      ),
      findsOneWidget,
    );
    expect(find.text(selectedIntention.displayNamePtPt), findsWidgets);
    expect(find.text(pathDisplayName(selectedPath)), findsWidgets);
    expect(
      find.byKey(
        ValueKey(
          'canonical_core_breadcrumb_path_${selectedPath.key.contractId}',
        ),
      ),
      findsOneWidget,
    );
  });

  testWidgets('back, home, and system back preserve global intention state', (
    tester,
  ) async {
    final repository = _RecordingRepository();
    final selectedIntention = compatibleIntention();
    final selectedPath = firstCompatiblePath(selectedIntention);

    await pumpScreen(tester, repository: repository);
    await tester.tap(axis());
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      intention(selectedIntention.id),
      320,
      scrollable: globalIntentionsScroll(),
    );
    await tester.tap(intention(selectedIntention.id));
    await tester.pumpAndSettle();
    await tester.tap(path(selectedPath));
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_core_global_intention_paths')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('canonical_core_global_intention_empty_state')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('canonical_core_search_loading')),
      findsNothing,
    );
    expect(repository.queries, hasLength(1));

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_core_global_intentions')),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('canonical_core_home')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_core_root_screen')),
      findsOneWidget,
    );
  });

  testWidgets('home clears a pending global intention search', (tester) async {
    final repository = _PendingRepository();
    final selectedIntention = compatibleIntention();
    final selectedPath = firstCompatiblePath(selectedIntention);

    await pumpScreen(tester, repository: repository);
    await tester.tap(axis());
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      intention(selectedIntention.id),
      320,
      scrollable: globalIntentionsScroll(),
    );
    await tester.tap(intention(selectedIntention.id));
    await tester.pumpAndSettle();
    await tester.tap(path(selectedPath));
    await tester.pump();

    expect(repository.queries, hasLength(1));
    expect(
      find.byKey(const ValueKey('canonical_core_search_loading')),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('canonical_core_home')));
    await tester.pumpAndSettle();
    repository.complete();
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('canonical_core_root_screen')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('canonical_core_search_loading')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('canonical_core_global_intention_empty_state')),
      findsNothing,
    );
  });

  testWidgets('global intention flow has no narrow large-text overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final selectedIntention = compatibleIntention();

    await pumpScreen(tester, textScaler: const TextScaler.linear(1.5));
    await tester.drag(find.byType(Scrollable), const Offset(0, -1000));
    await tester.pumpAndSettle();
    await tester.ensureVisible(axis());
    await tester.pumpAndSettle();
    await tester.tap(axis());
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      intention(selectedIntention.id),
      260,
      scrollable: globalIntentionsScroll(),
    );
    expect(tester.takeException(), isNull);
  });
}

class _RecordingRepository
    implements CanonicalExerciseSearchRepository<Object?> {
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
      status: CanonicalSearchResultStatus.success,
    );
  }
}

class _PendingRepository implements CanonicalExerciseSearchRepository<Object?> {
  final queries = <CanonicalSearchQuery>[];
  final _result = Completer<CanonicalSearchResult<Object?>>();

  @override
  Future<CanonicalSearchResult<Object?>> search(CanonicalSearchQuery query) {
    queries.add(query);
    return _result.future;
  }

  void complete() {
    _result.complete(
      CanonicalSearchResult<Object?>(
        query: queries.single,
        total: 0,
        items: const [],
        status: CanonicalSearchResultStatus.success,
      ),
    );
  }
}
