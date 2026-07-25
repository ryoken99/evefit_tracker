import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../tool/canonical/generate_wave1_exercises_registry.dart'
    as generator;

void main() {
  test('approved Wave1 sources pass hashes, joins and exact counts', () async {
    final data = await generator.loadWave1ExerciseSourcesForTesting();

    expect(data.technicalArchive.hash, _technicalHash);
    expect(data.publicArchive.hash, _publicHash);
    expect(data.specification.hash, _specificationHash);
    expect(data.technicalExercises, hasLength(49));
    expect(data.publicExercises, hasLength(49));
    expect(data.readyRelations, hasLength(88));
    expect(data.deferredRelations, hasLength(66));
    expect(
      data.technicalExercises.map((item) => item['exercise_id']).toSet(),
      data.publicExercises.map((item) => item['exercise_id']).toSet(),
    );
  });

  test('generated Dart and manifest have no source drift', () async {
    await generator.checkWave1ExerciseOutputsForTesting();
  });

  test('external source hash mismatch fails closed', () async {
    await expectLater(
      generator.loadWave1ExerciseSourcesForTesting(
        technicalArchiveHash:
            '0000000000000000000000000000000000000000000000000000000000000000',
      ),
      throwsA(
        isA<generator.Wave1GeneratorFailure>().having(
          (error) => error.message,
          'message',
          contains('SHA-256 mismatch'),
        ),
      ),
    );
  });

  test('unsafe archive path is rejected before parsing content', () async {
    final temporary = await Directory.systemTemp.createTemp(
      'evefit_wave1_unsafe_',
    );
    addTearDown(() => temporary.delete(recursive: true));
    const unsafeName = '../escape.json';
    final unsafeContent = '{"padding":"${List.filled(2048, 'x').join()}"}';
    final unsafeHash = sha256.convert(utf8.encode(unsafeContent)).toString();
    final archive = Archive()
      ..addFile(ArchiveFile.string(unsafeName, unsafeContent))
      ..addFile(
        ArchiveFile.string(
          'SHA256SUMS_EveFit_Exercise_Implementation_Wave1_v0.1.txt',
          '$unsafeHash  $unsafeName\n',
        ),
      );
    final bytes = ZipEncoder().encode(archive);
    final archiveFile = File('${temporary.path}/unsafe.zip');
    await archiveFile.writeAsBytes(bytes);

    await expectLater(
      generator.loadWave1ExerciseSourcesForTesting(
        technicalArchivePath: archiveFile.path,
        technicalArchiveHash: sha256.convert(bytes).toString(),
      ),
      throwsA(
        isA<generator.Wave1GeneratorFailure>().having(
          (error) => error.message,
          'message',
          contains('Unsafe ZIP member path'),
        ),
      ),
    );
  });

  test('ready relation status mutation fails closed', () async {
    final original = await generator.loadWave1ExerciseSourcesForTesting();
    final mutatedReady = _cloneRecords(original.readyRelations);
    mutatedReady.first['compatibility_status'] = 'conditional';
    final mutated = _copyWith(original, readyRelations: mutatedReady);

    expect(
      () => generator.validateWave1SourceDataForTesting(mutated),
      throwsA(
        isA<generator.Wave1GeneratorFailure>().having(
          (error) => error.message,
          'message',
          contains('Non-compatible relation'),
        ),
      ),
    );
  });

  test('removed, extra and duplicate active relations fail closed', () async {
    final original = await generator.loadWave1ExerciseSourcesForTesting();
    final removed = _cloneRecords(original.readyRelations)..removeLast();
    expect(
      () => generator.validateWave1SourceDataForTesting(
        _copyWith(original, readyRelations: removed),
      ),
      throwsA(isA<generator.Wave1GeneratorFailure>()),
    );

    final extra = _cloneRecords(original.readyRelations)
      ..add(Map<String, dynamic>.from(original.readyRelations.first));
    expect(
      () => generator.validateWave1SourceDataForTesting(
        _copyWith(original, readyRelations: extra),
      ),
      throwsA(isA<generator.Wave1GeneratorFailure>()),
    );

    final duplicate = _cloneRecords(original.readyRelations);
    duplicate[1] = Map<String, dynamic>.from(duplicate.first);
    expect(
      () => generator.validateWave1SourceDataForTesting(
        _copyWith(original, readyRelations: duplicate),
      ),
      throwsA(
        isA<generator.Wave1GeneratorFailure>().having(
          (error) => error.message,
          'message',
          contains('Duplicate relation ID'),
        ),
      ),
    );
  });
}

generator.Wave1SourceData _copyWith(
  generator.Wave1SourceData source, {
  List<Map<String, dynamic>>? readyRelations,
}) => generator.Wave1SourceData(
  technicalArchive: source.technicalArchive,
  publicArchive: source.publicArchive,
  specification: source.specification,
  technicalExercises: source.technicalExercises,
  readyRelations: readyRelations ?? source.readyRelations,
  deferredRelations: source.deferredRelations,
  publicExercises: source.publicExercises,
  technicalManifest: source.technicalManifest,
  publicManifest: source.publicManifest,
  vocabularies: source.vocabularies,
);

List<Map<String, dynamic>> _cloneRecords(List<Map<String, dynamic>> records) =>
    (jsonDecode(jsonEncode(records)) as List<dynamic>)
        .cast<Map<String, dynamic>>();

const _technicalHash =
    '3393bde5d0d3980e823240effac9213ff6f6d3e90148990628e2e216f9287b71';
const _publicHash =
    '35296706fd2abb6f821324f80c8aafc091a944fba9007e3fb933f2046da3b279';
const _specificationHash =
    '9c6c65caa36e785bd82c4d8e4f5d37e1d21e3a974f9676d80658a82d10d9911c';
