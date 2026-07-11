# EveFit Android Test Lab Final Report

## Repository State

- Branch: `android-test-lab-finalization`
- Base commit: `b3aec6c6ee2e78ddde184ac7d55d33ea200006ec`
- Base meaning: main after Dashboard merge, migration proof, smoke test, and documentary report.
- Public app version: `1.0.0-rc.1` (unchanged).
- Functional application changes in this objective: none.

## Android Environment

- AVD: `EveFit_Test_Device`
- Device profile: Pixel 8 Pro
- Detected device ID: `emulator-5554`
- Device model reported by Android: `sdk_gphone64_x86_64`
- Android: 16
- API: 36
- ABI: x86_64
- Package ID: `com.sandro.evefittracker`

The device ID remains dynamic in the scripts; `emulator-5554` is only the value detected during the recorded run.

## Scripts Finalized

- `tool/evefit_android_test_helpers.ps1`
- `tool/start_evefit_emulator.ps1`
- `tool/run_evefit_on_emulator.ps1`
- `tool/reset_evefit_test_device.ps1`
- `tool/run_dashboard_integration_test.ps1`
- `tool/capture_evefit_test_artifacts.ps1`

Changes made:

- Removed fixed branch and commit assumptions.
- Added optional `-ExpectedBranch` and `-ExpectedCommit` gates.
- Added optional `-DeviceId` and retained configurable `-AvdName`.
- Centralized SDK, Flutter, ADB, emulator, AVD, device, boot, Git, package, run-directory, command, and metadata helpers.
- Added SDK detection through environment variables and standard/fallback locations.
- Replaced fixed waits with ADB and `sys.boot_completed` polling and explicit timeouts.
- Added timestamped run directories and JSON metadata.
- Added real stdout, stderr, combined output, logcat, screenshots, and exit-code handling for the integration runner.
- Made explicit reset idempotent when Flutter Drive has already removed the package.
- Kept clear-data and uninstall operations behind explicit, mutually exclusive switches.
- Limited the runner to the Dashboard integration target.

## Startup and App Execution

`start_evefit_emulator.ps1` was run against the already active test AVD and successfully:

- detected `emulator-5554`;
- matched it to `EveFit_Test_Device`;
- confirmed ADB state, `sys.boot_completed=1`, and package-manager availability;
- wrote startup metadata and logs;
- returned exit code 0.

`run_evefit_on_emulator.ps1 -DeviceId emulator-5554 -ExpectedBranch android-test-lab-finalization -NoResident` built, installed, and launched EveFit successfully. It reported the branch, base commit, working-tree status, device, package, and log path without modifying Git.

## Reset Behavior

Force-stop-only execution passed and left the emulator operational. `-ClearAppData` was used explicitly for the integration fixture. During repeat validation, Flutter Drive had removed the package; the reset script correctly reported `APP_NOT_INSTALLED=true` and `APP_DATA_ALREADY_ABSENT=true` instead of treating an already-clean test state as data-clear success on a nonexistent package.

No AVD wipe, AVD deletion, implicit clear, or implicit uninstall occurred.

## Final Integration Test

Command:

```powershell
.\tool\run_dashboard_integration_test.ps1 `
  -AvdName EveFit_Test_Device `
  -ExpectedBranch android-test-lab-finalization `
  -ClearAppData
```

Target executed:

```text
integration_test/dashboard_rebuild_flow_test.dart
```

Result:

- Flutter Drive: all tests passed.
- Dashboard scenarios: all eight passed.
- Integration exit code: `0`.
- Emulator startup/reuse: automatic.
- Boot wait: passed.
- Device detection: passed.
- Human intervention during test: none.
- Capture process left running: none.

Validated scenarios include no goals, no active metrics, enabling Weight, immediate refresh, restart persistence, disabling Weight, goal removal/re-addition, history preservation, and profile isolation.

## Final Run Evidence

Run directory:

`test_artifacts/dashboard/integration/2026-07-11T132050Z_dashboard/`

Files:

- Integration output: `test_artifacts/dashboard/integration/2026-07-11T132050Z_dashboard/flutter_drive.log`
- Standard output: `test_artifacts/dashboard/integration/2026-07-11T132050Z_dashboard/flutter_drive.stdout.log`
- Standard error: `test_artifacts/dashboard/integration/2026-07-11T132050Z_dashboard/flutter_drive.stderr.log`
- Logcat: `test_artifacts/dashboard/integration/2026-07-11T132050Z_dashboard/logcat.log`
- Metadata: `test_artifacts/dashboard/integration/2026-07-11T132050Z_dashboard/metadata.json`
- Screenshots: `test_artifacts/dashboard/integration/2026-07-11T132050Z_dashboard/screenshots/`

Nine screenshots were produced, covering every scenario boundary. The final integration log is 15,956 bytes, logcat is 769,722 bytes, and metadata is 1,095 bytes. All artifacts are ignored by Git.

A separate manual artifact-capture validation also passed at:

`test_artifacts/dashboard/captures/2026-07-11T131456Z_lab_script_validation/`

## Script Validation

All six PowerShell files were parsed with `System.Management.Automation.Language.Parser`; all returned zero syntax errors. The command-execution helper was separately tested with a deliberate process exit code 7 and returned exactly 7. Start, force-stop, capture, app-run, explicit clean-state reset, and full integration flows were executed successfully.

## GitHub Actions Decision

No manual Android-emulator workflow was added. A reliable emulator workflow on hosted runners would add nested-virtualization constraints, long image/build/test times, and maintenance beyond the low-complexity threshold for this phase. The existing local Pixel 8 Pro laboratory is reproducible and already produces timestamped evidence. This decision avoids introducing a fragile CI path or new operational cost.

## Scope Preservation

- Main changed by the laboratory scripts: no.
- Public app version changed: no.
- Functional Flutter code changed: no.
- Catalog changed: no.
- Exercises changed: no.
- Training filters changed: no.
- Canonical schemas changed: no.
- Goals changed: no.
- Measurements or workout history changed outside emulator fixtures: no.
- APKs, screenshots, logs, or `test_artifacts/` staged: no.

## Limitations

- The test currently uses a local x86_64 Android 16 AVD rather than physical Pixel hardware.
- `flutter drive` may uninstall its test package after a run; reset handles this safely.
- Repeated runs should use explicit `-ClearAppData` when an isolated fixture is required.
- Flutter's native output encoding can render some accented log text differently in the combined PowerShell view; the original stdout and stderr files remain available separately.
- The scripts do not stop the emulator automatically, preserving the post-test state for manual inspection.

## Rollback

Rollback consists of reverting the laboratory commit. The ignored artifacts can remain or be deleted independently. No database migration, application data, catalog data, version, tag, release, or main history depends on these script changes. Reverting the scripts and documentation does not delete emulator data or repository data.

## Final Working Tree Expectation

The intended diff contains only the six scripts under `tool/` and the two documents under `docs/testing/`. The known external martial-arts source file and `docs/catalog_reports/v0.9.4/menu_matrix_review_pack.zip` remain untracked and excluded. Build output and all test artifacts remain ignored.
