# EveFit v1.1.4 Release Signing Hotfix Report

## Scope

This hotfix corrects the public APK asset for EveFit v1.1.4 and adds a
fail-closed release verification step. It does not change application behavior,
the public version, the database schema, migrations, the v1.1.4 tag, or the
existing release identity.

## Part A - Public asset correction

- Replaced asset SHA-256:
  `60527E922FF42A6B853E7B0922D24E80FDA0490E5B3068BDAE0F9BAEB098E512`
- Replaced certificate SHA-256:
  `29C606E23A35CE521B731804F2A84A3E182A54604E251AC857E0FEDF46298AA3`
- Final main and tag SHA: `836ad5ea05fb1d74f6e1113ef55e2f26384263d6`
- Release: `https://github.com/ryoken99/evefit_tracker/releases/tag/v1.1.4`
- Asset: `EveFit-v1.1.4-seven-contexts-training-intentions-release.apk`
- Size: `55282657` bytes
- APK SHA-256:
  `64EF52A85DDDDDCB6F9CF1F07645590B2338BC060D7FA7A3913E3E5636B934DA`
- Package: `com.sandro.evefittracker`
- versionName: `1.1.4`
- versionCode: `6`
- APK Signature Scheme v2: verified
- Certificate subject: `C=US, O=Android, CN=Android Debug`
- Certificate SHA-256:
  `59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B`
- The downloaded public asset is byte-for-byte equal to the approved final-main
  candidate.

The real upgrade test installed v1.1.4 over v1.1.3 with `adb install -r`. It did
not uninstall v1.1.3 between versions. Profiles, measurements, goals, workouts,
workout exercises, workout sets, preferences, foreign keys, and historical data
were preserved. Schema version 22 remained unchanged. The application opened,
showed all seven contexts, exposed explicit intention confirmation, and kept
legacy content hidden.

Upgrade result:

- exit code: `0`
- duration: `128.981` seconds
- profiles: `1 -> 1`
- body measurements: `1 -> 1`
- goals: `1 -> 1`
- workouts: `1 -> 1`
- workout exercises: `1 -> 1`
- workout sets: `1 -> 1`
- dashboard preferences: `1 -> 57`, with no row loss
- foreign key violations: `0`

Upgrade artifact directory:

`test_artifacts/release/v1.1.4/upgrade/2026-07-21T035652Z/`

## Part B - Permanent release protection

The release workflow now stops before asset preparation and upload unless all
of these checks pass:

- the requested release tag matches the version in `pubspec.yaml`;
- the release APK exists and is non-empty;
- package name is `com.sandro.evefittracker`;
- versionName and versionCode match `pubspec.yaml`;
- APK Signature Scheme v2 is verified;
- the signer certificate SHA-256 matches the approved certificate.

The verifier prints only release identity evidence. It does not read, store, or
print signing secrets. The current Android debug signing configuration remains
unchanged; this hotfix only prevents an incompatible certificate from reaching
the upload step.

## Validation

- focused verifier and version metadata tests: `6`, passed
- complete Flutter suite: `682`, passed in `145.822` seconds
- `flutter analyze`: passed with zero issues
- full repository Dart format check: `319` files, zero changes
- workflow YAML parse: passed
- approved public APK verification: passed
- deliberately incorrect certificate verification: rejected with exit code `1`
- real public-asset upgrade test: passed with exit code `0`
- initial PR classification rejected the new `tool/release/` path as unknown;
  the classifier now maps that path to the release gate and has a regression
  test for the fail-closed decision
- the next PR run correctly rejected the unassigned verifier test; the test is
  now explicitly assigned to the existing test manifest

## Rollback

The workflow protection can be reverted through the corrective PR without
moving the v1.1.4 tag or changing the public application. The corrected v1.1.4
asset must not be replaced with an APK whose package, version, or certificate
has not passed the same verification and upgrade test.
