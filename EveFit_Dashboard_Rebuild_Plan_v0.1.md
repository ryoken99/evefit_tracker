# EveFit Dashboard Rebuild Plan

**Status:** Draft for Sandro approval  
**Scope:** Dashboard module only  
**Implementation:** Not authorised  
**EveFit v1.1:** Paused  
**App version:** Must remain unchanged

---

## 1. Objective

Replace the current Dashboard implementation with one predictable composition pipeline and one source of truth for visible metrics.

The Dashboard module will be rebuilt without rebuilding the full application.

The binding rule is:

```text
goal_allowed_metrics =
metrics derived only from selected_user_goals

user_enabled_metrics =
metrics explicitly chosen and persisted by the user in the Dashboard editor

visible_dashboard_metrics =
goal_allowed_metrics INTERSECTION user_enabled_metrics
```

If:

```text
selected_user_goals = []
```

Then:

```text
goal_allowed_metrics = []
visible_dashboard_metrics = []
```

The same `visible_dashboard_metrics` collection must drive:

```text
Dashboard cards
Dashboard charts
Dashboard ordering
Dashboard editor state
```

No second visibility calculation may exist in the screen or individual widgets.

---

## 2. Hard Boundaries

This phase may change only the Dashboard module and the minimum persistence access required by that module.

It must not change:

```text
exercise catalogue
training filters
exercise data
canonical schemas
canonical documentation
selected goals
goal editing behaviour
body measurements
historical metric values
workout history
application version
Git tags or releases
```

Historical data must remain stored even when a metric is not visible.

No full app rewrite is allowed.

---

## 3. Confirmed Current Architecture and Defects

### 3.1 Dashboard screen

The current `DashboardScreen` loads:

```text
profile
measurements
workouts this week
dashboard widget configuration
```

through one `_dataFuture`.

It then derives the displayed StatCard metrics from selected goals only. The loaded Dashboard widget configuration is not used to filter those cards.

The same screen also creates a fixed list of charts directly in the widget tree, independently of goals and editor preferences.

After the editor saves, it only calls `setState()`. It does not assign a new `_dataFuture`, so the previously resolved data may remain in use.

### 3.2 Goal mapping

`DashboardGoalMetricService` contains a direct mapping from goal labels to metric keys.

This is currently one source of visibility truth, but it is not composed with saved editor preferences.

### 3.3 Metric definitions

`DashboardMetricService` contains:

```text
metric key
title
unit
value resolution
historical value resolution
defaultKeys
```

The `defaultKeys` list conflicts with the new rule when it is used to restore or seed metrics without an explicit user choice.

### 3.4 Persisted Dashboard widgets

`DashboardWidgetConfig` stores:

```text
profile_id
metric_key
title
is_visible
sort_order
timestamps
```

The persisted rows can represent user preference, but existing default-seeded rows may not represent an explicit user choice.

### 3.5 Editor draft

`DashboardWidgetDraftService` copies and toggles persisted widget configurations.

The editor currently receives all stored Dashboard widgets rather than only the metrics allowed by the user's active goals.

### 3.6 Multiple sources of truth

Current visibility can be influenced by:

```text
selected goals
goal-to-metric mapping
persisted widget visibility
default metric keys
hardcoded charts
possibly seeded Dashboard widget rows
```

The rebuild must collapse these into one composition path.

---

## 4. Required Discovery Before Implementation

Codex must first produce an exact repository map before changing code.

The discovery report must identify:

1. Every file importing or instantiating `DashboardScreen`.
2. Every Dashboard-specific model, service, screen and widget.
3. Every read and write path for the `dashboard_widgets` table.
4. Every seed, migration, fallback or default that creates visible Dashboard widgets.
5. Every reference to `DashboardMetricService.defaultKeys`.
6. Every goal-to-metric mapping.
7. Every hardcoded Dashboard chart.
8. Every test that asserts Dashboard widget defaults or visibility.
9. Every callback expected to refresh the Dashboard.
10. Every place that reads measurements or workout statistics for Dashboard use.

Expected confirmed files include:

```text
lib/screens/dashboard_screen.dart
lib/services/dashboard_goal_metric_service.dart
lib/services/dashboard_metric_service.dart
lib/services/dashboard_widget_draft_service.dart
lib/models/dashboard_widget_config.dart
lib/database/app_database.dart
lib/widgets/stat_card.dart
lib/widgets/progress_chart.dart
lib/services/profile_preferences_service.dart
```

This is not declared as a complete file list until Codex performs the repository inspection.

The discovery output must be reviewed before implementation starts.

---

## 5. Proposed Architecture

## 5.1 Single composition pipeline

The new module should use this flow:

```text
Persisted profile goals
        |
        v
selected_user_goals
        |
        v
DashboardMetricRegistry.allowedForGoals()
        |
        v
goal_allowed_metric_keys
        |
        +--------------------------+
        |                          |
        v                          v
Dashboard preference store   Dashboard metric definitions
        |                          |
        v                          |
user_enabled_metric_keys           |
        |                          |
        +------------+-------------+
                     |
                     v
DashboardCompositionService.compose()
                     |
                     v
DashboardViewModel
                     |
        +------------+-------------+
        |            |             |
        v            v             v
      Cards        Charts        Editor
```

The screen must not calculate metric visibility.

---

## 5.2 DashboardMetricRegistry

Create one central registry keyed by `metric_key`.

Each metric definition should contain, at minimum:

```text
metric_key
title
unit
compatible_goal_ids or compatible goal keys
value resolver
history series resolver
supports_card
supports_chart
empty value behaviour
chart title
stable display order
```

Optional metadata:

```text
description
preferred precision
trend direction semantics
minimum chart points
accessibility label
```

This registry replaces the split between:

```text
goal mapping
metric definition
hardcoded chart list
default card list
```

The goal-to-metric relationship must be centralized here or behind one registry API.

The screen, editor and composition service must not maintain independent mappings.

### Registry API contract

Conceptually:

```text
definitionFor(metricKey)
allowedMetricKeysFor(selectedGoals)
cardValueFor(metricKey, dashboardData)
chartSeriesFor(metricKey, dashboardData)
```

Unknown metric keys must be handled safely and reported, not silently displayed as defaults.

---

## 5.3 DashboardCompositionService

This must be a pure or near-pure service with no Flutter widget dependencies.

Inputs:

```text
selected_user_goals
persisted_dashboard_preferences
metric_registry
latest_measurement
measurement_history
workout statistics
profile metadata required by metrics
legacy preference compatibility state
```

Core calculation:

```text
goalAllowed =
registry.allowedMetricKeysFor(selected_user_goals)

userEnabled =
persisted preferences
where is_enabled == true

visible =
goalAllowed INTERSECTION userEnabled
```

Additional rules:

```text
deduplicate by metric_key
preserve explicit user order
exclude unknown metric keys
exclude metrics not allowed by active goals
do not mutate persistence during composition
do not delete historical data
```

Output:

```text
DashboardViewModel
```

The service must not know how cards or charts are rendered.

---

## 5.4 DashboardViewModel

The view model should be immutable and represent the entire Dashboard render state.

Proposed structure:

```text
selectedGoals
goalAllowedMetricKeys
userEnabledMetricKeys
visibleMetricKeys
visibleMetricItems
editorMetricOptions
emptyState
isUsingLegacyPreferenceCompatibility
warnings
```

Each visible metric item should contain:

```text
metricKey
title
unit
formattedCurrentValue
chartTitle
chartValues
supportsCard
supportsChart
sortOrder
hasCurrentValue
hasHistory
```

Cards and charts receive the same ordered metric items.

They may render different aspects of the item, but may not use different visibility rules.

---

## 5.5 Dashboard data snapshot

Replace `Future<List<Object>>` positional indexing with one typed object, for example:

```text
DashboardDataSnapshot
```

Proposed fields:

```text
profile
selectedGoals
measurements
latestMeasurement
workoutsThisWeek
workoutsThisMonth
setsThisWeek
exercisesThisWeek
dashboardPreferences
daysSinceStart
```

This avoids casts by index and makes refresh behaviour testable.

---

## 5.6 Dashboard screen

`dashboard_screen.dart` becomes a thin UI coordinator.

Responsibilities:

```text
load Dashboard data snapshot
ask composition service for DashboardViewModel
render loading, error, empty or content state
open the Dashboard editor
refresh after editor save
support pull-to-refresh
navigate to settings
```

It must not contain:

```text
goal-to-metric maps
metric definitions
metric value switch statements
hardcoded chart declarations
default visibility rules
database write logic
```

---

## 5.7 Dashboard editor

The editor must receive:

```text
goal_allowed_metrics
current user_enabled_metrics
current user order
```

It must show only metrics allowed by active selected goals.

Saving must persist:

```text
enabled state for allowed metrics
order for allowed metrics
```

It must not delete stored preferences for metrics temporarily disallowed by goal changes.

This preserves a user's previous choice if a removed goal is later re-added, subject to Sandro's decision on compatibility semantics.

After a successful save:

```text
await persistence write
close editor with a typed save result
reload Dashboard data
recompose DashboardViewModel
render the new state
```

A plain `setState()` without recreating the data load is insufficient.

### Editor actions

Proposed actions:

```text
Guardar
Cancelar
Ativar todas as permitidas
Desativar todas
```

Do not include a global “Restaurar padrão” that silently reintroduces unrelated defaults.

A future “Restaurar recomendações para os objetivos atuais” could exist only if Sandro explicitly approves recommendation defaults.

---

## 6. Empty States

The Dashboard must distinguish these states.

### 6.1 No selected goals

Condition:

```text
selected_user_goals = []
```

Result:

```text
zero cards
zero charts
editor shows no metric toggles
```

Proposed message:

```text
Ainda não selecionaste objetivos.

Escolhe objetivos no perfil para definir as métricas disponíveis no Dashboard.
```

### 6.2 Goals exist, but no metrics are enabled

Condition:

```text
goal_allowed_metrics is not empty
user_enabled_metrics INTERSECTION goal_allowed_metrics is empty
```

Result:

```text
zero cards
zero charts
editor remains available
```

Proposed message:

```text
Não tens métricas ativas no Dashboard.

Usa “Editar Dashboard” para escolher entre as métricas permitidas pelos teus objetivos.
```

### 6.3 Visible metric without recorded data

The metric remains visible because visibility and historical availability are different concerns.

Card:

```text
Sem dados
```

Chart:

```text
Ainda não existem registos suficientes para apresentar evolução.
```

No metric should disappear merely because its historical series is empty.

### 6.4 Load failure

Show one recoverable error state with retry.

No fallback to default cards or hardcoded charts is allowed.

---

## 7. Compatibility Strategy for Existing Configurations

No historical values, measurements or preference rows may be deleted.

Existing Dashboard configuration has an ambiguity:

```text
Some visible rows may be explicit user choices.
Some visible rows may have been created by legacy defaults.
The current data model does not appear to record their origin.
```

Therefore the implementation cannot safely infer which legacy rows are genuine user choices.

### Proposed compatibility framework

Classify existing preference rows as:

```text
explicit_current
legacy_unknown_origin
inactive_but_preserved
unknown_metric
```

Rules common to all strategies:

```text
never display a metric outside goal_allowed_metrics
never delete the row merely because it is currently disallowed
never delete measurement history
unknown metric keys remain preserved but not rendered
saving in the new editor produces explicit current preferences
```

### Decision required from Sandro

Choose one initial behaviour for `legacy_unknown_origin`.

#### Option A: strict reset of visibility

```text
Legacy unknown rows are preserved but ignored.
user_enabled_metrics starts empty.
The user selects metrics again in the editor.
```

Advantages:

```text
fully obeys “explicitly chosen by the user”
removes all legacy default contamination
predictable
```

Cost:

```text
existing users must configure the Dashboard again
```

#### Option B: compatibility carry-forward

```text
Existing rows with is_visible = true are temporarily treated as enabled,
but only inside goal_allowed_metrics.
They become explicit after the user next saves the editor.
```

Advantages:

```text
less disruption
preserves likely user choices
```

Cost:

```text
some old defaults may survive when they are compatible with a selected goal
```

#### Option C: one-time confirmation

```text
On first editor opening after the rebuild, show the compatible legacy selection
and ask the user to confirm or clear it before it becomes active.
```

Advantages:

```text
does not guess user intent
preserves recoverability
```

Cost:

```text
more UI and state complexity
```

Planner recommendation:

```text
Option A
```

It is the only option that strictly guarantees that `user_enabled_metrics` means metrics explicitly selected by the user.

No implementation may choose an option before Sandro approves it.

---

## 8. Persistence Design

The current `dashboard_widgets` data may be reused if inspection proves it can represent the new contract safely.

Required persistence semantics:

```text
profile-scoped
one row per profile + metric_key
is_enabled is an explicit user preference
sort_order is an explicit user preference
metric title is not authoritative
metric definition comes from the registry
```

Recommended uniqueness rule:

```text
UNIQUE(profile_id, metric_key)
```

The registry owns title and units. Persisted configuration should not become a second metric definition source.

### Non-destructive preference behaviour

When a goal is removed:

```text
preference row remains
historical data remains
metric is excluded during composition
```

When the goal is re-added:

```text
the previous explicit enabled state may become effective again
```

This behaviour depends on the approved legacy strategy for old rows, but should apply normally to preferences created after the rebuild.

### Migration restraint

Do not add a database migration unless inspection demonstrates it is necessary.

Preferred path:

```text
reinterpret or minimally adapt existing rows
add repository/service logic
avoid destructive schema changes
```

If an origin marker is required to distinguish legacy from explicit selections, Codex must stop after discovery and propose the smallest non-destructive migration before implementation.

---

## 9. Files Proposed

The final list must be confirmed by repository inspection.

### 9.1 Files likely to create

```text
lib/services/dashboard_composition_service.dart
lib/models/dashboard_view_model.dart
lib/models/dashboard_data_snapshot.dart
lib/services/dashboard_metric_registry.dart
lib/widgets/dashboard_metric_card.dart
lib/widgets/dashboard_metric_chart.dart
lib/widgets/dashboard_empty_state.dart
lib/widgets/dashboard_editor_sheet.dart
```

A feature folder may be used instead:

```text
lib/features/dashboard/
```

but moving unrelated files is prohibited.

### 9.2 Files likely to alter

```text
lib/screens/dashboard_screen.dart
lib/database/app_database.dart
lib/models/dashboard_widget_config.dart
lib/services/dashboard_goal_metric_service.dart
lib/services/dashboard_metric_service.dart
lib/services/dashboard_widget_draft_service.dart
```

Some existing services may instead be deprecated or reduced to compatibility adapters.

### 9.3 Files expected to retain or reuse

```text
lib/widgets/stat_card.dart
lib/widgets/progress_chart.dart
lib/models/body_measurement.dart
lib/services/profile_preferences_service.dart
goal creation and editing screens
measurement persistence
workout persistence
```

Existing generic widgets should be reused when they satisfy the new contract. Rewriting them merely to rename them is not justified.

### 9.4 Files prohibited from change

```text
exercise catalogue files
exercise filtering services
training architecture
canonical specification documents
legacy catalogue files
pubspec version
Android signing
release configuration
```

---

## 10. Test Strategy

## 10.1 Unit tests

### DashboardMetricRegistry

Test:

```text
each metric key is unique
each goal mapping references a known metric
each metric has a value resolver
chart-capable metrics have a history resolver
unknown keys are rejected or reported
no default visibility list exists
```

### DashboardCompositionService

Test:

```text
no goals -> no allowed metrics and no visible metrics
goals + no enabled metrics -> no visible metrics
one goal -> exact intersection
multiple goals -> exact union of allowed, then intersection with enabled
shared metric -> no duplicate
enabled but disallowed -> hidden
allowed but disabled -> hidden
allowed and enabled -> visible
stable user order is preserved
unknown persisted keys are ignored but preserved
no measurements -> visible metric with empty data state
historical values do not affect visibility
removing goal hides metrics
re-adding goal restores only previously explicit preferences
```

### Compatibility

Test every approved legacy strategy explicitly.

No test may infer user intent silently.

---

## 10.2 Widget tests

### Dashboard screen

Test:

```text
no selected goals shows no cards and no charts
no selected goals shows the correct empty state
goals but no enabled metrics shows editor guidance
visible metrics render corresponding cards
the exact same visible metrics render corresponding charts
hardcoded charts do not appear
disallowed metrics do not appear even with historical data
loading state
error and retry state
```

### Editor

Test:

```text
only goal-allowed metrics are listed
saved enabled metrics are selected
disallowed persisted metrics are not shown
toggle changes draft only until save
cancel does not persist
save persists and closes successfully
save triggers Dashboard reload
activate all affects only allowed metrics
disable all produces an empty Dashboard
```

---

## 10.3 Integration tests

Use an in-memory or temporary database.

Scenarios:

```text
create profile with no goals -> zero Dashboard metrics
select one goal -> allowed editor options only
enable one metric -> one card and corresponding chart
enable several metrics -> exact ordered result
remove goal -> related card and chart disappear
historical measurement rows remain unchanged
re-add goal -> explicit preferences behave according to approved policy
switch profile -> preferences remain profile-scoped
save editor -> reopen Dashboard -> preferences persist
restart data load -> no default widget reappears
legacy rows -> approved compatibility behaviour
```

Database assertions must prove that measurement and workout row counts do not decrease.

---

## 11. Implementation Phases After Approval

### Phase A: repository inspection

Deliver:

```text
exact file map
current data flow
seed/default source
database table behaviour
test map
scope confirmation
compatibility blocker report
```

Stop if the Dashboard is coupled to many unrelated modules.

### Phase B: domain layer

Create:

```text
metric registry
composition service
typed snapshot
view model
unit tests
```

No UI replacement until unit tests pass.

### Phase C: editor and persistence adapter

Implement:

```text
allowed-only editor options
explicit preference save
non-destructive compatibility
typed save result
refresh contract
```

### Phase D: screen replacement

Rewrite only the Dashboard screen around the view model.

Remove all hardcoded chart declarations.

### Phase E: tests and regression

Run:

```text
flutter analyze
flutter test -r compact
focused integration tests
```

No version change, release or tag.

---

## 12. Acceptance Criteria

The rebuild is acceptable only when:

1. There is one composition service for Dashboard visibility.
2. `selected_user_goals` is the only source for goal allowance.
3. Persisted explicit editor choices are the only source for user enablement.
4. Visible metrics equal the exact intersection.
5. Cards and charts use the same ordered visible metric collection.
6. No graphs are hardcoded in `dashboard_screen.dart`.
7. No default metric list affects visibility.
8. No selected goals produces zero cards and zero charts.
9. The editor shows only allowed metrics.
10. Saving reloads the actual Dashboard data source.
11. Cancelling does not persist changes.
12. Removing a goal hides related cards and charts.
13. Adding a goal exposes its metrics in the editor.
14. Historical data remains stored.
15. Unknown or old metric keys do not crash the screen.
16. Existing profile separation remains correct.
17. No catalogue, filter, exercise or schema file changes.
18. App version remains unchanged.
19. Analyze and all tests pass.
20. Codex stops and reports before any release activity.

---

## 13. Explicit Non-Goals

```text
No redesign of goals
No new goal catalogue
No exercise work
No canonical schema work
No v1.1 continuation
No global state-management rewrite
No full database redesign
No new app navigation
No release publishing
```

---

## 14. Risks

### Legacy default ambiguity

The database cannot necessarily distinguish defaults from true user selections.

Mitigation:

```text
Sandro chooses the compatibility policy before implementation.
```

### Goal labels as mapping keys

Current mappings appear to use visible goal strings.

Risk:

```text
renaming or localization can break mappings
```

Possible future correction:

```text
stable goal keys
```

This rebuild must not redesign goal storage unless the inspection proves stable IDs already exist or the current string mapping makes correctness impossible.

### Scope expansion

A “from zero” rewrite can become a broad architecture rewrite.

Mitigation:

```text
new composition core
thin screen
reuse generic widgets and persistence where safe
no unrelated refactor
```

### Double rendering contract

Some metrics may logically support a card but not a useful chart.

The binding rule says cards and graphs use `visible_dashboard_metrics`, but presentation capability may differ.

Proposed interpretation:

```text
Every visible metric participates in the shared visible collection.
A metric renders every presentation type declared by its registry definition.
```

This needs Sandro's decision if he expects every selected metric to always produce both a card and a graph.

---

## 15. Decisions Required From Sandro

### Decision 1: old persisted defaults

Choose:

```text
A. preserve rows but begin with zero user-enabled metrics
B. temporarily carry forward compatible visible rows
C. require one-time user confirmation
```

Planner recommends A.

### Decision 2: card and chart symmetry

Choose:

```text
A. every visible metric must always have both a card and a chart
B. the shared visible metric list is authoritative, but each metric declares whether it supports card, chart or both
```

Planner recommends B.

This preserves one visibility source without forcing meaningless charts for counters such as “dias desde o início”.

### Decision 3: re-adding a goal

For preferences explicitly saved after the rebuild, choose:

```text
A. preserve the metric's enabled state while the goal is inactive, then restore it when the goal returns
B. automatically disable the metric permanently when its last compatible goal is removed
```

Planner recommends A because it hides rather than destroys user preference.

---

## 16. Definition of Plan Approval

Approval authorises Codex only to perform the repository inspection and return the exact implementation plan.

It does not yet authorise code changes.

After the inspection report, Planner will compare the real file map against this architecture and return any contradiction to Sandro.

Only a second explicit approval authorises implementation.
