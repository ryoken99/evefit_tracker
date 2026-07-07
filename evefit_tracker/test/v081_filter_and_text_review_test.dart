import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final exercises = ExerciseCatalogContextService.entries
      .map((entry) => entry.toExercise())
      .toList();

  Set<String> namesFor(
    TrainingFlowSelection flow, {
    String location = 'Ginásio',
    Set<String> equipment = const {},
  }) {
    final selection = TrainingFlow.toTrainingSelection(flow);
    return ExerciseFilterService.getAvailableExercises(
      exercises: exercises,
      trainingLocation: location,
      availableEquipmentKeys: equipment,
      selection: selection,
      showAllExercises: false,
    ).map((item) => item.exercise.name).toSet();
  }

  TrainingFlowSelection strength({
    required String regionKey,
    required String groupKey,
    String subzoneKey = '',
    String focusKey = '',
  }) => TrainingFlowSelection(
    typeKey: 'strength',
    regionKey: regionKey,
    groupKey: groupKey,
    subzoneKey: subzoneKey,
    focusKey: focusKey,
  );

  group('v0.8.1 every UI strength focus returns exercises at the gym', () {
    const groups = <String, (String, String)>{
      'chest': ('upper', 'chest'),
      'back': ('upper', 'back'),
      'shoulders': ('upper', 'shoulders'),
      'arms': ('upper', 'arms'),
      'forearm_hand': ('upper', 'forearm_hand'),
      'traps_scapula': ('upper', 'traps_scapula'),
      'neck': ('upper', 'neck'),
      'core': ('core', ''),
      'legs': ('lower', 'legs'),
    };
    for (final groupEntry in groups.entries) {
      test('all subzones and focuses of ${groupEntry.key} are non-empty', () {
        for (final subzone in TrainingFlow.strengthSubzonesForGroup(
          groupEntry.key,
        )) {
          final base = strength(
            regionKey: groupEntry.value.$1,
            groupKey: groupEntry.value.$2,
            subzoneKey: subzone.key,
          );
          expect(
            namesFor(base),
            isNotEmpty,
            reason: '${groupEntry.key} > ${subzone.key}',
          );
          for (final focus in TrainingFlow.strengthSpecificOptions(
            groupEntry.key,
            subzone.key,
          )) {
            expect(
              namesFor(
                strength(
                  regionKey: groupEntry.value.$1,
                  groupKey: groupEntry.value.$2,
                  subzoneKey: subzone.key,
                  focusKey: focus.key,
                ),
              ),
              isNotEmpty,
              reason: '${groupEntry.key} > ${subzone.key} > ${focus.key}',
            );
          }
        }
      });
    }
  });

  group('v0.8.1 specific muscles no longer leak whole regions', () {
    test('posterior deltoid is a strict subset of complete shoulders', () {
      final complete = namesFor(
        strength(
          regionKey: 'upper',
          groupKey: 'shoulders',
          subzoneKey: 'shoulders_complete',
        ),
      );
      final posterior = namesFor(
        strength(
          regionKey: 'upper',
          groupKey: 'shoulders',
          subzoneKey: 'posterior_deltoid',
          focusKey: 'posterior_deltoid',
        ),
      );
      expect(posterior, isNotEmpty);
      expect(posterior.length, lessThan(complete.length));
      expect(posterior, contains('Elevação posterior'));
      expect(posterior, isNot(contains('Elevação frontal')));
    });

    test('lateral deltoid keeps lateral raises', () {
      final lateral = namesFor(
        strength(
          regionKey: 'upper',
          groupKey: 'shoulders',
          subzoneKey: 'lateral_deltoid',
          focusKey: 'lateral_deltoid',
        ),
      );
      expect(lateral, contains('Elevação lateral'));
      expect(lateral, isNot(contains('Elevação posterior')));
    });

    test('upper traps keep shrugs without arm curls', () {
      final traps = namesFor(
        strength(
          regionKey: 'upper',
          groupKey: 'traps_scapula',
          subzoneKey: 'upper_traps',
          focusKey: 'upper_traps',
        ),
      );
      expect(traps, contains('Encolhimento de ombros com halteres'));
      expect(traps, isNot(contains('Curl com halteres')));
    });

    test('adductors list only true adductor work', () {
      final adductors = namesFor(
        strength(
          regionKey: 'lower',
          groupKey: 'legs',
          subzoneKey: 'upper_leg_hip',
          focusKey: 'adductors',
        ),
      );
      expect(adductors, {
        'Agachamento sumo',
        'Adução de anca',
        'Copenhagen plank com apoio',
      });
    });

    test('lumbar zone keeps low-back entries without whole core', () {
      final lumbar = namesFor(
        strength(
          regionKey: 'core',
          groupKey: 'core',
          subzoneKey: 'lumbar_zone',
        ),
      );
      expect(lumbar, contains('Hiperextensão no chão'));
      expect(lumbar, isNot(contains('Crunch')));
    });
  });

  group('v0.8.1 location and equipment corrections', () {
    Set<String> availableAt(String location, Set<String> equipment) {
      return ExerciseFilterService.getAvailableExercises(
        exercises: exercises,
        trainingLocation: location,
        availableEquipmentKeys: equipment,
        selection: const TrainingSelection(),
        showAllExercises: false,
      ).map((item) => item.exercise.name).toSet();
    }

    test('uphill running needs outdoor space', () {
      expect(availableAt('Casa', {}), isNot(contains('Corrida em subida')));
      expect(
        availableAt('Exterior / parque', {}),
        contains('Corrida em subida'),
      );
    });

    test('gym includes jump rope and mat-based grappling drills', () {
      final gym = availableAt('Ginásio', {});
      expect(gym, contains('Corda de saltar ritmo leve'));
      expect(gym, contains('Shrimp / fuga de anca'));
      expect(gym, contains('Mobilidade de ombro para Jiu-Jitsu'));
    });

    test('karate drills do not demand a tatami', () {
      for (final entry in ExerciseCatalogContextService.entries.where(
        (entry) => entry.group == 'Karate',
      )) {
        // Único drill com equipamento próprio: o trabalho ao saco.
        expect(
          entry.details.equipment.toLowerCase(),
          isNot(equals('tatami')),
          reason: entry.name,
        );
      }
      expect(availableAt('Casa', {}), contains('Drills de guarda'));
    });

    test('ground jiu-jitsu drills accept tatami or a mat', () {
      final home = availableAt('Casa', {});
      expect(home, isNot(contains('Shrimp / fuga de anca')));
      final homeWithMat = availableAt('Casa', {'mat'});
      expect(homeWithMat, contains('Shrimp / fuga de anca'));
    });
  });

  group('v0.8.1 execution text teaches the actual variation', () {
    ExerciseCatalogEntry entryFor(String name, String group) =>
        ExerciseCatalogContextService.entryFor(name: name, group: group);

    test('leg curl is a hamstring machine, not an arm curl', () {
      final entry = entryFor('Curl de perna', 'Pernas');
      final text =
          '${entry.details.description} ${entry.details.executionSteps}'
              .toLowerCase();
      expect(text, contains('joelhos'));
      expect(text, contains('calcanhares'));
      expect(text, isNot(contains('bíceps braquial')));
      expect(
        entry.details.secondaryGroups.toLowerCase(),
        isNot(contains('braquiorradial')),
      );
    });

    test('leg extension and leg press describe the machines', () {
      expect(
        entryFor('Extensão de perna', 'Pernas').details.executionSteps,
        contains('rolo'),
      );
      expect(
        entryFor('Leg press', 'Pernas').details.executionSteps,
        contains('plataforma'),
      );
    });

    test('bulgarian split squat explains the rear foot on the bench', () {
      final steps = entryFor(
        'Agachamento búlgaro',
        'Pernas',
      ).details.executionSteps;
      expect(steps.toLowerCase(), contains('peito do pé de trás'));
      expect(steps.toLowerCase(), contains('banco'));
    });

    test('hip thrust and glute bridge explain hip elevation', () {
      expect(
        entryFor('Hip thrust', 'Pernas').details.executionSteps.toLowerCase(),
        contains('eleva a anca'),
      );
      expect(
        entryFor(
          'Ponte de glúteo',
          'Pernas',
        ).details.executionSteps.toLowerCase(),
        contains('eleva a anca'),
      );
    });

    test('no execution keeps the old placeholder wording', () {
      for (final entry in ExerciseCatalogContextService.entries) {
        expect(
          entry.details.executionSteps,
          isNot(contains('a trajetória específica desta variação')),
          reason: entry.id,
        );
      }
    });
  });
}
