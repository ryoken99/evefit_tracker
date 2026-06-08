# v0.7.11 Catalog Contexts Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Preserve all 305 catalog entries as explicit contexts, validate all descriptions, reduce fragile filtering, and ship APK v0.7.11.

**Architecture:** Keep the existing `Exercise` UI model, but add stable catalog identity fields and a context service derived from `SeedData.exercisesByGroup`. Database seeding moves from name-only identity to catalog-entry identity while preserving existing user data.

**Tech Stack:** Flutter/Dart, sqflite, existing seed/detail/filter services, Flutter unit tests.

---

### Task 1: RED Tests For Catalog Context Identity

**Files:**
- Create: `test/v0711_catalog_context_test.dart`
- Modify later: `lib/models/exercise.dart`
- Modify later: `lib/database/app_database.dart`
- Create later: `lib/services/exercise_catalog_context_service.dart`

- [ ] Add tests asserting 305 catalog entries, 294 unique names, stable keys, and duplicate context preservation.
- [ ] Add a database seed test showing default exercises are not collapsed by name.
- [ ] Run: `C:\tools\flutter\bin\flutter.bat test test\v0711_catalog_context_test.dart`
- [ ] Expected before implementation: fail because `catalogEntryKey` and context preservation do not exist.

### Task 2: Catalog Context Service And Model Fields

**Files:**
- Create: `lib/services/exercise_catalog_context_service.dart`
- Modify: `lib/models/exercise.dart`
- Modify: `lib/database/app_database.dart`

- [ ] Add `ExerciseCatalogEntry` with `entryId`, `exerciseKey`, `contextKey`, `catalogEntryKey`, `name`, `group`, details.
- [ ] Add `exerciseKey`, `contextKey`, and `catalogEntryKey` to `Exercise`.
- [ ] Add database columns and a v0.7.11 migration.
- [ ] Update `_seedExercises` and `_refreshDefaultExerciseDetails` to use catalog entry identity.
- [ ] Run the RED test and confirm it passes.

### Task 3: RED Tests For Description Quality

**Files:**
- Create: `test/v0711_description_305_test.dart`
- Modify later: `lib/services/exercise_catalog_detail_service.dart`
- Modify later: `lib/services/exercise_catalog_context_service.dart`

- [ ] Add tests that iterate all 305 catalog entries.
- [ ] Assert no forbidden phrase, no empty description/steps/mistakes/safety/equipment/focus.
- [ ] Assert zero entries depend only on fallback helper output.
- [ ] Assert mobility has time and breathing, cardio has intensity and duration, equipped strength mentions grip/position, martial arts has base or technical objective.
- [ ] Run: `C:\tools\flutter\bin\flutter.bat test test\v0711_description_305_test.dart`
- [ ] Expected before implementation: fail because family fallback helpers still serve many entries.

### Task 4: Per-Entry Description Stabilization

**Files:**
- Modify: `lib/services/exercise_catalog_detail_service.dart`
- Modify: `lib/services/exercise_catalog_context_service.dart`

- [ ] Add per-entry adapted descriptions generated from name, context, equipment, and movement family.
- [ ] Keep helpers internal, but expose `usesGenericFallback(entry)` for tests/audit.
- [ ] Replace forbidden generic phrases with concrete beginner instructions.
- [ ] Run v0.7.11 description tests until green.

### Task 5: Filter Metadata Priority

**Files:**
- Modify: `lib/services/exercise_filter_service.dart`
- Modify: `lib/services/training_architecture.dart`
- Modify: `lib/services/workout_taxonomy.dart`
- Test: `test/v0711_filter_metadata_test.dart`

- [ ] Add tests for complete filters, duplicate context exercises, cardio modality isolation, mobility, and recovery.
- [ ] Use catalog context keys/tags where available before `contains` fallback.
- [ ] Keep remaining `contains` fallbacks documented for legacy/custom exercises.
- [ ] Run v0.7.11 filter tests until green.

### Task 6: Reports And Version

**Files:**
- Create: `tool/catalog_audit_v0711.dart`
- Create required reports in repo root.
- Modify: `pubspec.yaml`
- Modify: `lib/screens/settings_screen.dart`
- Modify: `lib/database/app_database.dart`

- [ ] Generate six mandatory reports with one line per required entry where applicable.
- [ ] Update version to `0.7.11+19`, app label to `v0.7.11`, DB version to next integer.
- [ ] Run `dart format` on changed Dart files.

### Task 7: Final Validation And Release

**Files:**
- Build output: `build/app/outputs/flutter-apk/app-release.apk`

- [ ] Run `flutter pub get`.
- [ ] Run `flutter analyze`.
- [ ] Run `flutter test`.
- [ ] Run `flutter build apk --release`.
- [ ] Confirm APK exists.
- [ ] Commit, push branch, create GitHub release `v0.7.11`, attach APK.
