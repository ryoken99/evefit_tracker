import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/testing/src/models.dart';
import '../../tool/testing/src/runner.dart';

void main() {
  test('preserves a child process exit code and records its log', () async {
    final root = Directory.systemTemp.createTempSync('evefit-runner-root-');
    final logs = Directory.systemTemp.createTempSync('evefit-runner-logs-');
    addTearDown(() {
      root.deleteSync(recursive: true);
      logs.deleteSync(recursive: true);
    });
    final command = Platform.isWindows
        ? const GateCommand('failure', 'cmd.exe', ['/c', 'exit', '7'])
        : const GateCommand('failure', 'sh', ['-c', 'exit 7']);
    final result = await runCommand(command, root, logs);
    expect(result.exitCode, 7);
    expect(File(result.logPath).existsSync(), isTrue);
  });
}
