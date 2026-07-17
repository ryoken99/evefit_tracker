import 'dart:convert';
import 'dart:io';

import 'paths.dart';

class TestShard {
  const TestShard(this.id, this.estimatedMilliseconds, this.tests);

  final String id;
  final int estimatedMilliseconds;
  final List<String> tests;
}

class TestManifest {
  const TestManifest(this.version, this.profile, this.shards);

  final int version;
  final String profile;
  final List<TestShard> shards;

  Iterable<String> get tests => shards.expand((shard) => shard.tests);
}

TestManifest readManifest(File file) {
  final decoded = jsonDecode(file.readAsStringSync());
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('Manifest root must be an object');
  }
  final shards = decoded['shards'];
  if (decoded['version'] is! int ||
      decoded['profile'] is! String ||
      shards is! List) {
    throw const FormatException(
      'Manifest requires version, profile, and shards',
    );
  }
  return TestManifest(
    decoded['version'] as int,
    decoded['profile'] as String,
    shards
        .map((value) {
          if (value is! Map<String, dynamic> ||
              value['id'] is! String ||
              value['estimatedMilliseconds'] is! int ||
              value['tests'] is! List) {
            throw const FormatException(
              'Each shard requires id, estimatedMilliseconds, and tests',
            );
          }
          return TestShard(
            value['id'] as String,
            value['estimatedMilliseconds'] as int,
            (value['tests'] as List).cast<String>(),
          );
        })
        .toList(growable: false),
  );
}

List<String> validateManifest(TestManifest manifest, Directory root) {
  final errors = <String>[];
  if (manifest.version != 1) {
    errors.add('Unsupported manifest version: ${manifest.version}');
  }
  if (manifest.shards.length != 4) {
    errors.add('Manifest must define exactly four shards');
  }
  final seen = <String>{};
  for (final shard in manifest.shards) {
    if (shard.id.isEmpty || shard.tests.isEmpty) {
      errors.add('Shard ${shard.id} is empty');
    }
    final sorted = [...shard.tests]..sort();
    if (shard.tests.join('\n') != sorted.join('\n')) {
      errors.add('Shard ${shard.id} entries are not sorted');
    }
    for (final test in shard.tests) {
      try {
        final normalized = normalizeRepositoryPath(test);
        if (!normalized.startsWith('test/') ||
            !normalized.endsWith('_test.dart')) {
          errors.add('Invalid test path: $test');
        }
        if (!seen.add(normalized)) {
          errors.add('Duplicate test path: $normalized');
        }
      } on FormatException catch (error) {
        errors.add(error.message);
      }
    }
  }
  final actual = root
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.replaceAll('\\', '/').endsWith('_test.dart'))
      .map((file) => repositoryRelativePath(root, file))
      .where((path) => path.startsWith('test/'))
      .toSet();
  final missing = actual.difference(seen).toList()..sort();
  final stale = seen.difference(actual).toList()..sort();
  errors.addAll(missing.map((path) => 'Missing test path: $path'));
  errors.addAll(stale.map((path) => 'Manifest test does not exist: $path'));
  return errors;
}
