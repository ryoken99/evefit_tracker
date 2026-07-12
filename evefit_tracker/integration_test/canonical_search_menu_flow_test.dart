import 'package:evefit_tracker/features/canonical_search/screens/canonical_search_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Canonical search menu renders its intentional empty routes', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const CanonicalSearchMenuScreen(),
      ),
    );
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();

    _scenario('canonical_root');
    expect(
      find.byKey(const ValueKey('canonical_search_root_screen')),
      findsOneWidget,
    );
    expect(find.text('Mostrar todos'), findsNothing);
    await _screenshot(binding, tester, 'canonical_root');

    await _selectPath(tester, const [
      'cardio_conditioning',
      'cardio_conditioning_no_machines',
      'cardio_conditioning_no_machines_walk_run',
    ]);
    _scenario('canonical_cardio_terminal');
    expect(find.textContaining('Cardio e condicionamento'), findsWidgets);
    expect(
      find.byKey(const ValueKey('canonical_search_empty_path')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('canonical_search_empty_state')),
      findsOneWidget,
    );
    expect(find.text('Mostrar todos'), findsNothing);
    await _screenshot(binding, tester, 'canonical_cardio_terminal');

    await tester.tap(find.byKey(const ValueKey('canonical_search_home')));
    await tester.pumpAndSettle();
    await _scrollTo(tester, 'warmup');
    await _selectPath(tester, const [
      'warmup',
      'warmup_technical',
      'warmup_technical_cardio_preparation',
    ]);
    _scenario('canonical_warmup_terminal');
    expect(
      find.byKey(const ValueKey('canonical_search_empty_state')),
      findsOneWidget,
    );
    await _screenshot(binding, tester, 'canonical_warmup_terminal');

    await tester.tap(find.byKey(const ValueKey('canonical_search_back')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(
        const ValueKey(
          'canonical_search_node_warmup_technical_cardio_preparation',
        ),
      ),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const ValueKey('canonical_search_home')));
    await tester.pumpAndSettle();
    await _scrollTo(tester, 'prevention_adaptation_return');
    await _selectPath(tester, const [
      'prevention_adaptation_return',
      'prevention_adaptation_return_tissue_conditioning',
      'prevention_adaptation_return_tissue_conditioning_progressive_callusing',
    ]);
    _scenario('canonical_prevention_terminal');
    expect(
      find.byKey(const ValueKey('canonical_search_empty_state')),
      findsOneWidget,
    );
    expect(find.text('Mostrar todos'), findsNothing);
    await _screenshot(binding, tester, 'canonical_prevention_terminal');
  });
}

Future<void> _selectPath(WidgetTester tester, List<String> ids) async {
  for (final id in ids) {
    await _scrollTo(tester, id);
    await tester.tap(find.byKey(ValueKey('canonical_search_node_$id')));
    await tester.pumpAndSettle();
  }
}

Future<void> _scrollTo(WidgetTester tester, String id) async {
  final target = find.byKey(ValueKey('canonical_search_node_$id'));
  if (target.evaluate().isEmpty) {
    await tester.scrollUntilVisible(target, 260);
  }
  await tester.ensureVisible(target);
  await tester.pumpAndSettle();
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
  print('CANONICAL_SEARCH_INTEGRATION_SCENARIO=$name');
}
