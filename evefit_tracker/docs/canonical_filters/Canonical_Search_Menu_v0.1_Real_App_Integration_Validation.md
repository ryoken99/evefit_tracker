# Canonical Search Menu v0.1 - Phase A Validation

## Scope

- PR: https://github.com/ryoken99/evefit_tracker/pull/7
- Branch: `canonical-search-menu-v0.1`
- Initial head: `3574c577a4764355f2ec2fe4313b183e4d750778`
- Base: `61a70d86672f88f5b68da46d9c3e613d588dad52`
- Entry point: `app.main()`
- Scope restriction: Hero tag repair and validation only. No legacy seed,
  catalogue, exercise, dashboard, goal, schema, version, or release changes.

## Initial Quality Gate

The initial PR quality check was `Flutter quality gate`, run
`29177221288`, and completed successfully for the initial head.

## Floating Action Button Inventory

| File | Screen | Action | Previous tag | New tag | Coexistence |
| --- | --- | --- | --- | --- | --- |
| `lib/screens/goals_screen.dart` | `GoalsScreen` | Create goal | default | `goals_add_fab` | Kept alive by `EveFitHome` `IndexedStack` |
| `lib/screens/measurements_screen.dart` | `MeasurementsScreen` | Create measurement | default | `measurements_add_fab` | Kept alive by `EveFitHome` `IndexedStack` |
| `lib/screens/photos_screen.dart` | `PhotosScreen` | Add photo | default | `photos_add_fab` | Kept alive by `EveFitHome` `IndexedStack` |
| `lib/screens/workout_detail_screen.dart` | `WorkoutDetailScreen` | Add exercise | default | `workout_detail_add_exercise_fab` | Can be active during a route push over the home shell |

All tags are explicit, stable, descriptive, and unique. No tag is `null`.

## Root Cause and Repair

The full-app debug flow previously raised `multiple heroes that share the
same tag: <default FloatingActionButton tag>` when the canonical route was
pushed from workout detail. The default-tag condition was already present in
the app shell; the new route made the route transition exercise it. Assigning
explicit tags to every in-scope FAB removes the duplicate Hero identity while
preserving visuals, callbacks, and navigation.

## Structural and Runtime Regression Coverage

- `test/canonical_search/floating_action_button_hero_tag_contract_test.dart`
  checks the explicit, unique Hero-tag contract for all four FAB sources.
- `integration_test/canonical_search_menu_full_app_flow_test.dart` starts the
  normal app, creates a profile through the UI, creates a workout through the
  UI, opens canonical search from workout detail, traverses the Cardio route,
  returns using system Back, and checks captured Flutter errors for Hero
  collisions.
- `tool/run_canonical_search_menu_full_app_test.ps1` runs the Android flow on
  `EveFit_Test_Device`, captures the real exit code, logs, metadata, and
  screenshots. `-ClearAppData` is explicit and affects only the emulator.

## Full-App Result

The successful clean-data run started at `2026-07-12T12:33:39Z` and completed
in `2m56s` on `EveFit_Test_Device` (`emulator-5554`, Android API 36).

- The legacy seed completed without a Dart exception. SQLite code 28 warnings
  were observed during legacy text insertion; they did not stop startup.
- The profile was created in the real profile gate.
- A workout was created in the real UI and its detail screen opened.
- Canonical search opened through `Adicionar exercicio`.
- Eight capability roots and four context roots were confirmed.
- The route `Cardio e condicionamento > Sem maquinas > Caminhada e corrida`
  reached the intentional empty state with breadcrumb and no `Mostrar todos`.
- System Back returned through the canonical path and back to workouts.
- Dashboard, profile settings, goals, and main navigation remained reachable.
- No Hero exception was captured and the Android runner exit code was zero.

Runtime evidence is intentionally untracked:

`test_artifacts/canonical_search_menu/full_app/2026-07-12T123339Z/`

The run includes screenshots for initialization, Dashboard, workout detail,
canonical root, contexts, Cardio terminal, return to workouts, profile
settings, and goals; plus `flutter_drive.log`, `logcat.log`, and
`metadata.json`.

## Canonical Menu Invariants

Focused canonical tests confirm:

- 8 capability roots
- 4 usage-context roots
- 12 visible roots
- 45 level-two nodes
- 189 terminals
- 246 total nodes
- maximum depth 3
- structured query contracts with no `exercise_ids`
- no active canonical exercises or fabricated results

The legacy catalogue and legacy filters remain hidden. No taxonomy, query
contract, exercise, or dashboard source was modified during this phase.

## Validation

| Command | Result |
| --- | --- |
| `flutter pub get` | Passed |
| `dart format --set-exit-if-changed .` | Executed; the local formatter rewrites one pre-existing unrelated Clean Base test, which was restored and excluded from this PR |
| `flutter analyze` | Passed |
| `flutter test test/canonical_search/ -r compact` | Passed |
| `flutter test -r compact` | Passed, 571 tests |
| `run_canonical_search_menu_full_app_test.ps1 -ClearAppData` | Passed, exit code 0 |

## Risks and Recommendation

The legacy seed remains slow and is intentionally unchanged in Phase A. The
Hero collision found before this repair is covered by both the structural
contract and the real Android route flow.

Recommendation before the post-push CI result: await the new PR quality gate.
If it passes, this Phase A change is ready for `APPROVE FOR MERGE` while the
PR remains draft.
