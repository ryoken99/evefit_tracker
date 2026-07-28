import 'dart:async';

import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/profile.dart';
import 'package:evefit_tracker/screens/profile_gate_screen.dart';
import 'package:evefit_tracker/services/pin_service.dart';
import 'package:evefit_tracker/theme/app_theme.dart';
import 'package:evefit_tracker/theme/eft_visual_identity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'profile gate uses the coordinated PCB background and readable scrim',
    (tester) async {
      final profile = _profile();

      await _pumpGate(tester, profiles: [profile]);

      final background = tester.widget<Image>(
        find.byKey(const ValueKey('profile_gate_background_image')),
      );
      expect(background.image, isA<AssetImage>());
      expect(
        (background.image as AssetImage).assetName,
        EftVisualIdentity.profileBackgroundAsset,
      );
      expect(background.fit, BoxFit.cover);
      expect(
        find.byKey(const ValueKey('profile_gate_background_scrim')),
        findsOneWidget,
      );
      expect(find.text('Escolher perfil'), findsOneWidget);
      expect(find.byKey(const ValueKey('profile_option_1')), findsOneWidget);

      final profileTarget = tester.getSize(
        find.byKey(const ValueKey('profile_option_1')),
      );
      final createTarget = tester.getSize(
        find.widgetWithText(OutlinedButton, 'Criar novo perfil'),
      );
      expect(profileTarget.height, greaterThanOrEqualTo(48));
      expect(createTarget.height, greaterThanOrEqualTo(48));
    },
  );

  testWidgets(
    'loading, error, and empty states retain the localized background',
    (tester) async {
      final pending = Completer<List<Profile>>();
      await _pumpGate(tester, loader: () => pending.future);
      expect(find.text('Escolher perfil'), findsOneWidget);
      expect(find.text('A preparar os perfis...'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      _expectBackground();

      var loadAttempts = 0;
      await _pumpGate(
        tester,
        loader: () {
          loadAttempts += 1;
          if (loadAttempts == 1) {
            return Future<List<Profile>>.error(StateError('boom'));
          }
          return Future<List<Profile>>.value(const []);
        },
      );
      await tester.pump();
      expect(find.text('Não foi possível carregar os perfis.'), findsOneWidget);
      expect(find.text('Tentar novamente'), findsOneWidget);
      _expectBackground();

      await tester.tap(find.text('Tentar novamente'));
      await tester.pumpAndSettle();
      expect(loadAttempts, 2);
      expect(find.text('Configuração inicial'), findsOneWidget);
      expect(find.text('Começar'), findsOneWidget);
      _expectBackground();
    },
  );

  testWidgets('profile card preserves incorrect PIN behavior', (tester) async {
    Profile? unlocked;
    final profile = _profile(id: null);

    await _pumpGate(
      tester,
      profiles: [profile],
      onUnlocked: (profile) => unlocked = profile,
    );

    await tester.tap(find.byKey(const ValueKey('profile_option_null')));
    await _pumpUntilFound(
      tester,
      find.byKey(const ValueKey('profile_unlock_pin')),
    );
    await tester.enterText(
      find.byKey(const ValueKey('profile_unlock_pin')),
      '0000',
    );
    await tester.tap(find.byKey(const ValueKey('profile_unlock_submit')));
    await _pumpUntilFound(tester, find.text('Código incorreto.'));

    expect(find.text('Código incorreto.'), findsOneWidget);
    expect(unlocked, isNull);
  });

  testWidgets('create profile action still opens the existing sheet', (
    tester,
  ) async {
    await _pumpGate(tester, profiles: [_profile()]);

    await tester.tap(find.text('Criar novo perfil'));
    await tester.pumpAndSettle();

    expect(find.text('Passo 1 de 4'), findsOneWidget);
    expect(find.text('Nome do perfil'), findsOneWidget);
    expect(find.text('PIN de 4 dígitos'), findsOneWidget);
  });

  testWidgets('narrow viewport and enlarged text remain scrollable', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final profiles = List<Profile>.generate(
      8,
      (index) => _profile(
        id: index + 1,
        name: 'Perfil de validação com nome extenso ${index + 1}',
      ),
    );
    await _pumpGate(tester, profiles: profiles, textScale: 2);

    await tester.scrollUntilVisible(
      find.text('Criar novo perfil'),
      400,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Criar novo perfil'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('landscape viewport remains scrollable without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(640, 320);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final profiles = List<Profile>.generate(
      3,
      (index) => _profile(
        id: index + 1,
        name: 'Perfil horizontal com nome extenso ${index + 1}',
      ),
    );
    await _pumpGate(tester, profiles: profiles, textScale: 1.3);

    await tester.scrollUntilVisible(
      find.text('Criar novo perfil'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Criar novo perfil'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpGate(
  WidgetTester tester, {
  AppDatabase? database,
  List<Profile>? profiles,
  Future<List<Profile>> Function()? loader,
  ValueChanged<Profile>? onUnlocked,
  double textScale = 1,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.dark(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: ProfileGateScreen(
        key: UniqueKey(),
        database: database ?? AppDatabase.instance,
        profilesLoader: loader ?? () async => profiles ?? const [],
        onUnlocked: onUnlocked ?? (_) {},
      ),
    ),
  );
  await tester.pump();
  if (loader == null) await tester.pumpAndSettle();
}

void _expectBackground() {
  expect(find.byKey(const ValueKey('profile_gate_background')), findsOneWidget);
}

Future<void> _pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 100; attempt++) {
    await tester.pump(const Duration(milliseconds: 20));
    if (finder.evaluate().isNotEmpty) return;
  }
  expect(finder, findsOneWidget);
}

Profile _profile({int? id = 1, String name = 'Perfil de teste'}) {
  final now = DateTime(2026, 7, 26);
  return Profile(
    id: id,
    name: name,
    pinHash: PinService.hashPin('1234'),
    createdAt: now,
    updatedAt: now,
    isActive: false,
    trainingLocation: 'Ginásio',
  );
}
