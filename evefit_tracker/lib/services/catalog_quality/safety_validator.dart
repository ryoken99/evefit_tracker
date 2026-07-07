import 'catalog_quality_models.dart';
import '../../models/exercise.dart';

class SafetyValidator {
  const SafetyValidator();

  List<CatalogIssue> validate(List<Exercise> exercises) {
    final issues = <CatalogIssue>[];
    for (final exercise in exercises) {
      final text = _n('${exercise.description} ${exercise.executionSteps}');
      if (exercise.primaryType == 'recuperacao' &&
          RegExp(r'\b(hiit|sprint|maxim[ao])\b').hasMatch(text)) {
        issues.add(
          CatalogIssue(
            severity: CatalogIssueSeverity.critical,
            code: 'unsafe_recovery_intensity',
            message:
                'recuperacao nao deve conter HIIT, sprint, sparring ou intensidade maxima.',
            exercise: exercise,
          ),
        );
      }
      if (exercise.primaryType == 'prevencao' &&
          _n(
            '${exercise.description} ${exercise.adaptationNotes}',
          ).contains('previne les')) {
        issues.add(
          CatalogIssue(
            severity: CatalogIssueSeverity.critical,
            code: 'prevention_overclaim',
            message: 'prevencao nao pode prometer prevenir lesoes.',
            exercise: exercise,
          ),
        );
      }
    }
    return issues;
  }

  static String _n(String value) => value.toLowerCase();
}
