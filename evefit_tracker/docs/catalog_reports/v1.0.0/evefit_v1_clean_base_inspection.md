# EveFit v1.0 Clean Base inspection

## Context read before code changes

- Primary order read: attached `/goal EVEFIT v1.0 CLEAN BASE, ORDEM FINAL COMPLETA`.
- Required context files searched before code changes:
  - `ORDEM_CODEX_EVEFIT_v1_0_CLEAN_BASE.md`: not present in the current repository checkout.
  - `EVE_Fit_Canonical_Exercise_Specification.md`: not present in the current repository checkout.
  - `EVE_Fit_Legacy_Catalogue_Audit_and_Migration_Plan.md`: not present in the current repository checkout.
- Branch created before implementation: `evefit-v1-clean-base`.

## 1. Where the legacy catalogue appears

- `lib/screens/workout_detail_screen.dart`
  - `_pickExercise()` loads active exercises with `widget.database.exercises()`.
  - It passes those exercises through `ExerciseFilterService.getAvailableExercises(...)`.
  - It renders the resulting legacy catalogue in a bottom sheet under `Adicionar exercicio`.
  - `showAll` exposes all legacy catalogue rows through `Mostrar todos os exercicios`.
  - `_showExerciseInfo()` displays legacy exercise descriptions, steps and metadata.
- `lib/database/app_database.dart`
  - `exercises()` reads the `exercises` table for default legacy exercises and custom profile exercises.
  - `_seedExercises()` preserves and refreshes the seeded legacy catalogue from `ExerciseCatalogContextService.entries`.
- `lib/services/exercise_catalog_context_service.dart`
  - Source of the current generated/legacy exercise catalogue entries.

## 2. Where the legacy filters appear

- `lib/screens/workouts_screen.dart`
  - `_openWorkoutForm()` renders progressive legacy filter controls:
    - type of training
    - location
    - equipment
    - body region
    - muscle group
    - subzone
    - specific focus
    - cardio modality/focus
    - martial art/focus
    - mobility/recovery focus
  - These controls are driven by `TrainingFlow`, `TrainingArchitecture`, `EquipmentCatalogService` and profile equipment.
- `lib/screens/workout_detail_screen.dart`
  - `_pickExercise()` renders search, `Mostrar todos os exercicios`, contextual filter dropdowns and group matching.
  - `_matchesFilter()` contains the local legacy filter matching rules for visible exercises.
- `lib/services/exercise_filter_service.dart`
  - Main legacy filtering service used by the exercise picker and quality gates.
- `lib/services/training_flow.dart` and `lib/services/training_architecture.dart`
  - Main sources for visible menu/filter axes.

## 3. Where goals are loaded

- `lib/screens/profile_gate_screen.dart`
  - `selectedGoals` starts as an empty set.
  - `_GoalStep` lets the user select goals from `ProfilePreferencesService.generalGoalSections`.
  - `createProfile(... initialGoals: selectedGoals.toList())` saves user-selected goals.
- `lib/screens/settings_screen.dart`
  - `selectedGoals` is parsed from `profile.initialGoals`.
  - Profile edits write `initialGoals` through `ProfilePreferencesService.serializeGeneralGoals(selectedGoals)`.
- `lib/database/app_database.dart`
  - `Profile.initialGoals` is the selected user goal source on the active profile.
  - `goals()` reads rows from the `goals` table scoped to the active profile.

## 4. Where goals are shown

- `lib/screens/dashboard_screen.dart`
  - Shows `profile.mainGoal` in the profile summary line.
  - Also shows a hardcoded card: `Fase 1: Construcao de V-shape`.
- `lib/screens/goals_screen.dart`
  - Shows rows returned by `widget.database.goals()`.
- `lib/screens/settings_screen.dart`
  - Shows `profile.initialGoals` in the active profile summary.

## 5. Wrong source of the goals bug

The bug has three sources:

1. `dashboard_screen.dart` injects `V-shape` with a hardcoded dashboard card, independent of `selected_user_goals`.
2. `AppDatabase.createProfile()` stores `main_goal` as `Objetivo livre` when the user selects no initial goals.
3. `_insertDefaultGoals()` inserts `SeedData.goals.take(4)` when `selectedGoals` is empty, turning available/default goals into displayed profile goals.

This violates the required rule:

`displayed_goals = selected_user_goals`

## 6. Smallest reversible fix

- Introduce explicit Clean Base feature flags:
  - `legacyCatalogueVisible = false`
  - `legacyFiltersVisible = false`
- Preserve legacy catalogue data and services, but stop normal UI routes from rendering them.
- In `WorkoutDetailScreen`, keep existing workouts visible but replace the add-exercise catalogue picker with an intentional reconstruction empty state.
- In `WorkoutsScreen`, keep manual workout creation but hide template creation and legacy progressive filters in Clean Base mode.
- In `AppDatabase`, stop generating default goals when the user selected none.
- In `DashboardScreen`, render selected user goals from profile data only; render no goal card when none are selected.

## 7. Files expected to change

- `lib/services/clean_base_config.dart` or equivalent explicit config.
- `lib/screens/workout_detail_screen.dart`
- `lib/screens/workouts_screen.dart`
- `lib/screens/dashboard_screen.dart`
- `lib/database/app_database.dart`
- tests under `test/clean_base/` or existing focused test folders.
- `docs/catalog_reports/v1.0.0/evefit_v1_clean_base_report.md`

## 8. Files that should not change

- Legacy catalogue data files under `lib/services/v099*.dart` and `lib/services/v100_catalog_domain_data.dart`.
- `lib/services/exercise_catalog_context_service.dart`.
- `lib/services/exercise_filter_service.dart`.
- Existing migration/schema files, except no-op compatibility if tests require it.
- Build outputs, APKs, `.sha1`, external attachments and temporary zips.

## 9. Risk

- Low to moderate. The intended change is UI visibility and default-goal behavior only.
- Legacy data remains in the database and source files.
- Existing workout history and workout exercises remain visible when already attached to workouts.
- The main risk is tests that previously expected legacy catalogue visibility; those should be updated only where Clean Base intentionally changes the visible app contract.

## 10. Required tests

- User with no selected goals sees zero displayed goals.
- User selecting V-shape sees V-shape.
- User not selecting V-shape does not see V-shape.
- User with two selected goals sees exactly those two.
- Available/default goals are not injected as selected goals.
- Dashboard and profile use the same selected-goal source.
- Exercise picker does not expose legacy exercises in Clean Base.
- Legacy filters/search/show-all are not visible in Clean Base.
- Legacy catalogue source remains present in code.

## 11. Confirmation

No functional code was changed before this inspection report. Only the inspection branch was created and this report was written after reading and tracing the current implementation.
