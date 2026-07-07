import 'catalog_quality_models.dart';
import '../../models/exercise.dart';

class CanonicalIdentityValidator {
  const CanonicalIdentityValidator();

  List<CatalogIssue> validate(List<Exercise> exercises) {
    final issues = <CatalogIssue>[];
    final catalogKeys = <String>{};
    for (final exercise in exercises) {
      if (exercise.canonicalId.trim().isEmpty) {
        issues.add(
          _critical('missing_canonical_id', exercise, 'canonical_id vazio.'),
        );
      }
      if (exercise.catalogEntryKey.trim().isEmpty) {
        issues.add(
          _critical(
            'missing_catalog_entry_key',
            exercise,
            'catalog_entry_key vazio.',
          ),
        );
      } else if (!catalogKeys.add(exercise.catalogEntryKey)) {
        issues.add(
          _critical(
            'duplicate_catalog_entry_key',
            exercise,
            'catalog_entry_key duplicado.',
          ),
        );
      }
      if (exercise.exerciseKey.trim().isEmpty) {
        issues.add(
          _critical('missing_exercise_key', exercise, 'exercise_key vazio.'),
        );
      }
      if (exercise.contextKey.trim().isEmpty) {
        issues.add(
          _critical('missing_context_key', exercise, 'context_key vazio.'),
        );
      }
      if (exercise.primaryType.trim().isEmpty) {
        issues.add(
          _critical('missing_primary_type', exercise, 'primary_type vazio.'),
        );
      }
      if (exercise.aliases.isEmpty ||
          !exercise.aliases.contains(exercise.exerciseKey)) {
        issues.add(
          _critical(
            'missing_legacy_alias',
            exercise,
            'aliases nao preservam exercise_key antigo.',
          ),
        );
      }
    }
    return issues;
  }

  CatalogIssue _critical(String code, Exercise exercise, String message) =>
      CatalogIssue(
        severity: CatalogIssueSeverity.critical,
        code: code,
        message: message,
        exercise: exercise,
      );
}
