import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/exercise_taxonomy_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v1.0.0 filter visibility rules', () {
    test('home without equipment hides unavailable places and equipment', () {
      final names = _visibleNames(
        location: 'Casa sem equipamento',
        selectedEquipment: const {},
        selection: const TrainingSelection(),
      );

      expect(names, contains('Flexão clássica'));
      expect(names, isNot(contains('Leg press')));
      expect(names, isNot(contains('Extensão de tríceps no cabo')));
      expect(names, isNot(contains('Trabalho leve ao saco')));
      expect(names, isNot(contains('Breakfalls (ukemi)')));
      expect(names, isNot(contains('Passadeira caminhada')));
      expect(names, isNot(contains('Bicicleta ritmo leve')));
    });

    test('home equipped with dumbbells does not imply machines or cables', () {
      final names = _visibleNames(
        location: 'Casa equipada',
        selectedEquipment: const {'dumbbells'},
        selection: const TrainingSelection(),
      );

      expect(names, contains('Supino inclinado com halteres'));
      expect(names, isNot(contains('Leg press')));
      expect(names, isNot(contains('Crossover no cabo')));
    });

    test('gym strength selection exposes gym equipment families', () {
      final names = _visibleNames(
        location: 'Ginásio',
        selectedEquipment: const {},
        selection: const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'chest',
          specificMuscleKey: 'chest_complete',
        ),
      );

      expect(
        names,
        containsAll({
          'Supino com halteres',
          'Supino com barra',
          'Chest press',
          'Crossover no cabo',
          'Supino inclinado com halteres',
        }),
      );
    });

    test('dojo martial arts shows Karate, BJJ and tatami-safe drills', () {
      final names = _visibleNames(
        location: 'Dojo / Artes marciais',
        selectedEquipment: const {},
        selection: const TrainingSelection(regionKey: 'martial_arts'),
      );

      expect(
        names,
        containsAll({
          'Kihon',
          'Sombra de Karate',
          'Shrimp / fuga de anca',
          'Technical stand-up',
          'Breakfalls (ukemi)',
        }),
      );
      expect(names, isNot(contains('Trabalho leve ao saco')));
    });

    test('outdoor cardio shows outdoor modalities and explicit rope only', () {
      final outdoor = _visibleNames(
        location: 'Exterior',
        selectedEquipment: const {},
        selection: const TrainingSelection(regionKey: 'cardio'),
      );

      expect(
        outdoor,
        containsAll({
          'Caminhada exterior leve',
          'Corrida exterior leve',
          'Sprints exterior',
        }),
      );
      expect(outdoor, isNot(contains('Corda de saltar ritmo leve')));
      expect(outdoor, isNot(contains('Passadeira caminhada')));

      final withRope = _visibleNames(
        location: 'Exterior',
        selectedEquipment: const {'jump_rope'},
        selection: const TrainingSelection(regionKey: 'cardio'),
      );
      expect(withRope, contains('Corda de saltar ritmo leve'));
    });

    test('recovery excludes high intensity and combat contact', () {
      final names = _visibleNames(
        location: 'Casa sem equipamento',
        selectedEquipment: const {},
        selection: const TrainingSelection(
          regionKey: 'mobility_recovery',
          groupKey: 'active_recovery',
        ),
      );

      expect(names, contains('Caminhada leve'));
      expect(names, isNot(contains('HIIT simples')));
      expect(names, isNot(contains('Sprints exterior')));
      expect(names, isNot(contains('Kumite técnico')));
    });

    test(
      'mobility, elasticity, warm-up, activation and prevention stay separated',
      () {
        final activeMobility = _visibleNames(
          location: 'Casa sem equipamento',
          selectedEquipment: const {},
          selection: const TrainingSelection(
            regionKey: 'mobility_recovery',
            groupKey: 'general_mobility',
          ),
        );
        expect(activeMobility, contains('Mobilidade 90/90'));

        final passiveStretch = _visibleNames(
          location: 'Casa sem equipamento',
          selectedEquipment: const {},
          selection: const TrainingSelection(
            regionKey: 'mobility_recovery',
            groupKey: 'stretching',
          ),
        );
        expect(passiveStretch, contains('Alongamento posterior sentado'));
        expect(passiveStretch, isNot(contains('Mountain climbers')));

        final typedMobility = ExerciseFilterService.getAvailableExercises(
          exercises: [
            _fixture(
              name: 'Controlo articular ativo',
              group: 'Mobilidade',
              primaryType: 'mobilidade',
              equipmentKeys: const {'bodyweight', 'floor'},
            ),
            _fixture(
              name: 'Alongamento passivo longo',
              group: 'Elasticidade',
              primaryType: 'elasticidade',
              equipmentKeys: const {'bodyweight', 'floor'},
            ),
          ],
          trainingLocation: 'Casa sem equipamento',
          availableEquipmentKeys: const {},
          selection: const TrainingSelection(
            regionKey: 'mobility_recovery',
            groupKey: 'general_mobility',
          ),
          showAllExercises: false,
        ).map((item) => item.exercise.name).toSet();

        expect(typedMobility, contains('Controlo articular ativo'));
        expect(typedMobility, isNot(contains('Alongamento passivo longo')));
      },
    );

    test(
      'solo martial arts hides partner-only and impact ukemi without tatami',
      () {
        final names = ExerciseFilterService.getAvailableExercises(
          exercises: [
            _fixture(
              name: 'Sparring leve',
              group: 'Karate',
              primaryType: 'artes_marciais',
              equipmentKeys: const {'bodyweight', 'partner'},
              contextKey: 'karate',
            ),
            _fixture(
              name: 'Breakfalls (ukemi)',
              group: 'Jiu-Jitsu',
              primaryType: 'artes_marciais',
              equipmentKeys: const {'tatami'},
              contextKey: 'jiu_jitsu',
            ),
            _fixture(
              name: 'Technical stand-up',
              group: 'Jiu-Jitsu',
              canonicalId: 'technical_stand_up_lento',
              primaryType: 'artes_marciais',
              secondaryTypes: const {'mobilidade', 'defesa_pessoal'},
              equipmentKeys: const {'bodyweight', 'floor'},
              contextKey: 'jiu_jitsu',
            ),
          ],
          trainingLocation: 'Casa sem equipamento',
          availableEquipmentKeys: const {},
          selection: const TrainingSelection(regionKey: 'martial_arts'),
          showAllExercises: false,
        ).map((item) => item.exercise.name).toSet();

        expect(names, contains('Technical stand-up'));
        expect(names, isNot(contains('Sparring leve')));
        expect(names, isNot(contains('Breakfalls (ukemi)')));
      },
    );

    test('canonical examples respect domain visibility', () {
      final homeStrength = _visibleNames(
        location: 'Casa sem equipamento',
        selectedEquipment: const {},
        selection: const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'chest',
          specificMuscleKey: 'chest_complete',
          equipmentKey: 'bodyweight',
        ),
      );
      expect(homeStrength, contains('Flexão clássica'));

      final activation = _visibleNames(
        location: 'Casa sem equipamento',
        selectedEquipment: const {},
        selection: const TrainingSelection(
          regionKey: 'lower',
          groupKey: 'hips_glutes',
          subgroupKey: 'glutes',
          specificMuscleKey: 'glute_max',
          equipmentKey: 'bodyweight',
        ),
      );
      expect(activation, contains('Ponte de glúteo'));

      final hiit = _visibleNames(
        location: 'Casa sem equipamento',
        selectedEquipment: const {},
        selection: const TrainingSelection(
          regionKey: 'cardio',
          groupKey: 'hiit_group',
          subgroupKey: 'hiit',
          equipmentKey: 'bodyweight',
        ),
      );
      expect(hiit, isNot(contains('Ponte de glúteo')));

      final strength = _visibleNames(
        location: 'Dojo / Artes marciais',
        selectedEquipment: const {},
        selection: const TrainingSelection(regionKey: 'upper'),
      );
      expect(strength, isNot(contains('Technical stand-up')));
    });
  });
}

Set<String> _visibleNames({
  required String location,
  required Set<String> selectedEquipment,
  required TrainingSelection selection,
}) {
  final available = EquipmentCatalogService.availableKeys(
    trainingLocations: {location},
    selectedEquipmentKeys: selectedEquipment,
  );
  return ExerciseFilterService.getAvailableExercises(
    exercises: _catalogExercises(),
    trainingLocation: location,
    availableEquipmentKeys: available,
    selection: selection,
    showAllExercises: false,
  ).map((item) => item.exercise.name).toSet();
}

List<Exercise> _catalogExercises() => ExerciseCatalogContextService.entries
    .map(ExerciseTaxonomyService.enrichCatalogExercise)
    .toList();

Exercise _fixture({
  required String name,
  required String group,
  required String primaryType,
  required Set<String> equipmentKeys,
  String canonicalId = '',
  Set<String> secondaryTypes = const {},
  String contextKey = '',
}) {
  return Exercise(
    name: name,
    muscleGroup: group,
    isDefault: true,
    equipment: equipmentKeys.join(', '),
    canonicalId: canonicalId,
    primaryType: primaryType,
    secondaryTypes: secondaryTypes,
    exerciseKey: name.toLowerCase().replaceAll(' ', '_'),
    contextKey: contextKey,
    equipmentKeys: equipmentKeys,
  );
}
