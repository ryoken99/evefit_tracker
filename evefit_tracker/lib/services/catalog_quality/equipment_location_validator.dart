import 'catalog_quality_models.dart';
import '../../models/exercise.dart';

class EquipmentLocationValidator {
  const EquipmentLocationValidator();

  List<CatalogIssue> validate(List<Exercise> exercises) {
    final issues = <CatalogIssue>[];
    for (final exercise in exercises) {
      if (exercise.equipment.trim().isEmpty || exercise.equipmentKeys.isEmpty) {
        issues.add(
          CatalogIssue(
            severity: CatalogIssueSeverity.critical,
            code: 'missing_equipment',
            message: 'equipamento textual ou canonical equipment vazio.',
            exercise: exercise,
          ),
        );
      }
      if (exercise.primaryType == 'cardio' &&
          exercise.name.toLowerCase().contains('passadeira') &&
          !exercise.equipmentKeys.contains('treadmill')) {
        issues.add(
          CatalogIssue(
            severity: CatalogIssueSeverity.critical,
            code: 'treadmill_without_treadmill_equipment',
            message: 'exercicio de passadeira sem equipmentKey treadmill.',
            exercise: exercise,
          ),
        );
      }
    }
    return issues;
  }
}
