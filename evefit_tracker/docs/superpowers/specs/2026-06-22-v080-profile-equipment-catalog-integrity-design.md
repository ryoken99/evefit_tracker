# v0.8.0 Profile, Equipment and Catalog Integrity Design

## Context and baseline

The release branch `feature/v0.8.0-profile-equipment-catalog-integrity` starts at commit `444ec98`, the v0.7.17 anatomical-muscle-node release. This is intentionally newer than `origin/main`, which currently ends at v0.7.16. Keeping v0.7.17 preserves its exercise identity columns, muscle-node migration, display validation and regression tests.

The current application is a Flutter app backed by SQLite through a large `AppDatabase`. It already filters most first-level entities by the active profile, but several ownership boundaries remain incomplete: milestones are queried only by goal ID, custom exercises have no owner, equipment updates lose the profile location, PIN lockout is held only in memory, dashboard widget updates are saved individually, and `workouts()` performs two queries per workout. The catalog already contains stable identity and context fields, but the public model does not yet expose the complete canonical taxonomy requested for v0.8.0.

## Release outcome

v0.8.0 is an integrity-and-catalog release. It must:

1. enforce profile ownership for goals, milestones, equipment, locations, custom exercises, hidden defaults and exports;
2. make exercise availability deterministic from the active profile's locations and canonical equipment keys;
3. represent anatomical filters with canonical metadata instead of display-text matching;
4. preserve stable exercise/template identity through upgrades;
5. normalize corrupted Portuguese text without deleting user data;
6. complete and validate the exercise catalog, excluding facial exercises;
7. fix the identified dashboard, PIN and workout-loading defects when migration risk is controlled;
8. expose the public version as `0.8.0`/`v0.8.0` in all current release surfaces.

Historical audit documents may retain old version numbers when they are immutable evidence, but they will not be presented as the current release. Current metadata, UI, README, workflow defaults, changelog, release notes and new reports must identify v0.8.0. The required `pubspec.yaml` value is exactly `version: 0.8.0`; platform build systems may assign their own technical build number at build time, documented in the release instructions.

## Architecture

The implementation remains incremental. `AppDatabase` continues as the persistence facade for v0.8.0, with small focused services added for canonical equipment, taxonomy, text normalization and catalog auditing. There will be one forward-only SQLite migration. It may add nullable columns, ownership tables and indexes, then backfill safely; it will not drop user tables, delete exercises or rewrite user-entered descriptions without an exact corrupted-text match.

All profile-owned mutations use the active profile ID in the SQL predicate. Child records whose table does not store `profile_id`, especially milestones, are authorized through their parent using `EXISTS` or a join against `goals.profile_id`. An operation targeting another profile returns no data and changes zero rows. Public database methods report this through a boolean/affected-row result or a clear `StateError` where the caller supplied an invalid foreign owner.

Canonical catalog metadata is separate from localized display labels. Exercise identity uses `catalog_entry_key` first and `exercise_key` plus `context_key` as the compatibility pair. Anatomical and equipment filters compare normalized keys, never translated labels. Text matching remains only in a documented legacy migration fallback where stable keys do not yet exist.

## Delivery blocks

### 1. Release baseline and audit

Before functional changes, run `flutter analyze` and `flutter test` from the Flutter package directory and record exact failures in `AUDIT_REPORT.md`. Update current version surfaces to v0.8.0, but perform the final stale-version scan again after all documentation is generated. The audit records observed defects, fixes, deferred items, regression risks, technical debt and the future extraction plan for `AppDatabase`.

### 2. Profile ownership and persistence integrity

Goals are selected and mutated with `profile_id = activeProfileId`. Milestones are read, inserted, updated, completed and deleted only when their goal belongs to the active profile. Export includes both goals and milestones for that profile and no other profile.

`profile_equipment` and `profile_training_locations` remain keyed by profile. Equipment updates read the active profile's actual serialized locations instead of passing an empty location. `bodyweight` is always available. Gym locations enable the canonical gym set; home, outdoor and dojo availability is composed from their selected equipment and location capabilities without inheriting another profile's rows.

Default exercises remain global. Custom exercises gain `profile_id`; reads include global defaults plus customs owned by the active profile. Hiding a default uses a profile-specific hidden-entry table. Updating or deleting a custom exercise requires ownership. Existing custom exercises are assigned conservatively during migration: an unambiguous profile association from workout usage is used when available; otherwise they remain visible but immutable until explicitly adopted, which avoids destructive guesses.

PIN failed-attempt count and `locked_until` move to persisted per-profile columns or a focused table. Successful verification clears both values. Expired locks are cleared lazily. Dashboard widget batches are saved through one transaction. `workouts()` loads workouts, workout exercises and sets in three bounded queries and groups children by `workout_id` in memory.

### 3. Canonical equipment, location and anatomy

A canonical equipment registry owns each key exactly once. Sections in profile setup reference registry entries, so `jump_rope` can appear visually in more than one section without becoming two identities. Aliases from previous versions normalize to the canonical key during migration and at input boundaries.

Location capabilities are explicit:

- gym: machines, cables, dumbbells, barbells, plates, racks and benches;
- home: bodyweight plus only selected portable/home equipment;
- outdoor: walking, running, sprint and equipment-free outdoor cardio;
- dojo/tatami: Karate, Jiu-Jitsu, mobility and compatible conditioning;
- all profiles: bodyweight and safe equipment-free mobility.

Exercise taxonomy exposes canonical region, group and subgroup key sets; primary and secondary muscle keys; equipment keys; movement pattern; difficulty; optional force type, laterality and goal tags. The v0.7.17 muscle-node work is used as a migration source, not discarded. Filtering intersects explicit key sets and applies equipment/location availability separately. “Show all” may retain incompatible results only when each result carries an explicit unavailable reason.

Unknown persisted keys render a neutral fallback such as “Desconhecido”, “Foco antigo” or “Equipamento removido”. No lookup falls back to the first current option.

### 4. Catalog content, identity and migration

The existing catalog is audited before expansion. New exercises are added only to close a documented coverage gap for a requested muscle, movement, equipment or location. Facial exercises are rejected. Near-duplicate variations are rejected unless equipment, movement mechanics or training context materially changes.

Every catalog entry must have a clear name, primary muscle, secondary muscles, canonical equipment, difficulty, objective description, numbered execution, common errors, safety notes, regression, progression, breathing, posture and adaptation/avoidance guidance. Existing structured detail services may generate these fields from reviewed per-entry metadata, but no entry may depend on a generic unadapted fallback. Automated quality gates detect duplicate descriptions, generic phrases, empty required fields and missing anatomical keys; a report records any remaining exception explicitly.

Workout templates are changed from display-name lists to stable catalog references. Resolution order is `catalogEntryKey`, then the `exerciseKey/contextKey` pair. Display name is used only by a one-time compatibility mapper for legacy templates, with ambiguity detected rather than silently selecting the first row.

The v0.8.0 migration normalizes known mojibake sequences in seeded/default content and exact known values in existing rows. It does not broadly reinterpret arbitrary user text. Existing exercise IDs remain stable where possible; seed refresh updates default rows by stable catalog identity and never removes old rows merely because the current catalog changed.

### 5. UI, reports and release verification

Profile switching invalidates/reloads dashboard, goals, milestones, equipment and exercise availability immediately. The dashboard hides an unset height or displays “Altura por definir”; zero is not presented as measured data. Settings and current release documentation show v0.8.0.

`EXERCISE_CATALOG_REPORT.md` is generated or deterministically calculated from the final catalog. It includes totals, new/reviewed/complete/incomplete entries, duplicate and generic-text findings, missing metadata, anatomical coverage, exclusions and remaining gaps. `AUDIT_REPORT.md`, `CHANGELOG.md` and/or `RELEASE_NOTES.md` carry the required final release summary.

Final verification runs targeted tests during each TDD cycle, then the complete `flutter analyze` and `flutter test`. A repository scan distinguishes historical audit filenames/content from active version surfaces; only active public/current surfaces are required to have no stale release version.

## Data flow

1. The profile gate activates one profile and stores that choice transactionally.
2. Screens request profile-scoped state from `AppDatabase`; callers do not pass arbitrary profile IDs for normal operations.
3. The database facade authorizes reads and writes with the active profile ID, including parent joins for child records.
4. Profile locations and equipment are converted into canonical capability keys.
5. The filter service evaluates taxonomy matches and availability independently, returning an availability flag/reason for “show all”.
6. Templates resolve stable catalog identities to database IDs only when a workout is created.
7. Profile changes cause dependent futures/state to be recreated rather than reusing the former profile's snapshot.

## Migration and compatibility rules

- Increase the SQLite schema version once for v0.8.0.
- Add columns/tables/indexes with `IF NOT EXISTS` or guarded column checks.
- Backfill stable keys and ownership without changing existing primary IDs.
- Preserve unknown legacy values and display a neutral fallback.
- Normalize only known encoding corruption patterns or exact catalog-owned strings.
- Never delete user workouts, goals, milestones, measurements, photos or exercises.
- Keep legacy template compatibility through a deterministic migration path.
- Make the migration idempotent enough to survive an interrupted previous attempt.

## Error handling and safety

- Missing active profile: throw `StateError('Nenhum perfil ativo.')` before database access.
- Cross-profile or missing parent: return zero affected rows/false and leave data unchanged; insertion APIs reject invalid ownership.
- Ambiguous legacy template name: skip the ambiguous reference and report it instead of choosing an arbitrary exercise.
- Unknown filter/equipment key: preserve it for compatibility, render a neutral label and mark unavailable where appropriate.
- Catalog validation failure: fail tests and report the exact catalog key and missing/invalid field.
- Migration normalization failure on one optional value: retain the original value; the migration must not drop or truncate the row.

## Testing strategy

All behavior changes follow red-green-refactor. Database ownership tests use `sqflite_common_ffi` with at least two profiles and real SQL, not mocked query calls.

Required suites cover:

- goal and milestone read/update/delete/complete isolation and scoped export;
- equipment/location creation, editing and profile switching;
- home with no equipment, dumbbells, barbell/plates and bands; gym; outdoor; dojo;
- canonical anatomy positive cases and obvious false positives for every requested filter family;
- unavailable-result reasons in “show all”;
- global/default versus profile-custom exercise visibility and safe hiding/deletion;
- stable template resolution and legacy ambiguity handling;
- encoding migration, stable IDs and preservation of existing rows;
- persisted PIN lock state across database/service recreation;
- transactional dashboard widget batches and unset-height display;
- batch-loaded workout entries retaining existing ordering/count semantics;
- complete catalog fields, non-generic content, canonical tags, coverage and face exclusion;
- exact public version and current release metadata.

The final suite must pass without analyzer errors. If the environment cannot execute Flutter, the exact command, output, probable cause and environment/code classification are recorded rather than replaced by an unsupported success claim.

## Scope controls and deferred work

This release will not split the entire `AppDatabase`, redesign all Flutter state management, replace SQLite, or invent exhaustive exercise variants. Small extractions are permitted only when they isolate canonical registries, migration helpers or quality gates needed by v0.8.0.

If persistent PIN state or N+1 batching exposes a migration risk that cannot be covered safely by tests, the item is documented as deferred in `AUDIT_REPORT.md`; all profile isolation, equipment/location integrity, canonical filtering, template identity, encoding, dashboard display/transaction and release-version requirements remain mandatory.

## Acceptance

The release is acceptable when the required profile-isolation tests pass, active-profile changes refresh dependent data, catalog filters use canonical keys without obvious false positives, all catalog entries satisfy the final quality gate or appear as an explicit blocking exception, migrations preserve user data, current release surfaces identify v0.8.0, `flutter analyze` succeeds, and `flutter test` succeeds.
