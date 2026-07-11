import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  final directory = Directory(
    Platform.environment['EVEFIT_SCREENSHOT_DIR'] ??
        'test_artifacts/dashboard/screenshots',
  );
  final prefix = Platform.environment['EVEFIT_SCREENSHOT_PREFIX'] ?? '';
  await directory.create(recursive: true);

  await integrationDriver(
    onScreenshot: (name, bytes, [args]) async {
      final filename = prefix.isEmpty ? '$name.png' : '${prefix}_$name.png';
      final file = File('${directory.path}${Platform.pathSeparator}$filename');
      await file.writeAsBytes(bytes, flush: true);
      return true;
    },
  );
}
