import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/testing/src/manifest.dart';

void main() {
  late Directory root;

  setUp(() {
    root = Directory.systemTemp.createTempSync('evefit-manifest-');
    Directory(
      '${root.path}${Platform.pathSeparator}test${Platform.pathSeparator}one',
    ).createSync(recursive: true);
    for (final name in ['a', 'b', 'c', 'd']) {
      File(
        '${root.path}${Platform.pathSeparator}test${Platform.pathSeparator}one${Platform.pathSeparator}${name}_test.dart',
      ).writeAsStringSync('');
    }
  });

  tearDown(() => root.deleteSync(recursive: true));

  TestManifest manifest(List<List<String>> tests) =>
      TestManifest(1, 'fixture', [
        TestShard('shard-1', 1, tests[0]),
        TestShard('shard-2', 1, tests[1]),
        TestShard('shard-3', 1, tests[2]),
        TestShard('shard-4', 1, tests[3]),
      ]);

  test('accepts a complete deterministic shard union', () {
    final complete = manifest([
      ['test/one/a_test.dart'],
      ['test/one/b_test.dart'],
      ['test/one/c_test.dart'],
      ['test/one/d_test.dart'],
    ]);
    expect(validateManifest(complete, root), isEmpty);
    expect(complete.tests.toSet().length, 4);
  });

  test(
    'reports duplicates, missing files, escaped paths, and unsorted entries',
    () {
      final value = manifest([
        ['test/one/b_test.dart', 'test/one/a_test.dart'],
        ['test/one/b_test.dart'],
        ['test/../outside_test.dart'],
        ['test/one/missing_test.dart'],
      ]);
      final errors = validateManifest(value, root).join('\n');
      expect(errors, contains('not sorted'));
      expect(errors, contains('Duplicate test path'));
      expect(errors, contains('Path escapes'));
      expect(errors, contains('Missing test path'));
      expect(errors, contains('does not exist'));
    },
  );
}
