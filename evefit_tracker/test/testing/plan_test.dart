import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/testing/src/models.dart';
import '../../tool/testing/src/plan.dart';
import '../../tool/testing/src/manifest.dart';

void main() {
  final manifest = TestManifest(1, 'fixture', const [
    TestShard('shard-1', 10, ['test/a_test.dart']),
    TestShard('shard-2', 10, ['test/b_test.dart']),
    TestShard('shard-3', 10, ['test/c_test.dart']),
    TestShard('shard-4', 10, ['test/d_test.dart']),
  ]);
  final classified = const Classification(<ChangeClass>{ChangeClass.dartNonUi});

  test('fast mode excludes pub get, full shards, and Android builds', () {
    final plan = composePlan(
      mode: GateMode.fast,
      classification: classified,
      manifest: manifest,
      root: Directory.current,
      changedPaths: const ['lib/service.dart'],
    );
    final names = plan.commands.map((command) => command.name).toList();
    expect(
      names,
      containsAll([
        'format-changed-dart',
        'analyze-changed-dart',
        'focused-tests',
      ]),
    );
    expect(names, isNot(contains('pub-get')));
    expect(names.where((name) => name.startsWith('test-shard')), isEmpty);
  });

  test(
    'PR requires every shard for pipeline changes and release composes audit',
    () {
      final pipeline = const Classification(<ChangeClass>{
        ChangeClass.pipelineTests,
      });
      final pr = composePlan(
        mode: GateMode.pr,
        classification: pipeline,
        manifest: manifest,
        root: Directory.current,
        changedPaths: const ['tool/testing/a.dart'],
      );
      expect(
        pr.commands
            .where((command) => command.name.startsWith('test-shard'))
            .length,
        4,
      );
      final release = composePlan(
        mode: GateMode.release,
        classification: classified,
        manifest: manifest,
        root: Directory.current,
        changedPaths: const ['lib/service.dart'],
      );
      expect(
        release.commands.map((command) => command.name),
        contains('catalog-audit'),
      );
    },
  );

  test('policy failures propagate without a runnable command', () {
    final plan = composePlan(
      mode: GateMode.fast,
      classification: const Classification(<ChangeClass>{
        ChangeClass.unknown,
      }, reason: 'unknown'),
      manifest: manifest,
      root: Directory.current,
      changedPaths: const ['unknown'],
    );
    expect(plan.exitCode, exitPolicy);
    expect(plan.commands, isEmpty);
  });
}
