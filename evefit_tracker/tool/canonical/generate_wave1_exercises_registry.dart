import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/features/canonical_core/models/training_intention_models.dart';

const _generatorVersion = '1.0.0';
const _registryVersion = '0.1';
const _contentVersion = '0.1.2';
const _archiveDirectory = 'docs/canonical/source/exercises/wave1/archives';
const _technicalArchivePath =
    '$_archiveDirectory/EveFit_Exercise_Implementation_Bundle_Wave1_v0.1.zip';
const _publicArchivePath =
    '$_archiveDirectory/EveFit_Exercise_Beginner_Content_Wave1_Bundle_v0.1.2.zip';
const _classificationSpecPath =
    '$_archiveDirectory/EveFit_Canonical_Exercise_Classification_Spec_v0.1.md';
const _technicalArchiveHash =
    '3393bde5d0d3980e823240effac9213ff6f6d3e90148990628e2e216f9287b71';
const _publicArchiveHash =
    '35296706fd2abb6f821324f80c8aafc091a944fba9007e3fb933f2046da3b279';
const _classificationSpecHash =
    '9c6c65caa36e785bd82c4d8e4f5d37e1d21e3a974f9676d80658a82d10d9911c';
const _technicalSums =
    'SHA256SUMS_EveFit_Exercise_Implementation_Wave1_v0.1.txt';
const _publicSums = 'SHA256SUMS_EveFit_Exercise_Beginner_Content_Wave1.txt';
const _technicalRegistry =
    'EveFit_Exercise_Implementation_Registry_Wave1_v0.1.json';
const _readyRelations =
    'EveFit_Exercise_Implementation_Ready_Relations_Wave1_v0.1.json';
const _deferredRelations =
    'EveFit_Exercise_Implementation_Deferred_Conditional_Relations_Wave1_v0.1.json';
const _technicalVocabularies =
    'EveFit_Exercise_Implementation_Vocabularies_Wave1_v0.1.json';
const _technicalManifest =
    'EveFit_Exercise_Implementation_Manifest_Wave1_v0.1.json';
const _publicMaster = 'EveFit_Exercise_Beginner_Content_Wave1_Master.json';
const _publicManifest = 'EveFit_Exercise_Beginner_Content_Wave1_Manifest.json';
const _generatedDirectory = 'lib/features/canonical_core/generated/exercises';
const _manifestPath =
    'docs/canonical/generated/wave1_exercises_v0.1_manifest.json';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 1 ||
      !const {'generate', 'check', 'report'}.contains(arguments.single)) {
    stderr.writeln(
      'Usage: dart run tool/canonical/generate_wave1_exercises_registry.dart '
      '<generate|check|report>',
    );
    exitCode = 64;
    return;
  }

  try {
    final data = await loadWave1ExerciseSourcesForTesting();
    final outputs = _buildOutputs(data);
    switch (arguments.single) {
      case 'generate':
        await _writeOutputs(outputs);
        stdout.writeln(_report(data));
      case 'check':
        _checkOutputs(outputs);
        stdout.writeln('Generated Wave1 exercise outputs are current.');
      case 'report':
        stdout.writeln(_report(data));
    }
  } on Wave1GeneratorFailure catch (error) {
    stderr.writeln('Wave1 exercise generator failed: ${error.message}');
    exitCode = 1;
  } catch (error, stackTrace) {
    stderr.writeln('Wave1 exercise generator failed unexpectedly: $error');
    stderr.writeln(stackTrace);
    exitCode = 1;
  }
}

Future<Wave1SourceData> loadWave1ExerciseSourcesForTesting({
  String technicalArchivePath = _technicalArchivePath,
  String publicArchivePath = _publicArchivePath,
  String classificationSpecPath = _classificationSpecPath,
  String technicalArchiveHash = _technicalArchiveHash,
  String publicArchiveHash = _publicArchiveHash,
  String classificationSpecHash = _classificationSpecHash,
}) async {
  final specification = await _readSourceFile(
    classificationSpecPath,
    classificationSpecHash,
  );
  final technical = await _readArchive(
    technicalArchivePath,
    technicalArchiveHash,
    _technicalSums,
  );
  final public = await _readArchive(
    publicArchivePath,
    publicArchiveHash,
    _publicSums,
  );

  final data = Wave1SourceData(
    technicalArchive: technical,
    publicArchive: public,
    specification: specification,
    technicalExercises: _jsonRecords(
      technical,
      _technicalRegistry,
      'exercises',
    ),
    readyRelations: _jsonRecords(technical, _readyRelations, 'relations'),
    deferredRelations: _jsonRecords(technical, _deferredRelations, 'relations'),
    publicExercises: _jsonRecords(public, _publicMaster, 'exercises'),
    technicalManifest: _jsonObject(technical, _technicalManifest),
    publicManifest: _jsonObject(public, _publicManifest),
    vocabularies: _jsonObject(technical, _technicalVocabularies),
  );
  _validate(data);
  return data;
}

void validateWave1SourceDataForTesting(Wave1SourceData data) => _validate(data);

Future<void> regenerateWave1ExerciseOutputsForTesting() async {
  final data = await loadWave1ExerciseSourcesForTesting();
  await _writeOutputs(_buildOutputs(data));
}

Future<void> checkWave1ExerciseOutputsForTesting() async {
  final data = await loadWave1ExerciseSourcesForTesting();
  _checkOutputs(_buildOutputs(data));
}

Future<Wave1SourceFile> _readSourceFile(
  String path,
  String expectedHash,
) async {
  final file = File(path);
  _expect(await file.exists(), 'Required source is missing: $path.');
  final bytes = await file.readAsBytes();
  _expect(bytes.length > 1024, 'Required source is truncated: $path.');
  final actualHash = _sha256(bytes);
  _expect(
    actualHash == expectedHash,
    'SHA-256 mismatch for $path: expected $expectedHash, found $actualHash.',
  );
  _decodeUtf8(bytes, path);
  return Wave1SourceFile(path, bytes, actualHash);
}

Future<Wave1SourceArchive> _readArchive(
  String path,
  String expectedHash,
  String sumsFileName,
) async {
  final file = File(path);
  _expect(await file.exists(), 'Required source archive is missing: $path.');
  final bytes = await file.readAsBytes();
  _expect(bytes.length > 32, 'Required source archive is truncated: $path.');
  final actualHash = _sha256(bytes);
  _expect(
    actualHash == expectedHash,
    'SHA-256 mismatch for $path: expected $expectedHash, found $actualHash.',
  );

  final headerNames = <String>[];
  late final Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(
      bytes,
      verify: true,
      callback: (entry) => headerNames.add(entry.name),
    );
  } catch (error) {
    _fail('Invalid ZIP archive $path: $error.');
  }
  _expect(
    headerNames.toSet().length == headerNames.length,
    'Duplicate ZIP member in $path.',
  );

  final entries = <String, Uint8List>{};
  for (final entry in archive.files) {
    if (!entry.isFile) {
      _fail('Directory entries are not allowed in $path: ${entry.name}.');
    }
    _validateArchivePath(entry.name, path);
    final content = entry.readBytes();
    _expect(content != null, 'Unreadable ZIP member ${entry.name} in $path.');
    entries[entry.name] = content!;
  }
  _expect(
    entries.containsKey(sumsFileName),
    'Missing internal SHA256SUMS file in $path.',
  );

  final sumsText = _decodeUtf8(entries[sumsFileName]!, '$path:$sumsFileName');
  final expectedMembers = _parseSums(sumsText, '$path:$sumsFileName');
  final completeExpected = {...expectedMembers.keys, sumsFileName};
  _expect(
    entries.keys.toSet().containsAll(completeExpected) &&
        completeExpected.containsAll(entries.keys),
    'ZIP member set differs from the signed manifest in $path.',
  );
  for (final item in expectedMembers.entries) {
    final actual = _sha256(entries[item.key]!);
    _expect(
      actual == item.value,
      'Internal SHA-256 mismatch in $path for ${item.key}: '
      'expected ${item.value}, found $actual.',
    );
  }
  for (final entry in entries.entries) {
    if (_isTextFile(entry.key)) {
      final text = _decodeUtf8(entry.value, '$path:${entry.key}');
      _expect(
        !_containsCombiningMark(text),
        'Text member is not NFC-safe: $path:${entry.key}.',
      );
    }
  }
  return Wave1SourceArchive(path, bytes, actualHash, entries);
}

void _validateArchivePath(String name, String archivePath) {
  final normalized = name.replaceAll('\\', '/');
  final segments = normalized.split('/');
  _expect(name == normalized, 'Backslash ZIP path is unsafe in $archivePath.');
  _expect(
    normalized.isNotEmpty &&
        !normalized.startsWith('/') &&
        !RegExp(r'^[A-Za-z]:').hasMatch(normalized) &&
        !segments.contains('..') &&
        !segments.contains('.'),
    'Unsafe ZIP member path in $archivePath: $name.',
  );
}

Map<String, String> _parseSums(String text, String source) {
  final result = <String, String>{};
  for (final rawLine in const LineSplitter().convert(text)) {
    final line = rawLine.trim();
    if (line.isEmpty) continue;
    final match = RegExp(r'^([a-fA-F0-9]{64})\s+\*?(.+)$').firstMatch(line);
    _expect(match != null, 'Malformed SHA256SUMS line in $source: $line.');
    final name = match!.group(2)!.trim();
    _expect(!result.containsKey(name), 'Duplicate checksum entry in $source.');
    result[name] = match.group(1)!.toLowerCase();
  }
  _expect(result.isNotEmpty, 'Empty SHA256SUMS file: $source.');
  return result;
}

String _decodeUtf8(List<int> bytes, String source) {
  try {
    return utf8.decode(bytes, allowMalformed: false);
  } on FormatException {
    _fail('Invalid UTF-8 in $source.');
  }
}

bool _isTextFile(String name) =>
    name.endsWith('.json') || name.endsWith('.md') || name.endsWith('.txt');

bool _containsCombiningMark(String value) =>
    RegExp(r'[\u0300-\u036f\u1ab0-\u1aff\u1dc0-\u1dff]').hasMatch(value);

Map<String, dynamic> _jsonObject(Wave1SourceArchive archive, String member) {
  final bytes = archive.entries[member];
  _expect(bytes != null, 'Missing required JSON member: $member.');
  try {
    final value = jsonDecode(_decodeUtf8(bytes!, '${archive.path}:$member'));
    _expect(
      value is Map<String, dynamic>,
      'JSON root must be an object: $member.',
    );
    return value as Map<String, dynamic>;
  } on FormatException catch (error) {
    _fail('Invalid JSON in $member: $error.');
  }
}

List<Map<String, dynamic>> _jsonRecords(
  Wave1SourceArchive archive,
  String member,
  String key,
) {
  final object = _jsonObject(archive, member);
  final records = object[key];
  _expect(records is List<dynamic>, 'Missing JSON array $key in $member.');
  return List<Map<String, dynamic>>.unmodifiable(
    (records! as List<dynamic>).map((item) {
      _expect(item is Map<String, dynamic>, 'Invalid record in $member.');
      return item as Map<String, dynamic>;
    }),
  );
}

void _validate(Wave1SourceData data) {
  _expect(data.technicalExercises.length == 49, 'Expected 49 exercises.');
  _expect(data.publicExercises.length == 49, 'Expected 49 public records.');
  _expect(data.readyRelations.length == 88, 'Expected 88 ready relations.');
  _expect(
    data.deferredRelations.length == 66,
    'Expected 66 deferred conditional relations.',
  );
  _expect(
    data.publicManifest['package_version'] == _contentVersion,
    'Only public content v0.1.2 is allowed.',
  );
  _expect(
    _map(data.technicalManifest['ontology_snapshot'])['contexts'] == 7 &&
        _map(data.technicalManifest['ontology_snapshot'])['capabilities'] ==
            8 &&
        _map(data.technicalManifest['ontology_snapshot'])['concepts'] == 35 &&
        _map(data.technicalManifest['ontology_snapshot'])['intentions'] == 591,
    'Technical ontology snapshot differs from the approved registry.',
  );

  final technicalById = <String, Map<String, dynamic>>{};
  final entityTypeCounts = <String, int>{};
  final capabilityCounts = <String, int>{};
  final riskCounts = <String, int>{};
  final variants = <String, String?>{};
  var clinicalReviewRequired = 0;
  var mediaNotApproved = 0;
  for (final exercise in data.technicalExercises) {
    final id = _string(exercise, 'exercise_id');
    final identity = _map(exercise['identity']);
    final safety = _map(exercise['safety']);
    final media = _map(exercise['media']);
    _expect(!technicalById.containsKey(id), 'Duplicate exercise ID: $id.');
    _expect(
      _string(exercise, 'record_status') == 'approved',
      'Non-approved exercise in Wave1: $id.',
    );
    _expect(
      _string(exercise, 'primary_capability_root_id') != 'muscular_capacity',
      'Muscular exercise leaked into Wave1: $id.',
    );
    _increment(entityTypeCounts, _string(exercise, 'entity_type'));
    _increment(
      capabilityCounts,
      _string(exercise, 'primary_capability_root_id'),
    );
    _increment(riskCounts, _string(safety, 'operational_risk_tier'));
    if (_string(exercise, 'entity_type') == 'exercise_variant') {
      variants[id] = _nullableId(identity['variant_of']);
    }
    if (_boolean(safety, 'clinical_review_required')) {
      clinicalReviewRequired++;
    }
    if (_string(media, 'media_status') == 'not_yet_approved') {
      mediaNotApproved++;
    }
    technicalById[id] = exercise;
  }
  _expect(
    _sameCounts(entityTypeCounts, const {
      'canonical_exercise': 38,
      'technique_drill': 8,
      'exercise_variant': 3,
    }),
    'Exercise entity type counts differ from the approval.',
  );
  _expect(
    _sameCounts(capabilityCounts, const {
      'breathing_regulation': 4,
      'cardio_conditioning': 11,
      'flexibility': 9,
      'mobility': 5,
      'motor_control_coordination': 6,
      'speed_power': 9,
      'technique_skill': 5,
    }),
    'Primary capability counts differ from the approval.',
  );
  _expect(
    _sameCounts(riskCounts, const {'low': 22, 'moderate': 18, 'high': 9}),
    'Exercise risk counts differ from the approval.',
  );
  _expect(
    _sameNullableStrings(variants, const {
      'sled_resisted_sprint': 'linear_sprint',
      'supine_hamstring_strap_stretch':
          'supine_self_assisted_hamstring_stretch',
      'treadmill_walking': 'overground_walking',
    }),
    'Exercise variants differ from the approval.',
  );
  _expect(
    clinicalReviewRequired == 0,
    'Clinical-review exercise leaked into Wave1.',
  );
  _expect(
    mediaNotApproved == 49,
    'Wave1 media status differs from the approval.',
  );
  final publicById = <String, Map<String, dynamic>>{};
  for (final content in data.publicExercises) {
    final id = _string(content, 'exercise_id');
    _expect(!publicById.containsKey(id), 'Duplicate public exercise ID: $id.');
    publicById[id] = content;
  }
  _expect(
    technicalById.keys.toSet().containsAll(publicById.keys) &&
        publicById.keys.toSet().containsAll(technicalById.keys),
    'Technical and public exercise IDs do not join 1:1.',
  );

  for (final id in technicalById.keys) {
    final technical = technicalById[id]!;
    final public = publicById[id]!;
    final identity = _map(technical['identity']);
    _expect(
      _string(technical, 'name_pt_pt') == _string(public, 'name_pt_pt') &&
          _string(technical, 'entity_type') == _string(public, 'entity_type') &&
          _string(technical, 'primary_capability_root_id') ==
              _string(public, 'capability_primary') &&
          _nullableId(identity['base_exercise_id']) ==
              _nullableId(public['base_exercise_id']) &&
          _nullableId(identity['variant_of']) ==
              _nullableId(public['variant_of']),
      'Technical/public identity mismatch for $id.',
    );
    _expect(
      _list(public, 'unresolved_fields').isEmpty,
      'Public content has unresolved fields for $id.',
    );
  }

  final relationIds = <String>{};
  final representedExercises = <String>{};
  final activeRelationKeys = <String>{};
  final activeRelationTuples = <String>{};
  final activeIntentionIds = <String>{};
  final roleCounts = <String, int>{};
  final registry = const CanonicalRegistry();
  final contextIds = CanonicalRegistry.approvedUsageContexts
      .map((item) => item.id)
      .toSet();
  final capabilityIds = CanonicalRegistry.approvedCapabilityRoots
      .map((item) => item.id)
      .toSet();
  final conceptIds = CanonicalRegistry.approvedTrainingConcepts
      .map((item) => item.id)
      .toSet();
  final intentionIds = CanonicalRegistry.approvedTrainingIntentions
      .map((item) => item.id)
      .toSet();
  for (final relation in data.readyRelations) {
    final relationId = _string(relation, 'relation_id');
    final exerciseId = _string(relation, 'exercise_id');
    final contextId = _string(relation, 'usage_context_id');
    final capabilityId = _string(relation, 'capability_root_id');
    final conceptId = _string(relation, 'training_concept_id');
    final intentionId = _string(relation, 'training_intention_id');
    _expect(relationIds.add(relationId), 'Duplicate relation ID: $relationId.');
    final relationTuple = _relationTuple(relation);
    _expect(
      activeRelationTuples.add(relationTuple),
      'Duplicate ready relation tuple: $relationTuple.',
    );
    _expect(
      technicalById.containsKey(exerciseId),
      'Unknown exercise in ready relation: $exerciseId.',
    );
    _expect(
      _string(relation, 'compatibility_status') == 'compatible' &&
          _string(relation, 'conditional_classification') == 'not_applicable' &&
          _string(relation, 'implementation_bucket') ==
              'implementation_ready_relations',
      'Non-compatible relation leaked into the public set: $relationId.',
    );
    _expect(
      const {
        'principal_candidate',
        'alternative_primary',
        'complementary',
      }.contains(_string(relation, 'role')),
      'Invalid ready relation role: $relationId.',
    );
    _expect(
      contextIds.contains(contextId) &&
          capabilityIds.contains(capabilityId) &&
          conceptIds.contains(conceptId) &&
          intentionIds.contains(intentionId),
      'Unknown canonical path value in relation $relationId.',
    );
    final path = CanonicalTrainingPathKey(
      usageContextId: contextId,
      capabilityRootId: capabilityId,
      trainingConceptId: conceptId,
    );
    _expect(
      registry
          .resolvedOptionsForPath(path)
          .any((option) => option.definition.pillar.id == intentionId),
      'Relation does not exist in the approved path/intention registry: '
      '$relationId.',
    );
    representedExercises.add(exerciseId);
    activeRelationKeys.add(relationId);
    activeIntentionIds.add(intentionId);
    _increment(roleCounts, _string(relation, 'role'));
  }
  _expect(
    representedExercises.length == 49,
    'Every Wave1 exercise must appear in a ready relation.',
  );
  _expect(
    activeIntentionIds.length == 50,
    'Ready relations must touch exactly 50 intentions.',
  );
  _expect(
    _sameCounts(roleCounts, const {
      'principal_candidate': 34,
      'alternative_primary': 44,
      'complementary': 10,
    }),
    'Ready relation role counts differ from the approval.',
  );

  final deferredIds = <String>{};
  final deferredRelationTuples = <String>{};
  final deferredClassifications = <String, int>{};
  for (final relation in data.deferredRelations) {
    final relationId = _string(relation, 'relation_id');
    final relationTuple = _relationTuple(relation);
    _expect(deferredIds.add(relationId), 'Duplicate deferred relation ID.');
    _expect(
      deferredRelationTuples.add(relationTuple),
      'Duplicate deferred relation tuple: $relationTuple.',
    );
    _expect(
      !activeRelationKeys.contains(relationId),
      'Deferred relation leaked into active relations: $relationId.',
    );
    _expect(
      !activeRelationTuples.contains(relationTuple),
      'Deferred relation tuple leaked into active relations: $relationTuple.',
    );
    _expect(
      _string(relation, 'compatibility_status') == 'conditional' &&
          _string(relation, 'implementation_bucket') ==
              'implementation_deferred_conditional_relations',
      'Invalid deferred relation: $relationId.',
    );
    final classification = _string(relation, 'conditional_classification');
    deferredClassifications[classification] =
        (deferredClassifications[classification] ?? 0) + 1;
  }
  _expect(
    deferredClassifications['eligibility_engine_required'] == 57 &&
        deferredClassifications['unresolved_product_logic'] == 9,
    'Deferred relation classification counts differ from the approval.',
  );
}

String _relationTuple(Map<String, dynamic> relation) => [
  _string(relation, 'exercise_id'),
  _string(relation, 'usage_context_id'),
  _string(relation, 'capability_root_id'),
  _string(relation, 'training_concept_id'),
  _string(relation, 'training_intention_id'),
].join('|');

void _increment(Map<String, int> counts, String key) {
  counts[key] = (counts[key] ?? 0) + 1;
}

bool _sameCounts(Map<String, int> actual, Map<String, int> expected) =>
    actual.length == expected.length &&
    expected.entries.every((entry) => actual[entry.key] == entry.value);

bool _sameNullableStrings(
  Map<String, String?> actual,
  Map<String, String?> expected,
) =>
    actual.length == expected.length &&
    expected.entries.every((entry) => actual[entry.key] == entry.value);

Map<String, String> _buildOutputs(Wave1SourceData data) {
  final technical = [...data.technicalExercises]
    ..sort(
      (left, right) =>
          _string(left, 'exercise_id').compareTo(_string(right, 'exercise_id')),
    );
  final public = [...data.publicExercises]
    ..sort(
      (left, right) =>
          _string(left, 'exercise_id').compareTo(_string(right, 'exercise_id')),
    );
  final outputs = <String, String>{};
  final definitionParts = _chunks(technical, 10);
  final contentParts = _chunks(public, 10);
  for (var index = 0; index < definitionParts.length; index++) {
    outputs['$_generatedDirectory/canonical_exercises_registry_part_'
            '${(index + 1).toString().padLeft(2, '0')}.g.dart'] =
        _renderDefinitionPart(definitionParts[index], index + 1);
  }
  for (var index = 0; index < contentParts.length; index++) {
    outputs['$_generatedDirectory/canonical_exercise_beginner_content_part_'
            '${(index + 1).toString().padLeft(2, '0')}.g.dart'] =
        _renderContentPart(contentParts[index], index + 1);
  }
  outputs['$_generatedDirectory/canonical_exercises_registry.g.dart'] =
      _renderDefinitionIndex(definitionParts.length);
  outputs['$_generatedDirectory/canonical_exercise_beginner_content.g.dart'] =
      _renderContentIndex(contentParts.length);
  outputs['$_generatedDirectory/canonical_exercise_path_links.g.dart'] =
      _renderRelations(data.readyRelations);
  outputs['$_generatedDirectory/canonical_exercises_provenance.g.dart'] =
      _renderProvenance();

  final outputHashes = <String, String>{
    for (final entry in outputs.entries)
      entry.key: _normalizedOutputHash(entry.key, entry.value),
  };
  outputs[_manifestPath] = _renderManifest(data, outputHashes);
  return outputs;
}

List<List<T>> _chunks<T>(List<T> values, int size) => <List<T>>[
  for (var start = 0; start < values.length; start += size)
    values.sublist(start, (start + size).clamp(0, values.length)),
];

String _renderDefinitionIndex(int partCount) {
  final buffer = StringBuffer(_generatedHeader());
  buffer.writeln("import '../../models/canonical_exercise_models.dart';");
  for (var index = 1; index <= partCount; index++) {
    final suffix = index.toString().padLeft(2, '0');
    buffer.writeln(
      "import 'canonical_exercises_registry_part_$suffix.g.dart';",
    );
  }
  buffer.writeln();
  buffer.writeln(
    'const generatedCanonicalWave1Exercises = <CanonicalExerciseDefinition>[',
  );
  for (var index = 1; index <= partCount; index++) {
    final suffix = index.toString().padLeft(2, '0');
    buffer.writeln('  ...generatedCanonicalWave1ExercisesPart$suffix,');
  }
  buffer.writeln('];');
  return buffer.toString();
}

String _renderContentIndex(int partCount) {
  final buffer = StringBuffer(_generatedHeader());
  buffer.writeln("import '../../models/canonical_exercise_models.dart';");
  for (var index = 1; index <= partCount; index++) {
    final suffix = index.toString().padLeft(2, '0');
    buffer.writeln(
      "import 'canonical_exercise_beginner_content_part_$suffix.g.dart';",
    );
  }
  buffer.writeln();
  buffer.writeln(
    'const generatedCanonicalWave1BeginnerContent = '
    '<CanonicalExerciseBeginnerContent>[',
  );
  for (var index = 1; index <= partCount; index++) {
    final suffix = index.toString().padLeft(2, '0');
    buffer.writeln('  ...generatedCanonicalWave1BeginnerContentPart$suffix,');
  }
  buffer.writeln('];');
  return buffer.toString();
}

String _renderDefinitionPart(List<Map<String, dynamic>> exercises, int part) {
  final suffix = part.toString().padLeft(2, '0');
  final buffer = StringBuffer(_generatedHeader());
  buffer.writeln("import '../../models/canonical_exercise_models.dart';");
  buffer.writeln();
  buffer.writeln(
    'const generatedCanonicalWave1ExercisesPart$suffix = '
    '<CanonicalExerciseDefinition>[',
  );
  for (final exercise in exercises) {
    final identity = _map(exercise['identity']);
    final anatomy = _map(exercise['anatomy']);
    final material = _map(exercise['material']);
    final environment = _map(exercise['environment']);
    final safety = _map(exercise['safety']);
    final evidence = _map(exercise['evidence']);
    final media = _map(exercise['media']);
    final provenance = _map(exercise['provenance']);
    buffer
      ..writeln('  CanonicalExerciseDefinition(')
      ..writeln("    id: ${_dart(_string(exercise, 'exercise_id'))},")
      ..writeln("    namePtPt: ${_dart(_string(exercise, 'name_pt_pt'))},")
      ..writeln(
        '    entityType: ${_entityType(_string(exercise, 'entity_type'))},',
      )
      ..writeln(
        "    recordStatus: ${_dart(_string(exercise, 'record_status'))},",
      )
      ..writeln(
        "    catalogVersion: ${_dart(_string(exercise, 'catalog_version'))},",
      )
      ..writeln(
        '    primaryCapabilityRootId: '
        "${_dart(_string(exercise, 'primary_capability_root_id'))},",
      )
      ..writeln(
        '    secondaryCapabilityRootIds: '
        '${_dartValue(_list(exercise, 'secondary_capability_root_ids'))},',
      )
      ..writeln('    identity: CanonicalExerciseIdentity(')
      ..writeln(
        '      canonicalDefinitionPtPt: '
        "${_dart(_string(identity, 'canonical_definition_pt_pt'))},",
      )
      ..writeln(
        '      identitySummaryPtPt: '
        "${_dart(_string(identity, 'identity_summary_pt_pt'))},",
      )
      ..writeln(
        '      technicalPurposeImmediatePtPt: '
        "${_dart(_string(identity, 'technical_purpose_immediate_pt_pt'))},",
      )
      ..writeln(
        "      exerciseFamilyId: ${_dart(_string(identity, 'exercise_family_id'))},",
      )
      ..writeln(
        '      baseExerciseId: ${_dartNullable(_nullableId(identity['base_exercise_id']))},',
      )
      ..writeln(
        '      variantOf: ${_dartNullable(_nullableId(identity['variant_of']))},',
      )
      ..writeln(
        "      synonymsPtPt: ${_dartValue(_list(identity, 'synonyms_pt_pt'))},",
      )
      ..writeln(
        '      commonEnglishNames: '
        "${_dartValue(_list(identity, 'common_english_names'))},",
      )
      ..writeln(
        '      siblingExerciseIds: '
        "${_dartValue(_list(identity, 'sibling_exercise_ids'))},",
      )
      ..writeln(
        '      commonlyConfusedWith: '
        "${_dartValue(_list(identity, 'commonly_confused_with'))},",
      )
      ..writeln(
        '      distinctionNotesPtPt: '
        "${_dart(_string(identity, 'distinction_notes_pt_pt'))},",
      )
      ..writeln('    ),')
      ..writeln(
        '    mechanics: CanonicalExerciseMechanics('
        "values: ${_dartValue(_map(exercise['mechanics']))}),",
      )
      ..writeln('    anatomy: CanonicalExerciseAnatomy(')
      ..writeln(
        '      primaryBodyRegions: '
        "${_dartValue(_list(anatomy, 'primary_body_regions'))},",
      )
      ..writeln(
        '      secondaryBodyRegions: '
        "${_dartValue(_list(anatomy, 'secondary_body_regions'))},",
      )
      ..writeln("      wholeBody: ${_boolean(anatomy, 'whole_body')},")
      ..writeln(
        "      primaryGroups: ${_dartValue(_list(anatomy, 'primary_groups'))},",
      )
      ..writeln(
        "      secondaryGroups: ${_dartValue(_list(anatomy, 'secondary_groups'))},",
      )
      ..writeln(
        '      stabilizerGroups: '
        "${_dartValue(_list(anatomy, 'stabilizer_groups'))},",
      )
      ..writeln(
        '      primaryTargetMuscles: '
        "${_dartValue(_list(anatomy, 'primary_target_muscles'))},",
      )
      ..writeln(
        "      secondaryMuscles: ${_dartValue(_list(anatomy, 'secondary_muscles'))},",
      )
      ..writeln(
        '      stabilizerMuscles: '
        "${_dartValue(_list(anatomy, 'stabilizer_muscles'))},",
      )
      ..writeln(
        '      isolatedTargetSupported: '
        "${_boolean(anatomy, 'isolated_target_supported')},",
      )
      ..writeln('    ),')
      ..writeln('    material: CanonicalExerciseMaterialRequirements(')
      ..writeln(
        '      requiredEquipment: '
        "${_dartValue(_list(material, 'required_equipment'))},",
      )
      ..writeln(
        '      optionalEquipment: '
        "${_dartValue(_list(material, 'optional_equipment'))},",
      )
      ..writeln(
        '      alternativeEquipmentGroups: '
        "${_dartNestedStringList(_list(material, 'alternative_equipment_groups'))},",
      )
      ..writeln(
        '      noEquipmentSupported: '
        "${_boolean(material, 'no_equipment_supported')},",
      )
      ..writeln(
        '      personalGearRequirements: '
        "${_dartValue(_list(material, 'personal_gear_requirements'))},",
      )
      ..writeln(
        "      partnerRequired: ${_boolean(material, 'partner_required')},",
      )
      ..writeln(
        "      targetRequired: ${_boolean(material, 'target_required')},",
      )
      ..writeln(
        "      spotterRequired: ${_boolean(material, 'spotter_required')},",
      )
      ..writeln(
        '      supervisionRequirement: '
        "${_dart(_string(material, 'supervision_requirement'))},",
      )
      ..writeln('    ),')
      ..writeln('    environment: CanonicalExerciseEnvironmentRequirements(')
      ..writeln(
        "      indoorCompatible: ${_boolean(environment, 'indoor_compatible')},",
      )
      ..writeln(
        "      outdoorCompatible: ${_boolean(environment, 'outdoor_compatible')},",
      )
      ..writeln("      aquatic: ${_boolean(environment, 'aquatic')},")
      ..writeln(
        '      spaceRequirements: '
        "${_dartValue(_map(environment['space_requirements']))},",
      )
      ..writeln(
        '      minimumSpaceClass: '
        "${_dart(_string(environment, 'minimum_space_class'))},",
      )
      ..writeln(
        '      surfaceRequirements: '
        "${_dartValue(_list(environment, 'surface_requirements'))},",
      )
      ..writeln(
        '      unsuitableSurfaces: '
        "${_dartValue(_list(environment, 'unsuitable_surfaces'))},",
      )
      ..writeln(
        '      obstacleFreePathRequired: '
        "${_boolean(environment, 'obstacle_free_path_required')},",
      )
      ..writeln(
        '      genericLocationTypes: '
        "${_dartValue(_list(environment, 'generic_location_types'))},",
      )
      ..writeln(
        '      requiredLocationFeatures: '
        "${_dartValue(_list(environment, 'required_location_features'))},",
      )
      ..writeln(
        '      prohibitedLocationFeatures: '
        "${_dartValue(_list(environment, 'prohibited_location_features'))},",
      )
      ..writeln('    ),')
      ..writeln(
        '    technicalDemand: CanonicalExerciseTechnicalDemand('
        "values: ${_dartValue(_map(exercise['technical']))}),",
      )
      ..writeln('    safety: CanonicalExerciseSafety(')
      ..writeln(
        '      operationalRiskTier: '
        "${_riskTier(_string(safety, 'operational_risk_tier'))},",
      )
      ..writeln(
        '      principalRiskFactors: '
        "${_dartValue(_list(safety, 'principal_risk_factors'))},",
      )
      ..writeln(
        '      contextualRiskModifiers: '
        "${_dartValue(_list(safety, 'contextual_risk_modifiers'))},",
      )
      ..writeln(
        '      environmentalRiskModifiers: '
        "${_dartValue(_list(safety, 'environmental_risk_modifiers'))},",
      )
      ..writeln(
        '      equipmentRiskModifiers: '
        "${_dartValue(_list(safety, 'equipment_risk_modifiers'))},",
      )
      ..writeln(
        '      clinicalReviewRequired: '
        "${_boolean(safety, 'clinical_review_required')},",
      )
      ..writeln(
        '      eligibilityPrerequisites: '
        "${_dartValue(_list(safety, 'eligibility_prerequisites'))},",
      )
      ..writeln(
        '      stopOrReduceSigns: '
        "${_dartValue(_list(safety, 'stop_or_reduce_signs'))},",
      )
      ..writeln(
        '      populationsRequiringAdaptation: '
        "${_dartValue(_list(safety, 'populations_requiring_adaptation'))},",
      )
      ..writeln(
        '      populationsRequiringReview: '
        "${_dartValue(_list(safety, 'populations_requiring_review'))},",
      )
      ..writeln(
        '      supervisionTriggers: '
        "${_dartValue(_list(safety, 'supervision_triggers'))},",
      )
      ..writeln('    ),')
      ..writeln('    evidence: CanonicalExerciseEvidence(')
      ..writeln(
        "      evidenceBasis: ${_dart(_string(evidence, 'evidence_basis'))},",
      )
      ..writeln(
        "      sourceCodes: ${_dartValue(_list(evidence, 'source_codes'))},",
      )
      ..writeln(
        '      evidenceLimitPtPt: '
        "${_dart(_string(evidence, 'evidence_limit_pt_pt'))},",
      )
      ..writeln('    ),')
      ..writeln(
        '    prescriptionCapabilities: '
        "${_dartValue(_map(exercise['prescription_capabilities']))},",
      )
      ..writeln('    media: CanonicalExerciseMediaState(')
      ..writeln("      imageRequired: ${_boolean(media, 'image_required')},")
      ..writeln("      videoRequired: ${_boolean(media, 'video_required')},")
      ..writeln("      status: ${_dart(_string(media, 'media_status'))},")
      ..writeln('    ),')
      ..writeln('    provenance: CanonicalExerciseRuntimeProvenance(')
      ..writeln("      technicalBundleSha256: '$_technicalArchiveHash',")
      ..writeln("      beginnerContentBundleSha256: '$_publicArchiveHash',")
      ..writeln("      classificationSpecSha256: '$_classificationSpecHash',")
      ..writeln(
        '      sourcePackageSha256: '
        "${_dart(_string(provenance, 'source_package_sha256'))},",
      )
      ..writeln(
        "      sourceRegistry: ${_dart(_string(provenance, 'source_registry'))},",
      )
      ..writeln(
        "      sourceCodes: ${_dartValue(_list(provenance, 'source_codes'))},",
      )
      ..writeln(
        '      decisionLogReference: '
        "${_dart(_string(provenance, 'decision_log_reference'))},",
      )
      ..writeln("      generatorVersion: '$_generatorVersion',")
      ..writeln('    ),')
      ..writeln('  ),');
  }
  buffer.writeln('];');
  return buffer.toString();
}

String _renderContentPart(List<Map<String, dynamic>> contents, int part) {
  final suffix = part.toString().padLeft(2, '0');
  final buffer = StringBuffer(_generatedHeader());
  buffer.writeln("import '../../models/canonical_exercise_models.dart';");
  buffer.writeln();
  buffer.writeln(
    'const generatedCanonicalWave1BeginnerContentPart$suffix = '
    '<CanonicalExerciseBeginnerContent>[',
  );
  for (final sourceContent in contents) {
    final content = _sanitizePublicContent(sourceContent);
    final phases = _list(content, 'movement_phases_pt_pt');
    final errors = _list(content, 'common_errors_pt_pt');
    buffer
      ..writeln('  CanonicalExerciseBeginnerContent(')
      ..writeln("    exerciseId: ${_dart(_string(content, 'exercise_id'))},")
      ..writeln(
        '    shortDescriptionPtPt: '
        "${_dart(_string(content, 'short_description_pt_pt'))},",
      )
      ..writeln(
        '    beginnerDefinitionPtPt: '
        "${_dart(_string(content, 'beginner_definition_pt_pt'))},",
      )
      ..writeln(
        '    whatYouWillDoPtPt: '
        "${_dart(_string(content, 'what_you_will_do_pt_pt'))},",
      )
      ..writeln(
        '    whyThisMovementExistsPtPt: '
        "${_dart(_string(content, 'why_this_movement_exists_pt_pt'))},",
      )
      ..writeln(
        '    beforeYouStartPtPt: '
        "${_dartValue(_list(content, 'before_you_start_pt_pt'))},",
      )
      ..writeln(
        '    equipmentSetupPtPt: '
        "${_dartValue(_list(content, 'equipment_setup_pt_pt'))},",
      )
      ..writeln(
        '    environmentSetupPtPt: '
        "${_dartValue(_list(content, 'environment_setup_pt_pt'))},",
      )
      ..writeln(
        '    bodyReadinessCheckPtPt: '
        "${_dartValue(_list(content, 'body_readiness_check_pt_pt'))},",
      )
      ..writeln(
        '    startingPositionPtPt: '
        "${_dart(_string(content, 'starting_position_pt_pt'))},",
      )
      ..writeln(
        '    startingPositionChecklistPtPt: '
        "${_dartValue(_list(content, 'starting_position_checklist_pt_pt'))},",
      )
      ..writeln(
        '    executionStepsPtPt: '
        "${_dartValue(_list(content, 'execution_steps_pt_pt'))},",
      )
      ..writeln('    movementPhasesPtPt: <CanonicalExerciseMovementPhase>[');
    for (final phase in phases) {
      final item = _map(phase);
      buffer
        ..writeln('      CanonicalExerciseMovementPhase(')
        ..writeln("        namePtPt: ${_dart(_string(item, 'phase_pt_pt'))},")
        ..writeln(
          "        descriptionPtPt: ${_dart(_string(item, 'description_pt_pt'))},",
        )
        ..writeln('      ),');
    }
    buffer
      ..writeln('    ],')
      ..writeln(
        '    breathingGuidancePtPt: '
        "${_dart(_string(content, 'breathing_guidance_pt_pt'))},",
      )
      ..writeln(
        '    expectedSensationsPtPt: '
        "${_dartValue(_list(content, 'expected_sensations_pt_pt'))},",
      )
      ..writeln(
        '    unexpectedOrWarningSensationsPtPt: '
        "${_dartValue(_list(content, 'unexpected_or_warning_sensations_pt_pt'))},",
      )
      ..writeln(
        '    principalCuesPtPt: '
        "${_dartValue(_list(content, 'principal_cues_pt_pt'))},",
      )
      ..writeln('    commonErrorsPtPt: <CanonicalExerciseCommonError>[');
    for (final error in errors) {
      final item = _map(error);
      buffer
        ..writeln('      CanonicalExerciseCommonError(')
        ..writeln("        errorPtPt: ${_dart(_string(item, 'error_pt_pt'))},")
        ..writeln(
          '        howToRecognisePtPt: '
          "${_dart(_string(item, 'how_to_recognise_pt_pt'))},",
        )
        ..writeln(
          "        correctionPtPt: ${_dart(_string(item, 'correction_pt_pt'))},",
        )
        ..writeln('      ),');
    }
    buffer
      ..writeln('    ],')
      ..writeln(
        '    beginnerSimplificationsPtPt: '
        "${_dartValue(_list(content, 'beginner_simplifications_pt_pt'))},",
      )
      ..writeln(
        '    supervisionGuidancePtPt: '
        "${_dart(_string(content, 'supervision_guidance_pt_pt'))},",
      )
      ..writeln(
        '    endingTheExercisePtPt: '
        "${_dart(_string(content, 'ending_the_exercise_pt_pt'))},",
      )
      ..writeln(
        "    safetyNotePtPt: ${_dart(_string(content, 'safety_note_pt_pt'))},",
      )
      ..writeln(
        '    stopOrReduceSignsPtPt: '
        "${_dartValue(_list(content, 'stop_or_reduce_signs_pt_pt'))},",
      )
      ..writeln(
        '    equipmentSafetyPtPt: '
        "${_dart(_string(content, 'equipment_safety_pt_pt'))},",
      )
      ..writeln(
        '    environmentSafetyPtPt: '
        "${_dart(_string(content, 'environment_safety_pt_pt'))},",
      )
      ..writeln("    confidencePtPt: ${_dart(_string(content, 'confidence'))},")
      ..writeln(
        "    limitationsPtPt: ${_dartValue(_list(content, 'limitations_pt_pt'))},",
      )
      ..writeln(
        '    variantExplanation: '
        '${_renderVariantExplanation(content['formal_variant_explanation'])},',
      )
      ..writeln('  ),');
  }
  buffer.writeln('];');
  return buffer.toString();
}

String _renderVariantExplanation(Object? value) {
  if (value is! Map<String, dynamic>) return 'null';
  final errorsValue = value['variant_specific_errors_pt_pt'];
  final errors = errorsValue is List<dynamic> ? errorsValue : const <dynamic>[];
  return 'CanonicalExerciseVariantExplanation('
      'baseExerciseId: ${_dart(_string(value, 'base_exercise_id'))}, '
      'whatChangesPtPt: ${_dart(_string(value, 'what_changes_pt_pt'))}, '
      'whatStaysTheSamePtPt: '
      '${_dart(_string(value, 'what_stays_the_same_pt_pt'))}, '
      'whySeparatePtPt: ${_dart(_string(value, 'why_separate_pt_pt'))}, '
      'additionalEquipmentPtPt: '
      '${_dart(_string(value, 'additional_equipment_pt_pt'))}, '
      'additionalSetupPtPt: '
      '${_dart(_string(value, 'additional_setup_pt_pt'))}, '
      'additionalRisksPtPt: '
      '${_dart(_string(value, 'additional_risks_pt_pt'))}, '
      'variantSpecificErrorsPtPt: ${_dartValue(errors)})';
}

Map<String, dynamic> _sanitizePublicContent(Map<String, dynamic> source) => {
  for (final entry in source.entries)
    entry.key: entry.key == 'confidence'
        ? _sanitizePublicConfidence(entry.value as String)
        : _sanitizePublicValue(entry.value),
};

Object? _sanitizePublicValue(Object? value) {
  if (value is String) {
    final sanitized = _sanitizePublicText(value);
    return _isPublicSentinel(sanitized) ? '' : sanitized;
  }
  if (value is List<dynamic>) {
    return value
        .map(_sanitizePublicValue)
        .where((item) => item is! String || item.isNotEmpty)
        .toList(growable: false);
  }
  if (value is Map<String, dynamic>) {
    return _sanitizePublicContent(value);
  }
  return value;
}

String _sanitizePublicConfidence(String value) {
  final parts = value
      .split(' — ')
      .map(_sanitizePublicText)
      .where((item) => item.isNotEmpty)
      .toList(growable: false);
  final firstNarrative = parts.indexWhere(
    (part) => RegExp(r'[.!?:;]').hasMatch(part),
  );
  if (firstNarrative < 0) return '';
  return parts.sublist(firstNarrative).join(' — ');
}

String _sanitizePublicText(String value) {
  var result = value
      .replaceAll('os indicações', 'as indicações')
      .replaceAll('da movimento', 'do movimento');
  result = result.replaceAll(
    RegExp(r'\s*Implementação realizada:\s*não\.?', caseSensitive: false),
    '',
  );
  return result.trim();
}

bool _isPublicSentinel(String value) => const {
  'sim',
  'não',
  'nao',
  'not_applicable',
  'omitted_by_scope',
  'not_yet_approved',
}.contains(value.toLowerCase());

String _renderRelations(List<Map<String, dynamic>> relations) {
  final buffer = StringBuffer(_generatedHeader());
  buffer.writeln("import '../../models/canonical_exercise_models.dart';");
  buffer.writeln();
  buffer.writeln(
    'const generatedCanonicalWave1PathLinks = '
    '<CanonicalExercisePathCompatibility>[',
  );
  for (var index = 0; index < relations.length; index++) {
    final relation = relations[index];
    final provenance = _map(relation['provenance']);
    final variant = relation['variant_requirement'];
    final variantMap = variant is Map<String, dynamic> ? variant : null;
    buffer
      ..writeln('  CanonicalExercisePathCompatibility(')
      ..writeln("    relationId: ${_dart(_string(relation, 'relation_id'))},")
      ..writeln("    exerciseId: ${_dart(_string(relation, 'exercise_id'))},")
      ..writeln('    pathKey: CanonicalExercisePathKey(')
      ..writeln(
        '      usageContextId: '
        "${_dart(_string(relation, 'usage_context_id'))},",
      )
      ..writeln(
        '      capabilityRootId: '
        "${_dart(_string(relation, 'capability_root_id'))},",
      )
      ..writeln(
        '      trainingConceptId: '
        "${_dart(_string(relation, 'training_concept_id'))},",
      )
      ..writeln(
        '      trainingIntentionId: '
        "${_dart(_string(relation, 'training_intention_id'))},",
      )
      ..writeln('    ),')
      ..writeln("    role: ${_dart(_string(relation, 'role'))},")
      ..writeln(
        "    rationalePtPt: ${_dart(_string(relation, 'rationale_pt_pt'))},",
      )
      ..writeln("    limitsPtPt: ${_dart(_string(relation, 'limits_pt_pt'))},")
      ..writeln(
        '    contextualRiskModifier: '
        "${_dart(_string(relation, 'contextual_risk_modifier'))},",
      )
      ..writeln(
        '    clinicalReviewModifier: '
        "${_dart(_string(relation, 'clinical_review_modifier'))},",
      )
      ..writeln(
        '    variantRequired: '
        "${variantMap == null ? false : _boolean(variantMap, 'required')},",
      )
      ..writeln(
        '    variantBaseExerciseId: '
        '${_dartNullable(variantMap == null ? null : _nullableId(variantMap['base_exercise_id']))},',
      )
      ..writeln(
        '    equipmentCondition: '
        "${_dartValue(_map(relation['equipment_condition']))},",
      )
      ..writeln(
        '    environmentCondition: '
        "${_dartValue(_map(relation['environment_condition']))},",
      )
      ..writeln(
        '    supervisionCondition: '
        "${_dartValue(_map(relation['supervision_condition']))},",
      )
      ..writeln(
        '    eligibilityCondition: '
        "${_dartValue(_map(relation['eligibility_condition']))},",
      )
      ..writeln(
        '    canonicalPathNumber: '
        "${_integer(provenance, 'canonical_path_number')},",
      )
      ..writeln('    sourceOrder: ${index + 1},')
      ..writeln('  ),');
  }
  buffer.writeln('];');
  return buffer.toString();
}

String _renderProvenance() =>
    '${_generatedHeader()}'
    "const generatedCanonicalWave1RegistryVersion = '$_registryVersion';\n"
    "const generatedCanonicalWave1ContentVersion = '$_contentVersion';\n"
    "const generatedCanonicalWave1GeneratorVersion = '$_generatorVersion';\n"
    "const generatedCanonicalWave1TechnicalArchiveSha256 = "
    "'$_technicalArchiveHash';\n"
    "const generatedCanonicalWave1PublicArchiveSha256 = "
    "'$_publicArchiveHash';\n"
    "const generatedCanonicalWave1ClassificationSpecSha256 = "
    "'$_classificationSpecHash';\n"
    'const generatedCanonicalWave1Counts = <String, int>{\n'
    "  'exercises': 49,\n"
    "  'active_relations': 88,\n"
    "  'deferred_relations': 66,\n"
    "  'variants': 3,\n"
    '};\n';

String _renderManifest(Wave1SourceData data, Map<String, String> outputHashes) {
  final exerciseTypes = _distribution(
    data.technicalExercises.map((item) => _string(item, 'entity_type')),
  );
  final risks = _distribution(
    data.technicalExercises.map(
      (item) => _string(_map(item['safety']), 'operational_risk_tier'),
    ),
  );
  final roles = _distribution(
    data.readyRelations.map((item) => _string(item, 'role')),
  );
  final deferred = _distribution(
    data.deferredRelations.map(
      (item) => _string(item, 'conditional_classification'),
    ),
  );
  final manifest = <String, Object>{
    'generator_version': _generatorVersion,
    'registry_version': _registryVersion,
    'beginner_content_version': _contentVersion,
    'source_files': <String, Object>{
      _technicalArchivePath: <String, Object>{
        'sha256': data.technicalArchive.hash,
      },
      _publicArchivePath: <String, Object>{'sha256': data.publicArchive.hash},
      _classificationSpecPath: <String, Object>{
        'sha256': data.specification.hash,
      },
    },
    'counts': <String, Object>{
      'exercises': data.technicalExercises.length,
      'active_compatible_relations': data.readyRelations.length,
      'deferred_conditional_relations': data.deferredRelations.length,
      'public_content_records': data.publicExercises.length,
      'variants': 3,
      'pending_review_excluded': 52,
      'specialist_review_excluded': 25,
      'muscular_excluded': 159,
      'nonapproved_conditional_excluded': 13,
    },
    'distributions': <String, Object>{
      'entity_type': exerciseTypes,
      'operational_risk_tier': risks,
      'active_relation_role': roles,
      'deferred_classification': deferred,
    },
    'output_hashes_normalized': outputHashes,
    'runtime_separation': <String, Object>{
      'zip_parsed_at_runtime': false,
      'json_parsed_at_runtime': false,
      'markdown_parsed_at_runtime': false,
      'deferred_relations_exported_to_public_provider': false,
      'legacy_catalogue_queried': false,
      'database_seeded': false,
      'schema_changed': false,
      'media_rendered': false,
    },
  };
  return '${const JsonEncoder.withIndent('  ').convert(manifest)}\n';
}

Map<String, int> _distribution(Iterable<String> values) {
  final result = <String, int>{};
  for (final value in values) {
    result[value] = (result[value] ?? 0) + 1;
  }
  return Map<String, int>.fromEntries(
    result.entries.toList()
      ..sort((left, right) => left.key.compareTo(right.key)),
  );
}

Future<void> _writeOutputs(Map<String, String> outputs) async {
  for (final entry in outputs.entries) {
    final file = File(entry.key);
    await file.parent.create(recursive: true);
    await file.writeAsString(entry.value, encoding: utf8);
  }
  final formatResult = await Process.run(Platform.resolvedExecutable, [
    'format',
    _generatedDirectory,
  ]);
  _expect(
    formatResult.exitCode == 0,
    'Unable to format generated Dart outputs: ${formatResult.stderr}.',
  );
}

void _checkOutputs(Map<String, String> expected) {
  for (final entry in expected.entries) {
    final file = File(entry.key);
    _expect(file.existsSync(), 'Missing generated output: ${entry.key}.');
    final actual = file.readAsStringSync(encoding: utf8);
    _expect(
      entry.key.endsWith('.dart')
          ? _normalizeDart(actual) == _normalizeDart(entry.value)
          : actual == entry.value,
      'Generated output diverges: ${entry.key}. Run generate.',
    );
  }
  final directory = Directory(_generatedDirectory);
  _expect(directory.existsSync(), 'Generated exercise directory is missing.');
  final expectedDart = expected.keys
      .where((path) => path.endsWith('.dart'))
      .toSet();
  final actualDart = directory
      .listSync(recursive: false)
      .whereType<File>()
      .map((file) => file.path.replaceAll('\\', '/'))
      .where((path) => path.endsWith('.dart'))
      .toSet();
  _expect(
    actualDart.containsAll(expectedDart) &&
        expectedDart.containsAll(actualDart),
    'Generated exercise directory contains unexpected Dart outputs.',
  );
}

String _report(Wave1SourceData data) => <String>[
  'Wave1 exercise registry report',
  'generator_version: $_generatorVersion',
  'registry_version: $_registryVersion',
  'beginner_content_version: $_contentVersion',
  'technical_archive_sha256: ${data.technicalArchive.hash}',
  'public_archive_sha256: ${data.publicArchive.hash}',
  'classification_spec_sha256: ${data.specification.hash}',
  'exercises: ${data.technicalExercises.length}',
  'active_compatible_relations: ${data.readyRelations.length}',
  'deferred_conditional_relations: ${data.deferredRelations.length}',
  'runtime_zip_parsing: false',
  'runtime_json_parsing: false',
  'runtime_deferred_relations: false',
  'runtime_legacy_queries: false',
  'database_migration: false',
].join('\n');

String _generatedHeader() =>
    '// GENERATED CODE - DO NOT MODIFY BY HAND.\n'
    '// Wave1 exercises v$_registryVersion; public content v$_contentVersion.\n'
    '// Generator $_generatorVersion; technical source $_technicalArchiveHash.\n\n';

String _entityType(String value) => switch (value) {
  'canonical_exercise' => 'CanonicalExerciseEntityType.canonicalExercise',
  'technique_drill' => 'CanonicalExerciseEntityType.techniqueDrill',
  'exercise_variant' => 'CanonicalExerciseEntityType.exerciseVariant',
  _ => throw Wave1GeneratorFailure('Unknown exercise entity type: $value.'),
};

String _riskTier(String value) => switch (value) {
  'low' => 'CanonicalExerciseRiskTier.low',
  'moderate' => 'CanonicalExerciseRiskTier.moderate',
  'high' => 'CanonicalExerciseRiskTier.high',
  _ => throw Wave1GeneratorFailure('Unknown exercise risk tier: $value.'),
};

String _dartValue(Object? value) {
  if (value == null) return 'null';
  if (value is String) return _dart(value);
  if (value is num || value is bool) return value.toString();
  if (value is List<dynamic>) {
    final type = value.every((item) => item is String)
        ? 'String'
        : value.every(
            (item) =>
                item is List<dynamic> &&
                item.every((nested) => nested is String),
          )
        ? 'List<String>'
        : 'Object?';
    return '<$type>[${value.map(_dartValue).join(', ')}]';
  }
  if (value is Map<String, dynamic>) {
    return '<String, Object?>{${value.entries.map((entry) {
      return '${_dart(entry.key)}: ${_dartValue(entry.value)}';
    }).join(', ')}}';
  }
  throw Wave1GeneratorFailure(
    'Unsupported generated value type: ${value.runtimeType}.',
  );
}

String _dartNestedStringList(List<dynamic> values) =>
    '<List<String>>[${values.map((value) {
      _expect(value is List<dynamic>, 'Expected nested equipment list.');
      return '<String>[${(value as List<dynamic>).map((item) {
        _expect(item is String, 'Expected equipment ID string.');
        return _dart(item as String);
      }).join(', ')}]';
    }).join(', ')}]';

String _dart(String value) {
  final escaped = value
      .replaceAll('\\', '\\\\')
      .replaceAll("'", "\\'")
      .replaceAll(r'$', r'\$')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\r');
  return "'$escaped'";
}

String _dartNullable(String? value) => value == null ? 'null' : _dart(value);

String? _nullableId(Object? value) {
  if (value == null) return null;
  final text = value.toString().trim();
  return text.isEmpty || text == 'none' || text == 'not_applicable'
      ? null
      : text;
}

String _string(Map<String, dynamic> source, String key) {
  final value = source[key];
  _expect(value is String, 'Expected string field $key.');
  return value as String;
}

bool _boolean(Map<String, dynamic> source, String key) {
  final value = source[key];
  _expect(value is bool, 'Expected boolean field $key.');
  return value as bool;
}

int _integer(Map<String, dynamic> source, String key) {
  final value = source[key];
  _expect(value is int, 'Expected integer field $key.');
  return value as int;
}

List<dynamic> _list(Map<String, dynamic> source, String key) {
  final value = source[key];
  _expect(value is List<dynamic>, 'Expected list field $key.');
  return value as List<dynamic>;
}

Map<String, dynamic> _map(Object? value) {
  _expect(value is Map<String, dynamic>, 'Expected JSON object.');
  return value as Map<String, dynamic>;
}

String _sha256(List<int> bytes) => sha256.convert(bytes).toString();

String _normalizedOutputHash(String path, String value) => _sha256(
  utf8.encode(path.endsWith('.dart') ? _normalizeDart(value) : value),
);

String _normalizeDart(String source) {
  final buffer = StringBuffer();
  var inSingleQuote = false;
  var inDoubleQuote = false;
  var escaped = false;
  for (final codePoint in source.runes) {
    final character = String.fromCharCode(codePoint);
    if (escaped) {
      buffer.write(character);
      escaped = false;
      continue;
    }
    if ((inSingleQuote || inDoubleQuote) && character == r'\') {
      buffer.write(character);
      escaped = true;
      continue;
    }
    if (!inDoubleQuote && character == "'") {
      inSingleQuote = !inSingleQuote;
      buffer.write(character);
      continue;
    }
    if (!inSingleQuote && character == '"') {
      inDoubleQuote = !inDoubleQuote;
      buffer.write(character);
      continue;
    }
    if (!inSingleQuote &&
        !inDoubleQuote &&
        const {' ', '\t', '\r', '\n'}.contains(character)) {
      continue;
    }
    buffer.write(character);
  }
  return _removeTrailingCommas(buffer.toString());
}

String _removeTrailingCommas(String source) {
  final buffer = StringBuffer();
  var inSingleQuote = false;
  var inDoubleQuote = false;
  var escaped = false;
  for (var index = 0; index < source.length; index++) {
    final character = source[index];
    if (escaped) {
      buffer.write(character);
      escaped = false;
      continue;
    }
    if ((inSingleQuote || inDoubleQuote) && character == r'\') {
      buffer.write(character);
      escaped = true;
      continue;
    }
    if (!inDoubleQuote && character == "'") {
      inSingleQuote = !inSingleQuote;
      buffer.write(character);
      continue;
    }
    if (!inSingleQuote && character == '"') {
      inDoubleQuote = !inDoubleQuote;
      buffer.write(character);
      continue;
    }
    if (!inSingleQuote &&
        !inDoubleQuote &&
        character == ',' &&
        index + 1 < source.length &&
        const {')', ']', '}'}.contains(source[index + 1])) {
      continue;
    }
    buffer.write(character);
  }
  return buffer.toString();
}

Never _fail(String message) => throw Wave1GeneratorFailure(message);

void _expect(bool condition, String message) {
  if (!condition) _fail(message);
}

class Wave1GeneratorFailure implements Exception {
  const Wave1GeneratorFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

class Wave1SourceData {
  const Wave1SourceData({
    required this.technicalArchive,
    required this.publicArchive,
    required this.specification,
    required this.technicalExercises,
    required this.readyRelations,
    required this.deferredRelations,
    required this.publicExercises,
    required this.technicalManifest,
    required this.publicManifest,
    required this.vocabularies,
  });

  final Wave1SourceArchive technicalArchive;
  final Wave1SourceArchive publicArchive;
  final Wave1SourceFile specification;
  final List<Map<String, dynamic>> technicalExercises;
  final List<Map<String, dynamic>> readyRelations;
  final List<Map<String, dynamic>> deferredRelations;
  final List<Map<String, dynamic>> publicExercises;
  final Map<String, dynamic> technicalManifest;
  final Map<String, dynamic> publicManifest;
  final Map<String, dynamic> vocabularies;
}

class Wave1SourceFile {
  const Wave1SourceFile(this.path, this.bytes, this.hash);

  final String path;
  final Uint8List bytes;
  final String hash;
}

class Wave1SourceArchive extends Wave1SourceFile {
  const Wave1SourceArchive(super.path, super.bytes, super.hash, this.entries);

  final Map<String, Uint8List> entries;
}
