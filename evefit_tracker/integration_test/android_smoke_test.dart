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

  testWidgets('Android smoke reaches the first selector step', (tester) async {
    final capturedErrors = <FlutterErrorDetails>[];
    final previousOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      capturedErrors.add(details);
      previousOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = previousOnError);

    try {
      final profileTimer = Stopwatch()..start();
      app.main();
      final initialState = await _pumpUntilAny(tester, <String, Finder>{
        'setup': find.text('Configuração inicial'),
        'dashboard': find.text('Dashboard'),
        'profile_selection': find.text('Escolher perfil'),
      }, timeout: const Duration(minutes: 2));

      if (initialState == 'setup') {
        await tester.tap(find.text('Começar'));
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

      expect(find.text('Dashboard'), findsWidgets);
      await tester.tap(_navigationDestination('Treinos'));
      await _pumpUntilFound(tester, find.text('Criar treino'));
      await tester.tap(find.text('Criar treino'));
      final saveWorkout = find.widgetWithText(FilledButton, 'Guardar treino');
      await _pumpUntilFound(tester, saveWorkout);
      final saveCallback = tester.widget<FilledButton>(saveWorkout).onPressed;
      expect(saveCallback, isNotNull);
      saveCallback!();
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('workout_detail_add_exercise')),
      );

      final selectorTimer = Stopwatch()..start();
      await tester.tap(
        find.byKey(const ValueKey('workout_detail_add_exercise')),
      );
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
      final contextFinder = find.byWidgetPredicate(
        (widget) =>
            widget.key is ValueKey<String> &&
            (widget.key! as ValueKey<String>).value.startsWith(
              'workout_exercise_selector_context_',
            ),
        description: 'workout exercise selector contexts',
      );
      expect(contextFinder, findsNWidgets(_contextIds.length));
      for (final id in _contextIds) {
        expect(
          find.byKey(ValueKey('workout_exercise_selector_context_$id')),
          findsOneWidget,
        );
      }
      _marker('CONTEXT_COUNT=${_contextIds.length}');

      await tester.binding.handlePopRoute();
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('workout_detail_add_exercise')),
      );
      _marker('BACK_TO_WORKOUT=true');

      expect(capturedErrors, isEmpty);
      expect(tester.takeException(), isNull);
      _marker('REAL_APP_SELECTOR_SMOKE_COMPLETE');
    } catch (_) {
      rethrow;
    }
  });
}

const _contextIds = <String>[
  'main_training',
  'warmup',
  'activation',
  'recovery_cooldown',
  'prevention_adaptation_return',
];

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
  for (var attempt = 0; attempt <= maxScrolls; attempt++) {
    if (target.evaluate().isNotEmpty) {
      await tester.ensureVisible(target.last);
      await tester.pump();
      final center = tester.getCenter(target.last);
      if (center.dx.isFinite &&
          center.dy.isFinite &&
          center.dy > 0 &&
          center.dy < viewportHeight) {
        await tester.tap(target.last);
        await tester.pump();
        return;
      }
    }
    await tester.dragFrom(const Offset(224, 760), const Offset(0, -520));
    await tester.pump(const Duration(milliseconds: 100));
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
