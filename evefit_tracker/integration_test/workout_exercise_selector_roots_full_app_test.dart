import 'dart:io';

import 'package:evefit_tracker/main.dart' as app;
import 'package:flutter/foundation.dart' show FlutterError, FlutterErrorDetails;
import 'package:flutter/material.dart'
    show FocusManager, NavigationDestination, TextField, ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('workout exercise selector follows the canonical hierarchy', (
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
    await _screenshot(binding, tester, 'hierarchical_initial_setup');

    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextField);
    expect(fields, findsNWidgets(5));
    await tester.enterText(fields.at(0), 'Hierarchical search integration');
    await tester.enterText(fields.at(1), '1234');
    await tester.enterText(fields.at(2), '1234');
    FocusManager.instance.primaryFocus?.unfocus();
    await _tapVisibleText(tester, 'Continuar');
    await _tapVisibleText(tester, 'Continuar');
    await _tapVisibleText(tester, 'Continuar');
    await _tapVisibleText(tester, 'Criar perfil');

    await _pumpUntilFound(tester, find.text('Dashboard'));
    await _screenshot(binding, tester, 'hierarchical_dashboard');

    await tester.tap(_navigationDestination('Treinos'));
    await _pumpUntilFound(tester, find.text('Criar treino'));
    await tester.tap(find.text('Criar treino'));
    await _pumpUntilFound(tester, find.text('Guardar treino'));
    await _tapVisibleText(tester, 'Guardar treino');
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_detail_add_exercise')),
    );
    await _screenshot(binding, tester, 'hierarchical_workout_detail');

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
    for (final id in _capabilityIds) {
      expect(
        find.byKey(ValueKey('workout_exercise_selector_capability_$id')),
        findsNothing,
      );
    }
    _expectNoLegacyOrSublevels();
    await _screenshot(binding, tester, 'hierarchical_five_contexts');

    await _scrollToKey(
      tester,
      const ValueKey('workout_exercise_selector_context_warmup'),
      towardStart: true,
    );
    final contextTimer = Stopwatch()..start();
    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_context_warmup')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_capabilities')),
    );
    contextTimer.stop();
    _metric('CONTEXT_TO_CAPABILITY_MS', contextTimer.elapsedMilliseconds);

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
    await _screenshot(binding, tester, 'hierarchical_eight_capabilities');

    await _scrollToKey(
      tester,
      const ValueKey(
        'workout_exercise_selector_capability_cardio_conditioning',
      ),
      towardStart: true,
    );
    final capabilityTimer = Stopwatch()..start();
    await tester.tap(
      find.byKey(
        const ValueKey(
          'workout_exercise_selector_capability_cardio_conditioning',
        ),
      ),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_concepts')),
    );
    capabilityTimer.stop();
    _metric('CAPABILITY_TO_CONCEPTS_MS', capabilityTimer.elapsedMilliseconds);

    expect(_conceptCards(), findsNWidgets(5));
    for (final conceptId in _conceptIdsByCapability['cardio_conditioning']!) {
      expect(
        find.byKey(ValueKey('workout_exercise_selector_concept_$conceptId')),
        findsOneWidget,
      );
    }
    await _screenshot(binding, tester, 'hierarchical_warmup_cardio_concepts');
    await tester.tap(
      find.byKey(
        const ValueKey('workout_exercise_selector_concept_cyclic_locomotion'),
      ),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_intention_empty')),
    );
    expect(
      find.text('Ainda não existem intenções de treino aprovadas.'),
      findsOneWidget,
    );
    expect(find.text('Aquecimento'), findsWidgets);
    expect(find.text('Cardio e condicionamento'), findsWidgets);
    expect(find.text('Locomoção cíclica'), findsWidgets);
    expect(find.textContaining('Aquecimento\n> Cardio'), findsOneWidget);
    expect(find.textContaining('> Locomoção cíclica'), findsOneWidget);
    _expectNoLegacyOrSublevels();
    await _screenshot(
      binding,
      tester,
      'hierarchical_warmup_cardio_intention_empty',
    );

    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_back')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_concepts')),
    );
    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_back')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_capabilities')),
    );

    for (final capabilityId in _capabilityIds.where(
      (id) => id != 'cardio_conditioning',
    )) {
      await _scrollToKey(
        tester,
        ValueKey('workout_exercise_selector_capability_$capabilityId'),
      );
      await tester.tap(
        find.byKey(
          ValueKey('workout_exercise_selector_capability_$capabilityId'),
        ),
      );
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('workout_exercise_selector_concepts')),
      );
      final expectedConceptIds = _conceptIdsByCapability[capabilityId]!;
      expect(_conceptCards(), findsNWidgets(expectedConceptIds.length));
      for (final conceptId in expectedConceptIds) {
        await _scrollToKey(
          tester,
          ValueKey('workout_exercise_selector_concept_$conceptId'),
        );
        expect(
          find.byKey(ValueKey('workout_exercise_selector_concept_$conceptId')),
          findsOneWidget,
        );
      }
      _expectNoLegacyOrSublevels();
      await tester.tap(
        find.byKey(const ValueKey('workout_exercise_selector_back')),
      );
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('workout_exercise_selector_capabilities')),
      );
    }

    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_back')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_contexts')),
    );

    await _scrollToKey(
      tester,
      const ValueKey('workout_exercise_selector_context_main_training'),
      towardStart: true,
    );
    await tester.tap(
      find.byKey(
        const ValueKey('workout_exercise_selector_context_main_training'),
      ),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_capabilities')),
    );
    await _scrollToKey(
      tester,
      const ValueKey('workout_exercise_selector_capability_muscular_capacity'),
      towardStart: true,
    );
    await tester.tap(
      find.byKey(
        const ValueKey(
          'workout_exercise_selector_capability_muscular_capacity',
        ),
      ),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_concepts')),
    );
    expect(_conceptCards(), findsNWidgets(4));
    await tester.tap(
      find.byKey(
        const ValueKey('workout_exercise_selector_concept_overcome_resistance'),
      ),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_intention_empty')),
    );
    expect(find.text('Treino principal'), findsWidgets);
    expect(find.text('Força e capacidade muscular'), findsWidgets);
    expect(find.text('Vencer resistência'), findsWidgets);
    expect(find.textContaining('Treino principal\n> Força'), findsOneWidget);
    _expectNoLegacyOrSublevels();
    await _screenshot(
      binding,
      tester,
      'hierarchical_main_strength_intention_empty',
    );

    await tester.tap(
      find.byKey(const ValueKey('workout_exercise_selector_home')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_contexts')),
    );
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_detail_add_exercise')),
    );
    await _screenshot(binding, tester, 'hierarchical_returned_to_workout');

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await _pumpUntilFound(tester, find.text('Criar treino'));

    await tester.tap(_navigationDestination('Dashboard'));
    await _pumpUntilFound(tester, find.byTooltip('Definições'));
    await _screenshot(binding, tester, 'hierarchical_dashboard_return');
    await tester.tap(find.byTooltip('Definições'));
    await _pumpUntilFound(tester, find.text('Perfil ativo'));
    expect(find.text('Definições'), findsOneWidget);
    await _screenshot(binding, tester, 'hierarchical_profile_settings');
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    await tester.tap(_navigationDestination('Objetivos'));
    await _pumpUntilFound(tester, find.text('Criar objetivo'));
    await _screenshot(binding, tester, 'hierarchical_goals');
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
    _scenario('HIERARCHICAL_CANONICAL_EXERCISE_SEARCH_FULL_APP_COMPLETE');
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
  'main_training',
  'warmup',
  'activation',
  'recovery_cooldown',
  'prevention_adaptation_return',
];

const _conceptIdsByCapability = <String, List<String>>{
  'muscular_capacity': [
    'overcome_resistance',
    'control_resistance',
    'sustain_resistance',
    'loaded_carry',
  ],
  'cardio_conditioning': [
    'cyclic_locomotion',
    'cyclic_propulsion',
    'repetitive_rhythmic_movement',
    'repeated_multidirectional_displacement',
    'repeated_motor_sequence',
  ],
  'speed_power': [
    'explosive_acceleration',
    'ballistic_projection',
    'elastic_reactive_action',
    'braking_redirection',
    'cyclic_locomotion',
    'repeated_multidirectional_displacement',
  ],
  'mobility': [
    'active_joint_exploration',
    'range_transition',
    'integrated_chain_mobility',
    'supported_loaded_mobility',
    'segmental_dissociation',
  ],
  'flexibility': [
    'sustained_lengthening',
    'dynamic_lengthening',
    'assisted_lengthening',
  ],
  'motor_control_coordination': [
    'postural_stabilization',
    'base_of_support_control',
    'rhythm_synchronization',
    'reactive_adjustment',
    'segmental_dissociation',
    'repeated_motor_sequence',
  ],
  'technique_skill': [
    'isolated_technical_practice',
    'contextual_technical_application',
    'target_oriented_precision',
    'stimulus_response_decision',
    'technical_variability_adaptation',
    'repeated_motor_sequence',
  ],
  'breathing_regulation': [
    'voluntary_breath_cycle_control',
    'breath_movement_synchronization',
    'internal_pressure_management',
    'autonomic_modulation',
    'interoceptive_monitoring_adjustment',
  ],
};

Finder _conceptCards() => find.byWidgetPredicate(
  (widget) =>
      widget.key is ValueKey<String> &&
      (widget.key! as ValueKey<String>).value.startsWith(
        'workout_exercise_selector_concept_',
      ),
  description: 'canonical concept cards',
);

void _expectNoLegacyOrSublevels() {
  expect(find.text('Sem máquinas'), findsNothing);
  expect(find.text('Caminhada e corrida'), findsNothing);
  expect(find.text('Mostrar todos'), findsNothing);
  expect(find.text('Hipertrofia'), findsNothing);
  expect(find.text('Exercício recomendado'), findsNothing);
  expect(find.text('Resultados: 0'), findsNothing);
}

Future<void> _scrollToKey(
  WidgetTester tester,
  ValueKey<String> key, {
  bool towardStart = false,
}) async {
  final target = find.byKey(key);
  for (var attempt = 0; attempt < 18; attempt++) {
    if (target.evaluate().isNotEmpty) {
      final center = tester.getCenter(target);
      if (center.dy > 80 && center.dy < 920) return;
    }
    await tester.dragFrom(
      const Offset(224, 760),
      Offset(0, towardStart ? 480 : -480),
    );
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
