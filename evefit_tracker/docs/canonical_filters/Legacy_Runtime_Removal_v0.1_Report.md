# Legacy Runtime Removal v0.1 Report

## Summary

The legacy exercise catalogue has been removed from the EveFit production
startup and navigation paths without deleting local catalogue rows or personal
history. A clean installation creates an empty `exercises` table, while an
upgrade preserves all existing exercise rows needed by historical workouts.

- Branch: `legacy-runtime-removal-v0.1`
- Base commit: `1078f3e1176c2432701c7a4d702bb5d80e39645d`
- Date: 2026-07-12
- Legacy source entries: 1762
- Canonical exercises added: 0
- Legacy seed executed after removal: false
- Legacy entries processed after removal: 0
- Canonical menu: 8 capabilities, 4 contexts, 246 nodes

## Sources and archive

The legacy catalogue inventory and immutable recovery instructions are in:

- `docs/archive/legacy_catalog/README.md`
- `docs/archive/legacy_catalog/SOURCE_MANIFEST.md`

The manifest records the original paths, byte sizes, SHA-256 checksums and the
origin commit. Git history is used as the archive rather than duplicating more
than 800 KB of generated Dart source. The offline sources remain available to
historical audit tests, but no production import path from `main.dart`,
`app.dart`, database startup, screens or widgets reaches the catalogue source,
filter service, training architecture or training flow.

`seed_data.dart` previously mixed exercise rows with workout types and initial
goal definitions. The runtime now reads workout types from `WorkoutTaxonomy`
and preserves the exact existing initial goal titles in the profile creation
routine. This removes `seed_data.dart` from the production import graph without
changing available goals or workout types.

## Previous runtime flow

```text
AppDatabase.open
  -> schema creation and every historical migration
  -> legacy source construction
  -> parse, enrich and validate catalogue entries
  -> insert/update exercises, aliases and relations
  -> rebuild catalogue indexes
  -> expose legacy picker and filters
```

The baseline invoked legacy processing 51 times during one clean startup. With
1762 source rows, this produced 89862 processed entry visits.

## New runtime flow

```text
AppDatabase.open
  -> create or upgrade compatibility schema
  -> preserve existing exercises and workout foreign keys
  -> do not load, parse, validate or seed legacy catalogue data
  -> expose the canonical search menu
  -> terminal nodes remain intentional empty states
```

The legacy catalogue and filter visibility flags remain false. Explicit runtime
flags also state that the seed, catalogue runtime and filter runtime are off,
while the canonical catalogue has no active exercises.

## Runtime changes

- Removed legacy exercise seed, refresh, alias rebuild and relation rebuild from
  database creation and migrations.
- Converted the v0.7.17 migration to a schema-only, idempotent column addition.
- Kept the `exercises` table and all workout foreign keys for compatibility.
- Made the old catalogue refresh API a deprecated no-op for passive API
  compatibility.
- Replaced the workout exercise picker with the canonical menu; terminal nodes
  do not create exercise rows.
- Removed legacy training flow and filter usage from workout creation/editing.
- Removed training architecture lookup from workout cards.
- Separated `WorkoutTemplateExerciseRef` into a neutral model so historical
  template resolution does not import legacy template/catalogue definitions.
- Added deterministic startup diagnostics for seed invocation count, processed
  entry count and durations.

## Historical compatibility

No destructive migration was introduced. Existing rows in `exercises` remain
in each user's database. Historical joins continue through
`workout_sets.exercise_id` and `workout_exercises.exercise_id`. Existing rows:

- remain accessible from historical workout details;
- do not appear in canonical search;
- are not available for creating new workouts;
- are never seeded again;
- are not deleted, renamed or rewritten by the new startup path.

The upgrade test used a representative version-22 database with a profile,
measurement, goal, workout, workout set, workout exercise and 1762 legacy
exercise rows. Before and after counts were identical:

| Table | Before | After |
| --- | ---: | ---: |
| profiles | 1 | 1 |
| body_measurements | 1 | 1 |
| goals | 1 | 1 |
| workouts | 1 | 1 |
| workout_sets | 1 | 1 |
| workout_exercises | 1 | 1 |
| exercises | 1762 | 1762 |

Foreign key verification passed and the historical workout/exercise join
remained accessible. Artifact:

`test_artifacts/legacy_runtime/upgrade/2026-07-12T165857Z`

## Startup performance

All measurements used the same `EveFit_Test_Device` AVD, debug mode, cleared app
data and the same host environment.

### Before

| Run | Startup | Database initialization | Legacy seed | Invocations | Entries processed |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 181436 ms | 180952 ms | 107480 ms | 15 | 89862 |
| 2 | 181530 ms | 181079 ms | 107820 ms | 15 | 89862 |
| 3 | 186670 ms | 186152 ms | 110880 ms | 15 | 89862 |

- Median: 181530 ms
- Worst: 186670 ms
- Artifacts: `test_artifacts/startup_performance/before/`

### After

| Run | Startup | Database initialization | Legacy seed | Invocations | Entries processed |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 1538 ms | 1150 ms | 0 ms | 0 | 0 |
| 2 | 1637 ms | 1140 ms | 0 ms | 0 | 0 |
| 3 | 1644 ms | 1159 ms | 0 ms | 0 | 0 |

- Median: 1637 ms
- Worst: 1644 ms
- Median improvement: 99.098%
- Artifacts: `test_artifacts/startup_performance/after/`

## Validation

- `flutter pub get`: passed
- `dart format --set-exit-if-changed .`: passed, 271 files, 0 changed
- `flutter analyze`: passed, no issues
- Focused Clean Base, canonical menu, template and migration tests: passed
- Full test suite: passed, 574 tests in 11m05s
- Full-app clean install: passed in 14 seconds
- Upgrade test: passed with equal personal-data counts and valid foreign keys
- `flutter build apk --debug`: passed
- `flutter build apk --release`: passed, 51.7 MB

Full-app artifact:

`test_artifacts/canonical_search_menu/full_app/2026-07-12T165733Z`

Final full-suite log:

`test_artifacts/phase_b_validation/2026-07-12T174617Z/flutter_test_full.log`

## Files changed by responsibility

Runtime and compatibility:

- `lib/database/app_database.dart`
- `lib/models/workout_template_exercise_ref.dart`
- `lib/screens/workout_detail_screen.dart`
- `lib/screens/workouts_screen.dart`
- `lib/services/clean_base_config.dart`
- `lib/services/exercise_v717_migration.dart`
- `lib/services/workout_template_service.dart`
- `lib/widgets/workout_card.dart`

Diagnostics and test laboratory:

- `lib/services/startup_catalog_diagnostics.dart`
- `integration_test/startup_performance_probe_test.dart`
- `integration_test/legacy_runtime_upgrade_setup_test.dart`
- `integration_test/legacy_runtime_upgrade_verify_test.dart`
- `tool/run_startup_performance_probe.ps1`
- `tool/run_legacy_runtime_upgrade_test.ps1`
- `tool/legacy_upgrade_database_helper.py`

Tests update previous seed/backfill expectations to the new non-destructive,
legacy-free runtime contract. No Dashboard file, public version, canonical menu
taxonomy, goal editor, measurement model or exercise content was changed.

## Risks and limitations

- Historical catalogue source remains available to offline tests and tools. It
  is intentionally not deleted, but production code must not import it again.
- Historical local exercise rows remain in upgraded databases by design; their
  presence does not mean the legacy catalogue is active.
- Canonical terminal nodes remain empty until a later explicitly approved
  catalogue phase.

## Rollback

Revert the Phase B commits to restore the old runtime flow. The removal does not
drop tables or rows, so rollback requires no downgrade migration and loses no
personal data. Databases opened by the new code remain compatible with the old
schema because only existing tables and columns are retained.
