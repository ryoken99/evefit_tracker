import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('unknown hierarchy and equipment keys never resolve to first item', () {
    expect(TrainingArchitecture.regionNameFor('legacy-region'), 'Foco antigo');
    expect(TrainingArchitecture.groupNameFor('legacy-group'), 'Foco antigo');
    expect(
      TrainingArchitecture.subgroupNameFor('legacy-subgroup'),
      'Foco antigo',
    );
    expect(TrainingArchitecture.muscleNameFor('legacy-muscle'), 'Foco antigo');
    expect(
      TrainingArchitecture.equipmentNameFor('legacy-equipment'),
      'Equipamento removido',
    );
  });
}
