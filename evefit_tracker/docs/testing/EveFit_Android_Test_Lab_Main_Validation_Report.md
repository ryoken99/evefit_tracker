# EveFit Android Test Lab: Main Validation

- Date: 2026-07-11
- Pull request: #6, https://github.com/ryoken99/evefit_tracker/pull/6
- Validated head: `9bb7bacdda5d389ff93cdb5c5915533fff4b8200`
- Quality gate: passed (`Flutter quality gate / quality`)
- Merge method: merge commit
- Merge commit: `be2ceacda56792f893bbbcd334aa2e24c0bf124c`
- Main commit used by the test: `be2ceacda56792f893bbbcd334aa2e24c0bf124c`
- App version: `1.0.0-rc.1` (unchanged)

## Android Validation

Command executed from main:

```powershell
.\tool\run_dashboard_integration_test.ps1 -ClearAppData
```

- Start: 2026-07-11 13:57:31 UTC
- End: 2026-07-11 14:01:10 UTC
- AVD: `EveFit_Test_Device` (Pixel 8 Pro profile)
- Device ID: `emulator-5554`
- Android: 16 / API 36 / x86_64
- Result: passed
- Exit code: `0`

The test ran only `integration_test/dashboard_rebuild_flow_test.dart`; it did not run the historical full test suite. No unhandled exception was recorded.

## Scenarios

The run passed all Dashboard scenarios:

1. Profile with no goals: zero cards, zero charts, and the correct empty state.
2. Compatible Weight goal with no enabled metrics: editor exposes only permitted metrics and Dashboard remains empty.
3. Weight enabled and saved: immediate card/chart update with no extra metric.
4. Restart: explicit preference persists.
5. Weight disabled: card and chart disappear.
6. Goal removed: the preference is preserved but hidden.
7. Goal re-added: the preference becomes effective again.
8. Second profile: no preference leakage between profiles.

## Evidence

- Screenshots: `test_artifacts/dashboard/integration/2026-07-11T135731Z_dashboard/screenshots/`
- Screenshot count: 9
- Flutter log: `test_artifacts/dashboard/integration/2026-07-11T135731Z_dashboard/flutter_drive.log`
- Logcat: `test_artifacts/dashboard/integration/2026-07-11T135731Z_dashboard/logcat.log`
- Metadata: `test_artifacts/dashboard/integration/2026-07-11T135731Z_dashboard/metadata.json`

Artifacts are timestamped, ignored by Git, and excluded from this commit.

## Scope Confirmation

- Catalog altered: no.
- Exercises altered: no.
- Training filters altered: no.
- Canonical schemas altered: no.
- App version altered: no.
- Project goals, measurements, and history altered: no.
- Test script altered Git state: no.

At validation completion, the only untracked entries were the known external martial-arts source file and `docs/catalog_reports/v0.9.4/menu_matrix_review_pack.zip`; neither is included.
