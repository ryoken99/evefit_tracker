import '../models/profile.dart';

class ProfileSetupSection<T> {
  const ProfileSetupSection({required this.title, required this.options});

  final String title;
  final List<T> options;
}

class ProfileEquipmentOption {
  const ProfileEquipmentOption({required this.key, required this.name});

  final String key;
  final String name;
}

class ProfilePreferencesService {
  const ProfilePreferencesService._();

  static const equipmentSections = [
    ProfileSetupSection<ProfileEquipmentOption>(
      title: 'Básico',
      options: [
        ProfileEquipmentOption(key: 'bodyweight', name: 'Peso corporal'),
        ProfileEquipmentOption(key: 'free_space', name: 'Espaço livre'),
        ProfileEquipmentOption(key: 'mat', name: 'Tapete / colchonete'),
        ProfileEquipmentOption(
          key: 'chair_support',
          name: 'Banco / cadeira / apoio',
        ),
        ProfileEquipmentOption(
          key: 'weighted_backpack',
          name: 'Mochila com peso',
        ),
        ProfileEquipmentOption(key: 'towel', name: 'Toalha'),
        ProfileEquipmentOption(key: 'none', name: 'Nenhum equipamento'),
        ProfileEquipmentOption(key: 'other', name: 'Outro'),
      ],
    ),
    ProfileSetupSection<ProfileEquipmentOption>(
      title: 'Pesos livres',
      options: [
        ProfileEquipmentOption(key: 'dumbbells', name: 'Halteres'),
        ProfileEquipmentOption(key: 'barbell', name: 'Barra'),
        ProfileEquipmentOption(key: 'plates', name: 'Discos'),
        ProfileEquipmentOption(key: 'kettlebell', name: 'Kettlebell'),
        ProfileEquipmentOption(key: 'medicine_ball', name: 'Medicine ball'),
        ProfileEquipmentOption(key: 'sandbag', name: 'Saco de areia'),
        ProfileEquipmentOption(key: 'weighted_vest', name: 'Colete com peso'),
        ProfileEquipmentOption(
          key: 'ankle_weights',
          name: 'Tornozeleiras com peso',
        ),
      ],
    ),
    ProfileSetupSection<ProfileEquipmentOption>(
      title: 'Calistenia',
      options: [
        ProfileEquipmentOption(key: 'pullup_bar', name: 'Barra fixa'),
        ProfileEquipmentOption(key: 'parallel_bars', name: 'Paralelas'),
        ProfileEquipmentOption(key: 'rings', name: 'Argolas'),
        ProfileEquipmentOption(key: 'trx', name: 'TRX / suspensão'),
        ProfileEquipmentOption(key: 'bands', name: 'Elásticos'),
        ProfileEquipmentOption(key: 'mini_bands', name: 'Mini bands'),
        ProfileEquipmentOption(key: 'ab_wheel', name: 'Roda abdominal'),
        ProfileEquipmentOption(key: 'jump_rope', name: 'Corda de saltar'),
      ],
    ),
    ProfileSetupSection<ProfileEquipmentOption>(
      title: 'Máquinas e cabos',
      options: [
        ProfileEquipmentOption(key: 'machine', name: 'Máquina multifunções'),
        ProfileEquipmentOption(key: 'high_cable', name: 'Cabo alto'),
        ProfileEquipmentOption(key: 'low_cable', name: 'Cabo baixo'),
        ProfileEquipmentOption(
          key: 'adjustable_cable',
          name: 'Polia ajustável',
        ),
        ProfileEquipmentOption(key: 'lat_pulldown', name: 'Lat pulldown'),
        ProfileEquipmentOption(key: 'seated_row_machine', name: 'Remo sentado'),
        ProfileEquipmentOption(key: 'chest_press_machine', name: 'Chest press'),
        ProfileEquipmentOption(
          key: 'shoulder_press_machine',
          name: 'Shoulder press machine',
        ),
        ProfileEquipmentOption(key: 'leg_press', name: 'Leg press'),
        ProfileEquipmentOption(key: 'leg_extension', name: 'Extensão de perna'),
        ProfileEquipmentOption(key: 'leg_curl', name: 'Curl de perna'),
        ProfileEquipmentOption(
          key: 'abductor_machine',
          name: 'Máquina abdutora',
        ),
        ProfileEquipmentOption(
          key: 'adductor_machine',
          name: 'Máquina adutora',
        ),
        ProfileEquipmentOption(key: 'smith_machine', name: 'Smith machine'),
        ProfileEquipmentOption(
          key: 'squat_rack',
          name: 'Rack / suporte de agachamento',
        ),
        ProfileEquipmentOption(
          key: 'adjustable_bench',
          name: 'Banco regulável',
        ),
        ProfileEquipmentOption(key: 'flat_bench', name: 'Banco plano'),
        ProfileEquipmentOption(key: 'incline_bench', name: 'Banco inclinado'),
        ProfileEquipmentOption(key: 'decline_bench', name: 'Banco declinado'),
      ],
    ),
    ProfileSetupSection<ProfileEquipmentOption>(
      title: 'Cardio',
      options: [
        ProfileEquipmentOption(key: 'treadmill', name: 'Passadeira'),
        ProfileEquipmentOption(key: 'bike', name: 'Bicicleta'),
        ProfileEquipmentOption(key: 'elliptical', name: 'Elíptica'),
        ProfileEquipmentOption(key: 'rower', name: 'Remo ergómetro'),
        ProfileEquipmentOption(key: 'stepper', name: 'Stepper / escadas'),
        ProfileEquipmentOption(key: 'air_bike', name: 'Air bike'),
        ProfileEquipmentOption(key: 'jump_rope', name: 'Corda de saltar'),
        ProfileEquipmentOption(
          key: 'outdoor_space',
          name: 'Espaço exterior para caminhar/correr',
        ),
      ],
    ),
    ProfileSetupSection<ProfileEquipmentOption>(
      title: 'Artes marciais',
      options: [
        ProfileEquipmentOption(
          key: 'tatami',
          name: 'Tatami / espaço de artes marciais',
        ),
        ProfileEquipmentOption(key: 'heavy_bag', name: 'Saco de pancada'),
        ProfileEquipmentOption(key: 'gloves', name: 'Luvas'),
        ProfileEquipmentOption(key: 'shin_guards', name: 'Caneleiras'),
        ProfileEquipmentOption(key: 'pads', name: 'Paos / aparadores'),
        ProfileEquipmentOption(key: 'gi', name: 'Kimono'),
        ProfileEquipmentOption(key: 'belt', name: 'Cinto / faixa'),
        ProfileEquipmentOption(
          key: 'grappling_dummy',
          name: 'Boneco de grappling',
        ),
        ProfileEquipmentOption(key: 'grip_trainer', name: 'Grip trainer'),
      ],
    ),
    ProfileSetupSection<ProfileEquipmentOption>(
      title: 'Recuperação e mobilidade',
      options: [
        ProfileEquipmentOption(key: 'foam_roller', name: 'Foam roller'),
        ProfileEquipmentOption(key: 'massage_ball', name: 'Bola de massagem'),
        ProfileEquipmentOption(
          key: 'mobility_band',
          name: 'Elástico de mobilidade',
        ),
        ProfileEquipmentOption(key: 'yoga_block', name: 'Bloco de yoga'),
        ProfileEquipmentOption(
          key: 'mobility_roller',
          name: 'Rolo de mobilidade',
        ),
        ProfileEquipmentOption(key: 'massage_gun', name: 'Pistola de massagem'),
      ],
    ),
  ];

  static const generalGoalSections = [
    ProfileSetupSection<String>(
      title: 'Composição corporal',
      options: [
        'Ganhar massa muscular',
        'Perder gordura',
        'Recomposição corporal',
        'Manutenção',
        'Ganhar peso',
        'Perder peso',
        'Definir abdominal',
        'Reduzir cintura',
        'Melhorar percentagem de gordura',
        'Aumentar massa muscular',
      ],
    ),
    ProfileSetupSection<String>(
      title: 'Estética / forma corporal',
      options: [
        'Construir V-shape',
        'Aumentar costas',
        'Aumentar ombros',
        'Aumentar peito',
        'Aumentar braços',
        'Aumentar glúteos',
        'Aumentar pernas',
        'Melhorar postura',
        'Ficar mais atlético',
      ],
    ),
    ProfileSetupSection<String>(
      title: 'Força',
      options: [
        'Ganhar força geral',
        'Melhorar força no supino',
        'Melhorar força no agachamento',
        'Melhorar força no peso morto',
        'Melhorar força de pega',
        'Melhorar força de core',
        'Melhorar resistência muscular',
      ],
    ),
    ProfileSetupSection<String>(
      title: 'Cardio e saúde',
      options: [
        'Melhorar cardio',
        'Caminhar mais',
        'Correr mais tempo',
        'Melhorar resistência aeróbia',
        'Melhorar velocidade',
        'Melhorar recuperação',
        'Melhorar saúde geral',
      ],
    ),
    ProfileSetupSection<String>(
      title: 'Mobilidade e recuperação',
      options: [
        'Melhorar mobilidade',
        'Melhorar elasticidade',
        'Melhorar mobilidade de ombros',
        'Melhorar mobilidade de anca',
        'Melhorar mobilidade de tornozelos',
        'Reduzir dores',
        'Recuperar melhor',
      ],
    ),
    ProfileSetupSection<String>(
      title: 'Artes marciais',
      options: [
        'Melhorar performance no Karate',
        'Melhorar performance no Jiu-Jitsu',
        'Melhorar explosão',
        'Melhorar deslocamento',
        'Melhorar core para artes marciais',
        'Melhorar força de pega para grappling',
        'Melhorar mobilidade para pontapés',
        'Melhorar condicionamento para combate',
      ],
    ),
    ProfileSetupSection<String>(
      title: 'Hábitos',
      options: [
        'Treinar com consistência',
        'Treinar 2 vezes por semana',
        'Treinar 3 vezes por semana',
        'Treinar 4 vezes por semana',
        'Treinar 5 vezes por semana',
        'Criar rotina de treino',
        'Voltar a treinar depois de pausa',
        'Outro',
      ],
    ),
  ];

  static Map<String, String> get equipmentMap => {
    for (final section in equipmentSections)
      for (final option in section.options) option.key: option.name,
  };

  static Set<String> toggleLocation(
    Set<String> current,
    String location,
    bool selected,
  ) {
    final next = {...current};
    if (selected) {
      next.add(location);
    } else {
      next.remove(location);
    }
    return next;
  }

  static Map<String, String> toggleEquipment(
    Map<String, String> current,
    ProfileEquipmentOption option,
    bool selected,
  ) {
    final next = {...current};
    if (selected) {
      next[option.key] = option.name;
    } else {
      next.remove(option.key);
    }
    return next;
  }

  static List<String> parseGeneralGoals(String value) {
    return value
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toSet()
        .toList();
  }

  static String serializeGeneralGoals(Iterable<String> values) {
    return values
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toSet()
        .join(', ');
  }

  static Profile addGeneralGoal(Profile profile, String goal) {
    final goals = parseGeneralGoals(profile.initialGoals);
    goals.add(goal.trim());
    return profile.copyWith(initialGoals: serializeGeneralGoals(goals));
  }

  static Profile editGeneralGoal(
    Profile profile,
    String oldGoal,
    String newGoal,
  ) {
    final goals = parseGeneralGoals(
      profile.initialGoals,
    ).map((goal) => goal == oldGoal ? newGoal.trim() : goal).toList();
    return profile.copyWith(initialGoals: serializeGeneralGoals(goals));
  }

  static Profile deactivateGeneralGoal(Profile profile, String goal) {
    final goals = parseGeneralGoals(
      profile.initialGoals,
    ).where((item) => item != goal).toList();
    return profile.copyWith(initialGoals: serializeGeneralGoals(goals));
  }
}
