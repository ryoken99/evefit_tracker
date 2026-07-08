import 'dart:convert';
import 'dart:io';

import '../../models/exercise.dart';
import '../exercise_catalog_context_service.dart';
import '../exercise_taxonomy_service.dart';
import 'canonical_identity_validator.dart';
import 'catalog_quality_models.dart';
import 'content_quality_validator.dart';
import 'equipment_location_validator.dart';
import 'filter_reachability_validator.dart';
import 'language_validator.dart';
import 'safety_validator.dart';
import 'scenario_matrix_validator.dart';
import 'catalog_total_matrix_audit.dart';
import 'taxonomy_validator.dart';

class CatalogQualityAudit {
  const CatalogQualityAudit._();

  static List<Exercise> currentExercises() => ExerciseCatalogContextService
      .entries
      .map(ExerciseTaxonomyService.enrichCatalogExercise)
      .toList(growable: false);

  static CatalogAuditResult run({bool writeReports = false}) {
    final exercises = currentExercises();
    final scenarioValidator = ScenarioMatrixValidator();
    final totalMatrix = CatalogTotalMatrixAudit.run();
    final issues = <CatalogIssue>[
      ...const CanonicalIdentityValidator().validate(exercises),
      ...const TaxonomyValidator().validate(exercises),
      ...const EquipmentLocationValidator().validate(exercises),
      ...const FilterReachabilityValidator().validate(exercises),
      ...const ContentQualityValidator().validate(exercises),
      ...const SafetyValidator().validate(exercises),
      ...const LanguageValidator().validate(exercises),
      ...scenarioValidator.validate(exercises),
    ];
    final result = CatalogAuditResult(
      exercises: exercises,
      issues: issues,
      scenarios: scenarioValidator.run(exercises),
      totalMatrix: totalMatrix.toJson(),
    );
    if (writeReports) writeAllReports(result);
    return result;
  }

  static void writeAllReports(CatalogAuditResult result) {
    final reportsDir = Directory('build/reports')..createSync(recursive: true);
    File(
      '${reportsDir.path}/catalog_audit.md',
    ).writeAsStringSync(_auditMarkdown(result));
    File('${reportsDir.path}/catalog_audit.json').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(result.toJson()),
    );
    File(
      '${reportsDir.path}/catalog_inventory.md',
    ).writeAsStringSync(_inventoryMarkdown(result.exercises, result.issues));
    File(
      '${reportsDir.path}/catalog_inventory.csv',
    ).writeAsStringSync(_inventoryCsv(result.exercises, result.issues));
    File('${reportsDir.path}/catalog_inventory.json').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(
        result.exercises
            .map((exercise) => _inventoryJson(exercise, result.issues))
            .toList(),
      ),
    );
    File(
      '${reportsDir.path}/catalog_gap_analysis.md',
    ).writeAsStringSync(_gapAnalysisMarkdown(result));
    CatalogTotalMatrixAudit.writeReportsFor(CatalogTotalMatrixAudit.run());
  }

  static String _auditMarkdown(CatalogAuditResult result) {
    final buffer = StringBuffer()
      ..writeln('# Catalog audit')
      ..writeln()
      ..writeln('- Total exercises: ${result.totalExercises}')
      ..writeln('- Unique canonical IDs: ${result.uniqueCanonicalIds}')
      ..writeln('- Critical issues: ${result.criticalCount}')
      ..writeln('- Warnings: ${result.warningCount}')
      ..writeln()
      ..writeln('## Counts by primary_type');
    final counts = result.countsByPrimaryType.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    for (final entry in counts) {
      buffer.writeln('- ${entry.key}: ${entry.value}');
    }
    buffer
      ..writeln()
      ..writeln('## Scenario matrix');
    for (final scenario in result.scenarios) {
      buffer.writeln(
        '- ${scenario.passed ? 'PASS' : 'FAIL'} ${scenario.name}: ${scenario.count}',
      );
    }
    buffer
      ..writeln()
      ..writeln('## Axis Inventory')
      ..writeln('- See build/reports/catalog_axis_inventory.md')
      ..writeln()
      ..writeln('## Axis Coverage Audit')
      ..writeln('- See build/reports/axis_coverage_audit.md')
      ..writeln()
      ..writeln('## Full Menu Matrix Audit')
      ..writeln('- See build/reports/full_menu_matrix_audit.md')
      ..writeln()
      ..writeln('## Empty Menu Paths Audit')
      ..writeln('- See build/reports/empty_menu_paths_audit.md')
      ..writeln()
      ..writeln('## Unreachable Exercises Audit')
      ..writeln('- See build/reports/unreachable_exercises_audit.md')
      ..writeln()
      ..writeln('## Wrong Results Audit')
      ..writeln('- Critical wrong-result paths are included in Issues.')
      ..writeln()
      ..writeln('## Fallback and Notices Audit')
      ..writeln('- Empty paths with explicit notices are reported separately.')
      ..writeln()
      ..writeln('## Issues');
    if (result.issues.isEmpty) {
      buffer.writeln('No issues found.');
    } else {
      for (final issue in result.issues) {
        buffer.writeln('- $issue');
      }
    }
    return buffer.toString();
  }

  static String _inventoryMarkdown(
    List<Exercise> exercises,
    List<CatalogIssue> issues,
  ) {
    final byExercise = _issuesByCatalogKey(issues);
    final buffer = StringBuffer()
      ..writeln('# Catalog inventory')
      ..writeln()
      ..writeln(
        '| name | canonical_id | catalog_entry_key | primary_type | contexts | equipment | locations | issues |',
      )
      ..writeln('|---|---|---|---|---|---|---|---|');
    for (final exercise in exercises) {
      final exerciseIssues = byExercise[exercise.catalogEntryKey] ?? const [];
      buffer.writeln(
        '| ${_md(exercise.name)} | ${exercise.canonicalId} | ${exercise.catalogEntryKey} | ${exercise.primaryType} | ${exercise.contextKey} | ${_md(exercise.equipmentKeys.join('; '))} | ${_locationsFor(exercise).join('; ')} | ${exerciseIssues.map((issue) => issue.code).join('; ')} |',
      );
    }
    return buffer.toString();
  }

  static String _inventoryCsv(
    List<Exercise> exercises,
    List<CatalogIssue> issues,
  ) {
    final byExercise = _issuesByCatalogKey(issues);
    final buffer = StringBuffer()
      ..writeln(
        'name,canonical_id,catalog_entry_key,primary_type,secondary_types,contexts,aliases,muscles,equipment,locations,filters,problems,quality_flags',
      );
    for (final exercise in exercises) {
      final exerciseIssues = byExercise[exercise.catalogEntryKey] ?? const [];
      buffer.writeln(
        [
          exercise.name,
          exercise.canonicalId,
          exercise.catalogEntryKey,
          exercise.primaryType,
          exercise.secondaryTypes.join(';'),
          exercise.contextKey,
          exercise.aliases.join(';'),
          [
            exercise.primaryMuscleKey,
            ...exercise.secondaryMuscleKeys,
          ].where((item) => item.isNotEmpty).join(';'),
          exercise.equipmentKeys.join(';'),
          _locationsFor(exercise).join(';'),
          [
            ...exercise.regionKeys,
            ...exercise.groupKeys,
            ...exercise.subgroupKeys,
          ].join(';'),
          exerciseIssues.map((issue) => issue.message).join(';'),
          exerciseIssues.map((issue) => issue.code).join(';'),
        ].map(_csv).join(','),
      );
    }
    return buffer.toString();
  }

  static Map<String, Object?> _inventoryJson(
    Exercise exercise,
    List<CatalogIssue> issues,
  ) {
    final exerciseIssues =
        _issuesByCatalogKey(issues)[exercise.catalogEntryKey] ?? const [];
    return {
      'name': exercise.name,
      'canonical_id': exercise.canonicalId,
      'catalog_entry_key': exercise.catalogEntryKey,
      'exercise_key': exercise.exerciseKey,
      'primary_type': exercise.primaryType,
      'secondary_types': exercise.secondaryTypes.toList()..sort(),
      'contexts': [exercise.contextKey],
      'aliases': exercise.aliases.toList()..sort(),
      'muscles': [
        exercise.primaryMuscleKey,
        ...exercise.secondaryMuscleKeys,
      ].where((item) => item.isNotEmpty).toList(),
      'equipment': exercise.equipmentKeys.toList()..sort(),
      'locations': _locationsFor(exercise),
      'filters': [
        ...exercise.regionKeys,
        ...exercise.groupKeys,
        ...exercise.subgroupKeys,
      ],
      'problems': exerciseIssues.map((issue) => issue.message).toList(),
      'quality_flags': exerciseIssues.map((issue) => issue.code).toList(),
    };
  }

  static String _gapAnalysisMarkdown(CatalogAuditResult result) {
    final muscles = <String, int>{};
    final equipment = <String, int>{};
    final locations = <String, int>{};
    final martial = <String, int>{};
    for (final exercise in result.exercises) {
      for (final muscle in {
        exercise.primaryMuscleKey,
        ...exercise.secondaryMuscleKeys,
      }) {
        if (muscle.isNotEmpty) {
          muscles.update(muscle, (value) => value + 1, ifAbsent: () => 1);
        }
      }
      for (final item in exercise.equipmentKeys) {
        equipment.update(item, (value) => value + 1, ifAbsent: () => 1);
      }
      for (final item in _locationsFor(exercise)) {
        locations.update(item, (value) => value + 1, ifAbsent: () => 1);
      }
      if (exercise.primaryType == 'artes_marciais') {
        martial.update(
          exercise.contextKey,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    }
    final buffer = StringBuffer()
      ..writeln('# Catalog gap analysis')
      ..writeln()
      ..writeln('## Bem coberto')
      ..writeln(
        '- Musculacao, cardio base, mobilidade, elasticidade, recuperacao, aquecimento, ativacao e prevencao têm cobertura ampla.',
      )
      ..writeln(
        '- Passadeira tem cenarios permanentes para resistencia, aquecimento, ritmo leve, intervalos, casa equipada e ginasio.',
      )
      ..writeln()
      ..writeln('## Fraco ou a acompanhar')
      ..writeln(
        '- Musculos com menos de 5 entradas: ${_few(muscles).join(', ')}',
      )
      ..writeln(
        '- Equipamentos com menos de 5 entradas: ${_few(equipment).join(', ')}',
      )
      ..writeln(
        '- Locais com menos de 5 entradas: ${_few(locations).join(', ')}',
      )
      ..writeln(
        '- Modalidades marciais com menor cobertura: ${_few(martial).join(', ')}',
      )
      ..writeln()
      ..writeln('## Exercicios adicionados agora')
      ..writeln(
        '- Passadeira resistencia aerobica, ritmo leve, ritmo moderado, intervalos, HIIT passadeira, caminhada/corrida na passadeira e caminhada com inclinacao.',
      )
      ..writeln()
      ..writeln('## Sugestoes para versao futura')
      ..writeln(
        '- Expandir equipamentos raros apenas depois de decisao humana.',
      )
      ..writeln(
        '- Rever modalidades marciais menos representadas contra os ficheiros 10 a 30 antes de adicionar centenas de entradas.',
      );
    return buffer.toString();
  }

  static Map<String, List<CatalogIssue>> _issuesByCatalogKey(
    List<CatalogIssue> issues,
  ) {
    final map = <String, List<CatalogIssue>>{};
    for (final issue in issues) {
      final key = issue.exercise?.catalogEntryKey;
      if (key == null || key.isEmpty) continue;
      map.putIfAbsent(key, () => []).add(issue);
    }
    return map;
  }

  static List<String> _locationsFor(Exercise exercise) {
    if (exercise.equipmentKeys.contains('treadmill') ||
        exercise.equipmentKeys.contains('bike') ||
        exercise.equipmentKeys.contains('elliptical') ||
        exercise.equipmentKeys.contains('machine')) {
      return ['ginasio', 'casa_equipada'];
    }
    if (exercise.equipmentKeys.contains('outdoor_space')) return ['exterior'];
    if (exercise.primaryType == 'artes_marciais') return ['dojo', 'ginasio'];
    return ['casa', 'ginasio'];
  }

  static List<String> _few(Map<String, int> counts) {
    final entries = counts.entries.where((entry) => entry.value < 5).toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    return entries
        .take(12)
        .map((entry) => '${entry.key} (${entry.value})')
        .toList();
  }

  static String _csv(String value) => '"${value.replaceAll('"', '""')}"';

  static String _md(String value) => value.replaceAll('|', '\\|');
}
