import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../tool/canonical/generate_training_intentions_registry.dart'
    as generator;

const _sourceDirectory = 'docs/canonical/source/training_intentions';
const _generatedDirectory =
    'lib/features/canonical_core/generated/training_intentions';
const _manifestPath =
    'docs/canonical/generated/training_intentions_v0.4.1_manifest.json';
const _v04Path =
    '$_sourceDirectory/EveFit_Training_Intentions_Production_Registry_v0.4.md';
const _v041Path =
    '$_sourceDirectory/EveFit_Training_Intentions_Production_Registry_v0.4.1.md';

void main() {
  test(
    'source bytes, UTF-8 text, and manifest source claims are exact',
    () async {
      final v04Bytes = await File(_v04Path).readAsBytes();
      final v041Bytes = await File(_v041Path).readAsBytes();
      final v04 = utf8.decode(v04Bytes, allowMalformed: false);
      final v041 = utf8.decode(v041Bytes, allowMalformed: false);
      final manifest = await _readManifest();

      expect(v04Bytes.length, greaterThan(1000000));
      expect(v041Bytes.length, greaterThan(1000000));
      expect(utf8.encode(v04), orderedEquals(v04Bytes));
      expect(utf8.encode(v041), orderedEquals(v041Bytes));
      expect(v041.runes.any((rune) => rune > 0x7f), isTrue);
      expect(
        sha256.convert(v04Bytes).toString(),
        'd9cf51727dc28aa078b7cc55fa0f6246360e86bcba93b40fe34feac9ac7f50ad',
      );
      expect(
        sha256.convert(v041Bytes).toString(),
        '4d6f6d06f8f593f549dfd0ab132ce09f92ec760dfed11966cdd816be3506c0d8',
      );
      expect(manifest['generator_version'], '1.0.0');
      expect(manifest['registry_version'], '0.4.1');
      expect(
        (manifest['source_files'] as Map<String, dynamic>)[_v04Path]['sha256'],
        sha256.convert(v04Bytes).toString(),
      );
      expect(
        (manifest['source_files'] as Map<String, dynamic>)[_v041Path]['sha256'],
        sha256.convert(v041Bytes).toString(),
      );
      expect(manifest.containsKey('timestamp'), isFalse);
    },
  );

  test(
    'regeneration is byte-deterministic, hashes are independent, and check fails closed',
    () async {
      final manifest = await _readManifest();
      final outputHashes = Map<String, dynamic>.from(
        manifest['output_hashes_normalized'] as Map<String, dynamic>,
      );
      final generatedFiles =
          Directory(_generatedDirectory)
              .listSync()
              .whereType<File>()
              .where((file) => file.path.endsWith('.dart'))
              .toList()
            ..sort((left, right) => left.path.compareTo(right.path));
      final before = <String, List<int>>{
        for (final file in generatedFiles) file.path: await file.readAsBytes(),
        _manifestPath: await File(_manifestPath).readAsBytes(),
      };

      expect(outputHashes, hasLength(10));
      expect(generatedFiles, hasLength(10));
      for (final entry in outputHashes.entries) {
        final bytes = await File(entry.key).readAsBytes();
        expect(bytes, isNotEmpty, reason: entry.key);
        expect(
          sha256.convert(bytes).toString(),
          entry.value,
          reason: entry.key,
        );
      }

      await generator.regenerateTrainingIntentionsOutputsForTesting();
      for (final entry in before.entries) {
        expect(
          await File(entry.key).readAsBytes(),
          orderedEquals(entry.value),
          reason: 'Regeneration changed ${entry.key}.',
        );
      }
      await generator.checkTrainingIntentionsOutputsForTesting();

      final tampered = File(outputHashes.keys.first);
      final original = await tampered.readAsBytes();
      await tampered.writeAsBytes(<int>[...original, 0x0a]);
      try {
        await expectLater(
          generator.checkTrainingIntentionsOutputsForTesting(),
          throwsA(isA<Exception>()),
        );
      } finally {
        await tampered.writeAsBytes(original);
      }
      await generator.checkTrainingIntentionsOutputsForTesting();
    },
  );

  test('historical rows and path-matrix triples round-trip exactly', () async {
    final v04 = utf8.decode(await File(_v04Path).readAsBytes());
    final v041 = utf8.decode(await File(_v041Path).readAsBytes());
    final v04Historic = _tableRows(
      v04,
      '## 12. Mapeamento integral v0.3 para v0.4',
    );
    final v041Historic = _tableRows(
      v041,
      '### 25.2 Mapeamento v0.3 para v0.4 preservado',
    );
    final pathRows = _tableRows(v041, '## 21. Matriz final dos 280 percursos');

    expect(v04Historic, hasLength(693));
    expect(v041Historic, hasLength(693));
    expect(v041Historic, equals(v04Historic));
    expect(pathRows, hasLength(280));

    final historicTriples = <String>{};
    final normalizedHistoricRows = <String>[];
    var historicOccurrences = 0;
    for (final row in v041Historic) {
      expect(row, hasLength(9));
      final historicId = _idAndNameId(row[0]);
      final destinationId = _idAndNameId(row[2]);
      normalizedHistoricRows.add(
        <String>[
          historicId,
          _idAndNameName(row[0]),
          row[1].substring(1, row[1].length - 1),
          destinationId,
          _idAndNameName(row[2]),
          row[3],
          row[4],
          row[5],
          row[6],
          row[7],
          row[8],
        ].join('\u001f'),
      );
      for (final rawPathNumber in row[7].split(', ')) {
        historicTriples.add(
          '$historicId\u001f$rawPathNumber\u001f$destinationId',
        );
        historicOccurrences++;
      }
    }

    final pathMatrixTriples = <String>{};
    var pathMatrixOccurrences = 0;
    for (final row in pathRows) {
      expect(row, hasLength(17));
      final pathNumber = row[0];
      for (final match in RegExp(
        r'`([a-z0-9_]+)`→`([a-z0-9_]+)`',
      ).allMatches(row[6])) {
        pathMatrixTriples.add(
          '${match.group(1)}\u001f$pathNumber\u001f${match.group(2)}',
        );
        pathMatrixOccurrences++;
      }
    }

    expect(historicOccurrences, 792);
    expect(historicTriples, hasLength(792));
    expect(pathMatrixOccurrences, 792);
    expect(pathMatrixTriples, hasLength(792));
    expect(pathMatrixTriples, equals(historicTriples));

    normalizedHistoricRows.sort();
    final manifest = await _readManifest();
    expect(
      sha256
          .convert(utf8.encode('${normalizedHistoricRows.join('\n')}\n'))
          .toString(),
      (manifest['historic_v03_audit']
          as Map<String, dynamic>)['normalized_mapping_sha256'],
    );
    final labels = Map<String, dynamic>.from(
      manifest['contextual_labels'] as Map<String, dynamic>,
    );
    final uniqueLabels = List<String>.from(
      labels['unique_labels_pt_pt'] as List,
    );
    final resolvedOccurrences = List<dynamic>.from(
      labels['resolved_link_occurrences'] as List,
    );
    expect(uniqueLabels, hasLength(59));
    expect(uniqueLabels.toSet(), hasLength(59));
    expect(resolvedOccurrences, hasLength(66));
    expect(
      uniqueLabels.every(
        (label) =>
            utf8.decode(utf8.encode(label), allowMalformed: false) == label,
      ),
      isTrue,
    );
  });

  test(
    'parser rejects malformed structured cells and headers outside their section',
    () async {
      final v04 = utf8.decode(await File(_v04Path).readAsBytes());
      final v041 = utf8.decode(await File(_v041Path).readAsBytes());
      final malformedV041 = v041.replaceFirst(
        '1; principal_candidate:1',
        '1; principal_candidate:1 unexpected_suffix',
      );
      final prefixedV041 = v041.replaceFirst(
        '1; principal_candidate:1',
        'unexpected_prefix 1; principal_candidate:1',
      );

      expect(malformedV041, isNot(equals(v041)));
      expect(prefixedV041, isNot(equals(v041)));
      expect(
        () => generator.validateTrainingIntentionsSourceTextsForTesting(
          sourceV04: v04,
          sourceV041: malformedV041,
        ),
        throwsA(isA<Exception>()),
      );
      expect(
        () => generator.validateTrainingIntentionsSourceTextsForTesting(
          sourceV04: v04,
          sourceV041: prefixedV041,
        ),
        throwsA(isA<Exception>()),
      );
      expect(
        () => generator.readTrainingIntentionsTableForTesting(
          '## intended\ntext\n## later\n| id |\n| --- |\n| `valid` |\n',
          heading: '## intended',
          header: '| id |',
          columnCount: 1,
        ),
        throwsA(isA<Exception>()),
      );
    },
  );
}

Future<Map<String, dynamic>> _readManifest() async => Map<String, dynamic>.from(
  jsonDecode(await File(_manifestPath).readAsString()) as Map<String, dynamic>,
);

List<List<String>> _tableRows(String source, String heading) {
  final lines = source.split('\n');
  final headingIndex = lines.indexOf(heading);
  expect(headingIndex, isNonNegative, reason: heading);
  final sectionEnd = lines.indexWhere(
    (line) => line.startsWith('#'),
    headingIndex + 1,
  );
  final end = sectionEnd < 0 ? lines.length : sectionEnd;
  final headerIndex = lines.indexWhere(
    (line) => line.startsWith('|'),
    headingIndex + 1,
  );
  expect(headerIndex, inInclusiveRange(headingIndex + 1, end - 2));
  expect(lines[headerIndex + 1], startsWith('|'));

  final rows = <List<String>>[];
  for (var index = headerIndex + 2; index < end; index++) {
    if (!lines[index].startsWith('|')) {
      break;
    }
    rows.add(
      lines[index]
          .substring(1, lines[index].length - 1)
          .split('|')
          .map((cell) => cell.trim())
          .toList(),
    );
  }
  return rows;
}

String _idAndNameId(String value) {
  final match = RegExp(r'^`([a-z0-9_]+)` · .+$').firstMatch(value);
  expect(match, isNotNull, reason: value);
  return match!.group(1)!;
}

String _idAndNameName(String value) {
  final match = RegExp(r'^`[a-z0-9_]+` · (.+)$').firstMatch(value);
  expect(match, isNotNull, reason: value);
  return match!.group(1)!;
}
