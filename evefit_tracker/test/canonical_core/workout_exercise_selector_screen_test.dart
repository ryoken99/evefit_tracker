import 'dart:io';

import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/repositories/canonical_exercise_search_repository.dart';
import 'package:evefit_tracker/features/canonical_core/screens/workout_exercise_selector_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Finder capability(String id) =>
      find.byKey(ValueKey('workout_exercise_selector_capability_$id'));
  Finder usageContext(String id) =>
      find.byKey(ValueKey('workout_exercise_selector_context_$id'));

  Future<void> pumpScreen(
    WidgetTester tester, {
    CanonicalExerciseSearchRepository<Object?> repository =
        const EmptyCanonicalExerciseSearchRepository<Object?>(),
    Size size = const Size(800, 1600),
    double textScale = 1,
  }) async {
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
        home: WorkoutExerciseSelectorScreen(repository: repository),
      ),
    );
    await tester.pumpAndSettle();
  }

  test('selector source uses the registry and has no legacy value list', () {
    final source = File(
      'lib/features/canonical_core/screens/'
      'workout_exercise_selector_screen.dart',
    ).readAsStringSync();
    final workoutDetail = File(
      'lib/screens/workout_detail_screen.dart',
    ).readAsStringSync();

    expect(source, contains('CanonicalRegistry.approvedCapabilityRoots'));
    expect(source, contains('CanonicalRegistry.approvedUsageContexts'));
    expect(source, isNot(contains('ExerciseFilterService')));
    expect(source, isNot(contains('TrainingFlow')));
    expect(source, isNot(contains('main_training')));
    expect(source, isNot(contains('exercise_ids')));
    expect(source, isNot(contains("'cardio_conditioning'")));
    expect(source, isNot(contains("'warmup'")));
    expect(workoutDetail, contains('WorkoutExerciseSelectorScreen'));
    expect(workoutDetail, isNot(contains('CanonicalCoreSearchScreen')));
  });

  testWidgets('shows exactly the eight capability roots first', (tester) async {
    await pumpScreen(tester);

    expect(find.text('Adicionar exercício'), findsOneWidget);
    expect(find.text('Que capacidade queres trabalhar?'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_root')),
      findsOneWidget,
    );
    for (final definition in CanonicalRegistry.approvedCapabilityRoots) {
      expect(capability(definition.id), findsOneWidget);
      expect(find.text(definition.displayNamePtPt), findsOneWidget);
      expect(find.text(definition.descriptionPtPt), findsOneWidget);
      expect(find.bySemanticsLabel(definition.displayNamePtPt), findsOneWidget);
    }
    expect(CanonicalRegistry.approvedCapabilityRoots, hasLength(8));
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_context_entry')),
      findsOneWidget,
    );
    for (final definition in CanonicalRegistry.approvedUsageContexts) {
      expect(usageContext(definition.id), findsNothing);
    }
    expect(find.text('Por intenção'), findsNothing);
    expect(find.text('Por conceito de treino'), findsNothing);
    expect(find.text('Sem máquinas'), findsNothing);
    expect(find.text('Caminhada e corrida'), findsNothing);
    expect(find.text('Mostrar todos'), findsNothing);
  });

  testWidgets(
    'capability creates one criterion and opens the real empty state',
    (tester) async {
      final repository = _RecordingRepository();
      await pumpScreen(tester, repository: repository);

      await tester.tap(capability('cardio_conditioning'));
      await tester.pumpAndSettle();

      expect(repository.queries, hasLength(1));
      final query = repository.queries.single;
      expect(query.criteria, hasLength(1));
      expect(
        query.criteria.single,
        const CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.capabilityRoot,
          valueId: 'cardio_conditioning',
        ),
      );
      expect(query.toJson().toString(), isNot(contains('main_training')));
      expect(query.toJson().toString(), isNot(contains('exercise_ids')));
      expect(
        find.byKey(const ValueKey('workout_exercise_selector_result_empty')),
        findsOneWidget,
      );
      expect(
        find.byKey(
          const ValueKey('workout_exercise_selector_active_criterion'),
        ),
        findsOneWidget,
      );
      expect(find.text('Raiz de capacidade'), findsOneWidget);
      expect(find.text('Cardio e condicionamento'), findsWidgets);
      expect(find.text('Resultados: 0'), findsOneWidget);
      expect(find.text('Sem máquinas'), findsNothing);
      expect(find.text('Caminhada e corrida'), findsNothing);
      expect(find.text('Mostrar todos'), findsNothing);
    },
  );

  testWidgets(
    'contexts are optional, separate, and use one context criterion',
    (tester) async {
      final repository = _RecordingRepository();
      await pumpScreen(tester, repository: repository);

      await tester.tap(
        find.byKey(const ValueKey('workout_exercise_selector_context_entry')),
      );
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('workout_exercise_selector_contexts')),
        findsOneWidget,
      );
      expect(CanonicalRegistry.approvedUsageContexts, hasLength(4));
      for (final definition in CanonicalRegistry.approvedUsageContexts) {
        expect(usageContext(definition.id), findsOneWidget);
      }
      for (final definition in CanonicalRegistry.approvedCapabilityRoots) {
        expect(capability(definition.id), findsNothing);
      }

      await tester.tap(usageContext('warmup'));
      await tester.pumpAndSettle();

      expect(repository.queries, hasLength(1));
      expect(repository.queries.single.criteria, hasLength(1));
      expect(
        repository.queries.single.criteria.single,
        const CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.usageContext,
          valueId: 'warmup',
        ),
      );
      expect(find.text('Contexto de utilização'), findsOneWidget);
      expect(find.text('Aquecimento'), findsWidgets);
      expect(find.text('Resultados: 0'), findsOneWidget);
    },
  );

  testWidgets('back and home return to the expected selector level', (
    tester,
  ) async {
    await pumpScreen(tester);

    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_context_entry')),
    );
    await tester.pumpAndSettle();
    await tester.tap(usageContext('activation'));
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_contexts')),
      findsOneWidget,
    );

    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_home')),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_root')),
      findsOneWidget,
    );

    await tester.tap(capability('mobility'));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_root')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('narrow large-text layout remains scrollable without overflow', (
    tester,
  ) async {
    await pumpScreen(tester, size: const Size(320, 568), textScale: 1.6);

    await tester.scrollUntilVisible(
      capability('breathing_regulation'),
      260,
      scrollable: find.byType(Scrollable).first,
    );
    expect(capability('breathing_regulation'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('workout_exercise_selector_context_entry')),
      260,
      scrollable: find.byType(Scrollable).first,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('invalid result is never replaced by fake exercises', (
    tester,
  ) async {
    await pumpScreen(tester, repository: _RecordingRepository(invalid: true));
    await tester.tap(capability('speed_power'));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('workout_exercise_selector_search_error')),
      findsOneWidget,
    );
    expect(find.text('Mostrar todos'), findsNothing);
    expect(find.text('Exercício recomendado'), findsNothing);
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
