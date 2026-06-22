import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('refresh callbacks do not return a Future from setState', () {
    const screenPaths = <String>[
      'lib/screens/dashboard_screen.dart',
      'lib/screens/goals_screen.dart',
      'lib/screens/measurements_screen.dart',
      'lib/screens/photos_screen.dart',
      'lib/screens/workouts_screen.dart',
    ];

    for (final path in screenPaths) {
      final source = File(path).readAsStringSync();
      expect(
        source,
        isNot(contains('setState(() => _dataFuture =')),
        reason: '$path must use a block callback so setState returns void',
      );
    }
  });

  test('PIN dialog does not dispose its text state before route teardown', () {
    final source = File(
      'lib/screens/profile_gate_screen.dart',
    ).readAsStringSync();
    final unlockMethod = source.substring(
      source.indexOf('Future<void> _unlock'),
      source.indexOf('class _CreateFirstProfile'),
    );

    expect(
      unlockMethod,
      isNot(contains('final pin = TextEditingController();')),
    );
    expect(unlockMethod, isNot(contains('pin.dispose();')));
  });
}
