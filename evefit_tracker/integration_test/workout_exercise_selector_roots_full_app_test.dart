import 'dart:io';

import 'package:evefit_tracker/main.dart' as app;
import 'package:flutter/foundation.dart' show FlutterError, FlutterErrorDetails;
import 'package:flutter/material.dart'
    show FocusManager, NavigationDestination, TextField, ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('workout exercise selector starts with canonical roots', (
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
    await _pumpUntilFound(
      tester,
      find.text('Configuração inicial'),
      timeout: const Duration(minutes: 3),
    );
    await binding.convertFlutterSurfaceToImage();
    await _screenshot(binding, tester, 'selector_initial_setup');

    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextField);
    expect(fields, findsNWidgets(5));
    await tester.enterText(fields.at(0), 'Workout selector integration');
    await tester.enterText(fields.at(1), '1234');
    await tester.enterText(fields.at(2), '1234');
    FocusManager.instance.primaryFocus?.unfocus();
    await _tapVisibleText(tester, 'Continuar');
    await _tapVisibleText(tester, 'Continuar');
    await _tapVisibleText(tester, 'Continuar');
    await _tapVisibleText(tester, 'Criar perfil');

    await _pumpUntilFound(tester, find.text('Dashboard'));
    await _screenshot(binding, tester, 'selector_dashboard');

    await tester.tap(_navigationDestination('Treinos'));
    await _pumpUntilFound(tester, find.text('Criar treino'));
    await tester.tap(find.text('Criar treino'));
    await _pumpUntilFound(tester, find.text('Guardar treino'));
    await _tapVisibleText(tester, 'Guardar treino');
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_detail_add_exercise')),
    );
    await _screenshot(binding, tester, 'selector_workout_detail');

    final openTimer = Stopwatch()..start();
    await tester.tap(find.byKey(const ValueKey('workout_detail_add_exercise')));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_root')),
    );
    openTimer.stop();
    _metric('OPEN_MS', openTimer.elapsedMilliseconds);

    expect(find.text('Que capacidade queres trabalhar?'), findsOneWidget);
    for (final id in _capabilityIds) {
      await _scrollToKey(
        tester,
        ValueKey('workout_exercise_selector_capability_$id'),
      );
      expect(
        find.byKey(ValueKey('workout_exercise_selector_capability_$id')),
        findsOneWidget,
      );
    }
    for (final id in _contextIds) {
      expect(
        find.byKey(ValueKey('workout_exercise_selector_context_$id')),
        findsNothing,
      );
    }
    _expectNoLegacyOrSublevels();
    await _screenshot(binding, tester, 'selector_eight_capability_roots');

    await _scrollToKey(
      tester,
      const ValueKey(
        'workout_exercise_selector_capability_cardio_conditioning',
      ),
    );
    final rootResultTimer = Stopwatch()..start();
    await tester.tap(
      find.byKey(
        const ValueKey(
          'workout_exercise_selector_capability_cardio_conditioning',
        ),
      ),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_result_empty')),
    );
    rootResultTimer.stop();
    _metric('CAPABILITY_EMPTY_MS', rootResultTimer.elapsedMilliseconds);
    expect(find.text('Raiz de capacidade'), findsOneWidget);
    expect(find.text('Cardio e condicionamento'), findsWidgets);
    expect(find.text('Resultados: 0'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_active_criterion')),
      findsOneWidget,
    );
    _expectNoLegacyOrSublevels();
    await _screenshot(binding, tester, 'selector_cardio_empty');

    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_back')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_root')),
    );
    for (final id in _capabilityIds) {
      await _scrollToKey(
        tester,
        ValueKey('workout_exercise_selector_capability_$id'),
      );
      expect(
        find.byKey(ValueKey('workout_exercise_selector_capability_$id')),
        findsOneWidget,
      );
    }

    await _scrollToKey(
      tester,
      const ValueKey('workout_exercise_selector_context_entry'),
    );
    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_context_entry')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_contexts')),
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
    for (final id in _capabilityIds) {
      expect(
        find.byKey(ValueKey('workout_exercise_selector_capability_$id')),
        findsNothing,
      );
    }
    await _screenshot(binding, tester, 'selector_four_contexts');

    await _scrollToKey(
      tester,
      const ValueKey('workout_exercise_selector_context_warmup'),
    );
    final contextResultTimer = Stopwatch()..start();
    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_context_warmup')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_result_empty')),
    );
    contextResultTimer.stop();
    _metric('CONTEXT_EMPTY_MS', contextResultTimer.elapsedMilliseconds);
    expect(find.text('Contexto de utilização'), findsOneWidget);
    expect(find.text('Aquecimento'), findsWidgets);
    expect(find.text('Resultados: 0'), findsOneWidget);
    _expectNoLegacyOrSublevels();
    await _screenshot(binding, tester, 'selector_warmup_empty');

    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_back')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_contexts')),
    );
    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_home')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_root')),
    );
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_detail_add_exercise')),
    );
    await _screenshot(binding, tester, 'selector_returned_to_workout_detail');

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await _pumpUntilFound(tester, find.text('Criar treino'));

    await tester.tap(_navigationDestination('Dashboard'));
    await _pumpUntilFound(tester, find.byTooltip('Definições'));
    await tester.tap(find.byTooltip('Definições'));
    await _pumpUntilFound(tester, find.text('Perfil ativo'));
    expect(find.text('Definições'), findsOneWidget);
    await _screenshot(binding, tester, 'selector_profile_settings');
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    await tester.tap(_navigationDestination('Objetivos'));
    await _pumpUntilFound(tester, find.text('Criar objetivo'));
    await _screenshot(binding, tester, 'selector_goals');
    await tester.tap(_navigationDestination('Treinos'));
    await _pumpUntilFound(tester, find.text('Treinos'));

    expect(
      capturedErrors.where(
        (details) => details.exception.toString().contains('multiple heroes'),
      ),
      isEmpty,
    );
    expect(capturedErrors, isEmpty);
    expect(tester.takeException(), isNull);
    _scenario('WORKOUT_EXERCISE_SELECTOR_ROOTS_FULL_APP_COMPLETE');
  });
}

const _capabilityIds = <String>[
  'muscular_capacity',
  'cardio_conditioning',
  'speed_power',
  'mobility',
  'flexibility',
  'motor_control_coordination',
  'technique_skill',
  'breathing_regulation',
];

const _contextIds = <String>[
  'warmup',
  'activation',
  'recovery_cooldown',
  'prevention_adaptation_return',
];

void _expectNoLegacyOrSublevels() {
  expect(find.text('Sem máquinas'), findsNothing);
  expect(find.text('Caminhada e corrida'), findsNothing);
  expect(find.text('Mostrar todos'), findsNothing);
  expect(find.text('Por intenção'), findsNothing);
  expect(find.text('Por conceito de treino'), findsNothing);
}

Future<void> _scrollToKey(WidgetTester tester, ValueKey<String> key) async {
  final target = find.byKey(key);
  for (var attempt = 0; attempt < 12; attempt++) {
    if (target.evaluate().isNotEmpty) {
      final center = tester.getCenter(target);
      if (center.dy > 24 && center.dy < 950) return;
    }
    await tester.dragFrom(const Offset(224, 760), const Offset(0, -480));
    await tester.pumpAndSettle();
  }
  expect(target, findsOneWidget);
}

Finder _navigationDestination(String label) => find.byWidgetPredicate(
  (widget) => widget is NavigationDestination && widget.label == label,
  description: 'NavigationDestination($label)',
);

Future<void> _tapVisibleText(
  WidgetTester tester,
  String label, {
  int maxScrolls = 10,
}) async {
  final target = find.text(label);
  for (var attempt = 0; attempt <= maxScrolls; attempt++) {
    if (target.evaluate().isNotEmpty) {
      final center = tester.getCenter(target.last);
      if (center.dy > 24 && center.dy < 950) {
        await tester.tap(target.last);
        await tester.pumpAndSettle();
        return;
      }
    }
    await tester.dragFrom(const Offset(224, 760), const Offset(0, -520));
    await tester.pumpAndSettle();
  }
  expect(target, findsOneWidget);
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

Future<void> _screenshot(
  IntegrationTestWidgetsFlutterBinding binding,
  WidgetTester tester,
  String name,
) async {
  await tester.pump();
  final image = await binding.takeScreenshot(name);
  expect(image, isNotEmpty);
  final directory = Directory(
    '${Directory.systemTemp.path}/workout_exercise_selector_roots',
  );
  await directory.create(recursive: true);
  final file = File('${directory.path}/$name.png');
  await file.writeAsBytes(image, flush: true);
  // ignore: avoid_print
  print('WORKOUT_EXERCISE_SELECTOR_SCREENSHOT=$name|${file.path}');
}

void _metric(String name, int milliseconds) {
  // ignore: avoid_print
  print('WORKOUT_EXERCISE_SELECTOR_$name=$milliseconds');
}

void _scenario(String name) {
  // ignore: avoid_print
  print(name);
}
