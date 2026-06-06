import 'package:evefit_tracker/services/goal_progress_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('calculates increasing goal progress clamped to 100 percent', () {
    final progress = GoalProgressService.calculateProgress(
      initialValue: 30,
      currentValue: 35,
      targetValue: 34,
    );

    expect(progress, 1);
  });

  test('calculates decreasing goal progress', () {
    final progress = GoalProgressService.calculateProgress(
      initialValue: 80,
      currentValue: 76,
      targetValue: 72,
    );

    expect(progress, 0.5);
  });
}
