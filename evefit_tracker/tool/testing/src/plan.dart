import 'dart:io';

import 'manifest.dart';
import 'models.dart';

enum GateMode { fast, pr, release }

class GateOptions {
  const GateOptions({
    this.enableAndroid = false,
    this.enableFullApp = false,
    this.enableUpgrade = false,
    this.enableBuild = false,
  });
  final bool enableAndroid;
  final bool enableFullApp;
  final bool enableUpgrade;
  final bool enableBuild;
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
  final flutter = flutterExecutable();
  final dart = Platform.resolvedExecutable;
  final commands = <GateCommand>[];
  final dartChanges =
      changedPaths.where((path) => path.endsWith('.dart')).toList()..sort();
  void add(String name, List<String> args) =>
      commands.add(GateCommand(name, flutter, args));
  if (mode != GateMode.fast) {
    add('pub-get', const ['pub', 'get']);
    add('format', const ['format', '--set-exit-if-changed', '.']);
    add('analyze', const ['analyze']);
  } else {
    if (dartChanges.isNotEmpty) {
      add('format-changed-dart', [
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
  if (mode == GateMode.release) {
    commands.add(
      GateCommand('catalog-audit', dart, const [
        'run',
        'tool/catalog_audit_report.dart',
        '--strict',
      ]),
    );
    _optional(
      commands,
      root,
      options.enableAndroid,
      'android-smoke',
      'powershell',
      const ['-File', 'tool/run_evefit_on_emulator.ps1'],
    );
    _optional(
      commands,
      root,
      options.enableFullApp,
      'full-app',
      'powershell',
      const ['-File', 'tool/run_canonical_core_full_app_test.ps1'],
    );
    _optional(
      commands,
      root,
      options.enableUpgrade,
      'upgrade',
      'powershell',
      const ['-File', 'tool/run_v112_hierarchical_upgrade_test.ps1'],
    );
    if (options.enableBuild) {
      add('android-release-build', const ['build', 'apk', '--release']);
    }
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

void _optional(
  List<GateCommand> commands,
  Directory root,
  bool enabled,
  String name,
  String executable,
  List<String> args,
) {
  if (!enabled) return;
  final script = args.last;
  if (File('${root.path}${Platform.pathSeparator}$script').existsSync()) {
    commands.add(GateCommand(name, executable, args));
  }
}
