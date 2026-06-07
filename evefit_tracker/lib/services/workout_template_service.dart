class WorkoutTemplate {
  const WorkoutTemplate({required this.name, required this.exerciseNames});

  final String name;
  final List<String> exerciseNames;
}

class WorkoutTemplateService {
  static const templates = [
    WorkoutTemplate(
      name: 'Costas + Bíceps + Antebraço',
      exerciseNames: [
        'Puxada alta na máquina',
        'Remo baixo no gancho de baixo',
        'Remo unilateral com haltere',
        'Curl com barra',
        'Curl martelo',
        'Wrist curl',
        'Farmer walk com halteres',
      ],
    ),
    WorkoutTemplate(
      name: 'Peito + Ombros + Tríceps',
      exerciseNames: [
        'Supino com barra',
        'Supino com halteres',
        'Press inclinado',
        'Press militar com halteres',
        'Elevação lateral',
        'Extensão de tríceps no cabo',
        'Tríceps testa com barra EZ',
      ],
    ),
    WorkoutTemplate(
      name: 'Costas + Ombros',
      exerciseNames: [
        'Puxada alta na máquina',
        'Remo baixo no gancho de baixo',
        'Remo unilateral com haltere',
        'Face pull no cabo',
        'Elevação lateral',
        'Elevação posterior',
      ],
    ),
    WorkoutTemplate(
      name: 'Full Upper Body',
      exerciseNames: [
        'Puxada alta na máquina',
        'Remo baixo no gancho de baixo',
        'Supino com halteres',
        'Press militar com halteres',
        'Curl martelo',
        'Extensão de tríceps no cabo',
        'Prancha',
      ],
    ),
    WorkoutTemplate(
      name: 'Pernas + Core',
      exerciseNames: [
        'Agachamento com peso corporal',
        'Agachamento goblet',
        'Peso morto romeno',
        'Extensão de perna na máquina',
        'Gémeos em pé',
        'Prancha',
        'Elevação de pernas',
      ],
    ),
    WorkoutTemplate(
      name: 'Cardio / Passadeira',
      exerciseNames: ['Passadeira', 'Mountain climbers'],
    ),
  ];
}
