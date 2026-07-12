# EveFit v1.1.0 Foundation Release Report

Status: release candidate validated

## Release identity

- Version name: 1.1.0
- Previous version code: 1
- Version code: 2
- Previous version evidence: `aapt dump badging` on the Phase B release APK
- Source branch: `release/v1.1.0-foundation`
- Release branch base: `742cd5488794bbf87ecfbc4318abeaf2517e65e6`
- Version commit: `eef173338daf5316e69d377cb45dd0e72670c92b`
- Final main SHA: assigned after the release PR merge and recorded at publication
- Tag: `v1.1.0`, created only after final-main validation
- GitHub Release: created only after final-main validation

## Included changes

- PR #7: canonical search menu and full-app Hero correction
- PR #8: legacy runtime removal, archive and compatibility validation
- Canonical menu: 8 capabilities, 4 usage contexts, 246 nodes
- Canonical active exercises: 0
- Legacy source entries: 1762
- Legacy seed at startup: false
- Legacy entries processed at startup: 0

## Data preservation

The representative upgrade retained these counts exactly:

| Table | Before | After |
| --- | ---: | ---: |
| profiles | 1 | 1 |
| body_measurements | 1 | 1 |
| goals | 1 | 1 |
| workouts | 1 | 1 |
| workout_sets | 1 | 1 |
| workout_exercises | 1 | 1 |
| exercises | 1762 | 1762 |

- Historical workout accessible: yes
- Foreign keys valid: yes
- Destructive migration: no

## Performance

- Before runs: 181436 ms, 181530 ms, 186670 ms
- Median before: 181530 ms
- Worst before: 186670 ms
- After runs: 1538 ms, 1637 ms, 1644 ms
- Median after: 1637 ms
- Worst after: 1644 ms
- Median improvement: 99.098%

## Validation

- `flutter pub get`: passed
- `dart format --set-exit-if-changed .`: passed, 272 files, 0 changed
- `flutter analyze`: passed, no issues
- Focused tests: passed, including menu, Hero, Clean Base, migrations and version metadata
- Full suite: passed, 574 tests in 11m04s
- Full-app clean install: passed in 14 seconds
- Upgrade test: passed with all personal-data counts unchanged
- Debug build: passed
- Release build: passed
- Quality gate: pending release PR

## APK

- Candidate file: `build/app/outputs/flutter-apk/app-release.apk`
- Final asset name: `EveFit-v1.1.0-foundation-release.apk`
- Package: `com.sandro.evefittracker`
- Version name: 1.1.0
- Version code: 2
- Candidate size: 54235905 bytes
- Candidate SHA-256: `0BE313EBA7017C0A1D3D38914B2268F0725AA88ABFCA9C0BC4C8697BCFC2786E`
- Signing certificate: `C=US, O=Android, CN=Android Debug`
- Signing configuration: existing project configuration; not asserted as Play Store signing

## Scope confirmations

- New exercises: 0
- Legacy catalogue visible: no
- Legacy filters visible: no
- Legacy fallback active: no
- Dashboard redesign: no
- Automatic legacy conversion: no
- APK committed: no
- `build/` committed: no

## Remaining release actions

1. Create and merge the release PR after its quality gate passes.
2. Repeat the required validation from final `main`.
3. Build and inspect the final APK from final `main`.
4. Tag final `main` and publish the stable GitHub Release.

## Validation artifacts

- Full suite: `test_artifacts/release_v1_1_0/2026-07-12T183455Z/flutter_test_full.log`
- Full-app clean install: `test_artifacts/canonical_search_menu/full_app/2026-07-12T174608Z`
- Upgrade: `test_artifacts/legacy_runtime/upgrade/2026-07-12T174644Z`

Runtime artifacts are ignored by Git and are not part of the release commit.
