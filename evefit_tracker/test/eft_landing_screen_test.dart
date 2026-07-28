import 'dart:ui' as ui;

import 'package:evefit_tracker/app.dart';
import 'package:evefit_tracker/screens/eft_landing_screen.dart';
import 'package:evefit_tracker/theme/eft_visual_identity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('landing presents the EFT identity and a full-screen action', (
    tester,
  ) async {
    var continuations = 0;
    final semantics = tester.ensureSemantics();

    await _pumpLanding(tester, onContinue: () => continuations += 1);

    expect(find.byKey(const ValueKey('eft_landing_screen')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('eft_landing_background_image')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('eft_landing_wordmark')), findsNothing);
    expect(find.text('EFT'), findsNothing);
    expect(find.text('Tocar para continuar'), findsOneWidget);
    final background = tester.widget<Image>(
      find.byKey(const ValueKey('eft_landing_background_image')),
    );
    expect(background.image, isA<AssetImage>());
    expect(
      (background.image as AssetImage).assetName,
      EftVisualIdentity.landingBackgroundAsset,
    );
    final actionSemantics = tester
        .getSemantics(find.byKey(const ValueKey('eft_landing_continue')))
        .getSemanticsData();
    expect(
      actionSemantics.label,
      'EFT. Tocar para continuar para a seleção de perfil',
    );
    expect(actionSemantics.flagsCollection.isButton, isTrue);
    expect(actionSemantics.hasAction(ui.SemanticsAction.tap), isTrue);
    expect(
      find.bySemanticsLabel(
        'EFT. Tocar para continuar para a seleção de perfil',
      ),
      findsOneWidget,
    );

    final actionSize = tester.getSize(
      find.byKey(const ValueKey('eft_landing_continue')),
    );
    final promptSize = tester.getSize(
      find.byKey(const ValueKey('eft_landing_continue_prompt')),
    );
    expect(actionSize.width, greaterThanOrEqualTo(48));
    expect(actionSize.height, greaterThanOrEqualTo(48));
    expect(promptSize.height, greaterThanOrEqualTo(48));

    await tester.tap(find.byKey(const ValueKey('eft_landing_continue')));
    await tester.tap(find.byKey(const ValueKey('eft_landing_continue')));
    expect(continuations, 1);
    semantics.dispose();
  });

  testWidgets(
    'real app starts at landing and transitions to the profile gate',
    (tester) async {
      await tester.pumpWidget(const EveFitApp());
      await tester.pump();

      expect(find.byKey(const ValueKey('eft_landing_screen')), findsOneWidget);
      expect(
        find.byKey(const ValueKey('profile_gate_background')),
        findsNothing,
      );

      await tester.tap(find.byKey(const ValueKey('eft_landing_continue')));
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('profile_gate_background')),
      );
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byKey(const ValueKey('eft_landing_screen')), findsNothing);
      expect(
        find.byKey(const ValueKey('profile_gate_background')),
        findsOneWidget,
      );
    },
  );

  testWidgets('landing remains legible without overflow across phone layouts', (
    tester,
  ) async {
    for (final scenario in const [
      (size: Size(320, 568), textScale: 1.0),
      (size: Size(390, 844), textScale: 1.3),
      (size: Size(448, 998), textScale: 2.0),
      (size: Size(640, 320), textScale: 1.3),
    ]) {
      tester.view.physicalSize = scenario.size;
      tester.view.devicePixelRatio = 1;
      await _pumpLanding(
        tester,
        onContinue: () {},
        textScale: scenario.textScale,
      );

      expect(
        find.byKey(const ValueKey('eft_landing_background_image')),
        findsOneWidget,
      );
      final image = tester.widget<Image>(
        find.byKey(const ValueKey('eft_landing_background_image')),
      );
      final landscape = scenario.size.width > scenario.size.height;
      expect(image.fit, landscape ? BoxFit.contain : BoxFit.cover);
      expect(
        find.byKey(const ValueKey('eft_landing_landscape_side_fill')),
        landscape ? findsOneWidget : findsNothing,
      );
      expect(find.text('Tocar para continuar'), findsOneWidget);
      expect(tester.takeException(), isNull);
    }

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('landing stops ambient motion when reduced motion is enabled', (
    tester,
  ) async {
    await _pumpLanding(tester, onContinue: () {}, disableAnimations: true);
    await tester.pump(const Duration(seconds: 1));

    expect(
      find.byKey(const ValueKey('eft_landing_background_image')),
      findsOneWidget,
    );
    expect(tester.binding.transientCallbackCount, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'profile gate remains active after background resume and layout rebuild',
    (tester) async {
      await tester.pumpWidget(const EveFitApp());
      await tester.pump();

      await tester.tap(find.byKey(const ValueKey('eft_landing_continue')));
      await _pumpUntilFound(
        tester,
        find.byKey(const ValueKey('profile_gate_background')),
      );
      await tester.pump(const Duration(milliseconds: 300));

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pump();
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();

      tester.view.physicalSize = const Size(640, 320);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pump();

      expect(find.byKey(const ValueKey('eft_landing_screen')), findsNothing);
      expect(
        find.byKey(const ValueKey('profile_gate_background')),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );

  test('local visual identity keeps readable composite contrast', () {
    final backgroundColors = {
      ...EftVisualIdentity.landingGradient.colors,
      ...EftVisualIdentity.profileGradient.colors,
    };

    for (final background in backgroundColors) {
      final surface = Color.alphaBlend(EftVisualIdentity.surface, background);
      final cardSurface = Color.alphaBlend(
        EftVisualIdentity.cardSurface,
        background,
      );
      expect(
        _contrastRatio(EftVisualIdentity.foreground, surface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrastRatio(EftVisualIdentity.secondaryForeground, surface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrastRatio(EftVisualIdentity.foreground, cardSurface),
        greaterThanOrEqualTo(4.5),
      );
    }
  });
}

Future<void> _pumpLanding(
  WidgetTester tester, {
  required VoidCallback onContinue,
  double textScale = 1,
  bool disableAnimations = false,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(
          size: tester.view.physicalSize,
          devicePixelRatio: tester.view.devicePixelRatio,
          textScaler: TextScaler.linear(textScale),
          disableAnimations: disableAnimations,
        ),
        child: EftLandingScreen(onContinue: onContinue),
      ),
    ),
  );
  await tester.pump();
}

Future<void> _pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 100; attempt++) {
    await tester.pump(const Duration(milliseconds: 20));
    if (finder.evaluate().isNotEmpty) return;
  }
  expect(finder, findsOneWidget);
}

double _contrastRatio(Color foreground, Color background) {
  final light = foreground.computeLuminance();
  final dark = background.computeLuminance();
  final brightest = light > dark ? light : dark;
  final darkest = light > dark ? dark : light;
  return (brightest + 0.05) / (darkest + 0.05);
}
