class WorkoutTypeSection {
  const WorkoutTypeSection({required this.title, required this.types});

  final String title;
  final List<String> types;
}

class WorkoutTaxonomy {
  const WorkoutTaxonomy._();

  static const sections = [
    WorkoutTypeSection(
      title: 'Corpo inteiro',
      types: ['Full Body', 'Upper Body', 'Lower Body', 'Push', 'Pull', 'Legs'],
    ),
    WorkoutTypeSection(
      title: 'Parte superior',
      types: [
        'Peito',
        'Costas',
        'Ombros',
        'Braços',
        'Bíceps',
        'Tríceps',
        'Antebraço/Pega',
        'Trapézio',
        'Pescoço',
      ],
    ),
    WorkoutTypeSection(title: 'Core', types: ['Core/Abdominal', 'Lombar']),
    WorkoutTypeSection(
      title: 'Parte inferior',
      types: [
        'Pernas',
        'Quadríceps',
        'Posterior de coxa',
        'Glúteos',
        'Gémeos',
        'Adutores/Abdutores',
      ],
    ),
    WorkoutTypeSection(
      title: 'Cardio',
      types: [
        'Cardio geral',
        'Passadeira',
        'Bicicleta',
        'Elíptica',
        'Corda de saltar',
        'Caminhada exterior',
        'Corrida exterior',
        'HIIT',
      ],
    ),
    WorkoutTypeSection(
      title: 'Artes marciais',
      types: [
        'Karate',
        'Jiu-Jitsu',
        'Condicionamento para artes marciais',
        'Mobilidade para artes marciais',
      ],
    ),
    WorkoutTypeSection(
      title: 'Mobilidade e recuperação',
      types: ['Mobilidade', 'Alongamentos', 'Recuperação'],
    ),
    WorkoutTypeSection(
      title: 'Personalizado',
      types: ['Outro', 'Treino personalizado'],
    ),
  ];

  static List<String> get defaultTypeNames => [
    for (final section in sections) ...section.types,
  ];

  static WorkoutTypeSection? sectionFor(String workoutType) {
    final normalized = normalize(workoutType);
    for (final section in sections) {
      for (final type in section.types) {
        if (normalize(type) == normalized) return section;
      }
    }
    return null;
  }

  static String displayWithSection(String workoutType) {
    final section = sectionFor(workoutType);
    if (section == null) return workoutType;
    return '${section.title} · $workoutType';
  }

  static List<String> groupsFor(String workoutType) {
    final key = normalize(workoutType);
    return _typeGroups[key] ?? const [];
  }

  static bool isSpecific(String workoutType) {
    return _specificTypes.contains(normalize(workoutType));
  }

  static bool allowsExercise({
    required String workoutType,
    required String exerciseName,
    required String primaryGroup,
    required String secondaryGroups,
    required String equipment,
  }) {
    final allowedGroups = groupsFor(workoutType);
    if (allowedGroups.isEmpty) return true;
    final tags = exerciseGroups(
      name: exerciseName,
      primaryGroup: primaryGroup,
      secondaryGroups: secondaryGroups,
      equipment: equipment,
    );
    return tags.any(allowedGroups.contains);
  }

  static Set<String> exerciseGroups({
    required String name,
    required String primaryGroup,
    required String secondaryGroups,
    required String equipment,
  }) {
    final haystack = normalize(
      '$name $primaryGroup $secondaryGroups $equipment',
    );
    final result = <String>{};

    void addIf(String tag, List<String> needles) {
      if (needles.any(haystack.contains)) result.add(tag);
    }

    addIf('passadeira', ['passadeira']);
    addIf('bicicleta', ['bicicleta']);
    addIf('eliptica', ['eliptica']);
    addIf('corda_saltar', ['corda']);
    addIf('caminhada_exterior', ['caminhada exterior']);
    addIf('corrida_exterior', ['corrida exterior', 'sprints exterior']);
    addIf('hiit', ['hiit', 'circuito cardio']);
    addIf('cardio', [
      'cardio',
      'passadeira',
      'bicicleta',
      'eliptica',
      'corda',
      'caminhada',
      'corrida',
      'sprint',
    ]);

    addIf('peito', [
      'peito',
      'flex',
      'supino',
      'abertura',
      'chest press',
      'crossover',
      'dips para peito',
    ]);
    addIf('costas', [
      'costas',
      'dorsal',
      'puxada',
      'remo',
      'pullover',
      'face pull',
      'dead hang',
      'hiperextensao',
    ]);
    addIf('ombros', [
      'ombro',
      'ombros',
      'deltoide',
      'press militar',
      'arnold',
      'elevacao lateral',
      'elevacao frontal',
      'reverse fly',
      'rotacao externa',
      'rotacao interna',
      'y raise',
      'w raise',
    ]);
    addIf('biceps', [
      'biceps',
      'bicep',
      'braquial',
      'braquiorradial',
      'curl',
      'chin-up',
    ]);
    addIf('triceps', [
      'triceps',
      'tricep',
      'supino fechado',
      'fundos entre apoios',
      'flexoes fechadas',
      'kickback',
    ]);
    addIf('antebraco_pega', [
      'antebraco',
      'pega',
      'wrist',
      'farmer',
      'dead hang',
      'aperto',
      'pinch',
      'plate hold',
      'towel',
      'finger',
      'punho',
    ]);
    addIf('trapezio', ['trapezio', 'encolhimento', 'remo alto']);
    addIf('pescoco', ['pescoco', 'cervical']);
    addIf('core', [
      'core',
      'abdominal',
      'prancha',
      'crunch',
      'dead bug',
      'hollow',
      'mountain climbers',
      'pallof',
      'russian',
      'bird dog',
      'side bend',
      'vacuum',
      'flutter',
      'toe touches',
    ]);
    addIf('lombar', ['lombar', 'hiperextensao', 'bird dog', 'peso morto']);

    addIf('quadriceps', [
      'quadriceps',
      'agachamento',
      'extensao de perna',
      'leg press',
      'step-up',
      'wall sit',
      'lunges',
    ]);
    addIf('posterior_coxa', [
      'posterior',
      'peso morto',
      'curl de perna',
      'good morning',
      'ponte de gluteo',
      'hip thrust',
    ]);
    addIf('gluteos', [
      'gluteo',
      'gluteos',
      'hip thrust',
      'ponte',
      'abducao de anca',
      'kickback',
    ]);
    addIf('gemeos', ['gemeos', 'soleo', 'panturrilha', 'calf']);
    addIf('adutores_abdutores', [
      'adutor',
      'adutores',
      'abdutor',
      'abdutores',
      'abducao',
      'aducao',
    ]);
    addIf('pernas', [
      'pernas',
      'quadriceps',
      'posterior',
      'gluteo',
      'gemeos',
      'soleo',
      'tibial',
      'adutor',
      'abdutor',
      'agachamento',
      'lunges',
      'step-up',
    ]);

    addIf('karate', [
      'karate',
      'kihon',
      'kata',
      'kumite',
      'sombra de karate',
      'socos tecnicos',
      'pontapes tecnicos',
    ]);
    addIf('jiu_jitsu', [
      'jiu-jitsu',
      'jiu jitsu',
      'shrimp',
      'grappling',
      'technical stand-up',
      'passagem de guarda',
    ]);
    addIf('artes_marciais', [
      'karate',
      'jiu-jitsu',
      'jiu jitsu',
      'tatami',
      'guarda',
      'grappling',
    ]);
    addIf('mobilidade', ['mobilidade', 'rotacao', 'alongamento dinamico']);
    addIf('alongamentos', ['alongamento', 'alongamentos']);
    addIf('recuperacao', ['recuperacao', 'respiracao', 'cooldown']);

    if (result.isEmpty) {
      result.add(normalize(primaryGroup).replaceAll(' ', '_'));
    }
    return result;
  }

  static String normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll('ã', 'a')
        .replaceAll('á', 'a')
        .replaceAll('à', 'a')
        .replaceAll('â', 'a')
        .replaceAll('ç', 'c')
        .replaceAll('é', 'e')
        .replaceAll('ê', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ô', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static const _specificTypes = {
    'passadeira',
    'bicicleta',
    'eliptica',
    'corda de saltar',
    'caminhada exterior',
    'corrida exterior',
    'biceps',
    'triceps',
    'peito',
    'ombros',
    'costas',
    'quadriceps',
    'posterior de coxa',
    'gluteos',
    'gemeos',
    'karate',
    'jiu-jitsu',
    'pescoco',
    'trapezio',
    'lombar',
    'adutores/abdutores',
  };

  static const _typeGroups = {
    'full body': [
      'peito',
      'costas',
      'ombros',
      'biceps',
      'triceps',
      'antebraco_pega',
      'core',
      'pernas',
      'quadriceps',
      'posterior_coxa',
      'gluteos',
      'gemeos',
      'adutores_abdutores',
    ],
    'upper body': [
      'peito',
      'costas',
      'ombros',
      'biceps',
      'triceps',
      'antebraco_pega',
      'trapezio',
      'pescoco',
    ],
    'lower body': [
      'pernas',
      'quadriceps',
      'posterior_coxa',
      'gluteos',
      'gemeos',
      'adutores_abdutores',
    ],
    'push': ['peito', 'ombros', 'triceps'],
    'pull': ['costas', 'biceps', 'antebraco_pega', 'trapezio'],
    'legs': [
      'pernas',
      'quadriceps',
      'posterior_coxa',
      'gluteos',
      'gemeos',
      'adutores_abdutores',
    ],
    'peito': ['peito'],
    'costas': ['costas', 'lombar'],
    'ombros': ['ombros'],
    'bracos': ['biceps', 'triceps', 'antebraco_pega'],
    'biceps': ['biceps'],
    'triceps': ['triceps'],
    'antebraco/pega': ['antebraco_pega'],
    'trapezio': ['trapezio'],
    'pescoco': ['pescoco'],
    'core/abdominal': ['core'],
    'lombar': ['lombar'],
    'pernas': [
      'pernas',
      'quadriceps',
      'posterior_coxa',
      'gluteos',
      'gemeos',
      'adutores_abdutores',
    ],
    'quadriceps': ['quadriceps'],
    'posterior de coxa': ['posterior_coxa'],
    'gluteos': ['gluteos'],
    'gemeos': ['gemeos'],
    'adutores/abdutores': ['adutores_abdutores'],
    'cardio geral': [
      'cardio',
      'passadeira',
      'bicicleta',
      'eliptica',
      'corda_saltar',
      'caminhada_exterior',
      'corrida_exterior',
      'hiit',
    ],
    'passadeira': ['passadeira'],
    'bicicleta': ['bicicleta'],
    'eliptica': ['eliptica'],
    'corda de saltar': ['corda_saltar'],
    'caminhada exterior': ['caminhada_exterior'],
    'corrida exterior': ['corrida_exterior'],
    'hiit': ['hiit'],
    'karate': ['karate'],
    'jiu-jitsu': ['jiu_jitsu'],
    'condicionamento para artes marciais': [
      'artes_marciais',
      'karate',
      'jiu_jitsu',
      'core',
      'antebraco_pega',
    ],
    'mobilidade para artes marciais': ['artes_marciais', 'mobilidade'],
    'mobilidade': ['mobilidade'],
    'alongamentos': ['alongamentos', 'mobilidade'],
    'recuperacao': ['recuperacao', 'mobilidade'],
  };
}
