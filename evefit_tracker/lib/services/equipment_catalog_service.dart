class EquipmentDefinition {
  const EquipmentDefinition({
    required this.key,
    required this.name,
    required this.category,
  });

  final String key;
  final String name;
  final String category;
}

class EquipmentCatalogService {
  const EquipmentCatalogService._();

  static const definitions = <String, EquipmentDefinition>{
    'bodyweight': EquipmentDefinition(
      key: 'bodyweight',
      name: 'Peso corporal',
      category: 'basic',
    ),
    'free_space': EquipmentDefinition(
      key: 'free_space',
      name: 'Espaço livre',
      category: 'basic',
    ),
    'mat': EquipmentDefinition(
      key: 'mat',
      name: 'Tapete / colchonete',
      category: 'basic',
    ),
    'chair_support': EquipmentDefinition(
      key: 'chair_support',
      name: 'Banco / cadeira / apoio',
      category: 'basic',
    ),
    'weighted_backpack': EquipmentDefinition(
      key: 'weighted_backpack',
      name: 'Mochila com peso',
      category: 'basic',
    ),
    'water_bottles': EquipmentDefinition(
      key: 'water_bottles',
      name: 'Garrafas de água',
      category: 'basic',
    ),
    'water_jug': EquipmentDefinition(
      key: 'water_jug',
      name: 'Garrafão de água',
      category: 'basic',
    ),
    'stable_step': EquipmentDefinition(
      key: 'stable_step',
      name: 'Degrau / escada estável',
      category: 'basic',
    ),
    'sturdy_table': EquipmentDefinition(
      key: 'sturdy_table',
      name: 'Mesa resistente',
      category: 'basic',
    ),
    'broomstick': EquipmentDefinition(
      key: 'broomstick',
      name: 'Cabo de vassoura',
      category: 'basic',
    ),
    'towel': EquipmentDefinition(
      key: 'towel',
      name: 'Toalha',
      category: 'basic',
    ),
    'none': EquipmentDefinition(
      key: 'none',
      name: 'Nenhum equipamento',
      category: 'basic',
    ),
    'other': EquipmentDefinition(
      key: 'other',
      name: 'Outro',
      category: 'basic',
    ),
    'dumbbells': EquipmentDefinition(
      key: 'dumbbells',
      name: 'Halteres',
      category: 'free_weight',
    ),
    'barbell': EquipmentDefinition(
      key: 'barbell',
      name: 'Barra',
      category: 'free_weight',
    ),
    'plates': EquipmentDefinition(
      key: 'plates',
      name: 'Discos',
      category: 'free_weight',
    ),
    'kettlebell': EquipmentDefinition(
      key: 'kettlebell',
      name: 'Kettlebell',
      category: 'free_weight',
    ),
    'medicine_ball': EquipmentDefinition(
      key: 'medicine_ball',
      name: 'Medicine ball',
      category: 'free_weight',
    ),
    'sandbag': EquipmentDefinition(
      key: 'sandbag',
      name: 'Saco de areia',
      category: 'free_weight',
    ),
    'weighted_vest': EquipmentDefinition(
      key: 'weighted_vest',
      name: 'Colete com peso',
      category: 'free_weight',
    ),
    'ankle_weights': EquipmentDefinition(
      key: 'ankle_weights',
      name: 'Tornozeleiras com peso',
      category: 'free_weight',
    ),
    'pullup_bar': EquipmentDefinition(
      key: 'pullup_bar',
      name: 'Barra fixa',
      category: 'calisthenics',
    ),
    'parallel_bars': EquipmentDefinition(
      key: 'parallel_bars',
      name: 'Paralelas',
      category: 'calisthenics',
    ),
    'rings': EquipmentDefinition(
      key: 'rings',
      name: 'Argolas',
      category: 'calisthenics',
    ),
    'trx': EquipmentDefinition(
      key: 'trx',
      name: 'TRX / suspensão',
      category: 'calisthenics',
    ),
    'bands': EquipmentDefinition(
      key: 'bands',
      name: 'Elásticos',
      category: 'calisthenics',
    ),
    'mini_bands': EquipmentDefinition(
      key: 'mini_bands',
      name: 'Mini bands',
      category: 'calisthenics',
    ),
    'ab_wheel': EquipmentDefinition(
      key: 'ab_wheel',
      name: 'Roda abdominal',
      category: 'calisthenics',
    ),
    'jump_rope': EquipmentDefinition(
      key: 'jump_rope',
      name: 'Corda de saltar',
      category: 'cardio',
    ),
    'machine': EquipmentDefinition(
      key: 'machine',
      name: 'Máquina multifunções',
      category: 'gym',
    ),
    'high_cable': EquipmentDefinition(
      key: 'high_cable',
      name: 'Cabo alto',
      category: 'gym',
    ),
    'low_cable': EquipmentDefinition(
      key: 'low_cable',
      name: 'Cabo baixo',
      category: 'gym',
    ),
    'adjustable_cable': EquipmentDefinition(
      key: 'adjustable_cable',
      name: 'Polia ajustável',
      category: 'gym',
    ),
    'lat_pulldown': EquipmentDefinition(
      key: 'lat_pulldown',
      name: 'Lat pulldown',
      category: 'gym',
    ),
    'seated_row_machine': EquipmentDefinition(
      key: 'seated_row_machine',
      name: 'Remo sentado',
      category: 'gym',
    ),
    'chest_press_machine': EquipmentDefinition(
      key: 'chest_press_machine',
      name: 'Chest press',
      category: 'gym',
    ),
    'shoulder_press_machine': EquipmentDefinition(
      key: 'shoulder_press_machine',
      name: 'Shoulder press machine',
      category: 'gym',
    ),
    'leg_press': EquipmentDefinition(
      key: 'leg_press',
      name: 'Leg press',
      category: 'gym',
    ),
    'leg_extension': EquipmentDefinition(
      key: 'leg_extension',
      name: 'Extensão de perna',
      category: 'gym',
    ),
    'leg_curl': EquipmentDefinition(
      key: 'leg_curl',
      name: 'Curl de perna',
      category: 'gym',
    ),
    'abductor_machine': EquipmentDefinition(
      key: 'abductor_machine',
      name: 'Máquina abdutora',
      category: 'gym',
    ),
    'adductor_machine': EquipmentDefinition(
      key: 'adductor_machine',
      name: 'Máquina adutora',
      category: 'gym',
    ),
    'smith_machine': EquipmentDefinition(
      key: 'smith_machine',
      name: 'Smith machine',
      category: 'gym',
    ),
    'squat_rack': EquipmentDefinition(
      key: 'squat_rack',
      name: 'Rack / suporte de agachamento',
      category: 'gym',
    ),
    'adjustable_bench': EquipmentDefinition(
      key: 'adjustable_bench',
      name: 'Banco regulável',
      category: 'gym',
    ),
    'flat_bench': EquipmentDefinition(
      key: 'flat_bench',
      name: 'Banco plano',
      category: 'gym',
    ),
    'incline_bench': EquipmentDefinition(
      key: 'incline_bench',
      name: 'Banco inclinado',
      category: 'gym',
    ),
    'decline_bench': EquipmentDefinition(
      key: 'decline_bench',
      name: 'Banco declinado',
      category: 'gym',
    ),
    'treadmill': EquipmentDefinition(
      key: 'treadmill',
      name: 'Passadeira',
      category: 'cardio',
    ),
    'bike': EquipmentDefinition(
      key: 'bike',
      name: 'Bicicleta',
      category: 'cardio',
    ),
    'elliptical': EquipmentDefinition(
      key: 'elliptical',
      name: 'Elíptica',
      category: 'cardio',
    ),
    'rower': EquipmentDefinition(
      key: 'rower',
      name: 'Remo ergómetro',
      category: 'cardio',
    ),
    'stepper': EquipmentDefinition(
      key: 'stepper',
      name: 'Stepper / escadas',
      category: 'cardio',
    ),
    'air_bike': EquipmentDefinition(
      key: 'air_bike',
      name: 'Air bike',
      category: 'cardio',
    ),
    'outdoor_space': EquipmentDefinition(
      key: 'outdoor_space',
      name: 'Espaço exterior para caminhar/correr',
      category: 'location',
    ),
    'tatami': EquipmentDefinition(
      key: 'tatami',
      name: 'Tatami / espaço de artes marciais',
      category: 'martial_arts',
    ),
    'heavy_bag': EquipmentDefinition(
      key: 'heavy_bag',
      name: 'Saco de pancada',
      category: 'martial_arts',
    ),
    'gloves': EquipmentDefinition(
      key: 'gloves',
      name: 'Luvas',
      category: 'martial_arts',
    ),
    'shin_guards': EquipmentDefinition(
      key: 'shin_guards',
      name: 'Caneleiras',
      category: 'martial_arts',
    ),
    'pads': EquipmentDefinition(
      key: 'pads',
      name: 'Paos / aparadores',
      category: 'martial_arts',
    ),
    'gi': EquipmentDefinition(
      key: 'gi',
      name: 'Kimono',
      category: 'martial_arts',
    ),
    'belt': EquipmentDefinition(
      key: 'belt',
      name: 'Cinto / faixa',
      category: 'martial_arts',
    ),
    'grappling_dummy': EquipmentDefinition(
      key: 'grappling_dummy',
      name: 'Boneco de grappling',
      category: 'martial_arts',
    ),
    'grip_trainer': EquipmentDefinition(
      key: 'grip_trainer',
      name: 'Grip trainer',
      category: 'martial_arts',
    ),
    'foam_roller': EquipmentDefinition(
      key: 'foam_roller',
      name: 'Foam roller',
      category: 'recovery',
    ),
    'massage_ball': EquipmentDefinition(
      key: 'massage_ball',
      name: 'Bola de massagem',
      category: 'recovery',
    ),
    'mobility_band': EquipmentDefinition(
      key: 'mobility_band',
      name: 'Elástico de mobilidade',
      category: 'recovery',
    ),
    'yoga_block': EquipmentDefinition(
      key: 'yoga_block',
      name: 'Bloco de yoga',
      category: 'recovery',
    ),
    'mobility_roller': EquipmentDefinition(
      key: 'mobility_roller',
      name: 'Rolo de mobilidade',
      category: 'recovery',
    ),
    'massage_gun': EquipmentDefinition(
      key: 'massage_gun',
      name: 'Pistola de massagem',
      category: 'recovery',
    ),
  };

  static const gymEquipmentKeys = <String>{
    'bodyweight',
    'free_space',
    'mat',
    'dumbbells',
    'barbell',
    'plates',
    'kettlebell',
    'medicine_ball',
    'pullup_bar',
    'parallel_bars',
    'bands',
    'machine',
    'high_cable',
    'low_cable',
    'adjustable_cable',
    'lat_pulldown',
    'seated_row_machine',
    'chest_press_machine',
    'shoulder_press_machine',
    'leg_press',
    'leg_extension',
    'leg_curl',
    'abductor_machine',
    'adductor_machine',
    'smith_machine',
    'squat_rack',
    'adjustable_bench',
    'flat_bench',
    'incline_bench',
    'decline_bench',
    'treadmill',
    'bike',
    'elliptical',
    'rower',
    'stepper',
    'air_bike',
  };

  static Set<String> availableKeys({
    required Set<String> trainingLocations,
    required Set<String> selectedEquipmentKeys,
  }) {
    final normalizedLocations = trainingLocations
        .map((location) => location.trim().toLowerCase())
        .toSet();
    final result = <String>{
      'bodyweight',
      ...selectedEquipmentKeys.where(definitions.containsKey),
    };
    if (normalizedLocations.any(
      (location) =>
          location.contains('ginásio') || location.contains('ginasio'),
    )) {
      result.addAll(gymEquipmentKeys);
    }
    if (normalizedLocations.any(
      (location) =>
          location.contains('exterior') || location.contains('parque'),
    )) {
      result.add('outdoor_space');
    }
    if (normalizedLocations.any(
      (location) => location.contains('dojo') || location.contains('marciais'),
    )) {
      result.add('tatami');
    }
    return result;
  }
}
