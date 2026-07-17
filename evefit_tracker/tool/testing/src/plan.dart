import 'dart:io';

import 'manifest.dart';
import 'models.dart';
import 'paths.dart';

enum GateMode { fast, pr, release }

const _androidSmokeScript = 'tool/run_android_smoke.ps1';
const _trackedDartRoots = <String>[
  'lib',
  'test',
  'integration_test',
  'test_driver',
  'tool',
];

class GateOptions {
  const GateOptions({
    this.enableAndroid = false,
    this.enableFullApp = false,
    this.enableUpgrade = false,
    this.enableBuild = false,
    this.baselineApk,
    this.currentApk,
  });
  final bool enableAndroid;
  final bool enableFullApp;
  final bool enableUpgrade;
  final bool enableBuild;
  final String? baselineApk;
  final String? currentApk;
}

class GatePlan {
  const GatePlan(this.commands, this.exitCode, this.reason);
  final List<GateCommand> commands;
  final int exitCode;
  final String? reason;
}

GatePlan composePlan({
  required GateMode mode,
  required Classification classification,
  required TestManifest manifest,
  required Directory root,
  required List<String> changedPaths,
  GateOptions options = const GateOptions(),
}) {
  if (classification.failsClosed) {
    return GatePlan(const [], exitPolicy, classification.reason);
  }
  final requiresAndroidSmoke =
      mode == GateMode.pr &&
      classification.classes.contains(ChangeClass.uiNavigation);
  final missingScripts = _missingRequestedScripts(
    root,
    mode,
    options,
    requiresAndroidSmoke: requiresAndroidSmoke,
  );
  if (missingScripts.isNotEmpty) {
    return GatePlan(
      const [],
      exitEnvironment,
      'Requested validation script is unavailable: ${missingScripts.join(', ')}',
    );
  }
  String? baselineApk;
  String? currentApk;
  if (mode == GateMode.release && options.enableUpgrade) {
    if (options.baselineApk == null) {
      return const GatePlan(
        [],
        exitEnvironment,
        '--enable-upgrade requires --baseline-apk <path>',
      );
    }
    try {
      baselineApk = resolveLocalApk(root, options.baselineApk!).path;
      if (!options.enableBuild && options.currentApk == null) {
        return const GatePlan(
          [],
          exitEnvironment,
          '--enable-upgrade requires --enable-build or --current-apk <path>',
        );
      }
      if (options.currentApk != null) {
        currentApk = resolveLocalApk(root, options.currentApk!).path;
      } else if (options.enableBuild) {
        currentApk = File(
          '${root.absolute.path}${Platform.pathSeparator}build${Platform.pathSeparator}app${Platform.pathSeparator}outputs${Platform.pathSeparator}flutter-apk${Platform.pathSeparator}app-release.apk',
        ).path;
      }
    } on FormatException catch (error) {
      return GatePlan(
        const [],
        exitEnvironment,
        'Invalid upgrade APK path: ${error.message}',
      );
    }
  }
  final flutter = flutterExecutable();
  final dart = Platform.resolvedExecutable;
  final commands = <GateCommand>[];
  final dartChanges =
      changedPaths.where((path) => path.endsWith('.dart')).toList()..sort();
  void add(String name, List<String> args) =>
      commands.add(GateCommand(name, flutter, args));
  void addDart(String name, List<String> args) =>
      commands.add(GateCommand(name, dart, args));
  if (mode != GateMode.fast) {
    add('pub-get', const ['pub', 'get']);
    addDart('format', const [
      'format',
      '--set-exit-if-changed',
      ..._trackedDartRoots,
    ]);
    add('analyze', const ['analyze']);
  } else {
    if (dartChanges.isNotEmpty) {
      addDart('format-changed-dart', [
        'format',
        '--set-exit-if-changed',
        ...dartChanges,
      ]);
    }
    if (dartChanges.isNotEmpty) {
      add('analyze-changed-dart', ['analyze', ...dartChanges]);
    }
  }
  final pipeline = classification.classes.contains(ChangeClass.pipelineTests);
  final contracts = <String>[
    'test/canonical_core/canonical_core_contract_test.dart',
    'test/testing',
  ];
  if (mode == GateMode.fast) {
    final selected = <String>{
      ...contracts,
      ...changedPaths.where(
        (path) => path.startsWith('test/') && path.endsWith('_test.dart'),
      ),
    }.toList()..sort();
    add('focused-tests', ['test', '-r', 'compact', ...selected]);
  } else if (mode == GateMode.pr && !pipeline) {
    add('focused-contract-tests', ['test', '-r', 'compact', ...contracts]);
  } else {
    for (final shard in manifest.shards) {
      add('test-${shard.id}', ['test', '-r', 'compact', ...shard.tests]);
    }
  }
  if (mode != GateMode.fast) {
    commands.add(
      GateCommand('manifest-validation', dart, const [
        'run',
        'tool/testing/evefit_gate.dart',
        'manifest',
      ]),
    );
  }
  if (requiresAndroidSmoke) {
    _addRequestedScript(commands, true, 'android-smoke', 'powershell', const [
      '-File',
      _androidSmokeScript,
    ]);
  }
  if (mode == GateMode.release) {
    commands.add(
      GateCommand('catalog-audit', dart, const [
        'run',
        'tool/catalog_audit_report.dart',
        '--strict',
      ]),
    );
    _addRequestedScript(
      commands,
      options.enableAndroid,
      'android-smoke',
      'powershell',
      const ['-File', _androidSmokeScript],
    );
    _addRequestedScript(
      commands,
      options.enableFullApp,
      'full-app',
      'powershell',
      const ['-File', 'tool/run_workout_exercise_selector_roots_test.ps1'],
    );
    if (options.enableBuild) {
      add('android-release-build', const ['build', 'apk', '--release']);
    }
    _addRequestedScript(
      commands,
      options.enableUpgrade,
      'upgrade',
      'powershell',
      [
        '-File',
        'tool/run_v112_hierarchical_upgrade_test.ps1',
        if (baselineApk != null) ...['-BaselineApk', baselineApk],
        if (currentApk != null) ...['-CurrentApk', currentApk],
      ],
    );
  }
  return GatePlan(commands, exitPass, null);
}

String flutterExecutable() {
  final suffix = Platform.isWindows ? 'flutter.bat' : 'flutter';
  final flutterRoot = Platform.environment['FLUTTER_ROOT'];
  if (flutterRoot != null) {
    final candidate = File(
      '$flutterRoot${Platform.pathSeparator}bin${Platform.pathSeparator}$suffix',
    );
    if (candidate.existsSync()) return candidate.path;
  }
  var directory = File(Platform.resolvedExecutable).parent;
  for (var depth = 0; depth < 6; depth++) {
    final candidate = File(
      '${directory.path}${Platform.pathSeparator}bin${Platform.pathSeparator}$suffix',
    );
    if (candidate.existsSync()) return candidate.path;
    directory = directory.parent;
  }
  return suffix;
}

List<String> _missingRequestedScripts(
  Directory root,
  GateMode mode,
  GateOptions options, {
  required bool requiresAndroidSmoke,
}) {
  if (mode != GateMode.release && !requiresAndroidSmoke) {
    return const [];
  }
  final requested = <String>[
    if (options.enableAndroid || requiresAndroidSmoke) _androidSmokeScript,
    if (mode == GateMode.release && options.enableFullApp)
      'tool/run_workout_exercise_selector_roots_test.ps1',
    if (mode == GateMode.release && options.enableUpgrade)
      'tool/run_v112_hierarchical_upgrade_test.ps1',
  ];
  return requested
      .where(
        (script) =>
            !File('${root.path}${Platform.pathSeparator}$script').existsSync(),
      )
      .toList(growable: false);
}

void _addRequestedScript(
  List<GateCommand> commands,
  bool enabled,
  String name,
  String executable,
  List<String> args,
) {
  if (!enabled) {
    return;
  }
  commands.add(GateCommand(name, executable, args));
}
