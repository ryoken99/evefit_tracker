# EveFit Tracker v0.7.8 Complete Aggregation and Pedagogy Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship v0.7.8 with audited “completo” filters, corrected aggregation of child branches, stronger exercise descriptions, regression tests, reports, APK, and GitHub release.

**Architecture:** Keep the existing flow architecture. Fix behavior at the selection/tag/filter layer (`TrainingFlow`, `ExerciseFilterService`, `TrainingArchitecture`) and at the catalog detail layer (`ExerciseCatalogDetailService`), preserving existing user data through seed/migration updates.

**Tech Stack:** Flutter/Dart, sqflite seed migrations, `flutter_test`, GitHub CLI release upload.

---

### Task 1: Regression Tests for Complete Aggregation

**Files:**
- Create: `test/v078_complete_aggregation_test.dart`
- Modify only after RED: `lib/services/training_architecture.dart`, `lib/services/exercise_filter_service.dart`, `lib/services/training_flow.dart`, `lib/database/seed_data.dart`, `lib/services/exercise_catalog_detail_service.dart`

- [ ] **Step 1: Write failing tests**

Add tests that call `ExerciseFilterService.getAvailableExercises` with `TrainingFlow.toTrainingSelection(...)` and representative seed-derived exercises. Cover: arms complete with dumbbells aggregates biceps/triceps/forearm and excludes chest/back/legs/cardio; chest complete aggregates upper/mid/lower/serratus; back complete aggregates width/thickness/lower; legs complete aggregates upper/lower leg; core complete aggregates abdominal/lumbar/stability; martial complete aggregates technical children; treadmill complete includes warm-up, walk, intervals, cooldown; mobility general includes major mobility zones.

- [ ] **Step 2: Verify RED**

Run: `C:\tools\flutter\bin\flutter.bat test test\v078_complete_aggregation_test.dart`

Expected: at least one failure showing missing child aggregation or missing catalog coverage.

- [ ] **Step 3: Implement minimal aggregation fixes**

Add explicit branch expansion for complete keys and missing tags/metadata. Do not include secondary-only exercises such as supino in arms complete.

- [ ] **Step 4: Verify GREEN**

Run: `C:\tools\flutter\bin\flutter.bat test test\v078_complete_aggregation_test.dart`

Expected: all v0.7.8 aggregation tests pass.

### Task 2: Regression Tests for Pedagogical Descriptions

**Files:**
- Create: `test/v078_exercise_pedagogy_test.dart`
- Modify only after RED: `lib/services/exercise_catalog_detail_service.dart`

- [ ] **Step 1: Write failing tests**

Add tests for forbidden generic phrases across all catalog details. Add specific tests for `Supino com barra`, `Passadeira aquecimento`, `Passadeira cooldown`, and `Puxada alta pega neutra`. Assert equipment families mention required teaching details: bar grip/bar position, dumbbell hold/control, cable/machine setup, mobility time/breathing, strength amplitude/breathing, cardio intensity/duration, martial base/objective.

- [ ] **Step 2: Verify RED**

Run: `C:\tools\flutter\bin\flutter.bat test test\v078_exercise_pedagogy_test.dart`

Expected: failures on generic or insufficient text.

- [ ] **Step 3: Implement description fixes**

Add manual description/step/mistake/safety cases for the named exercises and improve movement family generators so they teach exact setup, path, breathing, rhythm, return, common errors, and safety.

- [ ] **Step 4: Verify GREEN**

Run: `C:\tools\flutter\bin\flutter.bat test test\v078_exercise_pedagogy_test.dart`

Expected: all v0.7.8 pedagogy tests pass.

### Task 3: Reports and Version

**Files:**
- Create: `FILTER_COMPLETE_AGGREGATION_AUDIT_v0.7.8.md`
- Create: `EXERCISE_PEDAGOGY_AUDIT_v0.7.8.md`
- Create: `DESCRIPTION_PATTERN_FIXES_v0.7.8.md`
- Modify: `pubspec.yaml`
- Modify: `lib/screens/settings_screen.dart`

- [ ] **Step 1: Generate reports from the final catalog/test results**

Include audited complete options, expected children, sample visible exercises, corrections, test names, total descriptions changed, generic phrases removed, and “Teste humano simulado”.

- [ ] **Step 2: Update version**

Set `version: 0.7.8+16` and visible app label/button to `v0.7.8`.

### Task 4: Final Validation, APK, Commit, Release

**Files:**
- Modify: `build/app/outputs/flutter-apk/app-release.apk`
- Modify: `build/app/outputs/flutter-apk/app-release.apk.sha1`

- [ ] **Step 1: Run required validation**

Run:
`C:\tools\flutter\bin\flutter.bat pub get`
`C:\tools\flutter\bin\flutter.bat analyze`
`C:\tools\flutter\bin\flutter.bat test`
`C:\tools\flutter\bin\flutter.bat build apk --release`

- [ ] **Step 2: Confirm APK**

Run: `Get-ChildItem build\app\outputs\flutter-apk\`

- [ ] **Step 3: Commit and release**

Commit message: `Release v0.7.8 complete aggregation and pedagogy`

Create GitHub release `v0.7.8`, title `EveFit Tracker v0.7.8`, attach `build/app/outputs/flutter-apk/app-release.apk`.

