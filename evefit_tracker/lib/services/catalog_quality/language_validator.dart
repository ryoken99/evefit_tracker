import 'catalog_quality_models.dart';
import '../../models/exercise.dart';

class LanguageValidator {
  const LanguageValidator();

  static const _forbidden = {
    'activation',
    'adductors light',
    'target pattern',
    'referencia tecnica',
    'referência técnica',
    'zona trabalhada',
    'trajetoria curta',
    'trajetória curta',
    'intensidade conservadora',
    'nivel ajustado',
    'nível ajustado',
    'canonical_id',
    'catalog_entry_key',
  };

  List<CatalogIssue> validate(List<Exercise> exercises) {
    final issues = <CatalogIssue>[];
    for (final exercise in exercises) {
      final text = _n(
        [
          exercise.description,
          exercise.executionSteps,
          exercise.commonMistakes,
          exercise.safetyNotes,
          exercise.regression,
          exercise.progression,
          exercise.breathingTips,
          exercise.postureTips,
          exercise.adaptationNotes,
        ].join(' '),
      );
      for (final token in _forbidden) {
        if (text.contains(token)) {
          issues.add(
            CatalogIssue(
              severity: CatalogIssueSeverity.critical,
              code: 'forbidden_catalog_language',
              message: 'texto contem token generico proibido: $token',
              exercise: exercise,
            ),
          );
        }
      }
      if (RegExp(r'\b[a-z]+_[a-z0-9_]+\b').hasMatch(text)) {
        issues.add(
          CatalogIssue(
            severity: CatalogIssueSeverity.critical,
            code: 'internal_token_in_text',
            message: 'texto visivel contem token interno em snake_case.',
            exercise: exercise,
          ),
        );
      }
    }
    return issues;
  }

  static String _n(String value) => value.toLowerCase();
}
