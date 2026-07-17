import 'dart:io';

import 'src/classifier.dart';
import 'src/manifest.dart';
import 'src/models.dart';
import 'src/plan.dart';
import 'src/profiler.dart';
import 'src/runner.dart';

Future<void> main(List<String> argv) async {
  final started = Stopwatch()..start();
  final root = Directory.current;
  var exitCode = exitPass;
  final report = <String, Object?>{
    'argv': argv,
    'startedAtUtc': DateTime.now().toUtc().toIso8601String(),
  };
  try {
    if (argv.isEmpty) {
      throw const _Usage('Expected fast, pr, release, manifest, or profile');
    }
    final command = argv.first;
    if (command == 'manifest') {
      final errors = validateManifest(
        readManifest(
          File(
            '${root.path}${Platform.pathSeparator}tool${Platform.pathSeparator}testing${Platform.pathSeparator}test_shards.json',
          ),
        ),
        root,
      );
      report['manifestErrors'] = errors;
      exitCode = errors.isEmpty ? exitPass : exitPolicy;
    } else if (command == 'profile') {
      final path = _value(argv, '--input') ?? _value(argv, '--profile');
      if (path == null) throw const _Usage('profile requires --input <jsonl>');
      report['profile'] = profileFlutterJsonl(File(path)).toJson();
    } else {
      final mode = GateMode.values
          .where((value) => value.name == command)
          .firstOrNull;
      if (mode == null) throw _Usage('Unknown mode: $command');
      final changed = _changedFiles(argv);
      final classification = classifyChangedFiles(changed);
      final manifest = readManifest(
        File(
          '${root.path}${Platform.pathSeparator}tool${Platform.pathSeparator}testing${Platform.pathSeparator}test_shards.json',
        ),
      );
      final options = GateOptions(
        enableAndroid: argv.contains('--enable-android'),
        enableFullApp: argv.contains('--enable-full-app'),
        enableUpgrade: argv.contains('--enable-upgrade'),
        enableBuild: argv.contains('--enable-build'),
      );
      final plan = composePlan(
        mode: mode,
        classification: classification,
        manifest: manifest,
        root: root,
        changedPaths: changed.map((file) => file.path).toList(),
        options: options,
      );
      report['mode'] = mode.name;
      report['classification'] = classification.toJson();
      report['reason'] = plan.reason;
      report['plan'] = plan.commands.map((item) => item.toJson()).toList();
      exitCode = plan.exitCode;
      report['commands'] = plan.commands
          .map(
            (item) => <String, Object?>{
              ...item.toJson(),
              'exitCode': null,
              'logPath': null,
              'durationMilliseconds': null,
            },
          )
          .toList();
      if (exitCode == exitPass && !argv.contains('--dry-run')) {
        final logs = Directory(
          '${root.path}${Platform.pathSeparator}.dart_tool${Platform.pathSeparator}evefit_gate_logs${Platform.pathSeparator}${DateTime.now().toUtc().toIso8601String().replaceAll(':', '-')}',
        );
        final results = <CommandResult>[];
        for (final item in plan.commands) {
          final result = await runCommand(item, root, logs);
          results.add(result);
          if (result.exitCode != 0) {
            exitCode = result.exitCode == exitEnvironment
                ? exitEnvironment
                : exitValidation;
            break;
          }
        }
        report['commands'] = results.map((item) => item.toJson()).toList();
      }
    }
  } on _Usage catch (error) {
    exitCode = exitUsage;
    report['error'] = error.message;
  } on FormatException catch (error) {
    exitCode = exitPolicy;
    report['error'] = error.message;
  } on FileSystemException catch (error) {
    exitCode = exitEnvironment;
    report['error'] = error.message;
  }
  started.stop();
  report['durationMilliseconds'] = started.elapsedMilliseconds;
  report['exitCode'] = exitCode;
  report['result'] = exitCode == exitPass ? 'pass' : 'fail';
  stdout.writeln(encodeJson(report));
  exitCode == exitPass ? exit(0) : exit(exitCode);
}

String? _value(List<String> args, String flag) {
  final index = args.indexOf(flag);
  return index >= 0 && index + 1 < args.length ? args[index + 1] : null;
}

List<ChangedFile> _changedFiles(List<String> args) {
  final changes = <ChangedFile>[];
  const statuses = <String, ChangeStatus>{
    '--changed': ChangeStatus.modified,
    '--added': ChangeStatus.added,
    '--deleted': ChangeStatus.deleted,
    '--renamed': ChangeStatus.renamed,
  };
  for (var index = 0; index < args.length; index++) {
    final status = statuses[args[index]];
    if (status != null && index + 1 < args.length) {
      changes.add(ChangedFile(args[++index], status: status));
    }
  }
  return changes;
}

class _Usage implements Exception {
  const _Usage(this.message);
  final String message;
}
