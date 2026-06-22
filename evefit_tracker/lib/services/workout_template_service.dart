import 'exercise_catalog_context_service.dart';

class WorkoutTemplateExerciseRef {
  const WorkoutTemplateExerciseRef({
    this.catalogEntryKey = '',
    this.exerciseKey = '',
    this.contextKey = '',
    required this.legacyName,
  });

  final String catalogEntryKey;
  final String exerciseKey;
  final String contextKey;
  final String legacyName;
}

class WorkoutTemplate {
  const WorkoutTemplate({required this.name, required this.exercises});

  final String name;
  final List<WorkoutTemplateExerciseRef> exercises;

  List<String> get exerciseNames => [
    for (final exercise in exercises) exercise.legacyName,
  ];
}

class WorkoutTemplateService {
  const WorkoutTemplateService._();

  static final templates = [
    WorkoutTemplate(
      name: 'Costas + Bíceps + Antebraço',
      exercises: [
        _ref('Puxada alta na máquina', 'Puxada alta', 'Costas'),
        _ref('Remo baixo no gancho de baixo', 'Remo baixo no cabo', 'Costas'),
        _ref(
          'Remo unilateral com halter',
          'Remo unilateral com halter',
          'Costas',
        ),
        _ref('Curl com barra', 'Curl com barra', 'Bíceps'),
        _ref('Curl martelo', 'Curl martelo', 'Bíceps'),
        _ref('Wrist curl', 'Wrist curl', 'Antebraço/Pega'),
        _ref('Farmer walk com halteres', 'Farmer walk', 'Antebraço/Pega'),
      ],
    ),
    WorkoutTemplate(
      name: 'Peito + Ombros + Tríceps',
      exercises: [
        _ref('Supino com barra', 'Supino com barra', 'Peito'),
        _ref('Supino com halteres', 'Supino com halteres', 'Peito'),
        _ref('Press inclinado', 'Supino inclinado com halteres', 'Peito'),
        _ref(
          'Press militar com halteres',
          'Press militar com halteres',
          'Ombros',
        ),
        _ref('Elevação lateral', 'Elevação lateral', 'Ombros'),
        _ref(
          'Extensão de tríceps no cabo',
          'Extensão de tríceps no cabo',
          'Tríceps',
        ),
        _ref(
          'Tríceps testa com barra EZ',
          'Tríceps testa com barra EZ',
          'Tríceps',
        ),
      ],
    ),
    WorkoutTemplate(
      name: 'Costas + Ombros',
      exercises: [
        _ref('Puxada alta na máquina', 'Puxada alta', 'Costas'),
        _ref('Remo baixo no gancho de baixo', 'Remo baixo no cabo', 'Costas'),
        _ref(
          'Remo unilateral com halter',
          'Remo unilateral com halter',
          'Costas',
        ),
        _ref('Face pull no cabo', 'Face pull no cabo', 'Ombros'),
        _ref('Elevação lateral', 'Elevação lateral', 'Ombros'),
        _ref('Elevação posterior', 'Elevação posterior', 'Ombros'),
      ],
    ),
    WorkoutTemplate(
      name: 'Full Upper Body',
      exercises: [
        _ref('Puxada alta na máquina', 'Puxada alta', 'Costas'),
        _ref('Remo baixo no gancho de baixo', 'Remo baixo no cabo', 'Costas'),
        _ref('Supino com halteres', 'Supino com halteres', 'Peito'),
        _ref(
          'Press militar com halteres',
          'Press militar com halteres',
          'Ombros',
        ),
        _ref('Curl martelo', 'Curl martelo', 'Bíceps'),
        _ref(
          'Extensão de tríceps no cabo',
          'Extensão de tríceps no cabo',
          'Tríceps',
        ),
        _ref('Prancha', 'Prancha', 'Core'),
      ],
    ),
    WorkoutTemplate(
      name: 'Pernas + Core',
      exercises: [
        _ref(
          'Agachamento com peso corporal',
          'Agachamento com peso corporal',
          'Pernas',
        ),
        _ref('Agachamento goblet', 'Agachamento goblet', 'Pernas'),
        _ref('Peso morto romeno', 'Peso morto romeno com halteres', 'Pernas'),
        _ref('Extensão de perna na máquina', 'Extensão de perna', 'Pernas'),
        _ref('Gémeos em pé', 'Gémeos em pé', 'Pernas'),
        _ref('Prancha', 'Prancha', 'Core'),
        _ref('Elevação de pernas', 'Elevação de pernas', 'Core'),
      ],
    ),
    WorkoutTemplate(
      name: 'Cardio / Passadeira',
      exercises: [
        _ref('Passadeira', 'Passadeira caminhada', 'Cardio'),
        _ref('Mountain climbers', 'Mountain climbers', 'Core'),
      ],
    ),
  ];

  static WorkoutTemplateExerciseRef _ref(
    String displayName,
    String catalogName,
    String group,
  ) {
    final exerciseKey = ExerciseCatalogContextService.stableKey(catalogName);
    final contextKey = ExerciseCatalogContextService.stableKey(group);
    return WorkoutTemplateExerciseRef(
      catalogEntryKey: '${exerciseKey}__$contextKey',
      exerciseKey: exerciseKey,
      contextKey: contextKey,
      legacyName: displayName,
    );
  }
}
