import 'package:evefit_tracker/services/catalog_quality_gate_service.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/exercise_taxonomy_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v1.0.0 catalog QA audit from file 28', () {
    test('structured quality gates have zero critical failures', () {
      final failures = CatalogQualityGateService.allFailures();

      expect(
        failures,
        isEmpty,
        reason: CatalogQualityGateService.formatFailures(failures),
      );
    });

    test(
      'all catalog entries expose identity, filters, equipment and content',
      () {
        final catalogEntryKeys = <String>{};
        for (final entry in ExerciseCatalogContextService.entries) {
          final exercise = ExerciseTaxonomyService.enrichCatalogExercise(entry);
          expect(exercise.canonicalId, isNotEmpty, reason: entry.id);
          expect(exercise.catalogEntryKey, isNotEmpty, reason: entry.id);
          expect(exercise.primaryType, isNotEmpty, reason: entry.id);
          expect(exercise.equipmentKeys, isNotEmpty, reason: entry.id);
          expect(exercise.description.trim().length, greaterThanOrEqualTo(130));
          expect(exercise.executionSteps.trim(), contains('1.'));
          expect(exercise.safetyNotes.trim().length, greaterThanOrEqualTo(70));
          expect(catalogEntryKeys.add(exercise.catalogEntryKey), isTrue);
        }
      },
    );

    test('file 28 E2E scenarios return coherent catalog results', () {
      final homeChest = _visibleNames(
        location: 'Casa sem equipamento',
        equipment: const {},
        selection: const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'chest',
          specificMuscleKey: 'chest_complete',
        ),
      );
      expect(
        homeChest.any(
          (name) =>
              ExerciseCatalogContextService.stableKey(name) ==
              'flexao_classica',
        ),
        isTrue,
      );
      expect(homeChest, isNot(contains('Crossover no cabo')));
      expect(homeChest, isNot(contains('Chest press')));

      final lowImpactCardio = _visibleNames(
        location: 'Casa equipada',
        equipment: const {'bike'},
        selection: const TrainingSelection(
          regionKey: 'cardio',
          groupKey: 'cardio_machine',
          subgroupKey: 'bike',
          equipmentKey: 'bike',
        ),
      );
      expect(lowImpactCardio, contains('Bicicleta ritmo leve'));
      expect(lowImpactCardio, isNot(contains('Sprints exterior')));

      final bjjBeginner = _visibleNames(
        location: 'Dojo / Artes marciais',
        equipment: const {},
        selection: const TrainingSelection(regionKey: 'martial_arts'),
      );
      expect(bjjBeginner, contains('Shrimp / fuga de anca'));
      expect(bjjBeginner, contains('Technical stand-up'));

      final pnfStretching = _visibleNames(
        location: 'Casa sem equipamento',
        equipment: const {},
        selection: const TrainingSelection(
          regionKey: 'mobility_recovery',
          groupKey: 'stretching',
        ),
      );
      expect(pnfStretching, contains('Alongamento PNF de isquiotibiais'));
      expect(pnfStretching, isNot(contains('Caminhada leve')));
    });

    test(
      'recovery, prevention and martial safety constraints are explicit',
      () {
        final recoveryNames = _entriesForContext(
          'recuperacao',
        ).map((entry) => entry.name).join('\n').toLowerCase();
        expect(recoveryNames, isNot(contains('hiit')));
        expect(recoveryNames, isNot(contains('sprint')));
        expect(
          _entriesForContext(
            'recuperacao',
          ).map((entry) => entry.details.safetyNotes).join('\n').toLowerCase(),
          contains('dor aguda'),
        );

        final preventionText = _entriesForContext('prevencao')
            .map(
              (entry) =>
                  '${entry.details.description} ${entry.details.safetyNotes}',
            )
            .join('\n')
            .toLowerCase();
        expect(preventionText, isNot(contains('previne les')));
        expect(preventionText, isNot(contains('evita les')));

        final soloMartial = _visibleNames(
          location: 'Casa sem equipamento',
          equipment: const {},
          selection: const TrainingSelection(regionKey: 'martial_arts'),
        );
        expect(soloMartial, isNot(contains('Sparring')));
        expect(soloMartial, isNot(contains('Breakfalls (ukemi)')));
      },
    );
  });
}

Set<String> _visibleNames({
  required String location,
  required Set<String> equipment,
  required TrainingSelection selection,
}) {
  final exercises = ExerciseCatalogContextService.entries
      .map(ExerciseTaxonomyService.enrichCatalogExercise)
      .toList();
  return ExerciseFilterService.getAvailableExercises(
    exercises: exercises,
    trainingLocation: location,
    availableEquipmentKeys: equipment,
    selection: selection,
    showAllExercises: false,
  ).map((item) => item.exercise.name).toSet();
}

Iterable<ExerciseCatalogEntry> _entriesForContext(String contextKey) =>
    ExerciseCatalogContextService.entries.where(
      (entry) => entry.contextKey == contextKey,
    );
