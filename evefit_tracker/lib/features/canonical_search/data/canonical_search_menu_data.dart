import '../models/canonical_search_models.dart';

class CanonicalSearchMenuData {
  const CanonicalSearchMenuData._();

  static final List<CanonicalSearchFilterNode> nodes = List.unmodifiable(
    _buildNodes(),
  );

  static List<CanonicalSearchFilterNode> _buildNodes() {
    final nodes = <CanonicalSearchFilterNode>[];
    for (var rootIndex = 0; rootIndex < _roots.length; rootIndex++) {
      final root = _roots[rootIndex];
      nodes.add(
        CanonicalSearchFilterNode(
          id: root.id,
          parentId: null,
          axis: root.axis,
          depth: 1,
          displayNamePtPt: root.name,
          descriptionPtPt: root.description,
          iconKey: root.iconKey,
          displayOrder: rootIndex,
          queryContract: CanonicalSearchQueryContract(
            conditions: [
              CanonicalSearchCondition(
                field: root.queryField,
                operator: CanonicalSearchQueryOperator.equals,
                value: root.queryValue,
              ),
            ],
          ),
          isEnabled: true,
          isTerminal: false,
          schemaVersion: canonicalSearchMenuSchemaVersion,
        ),
      );
      for (var groupIndex = 0; groupIndex < root.groups.length; groupIndex++) {
        final group = root.groups[groupIndex];
        nodes.add(
          CanonicalSearchFilterNode(
            id: group.id,
            parentId: root.id,
            axis: group.axis,
            depth: 2,
            displayNamePtPt: group.name,
            descriptionPtPt: group.description(root.name),
            iconKey: group.iconKey,
            displayOrder: groupIndex,
            queryContract: CanonicalSearchQueryContract(
              conditions: [
                CanonicalSearchCondition(
                  field: CanonicalSearchQueryField.conceptFamily,
                  operator: CanonicalSearchQueryOperator.contains,
                  value: group.queryValue,
                ),
              ],
            ),
            isEnabled: true,
            isTerminal: false,
            schemaVersion: canonicalSearchMenuSchemaVersion,
          ),
        );
        for (
          var terminalIndex = 0;
          terminalIndex < group.terminals.length;
          terminalIndex++
        ) {
          final terminal = group.terminals[terminalIndex];
          nodes.add(
            CanonicalSearchFilterNode(
              id: terminal.id,
              parentId: group.id,
              axis: terminal.axis,
              depth: 3,
              displayNamePtPt: terminal.name,
              descriptionPtPt: terminal.description(root.name, group.name),
              iconKey: terminal.iconKey ?? group.iconKey,
              displayOrder: terminalIndex,
              queryContract: CanonicalSearchQueryContract(
                conditions: [
                  CanonicalSearchCondition(
                    field: terminal.queryField,
                    operator: CanonicalSearchQueryOperator.equals,
                    value: terminal.queryValue,
                  ),
                ],
              ),
              isEnabled: true,
              isTerminal: true,
              schemaVersion: canonicalSearchMenuSchemaVersion,
            ),
          );
        }
      }
    }
    return nodes;
  }

  static final _roots = <_RootSeed>[
    _RootSeed.capability(
      id: 'muscular_capacity',
      name: 'Força e capacidade muscular',
      description:
          'Explora capacidades de produção de força, suporte e controlo muscular.',
      iconKey: CanonicalSearchIconKey.strength,
      groups: [
        _GroupSeed.anatomy(
          id: 'muscular_capacity_upper_body',
          name: 'Parte superior',
          iconKey: CanonicalSearchIconKey.upperBody,
          terms: [
            'chest:Peito',
            'back:Costas',
            'shoulders:Ombros',
            'arms:Braços',
          ],
        ),
        _GroupSeed.anatomy(
          id: 'muscular_capacity_lower_body',
          name: 'Parte inferior',
          iconKey: CanonicalSearchIconKey.lowerBody,
          terms: [
            'glutes:Glúteos',
            'thighs:Coxas',
            'lower_leg:Perna inferior',
            'foot_ankle:Pé e tornozelo',
          ],
        ),
        _GroupSeed.anatomy(
          id: 'muscular_capacity_core_trunk',
          name: 'Core e tronco',
          iconKey: CanonicalSearchIconKey.core,
          terms: [
            'anterior:Anterior',
            'lateral:Lateral',
            'posterior:Posterior',
            'rotation_anti_rotation:Rotação e anti-rotação',
          ],
        ),
        _GroupSeed.movement(
          id: 'muscular_capacity_full_body',
          name: 'Corpo inteiro',
          iconKey: CanonicalSearchIconKey.fullBody,
          terms: [
            'push:Empurrar',
            'pull:Puxar',
            'squat:Agachar',
            'hip_hinge_extension:Hinge e extensão da anca',
            'carry_transport:Carregar e transportar',
          ],
        ),
      ],
    ),
    _RootSeed.capability(
      id: 'cardio_conditioning',
      name: 'Cardio e condicionamento',
      description:
          'Organiza a pesquisa por formas de elevar a capacidade cardiovascular e o condicionamento.',
      iconKey: CanonicalSearchIconKey.cardio,
      groups: [
        _GroupSeed.movement(
          id: 'cardio_conditioning_no_machines',
          name: 'Sem máquinas',
          iconKey: CanonicalSearchIconKey.walkRun,
          terms: [
            'walk_run:Caminhada e corrida',
            'jumps_bodyweight:Saltos e peso corporal',
            'rope:Corda',
            'agility_locomotion:Agilidade e deslocamentos',
          ],
        ),
        _GroupSeed.modality(
          id: 'cardio_conditioning_with_machines',
          name: 'Com máquinas',
          iconKey: CanonicalSearchIconKey.machine,
          terms: [
            'treadmill:Passadeira',
            'bicycle:Bicicleta',
            'rowing:Remo',
            'elliptical:Elíptica',
            'stairs_steppers:Escadas e steppers',
            'arm_full_body_ergometers:Ergómetros de braços ou corpo inteiro',
          ],
        ),
        _GroupSeed.modality(
          id: 'cardio_conditioning_outdoor_modalities',
          name: 'Exterior e modalidades',
          iconKey: CanonicalSearchIconKey.outdoor,
          terms: [
            'cycling:Ciclismo',
            'swimming:Natação',
            'trail_mountain:Trilho e montanha',
            'rowing_kayak_paddle:Remo, kayak e paddle',
            'wheel_sports:Desportos de rodas',
          ],
        ),
        _GroupSeed.modality(
          id: 'cardio_conditioning_rhythmic_combat',
          name: 'Rítmico e combate',
          iconKey: CanonicalSearchIconKey.combat,
          terms: [
            'dance_aerobics:Dança e aeróbica',
            'shadow:Shadow',
            'bag_work:Trabalho de saco',
            'combat_footwork:Footwork e deslocamento de combate',
          ],
        ),
      ],
    ),
    _RootSeed.capability(
      id: 'speed_power',
      name: 'Velocidade e potência',
      description:
          'Reúne padrões explosivos, acelerações e respostas rápidas ao movimento.',
      iconKey: CanonicalSearchIconKey.speed,
      groups: [
        _GroupSeed.movement(
          id: 'speed_power_acceleration_sprint',
          name: 'Aceleração e sprint',
          iconKey: CanonicalSearchIconKey.speed,
          terms: [
            'linear_acceleration:Aceleração linear',
            'sprint:Sprint',
            'start_departure:Arranque e saída',
            'uphill_resistance:Subida ou resistência',
          ],
        ),
        _GroupSeed.movement(
          id: 'speed_power_jumps_plyometrics',
          name: 'Saltos e pliometria',
          iconKey: CanonicalSearchIconKey.movement,
          terms: [
            'vertical:Vertical',
            'horizontal:Horizontal',
            'lateral:Lateral',
            'unilateral:Unilateral',
            'reactive:Reativo',
          ],
        ),
        _GroupSeed.movement(
          id: 'speed_power_throws_ballistic',
          name: 'Lançamentos e movimentos balísticos',
          iconKey: CanonicalSearchIconKey.movement,
          terms: [
            'frontal:Frontal',
            'overhead:Acima da cabeça',
            'rotational:Rotacional',
            'bottom_up:De baixo para cima',
          ],
        ),
        _GroupSeed.movement(
          id: 'speed_power_change_direction_reaction',
          name: 'Mudança de direção e reação',
          iconKey: CanonicalSearchIconKey.coordination,
          terms: [
            'planned_change:Mudança planeada',
            'reactive_change:Mudança reativa',
            'multidirectional:Multidirecional',
            'stimulus_response:Resposta a estímulo',
          ],
        ),
      ],
    ),
    _RootSeed.capability(
      id: 'mobility',
      name: 'Mobilidade',
      description:
          'Agrupa movimentos de amplitude ativa e controlo articular por região corporal.',
      iconKey: CanonicalSearchIconKey.mobility,
      groups: [
        _GroupSeed.joint(
          id: 'mobility_upper_body',
          name: 'Parte superior',
          iconKey: CanonicalSearchIconKey.upperBody,
          terms: ['shoulder:Ombro', 'elbow:Cotovelo', 'wrist_hand:Punho e mão'],
        ),
        _GroupSeed.joint(
          id: 'mobility_lower_body',
          name: 'Parte inferior',
          iconKey: CanonicalSearchIconKey.lowerBody,
          terms: ['hip:Anca', 'knee:Joelho', 'ankle_foot:Tornozelo e pé'],
        ),
        _GroupSeed.anatomy(
          id: 'mobility_spine_trunk',
          name: 'Coluna e tronco',
          iconKey: CanonicalSearchIconKey.core,
          terms: [
            'cervical:Cervical',
            'thoracic:Torácica',
            'lumbar:Lombar',
            'trunk_rotation:Rotação do tronco',
          ],
        ),
      ],
    ),
    _RootSeed.capability(
      id: 'flexibility',
      name: 'Flexibilidade',
      description:
          'Estrutura a pesquisa por amplitudes sustentadas e cadeias corporais.',
      iconKey: CanonicalSearchIconKey.flexibility,
      groups: [
        _GroupSeed.anatomy(
          id: 'flexibility_upper_body',
          name: 'Parte superior',
          iconKey: CanonicalSearchIconKey.upperBody,
          terms: [
            'chest:Peito',
            'shoulders:Ombros',
            'arms:Braços',
            'back:Costas',
          ],
        ),
        _GroupSeed.anatomy(
          id: 'flexibility_lower_body',
          name: 'Parte inferior',
          iconKey: CanonicalSearchIconKey.lowerBody,
          terms: [
            'hip_glutes:Anca e glúteos',
            'quadriceps:Quadríceps',
            'hamstrings:Posteriores da coxa',
            'adductors_abductors:Adutores e abdutores',
            'calves_ankle:Gémeos e tornozelo',
          ],
        ),
        _GroupSeed.anatomy(
          id: 'flexibility_trunk_body_chains',
          name: 'Tronco e cadeias corporais',
          iconKey: CanonicalSearchIconKey.core,
          terms: [
            'anterior_chain:Cadeia anterior',
            'posterior_chain:Cadeia posterior',
            'lateral_chains:Cadeias laterais',
            'rotation:Rotação',
            'full_body:Corpo inteiro',
          ],
        ),
      ],
    ),
    _RootSeed.capability(
      id: 'motor_control_coordination',
      name: 'Controlo motor e coordenação',
      description:
          'Explora equilíbrio, organização motora e respostas coordenadas.',
      iconKey: CanonicalSearchIconKey.coordination,
      groups: [
        _GroupSeed.adaptation(
          id: 'motor_control_coordination_balance',
          name: 'Equilíbrio',
          iconKey: CanonicalSearchIconKey.balance,
          terms: [
            'static:Estático',
            'dynamic:Dinâmico',
            'unilateral:Unilateral',
            'locomotion:Em deslocamento',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'motor_control_coordination_coordination',
          name: 'Coordenação',
          iconKey: CanonicalSearchIconKey.coordination,
          terms: [
            'full_body:Corpo inteiro',
            'hand_eye:Mão-olho',
            'foot_eye:Pé-olho',
            'bilateral:Coordenação bilateral',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'motor_control_coordination_proprioception_stability',
          name: 'Proprioceção e estabilidade',
          iconKey: CanonicalSearchIconKey.balance,
          terms: [
            'joint_stability:Estabilidade articular',
            'postural_control:Controlo postural',
            'landing:Aterragem',
            'alignment:Alinhamento',
          ],
        ),
        _GroupSeed.movement(
          id: 'motor_control_coordination_agility_reaction',
          name: 'Agilidade e reação',
          iconKey: CanonicalSearchIconKey.speed,
          terms: [
            'rhythm:Ritmo',
            'visual_response:Resposta visual',
            'sound_response:Resposta sonora',
            'change_direction:Mudança de direção',
            'motor_decision:Decisão motora',
          ],
        ),
      ],
    ),
    _RootSeed.capability(
      id: 'technique_skill',
      name: 'Técnica e habilidade',
      description:
          'Organiza modalidades e padrões técnicos sem associar exercícios específicos.',
      iconKey: CanonicalSearchIconKey.technique,
      groups: [
        _GroupSeed.modality(
          id: 'technique_skill_martial_combat',
          name: 'Artes marciais e combate',
          iconKey: CanonicalSearchIconKey.combat,
          terms: [
            'striking:Striking',
            'grappling:Grappling',
            'defense_locomotion:Defesa e deslocamento',
            'ground_transitions:Solo e transições',
          ],
        ),
        _GroupSeed.modality(
          id: 'technique_skill_sport_technique',
          name: 'Técnica desportiva',
          iconKey: CanonicalSearchIconKey.technique,
          terms: [
            'running:Técnica de corrida',
            'swimming:Técnica de natação',
            'cycling:Técnica de ciclismo',
            'jumps_throws:Saltos e lançamentos',
            'sport_specific:Técnica específica de modalidade',
          ],
        ),
        _GroupSeed.modality(
          id: 'technique_skill_dance_expression',
          name: 'Dança e expressão motora',
          iconKey: CanonicalSearchIconKey.coordination,
          terms: [
            'steps:Passos',
            'sequences:Sequências',
            'rhythm:Ritmo',
            'musical_coordination:Coordenação musical',
          ],
        ),
        _GroupSeed.modality(
          id: 'technique_skill_object_control',
          name: 'Controlo de objetos',
          iconKey: CanonicalSearchIconKey.general,
          terms: [
            'ball:Bola',
            'racket:Raquete',
            'bat_implement:Bastão ou implemento',
            'throw_catch:Lançar e receber',
          ],
        ),
      ],
    ),
    _RootSeed.capability(
      id: 'breathing_regulation',
      name: 'Respiração e regulação corporal',
      description:
          'Explora padrões respiratórios e estratégias de regulação corporal.',
      iconKey: CanonicalSearchIconKey.breathing,
      groups: [
        _GroupSeed.adaptation(
          id: 'breathing_regulation_mechanics',
          name: 'Mecânica respiratória',
          iconKey: CanonicalSearchIconKey.breathing,
          terms: [
            'diaphragmatic:Diafragmática',
            'costal:Costal',
            'nasal:Nasal',
            'breath_movement:Coordenação respiração-movimento',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'breathing_regulation_rhythm_control',
          name: 'Controlo do ritmo respiratório',
          iconKey: CanonicalSearchIconKey.breathing,
          terms: [
            'cadence:Cadência',
            'prolonged_exhalation:Expiração prolongada',
            'controlled_rhythm:Ritmo controlado',
            'controlled_pauses:Pausas respiratórias controladas',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'breathing_regulation_relaxation',
          name: 'Relaxamento e regulação',
          iconKey: CanonicalSearchIconKey.recovery,
          terms: [
            'slow_breathing:Respiração lenta',
            'reduced_activation:Redução de ativação',
            'cooldown:Retorno à calma',
            'focus_concentration:Foco e concentração',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'breathing_regulation_body_awareness',
          name: 'Consciência corporal',
          iconKey: CanonicalSearchIconKey.general,
          terms: [
            'breathing_posture:Postura respiratória',
            'body_awareness:Perceção corporal',
            'body_scan:Body scan',
            'mindful_movement:Movimento consciente',
          ],
        ),
      ],
    ),
    _RootSeed.context(
      id: 'warmup',
      name: 'Aquecimento',
      description: 'Organiza opções de preparação gradual para uma sessão.',
      iconKey: CanonicalSearchIconKey.warmup,
      groups: [
        _GroupSeed.adaptation(
          id: 'warmup_general',
          name: 'Geral',
          iconKey: CanonicalSearchIconKey.warmup,
          terms: [
            'temperature_increase:Aumento de temperatura',
            'light_cardio:Cardio leve',
            'global_mobilization:Mobilização global',
          ],
        ),
        _GroupSeed.anatomy(
          id: 'warmup_specific',
          name: 'Específico',
          iconKey: CanonicalSearchIconKey.joint,
          terms: [
            'body_region:Região corporal',
            'joint:Articulação',
            'movement_pattern:Padrão de movimento',
            'equipment_future_task:Equipamento ou tarefa futura',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'warmup_technical',
          name: 'Técnico',
          iconKey: CanonicalSearchIconKey.technique,
          terms: [
            'strength_preparation:Preparação para força',
            'cardio_preparation:Preparação para cardio',
            'martial_arts_preparation:Preparação para artes marciais',
            'sport_specific_preparation:Preparação para desporto específico',
          ],
        ),
      ],
    ),
    _RootSeed.context(
      id: 'activation',
      name: 'Ativação',
      description:
          'Agrupa preparação direcionada antes de esforço ou prática técnica.',
      iconKey: CanonicalSearchIconKey.activation,
      groups: [
        _GroupSeed.anatomy(
          id: 'activation_muscular',
          name: 'Muscular',
          iconKey: CanonicalSearchIconKey.strength,
          terms: [
            'glutes:Glúteos',
            'core:Core',
            'scapulae:Escápulas',
            'upper_limbs:Membros superiores',
            'lower_limbs:Membros inferiores',
          ],
        ),
        _GroupSeed.joint(
          id: 'activation_articular',
          name: 'Articular',
          iconKey: CanonicalSearchIconKey.joint,
          terms: [
            'shoulder:Ombro',
            'hip:Anca',
            'knee:Joelho',
            'ankle:Tornozelo',
            'spine_trunk:Coluna e tronco',
          ],
        ),
        _GroupSeed.movement(
          id: 'activation_movement_pattern',
          name: 'Padrão de movimento',
          iconKey: CanonicalSearchIconKey.movement,
          terms: [
            'push:Empurrar',
            'pull:Puxar',
            'squat:Agachar',
            'hinge:Hinge',
            'run_locomote:Correr e deslocar',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'activation_neuromotor',
          name: 'Neuromotora',
          iconKey: CanonicalSearchIconKey.coordination,
          terms: [
            'balance:Equilíbrio',
            'coordination:Coordenação',
            'rhythm:Ritmo',
            'reaction:Reação',
          ],
        ),
      ],
    ),
    _RootSeed.context(
      id: 'recovery_cooldown',
      name: 'Recuperação e retorno à calma',
      description:
          'Organiza escolhas de redução gradual de esforço e regulação pós-sessão.',
      iconKey: CanonicalSearchIconKey.recovery,
      groups: [
        _GroupSeed.movement(
          id: 'recovery_cooldown_active_recovery',
          name: 'Recuperação ativa',
          iconKey: CanonicalSearchIconKey.recovery,
          terms: [
            'light_locomotion:Locomoção leve',
            'light_cyclic_movement:Movimento cíclico leve',
            'low_intensity_global_movement:Movimento global de baixa intensidade',
          ],
        ),
        _GroupSeed.anatomy(
          id: 'recovery_cooldown_mobility_flexibility',
          name: 'Mobilidade e flexibilidade suave',
          iconKey: CanonicalSearchIconKey.mobility,
          terms: [
            'upper_body:Parte superior',
            'lower_body:Parte inferior',
            'spine_trunk:Coluna e tronco',
            'full_body:Corpo inteiro',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'recovery_cooldown_breathing_relaxation',
          name: 'Respiração e relaxamento',
          iconKey: CanonicalSearchIconKey.breathing,
          terms: [
            'slow_breathing:Respiração lenta',
            'prolonged_exhalation:Expiração prolongada',
            'body_relaxation:Relaxamento corporal',
            'reduced_activation:Redução de ativação',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'recovery_cooldown_gradual_rest',
          name: 'Retorno gradual ao repouso',
          iconKey: CanonicalSearchIconKey.recovery,
          terms: [
            'progressive_pace_reduction:Redução progressiva do ritmo',
            'breathing_normalization:Normalização respiratória',
            'release_relaxation:Descarga e relaxamento',
          ],
        ),
      ],
    ),
    _RootSeed.context(
      id: 'prevention_adaptation_return',
      name: 'Prevenção, adaptação e retorno à função',
      description:
          'Organiza progressões gerais de controlo, tolerância e retorno à atividade.',
      iconKey: CanonicalSearchIconKey.prevention,
      groups: [
        _GroupSeed.adaptation(
          id: 'prevention_adaptation_return_stability_control',
          name: 'Estabilidade e controlo',
          iconKey: CanonicalSearchIconKey.balance,
          terms: [
            'joint_stability:Estabilidade articular',
            'postural_control:Controlo postural',
            'alignment:Alinhamento',
            'landing_control:Controlo de aterragem',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'prevention_adaptation_return_load_tolerance',
          name: 'Tolerância progressiva à carga',
          iconKey: CanonicalSearchIconKey.strength,
          terms: [
            'muscle_tendon:Músculo e tendão',
            'joint:Articulação',
            'spine:Coluna',
            'repetition_volume:Repetição e volume',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'prevention_adaptation_return_tissue_conditioning',
          name: 'Condicionamento dos tecidos',
          iconKey: CanonicalSearchIconKey.tissue,
          terms: [
            'pressure:Pressão',
            'friction:Fricção',
            'contact:Contacto',
            'controlled_impact:Impacto controlado',
            'progressive_callusing:Calejamento progressivo',
          ],
        ),
        _GroupSeed.adaptation(
          id: 'prevention_adaptation_return_gradual_activity',
          name: 'Retorno gradual à atividade',
          iconKey: CanonicalSearchIconKey.movement,
          terms: [
            'basic_movement:Movimento básico',
            'range_recovery:Recuperação de amplitude',
            'control_recovery:Recuperação de controlo',
            'effort_progression:Progressão de esforço',
            'technique_return:Regresso à técnica',
          ],
        ),
      ],
    ),
  ];
}

class _RootSeed {
  const _RootSeed._({
    required this.id,
    required this.name,
    required this.description,
    required this.axis,
    required this.queryField,
    required this.queryValue,
    required this.iconKey,
    required this.groups,
  });

  const _RootSeed.capability({
    required String id,
    required String name,
    required String description,
    required CanonicalSearchIconKey iconKey,
    required List<_GroupSeed> groups,
  }) : this._(
         id: id,
         name: name,
         description: description,
         axis: CanonicalSearchAxis.capabilityRoot,
         queryField: CanonicalSearchQueryField.capability,
         queryValue: id,
         iconKey: iconKey,
         groups: groups,
       );

  const _RootSeed.context({
    required String id,
    required String name,
    required String description,
    required CanonicalSearchIconKey iconKey,
    required List<_GroupSeed> groups,
  }) : this._(
         id: id,
         name: name,
         description: description,
         axis: CanonicalSearchAxis.usageContext,
         queryField: CanonicalSearchQueryField.usageContext,
         queryValue: id,
         iconKey: iconKey,
         groups: groups,
       );

  final String id;
  final String name;
  final String description;
  final CanonicalSearchAxis axis;
  final CanonicalSearchQueryField queryField;
  final String queryValue;
  final CanonicalSearchIconKey iconKey;
  final List<_GroupSeed> groups;
}

class _GroupSeed {
  const _GroupSeed._({
    required this.id,
    required this.name,
    required this.axis,
    required this.iconKey,
    required this.terminalAxis,
    required this.terminalField,
    required this.terms,
  });

  factory _GroupSeed.anatomy({
    required String id,
    required String name,
    required CanonicalSearchIconKey iconKey,
    required List<String> terms,
  }) => _GroupSeed._(
    id: id,
    name: name,
    axis: CanonicalSearchAxis.conceptFamily,
    iconKey: iconKey,
    terminalAxis: CanonicalSearchAxis.anatomicalRegion,
    terminalField: CanonicalSearchQueryField.bodyRegion,
    terms: terms,
  );

  factory _GroupSeed.joint({
    required String id,
    required String name,
    required CanonicalSearchIconKey iconKey,
    required List<String> terms,
  }) => _GroupSeed._(
    id: id,
    name: name,
    axis: CanonicalSearchAxis.conceptFamily,
    iconKey: iconKey,
    terminalAxis: CanonicalSearchAxis.anatomicalRegion,
    terminalField: CanonicalSearchQueryField.joint,
    terms: terms,
  );

  factory _GroupSeed.movement({
    required String id,
    required String name,
    required CanonicalSearchIconKey iconKey,
    required List<String> terms,
  }) => _GroupSeed._(
    id: id,
    name: name,
    axis: CanonicalSearchAxis.conceptFamily,
    iconKey: iconKey,
    terminalAxis: CanonicalSearchAxis.movementPattern,
    terminalField: CanonicalSearchQueryField.movementPattern,
    terms: terms,
  );

  factory _GroupSeed.modality({
    required String id,
    required String name,
    required CanonicalSearchIconKey iconKey,
    required List<String> terms,
  }) => _GroupSeed._(
    id: id,
    name: name,
    axis: CanonicalSearchAxis.modality,
    iconKey: iconKey,
    terminalAxis: CanonicalSearchAxis.modality,
    terminalField: CanonicalSearchQueryField.modality,
    terms: terms,
  );

  factory _GroupSeed.adaptation({
    required String id,
    required String name,
    required CanonicalSearchIconKey iconKey,
    required List<String> terms,
  }) => _GroupSeed._(
    id: id,
    name: name,
    axis: CanonicalSearchAxis.conceptFamily,
    iconKey: iconKey,
    terminalAxis: CanonicalSearchAxis.adaptationGoal,
    terminalField: CanonicalSearchQueryField.adaptationGoal,
    terms: terms,
  );

  final String id;
  final String name;
  final CanonicalSearchAxis axis;
  final CanonicalSearchIconKey iconKey;
  final CanonicalSearchAxis terminalAxis;
  final CanonicalSearchQueryField terminalField;
  final List<String> terms;

  String get queryValue => id.substring(id.indexOf('_') + 1);

  String description(String rootName) =>
      'Agrupa escolhas de $name dentro de $rootName para refinar a pesquisa canónica.';

  List<_TerminalSeed> get terminals => terms
      .map((entry) {
        final parts = entry.split(':');
        final slug = parts.first;
        final label = parts.sublist(1).join(':');
        return _TerminalSeed(
          id: '${id}_$slug',
          name: label,
          axis: terminalAxis,
          queryField: terminalField,
          queryValue: slug,
          iconKey: null,
        );
      })
      .toList(growable: false);
}

class _TerminalSeed {
  const _TerminalSeed({
    required this.id,
    required this.name,
    required this.axis,
    required this.queryField,
    required this.queryValue,
    required this.iconKey,
  });

  final String id;
  final String name;
  final CanonicalSearchAxis axis;
  final CanonicalSearchQueryField queryField;
  final String queryValue;
  final CanonicalSearchIconKey? iconKey;

  String description(String rootName, String groupName) {
    final focus = switch (axis) {
      CanonicalSearchAxis.anatomicalRegion => 'a região ou articulação',
      CanonicalSearchAxis.movementPattern => 'o padrão de movimento',
      CanonicalSearchAxis.modality => 'a modalidade ou meio de prática',
      CanonicalSearchAxis.adaptationGoal => 'a finalidade de adaptação',
      _ => 'o conceito de pesquisa',
    };
    return 'Delimita $focus "$name" no grupo $groupName de $rootName.';
  }
}
