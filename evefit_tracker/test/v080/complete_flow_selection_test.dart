import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'complete workout filters remain aggregate rather than fake muscles',
    () {
      const cases = <TrainingFlowSelection>[
        TrainingFlowSelection(
          typeKey: 'strength',
          regionKey: 'upper',
          groupKey: 'chest',
          subzoneKey: 'chest_complete',
        ),
        TrainingFlowSelection(
          typeKey: 'strength',
          regionKey: 'upper',
          groupKey: 'arms',
          subzoneKey: 'arms_complete',
        ),
        TrainingFlowSelection(
          typeKey: 'strength',
          regionKey: 'upper',
          groupKey: 'back',
          subzoneKey: 'back_complete',
        ),
        TrainingFlowSelection(
          typeKey: 'strength',
          regionKey: 'upper',
          groupKey: 'shoulders',
          subzoneKey: 'shoulders_complete',
        ),
        TrainingFlowSelection(
          typeKey: 'strength',
          regionKey: 'core',
          groupKey: 'core',
          subzoneKey: 'core_complete',
        ),
        TrainingFlowSelection(
          typeKey: 'strength',
          regionKey: 'lower',
          groupKey: 'legs',
          subzoneKey: 'legs_complete',
        ),
      ];

      for (final flow in cases) {
        final selection = TrainingFlow.toTrainingSelection(flow);
        expect(selection.subgroupKey, endsWith('_complete'));
        expect(selection.specificMuscleKey, isEmpty);
      }
    },
  );
}
