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
  String apkSignerStdout = '',
  String apkSignerStderr = '',
  String apkSignerVersion = 'unknown',
}) {
  final packagePattern = RegExp(
    r"^package: name='([^']+)' versionCode='([^']+)' versionName='([^']+)'",
  );
  final packageMatch = _normalizedLines(
    aaptOutput,
  ).map(packagePattern.firstMatch).whereType<RegExpMatch>().firstOrNull;
  if (packageMatch == null) {
    throw const ReleaseApkVerificationException(
      'aapt did not return package, versionCode, and versionName.',
    );
  }

  final outputSources = <_ApkSignerOutputSource>[
    if (apkSignerOutput.isNotEmpty)
      _ApkSignerOutputSource('combined', apkSignerOutput),
    if (apkSignerStdout.isNotEmpty)
      _ApkSignerOutputSource('stdout', apkSignerStdout),
    if (apkSignerStderr.isNotEmpty)
      _ApkSignerOutputSource('stderr', apkSignerStderr),
  ];
  final signerLines = outputSources
      .expand((source) => _normalizedLines(source.output))
      .toList(growable: false);

  final signerCounts = <int>{};
  final signerCountPattern = RegExp(r'^Number of signers:\s*(\d+)$');
  for (final line in signerLines) {
    final match = signerCountPattern.firstMatch(line);
    if (match != null) signerCounts.add(int.parse(match.group(1)!));
  }
  if (signerCounts.isEmpty) {
    throw _apkSignerFailure(
      'apksigner did not report the number of signers.',
      outputSources,
      apkSignerVersion,
    );
  }
  if (signerCounts.length > 1 || signerCounts.any((count) => count != 1)) {
    throw _apkSignerFailure(
      'apksigner reported an unsupported signer count: '
      '${signerCounts.toList()..sort()}.',
      outputSources,
      apkSignerVersion,
    );
  }

  final certificateValues = <String>[];
  final legacyCertificatePattern = RegExp(
    r'^Signer #(\d+) certificate SHA-256 digest:\s*(\S.*)$',
  );
  final linux37CertificatePattern = RegExp(
    r'^V2 Signer:\s*certificate SHA-256 digest:\s*(\S.*)$',
  );
  for (final line in signerLines) {
    final legacyMatch = legacyCertificatePattern.firstMatch(line);
    if (legacyMatch != null) {
      if (legacyMatch.group(1) != '1') {
        throw _apkSignerFailure(
          'apksigner reported a certificate for an unsupported signer: '
          'Signer #${legacyMatch.group(1)}.',
          outputSources,
          apkSignerVersion,
        );
      }
      certificateValues.add(legacyMatch.group(2)!);
      continue;
    }

    final linux37Match = linux37CertificatePattern.firstMatch(line);
    if (linux37Match != null) {
      certificateValues.add(linux37Match.group(1)!);
    }
  }
  if (certificateValues.isEmpty) {
    throw _apkSignerFailure(
      'apksigner did not return the signer SHA-256 certificate digest.',
      outputSources,
      apkSignerVersion,
    );
  }

  final normalizedCertificates = <String>{};
  for (final value in certificateValues) {
    try {
      normalizedCertificates.add(normalizeCertificateSha256(value));
    } on ReleaseApkVerificationException catch (error) {
      throw _apkSignerFailure(error.message, outputSources, apkSignerVersion);
    }
  }
  if (normalizedCertificates.length != 1) {
    throw _apkSignerFailure(
      'apksigner returned conflicting signer SHA-256 certificate digests.',
      outputSources,
      apkSignerVersion,
    );
  }

  final v2Values = <bool>{};
  final v2Pattern = RegExp(
    r'^Verified using v2 scheme \(APK Signature Scheme v2\):\s*(true|false)$',
  );
  for (final line in signerLines) {
    final match = v2Pattern.firstMatch(line);
    if (match != null) v2Values.add(match.group(1) == 'true');
  }
  if (v2Values.isEmpty) {
    throw _apkSignerFailure(
      'apksigner did not report APK Signature Scheme v2.',
      outputSources,
      apkSignerVersion,
    );
  }
  if (v2Values.length != 1) {
    throw _apkSignerFailure(
      'apksigner returned conflicting APK Signature Scheme v2 results.',
      outputSources,
      apkSignerVersion,
    );
  }

  return ReleaseApkEvidence(
    packageName: packageMatch.group(1)!,
    versionCode: packageMatch.group(2)!,
    versionName: packageMatch.group(3)!,
    certificateSha256: normalizedCertificates.single,
    usesSignatureSchemeV2: v2Values.single,
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

String normalizeCertificateSha256(String value) {
  final trimmed = value.trim();
  final continuous = RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(trimmed);
  final colonSeparated = RegExp(
    r'^(?:[0-9a-fA-F]{2}:){31}[0-9a-fA-F]{2}$',
  ).hasMatch(trimmed);
  if (!continuous && !colonSeparated) {
    throw const ReleaseApkVerificationException(
      'The signer SHA-256 certificate digest must contain exactly 64 '
      'hexadecimal characters, optionally separated into bytes by colons.',
    );
  }
  return trimmed.replaceAll(':', '').toUpperCase();
}

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
  final signerVersionResult = await _runTool(apkSigner.path, ['--version']);
  final signerVersion = signerVersionResult.exitCode == 0
      ? '${signerVersionResult.stdout}\n${signerVersionResult.stderr}'.trim()
      : 'unavailable (exit code ${signerVersionResult.exitCode})';

  return parseReleaseApkEvidence(
    aaptOutput: '${aaptResult.stdout}\n${aaptResult.stderr}',
    apkSignerOutput: '',
    apkSignerStdout: '${signerResult.stdout}',
    apkSignerStderr: '${signerResult.stderr}',
    apkSignerVersion: signerVersion,
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

Iterable<String> _normalizedLines(String output) sync* {
  for (final line
      in output.replaceAll('\r\n', '\n').replaceAll('\r', '\n').split('\n')) {
    final trimmed = line.trim();
    if (trimmed.isNotEmpty) yield trimmed;
  }
}

ReleaseApkVerificationException _apkSignerFailure(
  String reason,
  List<_ApkSignerOutputSource> sources,
  String version,
) {
  final diagnostics = sources
      .map((source) {
        final relevant = _normalizedLines(source.output)
            .where(
              (line) =>
                  line.contains('Signer') ||
                  line.startsWith('Number of signers:') ||
                  line.startsWith('Verified'),
            )
            .toList(growable: false);
        return '${source.name}: '
            '${relevant.isEmpty ? '<no relevant lines>' : relevant.join(' | ')}';
      })
      .join('; ');
  final safeVersion = version.replaceAll(RegExp(r'[\r\n]+'), ' ').trim();
  return ReleaseApkVerificationException(
    '$reason apksigner version: '
    '${safeVersion.isEmpty ? 'unknown' : safeVersion}. '
    'Relevant output: '
    '${diagnostics.isEmpty ? '<no stdout or stderr>' : diagnostics}',
  );
}

final class _ApkSignerOutputSource {
  const _ApkSignerOutputSource(this.name, this.output);

  final String name;
  final String output;
}
