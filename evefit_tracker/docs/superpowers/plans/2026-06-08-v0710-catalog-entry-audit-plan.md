# v0.7.10 Catalog Entry Audit Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Stabilize the current 305-entry exercise catalog through per-entry audit, metadata/description/filter corrections, tests, reports, APK and GitHub release.

**Architecture:** Keep the app architecture intact. Use `tool/catalog_audit_v0710.dart` to generate reproducible audit reports from existing seed/detail/filter services, and keep production edits scoped to catalog metadata and filters.

**Tech Stack:** Flutter, Dart, sqflite seed data, existing Dart test suite, GitHub CLI release flow.

---

### Task 1: Baseline And Snapshot

**Files:**
- Create: `tool/catalog_audit_v0710.dart`
- Create: `CATALOG_SNAPSHOT_BEFORE_v0.7.10.md`

- [x] Count current seed entries.
- [x] Run baseline `flutter test`.
- [x] Generate snapshot before catalog changes.
- [x] Verify snapshot has 305 entry rows and 294 unique names.

### Task 2: RED Tests For v0.7.10

**Files:**
- Create: `test/v0710_catalog_entry_audit_test.dart`
- Create: `test/v0710_complete_filter_entry_test.dart`

- [ ] Add tests that iterate all 305 seed entries and validate required fields.
- [ ] Add tests for forbidden generic phrases.
- [ ] Add tests for name/equipment mismatch and bodyweight misuse.
- [ ] Add tests for teaching requirements by type/equipment.
- [ ] Add complete-filter tests for the required complete branches.
- [ ] Run the new tests and confirm they fail on current weak spots before production edits.

### Task 3: Metadata And Description Corrections

**Files:**
- Modify: `lib/services/exercise_catalog_detail_service.dart`
- Modify: `lib/services/training_architecture.dart`
- Modify: `lib/services/exercise_filter_service.dart`
- Modify only if necessary: `lib/database/seed_data.dart`

- [ ] Correct equipment metadata where the name implies halteres, barra, cabo, maquina, paralelas or caseiro.
- [ ] Correct architecture tags where exercises appear in the wrong branch.
- [ ] Remove remaining generic description phrases.
- [ ] Strengthen descriptions for entries caught by the v0.7.10 tests.
- [ ] Keep total catalog size unchanged unless an ambiguity split is justified in reports.

### Task 4: Report Generation

**Files:**
- Modify: `tool/catalog_audit_v0710.dart`
- Create: `CATALOG_ENTRY_AUDIT_v0.7.10.md`
- Create: `EQUIPMENT_METADATA_AUDIT_v0.7.10.md`
- Create: `COMPLETE_FILTER_ENTRY_AUDIT_v0.7.10.md`
- Create: `DESCRIPTION_ENTRY_REVIEW_v0.7.10.md`

- [ ] Extend the generator to produce all required audit reports.
- [ ] Include one row per entry where required.
- [ ] Include total corrections, metadata corrections, filter corrections and exceptions.
- [ ] Mark exceptions only with explicit justification.

### Task 5: Version, Validation, APK And Release

**Files:**
- Modify: `pubspec.yaml`
- Modify: `lib/screens/settings_screen.dart`
- Modify if catalog details need reseed: `lib/database/app_database.dart`
- Modify: `build/app/outputs/flutter-apk/app-release.apk`
- Modify: `build/app/outputs/flutter-apk/app-release.apk.sha1`

- [ ] Update version to `0.7.10+18`.
- [ ] Show `v0.7.10` in the app/update button.
- [ ] Run `flutter pub get`.
- [ ] Run `flutter analyze`.
- [ ] Run `flutter test`.
- [ ] Run `flutter build apk --release`.
- [ ] Confirm APK exists in `build/app/outputs/flutter-apk/`.
- [ ] Commit, push branch and create GitHub release `v0.7.10` with APK.
