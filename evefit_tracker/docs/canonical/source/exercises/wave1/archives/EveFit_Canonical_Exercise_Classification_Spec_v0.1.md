# EveFit — Especificação Canónica de Classificação de Exercícios v0.1

**Estado:** especificação de produto para investigação, documentação, validação e futura implementação  
**Idioma:** português europeu  
**Codificação:** UTF-8  
**Âmbito:** identidade do exercício, atributos, compatibilidades, requisitos, risco, elegibilidade e proveniência  
**Fora do âmbito:** prescrição individual, diagnóstico, tratamento, autorização clínica, geração automática de exercícios e implementação de código

---

## 0. Objetivo

Este documento é a fonte canónica para classificar qualquer exercício na EveFit.

Cada exercício analisado deve responder a todos os campos e testes aqui definidos. Um campo não pode ser simplesmente ignorado: deve ser preenchido, marcado como `not_applicable`, `none`, `unknown_pending_review` ou rejeitado com justificação.

A classificação só é considerada concluída quando:

1. a entidade foi identificada corretamente como exercício, variante, família, protocolo, método, prescrição ou não-exercício;
2. a identidade canónica foi distinguida de variantes e prescrições;
3. os atributos mecânicos, anatómicos, técnicos, materiais, ambientais e de risco foram documentados;
4. as compatibilidades com os quatro pilares foram registadas como relações completas de percurso;
5. os dados foram revistos e validados;
6. não existem contradições internas;
7. a entrada passou os critérios de aceitação deste documento.

---

## 1. Princípio central da EveFit

> **Os pilares classificam. Os atributos identificam e distinguem. A prescrição operacionaliza a intenção.**

Consequências:

- Contexto, Capacidade, Conceito de treino e Intenção não definem sozinhos a identidade do exercício.
- Um mesmo exercício pode ser compatível com vários percursos sem ser duplicado.
- Equipamento, local e ambiente não definem a identidade da intenção.
- Equipamento, local, ambiente, parceiro, alvo, superfície e supervisão pertencem ao exercício, à variante ou à elegibilidade.
- Carga, volume, intensidade, duração, ritmo, cadência, descanso e frequência pertencem à prescrição, salvo quando uma alteração muda materialmente a identidade técnica do exercício.
- Protocolos como HIIT, Tabata, EMOM ou AMRAP não são exercícios.

---

## 2. Quatro pilares canónicos

Cada compatibilidade do exercício deve ser representada por uma relação completa:

1. `usage_context`
2. `capability_root`
3. `training_concept`
4. `training_intention`

Não usar uma lista plana de etiquetas independentes para inferir todas as combinações possíveis.

Exemplo correto:

```yaml
path_compatibility:
  usage_context_id: main_training
  capability_root_id: cardio_conditioning
  training_concept_id: cyclic_locomotion
  training_intention_id: develop_aerobic_endurance
```

Exemplo incorreto:

```yaml
tags:
  - main_training
  - cardio_conditioning
  - cyclic_locomotion
  - develop_aerobic_endurance
```

O exemplo incorreto permitiria combinações que podem nunca ter sido aprovadas.

---

## 3. Tipos de entidade

Antes de classificar, determinar o tipo real da entidade.

### 3.1 `canonical_exercise`

Identidade técnica estável, reconhecível e suficientemente distinta.

### 3.2 `exercise_variant`

Forma de um exercício-base com alteração relevante, mas que ainda preserva a identidade nuclear.

### 3.3 `exercise_family`

Agrupamento de exercícios relacionados, não selecionável como exercício concreto.

### 3.4 `protocol`

Estrutura temporal ou organizativa aplicada a exercícios.

### 3.5 `prescription`

Forma concreta de usar o exercício.

### 3.6 `technique_drill`

Exercício cujo propósito técnico imediato é praticar um componente delimitado de uma habilidade.

### 3.7 `activity_or_task`

Atividade demasiado ampla ou variável para ser um único exercício.

### 3.8 `not_an_exercise`

Equipamento, ambiente, posição, músculo, objetivo, intenção, protocolo ou descrição sem ação executável.

---

## 4. Regra de identidade canónica

Criar uma nova identidade quando a alteração muda materialmente um ou mais destes elementos:

1. mecânica essencial;
2. técnica essencial;
3. trajetória;
4. direção de força;
5. forma de aplicação ou receção de força;
6. articulações ativas principais;
7. organização de suporte;
8. cadeia cinética;
9. alvo funcional imediato;
10. propósito técnico imediato;
11. relação corpo-carga;
12. relação corpo-superfície;
13. coordenação ou sequência motora nuclear;
14. presença ou ausência de deslocamento global relevante;
15. presença ou ausência de fase balística, aérea, reativa ou sustentada quando isso transforma a ação.

Não criar nova identidade apenas por mudança de:

- carga;
- repetições;
- séries;
- duração;
- distância;
- descanso;
- frequência;
- ritmo;
- intensidade;
- RPE;
- velocidade prescrita, salvo mudança técnica material;
- amplitude prescrita, salvo mudança material da técnica;
- ordem dentro de uma sessão.

---

## 5. Teste obrigatório: exercício, variante ou prescrição

Responder sequencialmente:

1. Existe uma ação motora executável e observável?
2. A ação tem início, organização técnica e resultado mecânico identificáveis?
3. O nome descreve uma ação, e não um objetivo ou protocolo?
4. A alteração em análise muda a técnica essencial?
5. Muda a trajetória?
6. Muda as articulações ativas principais?
7. Muda a forma de aplicar ou receber força?
8. Muda o suporte, a cadeia cinética ou a relação corpo-carga?
9. Muda o alvo funcional ou técnico imediato?
10. A mudança é apenas dose, ritmo, carga, volume ou duração?
11. A entidade pode ser descrita sem depender de uma intenção específica?
12. A entidade continua reconhecível quando usada noutro contexto válido?

Resultado obrigatório:

- nova identidade;
- variante;
- prescrição;
- família;
- protocolo;
- atividade ampla;
- rejeitada.

Toda a decisão deve conter justificação textual.

---

# PARTE I — IDENTIFICAÇÃO E PROVENIÊNCIA

## 6. Identificadores obrigatórios

```yaml
exercise_id:
name_pt_pt:
entity_type:
catalog_version:
record_status:
```

### 6.1 `exercise_id`

- inglês técnico simples;
- `snake_case`;
- estável;
- sem contexto, intenção, intensidade ou população;
- sem números de séries, repetições, duração ou carga.

### 6.2 `name_pt_pt`

Nome público em português europeu.

### 6.3 `entity_type`

Valores:

- `canonical_exercise`
- `exercise_variant`
- `exercise_family`
- `protocol`
- `prescription`
- `technique_drill`
- `activity_or_task`
- `not_an_exercise`

### 6.4 `record_status`

Valores:

- `draft`
- `researching`
- `specialist_review`
- `approved`
- `rejected`
- `deprecated`
- `superseded`

---

## 7. Proveniência

```yaml
provenance:
  created_by:
  reviewed_by: []
  source_codes: []
  evidence_basis:
  evidence_limit_pt_pt:
  decision_log_reference:
  previous_ids: []
  replaces_ids: []
  superseded_by:
```

Nenhuma fonte externa pode ser tratada como autoridade automática. As fontes informam; a decisão pertence ao processo de produto da EveFit.

---

# PARTE II — IDENTIDADE E DEFINIÇÃO

## 8. Definição canónica

```yaml
definitions:
  canonical_definition_pt_pt:
  identity_summary_pt_pt:
  technical_purpose_immediate_pt_pt:
```

A definição deve:

- descrever o que a pessoa faz;
- indicar a organização mecânica essencial;
- evitar dose e prescrição;
- evitar prometer resultados;
- evitar depender de uma intenção;
- permitir distinguir o exercício de outros semelhantes.

---

## 9. Sinónimos e nomes alternativos

```yaml
naming:
  synonyms_pt_pt: []
  common_english_names: []
  ambiguous_names: []
  prohibited_public_names: []
```

Sinónimos não criam novas identidades.

---

## 10. Família e relações de identidade

```yaml
identity_relations:
  exercise_family_id:
  base_exercise_id:
  variant_of:
  sibling_exercise_ids: []
  commonly_confused_with: []
  distinction_notes_pt_pt:
```

---

# PARTE III — ASSINATURA MECÂNICA

## 11. Ação motora

```yaml
mechanical_signature:
  primary_motor_action:
  secondary_motor_actions: []
  movement_pattern_family:
  cyclicity:
  continuity:
  repetition_structure:
  locomotion_present:
  whole_body_displacement:
  external_load_displacement:
```

`cyclicity`:

- `cyclic`
- `acyclic`
- `mixed`

`continuity`:

- `continuous_possible`
- `discrete_repetitions`
- `sustained_hold`
- `sequence`
- `reactive_repetition`
- `mixed`

---

## 12. Posição e orientação corporal

```yaml
body_configuration:
  starting_position:
  ending_position:
  body_orientation:
  base_of_support:
  support_contacts: []
  external_support:
  suspended:
  aquatic_support:
```

Valores possíveis de `body_orientation`:

- standing
- seated
- kneeling
- quadruped
- supine
- prone
- side_lying
- hanging
- inverted
- locomoting
- mixed

---

## 13. Trajetória e direção

```yaml
trajectory:
  body_trajectory:
  load_trajectory:
  primary_direction:
  secondary_directions: []
  path_shape:
  range_character:
  direction_changes:
```

---

## 14. Planos e eixos

```yaml
movement_planes:
  primary_planes: []
  secondary_planes: []
  multiplanar:
  rotational_component:
```

Valores:

- sagittal
- frontal
- transverse
- multiplanar

---

## 15. Articulações

```yaml
joints:
  primary_active_joints: []
  secondary_active_joints: []
  stabilized_joints: []
  primary_joint_actions: []
  coupled_joint_actions: []
```

Não preencher apenas com “corpo inteiro”. Identificar as articulações relevantes.

---

## 16. Cadeia cinética e suporte

```yaml
kinetic_chain:
  classification:
  support_pattern:
  unilateral_bilateral:
  alternating:
  symmetrical_asymmetrical:
  single_limb_support:
  double_limb_support:
```

`classification`:

- open_chain
- closed_chain
- mixed_chain
- not_applicable

---

## 17. Produção, absorção e transmissão de força

```yaml
force_profile:
  force_application_mode:
  force_reception_mode:
  braking_component:
  propulsive_component:
  elastic_reactive_component:
  ballistic_component:
  impact_present:
  external_resistance_present:
  bodyweight_resistance_present:
  gravity_role:
```

Não classificar “aeróbio” ou “anaeróbio” como identidade mecânica.

---

## 18. Regimes de ação muscular

```yaml
muscle_action_profile:
  concentric_present:
  eccentric_present:
  isometric_present:
  stretch_shortening_cycle:
  sustained_tension:
  rapid_force_application:
```

---

## 19. Lateralidade e coordenação

```yaml
coordination_structure:
  laterality:
  interlimb_pattern:
  ipsilateral_contralateral:
  segmental_sequence:
  rhythm_required:
  external_timing_required:
  reactive_stimulus_required:
  decision_component:
```

---

# PARTE IV — ANATOMIA

## 20. Regiões corporais

```yaml
anatomy:
  primary_body_regions: []
  secondary_body_regions: []
  whole_body:
```

Vocabulário inicial:

- upper_body
- lower_body
- core
- whole_body

---

## 21. Grupos musculares

```yaml
muscle_groups:
  primary_groups: []
  secondary_groups: []
  stabilizer_groups: []
```

A participação deve ser classificada por papel, não apenas por presença.

---

## 22. Músculos específicos

```yaml
muscles:
  primary_target_muscles: []
  secondary_muscles: []
  stabilizer_muscles: []
  isolated_target_supported:
  isolation_claim_limit_pt_pt:
```

Regras:

- não afirmar isolamento absoluto sem fundamento;
- não usar qualquer músculo participante como alvo principal;
- exercícios globais podem ter `primary_target_muscles: []`;
- `isolated_target_supported` deve ser falso quando a seletividade é apenas parcial.

---

## 23. Navegação anatómica da musculação

Aplicável sobretudo a `muscular_capacity`.

```yaml
muscular_navigation:
  applicable:
  upper_lower_full_body:
  muscle_group_options: []
  full_group_selectable:
  specific_muscle_options: []
  anatomical_filter_behavior:
```

`anatomical_filter_behavior`:

- `primary_target_only`
- `primary_and_secondary`
- `whole_group`
- `not_applicable`

Regras recomendadas:

- pesquisa por músculo específico: usar alvo principal;
- pesquisa por grupo muscular: pode incluir alvo principal e exercícios compostos relevantes;
- músculos estabilizadores não devem, por si só, fazer o exercício aparecer como resultado principal.

---

# PARTE V — EQUIPAMENTO, LOCAL E AMBIENTE

## 24. Equipamento

```yaml
equipment:
  required_equipment: []
  optional_equipment: []
  alternative_equipment_groups: []
  no_equipment_supported:
  personal_gear_requirements: []
  improvised_equipment_allowed:
  equipment_notes_pt_pt:
```

Regras:

- tudo o que é obrigatório deve existir no local ativo;
- cada grupo alternativo funciona em relação OU;
- equipamento opcional não exclui;
- equipamento improvisado só conta quando aprovado;
- não misturar equipamento de locais diferentes.

---

## 25. Parceiro, alvo e supervisão

```yaml
operational_requirements:
  partner_required:
  target_required:
  spotter_required:
  supervision_requirement:
  clinical_setting_required:
```

`supervision_requirement`:

- none
- recommended
- required
- clinically_required
- unknown_pending_review

---

## 26. Ambiente

```yaml
environment:
  indoor_compatible:
  outdoor_compatible:
  aquatic:
  altitude_sensitive:
  heat_sensitive:
  cold_sensitive:
  air_quality_sensitive:
  traffic_exposure_possible:
  lighting_requirement:
  noise_requirement:
```

---

## 27. Espaço e superfície

```yaml
space_surface:
  displacement_space_required:
  minimum_space_class:
  overhead_clearance_required:
  lateral_clearance_required:
  surface_requirements: []
  unsuitable_surfaces: []
  obstacle_free_path_required:
```

`minimum_space_class`:

- minimal_stationary
- small_stationary
- moderate_stationary
- linear_displacement
- multidirectional_displacement
- large_field
- aquatic_space
- specialized_facility

---

## 28. Compatibilidade com local

O exercício não contém uma lista fixa de locais do utilizador. Contém requisitos comparados com o `active_location_id`.

```yaml
location_compatibility:
  generic_location_types: []
  required_location_features: []
  prohibited_location_features: []
```

---

# PARTE VI — ATRIBUTOS TÉCNICOS E FUNCIONAIS

## 29. Complexidade técnica

```yaml
technical_demand:
  base_complexity:
  learning_requirement:
  coordination_demand:
  balance_demand:
  precision_demand:
  timing_demand:
  mobility_demand:
  stability_demand:
  decision_demand:
  predictability:
```

Escala fechada:

- low
- moderate
- high
- advanced
- variable
- not_applicable

---

## 30. Estabilidade

```yaml
stability:
  external_stability:
  internal_stability_demand:
  base_of_support_difficulty:
  unstable_surface_intrinsic:
  load_stability_demand:
```

---

## 31. Ritmo, velocidade e reatividade

```yaml
speed_reactivity:
  can_be_slow:
  can_be_fast:
  high_speed_intrinsic:
  ballistic_intrinsic:
  reactive_intrinsic:
  externally_paced_possible:
  self_paced_possible:
```

Não transformar velocidade prescrita em identidade, salvo quando a técnica muda materialmente.

---

## 32. Continuidade e duração possível

```yaml
execution_structure:
  repetition_based:
  duration_based:
  distance_based:
  hold_based:
  sequence_based:
  continuous_possible:
  interval_possible:
```

Estes campos indicam formas possíveis de prescrição, não a prescrição concreta.

---

## 33. Impacto e contacto

```yaml
contact_impact:
  ground_contact:
  aerial_phase:
  impact_level_base:
  repeated_contacts:
  landing_required:
  takeoff_required:
  collision_possible:
```

`impact_level_base`:

- none
- low
- moderate
- high
- variable

---

# PARTE VII — RISCO, ELEGIBILIDADE E SEGURANÇA

## 34. Risco operacional base

```yaml
risk:
  operational_risk_tier:
  principal_risk_factors: []
  contextual_risk_modifiers: []
  equipment_risk_modifiers: []
  environmental_risk_modifiers: []
  fatigue_risk_modifier:
```

Valores:

- low
- moderate
- high
- clinically_restricted

O risco base não substitui elegibilidade.

---

## 35. Revisão clínica

```yaml
clinical_review:
  required:
  reasons: []
  review_limit_pt_pt:
```

A revisão clínica é independente do risco operacional.

---

## 36. Elegibilidade

```yaml
eligibility:
  general_prerequisites: []
  contraindication_flags: []
  stop_or_reduce_signs: []
  populations_requiring_adaptation: []
  populations_requiring_review: []
  supervision_triggers: []
```

Não criar diagnósticos nem prescrever conduta clínica individual.

---

## 37. Regressões e progressões

```yaml
progression_relations:
  possible_regressions: []
  possible_progressions: []
  progression_dimensions: []
  regression_dimensions: []
```

Dimensões possíveis:

- support
- stability
- range
- speed
- load
- coordination
- complexity
- impact
- predictability
- displacement
- supervision

---

# PARTE VIII — COMPATIBILIDADE COM A ONTOLOGIA EVEFIT

## 38. Relações completas de percurso

```yaml
canonical_path_compatibilities:
  - usage_context_id:
    capability_root_id:
    training_concept_id:
    training_intention_id:
    compatibility_status:
    role:
    rationale_pt_pt:
    limits_pt_pt:
    contextual_risk_modifier:
    clinical_review_modifier:
```

`compatibility_status`:

- compatible
- conditional
- incompatible
- pending_review

`role`:

- principal_candidate
- alternative_primary
- complementary
- conditional_complementary
- hidden_advanced

---

## 39. Regras de compatibilidade

Uma relação só pode ser aprovada quando:

1. o contexto é coerente com a utilização;
2. a capacidade é realmente trabalhada;
3. o conceito descreve a ação do exercício;
4. a intenção pode ser operacionalizada por esse exercício;
5. a relação não depende de equipamento ou ambiente inexistente;
6. o risco não é reduzido indevidamente;
7. a elegibilidade não é presumida;
8. a relação não é inferida apenas por palavras semelhantes;
9. não existe uma incompatibilidade canónica no percurso;
10. a relação foi revista.

---

## 40. Atributos adicionais de filtragem

```yaml
filter_attributes:
  modality_tags: []
  mechanical_tags: []
  anatomical_tags: []
  technical_tags: []
  environment_tags: []
  equipment_tags: []
  risk_tags: []
```

Estas etiquetas são projeções para pesquisa. Não substituem os campos estruturados.

---

# PARTE IX — FRONTEIRA COM PRESCRIÇÃO

## 41. Campos proibidos na identidade do exercício

Não incluir como identidade canónica:

- séries;
- repetições;
- carga;
- percentagem de 1RM;
- RPE;
- RIR;
- velocidade prescrita;
- duração;
- distância;
- descanso;
- frequência semanal;
- tempo sob tensão;
- zona cardíaca;
- densidade;
- ordem da sessão;
- protocolo;
- progressão individual;
- regressão individual;
- amplitude individual prescrita.

---

## 42. Capacidades de prescrição suportadas

```yaml
prescription_capabilities:
  supports_repetitions:
  supports_sets:
  supports_duration:
  supports_distance:
  supports_load:
  supports_speed:
  supports_pace:
  supports_cadence:
  supports_hold_time:
  supports_intervals:
  supports_rest:
  supports_range_adjustment:
```

Isto não atribui qualquer dose.

---

# PARTE X — CONTEÚDO PÚBLICO

## 43. Nome e explicação para o utilizador

```yaml
public_content:
  short_description_pt_pt:
  execution_summary_pt_pt:
  principal_cues_pt_pt: []
  common_errors_pt_pt: []
  safety_note_pt_pt:
  equipment_display_pt_pt:
  environment_display_pt_pt:
```

---

## 44. Multimédia

```yaml
media:
  image_required:
  video_required:
  media_status:
  approved_media_ids: []
  prohibited_media_ids: []
```

---

# PARTE XI — EVIDÊNCIA E REVISÃO

## 45. Evidência

```yaml
evidence:
  evidence_basis:
  source_codes: []
  evidence_limit_pt_pt:
  direct_exercise_evidence:
  family_level_evidence:
  biomechanical_support:
  consensus_support:
```

Valores recomendados:

- strong_family_evidence
- moderate_family_evidence
- limited_family_evidence
- professional_consensus
- product_ontology_inference

---

## 46. Revisões obrigatórias

```yaml
reviews:
  semantic_review:
  biomechanical_review:
  training_review:
  safety_review:
  clinical_review:
  product_review:
  final_integrity_review:
```

Estados:

- not_started
- in_progress
- passed
- passed_with_limits
- failed
- not_applicable

---

# PARTE XII — TEMPLATE OBRIGATÓRIO POR EXERCÍCIO

## 47. Registo canónico completo

```yaml
exercise_record:
  exercise_id:
  name_pt_pt:
  entity_type:
  catalog_version:
  record_status:

  provenance:
    created_by:
    reviewed_by: []
    source_codes: []
    evidence_basis:
    evidence_limit_pt_pt:
    decision_log_reference:
    previous_ids: []
    replaces_ids: []
    superseded_by:

  definitions:
    canonical_definition_pt_pt:
    identity_summary_pt_pt:
    technical_purpose_immediate_pt_pt:

  naming:
    synonyms_pt_pt: []
    common_english_names: []
    ambiguous_names: []
    prohibited_public_names: []

  identity_relations:
    exercise_family_id:
    base_exercise_id:
    variant_of:
    sibling_exercise_ids: []
    commonly_confused_with: []
    distinction_notes_pt_pt:

  identity_decision:
    classification_result:
    new_identity_justification_pt_pt:
    variant_justification_pt_pt:
    prescription_boundary_pt_pt:

  mechanical_signature:
    primary_motor_action:
    secondary_motor_actions: []
    movement_pattern_family:
    cyclicity:
    continuity:
    repetition_structure:
    locomotion_present:
    whole_body_displacement:
    external_load_displacement:

  body_configuration:
    starting_position:
    ending_position:
    body_orientation:
    base_of_support:
    support_contacts: []
    external_support:
    suspended:
    aquatic_support:

  trajectory:
    body_trajectory:
    load_trajectory:
    primary_direction:
    secondary_directions: []
    path_shape:
    range_character:
    direction_changes:

  movement_planes:
    primary_planes: []
    secondary_planes: []
    multiplanar:
    rotational_component:

  joints:
    primary_active_joints: []
    secondary_active_joints: []
    stabilized_joints: []
    primary_joint_actions: []
    coupled_joint_actions: []

  kinetic_chain:
    classification:
    support_pattern:
    unilateral_bilateral:
    alternating:
    symmetrical_asymmetrical:
    single_limb_support:
    double_limb_support:

  force_profile:
    force_application_mode:
    force_reception_mode:
    braking_component:
    propulsive_component:
    elastic_reactive_component:
    ballistic_component:
    impact_present:
    external_resistance_present:
    bodyweight_resistance_present:
    gravity_role:

  muscle_action_profile:
    concentric_present:
    eccentric_present:
    isometric_present:
    stretch_shortening_cycle:
    sustained_tension:
    rapid_force_application:

  coordination_structure:
    laterality:
    interlimb_pattern:
    ipsilateral_contralateral:
    segmental_sequence:
    rhythm_required:
    external_timing_required:
    reactive_stimulus_required:
    decision_component:

  anatomy:
    primary_body_regions: []
    secondary_body_regions: []
    whole_body:

  muscle_groups:
    primary_groups: []
    secondary_groups: []
    stabilizer_groups: []

  muscles:
    primary_target_muscles: []
    secondary_muscles: []
    stabilizer_muscles: []
    isolated_target_supported:
    isolation_claim_limit_pt_pt:

  muscular_navigation:
    applicable:
    upper_lower_full_body:
    muscle_group_options: []
    full_group_selectable:
    specific_muscle_options: []
    anatomical_filter_behavior:

  equipment:
    required_equipment: []
    optional_equipment: []
    alternative_equipment_groups: []
    no_equipment_supported:
    personal_gear_requirements: []
    improvised_equipment_allowed:
    equipment_notes_pt_pt:

  operational_requirements:
    partner_required:
    target_required:
    spotter_required:
    supervision_requirement:
    clinical_setting_required:

  environment:
    indoor_compatible:
    outdoor_compatible:
    aquatic:
    altitude_sensitive:
    heat_sensitive:
    cold_sensitive:
    air_quality_sensitive:
    traffic_exposure_possible:
    lighting_requirement:
    noise_requirement:

  space_surface:
    displacement_space_required:
    minimum_space_class:
    overhead_clearance_required:
    lateral_clearance_required:
    surface_requirements: []
    unsuitable_surfaces: []
    obstacle_free_path_required:

  location_compatibility:
    generic_location_types: []
    required_location_features: []
    prohibited_location_features: []

  technical_demand:
    base_complexity:
    learning_requirement:
    coordination_demand:
    balance_demand:
    precision_demand:
    timing_demand:
    mobility_demand:
    stability_demand:
    decision_demand:
    predictability:

  stability:
    external_stability:
    internal_stability_demand:
    base_of_support_difficulty:
    unstable_surface_intrinsic:
    load_stability_demand:

  speed_reactivity:
    can_be_slow:
    can_be_fast:
    high_speed_intrinsic:
    ballistic_intrinsic:
    reactive_intrinsic:
    externally_paced_possible:
    self_paced_possible:

  execution_structure:
    repetition_based:
    duration_based:
    distance_based:
    hold_based:
    sequence_based:
    continuous_possible:
    interval_possible:

  contact_impact:
    ground_contact:
    aerial_phase:
    impact_level_base:
    repeated_contacts:
    landing_required:
    takeoff_required:
    collision_possible:

  risk:
    operational_risk_tier:
    principal_risk_factors: []
    contextual_risk_modifiers: []
    equipment_risk_modifiers: []
    environmental_risk_modifiers: []
    fatigue_risk_modifier:

  clinical_review:
    required:
    reasons: []
    review_limit_pt_pt:

  eligibility:
    general_prerequisites: []
    contraindication_flags: []
    stop_or_reduce_signs: []
    populations_requiring_adaptation: []
    populations_requiring_review: []
    supervision_triggers: []

  progression_relations:
    possible_regressions: []
    possible_progressions: []
    progression_dimensions: []
    regression_dimensions: []

  canonical_path_compatibilities:
    - usage_context_id:
      capability_root_id:
      training_concept_id:
      training_intention_id:
      compatibility_status:
      role:
      rationale_pt_pt:
      limits_pt_pt:
      contextual_risk_modifier:
      clinical_review_modifier:

  filter_attributes:
    modality_tags: []
    mechanical_tags: []
    anatomical_tags: []
    technical_tags: []
    environment_tags: []
    equipment_tags: []
    risk_tags: []

  prescription_capabilities:
    supports_repetitions:
    supports_sets:
    supports_duration:
    supports_distance:
    supports_load:
    supports_speed:
    supports_pace:
    supports_cadence:
    supports_hold_time:
    supports_intervals:
    supports_rest:
    supports_range_adjustment:

  public_content:
    short_description_pt_pt:
    execution_summary_pt_pt:
    principal_cues_pt_pt: []
    common_errors_pt_pt: []
    safety_note_pt_pt:
    equipment_display_pt_pt:
    environment_display_pt_pt:

  media:
    image_required:
    video_required:
    media_status:
    approved_media_ids: []
    prohibited_media_ids: []

  evidence:
    evidence_basis:
    source_codes: []
    evidence_limit_pt_pt:
    direct_exercise_evidence:
    family_level_evidence:
    biomechanical_support:
    consensus_support:

  reviews:
    semantic_review:
    biomechanical_review:
    training_review:
    safety_review:
    clinical_review:
    product_review:
    final_integrity_review:
```

---

# PARTE XIII — VALIDAÇÕES OBRIGATÓRIAS

## 48. Validações de identidade

- `exercise_id` único;
- nome não ambíguo sem nota;
- definição sem prescrição;
- distinção explícita de exercícios semelhantes;
- exercício versus variante justificado;
- protocolo e prescrição excluídos;
- ausência de duplicação semântica;
- identidade não dependente de um único contexto.

## 49. Validações mecânicas

- ação motora identificada;
- posição documentada;
- trajetória documentada;
- articulações documentadas;
- força documentada;
- cadeia cinética documentada;
- lateralidade documentada;
- coordenação documentada;
- impacto documentado;
- nenhuma contradição entre campos.

## 50. Validações anatómicas

- regiões classificadas;
- grupos musculares separados por papel;
- músculos específicos apenas quando defensáveis;
- estabilizadores não promovidos a alvo principal;
- anatomia da musculação preenchida quando aplicável;
- ausência de promessa de isolamento absoluto.

## 51. Validações materiais

- equipamento obrigatório fechado;
- alternativas representadas como grupos OU;
- equipamento opcional não exclui;
- parceiro, alvo e supervisão separados;
- local representado por requisitos, não por inventário agregado;
- superfície e espaço documentados.

## 52. Validações dos quatro pilares

- cada compatibilidade é uma relação completa;
- não existem combinações inferidas por produto cartesiano;
- todos os IDs existem nos registos canónicos;
- nenhum percurso incompatível recebe exercício;
- intenção compatível justificada;
- papel e limites documentados;
- risco e revisão nunca reduzidos.

## 53. Validações de risco

- risco operacional base atribuído;
- revisão clínica separada;
- modificadores contextuais documentados;
- elegibilidade não presumida;
- sinais de interrupção documentados;
- linguagem não clínica e não prescritiva.

## 54. Validações de prescrição

- nenhum campo de dose dentro da identidade;
- capacidades de prescrição separadas;
- ritmo, carga, volume e duração não criam identidade sem justificação mecânica;
- protocolo não tratado como exercício.

---

# PARTE XIV — CRITÉRIO FINAL DE APROVAÇÃO

## 55. Estado `approved`

Um exercício só recebe `record_status: approved` quando:

1. passou o teste exercício/variante/prescrição;
2. possui identidade única;
3. todos os campos obrigatórios estão preenchidos;
4. todos os `unknown_pending_review` foram resolvidos ou formalmente aceites;
5. passou revisão semântica;
6. passou revisão biomecânica;
7. passou revisão de treino;
8. passou revisão de segurança;
9. passou revisão clínica quando aplicável;
10. passou revisão de produto;
11. passou validação das compatibilidades com os quatro pilares;
12. passou auditoria de duplicação;
13. passou auditoria de equipamento, local e ambiente;
14. passou auditoria anatómica;
15. passou validação final de integridade.

---

## 56. Regra de falha fechada

Quando existir dúvida material sobre identidade, variante, risco, equipamento, anatomia, compatibilidade, elegibilidade, definição ou evidência, a entrada não é aprovada por aproximação.

Usar:

```yaml
record_status: specialist_review
```

ou:

```yaml
compatibility_status: pending_review
```

A ausência de certeza não pode ser escondida por texto convincente.

---

## 57. Regra de continuidade

Esta especificação deve ser aplicada a todos os exercícios futuros.

Alterações ao modelo exigem:

1. nova versão da especificação;
2. razão documentada;
3. avaliação de impacto nas entradas existentes;
4. migração ou validação retroativa;
5. aprovação de produto;
6. preservação do histórico.

Nenhuma equipa de agentes pode alterar silenciosamente os campos, enums ou regras enquanto produz o catálogo.

---

## 58. Resultado esperado por exercício

Cada exercício aprovado produz:

1. uma identidade canónica;
2. uma definição pública;
3. uma assinatura mecânica;
4. anatomia estruturada;
5. requisitos materiais e ambientais;
6. risco e elegibilidade;
7. compatibilidades completas com os quatro pilares;
8. fronteira clara com variantes e prescrição;
9. proveniência;
10. revisão auditável;
11. registo estruturado pronto para futura implementação.
