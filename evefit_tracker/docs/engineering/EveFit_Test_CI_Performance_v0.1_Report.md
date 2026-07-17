# EveFit Test & CI Performance v0.1

Status: implementation, local validation, and real Draft PR CI complete.

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

## Orchestration

The Sol orchestrator retained integration, Git, validation, and PR ownership.
Four isolated implementation agents worked in parallel from the same base:

| Agent | Model / reasoning | Isolated branch and worktree | Reserved scope |
|---|---|---|---|
| Performance A | Luna / xhigh | `agent/perf-a-near-duplicates`, `evefit-perf-a` | Exact near-duplicate audit optimization and equivalence tests |
| CI B | Terra / high | `agent/perf-b-ci`, `evefit-perf-b` | GitHub Actions decomposition and deterministic shards |
| Android C | Terra / high | `agent/perf-c-android-smoke`, `evefit-perf-c` | Real-app Android smoke and PowerShell runner |
| Gates D | Terra / high | `agent/perf-d-local-gates`, `evefit-perf-d` | Fast/PR/Release gate tooling, classifier, profiler, and tests |

The orchestrator audited every diff and accepted the implementations after
scope and test review. It rejected direct unreviewed integration, corrected
working-directory/profile assumptions in hosted Android, hardened transient
output discovery, forced Release full-app data isolation, and moved the Gradle
cache from the non-building Analyze job to Android smoke. No agent merged,
tagged, released, or changed `main`.

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

| Top file before | ms |
|---|---:|
| `v0714_template_and_hierarchy_test.dart` | 626264 |
| `catalog_axis_coverage_test.dart` | 50825 |
| `catalog_cardio_filter_contract_test.dart` | 50754 |
| `catalog_full_menu_matrix_test.dart` | 49743 |
| `catalog_recovery_filter_contract_test.dart` | 46542 |
| `v100_catalog_qa_audit_test.dart` | 36980 |
| `catalog_cardio_warmup_recovery_v099b6a_test.dart` | 34153 |
| `catalog_good_v1_category_targets_test.dart` | 31974 |
| `catalog_integrity_test.dart` | 31846 |
| `catalog_entry_quality_evidence_test.dart` | 31791 |

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

| Top file after | ms |
|---|---:|
| `catalog_cardio_filter_contract_test.dart` | 48644 |
| `catalog_axis_coverage_test.dart` | 48563 |
| `catalog_full_menu_matrix_test.dart` | 45279 |
| `catalog_recovery_filter_contract_test.dart` | 42736 |
| `v100_catalog_qa_audit_test.dart` | 36865 |
| `catalog_cardio_warmup_recovery_v099b6a_test.dart` | 33655 |
| `catalog_activation_quality_v099b4a_test.dart` | 31929 |
| `catalog_entry_quality_evidence_test.dart` | 31650 |
| `catalog_integrity_test.dart` | 30818 |
| `v100_beginner_content_test.dart` | 30038 |

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

Real Draft PR: [#15](https://github.com/ryoken99/evefit_tracker/pull/15).
The implementation head remained mergeable and the PR remained Draft.

| Run | Head | Result | Duration | Evidence / action |
|---|---|---|---:|---|
| `29589282491` | `71ccd9d` | fail | 264 s | Hosted SDK lacked the requested `pixel_8_pro` AVD profile |
| `29589865285` | `0783443` | fail | 247 s | Android action executed outside the Flutter project |
| `29590199572` | `439d92d` | pass | 498 s | First complete green pipeline; 44.5% reduction was below the requested minimum |
| `29590973541` attempt 1 | `7f52366` | pass | 481 s | AVD cache fill; 46.4% reduction |
| `29590973541` attempt 2 | `7f52366` | pass | 492 s | AVD cache hit; 45.2% reduction |
| `29592516457` | `0cc17b6` | pass | 429 s | Proved Gradle setup was read-only by default on the PR |
| `29593117295` attempt 1 | `62babf2` | pass | 537 s | Writable Gradle cache fill, including post-job cache upload |
| `29593117295` attempt 2 | `62babf2` | pass | **392 s** | Flutter, Pub, AVD, and Gradle cache hits; final warm measurement |
| `29601299128` | `24e6a00` | fail | 400 s | Onboarding finder disappeared after a pump; no product exception |

Compared with the 898 s baseline, final warm CI removes **506 s (56.3%)**.
Every required check passed: classifier, Analyze, contracts, manifest, strict
audit, four shards, real Android smoke, and the stable `quality` aggregator.
The final documentation-only head is validated by the PR after this report is
committed; this avoids a circular report commit solely to record its own run.
The final hardening re-evaluates the Android tap finder after each pump and
fails closed if the target cannot be made visible. It adds no retry or timeout.
The runner also bounds cleanup of the `adb logcat` process to prevent a passed
smoke test from hanging while redirected log streams are being closed.

## Android, GPU, And Gradle

The new real-app smoke creates/reuses a profile, opens Dashboard and Treinos,
creates a workout, opens Add Exercise, verifies exactly five contexts, checks
Back, and captures Flutter/Hero errors. All waits are bounded and observable.

Measured local mission-branch runs:

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

Gradle daemon 9.1.0 was active locally. Hosted Android uses the immutable
`gradle/actions/setup-gradle` action with PR-scoped writable cache state. The
first writable run saved dependencies, transforms, generated jars, wrapper,
and Gradle User Home entries. The exact-head warm run restored them and reduced
`assembleDebug` from 260.5-280.8 s to **129.1 s**. No configuration cache,
memory, Android SDK, signing, Gradle project setting, or build semantics changed.

## Results After

- Final monolithic suite before the last runner hardening: **630/630 pass**,
  approximately 134 s, 0 skipped
- Final complete four-shard PR Gate: **632/632 pass**, 198.815 s including
  dependency resolution, format, analyze, manifest, and Android smoke
- Baseline median: 724.542 s
- Absolute reduction: approximately **590.5 s**
- Comparable local critical-path reduction: approximately **81.5%**
- Required minimum: 45%
- Baseline CI median: 898 s
- Final warm CI: 392 s
- Comparable CI critical-path reduction: **56.3%**
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
| Tests | 603 | 632 |
| `expect`/`expectLater` calls | 2021 | 2127 |
| Skip markers | 0 | 0 |
| Retry markers | 0 | 0 |
| Timeout markers | 3 | 4 |

No test, assertion, or coverage path was removed. The one added timeout marker
is the bounded two-minute initial-state wait in the Android smoke, not an
increased existing timeout. No retry, sleep, ignored error, or optional required
shard was introduced.

The final local Android smoke completed in 27.769 seconds with exit code 0,
created the test profile, found all five contexts, opened the real selector,
and returned to the workout. The bounded logcat cleanup then exited normally.

## Files And Product Safety

Changed areas are limited to the PR workflow, test-only near-duplicate audit,
test tooling/tests/manifest, Android test/runner, and engineering documentation.
Production `lib/`, schema, migrations, version, Dashboard, personal data,
canonical content, tags, releases, and main remain unchanged.

Generated catalog-report churn from strict local audit is restored before each
scope review and is not committed. Runtime logs, profiles, APKs, builds, caches,
and private AVD configuration remain ignored.

## Risks And Limitations

- Hosted runner and 2.7 GB AVD-cache transfer times remain externally variable.
- `actions/checkout` v4 emits GitHub's Node 20 compatibility warning while the
  hosted runner forces Node 24; the pinned action still completes successfully.
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
