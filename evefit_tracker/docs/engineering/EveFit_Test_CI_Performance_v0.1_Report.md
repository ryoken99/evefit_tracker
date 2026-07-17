# EveFit Test & CI Performance v0.1

Status: implementation and local validation complete; real Draft PR CI pending.

## Authority And Scope

- Order source branch: `origin/Velocidade`
- Order source SHA: `b763bd69218b155b7e49530df0e1f494b4089f90`
- Order file: `EveFit_Test_CI_Performance_v0.1_Codex_Order-3.txt`
- Order SHA-256: `E23E4EEE9A6A3EA9D8862F14B394CAD5A60ECAB66D5300834464C8A0CE2C9CCF`
- Implementation branch: `perf/test-ci-pipeline-v0.1`
- Base SHA: `b8ebbbb67b625dc8f0e99b804697faa882f2dc51`
- App version: `1.1.2+4` (unchanged)

No product behavior, schema, migration, canonical data, Dashboard, profile,
goals, measurements, historical data, version, tag, or release is changed.

## Environment

- OS: Windows 11 Home `10.0.26200`
- CPU: Intel Core i9-12900, 16 cores / 24 logical processors
- RAM: 32 GB
- GPU: NVIDIA GeForce RTX 3080 Ti
- Flutter: 3.44.4 stable
- Dart: 3.12.2
- Java: 17.0.19
- Gradle: 9.1.0, daemon enabled
- AVD: `EveFit_Test_Device`, Google Pixel 8 Pro
- Android: API 36, Google APIs, x86_64
- AVD resources: 4 cores, 2 GB RAM, 6 GB storage
- Hypervisor: WHPX available and usable
- Runtime renderer: Android Emulator OpenGL ES Translator on RTX 3080 Ti

CPU peak, per-command process count, and reliable peak RAM were not available
from the existing runners and are not estimated.

## Methodology

Cold local means a fresh process and clean checkout/project artifacts while
preserving global SDK, Pub, Flutter, and Gradle caches. Warm local means the same
commit and machine, resolved dependencies, no `flutter clean`, and immediate
repetition. Cold/warm CI is determined only from cache evidence in the Actions
logs. Queue time is separated from execution time.

The immutable baseline worktree is
`C:\Users\utilizador\Documents\evefit-test-ci-baseline` at the base SHA. Runtime
evidence is stored under ignored `test_artifacts/test_ci_performance` paths.

## Architecture Before

The PR workflow had one Ubuntu job: checkout, Flutter setup, Pub get, analyze,
the complete suite sequentially, then strict catalog audit. Local validation had
no risk classifier, shard manifest, reproducible profiler, or short Android
smoke. The full suite was dominated by one all-pairs near-duplicate audit.

## Baseline Local

| Command | Cold | Warm | Result |
|---|---:|---:|---|
| `flutter pub get` | 4.528 s | 1.386 s median | pass |
| `dart format --set-exit-if-changed .` | 3.071 s | 1.066 s median | pass |
| `flutter analyze` | 48.162 s | 4.402 s median | pass |
| Complete suite | 716.256 s | 732.828 s | 603 pass |
| Strict catalog audit | 27.306 s | not repeated | pass |
| Database/migration focus | 12.255 s | not repeated | 10 pass |
| Widget focus | 4.880 s | not repeated | 28 pass |
| Hierarchical full-app | 34.5 s | not repeated | pass |
| Debug build | 27.714 s | 6.950 s repeat | pass |

Baseline complete-suite median: **724.542 s**.

The obsolete canonical-core full-app runner failed in the baseline because it
expects `canonical_core_root_screen`, which was superseded before this mission.
The approved hierarchical full-app runner passed and is used by the Release
Gate. No old test was deleted.

## Baseline GitHub CI

Five comparable successful PR runs took 898, 1017, 829, 1058, and 839 seconds;
median **898 s**. The latest baseline run was
[`29494726581`](https://github.com/ryoken99/evefit_tracker/actions/runs/29494726581).

Latest-run steps:

- Flutter setup: 58 s
- Pub get: 7 s
- Analyze: 9 s
- Complete tests: 778 s
- Strict audit: 35 s
- Queue: approximately 2-3 s
- Total: 898 s

The complete test step was the critical path.

## Profiler And Root Cause

`flutter test --machine` is parsed by the versioned profiler, including UTF-16
PowerShell output. The dominant test was:

`v0714_template_and_hierarchy_test.dart :: different catalog descriptions are not near-duplicates`

- Before: 619.552 s
- After: 14.139 s
- Reduction: **97.72%**

The previous implementation evaluated every catalog pair and repeatedly
normalized text and ran word LCS. The replacement indexes exact contiguous
40-token windows, precomputes normalized values, and invokes the unchanged
exact scorer only for mathematically possible candidates. Candidate pairs are
sorted back into original deterministic order.

Equivalence tests compare the reference and optimized implementations for empty,
single, duplicate-key, exact duplicate, near-duplicate, Unicode/accent,
normalization, below/exact/above-window, unrelated, input-order, and offender
ordering cases. No approximation or sampling is used.

## Top 10 Before

| Test | ms |
|---|---:|
| Near-duplicate catalog descriptions | 619552 |
| Structured quality gates have zero critical failures | 35491 |
| GOOD_V1 category totals | 31209 |
| Catalog identity and complete fields | 31024 |
| Catalog entry evidence coverage | 29430 |
| Execution instruction completeness | 29101 |
| Beginner teaching fields | 29037 |
| Strict quality gate | 28889 |
| Activation target audit | 28803 |
| GOOD_V1 content quality | 28367 |

The top file was `test/v0714_template_and_hierarchy_test.dart` at 626264 ms.

## Top 10 After

| Test | ms |
|---|---:|
| Structured quality gates have zero critical failures | 35229 |
| Catalog identity and complete fields | 29984 |
| Activation target audit | 29400 |
| Beginner teaching fields | 29134 |
| Catalog entry evidence coverage | 28986 |
| Execution instruction completeness | 28573 |
| GOOD_V1 category totals | 27435 |
| Karate quality audit | 26976 |
| Visible content quality | 26932 |
| Template language audit | 26737 |

The slowest final file is
`test/catalog/catalog_cardio_filter_contract_test.dart` at 48644 ms. No single
test now monopolizes the suite.

## Concurrency

| Workers | Duration | Result |
|---:|---:|---|
| 1 | 660.596 s | 605 pass |
| 2 | 360.817 s | 605 pass |
| 4 | 189.705 s | 605 pass |
| 4 repeat | 198.996 s | 605 pass |
| 8 | 157.829 s | 629 pass |
| 8 repeat | 158.552 s | 629 pass |

Eight workers are the explicit stable recommendation for this 24-thread local
machine. Gates and CI retain runner-adaptive defaults rather than imposing eight
workers on smaller hosted runners. No SQLite, file, port, or orphan-process
conflict appeared.

## Deterministic Shards

`tool/testing/test_shards.json` covers all 157 unit/widget test files exactly
once across four duration-balanced shards. Integration tests are a separate
Android lane. Manifest validation fails for missing, duplicate, stale, invalid,
or unsorted paths.

Final warm PR Gate shard durations were 57.085, 35.558, 34.147, and 33.125
seconds on the first run, then 53.232, 35.749, 34.698, and 33.471 seconds on
the repeat. Both runs reused the same Android/build outputs and passed manifest
validation, proving generated files outside `test/` cannot enter the declared
test universe. Hosted shard timings are recorded separately by the Draft PR.

## Local Gates

- Fast Gate: changed-file discovery, changed Dart format/analyze, related tests,
  and canonical/gate contracts; no Android or build.
- PR Gate: full format/analyze, focused contracts, manifest; all shards for
  pipeline/test-runner changes and Android for UI/navigation/integration.
- Release Gate: maximum local suite, strict audit, optional Android, current
  hierarchical full-app, release build, and explicit baseline/current upgrade.

Release full-app validation always passes `-ClearAppData`. This isolates it
from the preceding smoke, which intentionally creates or reuses a profile. A
regression test verifies the composed command. Before this correction, the
first Release Gate attempt passed every Dart check, the audit, and smoke, then
waited for onboarding against the smoke profile and failed closed after 198.924
seconds. The isolated full-app rerun and the complete Release Gate both passed.

The classifier is deterministic and conservative. Production code cannot avoid
the sharded CI suite. Unknown, deleted, renamed, unsafe, and out-of-scope paths
fail closed. JSON plans, command durations, logs, results, and exit codes are
machine-readable.

## GitHub Actions

The workflow retains `Flutter quality gate` and the stable final check `quality`.
It now contains classification, analyze, contracts, manifest, strict audit, a
four-shard matrix, conditional Pixel 8 Pro Android smoke, and an `always()`
aggregator. A failed required dependency fails `quality`; Android `skipped` is
accepted only when classification does not require it.

Actions are pinned to immutable SHAs. Permissions are `contents: read`.
Flutter/Pub caching uses the supported Flutter setup action. Concurrency is
grouped per PR/ref with `cancel-in-progress: true`. The full suite is not rerun
sequentially after the shards.

Real Draft PR cold/warm timings and final check results: **PENDING_REAL_PR**.

## Android, GPU, And Gradle

The new real-app smoke creates/reuses a profile, opens Dashboard and Treinos,
creates a workout, opens Add Exercise, verifies exactly five contexts, checks
Back, and captures Flutter/Hero errors. All waits are bounded and observable.

Measured mission-branch runs:

- Clean data: 25.722 s
- Warm profile: 21.220 s
- PR Gate warm: 22.405 s
- Final PR Gate warm repeats: 21.362 / 21.334 s
- Final Release Gate smoke: 22.490 s
- Agent clean/warm evidence: 29.738 / 25.304 s

The final isolated and Release Gate full-app runs passed in 34.550 and 34.636
seconds. The emulator reports WHPX usable and a host OpenGL ES translator on
RTX 3080 Ti, so it is not software-rendering; no private AVD configuration
change was justified or retained.

Gradle daemon 9.1.0 was active. Debug builds passed. No aggressive Gradle,
configuration-cache, memory, Android SDK, signing, or project setting was
changed because the measured critical path was the test audit, not Gradle.

## Results After

- Final complete suite: **629/629 pass**, 141.185 s, 0 skipped
- Baseline median: 724.542 s
- Absolute reduction: **583.357 s**
- Comparable local critical-path reduction: **80.5%**
- Required minimum: 45%
- Fast Gate final: 18.523 s internal / 19.316 s wall, pass
- PR Gate final warm: 188.751 / 187.620 s internal, both pass
- PR Gate final warm wall median: 190.050 s
- Release Gate final: 352.203 s internal / 354.818 s wall, pass
- Strict audit in Release Gate: 24.899 s, pass
- Release build in Release Gate: 52.897 s, pass
- Upgrade in Release Gate: 50.532 s, pass
- Database/migration focus: 5.773 s, 10 pass
- Widget focus: 5.034 s, 28 pass
- Debug builds: pass
- Release build: pass
- Analyze: pass, no issues (8.1 s analyzer time)

## Quality Audit

| Measure | Before | After |
|---|---:|---:|
| Unit/widget test files | 151 | 157 |
| Integration test files | 6 | 7 |
| Tests | 603 | 629 |
| `expect`/`expectLater` calls | 2021 | 2079 |
| Skip markers | 0 | 0 |
| Retry markers | 0 | 0 |
| Timeout markers | 3 | 4 |

No test, assertion, or coverage path was removed. The one added timeout marker
is the bounded two-minute initial-state wait in the Android smoke, not an
increased existing timeout. No retry, sleep, ignored error, or optional required
shard was introduced.

## Files And Product Safety

Changed areas are limited to the PR workflow, test-only near-duplicate audit,
test tooling/tests/manifest, Android test/runner, and engineering documentation.
Production `lib/`, schema, migrations, version, Dashboard, personal data,
canonical content, tags, releases, and main remain unchanged.

Generated catalog-report churn from strict local audit is restored before each
scope review and is not committed. Runtime logs, profiles, APKs, builds, caches,
and private AVD configuration remain ignored.

## Risks And Limitations

- Hosted Android cold-start time is external and must be confirmed in real CI.
- Deleted/renamed/unclassified changes intentionally require an explicit gate
  decision instead of guessing.
- Untracked additions require explicit `--added` so protected local untracked
  files are never read or silently included.
- Historical profile weights should be regenerated after material suite growth.
- The obsolete canonical-core full-app runner remains for history but is not the
  current hierarchical release lane.

## Rollback

Revert the commits on `perf/test-ci-pipeline-v0.1`. The old workflow and test
algorithm are restored without schema, migration, data, version, tag, or release
changes. Local test artefacts and worktrees can be removed independently after
review. No destructive data rollback is required.

## Future Work

- Rebalance shards when CI history provides stable per-shard hosted timings.
- Consider a versioned audit output mode that writes only under `build/reports`
  to avoid local generated-doc churn.
- Re-evaluate Android image caching only with measured, reproducible gains.
- Keep `quality` stable if branch protection is enabled in the future.
