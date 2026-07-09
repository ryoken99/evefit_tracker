# EveFit v1.0 Clean Base final report

## Objective

Prepare a reversible EveFit v1.0 Clean Base that hides the old catalogue and old filter UI from normal use, preserves all legacy data, and fixes goal visibility so displayed goals match selected user goals.

## Inspection

- Inspection report: `docs/catalog_reports/v1.0.0/evefit_v1_clean_base_inspection.md`
- Legacy catalogue visibility source: `lib/screens/workout_detail_screen.dart`, `_pickExercise()`.
- Legacy filter visibility source: `lib/screens/workouts_screen.dart`, `_openWorkoutForm()`, plus the exercise picker filters in `lib/screens/workout_detail_screen.dart`.
- Goal bug source: hardcoded dashboard V-shape card, fallback `main_goal`, and default inserted goals when the user had no selected goals.

## Files altered

- `lib/services/clean_base_config.dart`
- `lib/database/app_database.dart`
- `lib/screens/dashboard_screen.dart`
- `lib/screens/settings_screen.dart`
- `lib/screens/workout_detail_screen.dart`
- `lib/screens/workouts_screen.dart`
- `test/clean_base/clean_base_catalog_visibility_test.dart`
- `test/clean_base/clean_base_goal_visibility_test.dart`
- `test/v080/version_metadata_test.dart`
- `docs/catalog_reports/v1.0.0/evefit_v1_clean_base_inspection.md`
- `docs/catalog_reports/v1.0.0/evefit_v1_clean_base_report.md`

## Behaviour before

- The workout detail screen opened the full legacy exercise picker.
- The workout creation form exposed the old progressive filter/menu flow.
- The dashboard could show a V-shape goal even when the user did not select it.
- New profiles without selected goals could receive default seeded goal rows.

## Behaviour after

- `CleanBaseConfig.legacyCatalogueVisible` is `false`.
- `CleanBaseConfig.legacyFiltersVisible` is `false`.
- The old exercise picker is still present in code but guarded behind the Clean Base flag.
- The old filter/template workout form is still present in code but guarded behind the Clean Base flag.
- The normal workout creation path now creates a free workout without exposing legacy filters.
- The add-exercise action shows a clear Clean Base rebuild notice instead of the old catalogue.
- Dashboard goals are rendered from selected profile goals only.

## Legacy data preservation

- No exercises were deleted.
- No filters were deleted.
- No logs were deleted.
- No schema migration was added.
- No catalogue migration was added.
- The legacy database seed/catalogue remains intact for future canonical migration.

## Goals fix

- Source of truth: `Profile.initialGoals`, serialized through `ProfilePreferencesService`.
- `user_profile.main_goal` is written from selected initial goals instead of a fallback default.
- `_insertDefaultGoals()` inserts only user-selected goals and inserts none when the user selected none.
- `profile()` prefers active profile selected goals over stale `user_profile.main_goal` data.
- Dashboard no longer injects a hardcoded V-shape card.

## Goal scenarios

- User without goals: displayed goals are empty.
- User with selected goals: displayed goals equal the selected goals.
- V-shape appears only when V-shape was explicitly selected.

## Tests added or updated

- `test/clean_base/clean_base_goal_visibility_test.dart`
- `test/clean_base/clean_base_catalog_visibility_test.dart`
- `test/v080/version_metadata_test.dart`

## Validation

- `flutter pub get`: passed.
- `dart format --set-exit-if-changed .`: passed.
- `flutter analyze`: passed, no issues found.
- `flutter test -r compact`: passed, 541 tests.
- `dart run tool/catalog_audit_report.dart --strict`: passed.
  - Catalog entries: 1762.
  - Unique canonical IDs: 1725.
  - Critical issues: 0.
  - Warnings: 0.
- `flutter build apk --debug`: passed.
  - APK: `build/app/outputs/flutter-apk/app-debug.apk`
  - Size: 156677034 bytes.
- `flutter build apk --release`: passed.
  - APK: `build/app/outputs/flutter-apk/app-release.apk`
  - Size: 56657861 bytes.

## Scope confirmations

- No exercises generated.
- No filters generated.
- No new schema implemented.
- No migration implemented.
- No catalogue rebuild implemented.
- No Shukokai changes.
- No APKs staged or committed.
- Old catalogue and filters were hidden by reversible flags, not removed.

## Pending

- Future canonical schema, migration, catalogue rebuild and new filters require explicit approval.
- Clean Base intentionally stops here.
