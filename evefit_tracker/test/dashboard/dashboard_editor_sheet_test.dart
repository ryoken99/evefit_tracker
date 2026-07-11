import 'package:evefit_tracker/models/dashboard_view_model.dart';
import 'package:evefit_tracker/widgets/dashboard_editor_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget host(
    List<DashboardEditorMetricOption> options,
    Future<void> Function(List<DashboardEditorMetricOption>) onSave,
  ) => MaterialApp(
    home: Builder(
      builder: (context) => Scaffold(
        body: FilledButton(
          onPressed: () => showModalBottomSheet<bool>(
            context: context,
            builder: (_) =>
                DashboardEditorSheet(options: options, onSave: onSave),
          ),
          child: const Text('Abrir editor'),
        ),
      ),
    ),
  );

  testWidgets('editor without goals has no metric toggles', (tester) async {
    await tester.pumpWidget(host(const [], (_) async {}));
    await tester.tap(find.text('Abrir editor'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Seleciona objetivos'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsNothing);
  });

  testWidgets(
    'editor saves only its allowed options and cancel does not save',
    (tester) async {
      List<DashboardEditorMetricOption>? saved;
      final options = const [
        DashboardEditorMetricOption(
          metricKey: 'weight',
          title: 'Peso atual',
          isEnabled: false,
          sortOrder: 0,
        ),
      ];
      await tester.pumpWidget(host(options, (value) async => saved = value));
      await tester.tap(find.text('Abrir editor'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(SwitchListTile));
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(saved, isNull);

      await tester.pumpWidget(host(options, (value) async => saved = value));
      await tester.tap(find.text('Abrir editor'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(SwitchListTile));
      await tester.tap(find.text('Guardar'));
      await tester.pumpAndSettle();
      expect(saved!.single.metricKey, 'weight');
      expect(saved!.single.isEnabled, isTrue);
    },
  );
}
