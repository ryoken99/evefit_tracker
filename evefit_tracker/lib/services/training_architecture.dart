import '../models/exercise.dart';
import 'workout_taxonomy.dart';

class TrainingRegion {
  const TrainingRegion({
    required this.key,
    required this.name,
    required this.description,
    required this.sortOrder,
  });

  final String key;
  final String name;
  final String description;
  final int sortOrder;
}

class TrainingGroup {
  const TrainingGroup({
    required this.key,
    required this.regionKey,
    required this.name,
    required this.description,
    required this.sortOrder,
  });

  final String key;
  final String regionKey;
  final String name;
  final String description;
  final int sortOrder;
}

class TrainingSubgroup {
  const TrainingSubgroup({
    required this.key,
    required this.regionKey,
    required this.groupKey,
    required this.name,
    required this.description,
    required this.sortOrder,
  });

  final String key;
  final String regionKey;
  final String groupKey;
  final String name;
  final String description;
  final int sortOrder;
}

class TrainingMuscle {
  const TrainingMuscle({
    required this.key,
    required this.regionKey,
    required this.groupKey,
    required this.subgroupKey,
    required this.name,
    required this.description,
    required this.sortOrder,
  });

  final String key;
  final String regionKey;
  final String groupKey;
  final String subgroupKey;
  final String name;
  final String description;
  final int sortOrder;
}

class TrainingEquipment {
  const TrainingEquipment({
    required this.key,
    required this.name,
    required this.category,
    required this.description,
  });

  final String key;
  final String name;
  final String category;
  final String description;
}

class TrainingSelection {
  const TrainingSelection({
    this.regionKey = '',
    this.groupKey = '',
    this.subgroupKey = '',
    this.specificMuscleKey = '',
    this.equipmentKey = '',
  });

  final String regionKey;
  final String groupKey;
  final String subgroupKey;
  final String specificMuscleKey;
  final String equipmentKey;

  bool get isEmpty =>
      regionKey.isEmpty &&
      groupKey.isEmpty &&
      subgroupKey.isEmpty &&
      specificMuscleKey.isEmpty &&
      equipmentKey.isEmpty;

  TrainingSelection copyWith({
    String? regionKey,
    String? groupKey,
    String? subgroupKey,
    String? specificMuscleKey,
    String? equipmentKey,
  }) {
    return TrainingSelection(
      regionKey: regionKey ?? this.regionKey,
      groupKey: groupKey ?? this.groupKey,
      subgroupKey: subgroupKey ?? this.subgroupKey,
      specificMuscleKey: specificMuscleKey ?? this.specificMuscleKey,
      equipmentKey: equipmentKey ?? this.equipmentKey,
    );
  }
}

class ExerciseAvailability {
  const ExerciseAvailability({
    required this.exercise,
    required this.isAvailable,
    required this.unavailableReason,
  });

  final Exercise exercise;
  final bool isAvailable;
  final String unavailableReason;
}

class ExerciseArchitectureTags {
  const ExerciseArchitectureTags({
    required this.regionKeys,
    required this.groupKeys,
    required this.subgroupKeys,
    required this.muscleKeys,
    required this.equipmentKeys,
  });

  final Set<String> regionKeys;
  final Set<String> groupKeys;
  final Set<String> subgroupKeys;
  final Set<String> muscleKeys;
  final Set<String> equipmentKeys;
}

class TrainingArchitecture {
  const TrainingArchitecture._();

  static const regions = [
    TrainingRegion(
      key: 'full_body',
      name: 'Corpo inteiro',
      description: 'Treinos globais e padrões compostos.',
      sortOrder: 1,
    ),
    TrainingRegion(
      key: 'upper',
      name: 'Parte superior',
      description: 'Pescoço, escápula, peito, costas, ombros e braços.',
      sortOrder: 2,
    ),
    TrainingRegion(
      key: 'lower',
      name: 'Parte inferior',
      description: 'Anca, glúteos, pernas, tornozelo e pés.',
      sortOrder: 3,
    ),
    TrainingRegion(
      key: 'core',
      name: 'Core',
      description: 'Abdominal, lombar e estabilidade do tronco.',
      sortOrder: 4,
    ),
    TrainingRegion(
      key: 'cardio',
      name: 'Cardio',
      description: 'Resistência, velocidade, intervalos e recuperação.',
      sortOrder: 5,
    ),
    TrainingRegion(
      key: 'martial_arts',
      name: 'Artes marciais',
      description: 'Karate, Jiu-Jitsu e preparação física associada.',
      sortOrder: 6,
    ),
    TrainingRegion(
      key: 'mobility_recovery',
      name: 'Mobilidade e recuperação',
      description: 'Mobilidade, alongamentos, respiração e postura.',
      sortOrder: 7,
    ),
    TrainingRegion(
      key: 'custom',
      name: 'Personalizado',
      description: 'Treinos livres e templates personalizados.',
      sortOrder: 8,
    ),
  ];

  static const groups = [
    TrainingGroup(
      key: 'neck',
      regionKey: 'upper',
      name: 'Pescoço',
      description: 'Musculatura cervical.',
      sortOrder: 1,
    ),
    TrainingGroup(
      key: 'traps_scapula',
      regionKey: 'upper',
      name: 'Trapézio / cintura escapular',
      description: 'Trapézio, romboides e estabilizadores escapulares.',
      sortOrder: 2,
    ),
    TrainingGroup(
      key: 'chest',
      regionKey: 'upper',
      name: 'Peito',
      description: 'Peitoral e auxiliares diretos.',
      sortOrder: 3,
    ),
    TrainingGroup(
      key: 'back',
      regionKey: 'upper',
      name: 'Costas',
      description: 'Dorsal, espessura das costas e lombar relacionada.',
      sortOrder: 4,
    ),
    TrainingGroup(
      key: 'shoulders',
      regionKey: 'upper',
      name: 'Ombros',
      description: 'Deltoides e manguito rotador.',
      sortOrder: 5,
    ),
    TrainingGroup(
      key: 'arms',
      regionKey: 'upper',
      name: 'Braços',
      description: 'Bíceps, tríceps, braquial e braquiorradial.',
      sortOrder: 6,
    ),
    TrainingGroup(
      key: 'forearm_hand',
      regionKey: 'upper',
      name: 'Antebraço / punho / mão',
      description: 'Punho, dedos e força de pega.',
      sortOrder: 7,
    ),
    TrainingGroup(
      key: 'hips_glutes',
      regionKey: 'lower',
      name: 'Anca / glúteos',
      description: 'Glúteos, flexores e rotadores da anca.',
      sortOrder: 1,
    ),
    TrainingGroup(
      key: 'quadriceps',
      regionKey: 'lower',
      name: 'Quadríceps',
      description: 'Extensão do joelho.',
      sortOrder: 2,
    ),
    TrainingGroup(
      key: 'hamstrings',
      regionKey: 'lower',
      name: 'Posterior de coxa',
      description: 'Flexão do joelho e extensão da anca.',
      sortOrder: 3,
    ),
    TrainingGroup(
      key: 'adductors',
      regionKey: 'lower',
      name: 'Adutores',
      description: 'Adução da anca.',
      sortOrder: 4,
    ),
    TrainingGroup(
      key: 'abductors',
      regionKey: 'lower',
      name: 'Abdutores',
      description: 'Abdução e estabilidade lateral da anca.',
      sortOrder: 5,
    ),
    TrainingGroup(
      key: 'calves',
      regionKey: 'lower',
      name: 'Gémeos / sóleo',
      description: 'Flexão plantar.',
      sortOrder: 6,
    ),
    TrainingGroup(
      key: 'tibialis',
      regionKey: 'lower',
      name: 'Tibial anterior',
      description: 'Dorsiflexão.',
      sortOrder: 7,
    ),
    TrainingGroup(
      key: 'feet_ankle',
      regionKey: 'lower',
      name: 'Pés / tornozelo',
      description: 'Estabilidade do pé e tornozelo.',
      sortOrder: 8,
    ),
    TrainingGroup(
      key: 'abdominal',
      regionKey: 'core',
      name: 'Abdominal',
      description: 'Reto abdominal.',
      sortOrder: 1,
    ),
    TrainingGroup(
      key: 'obliques',
      regionKey: 'core',
      name: 'Oblíquos',
      description: 'Rotação e inclinação do tronco.',
      sortOrder: 2,
    ),
    TrainingGroup(
      key: 'transverse_abs',
      regionKey: 'core',
      name: 'Transverso abdominal',
      description: 'Pressão intra-abdominal.',
      sortOrder: 3,
    ),
    TrainingGroup(
      key: 'low_back',
      regionKey: 'core',
      name: 'Lombar',
      description: 'Eretores e quadrado lombar.',
      sortOrder: 4,
    ),
    TrainingGroup(
      key: 'core_stability',
      regionKey: 'core',
      name: 'Estabilidade do core',
      description: 'Controlo global do tronco.',
      sortOrder: 5,
    ),
    TrainingGroup(
      key: 'anti_rotation',
      regionKey: 'core',
      name: 'Anti-rotação',
      description: 'Resistência à rotação.',
      sortOrder: 6,
    ),
    TrainingGroup(
      key: 'anti_extension',
      regionKey: 'core',
      name: 'Anti-extensão',
      description: 'Resistência à extensão lombar.',
      sortOrder: 7,
    ),
    TrainingGroup(
      key: 'anti_lateral_flexion',
      regionKey: 'core',
      name: 'Anti-flexão lateral',
      description: 'Resistência à inclinação lateral.',
      sortOrder: 8,
    ),
    TrainingGroup(
      key: 'cardio_general',
      regionKey: 'cardio',
      name: 'Cardio geral',
      description: 'Modalidades de cardio combinadas.',
      sortOrder: 1,
    ),
    TrainingGroup(
      key: 'cardio_machine',
      regionKey: 'cardio',
      name: 'Máquina de cardio',
      description: 'Passadeira, bicicleta e elíptica.',
      sortOrder: 2,
    ),
    TrainingGroup(
      key: 'jump_rope_group',
      regionKey: 'cardio',
      name: 'Corda de saltar',
      description: 'Coordenação e cardio com corda.',
      sortOrder: 3,
    ),
    TrainingGroup(
      key: 'outdoor_cardio',
      regionKey: 'cardio',
      name: 'Exterior',
      description: 'Caminhada, corrida e sprints.',
      sortOrder: 4,
    ),
    TrainingGroup(
      key: 'hiit_group',
      regionKey: 'cardio',
      name: 'HIIT',
      description: 'Intervalos de alta intensidade.',
      sortOrder: 5,
    ),
    TrainingGroup(
      key: 'karate',
      regionKey: 'martial_arts',
      name: 'Karate',
      description: 'Kihon, kata, kumite e técnica de Karate.',
      sortOrder: 1,
    ),
    TrainingGroup(
      key: 'jiu_jitsu',
      regionKey: 'martial_arts',
      name: 'Jiu-Jitsu',
      description: 'Grappling, guarda e movimentação no solo.',
      sortOrder: 2,
    ),
    TrainingGroup(
      key: 'martial_conditioning',
      regionKey: 'martial_arts',
      name: 'Condicionamento para artes marciais',
      description: 'Preparação física para artes marciais.',
      sortOrder: 3,
    ),
    TrainingGroup(
      key: 'martial_mobility',
      regionKey: 'martial_arts',
      name: 'Mobilidade para artes marciais',
      description: 'Mobilidade específica.',
      sortOrder: 4,
    ),
    TrainingGroup(
      key: 'grappling_grip',
      regionKey: 'martial_arts',
      name: 'Força de pega para grappling',
      description: 'Pega aplicada ao grappling.',
      sortOrder: 5,
    ),
    TrainingGroup(
      key: 'martial_core',
      regionKey: 'martial_arts',
      name: 'Core para artes marciais',
      description: 'Core aplicado a combate.',
      sortOrder: 6,
    ),
    TrainingGroup(
      key: 'general_mobility',
      regionKey: 'mobility_recovery',
      name: 'Mobilidade geral',
      description: 'Mobilidade global.',
      sortOrder: 1,
    ),
    TrainingGroup(
      key: 'shoulder_mobility',
      regionKey: 'mobility_recovery',
      name: 'Mobilidade de ombros',
      description: 'Ombros e escápulas.',
      sortOrder: 2,
    ),
    TrainingGroup(
      key: 'hip_mobility',
      regionKey: 'mobility_recovery',
      name: 'Mobilidade de anca',
      description: 'Ancas e bacia.',
      sortOrder: 3,
    ),
    TrainingGroup(
      key: 'ankle_mobility',
      regionKey: 'mobility_recovery',
      name: 'Mobilidade de tornozelo',
      description: 'Tornozelos.',
      sortOrder: 4,
    ),
    TrainingGroup(
      key: 'thoracic_mobility',
      regionKey: 'mobility_recovery',
      name: 'Mobilidade torácica',
      description: 'Coluna torácica.',
      sortOrder: 5,
    ),
    TrainingGroup(
      key: 'stretching',
      regionKey: 'mobility_recovery',
      name: 'Alongamentos',
      description: 'Flexibilidade.',
      sortOrder: 6,
    ),
    TrainingGroup(
      key: 'active_recovery',
      regionKey: 'mobility_recovery',
      name: 'Recuperação ativa',
      description: 'Baixa intensidade.',
      sortOrder: 7,
    ),
    TrainingGroup(
      key: 'breathing',
      regionKey: 'mobility_recovery',
      name: 'Respiração',
      description: 'Controlo respiratório.',
      sortOrder: 8,
    ),
    TrainingGroup(
      key: 'posture',
      regionKey: 'mobility_recovery',
      name: 'Postura',
      description: 'Alinhamento postural.',
      sortOrder: 9,
    ),
    TrainingGroup(
      key: 'custom_workout',
      regionKey: 'custom',
      name: 'Treino personalizado',
      description: 'Foco livre.',
      sortOrder: 1,
    ),
  ];

  static const subgroups = [
    TrainingSubgroup(
      key: 'anterior_arm',
      regionKey: 'upper',
      groupKey: 'arms',
      name: 'Braço anterior',
      description: 'Bíceps, braquial e braquiorradial.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'posterior_arm',
      regionKey: 'upper',
      groupKey: 'arms',
      name: 'Braço posterior',
      description: 'Tríceps.',
      sortOrder: 2,
    ),
    TrainingSubgroup(
      key: 'grip_strength',
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      name: 'Força de pega',
      description: 'Pega de suporte, pinça e punho.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'chest_primary',
      regionKey: 'upper',
      groupKey: 'chest',
      name: 'Peito',
      description: 'Peitoral superior, médio e inferior.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'back_width',
      regionKey: 'upper',
      groupKey: 'back',
      name: 'Costas largura',
      description: 'Dorsal e puxadas.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'back_thickness',
      regionKey: 'upper',
      groupKey: 'back',
      name: 'Costas espessura',
      description: 'Remadas e romboides.',
      sortOrder: 2,
    ),
    TrainingSubgroup(
      key: 'deltoids',
      regionKey: 'upper',
      groupKey: 'shoulders',
      name: 'Deltoides',
      description: 'Deltoide anterior, lateral e posterior.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'glutes',
      regionKey: 'lower',
      groupKey: 'hips_glutes',
      name: 'Glúteos',
      description: 'Glúteo máximo, médio e mínimo.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'quadriceps',
      regionKey: 'lower',
      groupKey: 'quadriceps',
      name: 'Quadríceps',
      description: 'Reto femoral e vastos.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'hamstrings',
      regionKey: 'lower',
      groupKey: 'hamstrings',
      name: 'Posterior de coxa',
      description: 'Bíceps femoral e isquiotibiais.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'calves',
      regionKey: 'lower',
      groupKey: 'calves',
      name: 'Gémeos e sóleo',
      description: 'Flexão plantar.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'adductors',
      regionKey: 'lower',
      groupKey: 'adductors',
      name: 'Adutores',
      description: 'Adução da anca.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'abductors',
      regionKey: 'lower',
      groupKey: 'abductors',
      name: 'Abdutores',
      description: 'Abdução da anca.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'core_general',
      regionKey: 'core',
      groupKey: 'core_stability',
      name: 'Core completo',
      description: 'Estabilidade global.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'treadmill',
      regionKey: 'cardio',
      groupKey: 'cardio_machine',
      name: 'Passadeira',
      description: 'Caminhada e corrida em passadeira.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'bike',
      regionKey: 'cardio',
      groupKey: 'cardio_machine',
      name: 'Bicicleta',
      description: 'Cardio em bicicleta.',
      sortOrder: 2,
    ),
    TrainingSubgroup(
      key: 'elliptical',
      regionKey: 'cardio',
      groupKey: 'cardio_machine',
      name: 'Elíptica',
      description: 'Cardio de baixo impacto.',
      sortOrder: 3,
    ),
    TrainingSubgroup(
      key: 'jump_rope',
      regionKey: 'cardio',
      groupKey: 'jump_rope_group',
      name: 'Corda de saltar',
      description: 'Cardio com corda.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'outdoor_walk',
      regionKey: 'cardio',
      groupKey: 'outdoor_cardio',
      name: 'Caminhada exterior',
      description: 'Caminhada no exterior.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'outdoor_run',
      regionKey: 'cardio',
      groupKey: 'outdoor_cardio',
      name: 'Corrida exterior',
      description: 'Corrida no exterior.',
      sortOrder: 2,
    ),
    TrainingSubgroup(
      key: 'hiit',
      regionKey: 'cardio',
      groupKey: 'hiit_group',
      name: 'HIIT',
      description: 'Intervalos intensos.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'karate_technical',
      regionKey: 'martial_arts',
      groupKey: 'karate',
      name: 'Karate técnico',
      description: 'Kihon, kata e kumite.',
      sortOrder: 1,
    ),
    TrainingSubgroup(
      key: 'jiu_jitsu_technical',
      regionKey: 'martial_arts',
      groupKey: 'jiu_jitsu',
      name: 'Jiu-Jitsu técnico',
      description: 'Grappling e transições.',
      sortOrder: 1,
    ),
  ];

  static const muscles = [
    TrainingMuscle(
      key: 'biceps',
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'anterior_arm',
      name: 'Bíceps',
      description: 'Flexão do cotovelo e supinação.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'brachialis',
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'anterior_arm',
      name: 'Braquial',
      description: 'Flexor profundo do cotovelo.',
      sortOrder: 2,
    ),
    TrainingMuscle(
      key: 'brachioradialis',
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'anterior_arm',
      name: 'Braquiorradial',
      description: 'Flexão do cotovelo em pega neutra.',
      sortOrder: 3,
    ),
    TrainingMuscle(
      key: 'triceps_long',
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'posterior_arm',
      name: 'Tríceps cabeça longa',
      description: 'Extensão do cotovelo e ombro.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'triceps_lateral',
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'posterior_arm',
      name: 'Tríceps cabeça lateral',
      description: 'Extensão do cotovelo.',
      sortOrder: 2,
    ),
    TrainingMuscle(
      key: 'triceps_medial',
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'posterior_arm',
      name: 'Tríceps cabeça medial',
      description: 'Extensão controlada.',
      sortOrder: 3,
    ),
    TrainingMuscle(
      key: 'grip_support',
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
      name: 'Pega de suporte',
      description: 'Suportar carga.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'pinch_grip',
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
      name: 'Pega de pinça',
      description: 'Pinça com dedos.',
      sortOrder: 2,
    ),
    TrainingMuscle(
      key: 'upper_chest',
      regionKey: 'upper',
      groupKey: 'chest',
      subgroupKey: 'chest_primary',
      name: 'Peito superior',
      description: 'Porção clavicular.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'mid_chest',
      regionKey: 'upper',
      groupKey: 'chest',
      subgroupKey: 'chest_primary',
      name: 'Peito médio',
      description: 'Porção média.',
      sortOrder: 2,
    ),
    TrainingMuscle(
      key: 'lower_chest',
      regionKey: 'upper',
      groupKey: 'chest',
      subgroupKey: 'chest_primary',
      name: 'Peito inferior',
      description: 'Porção inferior.',
      sortOrder: 3,
    ),
    TrainingMuscle(
      key: 'lats',
      regionKey: 'upper',
      groupKey: 'back',
      subgroupKey: 'back_width',
      name: 'Dorsal / latíssimo do dorso',
      description: 'Largura das costas.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'rhomboids',
      regionKey: 'upper',
      groupKey: 'back',
      subgroupKey: 'back_thickness',
      name: 'Romboides',
      description: 'Retração escapular.',
      sortOrder: 2,
    ),
    TrainingMuscle(
      key: 'deltoid_lateral',
      regionKey: 'upper',
      groupKey: 'shoulders',
      subgroupKey: 'deltoids',
      name: 'Deltoide lateral',
      description: 'Abdução do ombro.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'glute_max',
      regionKey: 'lower',
      groupKey: 'hips_glutes',
      subgroupKey: 'glutes',
      name: 'Glúteo máximo',
      description: 'Extensão da anca.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'glute_med',
      regionKey: 'lower',
      groupKey: 'hips_glutes',
      subgroupKey: 'glutes',
      name: 'Glúteo médio',
      description: 'Estabilidade lateral.',
      sortOrder: 2,
    ),
    TrainingMuscle(
      key: 'rectus_femoris',
      regionKey: 'lower',
      groupKey: 'quadriceps',
      subgroupKey: 'quadriceps',
      name: 'Reto femoral',
      description: 'Extensão do joelho.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'vastus_lateralis',
      regionKey: 'lower',
      groupKey: 'quadriceps',
      subgroupKey: 'quadriceps',
      name: 'Vasto lateral',
      description: 'Quadríceps lateral.',
      sortOrder: 2,
    ),
    TrainingMuscle(
      key: 'biceps_femoris',
      regionKey: 'lower',
      groupKey: 'hamstrings',
      subgroupKey: 'hamstrings',
      name: 'Bíceps femoral',
      description: 'Posterior lateral.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'calves',
      regionKey: 'lower',
      groupKey: 'calves',
      subgroupKey: 'calves',
      name: 'Gémeos',
      description: 'Flexão plantar.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'soleus',
      regionKey: 'lower',
      groupKey: 'calves',
      subgroupKey: 'calves',
      name: 'Sóleo',
      description: 'Flexão plantar com joelho fletido.',
      sortOrder: 2,
    ),
    TrainingMuscle(
      key: 'rectus_abdominis',
      regionKey: 'core',
      groupKey: 'abdominal',
      subgroupKey: 'core_general',
      name: 'Reto abdominal',
      description: 'Flexão do tronco.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'anti_extension',
      regionKey: 'core',
      groupKey: 'anti_extension',
      subgroupKey: 'core_general',
      name: 'Anti-extensão',
      description: 'Resistência à extensão.',
      sortOrder: 2,
    ),
    TrainingMuscle(
      key: 'aerobic_endurance',
      regionKey: 'cardio',
      groupKey: 'cardio_general',
      subgroupKey: 'treadmill',
      name: 'Resistência aeróbia',
      description: 'Capacidade aeróbia.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'karate_technical',
      regionKey: 'martial_arts',
      groupKey: 'karate',
      subgroupKey: 'karate_technical',
      name: 'Karate técnico',
      description: 'Técnica de Karate.',
      sortOrder: 1,
    ),
    TrainingMuscle(
      key: 'jiu_jitsu_technical',
      regionKey: 'martial_arts',
      groupKey: 'jiu_jitsu',
      subgroupKey: 'jiu_jitsu_technical',
      name: 'Jiu-Jitsu técnico',
      description: 'Técnica de Jiu-Jitsu.',
      sortOrder: 1,
    ),
  ];

  static const equipment = [
    TrainingEquipment(
      key: 'bodyweight',
      name: 'Peso corporal',
      category: 'base',
      description: 'Exercícios sem carga externa.',
    ),
    TrainingEquipment(
      key: 'dumbbells',
      name: 'Halteres',
      category: 'free_weight',
      description: 'Cargas livres unilaterais ou bilaterais.',
    ),
    TrainingEquipment(
      key: 'barbell',
      name: 'Barra',
      category: 'free_weight',
      description: 'Barra olímpica ou reta.',
    ),
    TrainingEquipment(
      key: 'plates',
      name: 'Discos',
      category: 'free_weight',
      description: 'Discos para carga ou pega.',
    ),
    TrainingEquipment(
      key: 'bench',
      name: 'Banco',
      category: 'support',
      description: 'Banco plano ou ajustável.',
    ),
    TrainingEquipment(
      key: 'machine',
      name: 'Máquina multifunções',
      category: 'machine',
      description: 'Máquina de musculação multifunções.',
    ),
    TrainingEquipment(
      key: 'high_cable',
      name: 'Cabo alto',
      category: 'cable',
      description: 'Polia alta.',
    ),
    TrainingEquipment(
      key: 'low_cable',
      name: 'Cabo baixo',
      category: 'cable',
      description: 'Polia baixa.',
    ),
    TrainingEquipment(
      key: 'gym_machines',
      name: 'Máquinas de ginásio',
      category: 'machine',
      description: 'Máquinas dedicadas.',
    ),
    TrainingEquipment(
      key: 'pullup_bar',
      name: 'Barra fixa',
      category: 'bar',
      description: 'Barra para suspensão.',
    ),
    TrainingEquipment(
      key: 'bands',
      name: 'Elásticos',
      category: 'band',
      description: 'Bandas elásticas.',
    ),
    TrainingEquipment(
      key: 'kettlebell',
      name: 'Kettlebell',
      category: 'free_weight',
      description: 'Kettlebell.',
    ),
    TrainingEquipment(
      key: 'treadmill',
      name: 'Passadeira',
      category: 'cardio',
      description: 'Máquina de caminhada/corrida.',
    ),
    TrainingEquipment(
      key: 'bike',
      name: 'Bicicleta',
      category: 'cardio',
      description: 'Bicicleta estática.',
    ),
    TrainingEquipment(
      key: 'elliptical',
      name: 'Elíptica',
      category: 'cardio',
      description: 'Máquina elíptica.',
    ),
    TrainingEquipment(
      key: 'jump_rope',
      name: 'Corda de saltar',
      category: 'cardio',
      description: 'Corda para saltar.',
    ),
    TrainingEquipment(
      key: 'heavy_bag',
      name: 'Saco de pancada',
      category: 'martial',
      description: 'Saco de pancada.',
    ),
    TrainingEquipment(
      key: 'tatami',
      name: 'Tatami / espaço de artes marciais',
      category: 'martial',
      description: 'Área segura para artes marciais.',
    ),
    TrainingEquipment(
      key: 'outdoor_space',
      name: 'Espaço exterior',
      category: 'outdoor',
      description: 'Rua, pista ou parque.',
    ),
    TrainingEquipment(
      key: 'none',
      name: 'Nenhum equipamento',
      category: 'base',
      description: 'Sem equipamento.',
    ),
    TrainingEquipment(
      key: 'other',
      name: 'Outro',
      category: 'custom',
      description: 'Equipamento personalizado.',
    ),
  ];

  static List<TrainingGroup> groupsForRegion(String regionKey) =>
      groups.where((item) => item.regionKey == regionKey).toList();

  static List<TrainingSubgroup> subgroupsForGroup(String groupKey) =>
      subgroups.where((item) => item.groupKey == groupKey).toList();

  static List<TrainingMuscle> musclesForSubgroup(String subgroupKey) =>
      muscles.where((item) => item.subgroupKey == subgroupKey).toList();

  static String labelForSelection(TrainingSelection selection) {
    if (selection.specificMuscleKey.isNotEmpty) {
      return _nameByKey(muscles, selection.specificMuscleKey);
    }
    if (selection.subgroupKey.isNotEmpty) {
      return _nameByKey(subgroups, selection.subgroupKey);
    }
    if (selection.groupKey.isNotEmpty) {
      return _nameByKey(groups, selection.groupKey);
    }
    if (selection.regionKey.isNotEmpty) {
      return _nameByKey(regions, selection.regionKey);
    }
    return 'Treino personalizado';
  }

  static TrainingSelection legacySelectionFor(String value) {
    final key = WorkoutTaxonomy.normalize(value);
    return _legacyMap[key] ??
        const TrainingSelection(
          regionKey: 'custom',
          groupKey: 'custom_workout',
        );
  }

  static ExerciseArchitectureTags tagsForExercise(Exercise exercise) {
    final primaryHaystack = WorkoutTaxonomy.normalize(
      '${exercise.name} ${exercise.muscleGroup} ${exercise.equipment}',
    );
    final detailHaystack = WorkoutTaxonomy.normalize(
      '${exercise.name} ${exercise.muscleGroup} '
      '${exercise.secondaryMuscleGroups} ${exercise.equipment}',
    );
    final regionKeys = <String>{};
    final groupKeys = <String>{};
    final subgroupKeys = <String>{};
    final muscleKeys = <String>{};

    void add({
      required String region,
      required String group,
      String subgroup = '',
      List<String> muscles = const [],
    }) {
      regionKeys.add(region);
      groupKeys.add(group);
      if (subgroup.isNotEmpty) subgroupKeys.add(subgroup);
      muscleKeys.addAll(muscles);
    }

    if (_has(primaryHaystack, [
      'curl com halteres',
      'curl martelo',
      'curl alternado',
      'curl concentrado',
      'curl isometrico',
      'curl isométrico',
      'curl com barra',
      'curl no cabo',
      'chin-up',
    ])) {
      add(
        region: 'upper',
        group: 'arms',
        subgroup: 'anterior_arm',
        muscles: ['biceps', 'brachialis', 'brachioradialis'],
      );
    }
    if (_has(primaryHaystack, [
      'triceps',
      'tríceps',
      'flexoes fechadas',
      'flexões fechadas',
      'flexoes diamante',
      'flexões diamante',
      'supino fechado',
      'fundos entre apoios',
      'dips para triceps',
    ])) {
      add(
        region: 'upper',
        group: 'arms',
        subgroup: 'posterior_arm',
        muscles: ['triceps_long', 'triceps_lateral', 'triceps_medial'],
      );
    }
    if (_has(primaryHaystack, [
      'wrist',
      'farmer',
      'dead hang',
      'aperto',
      'pinch',
      'plate hold',
      'towel',
      'pega',
      'punho',
    ])) {
      add(
        region: 'upper',
        group: 'forearm_hand',
        subgroup: 'grip_strength',
        muscles: ['grip_support', 'pinch_grip'],
      );
      groupKeys.add('arms');
      add(
        region: 'martial_arts',
        group: 'grappling_grip',
        subgroup: 'jiu_jitsu_technical',
        muscles: ['grip_support'],
      );
    }
    if (_has(primaryHaystack, [
          'supino',
          'flexoes',
          'flexões',
          'aberturas',
          'chest press',
          'crossover',
          'dips para peito',
        ]) &&
        !_has(primaryHaystack, [
          'supino fechado',
          'flexoes fechadas',
          'flexões fechadas',
          'flexoes diamante',
          'flexões diamante',
        ])) {
      add(
        region: 'upper',
        group: 'chest',
        subgroup: 'chest_primary',
        muscles: ['upper_chest', 'mid_chest', 'lower_chest'],
      );
    }
    if (_has(primaryHaystack, [
      'remo',
      'puxada',
      'pullover',
      'dorsal',
      'costas',
      'hiperextensao',
    ])) {
      add(
        region: 'upper',
        group: 'back',
        subgroup: 'back_thickness',
        muscles: ['lats', 'rhomboids'],
      );
    }
    if (_has(primaryHaystack, [
      'elevacao lateral',
      'elevação lateral',
      'press militar',
      'arnold',
      'reverse fly',
      'face pull',
      'pull-apart',
      'wall slides',
      'wall slide',
      'scapular push-up',
      'pike push-up',
      'rotacao externa',
      'rotação externa',
    ])) {
      add(
        region: 'upper',
        group: 'shoulders',
        subgroup: 'deltoids',
        muscles: ['deltoid_lateral'],
      );
    }
    if (_has(primaryHaystack, [
      'agachamento',
      'leg press',
      'extensao de perna',
      'extensão de perna',
      'wall sit',
      'step-up',
      'lunges',
    ])) {
      add(
        region: 'lower',
        group: 'quadriceps',
        subgroup: 'quadriceps',
        muscles: ['rectus_femoris', 'vastus_lateralis'],
      );
    }
    if (_has(primaryHaystack, [
      'peso morto',
      'posterior',
      'curl de perna',
      'good morning',
    ])) {
      add(
        region: 'lower',
        group: 'hamstrings',
        subgroup: 'hamstrings',
        muscles: ['biceps_femoris'],
      );
    }
    if (_has(primaryHaystack, [
      'gluteo',
      'glúteo',
      'hip thrust',
      'ponte',
      'abducao de anca',
      'abdução de anca',
    ])) {
      add(
        region: 'lower',
        group: 'hips_glutes',
        subgroup: 'glutes',
        muscles: ['glute_max', 'glute_med'],
      );
    }
    if (_has(primaryHaystack, ['gemeos', 'gémeos', 'soleo', 'sóleo'])) {
      add(
        region: 'lower',
        group: 'calves',
        subgroup: 'calves',
        muscles: ['calves', 'soleus'],
      );
    }
    if (_has(primaryHaystack, ['adutor', 'aducao', 'adução'])) {
      add(region: 'lower', group: 'adductors', subgroup: 'adductors');
    }
    if (_has(primaryHaystack, ['abdutor', 'abducao', 'abdução'])) {
      add(region: 'lower', group: 'abductors', subgroup: 'abductors');
    }
    if (_has(primaryHaystack, [
      'core',
      'abdominal',
      'prancha',
      'crunch',
      'dead bug',
      'hollow',
      'pallof',
      'bird dog',
      'russian twist',
      'bicycle crunch',
      'vacuum',
      'flutter',
      'toe touches',
    ])) {
      add(
        region: 'core',
        group: 'core_stability',
        subgroup: 'core_general',
        muscles: ['rectus_abdominis', 'anti_extension'],
      );
    }
    if (_has(primaryHaystack, ['passadeira'])) {
      add(
        region: 'cardio',
        group: 'cardio_general',
        subgroup: 'treadmill',
        muscles: ['aerobic_endurance'],
      );
      add(
        region: 'cardio',
        group: 'cardio_machine',
        subgroup: 'treadmill',
        muscles: ['aerobic_endurance'],
      );
    } else if (_has(primaryHaystack, ['bicicleta'])) {
      add(
        region: 'cardio',
        group: 'cardio_general',
        subgroup: 'bike',
        muscles: ['aerobic_endurance'],
      );
      add(
        region: 'cardio',
        group: 'cardio_machine',
        subgroup: 'bike',
        muscles: ['aerobic_endurance'],
      );
    } else if (_has(primaryHaystack, ['eliptica', 'elíptica'])) {
      add(
        region: 'cardio',
        group: 'cardio_general',
        subgroup: 'elliptical',
        muscles: ['aerobic_endurance'],
      );
      add(
        region: 'cardio',
        group: 'cardio_machine',
        subgroup: 'elliptical',
        muscles: ['aerobic_endurance'],
      );
    } else if (_has(primaryHaystack, ['corda'])) {
      add(
        region: 'cardio',
        group: 'cardio_general',
        subgroup: 'jump_rope',
        muscles: ['aerobic_endurance'],
      );
      add(
        region: 'cardio',
        group: 'jump_rope_group',
        subgroup: 'jump_rope',
        muscles: ['aerobic_endurance'],
      );
    } else if (_has(primaryHaystack, [
      'corrida exterior',
      'caminhada exterior',
      'sprints exterior',
    ])) {
      add(
        region: 'cardio',
        group: 'cardio_general',
        subgroup: 'outdoor_run',
        muscles: ['aerobic_endurance'],
      );
      add(
        region: 'cardio',
        group: 'outdoor_cardio',
        subgroup: 'outdoor_run',
        muscles: ['aerobic_endurance'],
      );
    } else if (_has(primaryHaystack, ['hiit'])) {
      add(region: 'cardio', group: 'hiit_group', subgroup: 'hiit');
      add(region: 'cardio', group: 'cardio_general', subgroup: 'hiit');
    } else if (_has(primaryHaystack, [
      'circuito cardio',
      'marcha no lugar',
      'jumping jacks',
      'burpees',
      'skaters',
      'high knees',
      'mountain climbers',
    ])) {
      add(region: 'cardio', group: 'cardio_general', subgroup: 'hiit');
      add(region: 'cardio', group: 'hiit_group', subgroup: 'hiit');
    }
    if (_has(primaryHaystack, ['karate', 'kihon', 'kata', 'kumite'])) {
      add(
        region: 'martial_arts',
        group: 'karate',
        subgroup: 'karate_technical',
        muscles: ['karate_technical'],
      );
    }
    if (_has(primaryHaystack, [
      'jiu-jitsu',
      'jiu jitsu',
      'shrimp',
      'grappling',
      'passagem de guarda',
    ])) {
      add(
        region: 'martial_arts',
        group: 'jiu_jitsu',
        subgroup: 'jiu_jitsu_technical',
        muscles: ['jiu_jitsu_technical'],
      );
    }
    if (_has(detailHaystack, [
      'mobilidade',
      'alongamento',
      'respiracao',
      'respiração',
      'wall slides',
      'cat-cow',
      'open book',
      'pigeon',
      '90/90',
      'chin tuck',
      'cervical',
      'circulos',
      'círculos',
      'relaxamento',
    ])) {
      add(region: 'mobility_recovery', group: 'general_mobility');
      if (_has(detailHaystack, ['alongamento'])) {
        add(region: 'mobility_recovery', group: 'stretching');
      }
      if (_has(detailHaystack, ['respiracao', 'respiração'])) {
        add(region: 'mobility_recovery', group: 'breathing');
      }
      if (_has(detailHaystack, ['anca', 'hip', '90/90'])) {
        add(region: 'mobility_recovery', group: 'hip_mobility');
      }
      if (_has(detailHaystack, [
        'gluteo',
        'glúteo',
        'piriforme',
        'pigeon',
        'figura 4',
        '90/90',
      ])) {
        add(region: 'mobility_recovery', group: 'glute_mobility');
      }
      if (_has(detailHaystack, ['posterior de coxa', 'hamstring'])) {
        add(region: 'mobility_recovery', group: 'hamstring_mobility');
      }
      if (_has(detailHaystack, ['quadriceps', 'quadríceps'])) {
        add(region: 'mobility_recovery', group: 'quadriceps_mobility');
      }
      if (_has(detailHaystack, ['ombro'])) {
        add(region: 'mobility_recovery', group: 'shoulder_mobility');
      }
      if (_has(detailHaystack, ['peitoral', 'peito'])) {
        add(region: 'mobility_recovery', group: 'chest_mobility');
      }
      if (_has(detailHaystack, ['dorsal', 'costas'])) {
        add(region: 'mobility_recovery', group: 'back_mobility');
      }
      if (_has(detailHaystack, ['toracica', 'torácica'])) {
        add(region: 'mobility_recovery', group: 'thoracic_mobility');
      }
      if (_has(detailHaystack, ['tornozelo'])) {
        add(region: 'mobility_recovery', group: 'ankle_mobility');
      }
      if (_has(detailHaystack, ['gemeos', 'gémeos'])) {
        add(region: 'mobility_recovery', group: 'calf_mobility');
      }
      if (_has(detailHaystack, ['pescoco', 'pescoço', 'cervical'])) {
        add(region: 'mobility_recovery', group: 'neck_mobility');
      }
      if (_has(detailHaystack, ['punho', 'punhos'])) {
        add(region: 'mobility_recovery', group: 'wrist_mobility');
      }
      if (_has(detailHaystack, ['caminhada leve', 'relaxamento'])) {
        add(region: 'mobility_recovery', group: 'active_recovery');
      }
    }
    if (regionKeys.isEmpty) {
      regionKeys.add('custom');
      groupKeys.add('custom_workout');
    }

    return ExerciseArchitectureTags(
      regionKeys: regionKeys,
      groupKeys: groupKeys,
      subgroupKeys: subgroupKeys,
      muscleKeys: muscleKeys,
      equipmentKeys: equipmentKeysFor(exercise.equipment),
    );
  }

  static Set<String> equipmentKeysFor(String equipmentText) {
    final text = WorkoutTaxonomy.normalize(equipmentText);
    final keys = <String>{};
    void addIf(String key, List<String> needles) {
      if (needles.any(text.contains)) keys.add(key);
    }

    addIf('bodyweight', ['peso corporal']);
    addIf('dumbbells', ['halter', 'halteres']);
    addIf('barbell', ['barra', 'barbell']);
    addIf('plates', ['disco', 'plate']);
    addIf('bench', ['banco']);
    addIf('machine', ['maquina', 'máquina', 'multifuncoes']);
    addIf('high_cable', ['cabo alto']);
    addIf('low_cable', ['cabo baixo']);
    if (text.contains('cabo') &&
        !keys.contains('high_cable') &&
        !keys.contains('low_cable')) {
      keys.addAll(['high_cable', 'low_cable']);
    }
    addIf('gym_machines', ['maquinas de ginasio', 'cabo ou maquina']);
    addIf('pullup_bar', ['barra fixa', 'chin-up', 'pull-up']);
    addIf('bands', ['elastico', 'elásticos']);
    addIf('kettlebell', ['kettlebell']);
    addIf('treadmill', ['passadeira']);
    addIf('bike', ['bicicleta']);
    addIf('elliptical', ['eliptica', 'elíptica']);
    addIf('jump_rope', ['corda']);
    addIf('heavy_bag', ['saco']);
    addIf('tatami', ['tatami']);
    addIf('outdoor_space', ['exterior', 'espaco exterior', 'espaço exterior']);
    addIf('none', ['nenhum equipamento']);
    if (keys.isEmpty) keys.add('bodyweight');
    return keys;
  }

  static bool matchesSelection(Exercise exercise, TrainingSelection selection) {
    if (selection.isEmpty) return true;
    final tags = tagsForExercise(exercise);
    if (selection.regionKey.isNotEmpty &&
        !tags.regionKeys.contains(selection.regionKey)) {
      return false;
    }
    if (selection.groupKey.isNotEmpty &&
        !tags.groupKeys.contains(selection.groupKey)) {
      return false;
    }
    if (selection.subgroupKey.isNotEmpty &&
        !tags.subgroupKeys.contains(selection.subgroupKey)) {
      return false;
    }
    if (selection.specificMuscleKey.isNotEmpty &&
        !tags.muscleKeys.contains(selection.specificMuscleKey)) {
      return false;
    }
    if (selection.equipmentKey.isNotEmpty &&
        !tags.equipmentKeys.contains(selection.equipmentKey)) {
      return false;
    }
    return true;
  }

  static bool _has(String haystack, List<String> needles) {
    return needles.any(
      (needle) => haystack.contains(WorkoutTaxonomy.normalize(needle)),
    );
  }

  static String _nameByKey(List<Object> items, String key) {
    for (final item in items) {
      if (item is TrainingRegion && item.key == key) return item.name;
      if (item is TrainingGroup && item.key == key) return item.name;
      if (item is TrainingSubgroup && item.key == key) return item.name;
      if (item is TrainingMuscle && item.key == key) return item.name;
    }
    return key;
  }

  static const _legacyMap = {
    'full body': TrainingSelection(regionKey: 'full_body'),
    'upper body': TrainingSelection(regionKey: 'upper'),
    'lower body': TrainingSelection(regionKey: 'lower'),
    'push': TrainingSelection(regionKey: 'upper', groupKey: 'chest'),
    'pull': TrainingSelection(regionKey: 'upper', groupKey: 'back'),
    'legs': TrainingSelection(regionKey: 'lower'),
    'bracos': TrainingSelection(regionKey: 'upper', groupKey: 'arms'),
    'biceps': TrainingSelection(
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'anterior_arm',
      specificMuscleKey: 'biceps',
    ),
    'triceps': TrainingSelection(
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'posterior_arm',
    ),
    'antebraco/pega': TrainingSelection(
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
    ),
    'peito': TrainingSelection(
      regionKey: 'upper',
      groupKey: 'chest',
      subgroupKey: 'chest_primary',
    ),
    'costas': TrainingSelection(regionKey: 'upper', groupKey: 'back'),
    'ombros': TrainingSelection(
      regionKey: 'upper',
      groupKey: 'shoulders',
      subgroupKey: 'deltoids',
    ),
    'trapezio': TrainingSelection(
      regionKey: 'upper',
      groupKey: 'traps_scapula',
    ),
    'pescoco': TrainingSelection(regionKey: 'upper', groupKey: 'neck'),
    'pernas': TrainingSelection(regionKey: 'lower'),
    'quadriceps': TrainingSelection(
      regionKey: 'lower',
      groupKey: 'quadriceps',
      subgroupKey: 'quadriceps',
    ),
    'posterior de coxa': TrainingSelection(
      regionKey: 'lower',
      groupKey: 'hamstrings',
      subgroupKey: 'hamstrings',
    ),
    'gluteos': TrainingSelection(
      regionKey: 'lower',
      groupKey: 'hips_glutes',
      subgroupKey: 'glutes',
    ),
    'gemeos': TrainingSelection(
      regionKey: 'lower',
      groupKey: 'calves',
      subgroupKey: 'calves',
    ),
    'adutores/abdutores': TrainingSelection(regionKey: 'lower'),
    'core/abdominal': TrainingSelection(regionKey: 'core'),
    'lombar': TrainingSelection(regionKey: 'core', groupKey: 'low_back'),
    'cardio geral': TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'cardio_general',
    ),
    'passadeira': TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'cardio_machine',
      subgroupKey: 'treadmill',
      equipmentKey: 'treadmill',
    ),
    'bicicleta': TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'cardio_machine',
      subgroupKey: 'bike',
      equipmentKey: 'bike',
    ),
    'eliptica': TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'cardio_machine',
      subgroupKey: 'elliptical',
      equipmentKey: 'elliptical',
    ),
    'corda de saltar': TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'jump_rope_group',
      subgroupKey: 'jump_rope',
      equipmentKey: 'jump_rope',
    ),
    'caminhada exterior': TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'outdoor_cardio',
      subgroupKey: 'outdoor_walk',
      equipmentKey: 'outdoor_space',
    ),
    'corrida exterior': TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'outdoor_cardio',
      subgroupKey: 'outdoor_run',
      equipmentKey: 'outdoor_space',
    ),
    'hiit': TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'hiit_group',
      subgroupKey: 'hiit',
    ),
    'karate': TrainingSelection(
      regionKey: 'martial_arts',
      groupKey: 'karate',
      subgroupKey: 'karate_technical',
    ),
    'jiu-jitsu': TrainingSelection(
      regionKey: 'martial_arts',
      groupKey: 'jiu_jitsu',
      subgroupKey: 'jiu_jitsu_technical',
    ),
    'mobilidade': TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'general_mobility',
    ),
    'alongamentos': TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'stretching',
    ),
    'recuperacao': TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'active_recovery',
    ),
  };
}
