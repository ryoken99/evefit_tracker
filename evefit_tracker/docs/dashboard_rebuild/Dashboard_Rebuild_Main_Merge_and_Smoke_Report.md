# Dashboard Rebuild: Main Merge and Emulator Smoke Report

## Summary

- Date: 2026-07-11
- Pull request: https://github.com/ryoken99/evefit_tracker/pull/5
- Validated PR head: `aecdfdff3741e86a0198e631857900655b5e8055`
- Quality gate: passed (`Flutter quality gate / quality`)
- Merge method: merge commit
- Main before merge: `1ce06edbe66d14c5c7859764d6c1a017a27de990`
- Main after merge: `0365401cdcf73fa74c51160a5e9081ba32267cd2`
- Merge time: 2026-07-11 12:53:25 UTC
- App version: `1.0.0-rc.1` (unchanged)

## Pull Request Gate

PR #5 was marked ready only after its required quality check completed successfully. Immediately before merge, the PR was `MERGEABLE`, its merge state was `CLEAN`, its base was `main`, and its head still matched the validated commit. The merge used `gh pr merge --merge --match-head-commit` with the complete expected SHA.

Quality run: https://github.com/ryoken99/evefit_tracker/actions/runs/29152274493/job/86543542509

## Schema Migration 21 to 22

The migration was validated as a real Android application upgrade, not as a clean schema-22 install.

1. A detached temporary worktree was created at the pre-migration main commit `1ce06edbe66d14c5c7859764d6c1a017a27de990`.
2. That source declared database version 21 and was built and installed on the test AVD.
3. The clean schema-21 database was seeded with a test profile, selected goal, body measurement, workout, and legacy `dashboard_widgets` row.
4. The schema-22 debug APK built from main commit `0365401cdcf73fa74c51160a5e9081ba32267cd2` was installed over the schema-21 app without clearing data.
5. The upgraded database was copied out with Android `run-as` and inspected directly with SQLite.

Counts before and after:

| Record | Before (v21) | After (v22) |
| --- | ---: | ---: |
| Profiles | 1 | 1 |
| Goals | 1 | 1 |
| Body measurements | 1 | 1 |
| Workouts | 1 | 1 |
| Dashboard widgets | 1 | 1 |

Direct database evidence:

- `PRAGMA user_version`: `21` before, `22` after.
- `dashboard_widgets` gained nullable `explicitly_configured_at`.
- The existing legacy `weight` row remained present and visible.
- The legacy row had `explicitly_configured_at IS NULL`, as required.
- The profile's selected goal remained present.
- No seeded test row was deleted.

The temporary worktree was removed after the proof. Only emulator test data was used; no Sandro or production data was accessed.

## Android Environment

- AVD: `EveFit_Test_Device`
- Device ID: `emulator-5554`
- Model: `sdk_gphone64_x86_64` (Pixel 8 Pro test profile)
- Android: 16
- API: 36
- ABI: x86_64
- Package ID: `com.sandro.evefittracker`

The main APK was built with:

```powershell
flutter pub get
flutter build apk --debug
```

It was installed over the v21 test app with `adb install -r`, preserving the database during migration.

## Dashboard Integration and Smoke Test

After migration evidence was captured, app data on the test-only AVD was reset to give the automated smoke test an isolated fixture. The test ran from main commit `0365401cdcf73fa74c51160a5e9081ba32267cd2`:

```powershell
flutter drive --driver test_driver/integration_test.dart --target integration_test/dashboard_rebuild_flow_test.dart -d emulator-5554
```

Result: passed, exit code 0, all eight scenarios completed.

Validated behavior:

- No goals: zero cards, zero charts, correct empty state, and no editor metrics.
- Goal selected with no explicit metrics: zero cards and charts, correct edit prompt.
- Weight enabled: card and supported chart appeared immediately, without extra metrics.
- Restart: the explicit weight preference persisted.
- Weight disabled: card and chart disappeared while the measurement remained stored.
- Goal removed: weight became hidden without deleting the explicit preference.
- Goal re-added: the preserved preference became effective again.
- Second profile: preferences remained profile-scoped.

## Evidence

Integration log:

`test_artifacts/dashboard/logs/2026-07-11T130216Z_dashboard_main_integration.log`

Logcat:

`test_artifacts/dashboard/logs/2026-07-11T130216Z_dashboard_main_logcat.log`

Screenshots:

`test_artifacts/dashboard/screenshots/2026-07-11T130216Z/`

The folder contains nine timestamped screenshots covering no goals, no active metrics, enable/save, restart, disable, goal removal, goal re-addition, and profile isolation. These artifacts are ignored by Git and are not part of this commit.

## Scope and Preservation

- Historical measurements preserved: yes.
- Workout history preserved: yes.
- Dashboard legacy rows preserved: yes.
- Public app version changed: no.
- Catalog changed by this merge validation: no.
- Exercises changed by this merge validation: no.
- Training filters changed by this merge validation: no.
- Canonical schemas changed by this merge validation: no.
- APKs, logs, screenshots, and `test_artifacts/` committed: no.

At report creation, main and `origin/main` both pointed to `0365401cdcf73fa74c51160a5e9081ba32267cd2`. The only visible untracked files were the known external martial-arts source file and `docs/catalog_reports/v0.9.4/menu_matrix_review_pack.zip`; neither is included.
