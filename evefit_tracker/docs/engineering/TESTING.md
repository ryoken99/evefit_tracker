# EveFit Testing Gates

Run commands from `evefit_tracker`. The gate entrypoint is:

```powershell
dart run tool/testing/evefit_gate.dart <mode>
```

On the EveFit Windows lab, use `C:\tools\flutter\bin\dart.bat` when `dart` is
not on `PATH`.

## Fast Gate

Use while implementing:

```powershell
dart run tool/testing/evefit_gate.dart fast
```

`fast` discovers committed and tracked staged/unstaged changes against
`origin/main`, formats and analyses changed Dart files, and runs changed tests
plus the canonical and gate contracts. It does not run Android, a build, or the
full suite.

Useful options:

- `--base-ref <ref>` changes the comparison base.
- `--added|--changed|--deleted|--renamed <path>` supplies changes explicitly.
- `--dry-run` prints the plan without running it.
- `--json-report <relative.json>` writes the same final JSON printed to stdout.

Untracked files are intentionally not read. New untracked work must be supplied
with `--added`. Deleted, renamed, unknown, unsafe, and unclassified paths fail
closed.

## PR Gate

Use before pushing:

```powershell
dart run tool/testing/evefit_gate.dart pr
```

It runs dependency resolution, full format and analyze, focused contracts, and
manifest validation. Pipeline or runner changes run all four shards locally.
UI, navigation, or integration changes also require the real-app Android smoke.

## Release Gate

Use before a release, never for publication:

```powershell
dart run tool/testing/evefit_gate.dart release --enable-android --enable-full-app --enable-build --enable-upgrade --baseline-apk <previous.apk>
```

The release plan includes full format/analyze, every shard, strict catalog
audit, optional Android smoke, current hierarchical full-app, release APK build,
and optional upgrade validation. Upgrade requires `--baseline-apk` and either
`--enable-build` or an existing `--current-apk`; it never accepts a stale
implicit current APK. The build runs before upgrade.

The gate does not publish, tag, merge, or change the version.

## Shards

`tool/testing/test_shards.json` declares the complete
`test/**/*_test.dart` universe exactly once across four duration-balanced
shards. Integration tests are intentionally outside this unit/widget manifest.

Validate it after adding, moving, or deleting a test file:

```powershell
dart run tool/testing/evefit_gate.dart manifest
```

Regenerate balancing evidence from a machine-readable full-suite profile:

```powershell
flutter test --machine > test_events.jsonl
dart run tool/testing/evefit_gate.dart profile --input test_events.jsonl
```

Keep paths sorted inside each shard. Update the manifest whenever the validator
reports missing, duplicate, or stale files.

## Android

The short real-app smoke uses the approved `EveFit_Test_Device` Pixel 8 Pro:

```powershell
.\tool\run_android_smoke.ps1 -ClearAppData
.\tool\run_android_smoke.ps1
```

`-ClearAppData` is explicit. The warm run preserves emulator data. The smoke
opens Dashboard, Treinos, a workout, Add Exercise, verifies all five contexts,
checks Back, and fails on Flutter/Hero exceptions.

Use the longer hierarchical flow when full-app evidence is required:

```powershell
.\tool\run_workout_exercise_selector_roots_test.ps1 -ClearAppData
```

The older `run_canonical_core_full_app_test.ps1` targets a pre-hierarchical key
and is not the current release full-app lane.

## GitHub CI

`Flutter quality gate` contains:

1. conservative change classification;
2. analyze, contracts, manifest, and strict audit jobs;
3. four parallel unit/widget shards;
4. conditional Pixel 8 Pro Android smoke;
5. the stable final `quality` aggregator.

All actions are pinned to immutable SHAs. CI always runs the complete sharded
suite for a PR. Documentation-only changes skip Android; UI, navigation,
database/startup, and release classifications require it. `cancel-in-progress`
cancels obsolete runs for the same PR.

When `quality` fails, inspect the named dependency first. A failed shard, audit,
manifest, classification, or required Android job must fail the aggregator.
Android `skipped` is valid only when classification says it is not required.

## Exit Codes

- `0`: pass
- `1`: validation failure
- `2`: invalid usage
- `3`: environment or required local asset unavailable
- `4`: policy, manifest, or change-classification failure

Runtime logs and JSON reports belong under ignored `.dart_tool` or
`test_artifacts` directories. Do not commit logs, profiles, APKs, caches, or
generated catalog-report churn.
