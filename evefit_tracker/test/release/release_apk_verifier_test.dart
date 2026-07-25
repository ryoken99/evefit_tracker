import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/release/release_apk_verifier.dart';

void main() {
  const expectedCertificate =
      '59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B';
  const contract = ReleaseApkContract(
    packageName: 'com.sandro.evefittracker',
    versionName: '1.1.5',
    versionCode: '7',
    certificateSha256: expectedCertificate,
  );

  group('release APK evidence', () {
    test('accepts the approved package, version, scheme, and certificate', () {
      final evidence = parseReleaseApkEvidence(
        aaptOutput: _aaptOutput,
        apkSignerOutput: _signerOutput(expectedCertificate.toLowerCase()),
      );

      expect(
        () => verifyReleaseApkEvidence(contract: contract, evidence: evidence),
        returnsNormally,
      );
      expect(evidence.certificateSha256, expectedCertificate);
    });

    test('rejects identity and signing mismatches', () {
      final valid = parseReleaseApkEvidence(
        aaptOutput: _aaptOutput,
        apkSignerOutput: _signerOutput(expectedCertificate),
      );
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
          certificateSha256: List.filled(32, '00').join(),
          usesSignatureSchemeV2: true,
        ),
        ReleaseApkEvidence(
          packageName: valid.packageName,
          versionName: valid.versionName,
          versionCode: valid.versionCode,
          certificateSha256: valid.certificateSha256,
          usesSignatureSchemeV2: false,
        ),
      ];

      for (final mismatch in mismatches) {
        expect(
          () =>
              verifyReleaseApkEvidence(contract: contract, evidence: mismatch),
          throwsA(isA<ReleaseApkVerificationException>()),
        );
      }
    });

    test('rejects missing metadata, certificate, and scheme evidence', () {
      expect(
        () => parseReleaseApkEvidence(
          aaptOutput: 'badging unavailable',
          apkSignerOutput: _signerOutput(expectedCertificate),
        ),
        throwsA(isA<ReleaseApkVerificationException>()),
      );
      expect(
        () => parseReleaseApkEvidence(
          aaptOutput: _aaptOutput,
          apkSignerOutput:
              'Verified using v2 scheme (APK Signature Scheme v2): true',
        ),
        throwsA(isA<ReleaseApkVerificationException>()),
      );
      expect(
        () => parseReleaseApkEvidence(
          aaptOutput: _aaptOutput,
          apkSignerOutput:
              'Signer #1 certificate SHA-256 digest: $expectedCertificate',
        ),
        throwsA(isA<ReleaseApkVerificationException>()),
      );
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

      expect(setVersion, greaterThanOrEqualTo(0));
      expect(verify, greaterThan(setVersion));
      expect(prepare, greaterThan(verify));
      expect(upload, greaterThan(prepare));
      expect(verifyPublished, greaterThan(upload));
      expect(workflow, contains('tool/release/verify_release_apk.dart'));
      expect(workflow, contains('com.sandro.evefittracker'));
      expect(workflow, contains(expectedCertificate));
      expect(workflow, contains('pubspec_version='));
      expect(workflow, contains('expected_tag="v\${expected_version_name}"'));
      expect(workflow, contains('"\$RELEASE_TAG" != "\$expected_tag"'));
      expect(workflow, contains('--expected-version-name'));
      expect(workflow, contains('--expected-version-code'));
      expect(workflow, contains('sha256sum -c'));
      expect(workflow, contains('gh release download'));
      expect(workflow, contains('cmp --silent'));
    },
  );
}

const _aaptOutput =
    "package: name='com.sandro.evefittracker' versionCode='7' "
    "versionName='1.1.5' platformBuildVersionName='16'";

String _signerOutput(String certificate) =>
    '''
Verified using v1 scheme (JAR signing): false
Verified using v2 scheme (APK Signature Scheme v2): true
Verified using v3 scheme (APK Signature Scheme v3): false
Signer #1 certificate DN: C=US, O=Android, CN=Android Debug
Signer #1 certificate SHA-256 digest: $certificate
''';
