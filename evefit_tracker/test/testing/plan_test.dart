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
    final format = plan.commands.firstWhere(
      (command) => command.name == 'format-changed-dart',
    );
    expect(format.executable, Platform.resolvedExecutable);
    expect(format.arguments, containsAll(['format', '--set-exit-if-changed']));
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
      expect(
        pr.commands
            .firstWhere((command) => command.name == 'format')
            .executable,
        Platform.resolvedExecutable,
      );
    },
  );

  test(
    'requested release scripts are explicit and fail closed when unavailable',
    () {
      final root = Directory.systemTemp.createTempSync('evefit-plan-');
      addTearDown(() => root.deleteSync(recursive: true));
      final unavailable = composePlan(
        mode: GateMode.release,
        classification: classified,
        manifest: manifest,
        root: root,
        changedPaths: const ['lib/service.dart'],
        options: const GateOptions(enableAndroid: true),
      );
      expect(unavailable.exitCode, exitEnvironment);
      expect(unavailable.reason, contains('tool/run_android_smoke.ps1'));
      expect(unavailable.commands, isEmpty);

      final allUnavailable = composePlan(
        mode: GateMode.release,
        classification: classified,
        manifest: manifest,
        root: root,
        changedPaths: const ['lib/service.dart'],
        options: const GateOptions(enableFullApp: true, enableUpgrade: true),
      );
      expect(allUnavailable.exitCode, exitEnvironment);
      expect(
        allUnavailable.reason,
        contains('tool/run_canonical_core_full_app_test.ps1'),
      );
      expect(
        allUnavailable.reason,
        contains('tool/run_v112_hierarchical_upgrade_test.ps1'),
      );

      Directory('${root.path}${Platform.pathSeparator}tool').createSync();
      File(
        '${root.path}${Platform.pathSeparator}tool${Platform.pathSeparator}run_android_smoke.ps1',
      ).writeAsStringSync('');
      final available = composePlan(
        mode: GateMode.release,
        classification: classified,
        manifest: manifest,
        root: root,
        changedPaths: const ['lib/service.dart'],
        options: const GateOptions(enableAndroid: true),
      );
      final smoke = available.commands.firstWhere(
        (command) => command.name == 'android-smoke',
      );
      expect(smoke.arguments, const ['-File', 'tool/run_android_smoke.ps1']);
    },
  );

  test('PR UI navigation changes require the Android smoke runner', () {
    final root = Directory.systemTemp.createTempSync('evefit-pr-smoke-');
    addTearDown(() => root.deleteSync(recursive: true));
    const ui = Classification(<ChangeClass>{ChangeClass.uiNavigation});
    final unavailable = composePlan(
      mode: GateMode.pr,
      classification: ui,
      manifest: manifest,
      root: root,
      changedPaths: const ['integration_test/workout_flow_test.dart'],
    );
    expect(unavailable.exitCode, exitEnvironment);
    expect(unavailable.reason, contains('tool/run_android_smoke.ps1'));

    Directory('${root.path}${Platform.pathSeparator}tool').createSync();
    File(
      '${root.path}${Platform.pathSeparator}tool${Platform.pathSeparator}run_android_smoke.ps1',
    ).writeAsStringSync('');
    final available = composePlan(
      mode: GateMode.pr,
      classification: ui,
      manifest: manifest,
      root: root,
      changedPaths: const ['integration_test/workout_flow_test.dart'],
    );
    expect(
      available.commands.map((command) => command.name),
      contains('android-smoke'),
    );
  });

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
