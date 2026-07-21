# Seven Usage Contexts v0.1 - Compatibility Report

## Decision

The active Canonical Core usage contexts are exactly, in order:

1. `main_training` - Treino principal
2. `warmup` - Aquecimento
3. `activation` - Ativação
4. `recovery` - Recuperação
5. `cooldown` - Retorno à calma
6. `prevention` - Prevenção e adaptação
7. `return_to_function` - Retorno à função

`main_training` is explicit and is never injected automatically. The previous combined IDs `recovery_cooldown` and `prevention_adaptation_return` are not active navigation values.

## Compatibility model

The seven contexts classify the use of a training action; they do not own capabilities, concepts, intentions, or exercises. Compatibility is represented only by typed path definitions and path-intention links:

`usage_context > capability_root > training_concept > training_intention`

Across seven contexts and forty capability-concept relations, the approved matrix contains 280 paths. Of those, 261 have compatible intention links and 19 remain explicitly incompatible with preserved reasons. Incompatible paths are never shown as available intention results.

Changing context clears capability, concept, and intention. Changing capability clears concept and intention. Changing concept clears intention. Back preserves still-valid earlier choices; Home clears the complete transient path.

## Legacy and persistence audit

The former combined IDs remain absent from active registry values and new queries. Global searches found no canonical selection columns or stored canonical IDs in profiles, goals, workouts, workout exercises, workout sets, measurements, preferences, exports, or database migrations. The feature therefore requires no schema or data migration.

Existing personal and historical data remain untouched. Legacy catalogue data stays outside active search and is neither converted nor deleted.

O histórico v0.3 foi validado integralmente, mas não é carregado no runtime nem incluído no APK como dados funcionais.

## Safety and semantics

Recovery and cooldown are separate contexts. Prevention and return to function are also separate. Return-to-function options preserve path-specific risk and clinical review and display the approved note:

`Retorno à função não substitui diagnóstico, reabilitação, critérios clínicos ou autorização de retorno ao desporto.`

The context does not imply diagnosis, treatment, rehabilitation, individual eligibility, or authorization to return to sport.

## Validation status

Completed:

- exact seven-context order and IDs;
- absence of active combined IDs;
- full 7 x 40 path matrix;
- 261 compatible and 19 incompatible paths;
- progressive 1/2/3/4 criterion controller tests;
- path-aware intention compatibility tests;
- no `exercise_ids`, `parent_id`, legacy IDs, equipment, environment, protocol, or prescription in queries;
- database version 22 unchanged and no migration diff;
- final Fast Gate passed with 113 focused tests;
- functional PR Gate passed with 678 tests across four shards plus Android smoke;
- dedicated Pixel 8 Pro full-app passed with seven contexts and no Flutter or Hero exceptions;
- v1.1.3+5 existing-install validation preserved personal data, historical joins, schema, and foreign keys.

Runtime evidence:

- clean smoke: `test_artifacts/test_ci_performance/android_smoke/2026-07-21T002637Z/`;
- full-app: `test_artifacts/workout_exercise_selector_roots/full_app/2026-07-21T001052Z/`;
- existing install: `test_artifacts/release/v1.1.4/functional_existing_install/runs/2026-07-21T001754Z/`.

The remote CI quality gate remains pending until the functional branch is pushed.

## Rollback

Revert the functional merge. No data downgrade is required because selections remain transient and no schema or persisted row changed.
