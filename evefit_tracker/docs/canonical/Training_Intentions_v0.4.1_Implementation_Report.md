# Training Intentions v0.4.1 - Implementation Report

## Scope and provenance

- Base SHA: `62705d997fde945b5dbd5aa9b48c37ac0b2b8ba9`
- Functional branch: `feature/seven-context-training-intentions-v0.1`
- Runtime registry version: `0.4.1`
- Generator version: `1.0.0`
- v0.4 SHA-256: `d9cf51727dc28aa078b7cc55fa0f6246360e86bcba93b40fe34feac9ac7f50ad`
- v0.4.1 SHA-256: `4d6f6d06f8f593f549dfd0ab132ce09f92ec760dfed11966cdd816be3506c0d8`
- Precedence: v0.4.1 overrides corrected v0.4 fields; both immutable sources remain available for audit.

The source hashes are validated against raw Git blob bytes. The Windows working-tree LF-to-CRLF conversion incident did not change the approved Git blobs. Local `.gitattributes` rules preserve the source bytes across platforms.

## Architecture

The existing Canonical Core was synchronous and code-backed. The implementation keeps that contract by generating typed Dart from the approved Markdown sources before runtime. The app imports generated Dart only; it does not read Markdown, use the network, or rebuild the registry while rendering.

The generator supports `generate`, `check`, and `report`. It fails closed on malformed tables, ambiguous rows, unknown IDs, changed columns, count drift, broken historical mappings, and non-deterministic output. Generated files contain runtime definitions, paths, links, and minimal provenance. Complete historical mapping and decision records remain documentary audit data.

Runtime indexes are built once and exposed as immutable collections:

- definition by intention ID;
- path by typed key and contract ID;
- links and resolved options by exact path;
- compatible paths by intention;
- compatible concepts by context and capability.

Lookups are O(1) or O(k) over the final result list. The 771 links are not scanned per frame.

## Closed inventory

| Contract | Count |
| --- | ---: |
| Active usage contexts | 7 |
| Capability roots | 8 |
| Training concepts | 35 |
| Capability-concept relations | 40 |
| Paths | 280 |
| Compatible paths | 261 |
| Incompatible paths | 19 |
| Global intentions | 591 |
| Path-intention links | 771 |
| Historical v0.3 IDs | 693 |
| Historical v0.3 occurrences | 792 |
| Contextual labels | 59 |
| Official attributes | 0 |
| Canonical exercises | 0 |
| Sublevels | 0 |

The generated manifest records the exact distributions by intention type, operational risk, clinical review, path role, horizon, and evidence basis. Runtime validation enforces those distributions and the complete 280-path matrix.

## Runtime model

Each final intention has a global typed definition. Compatibility is occurrence-based: a `CanonicalPathIntentionLink` joins one global intention to one exact Context > Capability > Concept path and carries role, display order, contextual label, risk modifier, and clinical review modifier. Aggregated declaration fields never replace the path link as the compatibility source of truth.

Risk and clinical review remain separate. A path can preserve or increase operational risk and can require clinical review; it cannot reduce either state. Equipment, environment, prescription, protocols, `parent_id`, `exercise_ids`, legacy IDs, and historical aliases are absent from executable intention identity and query contracts.

The progressive query after explicit intention confirmation contains exactly:

1. `usage_context`
2. `capability_root`
3. `training_concept`
4. `training_intention`

An intention is not universal merely because its global ID exists. The validator requires a real compatible link for the selected path.

## User interface

The workout selector now completes the fourth step with real path-resolved intentions. It groups primary, alternative, complementary, conditional, and hidden advanced occurrences without projecting global aggregate roles onto a path. Selection is explicit: opening the detail does not change the query; only `Selecionar esta intenção` advances to the empty exercise result.

The detail presents the actual PT-PT context, capability, concept, definition, effective risk, and review status. High-risk, clinically restricted, clinical review, and return-to-function messages use the approved cautious copy. Hidden advanced options remain collapsed until requested. Lists are scrollable and use stable `ValueKey` values.

The result remains intentionally empty:

`Ainda não existem exercícios aprovados para este percurso.`

`Os exercícios compatíveis serão adicionados e validados progressivamente.`

The generic `Por intenção` flow is completed separately in the same functional branch. It lists the 591 global intentions using a virtualized deterministic list, then requires selection of a real compatible path before producing the four-criterion query.

## Historical audit and persistence

O histórico v0.3 foi validado integralmente, mas não é carregado no runtime nem incluído no APK como dados funcionais.

The generator validates all 693 historical IDs and all 792 historical occurrences against the approved v0.4/v0.4.1 sources. Consolidation and rename reasons and the decision ledger remain in immutable source documents and the deterministic audit manifest.

Repository inspection found canonical context, capability, concept, and intention selections to be transient UI state. The database remains at schema/user version 22. No table, migration, personal row, workout history, measurement, goal, profile, preference, photo, or legacy archive is modified by this feature.

## Validation status

Completed on the functional branch:

- raw Git blob SHA-256 gate;
- deterministic generator `report` and `check`;
- exact closed counts and historical mapping validation;
- generator tamper, malformed-input, Unicode, and round-trip tests;
- registry, matrix, provider, controller, query, and widget focused tests;
- Fast Gate on coherent implementation batches;
- baseline Pixel 8 Pro full-app run from the authorized base.

Still to be recorded before functional integration:

- final Fast Gate and PR Gate on the complete functional diff;
- updated Android smoke and full-app flow;
- existing-install validation over the v1.1.3 baseline;
- startup and selector-open performance before/after;
- CI quality gate and final PR head.

No pending result is reported as passed before its command completes.

## Performance

The baseline Pixel 8 Pro AVD run recorded selector transitions of 129 ms to open, 127 ms from context to capability, and 108 ms from capability to concepts. The final implementation will be measured with the same environment and procedure. The 591-item global list is virtualized, generated data is memory-backed, and path indexes avoid repeated link scans. Any reproducible regression above 25% remains a blocker for investigation. The additional user performance gate is evaluated from real before/after measurements and is not inferred from architecture alone.

## Limitations, risks, and rollback

- There are no canonical exercises, so every completed path intentionally ends empty.
- Eligibility and clinical decisions are not implemented; warnings are informational safeguards only.
- The generated registry is large, so APK size and selector timing must be measured before release.
- Source documents are immutable inputs and must not be edited to fix generated output.

Rollback is a normal revert of the functional merge. The database and personal data need no downgrade because this feature adds no persistence or migration. Immutable sources and generated audit evidence may remain in Git history without affecting runtime data.
