import 'catalog_quality_models.dart';
import '../../models/exercise.dart';

class ContentQualityValidator {
  const ContentQualityValidator();

  List<CatalogIssue> validate(List<Exercise> exercises) {
    final issues = <CatalogIssue>[];
    for (final exercise in exercises) {
      if (exercise.description.trim().length < 80) {
        issues.add(
          _critical(
            'description_too_short',
            exercise,
            'descricao curta ou generica demais.',
          ),
        );
      }
      if (_stepCount(exercise.executionSteps) < 4) {
        issues.add(
          _critical(
            'execution_steps_missing',
            exercise,
            'execucao precisa de pelo menos 4 passos claros.',
          ),
        );
      }
      if (exercise.breathingTips.trim().isEmpty) {
        issues.add(
          _critical('missing_breathing', exercise, 'respiracao vazia.'),
        );
      }
      if (exercise.commonMistakes.trim().isEmpty) {
        issues.add(
          _critical(
            'missing_common_mistakes',
            exercise,
            'erros comuns vazios.',
          ),
        );
      }
      if (exercise.safetyNotes.trim().isEmpty) {
        issues.add(_critical('missing_safety', exercise, 'cuidados vazios.'));
      }
      if (exercise.regression.trim().isEmpty) {
        issues.add(
          _critical('missing_regression', exercise, 'regressao vazia.'),
        );
      }
      if (exercise.progression.trim().isEmpty) {
        issues.add(
          _critical('missing_progression', exercise, 'progressao vazia.'),
        );
      }
      if (exercise.adaptationNotes.trim().isEmpty) {
        issues.add(
          _critical(
            'missing_when_avoid',
            exercise,
            'quando evitar/adaptar vazio.',
          ),
        );
      }
    }
    return issues;
  }

  static int _stepCount(String value) =>
      RegExp(r'(^|\n)\s*\d+[.)]').allMatches(value).length;

  CatalogIssue _critical(String code, Exercise exercise, String message) =>
      CatalogIssue(
        severity: CatalogIssueSeverity.critical,
        code: code,
        message: message,
        exercise: exercise,
      );
}
