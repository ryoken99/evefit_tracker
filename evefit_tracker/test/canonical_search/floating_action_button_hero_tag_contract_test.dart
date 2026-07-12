import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const expectedTags = <String, String>{
    'lib/screens/goals_screen.dart': 'goals_add_fab',
    'lib/screens/measurements_screen.dart': 'measurements_add_fab',
    'lib/screens/photos_screen.dart': 'photos_add_fab',
    'lib/screens/workout_detail_screen.dart': 'workout_detail_add_exercise_fab',
  };

  test('all app FloatingActionButtons use explicit unique hero tags', () {
    final foundTags = <String>[];

    for (final entry in expectedTags.entries) {
      final source = File(entry.key).readAsStringSync();
      expect(source, contains('FloatingActionButton'));
      expect(source, contains("heroTag: '${entry.value}'"));
      foundTags.add(entry.value);
    }

    expect(foundTags.toSet().length, foundTags.length);
  });
}
