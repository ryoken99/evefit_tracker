# EveFit Dashboard Rebuild: Implementation Report v0.1

## Scope and Base

- Base commit: `1ce06edbe66d14c5c7859764d6c1a017a27de990`
- Branch: `dashboard-rebuild-v1`
- Scope: Dashboard module and minimum `dashboard_widgets` persistence only.
- Public app version: unchanged.

## New Composition Flow

```text
selected_user_goals
  -> DashboardMetricRegistry.allowedMetricKeysFor()
  -> goal_allowed_metrics

explicit dashboard_widgets rows (explicitly_configured_at != null && is_visible)
  -> user_enabled_metrics

goal_allowed_metrics INTERSECTION user_enabled_metrics
  -> DashboardCompositionService
  -> DashboardViewModel
  -> Dashboard cards, charts and editor
```

`DashboardScreen` now loads a typed `DashboardDataSnapshot`, composes one `DashboardViewModel`, and renders cards and charts by iterating the same ordered `visibleMetricItems` collection. The previous fixed chart list has been removed.

## Migration and Legacy Rows

- Database schema version: `21 -> 22`.
- Added nullable `dashboard_widgets.explicitly_configured_at TEXT`.
- The migration uses the existing idempotent add-column helper.
- Existing rows retain `explicitly_configured_at = NULL`, remain in the table and are ignored as legacy/unknown preferences.
- New editor saves update only the presented allowed rows, preserving `created_at`, unrelated metrics, unknown metric rows and other profiles.
- New explicit saves set `is_visible`, `sort_order`, `updated_at` and `explicitly_configured_at`.
- No measurement, workout, profile, goal or dashboard row was deleted by the migration or composition flow.

## Editor and Refresh

- `DashboardEditorSheet` receives only goal-allowed metric options from the ViewModel.
- It supports Guardar, Cancelar, Ativar todas and Desativar todas.
- “Restaurar padrão” and `defaultKeys` visibility behavior were removed from the Dashboard UI.
- Save writes explicit preferences and closes with success.
- `DashboardScreen` calls `_refresh()`, which assigns a new `_dataFuture`, after a successful save and after returning from Settings.

## Files Created

- `lib/models/dashboard_data_snapshot.dart`
- `lib/models/dashboard_view_model.dart`
- `lib/services/dashboard_metric_registry.dart`
- `lib/services/dashboard_composition_service.dart`
- `lib/widgets/dashboard_editor_sheet.dart`
- `lib/widgets/dashboard_empty_state.dart`
- `test/dashboard/dashboard_composition_service_test.dart`
- `test/dashboard/dashboard_preferences_migration_test.dart`
- `test/dashboard/dashboard_editor_sheet_test.dart`

## Files Altered

- `lib/database/app_database.dart`
- `lib/models/dashboard_widget_config.dart`
- `lib/screens/dashboard_screen.dart`
- `lib/services/dashboard_goal_metric_service.dart` (compatibility adapter)
- `lib/widgets/progress_chart.dart`
- Dashboard schema fixtures in existing tests.

## Empty States

- No goals: zero visible metrics and guidance to select goals.
- Goals with zero explicit enabled metrics: zero visible metrics and guidance to use the editor.
- Visible metric with no current value: `Sem dados`.
- Visible chart with insufficient history: explicit evolution guidance.

## Tests Added or Updated

- Registry uniqueness and known goal mappings.
- Exact allowed/enabled intersection, explicit ordering, unknown keys and missing data.
- Legacy-null marker ignored; explicit marker used; remove/re-add goal behavior.
- In-memory migration preservation and profile-scoped explicit save.
- Editor empty state, cancel-without-save and explicit save behavior.
- Existing Dashboard schema fixtures updated for the new nullable column.

## Validation

Executed successfully on `dashboard-rebuild-v1`:

```text
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
flutter test -r compact
flutter build apk --debug
flutter build apk --release
```

- `flutter pub get`: passed
- `dart format --set-exit-if-changed .`: passed
- `flutter analyze`: passed with no issues
- `flutter test -r compact`: passed, 561 tests
- `flutter build apk --debug`: passed
- `flutter build apk --release`: passed

## Rollback

The implementation can be reverted as a code commit. The nullable marker column remains compatible with previous code and no downgrade migration is needed. Rows, user preferences, measurements, workouts and history remain preserved.

## Scope Confirmation

- Goals altered: no
- Catalogue altered: no
- Exercises altered: no
- Training filters altered: no
- Canonical schemas altered: no
- Public version altered: no
- Tags/releases/APKs published: no
