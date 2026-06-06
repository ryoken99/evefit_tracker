import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.0 training architecture', () {
    test('defines anatomical hierarchy from region to specific muscle', () {
      expect(TrainingArchitecture.regions.map((item) => item.name), [
        'Corpo inteiro',
        'Parte superior',
        'Parte inferior',
        'Core',
        'Cardio',
        'Artes marciais',
        'Mobilidade e recuperação',
        'Personalizado',
      ]);

      final biceps = TrainingArchitecture.legacySelectionFor('Bíceps');
      expect(biceps.regionKey, 'upper');
      expect(biceps.groupKey, 'arms');
      expect(biceps.subgroupKey, 'anterior_arm');
      expect(biceps.specificMuscleKey, 'biceps');

      final treadmill = TrainingArchitecture.legacySelectionFor('Passadeira');
      expect(treadmill.regionKey, 'cardio');
      expect(treadmill.groupKey, 'cardio_machine');
      expect(treadmill.subgroupKey, 'treadmill');
    });

    test('equipment catalog contains required base equipment', () {
      expect(
        TrainingArchitecture.equipment.map((item) => item.name),
        containsAll([
          'Peso corporal',
          'Halteres',
          'Barra',
          'Discos',
          'Banco',
          'Máquina multifunções',
          'Cabo alto',
          'Cabo baixo',
          'Máquinas de ginásio',
          'Barra fixa',
          'Elásticos',
          'Kettlebell',
          'Passadeira',
          'Bicicleta',
          'Elíptica',
          'Corda de saltar',
          'Saco de pancada',
          'Tatami / espaço de artes marciais',
          'Espaço exterior',
          'Nenhum equipamento',
          'Outro',
        ]),
      );
    });
  });

  group('v0.7.0 anatomical filters', () {
    test(
      'complete arms shows biceps, triceps, brachialis, forearm and grip',
      () {
        final names = _names(
          const TrainingSelection(regionKey: 'upper', groupKey: 'arms'),
        );

        expect(
          names,
          containsAll([
            'Curl com halteres',
            'Curl martelo',
            'Extensão de tríceps no cabo',
            'Farmer walk',
            'Dead hang',
          ]),
        );
      },
    );

    test('biceps does not show triceps', () {
      final names = _names(TrainingArchitecture.legacySelectionFor('Bíceps'));

      expect(names, contains('Curl com halteres'));
      expect(names, isNot(contains('Extensão de tríceps no cabo')));
    });

    test('triceps does not show biceps', () {
      final names = _names(TrainingArchitecture.legacySelectionFor('Tríceps'));

      expect(names, contains('Extensão de tríceps no cabo'));
      expect(names, isNot(contains('Curl com halteres')));
    });

    test('forearm and grip does not show bench press', () {
      final names = _names(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'forearm_hand',
          subgroupKey: 'grip_strength',
        ),
      );

      expect(names, contains('Dead hang'));
      expect(names, isNot(contains('Supino com barra')));
    });

    test('chest does not show legs', () {
      final names = _names(TrainingArchitecture.legacySelectionFor('Peito'));

      expect(names, contains('Supino com barra'));
      expect(names, isNot(contains('Agachamento goblet')));
    });

    test('back does not show isolated biceps curl', () {
      final names = _names(TrainingArchitecture.legacySelectionFor('Costas'));

      expect(names, contains('Remo unilateral com halter'));
      expect(names, isNot(contains('Curl com halteres')));
    });

    test('shoulders do not show bench press as primary exercise', () {
      final names = _names(TrainingArchitecture.legacySelectionFor('Ombros'));

      expect(names, contains('Elevação lateral'));
      expect(names, isNot(contains('Supino com barra')));
    });

    test(
      'complete legs shows quadriceps, posterior, glutes, calves and adductors',
      () {
        final names = _names(TrainingArchitecture.legacySelectionFor('Pernas'));

        expect(
          names,
          containsAll([
            'Agachamento goblet',
            'Peso morto romeno com halteres',
            'Hip thrust',
            'Gémeos em pé',
            'Adução de anca',
            'Abdução de anca',
          ]),
        );
        expect(names, isNot(contains('Curl com halteres')));
      },
    );

    test('quadriceps does not show biceps curl', () {
      final names = _names(
        TrainingArchitecture.legacySelectionFor('Quadríceps'),
      );

      expect(names, contains('Agachamento goblet'));
      expect(names, isNot(contains('Curl com halteres')));
    });

    test('glutes do not show chest', () {
      final names = _names(TrainingArchitecture.legacySelectionFor('Glúteos'));

      expect(names, contains('Hip thrust'));
      expect(names, isNot(contains('Supino com barra')));
    });

    test('core does not show biceps', () {
      final names = _names(
        TrainingArchitecture.legacySelectionFor('Core/Abdominal'),
      );

      expect(names, contains('Prancha'));
      expect(names, isNot(contains('Curl com halteres')));
    });
  });

  group('v0.7.0 cardio and martial arts filters', () {
    test('treadmill only shows treadmill exercises', () {
      expect(_names(TrainingArchitecture.legacySelectionFor('Passadeira')), [
        'Passadeira caminhada',
        'Passadeira corrida leve',
      ]);
    });

    test('bike only shows bike exercises', () {
      expect(_names(TrainingArchitecture.legacySelectionFor('Bicicleta')), [
        'Bicicleta ritmo leve',
      ]);
    });

    test('elliptical only shows elliptical exercises', () {
      expect(_names(TrainingArchitecture.legacySelectionFor('Elíptica')), [
        'Elíptica ritmo leve',
      ]);
    });

    test('general cardio shows several modalities', () {
      expect(
        _names(TrainingArchitecture.legacySelectionFor('Cardio geral')),
        containsAll([
          'Passadeira caminhada',
          'Bicicleta ritmo leve',
          'Elíptica ritmo leve',
          'Corda de saltar ritmo leve',
          'Corrida exterior leve',
        ]),
      );
    });

    test('karate does not show exclusive jiu-jitsu', () {
      final names = _names(TrainingArchitecture.legacySelectionFor('Karate'));

      expect(names, contains('Kihon'));
      expect(names, isNot(contains('Shrimp / fuga de anca')));
    });

    test('jiu-jitsu does not show exclusive karate', () {
      final names = _names(
        TrainingArchitecture.legacySelectionFor('Jiu-Jitsu'),
      );

      expect(names, contains('Shrimp / fuga de anca'));
      expect(names, isNot(contains('Kihon')));
    });
  });

  group('v0.7.0 equipment and location filters', () {
    test('home with dumbbells shows dumbbell and bodyweight exercises', () {
      final names = _names(
        const TrainingSelection(regionKey: 'upper', groupKey: 'arms'),
        location: 'Casa',
        equipment: {'bodyweight', 'dumbbells'},
      );

      expect(names, contains('Curl com halteres'));
      expect(names, contains('Flexões fechadas'));
    });

    test('home with dumbbells does not show cable', () {
      final names = _names(
        TrainingArchitecture.legacySelectionFor('Tríceps'),
        location: 'Casa',
        equipment: {'bodyweight', 'dumbbells'},
      );

      expect(names, isNot(contains('Extensão de tríceps no cabo')));
    });

    test('home with treadmill shows treadmill', () {
      final names = _names(
        TrainingArchitecture.legacySelectionFor('Passadeira'),
        location: 'Casa',
        equipment: {'bodyweight', 'treadmill'},
      );

      expect(names, contains('Passadeira caminhada'));
    });

    test('home without treadmill does not show treadmill', () {
      final names = _names(
        TrainingArchitecture.legacySelectionFor('Passadeira'),
        location: 'Casa',
        equipment: {'bodyweight', 'dumbbells'},
      );

      expect(names, isEmpty);
    });

    test('gym still respects selected subcategory with full equipment', () {
      final names = _names(
        TrainingArchitecture.legacySelectionFor('Passadeira'),
        location: 'Ginásio',
      );

      expect(names, ['Passadeira caminhada', 'Passadeira corrida leve']);
    });

    test('show all ignores filters but marks unavailable exercises', () {
      final availability = ExerciseFilterService.getAvailableExercises(
        exercises: _fixtureExercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: {'bodyweight'},
        selection: TrainingArchitecture.legacySelectionFor('Bíceps'),
        showAllExercises: true,
      );

      final cable = availability.firstWhere(
        (item) => item.exercise.name == 'Extensão de tríceps no cabo',
      );
      expect(availability.length, _fixtureExercises.length);
      expect(cable.isAvailable, isFalse);
      expect(cable.unavailableReason, contains('filtro'));
    });

    test('all presented exercises have descriptions, steps and equipment', () {
      final availability = ExerciseFilterService.getAvailableExercises(
        exercises: _fixtureExercises,
        trainingLocation: 'Ginásio',
        availableEquipmentKeys: {},
        selection: const TrainingSelection(regionKey: 'upper'),
        showAllExercises: false,
      );

      for (final item in availability) {
        expect(item.exercise.description.trim(), isNotEmpty);
        expect(item.exercise.executionSteps.trim(), isNotEmpty);
        expect(item.exercise.equipment.trim(), isNotEmpty);
      }
    });
  });
}

List<String> _names(
  TrainingSelection selection, {
  String location = 'Ginásio',
  Set<String> equipment = const {},
}) {
  return ExerciseFilterService.getAvailableExercises(
    exercises: _fixtureExercises,
    trainingLocation: location,
    availableEquipmentKeys: equipment,
    selection: selection,
    showAllExercises: false,
  ).map((item) => item.exercise.name).toList();
}

final _fixtureExercises = [
  _exercise(
    'Curl com halteres',
    'Bíceps',
    'Halteres',
    'Braquial, braquiorradial, flexores do antebraço',
  ),
  _exercise('Curl martelo', 'Bíceps', 'Halteres', 'Braquial, braquiorradial'),
  _exercise(
    'Extensão de tríceps no cabo',
    'Tríceps',
    'Cabo alto',
    'Tríceps cabeça longa, cabeça lateral, cabeça medial',
  ),
  _exercise('Flexões fechadas', 'Tríceps', 'Peso corporal', 'Peito, ombros'),
  _exercise('Farmer walk', 'Antebraço/Pega', 'Halteres', 'Pega de suporte'),
  _exercise('Dead hang', 'Antebraço/Pega', 'Barra fixa', 'Pega de suporte'),
  _exercise('Supino com barra', 'Peito', 'Barra, banco', 'Ombros, tríceps'),
  _exercise(
    'Remo unilateral com halter',
    'Costas',
    'Halteres',
    'Dorsal, romboides',
  ),
  _exercise('Elevação lateral', 'Ombros', 'Halteres', 'Deltoide lateral'),
  _exercise('Agachamento goblet', 'Quadríceps', 'Halteres', 'Glúteos'),
  _exercise(
    'Peso morto romeno com halteres',
    'Posterior de coxa',
    'Halteres',
    'Glúteos, lombar',
  ),
  _exercise('Hip thrust', 'Glúteos', 'Banco', 'Glúteo máximo'),
  _exercise('Gémeos em pé', 'Gémeos', 'Peso corporal', 'Sóleo'),
  _exercise('Adução de anca', 'Adutores', 'Peso corporal', 'Adutores'),
  _exercise('Abdução de anca', 'Abdutores', 'Peso corporal', 'Abdutores'),
  _exercise('Prancha', 'Core', 'Peso corporal', 'Anti-extensão'),
  _exercise('Passadeira caminhada', 'Cardio', 'Passadeira', 'Passadeira'),
  _exercise('Passadeira corrida leve', 'Cardio', 'Passadeira', 'Passadeira'),
  _exercise('Bicicleta ritmo leve', 'Cardio', 'Bicicleta', 'Bicicleta'),
  _exercise('Elíptica ritmo leve', 'Cardio', 'Elíptica', 'Elíptica'),
  _exercise(
    'Corda de saltar ritmo leve',
    'Cardio',
    'Corda de saltar',
    'Corda de saltar',
  ),
  _exercise('Corrida exterior leve', 'Cardio', 'Espaço exterior', 'Corrida'),
  _exercise('Kihon', 'Karate', 'Peso corporal', 'Karate técnico'),
  _exercise('Shrimp / fuga de anca', 'Jiu-Jitsu', 'Tatami', 'Grappling'),
];

Exercise _exercise(
  String name,
  String group,
  String equipment,
  String secondary,
) {
  return Exercise(
    name: name,
    muscleGroup: group,
    secondaryMuscleGroups: secondary,
    equipment: equipment,
    description:
        '$name trabalha $group com foco específico e progressão segura.',
    executionSteps:
        'Prepara a posição, estabiliza o corpo, executa $name com controlo e regressa de forma gradual.',
    commonMistakes: 'Evitar pressa, compensações e amplitude sem controlo.',
    safetyNotes: 'Para se houver dor aguda, tontura ou perda de técnica.',
    isDefault: true,
  );
}
