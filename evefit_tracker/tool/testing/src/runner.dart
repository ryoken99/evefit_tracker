import 'dart:io';

import 'models.dart';

Future<CommandResult> runCommand(
  GateCommand command,
  Directory root,
  Directory logDirectory,
) async {
  logDirectory.createSync(recursive: true);
  final safeName = command.name.replaceAll(RegExp(r'[^a-zA-Z0-9_.-]'), '_');
  final log = File(
    '${logDirectory.path}${Platform.pathSeparator}$safeName.log',
  );
  final watch = Stopwatch()..start();
  try {
    final result = await Process.run(
      command.executable,
      command.arguments,
      workingDirectory: root.path,
    );
    watch.stop();
    log.writeAsStringSync('${result.stdout}${result.stderr}');
    return CommandResult(command, result.exitCode, log.path, watch.elapsed);
  } on ProcessException catch (error) {
    watch.stop();
    log.writeAsStringSync(error.toString());
    return CommandResult(command, exitEnvironment, log.path, watch.elapsed);
  }
}
