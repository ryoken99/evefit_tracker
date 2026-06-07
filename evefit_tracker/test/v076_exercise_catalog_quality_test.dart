import 'dart:io';

import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.6 filter mapping', () {
    test('supino com halteres não aparece em Braços completo', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'dumbbells',
          regionKey: 'upper',
          groupKey: 'arms',
          subzoneKey: 'arms_complete',
        ),
        equipment: {'dumbbells'},
      );

      expect(names, contains('Curl com halteres'));
      expect(names, contains('Kickback de tríceps'));
      expect(names, contains('Pronação com halter'));
      expect(names, isNot(contains('Supino com halteres')));
      expect(names, isNot(contains('Aberturas com halteres')));
    });

    test('bíceps com peso corporal sem barra fixa não mostra flexões', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'bodyweight',
          regionKey: 'upper',
          groupKey: 'arms',
          subzoneKey: 'upper_arm',
          focusKey: 'biceps_brachii',
        ),
        equipment: const {},
      );

      expect(names, isNot(contains('Flexões')));
      expect(names, isNot(contains('Flexões fechadas')));
    });

    test('tríceps com peso corporal mostra flexões fechadas', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'strength',
          equipmentKey: 'bodyweight',
          regionKey: 'upper',
          groupKey: 'arms',
          subzoneKey: 'upper_arm',
          focusKey: 'triceps',
        ),
        equipment: const {},
      );

      expect(names, contains('Flexões fechadas'));
      expect(names, isNot(contains('Supino com halteres')));
    });

    test('mobilidade glúteos mostra alongamentos de glúteos', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'mobility',
          mobilityZoneKey: 'glute_mobility',
        ),
      );

      expect(
        names,
        containsAll([
          'Alongamento glúteos',
          'Alongamento figura 4',
          'Mobilidade 90/90',
        ]),
      );
    });

    test('mobilidade posterior de coxa mostra alongamentos de posterior', () {
      final names = _names(
        const TrainingFlowSelection(
          typeKey: 'mobility',
          mobilityZoneKey: 'hamstring_mobility',
        ),
      );

      expect(
        names,
        containsAll([
          'Alongamento posterior de coxa',
          'Alongamento posterior sentado',
          'Mobilidade dinâmica de posterior',
        ]),
      );
    });

    test('cardio passadeira separa resistência de intervalos', () {
      final aerobic = _names(
        const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
          cardioFocusKey: 'aerobic_endurance',
        ),
        location: 'Ginásio',
      );
      final intervals = _names(
        const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
          cardioFocusKey: 'treadmill_intervals',
        ),
        location: 'Ginásio',
      );

      expect(aerobic, contains('Passadeira caminhada'));
      expect(aerobic, contains('Passadeira inclinação moderada'));
      expect(aerobic, isNot(contains('HIIT passadeira')));
      expect(aerobic, isNot(contains('Passadeira sprints')));

      expect(intervals, contains('Passadeira corrida intervalada'));
      expect(intervals, contains('Passadeira sprints'));
      expect(intervals, contains('HIIT passadeira'));
    });
  });

  group('v0.7.6 catalog metadata', () {
    test('face pull variants use separate equipment', () {
      final elasticTags = TrainingArchitecture.tagsForExercise(
        _exercise(
          'Face pull com elástico',
          'Ombros',
          'Elásticos',
          'Deltoide posterior, estabilizadores escapulares',
        ),
      );
      final cableTags = TrainingArchitecture.tagsForExercise(
        _exercise(
          'Face pull no cabo',
          'Ombros',
          'Cabo alto / polia',
          'Deltoide posterior, trapézio médio',
        ),
      );

      expect(elasticTags.equipmentKeys, contains('bands'));
      expect(elasticTags.equipmentKeys, isNot(contains('high_cable')));
      expect(cableTags.equipmentKeys, contains('high_cable'));
      expect(cableTags.equipmentKeys, isNot(contains('bands')));
    });

    test('shrugs have explicit equipment variants in the seed catalog', () {
      final names = SeedData.exercisesByGroup.values.expand((items) => items);

      expect(names, contains('Encolhimento de ombros com halteres'));
      expect(names, contains('Encolhimento de ombros com barra'));
      expect(names, contains('Encolhimento de ombros na máquina'));
      expect(names, isNot(contains('Encolhimento de ombros')));
    });
  });

  group('v0.7.6 description quality', () {
    test('source has no visible placeholder or prohibited generic text', () {
      final source = [
        File('lib/database/app_database.dart').readAsStringSync(),
        File('lib/screens/workout_detail_screen.dart').readAsStringSync(),
      ].join('\n').toLowerCase();

      const forbidden = [
        'descrição ainda incompleta',
        'será melhorado numa próxima versão',
        'prepara a posição inicial',
        'confirma que o equipamento está estável',
        'executa com boa técnica',
      ];

      for (final text in forbidden) {
        expect(source, isNot(contains(text)));
      }
    });

    test('visible fixture exercises have specific description fields', () {
      final visible = ExerciseFilterService.getAvailableExercises(
        exercises: _fixtureExercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: {'dumbbells', 'bands', 'treadmill'},
        selection: const TrainingSelection(),
        showAllExercises: false,
      );

      for (final item in visible) {
        expect(item.exercise.description.trim(), isNotEmpty);
        expect(item.exercise.executionSteps.trim(), contains('1.'));
        expect(item.exercise.executionSteps.trim(), contains('2.'));
        expect(item.exercise.commonMistakes.trim(), isNotEmpty);
        expect(item.exercise.safetyNotes.trim(), isNotEmpty);
        expect(item.exercise.equipment.trim(), isNotEmpty);
      }
    });
  });
}

List<String> _names(
  TrainingFlowSelection flow, {
  String location = 'Casa',
  Set<String> equipment = const {'bodyweight'},
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
    'Curl com halteres',
    'Bíceps',
    'Halteres',
    'Braquial, braquiorradial, antebraço',
  ),
  _exercise(
    'Curl alternado',
    'Bíceps',
    'Halteres',
    'Braquial, braquiorradial, antebraço',
  ),
  _exercise('Kickback de tríceps', 'Tríceps', 'Halteres', 'Ombros'),
  _exercise('Pronação com halter', 'Antebraço/Pega', 'Halteres', 'Punho, pega'),
  _exercise('Supino com halteres', 'Peito', 'Halteres', 'Ombros, tríceps'),
  _exercise('Aberturas com halteres', 'Peito', 'Halteres', 'Ombros'),
  _exercise('Flexões', 'Peito', 'Peso corporal', 'Ombros, tríceps'),
  _exercise('Flexões fechadas', 'Tríceps', 'Peso corporal', 'Peito, ombros'),
  _exercise('Alongamento glúteos', 'Mobilidade', 'Peso corporal', 'Glúteos'),
  _exercise(
    'Alongamento figura 4',
    'Mobilidade',
    'Peso corporal',
    'Glúteos, piriforme',
  ),
  _exercise('Mobilidade 90/90', 'Mobilidade', 'Peso corporal', 'Anca'),
  _exercise(
    'Alongamento posterior de coxa',
    'Mobilidade',
    'Peso corporal',
    'Posterior de coxa',
  ),
  _exercise(
    'Alongamento posterior sentado',
    'Mobilidade',
    'Peso corporal',
    'Posterior de coxa',
  ),
  _exercise(
    'Mobilidade dinâmica de posterior',
    'Mobilidade',
    'Peso corporal',
    'Posterior de coxa',
  ),
  _exercise('Passadeira caminhada', 'Cardio', 'Passadeira', 'Caminhada'),
  _exercise(
    'Passadeira inclinação moderada',
    'Cardio',
    'Passadeira',
    'Inclinação',
  ),
  _exercise(
    'Passadeira corrida intervalada',
    'Cardio',
    'Passadeira',
    'Intervalos',
  ),
  _exercise('Passadeira sprints', 'Cardio', 'Passadeira', 'Sprints'),
  _exercise('HIIT passadeira', 'Cardio', 'Passadeira', 'HIIT'),
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
    description: '$name explicado para iniciantes com foco em $group.',
    executionSteps:
        '1. Organiza a posição com controlo. 2. Faz o movimento principal sem pressa. 3. Respira de forma regular. 4. Volta à posição inicial devagar.',
    commonMistakes: 'Usar pressa, compensar com outra zona e perder controlo.',
    safetyNotes:
        'Usa uma intensidade confortável e para se houver dor aguda ou tontura.',
    isDefault: true,
  );
}
