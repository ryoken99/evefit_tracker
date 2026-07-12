import 'package:evefit_tracker/features/canonical_search/screens/canonical_search_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpMenu(WidgetTester tester) =>
      tester.pumpWidget(const MaterialApp(home: CanonicalSearchMenuScreen()));

  Finder node(String id) => find.byKey(ValueKey('canonical_search_node_$id'));

  testWidgets('root presents eight capabilities and four usage contexts', (
    tester,
  ) async {
    await pumpMenu(tester);
    expect(find.text('Explorar exercícios'), findsWidgets);
    expect(
      find.byKey(const ValueKey('canonical_search_capabilities_section')),
      findsOneWidget,
    );
    expect(node('muscular_capacity'), findsOneWidget);
    await tester.scrollUntilVisible(node('breathing_regulation'), 260);
    expect(node('breathing_regulation'), findsOneWidget);
    await tester.scrollUntilVisible(node('warmup'), 260);
    expect(
      find.byKey(const ValueKey('canonical_search_contexts_section')),
      findsOneWidget,
    );
    expect(node('warmup'), findsOneWidget);
    expect(node('prevention_adaptation_return'), findsOneWidget);
    expect(find.text('Treino principal'), findsNothing);
    expect(find.text('Mostrar todos'), findsNothing);
  });

  testWidgets('cardio terminal shows breadcrumb and intentional empty state', (
    tester,
  ) async {
    await pumpMenu(tester);
    await tester.tap(node('cardio_conditioning'));
    await tester.pumpAndSettle();
    await tester.tap(node('cardio_conditioning_no_machines'));
    await tester.pumpAndSettle();
    await tester.tap(node('cardio_conditioning_no_machines_walk_run'));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('canonical_search_empty_state')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('canonical_search_empty_path')),
      findsOneWidget,
    );
    expect(
      find.text(
        'Cardio e condicionamento > Sem máquinas > Caminhada e corrida',
      ),
      findsOneWidget,
    );
    expect(
      find.text('Este catálogo está a ser construído por fases.'),
      findsOneWidget,
    );
    expect(find.text('Mostrar todos'), findsNothing);
  });

  testWidgets('context terminal supports breadcrumbs, home, and system back', (
    tester,
  ) async {
    await pumpMenu(tester);
    await tester.scrollUntilVisible(node('warmup'), 260);
    await tester.tap(node('warmup'));
    await tester.pumpAndSettle();
    await tester.tap(node('warmup_technical'));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(node('warmup_technical'), findsOneWidget);
    await tester.tap(node('warmup_technical'));
    await tester.pumpAndSettle();
    expect(node('warmup_technical_cardio_preparation'), findsOneWidget);
    await tester.tap(node('warmup_technical_cardio_preparation'));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_search_empty_state')),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const ValueKey('canonical_search_home')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('canonical_search_root_screen')),
      findsOneWidget,
    );
  });

  testWidgets(
    'prevention language is non-medical and narrow layouts do not overflow',
    (tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await pumpMenu(tester);
      await tester.scrollUntilVisible(
        node('prevention_adaptation_return'),
        260,
      );
      await tester.ensureVisible(node('prevention_adaptation_return'));
      await tester.pumpAndSettle();
      await tester.tap(node('prevention_adaptation_return'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        node('prevention_adaptation_return_tissue_conditioning'),
        220,
      );
      await tester.ensureVisible(
        node('prevention_adaptation_return_tissue_conditioning'),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        node('prevention_adaptation_return_tissue_conditioning'),
      );
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        node(
          'prevention_adaptation_return_tissue_conditioning_progressive_callusing',
        ),
        220,
      );
      await tester.ensureVisible(
        node(
          'prevention_adaptation_return_tissue_conditioning_progressive_callusing',
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        node(
          'prevention_adaptation_return_tissue_conditioning_progressive_callusing',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('diagnóstico'), findsNothing);
      expect(find.textContaining('tratamento'), findsNothing);
      expect(
        find.byKey(const ValueKey('canonical_search_empty_state')),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
