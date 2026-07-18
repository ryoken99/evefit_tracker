# Training Concepts v0.1 - Implementation Report

## Scope and provenance

- Product: EveFit v1.1.3 - Canonical Training Concepts.
- Base SHA: `6a7dc2e579c927f24c3f04801b86b710d973eb30`.
- Branch: `release/v1.1.3-canonical-training-concepts`.
- Scope: canonical registry, ordered compatibility, hierarchical selector, validation, release metadata and documentation.

The target below is copied from the approved v1.1.3 mission. It is the canonical contract for the implementation agents and Sol's final audit, not fabricated execution evidence.

## Required inventory

| Item | Required value |
| --- | ---: |
| Active contexts | 5 |
| Active capabilities | 8 |
| Global unique concepts | 35 |
| Capability-concept relations | 40 |
| Training intentions | 0 |
| Official attributes | 0 |
| Exercises | 0 |
| Sublevels | 0 |
| Schema changes | 0 |
| Migrations | 0 |

## Reused architecture

The implementation must reuse the existing canonical-core boundaries:

- `CanonicalRegistry` for typed definitions and ordering.
- `CanonicalPillarDefinition` and the existing canonical axis model for IDs, names, definitions, status and schema version.
- `CanonicalSelectionCompatibilityProvider` for context-to-capability and capability-to-concept compatibility.
- `CanonicalExerciseSelectionPath` for the selected context, capability and concept.
- `CanonicalSearchQuery` for typed progressive criteria.
- `HierarchicalCanonicalSearchController` for selection, reset, Back and Home.
- Existing selector widgets, breadcrumbs, empty states and Material icon resolver.
- Existing PR15 Fast Gate, PR Gate, four-shard manifest, Android smoke and Release Gate tooling.

No parallel registry, database persistence, migration, schema extension, legacy fallback or exercise result repository is part of this release.

## Global concepts

Each row is one global entity. A relation may reuse the same ID; it must not duplicate the entity.

### Muscular capacity

| ID | Name | Definition |
| --- | --- | --- |
| `overcome_resistance` | Vencer resistência | Produzir força suficiente para deslocar o corpo, uma carga ou um implemento contra uma resistência. |
| `control_resistance` | Controlar resistência | Regular, desacelerar ou travar o movimento enquanto uma resistência atua. |
| `sustain_resistance` | Sustentar resistência | Manter uma posição, carga ou tensão contra uma força, sem deslocamento relevante. |
| `loaded_carry` | Transportar carga | Deslocar o corpo enquanto se suporta e controla uma carga. |

### Cardio and conditioning

| ID | Name | Definition |
| --- | --- | --- |
| `cyclic_locomotion` | Locomoção cíclica | Deslocar o corpo através da repetição regular de um padrão locomotor. |
| `cyclic_propulsion` | Propulsão cíclica | Produzir repetidamente força para deslocar o corpo, um veículo ou um implemento através de ciclos sucessivos. |
| `repetitive_rhythmic_movement` | Movimento rítmico repetitivo | Repetir regularmente um movimento corporal simples para sustentar esforço. |
| `repeated_multidirectional_displacement` | Deslocamento multidirecional repetido | Deslocar-se repetidamente em várias direções, mudando sentido, trajetória ou orientação. |
| `repeated_motor_sequence` | Sequência motora repetida | Encadear várias ações diferentes numa sequência que se repete continuamente. |

### Speed and power

| ID | Name | Definition |
| --- | --- | --- |
| `explosive_acceleration` | Aceleração explosiva | Aumentar rapidamente a velocidade do corpo, de um segmento corporal ou de um implemento. |
| `ballistic_projection` | Projeção explosiva | Produzir impulso suficiente para lançar o corpo ou um implemento numa trajetória livre. |
| `elastic_reactive_action` | Ação elástico-reativa | Absorver rapidamente energia mecânica e reutilizá-la numa ação imediata de propulsão. |
| `braking_redirection` | Travagem e redirecionamento | Reduzir ou interromper rapidamente o movimento e produzir uma nova aceleração noutra direção. |

### Mobility

| ID | Name | Definition |
| --- | --- | --- |
| `active_joint_exploration` | Exploração articular ativa | Mover voluntariamente uma articulação através da amplitude disponível, com controlo. |
| `range_transition` | Transição em amplitude | Passar entre posições que exigem diferentes amplitudes articulares. |
| `integrated_chain_mobility` | Mobilidade integrada em cadeia | Combinar o movimento de várias articulações numa ação contínua e coordenada. |
| `supported_loaded_mobility` | Mobilidade sob suporte ou carga | Expressar amplitude enquanto o corpo suporta peso ou controla uma resistência. |
| `segmental_dissociation` | Dissociação segmentar | Mover uma região corporal mantendo outras regiões relativamente estáveis ou independentes. |

### Flexibility

| ID | Name | Definition |
| --- | --- | --- |
| `sustained_lengthening` | Alongamento sustentado | Manter um tecido ou região corporal numa posição alongada durante determinado período. |
| `dynamic_lengthening` | Alongamento dinâmico | Entrar e sair repetidamente de uma amplitude que alonga os tecidos envolvidos. |
| `assisted_lengthening` | Alongamento assistido | Utilizar uma força externa para posicionar ou aprofundar uma região corporal em alongamento. |

### Motor control and coordination

| ID | Name | Definition |
| --- | --- | --- |
| `postural_stabilization` | Estabilização postural | Manter ou recuperar uma organização corporal estável durante uma posição ou movimento. |
| `base_of_support_control` | Controlo da base de apoio | Gerir a relação entre o centro de massa e a base de apoio para conservar ou recuperar equilíbrio. |
| `rhythm_synchronization` | Ritmo e sincronização | Organizar movimentos segundo uma sequência temporal, cadência ou relação coordenada. |
| `reactive_adjustment` | Ajuste reativo | Modificar rapidamente a ação corporal em resposta a uma alteração, perturbação ou estímulo. |

### Technique and skill

| ID | Name | Definition |
| --- | --- | --- |
| `isolated_technical_practice` | Prática técnica isolada | Praticar uma ação técnica ou uma parte específica dela fora da situação completa. |
| `contextual_technical_application` | Aplicação técnica contextualizada | Executar uma técnica dentro das condições, relações ou exigências em que deverá ser utilizada. |
| `target_oriented_precision` | Precisão orientada a alvo | Executar uma ação procurando atingir um alvo espacial, temporal ou mecânico definido. |
| `stimulus_response_decision` | Resposta a estímulo e decisão | Escolher e executar uma ação adequada em resposta a informação ou estímulos relevantes. |
| `technical_variability_adaptation` | Adaptação técnica à variabilidade | Preservar a função essencial de uma técnica enquanto se ajusta a mudanças nas condições de execução. |

### Breathing and bodily regulation

| ID | Name | Definition |
| --- | --- | --- |
| `voluntary_breath_cycle_control` | Controlo voluntário do ciclo respiratório | Regular conscientemente a inspiração, expiração, pausas e ritmo respiratório. |
| `breath_movement_synchronization` | Sincronização entre respiração e movimento | Coordenar as fases da respiração com posições, movimentos ou momentos de produção de esforço. |
| `internal_pressure_management` | Gestão da pressão interna | Criar, manter ou libertar pressão interna para apoiar estabilidade, transferência de força ou controlo corporal. |
| `autonomic_modulation` | Modulação autonómica | Utilizar ações respiratórias e corporais para alterar o estado de ativação ou recuperação do organismo. |
| `interoceptive_monitoring_adjustment` | Monitorização e ajuste interoceptivo | Perceber sinais internos do corpo e ajustar conscientemente respiração, tensão, posição ou ritmo. |

## Ordered capability relations

The following is the binding visual order. The totals sum to 40, while the global entity count remains 35 through reuse.

1. `muscular_capacity`: `overcome_resistance`, `control_resistance`, `sustain_resistance`, `loaded_carry` (4)
2. `cardio_conditioning`: `cyclic_locomotion`, `cyclic_propulsion`, `repetitive_rhythmic_movement`, `repeated_multidirectional_displacement`, `repeated_motor_sequence` (5)
3. `speed_power`: `explosive_acceleration`, `ballistic_projection`, `elastic_reactive_action`, `braking_redirection`, `cyclic_locomotion`, `repeated_multidirectional_displacement` (6)
4. `mobility`: `active_joint_exploration`, `range_transition`, `integrated_chain_mobility`, `supported_loaded_mobility`, `segmental_dissociation` (5)
5. `flexibility`: `sustained_lengthening`, `dynamic_lengthening`, `assisted_lengthening` (3)
6. `motor_control_coordination`: `postural_stabilization`, `base_of_support_control`, `rhythm_synchronization`, `reactive_adjustment`, `segmental_dissociation`, `repeated_motor_sequence` (6)
7. `technique_skill`: `isolated_technical_practice`, `contextual_technical_application`, `target_oriented_precision`, `stimulus_response_decision`, `technical_variability_adaptation`, `repeated_motor_sequence` (6)
8. `breathing_regulation`: `voluntary_breath_cycle_control`, `breath_movement_synchronization`, `internal_pressure_management`, `autonomic_modulation`, `interoceptive_monitoring_adjustment` (5)

Explicit reuse:

- `repeated_motor_sequence`: cardio, motor control and technique.
- `segmental_dissociation`: mobility and motor control.
- `cyclic_locomotion`: cardio and speed/power.
- `repeated_multidirectional_displacement`: cardio and speed/power.

## Context, query and interface contract

The five contexts are `main_training`, `warmup`, `activation`, `recovery_cooldown` and `prevention_adaptation_return`. Context does not redefine a concept. Every context must return the same ordered concept list for a selected capability; there are no context-specific duplicates.

The user flow is:

`Contexto → Capacidade → Conceito → estado vazio de Intenção`

After concept selection, the query has exactly three criteria in this order:

1. `usageContext`
2. `capabilityRoot`
3. `trainingConcept`

It must not contain `trainingIntention`, `exercise_ids`, `parent_id`, `legacy_ids`, protocols or invented attributes. The UI shows the concept name and definition, advances to the empty intention state, and shows no exercises or results.

Navigation must preserve the selected concept when returning from the empty intention state; capability changes clear concept and intention, context changes clear capability, concept and intention, Home clears the full path, and system Back follows the same contract.

## Validation and operational status

Required focused assertions cover all counts, exact IDs, names, definitions, order, reuse, the 5x8 context matrix, query criteria, empty intention state, absence of hierarchy fields, absence of exercises and legacy visibility. Widget tests cover selection, breadcrumb, Back, Home, narrow layouts, text scaling and overflow. Android smoke covers the canonical route and the eight-capability release evidence.

Required commands are the real PR15 pipeline commands documented in `docs/engineering/TESTING.md`:

```powershell
dart run tool/testing/evefit_gate.dart fast
dart run tool/testing/evefit_gate.dart pr
```

Fast Gate target: <= 2 minutes. PR Gate warm target: <= 5 minutes. GitHub CI warm target: <= 7 minutes. Release Gate target: <= 8 minutes.

Current evidence on the release branch:

- Focused canonical, widget and Clean Base tests: 39 passed.
- Version metadata tests: 2 passed.
- Fast Gate: passed in 11.830 seconds wall time (9.108 seconds reported by the gate).
- Changed-file format and analyze: passed through the Fast Gate.
- PR Gate, Android, CI, upgrade, APK metadata, signature and release evidence: pending their required execution stages.

## Risks, limitations and rollback

- The registry, compatibility provider, selector and focused tests are integrated on the release branch; remote CI and post-merge Release Gate evidence remain pending.
- Tag, PR merge SHA, release URL, APK path, APK hash and certificate evidence remain pending.
- Rollback is a revert of the release commits; no database rollback is required because this release makes no schema or migration change.
- Publication is allowed only after the consolidated gates pass.
