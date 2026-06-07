# v0.7.9 Exercise Coverage Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build v0.7.9 with researched exercise coverage, expanded catalog variants, safer home alternatives, complete-filter tests, pedagogy tests, reports, APK and GitHub release.

**Architecture:** Keep the current seed/detail/tag/filter architecture. Add focused catalog entries and metadata rules, then prove behavior with tests that use the real seed and services.

**Tech Stack:** Flutter/Dart, sqflite migrations, `flutter_test`, GitHub CLI.

---

### Task 1: Research And Baseline Audit

**Files:**
- Create/Update: `EXERCISE_COVERAGE_RESEARCH_v0.7.9.md`
- Read: `lib/database/seed_data.dart`
- Read: `lib/services/exercise_catalog_detail_service.dart`
- Read: `lib/services/training_architecture.dart`

- [x] Count current seed exercises.
- [x] Record reliable sources used for structure.
- [x] List functional anatomy, equipment, home alternatives and gaps.

### Task 2: Write RED Coverage Tests

**Files:**
- Create: `test/v079_exercise_coverage_test.dart`
- Create: `test/v079_description_pedagogy_test.dart`

- [ ] Add tests for arms complete with dumbbells including new biceps/triceps/forearm/grip variants.
- [ ] Add tests for minimum arms-complete count and exclusion of chest/back/legs/cardio.
- [ ] Add tests for full branches: chest, back, legs, core, mobility, recovery, martial arts and cardio.
- [ ] Add tests for safe home alternatives.
- [ ] Add tests for flexion/squat pedagogy and ambiguous seed names.
- [ ] Run focused tests and verify RED failures.

### Task 3: Expand Seed Catalog

**Files:**
- Modify: `lib/database/seed_data.dart`
- Modify: `lib/services/workout_template_service.dart`

- [ ] Replace ambiguous default seed names with explicit variants where needed.
- [ ] Add arm/dumbbell variants: `Curl 21 com halteres`, `Curl arrastado com halteres`, `Extensao acima da cabeca com halter`, `Press fechado com halteres`, `Tate press`, `Suitcase carry`, `Hold estatico com halteres`, `Rotacao controlada com halter leve`.
- [ ] Add flexion and squat variants.
- [ ] Add safe home alternatives with explicit equipment names.

### Task 4: Metadata And Equipment Mapping

**Files:**
- Modify: `lib/services/profile_preferences_service.dart`
- Modify: `lib/services/training_architecture.dart`
- Modify: `lib/services/exercise_filter_service.dart`
- Modify: `lib/services/exercise_catalog_detail_service.dart`
- Modify: `lib/database/app_database.dart`

- [ ] Add equipment options/keys for safe home alternatives.
- [ ] Add equipment aliases and architecture equipment keys.
- [ ] Map new exercises to correct equipment, group, subgroup and focus.
- [ ] Add v0.7.9 migration to seed and refresh default details.

### Task 5: Description Pedagogy

**Files:**
- Modify: `lib/services/exercise_catalog_detail_service.dart`

- [ ] Rewrite `Flexao classica` with hands, feet, plank, descent, ascent, breathing, errors and safety.
- [ ] Rewrite `Agachamento com peso corporal` with feet, knees, hip, descent, ascent, breathing, errors and safety.
- [ ] Add safe-object warnings for backpack, water jug, chair/step, towel/broomstick and table variants.
- [ ] Ensure generic prohibited phrases remain blocked.

### Task 6: Final Reports

**Files:**
- Create: `MUSCLE_EQUIPMENT_EXERCISE_MATRIX_v0.7.9.md`
- Create: `FULL_BODY_CATALOG_AUDIT_v0.7.9.md`
- Create: `DESCRIPTION_PEDAGOGY_REVIEW_v0.7.9.md`
- Update: `EXERCISE_COVERAGE_RESEARCH_v0.7.9.md`

- [ ] Record final exercise count, added count, rewritten description count and complete-filter audit count.
- [ ] List honest known gaps.

### Task 7: Validation, APK And Release

**Files:**
- Modify: `pubspec.yaml`
- Modify: `lib/screens/settings_screen.dart`
- Stage: `build/app/outputs/flutter-apk/app-release.apk`

- [ ] Set version to `0.7.9+17` and visible app label to `v0.7.9`.
- [ ] Run `flutter pub get`.
- [ ] Run `flutter analyze`.
- [ ] Run `flutter test`.
- [ ] Run `flutter build apk --release`.
- [ ] Commit, push branch and create GitHub release `v0.7.9` with APK.

