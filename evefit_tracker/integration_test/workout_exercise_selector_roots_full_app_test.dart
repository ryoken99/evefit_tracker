import 'dart:io';

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

import 'helpers/eft_landing_test_helper.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('full app validates Wave1 exercise results and empty paths', (
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
    await dismissEftLanding(tester);
    await _ensureDashboard(tester);
    await binding.convertFlutterSurfaceToImage();
    await _screenshot(binding, tester, 'v114_dashboard');

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
    await _screenshot(binding, tester, 'v114_workout_detail');

    final openTimer = Stopwatch()..start();
    await tester.tap(find.byKey(const ValueKey('workout_detail_add_exercise')));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_contexts')),
    );
    openTimer.stop();
    _metric('OPEN_MS', openTimer.elapsedMilliseconds);

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
    _expectNoLegacy();
    await _screenshot(binding, tester, 'v114_seven_contexts');

    await _selectPath(
      tester,
      contextId: 'main_training',
      capabilityId: 'speed_power',
      conceptId: 'explosive_acceleration',
    );
    final increaseAcceleration = find.byKey(
      const ValueKey(
        'training_intention_card_increase_initial_acceleration_main_training_speed_power_explosive_acceleration',
      ),
    );
    await _tapIntention(tester, increaseAcceleration);
    await _pumpUntilFound(tester, find.text('Detalhe da intenção'));
    await _tapVisible(tester, find.text('Selecionar esta intenção'));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_results_list')),
    );
    expect(find.text('Exercícios disponíveis'), findsOneWidget);
    expect(find.text('Passo 5 de 5: Exercícios'), findsOneWidget);
    await _scrollToKey(
      tester,
      const ValueKey('workout_exercise_selector_exercise_sled_resisted_sprint'),
    );
    expect(find.text('Variante'), findsWidgets);
    expect(find.text('Exigência elevada'), findsWidgets);
    expect(find.text('Adicionar ao treino'), findsNothing);
    await _screenshot(binding, tester, 'wave1_exercise_results');

    await _tapVisible(
      tester,
      find.byKey(
        const ValueKey('workout_exercise_selector_view_sled_resisted_sprint'),
      ),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('canonical_exercise_detail_screen')),
    );
    expect(
      find.byKey(const ValueKey('canonical_exercise_detail_high_risk')),
      findsOneWidget,
    );
    expect(find.text('Variante'), findsWidgets);
    expect(find.text('Adicionar ao treino'), findsNothing);
    await _screenshot(binding, tester, 'wave1_high_risk_variant_detail');
    await _scrollUntilFound(tester, find.text('Evidência e limites'));
    expect(find.text('Evidência e limites'), findsOneWidget);
    await _screenshot(binding, tester, 'wave1_long_detail_scrolled');
    await tester.binding.handlePopRoute();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_results_list')),
    );
    expect(tester.takeException(), isNull);

    await _goHome(tester);
    await _selectPath(
      tester,
      contextId: 'warmup',
      capabilityId: 'cardio_conditioning',
      conceptId: 'cyclic_locomotion',
    );
    expect(_intentionCards(), findsWidgets);
    await _screenshot(binding, tester, 'v114_warmup_cardio_intentions');

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
    await _screenshot(binding, tester, 'v114_warmup_exercises_empty');

    await _goHome(tester);
    await _selectContextAndCapability(
      tester,
      contextId: 'recovery',
      capabilityId: 'speed_power',
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_concept_empty')),
    );
    expect(
      find.text('Ainda não existem conceitos de treino aprovados.'),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('workout_exercise_selector_empty_path')),
      findsOneWidget,
    );
    _expectNoLegacy();
    await _screenshot(binding, tester, 'v114_recovery_speed_power_empty');

    await _goHome(tester);
    await _selectPath(
      tester,
      contextId: 'return_to_function',
      capabilityId: 'muscular_capacity',
      conceptId: 'loaded_carry',
    );
    final clinicalCard = find.byKey(
      const ValueKey(
        'training_intention_card_restore_gait_under_load_return_to_function_muscular_capacity_loaded_carry',
      ),
    );
    await _tapVisible(tester, clinicalCard);
    await _pumpUntilFound(tester, find.text('Detalhe da intenção'));
    expect(
      find.text(
        'Utilização dependente de critérios de elegibilidade ou avaliação profissional.',
      ),
      findsWidgets,
    );
    expect(
      find.text(
        'Esta intenção requer revisão clínica antes de ser utilizada numa decisão individual.',
      ),
      findsWidgets,
    );
    final returnToFunctionNote = find.text(
      'Retorno à função não substitui diagnóstico, reabilitação, critérios clínicos ou autorização de retorno ao desporto.',
    );
    await _scrollUntilFound(tester, returnToFunctionNote);
    expect(returnToFunctionNote, findsOneWidget);
    await _screenshot(
      binding,
      tester,
      'v114_return_to_function_clinical_detail',
    );
    await tester.tap(find.byTooltip('Fechar'));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_intentions')),
    );

    await _goHome(tester);
    await _selectPath(
      tester,
      contextId: 'warmup',
      capabilityId: 'speed_power',
      conceptId: 'ballistic_projection',
    );
    final hiddenAdvanced = find.byKey(
      const ValueKey(
        'training_intention_card_prepare_ballistic_projection_chain_warmup_speed_power_ballistic_projection',
      ),
    );
    expect(hiddenAdvanced, findsNothing);
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('training_intention_advanced_toggle')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('training_intention_advanced_group')),
    );
    await _scrollToKey(
      tester,
      const ValueKey(
        'training_intention_card_prepare_ballistic_projection_chain_warmup_speed_power_ballistic_projection',
      ),
    );
    expect(hiddenAdvanced, findsOneWidget);
    await _screenshot(binding, tester, 'v114_hidden_advanced_expanded');

    await _goHome(tester);
    await tester.binding.handlePopRoute();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_detail_add_exercise')),
    );
    await tester.binding.handlePopRoute();
    await _pumpUntilFound(tester, find.text('Criar treino'));
    await tester.pumpAndSettle();

    await tester.tap(_navigationDestination('Dashboard'));
    await _pumpUntilFound(tester, find.byTooltip('Definições'));
    expect(find.text('Dashboard'), findsWidgets);
    await _screenshot(binding, tester, 'v114_dashboard_return');
    await tester.tap(find.byTooltip('Definições'));
    await _pumpUntilFound(tester, find.text('Perfil ativo'));
    expect(find.text('Definições'), findsOneWidget);
    await _screenshot(binding, tester, 'v114_profile_settings');
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await _pumpUntilFound(tester, find.text('Dashboard'));

    await tester.tap(_navigationDestination('Objetivos'));
    await _pumpUntilFound(tester, find.text('Criar objetivo'));
    await _screenshot(binding, tester, 'v114_goals');
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
    _scenario('WAVE1_EXERCISE_RESULTS_FULL_APP_COMPLETE');
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

Future<void> _ensureDashboard(WidgetTester tester) async {
  final initialState = await _pumpUntilAny(tester, <String, Finder>{
    'setup': find.text('Configuração inicial'),
    'dashboard': find.text('Dashboard'),
    'profile_selection': _profileOptionFinder(),
  }, timeout: const Duration(minutes: 3));
  if (initialState == 'dashboard') return;

  if (initialState == 'profile_selection') {
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
    return;
  }

  await _tapVisible(tester, find.text('Começar'));
  await _pumpUntilFound(tester, find.byType(TextField));
  final fields = find.byType(TextField);
  expect(fields, findsNWidgets(5));
  await tester.enterText(fields.at(0), 'Full app selector profile');
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
  await _tapVisible(tester, find.widgetWithText(FilledButton, 'Criar perfil'));
  await _pumpUntilFound(tester, find.text('Dashboard'));
}

Future<void> _goHome(WidgetTester tester) async {
  await tester.tap(
    find.byKey(const ValueKey('workout_exercise_selector_home')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('workout_exercise_selector_contexts')),
  );
}

Future<void> _selectContextAndCapability(
  WidgetTester tester, {
  required String contextId,
  required String capabilityId,
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
}

Future<void> _selectPath(
  WidgetTester tester, {
  required String contextId,
  required String capabilityId,
  required String conceptId,
}) async {
  await _selectContextAndCapability(
    tester,
    contextId: contextId,
    capabilityId: capabilityId,
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

Future<void> _tapIntention(WidgetTester tester, Finder target) async {
  if (target.evaluate().isEmpty) {
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('training_intention_advanced_toggle')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('training_intention_advanced_group')),
    );
  }
  await _tapVisible(tester, target);
}

Future<void> _scrollToKey(WidgetTester tester, ValueKey<String> key) async {
  await _scrollUntilFound(tester, find.byKey(key));
}

Future<void> _scrollUntilFound(WidgetTester tester, Finder target) async {
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
