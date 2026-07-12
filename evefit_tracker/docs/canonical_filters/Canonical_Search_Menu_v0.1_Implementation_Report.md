# Canonical Search Menu v0.1 - Implementation Report

## 1. Base and branch

- Base commit: `61a70d86672f88f5b68da46d9c3e613d588dad52` (`Document Android test lab validation on main`)
- Branch: `canonical-search-menu-v0.1`
- Menu schema version: `0.1`

## 2. Inspection and integration point

The Clean Base has no global Exercises tab. The only active exercise entry is
the `Adicionar exercicio` action in `WorkoutDetailScreen`. Legacy catalogue
visibility remains disabled there. When the separate
`CleanBaseConfig.canonicalSearchMenuVisible` flag is true, that action opens
`CanonicalSearchMenuScreen` and returns without calling the legacy picker.

The Dashboard, global application shell, workout history, goals, measurements,
and legacy catalogue/filter services were not changed.

## 3. Implemented architecture

`lib/features/canonical_search/` is isolated from legacy filter and catalogue
services:

- `models/canonical_search_models.dart`: immutable node, icon, condition, and
  query-contract types.
- `data/canonical_search_menu_data.dart`: typed immutable menu data.
- `services/canonical_search_menu_validator.dart`: structural and query guard.
- `services/canonical_search_navigation_controller.dart`: path, ancestors,
  back, home, and effective-query composition.
- `screens/canonical_search_menu_screen.dart`: presentation and navigation.
- `widgets/canonical_search_empty_state.dart`: terminal state.

No exercise model, exercise id, catalogue row, or static result list appears in
the menu data or query contracts.

## 4. Query contract

Each node stores only the condition introduced by that node. The effective
contract is the ordered `AND` composition of the selected node and its
ancestors. Allowed fields are `capability`, `usage_context`, `concept_family`,
`body_region`, `joint`, `movement_pattern`, `modality`, and
`adaptation_goal`; operators are `equals`, `contains`, and `contains_any`.

The validator rejects result-owning or legacy properties including
`exercise_id`, `exercise_ids`, `owned_exercises`, `hardcoded_results`,
`catalogue_rows`, `legacy_ids`, `manual_membership`, and `result_list`.

Entering through a capability adds the non-visible local condition
`usage_context = main_training`. It does not create a fifth visible context
node.

## 5. Tree and counts

The validator proves the approved tree shape:

| Structure | Count |
| --- | ---: |
| Capability roots | 8 |
| Usage-context roots | 4 |
| Visible roots | 12 |
| Capability level-2 nodes | 30 |
| Context level-2 nodes | 15 |
| Total level-2 nodes | 45 |
| Capability terminals | 127 |
| Context terminals | 62 |
| Total terminals | 189 |
| Total nodes | 246 |
| Maximum depth | 3 |

Every node has a stable snake_case id, local PT-PT label and description,
closed icon key, sibling display order, parent relationship, schema version,
and query contract. The full node list is the typed definition in
`canonical_search_menu_data.dart`.

## 6. Navigation and empty states

The root presents the two parallel sections directly: eight capabilities and
four contexts. The feature supports children, breadcrumbs, selecting an
ancestor, back, home, and terminal states. All level-3 nodes display only:

- `Este catalogo esta a ser construido por fases.`
- `Os exercicios desta categoria serao adicionados e validados progressivamente.`

The complete path is shown. No legacy results, `Mostrar todos`, result count,
or fictitious exercises are shown.

## 7. Test hooks

Stable keys include `canonical_search_root_screen`, section keys, per-node
keys, breadcrumb keys, `canonical_search_back`, `canonical_search_home`,
`canonical_search_empty_state`, and `canonical_search_empty_path`.

## 8. Tests and Android validation

- `test/canonical_search/canonical_search_menu_test.dart`: tree counts,
  validator, root ids, query restrictions, effective implicit context, and
  legacy isolation.
- `test/canonical_search/canonical_search_menu_screen_test.dart`: root UI,
  paths, breadcrumbs, back/home, terminal state, narrow layout, and non-medical
  prevention wording.
- `test/clean_base/clean_base_catalog_visibility_test.dart`: legacy flags stay
  false and the Clean Base exercise entry routes to canonical search.
- `integration_test/canonical_search_menu_flow_test.dart`: Android rendering,
  Cardio, Aquecimento, and Prevencao terminal paths with screenshots.
- `tool/run_canonical_search_menu_test.ps1`: starts/reuses
  `EveFit_Test_Device`, optionally clears app data, stops pre-warmed app state,
  runs only the canonical flow, returns the real exit code, and captures logs,
  screenshots, and metadata under `test_artifacts/`.

The Android host intentionally renders the isolated canonical feature instead
of starting the full application. The full app's first-launch legacy database
seed repeatedly replays catalogue migrations and prevents a bounded menu test
from reaching the UI. This preserves the required legacy data and avoids an
out-of-scope seed/catalogue change. The real Clean Base entry point is covered
by the focused Clean Base contract test.

Successful Android evidence:

- Device: `EveFit_Test_Device` (`emulator-5554`, Android 16/API 36).
- Run directory:
  `test_artifacts/canonical_search_menu/integration/2026-07-12T024234Z/`
- Screenshots: root, Cardio terminal, Aquecimento terminal, and Prevencao
  terminal.
- Exit code: `0`.

Runtime screenshots and logs remain ignored and are not committed.

## 9. Validation results

- `flutter analyze`: passed.
- Focused Clean Base and canonical widget/unit tests: passed.
- Canonical Android integration runner: passed.
- Full suite: not run. The change is isolated to the feature and one local
  workout-detail entry branch; no app shell, global router, or shared
  navigation mechanism changed.

## 10. Scope confirmation

- Exercises added: no.
- Fictitious results added: no.
- Legacy catalogue visible: no.
- Legacy filters visible: no.
- Dashboard changed: no.
- Goals, measurements, and existing workouts changed: no.
- Public version changed: no.
- Database schema changed: no.

## 11. Risks, limitations, rollback, and next steps

The menu has no active canonical exercise matcher by design. All terminal nodes
remain intentionally empty until a separately approved canonical catalogue
phase supplies exercise signatures. The full-app Android first-launch seed is
a pre-existing lab limitation and is not masked by this feature.

Rollback is a normal revert of this branch's commit(s): no persisted menu data,
schema, exercises, or historical records are introduced. The legacy flags
remain false after rollback.

Possible later work, not started here: canonical exercise signatures and a
matcher that evaluates the same structured query contracts.
