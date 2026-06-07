# v0.7.7 Exercise Description Audit Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Audit every exercise in the EveFit Tracker catalog, rewrite specific beginner-friendly descriptions, correct metadata, add catalog-wide tests, generate reports, build APK, and publish release v0.7.7.

**Architecture:** Keep the existing training flow and filter architecture. Add a focused catalog detail service that produces complete metadata for each seed exercise and let `AppDatabase` delegate to it. Tests must iterate over `SeedData.exercisesByGroup` and the detail service so missing or generic descriptions fail.

**Tech Stack:** Flutter/Dart, sqflite seed data, Flutter tests, GitHub CLI for release.

---

### Task 1: Catalog Inventory

**Files:**
- Read: `lib/database/seed_data.dart`
- Create: `EXERCISE_DESCRIPTION_FULL_AUDIT_v0.7.7.md`

- [ ] Count unique visible default exercises from `SeedData.exercisesByGroup`.
- [ ] Record every exercise name in the full audit report with a final state.

### Task 2: Test First

**Files:**
- Create: `test/exercise_descriptions_are_specific_test.dart`

- [ ] Add tests that iterate every unique exercise in `SeedData.exercisesByGroup`.
- [ ] Fail on empty description, steps, equipment, muscle group, prohibited text, short descriptions, generic safety, missing grip instructions for equipment, missing time/breathing for mobility, and bad equipment for specific exercises.
- [ ] Run `C:\tools\flutter\bin\flutter.bat test test\exercise_descriptions_are_specific_test.dart` and confirm failures on current code.

### Task 3: Catalog Detail Service

**Files:**
- Create: `lib/services/exercise_catalog_detail_service.dart`
- Modify: `lib/database/app_database.dart`

- [ ] Add public detail methods for equipment, secondary groups, description, execution steps, mistakes, and safety notes.
- [ ] Write specific special cases for ambiguous exercises: cervical stretch, incline fly variants, dips, decline bench variants, French extension, dumbbell curl.
- [ ] Add equipment-family and movement-family generators that produce detailed, exercise-specific text without prohibited phrases.
- [ ] Delegate `AppDatabase` helper methods to this service.

### Task 4: Catalog Corrections

**Files:**
- Modify: `lib/database/seed_data.dart`
- Modify: `lib/services/training_architecture.dart`

- [ ] Split ambiguous exercises into equipment-specific variants.
- [ ] Correct equipment metadata for incline fly, decline bench, dips, French extension, and cable/band variants.
- [ ] Keep filters compatible with the new variant names.

### Task 5: Reports

**Files:**
- Create: `EXERCISE_DESCRIPTION_FULL_AUDIT_v0.7.7.md`
- Create: `EXERCISE_DESCRIPTION_REWRITE_v0.7.7.md`

- [ ] Include totals: exercises found, audited, descriptions rewritten, metadata corrected, placeholders removed, variants split, tests created, tests passed.
- [ ] Include before/after examples and known limitations.

### Task 6: Version, Verification, Release

**Files:**
- Modify: `pubspec.yaml`
- Modify: `lib/screens/settings_screen.dart`

- [ ] Update to `0.7.7+15` and visible `v0.7.7`.
- [ ] Run `flutter pub get`, `flutter analyze`, `flutter test`, `flutter build apk --release`.
- [ ] Confirm `build/app/outputs/flutter-apk/app-release.apk`.
- [ ] Commit, push branch, create GitHub release `v0.7.7` with APK attached.
