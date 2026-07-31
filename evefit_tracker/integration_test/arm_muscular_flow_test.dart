import 'dart:io';

import 'package:evefit_tracker/main.dart' as app;
import 'package:flutter/foundation.dart' show FlutterError, FlutterErrorDetails;
import 'package:flutter/material.dart'
    show
        FilledButton,
        FocusManager,
        NavigationDestination,
        Scrollable,
        ScrollableState,
        TextField,
        ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/eft_landing_test_helper.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('full app opens the arm muscular anatomy flow', (tester) async {
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
    await _screenshot(binding, tester, 'dashboard');

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
    await _screenshot(binding, tester, 'workout_detail');

    await tester.tap(find.byKey(const ValueKey('workout_detail_add_exercise')));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_contexts')),
    );
    _expectNoLegacy();

    await _tapVisible(
      tester,
      find.byKey(
        const ValueKey('workout_exercise_selector_context_main_training'),
      ),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_capabilities')),
    );
    await _tapVisible(
      tester,
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
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_explore_anatomy')),
    );
    expect(
      find.byKey(
        const ValueKey('workout_exercise_selector_breadcrumb_context'),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const ValueKey('workout_exercise_selector_breadcrumb_capability'),
      ),
      findsOneWidget,
    );
    await _screenshot(binding, tester, 'muscular_anatomy_callout');

    final anatomyCallout = find.byKey(
      const ValueKey('workout_exercise_selector_explore_anatomy'),
    );
    await tester.ensureVisible(anatomyCallout);
    await tester.pumpAndSettle();
    final anatomyRoute = Stopwatch()..start();
    await tester.tap(anatomyCallout.hitTestable());
    await tester.pump();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('muscular_anatomy_browser_root')),
    );
    anatomyRoute.stop();
    expect(anatomyRoute.elapsedMilliseconds, lessThanOrEqualTo(300));
    // ignore: avoid_print
    print('ARM_MUSCULAR_ANATOMY_ROUTE_MS=${anatomyRoute.elapsedMilliseconds}');
    await _openBicepsResults(tester);
    await _screenshot(binding, tester, 'biceps_results');
    expect(
      find.byKey(const ValueKey('muscular_anatomy_exercise_preacher_curl')),
      findsOneWidget,
    );
    final preacherCurl = find.byKey(
      const ValueKey('muscular_anatomy_exercise_preacher_curl'),
    );
    await tester.ensureVisible(preacherCurl);
    await tester.pumpAndSettle();
    final exerciseDetail = Stopwatch()..start();
    await tester.tap(preacherCurl.hitTestable());
    await tester.pump();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('canonical_arm_exercise_detail_screen')),
    );
    exerciseDetail.stop();
    expect(exerciseDetail.elapsedMilliseconds, lessThanOrEqualTo(200));
    // ignore: avoid_print
    print(
      'ARM_MUSCULAR_EXERCISE_DETAIL_MS=${exerciseDetail.elapsedMilliseconds}',
    );
    await _screenshot(binding, tester, 'biceps_exercise_detail');
    await tester.binding.handlePopRoute();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('muscular_anatomy_results')),
    );

    await _goAnatomyHome(tester);
    await _openForearmFlexorResults(tester);
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('muscular_anatomy_exercise_dead_hang')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('canonical_arm_exercise_detail_screen')),
    );
    expect(
      find.byKey(const ValueKey('canonical_arm_exercise_detail_limit_notice')),
      findsOneWidget,
    );
    await _scrollToKey(
      tester,
      const ValueKey('canonical_arm_exercise_variant_towel_hang'),
    );
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('canonical_arm_exercise_variant_towel_hang')),
    );
    final detailScroll = tester.state<ScrollableState>(
      find.byType(Scrollable).last,
    );
    detailScroll.position.jumpTo(0);
    await tester.pumpAndSettle();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('canonical_arm_exercise_detail_variant_panel')),
    );
    await _screenshot(binding, tester, 'dead_hang_towel_variant');

    await tester.binding.handlePopRoute();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('muscular_anatomy_results')),
    );
    await _goAnatomyHome(tester);
    await _openCoracobrachialisEmpty(tester);
    expect(
      find.text(
        'Ainda não existem exercícios canónicos aprovados para esta seleção.',
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const ValueKey('muscular_anatomy_exercise_resisted_thumb_opposition'),
      ),
      findsNothing,
    );
    expect(find.textContaining('oposição resistida do polegar'), findsNothing);
    await _screenshot(binding, tester, 'coracobrachialis_empty');

    await tester.tap(
      find.byKey(const ValueKey('muscular_anatomy_browser_home')),
    );
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('muscular_anatomy_region_upper_body')),
    );
    await tester.binding.handlePopRoute();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_concepts')),
    );
    await tester.binding.handlePopRoute();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_capabilities')),
    );
    await tester.binding.handlePopRoute();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_exercise_selector_contexts')),
    );
    await tester.binding.handlePopRoute();
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('workout_detail_add_exercise')),
    );

    _expectNoLegacy();
    expect(
      capturedErrors.where(
        (details) => details.exception.toString().contains('multiple heroes'),
      ),
      isEmpty,
    );
    expect(capturedErrors, isEmpty);
    expect(tester.takeException(), isNull);
    // ignore: avoid_print
    print('ARM_MUSCULAR_FULL_APP_COMPLETE');
  });
}

Future<void> _openBicepsResults(WidgetTester tester) async {
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_upper_body')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_arm')),
  );
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_arm')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_group_anterior_arm')),
  );
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_group_anterior_arm')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_muscle_biceps_brachii')),
  );
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_muscle_biceps_brachii')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_results')),
  );
}

Future<void> _openForearmFlexorResults(WidgetTester tester) async {
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_upper_body')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_forearm')),
  );
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_forearm')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(
      const ValueKey('muscular_anatomy_group_anterior_forearm_intermediate'),
    ),
  );
  await _tapVisible(
    tester,
    find.byKey(
      const ValueKey('muscular_anatomy_group_anterior_forearm_intermediate'),
    ),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(
      const ValueKey('muscular_anatomy_muscle_flexor_digitorum_superficialis'),
    ),
  );
  await _tapVisible(
    tester,
    find.byKey(
      const ValueKey('muscular_anatomy_muscle_flexor_digitorum_superficialis'),
    ),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_results')),
  );
}

Future<void> _openCoracobrachialisEmpty(WidgetTester tester) async {
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_upper_body')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_arm')),
  );
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_arm')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_group_anterior_arm')),
  );
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_group_anterior_arm')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_muscle_coracobrachialis')),
  );
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_muscle_coracobrachialis')),
  );
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_results')),
  );
}

Future<void> _goAnatomyHome(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('muscular_anatomy_browser_home')));
  await tester.pumpAndSettle();
  await _pumpUntilFound(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_upper_body')),
  );
}

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
  await tester.enterText(fields.at(0), 'Arm muscular integration profile');
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
  for (final offset in const [Offset(0, -520), Offset(0, 520)]) {
    for (var attempt = 0; attempt <= maxScrolls; attempt++) {
      if (target.evaluate().isNotEmpty) {
        await tester.ensureVisible(target.last);
        await tester.pumpAndSettle();
        final hitTargets = target.hitTestable().evaluate().toList();
        if (hitTargets.isNotEmpty) {
          await tester.tap(target.hitTestable().last);
          await tester.pumpAndSettle();
          return;
        }
      }
      await tester.dragFrom(const Offset(224, 760), offset);
      await tester.pump(const Duration(milliseconds: 100));
    }
  }
  fail('Could not make the tap target visible within $maxScrolls scrolls.');
}

Future<void> _scrollToKey(WidgetTester tester, ValueKey<String> key) async {
  final target = find.byKey(key);
  for (final offset in const [Offset(0, -480), Offset(0, 480)]) {
    for (var attempt = 0; attempt < 18; attempt++) {
      if (target.evaluate().isNotEmpty) {
        await tester.ensureVisible(target);
        await tester.pumpAndSettle();
        return;
      }
      await tester.dragFrom(const Offset(224, 500), offset);
      await tester.pump(const Duration(milliseconds: 100));
    }
  }
  expect(target, findsOneWidget);
}

Future<void> _screenshot(
  IntegrationTestWidgetsFlutterBinding binding,
  WidgetTester tester,
  String name,
) async {
  await tester.pump();
  final image = await binding.takeScreenshot(name);
  expect(image, isNotEmpty);
  final directory = Directory('${Directory.systemTemp.path}/arm_muscular');
  await directory.create(recursive: true);
  final file = File('${directory.path}/$name.png');
  await file.writeAsBytes(image, flush: true);
  // ignore: avoid_print
  print('ARM_MUSCULAR_SCREENSHOT=$name|${file.path}');
}
