import 'catalog_quality_models.dart';
import '../../models/exercise.dart';

class TaxonomyValidator {
  const TaxonomyValidator();

  static final _invalidMuscleLabels = {
    'ativacao',
    'ativação',
    'aquecimento',
    'recuperacao',
    'recuperação',
    'prevencao',
    'prevenção',
  };

  List<CatalogIssue> validate(List<Exercise> exercises) {
    final issues = <CatalogIssue>[];
    for (final exercise in exercises) {
      final group = _n(exercise.muscleGroup);
      if (_invalidMuscleLabels.contains(group)) {
        issues.add(
          CatalogIssue(
            severity: CatalogIssueSeverity.critical,
            code: 'invalid_muscle_label',
            message:
                'muscleGroup usa tipo de treino em vez de musculo/zona real.',
            exercise: exercise,
          ),
        );
      }
      if (exercise.primaryMuscleKey.trim().isEmpty) {
        issues.add(
          CatalogIssue(
            severity: CatalogIssueSeverity.warning,
            code: 'missing_primary_muscle_key',
            message: 'primary_muscle_key vazio; verifica taxonomia.',
            exercise: exercise,
          ),
        );
      }
    }
    return issues;
  }

  static String _n(String value) => value.toLowerCase().trim();
}
