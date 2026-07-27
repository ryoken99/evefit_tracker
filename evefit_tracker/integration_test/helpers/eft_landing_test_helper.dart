import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> dismissEftLanding(
  WidgetTester tester, {
  Duration timeout = const Duration(seconds: 45),
}) async {
  final continueAction = find.byKey(const ValueKey('eft_landing_continue'));
  final deadline = DateTime.now().add(timeout);

  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (continueAction.evaluate().isNotEmpty) {
      await tester.tap(continueAction);
      await tester.pump(const Duration(milliseconds: 350));
      return;
    }
  }

  expect(continueAction, findsOneWidget);
}
