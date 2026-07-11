# EveFit Dashboard Rebuild: Repository Inspection v0.1

## 1. Executive Summary

**Inspection only. No implementation was performed.**

The Dashboard is isolated enough to rebuild within the Dashboard module plus the minimum `dashboard_widgets` persistence adapter. It is not a catalogue, training-filter, exercise, or canonical-schema concern.

The current implementation has three independent visibility paths:

```text
selected goals -> DashboardGoalMetricService -> StatCard grid
dashboard_widgets -> editor draft -> database write
hardcoded metric list -> ProgressChart widgets
```

These paths do not compose. In particular, persisted editor choices are not used by the card grid, and neither goals nor persisted choices are used by the chart list.

The approved target remains:

```text
goal_allowed_metrics = metrics derived only from selected_user_goals
visible_dashboard_metrics = goal_allowed_metrics INTERSECTION user_enabled_metrics
```

The one ordered `visible_dashboard_metrics` collection must supply cards, charts, and editor state.

## 2. Repository State

- Branch analysed: `main`
- Commit analysed: `1ce06edbe66d14c5c7859764d6c1a017a27de990`
- Reference architecture read in full: `EveFit_Dashboard_Rebuild_Plan_v0.1.md` at repository root.
- App source root: `evefit_tracker/`
- No tracked changes were present before this report.
- Known untracked local files were left untouched:
  - `15_ARTES_MARCIAIS_EXERCICIOS_DERIVADOS.md`
  - `evefit_tracker/docs/catalog_reports/v0.9.4/menu_matrix_review_pack.zip`

## 3. Exact File Map

### Directly involved

| File | Role |
| --- | --- |
| `evefit_tracker/lib/screens/dashboard_screen.dart` | Loads Dashboard data, renders cards and hardcoded charts, owns editor sheet and refresh attempt. |
| `evefit_tracker/lib/services/dashboard_goal_metric_service.dart` | Current goal-label to metric-key mapping and allowed-card derivation. |
| `evefit_tracker/lib/services/dashboard_metric_service.dart` | Metric definitions, default keys, current value resolver, historical value resolver. |
| `evefit_tracker/lib/services/dashboard_widget_draft_service.dart` | Copies/toggles editor draft rows. |
| `evefit_tracker/lib/models/dashboard_widget_config.dart` | Persisted widget row model. |
| `evefit_tracker/lib/database/app_database.dart` | Creates, seeds, reads, updates and resets `dashboard_widgets`. |

### Presentation dependencies

| File | Role |
| --- | --- |
| `evefit_tracker/lib/widgets/stat_card.dart` | Generic current-value card; no visibility logic. |
| `evefit_tracker/lib/widgets/progress_chart.dart` | Generic history chart; renders an empty-data state for fewer than two values. |
| `evefit_tracker/lib/app.dart` | Instantiates `DashboardScreen` in the root `IndexedStack`. |
| `evefit_tracker/lib/screens/settings_screen.dart` | Persists selected general goals and returns control to Dashboard. |

### Indirect data dependencies

| File | Role |
| --- | --- |
| `evefit_tracker/lib/services/profile_preferences_service.dart` | Parses/serializes `Profile.initialGoals`. |
| `evefit_tracker/lib/models/profile.dart` | Stores `initialGoals`. |
| `evefit_tracker/lib/models/user_profile.dart` | Dashboard profile projection with `mainGoal`. |
| `evefit_tracker/lib/models/body_measurement.dart` | Current and historical body values. |
| `evefit_tracker/lib/services/dashboard_stats_service.dart` | Derived arm metric used by the metric service. |
| `evefit_tracker/lib/screens/goals_screen.dart` | Uses metric value/history services for goal detail, but is not Dashboard visibility code. |

### Tests

| File | Classification |
| --- | --- |
| `test/dashboard/dashboard_goal_metric_service_test.dart` | Reusable unit coverage for goal allowance; does not test editor intersection or screen rendering. |
| `test/v051_dashboard_draft_test.dart` | Reusable draft-copy/toggle test. |
| `test/v080/dashboard_transaction_test.dart` | Reusable atomic-write regression test. |
| `test/dashboard_metric_test.dart` | Reusable current value formatting test. |
| `test/v053_body_data_test.dart` | Reusable value-resolution coverage. |
| `test/clean_base/clean_base_goal_visibility_test.dart` | Reusable profile goal-source coverage; not Dashboard card/chart coverage. |
| `test/regression/async_refresh_callback_test.dart` | Regression test for safe `setState` syntax only; it does not prove a Dashboard reload. |
| `test/dashboard_stats_test.dart`, `test/goal_progress_test.dart`, `test/v051_goal_progress_test.dart`, `test/v080/goal_profile_isolation_test.dart` | Indirect metric/goal/profile coverage. |

There are no Dashboard screen widget tests, editor save/reload tests, card/chart symmetry tests, legacy-default tests, or profile-switching Dashboard integration tests.

## 4. Current Data and UI Flow

```text
Active Profile.initialGoals / UserProfile.mainGoal
        |
        v
ProfilePreferencesService.parseGeneralGoals()
        |
        v
DashboardGoalMetricService.metricsForGoals()
        |
        v
StatCard grid in DashboardScreen

dashboard_widgets rows
        |
        v
AppDatabase.dashboardWidgets()
        |
        v
Dashboard editor draft -> updateDashboardWidgets()
        |
        X
Not used to select StatCards; no _dataFuture reload after save

hardcoded chart calls in DashboardScreen
        |
        v
DashboardMetricService.valuesFor()
        |
        v
ProgressChart widgets, always in the screen tree
```

`DashboardScreen._loadData()` loads profile, measurements, workouts this week and widget rows through `Future<List<Object>>` (`dashboard_screen.dart:40-45`). It then uses positional casts (`:82-86`).

Selected goals are parsed from `activeProfile.initialGoals`, falling back to `profile.mainGoal` (`dashboard_screen.dart:89-91`). Card metrics are derived only from `DashboardGoalMetricService.metricsForGoals(selectedGoals)` (`:92-94`) and rendered at `:178-187`.

The widget rows are loaded solely to supply the editor (`:85-86`, `:207`); their `isVisible` and `sortOrder` do not affect the card grid.

## 5. dashboard_widgets Persistence Map

### Table and constraints

`AppDatabase._createDashboardWidgetsTable()` defines:

```text
dashboard_widgets(
  id, profile_id, metric_key, title, is_visible, sort_order,
  created_at, updated_at,
  UNIQUE(profile_id, metric_key)
)
```

Location: `app_database.dart:805-809`.

Therefore rows are profile-scoped and duplicate `(profile_id, metric_key)` rows are prevented in production schema. The in-memory transaction test creates a weaker table without that unique constraint, so it does not prove production duplicate behavior.

### Create, migration and automatic writes

| Moment | Location | Write and visibility effect |
| --- | --- | --- |
| v5 migration | `app_database.dart:433-437` | Creates the table. |
| v5.3 migration | `:498-512` | Seeds default rows for every existing profile. |
| New profile | `:1379-1408`, especially `:1396` | Seeds all metric rows. |
| Empty read result | `:1661-1679` | Inserts default rows automatically. |
| Missing definition keys | `:1680-1716` | Inserts missing rows automatically as hidden. |
| Explicit reset API | `:1755-1764` | Deletes all profile rows and recreates defaults. No caller currently exists. |

`_insertDefaultDashboardWidgets()` writes every metric definition with a title and definition order; six keys are created with `is_visible = true` (`:1529-1551`). It uses `ConflictAlgorithm.ignore`, so it does not overwrite existing rows.

### Reads and updates

| Operation | Location | Behavior |
| --- | --- | --- |
| Read | `dashboardWidgets()` at `:1661-1692` | Queries by active `profile_id`, orders by `sort_order`, may insert defaults/missing rows. |
| Single update | `updateDashboardWidget()` at `:1719-1729` | Updates one existing row by `id` and profile. No caller found. |
| Batch save | `updateDashboardWidgets()` at `:1731-1753` | Transactional in-place updates; rolls back if any row does not update exactly once. It does not delete or insert rows. |
| Reset | `resetDashboardWidgets()` at `:1755-1764` | Deletes every row for active profile then reseeds defaults. No caller found. |

`title` is persisted and displayed by the editor (`dashboard_screen.dart:315`) but card rendering uses the service definition title (`:180`). It is consequently not a consistent authoritative title source. `sort_order` is honoured by the database query but is not used to order cards or charts.

## 6. Defaults, Seeds and Fallbacks

`DashboardMetricService.defaultKeys` (`dashboard_metric_service.dart:270-277`) is:

```text
weight
avg_biceps_flexed
shoulders
side_hip_area
workouts_week
days_since_start
```

Its only production uses are:

1. Default row creation (`app_database.dart:1542-1544`), which persists visible legacy/default rows.
2. The editor's `Restaurar padrão` control (`dashboard_screen.dart:331-346`), which toggles the draft to those keys before a user saves.

There is no runtime fallback from `defaultKeys` into the current card grid. It remains a legacy/default source in persistence and editor behavior, incompatible with the approved future rule that user enablement means explicit selection.

## 7. Hardcoded Charts

`dashboard_screen.dart:212-260` declares eleven unconditional charts. They all call `_metricChart()` (`:268-277`), which calls `DashboardMetricService.valuesFor()` and creates `ProgressChart`.

| Metric key | Current title | Current condition | Registry definition exists |
| --- | --- | --- | --- |
| `weight` | Peso ao longo do tempo | Always | Yes |
| `bmi` | IMC ao longo do tempo | Always | Yes |
| `body_fat` | Gordura corporal ao longo do tempo | Always | Yes |
| `muscle_mass` | Massa muscular ao longo do tempo | Always | Yes |
| `waist` | Cintura ao longo do tempo | Always | Yes |
| `chest` | Peito ao longo do tempo | Always | Yes |
| `visceral_fat` | Gordura visceral ao longo do tempo | Always | Yes |
| `basal_metabolism` | BMR ao longo do tempo | Always | Yes |
| `avg_biceps_flexed` | Braço contraído ao longo do tempo | Always | Yes |
| `side_hip_area` | Zona lateral acima da anca ao longo do tempo | Always | Yes |
| `shoulders` | Ombros ao longo do tempo | Always | Yes |

No other Dashboard chart exists. `GoalsScreen` has a separate goal-detail `ProgressChart` and is outside the Dashboard module.

## 8. Exact Causes of the Observed Problems

### A. Metrics appear when they should not

The card grid is goal-filtered but not preference-filtered. `DashboardGoalMetricService.metricsForGoals()` returns all allowed definitions in definition order (`dashboard_goal_metric_service.dart:69-79`), and `DashboardScreen` renders all of them (`dashboard_screen.dart:178-187`). Persisted `is_visible` values are ignored.

The eleven charts are independent hardcoded calls, so they remain visible even with zero selected goals, zero enabled rows, or no matching metric.

### B. Saving in the editor does not visibly update Dashboard

The editor correctly awaits the transactional database write (`dashboard_screen.dart:350-354`) and returns `true`. The caller only executes `setState(() {})` (`:368`); it does not replace `_dataFuture` through `_refresh()`. The already-resolved `dashboardWidgets` snapshot remains in use on subsequent editor openings.

More importantly, even a fresh row read would not change the cards because card visibility never reads `DashboardWidgetConfig.isVisible`. Charts also ignore it. This is the primary functional reason the saved selection appears ineffective.

### C. Charts ignore preferences

Every Dashboard chart is inserted unconditionally at `dashboard_screen.dart:212-260`. The chart helper has no selected-goal, widget-preference, or visibility input. `ProgressChart` itself is generic and not the source of the policy defect.

## 9. Recommended Future Architecture (No Code in This Phase)

Create a Dashboard-only domain pipeline:

```text
DashboardMetricRegistry.allowedMetricKeysFor(selectedGoals)
        +
DashboardPreferenceAdapter.explicitEnabledMetricKeys(profileId)
        |
        v
DashboardCompositionService.compose(...)
        |
        v
immutable DashboardViewModel
        |
        +-- cards
        +-- charts
        +-- editor options/order
        +-- empty state / warnings
```

`DashboardMetricRegistry` owns metric key, title, unit, goal compatibility, current-value resolver, history resolver, card/chart capability, stable order and empty-value behavior. It replaces the split between `DashboardGoalMetricService`, hardcoded charts, and default visibility semantics.

`DashboardCompositionService` is pure or near-pure. It deduplicates keys, preserves explicit user order, removes unknown/disallowed keys, and never mutates persistence. The screen only loads a typed `DashboardDataSnapshot`, composes a `DashboardViewModel`, renders it, and reloads after an editor save.

## 10. Legacy Strategy and Migration Decision

**Database migration required: YES.**

The approved Option A requires legacy rows to be preserved but their visibility ignored, while choices saved after the rebuild must be treated as explicit. The current table has no origin/version/configuration marker. `is_visible`, `created_at`, `updated_at`, title and sort order cannot reliably distinguish a legacy default from a genuine historical user choice.

The smallest safe future design is a nullable, non-destructive profile-scoped marker, for example `explicitly_configured_at` or `preference_origin`, with these semantics:

```text
existing rows: marker null / legacy_unknown -> ignored for user_enabled_metrics
new editor save: marker explicit -> is_visible and sort_order become active preferences
inactive goal: explicit row remains stored but is excluded by composition
re-added goal: explicit row becomes eligible again
unknown metric: row remains stored but is excluded and reported
```

The migration must add data only, preserve every existing row, and must not be implemented without the next explicit implementation approval.

## 11. Future File Plan

### Create

- `lib/services/dashboard_metric_registry.dart`
- `lib/services/dashboard_composition_service.dart`
- `lib/models/dashboard_data_snapshot.dart`
- `lib/models/dashboard_view_model.dart`
- Dashboard-specific widget/editor/empty-state files only if extraction keeps `dashboard_screen.dart` thin.
- Unit, widget and integration tests under `test/dashboard/`.

### Alter

- `lib/screens/dashboard_screen.dart`
- `lib/database/app_database.dart` (minimal non-destructive preference marker/adapter only)
- `lib/models/dashboard_widget_config.dart`
- `lib/services/dashboard_metric_service.dart`
- `lib/services/dashboard_goal_metric_service.dart` (reduce to compatibility adapter or retire its visibility role)
- `lib/services/dashboard_widget_draft_service.dart`

### Keep and reuse

- `lib/widgets/stat_card.dart`
- `lib/widgets/progress_chart.dart`
- `lib/models/body_measurement.dart`
- `lib/services/profile_preferences_service.dart`
- Profile goal editing, measurement persistence, workout persistence, and `lib/app.dart` navigation contract.

### Potentially obsolete after implementation

- `DashboardGoalMetricService.metricsForGoals()` as the direct UI selector.
- The Dashboard-local `_metricChart()` helper and the inline editor sheet in `DashboardScreen`.
- `DashboardMetricService.defaultKeys` as a visibility source. The definitions/value helpers remain reusable.

### Do not touch

- Exercise catalogue, exercise data, training filters, training architecture.
- Canonical schemas and canonical documentation.
- Available goals and goal-editing behavior.
- `pubspec.yaml` version, tags, releases, Android signing, build setup.
- Legacy measurements, workouts, profiles, goals, or existing dashboard rows.

## 12. Proposed Implementation Phases and Acceptance Criteria

| Phase | Scope | Acceptance criteria | Risk / rollback |
| --- | --- | --- | --- |
| A: Domain | Registry, typed snapshot, composition service, view model, unit tests | Exact intersection, no defaults, stable explicit order, unknown-key safety | New isolated classes; revert without touching UI/persistence. |
| B: Persistence/editor | Non-destructive marker migration, preference adapter, allowed-only editor, typed save result | Legacy rows ignored, explicit rows persist per profile, save reloads data, cancel writes nothing | Migration must be reviewed; rollback adapter while retaining added nullable data. |
| C: Screen | Replace positional future and inline visibility logic; remove hardcoded chart declarations | One view model drives cards/charts/editor; correct empty states; no hardcoded charts | Keep generic widgets; rollback screen only after domain tests remain. |
| D: Regression | Widget/integration tests | Profile isolation, restart behavior, legacy preservation, measurement/workout counts unchanged | No production data mutation beyond approved marker. |

## 13. Required Future Tests

### Unit

- Zero goals -> zero allowed and zero visible.
- Goals plus zero enabled -> zero visible.
- One/multiple goals -> exact allowed union without duplicates.
- Exact allowed/enabled intersection; allowed-disabled and enabled-disallowed are hidden.
- Stable persisted order, unknown metric preservation/exclusion, empty current/history values.
- Card/chart capability declarations and historical data not affecting visibility.

### Widget

- Zero goals -> zero cards/charts and correct empty state.
- Goals with no enabled metrics -> editor guidance.
- Editor lists only allowed metrics; save reloads Dashboard; cancel does not write.
- No hardcoded charts; cards/charts use the same view-model collection.

### Integration

- Profile-scoped preferences, save/reload/restart, goal removal/re-addition.
- Legacy rows preserved/ignored under Option A.
- Measurement and workout row counts unchanged.
- No default visibility reactivation.

## 14. Risks and Scope Conclusion

- Goal labels are visible strings, not stable IDs; renaming/localization can break mapping.
- Legacy and explicit preferences are indistinguishable without a marker.
- Persisted titles conflict with registry titles.
- Existing default reseeding writes can contaminate preference meaning.
- The `Future<List<Object>>` snapshot is fragile and currently not reloaded after editor save.
- Some counter metrics may not support meaningful history; capability metadata resolves this without a second visibility list.

The Dashboard rebuild can remain isolated. Its necessary dependencies are Dashboard presentation/domain code, the profile-goal read contract, body/workout read APIs, and a minimal dashboard preference persistence change. It does not require changes to catalogue, filters, exercises, canonical schemas, or general application architecture.

## 15. Inspection Outcome

No implementation has been authorized or performed. The next step requires explicit approval for the proposed Dashboard implementation phases, including the non-destructive legacy marker migration required by Option A.
