# EveFit Android Test Environment Report v0.1

## Scope and repository state

- Branch: `dashboard-rebuild-v1`
- Commit: `e80b6155ec3c41ee3383fd9639872450ccac9fc8`
- Main / origin/main: `1ce06edbe66d14c5c7859764d6c1a017a27de990`
- PR #5: open, draft, unmerged: <https://github.com/ryoken99/evefit_tracker/pull/5>
- Public app version: unchanged at `1.0.0-rc.1`.
- No Dashboard functional code, catalog, exercise, training filter, canonical schema, app version, tag, release, or main branch was changed.

## Host environment

| Item | Result |
| --- | --- |
| Operating system | Windows 11 Home 64-bit, build 26200 |
| Flutter | 3.44.4 stable (`ad70ec4617`) |
| Dart | 3.12.2 |
| Android Studio | Not installed; not required for the command-line SDK workflow |
| Android SDK | `C:\tools\android-sdk`, platform android-36 / build-tools 36.0.0 |
| Platform Tools | 37.0.0-14910828 |
| Emulator | 36.6.11.0 |
| Java | Microsoft OpenJDK 17.0.19 LTS |
| Flutter doctor | Passed with no issues |
| Free disk space | approximately 97 GB on C:, 1.24 TB on D: |
| SDK environment | Scripts locate `C:\tools\android-sdk` without requiring permanent PATH changes |

## Virtualization and AVD

Windows reports an active hypervisor and `emulator -accel-check` reports that WHPX is installed and usable. The dedicated AVD was created as requested and the pre-existing `EveFit_Pixel_7_API_36` AVD was left untouched.

| Item | Result |
| --- | --- |
| AVD name | `EveFit_Test_Device` |
| Device profile | Pixel 8 Pro |
| Android | Android 16, API 36, Google APIs |
| ABI | x86_64 |
| Resolution | 1344 x 2992 |
| Density | 480 dpi |
| RAM | 2 GB |
| Data partition | 6 GB |
| AVD path | `%USERPROFILE%\.android\avd\EveFit_Test_Device.avd` |
| Current device id | `emulator-5554` |
| Boot validation | `adb`, `sys.boot_completed=1`, and package manager all passed |

## EveFit execution

- Package id discovered from `android/app/build.gradle.kts`: `com.sandro.evefittracker`.
- Launcher activity: `com.sandro.evefittracker/.MainActivity`.
- `flutter run -d emulator-5554 --no-resident` built, installed, and opened the app.
- `adb shell am force-stop`, `adb shell monkey -p`, `adb shell pidof`, `adb shell dumpsys package`, `adb logcat`, and `adb exec-out screencap -p` were validated.
- A normal force-stop and reopen succeeded. The explicit `-ClearAppData` reset also succeeded on the new emulator test data.
- Hot reload and hot restart were not automated because the validation used `--no-resident`; they require an interactive `tool/run_evefit_on_emulator.ps1` session and remain a manual follow-up.

## Scripts created

| Script | Purpose |
| --- | --- |
| `tool/evefit_android_test_helpers.ps1` | Locates SDK/Flutter tools, package id, artifacts, active emulator, and metadata. |
| `tool/start_evefit_emulator.ps1` | Starts or reuses `EveFit_Test_Device`, waits for boot, logs startup, and returns a device id. |
| `tool/reset_evefit_test_device.ps1` | Force-stops by default; supports explicit `-ClearAppData` or `-UninstallApp`. |
| `tool/run_evefit_on_emulator.ps1` | Verifies branch/commit/diff scope, starts the emulator, and runs EveFit. `-NoResident` supports non-interactive validation. |
| `tool/capture_evefit_test_artifacts.ps1` | Captures screenshot, logcat, package data, and JSON metadata. |
| `tool/run_dashboard_integration_test.ps1` | Verifies branch/commit/diff scope and runs only the Dashboard integration test. |

All scripts write artifacts below `test_artifacts/dashboard/`, which is ignored by Git. The script default never clears app data, uninstalls the app, wipes the AVD, changes Git, or creates releases.

## Integration test status

`integration_test` did not previously exist. The Flutter SDK dependency and `integration_test/dashboard_rebuild_flow_test.dart` were added as test-only infrastructure.

The command below was executed against `emulator-5554`:

```powershell
flutter test integration_test/dashboard_rebuild_flow_test.dart -d emulator-5554 -r expanded
```

It compiled and installed the debug app, then correctly reported one skipped test. This is not a functional pass.

### Stable identifier blocker

The integration test cannot reliably automate the approved Dashboard flow without altering UI testability hooks. The following widgets have no stable `ValueKey` or semantic identifier:

| Widget | File | Reason / required non-functional hook |
| --- | --- | --- |
| Dashboard editor button | `lib/screens/dashboard_screen.dart` | A stable key is required to open the editor without relying on display text. |
| Visible metric cards | `lib/screens/dashboard_screen.dart` and `lib/widgets/stat_card.dart` | Metric-key-based identifiers are required to assert zero cards, selected cards, and no extras. |
| Visible charts | `lib/screens/dashboard_screen.dart` and `lib/widgets/progress_chart.dart` | Metric-key-based identifiers are required to assert zero charts and chart visibility. |
| Editor metric switches | `lib/widgets/dashboard_editor_sheet.dart` | A stable key per metric is required to toggle `Peso atual` reliably. |
| Editor save/cancel/actions | `lib/widgets/dashboard_editor_sheet.dart` | Stable keys are required for Save, Cancel, enable-all, and disable-all. |

Required approval before continuing the functional integration flow: add only the stable widget identifiers above. No UI behavior or Dashboard logic change is required, but the change is outside this environment-only authorization.

## Artifacts and logs

Artifacts are local only and ignored by Git:

- `test_artifacts/dashboard/emulator_start/`
- `test_artifacts/dashboard/runs/`
- `test_artifacts/dashboard/integration/`
- `test_artifacts/dashboard/device/`
- `test_artifacts/dashboard/screenshots/`

Validated captures include `app_start` and `clean_start`, each containing screenshot PNG, logcat, package dump, branch, commit, package id, device id, Android version, and API metadata.

## Known limitations and rollback

- The first Android build encountered a transient GitHub download failure for the `sqlite3` Android native asset. A retry succeeded without any dependency or project change.
- Dashboard preference persistence, goal removal/re-addition, and profile isolation cannot be verified automatically until the stable identifiers above are approved.
- No device or real-user data was used. The only data reset targeted the newly created emulator with explicit `-ClearAppData`.
- Rollback is safe: remove the test-only scripts, `integration_test` infrastructure, report, and `/test_artifacts/` ignore entry. The AVD is outside Git and can be removed independently. No application data, legacy data, migration, schema, or catalog data was modified.

## Files changed in this phase

- `.gitignore`
- `pubspec.yaml`
- `pubspec.lock`
- `tool/evefit_android_test_helpers.ps1`
- `tool/start_evefit_emulator.ps1`
- `tool/reset_evefit_test_device.ps1`
- `tool/run_evefit_on_emulator.ps1`
- `tool/capture_evefit_test_artifacts.ps1`
- `tool/run_dashboard_integration_test.ps1`
- `integration_test/dashboard_rebuild_flow_test.dart`
- `docs/dashboard_rebuild/EveFit_Android_Test_Environment_Report_v0.1.md`

No commit, push, merge, tag, release, or APK publication was performed.
