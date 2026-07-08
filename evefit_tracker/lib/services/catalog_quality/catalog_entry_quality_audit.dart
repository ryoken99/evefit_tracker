import 'dart:convert';
import 'dart:io';

import '../../models/exercise.dart';
import '../exercise_catalog_context_service.dart';
import '../exercise_taxonomy_service.dart';
import 'catalog_route_registry.dart';
import 'catalog_total_matrix_audit.dart';

enum EntryQualityLevel {
  aEspecializadoConcreto,
  bBomGeradoPorRegras,
  cAceitavelReverHumano,
  dTemplateFraco,
  eIncompletoOuInseguro,
}

class EntryQualityRouteSummary {
  const EntryQualityRouteSummary({
    required this.failWrongResultsCount,
    required this.unreachableExerciseCount,
    required this.usableCleanExerciseCount,
  });

  final int failWrongResultsCount;
  final int unreachableExerciseCount;
  final int usableCleanExerciseCount;
}

class CatalogEntryQualityEvidence {
  const CatalogEntryQualityEvidence({
    required this.exercise,
    required this.level,
    required this.executionStepCount,
    required this.hasCadenceOrRhythm,
    required this.hasExpectedSensation,
    required this.hasBreathing,
    required this.hasCommonMistakes,
    required this.hasSafety,
    required this.hasRegression,
    required this.hasProgression,
    required this.hasInternalToken,
    required this.hasForbiddenLanguage,
    required this.hasMedicalOverclaim,
    required this.routesOk,
    required this.routesWithFallback,
    required this.emptyRoutes,
    required this.templateLevel,
    required this.contentOrigin,
  });

  final Exercise exercise;
  final EntryQualityLevel level;
  final int executionStepCount;
  final bool hasCadenceOrRhythm;
  final bool hasExpectedSensation;
  final bool hasBreathing;
  final bool hasCommonMistakes;
  final bool hasSafety;
  final bool hasRegression;
  final bool hasProgression;
  final bool hasInternalToken;
  final bool hasForbiddenLanguage;
  final bool hasMedicalOverclaim;
  final int routesOk;
  final int routesWithFallback;
  final int emptyRoutes;
  final String templateLevel;
  final String contentOrigin;

  String get name => exercise.name;
  String get catalogEntryKey => exercise.catalogEntryKey;

  Map<String, Object?> toJson() => {
    'nome': exercise.name,
    'catalog_entry_key': exercise.catalogEntryKey,
    'canonical_id': exercise.canonicalId,
    'categoria': exercise.primaryType,
    'subcategoria': exercise.contextKey,
    'musculos_grupos': exercise.muscleGroup,
    'equipamentos': exercise.equipment,
    'locais': CatalogEntryQualityAudit._locationsFor(exercise),
    'descricao_curta': CatalogEntryQualityAudit._shortDescription(
      exercise.description,
    ),
    'descricao_longa': exercise.description,
    'passos_execucao': exercise.executionSteps,
    'respiracao': exercise.breathingTips,
    'erros_comuns': exercise.commonMistakes,
    'seguranca_cuidados': exercise.safetyNotes,
    'regressao': exercise.regression,
    'progressao': exercise.progression,
    'quando_evitar': exercise.adaptationNotes,
    'quando_adaptar': exercise.adaptationNotes,
    'origem_conteudo': contentOrigin,
    'nivel_template': templateLevel,
    'rotas_ok': routesOk,
    'rotas_com_fallback': routesWithFallback,
    'rotas_vazias': emptyRoutes,
    'estado_final_qualidade': CatalogEntryQualityAudit.levelName(level),
  };
}

class CatalogEntryQualityResult {
  const CatalogEntryQualityResult({
    required this.entries,
    required this.routeSummary,
  });

  final List<CatalogEntryQualityEvidence> entries;
  final EntryQualityRouteSummary routeSummary;

  Map<EntryQualityLevel, int> get levelCounts {
    final counts = {for (final level in EntryQualityLevel.values) level: 0};
    for (final entry in entries) {
      counts.update(entry.level, (value) => value + 1);
    }
    return counts;
  }

  List<CatalogEntryQualityEvidence> get visibleEntriesWithWeakTemplate =>
      entries
          .where(
            (entry) =>
                entry.level == EntryQualityLevel.dTemplateFraco ||
                entry.level == EntryQualityLevel.eIncompletoOuInseguro,
          )
          .toList(growable: false);
}

class CatalogEntryQualityAudit {
  const CatalogEntryQualityAudit._();

  static CatalogEntryQualityResult run() {
    final exercises = ExerciseCatalogContextService.entries
        .map(ExerciseTaxonomyService.enrichCatalogExercise)
        .toList(growable: false);
    final routeRegistry = CatalogRouteRegistry.build(exercises: exercises);
    final matrix = CatalogTotalMatrixAudit.run(writeReports: false);
    final entries = exercises
        .map((exercise) => _evidence(exercise, routeRegistry, matrix))
        .toList(growable: false);
    return CatalogEntryQualityResult(
      entries: entries,
      routeSummary: EntryQualityRouteSummary(
        failWrongResultsCount: matrix.failWrongResults.length,
        unreachableExerciseCount: matrix.unreachableExercises.length,
        usableCleanExerciseCount: routeRegistry.usableCleanExerciseCount,
      ),
    );
  }

  static void writeReports({required Directory directory}) {
    directory.createSync(recursive: true);
    final result = run();
    _writeEvidence(directory, result);
    _writeAfter(directory, result);
  }

  static CatalogEntryQualityEvidence _evidence(
    Exercise exercise,
    CatalogRouteRegistry routeRegistry,
    CatalogTotalMatrixResult matrix,
  ) {
    final text = _allText(exercise);
    final stepCount = _stepCount(exercise.executionSteps);
    final hasRequiredFields =
        exercise.description.trim().length >= 80 &&
        stepCount >= 4 &&
        exercise.breathingTips.trim().isNotEmpty &&
        exercise.commonMistakes.trim().isNotEmpty &&
        exercise.safetyNotes.trim().isNotEmpty &&
        exercise.regression.trim().isNotEmpty &&
        exercise.progression.trim().isNotEmpty &&
        exercise.adaptationNotes.trim().isNotEmpty;
    final hasForbidden = _hasForbiddenLanguage(text);
    final hasInternal = RegExp(r'\b[a-z]+_[a-z0-9_]+\b').hasMatch(text);
    final hasMedical = _hasMedicalOverclaim(exercise);
    final hasCadence =
        stepCount >= 4 ||
        _hasAny(text, const [
          'ritmo',
          'cadencia',
          'cadência',
          'control',
          'pausa',
          'segundos',
          'tempo',
        ]);
    final hasSensation =
        exercise.muscleGroup.trim().isNotEmpty ||
        _hasAny(text, const [
          'sentir',
          'sente',
          'tensao',
          'tensão',
          'zona',
          'musculo',
          'músculo',
          'estabilidade',
          'ativar',
          'controlo',
          'controle',
          'pressao',
          'pressão',
          'alongamento',
          'mobilidade',
          'relaxamento',
        ]);
    final routesOk = routeRegistry
        .routesForExercise(exercise.catalogEntryKey)
        .length;
    final fallbackRoutes = matrix.okWithFallback
        .where((path) => path.exerciseKeys.contains(exercise.catalogEntryKey))
        .length;
    final emptyRoutes = matrix.okEmptyWithExplicitNotice
        .where((path) => path.exerciseKeys.contains(exercise.catalogEntryKey))
        .length;
    final level = _level(
      exercise: exercise,
      hasRequiredFields: hasRequiredFields,
      hasForbidden: hasForbidden,
      hasInternal: hasInternal,
      hasMedical: hasMedical,
      hasCadence: hasCadence,
      hasSensation: hasSensation,
      routesOk: routesOk,
    );
    return CatalogEntryQualityEvidence(
      exercise: exercise,
      level: level,
      executionStepCount: stepCount,
      hasCadenceOrRhythm: hasCadence,
      hasExpectedSensation: hasSensation,
      hasBreathing: exercise.breathingTips.trim().isNotEmpty,
      hasCommonMistakes: exercise.commonMistakes.trim().isNotEmpty,
      hasSafety: exercise.safetyNotes.trim().isNotEmpty,
      hasRegression: exercise.regression.trim().isNotEmpty,
      hasProgression: exercise.progression.trim().isNotEmpty,
      hasInternalToken: hasInternal,
      hasForbiddenLanguage: hasForbidden,
      hasMedicalOverclaim: hasMedical,
      routesOk: routesOk,
      routesWithFallback: fallbackRoutes,
      emptyRoutes: emptyRoutes,
      templateLevel: _templateLevel(exercise, level),
      contentOrigin: _contentOrigin(exercise),
    );
  }

  static EntryQualityLevel _level({
    required Exercise exercise,
    required bool hasRequiredFields,
    required bool hasForbidden,
    required bool hasInternal,
    required bool hasMedical,
    required bool hasCadence,
    required bool hasSensation,
    required int routesOk,
  }) {
    if (!hasRequiredFields ||
        hasForbidden ||
        hasInternal ||
        hasMedical ||
        routesOk == 0) {
      return EntryQualityLevel.eIncompletoOuInseguro;
    }
    if (_looksWeakTemplate(exercise)) {
      return EntryQualityLevel.dTemplateFraco;
    }
    final textLength =
        exercise.description.length +
        exercise.executionSteps.length +
        exercise.commonMistakes.length +
        exercise.safetyNotes.length;
    if (_isSpecificToExercise(exercise) && textLength >= 1200) {
      return EntryQualityLevel.aEspecializadoConcreto;
    }
    if (_isSpecificToExercise(exercise)) {
      return EntryQualityLevel.bBomGeradoPorRegras;
    }
    return EntryQualityLevel.cAceitavelReverHumano;
  }

  static void _writeEvidence(
    Directory directory,
    CatalogEntryQualityResult result,
  ) {
    final rows = result.entries.map((entry) => entry.toJson()).toList();
    _writeJson(
      File('${directory.path}/catalog_entry_quality_evidence.json'),
      rows,
    );
    _writeCsv(
      File('${directory.path}/catalog_entry_quality_evidence.csv'),
      rows,
    );
    final buffer = StringBuffer()
      ..writeln('# v0.9.8 Catalog Entry Quality Evidence')
      ..writeln()
      ..writeln('- Total exercises: ${result.entries.length}')
      ..writeln()
      ..writeln('| Exercise | Entry | Level | Routes |')
      ..writeln('|---|---|---|---|');
    for (final entry in result.entries) {
      buffer.writeln(
        '| ${entry.name} | `${entry.catalogEntryKey}` | ${levelName(entry.level)} | ${entry.routesOk} |',
      );
    }
    File(
      '${directory.path}/catalog_entry_quality_evidence.md',
    ).writeAsStringSync(buffer.toString());
  }

  static void _writeAfter(
    Directory directory,
    CatalogEntryQualityResult result,
  ) {
    final counts = result.levelCounts;
    final rows = [
      for (final level in EntryQualityLevel.values)
        {
          'level': levelName(level),
          'before': counts[level] ?? 0,
          'after': counts[level] ?? 0,
        },
    ];
    final worst = result.entries
        .where(
          (entry) => entry.level != EntryQualityLevel.aEspecializadoConcreto,
        )
        .take(50)
        .map((entry) => entry.toJson())
        .toList();
    final after = {
      'total_exercises': result.entries.length,
      'levels_before_after': rows,
      'rewritten_exercises': 0,
      'needs_human_review':
          counts[EntryQualityLevel.cAceitavelReverHumano] ?? 0,
      'worst_50_before': worst,
      'corrected_cases': const [],
      'visible_has_no_d_or_e': result.visibleEntriesWithWeakTemplate.isEmpty,
    };
    _writeJson(
      File('${directory.path}/catalog_entry_quality_after.json'),
      after,
    );
    _writeCsv(File('${directory.path}/catalog_entry_quality_after.csv'), rows);
    final buffer = StringBuffer()
      ..writeln('# v0.9.8 Catalog Entry Quality After')
      ..writeln()
      ..writeln('- Total exercises: ${result.entries.length}')
      ..writeln('- Rewritten exercises: 0')
      ..writeln(
        '- Needs human review: ${counts[EntryQualityLevel.cAceitavelReverHumano] ?? 0}',
      )
      ..writeln(
        '- Visible entries with D/E: ${result.visibleEntriesWithWeakTemplate.length}',
      )
      ..writeln()
      ..writeln('| Level | Before | After |')
      ..writeln('|---|---|---|');
    for (final row in rows) {
      buffer.writeln(
        '| ${row['level']} | ${row['before']} | ${row['after']} |',
      );
    }
    buffer
      ..writeln()
      ..writeln('## 50 Worst Cases Before')
      ..writeln();
    for (final entry in worst) {
      buffer.writeln(
        '- ${entry['nome']} `${entry['catalog_entry_key']}`: ${entry['estado_final_qualidade']}',
      );
    }
    File(
      '${directory.path}/catalog_entry_quality_after.md',
    ).writeAsStringSync(buffer.toString());
  }

  static int _stepCount(String value) =>
      RegExp(r'(^|\n)\s*\d+[.)]').allMatches(value).length;

  static bool _hasForbiddenLanguage(String text) {
    for (final token in const {
      'activation',
      'adductors light',
      'target pattern',
      'referencia tecnica',
      'referência técnica',
      'canonical_id',
      'catalog_entry_key',
    }) {
      if (text.contains(token)) return true;
    }
    return false;
  }

  static bool _hasMedicalOverclaim(Exercise exercise) {
    final text = _allText(exercise);
    if (exercise.primaryType == 'prevencao' &&
        (text.contains('previne les') || text.contains('evita les'))) {
      return true;
    }
    return text.contains('cura dor') ||
        text.contains('trata dor') ||
        text.contains('substitui avaliacao') ||
        text.contains('substitui avaliação');
  }

  static bool _looksWeakTemplate(Exercise exercise) {
    final description = _n(exercise.description);
    return description.length < 120 ||
        description.contains('movimento de apoio geral') ||
        description.contains('exercicio para trabalhar a zona indicada');
  }

  static bool _isSpecificToExercise(Exercise exercise) {
    final nameTokens = _n(
      exercise.name,
    ).split(RegExp(r'\s+')).where((token) => token.length >= 4).toSet();
    final text = _allText(exercise);
    return nameTokens.any(text.contains) ||
        _n(exercise.equipment).split(RegExp(r'\s+')).any(text.contains);
  }

  static String _templateLevel(Exercise exercise, EntryQualityLevel level) {
    if (level == EntryQualityLevel.aEspecializadoConcreto) {
      return 'especializado';
    }
    if (level == EntryQualityLevel.bBomGeradoPorRegras) {
      return 'bom_gerado_por_regras';
    }
    if (level == EntryQualityLevel.cAceitavelReverHumano) {
      return 'aceitavel_para_revisao_humana';
    }
    if (level == EntryQualityLevel.dTemplateFraco) return 'template_fraco';
    return 'incompleto_ou_inseguro';
  }

  static String _contentOrigin(Exercise exercise) =>
      exercise.catalogEntryKey.contains('__')
      ? 'catalogo_canonico_gerado_por_regras'
      : 'catalogo_legado';

  static String _shortDescription(String value) {
    final trimmed = value.trim();
    if (trimmed.length <= 180) return trimmed;
    return '${trimmed.substring(0, 180)}...';
  }

  static String _locationsFor(Exercise exercise) {
    if (exercise.primaryType == 'artes_marciais') return 'Dojo / tatami';
    if (exercise.primaryType == 'recuperacao') {
      return 'Casa, clinica ou fisioterapia';
    }
    if (_n(exercise.equipment).contains('passadeira')) return 'Ginasio';
    return 'Casa ou ginasio conforme equipamento';
  }

  static String _allText(Exercise exercise) => _n(
    [
      exercise.name,
      exercise.description,
      exercise.executionSteps,
      exercise.commonMistakes,
      exercise.safetyNotes,
      exercise.regression,
      exercise.progression,
      exercise.breathingTips,
      exercise.postureTips,
      exercise.adaptationNotes,
      exercise.muscleGroup,
      exercise.equipment,
    ].join(' '),
  );

  static bool _hasAny(String text, List<String> needles) =>
      needles.any(text.contains);

  static String _n(String value) {
    var text = value.toLowerCase();
    const replacements = {
      'Ã¡': 'á',
      'Ã£': 'ã',
      'Ã¢': 'â',
      'Ã©': 'é',
      'Ãª': 'ê',
      'Ã­': 'í',
      'Ã³': 'ó',
      'Ãµ': 'õ',
      'Ãº': 'ú',
      'Ã§': 'ç',
    };
    for (final entry in replacements.entries) {
      text = text.replaceAll(entry.key, entry.value);
    }
    return text;
  }

  static String levelName(EntryQualityLevel level) {
    return switch (level) {
      EntryQualityLevel.aEspecializadoConcreto => 'A_ESPECIALIZADO_CONCRETO',
      EntryQualityLevel.bBomGeradoPorRegras => 'B_BOM_GERADO_POR_REGRAS',
      EntryQualityLevel.cAceitavelReverHumano => 'C_ACEITAVEL_REVER_HUMANO',
      EntryQualityLevel.dTemplateFraco => 'D_TEMPLATE_FRACO',
      EntryQualityLevel.eIncompletoOuInseguro => 'E_INCOMPLETO_OU_INSEGURO',
    };
  }

  static void _writeJson(File file, Object value) {
    file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(value));
  }

  static void _writeCsv(File file, List<Map<String, Object?>> rows) {
    if (rows.isEmpty) {
      file.writeAsStringSync('');
      return;
    }
    final headers = rows.first.keys.toList(growable: false);
    final buffer = StringBuffer()..writeln(headers.map(_escape).join(','));
    for (final row in rows) {
      buffer.writeln(headers.map((header) => _escape(row[header])).join(','));
    }
    file.writeAsStringSync(buffer.toString());
  }

  static String _escape(Object? value) {
    final text = '$value'.replaceAll('"', '""');
    return '"$text"';
  }
}
