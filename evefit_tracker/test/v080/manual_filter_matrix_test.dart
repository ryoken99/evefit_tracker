import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/exercise_taxonomy_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.8.0 manual filter review matrix', () {
    test(
      'BW-CHEST-001 persisted home bodyweight chest complete shows push-ups',
      () {
        final names = _visibleNames(
          const TrainingSelection(
            regionKey: 'upper',
            groupKey: 'chest',
            specificMuscleKey: 'chest_complete',
            equipmentKey: 'bodyweight',
          ),
        );

        expect(
          names,
          containsAll({
            'Flexão clássica',
            'Flexão com joelhos apoiados',
            'Flexão aberta',
          }),
        );
        expect(names.any((name) => name.contains('Supino')), isFalse);
        expect(names.any((name) => name.contains('cabo')), isFalse);
        expect(names.any((name) => name.contains('máquina')), isFalse);
      },
    );

    test('BW-ARMS-001 bodyweight arms complete keeps direct triceps work', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'arms',
          subgroupKey: 'arms_complete',
          specificMuscleKey: 'arms_complete',
          equipmentKey: 'bodyweight',
        ),
      );

      expect(names, containsAll({'Flexão fechada', 'Flexão diamante'}));
      expect(names.any((name) => name.startsWith('Curl com halter')), isFalse);
      expect(names, isNot(contains('Extensão de tríceps no cabo')));
    });

    test('BW-CORE-001 bodyweight core complete keeps floor exercises', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'core',
          groupKey: 'abdominal',
          subgroupKey: 'core_complete',
          specificMuscleKey: 'core_complete',
          equipmentKey: 'bodyweight',
        ),
      );

      expect(
        names,
        containsAll({'Prancha', 'Crunch', 'Dead bug', 'Hollow hold'}),
      );
      expect(names, isNot(contains('Pallof press no cabo')));
    });

    test('BW-LEGS-001 bodyweight legs complete keeps unsupported basics', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'lower',
          groupKey: 'legs',
          subgroupKey: 'legs_complete',
          specificMuscleKey: 'legs_complete',
          equipmentKey: 'bodyweight',
        ),
      );

      expect(
        names,
        containsAll({
          'Agachamento com peso corporal',
          'Lunges',
          'Ponte de glúteo',
          'Gémeos em pé',
        }),
      );
      expect(names, isNot(contains('Leg press')));
      expect(names, isNot(contains('Agachamento com barra')));
    });

    test('BW-BACK-001 bodyweight back complete keeps floor/lumbar work', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'back',
          subgroupKey: 'back_complete',
          specificMuscleKey: 'back_complete',
          equipmentKey: 'bodyweight',
        ),
      );

      expect(
        names,
        containsAll({'Good morning sem carga', 'Superman isométrico'}),
      );
      expect(names, isNot(contains('Pull-up')));
      expect(names, isNot(contains('Remo unilateral com halter')));
    });

    test(
      'BW-SHOULDERS-001 bodyweight shoulders complete keeps direct control',
      () {
        final names = _visibleNames(
          const TrainingSelection(
            regionKey: 'upper',
            groupKey: 'shoulders',
            subgroupKey: 'shoulders_complete',
            specificMuscleKey: 'shoulders_complete',
            equipmentKey: 'bodyweight',
          ),
        );

        expect(names, containsAll({'Pike push-up', 'Scapular push-up'}));
        expect(names, isNot(contains('Press militar com halteres')));
        expect(names, isNot(contains('Press militar com barra')));
      },
    );

    test('GYM-CHEST-001 gym chest complete expands to gym and bodyweight', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'chest',
          specificMuscleKey: 'chest_complete',
        ),
        location: 'Ginásio',
        equipment: const {
          'bodyweight',
          'floor',
          'wall',
          'dumbbells',
          'barbell',
          'plates',
          'machine',
          'high_cable',
          'low_cable',
          'parallel_bars',
          'flat_bench',
          'incline_bench',
          'decline_bench',
        },
      );

      expect(
        names,
        containsAll({
          'Flexão clássica',
          'Supino com barra',
          'Supino com halteres',
          'Crossover no cabo',
        }),
      );
      expect(names, isNot(contains('Remo com barra')));
    });

    test(
      'BW-CHEST-002 bodyweight without support excludes raised push-ups',
      () {
        final names = _visibleNames(
          const TrainingSelection(
            regionKey: 'upper',
            groupKey: 'chest',
            specificMuscleKey: 'chest_complete',
            equipmentKey: 'bodyweight',
          ),
        );

        expect(names, isNot(contains('Flexão inclinada')));
        expect(names, isNot(contains('Flexão declinada')));
        expect(names, isNot(contains('Dips para peito em paralelas')));
      },
    );

    test('SUPPORT-CHEST-001 home support enables inclined push-up only', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'chest',
          specificMuscleKey: 'chest_complete',
          equipmentKey: 'bodyweight',
        ),
        equipment: const {'bodyweight', 'floor', 'wall', 'chair_support'},
      );

      expect(names, contains('Flexão inclinada'));
      expect(names, isNot(contains('Dips para peito em paralelas')));
    });

    test('BW-ARMS-002 bodyweight without support excludes bench dips', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'arms',
          subgroupKey: 'arms_complete',
          specificMuscleKey: 'arms_complete',
          equipmentKey: 'bodyweight',
        ),
      );

      expect(names, isNot(contains('Fundos entre apoios')));
      expect(names, isNot(contains('Dips para tríceps')));
    });

    test('SUPPORT-ARMS-001 chair support enables fundos entre apoios', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'arms',
          subgroupKey: 'arms_complete',
          specificMuscleKey: 'arms_complete',
          equipmentKey: 'bodyweight',
        ),
        equipment: const {'bodyweight', 'floor', 'wall', 'chair_support'},
      );

      expect(names, contains('Fundos entre apoios'));
      expect(names, isNot(contains('Dips para tríceps')));
    });

    test('BW-LEGS-002 bodyweight without chair excludes chair squat', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'lower',
          groupKey: 'legs',
          subgroupKey: 'legs_complete',
          specificMuscleKey: 'legs_complete',
          equipmentKey: 'bodyweight',
        ),
      );

      expect(names, isNot(contains('Agachamento para cadeira')));
      expect(names, isNot(contains('Agachamento búlgaro com apoio')));
    });

    test('BW-BACK-002 bodyweight without bar excludes vertical bar work', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'back',
          subgroupKey: 'back_width',
          specificMuscleKey: 'back_width',
        ),
      );

      expect(names, isNot(contains('Pull-up')));
      expect(names, isNot(contains('Scapular pull-up')));
    });

    test('PULLUP-BACK-001 home pull-up bar enables vertical bar work', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'back',
          subgroupKey: 'back_width',
          specificMuscleKey: 'back_width',
          equipmentKey: 'pullup_bar',
        ),
        equipment: const {'bodyweight', 'floor', 'wall', 'pullup_bar'},
      );

      expect(names, containsAll({'Pull-up', 'Scapular pull-up'}));
      expect(names, isNot(contains('Puxada alta')));
    });
  });
}

Set<String> _visibleNames(
  TrainingSelection selection, {
  String location = 'Casa',
  Set<String> equipment = const {'bodyweight', 'floor', 'wall'},
}) {
  final persistedExercises = ExerciseCatalogContextService.entries
      .map(ExerciseTaxonomyService.enrichCatalogExercise)
      .toList();
  return ExerciseFilterService.getAvailableExercises(
    exercises: persistedExercises,
    trainingLocation: location,
    availableEquipmentKeys: equipment,
    selection: selection,
    showAllExercises: false,
  ).map((item) => item.exercise.name).toSet();
}
