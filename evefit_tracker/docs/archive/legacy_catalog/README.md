# EveFit legacy catalogue archive

This directory records the exercise catalogue removed from the EveFit runtime
for v1.1.0. The original source is preserved by Git at commit
`1078f3e1176c2432701c7a4d702bb5d80e39645d`; the manifest lists exact paths,
sizes and SHA-256 checksums so each file can be recovered without duplicating
more than 800 KB of generated Dart data in the current tree.

The material is historical. It is not loaded, parsed, validated, transformed
or inserted by the app. It is not a source of truth for the canonical model and
must not be reactivated without an explicit product decision and a new data
review. It is not automatically compatible with canonical exercise signatures.

Exercises will be rebuilt in small validated batches. Protocols such as HIIT,
Tabata, EMOM and AMRAP are not exercises. Canonical filters contain structured
conditions and never own lists of exercise IDs. No legacy content was converted
automatically as part of the runtime removal.

## Recovery

Recover a file without changing the working tree:

```powershell
git show 1078f3e1176c2432701c7a4d702bb5d80e39645d:evefit_tracker/<path>
```

The database schema and local historical rows are intentionally not archived or
deleted. Existing rows referenced by workouts remain in each user's database so
historical joins and foreign keys continue to work.
