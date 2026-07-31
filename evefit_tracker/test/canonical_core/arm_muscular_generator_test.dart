import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../tool/canonical/generate_arm_muscular_registry.dart' as generator;

void main() {
  test(
    'approved arm muscular sources have pinned hashes and exact counts',
    () async {
      final data = await generator.loadArmMuscularSourcesForTesting();

      expect(data.muscularArchive.hash, _muscularHash);
      expect(data.armArchive.hash, _armHash);
      expect(data.regions, hasLength(16));
      expect(data.groups, hasLength(45));
      expect(data.muscles, hasLength(179));
      expect(data.components, hasLength(36));
      expect(data.joints, hasLength(35));
      expect(data.actions, hasLength(94));
      expect(data.trainability, hasLength(179));
      expect(data.muscleJointRelations, hasLength(365));
      expect(data.muscleActionRelations, hasLength(484));
      expect(data.muscleInteractions, hasLength(394));
      expect(
        data.muscleJointRelations.length +
            data.muscleActionRelations.length +
            data.muscleInteractions.length,
        1243,
      );
      expect(data.families, hasLength(15));
      expect(data.equipment, hasLength(33));
      expect(data.exercises, hasLength(36));
      expect(data.publicExercises, hasLength(35));
      expect(data.variants, hasLength(85));
      expect(data.exerciseMuscleRelations, hasLength(228));
      expect(data.exerciseJointRelations, hasLength(86));
      expect(data.exerciseActionRelations, hasLength(68));
      expect(data.exerciseEquipmentRelations, hasLength(91));
    },
  );

  test(
    'generated outputs are current and checking them is deterministic',
    () async {
      await generator.checkArmMuscularOutputsForTesting();
      await generator.checkArmMuscularOutputsForTesting();
    },
  );

  test(
    'missing, truncated, corrupted and hash-mismatched sources fail closed',
    () async {
      final temporary = await Directory.systemTemp.createTemp(
        'evefit_arm_source_',
      );
      addTearDown(() => temporary.delete(recursive: true));

      await expectLater(
        generator.loadArmMuscularSourcesForTesting(
          muscularArchivePath: '${temporary.path}/missing.zip',
        ),
        throwsA(_failsWith('Required source archive is missing')),
      );

      final truncated = File('${temporary.path}/truncated.zip');
      await truncated.writeAsBytes(<int>[1, 2, 3]);
      await expectLater(
        generator.loadArmMuscularSourcesForTesting(
          muscularArchivePath: truncated.path,
          muscularArchiveHash: await _sha256File(truncated),
        ),
        throwsA(_failsWith('Required source archive is truncated')),
      );

      final corrupted = File('${temporary.path}/corrupted.zip');
      await corrupted.writeAsBytes(List<int>.filled(2048, 0x5a));
      await expectLater(
        generator.loadArmMuscularSourcesForTesting(
          muscularArchivePath: corrupted.path,
          muscularArchiveHash: await _sha256File(corrupted),
        ),
        throwsA(_failsWith('Missing SHA256SUMS.txt')),
      );

      await expectLater(
        generator.loadArmMuscularSourcesForTesting(
          muscularArchiveHash: List.filled(64, '0').join(),
        ),
        throwsA(_failsWith('SHA-256 mismatch')),
      );
    },
  );

  test('unsafe ZIP members fail before content parsing', () async {
    final temporary = await Directory.systemTemp.createTemp(
      'evefit_arm_unsafe_',
    );
    addTearDown(() => temporary.delete(recursive: true));
    const root = 'EveFit_Muscular_Knowledge_Base_v0.1.1';
    final random = Random(7);
    final unsafePayload = List<int>.generate(4096, (_) => random.nextInt(256));
    final archive = Archive()
      ..addFile(
        ArchiveFile('$root/../escape.bin', unsafePayload.length, unsafePayload),
      );
    final bytes = ZipEncoder().encode(archive);
    final file = File('${temporary.path}/unsafe.zip');
    await file.writeAsBytes(bytes);

    await expectLater(
      generator.loadArmMuscularSourcesForTesting(
        muscularArchivePath: file.path,
        muscularArchiveHash: sha256.convert(bytes).toString(),
      ),
      throwsA(_failsWith('Unsafe ZIP member path')),
    );
  });

  test(
    'structural drift, duplicate IDs and orphan references fail closed',
    () async {
      final original = await generator.loadArmMuscularSourcesForTesting();

      final missingExercise = _copyWith(
        original,
        exercises: _cloneRecords(original.exercises)..removeLast(),
      );
      expect(
        () =>
            generator.validateArmMuscularSourceDataForTesting(missingExercise),
        throwsA(_failsWith('Expected 36 arm exercises')),
      );

      final extraExercise = _copyWith(
        original,
        exercises: _cloneRecords(original.exercises)
          ..add(Map<String, dynamic>.from(original.exercises.first)),
      );
      expect(
        () => generator.validateArmMuscularSourceDataForTesting(extraExercise),
        throwsA(_failsWith('Expected 36 arm exercises')),
      );

      final duplicateRegionRecords = _cloneRecords(original.regions);
      final duplicateGroups = _cloneRecords(original.groups);
      final duplicateMuscles = _cloneRecords(original.muscles);
      final displacedRegionId = duplicateRegionRecords[1]['canonical_id'];
      duplicateRegionRecords[1]['canonical_id'] =
          duplicateRegionRecords.first['canonical_id'];
      for (final group in duplicateGroups) {
        if (group['region_id'] == displacedRegionId) {
          group['region_id'] = duplicateRegionRecords.first['canonical_id'];
        }
      }
      for (final muscle in duplicateMuscles) {
        if (muscle['region_id'] == displacedRegionId) {
          muscle['region_id'] = duplicateRegionRecords.first['canonical_id'];
        }
      }
      expect(
        () => generator.validateArmMuscularSourceDataForTesting(
          _copyWith(
            original,
            regions: duplicateRegionRecords,
            groups: duplicateGroups,
            muscles: duplicateMuscles,
          ),
        ),
        throwsA(_failsWith('Canonical region ID collision')),
      );

      final orphanComponents = _cloneRecords(original.components);
      orphanComponents.first['parent_muscle_id'] = 'missing_muscle';
      expect(
        () => generator.validateArmMuscularSourceDataForTesting(
          _copyWith(original, components: orphanComponents),
        ),
        throwsA(_failsWith('Component parent missing')),
      );
    },
  );
}

Matcher _failsWith(String message) =>
    isA<generator.ArmMuscularGeneratorFailure>().having(
      (error) => error.message,
      'message',
      contains(message),
    );

Future<String> _sha256File(File file) async =>
    sha256.convert(await file.readAsBytes()).toString();

generator.ArmMuscularSourceData _copyWith(
  generator.ArmMuscularSourceData source, {
  List<Map<String, dynamic>>? regions,
  List<Map<String, dynamic>>? groups,
  List<Map<String, dynamic>>? muscles,
  List<Map<String, dynamic>>? components,
  List<Map<String, dynamic>>? exercises,
}) => generator.ArmMuscularSourceData(
  muscularArchive: source.muscularArchive,
  armArchive: source.armArchive,
  regions: regions ?? source.regions,
  groups: groups ?? source.groups,
  muscles: muscles ?? source.muscles,
  components: components ?? source.components,
  joints: source.joints,
  actions: source.actions,
  trainability: source.trainability,
  publicTaxonomy: source.publicTaxonomy,
  muscleJointRelations: source.muscleJointRelations,
  muscleActionRelations: source.muscleActionRelations,
  muscleInteractions: source.muscleInteractions,
  families: source.families,
  equipment: source.equipment,
  exercises: exercises ?? source.exercises,
  publicExercises: source.publicExercises,
  variants: source.variants,
  exerciseMuscleRelations: source.exerciseMuscleRelations,
  exerciseJointRelations: source.exerciseJointRelations,
  exerciseActionRelations: source.exerciseActionRelations,
  exerciseEquipmentRelations: source.exerciseEquipmentRelations,
);

List<Map<String, dynamic>> _cloneRecords(List<Map<String, dynamic>> records) =>
    (jsonDecode(jsonEncode(records)) as List<dynamic>)
        .cast<Map<String, dynamic>>();

const _muscularHash =
    'a1876a1d4bc21ab54b3828774f66a99519a4953dc00191e69475d8c15b8b30b0';
const _armHash =
    '247b9c6b36e3dd93d7b9c4fc4e6569c2b71eb9c710b8fb2b9ba62ebc86dfd71f';
