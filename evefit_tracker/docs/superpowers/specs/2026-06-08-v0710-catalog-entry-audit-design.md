# v0.7.10 Catalog Entry Audit Design

## Goal

Stabilize the current exercise catalog without expanding it freely. The target is the current v0.7.9 catalog: 305 total seed entries and 294 unique exercise names.

## Scope

- Generate a before snapshot from the existing seed before catalog changes.
- Audit every seed entry, not only unique names.
- Correct descriptions, equipment metadata, inferred architecture tags and filter behavior.
- Keep catalog expansion frozen. New names are allowed only if an existing ambiguous entry must be split or clarified.
- Preserve user data, profiles, workouts, goals, photos and measurements.

## Current Sources of Truth

- `lib/database/seed_data.dart`: seed entries and seed group context.
- `lib/services/exercise_catalog_detail_service.dart`: equipment, secondary groups, description, steps, mistakes and safety.
- `lib/services/training_architecture.dart`: region/group/subgroup/muscle/equipment tags and selection matching.
- `lib/services/exercise_filter_service.dart`: available exercises and contextual filters.
- `test/*`: regression suite for previous v0.5.1 through v0.7.9 behavior.

## Audit Model

Each catalog entry gets a stable report ID, `E001` to `E305`, based on the current seed iteration order. Duplicate exercise names in multiple groups still receive separate IDs because their context matters.

For each entry the audit records:

- Name clarity.
- Required and optional equipment.
- Seed group and inferred architecture tags.
- Main muscle/focus and secondary groups.
- Filter membership and complete-filter behavior.
- Description, steps, common mistakes and safety quality.
- Final status.

## Implementation Approach

Use a small Dart audit generator in `tool/catalog_audit_v0710.dart` so reports are reproducible and based on the same Dart services used by the app. The generator creates the required Markdown reports and supports count checks.

Production changes stay constrained to:

- `exercise_catalog_detail_service.dart` for description/equipment corrections.
- `training_architecture.dart` and `exercise_filter_service.dart` for tag/filter corrections.
- `seed_data.dart` only if an existing ambiguous entry must be clarified.
- version files and migration version if catalog details change.

## Testing

Add v0.7.10 tests that fail if:

- the catalog no longer has 305 entries and 294 unique names without an explicit report update;
- any entry has empty description, execution, equipment, group or primary focus;
- forbidden generic phrases appear;
- name/equipment mismatches occur;
- bodyweight is assigned to equipment-dependent exercises;
- strength, mobility, cardio and martial arts descriptions miss required teaching details;
- complete filters include external branches or miss expected child entries;
- arms complete with dumbbells includes wrong families or misses biceps, triceps, forearm, wrist and grip.

## Reporting

Required reports:

- `CATALOG_SNAPSHOT_BEFORE_v0.7.10.md`
- `CATALOG_ENTRY_AUDIT_v0.7.10.md`
- `EQUIPMENT_METADATA_AUDIT_v0.7.10.md`
- `COMPLETE_FILTER_ENTRY_AUDIT_v0.7.10.md`
- `DESCRIPTION_ENTRY_REVIEW_v0.7.10.md`

Reports must have one line per seed entry where requested and must state final counts, corrections and exceptions.

## Completion

The release is complete only after:

- all reports exist;
- tests cover all entries;
- `flutter pub get`, `flutter analyze`, `flutter test` and `flutter build apk --release` pass;
- APK exists at `build/app/outputs/flutter-apk/app-release.apk`;
- GitHub release `v0.7.10` exists with the APK attached.
