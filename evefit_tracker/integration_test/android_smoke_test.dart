import 'package:evefit_tracker/main.dart' as app;
import 'package:flutter/foundation.dart' show FlutterError, FlutterErrorDetails;
import 'package:flutter/material.dart'
    show
        FilledButton,
        FocusManager,
        NavigationDestination,
        Scaffold,
        TextField,
        ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Android smoke completes a real canonical exercise path', (
    tester,
  ) async {
    final capturedErrors = <FlutterErrorDetails>[];
    final previousOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      capturedErrors.add(details);
      previousOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = previousOnError);

    app.main();
    final profileTimer = Stopwatch()..start();
    final initialState = await _pumpUntilAny(tester, <String, Finder>{
      'setup': find.text('Configuração inicial'),
      'dashboard': find.text('Dashboard'),
      'profile_selection': find.text('Escolher perfil'),
    }, timeout: const Duration(minutes: 2));

    if (initialState == 'setup') {
      await _tapVisible(tester, find.text('Começar'));
      await _pumpUntilFound(tester, find.byType(TextField));
      final fields = find.byType(TextField);
      expect(fields, findsNWidgets(5));
      await tester.enterText(fields.at(0), 'Android smoke profile');
      await tester.enterText(fields.at(1), '1234');
      await tester.enterText(fields.at(2), '1234');
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump();
      await _advanceProfileStep(tester, find.text('Passo 2 de 4'));
      await _advanceProfileStep(tester, find.text('Passo 3 de 4'));
      await _advanceProfileStep(
        tester,
        find.widgetWithText(FilledButton, 'Criar perfil'),
      );
      await _tapVisible(
        tester,
        find.widgetWithText(FilledButton, 'Criar perfil'),
      );
      await _pumpUntilFound(tester, find.text('Dashboard'));
      _marker('PROFILE=created');
    } else if (initialState == 'profile_selection') {
      await _tapVisible(tester, _profileOptionFinder());
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('profile_unlock_pin')),
      );
      await tester.enterText(
        find.byKey(const ValueKey('profile_unlock_pin')),
        '1234',
      );
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump();
      await _tapVisible(
        tester,
        find.byKey(const ValueKey('profile_unlock_submit')),
      );
      await _pumpUntilFound(tester, find.text('Dashboard'));
      _marker('PROFILE=reused');
    } else {
      _marker('PROFILE=reused');
    }
    profileTimer.stop();
    _metric('PROFILE_READY_MS', profileTimer.elapsedMilliseconds);

    await tester.tap(_navigationDestination('Treinos'));
    await _pumpUntilFound(tester, find.text('Criar treino'));
    await tester.tap(find.text('Criar treino'));
    final saveWorkout = find.widgetWithText(FilledButton, 'Guardar treino');
    await _pumpUntilFound(tester, saveWorkout);
    final saveCallback = tester.widget<FilledButton>(saveWorkout).onPressed;
    expect(saveCallback, isNotNull);
    saveCallback!();
    await tester.pump();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_detail_add_exercise')),
    );

    final selectorTimer = Stopwatch()..start();
    await tester.tap(find.byKey(const ValueKey('workout_detail_add_exercise')));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_contexts')),
    );
    selectorTimer.stop();
    _metric('OPEN_SELECTOR_MS', selectorTimer.elapsedMilliseconds);

    expect(
      find.text('Em que contexto vais utilizar o exercício?'),
      findsOneWidget,
    );
    for (final id in _contextIds) {
      await _scrollToKey(
        tester,
        ValueKey('workout_exercise_selector_context_$id'),
      );
      expect(
        find.byKey(ValueKey('workout_exercise_selector_context_$id')),
        findsOneWidget,
      );
    }
    _marker('CONTEXT_COUNT=${_contextIds.length}');

    await _selectPath(
      tester,
      contextId: 'warmup',
      capabilityId: 'cardio_conditioning',
      conceptId: 'cyclic_locomotion',
    );
    expect(
      find.byKey(const ValueKey('training_intention_list')),
      findsOneWidget,
    );
    expect(_intentionCards(), findsWidgets);
    _marker('WARMUP_CARDIO_CYCLIC_INTENTIONS=visible');

    await _tapVisible(tester, _intentionCards().first);
    await _pumpUntilFound(tester, find.text('Detalhe da intenção'));
    expect(find.text('Selecionar esta intenção'), findsOneWidget);
    await _tapVisible(tester, find.text('Selecionar esta intenção'));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_results_empty')),
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
    for (final key in _completeBreadcrumbKeys) {
      expect(find.byKey(key), findsOneWidget);
    }
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_empty_path')),
      findsOneWidget,
    );
    _expectNoLegacy();
    _marker('EXERCISES_EMPTY_WITH_COMPLETE_BREADCRUMB=true');

    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_home')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_contexts')),
    );
    await tester.binding.handlePopRoute();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_detail_add_exercise')),
    );
    _marker('BACK_TO_WORKOUT=true');

    expect(capturedErrors, isEmpty);
    expect(tester.takeException(), isNull);
    _marker('REAL_APP_SELECTOR_SMOKE_COMPLETE');
  });
}

const _contextIds = <String>[
  'main_training',
  'warmup',
  'activation',
  'recovery',
  'cooldown',
  'prevention',
  'return_to_function',
];

const _completeBreadcrumbKeys = <ValueKey<String>>[
  ValueKey('workout_exercise_selector_breadcrumb_context'),
  ValueKey('workout_exercise_selector_breadcrumb_capability'),
  ValueKey('workout_exercise_selector_breadcrumb_concept'),
  ValueKey('workout_exercise_selector_breadcrumb_intention'),
];

Finder _intentionCards() => find.byWidgetPredicate(
  (widget) =>
      widget.key is ValueKey<String> &&
      (widget.key! as ValueKey<String>).value.startsWith(
        'training_intention_card_',
      ),
  description: 'training intention cards',
);

void _expectNoLegacy() {
  expect(find.text('Sem máquinas'), findsNothing);
  expect(find.text('Caminhada e corrida'), findsNothing);
  expect(find.text('Mostrar todos'), findsNothing);
  expect(find.text('Hipertrofia'), findsNothing);
  expect(find.text('Exercício recomendado'), findsNothing);
  expect(find.text('Resultados: 0'), findsNothing);
}

Future<void> _selectPath(
  WidgetTester tester, {
  required String contextId,
  required String capabilityId,
  required String conceptId,
}) async {
  await _tapVisible(
    tester,
    find.byKey(ValueKey('workout_exercise_selector_context_$contextId')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('workout_exercise_selector_capabilities')),
  );
  await _tapVisible(
    tester,
    find.byKey(ValueKey('workout_exercise_selector_capability_$capabilityId')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('workout_exercise_selector_concepts')),
  );
  await _tapVisible(
    tester,
    find.byKey(ValueKey('workout_exercise_selector_concept_$conceptId')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('workout_exercise_selector_intentions')),
  );
}

Future<void> _scrollToKey(WidgetTester tester, ValueKey<String> key) async {
  final target = find.byKey(key);
  for (final offset in const [Offset(0, -480), Offset(0, 480)]) {
    for (var attempt = 0; attempt < 18; attempt++) {
      if (target.evaluate().isNotEmpty) {
        await tester.ensureVisible(target);
        await tester.pump();
        return;
      }
      await tester.dragFrom(const Offset(224, 500), offset);
      await tester.pump(const Duration(milliseconds: 100));
    }
  }
  expect(target, findsOneWidget);
}

Finder _navigationDestination(String label) => find.byWidgetPredicate(
  (widget) => widget is NavigationDestination && widget.label == label,
  description: 'NavigationDestination($label)',
);

Finder _profileOptionFinder() => find.byWidgetPredicate(
  (widget) =>
      widget.key is ValueKey<String> &&
      (widget.key! as ValueKey<String>).value.startsWith('profile_option_'),
  description: 'profile option',
);

Future<String> _pumpUntilAny(
  WidgetTester tester,
  Map<String, Finder> candidates, {
  Duration timeout = const Duration(seconds: 45),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 100));
    for (final candidate in candidates.entries) {
      if (candidate.value.evaluate().isNotEmpty) return candidate.key;
    }
  }
  fail('Timed out waiting for one of: ${candidates.keys.join(', ')}');
}

Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 45),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) return;
  }
  expect(finder, findsOneWidget);
}

Future<void> _advanceProfileStep(
  WidgetTester tester,
  Finder expectedState,
) async {
  await _tapVisible(tester, find.widgetWithText(FilledButton, 'Continuar'));
  await _pumpUntilFound(tester, expectedState);
}

Future<void> _tapVisible(
  WidgetTester tester,
  Finder target, {
  int maxScrolls = 18,
}) async {
  final viewportHeight = tester.getSize(find.byType(Scaffold).last).height;
  for (final offset in const [Offset(0, -520), Offset(0, 520)]) {
    for (var attempt = 0; attempt <= maxScrolls; attempt++) {
      if (target.evaluate().isNotEmpty) {
        await tester.ensureVisible(target.last);
        await tester.pump();
        final currentTargets = target.evaluate().toList();
        if (currentTargets.isNotEmpty) {
          final currentTarget = target.at(currentTargets.length - 1);
          final center = tester.getCenter(currentTarget);
          if (center.dx.isFinite &&
              center.dy.isFinite &&
              center.dy > 0 &&
              center.dy < viewportHeight) {
            await tester.tap(currentTarget);
            await tester.pump();
            return;
          }
        }
      }
      await tester.dragFrom(const Offset(224, 760), offset);
      await tester.pump(const Duration(milliseconds: 100));
    }
  }
  fail('Could not make the tap target visible within $maxScrolls scrolls.');
}

void _metric(String name, int milliseconds) {
  // ignore: avoid_print
  print('ANDROID_SMOKE_$name=$milliseconds');
}

void _marker(String value) {
  // ignore: avoid_print
  print('ANDROID_SMOKE_$value');
}
