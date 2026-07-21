import 'dart:io';

import 'release_apk_verifier.dart';

Future<void> main(List<String> arguments) async {
  try {
    final values = _parseArguments(arguments);
    final contract = ReleaseApkContract(
      packageName: _required(values, 'expected-package'),
      versionName: _required(values, 'expected-version-name'),
      versionCode: _required(values, 'expected-version-code'),
      certificateSha256: _required(values, 'expected-certificate-sha256'),
    );
    final apk = File(_required(values, 'apk'));
    final evidence = await inspectReleaseApk(
      apk: apk,
      androidSdkRoot: values['android-sdk-root'],
    );
    verifyReleaseApkEvidence(contract: contract, evidence: evidence);

    stdout
      ..writeln('EVEFIT_RELEASE_APK=${apk.absolute.path}')
      ..writeln('EVEFIT_RELEASE_PACKAGE=${evidence.packageName}')
      ..writeln('EVEFIT_RELEASE_VERSION_NAME=${evidence.versionName}')
      ..writeln('EVEFIT_RELEASE_VERSION_CODE=${evidence.versionCode}')
      ..writeln('EVEFIT_RELEASE_SIGNATURE_SCHEME_V2=true')
      ..writeln(
        'EVEFIT_RELEASE_CERTIFICATE_SHA256='
        '${evidence.certificateSha256}',
      );
  } on ReleaseApkVerificationException catch (error) {
    stderr.writeln(error.message);
    exitCode = 1;
  } on FormatException catch (error) {
    stderr.writeln(error.message);
    exitCode = 64;
  }
}

Map<String, String> _parseArguments(List<String> arguments) {
  if (arguments.length.isOdd) {
    throw const FormatException('Every release verifier option needs a value.');
  }
  final values = <String, String>{};
  for (var index = 0; index < arguments.length; index += 2) {
    final option = arguments[index];
    if (!option.startsWith('--') || option.length == 2) {
      throw FormatException('Invalid release verifier option: $option');
    }
    values[option.substring(2)] = arguments[index + 1];
  }
  return values;
}

String _required(Map<String, String> values, String name) {
  final value = values[name];
  if (value == null || value.trim().isEmpty) {
    throw FormatException('Missing required option --$name.');
  }
  return value;
}
