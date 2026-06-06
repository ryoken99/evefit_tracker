import 'package:evefit_tracker/services/goal_progress_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('calcula progresso de objetivo semanal por frequência', () {
    final progress = GoalProgressService.calculateFrequencyProgress(
      completed: 3,
      target: 4,
    );

    expect(progress, 0.75);
  });

  test(
    'objetivo manual aceita percentagem de 0 a 100 convertida para 0 a 1',
    () {
      final progress = GoalProgressService.calculateManualPercent(65);

      expect(progress, 0.65);
    },
  );
}
