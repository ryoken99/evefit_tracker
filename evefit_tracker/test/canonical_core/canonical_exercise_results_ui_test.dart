import 'dart:async';

import 'package:evefit_tracker/features/canonical_core/generated/exercises/canonical_exercise_beginner_content.g.dart';
import 'package:evefit_tracker/features/canonical_core/generated/exercises/canonical_exercise_path_links.g.dart';
import 'package:evefit_tracker/features/canonical_core/generated/exercises/canonical_exercises_registry.g.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_exercise_models.dart';
import 'package:evefit_tracker/features/canonical_core/repositories/canonical_exercise_search_repository.dart';
import 'package:evefit_tracker/features/canonical_core/screens/canonical_exercise_detail_screen.dart';
import 'package:evefit_tracker/features/canonical_core/screens/workout_exercise_selector_screen.dart';
import 'package:evefit_tracker/features/canonical_core/services/hierarchical_canonical_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('approved path shows ordered exercise list and reusable detail', (
    tester,
  ) async {
    final link = generatedCanonicalWave1PathLinks.first;
    final controller = _controllerAt(link);

    await _pump(tester, controller);

    expect(
      find.byKey(const ValueKey('workout_exercise_selector_results_list')),
      findsOneWidget,
    );
    expect(find.text('Exercícios disponíveis'), findsOneWidget);
    expect(find.text('Passo 5 de 5: Exercícios'), findsOneWidget);
    expect(
      find.byKey(
        ValueKey('workout_exercise_selector_exercise_${link.exerciseId}'),
      ),
      findsOneWidget,
    );
    expect(find.text('Adicionar ao treino'), findsNothing);

    await _openExercise(tester, link.exerciseId);

    expect(
      find.byKey(const ValueKey('canonical_exercise_detail_screen')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('canonical_exercise_detail_name')),
      findsOneWidget,
    );
    expect(find.text('O que é'), findsOneWidget);
    expect(find.text('O que vais fazer'), findsOneWidget);
    expect(find.text('Adicionar ao treino'), findsNothing);
    expect(find.textContaining('http'), findsNothing);
    expect(find.textContaining('media_id'), findsNothing);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_results_list')),
      findsOneWidget,
    );
    expect(
      tester
          .getCenter(
            find.byKey(
              ValueKey('workout_exercise_selector_view_${link.exerciseId}'),
            ),
          )
          .dy,
      lessThan(tester.view.physicalSize.height),
    );
    expect(controller.step, HierarchicalCanonicalSearchStep.results);
  });

  testWidgets('result loading and error states preserve safe navigation', (
    tester,
  ) async {
    final link = generatedCanonicalWave1PathLinks.first;
    final pending = _PendingRepository();
    final loadingController = _controllerAt(link, repository: pending);

    await _pumpFrame(tester, loadingController);
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_results_loading')),
      findsOneWidget,
    );
    pending.completer.complete(
      CanonicalSearchResult<CanonicalResolvedExercise>(
        query: loadingController.currentQuery,
        total: 0,
        items: const [],
        status: CanonicalSearchResultStatus.success,
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_results_empty')),
      findsOneWidget,
    );

    final errorController = _controllerAt(
      link,
      repository: const _ErrorRepository(),
    );
    await _pump(tester, errorController);
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_results_error')),
      findsOneWidget,
    );
    await tester.tap(find.text('Voltar à intenção'));
    await tester.pumpAndSettle();
    expect(
      errorController.step,
      HierarchicalCanonicalSearchStep.trainingIntention,
    );
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_intentions')),
      findsOneWidget,
    );
  });

  testWidgets('detail exposes its heading and 18 public sections in order', (
    tester,
  ) async {
    final link = generatedCanonicalWave1PathLinks.first;
    await _pump(tester, _controllerAt(link));
    await _openExercise(tester, link.exerciseId);
    expect(
      find.byKey(const ValueKey('canonical_exercise_detail_name')),
      findsOneWidget,
    );

    const sectionTitles = <String>[
      'O que é',
      'O que vais fazer',
      'Antes de começar',
      'Equipamento necessário',
      'Preparação do espaço',
      'Posição inicial',
      'Como executar',
      'Fases do movimento',
      'Como respirar',
      'O que deves sentir',
      'Sinais inesperados ou de alerta',
      'Pontos de controlo',
      'Erros comuns e correções',
      'Como simplificar',
      'Quando não deves executar sozinho',
      'Como terminar',
      'Segurança',
      'Evidência e limites',
    ];
    for (final title in sectionTitles) {
      await _bringDetailTextIntoView(tester, title);
      expect(find.text(title), findsOneWidget);
    }
    expect(sectionTitles, hasLength(18));
    expect(tester.takeException(), isNull);
  });

  testWidgets('all 49 detail screens render on the Pixel 8 Pro viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(448, 998);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final contentById = {
      for (final content in generatedCanonicalWave1BeginnerContent)
        content.exerciseId: content,
    };
    final linkByExerciseId = {
      for (final link in generatedCanonicalWave1PathLinks)
        link.exerciseId: link,
    };

    for (final definition in generatedCanonicalWave1Exercises) {
      final content = contentById[definition.id];
      final compatibility = linkByExerciseId[definition.id];
      expect(content, isNotNull, reason: definition.id);
      expect(compatibility, isNotNull, reason: definition.id);

      await tester.pumpWidget(
        MaterialApp(
          home: CanonicalExerciseDetailScreen(
            exercise: CanonicalResolvedExercise(
              definition: definition,
              content: content!,
              compatibility: compatibility!,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('canonical_exercise_detail_screen')),
        findsOneWidget,
        reason: definition.id,
      );
      await _bringDetailTextIntoView(tester, 'Evidência e limites');
      expect(tester.takeException(), isNull, reason: definition.id);
    }
  });

  testWidgets('result card exposes one accessible details action', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      final link = generatedCanonicalWave1PathLinks.first;
      final definition = generatedCanonicalWave1Exercises.firstWhere(
        (item) => item.id == link.exerciseId,
      );
      await _pump(tester, _controllerAt(link));
      await _bringResultIntoView(tester, link.exerciseId);

      expect(
        find.bySemanticsLabel('Ver detalhes de ${definition.namePtPt}'),
        findsOneWidget,
      );
      expect(
        tester.widget(
          find.byKey(
            ValueKey('workout_exercise_selector_view_${definition.id}'),
          ),
        ),
        isA<Text>(),
      );
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('high-risk detail exposes warning before execution content', (
    tester,
  ) async {
    final highRiskIds = generatedCanonicalWave1Exercises
        .where(
          (item) =>
              item.safety.operationalRiskTier == CanonicalExerciseRiskTier.high,
        )
        .map((item) => item.id)
        .toSet();
    final link = generatedCanonicalWave1PathLinks.firstWhere(
      (item) => highRiskIds.contains(item.exerciseId),
    );
    await _pump(tester, _controllerAt(link));

    await _openExercise(tester, link.exerciseId);

    expect(
      find.byKey(const ValueKey('canonical_exercise_detail_high_risk')),
      findsOneWidget,
    );
    expect(find.text('Exigência elevada'), findsWidgets);
    expect(find.textContaining('Confirma os pré-requisitos'), findsOneWidget);
    expect(find.text('Pára ou reduz perante:'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('variant is labelled publicly without exposing canonical IDs', (
    tester,
  ) async {
    final variantIds = generatedCanonicalWave1Exercises
        .where((item) => item.identity.isVariant)
        .map((item) => item.id)
        .toSet();
    final link = generatedCanonicalWave1PathLinks.firstWhere(
      (item) => variantIds.contains(item.exerciseId),
    );
    await _pump(tester, _controllerAt(link));

    await _bringResultIntoView(tester, link.exerciseId);
    expect(find.text('Variante'), findsOneWidget);
    expect(find.text(link.exerciseId), findsNothing);

    await _openExercise(tester, link.exerciseId);
    expect(find.text('Variante'), findsOneWidget);
    expect(find.text(link.exerciseId), findsNothing);
  });

  testWidgets('narrow large-text list and detail remain scrollable', (
    tester,
  ) async {
    final link = generatedCanonicalWave1PathLinks.first;
    await _pump(
      tester,
      _controllerAt(link),
      size: const Size(320, 568),
      textScale: 1.5,
    );

    expect(tester.takeException(), isNull);
    await _openExercise(tester, link.exerciseId);
    expect(tester.takeException(), isNull);

    await tester.dragUntilVisible(
      find.text('Evidência e limites'),
      find.byKey(const ValueKey('canonical_exercise_detail_screen')),
      const Offset(0, -300),
      maxIteration: 40,
    );
    expect(find.text('Evidência e limites'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

HierarchicalCanonicalSearchController _controllerAt(
  CanonicalExercisePathCompatibility link, {
  CanonicalExerciseSearchRepository<CanonicalResolvedExercise>? repository,
}) =>
    HierarchicalCanonicalSearchController(
        exerciseRepository:
            repository ?? const GeneratedCanonicalExerciseSearchRepository(),
      )
      ..selectUsageContext(link.pathKey.usageContextId)
      ..selectCapabilityRoot(link.pathKey.capabilityRootId)
      ..selectTrainingConcept(link.pathKey.trainingConceptId)
      ..selectTrainingIntention(link.pathKey.trainingIntentionId);

Future<void> _pump(
  WidgetTester tester,
  HierarchicalCanonicalSearchController controller, {
  Size size = const Size(430, 932),
  double textScale = 1,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          textScaler: TextScaler.linear(textScale),
        ),
        child: WorkoutExerciseSelectorScreen(controller: controller),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _pumpFrame(
  WidgetTester tester,
  HierarchicalCanonicalSearchController controller,
) async {
  await tester.pumpWidget(
    MaterialApp(home: WorkoutExerciseSelectorScreen(controller: controller)),
  );
  await tester.pump();
}

Future<void> _openExercise(WidgetTester tester, String exerciseId) async {
  await _bringResultIntoView(tester, exerciseId);
  await tester.tap(
    find.byKey(ValueKey('workout_exercise_selector_view_$exerciseId')),
  );
  await tester.pumpAndSettle();
}

Future<void> _bringResultIntoView(
  WidgetTester tester,
  String exerciseId,
) async {
  final target = find.byKey(
    ValueKey('workout_exercise_selector_view_$exerciseId'),
  );
  final list = find.byKey(
    const ValueKey('workout_exercise_selector_results_list'),
  );

  for (var attempt = 0; attempt < 20; attempt++) {
    if (target.evaluate().isNotEmpty) {
      final center = tester.getCenter(target);
      final viewportHeight = tester.view.physicalSize.height;
      if (center.dy >= 80 && center.dy <= viewportHeight - 40) {
        return;
      }
    }
    await tester.drag(list, const Offset(0, -260));
    await tester.pumpAndSettle();
  }

  expect(target, findsOneWidget);
}

Future<void> _bringDetailTextIntoView(WidgetTester tester, String text) async {
  final target = find.text(text);
  final list = find.byKey(const ValueKey('canonical_exercise_detail_screen'));
  for (var attempt = 0; attempt < 40; attempt++) {
    if (target.evaluate().isNotEmpty) {
      await tester.ensureVisible(target);
      await tester.pump();
      return;
    }
    await tester.drag(list, const Offset(0, -260));
    await tester.pumpAndSettle();
  }
  expect(target, findsOneWidget);
}

class _PendingRepository
    implements CanonicalExerciseSearchRepository<CanonicalResolvedExercise> {
  final completer =
      Completer<CanonicalSearchResult<CanonicalResolvedExercise>>();

  @override
  Future<CanonicalSearchResult<CanonicalResolvedExercise>> search(
    CanonicalSearchQuery query,
  ) => completer.future;
}

class _ErrorRepository
    implements CanonicalExerciseSearchRepository<CanonicalResolvedExercise> {
  const _ErrorRepository();

  @override
  Future<CanonicalSearchResult<CanonicalResolvedExercise>> search(
    CanonicalSearchQuery query,
  ) => Future.error(StateError('Deliberate repository failure.'));
}
