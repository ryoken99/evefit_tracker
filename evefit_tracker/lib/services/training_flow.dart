import 'training_architecture.dart';
import 'workout_taxonomy.dart';

class TrainingFlowSelection {
  const TrainingFlowSelection({
    this.typeKey = '',
    this.equipmentKey = '',
    this.regionKey = '',
    this.groupKey = '',
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
    'arms_complete': 'Braços completo',
    'biceps': 'Bíceps',
    'brachialis': 'Braquial',
    'brachioradialis': 'Braquiorradial',
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
    final focus = flow.focusKey;
    if (flow.groupKey == 'chest') {
      return TrainingSelection(
        regionKey: 'upper',
        groupKey: 'chest',
        subgroupKey: 'chest_primary',
        equipmentKey: flow.equipmentKey,
      );
    }
    if (flow.regionKey == 'core') {
      return TrainingSelection(
        regionKey: 'core',
        equipmentKey: flow.equipmentKey,
      );
    }
    if (flow.groupKey == 'arms') {
      if (focus == 'biceps') {
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
        equipmentKey: flow.equipmentKey,
      );
    }
    return TrainingSelection(
      regionKey: flow.regionKey,
      groupKey: flow.groupKey,
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
