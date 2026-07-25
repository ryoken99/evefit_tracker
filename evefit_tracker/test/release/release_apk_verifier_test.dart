import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/release/release_apk_verifier.dart';

void main() {
  group('release APK evidence', () {
    test('accepts the real Linux Build Tools 37 output', () {
      final evidence = _parseSigner(_linux37Output);

      expect(
        () => verifyReleaseApkEvidence(contract: _contract, evidence: evidence),
        returnsNormally,
      );
      expect(evidence.certificateSha256, _expectedCertificate);
      expect(evidence.usesSignatureSchemeV2, isTrue);
    });

    test('preserves support for the legacy Windows output', () {
      final evidence = _parseSigner(_legacySignerOutput);

      expect(evidence.certificateSha256, _expectedCertificate);
      expect(evidence.usesSignatureSchemeV2, isTrue);
    });

    test('normalizes LF, CRLF, and peripheral whitespace', () {
      for (final separator in const ['\n', '\r\n']) {
        final decorated = _linux37Output
            .split('\n')
            .map((line) => '  $line  ')
            .join(separator);

        final evidence = _parseSigner(decorated);

        expect(evidence.certificateSha256, _expectedCertificate);
        expect(evidence.usesSignatureSchemeV2, isTrue);
      }
    });

    test('accepts continuous and colon-separated hex in either case', () {
      final lower = _expectedCertificate.toLowerCase();
      final variants = <String>[
        lower,
        _expectedCertificate,
        _colonSeparated(lower),
        _colonSeparated(_expectedCertificate),
      ];

      for (final variant in variants) {
        final output = _legacySignerOutput.replaceFirst(
          _expectedCertificate,
          variant,
        );

        expect(_parseSigner(output).certificateSha256, _expectedCertificate);
      }
    });

    test('accepts evidence from stdout or stderr with surrounding lines', () {
      for (final inStdout in const [true, false]) {
        final output = 'before\n$_linux37Output\nafter';
        final evidence = parseReleaseApkEvidence(
          aaptOutput: _aaptOutput,
          apkSignerOutput: '',
          apkSignerStdout: inStdout ? output : '',
          apkSignerStderr: inStdout ? '' : output,
          apkSignerVersion: '0.9',
        );

        expect(evidence.certificateSha256, _expectedCertificate);
        expect(evidence.usesSignatureSchemeV2, isTrue);
      }
    });

    test('rejects missing, malformed, or non-SHA-256 digests', () {
      final sha1Only = '''
Verified using v2 scheme (APK Signature Scheme v2): true
Number of signers: 1
V2 Signer: certificate SHA-1 digest: e67ae7b509c8f778a318e3800c401a3f18532d9f
''';
      final malformed = <String>[
        _linux37Output.replaceFirst(
          RegExp(
            r'^V2 Signer: certificate SHA-256 digest:.*$',
            multiLine: true,
          ),
          '',
        ),
        _linux37WithDigest(_hexBytes(31)),
        _linux37WithDigest(_hexBytes(33)),
        _linux37WithDigest('${_hexBytes(31)}AG'),
        sha1Only,
      ];

      for (final output in malformed) {
        expect(
          () => _parseSigner(output),
          throwsA(isA<ReleaseApkVerificationException>()),
        );
      }
    });

    test('rejects absent, false, or conflicting v2 evidence', () {
      final withoutV2 = _linux37Output.replaceFirst(
        RegExp(
          r'^Verified using v2 scheme \(APK Signature Scheme v2\):.*$',
          multiLine: true,
        ),
        '',
      );
      expect(
        () => _parseSigner(withoutV2),
        throwsA(isA<ReleaseApkVerificationException>()),
      );

      final falseV2 = _parseSigner(
        _linux37Output.replaceFirst(
          'Verified using v2 scheme (APK Signature Scheme v2): true',
          'Verified using v2 scheme (APK Signature Scheme v2): false',
        ),
      );
      expect(
        () => verifyReleaseApkEvidence(contract: _contract, evidence: falseV2),
        throwsA(isA<ReleaseApkVerificationException>()),
      );

      expect(
        () => _parseSigner(
          '$_linux37Output\n'
          'Verified using v2 scheme (APK Signature Scheme v2): false',
        ),
        throwsA(isA<ReleaseApkVerificationException>()),
      );
    });

    test('rejects conflicting digests and multiple signers', () {
      final otherCertificate = _hexBytes(32, 'AB');
      expect(
        () => _parseSigner(
          '$_linux37Output\n'
          'Signer #1 certificate SHA-256 digest: $otherCertificate',
        ),
        throwsA(isA<ReleaseApkVerificationException>()),
      );

      expect(
        () => _parseSigner(
          _linux37Output.replaceFirst(
            'Number of signers: 1',
            'Number of signers: 2',
          ),
        ),
        throwsA(isA<ReleaseApkVerificationException>()),
      );

      expect(
        () => _parseSigner(
          '$_legacySignerOutput\n'
          'Signer #2 certificate SHA-256 digest: $otherCertificate',
        ),
        throwsA(isA<ReleaseApkVerificationException>()),
      );

      expect(
        () => _parseSigner(
          _linux37Output.replaceFirst('Number of signers: 1', ''),
        ),
        throwsA(isA<ReleaseApkVerificationException>()),
      );

      expect(
        () => _parseSigner(
          _linux37Output.replaceFirst(
            'V2 Signer: certificate SHA-256 digest:',
            'V2 Signer #1: certificate SHA-256 digest:',
          ),
        ),
        throwsA(isA<ReleaseApkVerificationException>()),
      );
    });

    test('rejects package, version, and certificate mismatches', () {
      final valid = _parseSigner(_linux37Output);
      final mismatches = <ReleaseApkEvidence>[
        ReleaseApkEvidence(
          packageName: 'invalid.package',
          versionName: valid.versionName,
          versionCode: valid.versionCode,
          certificateSha256: valid.certificateSha256,
          usesSignatureSchemeV2: true,
        ),
        ReleaseApkEvidence(
          packageName: valid.packageName,
          versionName: '1.1.4',
          versionCode: valid.versionCode,
          certificateSha256: valid.certificateSha256,
          usesSignatureSchemeV2: true,
        ),
        ReleaseApkEvidence(
          packageName: valid.packageName,
          versionName: valid.versionName,
          versionCode: '6',
          certificateSha256: valid.certificateSha256,
          usesSignatureSchemeV2: true,
        ),
        ReleaseApkEvidence(
          packageName: valid.packageName,
          versionName: valid.versionName,
          versionCode: valid.versionCode,
          certificateSha256: _hexBytes(32, '00'),
          usesSignatureSchemeV2: true,
        ),
      ];

      for (final mismatch in mismatches) {
        expect(
          () =>
              verifyReleaseApkEvidence(contract: _contract, evidence: mismatch),
          throwsA(isA<ReleaseApkVerificationException>()),
        );
      }

      expect(
        () => parseReleaseApkEvidence(
          aaptOutput: 'badging unavailable',
          apkSignerOutput: _linux37Output,
        ),
        throwsA(isA<ReleaseApkVerificationException>()),
      );
    });

    test('reports safe version and stream-specific diagnostics', () {
      expect(
        () => parseReleaseApkEvidence(
          aaptOutput: _aaptOutput,
          apkSignerOutput: '',
          apkSignerStdout:
              'Verified using v2 scheme (APK Signature Scheme v2): true',
          apkSignerStderr:
              'V3 Signer: certificate SHA-256 digest: '
              '$_expectedCertificate',
          apkSignerVersion: '0.9\n',
        ),
        throwsA(
          isA<ReleaseApkVerificationException>()
              .having((error) => error.message, 'message', contains('0.9'))
              .having(
                (error) => error.message,
                'message',
                contains('stdout: Verified using v2 scheme'),
              )
              .having(
                (error) => error.message,
                'message',
                contains('stderr: V3 Signer: certificate SHA-256 digest'),
              ),
        ),
      );
    });
  });

  group('certificate normalization', () {
    test('normalizes only complete SHA-256 hexadecimal encodings', () {
      expect(
        normalizeCertificateSha256(
          _colonSeparated(_expectedCertificate.toLowerCase()),
        ),
        _expectedCertificate,
      );

      for (final invalid in [
        _hexBytes(31),
        _hexBytes(33),
        '${_hexBytes(31)}AG',
        'AA:${_hexBytes(31)}',
      ]) {
        expect(
          () => normalizeCertificateSha256(invalid),
          throwsA(isA<ReleaseApkVerificationException>()),
        );
      }
    });
  });

  test(
    'release workflow verifies the APK before preparing and uploading it',
    () {
      final workflow = File(
        '../.github/workflows/release.yml',
      ).readAsStringSync();
      final setVersion = workflow.indexOf('- name: Set version name');
      final verify = workflow.indexOf(
        '- name: Verify release APK identity and signing',
      );
      final prepare = workflow.indexOf('- name: Prepare release APK');
      final upload = workflow.indexOf('- name: Create Release');
      final verifyPublished = workflow.indexOf(
        '- name: Verify published release assets',
      );
      final cleanup = workflow.indexOf(
        '- name: Remove temporary signing files',
      );

      expect(setVersion, greaterThanOrEqualTo(0));
      expect(verify, greaterThan(setVersion));
      expect(prepare, greaterThan(verify));
      expect(upload, greaterThan(prepare));
      expect(verifyPublished, greaterThan(upload));
      expect(cleanup, greaterThan(verifyPublished));
      expect(workflow, contains('tool/release/verify_release_apk.dart'));
      expect(
        workflow,
        contains('test/release/release_apk_verifier_integration_test.dart'),
      );
      expect(workflow, contains('/apksigner" --version'));
      expect(workflow, contains('com.sandro.evefittracker'));
      expect(workflow, contains(_expectedCertificate));
      expect(workflow, contains('pubspec_version='));
      expect(workflow, contains('expected_tag="v\${expected_version_name}"'));
      expect(workflow, contains('"\$RELEASE_TAG" != "\$expected_tag"'));
      expect(workflow, contains('--expected-version-name'));
      expect(workflow, contains('--expected-version-code'));
      expect(workflow, contains('sha256sum -c'));
      expect(workflow, contains('gh release download'));
      expect(workflow, contains('cmp --silent'));
      expect(
        workflow,
        contains(r'${{ secrets.ANDROID_RELEASE_KEYSTORE_BASE64 }}'),
      );
      expect(
        workflow,
        contains(r'${{ secrets.ANDROID_RELEASE_KEYSTORE_PASSWORD }}'),
      );
      expect(workflow, contains(r'${{ secrets.ANDROID_RELEASE_KEY_ALIAS }}'));
      expect(
        workflow,
        contains(r'${{ secrets.ANDROID_RELEASE_KEY_PASSWORD }}'),
      );
      expect(
        RegExp(
          r"- name: (Prepare release APK|Create Release|Verify published "
          r"release assets)\n\s+if: github\.event_name == 'push'",
        ).allMatches(workflow),
        hasLength(3),
      );
      expect(workflow, contains('- name: Remove temporary signing files'));
      expect(workflow, contains('if: always()'));
      expect(
        workflow,
        contains(
          'rm -f android/key.properties android/app/release-keystore.jks',
        ),
      );
    },
  );

  test('Android release signing uses temporary CI properties when present', () {
    final gradle = File('android/app/build.gradle.kts').readAsStringSync();

    expect(gradle, contains('rootProject.file("key.properties")'));
    expect(gradle, contains('create("release")'));
    expect(gradle, contains('keystoreProperties["keyAlias"]'));
    expect(gradle, contains('keystoreProperties["keyPassword"]'));
    expect(gradle, contains('keystoreProperties["storeFile"]'));
    expect(gradle, contains('keystoreProperties["storePassword"]'));
    expect(gradle, contains('signingConfigs.getByName("release")'));
    expect(gradle, contains('signingConfigs.getByName("debug")'));
  });
}

ReleaseApkEvidence _parseSigner(String output) {
  return parseReleaseApkEvidence(
    aaptOutput: _aaptOutput,
    apkSignerOutput: output,
    apkSignerVersion: '0.9',
  );
}

String _linux37WithDigest(String digest) {
  return _linux37Output.replaceFirst(
    RegExp(r'^V2 Signer: certificate SHA-256 digest:.*$', multiLine: true),
    'V2 Signer: certificate SHA-256 digest: $digest',
  );
}

String _colonSeparated(String digest) {
  return [
    for (var index = 0; index < digest.length; index += 2)
      digest.substring(index, index + 2),
  ].join(':');
}

String _hexBytes(int count, [String byte = 'AA']) {
  return List.filled(count, byte).join();
}

const _expectedCertificate =
    '59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B';

const _contract = ReleaseApkContract(
  packageName: 'com.sandro.evefittracker',
  versionName: '1.1.5',
  versionCode: '7',
  certificateSha256: _expectedCertificate,
);

const _aaptOutput =
    "package: name='com.sandro.evefittracker' versionCode='7' "
    "versionName='1.1.5' platformBuildVersionName='16'";

const _linux37Output = '''
Verifies
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): false
Verified using v3.1 scheme (APK Signature Scheme v3.1): false
Verified using v3.2 scheme (APK Signature Scheme v3.2): false
Verified using v4 scheme (APK Signature Scheme v4): false
Verified for SourceStamp: false
Number of signers: 1
V2 Signer: certificate DN: C=US, O=Android, CN=Android Debug
V2 Signer: certificate SHA-256 digest: 59042d19d9b0cea872a34cd0d1fd3a268f322b8819d1d6e3849b5761db17230b
V2 Signer: certificate SHA-1 digest: e67ae7b509c8f778a318e3800c401a3f18532d9f
V2 Signer: certificate MD5 digest: e9124634d164235a422a687981d46ef5
V2 Signer: key algorithm: RSA
V2 Signer: key size (bits): 2048
V2 Signer: public key SHA-256 digest: 2740d37dadb9d19ccd4bb1b01565ac66fded96092d6fd86f37f9f55e85e62565
V2 Signer: public key SHA-1 digest: 8fcbafac9a551d4328334d79e0e6b8e8dd548752
V2 Signer: public key MD5 digest: 737525453125eae0da2c586fce1cf73c
''';

const _legacySignerOutput =
    '''
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): false
Number of signers: 1
Signer #1 certificate DN: C=US, O=Android, CN=Android Debug
Signer #1 certificate SHA-256 digest: $_expectedCertificate
''';
