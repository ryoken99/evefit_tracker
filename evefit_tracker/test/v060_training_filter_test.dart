import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/models/workout_type.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/workout_taxonomy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.6.0 workout taxonomy', () {
    test('categorizes default workout types in the required sections', () {
      expect(WorkoutTaxonomy.sections.map((section) => section.title), [
        'Corpo inteiro',
        'Parte superior',
        'Core',
        'Parte inferior',
        'Cardio',
        'Artes marciais',
        'Mobilidade e recuperação',
        'Personalizado',
      ]);

      expect(WorkoutTaxonomy.sectionFor('Passadeira')?.title, 'Cardio');
      expect(WorkoutTaxonomy.sectionFor('Bíceps')?.title, 'Parte superior');
      expect(WorkoutTaxonomy.sectionFor('Lombar')?.title, 'Core');
      expect(
        WorkoutTaxonomy.sectionFor('Adutores/Abdutores')?.title,
        'Parte inferior',
      );
      expect(
        WorkoutTaxonomy.sectionFor('Treino personalizado')?.title,
        'Personalizado',
      );
    });
  });

  group('v0.6.0 workout exercise filters', () {
    test('specific cardio types only show their own modality', () {
      expect(_namesFor('Passadeira'), [
        'Passadeira caminhada',
        'Passadeira caminhada rápida',
        'Passadeira corrida leve',
        'Passadeira corrida intervalada',
        'Passadeira inclinação',
        'Passadeira sprints intervalados',
        'Passadeira aquecimento',
        'Passadeira cooldown',
      ]);

      expect(_namesFor('Bicicleta'), [
        'Bicicleta ritmo leve',
        'Bicicleta ritmo moderado',
        'Bicicleta intervalos',
        'Bicicleta resistência',
        'Bicicleta aquecimento',
        'Bicicleta cooldown',
      ]);

      expect(_namesFor('Elíptica'), [
        'Elíptica ritmo leve',
        'Elíptica ritmo moderado',
        'Elíptica intervalos',
        'Elíptica resistência',
        'Elíptica aquecimento',
        'Elíptica cooldown',
      ]);

      expect(_namesFor('Corda de saltar'), [
        'Corda de saltar ritmo leve',
        'Corda de saltar intervalos',
        'Corda de saltar pés alternados',
        'Corda de saltar joelhos altos',
        'Corda de saltar double unders',
      ]);
    });

    test('cardio geral shows several cardio modalities', () {
      final names = _namesFor('Cardio geral');

      expect(
        names,
        containsAll([
          'Passadeira caminhada',
          'Bicicleta ritmo leve',
          'Elíptica ritmo leve',
          'Corda de saltar ritmo leve',
          'Caminhada exterior leve',
          'Corrida exterior leve',
          'HIIT simples',
          'Circuito cardio leve',
        ]),
      );
    });

    test('muscle-specific types exclude unrelated muscle groups', () {
      expect(_namesFor('Bíceps'), contains('Curl com halteres'));
      expect(_namesFor('Bíceps'), isNot(contains('Agachamento goblet')));
      expect(
        _namesFor('Bíceps'),
        isNot(contains('Extensão de tríceps no cabo')),
      );

      expect(_namesFor('Tríceps'), contains('Extensão de tríceps no cabo'));
      expect(_namesFor('Tríceps'), isNot(contains('Supino com barra')));

      expect(_namesFor('Pernas'), contains('Agachamento goblet'));
      expect(_namesFor('Pernas'), contains('Abdução de anca'));
      expect(_namesFor('Pernas'), isNot(contains('Curl com halteres')));
    });

    test('martial arts types do not leak exclusive drills', () {
      expect(_namesFor('Karate'), contains('Kihon'));
      expect(_namesFor('Karate'), isNot(contains('Shrimp / fuga de anca')));

      expect(_namesFor('Jiu-Jitsu'), contains('Shrimp / fuga de anca'));
      expect(_namesFor('Jiu-Jitsu'), isNot(contains('Kihon')));
    });

    test('home equipment filters after workout type', () {
      final visible = ExerciseFilterService.filter(
        exercises: _fixtureExercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: {'bodyweight', 'dumbbells', 'treadmill'},
        workoutType: _type('Bíceps'),
      );

      expect(visible.map((item) => item.name), ['Curl com halteres']);
    });

    test(
      'dojo location excludes gym machines but keeps martial arts and core',
      () {
        final visible = ExerciseFilterService.filter(
          exercises: _fixtureExercises,
          trainingLocation: 'Dojo / Artes marciais',
          availableEquipmentKeys: {'bodyweight', 'tatami'},
          workoutType: _type('Jiu-Jitsu'),
        );

        expect(
          visible.map((item) => item.name),
          contains('Shrimp / fuga de anca'),
        );
        expect(
          visible.map((item) => item.name),
          isNot(contains('Remo baixo no cabo')),
        );
      },
    );

    test('show all ignores workout type and equipment filters', () {
      final visible = ExerciseFilterService.filter(
        exercises: _fixtureExercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: {'bodyweight'},
        workoutType: _type('Passadeira'),
        showAllWithoutEquipment: true,
      );

      expect(visible.length, _fixtureExercises.length);
    });

    test('contextual group dropdown only uses visible exercise groups', () {
      final groups = ExerciseFilterService.contextualGroups(
        exercises: _fixtureExercises,
        trainingLocation: 'Ginásio',
        availableEquipmentKeys: {},
        workoutType: _type('Passadeira'),
        showAll: false,
      );

      expect(groups, ['Todos', 'Cardio']);
    });

    test(
      'all filterable exercises have useful explanations and execution steps',
      () {
        for (final exercise in _fixtureExercises) {
          expect(
            exercise.description.trim().split(RegExp(r'\s+')).length,
            greaterThanOrEqualTo(8),
            reason: '${exercise.name} needs a useful description',
          );
          expect(
            exercise.executionSteps.trim().split(RegExp(r'\s+')).length,
            greaterThanOrEqualTo(12),
            reason: '${exercise.name} needs step-by-step execution',
          );
          expect(exercise.safetyNotes.trim(), isNotEmpty);
        }
      },
    );
  });
}

List<String> _namesFor(String type, {String location = 'Ginásio'}) {
  return ExerciseFilterService.filter(
    exercises: _fixtureExercises,
    trainingLocation: location,
    availableEquipmentKeys: {},
    workoutType: _type(type),
  ).map((item) => item.name).toList();
}

WorkoutType _type(String name) => WorkoutType(
  name: name,
  muscleGroups: WorkoutTaxonomy.groupsFor(name).join(', '),
  isDefault: true,
  createdAt: DateTime(2026, 6, 6),
  updatedAt: DateTime(2026, 6, 6),
);

final _fixtureExercises = [
  ..._cardio('Passadeira', [
    'Passadeira caminhada',
    'Passadeira caminhada rápida',
    'Passadeira corrida leve',
    'Passadeira corrida intervalada',
    'Passadeira inclinação',
    'Passadeira sprints intervalados',
    'Passadeira aquecimento',
    'Passadeira cooldown',
  ], 'Passadeira'),
  ..._cardio('Bicicleta', [
    'Bicicleta ritmo leve',
    'Bicicleta ritmo moderado',
    'Bicicleta intervalos',
    'Bicicleta resistência',
    'Bicicleta aquecimento',
    'Bicicleta cooldown',
  ], 'Bicicleta'),
  ..._cardio('Elíptica', [
    'Elíptica ritmo leve',
    'Elíptica ritmo moderado',
    'Elíptica intervalos',
    'Elíptica resistência',
    'Elíptica aquecimento',
    'Elíptica cooldown',
  ], 'Elíptica'),
  ..._cardio('Corda de saltar', [
    'Corda de saltar ritmo leve',
    'Corda de saltar intervalos',
    'Corda de saltar pés alternados',
    'Corda de saltar joelhos altos',
    'Corda de saltar double unders',
  ], 'Corda de saltar'),
  ..._cardio('Caminhada exterior', [
    'Caminhada exterior leve',
    'Caminhada exterior moderada',
  ], 'Peso corporal'),
  ..._cardio('Corrida exterior', [
    'Corrida exterior leve',
    'Corrida exterior intervalada',
  ], 'Peso corporal'),
  _exercise('HIIT simples', 'Cardio', 'Peso corporal'),
  _exercise('Circuito cardio leve', 'Cardio', 'Peso corporal'),
  _exercise('Curl com halteres', 'Bíceps', 'Halteres'),
  _exercise('Extensão de tríceps no cabo', 'Tríceps', 'Cabo alto'),
  _exercise('Supino com barra', 'Peito', 'Barra, banco'),
  _exercise('Remo baixo no cabo', 'Costas', 'Cabo baixo'),
  _exercise('Agachamento goblet', 'Quadríceps', 'Halteres'),
  _exercise('Abdução de anca', 'Abdutores', 'Peso corporal'),
  _exercise('Kihon', 'Karate', 'Peso corporal'),
  _exercise('Shrimp / fuga de anca', 'Jiu-Jitsu', 'Tatami'),
];

List<Exercise> _cardio(String group, List<String> names, String equipment) {
  return names
      .map((name) => _exercise(name, 'Cardio', equipment, tags: group))
      .toList();
}

Exercise _exercise(
  String name,
  String group,
  String equipment, {
  String tags = '',
}) {
  return Exercise(
    name: name,
    muscleGroup: group,
    secondaryMuscleGroups: tags,
    equipment: equipment,
    description:
        '$name trabalha o objetivo principal de $group com controlo de ritmo, postura e progressão adequada.',
    executionSteps:
        'Prepara a posição inicial, confirma o espaço e executa $name com cadência controlada, mantendo respiração estável até regressar à posição inicial.',
    commonMistakes:
        'Evitar pressa, amplitude incompleta, postura instável e resistência acima da técnica disponível.',
    safetyNotes:
        'Interrompe se houver dor aguda, tontura ou perda de controlo técnico.',
    isDefault: true,
  );
}
