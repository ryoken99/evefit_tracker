# Testing Gates

Run the local gate from `evefit_tracker` with `dart run tool/testing/evefit_gate.dart`.

- `fast` discovers changes from `origin/main` by default, formats and analyses changed Dart files, then runs the focused contracts. Use `--base-ref <ref>` to select another base. It never runs Android, builds, or the full suite.
- `pr --changed <path> ...` runs dependency resolution, complete format/analyse, focused contracts, and validates the shard manifest. Changes to the pipeline or test runner run every shard.
- `release --changed <path> ...` runs the full four-shard suite and strict catalog audit. It never publishes. Add `--enable-android`, `--enable-full-app`, `--enable-upgrade`, or `--enable-build` only to request an available local validation explicitly. Full-app uses `tool/run_workout_exercise_selector_roots_test.ps1`. Upgrade requires `--baseline-apk <local.apk>` plus either `--enable-build` or an existing `--current-apk <local.apk>`; it never accepts an implicit stale current APK. When build and upgrade are both enabled, the build runs first and an omitted current APK resolves to `build/app/outputs/flutter-apk/app-release.apk`.

Without explicit change flags the gate runs `git diff --name-status --find-renames -z <base-ref>`, covering committed plus tracked staged/unstaged changes. It preserves Git statuses, removes the `evefit_tracker/` prefix when Git is rooted at the parent directory, and permits only repository-level `.github/**` and `README*`; other parent paths fail closed. Untracked files are intentionally not discovered and require explicit `--added <path>`. Supply `--changed`, `--added`, `--deleted`, or `--renamed` to override discovery, as CI does; deleted, renamed, unknown, invalid-ref, unavailable-Git, and empty-diff cases fail closed.

Use `--dry-run` to print the deterministic JSON plan and `--json-report <relative.json>` to write the same final JSON to a safe repository-local path. The manifest declares and recursively validates the complete `test/**/*_test.dart` universe exactly once. `integration_test/**/*_test.dart` is intentionally outside these unit/widget shards; it is classified as UI/navigation and makes the PR gate require `tool/run_android_smoke.ps1`. The smoke runner itself has the same classification; other unknown scripts fail closed. `profile --input <flutter-jsonl>` accepts Flutter test-event JSONL even when dependency output precedes the JSON, and emits totals plus the ten slowest files/tests.

The exit codes are `0` pass, `1` validation failure, `2` usage, `3` environment, and `4` manifest or changed-file classification failure. Unknown, deleted, renamed, absolute, and escaping paths fail closed.

`tool/testing/test_shards.json` is versioned and uses durations from the post-optimization warm full-suite event profile. Keep paths sorted inside each shard and regenerate its balancing evidence when the test inventory materially changes.
