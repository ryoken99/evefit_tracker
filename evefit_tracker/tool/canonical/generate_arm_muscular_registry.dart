import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:csv/csv.dart';

const _generatorVersion = '0.1.0';
const _schemaVersion = '0.1';
const _muscularArchivePath =
    'docs/canonical/source/muscular/v0.1.1/EveFit_Muscular_Knowledge_Base_v0.1.1.zip';
const _armArchivePath =
    'docs/canonical/source/exercises/arms/v0.1/EveFit_Principal_Arm_Exercise_Catalogue_v0.1.zip';
const _muscularArchiveHash =
    'a1876a1d4bc21ab54b3828774f66a99519a4953dc00191e69475d8c15b8b30b0';
const _armArchiveHash =
    '247b9c6b36e3dd93d7b9c4fc4e6569c2b71eb9c710b8fb2b9ba62ebc86dfd71f';
const _muscularRoot = 'EveFit_Muscular_Knowledge_Base_v0.1.1';
const _armRoot = 'EveFit_Principal_Arm_Exercise_Catalogue_v0.1';
const _muscularGeneratedDirectory =
    'lib/features/canonical_core/generated/muscular';
const _armGeneratedDirectory =
    'lib/features/canonical_core/generated/exercises/arms';
const _barrelPath =
    'lib/features/canonical_core/generated/arm_muscular_registry.g.dart';
const _manifestPath =
    'docs/canonical/generated/arm_muscular_v0.1_manifest.json';
const _idPattern = r'^[a-z][a-z0-9]*(?:_[a-z0-9]+)*$';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 1 ||
      !const {'generate', 'check', 'report'}.contains(arguments.single)) {
    stderr.writeln(
      'Usage: dart run tool/canonical/generate_arm_muscular_registry.dart '
      '<generate|check|report>',
    );
    exitCode = 64;
    return;
  }

  try {
    final data = await loadArmMuscularSourcesForTesting();
    final outputs = _buildOutputs(data);
    switch (arguments.single) {
      case 'generate':
        await _writeOutputs(outputs);
        stdout.writeln(_report(data, outputs));
      case 'check':
        _checkOutputs(outputs);
        stdout.writeln('Generated arm muscular outputs are current.');
      case 'report':
        stdout.writeln(_report(data, outputs));
    }
  } on ArmMuscularGeneratorFailure catch (error) {
    stderr.writeln('Arm muscular generator failed: ${error.message}');
    exitCode = 1;
  } catch (error, stackTrace) {
    stderr.writeln('Arm muscular generator failed unexpectedly: $error');
    stderr.writeln(stackTrace);
    exitCode = 1;
  }
}

Future<ArmMuscularSourceData> loadArmMuscularSourcesForTesting({
  String muscularArchivePath = _muscularArchivePath,
  String armArchivePath = _armArchivePath,
  String muscularArchiveHash = _muscularArchiveHash,
  String armArchiveHash = _armArchiveHash,
}) async {
  final muscular = await _readArchive(
    muscularArchivePath,
    muscularArchiveHash,
    _muscularRoot,
  );
  final arms = await _readArchive(armArchivePath, armArchiveHash, _armRoot);
  final data = ArmMuscularSourceData(
    muscularArchive: muscular,
    armArchive: arms,
    regions: _jsonList(muscular, '13_EXPORTS/regions.json'),
    groups: _jsonList(muscular, '13_EXPORTS/muscle_groups.json'),
    muscles: _jsonLines(muscular, '13_EXPORTS/muscles.jsonl'),
    components: _jsonLines(muscular, '13_EXPORTS/muscle_components.jsonl'),
    joints: _jsonList(muscular, '13_EXPORTS/joints.json'),
    actions: <Map<String, dynamic>>[
      ..._jsonList(muscular, '13_EXPORTS/joint_actions.json'),
      ..._jsonList(muscular, '13_EXPORTS/functional_actions.json'),
    ],
    trainability: _jsonLines(
      muscular,
      '13_EXPORTS/muscle_trainability_profiles.jsonl',
    ),
    publicTaxonomy: _jsonObject(
      muscular,
      '13_EXPORTS/public_muscle_taxonomy.json',
    ),
    muscleJointRelations: _csvRows(
      muscular,
      '13_EXPORTS/muscle_joint_relations.csv',
    ),
    muscleActionRelations: _csvRows(
      muscular,
      '13_EXPORTS/muscle_action_relations.csv',
    ),
    muscleInteractions: _csvRows(
      muscular,
      '13_EXPORTS/muscle_interaction_relations.csv',
    ),
    families: _jsonList(arms, '13_EXPORTS/exercise_families.json'),
    equipment: _jsonList(arms, '13_EXPORTS/equipment.json'),
    exercises: _jsonLines(arms, '13_EXPORTS/exercises.jsonl'),
    publicExercises: _jsonList(arms, '13_EXPORTS/public_arm_exercises.json'),
    variants: _jsonLines(arms, '13_EXPORTS/exercise_variants.jsonl'),
    exerciseMuscleRelations: _csvRows(
      arms,
      '13_EXPORTS/exercise_muscle_relations.csv',
    ),
    exerciseJointRelations: _csvRows(
      arms,
      '13_EXPORTS/exercise_joint_relations.csv',
    ),
    exerciseActionRelations: _csvRows(
      arms,
      '13_EXPORTS/exercise_action_relations.csv',
    ),
    exerciseEquipmentRelations: _csvRows(
      arms,
      '13_EXPORTS/exercise_equipment_relations.csv',
    ),
  );
  _validate(data);
  return data;
}

void validateArmMuscularSourceDataForTesting(ArmMuscularSourceData data) =>
    _validate(data);

Future<void> regenerateArmMuscularOutputsForTesting() async {
  await _writeOutputs(_buildOutputs(await loadArmMuscularSourcesForTesting()));
}

Future<void> checkArmMuscularOutputsForTesting() async {
  _checkOutputs(_buildOutputs(await loadArmMuscularSourcesForTesting()));
}

Future<ArmMuscularSourceArchive> _readArchive(
  String path,
  String expectedHash,
  String expectedRoot,
) async {
  final file = File(path);
  _expect(await file.exists(), 'Required source archive is missing: $path.');
  final bytes = await file.readAsBytes();
  _expect(bytes.length > 1024, 'Required source archive is truncated: $path.');
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
    _expect(
      entry.isFile,
      'Directory ZIP member is not allowed: ${entry.name}.',
    );
    _validateArchivePath(entry.name, path);
    const separator = '/';
    final prefix = '$expectedRoot$separator';
    _expect(
      entry.name.startsWith(prefix),
      'Unexpected archive root in $path: ${entry.name}.',
    );
    final relative = entry.name.substring(prefix.length);
    _expect(relative.isNotEmpty, 'Empty archive member in $path.');
    final content = entry.readBytes();
    _expect(content != null, 'Unreadable ZIP member $relative in $path.');
    _expect(!entries.containsKey(relative), 'Duplicate ZIP member $relative.');
    entries[relative] = content!;
  }
  _expect(
    entries.containsKey('SHA256SUMS.txt'),
    'Missing SHA256SUMS.txt in $path.',
  );
  _expect(
    entries.containsKey('MANIFEST.json'),
    'Missing MANIFEST.json in $path.',
  );
  final sums = _parseSums(
    _decodeUtf8(entries['SHA256SUMS.txt']!, '$path:SHA256SUMS.txt'),
    '$path:SHA256SUMS.txt',
  );
  final signedMembers = <String>{...sums.keys, 'SHA256SUMS.txt'};
  _expect(
    entries.keys.toSet().containsAll(signedMembers) &&
        signedMembers.containsAll(entries.keys),
    'ZIP member set differs from SHA256SUMS.txt in $path.',
  );
  for (final item in sums.entries) {
    final content = entries[item.key];
    _expect(content != null, 'Checksum member is missing: ${item.key}.');
    _expect(
      _sha256(content!) == item.value,
      'Internal SHA-256 mismatch in $path for ${item.key}.',
    );
  }
  for (final item in entries.entries) {
    if (_isTextFile(item.key)) {
      final text = _decodeUtf8(item.value, '$path:${item.key}');
      _expect(!text.contains('\r'), 'Text member is not LF-only: ${item.key}.');
      _expect(
        !_containsCombiningMark(text),
        'Text member is not NFC-safe: ${item.key}.',
      );
    }
  }
  final manifest = _jsonObjectFromEntries(entries, 'MANIFEST.json', path);
  _validateManifest(manifest, entries, path);
  _validateSchemas(entries, path);
  return ArmMuscularSourceArchive(path, bytes, actualHash, entries, manifest);
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

void _validateManifest(
  Map<String, dynamic> manifest,
  Map<String, Uint8List> entries,
  String source,
) {
  final files = _list(manifest['files'], '$source:MANIFEST.files');
  _expect(files.isNotEmpty, 'Manifest has no files: $source.');
  for (final raw in files) {
    final row = _map(raw, '$source:manifest row');
    final path = _string(row, 'path');
    final expectedHash = _string(row, 'sha256');
    final expectedSize = row['bytes'] ?? row['size'];
    _expect(expectedSize is int, 'Manifest size missing for $path.');
    final content = entries[path];
    _expect(content != null, 'Manifest member missing: $path.');
    _expect(content!.length == expectedSize, 'Manifest size mismatch: $path.');
    _expect(_sha256(content) == expectedHash, 'Manifest hash mismatch: $path.');
  }
}

void _validateSchemas(Map<String, Uint8List> entries, String source) {
  final schemas = entries.keys.where((path) => path.contains('/schemas/'));
  _expect(schemas.isNotEmpty, 'No schemas in $source.');
  for (final schema in schemas) {
    final value = _jsonObjectFromEntries(entries, schema, source);
    _expect(value.isNotEmpty, 'Empty schema $schema in $source.');
    _expect(
      value.containsKey('type') || value.containsKey('required_columns'),
      'Schema contract is missing: $schema.',
    );
  }
}

Map<String, String> _parseSums(String text, String source) {
  final values = <String, String>{};
  for (final rawLine in const LineSplitter().convert(text)) {
    final line = rawLine.trim();
    if (line.isEmpty) continue;
    final match = RegExp(r'^([a-fA-F0-9]{64})\s+\*?(.+)$').firstMatch(line);
    _expect(match != null, 'Malformed SHA256SUMS line in $source: $line.');
    final path = match!.group(2)!.trim();
    _validateArchivePath(path, source);
    _expect(!values.containsKey(path), 'Duplicate checksum entry: $path.');
    values[path] = match.group(1)!.toLowerCase();
  }
  _expect(values.isNotEmpty, 'Empty SHA256SUMS file: $source.');
  return values;
}

List<Map<String, dynamic>> _jsonList(
  ArmMuscularSourceArchive source,
  String path,
) {
  final value = jsonDecode(
    _decodeUtf8(source.entries[path]!, '${source.path}:$path'),
  );
  return _list(
    value,
    path,
  ).map((item) => _map(item, path)).toList(growable: false);
}

List<Map<String, dynamic>> _jsonLines(
  ArmMuscularSourceArchive source,
  String path,
) {
  final text = _decodeUtf8(source.entries[path]!, '${source.path}:$path');
  return <Map<String, dynamic>>[
    for (final line in const LineSplitter().convert(text))
      if (line.trim().isNotEmpty) _map(jsonDecode(line), path),
  ];
}

Map<String, dynamic> _jsonObject(
  ArmMuscularSourceArchive source,
  String path,
) => _jsonObjectFromEntries(source.entries, path, source.path);

Map<String, dynamic> _jsonObjectFromEntries(
  Map<String, Uint8List> entries,
  String path,
  String source,
) {
  final content = entries[path];
  _expect(content != null, 'Required JSON member is missing: $path.');
  try {
    return _map(jsonDecode(_decodeUtf8(content!, '$source:$path')), path);
  } on FormatException {
    _fail('Invalid JSON in $source:$path.');
  }
}

List<Map<String, String>> _csvRows(
  ArmMuscularSourceArchive source,
  String path,
) {
  final rows = csv.decodeWithHeaders(
    _decodeUtf8(source.entries[path]!, '${source.path}:$path'),
  );
  _expect(rows.isNotEmpty, 'CSV has no records: $path.');
  final header = rows.first.headerMap.keys.toList(growable: false);
  _expect(
    header.toSet().length == header.length,
    'CSV duplicate header: $path.',
  );
  return <Map<String, String>>[
    for (final row in rows)
      <String, String>{
        for (var index = 0; index < header.length; index++)
          header[index]: index < row.length ? row[index].toString() : '',
      },
  ];
}

void _validate(ArmMuscularSourceData data) {
  _expect(
    _string(data.muscularArchive.manifest, 'version') == '0.1.1',
    'Unexpected muscular base version.',
  );
  _expect(
    _string(data.armArchive.manifest, 'version') == _schemaVersion,
    'Unexpected arm catalogue version.',
  );
  final input = _map(
    data.armArchive.manifest['canonical_input'],
    'canonical_input',
  );
  _expect(
    _string(input, 'sha256') == _muscularArchiveHash,
    'Arm source does not pin muscular base hash.',
  );

  _expect(data.regions.length == 16, 'Expected 16 muscle regions.');
  _expect(data.groups.length == 45, 'Expected 45 muscle groups.');
  _expect(data.muscles.length == 179, 'Expected 179 muscles.');
  _expect(data.components.length == 36, 'Expected 36 muscle components.');
  _expect(
    data.trainability.length == 179,
    'Expected 179 trainability profiles.',
  );
  _expect(data.joints.length == 35, 'Expected 35 joints.');
  _expect(data.actions.length == 94, 'Expected 94 actions.');
  _expect(
    data.muscleJointRelations.length == 365,
    'Expected 365 muscle-joint relations.',
  );
  _expect(
    data.muscleActionRelations.length == 484,
    'Expected 484 muscle-action relations.',
  );
  _expect(
    data.muscleInteractions.length == 394,
    'Expected 394 muscle-interaction relations.',
  );
  _expect(
    data.muscleJointRelations.length +
            data.muscleActionRelations.length +
            data.muscleInteractions.length ==
        1243,
    'Expected 1243 muscular relations.',
  );
  _expect(data.families.length == 15, 'Expected 15 exercise families.');
  _expect(data.equipment.length == 33, 'Expected 33 equipment records.');
  _expect(data.exercises.length == 36, 'Expected 36 arm exercises.');
  _expect(data.variants.length == 85, 'Expected 85 arm variants.');
  _expect(
    data.publicExercises.length == 35,
    'Expected 35 public arm exercises.',
  );
  _expect(
    data.exerciseMuscleRelations.length == 228,
    'Expected 228 exercise-muscle relations.',
  );
  _expect(
    data.exerciseJointRelations.length == 86,
    'Expected 86 exercise-joint relations.',
  );
  _expect(
    data.exerciseActionRelations.length == 68,
    'Expected 68 exercise-action relations.',
  );
  _expect(
    data.exerciseEquipmentRelations.length == 91,
    'Expected 91 exercise-equipment relations.',
  );

  final ids = <String>{};
  void addIds(Iterable<String> values, String label) {
    for (final id in values) {
      _expect(RegExp(_idPattern).hasMatch(id), 'Invalid $label ID: $id.');
      _expect(ids.add('$label:$id'), 'Canonical $label ID collision: $id.');
    }
  }

  final regionIds = _uniqueIds(data.regions, 'canonical_id', 'region');
  final groupIds = _uniqueIds(data.groups, 'canonical_id', 'group');
  final muscleIds = _uniqueIds(data.muscles, 'canonical_id', 'muscle');
  final componentIds = _uniqueIds(data.components, 'canonical_id', 'component');
  final jointIds = _uniqueIds(data.joints, 'canonical_id', 'joint');
  final actionIds = _uniqueIds(data.actions, 'canonical_id', 'action');
  final familyIds = _uniqueIds(data.families, 'family_id', 'family');
  final equipmentIds = _uniqueIds(data.equipment, 'equipment_id', 'equipment');
  final exerciseIds = _uniqueIds(data.exercises, 'exercise_id', 'exercise');
  final variantIds = _uniqueIds(data.variants, 'variant_id', 'variant');
  addIds(regionIds, 'region');
  addIds(groupIds, 'group');
  addIds(muscleIds, 'muscle');
  addIds(componentIds, 'component');
  addIds(jointIds, 'joint');
  addIds(actionIds, 'action');
  addIds(familyIds, 'family');
  addIds(equipmentIds, 'equipment');
  addIds(exerciseIds, 'exercise');
  addIds(variantIds, 'variant');
  _validateWave1Collisions(exerciseIds);

  final publicRegionIds = <String>{};
  final publicGroupIds = <String>{};
  final publicMuscleIds = <String>{};
  for (final area in _list(
    data.publicTaxonomy['navigation'],
    'public navigation',
  )) {
    final areaMap = _map(area, 'public area');
    if (_string(areaMap, 'body_area') != 'upper_body') continue;
    for (final region in _list(areaMap['regions'], 'public regions')) {
      final regionMap = _map(region, 'public region');
      final regionId = _string(regionMap, 'region_id');
      if (regionId != 'arm' && regionId != 'forearm') continue;
      publicRegionIds.add(regionId);
      for (final group in _list(regionMap['groups'], 'public groups')) {
        final groupMap = _map(group, 'public group');
        publicGroupIds.add(_string(groupMap, 'group_id'));
        for (final muscle in _list(groupMap['muscles'], 'public muscles')) {
          publicMuscleIds.add(
            _string(_map(muscle, 'public muscle'), 'muscle_id'),
          );
        }
      }
    }
  }
  _expect(publicRegionIds.length == 2, 'Expected two public regions.');
  _expect(publicGroupIds.length == 7, 'Expected seven public groups.');
  _expect(publicMuscleIds.length == 23, 'Expected 23 public muscles.');
  _expect(publicRegionIds.every(regionIds.contains), 'Unknown public region.');
  _expect(publicGroupIds.every(groupIds.contains), 'Unknown public group.');
  _expect(publicMuscleIds.every(muscleIds.contains), 'Unknown public muscle.');

  final exercisesById = _index(data.exercises, 'exercise_id');
  final publicById = _index(data.publicExercises, 'exercise_id');
  final publicEligible = <String>{
    for (final exercise in data.exercises)
      if (exercise['public_eligible'] == true &&
          const {
            'approved_public',
            'approved_with_limits',
          }.contains(_string(exercise, 'status')))
        _string(exercise, 'exercise_id'),
  };
  _expect(
    publicById.keys.toSet().containsAll(publicEligible) &&
        publicEligible.containsAll(publicById.keys),
    'Public exercise content differs from eligible exercises.',
  );
  _expect(
    _count(data.exercises, 'status', 'approved_public') == 29,
    'Expected 29 approved public exercises.',
  );
  _expect(
    _count(data.exercises, 'status', 'approved_with_limits') == 6,
    'Expected six limited exercises.',
  );
  _expect(
    _count(data.exercises, 'status', 'specialist_review') == 1,
    'Expected one specialist exercise.',
  );
  _expect(
    !publicById.containsKey('resisted_thumb_opposition'),
    'Specialist exercise is public.',
  );
  _expect(
    exercisesById['resisted_thumb_opposition']?['public_eligible'] == false,
    'Specialist exercise marked public.',
  );
  const limited = <String>{
    'bench_dip',
    'dead_hang',
    'machine_triceps_extension',
    'wrist_radial_deviation',
    'wrist_roller',
    'wrist_ulnar_deviation',
  };
  _expect(
    data.exercises
        .where((row) => _string(row, 'status') == 'approved_with_limits')
        .map((row) => _string(row, 'exercise_id'))
        .toSet()
        .containsAll(limited),
    'Required limited exercise is missing.',
  );
  for (final id in publicEligible) {
    final publicContent = publicById[id];
    _expect(publicContent != null, 'Public content missing for $id.');
    _expect(
      _list(publicContent!['cautions'], '$id cautions').isNotEmpty,
      'Cautions missing for $id.',
    );
    if (limited.contains(id)) {
      _expect(
        _string(publicContent, 'limit_reason').isNotEmpty,
        'Limit reason missing for $id.',
      );
    }
  }
  final variantById = _index(data.variants, 'variant_id');
  for (final variant in data.variants) {
    _expect(
      exercisesById.containsKey(_string(variant, 'parent_exercise_id')),
      'Variant parent is missing: ${_string(variant, 'variant_id')}.',
    );
  }
  _expect(
    _count(data.variants, 'status', 'approved_with_limits') == 21,
    'Expected 21 limited variants.',
  );
  _expect(
    _string(variantById['towel_hang']!, 'parent_exercise_id') == 'dead_hang',
    'towel_hang must remain a dead_hang child.',
  );
  _expect(
    !data.exerciseMuscleRelations.any(
      (row) => row['muscle_id'] == 'coracobrachialis',
    ),
    'coracobrachialis must remain an honest empty state.',
  );

  for (final group in data.groups) {
    _expect(
      regionIds.contains(_string(group, 'region_id')),
      'Group region missing.',
    );
    for (final member in _stringList(group['member_ids'], 'group members')) {
      _expect(muscleIds.contains(member), 'Group muscle missing: $member.');
    }
  }
  for (final muscle in data.muscles) {
    _expect(
      regionIds.contains(_string(muscle, 'region_id')),
      'Muscle region missing.',
    );
    _expect(
      groupIds.contains(_string(muscle, 'group_id')),
      'Muscle group missing.',
    );
  }
  for (final component in data.components) {
    _expect(
      muscleIds.contains(_string(component, 'parent_muscle_id')),
      'Component parent missing.',
    );
  }
  for (final profile in data.trainability) {
    _expect(
      muscleIds.contains(_string(profile, 'muscle_id')),
      'Trainability profile muscle missing.',
    );
  }
  _validateRelationReferences(
    data,
    muscleIds,
    componentIds,
    jointIds,
    actionIds,
    equipmentIds,
    exerciseIds,
  );
}

void _validateWave1Collisions(Set<String> armExerciseIds) {
  final directory = Directory(
    'lib/features/canonical_core/generated/exercises',
  );
  if (!directory.existsSync()) return;
  final waveIds = <String>{};
  for (final file in directory.listSync(recursive: true).whereType<File>()) {
    if (!file.path.endsWith('.dart') ||
        file.path.contains(
          '${Platform.pathSeparator}arms${Platform.pathSeparator}',
        )) {
      continue;
    }
    final source = file.readAsStringSync();
    for (final match in RegExp(
      r"(?:id|exerciseId):\s*'([a-z][a-z0-9_]*)'",
    ).allMatches(source)) {
      waveIds.add(match.group(1)!);
    }
  }
  final collisions = armExerciseIds.intersection(waveIds);
  _expect(
    collisions.isEmpty,
    'Arm/Wave1 exercise ID collision: ${collisions.join(', ')}.',
  );
}

void _validateRelationReferences(
  ArmMuscularSourceData data,
  Set<String> muscleIds,
  Set<String> componentIds,
  Set<String> jointIds,
  Set<String> actionIds,
  Set<String> equipmentIds,
  Set<String> exerciseIds,
) {
  for (final row in data.muscleJointRelations) {
    _expect(
      muscleIds.contains(row['muscle_id']) ||
          componentIds.contains(row['muscle_id']),
      'Muscle-joint orphan: ${row['muscle_id']}/${row['joint_id']}.',
    );
    _expect(
      jointIds.contains(row['joint_id']),
      'Muscle-joint unknown joint: ${row['muscle_id']}/${row['joint_id']}.',
    );
  }
  for (final row in data.muscleActionRelations) {
    _expect(
      muscleIds.contains(row['muscle_id']) ||
          componentIds.contains(row['muscle_id']),
      'Muscle-action orphan: ${row['muscle_id']}/${row['action_id']}.',
    );
    final jointId = row['joint_id'] ?? '';
    if (jointId.isEmpty) {
      // The approved source uses no joint for explicitly non-articular
      // functions. Preserve that distinction rather than inventing a joint.
      _expect(
        row['chain_context'] == 'not_applicable',
        'Muscle-action without a joint must be not_applicable: ${row['muscle_id']}/${row['action_id']}.',
      );
    } else {
      _expect(
        jointIds.contains(jointId),
        'Muscle-action unknown joint: ${row['muscle_id']}/$jointId.',
      );
    }
    _expect(
      actionIds.contains(row['action_id']),
      'Muscle-action unknown action: ${row['muscle_id']}/${row['action_id']}.',
    );
  }
  for (final row in data.exerciseMuscleRelations) {
    _expect(
      exerciseIds.contains(row['exercise_id']),
      'Exercise-muscle orphan: ${row['relation_id']}.',
    );
    _expect(
      muscleIds.contains(row['muscle_id']),
      'Exercise-muscle unknown muscle: ${row['relation_id']}.',
    );
    final component = row['component_id'] ?? '';
    _expect(
      component.isEmpty || componentIds.contains(component),
      'Exercise-muscle unknown component: ${row['relation_id']}.',
    );
    _expect(
      _armRole(row['role'] ?? '') != null,
      'Unknown muscle role: ${row['role']}.',
    );
  }
  for (final row in data.exerciseJointRelations) {
    _expect(
      exerciseIds.contains(row['exercise_id']),
      'Exercise-joint orphan: ${row['relation_id']}.',
    );
    _expect(
      jointIds.contains(row['joint_id']),
      'Exercise-joint unknown joint: ${row['relation_id']}.',
    );
  }
  for (final row in data.exerciseActionRelations) {
    _expect(
      exerciseIds.contains(row['exercise_id']),
      'Exercise-action orphan: ${row['relation_id']}.',
    );
    _expect(
      actionIds.contains(row['action_id']),
      'Exercise-action unknown action: ${row['relation_id']}.',
    );
  }
  for (final row in data.exerciseEquipmentRelations) {
    _expect(
      exerciseIds.contains(row['exercise_id']),
      'Exercise-equipment orphan: ${row['relation_id']}.',
    );
    _expect(
      equipmentIds.contains(row['equipment_id']),
      'Exercise-equipment unknown equipment: ${row['relation_id']}.',
    );
    _expect(
      _equipmentType(row['relation_type'] ?? '') != null,
      'Unknown equipment relation: ${row['relation_type']}.',
    );
  }
}

Map<String, String> _buildOutputs(ArmMuscularSourceData data) {
  final outputs = <String, String>{
    '$_muscularGeneratedDirectory/canonical_muscular_registry.g.dart':
        _renderMuscularRegistry(),
    '$_muscularGeneratedDirectory/canonical_muscular_regions.g.dart':
        _renderRegions(data),
    '$_muscularGeneratedDirectory/canonical_muscle_groups.g.dart':
        _renderGroups(data),
    '$_muscularGeneratedDirectory/canonical_muscles.g.dart': _renderMuscles(
      data,
    ),
    '$_muscularGeneratedDirectory/canonical_muscle_components.g.dart':
        _renderComponents(data),
    '$_muscularGeneratedDirectory/canonical_muscle_joints_actions.g.dart':
        _renderJointsActions(data),
    '$_muscularGeneratedDirectory/canonical_muscle_relations.g.dart':
        _renderMuscularRelations(data),
    '$_armGeneratedDirectory/canonical_arm_exercises_registry.g.dart':
        _renderArmRegistry(),
    '$_armGeneratedDirectory/canonical_arm_families_equipment.g.dart':
        _renderFamiliesEquipment(data),
    '$_armGeneratedDirectory/canonical_arm_exercises.g.dart':
        _renderArmExercises(data),
    '$_armGeneratedDirectory/canonical_arm_public_contents.g.dart':
        _renderPublicContents(data),
    '$_armGeneratedDirectory/canonical_arm_variants.g.dart': _renderVariants(
      data,
    ),
    '$_armGeneratedDirectory/canonical_arm_relations.g.dart':
        _renderArmRelations(data),
    _barrelPath:
        "export 'muscular/canonical_muscular_registry.g.dart';\nexport 'exercises/arms/canonical_arm_exercises_registry.g.dart';\n",
  };
  final hashes = <String, String>{
    for (final entry in outputs.entries)
      entry.key: _normalizedOutputHash(entry.key, entry.value),
  };
  outputs[_manifestPath] = _renderManifest(data, hashes);
  return outputs;
}

String _renderMuscularRegistry() =>
    '''// GENERATED CODE - DO NOT MODIFY BY HAND.
import '../../models/canonical_muscular_models.dart';

part 'canonical_muscular_regions.g.dart';
part 'canonical_muscle_groups.g.dart';
part 'canonical_muscles.g.dart';
part 'canonical_muscle_components.g.dart';
part 'canonical_muscle_joints_actions.g.dart';
part 'canonical_muscle_relations.g.dart';
''';

String _renderArmRegistry() => '''// GENERATED CODE - DO NOT MODIFY BY HAND.
import '../../../models/canonical_muscular_models.dart';

part 'canonical_arm_families_equipment.g.dart';
part 'canonical_arm_exercises.g.dart';
part 'canonical_arm_public_contents.g.dart';
part 'canonical_arm_variants.g.dart';
part 'canonical_arm_relations.g.dart';
''';

String _renderRegions(ArmMuscularSourceData data) {
  final publicIds = _publicIds(data, 'region');
  return _renderTypedList(
    'CanonicalMuscleRegion',
    'generatedCanonicalMuscleRegions',
    data.regions,
    (row) =>
        '''CanonicalMuscleRegion(
  id: ${_dartString(_string(row, 'canonical_id'))},
  namePtPt: ${_dartString(_string(row, 'name_pt_pt'))},
  bodyArea: ${_dartString(_string(row, 'body_area'))},
  regionType: ${_dartString(_string(row, 'region_type'))},
  isPublic: ${publicIds.contains(_string(row, 'canonical_id'))},
)''',
  );
}

String _renderGroups(ArmMuscularSourceData data) {
  final publicIds = _publicIds(data, 'group');
  return _renderTypedList(
    'CanonicalMuscleGroup',
    'generatedCanonicalMuscleGroups',
    data.groups,
    (row) =>
        '''CanonicalMuscleGroup(
  id: ${_dartString(_string(row, 'canonical_id'))},
  regionId: ${_dartString(_string(row, 'region_id'))},
  namePtPt: ${_dartString(_string(row, 'name_pt_pt'))},
  groupType: ${_dartString(_string(row, 'group_type'))},
  memberIds: ${_dartStrings(_stringList(row['member_ids'], 'member_ids'))},
  isPublic: ${publicIds.contains(_string(row, 'canonical_id'))},
)''',
  );
}

String _renderMuscles(ArmMuscularSourceData data) {
  final publicIds = _publicIds(data, 'muscle');
  final componentByMuscle = _groupValues(
    data.components,
    'parent_muscle_id',
    'canonical_id',
  );
  final actionsByMuscle = _groupCsvValues(
    data.muscleActionRelations,
    'muscle_id',
    'action_id',
  );
  final jointsByMuscle = _groupCsvValues(
    data.muscleJointRelations,
    'muscle_id',
    'joint_id',
  );
  final profiles = _index(data.trainability, 'muscle_id');
  return _renderTypedList(
    'CanonicalMuscle',
    'generatedCanonicalMuscles',
    data.muscles,
    (row) {
      final id = _string(row, 'canonical_id');
      final names = _map(row['names'], '$id names');
      final profile = profiles[id];
      return '''CanonicalMuscle(
  id: ${_dartString(id)},
  namePtPt: ${_dartString(_string(names, 'pt_pt'))},
  nameEn: ${_dartString(_string(names, 'en'))},
  nameLatin: ${_dartString(_string(names, 'latin'))},
  regionId: ${_dartString(_string(row, 'region_id'))},
  groupId: ${_dartString(_string(row, 'group_id'))},
  descriptionPtPt: ${_dartString(_string(row, 'public_description'))},
  originPtPt: ${_dartString(_string(row, 'origin'))},
  insertionPtPt: ${_dartString(_string(row, 'insertion'))},
  innervationPtPt: ${_dartString(_string(row, 'innervation'))},
  architecture: ${_dartString(_string(row, 'architecture'))},
  componentIds: ${_dartStrings(componentByMuscle[id] ?? const <String>[])},
  jointIds: ${_dartStrings(jointsByMuscle[id] ?? const <String>[])},
  actionIds: ${_dartStrings(actionsByMuscle[id] ?? const <String>[])},
  practicalEmphasis: ${_dartString(_string(row, 'practical_emphasis'))},
  trainabilitySummaryPtPt: ${_dartString(profile == null ? '' : _string(profile, 'evidence_boundary'))},
  limitationsPtPt: ${_dartString(_string(row, 'limitations_and_controversies'))},
  confidence: ${_dartString(profile == null ? _string(row, 'approval_status') : _string(profile, 'confidence'))},
  isPublic: ${publicIds.contains(id)},
)''';
    },
  );
}

String _renderComponents(ArmMuscularSourceData data) => _renderTypedList(
  'CanonicalMuscleComponent',
  'generatedCanonicalMuscleComponents',
  data.components,
  (row) =>
      '''CanonicalMuscleComponent(
  id: ${_dartString(_string(row, 'canonical_id'))},
  muscleId: ${_dartString(_string(row, 'parent_muscle_id'))},
  namePtPt: ${_dartString(_string(row, 'name_pt_pt'))},
  descriptionPtPt: ${_dartString('${_string(row, 'separation_criteria')} ${_string(row, 'structural_limitation')}')},
)''',
);

String _renderJointsActions(ArmMuscularSourceData data) =>
    '''part of 'canonical_muscular_registry.g.dart';

const generatedCanonicalMuscleJoints = <CanonicalMuscleJoint>[
${data.joints.map((row) => '''  CanonicalMuscleJoint(
    id: ${_dartString(_string(row, 'canonical_id'))},
    namePtPt: ${_dartString(_string(row, 'name_pt_pt'))},
  ),''').join('\n')}
];

const generatedCanonicalMuscleActions = <CanonicalMuscleAction>[
${data.actions.map((row) => '''  CanonicalMuscleAction(
    id: ${_dartString(_string(row, 'canonical_id'))},
    namePtPt: ${_dartString(_string(row, 'name_pt_pt'))},
    descriptionPtPt: ${_dartString(_string(row, 'context_requirement'))},
  ),''').join('\n')}
];
''';

String _renderMuscularRelations(ArmMuscularSourceData data) =>
    '''part of 'canonical_muscular_registry.g.dart';

const generatedCanonicalMuscleJointRelations = <CanonicalMuscleJointRelation>[
${data.muscleJointRelations.map((row) => '''  CanonicalMuscleJointRelation(
    muscleId: ${_dartString(row['muscle_id']!)},
    parentMuscleId: ${_dartNullable(row['parent_muscle_id'])},
    jointId: ${_dartString(row['joint_id']!)},
    relationType: ${_dartString(row['relation_type']!)},
    segmentConditionPtPt: ${_dartString(row['segment_condition']!)},
    confidence: ${_dartString(row['confidence']!)},
  ),''').join('\n')}
];

const generatedCanonicalMuscleActionRelations = <CanonicalMuscleActionRelation>[
${data.muscleActionRelations.map((row) => '''  CanonicalMuscleActionRelation(
    muscleId: ${_dartString(row['muscle_id']!)},
    parentMuscleId: ${_dartNullable(row['parent_muscle_id'])},
    jointId: ${_dartString(_relationJointId(row))},
    actionId: ${_dartString(row['action_id']!)},
    role: ${_dartString(row['role']!)},
    plane: ${_dartString(row['plane']!)},
    chainContext: ${_dartString(row['chain_context']!)},
    confidence: ${_dartString(row['confidence']!)},
  ),''').join('\n')}
];

const generatedCanonicalMuscleInteractionRelations = <CanonicalMuscleInteractionRelation>[
${data.muscleInteractions.map((row) => '''  CanonicalMuscleInteractionRelation(
    id: ${_dartString(row['relation_id']!)},
    muscleAId: ${_dartString(row['muscle_a_id']!)},
    muscleBId: ${_dartString(row['muscle_b_id']!)},
    relationType: ${_dartString(row['relation_type']!)},
    taskContextPtPt: ${_dartString(row['task_context']!)},
    actionContext: ${_dartString(row['action_context']!)},
    limitationsPtPt: ${_dartString(row['limitations']!)},
    confidence: ${_dartString(row['confidence']!)},
  ),''').join('\n')}
];

const generatedCanonicalMuscleTrainabilityProfiles = <CanonicalMuscleTrainabilityProfile>[
${data.trainability.map((row) {
      final stability = _map(row['stability_requirements'], 'stability requirements');
      final synergists = _map(row['unavoidable_synergists'], 'unavoidable synergists');
      return '''  CanonicalMuscleTrainabilityProfile(
    muscleId: ${_dartString(_string(row, 'muscle_id'))},
    practicalEmphasis: ${_dartString(_string(row, 'practical_emphasis'))},
    trainingTargetStatus: ${_dartString(_string(row, 'training_target_status'))},
    positionDependencePtPt: ${_dartString(_string(row, 'position_dependence'))},
    evidenceBoundaryPtPt: ${_dartString(_string(row, 'evidence_boundary'))},
    limitingJointIds: ${_dartStrings(_stringList(row['limiting_joint_ids'], 'limiting joint ids'))},
    stabilityMuscleIds: ${_dartStrings(_stringList(stability['muscle_ids'], 'stability muscles'))},
    synergistMuscleIds: ${_dartStrings(_stringList(synergists['muscle_ids'], 'synergist muscles'))},
    riskClass: ${_dartString(_string(row, 'risk_class'))},
    confidence: ${_dartString(_string(row, 'confidence'))},
  ),''';
    }).join('\n')}
];
''';

String _renderFamiliesEquipment(ArmMuscularSourceData data) =>
    '''part of 'canonical_arm_exercises_registry.g.dart';

const generatedCanonicalArmExerciseFamilies = <CanonicalArmExerciseFamily>[
${data.families.map((row) => '''  CanonicalArmExerciseFamily(
    id: ${_dartString(_string(row, 'family_id'))},
    namePtPt: ${_dartString(_string(row, 'name_pt_pt'))},
    domain: ${_dartString(_string(row, 'domain'))},
  ),''').join('\n')}
];

const generatedCanonicalArmEquipment = <CanonicalArmEquipment>[
${data.equipment.map((row) => '''  CanonicalArmEquipment(
    id: ${_dartString(_string(row, 'equipment_id'))},
    namePtPt: ${_dartString(_string(row, 'name_pt_pt'))},
    type: ${_dartString(_string(row, 'equipment_type'))},
  ),''').join('\n')}
];
''';

String _renderArmExercises(ArmMuscularSourceData data) =>
    '''part of 'canonical_arm_exercises_registry.g.dart';

const generatedCanonicalArmExercises = <CanonicalArmExercise>[
${data.exercises.map((row) {
      final equipment = _map(row['equipment'], 'exercise equipment');
      final execution = _map(row['execution'], 'exercise execution');
      final mechanics = _map(row['mechanics'], 'exercise mechanics');
      final safety = _map(row['safety'], 'exercise safety');
      return '''  CanonicalArmExercise(
    id: ${_dartString(_string(row, 'exercise_id'))},
    namePtPt: ${_dartString(_string(row, 'name_pt_pt'))},
    nameEn: ${_dartString(_string(row, 'name_en'))},
    familyId: ${_dartString(_string(row, 'family_id'))},
    state: ${_publicationState(_string(row, 'status'))},
    isPublicEligible: ${row['public_eligible'] == true},
    shortDescriptionPtPt: ${_dartString(_string(row, 'short_description'))},
    technicalDescriptionPtPt: ${_dartString(_string(row, 'technical_description'))},
    requiredEquipmentIds: ${_dartStrings(_stringList(equipment['required_ids'], 'required equipment'))},
    optionalEquipmentIds: ${_dartStrings(_stringList(equipment['optional_ids'], 'optional equipment'))},
    alternativeEquipmentIds: ${_dartStrings(_stringList(equipment['alternative_ids'], 'alternative equipment'))},
    setupPtPt: ${_dartStrings(_stringList(execution['setup'], 'setup'))},
    startPositionPtPt: ${_dartString(_string(execution, 'start_position'))},
    movementPtPt: ${_dartString(_string(execution, 'movement'))},
    endPositionPtPt: ${_dartString(_string(execution, 'end_position'))},
    trajectoryPtPt: ${_dartString(_string(execution, 'trajectory'))},
    cuesPtPt: ${_dartStrings(_stringList(execution['cues'], 'cues'))},
    commonErrorsPtPt: ${_dartStrings(_stringList(execution['common_errors'], 'errors'))},
    stopConditionsPtPt: ${_dartStrings(_stringList(execution['stop_conditions'], 'stops'))},
    generalCautionsPtPt: ${_dartStrings(_stringList(safety['general_cautions'], 'cautions'))},
    specialistReviewPtPt: ${_dartString(_string(safety, 'specialist_review'))},
    jointIds: ${_dartStrings(_stringList(mechanics['joint_ids'], 'joint ids'))},
    actionIds: ${_dartStrings(_stringList(mechanics['action_ids'], 'action ids'))},
    sourceIds: ${_dartStrings(_stringList(row['source_ids'], 'source ids'))},
  ),''';
    }).join('\n')}
];
''';

String _renderPublicContents(ArmMuscularSourceData data) =>
    '''part of 'canonical_arm_exercises_registry.g.dart';

const generatedCanonicalArmExercisePublicContents = <CanonicalArmExercisePublicContent>[
${data.publicExercises.map((row) => '''  CanonicalArmExercisePublicContent(
    exerciseId: ${_dartString(_string(row, 'exercise_id'))},
    namePtPt: ${_dartString(_string(row, 'name'))},
    objectivePtPt: ${_dartString(_string(row, 'objective'))},
    instructionsPtPt: ${_dartStrings(_stringList(row['instructions'], 'instructions'))},
    equipmentPtPt: ${_dartStrings(_stringList(row['equipment'], 'equipment'))},
    primaryMusclesPtPt: ${_dartStrings(_stringList(row['primary_muscles'], 'primary muscles'))},
    secondaryMusclesPtPt: ${_dartStrings(_stringList(row['secondary_muscles'], 'secondary muscles'))},
    potentialGripLimitersPtPt: ${_dartStrings(_stringList(row['potential_grip_limiters'], 'grip limiters'))},
    commonErrorsPtPt: ${_dartStrings(_stringList(row['common_errors'], 'common errors'))},
    cautionsPtPt: ${_dartStrings(_stringList(row['cautions'], 'cautions'))},
    environmentalControlsPtPt: ${_dartStrings(_stringList(row['environmental_controls'], 'environmental controls'))},
    simpleAlternativesPtPt: ${_dartStrings(_stringList(row['simple_alternatives'], 'alternatives'))},
    limitReasonPtPt: ${_dartString(_optionalString(row, 'limit_reason'))},
    state: ${_publicationState(_string(row, 'status'))},
  ),''').join('\n')}
];
''';

String _renderVariants(ArmMuscularSourceData data) =>
    '''part of 'canonical_arm_exercises_registry.g.dart';

const generatedCanonicalArmExerciseVariants = <CanonicalArmExerciseVariant>[
${data.variants.map((row) => '''  CanonicalArmExerciseVariant(
    id: ${_dartString(_string(row, 'variant_id'))},
    parentExerciseId: ${_dartString(_string(row, 'parent_exercise_id'))},
    namePtPt: ${_dartString(_string(row, 'name_pt_pt'))},
    classification: ${_dartString(_string(row, 'classification'))},
    changesPtPt: ${_dartString(_string(row, 'changes'))},
    mechanicalJustificationPtPt: ${_dartString(_string(row, 'mechanical_justification'))},
    equipmentIds: ${_dartStrings(_stringList(row['equipment_ids'], 'variant equipment'))},
    state: ${_publicationState(_string(row, 'status'))},
    sourceIds: ${_dartStrings(_stringList(row['source_ids'], 'variant source ids'))},
  ),''').join('\n')}
];
''';

String _renderArmRelations(ArmMuscularSourceData data) =>
    '''part of 'canonical_arm_exercises_registry.g.dart';

const generatedCanonicalArmExerciseMuscleRelations = <CanonicalArmExerciseMuscleRelation>[
${data.exerciseMuscleRelations.map((row) => '''  CanonicalArmExerciseMuscleRelation(
    id: ${_dartString(row['relation_id']!)},
    exerciseId: ${_dartString(row['exercise_id']!)},
    muscleId: ${_dartString(row['muscle_id']!)},
    componentId: ${_dartNullable(row['component_id'])},
    role: ${_armRole(row['role']!)},
    contextPtPt: ${_dartString(row['context']!)},
    limitationsPtPt: ${_dartString(row['limitations']!)},
    confidence: ${_dartString(row['confidence']!)},
  ),''').join('\n')}
];

const generatedCanonicalArmExerciseJointRelations = <CanonicalArmExerciseJointRelation>[
${data.exerciseJointRelations.map((row) => '''  CanonicalArmExerciseJointRelation(
    id: ${_dartString(row['relation_id']!)},
    exerciseId: ${_dartString(row['exercise_id']!)},
    jointId: ${_dartString(row['joint_id']!)},
    role: ${_dartString(row['role']!)},
    contextPtPt: ${_dartString(row['context']!)},
  ),''').join('\n')}
];

const generatedCanonicalArmExerciseActionRelations = <CanonicalArmExerciseActionRelation>[
${data.exerciseActionRelations.map((row) => '''  CanonicalArmExerciseActionRelation(
    id: ${_dartString(row['relation_id']!)},
    exerciseId: ${_dartString(row['exercise_id']!)},
    actionId: ${_dartString(row['action_id']!)},
    role: ${_dartString(row['role']!)},
    contractionMode: ${_dartString(row['contraction_mode']!)},
    contextPtPt: ${_dartString(row['context']!)},
  ),''').join('\n')}
];

const generatedCanonicalArmExerciseEquipmentRelations = <CanonicalArmExerciseEquipmentRelation>[
${data.exerciseEquipmentRelations.map((row) => '''  CanonicalArmExerciseEquipmentRelation(
    id: ${_dartString(row['relation_id']!)},
    exerciseId: ${_dartString(row['exercise_id']!)},
    equipmentId: ${_dartString(row['equipment_id']!)},
    type: ${_equipmentType(row['relation_type']!)},
    contextPtPt: ${_dartString(row['context']!)},
  ),''').join('\n')}
];

const generatedCanonicalArmMuscularProvenance = CanonicalArmMuscularProvenance(
  schemaVersion: $_dartSchemaVersion,
  generatorVersion: $_dartGeneratorVersion,
  muscularBundleSha256: $_dartMuscularHash,
  armCatalogueBundleSha256: $_dartArmHash,
);
''';

String get _dartSchemaVersion => _dartString(_schemaVersion);
String get _dartGeneratorVersion => _dartString(_generatorVersion);
String get _dartMuscularHash => _dartString(_muscularArchiveHash);
String get _dartArmHash => _dartString(_armArchiveHash);

String _renderTypedList(
  String type,
  String name,
  List<Map<String, dynamic>> rows,
  String Function(Map<String, dynamic>) render,
) =>
    '''part of 'canonical_muscular_registry.g.dart';

const $name = <$type>[
${rows.map((row) => '  ${render(row)},').join('\n')}
];
''';

String _renderManifest(ArmMuscularSourceData data, Map<String, String> hashes) {
  final document = <String, Object?>{
    'schema_version': _schemaVersion,
    'generator_version': _generatorVersion,
    'sources': <String, Object?>{
      _muscularArchivePath: data.muscularArchive.hash,
      _armArchivePath: data.armArchive.hash,
    },
    'counts': <String, int>{
      'regions': data.regions.length,
      'groups': data.groups.length,
      'muscles': data.muscles.length,
      'components': data.components.length,
      'joints': data.joints.length,
      'actions': data.actions.length,
      'muscle_joint_relations': data.muscleJointRelations.length,
      'muscle_action_relations': data.muscleActionRelations.length,
      'muscle_interactions': data.muscleInteractions.length,
      'muscle_trainability_profiles': data.trainability.length,
      'muscular_relations_total': 1243,
      'public_regions': 2,
      'public_groups': 7,
      'public_muscles': 23,
      'arm_exercises_internal': data.exercises.length,
      'arm_exercises_public': data.publicExercises.length,
      'arm_variants': data.variants.length,
      'limited_exercises': 6,
      'limited_variants': 21,
      'specialist_internal': 1,
      'exercise_muscle_relations': data.exerciseMuscleRelations.length,
      'exercise_joint_relations': data.exerciseJointRelations.length,
      'exercise_action_relations': data.exerciseActionRelations.length,
      'exercise_equipment_relations': data.exerciseEquipmentRelations.length,
    },
    'output_hashes_normalized': hashes,
    'runtime_separation': <String, Object?>{
      'zip_parsed_at_runtime': false,
      'claims_exported_to_runtime': false,
      'bibliography_exported_to_runtime': false,
      'legacy_catalogue_queried': false,
      'database_seeded': false,
      'schema_changed': false,
      'four_pillar_links_added': false,
    },
  };
  return '${const JsonEncoder.withIndent('  ').convert(document)}\n';
}

String _report(ArmMuscularSourceData data, Map<String, String> outputs) =>
    const JsonEncoder.withIndent('  ').convert(<String, Object?>{
      'status': 'PASS',
      'generator_version': _generatorVersion,
      'sources': <String, String>{
        'muscular': data.muscularArchive.hash,
        'arms': data.armArchive.hash,
      },
      'counts': <String, int>{
        'regions': data.regions.length,
        'groups': data.groups.length,
        'muscles': data.muscles.length,
        'components': data.components.length,
        'joints': data.joints.length,
        'actions': data.actions.length,
        'muscular_relations': 1243,
        'muscle_trainability_profiles': data.trainability.length,
        'public_regions': 2,
        'public_groups': 7,
        'public_muscles': 23,
        'arm_exercises_internal': data.exercises.length,
        'arm_exercises_public': data.publicExercises.length,
        'arm_variants': data.variants.length,
      },
      'outputs': outputs.keys.toList()..sort(),
    });

Future<void> _writeOutputs(Map<String, String> outputs) async {
  for (final entry in outputs.entries) {
    final file = File(entry.key);
    await file.parent.create(recursive: true);
    await file.writeAsString(entry.value, encoding: utf8);
  }
  final format = await Process.run(Platform.resolvedExecutable, <String>[
    'format',
    _muscularGeneratedDirectory,
    _armGeneratedDirectory,
    _barrelPath,
  ]);
  _expect(format.exitCode == 0, 'Dart format failed: ${format.stderr}');
}

void _checkOutputs(Map<String, String> expected) {
  for (final entry in expected.entries) {
    final file = File(entry.key);
    _expect(file.existsSync(), 'Missing generated output: ${entry.key}.');
    final actual = file.readAsStringSync(encoding: utf8);
    final equal = entry.key.endsWith('.dart')
        ? _normalizeDart(actual) == _normalizeDart(entry.value)
        : actual == entry.value;
    _expect(
      equal,
      'Generated output diverges: ${entry.key} at ${_firstDifference(actual, entry.value)}. Run generate.',
    );
  }
  final dartOutputs = expected.keys
      .where((path) => path.endsWith('.dart'))
      .toSet();
  final directories = <Directory>[
    Directory(_muscularGeneratedDirectory),
    Directory(_armGeneratedDirectory),
  ];
  for (final directory in directories) {
    _expect(
      directory.existsSync(),
      'Generated directory is missing: ${directory.path}.',
    );
    for (final file in directory.listSync(recursive: true).whereType<File>()) {
      if (file.path.endsWith('.dart')) {
        _expect(
          dartOutputs.contains(file.path.replaceAll('\\', '/')),
          'Unexpected generated Dart file: ${file.path}.',
        );
      }
    }
  }
}

String _normalizeDart(String source) {
  final result = StringBuffer();
  var inQuote = false;
  var quote = '';
  var escaped = false;
  for (final rune in source.runes) {
    final character = String.fromCharCode(rune);
    if (inQuote) {
      result.write(character);
      if (escaped) {
        escaped = false;
      } else if (character == '\\') {
        escaped = true;
      } else if (character == quote) {
        inQuote = false;
      }
      continue;
    }
    if (character == "'" || character == '"') {
      inQuote = true;
      quote = character;
      result.write(character);
    } else if (!RegExp(r'\s').hasMatch(character)) {
      result.write(character);
    }
  }
  // dart format may add a trailing comma to a multiline collection. It does
  // not alter the generated contract, so compare its normalized form.
  return result.toString().replaceAll(RegExp(r',(?=[\]\)])'), '');
}

String _firstDifference(String actual, String expected) {
  final normalizedActual = _normalizeDart(actual);
  final normalizedExpected = _normalizeDart(expected);
  final commonLength = normalizedActual.length < normalizedExpected.length
      ? normalizedActual.length
      : normalizedExpected.length;
  for (var index = 0; index < commonLength; index++) {
    if (normalizedActual.codeUnitAt(index) !=
        normalizedExpected.codeUnitAt(index)) {
      final start = index < 24 ? 0 : index - 24;
      final actualEnd = (index + 24).clamp(0, normalizedActual.length);
      final expectedEnd = (index + 24).clamp(0, normalizedExpected.length);
      return 'normalized offset $index actual=${normalizedActual.substring(start, actualEnd)} expected=${normalizedExpected.substring(start, expectedEnd)}';
    }
  }
  return 'normalized lengths ${normalizedActual.length}/${normalizedExpected.length}';
}

Set<String> _publicIds(ArmMuscularSourceData data, String kind) {
  final result = <String>{};
  for (final area in _list(
    data.publicTaxonomy['navigation'],
    'public navigation',
  )) {
    final areaMap = _map(area, 'public area');
    if (_string(areaMap, 'body_area') != 'upper_body') continue;
    for (final region in _list(areaMap['regions'], 'public regions')) {
      final regionMap = _map(region, 'public region');
      final regionId = _string(regionMap, 'region_id');
      if (regionId != 'arm' && regionId != 'forearm') continue;
      if (kind == 'region') result.add(regionId);
      for (final group in _list(regionMap['groups'], 'public groups')) {
        final groupMap = _map(group, 'public group');
        if (kind == 'group') result.add(_string(groupMap, 'group_id'));
        for (final muscle in _list(groupMap['muscles'], 'public muscles')) {
          if (kind == 'muscle') {
            result.add(_string(_map(muscle, 'public muscle'), 'muscle_id'));
          }
        }
      }
    }
  }
  return result;
}

Map<String, Map<String, dynamic>> _index(
  List<Map<String, dynamic>> rows,
  String key,
) {
  final result = <String, Map<String, dynamic>>{};
  for (final row in rows) {
    final value = _string(row, key);
    _expect(!result.containsKey(value), 'Duplicate $key: $value.');
    result[value] = row;
  }
  return result;
}

Set<String> _ids(List<Map<String, dynamic>> rows, String key) =>
    rows.map((row) => _string(row, key)).toSet();

Set<String> _uniqueIds(
  List<Map<String, dynamic>> rows,
  String key,
  String label,
) {
  final ids = _ids(rows, key);
  _expect(ids.length == rows.length, 'Canonical $label ID collision detected.');
  return ids;
}

Map<String, List<String>> _groupValues(
  List<Map<String, dynamic>> rows,
  String key,
  String value,
) {
  final grouped = <String, List<String>>{};
  for (final row in rows) {
    (grouped[_string(row, key)] ??= <String>[]).add(_string(row, value));
  }
  for (final values in grouped.values) {
    values.sort();
  }
  return grouped;
}

Map<String, List<String>> _groupCsvValues(
  List<Map<String, String>> rows,
  String key,
  String value,
) {
  final grouped = <String, List<String>>{};
  for (final row in rows) {
    (grouped[row[key]!] ??= <String>[]).add(row[value]!);
  }
  for (final values in grouped.values) {
    values.sort();
    final deduplicated = values.toSet().toList()..sort();
    values
      ..clear()
      ..addAll(deduplicated);
  }
  return grouped;
}

int _count(List<Map<String, dynamic>> rows, String key, String value) =>
    rows.where((row) => _string(row, key) == value).length;

String _publicationState(String value) => switch (value) {
  'approved_public' => 'CanonicalArmPublicationState.approvedPublic',
  'approved_with_limits' => 'CanonicalArmPublicationState.approvedWithLimits',
  'specialist_review' => 'CanonicalArmPublicationState.specialistReview',
  _ => _fail('Unknown publication state: $value.'),
};

String? _armRole(String value) => switch (value) {
  'primary' => 'CanonicalArmMuscleRole.primary',
  'primary_contextual' => 'CanonicalArmMuscleRole.primaryContextual',
  'secondary' => 'CanonicalArmMuscleRole.secondary',
  'synergist' => 'CanonicalArmMuscleRole.synergist',
  'stabilizer' => 'CanonicalArmMuscleRole.stabilizer',
  'neutralizer' => 'CanonicalArmMuscleRole.neutralizer',
  'antagonist_control' => 'CanonicalArmMuscleRole.antagonistControl',
  'grip_limiter' => 'CanonicalArmMuscleRole.gripLimiter',
  'specialist_review' => 'CanonicalArmMuscleRole.specialistReview',
  _ => null,
};

String? _equipmentType(String value) => switch (value) {
  'required' => 'CanonicalArmEquipmentRelationType.required',
  'optional' => 'CanonicalArmEquipmentRelationType.optional',
  'alternative' => 'CanonicalArmEquipmentRelationType.alternative',
  _ => null,
};

String _dartString(String value) => jsonEncode(value).replaceAll(r'$', r'\$');
String _dartNullable(String? value) =>
    value == null || value.isEmpty ? 'null' : _dartString(value);
String _relationJointId(Map<String, String> row) {
  final value = row['joint_id'] ?? '';
  return value.isEmpty ? 'not_applicable' : value;
}

String _dartStrings(List<String> values) =>
    '<String>[${values.map(_dartString).join(', ')}]';

String _decodeUtf8(List<int> bytes, String source) {
  try {
    return utf8.decode(bytes, allowMalformed: false);
  } on FormatException {
    _fail('Invalid UTF-8 in $source.');
  }
}

bool _isTextFile(String path) =>
    path.endsWith('.json') ||
    path.endsWith('.jsonl') ||
    path.endsWith('.csv') ||
    path.endsWith('.md') ||
    path.endsWith('.py') ||
    path.endsWith('.txt');

bool _containsCombiningMark(String value) =>
    RegExp(r'[\u0300-\u036f\u1ab0-\u1aff\u1dc0-\u1dff]').hasMatch(value);

List<dynamic> _list(Object? value, String source) {
  _expect(value is List<dynamic>, 'Expected list in $source.');
  return value! as List<dynamic>;
}

Map<String, dynamic> _map(Object? value, String source) {
  _expect(value is Map<String, dynamic>, 'Expected object in $source.');
  return value! as Map<String, dynamic>;
}

String _string(Map<String, dynamic> map, String key) {
  final value = map[key];
  _expect(
    value is String && value.isNotEmpty,
    'Expected non-empty string $key.',
  );
  return value! as String;
}

String _optionalString(Map<String, dynamic> map, String key) {
  final value = map[key];
  if (value == null) return '';
  _expect(value is String, 'Expected string $key.');
  return value as String;
}

List<String> _stringList(Object? value, String source) => _list(value, source)
    .map((item) {
      _expect(item is String, 'Expected string list item in $source.');
      return item! as String;
    })
    .toList(growable: false);

String _sha256(List<int> bytes) => sha256.convert(bytes).toString();
String _normalizedOutputHash(String path, String value) => _sha256(
  utf8.encode(path.endsWith('.dart') ? _normalizeDart(value) : value),
);

Never _fail(String message) => throw ArmMuscularGeneratorFailure(message);
void _expect(bool condition, String message) {
  if (!condition) _fail(message);
}

class ArmMuscularGeneratorFailure implements Exception {
  const ArmMuscularGeneratorFailure(this.message);
  final String message;
}

class ArmMuscularSourceArchive {
  const ArmMuscularSourceArchive(
    this.path,
    this.bytes,
    this.hash,
    this.entries,
    this.manifest,
  );

  final String path;
  final Uint8List bytes;
  final String hash;
  final Map<String, Uint8List> entries;
  final Map<String, dynamic> manifest;
}

class ArmMuscularSourceData {
  const ArmMuscularSourceData({
    required this.muscularArchive,
    required this.armArchive,
    required this.regions,
    required this.groups,
    required this.muscles,
    required this.components,
    required this.joints,
    required this.actions,
    required this.trainability,
    required this.publicTaxonomy,
    required this.muscleJointRelations,
    required this.muscleActionRelations,
    required this.muscleInteractions,
    required this.families,
    required this.equipment,
    required this.exercises,
    required this.publicExercises,
    required this.variants,
    required this.exerciseMuscleRelations,
    required this.exerciseJointRelations,
    required this.exerciseActionRelations,
    required this.exerciseEquipmentRelations,
  });

  final ArmMuscularSourceArchive muscularArchive;
  final ArmMuscularSourceArchive armArchive;
  final List<Map<String, dynamic>> regions;
  final List<Map<String, dynamic>> groups;
  final List<Map<String, dynamic>> muscles;
  final List<Map<String, dynamic>> components;
  final List<Map<String, dynamic>> joints;
  final List<Map<String, dynamic>> actions;
  final List<Map<String, dynamic>> trainability;
  final Map<String, dynamic> publicTaxonomy;
  final List<Map<String, String>> muscleJointRelations;
  final List<Map<String, String>> muscleActionRelations;
  final List<Map<String, String>> muscleInteractions;
  final List<Map<String, dynamic>> families;
  final List<Map<String, dynamic>> equipment;
  final List<Map<String, dynamic>> exercises;
  final List<Map<String, dynamic>> publicExercises;
  final List<Map<String, dynamic>> variants;
  final List<Map<String, String>> exerciseMuscleRelations;
  final List<Map<String, String>> exerciseJointRelations;
  final List<Map<String, String>> exerciseActionRelations;
  final List<Map<String, String>> exerciseEquipmentRelations;
}
