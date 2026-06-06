import '../models/body_measurement.dart';
import '../models/goal.dart';
import '../models/user_profile.dart';

class SeedData {
  static final startDate = DateTime(2026, 6, 6);

  static final profile = UserProfile(
    name: 'Sandro',
    heightCm: 159,
    startDate: startDate,
    mainGoal: 'V-shape',
    notes:
        'Objetivo secundário: definir abdominal e reduzir gordura lateral acima da anca. IMC 20.9, gordura 14.1%, massa muscular 44.9 kg, água 56.5%, proteína 24.4%, gordura subcutânea 4.2%, massa óssea 2.3 kg, gordura visceral 6, metabolismo basal 1390 kcal, idade corporal 22 anos.',
  );

  static final initialMeasurement = BodyMeasurement(
    date: startDate,
    weightKg: 54.9,
    bodyFatPercentage: 14.1,
    muscleMassKg: 44.9,
    leftBicepRelaxedCm: 27.5,
    leftBicepFlexedCm: 31.5,
    rightBicepRelaxedCm: 27.5,
    rightBicepFlexedCm: 31.5,
    shouldersCm: 40,
    chestCm: 30.5,
    sideHipAreaCm: 79,
    notes: 'Seed inicial: Pixel 8 Pro, objetivo V-shape.',
  );

  static const workoutTypes = [
    'Costas + Bíceps + Antebraço',
    'Peito + Ombros + Tríceps',
    'Pernas + Core',
    'Costas + Ombros',
    'Full Upper Body',
    'Cardio / Passadeira',
    'Jiu-Jitsu / Karate',
    'Outro',
  ];

  static const exercisesByGroup = {
    'Costas': [
      'Puxada alta na máquina',
      'Remo baixo no gancho de baixo',
      'Remo unilateral com haltere',
      'Pullover',
      'Face pull',
      'Encolhimento de ombros',
      'Hiperextensão lombar',
      'Remo com barra',
      'Remo invertido',
    ],
    'Ombros': [
      'Press militar com halteres',
      'Press militar com barra',
      'Elevação lateral',
      'Elevação frontal',
      'Elevação posterior',
      'Face pull',
      'Rotação externa do ombro',
      'Shrugs / encolhimentos',
    ],
    'Peito': [
      'Flexões',
      'Supino com barra',
      'Supino com halteres',
      'Aberturas com halteres',
      'Press inclinado',
      'Pullover com halter',
      'Squeeze press',
    ],
    'Bíceps e braquial': [
      'Curl com barra',
      'Curl com halteres',
      'Curl martelo',
      'Curl concentrado',
      'Curl inverso',
      'Curl inclinado',
    ],
    'Tríceps': [
      'Extensão de tríceps no cabo',
      'Extensão de tríceps acima da cabeça',
      'Tríceps testa',
      'Supino fechado',
      'Fundos entre apoios',
      'Flexões fechadas',
    ],
    'Antebraço, punho, mão e pega': [
      'Wrist curl',
      'Reverse wrist curl',
      'Farmer walk com halteres',
      'Dead hang',
      'Aperto isométrico de halteres',
      'Curl martelo',
      'Curl inverso',
      'Pronação/supinação com halter leve',
      'Pinch grip com discos',
    ],
    'Core e abdominal': [
      'Prancha',
      'Prancha lateral',
      'Crunch',
      'Reverse crunch',
      'Elevação de pernas',
      'Dead bug',
      'Hollow hold',
      'Mountain climbers',
      'Pallof press',
    ],
    'Pernas': [
      'Agachamento',
      'Agachamento goblet',
      'Lunges / afundos',
      'Peso morto romeno',
      'Extensão de perna na máquina',
      'Gémeos em pé',
      'Ponte de glúteo',
      'Passadeira',
    ],
  };

  static final goals = [
    ...[
      'Construir V-shape',
      'Aumentar largura das costas',
      'Desenvolver deltoide lateral e posterior',
      'Desenvolver peito completo',
      'Desenvolver braços completos',
      'Desenvolver antebraço, punho, mãos e força de pega',
      'Fortalecer core completo',
      'Definir abdominal gradualmente',
      'Reduzir gordura lateral acima da anca sem dieta agressiva',
      'Manter ou melhorar composição corporal',
    ].map(
      (title) => Goal(
        title: title,
        description: '',
        phase: 'Fase 1',
        isActive: true,
        createdAt: startDate,
      ),
    ),
    ...[
      'Reforçar pernas',
      'Melhorar equilíbrio geral',
      'Continuar a construir parte superior',
      'Melhorar condicionamento',
    ].map(
      (title) => Goal(
        title: title,
        description: '',
        phase: 'Fase 2',
        isActive: true,
        createdAt: startDate,
      ),
    ),
    ...[
      'Definição mais fina',
      'Ajuste estético',
      'Comparação visual de fotos',
      'Optimização de treino e nutrição',
    ].map(
      (title) => Goal(
        title: title,
        description: '',
        phase: 'Fase 3',
        isActive: true,
        createdAt: startDate,
      ),
    ),
  ];
}
