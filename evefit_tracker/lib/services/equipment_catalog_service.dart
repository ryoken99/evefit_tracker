enum CapabilityKind { equipment, surface, support, accessory, location, human }

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
    'floor': EquipmentDefinition(
      key: 'floor',
      name: 'Chão livre',
      category: 'basic',
    ),
    'wall': EquipmentDefinition(
      key: 'wall',
      name: 'Parede estável',
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
    'bench': EquipmentDefinition(
      key: 'bench',
      name: 'Banco estável',
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
    'jump_rope',
    'broomstick',
  };

  static const placeHomeNoEquipment = 'place_home_no_equipment';
  static const placeHomeEquipped = 'place_home_equipped';
  static const placeGym = 'place_gym';
  static const placeDojo = 'place_dojo';
  static const placeTatami = 'place_tatami';
  static const placeOutdoor = 'place_outdoor';
  static const placeWorkTravel = 'place_work_travel';
  static const placeClinic = 'place_clinic';

  static const canonicalPlaceNames = <String, String>{
    placeHomeNoEquipment: 'Casa sem equipamento',
    placeHomeEquipped: 'Casa equipada',
    placeGym: 'Ginasio',
    placeDojo: 'Dojo',
    placeTatami: 'Tatami',
    placeOutdoor: 'Exterior',
    placeWorkTravel: 'Trabalho ou viagem',
    placeClinic: 'Clinica ou fisioterapia',
  };

  static const surfaceKeys = <String>{'floor', 'mat', 'tatami'};
  static const supportKeys = <String>{
    'wall',
    'chair_support',
    'bench',
    'adjustable_bench',
    'flat_bench',
    'incline_bench',
    'decline_bench',
    'stable_step',
    'sturdy_table',
    'yoga_block',
  };
  static const accessoryKeys = <String>{
    'broomstick',
    'towel',
    'gloves',
    'shin_guards',
    'pads',
    'gi',
    'belt',
  };
  static const humanKeys = <String>{'partner'};
  static const locationCapabilityKeys = <String>{'free_space', 'outdoor_space'};

  static CapabilityKind kindFor(String key) {
    if (surfaceKeys.contains(key)) return CapabilityKind.surface;
    if (supportKeys.contains(key)) return CapabilityKind.support;
    if (accessoryKeys.contains(key)) return CapabilityKind.accessory;
    if (humanKeys.contains(key)) return CapabilityKind.human;
    if (locationCapabilityKeys.contains(key)) return CapabilityKind.location;
    return CapabilityKind.equipment;
  }

  static String normalizeEquipmentToken(String value, {String context = ''}) {
    final text = _normalize('$value $context');
    if (text.isEmpty) return '';

    if (text.contains('barra fixa') ||
        text.contains('pull up') ||
        text.contains('pull-up') ||
        text.contains('chin up') ||
        text.contains('chin-up')) {
      return 'pullup_bar';
    }
    if (text.contains('barra') &&
        (text.contains('cabo') || text.contains('polia'))) {
      return 'adjustable_cable';
    }
    if (text.contains('barra') &&
        (text.contains('maquina') || text.contains('smith'))) {
      return 'machine';
    }
    if (text.contains('barra')) return 'barbell';
    if (text.contains('saco') && text.contains('areia')) return 'sandbag';
    if (text.contains('saco')) return 'heavy_bag';
    if (text.contains('banco') && text.contains('inclinado')) {
      return 'incline_bench';
    }
    if (text.contains('banco') && text.contains('declinado')) {
      return 'decline_bench';
    }
    if (text.contains('cadeira') ||
        text.contains('sofa') ||
        text.contains('apoio improvisado')) {
      return 'chair_support';
    }
    if (text.contains('banco')) return 'bench';

    const aliases = <String, Set<String>>{
      'bodyweight': {'peso corporal', 'sem equipamento', 'eq none', 'none'},
      'floor': {'chao', 'solo'},
      'wall': {'parede', 'eq wall'},
      'mat': {'tapete', 'colchonete', 'mat', 'eq floor mat'},
      'towel': {'toalha', 'eq towel'},
      'dumbbells': {
        'halter',
        'halteres',
        'dumbbell',
        'dumbbells',
        'eq dumbbells',
      },
      'bands': {
        'elastico',
        'elasticos',
        'banda elastica',
        'resistance band',
        'band',
        'eq long band',
      },
      'machine': {'maquina', 'maquina de ginasio'},
      'high_cable': {'cabo alto'},
      'low_cable': {'cabo baixo'},
      'adjustable_cable': {'cabo', 'polia', 'cabo ajustavel'},
      'tatami': {'tatami', 'tapete de artes marciais', 'martial arts mat'},
      'heavy_bag': {'saco de boxe', 'saco de pancada', 'heavy bag'},
      'partner': {'parceiro', 'partner', 'eq partner'},
      'pullup_bar': {'barra fixa', 'pull up bar', 'chin up bar'},
      'barbell': {'barra livre', 'barra longa', 'barbell'},
    };

    for (final entry in aliases.entries) {
      if (entry.value.any(text.contains)) return entry.key;
    }
    for (final key in definitions.keys) {
      if (text.contains(_normalize(key))) return key;
    }
    return '';
  }

  static Set<String> normalizeEquipmentTokens(Iterable<String> values) {
    return values
        .map((value) => normalizeEquipmentToken(value))
        .where((key) => key.isNotEmpty)
        .toSet();
  }

  static Set<String> normalizePlaceTokens(Iterable<String> values) {
    final result = <String>{};
    for (final value in values) {
      final text = _normalize(value);
      if (text.contains('casa') &&
          (text.contains('sem equipamento') || text.contains('sem equip'))) {
        result.add(placeHomeNoEquipment);
      } else if (text.contains('casa')) {
        result.add(placeHomeEquipped);
      } else if (text.contains('ginasio') || text.contains('gym')) {
        result.add(placeGym);
      } else if (text.contains('dojo') || text.contains('artes marciais')) {
        result.add(placeDojo);
      } else if (text.contains('tatami')) {
        result.add(placeTatami);
      } else if (text.contains('exterior') || text.contains('parque')) {
        result.add(placeOutdoor);
      } else if (text.contains('trabalho') ||
          text.contains('viagem') ||
          text.contains('hotel')) {
        result.add(placeWorkTravel);
      } else if (text.contains('clinica') ||
          text.contains('fisioterapia') ||
          text.contains('reabilitacao')) {
        result.add(placeClinic);
      }
    }
    return result;
  }

  static Set<String> availableKeys({
    required Set<String> trainingLocations,
    required Set<String> selectedEquipmentKeys,
  }) {
    final places = normalizePlaceTokens(trainingLocations);
    final selected = <String>{
      ...selectedEquipmentKeys.where(definitions.containsKey),
      ...normalizeEquipmentTokens(selectedEquipmentKeys),
    };
    final result = <String>{
      'bodyweight',
      'floor',
      ...selected,
    };
    if (places.isEmpty || places.contains(placeHomeNoEquipment)) {
      result.add('wall');
    }
    if (places.contains(placeHomeEquipped)) {
      result.add('wall');
    }
    if (places.contains(placeGym)) {
      result.addAll(gymEquipmentKeys);
      result.addAll({'bench', 'chair_support', 'stable_step', 'wall'});
    }
    if (places.contains(placeOutdoor)) {
      result.add('outdoor_space');
    }
    if (places.contains(placeDojo)) {
      result.addAll({'wall', 'tatami'});
    }
    if (places.contains(placeTatami)) {
      result.addAll({'wall', 'tatami'});
    }
    if (places.contains(placeWorkTravel)) {
      result.add('wall');
    }
    return result;
  }

  static Set<String> legacyAvailableKeys({
    required Set<String> trainingLocations,
    required Set<String> selectedEquipmentKeys,
  }) {
    final normalizedLocations = trainingLocations
        .map((location) => location.trim().toLowerCase())
        .toSet();
    final result = <String>{
      'bodyweight',
      'floor',
      ...selectedEquipmentKeys.where(definitions.containsKey),
    };
    if (normalizedLocations.any(
      (location) =>
          location.contains('casa') ||
          location.contains('ginásio') ||
          location.contains('ginasio') ||
          location.contains('dojo') ||
          location.contains('marciais'),
    )) {
      result.add('wall');
    }
    if (normalizedLocations.any(
      (location) =>
          location.contains('ginásio') || location.contains('ginasio'),
    )) {
      result.addAll(gymEquipmentKeys);
      result.addAll({'bench', 'chair_support', 'stable_step'});
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

  static String _normalize(String value) {
    var text = value.toLowerCase();
    const replacements = {
      'á': 'a',
      'à': 'a',
      'ã': 'a',
      'â': 'a',
      'ä': 'a',
      'é': 'e',
      'ê': 'e',
      'è': 'e',
      'í': 'i',
      'ó': 'o',
      'õ': 'o',
      'ô': 'o',
      'ú': 'u',
      'ç': 'c',
      'Ã¡': 'a',
      'Ã£': 'a',
      'Ã¢': 'a',
      'Ã©': 'e',
      'Ãª': 'e',
      'Ã­': 'i',
      'Ã³': 'o',
      'Ãµ': 'o',
      'Ãº': 'u',
      'Ã§': 'c',
    };
    for (final entry in replacements.entries) {
      text = text.replaceAll(entry.key, entry.value);
    }
    return text.replaceAll(RegExp(r'[^a-z0-9]+'), ' ').trim();
  }
}
