# EveFit Android Emulator Test Guide

## Purpose

This guide describes the local Android test laboratory for EveFit. The default device is `EveFit_Test_Device`, a Pixel 8 Pro profile running Android 16 / API 36. The scripts only inspect Git state; they never checkout, pull, commit, reset, merge, or change branches.

## Requirements

- Windows 11 with hardware virtualization enabled.
- Flutter available on `PATH` or installed in one of the supported local paths.
- Android SDK with `platform-tools` and `emulator`.
- Java 17 for Flutter Android builds.
- AVD named `EveFit_Test_Device` unless another name is passed with `-AvdName`.
- The integration test files already present in the repository.

Android Studio is useful for creating or inspecting AVDs, but it is not required to run the scripts after the command-line SDK and AVD exist. The scripts detect `ANDROID_SDK_ROOT`, `ANDROID_HOME`, `%LOCALAPPDATA%\Android\Sdk`, and `C:\tools\android-sdk` in that order. They poll `sys.boot_completed` and the package manager instead of relying on a fixed startup delay.

## AVD and Device Selection

Default AVD:

- Name: `EveFit_Test_Device`
- Profile: Pixel 8 Pro
- Android: 16
- API: 36
- ABI: x86_64

The Android device ID is discovered at runtime and is not assumed to be `emulator-5554`. To target a specific running emulator, pass `-DeviceId`.

## Start the Emulator

```powershell
.\tool\start_evefit_emulator.ps1
```

Custom AVD or timeout:

```powershell
.\tool\start_evefit_emulator.ps1 -AvdName EveFit_Test_Device -BootTimeoutSeconds 420
```

The script reuses the requested AVD if it is already running. Otherwise it starts the AVD in the background, waits for ADB, boot completion, and the package manager, then prints `DEVICE_ID`, startup paths, and metadata.

## Run EveFit

Interactive Flutter session:

```powershell
.\tool\run_evefit_on_emulator.ps1
```

Non-resident validation with optional Git expectations:

```powershell
.\tool\run_evefit_on_emulator.ps1 `
  -NoResident `
  -ExpectedBranch main `
  -ExpectedCommit b3aec6c
```

The script reports the current branch, commit, and status without changing them. It runs `flutter pub get` explicitly only when package configuration is missing or `-ForcePubGet` is supplied. Flutter itself may still resolve dependencies as part of `flutter run`.

## Run the Dashboard Integration Test

Standard isolated run:

```powershell
.\tool\run_dashboard_integration_test.ps1 -ClearAppData
```

Pinned run:

```powershell
.\tool\run_dashboard_integration_test.ps1 `
  -AvdName EveFit_Test_Device `
  -ExpectedBranch android-test-lab-finalization `
  -ExpectedCommit b3aec6c `
  -ClearAppData
```

The script:

1. Starts or reuses the emulator.
2. Waits for boot and detects the actual device ID.
3. Records branch, commit, device, Android, API, ABI, and package metadata.
4. Clears app data only when `-ClearAppData` is explicitly present.
5. Starts timestamped logcat capture.
6. Runs only `integration_test/dashboard_rebuild_flow_test.dart` through `flutter drive`.
7. Saves stdout, stderr, combined output, logcat, metadata, and screenshots in one run directory.
8. Stops logcat capture in a `finally` block.
9. Prints and returns the real integration-test exit code.

It does not run the full historical Flutter test suite.

## Capture Artifacts Manually

```powershell
.\tool\capture_evefit_test_artifacts.ps1 -Scenario dashboard_manual_check
```

Optional device selection:

```powershell
.\tool\capture_evefit_test_artifacts.ps1 `
  -DeviceId emulator-5554 `
  -Scenario dashboard_manual_check
```

The capture includes a PNG screenshot, recent logcat, package dump, and JSON metadata with branch, commit, package ID, AVD, model, Android version, API, and ABI.

## Force-stop, Clear, and Uninstall

Force-stop only is the default and non-destructive action:

```powershell
.\tool\reset_evefit_test_device.ps1
```

Explicitly clear only EveFit test-app data:

```powershell
.\tool\reset_evefit_test_device.ps1 -ClearAppData
```

Explicitly uninstall only EveFit from the emulator:

```powershell
.\tool\reset_evefit_test_device.ps1 -UninstallApp
```

`-ClearAppData` and `-UninstallApp` cannot be combined. If Flutter Drive already removed the package, either explicit operation is treated as an already-clean state. The AVD is never deleted or wiped.

## Artifact Layout

All local output is below the ignored directory:

```text
test_artifacts/dashboard/
  captures/<timestamp>_<scenario>/
  device/<timestamp>_reset/
  emulator_start/<timestamp>_<avd>/
  integration/<timestamp>_dashboard/
    flutter_drive.stdout.log
    flutter_drive.stderr.log
    flutter_drive.log
    logcat.log
    metadata.json
    screenshots/
  runs/<timestamp>_flutter_run/
```

Screenshots and logs must not be staged or committed.

## Exit Codes and Failures

- Exit code `0`: requested operation completed successfully.
- Non-zero exit code: the script or underlying Flutter/ADB command failed.
- A missing AVD, unavailable device, boot timeout, Git expectation mismatch, failed explicit reset, or failed Flutter command is fatal.
- The integration runner always prints `INTEGRATION_EXIT_CODE=<code>` and returns that code.
- Logs remain available after a failure unless creation failed before the run directory was made.

Typical checks:

```powershell
adb devices
flutter devices
flutter doctor
```

Use the printed run path to inspect `flutter_drive.log`, `flutter_drive.stderr.log`, `logcat.log`, and `metadata.json`.

## Stop the Emulator

Use the detected device ID:

```powershell
adb -s emulator-5554 emu kill
```

Stopping the emulator is intentionally not part of the test runner, so artifacts and the app remain available for manual inspection after a test.

## Git and Safety Guarantees

The scripts never:

- checkout, pull, merge, commit, push, reset, rebase, or delete branches;
- alter the app version;
- run the full historical test suite;
- clear app data without `-ClearAppData`;
- uninstall without `-UninstallApp`;
- wipe or delete an AVD;
- add screenshots, logs, APKs, or `test_artifacts/` to Git;
- alter catalogs, exercises, filters, schemas, goals, measurements, workouts, or legacy data outside the emulator test app.
