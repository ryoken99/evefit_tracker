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
  };

  static const martialLabels = {
    'karate': 'Karate',
    'jiu_jitsu': 'Jiu-Jitsu',
    'martial_conditioning': 'Condicionamento para artes marciais',
    'martial_mobility': 'Mobilidade para artes marciais',
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
    final keys = _strengthSubzones[groupKey] ?? const <String>[];
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

  static String suggestedWorkoutName(TrainingFlowSelection flow) {
    final type = types[flow.typeKey] ?? 'Personalizado';
    final focus = _nameForFlowFocus(flow);
    if (focus.isEmpty) return type;
    if (flow.typeKey == 'martial_arts' && focus == 'Jiu-Jitsu') {
      return focus;
    }
    return '$type - $focus';
  }

  static TrainingSelection toTrainingSelection(TrainingFlowSelection flow) {
    return switch (flow.typeKey) {
      'strength' => _strengthSelection(flow),
      'cardio' => _cardioSelection(flow),
      'martial_arts' => _martialSelection(flow),
      'mobility' => _mobilitySelection(flow),
      'recovery' => _recoverySelection(flow),
      _ => const TrainingSelection(
        regionKey: 'custom',
        groupKey: 'custom_workout',
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
    final key = flow.cardioFocusKey.isNotEmpty
        ? flow.cardioFocusKey
        : flow.equipmentKey;
    return switch (key) {
      'treadmill' || 'aerobic_endurance' => TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'cardio_machine',
        subgroupKey: 'treadmill',
        equipmentKey: flow.equipmentKey == 'treadmill' ? 'treadmill' : '',
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
      'hiit' => const TrainingSelection(
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
    return switch (flow.martialArtKey) {
      'karate' => const TrainingSelection(
        regionKey: 'martial_arts',
        groupKey: 'karate',
        subgroupKey: 'karate_technical',
      ),
      'jiu_jitsu' => const TrainingSelection(
        regionKey: 'martial_arts',
        groupKey: 'jiu_jitsu',
        subgroupKey: 'jiu_jitsu_technical',
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
      'light_stretching' => 'stretching',
      _ => 'general_mobility',
    };
    return TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: groupKey,
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
      'martial_arts' => martialLabels[flow.martialArtKey] ?? '',
      'mobility' => mobilityLabels[flow.mobilityZoneKey] ?? '',
      'recovery' => recoveryLabels[flow.recoveryKey] ?? '',
      _ => '',
    };
  }

  static String? _architectureName(String key) {
    if (key.isEmpty) return null;
    return TrainingArchitecture.labelForSelection(
      TrainingSelection(regionKey: key, groupKey: key, subgroupKey: key),
    );
  }
}
