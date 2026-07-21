import 'dart:io';

final class ReleaseApkContract {
  const ReleaseApkContract({
    required this.packageName,
    required this.versionName,
    required this.versionCode,
    required this.certificateSha256,
  });

  final String packageName;
  final String versionName;
  final String versionCode;
  final String certificateSha256;
}

final class ReleaseApkEvidence {
  const ReleaseApkEvidence({
    required this.packageName,
    required this.versionName,
    required this.versionCode,
    required this.certificateSha256,
    required this.usesSignatureSchemeV2,
  });

  final String packageName;
  final String versionName;
  final String versionCode;
  final String certificateSha256;
  final bool usesSignatureSchemeV2;
}

final class ReleaseApkVerificationException implements Exception {
  const ReleaseApkVerificationException(this.message);

  final String message;

  @override
  String toString() => 'ReleaseApkVerificationException: $message';
}

ReleaseApkEvidence parseReleaseApkEvidence({
  required String aaptOutput,
  required String apkSignerOutput,
}) {
  final packageMatch = RegExp(
    r"^package: name='([^']+)' versionCode='([^']+)' versionName='([^']+)'",
    multiLine: true,
  ).firstMatch(aaptOutput);
  if (packageMatch == null) {
    throw const ReleaseApkVerificationException(
      'aapt did not return package, versionCode, and versionName.',
    );
  }

  final certificateMatch = RegExp(
    r'^Signer #1 certificate SHA-256 digest:\s*([0-9a-fA-F:]+)\s*$',
    multiLine: true,
  ).firstMatch(apkSignerOutput);
  if (certificateMatch == null) {
    throw const ReleaseApkVerificationException(
      'apksigner did not return the signer SHA-256 certificate digest.',
    );
  }

  final v2Match = RegExp(
    r'^Verified using v2 scheme \(APK Signature Scheme v2\):\s*(true|false)\s*$',
    multiLine: true,
  ).firstMatch(apkSignerOutput);
  if (v2Match == null) {
    throw const ReleaseApkVerificationException(
      'apksigner did not report APK Signature Scheme v2.',
    );
  }

  return ReleaseApkEvidence(
    packageName: packageMatch.group(1)!,
    versionCode: packageMatch.group(2)!,
    versionName: packageMatch.group(3)!,
    certificateSha256: normalizeCertificateSha256(certificateMatch.group(1)!),
    usesSignatureSchemeV2: v2Match.group(1) == 'true',
  );
}

void verifyReleaseApkEvidence({
  required ReleaseApkContract contract,
  required ReleaseApkEvidence evidence,
}) {
  _requireEqual('package name', contract.packageName, evidence.packageName);
  _requireEqual('versionName', contract.versionName, evidence.versionName);
  _requireEqual('versionCode', contract.versionCode, evidence.versionCode);
  _requireEqual(
    'signing certificate SHA-256',
    normalizeCertificateSha256(contract.certificateSha256),
    normalizeCertificateSha256(evidence.certificateSha256),
  );
  if (!evidence.usesSignatureSchemeV2) {
    throw const ReleaseApkVerificationException(
      'APK Signature Scheme v2 is not verified.',
    );
  }
}

String normalizeCertificateSha256(String value) =>
    value.replaceAll(':', '').trim().toUpperCase();

Future<ReleaseApkEvidence> inspectReleaseApk({
  required File apk,
  String? androidSdkRoot,
}) async {
  if (!apk.existsSync() || apk.lengthSync() == 0) {
    throw ReleaseApkVerificationException(
      'Release APK is missing or empty: ${apk.path}',
    );
  }

  final buildTools = _latestBuildToolsDirectory(androidSdkRoot);
  final aapt = File(
    '${buildTools.path}${Platform.pathSeparator}'
    '${Platform.isWindows ? 'aapt.exe' : 'aapt'}',
  );
  final apkSigner = File(
    '${buildTools.path}${Platform.pathSeparator}'
    '${Platform.isWindows ? 'apksigner.bat' : 'apksigner'}',
  );
  if (!aapt.existsSync() || !apkSigner.existsSync()) {
    throw ReleaseApkVerificationException(
      'aapt or apksigner is unavailable in ${buildTools.path}.',
    );
  }

  final aaptResult = await _runTool(aapt.path, ['dump', 'badging', apk.path]);
  _requireSuccessfulTool('aapt', aaptResult);
  final signerResult = await _runTool(apkSigner.path, [
    'verify',
    '--verbose',
    '--print-certs',
    apk.path,
  ]);
  _requireSuccessfulTool('apksigner', signerResult);

  return parseReleaseApkEvidence(
    aaptOutput: '${aaptResult.stdout}\n${aaptResult.stderr}',
    apkSignerOutput: '${signerResult.stdout}\n${signerResult.stderr}',
  );
}

Directory _latestBuildToolsDirectory(String? configuredRoot) {
  final sdkRoot =
      configuredRoot ??
      Platform.environment['ANDROID_SDK_ROOT'] ??
      Platform.environment['ANDROID_HOME'];
  if (sdkRoot == null || sdkRoot.trim().isEmpty) {
    throw const ReleaseApkVerificationException(
      'ANDROID_SDK_ROOT or ANDROID_HOME is required.',
    );
  }

  final buildToolsRoot = Directory(
    '$sdkRoot${Platform.pathSeparator}build-tools',
  );
  if (!buildToolsRoot.existsSync()) {
    throw ReleaseApkVerificationException(
      'Android build-tools directory is unavailable: ${buildToolsRoot.path}',
    );
  }

  final directories = buildToolsRoot.listSync().whereType<Directory>().toList()
    ..sort((left, right) => _compareVersionNames(right.path, left.path));
  if (directories.isEmpty) {
    throw const ReleaseApkVerificationException(
      'No Android build-tools installation was found.',
    );
  }
  return directories.first;
}

int _compareVersionNames(String leftPath, String rightPath) {
  final separator = Platform.pathSeparator;
  final left = leftPath.split(separator).last.split('.');
  final right = rightPath.split(separator).last.split('.');
  final count = left.length > right.length ? left.length : right.length;
  for (var index = 0; index < count; index++) {
    final leftPart = index < left.length ? int.tryParse(left[index]) ?? -1 : 0;
    final rightPart = index < right.length
        ? int.tryParse(right[index]) ?? -1
        : 0;
    final comparison = leftPart.compareTo(rightPart);
    if (comparison != 0) return comparison;
  }
  return leftPath.compareTo(rightPath);
}

Future<ProcessResult> _runTool(String executable, List<String> arguments) {
  return Process.run(executable, arguments, runInShell: Platform.isWindows);
}

void _requireSuccessfulTool(String name, ProcessResult result) {
  if (result.exitCode == 0) return;
  throw ReleaseApkVerificationException(
    '$name failed with exit code ${result.exitCode}: ${result.stderr}',
  );
}

void _requireEqual(String label, String expected, String actual) {
  if (expected == actual) return;
  throw ReleaseApkVerificationException(
    'Unexpected $label. Expected "$expected", found "$actual".',
  );
}
