import 'training_architecture.dart';
import 'workout_taxonomy.dart';

class TrainingFlowSelection {
  const TrainingFlowSelection({
    this.typeKey = '',
    this.equipmentKey = '',
    this.regionKey = '',
    this.groupKey = '',
    this.subzoneKey = '',
    this.focusKey = '',
    this.cardioFocusKey = '',
    this.martialArtKey = '',
    this.mobilityZoneKey = '',
    this.recoveryKey = '',
  });

  final String typeKey;
  final String equipmentKey;
  final String regionKey;
  final String groupKey;
  final String subzoneKey;
  final String focusKey;
  final String cardioFocusKey;
  final String martialArtKey;
  final String mobilityZoneKey;
  final String recoveryKey;

  TrainingFlowSelection copyWith({
    String? typeKey,
    String? equipmentKey,
    String? regionKey,
    String? groupKey,
    String? subzoneKey,
    String? focusKey,
    String? cardioFocusKey,
    String? martialArtKey,
    String? mobilityZoneKey,
    String? recoveryKey,
  }) {
    return TrainingFlowSelection(
      typeKey: typeKey ?? this.typeKey,
      equipmentKey: equipmentKey ?? this.equipmentKey,
      regionKey: regionKey ?? this.regionKey,
      groupKey: groupKey ?? this.groupKey,
      subzoneKey: subzoneKey ?? this.subzoneKey,
      focusKey: focusKey ?? this.focusKey,
      cardioFocusKey: cardioFocusKey ?? this.cardioFocusKey,
      martialArtKey: martialArtKey ?? this.martialArtKey,
      mobilityZoneKey: mobilityZoneKey ?? this.mobilityZoneKey,
      recoveryKey: recoveryKey ?? this.recoveryKey,
    );
  }
}

class TrainingFlow {
  const TrainingFlow._();

  static const types = {
    'strength': 'Musculação',
    'cardio': 'Cardio',
    'martial_arts': 'Artes marciais',
    'mobility': 'Mobilidade / elasticidade',
    'recovery': 'Recuperação',
    'custom': 'Personalizado',
  };

  static const strengthFocusLabels = {
    'chest_complete': 'Peito completo',
    'upper_chest': 'Peito superior',
    'mid_chest': 'Peito médio',
    'lower_chest': 'Peito inferior',
    'pectoralis_minor': 'Peitoral menor',
    'serratus_anterior': 'Serrátil anterior',
    'back_complete': 'Costas completo',
    'back_upper': 'Costas superior',
    'back_mid': 'Costas média',
    'back_lower': 'Costas inferior / lombar',
    'back_width': 'Costas largura',
    'back_thickness': 'Costas espessura',
    'shoulders_complete': 'Ombros completo',
    'anterior_deltoid': 'Deltoide anterior',
    'lateral_deltoid': 'Deltoide lateral',
    'posterior_deltoid': 'Deltoide posterior',
    'rotator_cuff': 'Manguito rotador',
    'external_rotators': 'Rotadores externos',
    'internal_rotators': 'Rotadores internos',
    'scapular_stability': 'Estabilidade escapular',
    'arms_complete': 'Braços completo',
    'upper_arm': 'Braço',
    'forearm_hand': 'Antebraço / punho / mão',
    'biceps_brachii': 'Bíceps braquial',
    'biceps': 'Bíceps',
    'brachialis': 'Braquial',
    'brachioradialis': 'Braquiorradial',
    'coracobrachialis': 'Coracobraquial',
    'triceps': 'Tríceps completo',
    'triceps_long': 'Tríceps cabeça longa',
    'triceps_lateral': 'Tríceps cabeça lateral',
    'triceps_medial': 'Tríceps cabeça medial',
    'forearm_complete': 'Antebraço completo',
    'forearm_flexors': 'Flexores do antebraço',
    'forearm_extensors': 'Extensores do antebraço',
    'pronators': 'Pronadores',
    'supinators': 'Supinadores',
    'wrist': 'Punho',
    'fingers': 'Dedos',
    'support_grip': 'Pega de suporte',
    'pinch_grip': 'Pega de pinça',
    'general_grip': 'Força de pega geral',
    'traps_complete': 'Trapézio completo',
    'upper_traps': 'Trapézio superior',
    'mid_traps': 'Trapézio médio',
    'lower_traps': 'Trapézio inferior',
    'neck_complete': 'Pescoço completo',
    'anterior_neck': 'Pescoço anterior',
    'posterior_neck': 'Pescoço posterior',
    'lateral_neck': 'Pescoço lateral',
    'cervical_stabilizers': 'Estabilizadores cervicais',
    'core_complete': 'Core completo',
    'abdominal_zone': 'Abdominal',
    'lumbar_zone': 'Lombar',
    'core_stability_zone': 'Estabilidade do core',
    'abs_complete': 'Abdominal completo',
    'upper_abs': 'Abdominal superior',
    'mid_abs': 'Abdominal médio',
    'lower_abs': 'Abdominal inferior',
    'lateral_abs': 'Abdominais laterais / oblíquos',
    'rectus_abdominis': 'Reto abdominal',
    'external_obliques': 'Oblíquos externos',
    'internal_obliques': 'Oblíquos internos',
    'transverse_abdominis': 'Transverso abdominal',
    'erectors': 'Eretores da espinha',
    'quadratus_lumborum': 'Quadrado lombar',
    'anti_rotation': 'Anti-rotação',
    'anti_extension': 'Anti-extensão',
    'anti_lateral_flexion': 'Anti-flexão lateral',
    'deep_stability': 'Estabilidade profunda',
    'legs_complete': 'Pernas completo',
    'upper_leg_hip': 'Acima do joelho / coxa e anca',
    'lower_leg_foot': 'Abaixo do joelho / perna inferior e pé',
    'thigh_complete': 'Coxa completa',
    'quadriceps_complete': 'Quadríceps completo',
    'rectus_femoris': 'Reto femoral',
    'vastus_lateralis': 'Vasto lateral',
    'vastus_medialis': 'Vasto medial',
    'vastus_intermedius': 'Vasto intermédio',
    'hamstrings_complete': 'Posterior de coxa completo',
    'biceps_femoris': 'Bíceps femoral',
    'semitendinosus': 'Semitendinoso',
    'semimembranosus': 'Semimembranoso',
    'glutes_complete': 'Glúteos completo',
    'glute_max': 'Glúteo máximo',
    'glute_med': 'Glúteo médio',
    'glute_min': 'Glúteo mínimo',
    'adductors': 'Adutores',
    'abductors': 'Abdutores',
    'hip_flexors': 'Flexores da anca',
    'hip_external_rotators': 'Rotadores externos da anca',
    'lower_leg_complete': 'Perna inferior completa',
    'calves': 'Gémeos',
    'soleus': 'Sóleo',
    'tibialis_anterior': 'Tibial anterior',
    'ankle': 'Tornozelo',
    'feet': 'Pés',
    'ankle_stability': 'Estabilidade do tornozelo',
    'rhomboids': 'Romboides',
    'scapular_stabilizers': 'Estabilizadores escapulares',
    'teres_major': 'Redondo maior',
    'teres_minor': 'Redondo menor',
    'latissimus_dorsi': 'Dorsal / latíssimo do dorso',
    'lumbar': 'Lombar',
    'lumbar_stability': 'Estabilidade lombar',
    'vertical_pulls': 'Puxadas verticais',
    'horizontal_rows': 'Remadas horizontais',
  };

  static const _completeStrengthKeys = {
    'arms_complete',
    'forearm_complete',
    'back_complete',
    'core_complete',
    'abs_complete',
    'legs_complete',
    'chest_complete',
    'shoulders_complete',
    'traps_complete',
    'neck_complete',
  };

  static const _strengthSubzones = {
    'chest': [
      'chest_complete',
      'upper_chest',
      'mid_chest',
      'lower_chest',
      'pectoralis_minor',
      'serratus_anterior',
    ],
    'back': [
      'back_complete',
      'back_upper',
      'back_mid',
      'back_lower',
      'back_width',
      'back_thickness',
    ],
    'shoulders': [
      'shoulders_complete',
      'anterior_deltoid',
      'lateral_deltoid',
      'posterior_deltoid',
      'rotator_cuff',
      'external_rotators',
      'internal_rotators',
      'scapular_stability',
    ],
    'arms': ['arms_complete', 'upper_arm', 'forearm_hand'],
    'forearm_hand': [
      'forearm_complete',
      'forearm_flexors',
      'forearm_extensors',
      'pronators',
      'supinators',
      'wrist',
      'fingers',
      'support_grip',
      'pinch_grip',
      'general_grip',
    ],
    'traps_scapula': [
      'traps_complete',
      'upper_traps',
      'mid_traps',
      'lower_traps',
      'scapular_stability',
    ],
    'neck': [
      'neck_complete',
      'anterior_neck',
      'posterior_neck',
      'lateral_neck',
      'cervical_stabilizers',
    ],
    'core': [
      'core_complete',
      'abdominal_zone',
      'lumbar_zone',
      'core_stability_zone',
    ],
    'legs': ['legs_complete', 'upper_leg_hip', 'lower_leg_foot'],
    'lower_complete': ['legs_complete', 'upper_leg_hip', 'lower_leg_foot'],
  };

  static const _strengthSpecificBySubzone = {
    'upper_arm': [
      'biceps_brachii',
      'brachialis',
      'brachioradialis',
      'coracobrachialis',
      'triceps',
      'triceps_long',
      'triceps_lateral',
      'triceps_medial',
    ],
    'forearm_hand': [
      'forearm_complete',
      'forearm_flexors',
      'forearm_extensors',
      'pronators',
      'supinators',
      'wrist',
      'fingers',
      'support_grip',
      'pinch_grip',
      'general_grip',
    ],
    'back_upper': [
      'upper_traps',
      'mid_traps',
      'lower_traps',
      'rhomboids',
      'posterior_deltoid',
      'scapular_stabilizers',
    ],
    'back_mid': [
      'rhomboids',
      'mid_traps',
      'teres_major',
      'teres_minor',
      'latissimus_dorsi',
    ],
    'back_lower': [
      'erectors',
      'lumbar',
      'quadratus_lumborum',
      'lumbar_stability',
    ],
    'back_width': ['latissimus_dorsi', 'teres_major', 'vertical_pulls'],
    'back_thickness': [
      'rhomboids',
      'mid_traps',
      'lower_traps',
      'horizontal_rows',
    ],
    'abdominal_zone': [
      'abs_complete',
      'upper_abs',
      'mid_abs',
      'lower_abs',
      'lateral_abs',
      'rectus_abdominis',
      'external_obliques',
      'internal_obliques',
      'transverse_abdominis',
    ],
    'lumbar_zone': ['lumbar', 'erectors', 'quadratus_lumborum'],
    'core_stability_zone': [
      'anti_rotation',
      'anti_extension',
      'anti_lateral_flexion',
      'deep_stability',
    ],
    'upper_leg_hip': [
      'thigh_complete',
      'quadriceps_complete',
      'rectus_femoris',
      'vastus_lateralis',
      'vastus_medialis',
      'vastus_intermedius',
      'hamstrings_complete',
      'biceps_femoris',
      'semitendinosus',
      'semimembranosus',
      'glutes_complete',
      'glute_max',
      'glute_med',
      'glute_min',
      'adductors',
      'abductors',
      'hip_flexors',
      'hip_external_rotators',
    ],
    'lower_leg_foot': [
      'lower_leg_complete',
      'calves',
      'soleus',
      'tibialis_anterior',
      'ankle',
      'feet',
      'ankle_stability',
    ],
  };

  static const cardioLabels = {
    'no_equipment': 'Sem equipamento',
    'treadmill': 'Passadeira',
    'bike': 'Bicicleta',
    'elliptical': 'Elíptica',
    'jump_rope': 'Corda de saltar',
    'outdoor_walk': 'Caminhada exterior',
    'outdoor_run': 'Corrida exterior',
    'hiit': 'HIIT',
    'aerobic_endurance': 'Resistência aeróbia',
    'treadmill_intervals': 'Intervalos / HIIT',
  };

  static const martialLabels = {
    'karate': 'Karate',
    'jiu_jitsu': 'Jiu-Jitsu',
    'martial_conditioning': 'Condicionamento para artes marciais',
    'martial_mobility': 'Mobilidade para artes marciais',
  };

  static const martialFocusLabels = {
    'karate_complete': 'Karate completo',
    'kihon': 'Kihon',
    'kata': 'Kata',
    'kumite_technical': 'Kumite técnico',
    'karate_shadow': 'Sombra de Karate',
    'karate_footwork': 'Deslocamentos',
    'karate_guard': 'Guarda',
    'karate_punches': 'Socos técnicos',
    'karate_kicks': 'Pontapés técnicos',
    'karate_mobility': 'Mobilidade para Karate',
    'karate_conditioning': 'Condicionamento para Karate',
    'jiu_jitsu_complete': 'Jiu-Jitsu completo',
    'shrimp': 'Shrimp / fuga de anca',
    'grappling_bridge': 'Ponte de grappling',
    'technical_stand_up': 'Technical stand-up',
    'jiu_jitsu_guard': 'Guarda',
    'guard_passing': 'Passagem de guarda',
    'jiu_jitsu_grip': 'Força de pega',
    'jiu_jitsu_core': 'Core para Jiu-Jitsu',
    'jiu_jitsu_mobility': 'Mobilidade para Jiu-Jitsu',
    'jiu_jitsu_conditioning': 'Condicionamento para Jiu-Jitsu',
  };

  static const _martialFocusByArt = {
    'karate': [
      'karate_complete',
      'kihon',
      'kata',
      'kumite_technical',
      'karate_shadow',
      'karate_footwork',
      'karate_guard',
      'karate_punches',
      'karate_kicks',
      'karate_mobility',
      'karate_conditioning',
    ],
    'jiu_jitsu': [
      'jiu_jitsu_complete',
      'shrimp',
      'grappling_bridge',
      'technical_stand_up',
      'jiu_jitsu_guard',
      'guard_passing',
      'jiu_jitsu_grip',
      'jiu_jitsu_core',
      'jiu_jitsu_mobility',
      'jiu_jitsu_conditioning',
    ],
  };

  static const mobilityLabels = {
    'general_mobility': 'Geral',
    'shoulder_mobility': 'Ombros',
    'chest_mobility': 'Peitoral',
    'back_mobility': 'Dorsal',
    'thoracic_mobility': 'Coluna torácica',
    'hip_mobility': 'Anca',
    'hamstring_mobility': 'Posterior de coxa',
    'glute_mobility': 'Glúteos',
    'ankle_mobility': 'Tornozelo',
    'calf_mobility': 'Gémeos',
    'neck_mobility': 'Pescoço',
  };

  static const recoveryLabels = {
    'easy_walk': 'Caminhada leve',
    'light_mobility': 'Mobilidade leve',
    'light_stretching': 'Alongamentos leves',
    'breathing': 'Respiração',
    'active_recovery': 'Recuperação ativa',
  };

  static List<MapEntry<String, String>> availableCardioModes({
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
  }) {
    final location = WorkoutTaxonomy.normalize(trainingLocation);
    final isGym = location.contains('ginasio');
    final hasOutdoor =
        location.contains('exterior') ||
        location.contains('parque') ||
        availableEquipmentKeys.contains('outdoor_space');
    final effectiveEquipment = {
      'bodyweight',
      'none',
      ...availableEquipmentKeys,
      if (isGym) 'treadmill',
      if (isGym) 'bike',
      if (isGym) 'elliptical',
      if (isGym) 'rower',
      if (isGym) 'stepper',
      if (isGym) 'air_bike',
      if (hasOutdoor) 'outdoor_space',
    };
    const ordered = [
      'no_equipment',
      'treadmill',
      'bike',
      'elliptical',
      'jump_rope',
      'outdoor_walk',
      'outdoor_run',
      'hiit',
    ];
    return [
      for (final key in ordered)
        if (key == 'no_equipment' ||
            key == 'hiit' ||
            effectiveEquipment.contains(_equipmentKeyForCardioMode(key)))
          MapEntry(key, cardioLabels[key]!),
    ];
  }

  static String _equipmentKeyForCardioMode(String modeKey) {
    return switch (modeKey) {
      'no_equipment' || 'hiit' => 'bodyweight',
      'outdoor_walk' || 'outdoor_run' => 'outdoor_space',
      _ => modeKey,
    };
  }

  static String finalFocusLabel(String typeKey) {
    return switch (typeKey) {
      'strength' => 'Músculo específico',
      'cardio' => 'Foco cardio',
      'martial_arts' => 'Foco técnico',
      'mobility' => 'Zona/foco',
      'recovery' => 'Tipo de recuperação',
      _ => 'Foco',
    };
  }

  static List<MapEntry<String, String>> strengthSubzonesForGroup(
    String groupKey,
  ) {
    final effectiveKey = groupKey == 'lower' ? 'legs' : groupKey;
    final keys = _strengthSubzones[effectiveKey] ?? const <String>[];
    return _entriesForStrengthKeys(keys);
  }

  static List<MapEntry<String, String>> strengthSpecificOptions(
    String groupKey,
    String subzoneKey,
  ) {
    final keys = _strengthSpecificBySubzone[subzoneKey] ?? const <String>[];
    return _entriesForStrengthKeys(keys);
  }

  static bool requiresStrengthSpecificFocus(
    String groupKey,
    String subzoneKey,
  ) {
    return subzoneKey.isNotEmpty &&
        !_completeStrengthKeys.contains(subzoneKey) &&
        strengthSpecificOptions(groupKey, subzoneKey).isNotEmpty;
  }

  static List<MapEntry<String, String>> _entriesForStrengthKeys(
    List<String> keys,
  ) {
    return [
      for (final key in keys)
        if (strengthFocusLabels.containsKey(key))
          MapEntry(key, strengthFocusLabels[key]!),
    ];
  }

  static List<MapEntry<String, String>> cardioFocusOptionsForEquipment(
    String equipmentKey,
  ) {
    final keys = switch (equipmentKey) {
      'treadmill' => ['aerobic_endurance', 'treadmill_intervals'],
      'bike' => ['aerobic_endurance', 'hiit'],
      'elliptical' => ['aerobic_endurance'],
      'jump_rope' => ['jump_rope', 'hiit'],
      'outdoor_space' => ['outdoor_walk', 'outdoor_run', 'hiit'],
      _ => ['no_equipment', 'hiit'],
    };
    return [
      for (final key in keys)
        if (cardioLabels.containsKey(key)) MapEntry(key, cardioLabels[key]!),
    ];
  }

  static String defaultCardioFocusForMode(String modeKey) {
    return switch (modeKey) {
      'treadmill' || 'bike' || 'elliptical' => 'aerobic_endurance',
      'jump_rope' => 'jump_rope',
      'outdoor_walk' || 'outdoor_run' => modeKey,
      'hiit' => 'hiit',
      _ => 'no_equipment',
    };
  }

  static List<MapEntry<String, String>> martialFocusOptions(
    String martialArtKey,
  ) {
    final keys = _martialFocusByArt[martialArtKey] ?? const <String>[];
    return [
      for (final key in keys)
        if (martialFocusLabels.containsKey(key))
          MapEntry(key, martialFocusLabels[key]!),
    ];
  }

  static String defaultMartialFocusForArt(String martialArtKey) {
    return switch (martialArtKey) {
      'jiu_jitsu' => 'jiu_jitsu_complete',
      _ => 'karate_complete',
    };
  }

  static String suggestedWorkoutName(TrainingFlowSelection flow) {
    final type = types[flow.typeKey] ?? 'Personalizado';
    final focus = _nameForFlowFocus(flow);
    if (focus.isEmpty) return type;
    return '$type - $focus';
  }

  static TrainingSelection toTrainingSelection(TrainingFlowSelection flow) {
    return switch (flow.typeKey) {
      'strength' => _strengthSelection(flow),
      'cardio' => _cardioSelection(flow),
      'martial_arts' => _martialSelection(flow),
      'mobility' => _mobilitySelection(flow),
      'recovery' => _recoverySelection(flow),
      _ => TrainingSelection(
        regionKey: flow.regionKey,
        groupKey: flow.groupKey,
        subgroupKey: flow.subzoneKey,
        specificMuscleKey: flow.focusKey,
        equipmentKey: flow.equipmentKey,
      ),
    };
  }

  static TrainingSelection _strengthSelection(TrainingFlowSelection flow) {
    final focus = flow.focusKey.isNotEmpty ? flow.focusKey : flow.subzoneKey;
    if (flow.groupKey == 'chest') {
      return TrainingSelection(
        regionKey: 'upper',
        groupKey: 'chest',
        subgroupKey: focus == 'chest_complete' || focus.isEmpty
            ? ''
            : 'chest_primary',
        specificMuscleKey: focus,
        equipmentKey: flow.equipmentKey,
      );
    }
    if (flow.regionKey == 'core') {
      return TrainingSelection(
        regionKey: 'core',
        groupKey: 'abdominal',
        subgroupKey: focus,
        specificMuscleKey: focus,
        equipmentKey: flow.equipmentKey,
      );
    }
    if (flow.groupKey == 'arms') {
      if (focus == 'biceps' || focus == 'biceps_brachii') {
        return TrainingSelection(
          regionKey: 'upper',
          groupKey: 'arms',
          subgroupKey: 'anterior_arm',
          specificMuscleKey: 'biceps',
          equipmentKey: flow.equipmentKey,
        );
      }
      if (focus == 'triceps') {
        return TrainingSelection(
          regionKey: 'upper',
          groupKey: 'arms',
          subgroupKey: 'posterior_arm',
          equipmentKey: flow.equipmentKey,
        );
      }
      return TrainingSelection(
        regionKey: 'upper',
        groupKey: 'arms',
        subgroupKey: flow.subzoneKey,
        specificMuscleKey: focus,
        equipmentKey: flow.equipmentKey,
      );
    }
    if (flow.groupKey == 'forearm_hand') {
      return TrainingSelection(
        regionKey: 'upper',
        groupKey: 'forearm_hand',
        subgroupKey: flow.subzoneKey,
        specificMuscleKey: focus,
        equipmentKey: flow.equipmentKey,
      );
    }
    if (flow.groupKey == 'back') {
      return TrainingSelection(
        regionKey: 'upper',
        groupKey: 'back',
        subgroupKey: focus,
        specificMuscleKey: focus,
        equipmentKey: flow.equipmentKey,
      );
    }
    if (flow.groupKey == 'shoulders' ||
        flow.groupKey == 'traps_scapula' ||
        flow.groupKey == 'neck') {
      return TrainingSelection(
        regionKey: 'upper',
        groupKey: flow.groupKey,
        subgroupKey: focus,
        specificMuscleKey: focus,
        equipmentKey: flow.equipmentKey,
      );
    }
    if (flow.groupKey == 'legs' || flow.regionKey == 'lower') {
      return TrainingSelection(
        regionKey: 'lower',
        groupKey: flow.groupKey.isEmpty ? 'legs' : flow.groupKey,
        subgroupKey: focus,
        specificMuscleKey: focus,
        equipmentKey: flow.equipmentKey,
      );
    }
    return TrainingSelection(
      regionKey: flow.regionKey,
      groupKey: flow.groupKey,
      subgroupKey: flow.subzoneKey,
      specificMuscleKey: focus,
      equipmentKey: flow.equipmentKey,
    );
  }

  static TrainingSelection _cardioSelection(TrainingFlowSelection flow) {
    final modeKey = flow.equipmentKey.isNotEmpty
        ? flow.equipmentKey
        : _equipmentKeyForCardioMode(flow.cardioFocusKey);
    final focusKey = flow.cardioFocusKey;
    return switch (modeKey) {
      'treadmill' => TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'cardio_machine',
        subgroupKey: 'treadmill',
        specificMuscleKey: switch (focusKey) {
          'aerobic_endurance' => 'treadmill_aerobic',
          'treadmill_intervals' || 'hiit' => 'treadmill_intervals',
          _ => '',
        },
        equipmentKey: 'treadmill',
      ),
      'bike' => const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'cardio_machine',
        subgroupKey: 'bike',
        equipmentKey: 'bike',
      ),
      'elliptical' => const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'cardio_machine',
        subgroupKey: 'elliptical',
        equipmentKey: 'elliptical',
      ),
      'jump_rope' => const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'jump_rope_group',
        subgroupKey: 'jump_rope',
        equipmentKey: 'jump_rope',
      ),
      'outdoor_walk' => const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'outdoor_cardio',
        subgroupKey: 'outdoor_walk',
        equipmentKey: 'outdoor_space',
      ),
      'outdoor_run' => const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'outdoor_cardio',
        subgroupKey: 'outdoor_run',
        equipmentKey: 'outdoor_space',
      ),
      'outdoor_space' => TrainingSelection(
        regionKey: 'cardio',
        groupKey: focusKey == 'hiit' ? 'hiit_group' : 'outdoor_cardio',
        subgroupKey: switch (focusKey) {
          'outdoor_walk' => 'outdoor_walk',
          'hiit' => 'hiit',
          _ => 'outdoor_run',
        },
        equipmentKey: focusKey == 'hiit' ? 'bodyweight' : 'outdoor_space',
      ),
      'hiit' => const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'hiit_group',
        subgroupKey: 'hiit',
        equipmentKey: 'bodyweight',
      ),
      'bodyweight' => const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'hiit_group',
        subgroupKey: 'hiit',
        equipmentKey: 'bodyweight',
      ),
      'no_equipment' => const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'hiit_group',
        subgroupKey: 'hiit',
        equipmentKey: 'bodyweight',
      ),
      _ => const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'cardio_general',
      ),
    };
  }

  static TrainingSelection _martialSelection(TrainingFlowSelection flow) {
    final focus = flow.focusKey.isNotEmpty
        ? flow.focusKey
        : defaultMartialFocusForArt(flow.martialArtKey);
    return switch (flow.martialArtKey) {
      'karate' => TrainingSelection(
        regionKey: 'martial_arts',
        groupKey: 'karate',
        subgroupKey: 'karate_technical',
        specificMuscleKey: focus == 'karate_complete' ? '' : focus,
      ),
      'jiu_jitsu' => TrainingSelection(
        regionKey: 'martial_arts',
        groupKey: 'jiu_jitsu',
        subgroupKey: 'jiu_jitsu_technical',
        specificMuscleKey: focus == 'jiu_jitsu_complete' ? '' : focus,
      ),
      _ => const TrainingSelection(regionKey: 'martial_arts'),
    };
  }

  static TrainingSelection _mobilitySelection(TrainingFlowSelection flow) {
    final groupKey = flow.mobilityZoneKey.isEmpty
        ? 'general_mobility'
        : flow.mobilityZoneKey;
    return TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: groupKey,
      equipmentKey: 'bodyweight',
    );
  }

  static TrainingSelection _recoverySelection(TrainingFlowSelection flow) {
    final groupKey = switch (flow.recoveryKey) {
      'breathing' => 'breathing',
      'active_recovery' || 'easy_walk' => 'active_recovery',
      'light_stretching' => '',
      _ => 'general_mobility',
    };
    return TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: groupKey,
      specificMuscleKey: flow.recoveryKey == 'light_stretching'
          ? 'light_stretching'
          : '',
      equipmentKey: 'bodyweight',
    );
  }

  static String _nameForFlowFocus(TrainingFlowSelection flow) {
    return switch (flow.typeKey) {
      'strength' =>
        strengthFocusLabels[flow.focusKey] ??
            strengthFocusLabels[flow.subzoneKey] ??
            _architectureName(flow.groupKey) ??
            _architectureName(flow.regionKey) ??
            '',
      'cardio' => [
        if (flow.equipmentKey.isNotEmpty)
          cardioLabels[flow.equipmentKey] ??
              _architectureName(flow.equipmentKey),
        if (flow.cardioFocusKey.isNotEmpty &&
            flow.cardioFocusKey != flow.equipmentKey)
          cardioLabels[flow.cardioFocusKey],
      ].whereType<String>().where((item) => item.isNotEmpty).join(' - '),
      'martial_arts' => [
        martialLabels[flow.martialArtKey] ?? '',
        if (flow.focusKey.isNotEmpty &&
            flow.focusKey != defaultMartialFocusForArt(flow.martialArtKey))
          martialFocusLabels[flow.focusKey] ?? '',
      ].where((item) => item.isNotEmpty).join(' - '),
      'mobility' => mobilityLabels[flow.mobilityZoneKey] ?? '',
      'recovery' => recoveryLabels[flow.recoveryKey] ?? '',
      _ =>
        _architectureName(flow.focusKey) ??
            _architectureName(flow.subzoneKey) ??
            _architectureName(flow.groupKey) ??
            _architectureName(flow.regionKey) ??
            '',
    };
  }

  static String? _architectureName(String key) {
    if (key.isEmpty) return null;
    for (final item in TrainingArchitecture.muscles) {
      if (item.key == key) return item.name;
    }
    for (final item in TrainingArchitecture.subgroups) {
      if (item.key == key) return item.name;
    }
    for (final item in TrainingArchitecture.groups) {
      if (item.key == key) return item.name;
    }
    for (final item in TrainingArchitecture.regions) {
      if (item.key == key) return item.name;
    }
    for (final item in TrainingArchitecture.equipment) {
      if (item.key == key) return item.name;
    }
    if (key == 'legs') return 'Pernas';
    if (key == 'core') return 'Core';
    return null;
  }
}
