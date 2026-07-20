import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

const _generatorVersion = '1.0.0';
const _registryVersion = '0.4.1';
const _sourceV04Path =
    'docs/canonical/source/training_intentions/EveFit_Training_Intentions_Production_Registry_v0.4.md';
const _sourceV041Path =
    'docs/canonical/source/training_intentions/EveFit_Training_Intentions_Production_Registry_v0.4.1.md';
const _sourceV04Hash =
    'd9cf51727dc28aa078b7cc55fa0f6246360e86bcba93b40fe34feac9ac7f50ad';
const _sourceV041Hash =
    '4d6f6d06f8f593f549dfd0ab132ce09f92ec760dfed11966cdd816be3506c0d8';
const _generatedDirectory =
    'lib/features/canonical_core/generated/training_intentions';
const _manifestPath =
    'docs/canonical/generated/training_intentions_v0.4.1_manifest.json';
const _provenanceId = 'training-intentions-v0.4.1-4d6f6d06f8f5';

const _definitionHeading = '## 20. Registo final das 591 intenções';
const _definitionHeader =
    '| final_id | Nome PT-PT | Definição canónica | Tipo | Efeito principal e alvo principal | Horizonte | Contextos / capacidades / conceitos compatíveis | Ocorrências e papéis possíveis | Alternativas incompatíveis | Complementares compatíveis | Populações relevantes | evidence_basis / fontes / limites | review_state | clinical_review_required / segurança geral | operational_risk_tier | IDs v0.3 incorporados / razão |';
const _pathHeading = '## 21. Matriz final dos 280 percursos';
const _pathHeader =
    '| N.º | Contexto | Capacidade | Conceito | Estado | Racional | Destinos v0.3→v0.4 | Intenções finais | Prioridade | Alternativas / complementares | Notas de contexto | Modificador de risco operacional | Modificador de revisão clínica | Limites | Progressão separada | Intensidade e prescrição separadas | Elegibilidade e segurança |';
const _historicHeading = '## 12. Mapeamento integral v0.3 para v0.4';
const _preservedHistoricHeading =
    '### 25.2 Mapeamento v0.3 para v0.4 preservado';
const _historicHeader =
    '| ID e nome v0.3 | Decisão | ID e nome v0.4 | Justificação | Efeitos preservados | Efeitos removidos | Camada de destino | Percursos afetados | Revisão clínica |';
const _contextualLabelsHeading =
    '### 13.1. Elementos convertidos em rótulo contextual';
const _contextualLabelsHeader = '| ID v0.3 | Destino v0.4 | Razão |';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 1 ||
      !const {'generate', 'check', 'report'}.contains(arguments.single)) {
    stderr.writeln(
      'Usage: dart run tool/canonical/generate_training_intentions_registry.dart '
      '<generate|check|report>',
    );
    exitCode = 64;
    return;
  }

  try {
    final registry = await _loadRegistry();
    final outputs = await _buildOutputs(registry);

    switch (arguments.single) {
      case 'generate':
        await _writeOutputs(outputs);
        stdout.writeln(_report(registry));
      case 'check':
        _checkOutputs(outputs);
        stdout.writeln('Generated training-intention outputs are current.');
      case 'report':
        stdout.writeln(_report(registry));
    }
  } on _GeneratorFailure catch (error) {
    stderr.writeln('Training intentions generator failed: ${error.message}');
    exitCode = 1;
  } catch (error, stackTrace) {
    stderr.writeln('Training intentions generator failed unexpectedly: $error');
    stderr.writeln(stackTrace);
    exitCode = 1;
  }
}

Future<_RegistryData> _loadRegistry() async {
  final sourceV04 = await _readSource(_sourceV04Path, _sourceV04Hash);
  final sourceV041 = await _readSource(_sourceV041Path, _sourceV041Hash);

  _expectTitle(
    sourceV04.text,
    '# EveFit: Registo de Intenções de Produção v0.4',
  );
  _expectTitle(
    sourceV041.text,
    '# EveFit: Registo de Intenções de Produção v0.4.1',
  );

  final definitionRows = _readTable(
    sourceV041.text,
    heading: _definitionHeading,
    header: _definitionHeader,
    columnCount: 16,
  );
  final pathRows = _readTable(
    sourceV041.text,
    heading: _pathHeading,
    header: _pathHeader,
    columnCount: 17,
  );
  final historicRowsV04 = _readTable(
    sourceV04.text,
    heading: _historicHeading,
    header: _historicHeader,
    columnCount: 9,
  );
  final historicRowsV041 = _readTable(
    sourceV041.text,
    heading: _preservedHistoricHeading,
    header: _historicHeader,
    columnCount: 9,
  );
  final contextualLabelRows = _readTable(
    sourceV04.text,
    heading: _contextualLabelsHeading,
    header: _contextualLabelsHeader,
    columnCount: 3,
  );

  final historicV04 = _parseHistoricRows(historicRowsV04);
  final historicV041 = _parseHistoricRows(historicRowsV041);
  _validatePreservedHistoricMap(historicV04, historicV041);

  final definitions = _parseDefinitions(definitionRows);
  final definitionsById = <String, _Definition>{
    for (final definition in definitions) definition.id: definition,
  };
  _expect(
    definitionsById.length == definitions.length,
    'Duplicate final intention ID.',
  );

  final paths = _parsePaths(pathRows);
  final labels = _parseContextualLabels(contextualLabelRows, historicV04);
  final links = _parseLinks(paths, definitionsById, labels);

  final data = _RegistryData(
    sourceV04: sourceV04,
    sourceV041: sourceV041,
    definitions: definitions,
    paths: paths,
    links: links,
    historicMappings: historicV041,
    contextualLabels: labels,
  );
  _validateRegistry(data);
  return data;
}

Future<_SourceDocument> _readSource(
  String relativePath,
  String expectedHash,
) async {
  final file = File(relativePath);
  if (!await file.exists()) {
    _fail('Required source is missing: $relativePath');
  }
  final bytes = await file.readAsBytes();
  _expect(bytes.length > 1024, 'Source is truncated: $relativePath');
  final hash = _sha256(bytes);
  _expect(
    hash == expectedHash,
    'SHA-256 mismatch for $relativePath: expected $expectedHash, found $hash.',
  );
  late final String text;
  try {
    text = utf8.decode(bytes, allowMalformed: false);
  } on FormatException {
    _fail('Source is not valid UTF-8: $relativePath');
  }
  _expect(
    text.endsWith('\n'),
    'Source is truncated or missing final LF: $relativePath',
  );
  return _SourceDocument(relativePath, bytes, text, hash);
}

void _expectTitle(String source, String expected) {
  final firstLine = source.split('\n').first.replaceFirst('\uFEFF', '');
  _expect(firstLine == expected, 'Unexpected source title: $firstLine');
}

List<List<String>> _readTable(
  String source, {
  required String heading,
  required String header,
  required int columnCount,
}) {
  final lines = source
      .split('\n')
      .map((line) => line.replaceFirst('\r', ''))
      .toList();
  final headingIndex = lines.indexOf(heading);
  _expect(headingIndex >= 0, 'Missing required heading: $heading');
  final headerIndex = lines.indexOf(header, headingIndex + 1);
  _expect(headerIndex >= 0, 'Missing exact table header after $heading.');
  final nextHeading = lines.indexWhere(
    (line) => line.startsWith('#'),
    headerIndex + 1,
  );
  _expect(
    nextHeading < 0 || headerIndex < nextHeading,
    'Table header occurs outside section $heading.',
  );
  _expect(
    headerIndex + 1 < lines.length,
    'Missing separator after table header: $heading.',
  );
  final separator = _splitTableLine(lines[headerIndex + 1], columnCount);
  _expect(
    separator.every((cell) => RegExp(r'^:?-{3,}:?$').hasMatch(cell)),
    'Malformed table separator: $heading.',
  );

  final rows = <List<String>>[];
  for (var index = headerIndex + 2; index < lines.length; index++) {
    final line = lines[index];
    if (!line.startsWith('|')) {
      break;
    }
    rows.add(_splitTableLine(line, columnCount));
  }
  _expect(rows.isNotEmpty, 'Table has no records: $heading.');
  return rows;
}

List<String> _splitTableLine(String line, int expectedColumns) {
  _expect(line.endsWith('|'), 'Ambiguous Markdown table row: $line');
  final cells = line
      .substring(1, line.length - 1)
      .split('|')
      .map((cell) => cell.trim())
      .toList();
  _expect(
    cells.length == expectedColumns,
    'Unexpected number of columns: expected $expectedColumns, found ${cells.length}.',
  );
  _expect(
    cells.every((cell) => cell.isNotEmpty),
    'Empty table cell is not allowed.',
  );
  return cells;
}

List<_HistoricMapping> _parseHistoricRows(List<List<String>> rows) {
  final mappings = <_HistoricMapping>[];
  final seen = <String>{};
  for (final row in rows) {
    final historical = _idAndName(row[0], 'historic source ID');
    final target = _idAndName(row[2], 'historic destination ID');
    _expect(
      seen.add(historical.id),
      'Duplicate historic ID: ${historical.id}.',
    );
    final affectedPaths = RegExp(
      r'\d+',
    ).allMatches(row[7]).map((match) => int.parse(match.group(0)!)).toList();
    _expect(
      affectedPaths.isNotEmpty,
      'Historic ID ${historical.id} has no affected path occurrence.',
    );
    mappings.add(
      _HistoricMapping(
        id: historical.id,
        namePtPt: historical.name,
        destinationId: target.id,
        affectedPathNumbers: affectedPaths,
      ),
    );
  }
  return mappings;
}

void _validatePreservedHistoricMap(
  List<_HistoricMapping> v04,
  List<_HistoricMapping> v041,
) {
  _expect(
    v04.length == 693,
    'Expected 693 historic v0.3 IDs, found ${v04.length}.',
  );
  _expect(
    v041.length == 693,
    'Expected 693 preserved v0.3 IDs, found ${v041.length}.',
  );
  final v04ById = {for (final item in v04) item.id: item};
  for (final item in v041) {
    final original = v04ById[item.id];
    _expect(
      original != null,
      'v0.4.1 contains unknown historic ID ${item.id}.',
    );
    _expect(
      original!.destinationId == item.destinationId,
      'Historic destination changed for ${item.id}.',
    );
    _expect(
      original.affectedPathNumbers.join(',') ==
          item.affectedPathNumbers.join(','),
      'Historic path occurrences changed for ${item.id}.',
    );
  }
}

List<_Definition> _parseDefinitions(List<List<String>> rows) {
  _expect(
    rows.length == 591,
    'Expected 591 intention definitions, found ${rows.length}.',
  );
  final definitions = <_Definition>[];
  final seen = <String>{};
  for (var index = 0; index < rows.length; index++) {
    final row = rows[index];
    final id = _singleId(row[0], 'final intention ID');
    _expect(seen.add(id), 'Duplicate final intention ID: $id.');
    final effectTarget = _splitRequired(
      row[4],
      'Alvo:',
      id,
      'effect and target',
    );
    final compatibility = _parseCompatibility(row[6], id);
    final occurrence = _parseOccurrenceAndRoles(row[7], id);
    final evidence = _parseEvidence(row[11], id);
    final clinicalAndSafety = _splitRequired(
      _plain(row[13]),
      ';',
      id,
      'clinical review and safety',
    );
    final definition = _Definition(
      id: id,
      namePtPt: _requiredText(row[1], id, 'name'),
      definitionPtPt: _requiredText(row[2], id, 'definition'),
      type: _enumId(row[3], _trainingIntentionTypes, id, 'type'),
      effectPtPt: _requiredText(effectTarget.$1, id, 'effect'),
      primaryTargetPtPt: _requiredText(effectTarget.$2, id, 'primary target'),
      horizon: _enumId(row[5], _horizons, id, 'horizon'),
      usageContextIds: compatibility.contexts,
      capabilityIds: compatibility.capabilities,
      conceptIds: compatibility.concepts,
      occurrenceCount: occurrence.count,
      possibleRoleIds: occurrence.roleIds,
      alternativeIds: _idList(row[8], id, 'alternatives'),
      complementaryIds: _idList(row[9], id, 'complementaries'),
      populationsPtPt: _textList(row[10], id, 'populations'),
      evidenceBasis: evidence.basis,
      sourceCodes: evidence.sourceCodes,
      evidenceLimitPtPt: evidence.limitPtPt,
      reviewState: _requiredText(_stripOuterCode(row[12]), id, 'review state'),
      clinicalReview: _enumId(
        clinicalAndSafety.$1,
        _clinicalReviews,
        id,
        'clinical review',
      ),
      safetyPtPt: _requiredText(clinicalAndSafety.$2, id, 'safety note'),
      riskTier: _enumId(row[14], _riskTiers, id, 'risk tier'),
      sourceOrder: index + 1,
    );
    definitions.add(definition);
  }
  return definitions;
}

List<_Path> _parsePaths(List<List<String>> rows) {
  _expect(rows.length == 280, 'Expected 280 paths, found ${rows.length}.');
  final paths = <_Path>[];
  final seenNumbers = <int>{};
  final seenKeys = <String>{};
  for (final row in rows) {
    final number = int.tryParse(_plain(row[0]));
    _expect(
      number != null && number >= 1 && number <= 280,
      'Invalid path number: ${row[0]}.',
    );
    _expect(seenNumbers.add(number!), 'Duplicate path number: $number.');
    final contextId = _singleId(row[1], 'path context');
    final capabilityId = _singleId(row[2], 'path capability');
    final conceptId = _singleId(row[3], 'path concept');
    final key = '$contextId/$capabilityId/$conceptId';
    _expect(seenKeys.add(key), 'Duplicate path key: $key.');
    final status = _enumId(row[4], _pathStatuses, key, 'path status');
    final finalIntentionIds = _idList(row[7], key, 'path final intentions');
    final priorities = _parsePriorities(row[8], key);
    final destinations = _parseDestinationPairs(row[6], key);
    if (status == 'incompatible') {
      _expect(
        finalIntentionIds.isEmpty,
        'Incompatible path $number has final intentions.',
      );
      _expect(priorities.isEmpty, 'Incompatible path $number has priorities.');
      _expect(
        destinations.isEmpty,
        'Incompatible path $number has historic destinations.',
      );
    } else {
      _expect(
        finalIntentionIds.isNotEmpty,
        'Compatible path $number has no intentions.',
      );
      _expect(
        priorities.length == finalIntentionIds.length,
        'Path $number has mismatched priorities and intentions.',
      );
      _expect(
        destinations.isNotEmpty,
        'Compatible path $number has no historic destinations.',
      );
      _expect(
        priorities.map((priority) => priority.id).join(',') ==
            finalIntentionIds.join(','),
        'Path $number priority order does not match final intention order.',
      );
    }
    paths.add(
      _Path(
        number: number,
        contextId: contextId,
        capabilityId: capabilityId,
        conceptId: conceptId,
        status: status,
        rationalePtPt: _requiredText(row[5], key, 'rationale'),
        destinations: destinations,
        finalIntentionIds: finalIntentionIds,
        priorities: priorities,
        alternativesAndComplementariesPtPt: _requiredText(
          row[9],
          key,
          'alternatives',
        ),
        contextNotesPtPt: _requiredText(row[10], key, 'context notes'),
        riskModifierPtPt: _requiredText(row[11], key, 'risk modifier'),
        clinicalModifierPtPt: _requiredText(row[12], key, 'clinical modifier'),
        limitsPtPt: _requiredText(row[13], key, 'limits'),
        progressionPtPt: _requiredText(row[14], key, 'progression'),
        intensityPtPt: _requiredText(
          row[15],
          key,
          'intensity and prescription',
        ),
        eligibilityPtPt: _requiredText(row[16], key, 'eligibility and safety'),
      ),
    );
  }
  paths.sort((left, right) => left.number.compareTo(right.number));
  _expect(
    paths.map((path) => path.number).join(',') ==
        List<int>.generate(280, (index) => index + 1).join(','),
    'Path numbers are not the closed range 1..280.',
  );
  return paths;
}

List<_ContextualLabel> _parseContextualLabels(
  List<List<String>> rows,
  List<_HistoricMapping> historicMappings,
) {
  _expect(
    rows.length == 59,
    'Expected 59 contextual labels, found ${rows.length}.',
  );
  final historicalById = {for (final item in historicMappings) item.id: item};
  final labels = <_ContextualLabel>[];
  final seen = <String>{};
  for (final row in rows) {
    final historicalId = _singleId(row[0], 'contextual label historic ID');
    final destinationId = _singleId(row[1], 'contextual label destination ID');
    _expect(
      seen.add(historicalId),
      'Duplicate contextual label historic ID: $historicalId.',
    );
    final historic = historicalById[historicalId];
    _expect(
      historic != null,
      'Contextual label has unknown historic ID: $historicalId.',
    );
    _expect(
      historic!.destinationId == destinationId,
      'Contextual label destination differs from historic map: $historicalId.',
    );
    _expect(
      historic.namePtPt.isNotEmpty,
      'Empty contextual label name: $historicalId.',
    );
    labels.add(
      _ContextualLabel(
        historicalId: historicalId,
        destinationId: destinationId,
        labelPtPt: historic.namePtPt,
      ),
    );
  }
  return labels;
}

List<_Link> _parseLinks(
  List<_Path> paths,
  Map<String, _Definition> definitionsById,
  List<_ContextualLabel> labels,
) {
  final labelsByHistoricalId = {
    for (final label in labels) label.historicalId: label,
  };
  final labelAssignments = <String, List<String>>{};
  final assignedHistoricalIds = <String>{};
  for (final path in paths) {
    for (final destination in path.destinations) {
      final label = labelsByHistoricalId[destination.fromId];
      if (label == null) {
        continue;
      }
      _expect(
        destination.toId == label.destinationId,
        'Contextual label ${label.historicalId} has mismatched destination in path ${path.number}.',
      );
      final key = '${path.number}/${destination.toId}';
      labelAssignments.putIfAbsent(key, () => <String>[]).add(label.labelPtPt);
      assignedHistoricalIds.add(label.historicalId);
    }
  }
  _expect(
    assignedHistoricalIds.length == 59,
    'Expected every one of the 59 contextual labels to resolve to a link.',
  );
  _expect(
    labelAssignments.values.every(
      (items) => items.toSet().length == items.length,
    ),
    'A contextual label was assigned more than once to one link.',
  );

  final links = <_Link>[];
  for (final path in paths) {
    for (var index = 0; index < path.priorities.length; index++) {
      final priority = path.priorities[index];
      _expect(
        definitionsById.containsKey(priority.id),
        'Path ${path.number} references unknown final intention ${priority.id}.',
      );
      links.add(
        _Link(
          pathNumber: path.number,
          intentionId: priority.id,
          roleId: priority.roleId,
          displayOrder: index + 1,
          contextualLabelsPtPt: List.unmodifiable(
            labelAssignments['${path.number}/${priority.id}'] ??
                const <String>[],
          ),
        ),
      );
    }
  }
  _expect(
    links.length == 771,
    'Expected 771 path-intention links, found ${links.length}.',
  );
  return links;
}

void _validateRegistry(_RegistryData data) {
  _expect(data.definitions.length == 591, 'Definition count diverged.');
  _expect(data.paths.length == 280, 'Path count diverged.');
  _expect(data.links.length == 771, 'Link count diverged.');
  _expect(data.historicMappings.length == 693, 'Historic ID count diverged.');
  _expect(
    data.historicMappings.expand((item) => item.affectedPathNumbers).length ==
        792,
    'Historic occurrence count diverged.',
  );
  _expect(
    data.contextualLabels.length == 59,
    'Contextual label count diverged.',
  );

  final usageContexts = data.paths.map((path) => path.contextId).toSet();
  final capabilities = data.paths.map((path) => path.capabilityId).toSet();
  final concepts = data.paths.map((path) => path.conceptId).toSet();
  final capabilityConceptRelations = data.paths
      .map((path) => '${path.capabilityId}/${path.conceptId}')
      .toSet();
  _expect(
    usageContexts.length == 7,
    'Expected 7 contexts, found ${usageContexts.length}.',
  );
  _expect(
    capabilities.length == 8,
    'Expected 8 capabilities, found ${capabilities.length}.',
  );
  _expect(
    concepts.length == 35,
    'Expected 35 concepts, found ${concepts.length}.',
  );
  _expect(
    capabilityConceptRelations.length == 40,
    'Expected 40 capability-concept relations, found ${capabilityConceptRelations.length}.',
  );
  _expect(
    data.paths.where((path) => path.status == 'compatible').length == 261,
    'Expected 261 compatible paths.',
  );
  _expect(
    data.paths.where((path) => path.status == 'incompatible').length == 19,
    'Expected 19 incompatible paths.',
  );

  final definitionsById = {for (final item in data.definitions) item.id: item};
  for (final mapping in data.historicMappings) {
    _expect(
      definitionsById.containsKey(mapping.destinationId),
      'Historic ID ${mapping.id} has unknown destination ${mapping.destinationId}.',
    );
  }
  for (final link in data.links) {
    _expect(
      definitionsById.containsKey(link.intentionId),
      'Runtime link references unknown intention ${link.intentionId}.',
    );
  }
  for (final definition in data.definitions) {
    final links = data.links
        .where((link) => link.intentionId == definition.id)
        .toList();
    _expect(
      links.length == definition.occurrenceCount,
      'Occurrence count diverged for ${definition.id}: expected ${definition.occurrenceCount}, found ${links.length}.',
    );
    final linkedRoles = links.map((link) => link.roleId).toSet();
    _expect(
      linkedRoles.every(definition.possibleRoleIds.contains),
      'Link role diverged for ${definition.id}.',
    );
  }

  _expectDistribution(data.definitions.map((item) => item.type), const {
    'adaptation_outcome': 100,
    'acute_preparation': 89,
    'targeted_activation': 98,
    'recovery_activity': 56,
    'cooldown_regulation': 20,
    'prevention_capacity': 102,
    'functional_restoration': 92,
    'technical_learning': 25,
    'self_regulation': 9,
  }, 'intention type');
  _expectDistribution(data.definitions.map((item) => item.riskTier), const {
    'low': 92,
    'moderate': 370,
    'high': 37,
    'clinically_restricted': 92,
  }, 'operational risk');
  _expectDistribution(
    data.definitions.map((item) => item.clinicalReview),
    const {'yes': 100, 'no': 491},
    'clinical review',
  );
  _expectDistribution(
    data.definitions.map((item) => item.evidenceBasis),
    const {
      'strong_family_evidence': 35,
      'moderate_family_evidence': 285,
      'limited_family_evidence': 160,
      'professional_consensus': 92,
      'product_ontology_inference': 19,
    },
    'evidence basis',
  );
  _expectDistribution(data.definitions.map((item) => item.horizon), const {
    'agudo': 263,
    'crónico': 227,
    'agudo e crónico': 9,
    'fase de retorno funcional': 92,
  }, 'horizon');
  _expectDistribution(data.links.map((item) => item.roleId), const {
    'principal_candidate': 238,
    'alternative_primary': 74,
    'complementary': 412,
    'conditional_complementary': 33,
    'hidden_advanced': 14,
  }, 'path-intention role');
  _expectDistribution(
    data.paths.map((item) => _riskModifier(item.riskModifierPtPt)),
    const {
      'inherit_only': 213,
      'may_escalate_to_high': 8,
      'clinically_restricted': 40,
      'not_applicable': 19,
    },
    'path risk modifier',
  );
  _expectDistribution(
    data.paths.map((item) => _clinicalModifier(item.clinicalModifierPtPt)),
    const {'inherit_only': 221, 'required': 40, 'not_applicable': 19},
    'path clinical review modifier',
  );
}

void _expectDistribution(
  Iterable<String> values,
  Map<String, int> expected,
  String name,
) {
  final actual = <String, int>{};
  for (final value in values) {
    actual[value] = (actual[value] ?? 0) + 1;
  }
  _expect(
    actual.length == expected.length &&
        expected.entries.every((entry) => actual[entry.key] == entry.value),
    'Unexpected $name distribution: $actual.',
  );
}

Future<Map<String, String>> _buildOutputs(_RegistryData data) async {
  final rawDart = <String, String>{};
  final partSize = 100;
  final partCount = (data.definitions.length / partSize).ceil();
  for (var part = 0; part < partCount; part++) {
    final start = part * partSize;
    final end = (start + partSize).clamp(0, data.definitions.length);
    final partNumber = (part + 1).toString().padLeft(2, '0');
    rawDart['$_generatedDirectory/training_intentions_registry_part_$partNumber.g.dart'] =
        _renderDefinitionPart(partNumber, data.definitions.sublist(start, end));
  }
  rawDart['$_generatedDirectory/training_intentions_registry.g.dart'] =
      _renderDefinitionRegistry(partCount);
  rawDart['$_generatedDirectory/training_paths_registry.g.dart'] = _renderPaths(
    data.paths,
  );
  rawDart['$_generatedDirectory/training_path_intention_links.g.dart'] =
      _renderLinks(data.links);
  rawDart['$_generatedDirectory/training_intentions_provenance.g.dart'] =
      _renderProvenance(data);

  final formattedDart = await _formatDartOutputs(rawDart);
  final outputs = <String, String>{...formattedDart};
  outputs[_manifestPath] = _renderManifest(data, formattedDart);
  return outputs;
}

Future<Map<String, String>> _formatDartOutputs(
  Map<String, String> sources,
) async {
  final temporaryDirectory = await Directory.systemTemp.createTemp(
    'evefit_training_intentions_generator_',
  );
  try {
    final temporaryPaths = <String>[];
    for (final entry in sources.entries) {
      final destination = File('${temporaryDirectory.path}/${entry.key}');
      await destination.parent.create(recursive: true);
      await destination.writeAsString(entry.value, encoding: utf8);
      temporaryPaths.add(destination.path);
    }
    final result = await Process.run(Platform.resolvedExecutable, [
      'format',
      ...temporaryPaths,
    ]);
    _expect(
      result.exitCode == 0,
      'dart format failed while generating outputs: ${result.stderr}',
    );
    final formatted = <String, String>{};
    for (final relativePath in sources.keys) {
      formatted[relativePath] = await File(
        '${temporaryDirectory.path}/$relativePath',
      ).readAsString(encoding: utf8);
    }
    return formatted;
  } finally {
    if (await temporaryDirectory.exists()) {
      await temporaryDirectory.delete(recursive: true);
    }
  }
}

String _renderDefinitionRegistry(int partCount) {
  final buffer = StringBuffer(_generatedHeader());
  buffer.writeln("import '../../models/training_intention_models.dart';");
  for (var part = 1; part <= partCount; part++) {
    final partNumber = part.toString().padLeft(2, '0');
    buffer.writeln(
      "import 'training_intentions_registry_part_$partNumber.g.dart';",
    );
  }
  buffer.writeln();
  buffer.writeln(
    'const generatedCanonicalTrainingIntentionDefinitions = '
    '<CanonicalTrainingIntentionDefinition>[',
  );
  for (var part = 1; part <= partCount; part++) {
    final partNumber = part.toString().padLeft(2, '0');
    buffer.writeln(
      '  ...generatedCanonicalTrainingIntentionDefinitionsPart$partNumber,',
    );
  }
  buffer.writeln('];');
  return buffer.toString();
}

String _renderDefinitionPart(String partNumber, List<_Definition> definitions) {
  final buffer = StringBuffer(_generatedHeader());
  buffer.writeln("import '../../models/canonical_core_models.dart';");
  buffer.writeln("import '../../models/training_intention_models.dart';");
  buffer.writeln();
  buffer.writeln(
    'const generatedCanonicalTrainingIntentionDefinitionsPart$partNumber = '
    '<CanonicalTrainingIntentionDefinition>[',
  );
  for (final definition in definitions) {
    _writeDefinition(buffer, definition);
  }
  buffer.writeln('];');
  return buffer.toString();
}

void _writeDefinition(StringBuffer buffer, _Definition item) {
  buffer.writeln('  CanonicalTrainingIntentionDefinition(');
  buffer.writeln('    pillar: CanonicalPillarDefinition(');
  buffer.writeln('      id: ${_dart(item.id)},');
  buffer.writeln('      axis: CanonicalPillarAxis.trainingIntention,');
  buffer.writeln('      displayNamePtPt: ${_dart(item.namePtPt)},');
  buffer.writeln('      descriptionPtPt: ${_dart(item.definitionPtPt)},');
  buffer.writeln('      status: CanonicalDefinitionStatus.approved,');
  buffer.writeln('      displayOrder: ${item.sourceOrder},');
  buffer.writeln('      iconKey: CanonicalCoreIconKey.intentionAxis,');
  buffer.writeln('    ),');
  buffer.writeln('    type: ${_typeExpression(item.type)},');
  buffer.writeln('    effectPtPt: ${_dart(item.effectPtPt)},');
  buffer.writeln('    primaryTargetPtPt: ${_dart(item.primaryTargetPtPt)},');
  buffer.writeln('    horizon: ${_horizonExpression(item.horizon)},');
  _writeStringList(buffer, 'declaredUsageContextIds', item.usageContextIds);
  _writeStringList(buffer, 'declaredCapabilityRootIds', item.capabilityIds);
  _writeStringList(buffer, 'declaredTrainingConceptIds', item.conceptIds);
  buffer.writeln('    occurrenceCount: ${item.occurrenceCount},');
  _writeExpressionList(
    buffer,
    'possibleRoles',
    item.possibleRoleIds.map(_roleExpression).toList(),
  );
  _writeStringList(
    buffer,
    'globallyIncompatibleAlternativeIds',
    item.alternativeIds,
  );
  _writeStringList(
    buffer,
    'globallyCompatibleComplementaryIds',
    item.complementaryIds,
  );
  _writeStringList(buffer, 'relevantPopulationPtPt', item.populationsPtPt);
  buffer.writeln(
    '    evidenceBasis: ${_evidenceExpression(item.evidenceBasis)},',
  );
  _writeStringList(buffer, 'sourceCodes', item.sourceCodes);
  buffer.writeln('    evidenceLimitPtPt: ${_dart(item.evidenceLimitPtPt)},');
  buffer.writeln('    reviewState: ${_dart(item.reviewState)},');
  buffer.writeln(
    '    clinicalReviewRequired: ${_clinicalReviewExpression(item.clinicalReview)},',
  );
  buffer.writeln('    operationalRiskTier: ${_riskExpression(item.riskTier)},');
  buffer.writeln('    generalSafetyNotePtPt: ${_dart(item.safetyPtPt)},');
  buffer.writeln('    sourceOrder: ${item.sourceOrder},');
  buffer.writeln("    sourceRegistryVersion: '$_registryVersion',");
  buffer.writeln("    runtimeProvenanceId: '$_provenanceId',");
  buffer.writeln('  ),');
}

String _renderPaths(List<_Path> paths) {
  final buffer = StringBuffer(_generatedHeader());
  buffer.writeln("import '../../models/training_intention_models.dart';");
  buffer.writeln();
  buffer.writeln(
    'const generatedCanonicalTrainingPaths = <CanonicalTrainingPathDefinition>[',
  );
  for (final path in paths) {
    buffer.writeln('  CanonicalTrainingPathDefinition(');
    buffer.writeln('    sourceNumber: ${path.number},');
    buffer.writeln('    key: CanonicalTrainingPathKey(');
    buffer.writeln('      usageContextId: ${_dart(path.contextId)},');
    buffer.writeln('      capabilityRootId: ${_dart(path.capabilityId)},');
    buffer.writeln('      trainingConceptId: ${_dart(path.conceptId)},');
    buffer.writeln('    ),');
    buffer.writeln('    status: ${_pathStatusExpression(path.status)},');
    buffer.writeln('    rationalePtPt: ${_dart(path.rationalePtPt)},');
    buffer.writeln('    contextNotesPtPt: ${_dart(path.contextNotesPtPt)},');
    buffer.writeln(
      '    alternativesAndComplementariesPtPt: '
      '${_dart(path.alternativesAndComplementariesPtPt)},',
    );
    buffer.writeln('    limitsPtPt: ${_dart(path.limitsPtPt)},');
    buffer.writeln('    progressionPtPt: ${_dart(path.progressionPtPt)},');
    buffer.writeln(
      '    intensityAndPrescriptionPtPt: ${_dart(path.intensityPtPt)},',
    );
    buffer.writeln(
      '    eligibilityAndSafetyPtPt: ${_dart(path.eligibilityPtPt)},',
    );
    buffer.writeln(
      '    operationalRiskModifier: '
      '${_riskModifierExpression(_riskModifier(path.riskModifierPtPt))},',
    );
    buffer.writeln(
      '    operationalRiskModifierPtPt: ${_dart(path.riskModifierPtPt)},',
    );
    buffer.writeln(
      '    clinicalReviewModifier: '
      '${_clinicalModifierExpression(_clinicalModifier(path.clinicalModifierPtPt))},',
    );
    buffer.writeln(
      '    clinicalReviewModifierPtPt: ${_dart(path.clinicalModifierPtPt)},',
    );
    buffer.writeln("    sourceRegistryVersion: '$_registryVersion',");
    buffer.writeln("    runtimeProvenanceId: '$_provenanceId',");
    buffer.writeln('  ),');
  }
  buffer.writeln('];');
  return buffer.toString();
}

String _renderLinks(List<_Link> links) {
  final buffer = StringBuffer(_generatedHeader());
  buffer.writeln("import '../../models/training_intention_models.dart';");
  buffer.writeln();
  buffer.writeln(
    'const generatedCanonicalPathIntentionLinks = <CanonicalPathIntentionLink>[',
  );
  for (final link in links) {
    buffer.writeln('  CanonicalPathIntentionLink(');
    buffer.writeln('    pathSourceNumber: ${link.pathNumber},');
    buffer.writeln('    intentionId: ${_dart(link.intentionId)},');
    buffer.writeln('    role: ${_roleExpression(link.roleId)},');
    buffer.writeln('    displayOrder: ${link.displayOrder},');
    _writeStringList(buffer, 'contextualLabelsPtPt', link.contextualLabelsPtPt);
    buffer.writeln("    sourceRegistryVersion: '$_registryVersion',");
    buffer.writeln("    runtimeProvenanceId: '$_provenanceId',");
    buffer.writeln('  ),');
  }
  buffer.writeln('];');
  return buffer.toString();
}

String _renderProvenance(_RegistryData data) {
  final buffer = StringBuffer(_generatedHeader());
  buffer.writeln(
    "const generatedTrainingIntentionsRegistryVersion = '$_registryVersion';",
  );
  buffer.writeln(
    "const generatedTrainingIntentionsGeneratorVersion = '$_generatorVersion';",
  );
  buffer.writeln(
    "const generatedTrainingIntentionsV04Sha256 = '$_sourceV04Hash';",
  );
  buffer.writeln(
    "const generatedTrainingIntentionsV041Sha256 = '$_sourceV041Hash';",
  );
  buffer.writeln(
    "const generatedTrainingIntentionsProvenanceId = '$_provenanceId';",
  );
  buffer.writeln(
    'const generatedTrainingIntentionsStructuralCounts = <String, int>{',
  );
  for (final entry in _structuralCounts(data).entries) {
    buffer.writeln("  '${entry.key}': ${entry.value},");
  }
  buffer.writeln('};');
  return buffer.toString();
}

String _renderManifest(_RegistryData data, Map<String, String> dartOutputs) {
  final contextualLabels = data.links
      .where((link) => link.contextualLabelsPtPt.isNotEmpty)
      .expand(
        (link) => link.contextualLabelsPtPt.map(
          (label) => <String, Object>{
            'path_source_number': link.pathNumber,
            'intention_id': link.intentionId,
            'label_pt_pt': label,
          },
        ),
      )
      .toList();
  final outputHashes = <String, String>{
    for (final entry in dartOutputs.entries)
      entry.key: _sha256(utf8.encode(entry.value)),
  };
  final historicRepresentation =
      data.historicMappings
          .map(
            (item) =>
                '${item.id}|${item.destinationId}|${item.affectedPathNumbers.join(',')}',
          )
          .toList()
        ..sort();
  final manifest = <String, Object>{
    'generator_version': _generatorVersion,
    'registry_version': _registryVersion,
    'generation_id': _provenanceId,
    'source_files': <String, Object>{
      _sourceV04Path: <String, Object>{'sha256': data.sourceV04.hash},
      _sourceV041Path: <String, Object>{'sha256': data.sourceV041.hash},
    },
    'output_hashes_normalized': outputHashes,
    'counts': _structuralCounts(data),
    'distributions': <String, Object>{
      'type': _distribution(data.definitions.map((item) => item.type)),
      'operational_risk_tier': _distribution(
        data.definitions.map((item) => item.riskTier),
      ),
      'clinical_review_required': _distribution(
        data.definitions.map((item) => item.clinicalReview),
      ),
      'evidence_basis': _distribution(
        data.definitions.map((item) => item.evidenceBasis),
      ),
      'horizon': _distribution(data.definitions.map((item) => item.horizon)),
      'path_intention_role': _distribution(
        data.links.map((item) => item.roleId),
      ),
      'path_operational_risk_modifier': _distribution(
        data.paths.map((item) => _riskModifier(item.riskModifierPtPt)),
      ),
      'path_clinical_review_modifier': _distribution(
        data.paths.map((item) => _clinicalModifier(item.clinicalModifierPtPt)),
      ),
    },
    'contextual_labels': <String, Object>{
      'unique_labels_pt_pt':
          (data.contextualLabels.map((label) => label.labelPtPt).toList()
            ..sort()),
      'resolved_link_occurrences': contextualLabels,
    },
    'historic_v03_audit': <String, Object>{
      'unique_ids': data.historicMappings.length,
      'occurrences': data.historicMappings
          .expand((item) => item.affectedPathNumbers)
          .length,
      'normalized_mapping_sha256': _sha256(
        utf8.encode('${historicRepresentation.join('\n')}\n'),
      ),
      'complete_mapping_validated': true,
      'all_historic_ids_have_destination': true,
      'no_historic_destination_is_unknown': true,
      'complete_mapping_emitted_to_runtime': false,
    },
    'runtime_separation': <String, Object>{
      'markdown_parsed_at_runtime': false,
      'executable_equipment_fields_present': false,
      'executable_environment_fields_present': false,
      'legacy_v03_ids_present_in_runtime_queries': false,
      'historic_reasons_present_in_runtime': false,
      'historic_ledger_present_in_runtime': false,
    },
  };
  return '${const JsonEncoder.withIndent('  ').convert(manifest)}\n';
}

Map<String, int> _structuralCounts(_RegistryData data) => <String, int>{
  'active_contexts': 7,
  'capabilities': 8,
  'concepts': 35,
  'capability_concept_relations': 40,
  'paths': data.paths.length,
  'compatible_paths': data.paths
      .where((path) => path.status == 'compatible')
      .length,
  'incompatible_paths': data.paths
      .where((path) => path.status == 'incompatible')
      .length,
  'global_intentions': data.definitions.length,
  'path_intention_links': data.links.length,
  'historic_v03_ids': data.historicMappings.length,
  'historic_v03_occurrences': data.historicMappings
      .expand((item) => item.affectedPathNumbers)
      .length,
  'contextual_labels': data.contextualLabels.length,
};

Map<String, int> _distribution(Iterable<String> values) {
  final distribution = <String, int>{};
  for (final value in values) {
    distribution[value] = (distribution[value] ?? 0) + 1;
  }
  return Map<String, int>.fromEntries(
    distribution.entries.toList()
      ..sort((left, right) => left.key.compareTo(right.key)),
  );
}

Future<void> _writeOutputs(Map<String, String> outputs) async {
  for (final entry in outputs.entries) {
    final file = File(entry.key);
    await file.parent.create(recursive: true);
    await file.writeAsString(entry.value, encoding: utf8);
  }
}

void _checkOutputs(Map<String, String> expected) {
  for (final entry in expected.entries) {
    final file = File(entry.key);
    _expect(file.existsSync(), 'Missing generated output: ${entry.key}.');
    final actual = file.readAsStringSync(encoding: utf8);
    _expect(
      actual == entry.value,
      'Generated output diverges: ${entry.key}. Run generate.',
    );
  }
  final generatedDirectory = Directory(_generatedDirectory);
  _expect(generatedDirectory.existsSync(), 'Generated directory is missing.');
  final expectedDartPaths = expected.keys
      .where((path) => path.endsWith('.dart'))
      .toSet();
  final actualDartPaths = generatedDirectory
      .listSync(recursive: true)
      .whereType<File>()
      .map((file) => file.path.replaceAll('\\', '/'))
      .where((path) => path.endsWith('.dart'))
      .map((path) => path.replaceFirst('./', ''))
      .toSet();
  _expect(
    actualDartPaths.containsAll(expectedDartPaths) &&
        expectedDartPaths.containsAll(actualDartPaths),
    'Generated directory contains unexpected Dart outputs.',
  );
}

String _report(_RegistryData data) {
  final counts = _structuralCounts(data);
  final lines = <String>[
    'Training intentions registry report',
    'generator_version: $_generatorVersion',
    'registry_version: $_registryVersion',
    'source_v0.4_sha256: ${data.sourceV04.hash}',
    'source_v0.4.1_sha256: ${data.sourceV041.hash}',
    ...counts.entries.map((entry) => '${entry.key}: ${entry.value}'),
    'historic_mapping_validated: true',
    'runtime_markdown_parsing: false',
    'runtime_legacy_v0.3_ids: false',
    'runtime_executable_equipment: false',
    'runtime_executable_environment: false',
  ];
  return lines.join('\n');
}

String _generatedHeader() =>
    '// GENERATED CODE - DO NOT MODIFY BY HAND.\n'
    '// Source registry: v0.4.1; SHA-256: $_sourceV041Hash\n'
    '// Generator: $_generatorVersion; provenance: $_provenanceId\n\n';

void _writeStringList(StringBuffer buffer, String name, List<String> values) {
  buffer.writeln('    $name: <String>[');
  for (final value in values) {
    buffer.writeln('      ${_dart(value)},');
  }
  buffer.writeln('    ],');
}

void _writeExpressionList(
  StringBuffer buffer,
  String name,
  List<String> values,
) {
  buffer.writeln('    $name: <CanonicalTrainingIntentionRole>[');
  for (final value in values) {
    buffer.writeln('      $value,');
  }
  buffer.writeln('    ],');
}

String _dart(String value) {
  final escaped = value
      .replaceAll('\\', '\\\\')
      .replaceAll("'", "\\'")
      .replaceAll(r'$', r'\$')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\r');
  return "'$escaped'";
}

String _typeExpression(String value) => switch (value) {
  'adaptation_outcome' => 'CanonicalTrainingIntentionType.adaptationOutcome',
  'acute_preparation' => 'CanonicalTrainingIntentionType.acutePreparation',
  'targeted_activation' => 'CanonicalTrainingIntentionType.targetedActivation',
  'recovery_activity' => 'CanonicalTrainingIntentionType.recoveryActivity',
  'cooldown_regulation' => 'CanonicalTrainingIntentionType.cooldownRegulation',
  'prevention_capacity' => 'CanonicalTrainingIntentionType.preventionCapacity',
  'functional_restoration' =>
    'CanonicalTrainingIntentionType.functionalRestoration',
  'technical_learning' => 'CanonicalTrainingIntentionType.technicalLearning',
  'self_regulation' => 'CanonicalTrainingIntentionType.selfRegulation',
  _ => throw _GeneratorFailure('Unknown intention type: $value.'),
};

String _roleExpression(String value) => switch (value) {
  'principal_candidate' => 'CanonicalTrainingIntentionRole.principalCandidate',
  'alternative_primary' => 'CanonicalTrainingIntentionRole.alternativePrimary',
  'complementary' => 'CanonicalTrainingIntentionRole.complementary',
  'conditional_complementary' =>
    'CanonicalTrainingIntentionRole.conditionalComplementary',
  'hidden_advanced' => 'CanonicalTrainingIntentionRole.hiddenAdvanced',
  _ => throw _GeneratorFailure('Unknown intention role: $value.'),
};

String _riskExpression(String value) => switch (value) {
  'low' => 'CanonicalOperationalRiskTier.low',
  'moderate' => 'CanonicalOperationalRiskTier.moderate',
  'high' => 'CanonicalOperationalRiskTier.high',
  'clinically_restricted' =>
    'CanonicalOperationalRiskTier.clinicallyRestricted',
  _ => throw _GeneratorFailure('Unknown operational risk tier: $value.'),
};

String _evidenceExpression(String value) => switch (value) {
  'strong_family_evidence' => 'CanonicalEvidenceBasis.strongFamilyEvidence',
  'moderate_family_evidence' => 'CanonicalEvidenceBasis.moderateFamilyEvidence',
  'limited_family_evidence' => 'CanonicalEvidenceBasis.limitedFamilyEvidence',
  'professional_consensus' => 'CanonicalEvidenceBasis.professionalConsensus',
  'product_ontology_inference' =>
    'CanonicalEvidenceBasis.productOntologyInference',
  _ => throw _GeneratorFailure('Unknown evidence basis: $value.'),
};

String _horizonExpression(String value) => switch (value) {
  'agudo' => 'CanonicalTrainingHorizon.acute',
  'crónico' => 'CanonicalTrainingHorizon.chronic',
  'agudo e crónico' => 'CanonicalTrainingHorizon.acuteAndChronic',
  'fase de retorno funcional' =>
    'CanonicalTrainingHorizon.functionalReturnPhase',
  _ => throw _GeneratorFailure('Unknown horizon: $value.'),
};

String _clinicalReviewExpression(String value) => switch (value) {
  'yes' => 'CanonicalClinicalReviewRequirement.yes',
  'no' => 'CanonicalClinicalReviewRequirement.no',
  _ => throw _GeneratorFailure('Unknown clinical review requirement: $value.'),
};

String _pathStatusExpression(String value) => switch (value) {
  'compatible' => 'CanonicalTrainingPathStatus.compatible',
  'incompatible' => 'CanonicalTrainingPathStatus.incompatible',
  _ => throw _GeneratorFailure('Unknown path status: $value.'),
};

String _riskModifierExpression(String value) => switch (value) {
  'inherit_only' => 'CanonicalPathOperationalRiskModifier.inheritOnly',
  'may_escalate_to_high' =>
    'CanonicalPathOperationalRiskModifier.mayEscalateToHigh',
  'clinically_restricted' =>
    'CanonicalPathOperationalRiskModifier.clinicallyRestricted',
  'not_applicable' => 'CanonicalPathOperationalRiskModifier.notApplicable',
  _ => throw _GeneratorFailure('Unknown path risk modifier: $value.'),
};

String _clinicalModifierExpression(String value) => switch (value) {
  'inherit_only' => 'CanonicalPathClinicalReviewModifier.inheritOnly',
  'required' => 'CanonicalPathClinicalReviewModifier.required',
  'not_applicable' => 'CanonicalPathClinicalReviewModifier.notApplicable',
  _ => throw _GeneratorFailure(
    'Unknown path clinical review modifier: $value.',
  ),
};

String _riskModifier(String raw) {
  final value = _plain(raw);
  if (value == 'não aplicável') {
    return 'not_applicable';
  }
  if (value.contains('pode agravar para `high`')) {
    return 'may_escalate_to_high';
  }
  if (value.contains('`clinically_restricted`')) {
    return 'clinically_restricted';
  }
  if (value.startsWith('sem agravamento automático')) {
    return 'inherit_only';
  }
  _fail('Unknown path operational risk modifier: $raw');
}

String _clinicalModifier(String raw) {
  final value = _plain(raw);
  if (value == 'não aplicável') {
    return 'not_applicable';
  }
  if (value.startsWith('`yes`')) {
    return 'required';
  }
  if (value.startsWith('herda a intenção')) {
    return 'inherit_only';
  }
  _fail('Unknown path clinical review modifier: $raw');
}

_Compatibility _parseCompatibility(String raw, String id) {
  final value = _plain(raw);
  final match = RegExp(
    r'^Ctxt: (.+); cap: (.+); conc: (.+)$',
  ).firstMatch(value);
  _expect(match != null, 'Malformed compatibility for $id: $raw');
  return _Compatibility(
    contexts: _idList(match!.group(1)!, id, 'contexts'),
    capabilities: _idList(match.group(2)!, id, 'capabilities'),
    concepts: _idList(match.group(3)!, id, 'concepts'),
  );
}

_Occurrence _parseOccurrenceAndRoles(String raw, String id) {
  final value = _plain(raw);
  final match = RegExp(r'^(\d+); (.+)$').firstMatch(value);
  _expect(match != null, 'Malformed occurrence and roles for $id: $raw');
  final count = int.parse(match!.group(1)!);
  final roleCounts = <String, int>{};
  for (final roleMatch in RegExp(
    r'([a-z_]+):(\d+)',
  ).allMatches(match.group(2)!)) {
    final role = roleMatch.group(1)!;
    _expect(
      _trainingIntentionRoles.contains(role),
      'Unknown role $role for $id.',
    );
    _expect(!roleCounts.containsKey(role), 'Duplicate role $role for $id.');
    roleCounts[role] = int.parse(roleMatch.group(2)!);
  }
  _expect(roleCounts.isNotEmpty, 'No roles for $id.');
  _expect(
    roleCounts.values.reduce((left, right) => left + right) == count,
    'Role count diverges from occurrence count for $id.',
  );
  return _Occurrence(count, roleCounts.keys.toList());
}

_Evidence _parseEvidence(String raw, String id) {
  final value = _plain(raw);
  final firstSeparator = value.indexOf(';');
  _expect(firstSeparator > 0, 'Malformed evidence basis for $id.');
  final basis = _stripOuterCode(value.substring(0, firstSeparator).trim());
  _expect(
    _evidenceBases.contains(basis),
    'Unknown evidence basis $basis for $id.',
  );
  final sourceCodes = RegExp(
    r'SRC-\d+',
  ).allMatches(value).map((match) => match.group(0)!).toList();
  _expect(sourceCodes.isNotEmpty, 'Missing source codes for $id.');
  final lastSource = value.lastIndexOf(sourceCodes.last);
  final limit = value
      .substring(lastSource + sourceCodes.last.length)
      .replaceFirst(';', '')
      .trim();
  _expect(limit.isNotEmpty, 'Missing evidence limit for $id.');
  return _Evidence(basis, sourceCodes, limit);
}

List<_Priority> _parsePriorities(String raw, String pathKey) {
  if (_isNone(raw)) {
    return const <_Priority>[];
  }
  final priorities = <_Priority>[];
  final seen = <String>{};
  final matches = RegExp(r'`([a-z0-9_]+)`:([a-z_]+)').allMatches(raw).toList();
  _expect(matches.isNotEmpty, 'Malformed priorities for $pathKey.');
  for (final match in matches) {
    final id = match.group(1)!;
    final roleId = match.group(2)!;
    _expect(seen.add(id), 'Duplicate priority ID $id for $pathKey.');
    _expect(
      _trainingIntentionRoles.contains(roleId),
      'Unknown priority role $roleId.',
    );
    priorities.add(_Priority(id, roleId));
  }
  return priorities;
}

List<_DestinationPair> _parseDestinationPairs(String raw, String pathKey) {
  if (_isNone(raw)) {
    return const <_DestinationPair>[];
  }
  final pairs = <_DestinationPair>[];
  final matches = RegExp(
    r'`([a-z0-9_]+)`→`([a-z0-9_]+)`',
  ).allMatches(raw).toList();
  _expect(matches.isNotEmpty, 'Malformed historic destinations for $pathKey.');
  for (final match in matches) {
    pairs.add(_DestinationPair(match.group(1)!, match.group(2)!));
  }
  return pairs;
}

List<String> _idList(String raw, String owner, String field) {
  if (_isNone(raw)) {
    return const <String>[];
  }
  final ids = RegExp(
    r'`([a-z0-9_]+)`',
  ).allMatches(raw).map((match) => match.group(1)!).toList();
  _expect(ids.isNotEmpty, 'Missing $field IDs for $owner.');
  _expect(ids.toSet().length == ids.length, 'Duplicate $field ID for $owner.');
  return ids;
}

List<String> _textList(String raw, String owner, String field) {
  final value = _plain(raw);
  final items = value
      .split(';')
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toList();
  _expect(items.isNotEmpty, 'Missing $field for $owner.');
  return items;
}

String _singleId(String raw, String field) {
  final ids = _idList(raw, field, field);
  _expect(ids.length == 1, 'Expected one $field, found ${ids.length}.');
  return ids.single;
}

_IdAndName _idAndName(String raw, String field) {
  final match = RegExp(r'^`([a-z0-9_]+)` · (.+)$').firstMatch(_plain(raw));
  _expect(match != null, 'Malformed $field: $raw');
  final name = match!.group(2)!.trim();
  _expect(name.isNotEmpty, 'Missing name for $field.');
  return _IdAndName(match.group(1)!, name);
}

(String, String) _splitRequired(
  String raw,
  String separator,
  String owner,
  String field,
) {
  final value = _plain(raw);
  final index = value.indexOf(separator);
  _expect(
    index > 0 && index + separator.length < value.length,
    'Malformed $field for $owner.',
  );
  return (
    value.substring(0, index).trim(),
    value.substring(index + separator.length).trim(),
  );
}

String _requiredText(String raw, String owner, String field) {
  final value = _plain(raw);
  _expect(value.isNotEmpty, 'Missing $field for $owner.');
  return value;
}

String _enumId(String raw, Set<String> allowed, String owner, String field) {
  final value = _plain(raw);
  final id = RegExp(r'^`?([^`]+?)`?$').firstMatch(value)?.group(1)?.trim();
  _expect(
    id != null && allowed.contains(id),
    'Unknown $field for $owner: $raw.',
  );
  return id!;
}

bool _isNone(String raw) {
  final value = _plain(raw).toLowerCase();
  return value == 'nenhum' ||
      value == 'nenhuma ocorrência' ||
      value == 'não aplicável';
}

String _plain(String raw) => raw.trim().replaceAll('**', '').trim();

String _stripOuterCode(String value) =>
    value.startsWith('`') && value.endsWith('`')
    ? value.substring(1, value.length - 1)
    : value;

const _trainingIntentionTypes = <String>{
  'adaptation_outcome',
  'acute_preparation',
  'targeted_activation',
  'recovery_activity',
  'cooldown_regulation',
  'prevention_capacity',
  'functional_restoration',
  'technical_learning',
  'self_regulation',
};
const _trainingIntentionRoles = <String>{
  'principal_candidate',
  'alternative_primary',
  'complementary',
  'conditional_complementary',
  'hidden_advanced',
};
const _riskTiers = <String>{'low', 'moderate', 'high', 'clinically_restricted'};
const _evidenceBases = <String>{
  'strong_family_evidence',
  'moderate_family_evidence',
  'limited_family_evidence',
  'professional_consensus',
  'product_ontology_inference',
};
const _horizons = <String>{
  'agudo',
  'crónico',
  'agudo e crónico',
  'fase de retorno funcional',
};
const _clinicalReviews = <String>{'yes', 'no'};
const _pathStatuses = <String>{'compatible', 'incompatible'};

String _sha256(List<int> source) {
  const mask = 0xffffffff;
  const words = <int>[
    0x428a2f98,
    0x71374491,
    0xb5c0fbcf,
    0xe9b5dba5,
    0x3956c25b,
    0x59f111f1,
    0x923f82a4,
    0xab1c5ed5,
    0xd807aa98,
    0x12835b01,
    0x243185be,
    0x550c7dc3,
    0x72be5d74,
    0x80deb1fe,
    0x9bdc06a7,
    0xc19bf174,
    0xe49b69c1,
    0xefbe4786,
    0x0fc19dc6,
    0x240ca1cc,
    0x2de92c6f,
    0x4a7484aa,
    0x5cb0a9dc,
    0x76f988da,
    0x983e5152,
    0xa831c66d,
    0xb00327c8,
    0xbf597fc7,
    0xc6e00bf3,
    0xd5a79147,
    0x06ca6351,
    0x14292967,
    0x27b70a85,
    0x2e1b2138,
    0x4d2c6dfc,
    0x53380d13,
    0x650a7354,
    0x766a0abb,
    0x81c2c92e,
    0x92722c85,
    0xa2bfe8a1,
    0xa81a664b,
    0xc24b8b70,
    0xc76c51a3,
    0xd192e819,
    0xd6990624,
    0xf40e3585,
    0x106aa070,
    0x19a4c116,
    0x1e376c08,
    0x2748774c,
    0x34b0bcb5,
    0x391c0cb3,
    0x4ed8aa4a,
    0x5b9cca4f,
    0x682e6ff3,
    0x748f82ee,
    0x78a5636f,
    0x84c87814,
    0x8cc70208,
    0x90befffa,
    0xa4506ceb,
    0xbef9a3f7,
    0xc67178f2,
  ];
  final bytes = Uint8List.fromList(source);
  final bitLength = bytes.length * 8;
  final padded = <int>[...bytes, 0x80];
  while (padded.length % 64 != 56) {
    padded.add(0);
  }
  for (var shift = 56; shift >= 0; shift -= 8) {
    padded.add((bitLength >> shift) & 0xff);
  }
  var h0 = 0x6a09e667;
  var h1 = 0xbb67ae85;
  var h2 = 0x3c6ef372;
  var h3 = 0xa54ff53a;
  var h4 = 0x510e527f;
  var h5 = 0x9b05688c;
  var h6 = 0x1f83d9ab;
  var h7 = 0x5be0cd19;
  for (var offset = 0; offset < padded.length; offset += 64) {
    final schedule = List<int>.filled(64, 0);
    for (var index = 0; index < 16; index++) {
      final start = offset + (index * 4);
      schedule[index] =
          (padded[start] << 24) |
          (padded[start + 1] << 16) |
          (padded[start + 2] << 8) |
          padded[start + 3];
    }
    for (var index = 16; index < 64; index++) {
      final sigma0 =
          _rotateRight(schedule[index - 15], 7) ^
          _rotateRight(schedule[index - 15], 18) ^
          (schedule[index - 15] >>> 3);
      final sigma1 =
          _rotateRight(schedule[index - 2], 17) ^
          _rotateRight(schedule[index - 2], 19) ^
          (schedule[index - 2] >>> 10);
      schedule[index] =
          (schedule[index - 16] + sigma0 + schedule[index - 7] + sigma1) & mask;
    }
    var a = h0;
    var b = h1;
    var c = h2;
    var d = h3;
    var e = h4;
    var f = h5;
    var g = h6;
    var h = h7;
    for (var index = 0; index < 64; index++) {
      final sigma1 =
          _rotateRight(e, 6) ^ _rotateRight(e, 11) ^ _rotateRight(e, 25);
      final choice = (e & f) ^ ((~e) & g);
      final temporary1 =
          (h + sigma1 + choice + words[index] + schedule[index]) & mask;
      final sigma0 =
          _rotateRight(a, 2) ^ _rotateRight(a, 13) ^ _rotateRight(a, 22);
      final majority = (a & b) ^ (a & c) ^ (b & c);
      final temporary2 = (sigma0 + majority) & mask;
      h = g;
      g = f;
      f = e;
      e = (d + temporary1) & mask;
      d = c;
      c = b;
      b = a;
      a = (temporary1 + temporary2) & mask;
    }
    h0 = (h0 + a) & mask;
    h1 = (h1 + b) & mask;
    h2 = (h2 + c) & mask;
    h3 = (h3 + d) & mask;
    h4 = (h4 + e) & mask;
    h5 = (h5 + f) & mask;
    h6 = (h6 + g) & mask;
    h7 = (h7 + h) & mask;
  }
  return [
    h0,
    h1,
    h2,
    h3,
    h4,
    h5,
    h6,
    h7,
  ].map((word) => word.toRadixString(16).padLeft(8, '0')).join();
}

int _rotateRight(int value, int amount) =>
    ((value >>> amount) | (value << (32 - amount))) & 0xffffffff;

void _expect(bool condition, String message) {
  if (!condition) {
    _fail(message);
  }
}

Never _fail(String message) => throw _GeneratorFailure(message);

class _GeneratorFailure implements Exception {
  const _GeneratorFailure(this.message);

  final String message;
}

class _SourceDocument {
  const _SourceDocument(this.path, this.bytes, this.text, this.hash);

  final String path;
  final Uint8List bytes;
  final String text;
  final String hash;
}

class _IdAndName {
  const _IdAndName(this.id, this.name);

  final String id;
  final String name;
}

class _HistoricMapping {
  const _HistoricMapping({
    required this.id,
    required this.namePtPt,
    required this.destinationId,
    required this.affectedPathNumbers,
  });

  final String id;
  final String namePtPt;
  final String destinationId;
  final List<int> affectedPathNumbers;
}

class _Compatibility {
  const _Compatibility({
    required this.contexts,
    required this.capabilities,
    required this.concepts,
  });

  final List<String> contexts;
  final List<String> capabilities;
  final List<String> concepts;
}

class _Occurrence {
  const _Occurrence(this.count, this.roleIds);

  final int count;
  final List<String> roleIds;
}

class _Evidence {
  const _Evidence(this.basis, this.sourceCodes, this.limitPtPt);

  final String basis;
  final List<String> sourceCodes;
  final String limitPtPt;
}

class _Definition {
  const _Definition({
    required this.id,
    required this.namePtPt,
    required this.definitionPtPt,
    required this.type,
    required this.effectPtPt,
    required this.primaryTargetPtPt,
    required this.horizon,
    required this.usageContextIds,
    required this.capabilityIds,
    required this.conceptIds,
    required this.occurrenceCount,
    required this.possibleRoleIds,
    required this.alternativeIds,
    required this.complementaryIds,
    required this.populationsPtPt,
    required this.evidenceBasis,
    required this.sourceCodes,
    required this.evidenceLimitPtPt,
    required this.reviewState,
    required this.clinicalReview,
    required this.safetyPtPt,
    required this.riskTier,
    required this.sourceOrder,
  });

  final String id;
  final String namePtPt;
  final String definitionPtPt;
  final String type;
  final String effectPtPt;
  final String primaryTargetPtPt;
  final String horizon;
  final List<String> usageContextIds;
  final List<String> capabilityIds;
  final List<String> conceptIds;
  final int occurrenceCount;
  final List<String> possibleRoleIds;
  final List<String> alternativeIds;
  final List<String> complementaryIds;
  final List<String> populationsPtPt;
  final String evidenceBasis;
  final List<String> sourceCodes;
  final String evidenceLimitPtPt;
  final String reviewState;
  final String clinicalReview;
  final String safetyPtPt;
  final String riskTier;
  final int sourceOrder;
}

class _DestinationPair {
  const _DestinationPair(this.fromId, this.toId);

  final String fromId;
  final String toId;
}

class _Priority {
  const _Priority(this.id, this.roleId);

  final String id;
  final String roleId;
}

class _Path {
  const _Path({
    required this.number,
    required this.contextId,
    required this.capabilityId,
    required this.conceptId,
    required this.status,
    required this.rationalePtPt,
    required this.destinations,
    required this.finalIntentionIds,
    required this.priorities,
    required this.alternativesAndComplementariesPtPt,
    required this.contextNotesPtPt,
    required this.riskModifierPtPt,
    required this.clinicalModifierPtPt,
    required this.limitsPtPt,
    required this.progressionPtPt,
    required this.intensityPtPt,
    required this.eligibilityPtPt,
  });

  final int number;
  final String contextId;
  final String capabilityId;
  final String conceptId;
  final String status;
  final String rationalePtPt;
  final List<_DestinationPair> destinations;
  final List<String> finalIntentionIds;
  final List<_Priority> priorities;
  final String alternativesAndComplementariesPtPt;
  final String contextNotesPtPt;
  final String riskModifierPtPt;
  final String clinicalModifierPtPt;
  final String limitsPtPt;
  final String progressionPtPt;
  final String intensityPtPt;
  final String eligibilityPtPt;
}

class _ContextualLabel {
  const _ContextualLabel({
    required this.historicalId,
    required this.destinationId,
    required this.labelPtPt,
  });

  final String historicalId;
  final String destinationId;
  final String labelPtPt;
}

class _Link {
  const _Link({
    required this.pathNumber,
    required this.intentionId,
    required this.roleId,
    required this.displayOrder,
    required this.contextualLabelsPtPt,
  });

  final int pathNumber;
  final String intentionId;
  final String roleId;
  final int displayOrder;
  final List<String> contextualLabelsPtPt;
}

class _RegistryData {
  const _RegistryData({
    required this.sourceV04,
    required this.sourceV041,
    required this.definitions,
    required this.paths,
    required this.links,
    required this.historicMappings,
    required this.contextualLabels,
  });

  final _SourceDocument sourceV04;
  final _SourceDocument sourceV041;
  final List<_Definition> definitions;
  final List<_Path> paths;
  final List<_Link> links;
  final List<_HistoricMapping> historicMappings;
  final List<_ContextualLabel> contextualLabels;
}
