import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/release/release_apk_verifier.dart';

void main() {
  test('real Android SDK tools verify the release APK contract', () async {
    if (Platform.environment['RUN_RELEASE_APK_INTEGRATION_TEST'] != 'true') {
      return;
    }

    final contract = ReleaseApkContract(
      packageName: _requiredEnvironment('EVEFIT_RELEASE_PACKAGE'),
      versionName: _requiredEnvironment('EVEFIT_RELEASE_VERSION_NAME'),
      versionCode: _requiredEnvironment('EVEFIT_RELEASE_VERSION_CODE'),
      certificateSha256: _requiredEnvironment(
        'EVEFIT_RELEASE_CERTIFICATE_SHA256',
      ),
    );
    final evidence = await inspectReleaseApk(
      apk: File(_requiredEnvironment('EVEFIT_RELEASE_APK')),
      androidSdkRoot:
          Platform.environment['ANDROID_SDK_ROOT'] ??
          Platform.environment['ANDROID_HOME'],
    );

    expect(
      () => verifyReleaseApkEvidence(contract: contract, evidence: evidence),
      returnsNormally,
    );
  });
}

String _requiredEnvironment(String name) {
  final value = Platform.environment[name];
  if (value == null || value.trim().isEmpty) {
    throw StateError('$name is required for the release APK integration test.');
  }
  return value;
}
