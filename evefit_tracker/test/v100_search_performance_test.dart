import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/exercise_taxonomy_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v1.0.0 search, listing and performance', () {
    test(
      'search matches name, alias, muscle, equipment and location metadata',
      () {
        final catalog = _catalogExercises();

        expect(
          _search(catalog, 'technical stand-up'),
          _hasCanonical('technical_stand_up_lento'),
        );
        expect(_search(catalog, 'flexao_bracos'), _hasCanonical('push_up'));
        expect(_search(catalog, 'peito'), _hasCanonical('push_up'));
        expect(
          _search(catalog, 'halteres'),
          contains(
            predicate<Exercise>(
              (item) => item.equipmentKeys.contains('dumbbells'),
            ),
          ),
        );
        expect(
          _search(catalog, 'exterior'),
          contains(
            predicate<Exercise>(
              (item) =>
                  item.equipmentKeys.contains('outdoor_space') &&
                  item.primaryType == 'cardio',
            ),
          ),
        );
      },
    );

    test('empty search and filter states keep a useful explanation', () {
      final catalog = _visibleCatalog(
        location: EquipmentCatalogService.placeHomeNoEquipment,
        selectedEquipment: const {},
        selection: const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'chest',
          specificMuscleKey: 'chest_complete',
          equipmentKey: 'bodyweight',
        ),
      );

      final none = catalog
          .where(
            (item) => ExerciseFilterService.matchesSearchQuery(
              item.exercise,
              'resultado inexistente xyz',
            ),
          )
          .toList();

      expect(none, isEmpty);
      expect(
        ExerciseFilterService.emptyStateMessage,
        contains('Mostrar todos'),
      );
      expect(
        ExerciseFilterService.emptyStateMessage,
        contains('equipamento/local'),
      );
    });

    test('combined filters and searches stay coherent on the full catalog', () {
      final chestAtHome = _visibleCatalog(
        location: EquipmentCatalogService.placeHomeNoEquipment,
        selectedEquipment: const {},
        selection: const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'chest',
          specificMuscleKey: 'chest_complete',
          equipmentKey: 'bodyweight',
        ),
      );

      final pushUps = chestAtHome
          .where(
            (item) => ExerciseFilterService.matchesSearchQuery(
              item.exercise,
              'push_up',
            ),
          )
          .map((item) => item.exercise)
          .toList();

      expect(pushUps, isNotEmpty);
      expect(
        pushUps,
        contains(predicate<Exercise>((item) => item.canonicalId == 'push_up')),
      );
      expect(
        pushUps.every((item) => item.equipmentKeys.contains('bodyweight')),
        isTrue,
      );
    });

    test(
      'large catalog filtering and search stay below the smoke threshold',
      () {
        final catalog = _catalogExercises();
        _available(
          catalog,
          location: EquipmentCatalogService.placeGym,
          selectedEquipment: const {'dumbbells', 'barbell', 'machine'},
          selection: const TrainingSelection(
            regionKey: 'upper',
            groupKey: 'chest',
            specificMuscleKey: 'chest_complete',
          ),
        );
        final stopwatch = Stopwatch()..start();

        for (var i = 0; i < 25; i++) {
          final visible = _available(
            catalog,
            location: EquipmentCatalogService.placeGym,
            selectedEquipment: const {'dumbbells', 'barbell', 'machine'},
            selection: const TrainingSelection(
              regionKey: 'upper',
              groupKey: 'chest',
              specificMuscleKey: 'chest_complete',
            ),
          );
          expect(visible, isNotEmpty);
          expect(
            visible.where(
              (item) => ExerciseFilterService.matchesSearchQuery(
                item.exercise,
                'halteres',
              ),
            ),
            isNotEmpty,
          );
        }

        stopwatch.stop();
        expect(stopwatch.elapsedMilliseconds, lessThan(5000));
      },
    );
  });
}

Matcher _hasCanonical(String canonicalId) =>
    contains(predicate<Exercise>((item) => item.canonicalId == canonicalId));

List<Exercise> _search(List<Exercise> catalog, String query) => catalog
    .where((item) => ExerciseFilterService.matchesSearchQuery(item, query))
    .toList();

List<ExerciseAvailability> _visibleCatalog({
  required String location,
  required Set<String> selectedEquipment,
  required TrainingSelection selection,
}) => _available(
  _catalogExercises(),
  location: location,
  selectedEquipment: selectedEquipment,
  selection: selection,
);

List<ExerciseAvailability> _available(
  List<Exercise> catalog, {
  required String location,
  required Set<String> selectedEquipment,
  required TrainingSelection selection,
}) {
  final available = EquipmentCatalogService.availableKeys(
    trainingLocations: {location},
    selectedEquipmentKeys: selectedEquipment,
  );
  return ExerciseFilterService.getAvailableExercises(
    exercises: catalog,
    trainingLocation: location,
    availableEquipmentKeys: available,
    selection: selection,
    showAllExercises: false,
  );
}

List<Exercise> _catalogExercises() => ExerciseCatalogContextService.entries
    .map(ExerciseTaxonomyService.enrichCatalogExercise)
    .toList();
