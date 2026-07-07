import 'catalog_quality_models.dart';
import '../../models/exercise.dart';

class FilterReachabilityValidator {
  const FilterReachabilityValidator();

  List<CatalogIssue> validate(List<Exercise> exercises) {
    final issues = <CatalogIssue>[];
    for (final exercise in exercises) {
      if (exercise.regionKeys.isEmpty || exercise.groupKeys.isEmpty) {
        issues.add(
          CatalogIssue(
            severity: CatalogIssueSeverity.critical,
            code: 'unreachable_filter_taxonomy',
            message: 'exercicio sem regionKeys/groupKeys para filtros.',
            exercise: exercise,
          ),
        );
      }
    }
    return issues;
  }
}
