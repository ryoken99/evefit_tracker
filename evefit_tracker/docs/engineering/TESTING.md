# Testing Gates

Run the local gate from `evefit_tracker` with `dart run tool/testing/evefit_gate.dart`.

- `fast --changed <path> ...` formats and analyses changed Dart files, then runs the focused contracts. It never runs Android, builds, or the full suite.
- `pr --changed <path> ...` runs dependency resolution, complete format/analyse, focused contracts, and validates the shard manifest. Changes to the pipeline or test runner run every shard.
- `release --changed <path> ...` runs the full four-shard suite and strict catalog audit. It never publishes. Add `--enable-android`, `--enable-full-app`, `--enable-upgrade`, or `--enable-build` only to request an available local validation explicitly.

Use `--dry-run` to print the deterministic JSON plan. Supply changed paths with `--changed`, `--added`, `--deleted`, or `--renamed`; the latter two intentionally fail closed. `manifest` recursively validates the complete `test/**/*_test.dart` universe exactly once. `integration_test/**/*_test.dart` is intentionally outside these unit/widget shards; it is classified as UI/navigation and makes the PR gate require `tool/run_android_smoke.ps1`. The smoke runner itself has the same classification; other unknown scripts fail closed. `profile --input <flutter-jsonl>` accepts Flutter test-event JSONL even when dependency output precedes the JSON, and emits totals plus the ten slowest files/tests.

The exit codes are `0` pass, `1` validation failure, `2` usage, `3` environment, and `4` manifest or changed-file classification failure. Unknown, deleted, renamed, absolute, and escaping paths fail closed.

`tool/testing/test_shards.json` is versioned and uses durations from the post-optimization warm full-suite event profile. Keep paths sorted inside each shard and regenerate its balancing evidence when the test inventory materially changes.
