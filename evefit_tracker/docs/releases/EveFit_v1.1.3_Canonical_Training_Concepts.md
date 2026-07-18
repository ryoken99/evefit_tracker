# EveFit v1.1.3 - Canonical Training Concepts

## Release scope

EveFit v1.1.3 defines a canonical training-concept layer over the existing hierarchical search flow. The approved inventory is five contexts, eight capabilities, 35 globally unique concepts and 40 ordered capability-concept relations.

The canonical flow is:

`Contexto → Capacidade → Conceito → estado vazio de Intenção`

This release has zero training intentions, zero official attributes, zero exercises and zero sublevels. Selecting a concept must not show exercises, protocols, prescriptions or legacy results.

## Compatibility model

Concepts are global entities. A capability is associated with concepts through ordered compatibility relations; it does not own them or create copies or subtrees. The same ID, name and definition are reused wherever a concept is compatible.

The 40 ordered relations are:

| Capability | Ordered concept IDs | Total |
| --- | --- | ---: |
| `muscular_capacity` | `overcome_resistance`, `control_resistance`, `sustain_resistance`, `loaded_carry` | 4 |
| `cardio_conditioning` | `cyclic_locomotion`, `cyclic_propulsion`, `repetitive_rhythmic_movement`, `repeated_multidirectional_displacement`, `repeated_motor_sequence` | 5 |
| `speed_power` | `explosive_acceleration`, `ballistic_projection`, `elastic_reactive_action`, `braking_redirection`, `cyclic_locomotion`, `repeated_multidirectional_displacement` | 6 |
| `mobility` | `active_joint_exploration`, `range_transition`, `integrated_chain_mobility`, `supported_loaded_mobility`, `segmental_dissociation` | 5 |
| `flexibility` | `sustained_lengthening`, `dynamic_lengthening`, `assisted_lengthening` | 3 |
| `motor_control_coordination` | `postural_stabilization`, `base_of_support_control`, `rhythm_synchronization`, `reactive_adjustment`, `segmental_dissociation`, `repeated_motor_sequence` | 6 |
| `technique_skill` | `isolated_technical_practice`, `contextual_technical_application`, `target_oriented_precision`, `stimulus_response_decision`, `technical_variability_adaptation`, `repeated_motor_sequence` | 6 |
| `breathing_regulation` | `voluntary_breath_cycle_control`, `breath_movement_synchronization`, `internal_pressure_management`, `autonomic_modulation`, `interoceptive_monitoring_adjustment` | 5 |

Reused entities are `repeated_motor_sequence`, `segmental_dissociation`, `cyclic_locomotion` and `repeated_multidirectional_displacement`. The complete ID/name/definition catalogue is in [`Training_Concepts_v0.1_Implementation_Report.md`](../canonical/Training_Concepts_v0.1_Implementation_Report.md).

## Preservation and boundaries

- Schema and migrations: unchanged.
- Personal data and histories: must remain preserved.
- Legacy catalogue and old tree: outside runtime and invisible.
- Package: `com.sandro.evefittracker`.
- Declared Flutter version: `1.1.3+5`.

No operational result is asserted here. PR status, merge SHA, final branch SHA, tag, release URL, APK path, size, SHA-256, signature, Android smoke, upgrade, CI and timing evidence are **PENDING DO SOL**.
