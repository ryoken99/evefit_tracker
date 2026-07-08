# EveFit v1.0.0 RC audit

## Scope

- Branch: `release-v100-rc`
- Version: `1.0.0-rc.1`
- Phase: release candidate freeze
- Catalog changes in this phase: none
- Pixel manual test: pending, documented in `v100_rc_pixel_test.md`

## Catalog totals

| Metric | Value |
| --- | ---: |
| Catalog entries | 1762 |
| Unique canonical IDs | 1725 |
| Critical issues | 0 |
| Warnings | 0 |
| Wrong-results | 0 |
| Unreachable exercises | 0 |
| D/E quality findings | 0 |
| Tracked APKs | 0 |

## Primary type totals

| Primary type | Total |
| --- | ---: |
| musculacao | 400 |
| cardio | 100 |
| artes_marciais | 360 |
| mobilidade | 230 |
| elasticidade | 170 |
| recuperacao | 147 |
| aquecimento | 150 |
| ativacao | 110 |
| prevencao | 95 |

## Menu matrix

| Status | Total |
| --- | ---: |
| OK_WITH_RESULTS | 756 |
| OK_WITH_FALLBACK | 3 |
| OK_EMPTY_WITH_EXPLICIT_NOTICE | 1026 |
| FAIL_EMPTY_SILENT | 0 |
| FAIL_WRONG_RESULTS | 0 |
| FAIL_INCOMPATIBLE_MENU | 0 |
| FAIL_UNREACHABLE_CONTENT | 0 |
| FAIL_AXIS_WITHOUT_COVERAGE | 0 |

## Axis coverage

| Status | Total |
| --- | ---: |
| OK_WITH_RESULTS | 172 |
| OK_EMPTY_WITH_EXPLICIT_NOTICE | 35 |
| FAIL_AXIS_WITHOUT_COVERAGE | 0 |

## Validation evidence

| Command | Result |
| --- | --- |
| `flutter clean` | passed |
| `flutter pub get` | passed |
| `dart format --set-exit-if-changed .` | passed after formatting `lib/screens/settings_screen.dart` |
| `flutter analyze` | passed, no issues found |
| `flutter test -r compact` | passed, 535 tests |
| `dart run tool/catalog_audit_report.dart --strict` | passed, 1762 entries, 0 critical, 0 warnings |
| `flutter build apk --debug` | passed |
| `flutter build apk --release` | passed, 54.6 MB |

## Release candidate decision

The release candidate is technically validated, but final v1.0.0 is blocked until the manual Pixel checklist is executed and approved.
