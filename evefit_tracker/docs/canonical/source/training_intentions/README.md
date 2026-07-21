# Canonical training-intention sources

These two Markdown files are immutable documentary inputs. Do not edit,
reformat, or regenerate them manually. Version `v0.4.1` takes precedence over
`v0.4` for every corrected field, while both files remain available for the
required historic audit.

| Source | SHA-256 |
| --- | --- |
| `EveFit_Training_Intentions_Production_Registry_v0.4.md` | `d9cf51727dc28aa078b7cc55fa0f6246360e86bcba93b40fe34feac9ac7f50ad` |
| `EveFit_Training_Intentions_Production_Registry_v0.4.1.md` | `4d6f6d06f8f593f549dfd0ab132ce09f92ec760dfed11966cdd816be3506c0d8` |

Generate committed outputs with:

```powershell
dart run tool/canonical/generate_training_intentions_registry.dart generate
```

Verify them without writing with:

```powershell
dart run tool/canonical/generate_training_intentions_registry.dart check
```

The documents are audit inputs only. The application imports generated Dart
records and never parses Markdown at runtime. The generated runtime excludes
the complete v0.3 map, consolidation reasons, and executable equipment or
environment fields; the deterministic manifest retains audit evidence.
