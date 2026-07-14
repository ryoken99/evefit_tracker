# NÃO APROVADO

Esta árvore foi implementada prematuramente e não faz parte da taxonomia canónica oficial da EveFit.

Os futuros subfiltros deverão nascer dos atributos e exercícios reais, com aprovação explícita do Sandro.

## Proveniência

- Commit de origem: `0388222fa541dea5ffcb0a185f0c335143ee4fe4`
- Ficheiro original: `lib/features/canonical_search/data/canonical_search_menu_data.dart`
- Schema original: `canonical_search_menu/0.1`
- Raízes de capacidade: 8
- Contextos: 4
- Nós de nível 2: 45
- Terminais: 189
- Total: 246

## Limites

- Este documento não entra no bundle da aplicação.
- Não é carregado pela app nem por testes de produção.
- Não é fonte de verdade e não representa conteúdo aprovado.
- Preserva apenas o rascunho histórico para investigação.

## Estrutura completa

| ID | Parent ID | Depth | Axis | Nome PT-PT | Ordem | Enabled | Terminal | Icon | Query namespace | Query conditions |
|---|---|---:|---|---|---:|---|---|---|---|---|
| `muscular_capacity` |  | 1 | `capabilityRoot` | Força e capacidade muscular | 0 | true | false | `strength` | `canonical_search_menu/0.1` | `capability equals muscular_capacity` |
| `muscular_capacity_upper_body` | `muscular_capacity` | 2 | `conceptFamily` | Parte superior | 0 | true | false | `upperBody` | `canonical_search_menu/0.1` | `conceptFamily contains capacity_upper_body` |
| `muscular_capacity_upper_body_chest` | `muscular_capacity_upper_body` | 3 | `anatomicalRegion` | Peito | 0 | true | true | `upperBody` | `canonical_search_menu/0.1` | `bodyRegion equals chest` |
| `muscular_capacity_upper_body_back` | `muscular_capacity_upper_body` | 3 | `anatomicalRegion` | Costas | 1 | true | true | `upperBody` | `canonical_search_menu/0.1` | `bodyRegion equals back` |
| `muscular_capacity_upper_body_shoulders` | `muscular_capacity_upper_body` | 3 | `anatomicalRegion` | Ombros | 2 | true | true | `upperBody` | `canonical_search_menu/0.1` | `bodyRegion equals shoulders` |
| `muscular_capacity_upper_body_arms` | `muscular_capacity_upper_body` | 3 | `anatomicalRegion` | Braços | 3 | true | true | `upperBody` | `canonical_search_menu/0.1` | `bodyRegion equals arms` |
| `muscular_capacity_lower_body` | `muscular_capacity` | 2 | `conceptFamily` | Parte inferior | 1 | true | false | `lowerBody` | `canonical_search_menu/0.1` | `conceptFamily contains capacity_lower_body` |
| `muscular_capacity_lower_body_glutes` | `muscular_capacity_lower_body` | 3 | `anatomicalRegion` | Glúteos | 0 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `bodyRegion equals glutes` |
| `muscular_capacity_lower_body_thighs` | `muscular_capacity_lower_body` | 3 | `anatomicalRegion` | Coxas | 1 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `bodyRegion equals thighs` |
| `muscular_capacity_lower_body_lower_leg` | `muscular_capacity_lower_body` | 3 | `anatomicalRegion` | Perna inferior | 2 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `bodyRegion equals lower_leg` |
| `muscular_capacity_lower_body_foot_ankle` | `muscular_capacity_lower_body` | 3 | `anatomicalRegion` | Pé e tornozelo | 3 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `bodyRegion equals foot_ankle` |
| `muscular_capacity_core_trunk` | `muscular_capacity` | 2 | `conceptFamily` | Core e tronco | 2 | true | false | `core` | `canonical_search_menu/0.1` | `conceptFamily contains capacity_core_trunk` |
| `muscular_capacity_core_trunk_anterior` | `muscular_capacity_core_trunk` | 3 | `anatomicalRegion` | Anterior | 0 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals anterior` |
| `muscular_capacity_core_trunk_lateral` | `muscular_capacity_core_trunk` | 3 | `anatomicalRegion` | Lateral | 1 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals lateral` |
| `muscular_capacity_core_trunk_posterior` | `muscular_capacity_core_trunk` | 3 | `anatomicalRegion` | Posterior | 2 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals posterior` |
| `muscular_capacity_core_trunk_rotation_anti_rotation` | `muscular_capacity_core_trunk` | 3 | `anatomicalRegion` | Rotação e anti-rotação | 3 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals rotation_anti_rotation` |
| `muscular_capacity_full_body` | `muscular_capacity` | 2 | `conceptFamily` | Corpo inteiro | 3 | true | false | `fullBody` | `canonical_search_menu/0.1` | `conceptFamily contains capacity_full_body` |
| `muscular_capacity_full_body_push` | `muscular_capacity_full_body` | 3 | `movementPattern` | Empurrar | 0 | true | true | `fullBody` | `canonical_search_menu/0.1` | `movementPattern equals push` |
| `muscular_capacity_full_body_pull` | `muscular_capacity_full_body` | 3 | `movementPattern` | Puxar | 1 | true | true | `fullBody` | `canonical_search_menu/0.1` | `movementPattern equals pull` |
| `muscular_capacity_full_body_squat` | `muscular_capacity_full_body` | 3 | `movementPattern` | Agachar | 2 | true | true | `fullBody` | `canonical_search_menu/0.1` | `movementPattern equals squat` |
| `muscular_capacity_full_body_hip_hinge_extension` | `muscular_capacity_full_body` | 3 | `movementPattern` | Hinge e extensão da anca | 3 | true | true | `fullBody` | `canonical_search_menu/0.1` | `movementPattern equals hip_hinge_extension` |
| `muscular_capacity_full_body_carry_transport` | `muscular_capacity_full_body` | 3 | `movementPattern` | Carregar e transportar | 4 | true | true | `fullBody` | `canonical_search_menu/0.1` | `movementPattern equals carry_transport` |
| `cardio_conditioning` |  | 1 | `capabilityRoot` | Cardio e condicionamento | 1 | true | false | `cardio` | `canonical_search_menu/0.1` | `capability equals cardio_conditioning` |
| `cardio_conditioning_no_machines` | `cardio_conditioning` | 2 | `conceptFamily` | Sem máquinas | 0 | true | false | `walkRun` | `canonical_search_menu/0.1` | `conceptFamily contains conditioning_no_machines` |
| `cardio_conditioning_no_machines_walk_run` | `cardio_conditioning_no_machines` | 3 | `movementPattern` | Caminhada e corrida | 0 | true | true | `walkRun` | `canonical_search_menu/0.1` | `movementPattern equals walk_run` |
| `cardio_conditioning_no_machines_jumps_bodyweight` | `cardio_conditioning_no_machines` | 3 | `movementPattern` | Saltos e peso corporal | 1 | true | true | `walkRun` | `canonical_search_menu/0.1` | `movementPattern equals jumps_bodyweight` |
| `cardio_conditioning_no_machines_rope` | `cardio_conditioning_no_machines` | 3 | `movementPattern` | Corda | 2 | true | true | `walkRun` | `canonical_search_menu/0.1` | `movementPattern equals rope` |
| `cardio_conditioning_no_machines_agility_locomotion` | `cardio_conditioning_no_machines` | 3 | `movementPattern` | Agilidade e deslocamentos | 3 | true | true | `walkRun` | `canonical_search_menu/0.1` | `movementPattern equals agility_locomotion` |
| `cardio_conditioning_with_machines` | `cardio_conditioning` | 2 | `modality` | Com máquinas | 1 | true | false | `machine` | `canonical_search_menu/0.1` | `conceptFamily contains conditioning_with_machines` |
| `cardio_conditioning_with_machines_treadmill` | `cardio_conditioning_with_machines` | 3 | `modality` | Passadeira | 0 | true | true | `machine` | `canonical_search_menu/0.1` | `modality equals treadmill` |
| `cardio_conditioning_with_machines_bicycle` | `cardio_conditioning_with_machines` | 3 | `modality` | Bicicleta | 1 | true | true | `machine` | `canonical_search_menu/0.1` | `modality equals bicycle` |
| `cardio_conditioning_with_machines_rowing` | `cardio_conditioning_with_machines` | 3 | `modality` | Remo | 2 | true | true | `machine` | `canonical_search_menu/0.1` | `modality equals rowing` |
| `cardio_conditioning_with_machines_elliptical` | `cardio_conditioning_with_machines` | 3 | `modality` | Elíptica | 3 | true | true | `machine` | `canonical_search_menu/0.1` | `modality equals elliptical` |
| `cardio_conditioning_with_machines_stairs_steppers` | `cardio_conditioning_with_machines` | 3 | `modality` | Escadas e steppers | 4 | true | true | `machine` | `canonical_search_menu/0.1` | `modality equals stairs_steppers` |
| `cardio_conditioning_with_machines_arm_full_body_ergometers` | `cardio_conditioning_with_machines` | 3 | `modality` | Ergómetros de braços ou corpo inteiro | 5 | true | true | `machine` | `canonical_search_menu/0.1` | `modality equals arm_full_body_ergometers` |
| `cardio_conditioning_outdoor_modalities` | `cardio_conditioning` | 2 | `modality` | Exterior e modalidades | 2 | true | false | `outdoor` | `canonical_search_menu/0.1` | `conceptFamily contains conditioning_outdoor_modalities` |
| `cardio_conditioning_outdoor_modalities_cycling` | `cardio_conditioning_outdoor_modalities` | 3 | `modality` | Ciclismo | 0 | true | true | `outdoor` | `canonical_search_menu/0.1` | `modality equals cycling` |
| `cardio_conditioning_outdoor_modalities_swimming` | `cardio_conditioning_outdoor_modalities` | 3 | `modality` | Natação | 1 | true | true | `outdoor` | `canonical_search_menu/0.1` | `modality equals swimming` |
| `cardio_conditioning_outdoor_modalities_trail_mountain` | `cardio_conditioning_outdoor_modalities` | 3 | `modality` | Trilho e montanha | 2 | true | true | `outdoor` | `canonical_search_menu/0.1` | `modality equals trail_mountain` |
| `cardio_conditioning_outdoor_modalities_rowing_kayak_paddle` | `cardio_conditioning_outdoor_modalities` | 3 | `modality` | Remo, kayak e paddle | 3 | true | true | `outdoor` | `canonical_search_menu/0.1` | `modality equals rowing_kayak_paddle` |
| `cardio_conditioning_outdoor_modalities_wheel_sports` | `cardio_conditioning_outdoor_modalities` | 3 | `modality` | Desportos de rodas | 4 | true | true | `outdoor` | `canonical_search_menu/0.1` | `modality equals wheel_sports` |
| `cardio_conditioning_rhythmic_combat` | `cardio_conditioning` | 2 | `modality` | Rítmico e combate | 3 | true | false | `combat` | `canonical_search_menu/0.1` | `conceptFamily contains conditioning_rhythmic_combat` |
| `cardio_conditioning_rhythmic_combat_dance_aerobics` | `cardio_conditioning_rhythmic_combat` | 3 | `modality` | Dança e aeróbica | 0 | true | true | `combat` | `canonical_search_menu/0.1` | `modality equals dance_aerobics` |
| `cardio_conditioning_rhythmic_combat_shadow` | `cardio_conditioning_rhythmic_combat` | 3 | `modality` | Shadow | 1 | true | true | `combat` | `canonical_search_menu/0.1` | `modality equals shadow` |
| `cardio_conditioning_rhythmic_combat_bag_work` | `cardio_conditioning_rhythmic_combat` | 3 | `modality` | Trabalho de saco | 2 | true | true | `combat` | `canonical_search_menu/0.1` | `modality equals bag_work` |
| `cardio_conditioning_rhythmic_combat_combat_footwork` | `cardio_conditioning_rhythmic_combat` | 3 | `modality` | Footwork e deslocamento de combate | 3 | true | true | `combat` | `canonical_search_menu/0.1` | `modality equals combat_footwork` |
| `speed_power` |  | 1 | `capabilityRoot` | Velocidade e potência | 2 | true | false | `speed` | `canonical_search_menu/0.1` | `capability equals speed_power` |
| `speed_power_acceleration_sprint` | `speed_power` | 2 | `conceptFamily` | Aceleração e sprint | 0 | true | false | `speed` | `canonical_search_menu/0.1` | `conceptFamily contains power_acceleration_sprint` |
| `speed_power_acceleration_sprint_linear_acceleration` | `speed_power_acceleration_sprint` | 3 | `movementPattern` | Aceleração linear | 0 | true | true | `speed` | `canonical_search_menu/0.1` | `movementPattern equals linear_acceleration` |
| `speed_power_acceleration_sprint_sprint` | `speed_power_acceleration_sprint` | 3 | `movementPattern` | Sprint | 1 | true | true | `speed` | `canonical_search_menu/0.1` | `movementPattern equals sprint` |
| `speed_power_acceleration_sprint_start_departure` | `speed_power_acceleration_sprint` | 3 | `movementPattern` | Arranque e saída | 2 | true | true | `speed` | `canonical_search_menu/0.1` | `movementPattern equals start_departure` |
| `speed_power_acceleration_sprint_uphill_resistance` | `speed_power_acceleration_sprint` | 3 | `movementPattern` | Subida ou resistência | 3 | true | true | `speed` | `canonical_search_menu/0.1` | `movementPattern equals uphill_resistance` |
| `speed_power_jumps_plyometrics` | `speed_power` | 2 | `conceptFamily` | Saltos e pliometria | 1 | true | false | `movement` | `canonical_search_menu/0.1` | `conceptFamily contains power_jumps_plyometrics` |
| `speed_power_jumps_plyometrics_vertical` | `speed_power_jumps_plyometrics` | 3 | `movementPattern` | Vertical | 0 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals vertical` |
| `speed_power_jumps_plyometrics_horizontal` | `speed_power_jumps_plyometrics` | 3 | `movementPattern` | Horizontal | 1 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals horizontal` |
| `speed_power_jumps_plyometrics_lateral` | `speed_power_jumps_plyometrics` | 3 | `movementPattern` | Lateral | 2 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals lateral` |
| `speed_power_jumps_plyometrics_unilateral` | `speed_power_jumps_plyometrics` | 3 | `movementPattern` | Unilateral | 3 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals unilateral` |
| `speed_power_jumps_plyometrics_reactive` | `speed_power_jumps_plyometrics` | 3 | `movementPattern` | Reativo | 4 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals reactive` |
| `speed_power_throws_ballistic` | `speed_power` | 2 | `conceptFamily` | Lançamentos e movimentos balísticos | 2 | true | false | `movement` | `canonical_search_menu/0.1` | `conceptFamily contains power_throws_ballistic` |
| `speed_power_throws_ballistic_frontal` | `speed_power_throws_ballistic` | 3 | `movementPattern` | Frontal | 0 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals frontal` |
| `speed_power_throws_ballistic_overhead` | `speed_power_throws_ballistic` | 3 | `movementPattern` | Acima da cabeça | 1 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals overhead` |
| `speed_power_throws_ballistic_rotational` | `speed_power_throws_ballistic` | 3 | `movementPattern` | Rotacional | 2 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals rotational` |
| `speed_power_throws_ballistic_bottom_up` | `speed_power_throws_ballistic` | 3 | `movementPattern` | De baixo para cima | 3 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals bottom_up` |
| `speed_power_change_direction_reaction` | `speed_power` | 2 | `conceptFamily` | Mudança de direção e reação | 3 | true | false | `coordination` | `canonical_search_menu/0.1` | `conceptFamily contains power_change_direction_reaction` |
| `speed_power_change_direction_reaction_planned_change` | `speed_power_change_direction_reaction` | 3 | `movementPattern` | Mudança planeada | 0 | true | true | `coordination` | `canonical_search_menu/0.1` | `movementPattern equals planned_change` |
| `speed_power_change_direction_reaction_reactive_change` | `speed_power_change_direction_reaction` | 3 | `movementPattern` | Mudança reativa | 1 | true | true | `coordination` | `canonical_search_menu/0.1` | `movementPattern equals reactive_change` |
| `speed_power_change_direction_reaction_multidirectional` | `speed_power_change_direction_reaction` | 3 | `movementPattern` | Multidirecional | 2 | true | true | `coordination` | `canonical_search_menu/0.1` | `movementPattern equals multidirectional` |
| `speed_power_change_direction_reaction_stimulus_response` | `speed_power_change_direction_reaction` | 3 | `movementPattern` | Resposta a estímulo | 3 | true | true | `coordination` | `canonical_search_menu/0.1` | `movementPattern equals stimulus_response` |
| `mobility` |  | 1 | `capabilityRoot` | Mobilidade | 3 | true | false | `mobility` | `canonical_search_menu/0.1` | `capability equals mobility` |
| `mobility_upper_body` | `mobility` | 2 | `conceptFamily` | Parte superior | 0 | true | false | `upperBody` | `canonical_search_menu/0.1` | `conceptFamily contains upper_body` |
| `mobility_upper_body_shoulder` | `mobility_upper_body` | 3 | `anatomicalRegion` | Ombro | 0 | true | true | `upperBody` | `canonical_search_menu/0.1` | `joint equals shoulder` |
| `mobility_upper_body_elbow` | `mobility_upper_body` | 3 | `anatomicalRegion` | Cotovelo | 1 | true | true | `upperBody` | `canonical_search_menu/0.1` | `joint equals elbow` |
| `mobility_upper_body_wrist_hand` | `mobility_upper_body` | 3 | `anatomicalRegion` | Punho e mão | 2 | true | true | `upperBody` | `canonical_search_menu/0.1` | `joint equals wrist_hand` |
| `mobility_lower_body` | `mobility` | 2 | `conceptFamily` | Parte inferior | 1 | true | false | `lowerBody` | `canonical_search_menu/0.1` | `conceptFamily contains lower_body` |
| `mobility_lower_body_hip` | `mobility_lower_body` | 3 | `anatomicalRegion` | Anca | 0 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `joint equals hip` |
| `mobility_lower_body_knee` | `mobility_lower_body` | 3 | `anatomicalRegion` | Joelho | 1 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `joint equals knee` |
| `mobility_lower_body_ankle_foot` | `mobility_lower_body` | 3 | `anatomicalRegion` | Tornozelo e pé | 2 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `joint equals ankle_foot` |
| `mobility_spine_trunk` | `mobility` | 2 | `conceptFamily` | Coluna e tronco | 2 | true | false | `core` | `canonical_search_menu/0.1` | `conceptFamily contains spine_trunk` |
| `mobility_spine_trunk_cervical` | `mobility_spine_trunk` | 3 | `anatomicalRegion` | Cervical | 0 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals cervical` |
| `mobility_spine_trunk_thoracic` | `mobility_spine_trunk` | 3 | `anatomicalRegion` | Torácica | 1 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals thoracic` |
| `mobility_spine_trunk_lumbar` | `mobility_spine_trunk` | 3 | `anatomicalRegion` | Lombar | 2 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals lumbar` |
| `mobility_spine_trunk_trunk_rotation` | `mobility_spine_trunk` | 3 | `anatomicalRegion` | Rotação do tronco | 3 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals trunk_rotation` |
| `flexibility` |  | 1 | `capabilityRoot` | Flexibilidade | 4 | true | false | `flexibility` | `canonical_search_menu/0.1` | `capability equals flexibility` |
| `flexibility_upper_body` | `flexibility` | 2 | `conceptFamily` | Parte superior | 0 | true | false | `upperBody` | `canonical_search_menu/0.1` | `conceptFamily contains upper_body` |
| `flexibility_upper_body_chest` | `flexibility_upper_body` | 3 | `anatomicalRegion` | Peito | 0 | true | true | `upperBody` | `canonical_search_menu/0.1` | `bodyRegion equals chest` |
| `flexibility_upper_body_shoulders` | `flexibility_upper_body` | 3 | `anatomicalRegion` | Ombros | 1 | true | true | `upperBody` | `canonical_search_menu/0.1` | `bodyRegion equals shoulders` |
| `flexibility_upper_body_arms` | `flexibility_upper_body` | 3 | `anatomicalRegion` | Braços | 2 | true | true | `upperBody` | `canonical_search_menu/0.1` | `bodyRegion equals arms` |
| `flexibility_upper_body_back` | `flexibility_upper_body` | 3 | `anatomicalRegion` | Costas | 3 | true | true | `upperBody` | `canonical_search_menu/0.1` | `bodyRegion equals back` |
| `flexibility_lower_body` | `flexibility` | 2 | `conceptFamily` | Parte inferior | 1 | true | false | `lowerBody` | `canonical_search_menu/0.1` | `conceptFamily contains lower_body` |
| `flexibility_lower_body_hip_glutes` | `flexibility_lower_body` | 3 | `anatomicalRegion` | Anca e glúteos | 0 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `bodyRegion equals hip_glutes` |
| `flexibility_lower_body_quadriceps` | `flexibility_lower_body` | 3 | `anatomicalRegion` | Quadríceps | 1 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `bodyRegion equals quadriceps` |
| `flexibility_lower_body_hamstrings` | `flexibility_lower_body` | 3 | `anatomicalRegion` | Posteriores da coxa | 2 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `bodyRegion equals hamstrings` |
| `flexibility_lower_body_adductors_abductors` | `flexibility_lower_body` | 3 | `anatomicalRegion` | Adutores e abdutores | 3 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `bodyRegion equals adductors_abductors` |
| `flexibility_lower_body_calves_ankle` | `flexibility_lower_body` | 3 | `anatomicalRegion` | Gémeos e tornozelo | 4 | true | true | `lowerBody` | `canonical_search_menu/0.1` | `bodyRegion equals calves_ankle` |
| `flexibility_trunk_body_chains` | `flexibility` | 2 | `conceptFamily` | Tronco e cadeias corporais | 2 | true | false | `core` | `canonical_search_menu/0.1` | `conceptFamily contains trunk_body_chains` |
| `flexibility_trunk_body_chains_anterior_chain` | `flexibility_trunk_body_chains` | 3 | `anatomicalRegion` | Cadeia anterior | 0 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals anterior_chain` |
| `flexibility_trunk_body_chains_posterior_chain` | `flexibility_trunk_body_chains` | 3 | `anatomicalRegion` | Cadeia posterior | 1 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals posterior_chain` |
| `flexibility_trunk_body_chains_lateral_chains` | `flexibility_trunk_body_chains` | 3 | `anatomicalRegion` | Cadeias laterais | 2 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals lateral_chains` |
| `flexibility_trunk_body_chains_rotation` | `flexibility_trunk_body_chains` | 3 | `anatomicalRegion` | Rotação | 3 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals rotation` |
| `flexibility_trunk_body_chains_full_body` | `flexibility_trunk_body_chains` | 3 | `anatomicalRegion` | Corpo inteiro | 4 | true | true | `core` | `canonical_search_menu/0.1` | `bodyRegion equals full_body` |
| `motor_control_coordination` |  | 1 | `capabilityRoot` | Controlo motor e coordenação | 5 | true | false | `coordination` | `canonical_search_menu/0.1` | `capability equals motor_control_coordination` |
| `motor_control_coordination_balance` | `motor_control_coordination` | 2 | `conceptFamily` | Equilíbrio | 0 | true | false | `balance` | `canonical_search_menu/0.1` | `conceptFamily contains control_coordination_balance` |
| `motor_control_coordination_balance_static` | `motor_control_coordination_balance` | 3 | `adaptationGoal` | Estático | 0 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals static` |
| `motor_control_coordination_balance_dynamic` | `motor_control_coordination_balance` | 3 | `adaptationGoal` | Dinâmico | 1 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals dynamic` |
| `motor_control_coordination_balance_unilateral` | `motor_control_coordination_balance` | 3 | `adaptationGoal` | Unilateral | 2 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals unilateral` |
| `motor_control_coordination_balance_locomotion` | `motor_control_coordination_balance` | 3 | `adaptationGoal` | Em deslocamento | 3 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals locomotion` |
| `motor_control_coordination_coordination` | `motor_control_coordination` | 2 | `conceptFamily` | Coordenação | 1 | true | false | `coordination` | `canonical_search_menu/0.1` | `conceptFamily contains control_coordination_coordination` |
| `motor_control_coordination_coordination_full_body` | `motor_control_coordination_coordination` | 3 | `adaptationGoal` | Corpo inteiro | 0 | true | true | `coordination` | `canonical_search_menu/0.1` | `adaptationGoal equals full_body` |
| `motor_control_coordination_coordination_hand_eye` | `motor_control_coordination_coordination` | 3 | `adaptationGoal` | Mão-olho | 1 | true | true | `coordination` | `canonical_search_menu/0.1` | `adaptationGoal equals hand_eye` |
| `motor_control_coordination_coordination_foot_eye` | `motor_control_coordination_coordination` | 3 | `adaptationGoal` | Pé-olho | 2 | true | true | `coordination` | `canonical_search_menu/0.1` | `adaptationGoal equals foot_eye` |
| `motor_control_coordination_coordination_bilateral` | `motor_control_coordination_coordination` | 3 | `adaptationGoal` | Coordenação bilateral | 3 | true | true | `coordination` | `canonical_search_menu/0.1` | `adaptationGoal equals bilateral` |
| `motor_control_coordination_proprioception_stability` | `motor_control_coordination` | 2 | `conceptFamily` | Proprioceção e estabilidade | 2 | true | false | `balance` | `canonical_search_menu/0.1` | `conceptFamily contains control_coordination_proprioception_stability` |
| `motor_control_coordination_proprioception_stability_joint_stability` | `motor_control_coordination_proprioception_stability` | 3 | `adaptationGoal` | Estabilidade articular | 0 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals joint_stability` |
| `motor_control_coordination_proprioception_stability_postural_control` | `motor_control_coordination_proprioception_stability` | 3 | `adaptationGoal` | Controlo postural | 1 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals postural_control` |
| `motor_control_coordination_proprioception_stability_landing` | `motor_control_coordination_proprioception_stability` | 3 | `adaptationGoal` | Aterragem | 2 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals landing` |
| `motor_control_coordination_proprioception_stability_alignment` | `motor_control_coordination_proprioception_stability` | 3 | `adaptationGoal` | Alinhamento | 3 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals alignment` |
| `motor_control_coordination_agility_reaction` | `motor_control_coordination` | 2 | `conceptFamily` | Agilidade e reação | 3 | true | false | `speed` | `canonical_search_menu/0.1` | `conceptFamily contains control_coordination_agility_reaction` |
| `motor_control_coordination_agility_reaction_rhythm` | `motor_control_coordination_agility_reaction` | 3 | `movementPattern` | Ritmo | 0 | true | true | `speed` | `canonical_search_menu/0.1` | `movementPattern equals rhythm` |
| `motor_control_coordination_agility_reaction_visual_response` | `motor_control_coordination_agility_reaction` | 3 | `movementPattern` | Resposta visual | 1 | true | true | `speed` | `canonical_search_menu/0.1` | `movementPattern equals visual_response` |
| `motor_control_coordination_agility_reaction_sound_response` | `motor_control_coordination_agility_reaction` | 3 | `movementPattern` | Resposta sonora | 2 | true | true | `speed` | `canonical_search_menu/0.1` | `movementPattern equals sound_response` |
| `motor_control_coordination_agility_reaction_change_direction` | `motor_control_coordination_agility_reaction` | 3 | `movementPattern` | Mudança de direção | 3 | true | true | `speed` | `canonical_search_menu/0.1` | `movementPattern equals change_direction` |
| `motor_control_coordination_agility_reaction_motor_decision` | `motor_control_coordination_agility_reaction` | 3 | `movementPattern` | Decisão motora | 4 | true | true | `speed` | `canonical_search_menu/0.1` | `movementPattern equals motor_decision` |
| `technique_skill` |  | 1 | `capabilityRoot` | Técnica e habilidade | 6 | true | false | `technique` | `canonical_search_menu/0.1` | `capability equals technique_skill` |
| `technique_skill_martial_combat` | `technique_skill` | 2 | `modality` | Artes marciais e combate | 0 | true | false | `combat` | `canonical_search_menu/0.1` | `conceptFamily contains skill_martial_combat` |
| `technique_skill_martial_combat_striking` | `technique_skill_martial_combat` | 3 | `modality` | Striking | 0 | true | true | `combat` | `canonical_search_menu/0.1` | `modality equals striking` |
| `technique_skill_martial_combat_grappling` | `technique_skill_martial_combat` | 3 | `modality` | Grappling | 1 | true | true | `combat` | `canonical_search_menu/0.1` | `modality equals grappling` |
| `technique_skill_martial_combat_defense_locomotion` | `technique_skill_martial_combat` | 3 | `modality` | Defesa e deslocamento | 2 | true | true | `combat` | `canonical_search_menu/0.1` | `modality equals defense_locomotion` |
| `technique_skill_martial_combat_ground_transitions` | `technique_skill_martial_combat` | 3 | `modality` | Solo e transições | 3 | true | true | `combat` | `canonical_search_menu/0.1` | `modality equals ground_transitions` |
| `technique_skill_sport_technique` | `technique_skill` | 2 | `modality` | Técnica desportiva | 1 | true | false | `technique` | `canonical_search_menu/0.1` | `conceptFamily contains skill_sport_technique` |
| `technique_skill_sport_technique_running` | `technique_skill_sport_technique` | 3 | `modality` | Técnica de corrida | 0 | true | true | `technique` | `canonical_search_menu/0.1` | `modality equals running` |
| `technique_skill_sport_technique_swimming` | `technique_skill_sport_technique` | 3 | `modality` | Técnica de natação | 1 | true | true | `technique` | `canonical_search_menu/0.1` | `modality equals swimming` |
| `technique_skill_sport_technique_cycling` | `technique_skill_sport_technique` | 3 | `modality` | Técnica de ciclismo | 2 | true | true | `technique` | `canonical_search_menu/0.1` | `modality equals cycling` |
| `technique_skill_sport_technique_jumps_throws` | `technique_skill_sport_technique` | 3 | `modality` | Saltos e lançamentos | 3 | true | true | `technique` | `canonical_search_menu/0.1` | `modality equals jumps_throws` |
| `technique_skill_sport_technique_sport_specific` | `technique_skill_sport_technique` | 3 | `modality` | Técnica específica de modalidade | 4 | true | true | `technique` | `canonical_search_menu/0.1` | `modality equals sport_specific` |
| `technique_skill_dance_expression` | `technique_skill` | 2 | `modality` | Dança e expressão motora | 2 | true | false | `coordination` | `canonical_search_menu/0.1` | `conceptFamily contains skill_dance_expression` |
| `technique_skill_dance_expression_steps` | `technique_skill_dance_expression` | 3 | `modality` | Passos | 0 | true | true | `coordination` | `canonical_search_menu/0.1` | `modality equals steps` |
| `technique_skill_dance_expression_sequences` | `technique_skill_dance_expression` | 3 | `modality` | Sequências | 1 | true | true | `coordination` | `canonical_search_menu/0.1` | `modality equals sequences` |
| `technique_skill_dance_expression_rhythm` | `technique_skill_dance_expression` | 3 | `modality` | Ritmo | 2 | true | true | `coordination` | `canonical_search_menu/0.1` | `modality equals rhythm` |
| `technique_skill_dance_expression_musical_coordination` | `technique_skill_dance_expression` | 3 | `modality` | Coordenação musical | 3 | true | true | `coordination` | `canonical_search_menu/0.1` | `modality equals musical_coordination` |
| `technique_skill_object_control` | `technique_skill` | 2 | `modality` | Controlo de objetos | 3 | true | false | `general` | `canonical_search_menu/0.1` | `conceptFamily contains skill_object_control` |
| `technique_skill_object_control_ball` | `technique_skill_object_control` | 3 | `modality` | Bola | 0 | true | true | `general` | `canonical_search_menu/0.1` | `modality equals ball` |
| `technique_skill_object_control_racket` | `technique_skill_object_control` | 3 | `modality` | Raquete | 1 | true | true | `general` | `canonical_search_menu/0.1` | `modality equals racket` |
| `technique_skill_object_control_bat_implement` | `technique_skill_object_control` | 3 | `modality` | Bastão ou implemento | 2 | true | true | `general` | `canonical_search_menu/0.1` | `modality equals bat_implement` |
| `technique_skill_object_control_throw_catch` | `technique_skill_object_control` | 3 | `modality` | Lançar e receber | 3 | true | true | `general` | `canonical_search_menu/0.1` | `modality equals throw_catch` |
| `breathing_regulation` |  | 1 | `capabilityRoot` | Respiração e regulação corporal | 7 | true | false | `breathing` | `canonical_search_menu/0.1` | `capability equals breathing_regulation` |
| `breathing_regulation_mechanics` | `breathing_regulation` | 2 | `conceptFamily` | Mecânica respiratória | 0 | true | false | `breathing` | `canonical_search_menu/0.1` | `conceptFamily contains regulation_mechanics` |
| `breathing_regulation_mechanics_diaphragmatic` | `breathing_regulation_mechanics` | 3 | `adaptationGoal` | Diafragmática | 0 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals diaphragmatic` |
| `breathing_regulation_mechanics_costal` | `breathing_regulation_mechanics` | 3 | `adaptationGoal` | Costal | 1 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals costal` |
| `breathing_regulation_mechanics_nasal` | `breathing_regulation_mechanics` | 3 | `adaptationGoal` | Nasal | 2 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals nasal` |
| `breathing_regulation_mechanics_breath_movement` | `breathing_regulation_mechanics` | 3 | `adaptationGoal` | Coordenação respiração-movimento | 3 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals breath_movement` |
| `breathing_regulation_rhythm_control` | `breathing_regulation` | 2 | `conceptFamily` | Controlo do ritmo respiratório | 1 | true | false | `breathing` | `canonical_search_menu/0.1` | `conceptFamily contains regulation_rhythm_control` |
| `breathing_regulation_rhythm_control_cadence` | `breathing_regulation_rhythm_control` | 3 | `adaptationGoal` | Cadência | 0 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals cadence` |
| `breathing_regulation_rhythm_control_prolonged_exhalation` | `breathing_regulation_rhythm_control` | 3 | `adaptationGoal` | Expiração prolongada | 1 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals prolonged_exhalation` |
| `breathing_regulation_rhythm_control_controlled_rhythm` | `breathing_regulation_rhythm_control` | 3 | `adaptationGoal` | Ritmo controlado | 2 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals controlled_rhythm` |
| `breathing_regulation_rhythm_control_controlled_pauses` | `breathing_regulation_rhythm_control` | 3 | `adaptationGoal` | Pausas respiratórias controladas | 3 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals controlled_pauses` |
| `breathing_regulation_relaxation` | `breathing_regulation` | 2 | `conceptFamily` | Relaxamento e regulação | 2 | true | false | `recovery` | `canonical_search_menu/0.1` | `conceptFamily contains regulation_relaxation` |
| `breathing_regulation_relaxation_slow_breathing` | `breathing_regulation_relaxation` | 3 | `adaptationGoal` | Respiração lenta | 0 | true | true | `recovery` | `canonical_search_menu/0.1` | `adaptationGoal equals slow_breathing` |
| `breathing_regulation_relaxation_reduced_activation` | `breathing_regulation_relaxation` | 3 | `adaptationGoal` | Redução de ativação | 1 | true | true | `recovery` | `canonical_search_menu/0.1` | `adaptationGoal equals reduced_activation` |
| `breathing_regulation_relaxation_cooldown` | `breathing_regulation_relaxation` | 3 | `adaptationGoal` | Retorno à calma | 2 | true | true | `recovery` | `canonical_search_menu/0.1` | `adaptationGoal equals cooldown` |
| `breathing_regulation_relaxation_focus_concentration` | `breathing_regulation_relaxation` | 3 | `adaptationGoal` | Foco e concentração | 3 | true | true | `recovery` | `canonical_search_menu/0.1` | `adaptationGoal equals focus_concentration` |
| `breathing_regulation_body_awareness` | `breathing_regulation` | 2 | `conceptFamily` | Consciência corporal | 3 | true | false | `general` | `canonical_search_menu/0.1` | `conceptFamily contains regulation_body_awareness` |
| `breathing_regulation_body_awareness_breathing_posture` | `breathing_regulation_body_awareness` | 3 | `adaptationGoal` | Postura respiratória | 0 | true | true | `general` | `canonical_search_menu/0.1` | `adaptationGoal equals breathing_posture` |
| `breathing_regulation_body_awareness_body_awareness` | `breathing_regulation_body_awareness` | 3 | `adaptationGoal` | Perceção corporal | 1 | true | true | `general` | `canonical_search_menu/0.1` | `adaptationGoal equals body_awareness` |
| `breathing_regulation_body_awareness_body_scan` | `breathing_regulation_body_awareness` | 3 | `adaptationGoal` | Body scan | 2 | true | true | `general` | `canonical_search_menu/0.1` | `adaptationGoal equals body_scan` |
| `breathing_regulation_body_awareness_mindful_movement` | `breathing_regulation_body_awareness` | 3 | `adaptationGoal` | Movimento consciente | 3 | true | true | `general` | `canonical_search_menu/0.1` | `adaptationGoal equals mindful_movement` |
| `warmup` |  | 1 | `usageContext` | Aquecimento | 8 | true | false | `warmup` | `canonical_search_menu/0.1` | `usageContext equals warmup` |
| `warmup_general` | `warmup` | 2 | `conceptFamily` | Geral | 0 | true | false | `warmup` | `canonical_search_menu/0.1` | `conceptFamily contains general` |
| `warmup_general_temperature_increase` | `warmup_general` | 3 | `adaptationGoal` | Aumento de temperatura | 0 | true | true | `warmup` | `canonical_search_menu/0.1` | `adaptationGoal equals temperature_increase` |
| `warmup_general_light_cardio` | `warmup_general` | 3 | `adaptationGoal` | Cardio leve | 1 | true | true | `warmup` | `canonical_search_menu/0.1` | `adaptationGoal equals light_cardio` |
| `warmup_general_global_mobilization` | `warmup_general` | 3 | `adaptationGoal` | Mobilização global | 2 | true | true | `warmup` | `canonical_search_menu/0.1` | `adaptationGoal equals global_mobilization` |
| `warmup_specific` | `warmup` | 2 | `conceptFamily` | Específico | 1 | true | false | `joint` | `canonical_search_menu/0.1` | `conceptFamily contains specific` |
| `warmup_specific_body_region` | `warmup_specific` | 3 | `anatomicalRegion` | Região corporal | 0 | true | true | `joint` | `canonical_search_menu/0.1` | `bodyRegion equals body_region` |
| `warmup_specific_joint` | `warmup_specific` | 3 | `anatomicalRegion` | Articulação | 1 | true | true | `joint` | `canonical_search_menu/0.1` | `bodyRegion equals joint` |
| `warmup_specific_movement_pattern` | `warmup_specific` | 3 | `anatomicalRegion` | Padrão de movimento | 2 | true | true | `joint` | `canonical_search_menu/0.1` | `bodyRegion equals movement_pattern` |
| `warmup_specific_equipment_future_task` | `warmup_specific` | 3 | `anatomicalRegion` | Equipamento ou tarefa futura | 3 | true | true | `joint` | `canonical_search_menu/0.1` | `bodyRegion equals equipment_future_task` |
| `warmup_technical` | `warmup` | 2 | `conceptFamily` | Técnico | 2 | true | false | `technique` | `canonical_search_menu/0.1` | `conceptFamily contains technical` |
| `warmup_technical_strength_preparation` | `warmup_technical` | 3 | `adaptationGoal` | Preparação para força | 0 | true | true | `technique` | `canonical_search_menu/0.1` | `adaptationGoal equals strength_preparation` |
| `warmup_technical_cardio_preparation` | `warmup_technical` | 3 | `adaptationGoal` | Preparação para cardio | 1 | true | true | `technique` | `canonical_search_menu/0.1` | `adaptationGoal equals cardio_preparation` |
| `warmup_technical_martial_arts_preparation` | `warmup_technical` | 3 | `adaptationGoal` | Preparação para artes marciais | 2 | true | true | `technique` | `canonical_search_menu/0.1` | `adaptationGoal equals martial_arts_preparation` |
| `warmup_technical_sport_specific_preparation` | `warmup_technical` | 3 | `adaptationGoal` | Preparação para desporto específico | 3 | true | true | `technique` | `canonical_search_menu/0.1` | `adaptationGoal equals sport_specific_preparation` |
| `activation` |  | 1 | `usageContext` | Ativação | 9 | true | false | `activation` | `canonical_search_menu/0.1` | `usageContext equals activation` |
| `activation_muscular` | `activation` | 2 | `conceptFamily` | Muscular | 0 | true | false | `strength` | `canonical_search_menu/0.1` | `conceptFamily contains muscular` |
| `activation_muscular_glutes` | `activation_muscular` | 3 | `anatomicalRegion` | Glúteos | 0 | true | true | `strength` | `canonical_search_menu/0.1` | `bodyRegion equals glutes` |
| `activation_muscular_core` | `activation_muscular` | 3 | `anatomicalRegion` | Core | 1 | true | true | `strength` | `canonical_search_menu/0.1` | `bodyRegion equals core` |
| `activation_muscular_scapulae` | `activation_muscular` | 3 | `anatomicalRegion` | Escápulas | 2 | true | true | `strength` | `canonical_search_menu/0.1` | `bodyRegion equals scapulae` |
| `activation_muscular_upper_limbs` | `activation_muscular` | 3 | `anatomicalRegion` | Membros superiores | 3 | true | true | `strength` | `canonical_search_menu/0.1` | `bodyRegion equals upper_limbs` |
| `activation_muscular_lower_limbs` | `activation_muscular` | 3 | `anatomicalRegion` | Membros inferiores | 4 | true | true | `strength` | `canonical_search_menu/0.1` | `bodyRegion equals lower_limbs` |
| `activation_articular` | `activation` | 2 | `conceptFamily` | Articular | 1 | true | false | `joint` | `canonical_search_menu/0.1` | `conceptFamily contains articular` |
| `activation_articular_shoulder` | `activation_articular` | 3 | `anatomicalRegion` | Ombro | 0 | true | true | `joint` | `canonical_search_menu/0.1` | `joint equals shoulder` |
| `activation_articular_hip` | `activation_articular` | 3 | `anatomicalRegion` | Anca | 1 | true | true | `joint` | `canonical_search_menu/0.1` | `joint equals hip` |
| `activation_articular_knee` | `activation_articular` | 3 | `anatomicalRegion` | Joelho | 2 | true | true | `joint` | `canonical_search_menu/0.1` | `joint equals knee` |
| `activation_articular_ankle` | `activation_articular` | 3 | `anatomicalRegion` | Tornozelo | 3 | true | true | `joint` | `canonical_search_menu/0.1` | `joint equals ankle` |
| `activation_articular_spine_trunk` | `activation_articular` | 3 | `anatomicalRegion` | Coluna e tronco | 4 | true | true | `joint` | `canonical_search_menu/0.1` | `joint equals spine_trunk` |
| `activation_movement_pattern` | `activation` | 2 | `conceptFamily` | Padrão de movimento | 2 | true | false | `movement` | `canonical_search_menu/0.1` | `conceptFamily contains movement_pattern` |
| `activation_movement_pattern_push` | `activation_movement_pattern` | 3 | `movementPattern` | Empurrar | 0 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals push` |
| `activation_movement_pattern_pull` | `activation_movement_pattern` | 3 | `movementPattern` | Puxar | 1 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals pull` |
| `activation_movement_pattern_squat` | `activation_movement_pattern` | 3 | `movementPattern` | Agachar | 2 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals squat` |
| `activation_movement_pattern_hinge` | `activation_movement_pattern` | 3 | `movementPattern` | Hinge | 3 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals hinge` |
| `activation_movement_pattern_run_locomote` | `activation_movement_pattern` | 3 | `movementPattern` | Correr e deslocar | 4 | true | true | `movement` | `canonical_search_menu/0.1` | `movementPattern equals run_locomote` |
| `activation_neuromotor` | `activation` | 2 | `conceptFamily` | Neuromotora | 3 | true | false | `coordination` | `canonical_search_menu/0.1` | `conceptFamily contains neuromotor` |
| `activation_neuromotor_balance` | `activation_neuromotor` | 3 | `adaptationGoal` | Equilíbrio | 0 | true | true | `coordination` | `canonical_search_menu/0.1` | `adaptationGoal equals balance` |
| `activation_neuromotor_coordination` | `activation_neuromotor` | 3 | `adaptationGoal` | Coordenação | 1 | true | true | `coordination` | `canonical_search_menu/0.1` | `adaptationGoal equals coordination` |
| `activation_neuromotor_rhythm` | `activation_neuromotor` | 3 | `adaptationGoal` | Ritmo | 2 | true | true | `coordination` | `canonical_search_menu/0.1` | `adaptationGoal equals rhythm` |
| `activation_neuromotor_reaction` | `activation_neuromotor` | 3 | `adaptationGoal` | Reação | 3 | true | true | `coordination` | `canonical_search_menu/0.1` | `adaptationGoal equals reaction` |
| `recovery_cooldown` |  | 1 | `usageContext` | Recuperação e retorno à calma | 10 | true | false | `recovery` | `canonical_search_menu/0.1` | `usageContext equals recovery_cooldown` |
| `recovery_cooldown_active_recovery` | `recovery_cooldown` | 2 | `conceptFamily` | Recuperação ativa | 0 | true | false | `recovery` | `canonical_search_menu/0.1` | `conceptFamily contains cooldown_active_recovery` |
| `recovery_cooldown_active_recovery_light_locomotion` | `recovery_cooldown_active_recovery` | 3 | `movementPattern` | Locomoção leve | 0 | true | true | `recovery` | `canonical_search_menu/0.1` | `movementPattern equals light_locomotion` |
| `recovery_cooldown_active_recovery_light_cyclic_movement` | `recovery_cooldown_active_recovery` | 3 | `movementPattern` | Movimento cíclico leve | 1 | true | true | `recovery` | `canonical_search_menu/0.1` | `movementPattern equals light_cyclic_movement` |
| `recovery_cooldown_active_recovery_low_intensity_global_movement` | `recovery_cooldown_active_recovery` | 3 | `movementPattern` | Movimento global de baixa intensidade | 2 | true | true | `recovery` | `canonical_search_menu/0.1` | `movementPattern equals low_intensity_global_movement` |
| `recovery_cooldown_mobility_flexibility` | `recovery_cooldown` | 2 | `conceptFamily` | Mobilidade e flexibilidade suave | 1 | true | false | `mobility` | `canonical_search_menu/0.1` | `conceptFamily contains cooldown_mobility_flexibility` |
| `recovery_cooldown_mobility_flexibility_upper_body` | `recovery_cooldown_mobility_flexibility` | 3 | `anatomicalRegion` | Parte superior | 0 | true | true | `mobility` | `canonical_search_menu/0.1` | `bodyRegion equals upper_body` |
| `recovery_cooldown_mobility_flexibility_lower_body` | `recovery_cooldown_mobility_flexibility` | 3 | `anatomicalRegion` | Parte inferior | 1 | true | true | `mobility` | `canonical_search_menu/0.1` | `bodyRegion equals lower_body` |
| `recovery_cooldown_mobility_flexibility_spine_trunk` | `recovery_cooldown_mobility_flexibility` | 3 | `anatomicalRegion` | Coluna e tronco | 2 | true | true | `mobility` | `canonical_search_menu/0.1` | `bodyRegion equals spine_trunk` |
| `recovery_cooldown_mobility_flexibility_full_body` | `recovery_cooldown_mobility_flexibility` | 3 | `anatomicalRegion` | Corpo inteiro | 3 | true | true | `mobility` | `canonical_search_menu/0.1` | `bodyRegion equals full_body` |
| `recovery_cooldown_breathing_relaxation` | `recovery_cooldown` | 2 | `conceptFamily` | Respiração e relaxamento | 2 | true | false | `breathing` | `canonical_search_menu/0.1` | `conceptFamily contains cooldown_breathing_relaxation` |
| `recovery_cooldown_breathing_relaxation_slow_breathing` | `recovery_cooldown_breathing_relaxation` | 3 | `adaptationGoal` | Respiração lenta | 0 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals slow_breathing` |
| `recovery_cooldown_breathing_relaxation_prolonged_exhalation` | `recovery_cooldown_breathing_relaxation` | 3 | `adaptationGoal` | Expiração prolongada | 1 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals prolonged_exhalation` |
| `recovery_cooldown_breathing_relaxation_body_relaxation` | `recovery_cooldown_breathing_relaxation` | 3 | `adaptationGoal` | Relaxamento corporal | 2 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals body_relaxation` |
| `recovery_cooldown_breathing_relaxation_reduced_activation` | `recovery_cooldown_breathing_relaxation` | 3 | `adaptationGoal` | Redução de ativação | 3 | true | true | `breathing` | `canonical_search_menu/0.1` | `adaptationGoal equals reduced_activation` |
| `recovery_cooldown_gradual_rest` | `recovery_cooldown` | 2 | `conceptFamily` | Retorno gradual ao repouso | 3 | true | false | `recovery` | `canonical_search_menu/0.1` | `conceptFamily contains cooldown_gradual_rest` |
| `recovery_cooldown_gradual_rest_progressive_pace_reduction` | `recovery_cooldown_gradual_rest` | 3 | `adaptationGoal` | Redução progressiva do ritmo | 0 | true | true | `recovery` | `canonical_search_menu/0.1` | `adaptationGoal equals progressive_pace_reduction` |
| `recovery_cooldown_gradual_rest_breathing_normalization` | `recovery_cooldown_gradual_rest` | 3 | `adaptationGoal` | Normalização respiratória | 1 | true | true | `recovery` | `canonical_search_menu/0.1` | `adaptationGoal equals breathing_normalization` |
| `recovery_cooldown_gradual_rest_release_relaxation` | `recovery_cooldown_gradual_rest` | 3 | `adaptationGoal` | Descarga e relaxamento | 2 | true | true | `recovery` | `canonical_search_menu/0.1` | `adaptationGoal equals release_relaxation` |
| `prevention_adaptation_return` |  | 1 | `usageContext` | Prevenção, adaptação e retorno à função | 11 | true | false | `prevention` | `canonical_search_menu/0.1` | `usageContext equals prevention_adaptation_return` |
| `prevention_adaptation_return_stability_control` | `prevention_adaptation_return` | 2 | `conceptFamily` | Estabilidade e controlo | 0 | true | false | `balance` | `canonical_search_menu/0.1` | `conceptFamily contains adaptation_return_stability_control` |
| `prevention_adaptation_return_stability_control_joint_stability` | `prevention_adaptation_return_stability_control` | 3 | `adaptationGoal` | Estabilidade articular | 0 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals joint_stability` |
| `prevention_adaptation_return_stability_control_postural_control` | `prevention_adaptation_return_stability_control` | 3 | `adaptationGoal` | Controlo postural | 1 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals postural_control` |
| `prevention_adaptation_return_stability_control_alignment` | `prevention_adaptation_return_stability_control` | 3 | `adaptationGoal` | Alinhamento | 2 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals alignment` |
| `prevention_adaptation_return_stability_control_landing_control` | `prevention_adaptation_return_stability_control` | 3 | `adaptationGoal` | Controlo de aterragem | 3 | true | true | `balance` | `canonical_search_menu/0.1` | `adaptationGoal equals landing_control` |
| `prevention_adaptation_return_load_tolerance` | `prevention_adaptation_return` | 2 | `conceptFamily` | Tolerância progressiva à carga | 1 | true | false | `strength` | `canonical_search_menu/0.1` | `conceptFamily contains adaptation_return_load_tolerance` |
| `prevention_adaptation_return_load_tolerance_muscle_tendon` | `prevention_adaptation_return_load_tolerance` | 3 | `adaptationGoal` | Músculo e tendão | 0 | true | true | `strength` | `canonical_search_menu/0.1` | `adaptationGoal equals muscle_tendon` |
| `prevention_adaptation_return_load_tolerance_joint` | `prevention_adaptation_return_load_tolerance` | 3 | `adaptationGoal` | Articulação | 1 | true | true | `strength` | `canonical_search_menu/0.1` | `adaptationGoal equals joint` |
| `prevention_adaptation_return_load_tolerance_spine` | `prevention_adaptation_return_load_tolerance` | 3 | `adaptationGoal` | Coluna | 2 | true | true | `strength` | `canonical_search_menu/0.1` | `adaptationGoal equals spine` |
| `prevention_adaptation_return_load_tolerance_repetition_volume` | `prevention_adaptation_return_load_tolerance` | 3 | `adaptationGoal` | Repetição e volume | 3 | true | true | `strength` | `canonical_search_menu/0.1` | `adaptationGoal equals repetition_volume` |
| `prevention_adaptation_return_tissue_conditioning` | `prevention_adaptation_return` | 2 | `conceptFamily` | Condicionamento dos tecidos | 2 | true | false | `tissue` | `canonical_search_menu/0.1` | `conceptFamily contains adaptation_return_tissue_conditioning` |
| `prevention_adaptation_return_tissue_conditioning_pressure` | `prevention_adaptation_return_tissue_conditioning` | 3 | `adaptationGoal` | Pressão | 0 | true | true | `tissue` | `canonical_search_menu/0.1` | `adaptationGoal equals pressure` |
| `prevention_adaptation_return_tissue_conditioning_friction` | `prevention_adaptation_return_tissue_conditioning` | 3 | `adaptationGoal` | Fricção | 1 | true | true | `tissue` | `canonical_search_menu/0.1` | `adaptationGoal equals friction` |
| `prevention_adaptation_return_tissue_conditioning_contact` | `prevention_adaptation_return_tissue_conditioning` | 3 | `adaptationGoal` | Contacto | 2 | true | true | `tissue` | `canonical_search_menu/0.1` | `adaptationGoal equals contact` |
| `prevention_adaptation_return_tissue_conditioning_controlled_impact` | `prevention_adaptation_return_tissue_conditioning` | 3 | `adaptationGoal` | Impacto controlado | 3 | true | true | `tissue` | `canonical_search_menu/0.1` | `adaptationGoal equals controlled_impact` |
| `prevention_adaptation_return_tissue_conditioning_progressive_callusing` | `prevention_adaptation_return_tissue_conditioning` | 3 | `adaptationGoal` | Calejamento progressivo | 4 | true | true | `tissue` | `canonical_search_menu/0.1` | `adaptationGoal equals progressive_callusing` |
| `prevention_adaptation_return_gradual_activity` | `prevention_adaptation_return` | 2 | `conceptFamily` | Retorno gradual à atividade | 3 | true | false | `movement` | `canonical_search_menu/0.1` | `conceptFamily contains adaptation_return_gradual_activity` |
| `prevention_adaptation_return_gradual_activity_basic_movement` | `prevention_adaptation_return_gradual_activity` | 3 | `adaptationGoal` | Movimento básico | 0 | true | true | `movement` | `canonical_search_menu/0.1` | `adaptationGoal equals basic_movement` |
| `prevention_adaptation_return_gradual_activity_range_recovery` | `prevention_adaptation_return_gradual_activity` | 3 | `adaptationGoal` | Recuperação de amplitude | 1 | true | true | `movement` | `canonical_search_menu/0.1` | `adaptationGoal equals range_recovery` |
| `prevention_adaptation_return_gradual_activity_control_recovery` | `prevention_adaptation_return_gradual_activity` | 3 | `adaptationGoal` | Recuperação de controlo | 2 | true | true | `movement` | `canonical_search_menu/0.1` | `adaptationGoal equals control_recovery` |
| `prevention_adaptation_return_gradual_activity_effort_progression` | `prevention_adaptation_return_gradual_activity` | 3 | `adaptationGoal` | Progressão de esforço | 3 | true | true | `movement` | `canonical_search_menu/0.1` | `adaptationGoal equals effort_progression` |
| `prevention_adaptation_return_gradual_activity_technique_return` | `prevention_adaptation_return_gradual_activity` | 3 | `adaptationGoal` | Regresso à técnica | 4 | true | true | `movement` | `canonical_search_menu/0.1` | `adaptationGoal equals technique_return` |
