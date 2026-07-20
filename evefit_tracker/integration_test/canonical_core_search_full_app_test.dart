import 'package:evefit_tracker/main.dart' as app;
import 'package:flutter/foundation.dart' show FlutterError, FlutterErrorDetails;
import 'package:flutter/material.dart'
    show FocusManager, NavigationDestination, TextField, ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Canonical core search works through the real app', (
    tester,
  ) async {
    final capturedErrors = <FlutterErrorDetails>[];
    final previousOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      capturedErrors.add(details);
      previousOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = previousOnError);

    final firstUsable = Stopwatch()..start();
    app.main();
    await _pumpUntilFound(
      tester,
      find.text('Configuração inicial'),
      timeout: const Duration(minutes: 3),
    );
    firstUsable.stop();
    _metric('FIRST_USABLE_MS', firstUsable.elapsedMilliseconds);
    await binding.convertFlutterSurfaceToImage();
    await _screenshot(binding, tester, 'canonical_core_first_usable');

    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextField);
    expect(fields, findsNWidgets(5));
    await tester.enterText(fields.at(0), 'Canonical core integration');
    await tester.enterText(fields.at(1), '1234');
    await tester.enterText(fields.at(2), '1234');
    FocusManager.instance.primaryFocus?.unfocus();
    await _tapVisibleText(tester, 'Continuar');
    await _tapVisibleText(tester, 'Continuar');
    await _tapVisibleText(tester, 'Continuar');
    await _tapVisibleText(tester, 'Criar perfil');

    await _pumpUntilFound(tester, find.text('Dashboard'));
    await _screenshot(binding, tester, 'canonical_core_dashboard');

    await tester.tap(find.text('Treinos'));
    await _pumpUntilFound(tester, find.text('Criar treino'));
    await tester.tap(find.text('Criar treino'));
    await _pumpUntilFound(tester, find.text('Guardar treino'));
    await _tapVisibleText(tester, 'Guardar treino');
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_detail_add_exercise')),
    );
    await _screenshot(binding, tester, 'canonical_core_workout_detail');

    final exploreTimer = Stopwatch()..start();
    await tester.tap(find.byKey(const ValueKey('workout_detail_add_exercise')));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('canonical_core_root_screen')),
    );
    exploreTimer.stop();
    _metric('EXPLORE_OPEN_MS', exploreTimer.elapsedMilliseconds);
    expect(find.text('Como queres procurar?'), findsOneWidget);
    for (final id in const [
      'capability_root',
      'training_intention',
      'training_concept',
      'usage_context',
    ]) {
      expect(find.byKey(ValueKey('canonical_core_axis_$id')), findsOneWidget);
    }
    expect(find.text('Sem máquinas'), findsNothing);
    expect(find.text('Calejamento progressivo'), findsNothing);
    expect(find.text('Mostrar todos'), findsNothing);
    await _screenshot(binding, tester, 'canonical_core_four_axes');

    final capabilityTimer = Stopwatch()..start();
    await tester.tap(
      find.byKey(const ValueKey('canonical_core_axis_capability_root')),
    );
    await tester.pumpAndSettle();
    capabilityTimer.stop();
    _metric('CAPABILITY_OPEN_MS', capabilityTimer.elapsedMilliseconds);
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
      await _scrollToValue(tester, id);
      expect(find.byKey(ValueKey('canonical_core_value_$id')), findsOneWidget);
    }
    await _screenshot(binding, tester, 'canonical_core_eight_roots');

    await _scrollToValue(tester, 'cardio_conditioning');
    final cardioTimer = Stopwatch()..start();
    await tester.tap(
      find.byKey(const ValueKey('canonical_core_value_cardio_conditioning')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('canonical_core_empty_state')),
    );
    cardioTimer.stop();
    _metric('CARDIO_EMPTY_MS', cardioTimer.elapsedMilliseconds);
    expect(find.text('Cardio e condicionamento'), findsWidgets);
    expect(find.text('Resultados: 0'), findsOneWidget);
    expect(find.text('Sem máquinas'), findsNothing);
    await _screenshot(binding, tester, 'canonical_core_cardio_empty');

    await tester.tap(find.byKey(const ValueKey('canonical_core_home')));
    await tester.pumpAndSettle();
    final contextTimer = Stopwatch()..start();
    await tester.tap(
      find.byKey(const ValueKey('canonical_core_axis_usage_context')),
    );
    await tester.pumpAndSettle();
    contextTimer.stop();
    _metric('CONTEXT_OPEN_MS', contextTimer.elapsedMilliseconds);
    for (final id in const [
      'main_training',
      'warmup',
      'activation',
      'recovery',
      'cooldown',
      'prevention',
      'return_to_function',
    ]) {
      await _scrollToValue(tester, id);
      expect(find.byKey(ValueKey('canonical_core_value_$id')), findsOneWidget);
    }
    await _screenshot(binding, tester, 'canonical_core_seven_contexts');

    final warmupTimer = Stopwatch()..start();
    await tester.tap(find.byKey(const ValueKey('canonical_core_value_warmup')));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('canonical_core_empty_state')),
    );
    warmupTimer.stop();
    _metric('WARMUP_EMPTY_MS', warmupTimer.elapsedMilliseconds);
    expect(find.text('Aquecimento'), findsWidgets);
    await _screenshot(binding, tester, 'canonical_core_warmup_empty');

    await tester.tap(find.byKey(const ValueKey('canonical_core_home')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey('canonical_core_axis_training_intention')),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_core_intentions_pending')),
      findsOneWidget,
    );
    await _screenshot(binding, tester, 'canonical_core_intentions_pending');

    await tester.tap(find.byKey(const ValueKey('canonical_core_home')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey('canonical_core_axis_training_concept')),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_core_concepts_pending')),
      findsOneWidget,
    );
    await _screenshot(binding, tester, 'canonical_core_concepts_pending');

    await tester.tap(find.byKey(const ValueKey('canonical_core_home')));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await _pumpUntilFound(tester, find.text('Criar treino'));

    await tester.tap(_navigationDestination('Dashboard'));
    await tester.pumpAndSettle();
    await _pumpUntilFound(tester, find.byTooltip('Definições'));
    await _screenshot(binding, tester, 'canonical_core_dashboard_return');
    await tester.tap(find.byTooltip('Definições'));
    await _pumpUntilFound(tester, find.text('Perfil ativo'));
    await _screenshot(binding, tester, 'canonical_core_profile_settings');
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await tester.tap(_navigationDestination('Objetivos'));
    await tester.pumpAndSettle();
    await _pumpUntilFound(tester, find.text('Criar objetivo'));
    await _screenshot(binding, tester, 'canonical_core_goals');
    await tester.tap(_navigationDestination('Treinos'));
    await tester.pumpAndSettle();
    await _pumpUntilFound(tester, find.text('Treinos'));

    expect(find.text('Mostrar todos'), findsNothing);
    expect(
      capturedErrors.where(
        (details) => details.exception.toString().contains('multiple heroes'),
      ),
      isEmpty,
    );
    expect(capturedErrors, isEmpty);
    expect(tester.takeException(), isNull);
    _scenario('CANONICAL_CORE_FULL_APP_COMPLETE');
  });
}

Future<void> _scrollToValue(WidgetTester tester, String id) async {
  final target = find.byKey(ValueKey('canonical_core_value_$id'));
  for (var attempt = 0; attempt < 10; attempt++) {
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
}

void _metric(String name, int milliseconds) {
  // ignore: avoid_print
  print('CANONICAL_CORE_$name=$milliseconds');
}

void _scenario(String name) {
  // ignore: avoid_print
  print(name);
}
