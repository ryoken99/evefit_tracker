import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_taxonomy_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every catalog exercise has complete canonical taxonomy', () {
    for (final entry in ExerciseCatalogContextService.entries) {
      final taxonomy = ExerciseTaxonomyService.forCatalogEntry(entry);
      expect(taxonomy.regionKeys, isNotEmpty, reason: entry.catalogEntryKey);
      expect(taxonomy.groupKeys, isNotEmpty, reason: entry.catalogEntryKey);
      expect(
        taxonomy.primaryMuscleKey,
        isNotEmpty,
        reason: entry.catalogEntryKey,
      );
      expect(taxonomy.equipmentKeys, isNotEmpty, reason: entry.catalogEntryKey);
      expect(
        taxonomy.movementPattern,
        isNotEmpty,
        reason: entry.catalogEntryKey,
      );
      expect(taxonomy.difficulty, isNotEmpty, reason: entry.catalogEntryKey);
      expect(taxonomy.goalTags, isNotEmpty, reason: entry.catalogEntryKey);
      expect(taxonomy.allMuscleKeys, isNot(contains('face')));
      expect(taxonomy.regionKeys, isNot(contains('face')));
      expect(taxonomy.groupKeys, isNot(contains('face')));
    }
  });

  test(
    'catalog covers every required trainable anatomical or specialty key',
    () {
      final covered = <String>{};
      for (final entry in ExerciseCatalogContextService.entries) {
        covered.addAll(
          ExerciseTaxonomyService.forCatalogEntry(entry).allMuscleKeys,
        );
      }

      expect(
        covered,
        containsAll({
          'cervical_stabilizers',
          'upper_traps',
          'mid_traps',
          'lower_traps',
          'scapular_stabilizers',
          'rhomboids',
          'serratus_anterior',
          'upper_chest',
          'mid_chest',
          'lower_chest',
          'pectoralis_minor',
          'lats',
          'teres_major',
          'teres_minor',
          'erectors',
          'anterior_deltoid',
          'deltoid_lateral',
          'posterior_deltoid',
          'external_rotators',
          'internal_rotators',
          'biceps',
          'brachialis',
          'brachioradialis',
          'triceps_long',
          'triceps_lateral',
          'triceps_medial',
          'forearm_flexors',
          'forearm_extensors',
          'pronators',
          'supinators',
          'wrist',
          'fingers',
          'general_grip',
          'upper_abs',
          'mid_abs',
          'lower_abs',
          'external_obliques',
          'transverse_abdominis',
          'anti_rotation',
          'anti_extension',
          'anti_lateral_flexion',
          'deep_stability',
          'glute_max',
          'glute_med',
          'glute_min',
          'rectus_femoris',
          'vastus_lateralis',
          'vastus_medialis',
          'vastus_intermedius',
          'biceps_femoris',
          'semitendinosus',
          'semimembranosus',
          'adductors',
          'abductors',
          'hip_flexors',
          'calves',
          'soleus',
          'tibialis_anterior',
          'ankle',
          'feet',
          'cardiovascular',
          'mobility',
          'karate_technical',
          'jiu_jitsu_technical',
        }),
      );
      expect(covered, isNot(contains('face')));
    },
  );

  test('canonical taxonomy survives database map serialization', () {
    final entry = ExerciseCatalogContextService.entryFor(
      name: 'Pallof press no cabo',
      group: 'Core',
    );
    final exercise = ExerciseTaxonomyService.enrichCatalogExercise(entry);
    final restored = Exercise.fromMap({...exercise.toMap(), 'id': 1});

    expect(restored.regionKeys, exercise.regionKeys);
    expect(restored.groupKeys, exercise.groupKeys);
    expect(restored.subgroupKeys, exercise.subgroupKeys);
    expect(restored.primaryMuscleKey, exercise.primaryMuscleKey);
    expect(restored.secondaryMuscleKeys, exercise.secondaryMuscleKeys);
    expect(restored.equipmentKeys, exercise.equipmentKeys);
    expect(restored.movementPattern, exercise.movementPattern);
    expect(restored.difficulty, exercise.difficulty);
    expect(restored.goalTags, exercise.goalTags);
  });
}
