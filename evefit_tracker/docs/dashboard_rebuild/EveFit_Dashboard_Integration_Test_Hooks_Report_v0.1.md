# EveFit Dashboard Integration Test Hooks Report v0.1

## Scope

- Branch: `dashboard-rebuild-v1`
- Base commit: `e80b6155ec3c41ee3383fd9639872450ccac9fc8`
- PR: <https://github.com/ryoken99/evefit_tracker/pull/5> (open draft, unmerged)
- Test device: `EveFit_Test_Device`, Pixel 8 Pro profile, Android 16 / API 36, x86_64, `emulator-5554`.

This change adds stable testability hooks and completes the Dashboard integration test. It does not alter Dashboard composition, visibility, persistence, user-facing text, layout, database schema, migrations, goals, catalog, filters, app version, main, tags, or releases.

## Hooks added

| Area | Stable hook |
| --- | --- |
| Dashboard editor entry | `dashboard_edit_button` |
| No-goals state | `dashboard_empty_no_goals` |
| No-active-metrics state | `dashboard_empty_no_metrics` |
| Metric card | `dashboard_card_<metric_key>` |
| Metric chart | `dashboard_chart_<metric_key>` |
| Metric switch | `dashboard_metric_switch_<metric_key>` |
| Editor save | `dashboard_editor_save` |
| Editor cancel | `dashboard_editor_cancel` |
| Enable all | `dashboard_editor_enable_all` |
| Disable all | `dashboard_editor_disable_all` |
| Test profile selection | `profile_option_<profile_id>` |
| Test profile PIN | `profile_unlock_pin` |
| Test profile unlock submit | `profile_unlock_submit` |

The three profile hooks are the minimum hooks outside Dashboard. They allow the integration test to unlock isolated test profiles after recreating the app root; no profile behavior changed.

## Test implementation

`integration_test/dashboard_rebuild_flow_test.dart` no longer has a skip. It creates isolated test profiles and a measurement in the emulator database, then tests the Dashboard UI through stable keys. The app root is recreated between persistence stages while preserving the same on-device database. The environment script separately validates Android force-stop and normal reopening.

The screenshot driver is `test_driver/integration_test.dart`. It writes screenshot bytes supplied by `IntegrationTestWidgetsFlutterBinding` into the ignored artifacts directory.

## Validation

Command executed:

```powershell
tool/run_dashboard_integration_test.ps1 -DeviceId emulator-5554 -ClearAppData
```

The script runs the equivalent Android integration command:

```powershell
flutter drive --driver test_driver/integration_test.dart --target integration_test/dashboard_rebuild_flow_test.dart -d emulator-5554
```

Result: passed, `All tests passed`.

Dashboard unit/widget tests also passed:

```powershell
flutter test test/dashboard/ -r compact
```

Result: 20 tests passed.

`flutter analyze` passed with no issues.

## Covered scenarios

1. Profile without goals: no cards, no charts, no-goals state, and an empty editor.
2. Weight-compatible goal with no explicit metrics: no-active-metrics state and no cards/charts.
3. Explicitly enable Weight: exactly the Weight card and Weight chart render immediately.
4. Recreate app root: explicit Weight preference remains visible with no extra metric.
5. Disable Weight: card/chart disappear and the measurement remains in the database.
6. Remove the goal: Weight hides while its explicit preference remains stored.
7. Re-add the goal: the saved explicit Weight preference becomes visible again.
8. Second profile: no inherited Weight preference, card, or chart.

## Artifacts

Successful run timestamp: `2026-07-11T120638Z`.

Screenshots, all ignored by Git:

- `test_artifacts/dashboard/screenshots/2026-07-11T120638Z/2026-07-11T120638Z_dashboard_no_goals.png`
- `test_artifacts/dashboard/screenshots/2026-07-11T120638Z/2026-07-11T120638Z_dashboard_no_active_metrics.png`
- `test_artifacts/dashboard/screenshots/2026-07-11T120638Z/2026-07-11T120638Z_dashboard_editor_weight_enabled.png`
- `test_artifacts/dashboard/screenshots/2026-07-11T120638Z/2026-07-11T120638Z_dashboard_after_save_weight.png`
- `test_artifacts/dashboard/screenshots/2026-07-11T120638Z/2026-07-11T120638Z_dashboard_after_restart.png`
- `test_artifacts/dashboard/screenshots/2026-07-11T120638Z/2026-07-11T120638Z_dashboard_after_disable.png`
- `test_artifacts/dashboard/screenshots/2026-07-11T120638Z/2026-07-11T120638Z_dashboard_goal_removed.png`
- `test_artifacts/dashboard/screenshots/2026-07-11T120638Z/2026-07-11T120638Z_dashboard_goal_readded.png`
- `test_artifacts/dashboard/screenshots/2026-07-11T120638Z/2026-07-11T120638Z_dashboard_second_profile.png`

Integration output, scenario boundaries, and Flutter/ADB diagnostics are stored in:

- `test_artifacts/dashboard/logs/2026-07-11T120638Z_dashboard_integration.log`
- `test_artifacts/dashboard/logs/2026-07-11T120638Z_dashboard_integration.log.stdout`
- `test_artifacts/dashboard/logs/2026-07-11T120638Z_dashboard_integration.log.stderr`

## Files changed

- `.gitignore`
- `pubspec.yaml`
- `pubspec.lock`
- `lib/screens/dashboard_screen.dart`
- `lib/widgets/dashboard_editor_sheet.dart`
- `lib/screens/profile_gate_screen.dart`
- `integration_test/dashboard_rebuild_flow_test.dart`
- `test_driver/integration_test.dart`
- `tool/evefit_android_test_helpers.ps1`
- `tool/start_evefit_emulator.ps1`
- `tool/reset_evefit_test_device.ps1`
- `tool/run_evefit_on_emulator.ps1`
- `tool/capture_evefit_test_artifacts.ps1`
- `tool/run_dashboard_integration_test.ps1`
- `docs/dashboard_rebuild/EveFit_Android_Test_Environment_Report_v0.1.md`
- `docs/dashboard_rebuild/EveFit_Dashboard_Integration_Test_Hooks_Report_v0.1.md`

No screenshots, logs, APKs, build output, local attachments, or unrelated files are included in the commit.
