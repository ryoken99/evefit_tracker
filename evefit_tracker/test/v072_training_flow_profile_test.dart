import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.2 workout flow depends on profile equipment', () {
    test(
      'adding treadmill unlocks treadmill and removing it blocks treadmill',
      () {
        final flow = const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
          cardioFocusKey: 'treadmill',
        );

        expect(_names(flow, location: 'Casa', equipment: {'treadmill'}), [
          'Passadeira caminhada',
          'Passadeira intervalos',
        ]);
        expect(_names(flow, location: 'Casa', equipment: {}), isEmpty);
      },
    );

    test('adding pull-up bar unlocks chin-up and dead hang where relevant', () {
      final bicepsFlow = const TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'pullup_bar',
        regionKey: 'upper',
        groupKey: 'arms',
        focusKey: 'biceps',
      );
      final gripFlow = const TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'pullup_bar',
        regionKey: 'upper',
        groupKey: 'forearm_hand',
      );

      expect(
        _names(bicepsFlow, location: 'Casa', equipment: {'pullup_bar'}),
        contains('Chin-up'),
      );
      expect(
        _names(gripFlow, location: 'Casa', equipment: {'pullup_bar'}),
        contains('Dead hang'),
      );
    });

    test('available cardio modes are restricted by profile equipment', () {
      expect(
        TrainingFlow.availableCardioModes(
          trainingLocation: 'Casa',
          availableEquipmentKeys: {'bodyweight'},
        ).map((item) => item.key),
        isNot(contains('treadmill')),
      );

      expect(
        TrainingFlow.availableCardioModes(
          trainingLocation: 'Casa',
          availableEquipmentKeys: {'bodyweight', 'treadmill'},
        ).map((item) => item.key),
        contains('treadmill'),
      );
    });
  });

  group('v0.7.2 contextual add-exercise filters', () {
    test('core workout shows contextual core filters only', () {
      final filters = ExerciseFilterService.contextualFiltersForSelection(
        exercises: _fixtureExercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: const {},
        selection: const TrainingSelection(
          regionKey: 'core',
          groupKey: 'abdominal',
          equipmentKey: 'bodyweight',
        ),
        showAll: false,
      );

      expect(filters, [
        'Todos',
        'Reto abdominal',
        'Oblíquos',
        'Transverso abdominal',
        'Anti-extensão',
        'Estabilidade do core',
      ]);
      expect(filters, isNot(contains('Cardio')));
      expect(filters, isNot(contains('Pernas')));
    });

    test('treadmill workout shows treadmill-specific filters only', () {
      final filters = ExerciseFilterService.contextualFiltersForSelection(
        exercises: _fixtureExercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: const {'treadmill'},
        selection: const TrainingSelection(
          regionKey: 'cardio',
          groupKey: 'cardio_machine',
          subgroupKey: 'treadmill',
          equipmentKey: 'treadmill',
        ),
        showAll: false,
      );

      expect(filters, ['Todos', 'Caminhada', 'Intervalos']);
      expect(filters, isNot(contains('Bicicleta')));
    });

    test('biceps workout shows contextual biceps filters only', () {
      final filters = ExerciseFilterService.contextualFiltersForSelection(
        exercises: _fixtureExercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: const {'dumbbells'},
        selection: const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'arms',
          subgroupKey: 'anterior_arm',
          specificMuscleKey: 'biceps',
          equipmentKey: 'dumbbells',
        ),
        showAll: false,
      );

      expect(filters, ['Todos', 'Bíceps', 'Braquial', 'Braquiorradial']);
      expect(filters, isNot(contains('Peito')));
    });
  });
}

List<String> _names(
  TrainingFlowSelection flow, {
  String location = 'Ginásio',
  Set<String> equipment = const {},
}) {
  return ExerciseFilterService.getAvailableExercises(
    exercises: _fixtureExercises,
    trainingLocation: location,
    availableEquipmentKeys: equipment,
    selection: TrainingFlow.toTrainingSelection(flow),
    showAllExercises: false,
  ).map((item) => item.exercise.name).toList();
}

final _fixtureExercises = [
  _exercise(
    'Passadeira caminhada',
    'Cardio',
    'Passadeira',
    'Passadeira caminhada',
  ),
  _exercise(
    'Passadeira intervalos',
    'Cardio',
    'Passadeira',
    'Passadeira intervalos',
  ),
  _exercise('Bicicleta ritmo leve', 'Cardio', 'Bicicleta', 'Bicicleta'),
  _exercise('Chin-up', 'Bíceps', 'Barra fixa', 'Bíceps, braquial'),
  _exercise('Dead hang', 'Antebraço/Pega', 'Barra fixa', 'Pega de suporte'),
  _exercise('Curl com halteres', 'Bíceps', 'Halteres', 'Bíceps'),
  _exercise('Curl martelo', 'Bíceps', 'Halteres', 'Braquial, braquiorradial'),
  _exercise('Flexões', 'Peito', 'Peso corporal', 'Peito, ombros'),
  _exercise('Crunch', 'Core', 'Peso corporal', 'Reto abdominal'),
  _exercise('Russian twist', 'Core', 'Peso corporal', 'Oblíquos'),
  _exercise(
    'Vacuum abdominal',
    'Core',
    'Peso corporal',
    'Transverso abdominal',
  ),
  _exercise('Hollow hold', 'Core', 'Peso corporal', 'Anti-extensão'),
  _exercise('Bird dog', 'Core', 'Peso corporal', 'Estabilidade do core'),
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
    description: '$name trabalha $group com foco específico.',
    executionSteps: 'Executa $name com controlo.',
    commonMistakes: 'Evitar compensações.',
    safetyNotes: 'Para se houver dor aguda.',
    isDefault: true,
  );
}
