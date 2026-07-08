import 'dart:convert';
import 'dart:io';

enum EmptyPathDecision {
  keepWithNotice,
  addFallback,
  hideUntilContentExists,
  needsContentInV099,
  invalidMenuRoute,
}

enum AxisVisibilityDecision {
  visibleWithContent,
  visibleWithFallback,
  keepWithNotice,
  hideUntilContentExists,
  futureExpansionV099,
  internalOnly,
}

class MenuAxisContractSummary {
  const MenuAxisContractSummary({
    required this.emptyPathCount,
    required this.emptyPathDecisionCounts,
    required this.zeroCoverageAxisCount,
    required this.visibleAxisCount,
    required this.hiddenAxisCount,
    required this.futureExpansionAxisCount,
    required this.genericNoticeCount,
    required this.visibleAxisWithoutDecisionCount,
    required this.failWrongResultsCount,
    required this.unreachableExerciseCount,
  });

  final int emptyPathCount;
  final Map<EmptyPathDecision, int> emptyPathDecisionCounts;
  final int zeroCoverageAxisCount;
  final int visibleAxisCount;
  final int hiddenAxisCount;
  final int futureExpansionAxisCount;
  final int genericNoticeCount;
  final int visibleAxisWithoutDecisionCount;
  final int failWrongResultsCount;
  final int unreachableExerciseCount;
}

class CatalogMenuAxisContractPolicy {
  const CatalogMenuAxisContractPolicy._();

  static const genericEmptyNotice =
      'Não há exercícios disponíveis para este foco com as capacidades atuais. Ativa Mostrar todos para ver o equipamento/local em falta.';

  static bool hasGenericNotice(dynamic path) =>
      path.notice.trim() == genericEmptyNotice;

  static bool hasApprovedEmptyPathDecision(dynamic path) =>
      emptyPathDecision(path) != null;

  static bool hasApprovedFallbackNotice(dynamic path) =>
      path.notice.trim().isNotEmpty && !hasGenericNotice(path);

  static bool hasAxisDecision(dynamic axis) =>
      axisVisibilityDecision(axis) != null;

  static bool isVisibleWithoutDecision(dynamic axis) =>
      axis.count == 0 && !hasAxisDecision(axis);

  static EmptyPathDecision? emptyPathDecision(dynamic path) {
    if (!_hasStatus(path, 'okEmptyWithExplicitNotice')) {
      return null;
    }
    if (_isInvalidMenuRoute(path)) return EmptyPathDecision.invalidMenuRoute;
    if (_shouldHideUntilContent(path)) {
      return EmptyPathDecision.hideUntilContentExists;
    }
    if (_needsV099Content(path)) return EmptyPathDecision.needsContentInV099;
    if (_shouldAddFallback(path)) return EmptyPathDecision.addFallback;
    return EmptyPathDecision.keepWithNotice;
  }

  static AxisVisibilityDecision? axisVisibilityDecision(dynamic axis) {
    if (axis.count > 0) return AxisVisibilityDecision.visibleWithContent;
    if (_isInternalAxis(axis)) return AxisVisibilityDecision.internalOnly;
    if (_isFutureExpansionAxis(axis)) {
      return AxisVisibilityDecision.futureExpansionV099;
    }
    if (_shouldHideAxis(axis)) {
      return AxisVisibilityDecision.hideUntilContentExists;
    }
    return AxisVisibilityDecision.keepWithNotice;
  }

  static String emptyPathNotice(dynamic path) {
    final decision = emptyPathDecision(path);
    if (decision == EmptyPathDecision.invalidMenuRoute) {
      return 'Esta combinação de menu não deve ser usada diretamente nesta versão.';
    }
    if (decision == EmptyPathDecision.hideUntilContentExists) {
      return 'Esta opção ainda não está disponível nesta versão porque não tem exercícios específicos aprovados.';
    }
    if (decision == EmptyPathDecision.needsContentInV099) {
      return 'Este catálogo específico ainda está incompleto e fica marcado para expansão futura.';
    }
    if (decision == EmptyPathDecision.addFallback) {
      return 'Ainda não há exercícios específicos para este foco. Mostra alternativas relacionadas quando disponíveis.';
    }
    if (path.equipmentKey.isNotEmpty &&
        path.equipmentKey != 'bodyweight' &&
        path.equipmentKey != 'floor' &&
        path.equipmentKey != 'mat' &&
        path.equipmentKey != 'wall') {
      return 'Este foco tem exercícios relacionados, mas nenhum compatível com o equipamento/local selecionado.';
    }
    if (path.martialArtKey.isNotEmpty) {
      return 'Este estilo ou foco técnico ainda não tem exercícios suficientes nesta versão.';
    }
    return 'Os filtros atuais estão demasiado restritos. Limpa filtros ou usa uma categoria geral relacionada.';
  }

  static String decisionReason(dynamic path) {
    final decision = emptyPathDecision(path);
    return switch (decision) {
      EmptyPathDecision.invalidMenuRoute =>
        'Combinação visível demasiado artificial para o fluxo real.',
      EmptyPathDecision.hideUntilContentExists =>
        'Opção comum sem conteúdo específico aprovado.',
      EmptyPathDecision.needsContentInV099 =>
        'Lacuna real de catálogo, reservada para expansão aprovada.',
      EmptyPathDecision.addFallback =>
        'Existe domínio relacionado onde a UI pode orientar o utilizador.',
      EmptyPathDecision.keepWithNotice =>
        'Caminho válido sem conteúdo específico, coberto por aviso explícito.',
      null => 'Não aplicável.',
    };
  }

  static String proposedCorrection(dynamic path) {
    final decision = emptyPathDecision(path);
    return switch (decision) {
      EmptyPathDecision.invalidMenuRoute =>
        'Remover a rota gerada da matriz se a UI real não a permitir.',
      EmptyPathDecision.hideUntilContentExists =>
        'Ocultar a opção numa fase futura se continuar sem conteúdo.',
      EmptyPathDecision.needsContentInV099 =>
        'Criar proposta de conteúdo para v0.9.9 antes de adicionar exercícios.',
      EmptyPathDecision.addFallback =>
        'Ligar fallback coerente do mesmo tipo/local quando aprovado.',
      EmptyPathDecision.keepWithNotice =>
        'Manter visível apenas com aviso específico aprovado.',
      null => 'Sem correção necessária.',
    };
  }

  static MenuAxisContractSummary summarize(dynamic audit) {
    final empty = audit.okEmptyWithExplicitNotice;
    final decisionCounts = <EmptyPathDecision, int>{
      for (final decision in EmptyPathDecision.values) decision: 0,
    };
    for (final path in empty) {
      final decision = emptyPathDecision(path);
      if (decision != null) {
        decisionCounts.update(decision, (value) => value + 1);
      }
    }

    final zeroAxes = audit.axisCoverage
        .where((axis) => axis.count == 0)
        .toList(growable: false);
    return MenuAxisContractSummary(
      emptyPathCount: empty.length,
      emptyPathDecisionCounts: Map.unmodifiable(decisionCounts),
      zeroCoverageAxisCount: zeroAxes.length,
      visibleAxisCount: zeroAxes
          .where(
            (axis) =>
                axisVisibilityDecision(axis) ==
                    AxisVisibilityDecision.keepWithNotice ||
                axisVisibilityDecision(axis) ==
                    AxisVisibilityDecision.visibleWithFallback,
          )
          .length,
      hiddenAxisCount: zeroAxes
          .where(
            (axis) =>
                axisVisibilityDecision(axis) ==
                AxisVisibilityDecision.hideUntilContentExists,
          )
          .length,
      futureExpansionAxisCount: zeroAxes
          .where(
            (axis) =>
                axisVisibilityDecision(axis) ==
                AxisVisibilityDecision.futureExpansionV099,
          )
          .length,
      genericNoticeCount: empty.where(hasGenericNotice).length,
      visibleAxisWithoutDecisionCount: zeroAxes
          .where(isVisibleWithoutDecision)
          .length,
      failWrongResultsCount: audit.failWrongResults.length,
      unreachableExerciseCount: audit.unreachableExercises.length,
    );
  }

  static void writeReports({
    required Directory directory,
    required dynamic audit,
  }) {
    directory.createSync(recursive: true);
    _writeEmptyPathDecisionMatrix(directory, audit);
    _writeAxisVisibilityDecision(directory, audit);
  }

  static void _writeEmptyPathDecisionMatrix(
    Directory directory,
    dynamic audit,
  ) {
    final rows = audit.okEmptyWithExplicitNotice
        .map<Map<String, Object?>>((path) {
          final decision = emptyPathDecision(path)!;
          return {
            'combination': path.id,
            'training_type': path.typeKey,
            'location': path.locationKey,
            'equipment': path.equipmentKey,
            'focus': _focusLabel(path),
            'current_notice': path.notice,
            'decision': _emptyDecisionName(decision),
            'reason': decisionReason(path),
            'proposed_correction': proposedCorrection(path),
            'applied_correction':
                'Aviso específico e decisão explícita registados em v0.9.7.',
          };
        })
        .toList(growable: false);

    _writeJson(
      File('${directory.path}/empty_paths_decision_matrix.json'),
      rows,
    );
    _writeCsv(File('${directory.path}/empty_paths_decision_matrix.csv'), [
      'combination',
      'training_type',
      'location',
      'equipment',
      'focus',
      'current_notice',
      'decision',
      'reason',
      'proposed_correction',
      'applied_correction',
    ], rows);
    final summary = summarize(audit);
    final buffer = StringBuffer()
      ..writeln('# v0.9.7 Empty Paths Decision Matrix')
      ..writeln()
      ..writeln('- Empty paths: ${summary.emptyPathCount}')
      ..writeln('- Generic notices remaining: ${summary.genericNoticeCount}')
      ..writeln()
      ..writeln('| Decision | Count |')
      ..writeln('|---|---|');
    for (final entry in summary.emptyPathDecisionCounts.entries) {
      buffer.writeln('| ${_emptyDecisionName(entry.key)} | ${entry.value} |');
    }
    buffer
      ..writeln()
      ..writeln('| Combination | Decision | Notice |')
      ..writeln('|---|---|---|');
    for (final row in rows) {
      buffer.writeln(
        '| `${row['combination']}` | ${row['decision']} | ${row['current_notice']} |',
      );
    }
    File(
      '${directory.path}/empty_paths_decision_matrix.md',
    ).writeAsStringSync(buffer.toString());
  }

  static void _writeAxisVisibilityDecision(Directory directory, dynamic audit) {
    final rows = audit.axisCoverage
        .where((axis) => axis.count == 0)
        .map<Map<String, Object?>>((axis) {
          final decision = axisVisibilityDecision(axis)!;
          return {
            'axis': axis.axis,
            'key': axis.key,
            'label': axis.label,
            'appears_in_ui': _appearsInUi(axis),
            'has_exercises': false,
            'has_fallback':
                decision == AxisVisibilityDecision.visibleWithFallback,
            'should_remain_visible':
                decision == AxisVisibilityDecision.keepWithNotice ||
                decision == AxisVisibilityDecision.visibleWithFallback,
            'should_be_hidden':
                decision == AxisVisibilityDecision.hideUntilContentExists,
            'future_expansion':
                decision == AxisVisibilityDecision.futureExpansionV099,
            'needs_content_v099':
                decision == AxisVisibilityDecision.futureExpansionV099,
            'decision': _axisDecisionName(decision),
            'reason': _axisReason(axis, decision),
          };
        })
        .toList(growable: false);

    _writeJson(File('${directory.path}/axis_visibility_decision.json'), rows);
    _writeCsv(File('${directory.path}/axis_visibility_decision.csv'), [
      'axis',
      'key',
      'label',
      'appears_in_ui',
      'has_exercises',
      'has_fallback',
      'should_remain_visible',
      'should_be_hidden',
      'future_expansion',
      'needs_content_v099',
      'decision',
      'reason',
    ], rows);
    final buffer = StringBuffer()
      ..writeln('# v0.9.7 Axis Visibility Decision')
      ..writeln()
      ..writeln('- Zero coverage axes: ${rows.length}')
      ..writeln()
      ..writeln('| Axis | Key | UI | Decision | Reason |')
      ..writeln('|---|---|---|---|---|');
    for (final row in rows) {
      buffer.writeln(
        '| ${row['axis']} | `${row['key']}` | ${row['appears_in_ui']} | ${row['decision']} | ${row['reason']} |',
      );
    }
    File(
      '${directory.path}/axis_visibility_decision.md',
    ).writeAsStringSync(buffer.toString());
  }

  static bool _shouldAddFallback(dynamic path) =>
      path.typeKey == 'mobility' ||
      path.typeKey == 'recovery' ||
      path.typeKey == 'warmup' ||
      path.typeKey == 'activation' ||
      path.typeKey == 'prevention';

  static bool _shouldHideUntilContent(dynamic path) =>
      path.typeKey == 'strength' &&
      _commonGymEquipmentWithoutContent.contains(path.equipmentKey);

  static bool _needsV099Content(dynamic path) =>
      path.typeKey == 'martial_arts' ||
      path.typeKey == 'elasticity' ||
      _futureEquipment.contains(path.equipmentKey);

  static bool _isInvalidMenuRoute(dynamic path) =>
      path.typeKey == 'strength' &&
      path.equipmentKey == 'treadmill' &&
      path.regionKey != 'cardio';

  static bool _isInternalAxis(dynamic axis) =>
      axis.axis == 'muscle' && axis.key.contains('complete');

  static bool _isFutureExpansionAxis(dynamic axis) =>
      axis.axis == 'equipment' && _futureEquipment.contains(axis.key);

  static bool _shouldHideAxis(dynamic axis) =>
      axis.axis == 'equipment' &&
      _commonGymEquipmentWithoutContent.contains(axis.key);

  static bool _appearsInUi(dynamic axis) => const {
    'training_type',
    'location',
    'equipment',
    'martial_art',
  }.contains(axis.axis);

  static String _axisReason(dynamic axis, AxisVisibilityDecision decision) {
    return switch (decision) {
      AxisVisibilityDecision.visibleWithContent => 'Eixo com cobertura.',
      AxisVisibilityDecision.visibleWithFallback =>
        'Eixo pode usar fallback aprovado.',
      AxisVisibilityDecision.keepWithNotice =>
        'Eixo válido, mantido apenas com aviso específico.',
      AxisVisibilityDecision.hideUntilContentExists =>
        'Equipamento comum sem conteúdo específico; decisão de esconder em fase futura.',
      AxisVisibilityDecision.futureExpansionV099 =>
        'Acessório ou eixo reservado para expansão v0.9.9.',
      AxisVisibilityDecision.internalOnly =>
        'Pseudo-eixo interno, não deve aparecer como opção direta.',
    };
  }

  static String _focusLabel(dynamic path) {
    return [
      path.regionKey,
      path.groupKey,
      path.subzoneKey,
      path.focusKey,
      path.cardioFocusKey,
      path.martialArtKey,
    ].where((value) => value.isNotEmpty).join(' / ');
  }

  static bool _hasStatus(dynamic item, String statusName) {
    final value = item.status.toString();
    return value == statusName || value.endsWith('.$statusName');
  }

  static String _emptyDecisionName(EmptyPathDecision decision) {
    return switch (decision) {
      EmptyPathDecision.keepWithNotice => 'KEEP_WITH_NOTICE',
      EmptyPathDecision.addFallback => 'ADD_FALLBACK',
      EmptyPathDecision.hideUntilContentExists => 'HIDE_UNTIL_CONTENT_EXISTS',
      EmptyPathDecision.needsContentInV099 => 'NEEDS_CONTENT_IN_V099',
      EmptyPathDecision.invalidMenuRoute => 'INVALID_MENU_ROUTE',
    };
  }

  static String _axisDecisionName(AxisVisibilityDecision decision) {
    return switch (decision) {
      AxisVisibilityDecision.visibleWithContent => 'VISIBLE_WITH_CONTENT',
      AxisVisibilityDecision.visibleWithFallback => 'VISIBLE_WITH_FALLBACK',
      AxisVisibilityDecision.keepWithNotice => 'KEEP_WITH_NOTICE',
      AxisVisibilityDecision.hideUntilContentExists =>
        'HIDE_UNTIL_CONTENT_EXISTS',
      AxisVisibilityDecision.futureExpansionV099 => 'FUTURE_EXPANSION_V099',
      AxisVisibilityDecision.internalOnly => 'INTERNAL_ONLY',
    };
  }

  static void _writeJson(File file, Object value) {
    file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(value));
  }

  static void _writeCsv(
    File file,
    List<String> headers,
    List<Map<String, Object?>> rows,
  ) {
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

  static const _commonGymEquipmentWithoutContent = {
    'leg_press',
    'leg_extension',
    'leg_curl',
    'smith_machine',
    'lat_pulldown',
  };

  static const _futureEquipment = {
    'trx',
    'rings',
    'ab_wheel',
    'medicine_ball',
    'sandbag',
    'water_bottles',
    'towel',
  };
}
