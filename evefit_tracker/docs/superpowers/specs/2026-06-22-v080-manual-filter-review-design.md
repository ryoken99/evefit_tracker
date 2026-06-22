# v0.8.0 Manual Filter Review Design

## Objective

Correct the real UI path that selects exercises for a workout and make the manually reviewed profile/location/equipment/focus combinations the source of truth. The public version remains `0.8.0`; the corrected Android artifact uses build number `82` and replaces the APK attached to the existing `v0.8.0` release.

## Confirmed root cause

The existing complete-filter tests build exercises with `ExerciseCatalogEntry.toExercise()`. Those objects have no persisted canonical `primaryMuscleKey`. The Pixel UI reads enriched exercises from SQLite. In `ExerciseFilterService._matchesHierarchyFocus`, enriched exercises enter the canonical-muscle branch and return `false` before complete aliases such as `chest_complete`, `back_complete`, `shoulders_complete`, `core_complete`, and `legs_complete` are evaluated. `arms_complete` works because it has an explicit check before that branch.

This explains why the automated catalogue tests passed while `Musculação - Peito completo` was empty in the real application.

A second defect exists in equipment matching: the current implementation accepts an exercise when any equipment key matches. Compound requirements such as bodyweight plus bench, chair, stable step, table, pull-up bar, or parallel bars must require the support capability instead of passing on `bodyweight` alone.

## Manual review source of truth

`MANUAL_FILTER_REVIEW.md` records every reviewed combination. Each row contains an ID, profile, location, available capabilities, training type, region, group, subgroup/focus, required inclusions, required exclusions, observed result, PASS/FAIL, and the applied correction.

Rows are reviewed explicitly. Helpers may list actual results, but they do not assign PASS/FAIL. A human comparison between anatomical intent, required capabilities, expected inclusions, and forbidden exercises determines the state.

The review covers the nine requested profiles and every relevant complete and specific focus. Repeated expectations that are identical across portable-equipment profiles may share a written rationale, but each profile/focus remains a separate matrix row and test ID.

## Filtering architecture

### Complete focus resolver

A declarative resolver maps each complete focus to allowed canonical groups, subgroups, and muscle keys. It runs before individual-muscle rejection and therefore behaves identically for in-memory, migrated, and persisted exercises.

Complete focuses aggregate only their anatomical descendants. They never use `contains()` on visible labels and never include an exercise solely because the selected muscle is secondary when the matrix requires primary dominance.

### Capability resolver

Profile availability is expressed with canonical capabilities:

- base movement: `bodyweight`, `floor`, and location-appropriate `wall`;
- supports: `chair_support`, `stable_step`, `sturdy_table`, `bench` and canonical bench variants;
- strength equipment: `dumbbells`, `barbell`, `plates`, `bands`, `pullup_bar`, `parallel_bars`, cables and machines;
- location equipment: `outdoor_space` and `tatami`.

An exercise may have required capability groups. Every group must be satisfied; alternatives inside one group are OR choices. For example, an inclined push-up needs bodyweight and one stable support, while a pull-up needs a pull-up bar. Gym bench variants satisfy the generic `bench` capability.

### Availability explanations

Normal mode returns only anatomically matching exercises whose required capabilities are satisfied. “Mostrar todos” retains entries and reports one deterministic reason: anatomical mismatch or missing equipment/location capability. Empty-state text distinguishes a legitimate anatomical absence from missing capabilities.

## Persistence and compatibility

Existing exercise IDs and workout relationships are preserved. If taxonomy or capability metadata must be refreshed for installed v0.8.0 databases, a safe additive database migration/backfill is used. No user exercise, workout, set, profile, or preference is deleted.

Custom exercises without canonical metadata continue through the legacy fallback, but default catalogue entries use canonical metadata.

## Testing strategy

Every corrective test is named with its matrix ID. Tests use enriched exercises equivalent to SQLite rows, not only raw catalogue objects. The first regression test reproduces `BW-CHEST-001` and must fail before production code changes.

Test groups cover:

- complete focus aggregation for chest, arms, back, shoulders, core and legs;
- specific anatomical focuses and obvious cross-branch false positives;
- bodyweight-only and support-dependent movements;
- home portable equipment, gym, outdoor and dojo profiles;
- unavailable reasons and “Mostrar todos”;
- migration/backfill preservation where required.

The complete existing suite remains mandatory.

## Visual validation

Android validation uses a Pixel AVD if the Android emulator and system image can be installed in the configured SDK. The exact flows for home without equipment and gym are exercised and screenshots or explicit notes are recorded in `MANUAL_FILTER_REVIEW.md`.

If Android SDK installation is blocked externally, the APK is still built and the automated UI-path tests run, but the report must state that Pixel visual validation remains blocked; it must not claim visual success.

## Release procedure

After review and tests:

1. merge the hotfix branch into `main`;
2. run `flutter analyze` and the full test suite on merged `main`;
3. build `0.8.0` with build number `82`;
4. copy the artifact to `EveFit-Tracker-v0.8.0.apk`;
5. push `main`;
6. keep tag and release name `v0.8.0`;
7. upload the corrected APK to the existing release with `--clobber`;
8. verify the remote asset digest equals the local SHA-256.
