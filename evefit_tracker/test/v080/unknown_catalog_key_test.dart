import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/dashboard_metric_service.dart';
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

  test('unknown dashboard metric is labelled as removed', () {
    final definition = DashboardMetricService.definitionFor('legacy-metric');
    expect(definition.key, 'legacy-metric');
    expect(definition.title, 'Métrica removida');
  });

  test('canonical complete filters have stable display labels', () {
    expect(
      TrainingArchitecture.subgroupNameFor('chest_complete'),
      'Peito completo',
    );
    expect(
      TrainingArchitecture.subgroupNameFor('arms_complete'),
      'Braços completos',
    );
    expect(
      TrainingArchitecture.subgroupNameFor('back_complete'),
      'Costas completas',
    );
    expect(
      TrainingArchitecture.subgroupNameFor('shoulders_complete'),
      'Ombros completos',
    );
    expect(
      TrainingArchitecture.subgroupNameFor('core_complete'),
      'Core completo',
    );
    expect(
      TrainingArchitecture.subgroupNameFor('legs_complete'),
      'Pernas completas',
    );
  });

  test('persisted aggregate selections render without legacy placeholders', () {
    expect(
      TrainingArchitecture.summaryForSelection(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'arms',
          subgroupKey: 'arms_complete',
          specificMuscleKey: 'arms_complete',
          equipmentKey: 'bodyweight',
        ),
      ),
      'Parte superior, Braços, Braços completos, Peso corporal',
    );
  });
}
