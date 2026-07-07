import '../../models/exercise.dart';

enum CatalogIssueSeverity { critical, warning }

class CatalogIssue {
  const CatalogIssue({
    required this.severity,
    required this.code,
    required this.message,
    this.exercise,
  });

  final CatalogIssueSeverity severity;
  final String code;
  final String message;
  final Exercise? exercise;

  bool get isCritical => severity == CatalogIssueSeverity.critical;

  Map<String, Object?> toJson() => {
    'severity': severity.name,
    'code': code,
    'message': message,
    if (exercise != null) 'name': exercise!.name,
    if (exercise != null) 'canonical_id': exercise!.canonicalId,
    if (exercise != null) 'catalog_entry_key': exercise!.catalogEntryKey,
    if (exercise != null) 'context_key': exercise!.contextKey,
  };

  @override
  String toString() {
    final prefix = exercise == null ? '' : '${exercise!.name}: ';
    return '[${severity.name}] $code - $prefix$message';
  }
}

class CatalogScenarioResult {
  const CatalogScenarioResult({
    required this.name,
    required this.count,
    required this.exerciseNames,
    this.expectedNames = const {},
    this.mustBeEmpty = false,
  });

  final String name;
  final int count;
  final List<String> exerciseNames;
  final Set<String> expectedNames;
  final bool mustBeEmpty;

  bool get passed => mustBeEmpty
      ? count == 0
      : count > 0 && expectedNames.every(exerciseNames.contains);

  Map<String, Object?> toJson() => {
    'name': name,
    'count': count,
    'passed': passed,
    'expected_names': expectedNames.toList()..sort(),
    'exercise_names': exerciseNames,
  };
}

class CatalogAuditResult {
  const CatalogAuditResult({
    required this.exercises,
    required this.issues,
    required this.scenarios,
    this.totalMatrix,
  });

  final List<Exercise> exercises;
  final List<CatalogIssue> issues;
  final List<CatalogScenarioResult> scenarios;
  final Object? totalMatrix;

  int get totalExercises => exercises.length;
  int get uniqueCanonicalIds =>
      exercises.map((exercise) => exercise.canonicalId).toSet().length;
  int get criticalCount => issues.where((issue) => issue.isCritical).length;
  int get warningCount => issues.length - criticalCount;
  bool get passed =>
      criticalCount == 0 && scenarios.every((scenario) => scenario.passed);

  Map<String, int> get countsByPrimaryType {
    final counts = <String, int>{};
    for (final exercise in exercises) {
      counts.update(
        exercise.primaryType,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }
    return counts;
  }

  Map<String, Object?> toJson() => {
    'total_exercises': totalExercises,
    'unique_canonical_ids': uniqueCanonicalIds,
    'critical_count': criticalCount,
    'warning_count': warningCount,
    'passed': passed,
    'counts_by_primary_type': countsByPrimaryType,
    'issues': issues.map((issue) => issue.toJson()).toList(),
    'scenarios': scenarios.map((scenario) => scenario.toJson()).toList(),
    if (totalMatrix != null) 'total_matrix': totalMatrix,
  };
}
