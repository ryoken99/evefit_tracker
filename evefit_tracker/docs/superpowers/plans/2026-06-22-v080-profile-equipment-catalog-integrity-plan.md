# v0.8.0 Profile, Equipment and Catalog Integrity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Deliver v0.8.0 with strict profile isolation, profile-derived exercise availability, canonical anatomical filtering, beginner-complete exercise guidance and verified full-body catalog coverage excluding face.

**Architecture:** Keep `AppDatabase` as the SQLite facade and add one schema migration plus focused canonical registries/services. Runtime filtering uses stored canonical keys; profile-owned child operations are authorized through SQL ownership joins; catalog quality and migration safety are enforced by executable tests and generated reports.

**Tech Stack:** Flutter, Dart 3.12, sqflite, sqflite_common_ffi, flutter_test, SQLite migrations, GitHub Actions.

---

## File structure

- Modify `lib/database/app_database.dart`: schema v18 migration, scoped CRUD/export, batch workouts, dashboard transaction, PIN persistence and exercise ownership.
- Create `lib/database/migrations/v080_integrity_migration.dart`: additive/idempotent schema and encoding/key backfill.
- Modify `lib/models/exercise.dart`: canonical taxonomy and profile ownership fields.
- Create `lib/models/exercise_taxonomy.dart`: typed canonical taxonomy serialization.
- Create `lib/services/equipment_catalog_service.dart`: unique canonical equipment registry and location capabilities.
- Create `lib/services/exercise_taxonomy_service.dart`: catalog-key taxonomy source and legacy migration adapter.
- Modify `lib/services/exercise_filter_service.dart`: key-only runtime selection/availability matching.
- Modify `lib/services/exercise_catalog_context_service.dart`: attach reviewed taxonomy and complete teaching detail.
- Modify `lib/services/exercise_catalog_detail_service.dart`: remove unadapted generic fallbacks and expose regression/progression/breathing/posture/adaptation guidance.
- Modify `lib/services/workout_template_service.dart`: stable template references.
- Create `lib/services/legacy_text_normalizer.dart`: exact safe mojibake normalization.
- Modify `lib/services/profile_preferences_service.dart` and `lib/services/training_location_service.dart`: canonical equipment/location UI data.
- Modify `lib/screens/workouts_screen.dart`, `lib/screens/dashboard_screen.dart`, `lib/screens/settings_screen.dart`: stable template calls, unavailable labels, height fallback, transactional save and v0.8.0 UI.
- Create `test/v080/`: SQLite ownership/migration tests and focused service matrices.
- Create/update `AUDIT_REPORT.md`, `EXERCISE_CATALOG_REPORT.md`, `CHANGELOG.md`, `RELEASE_NOTES.md`, `README.md`, `.github/workflows/release.yml`.

### Task 1: Baseline and initial audit

**Files:**
- Create: `AUDIT_REPORT.md`
- Verify: `pubspec.yaml`

- [ ] **Step 1: Verify repository and branch**

Run: `git remote get-url origin && git branch --show-current`

Expected: `https://github.com/ryoken99/evefit_tracker.git` and `feature/v0.8.0-profile-equipment-catalog-integrity`.

- [ ] **Step 2: Run analyzer baseline**

Run from `evefit_tracker`: `flutter analyze`

Expected: record the complete result and classify every failure as environment or code.

- [ ] **Step 3: Run test baseline**

Run from `evefit_tracker`: `flutter test`

Expected: record the test count and complete result; do not proceed silently past a code failure.

- [ ] **Step 4: Write the initial audit**

Create `AUDIT_REPORT.md` with repository/branch/base commit, both baseline commands, observed defects from the approved design, regression risks, and `AppDatabase` extraction debt. Mark defects as `OPEN`, not as fixed.

- [ ] **Step 5: Commit**

Run: `git add evefit_tracker/AUDIT_REPORT.md && git commit -m "docs: record v0.8.0 baseline audit"`

### Task 2: Public v0.8.0 version surfaces

**Files:**
- Create: `test/v080/version_metadata_test.dart`
- Modify: `pubspec.yaml`
- Modify: `lib/screens/settings_screen.dart`
- Modify: `README.md`
- Modify: `../.github/workflows/release.yml`
- Create: `CHANGELOG.md`
- Create: `RELEASE_NOTES.md`

- [ ] **Step 1: Write the failing version test**

The test reads repository files and asserts:

```dart
expect(pubspec, contains('version: 0.8.0'));
expect(settings, contains("appVersionLabel = 'v0.8.0'"));
expect(workflow, contains("default: 'v0.8.0'"));
expect(changelog, contains('# v0.8.0'));
expect(releaseNotes, contains('# v0.8.0'));
```

- [ ] **Step 2: Verify RED**

Run: `flutter test test/v080/version_metadata_test.dart`

Expected: FAIL because current files identify v0.7.16/v0.7.17 and release files are absent.

- [ ] **Step 3: Update current release surfaces**

Set `version: 0.8.0`, `appVersionLabel = 'v0.8.0'`, workflow input/default/release body to v0.8.0, and create the exact Portuguese release bullets required by the specification in both release documents. Document that `--build-number` may be supplied technically while public `--build-name` remains `0.8.0`.

- [ ] **Step 4: Verify GREEN and commit**

Run: `flutter test test/v080/version_metadata_test.dart`

Expected: PASS.

Run: `git add . && git commit -m "chore: set public version to v0.8.0"`

### Task 3: v0.8.0 additive database migration

**Files:**
- Create: `lib/database/migrations/v080_integrity_migration.dart`
- Create: `lib/services/legacy_text_normalizer.dart`
- Modify: `lib/database/app_database.dart`
- Modify: `lib/models/exercise.dart`
- Create: `test/v080/integrity_migration_test.dart`

- [ ] **Step 1: Write migration RED tests**

Create a v17-shaped in-memory database with goals, milestones, two profiles, custom/default exercises, workouts and mojibake text. Assert after migration:

```dart
expect(columns('exercises'), containsAll(['profile_id', 'region_keys',
  'group_keys', 'subgroup_keys', 'primary_muscle_key',
  'secondary_muscle_keys', 'equipment_keys', 'movement_pattern',
  'difficulty', 'force_type', 'laterality', 'goal_tags']));
expect(tableNames, containsAll(['profile_hidden_exercises', 'profile_security']));
expect(await rowCount('workouts'), originalWorkoutCount);
expect(await exerciseName(corruptId), 'Extensão de tríceps');
```

- [ ] **Step 2: Verify RED**

Run: `flutter test test/v080/integrity_migration_test.dart`

Expected: FAIL because schema version 18 and migration do not exist.

- [ ] **Step 3: Implement migration**

Add guarded columns and these tables:

```sql
CREATE TABLE IF NOT EXISTS profile_hidden_exercises(
  profile_id INTEGER NOT NULL,
  exercise_id INTEGER NOT NULL,
  created_at TEXT NOT NULL,
  PRIMARY KEY(profile_id, exercise_id)
);
CREATE TABLE IF NOT EXISTS profile_security(
  profile_id INTEGER PRIMARY KEY,
  failed_attempts INTEGER NOT NULL DEFAULT 0,
  locked_until TEXT
);
```

Normalize a finite map of known sequences (`ExtensÃ£o`, `BÃ­ceps`, `trÃ­ceps`, `mÃ£o`, `glÃºteos` and their common double-encoded forms). Preserve IDs and all row counts. Increase database version to 18 and invoke the migration on create/upgrade.

- [ ] **Step 4: Verify GREEN and idempotence**

Run the migration test twice against the same database.

Expected: PASS with unchanged row counts and no duplicate tables/columns.

- [ ] **Step 5: Commit**

Run: `git add lib test/v080/integrity_migration_test.dart && git commit -m "feat: add non-destructive v0.8.0 migration"`

### Task 4: Goal and milestone profile isolation

**Files:**
- Modify: `lib/database/app_database.dart`
- Modify: `lib/screens/goals_screen.dart`
- Modify: `lib/services/csv_export_service.dart`
- Create: `test/v080/goal_profile_isolation_test.dart`

- [ ] **Step 1: Write failing two-profile SQL tests**

Insert Profile A/B goals and milestones, activate A, and assert A cannot read, update, complete or delete B records. Assert export A includes only A goal/milestone IDs.

- [ ] **Step 2: Verify RED**

Run: `flutter test test/v080/goal_profile_isolation_test.dart`

Expected: FAIL on unscoped `goal_milestones` operations/export.

- [ ] **Step 3: Implement parent-authorized milestone SQL**

Use predicates shaped as:

```sql
WHERE goal_id = ? AND EXISTS (
  SELECT 1 FROM goals
  WHERE goals.id = goal_milestones.goal_id AND goals.profile_id = ?
)
```

For ID-only updates/deletes, authorize with the same `EXISTS` clause. Add `deleteGoalMilestone`. Insert first verifies that the parent goal belongs to the active profile. Export milestones joins goals and filters `goals.profile_id`.

- [ ] **Step 4: Verify GREEN and profile switch refresh**

Run the focused test and a widget/service test that activates B and recreates the goals/dashboard future.

Expected: PASS; no A IDs remain in B snapshots.

- [ ] **Step 5: Commit**

Run: `git add lib test/v080/goal_profile_isolation_test.dart && git commit -m "fix: isolate goals and milestones by profile"`

### Task 5: Canonical profile equipment and locations

**Files:**
- Create: `lib/services/equipment_catalog_service.dart`
- Modify: `lib/services/profile_preferences_service.dart`
- Modify: `lib/services/training_location_service.dart`
- Modify: `lib/database/app_database.dart`
- Modify: `lib/screens/settings_screen.dart`
- Modify: `lib/screens/profile_gate_screen.dart`
- Create: `test/v080/profile_equipment_isolation_test.dart`
- Create: `test/v080/location_equipment_matrix_test.dart`

- [ ] **Step 1: Write equipment/location RED tests**

Assert unique registry keys, one `jump_rope`, implicit `bodyweight`, no cross-profile equipment, gym capabilities, strict home selection, outdoor cardio and dojo/tatami capabilities.

- [ ] **Step 2: Verify RED**

Run: `flutter test test/v080/profile_equipment_isolation_test.dart test/v080/location_equipment_matrix_test.dart`

Expected: FAIL because `updateProfileEquipment` passes an empty location, bodyweight is not guaranteed and `jump_rope` is duplicated in section data.

- [ ] **Step 3: Implement canonical registry**

`EquipmentCatalogService` owns `Map<String, EquipmentDefinition>` exactly once. UI sections contain only key lists. `capabilitiesFor(locations, selected)` returns `{'bodyweight', ...}` plus gym/outdoor/dojo capabilities. `updateProfileEquipment` passes `activeProfile.trainingLocation`; database rows remain scoped by active profile.

- [ ] **Step 4: Verify GREEN and commit**

Run both focused tests and existing v0.7.2 equipment/filter tests.

Expected: PASS.

Run: `git add lib test/v080 && git commit -m "fix: derive equipment availability per profile"`

### Task 6: Stable template identity and exercise ownership

**Files:**
- Modify: `lib/services/workout_template_service.dart`
- Modify: `lib/database/app_database.dart`
- Modify: `lib/screens/workouts_screen.dart`
- Modify: `lib/models/exercise.dart`
- Create: `test/v080/template_identity_test.dart`
- Create: `test/v080/exercise_profile_ownership_test.dart`

- [ ] **Step 1: Write RED tests**

Create duplicate display names with distinct `catalog_entry_key` values and assert the template selects its declared key. Create customs for A/B and assert A sees/mutates only A customs; hiding a default for A does not hide it for B.

- [ ] **Step 2: Verify RED**

Run both focused tests.

Expected: FAIL because templates query `name = ?` and exercises are globally visible/mutable.

- [ ] **Step 3: Implement stable references**

Introduce `WorkoutTemplateExerciseRef(catalogEntryKey, exerciseKey, contextKey, legacyName)`. Resolve catalog entry key first, pair second, and legacy name only when exactly one row matches. Scope custom queries/mutations by `profile_id`; store default hides in `profile_hidden_exercises`.

- [ ] **Step 4: Verify GREEN and compatibility**

Run focused tests plus `test/workout_template_test.dart` and `test/v0714_template_and_hierarchy_test.dart`.

Expected: PASS; legacy templates remain displayable.

- [ ] **Step 5: Commit**

Run: `git add lib test/v080 && git commit -m "fix: use stable template and exercise ownership keys"`

### Task 7: Persisted canonical exercise taxonomy

**Files:**
- Create: `lib/models/exercise_taxonomy.dart`
- Create: `lib/services/exercise_taxonomy_service.dart`
- Modify: `lib/models/exercise.dart`
- Modify: `lib/services/exercise_catalog_context_service.dart`
- Modify: `lib/services/training_architecture.dart`
- Modify: `lib/services/exercise_filter_service.dart`
- Create: `test/v080/anatomy_taxonomy_test.dart`
- Create: `test/v080/anatomy_false_positive_test.dart`

- [ ] **Step 1: Write taxonomy RED tests**

Assert every catalog entry has non-empty canonical region/group/primary muscle/equipment/movement/difficulty fields and required optional sets. Assert face is absent. Add explicit positives and negatives for all requested chest, back, shoulder, arm, forearm, core, glute, leg, lower-leg, cardio and martial-arts keys.

- [ ] **Step 2: Verify RED**

Run both focused tests.

Expected: FAIL because the model lacks the complete persisted taxonomy and some focus paths still depend on text matching.

- [ ] **Step 3: Implement taxonomy source and serialization**

`ExerciseTaxonomy` serializes sets as sorted comma-separated keys. `ExerciseTaxonomyService` resolves by stable catalog identity, with explicit family maps and per-entry overrides. Seed entries store the result. `TrainingArchitecture.tagsForExercise` reads stored keys first and uses legacy derivation only for unmigrated custom exercises.

- [ ] **Step 4: Change runtime filtering to canonical keys**

Selection matching uses set membership. Biceps excludes triceps-primary entries; triceps excludes curls; back width and thickness are separate; lateral/rear deltoid, grip, anti-rotation and anti-extension use dedicated keys. Equipment availability uses canonical equipment sets, not display labels.

- [ ] **Step 5: Verify GREEN and commit**

Run all `test/filters`, v0.7.17 muscle-node tests and both v0.8.0 taxonomy tests.

Expected: PASS.

Run: `git add lib test/v080 && git commit -m "feat: add canonical exercise taxonomy"`

### Task 8: Scientific catalog coverage and individual teaching content

**Files:**
- Modify: `lib/database/seed_data.dart`
- Modify: `lib/services/exercise_catalog_context_service.dart`
- Modify: `lib/services/exercise_catalog_detail_service.dart`
- Modify: `lib/services/catalog_quality_gate_service.dart`
- Create: `test/v080/catalog_coverage_test.dart`
- Create: `test/v080/catalog_teaching_quality_test.dart`

- [ ] **Step 1: Write coverage and quality RED tests**

Require at least one realistic entry for every requested canonical muscle/specialty key and meaningful home/gym options where biomechanically applicable. For every entry require description, numbered execution with at least eleven instructional stages, error, safety, regression, progression, breathing, posture and adaptation guidance. Reject known generic phrases and duplicate normalized descriptions/executions.

- [ ] **Step 2: Verify RED and record exact gaps**

Run both tests and capture missing keys/entries in `AUDIT_REPORT.md`.

Expected: FAIL with a finite catalog-key list.

- [ ] **Step 3: Add only gap-closing exercises**

For each missing canonical key, add real exercises supported by standard movement mechanics; include stable identity, equipment/location compatibility, taxonomy, regression and progression. Do not add facial work or synonyms that duplicate an existing movement/context.

- [ ] **Step 4: Rewrite failing entries individually**

Replace each failing generic/duplicate entry using its stable catalog key. The execution explicitly covers setup, alignment, initiation, effort, return, breathing, tempo, failure cues, common error, regression and progression. Safety states when to stop/adapt.

- [ ] **Step 5: Verify GREEN and commit**

Run all catalog tests, including historical v0.7.6-v0.7.17 quality suites.

Expected: PASS with zero incomplete main entries and no face entries.

Run: `git add lib test/v080 && git commit -m "feat: complete full-body exercise catalog"`

### Task 9: Dashboard, unknown IDs, PIN and workout batching

**Files:**
- Modify: `lib/database/app_database.dart`
- Modify: `lib/screens/dashboard_screen.dart`
- Modify: `lib/screens/workouts_screen.dart`
- Modify: `lib/services/dashboard_metric_service.dart`
- Create: `test/v080/dashboard_integrity_test.dart`
- Create: `test/v080/unknown_key_display_test.dart`
- Create: `test/v080/pin_persistence_test.dart`
- Create: `test/v080/workout_batch_loading_test.dart`

- [ ] **Step 1: Write four focused RED suites**

Assert unset height renders “Altura por definir”; widget batches are atomic/profile-scoped; unknown keys never return the first definition; five failed PINs persist a lock across facade recreation; workout loading returns ordered equivalent entries using bounded batch queries.

- [ ] **Step 2: Verify RED**

Run the four tests.

Expected: FAIL on all identified current behaviors.

- [ ] **Step 3: Implement minimal fixes**

Add `updateDashboardWidgets(List<DashboardWidgetConfig>)` transaction; neutral lookup labels; `profile_security` reads/writes; and three-query workout loading using `WHERE workout_id IN (...)`, grouped by workout ID.

- [ ] **Step 4: Verify GREEN and commit**

Run focused tests plus existing dashboard/profile/workout tests.

Expected: PASS.

Run: `git add lib test/v080 && git commit -m "fix: harden dashboard pin and workout loading"`

### Task 10: Reports, stale-version audit and final verification

**Files:**
- Update: `AUDIT_REPORT.md`
- Create: `EXERCISE_CATALOG_REPORT.md`
- Update: `CHANGELOG.md`
- Update: `RELEASE_NOTES.md`

- [ ] **Step 1: Generate final catalog report**

Report total/new/reviewed/complete/incomplete counts, duplicate/generic/missing metadata counts, canonical muscle coverage, exclusions and anatomical decisions. Every count must be reproducible from the quality-gate test output.

- [ ] **Step 2: Close the audit**

Move fixed items from `OPEN` to `FIXED` with tests/commits. List genuinely deferred items and exact regression risks. Include the future `AppDatabase` extraction plan.

- [ ] **Step 3: Scan active version surfaces**

Run targeted `rg` against `pubspec.yaml`, `README.md`, `CHANGELOG.md`, `RELEASE_NOTES.md`, `.github/workflows/release.yml`, `lib/` and new v0.8.0 reports. Historical immutable v0.7.x audits/tests may retain their historical identifiers but must not be linked as the current release.

Expected: no stale current/public version and no `0.8.0+25`.

- [ ] **Step 4: Run final analyzer**

Run: `flutter analyze`

Expected: `No issues found!`.

- [ ] **Step 5: Run final test suite**

Run: `flutter test`

Expected: all tests pass.

- [ ] **Step 6: Review changes and commit**

Run: `git diff --check && git status --short && git log --oneline --decorate -12`

Expected: only intended report/release changes remain before the final commit.

Run: `git add . && git commit -m "docs: finalize v0.8.0 integrity release"`

### Task 11: Publish branch

- [ ] **Step 1: Push the exact branch**

Run: `git push -u origin feature/v0.8.0-profile-equipment-catalog-integrity`

Expected: remote branch created at `https://github.com/ryoken99/evefit_tracker/tree/feature/v0.8.0-profile-equipment-catalog-integrity`.

- [ ] **Step 2: Provide release build commands**

Document:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter test
flutter build apk --release --build-name 0.8.0
flutter build appbundle --release --build-name 0.8.0
```

If a store requires a monotonically increasing technical build number, add `--build-number <store-required-integer>` without changing public version/name `0.8.0`.
