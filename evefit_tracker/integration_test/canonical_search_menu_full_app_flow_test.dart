import 'package:evefit_tracker/main.dart' as app;
import 'package:flutter/foundation.dart' show FlutterError, FlutterErrorDetails;
import 'package:flutter/material.dart' show FocusManager, TextField, ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Canonical search works through the real app without hero errors',
    (tester) async {
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
        find.text('Configura\u00e7\u00e3o inicial'),
        timeout: const Duration(minutes: 12),
      );
      await binding.convertFlutterSurfaceToImage();
      _scenario('profile_gate_ready');
      await _screenshot(binding, tester, 'full_app_after_initialization');

      await tester.tap(find.text('Come\u00e7ar'));
      await tester.pumpAndSettle();
      final fields = find.byType(TextField);
      expect(fields, findsNWidgets(5));
      await tester.enterText(fields.at(0), 'Canonical integration');
      await tester.enterText(fields.at(1), '1234');
      await tester.enterText(fields.at(2), '1234');
      FocusManager.instance.primaryFocus?.unfocus();
      await _tapProfileAction(tester, 'Continuar');
      await _tapProfileAction(tester, 'Continuar');
      await _tapProfileAction(tester, 'Continuar');
      await _tapProfileAction(tester, 'Criar perfil');

      await _pumpUntilFound(tester, find.text('Dashboard'));
      _scenario('profile_created_dashboard');
      await _screenshot(binding, tester, 'full_app_dashboard');

      await tester.tap(find.text('Treinos'));
      await _pumpUntilFound(tester, find.text('Criar treino'));
      await tester.tap(find.text('Criar treino'));
      await _pumpUntilFound(tester, find.text('Guardar treino'));
      await _tapVisibleText(tester, 'Guardar treino');
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('workout_detail_add_exercise')),
      );
      await _screenshot(binding, tester, 'full_app_workout_detail');

      await tester.tap(
        find.byKey(const ValueKey('workout_detail_add_exercise')),
      );
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('canonical_search_root_screen')),
      );
      _expectNoHeroErrors(tester, capturedErrors);
      _scenario('canonical_root_from_workout');
      await _screenshot(binding, tester, 'full_app_canonical_root');

      expect(
        find.byKey(const ValueKey('canonical_search_capabilities_section')),
        findsOneWidget,
      );
      expect(
        _nodesAtDepth(tester, const [
          'muscular_capacity',
          'cardio_conditioning',
          'speed_power',
          'mobility',
          'flexibility',
          'motor_control_coordination',
          'technique_skill',
          'breathing_regulation',
        ]),
        8,
      );
      expect(find.text('Mostrar todos'), findsNothing);
      await tester.dragFrom(const Offset(224, 760), const Offset(0, -760));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('canonical_search_contexts_section')),
        findsOneWidget,
      );
      expect(
        _nodesAtDepth(tester, const [
          'warmup',
          'activation',
          'recovery_cooldown',
          'prevention_adaptation_return',
        ]),
        4,
      );
      await _screenshot(binding, tester, 'full_app_canonical_contexts');
      await tester.dragFrom(const Offset(224, 260), const Offset(0, 760));
      await tester.pumpAndSettle();

      await _selectPath(tester, const [
        'cardio_conditioning',
        'cardio_conditioning_no_machines',
        'cardio_conditioning_no_machines_walk_run',
      ]);
      _expectTerminal(tester);
      _expectNoHeroErrors(tester, capturedErrors);
      _scenario('canonical_cardio_terminal');
      await _screenshot(binding, tester, 'full_app_cardio_terminal');

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(
        find.byKey(
          const ValueKey(
            'canonical_search_node_cardio_conditioning_no_machines_walk_run',
          ),
        ),
        findsOneWidget,
      );
      await _systemBack(tester);
      await _systemBack(tester);
      await _systemBack(tester);
      await _systemBack(tester);
      await _pumpUntilFound(tester, find.text('Treinos'));
      _scenario('returned_to_workouts');
      await _screenshot(binding, tester, 'full_app_returned_to_workouts');

      await tester.tap(find.text('Dashboard'));
      await _pumpUntilFound(tester, find.byTooltip('Defini\u00e7\u00f5es'));
      await tester.tap(find.byTooltip('Defini\u00e7\u00f5es'));
      await _pumpUntilFound(tester, find.text('Perfil ativo'));
      await _screenshot(binding, tester, 'full_app_settings_profile');
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Objetivos'));
      await _pumpUntilFound(tester, find.text('Criar objetivo'));
      await _screenshot(binding, tester, 'full_app_goals');
      await tester.tap(find.text('Treinos'));
      await _pumpUntilFound(tester, find.text('Treinos'));

      _expectNoHeroErrors(tester, capturedErrors);
      expect(tester.takeException(), isNull);
      _scenario('full_app_flow_complete');
    },
  );
}

int _nodesAtDepth(WidgetTester tester, List<String> ids) => ids
    .where(
      (id) => find
          .byKey(ValueKey('canonical_search_node_$id'))
          .evaluate()
          .isNotEmpty,
    )
    .length;

Future<void> _tapProfileAction(WidgetTester tester, String label) async {
  await _tapVisibleText(tester, label, maxScrolls: 10);
}

Future<void> _tapVisibleText(
  WidgetTester tester,
  String label, {
  int maxScrolls = 6,
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

Future<void> _selectPath(WidgetTester tester, List<String> ids) async {
  for (final id in ids) {
    final target = find.byKey(ValueKey('canonical_search_node_$id'));
    for (var attempt = 0; attempt < 8; attempt++) {
      if (target.evaluate().isNotEmpty) {
        final center = tester.getCenter(target);
        if (center.dy > 24 && center.dy < 950) break;
      }
      await tester.dragFrom(const Offset(224, 760), const Offset(0, -520));
      await tester.pumpAndSettle();
    }
    await tester.tap(target);
    await tester.pumpAndSettle();
  }
}

Future<void> _systemBack(WidgetTester tester) async {
  await tester.binding.handlePopRoute();
  await tester.pumpAndSettle();
}

void _expectTerminal(WidgetTester tester) {
  expect(
    find.byKey(const ValueKey('canonical_search_empty_state')),
    findsOneWidget,
  );
  expect(
    find.byKey(const ValueKey('canonical_search_empty_path')),
    findsOneWidget,
  );
  expect(find.text('Mostrar todos'), findsNothing);
}

void _expectNoHeroErrors(
  WidgetTester tester,
  List<FlutterErrorDetails> capturedErrors,
) {
  final heroErrors = capturedErrors
      .where(
        (details) => details.exception.toString().contains('multiple heroes'),
      )
      .toList();
  expect(heroErrors, isEmpty);
  expect(tester.takeException(), isNull);
}

Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 30),
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

void _scenario(String name) {
  // ignore: avoid_print
  print('CANONICAL_SEARCH_FULL_APP_SCENARIO=$name');
}
