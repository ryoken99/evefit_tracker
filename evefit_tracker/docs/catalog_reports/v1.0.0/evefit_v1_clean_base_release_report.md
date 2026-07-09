# EveFit v1.0 Clean Base release report

## Release

- Clean Base commit: `eae5216 Prepare EveFit v1.0 Clean Base`.
- Merge result: fast-forward merge from `evefit-v1-clean-base` into `main`, with no conflicts.
- Release commit: created after this report is staged.
- Final main commit: reported in the delivery message after commit creation.

## Files altered in the release commit

- `CHANGELOG.md`
- `docs/catalog_reports/v1.0.0/evefit_v1_clean_base_release_report.md`

## Release notes

Added `EveFit v1.0 Clean Base` to `CHANGELOG.md` with these guarantees:

- Clean app for future canonical catalogue rebuild.
- Old exercise catalogue hidden by reversible configuration.
- Old filters hidden by reversible configuration.
- Legacy data preserved.
- Dashboard goals now show only user-selected goals.
- Users without selected goals do not receive default goals.
- V-shape appears only when selected.
- No new exercises generated.
- No new filters generated.
- No catalogue migration.
- No new canonical schema.

## Validation on main

- `flutter pub get`: passed.
- `dart format --set-exit-if-changed .`: passed, 0 files changed.
- `flutter analyze`: passed, no issues found.
- `flutter test -r compact`: passed, 541 tests.
- `dart run tool/catalog_audit_report.dart --strict`: passed.
  - Catalog entries: 1762.
  - Unique canonical IDs: 1725.
  - Critical issues: 0.
  - Warnings: 0.
- `flutter build apk --debug`: passed.
- `flutter build apk --release`: passed.

## APKs

- Debug APK: `build/app/outputs/flutter-apk/app-debug.apk`
  - Size: 156677034 bytes.
- Release APK: `build/app/outputs/flutter-apk/app-release.apk`
  - Size: 56657861 bytes.
- APKs were generated locally and were not staged or committed.

## Clean Base confirmations

- App is clean for future catalogue work.
- Old exercises do not appear in the user-facing add-exercise flow.
- Old filters do not appear in the normal workout creation flow.
- Legacy exercises, filters and logs remain preserved in code/data.
- Goals display uses selected user goals.
- V-shape appears only when selected.
- No new schema was implemented.
- No migration was performed.
- No new exercises were generated.
- No new filters were generated.
- No Shukokai changes were made.

## Git status before release commit

Expected tracked changes:

- `CHANGELOG.md`
- `docs/catalog_reports/v1.0.0/evefit_v1_clean_base_release_report.md`

Expected untracked files kept out of stage:

- `../15_ARTES_MARCIAIS_EXERCICIOS_DERIVADOS.md`
- `docs/catalog_reports/v0.9.4/menu_matrix_review_pack.zip`
