import 'package:evefit_tracker/models/exercise.dart';
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

    test('SUPPORT-LEGS-001 stable step enables Step-up', () {
      final names = _visibleNames(
        const TrainingSelection(
          regionKey: 'lower',
          groupKey: 'legs',
          subgroupKey: 'legs_complete',
          specificMuscleKey: 'legs_complete',
        ),
        equipment: const {'bodyweight', 'floor', 'wall', 'stable_step'},
      );

      expect(names, contains('Step-up'));
      expect(names, isNot(contains('Leg press')));
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

    for (final reviewCase in _reviewCases) {
      test('${reviewCase.id} ${reviewCase.description}', () {
        final names = _visibleNames(
          reviewCase.selection,
          location: reviewCase.location,
          equipment: reviewCase.equipment,
        );
        expect(
          names,
          containsAll(reviewCase.mustContain),
          reason: '${reviewCase.id}: inclusões manuais',
        );
        for (final forbidden in reviewCase.mustExclude) {
          expect(
            names,
            isNot(contains(forbidden)),
            reason: '${reviewCase.id}: exclusão manual de $forbidden',
          );
        }
      });
    }

    test('SHOWALL-BACK-001 explains the missing pull-up bar', () {
      final items = ExerciseFilterService.getAvailableExercises(
        exercises: _persistedCatalogExercises(),
        trainingLocation: 'Casa',
        availableEquipmentKeys: _homeBase,
        selection: const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'back',
          subgroupKey: 'back_width',
        ),
        showAllExercises: true,
      );
      final pullUp = items.singleWhere(
        (item) => item.exercise.name == 'Pull-up',
      );

      expect(pullUp.isAvailable, isFalse);
      expect(pullUp.unavailableReason, contains('Barra fixa'));
    });

    test('SHOWALL-ANATOMY-001 distinguishes an anatomical mismatch', () {
      final items = ExerciseFilterService.getAvailableExercises(
        exercises: _persistedCatalogExercises(),
        trainingLocation: 'Casa',
        availableEquipmentKeys: _homeBase,
        selection: const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'back',
          subgroupKey: 'back_width',
        ),
        showAllExercises: true,
      );
      final pushUp = items.singleWhere(
        (item) => item.exercise.name == 'Flexão clássica',
      );

      expect(pushUp.isAvailable, isFalse);
      expect(pushUp.unavailableReason, contains('filtro anatómico'));
    });

    test(
      'EMPTY-STATE-001 tells the user how to inspect missing capability',
      () {
        expect(
          ExerciseFilterService.emptyStateMessage,
          contains('Mostrar todos'),
        );
        expect(
          ExerciseFilterService.emptyStateMessage,
          contains('equipamento/local em falta'),
        );
      },
    );
  });
}

class _ManualReviewCase {
  const _ManualReviewCase({
    required this.id,
    required this.description,
    required this.selection,
    required this.mustContain,
    this.mustExclude = const {},
    this.location = 'Ginásio',
    this.equipment = const {},
  });

  final String id;
  final String description;
  final TrainingSelection selection;
  final Set<String> mustContain;
  final Set<String> mustExclude;
  final String location;
  final Set<String> equipment;
}

const _homeBase = {'bodyweight', 'floor', 'wall'};

const _reviewCases = <_ManualReviewCase>[
  _ManualReviewCase(
    id: 'GYM-CHEST-UPPER-001',
    description: 'upper chest keeps incline presses and excludes rows',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'chest',
      subgroupKey: 'chest_primary',
      specificMuscleKey: 'upper_chest',
    ),
    mustContain: {'Supino inclinado com halteres'},
    mustExclude: {'Remo unilateral com halter'},
  ),
  _ManualReviewCase(
    id: 'GYM-CHEST-MID-001',
    description: 'mid chest keeps classic press and excludes back',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'chest',
      subgroupKey: 'chest_primary',
      specificMuscleKey: 'mid_chest',
    ),
    mustContain: {'Flexão clássica', 'Supino com halteres'},
    mustExclude: {'Remo com barra'},
  ),
  _ManualReviewCase(
    id: 'GYM-CHEST-LOWER-001',
    description: 'lower chest keeps decline press and excludes curls',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'chest',
      subgroupKey: 'chest_primary',
      specificMuscleKey: 'lower_chest',
    ),
    mustContain: {'Supino declinado com halteres'},
    mustExclude: {'Curl com halteres'},
  ),
  _ManualReviewCase(
    id: 'BW-CHEST-SERRATUS-001',
    description: 'serratus keeps scapular push-up without presses',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'chest',
      subgroupKey: 'chest_primary',
      specificMuscleKey: 'serratus_anterior',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Scapular push-up'},
    mustExclude: {'Supino com barra'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'GYM-BACK-WIDTH-001',
    description: 'back width keeps vertical pulls and excludes rows',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'back',
      subgroupKey: 'back_width',
      specificMuscleKey: 'back_width',
    ),
    mustContain: {'Pull-up', 'Puxada alta'},
    mustExclude: {'Remo com barra'},
  ),
  _ManualReviewCase(
    id: 'GYM-BACK-THICKNESS-001',
    description: 'back thickness keeps rows and excludes pull-up',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'back',
      subgroupKey: 'back_thickness',
      specificMuscleKey: 'back_thickness',
    ),
    mustContain: {'Remo com barra', 'Remo baixo no cabo'},
    mustExclude: {'Pull-up'},
  ),
  _ManualReviewCase(
    id: 'GYM-BACK-LATS-001',
    description: 'lats keep pulldown and exclude triceps',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'back',
      subgroupKey: 'back_width',
      specificMuscleKey: 'lats',
    ),
    mustContain: {'Puxada alta'},
    mustExclude: {'Extensão de tríceps no cabo'},
  ),
  _ManualReviewCase(
    id: 'GYM-BACK-RHOMBOIDS-001',
    description: 'rhomboids keep rows and exclude chest press',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'back',
      subgroupKey: 'back_thickness',
      specificMuscleKey: 'rhomboids',
    ),
    mustContain: {'Remo sentado'},
    mustExclude: {'Chest press'},
  ),
  _ManualReviewCase(
    id: 'BW-BACK-LOWER-001',
    description: 'lower back keeps floor extension without machines',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'back',
      subgroupKey: 'back_complete',
      specificMuscleKey: 'erectors',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Superman isométrico'},
    mustExclude: {'Hiperextensão no banco romano'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'GYM-SHOULDER-ANTERIOR-001',
    description: 'anterior deltoid keeps presses and excludes reverse fly',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'shoulders',
      subgroupKey: 'deltoids',
      specificMuscleKey: 'anterior_deltoid',
    ),
    mustContain: {'Press militar com halteres'},
    mustExclude: {'Reverse fly'},
  ),
  _ManualReviewCase(
    id: 'GYM-SHOULDER-LATERAL-001',
    description: 'lateral deltoid keeps lateral raise and excludes curls',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'shoulders',
      subgroupKey: 'deltoids',
      specificMuscleKey: 'deltoid_lateral',
    ),
    mustContain: {'Elevação lateral'},
    mustExclude: {'Curl com halteres'},
  ),
  _ManualReviewCase(
    id: 'GYM-SHOULDER-POSTERIOR-001',
    description: 'posterior deltoid keeps reverse fly and excludes front raise',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'shoulders',
      subgroupKey: 'deltoids',
      specificMuscleKey: 'posterior_deltoid',
    ),
    mustContain: {'Reverse fly'},
    mustExclude: {'Elevação frontal'},
  ),
  _ManualReviewCase(
    id: 'GYM-SHOULDER-CUFF-001',
    description: 'external rotators keep external rotation',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'shoulders',
      subgroupKey: 'deltoids',
      specificMuscleKey: 'external_rotators',
    ),
    mustContain: {'Rotação externa'},
    mustExclude: {'Rotação interna'},
  ),
  _ManualReviewCase(
    id: 'BW-SHOULDER-SCAPULA-001',
    description: 'scapular control keeps wall and push-up drills',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'shoulders',
      subgroupKey: 'deltoids',
      specificMuscleKey: 'scapular_stabilizers',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Scapular push-up', 'Wall slides'},
    mustExclude: {'Press militar com barra'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'DB-ARMS-BICEPS-001',
    description: 'home dumbbells show curls without cables',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'anterior_arm',
      specificMuscleKey: 'biceps',
      equipmentKey: 'dumbbells',
    ),
    mustContain: {'Curl com halteres'},
    mustExclude: {'Curl no cabo'},
    location: 'Casa',
    equipment: {..._homeBase, 'dumbbells'},
  ),
  _ManualReviewCase(
    id: 'DB-ARMS-BRACHIALIS-001',
    description: 'home dumbbells show hammer curl for brachialis',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'anterior_arm',
      specificMuscleKey: 'brachialis',
      equipmentKey: 'dumbbells',
    ),
    mustContain: {'Curl martelo'},
    mustExclude: {'Extensão de tríceps no cabo'},
    location: 'Casa',
    equipment: {..._homeBase, 'dumbbells'},
  ),
  _ManualReviewCase(
    id: 'DB-ARMS-BRACHIORADIALIS-001',
    description: 'home dumbbells show neutral/reverse curl',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'anterior_arm',
      specificMuscleKey: 'brachioradialis',
      equipmentKey: 'dumbbells',
    ),
    mustContain: {'Curl martelo'},
    mustExclude: {'Flexão diamante'},
    location: 'Casa',
    equipment: {..._homeBase, 'dumbbells'},
  ),
  _ManualReviewCase(
    id: 'GYM-TRICEPS-LONG-001',
    description: 'long head keeps overhead extension and excludes curls',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'posterior_arm',
      specificMuscleKey: 'triceps_long',
    ),
    mustContain: {'Extensão acima da cabeça com halter'},
    mustExclude: {'Curl com halteres'},
  ),
  _ManualReviewCase(
    id: 'GYM-TRICEPS-COMPLETE-001',
    description: 'complete triceps keeps all heads and excludes curls',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'posterior_arm',
      specificMuscleKey: 'triceps',
    ),
    mustContain: {
      'Extensão francesa com halter',
      'Extensão de tríceps no cabo',
      'Tríceps no cabo com corda',
    },
    mustExclude: {'Curl com barra'},
  ),
  _ManualReviewCase(
    id: 'GYM-TRICEPS-LATERAL-001',
    description: 'lateral head keeps cable extension and excludes curls',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'posterior_arm',
      specificMuscleKey: 'triceps_lateral',
    ),
    mustContain: {'Extensão de tríceps no cabo'},
    mustExclude: {'Curl com barra'},
  ),
  _ManualReviewCase(
    id: 'GYM-TRICEPS-MEDIAL-001',
    description: 'medial head keeps controlled extension and excludes curls',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'arms',
      subgroupKey: 'posterior_arm',
      specificMuscleKey: 'triceps_medial',
    ),
    mustContain: {'Extensão de tríceps no cabo'},
    mustExclude: {'Curl com barra'},
  ),
  _ManualReviewCase(
    id: 'GYM-FOREARM-FLEXORS-001',
    description: 'forearm flexors keep wrist curl',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
      specificMuscleKey: 'forearm_flexors',
    ),
    mustContain: {'Wrist curl'},
    mustExclude: {'Reverse wrist curl'},
  ),
  _ManualReviewCase(
    id: 'GYM-FOREARM-COMPLETE-001',
    description: 'complete forearm includes wrist rotation and grip work',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
      specificMuscleKey: 'forearm_complete',
    ),
    mustContain: {
      'Wrist curl',
      'Reverse wrist curl',
      'Pronação com halter',
      'Supinação com halter',
      'Farmer hold',
    },
    mustExclude: {'Extensão de tríceps no cabo'},
  ),
  _ManualReviewCase(
    id: 'GYM-FOREARM-EXTENSORS-001',
    description: 'forearm extensors keep reverse wrist curl',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
      specificMuscleKey: 'forearm_extensors',
    ),
    mustContain: {'Reverse wrist curl'},
    mustExclude: {'Wrist curl'},
  ),
  _ManualReviewCase(
    id: 'GYM-FOREARM-PRONATION-001',
    description: 'pronation keeps pronation drill',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
      specificMuscleKey: 'pronators',
    ),
    mustContain: {'Pronação com halter'},
    mustExclude: {'Supinação com halter'},
  ),
  _ManualReviewCase(
    id: 'GYM-FOREARM-SUPINATION-001',
    description: 'supination keeps supination drill',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
      specificMuscleKey: 'supinators',
    ),
    mustContain: {'Supinação com halter'},
    mustExclude: {'Pronação com halter'},
  ),
  _ManualReviewCase(
    id: 'GYM-FOREARM-WRIST-001',
    description: 'wrist focus keeps wrist control',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
      specificMuscleKey: 'wrist',
    ),
    mustContain: {'Wrist curl', 'Desvio radial com halter'},
    mustExclude: {'Flexão diamante'},
  ),
  _ManualReviewCase(
    id: 'GYM-FOREARM-FINGERS-001',
    description: 'finger focus keeps finger curls',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
      specificMuscleKey: 'fingers',
    ),
    mustContain: {'Finger curls'},
    mustExclude: {'Farmer walk'},
  ),
  _ManualReviewCase(
    id: 'GYM-GRIP-001',
    description: 'general grip keeps carries and excludes triceps',
    selection: TrainingSelection(
      regionKey: 'upper',
      groupKey: 'forearm_hand',
      subgroupKey: 'grip_strength',
      specificMuscleKey: 'general_grip',
    ),
    mustContain: {'Farmer hold'},
    mustExclude: {'Extensão de tríceps no cabo'},
  ),
  _ManualReviewCase(
    id: 'BW-CORE-ABS-001',
    description: 'abdominal keeps crunch without cables',
    selection: TrainingSelection(
      regionKey: 'core',
      groupKey: 'abdominal',
      specificMuscleKey: 'rectus_abdominis',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Crunch'},
    mustExclude: {'Pallof press no cabo'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-CORE-OBLIQUES-001',
    description: 'obliques keep side plank and twist',
    selection: TrainingSelection(
      regionKey: 'core',
      groupKey: 'obliques',
      specificMuscleKey: 'external_obliques',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Prancha lateral', 'Russian twist'},
    mustExclude: {'Pallof press no cabo'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-CORE-TRANSVERSE-001',
    description: 'transverse focus keeps vacuum',
    selection: TrainingSelection(
      regionKey: 'core',
      groupKey: 'transverse_abs',
      specificMuscleKey: 'transverse_abdominis',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Vacuum abdominal'},
    mustExclude: {'Superman'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BANDS-CORE-ANTIROTATION-001',
    description: 'bands enable Pallof without cable',
    selection: TrainingSelection(
      regionKey: 'core',
      groupKey: 'anti_rotation',
      specificMuscleKey: 'anti_rotation',
      equipmentKey: 'bands',
    ),
    mustContain: {'Pallof press com elástico'},
    mustExclude: {'Pallof press no cabo'},
    location: 'Casa',
    equipment: {..._homeBase, 'bands'},
  ),
  _ManualReviewCase(
    id: 'BW-CORE-ANTIEXTENSION-001',
    description: 'anti-extension keeps plank/hollow without Pallof',
    selection: TrainingSelection(
      regionKey: 'core',
      groupKey: 'anti_extension',
      specificMuscleKey: 'anti_extension',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Prancha', 'Hollow hold'},
    mustExclude: {'Pallof press no cabo'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-CORE-STABILITY-001',
    description: 'deep stability keeps dead bug and bird dog',
    selection: TrainingSelection(
      regionKey: 'core',
      groupKey: 'core_stability',
      specificMuscleKey: 'deep_stability',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Dead bug', 'Bird dog'},
    mustExclude: {'Side bend'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-CORE-LOWERBACK-001',
    description: 'core lower-back focus keeps floor extension only',
    selection: TrainingSelection(
      regionKey: 'core',
      groupKey: 'low_back',
      subgroupKey: 'low_back_sub',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Hiperextensão no chão', 'Superman isométrico'},
    mustExclude: {'Hiperextensão no banco romano'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-CORE-ANTILATERAL-001',
    description: 'anti-lateral flexion keeps side plank without side bends',
    selection: TrainingSelection(
      regionKey: 'core',
      groupKey: 'anti_lateral_flexion',
      specificMuscleKey: 'anti_lateral_flexion',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Prancha lateral'},
    mustExclude: {'Side bend'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-LEGS-GLUTEMAX-001',
    description: 'glute max keeps bridge',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'hips_glutes',
      subgroupKey: 'glutes',
      specificMuscleKey: 'glute_max',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Ponte de glúteo'},
    mustExclude: {'Leg press'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-LEGS-GLUTES-COMPLETE-001',
    description: 'complete glutes keeps max and lateral bodyweight work',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'hips_glutes',
      subgroupKey: 'glutes',
      specificMuscleKey: 'glutes_complete',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Ponte de glúteo', 'Abdução de anca deitada'},
    mustExclude: {'Leg press'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-LEGS-GLUTEMED-001',
    description: 'glute med/min keep side-lying abduction',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'hips_glutes',
      subgroupKey: 'glutes',
      specificMuscleKey: 'glute_med',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Abdução de anca deitada'},
    mustExclude: {'Leg press'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-LEGS-QUADS-001',
    description: 'quadriceps keep squat and exclude curls',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'quadriceps',
      subgroupKey: 'quadriceps',
      specificMuscleKey: 'quadriceps_complete',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Agachamento com peso corporal'},
    mustExclude: {'Curl de perna'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BB-LEGS-QUADS-001',
    description: 'barbell profile keeps barbell squat',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'quadriceps',
      subgroupKey: 'quadriceps',
      specificMuscleKey: 'quadriceps_complete',
      equipmentKey: 'barbell',
    ),
    mustContain: {'Agachamento com barra'},
    mustExclude: {'Leg press'},
    location: 'Casa',
    equipment: {..._homeBase, 'barbell', 'plates'},
  ),
  _ManualReviewCase(
    id: 'DB-LEGS-QUADS-001',
    description: 'dumbbells profile keeps goblet squat',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'quadriceps',
      subgroupKey: 'quadriceps',
      specificMuscleKey: 'quadriceps_complete',
      equipmentKey: 'dumbbells',
    ),
    mustContain: {'Agachamento goblet'},
    mustExclude: {'Leg press'},
    location: 'Casa',
    equipment: {..._homeBase, 'dumbbells'},
  ),
  _ManualReviewCase(
    id: 'BW-LEGS-HAMSTRINGS-001',
    description: 'hamstrings keep unloaded good morning',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'hamstrings',
      subgroupKey: 'hamstrings',
      specificMuscleKey: 'hamstrings_complete',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Good morning sem carga'},
    mustExclude: {'Curl de perna'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'GYM-LEGS-ADDUCTORS-001',
    description: 'adductors keep machine adduction without abduction',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'adductors',
      subgroupKey: 'adductors',
    ),
    mustContain: {'Adução de anca'},
    mustExclude: {'Abdução de anca'},
  ),
  _ManualReviewCase(
    id: 'BW-LEGS-ABDUCTORS-001',
    description: 'abductors keep side-lying abduction',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'abductors',
      subgroupKey: 'abductors',
      specificMuscleKey: 'abductors',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Abdução de anca deitada'},
    mustExclude: {'Adução de anca'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BANDS-LEGS-HIPFLEXORS-001',
    description: 'bands enable standing hip flexion',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'hips_glutes',
      specificMuscleKey: 'hip_flexors',
      equipmentKey: 'bands',
    ),
    mustContain: {'Flexão da anca em pé com elástico'},
    mustExclude: {'Leg press'},
    location: 'Casa',
    equipment: {..._homeBase, 'bands'},
  ),
  _ManualReviewCase(
    id: 'BW-LEGS-CALVES-001',
    description: 'calves keep standing calf raise',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'calves',
      subgroupKey: 'calves',
      specificMuscleKey: 'calves',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Gémeos em pé'},
    mustExclude: {'Sóleo sentado'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'GYM-LEGS-SOLEUS-001',
    description: 'soleus keeps seated soleus work',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'calves',
      subgroupKey: 'calves',
      specificMuscleKey: 'soleus',
    ),
    mustContain: {'Sóleo sentado'},
    mustExclude: {'Leg press'},
  ),
  _ManualReviewCase(
    id: 'BW-LEGS-TIBIAL-001',
    description: 'tibialis keeps wall tibial raise',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'tibialis',
      specificMuscleKey: 'tibialis_anterior',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Elevação tibial'},
    mustExclude: {'Gémeos sentado'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-LEGS-FEET-001',
    description: 'feet keep intrinsic foot drills',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'feet_ankle',
      specificMuscleKey: 'feet',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Short foot / doming', 'Flexão ativa dos dedos do pé'},
    mustExclude: {'Leg press'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BANDS-LEGS-ANKLE-001',
    description: 'bands keep ankle inversion/eversion',
    selection: TrainingSelection(
      regionKey: 'lower',
      groupKey: 'feet_ankle',
      specificMuscleKey: 'ankle',
      equipmentKey: 'bands',
    ),
    mustContain: {
      'Inversão do tornozelo com elástico',
      'Eversão do tornozelo com elástico',
    },
    mustExclude: {'Leg press'},
    location: 'Casa',
    equipment: {..._homeBase, 'bands'},
  ),
  _ManualReviewCase(
    id: 'GYM-CARDIO-TREADMILL-001',
    description: 'treadmill focus keeps treadmill only',
    selection: TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'cardio_machine',
      subgroupKey: 'treadmill',
      equipmentKey: 'treadmill',
    ),
    mustContain: {'Passadeira caminhada'},
    mustExclude: {'Bicicleta ritmo moderado'},
  ),
  _ManualReviewCase(
    id: 'GYM-CARDIO-COMPLETE-001',
    description: 'complete gym cardio includes each installed modality',
    selection: TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'cardio_general',
    ),
    mustContain: {
      'Passadeira caminhada',
      'Bicicleta ritmo leve',
      'Elíptica ritmo leve',
      'HIIT simples',
    },
    mustExclude: {'Supino com barra'},
  ),
  _ManualReviewCase(
    id: 'GYM-CARDIO-BIKE-001',
    description: 'bike focus keeps bike only',
    selection: TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'cardio_machine',
      subgroupKey: 'bike',
      equipmentKey: 'bike',
    ),
    mustContain: {'Bicicleta ritmo moderado'},
    mustExclude: {'Passadeira caminhada'},
  ),
  _ManualReviewCase(
    id: 'GYM-CARDIO-ELLIPTICAL-001',
    description: 'elliptical focus keeps elliptical only',
    selection: TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'cardio_machine',
      subgroupKey: 'elliptical',
      equipmentKey: 'elliptical',
    ),
    mustContain: {'Elíptica ritmo moderado'},
    mustExclude: {'Passadeira caminhada'},
  ),
  _ManualReviewCase(
    id: 'OUT-CARDIO-WALK-001',
    description: 'outdoor walk keeps walking only',
    selection: TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'outdoor_cardio',
      subgroupKey: 'outdoor_walk',
    ),
    mustContain: {'Caminhada exterior leve'},
    mustExclude: {'Passadeira caminhada'},
    location: 'Exterior',
    equipment: {'bodyweight', 'floor', 'outdoor_space'},
  ),
  _ManualReviewCase(
    id: 'OUT-CARDIO-RUN-001',
    description: 'outdoor run keeps running without treadmill',
    selection: TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'outdoor_cardio',
      subgroupKey: 'outdoor_run',
    ),
    mustContain: {'Corrida exterior leve'},
    mustExclude: {'Passadeira corrida leve'},
    location: 'Exterior',
    equipment: {'bodyweight', 'floor', 'outdoor_space'},
  ),
  _ManualReviewCase(
    id: 'OUT-CARDIO-SPRINT-001',
    description: 'outdoor sprint keeps sprint outdoors',
    selection: TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'outdoor_cardio',
      subgroupKey: 'outdoor_sprints',
    ),
    mustContain: {'Sprints exterior'},
    mustExclude: {'Passadeira intervalos'},
    location: 'Exterior',
    equipment: {'bodyweight', 'floor', 'outdoor_space'},
  ),
  _ManualReviewCase(
    id: 'BW-CARDIO-HIIT-001',
    description: 'home HIIT keeps equipment-free intervals',
    selection: TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'hiit_group',
      subgroupKey: 'hiit',
      equipmentKey: 'bodyweight',
    ),
    mustContain: {'Mountain climbers'},
    mustExclude: {'Passadeira HIIT'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'ROPE-CARDIO-001',
    description: 'home jump-rope profile keeps rope cardio only',
    selection: TrainingSelection(
      regionKey: 'cardio',
      groupKey: 'jump_rope_group',
      subgroupKey: 'jump_rope',
      equipmentKey: 'jump_rope',
    ),
    mustContain: {'Corda de saltar ritmo leve', 'Corda de saltar intervalos'},
    mustExclude: {'Passadeira caminhada'},
    location: 'Casa',
    equipment: {..._homeBase, 'jump_rope'},
  ),
  _ManualReviewCase(
    id: 'BW-MOBILITY-COMPLETE-001',
    description: 'complete mobility includes several equipment-free regions',
    selection: TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'general_mobility',
    ),
    mustContain: {
      'Mobilidade de ombro',
      'Mobilidade 90/90',
      'Mobilidade de tornozelo na parede',
      'Mobilidade de punhos',
    },
    mustExclude: {'Supino com barra'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-MOBILITY-SHOULDER-001',
    description: 'shoulder mobility keeps dedicated shoulder mobility',
    selection: TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'shoulder_mobility',
    ),
    mustContain: {'Mobilidade de ombro'},
    mustExclude: {'Press militar com barra'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-MOBILITY-THORACIC-001',
    description: 'thoracic mobility keeps open book/cat-cow',
    selection: TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'thoracic_mobility',
    ),
    mustContain: {'Open book', 'Cat-cow'},
    mustExclude: {'Remo com barra'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-MOBILITY-HIP-001',
    description: 'hip mobility keeps 90/90',
    selection: TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'hip_mobility',
    ),
    mustContain: {'Mobilidade 90/90'},
    mustExclude: {'Agachamento com barra'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-MOBILITY-ANKLE-001',
    description: 'ankle mobility keeps ankle drill',
    selection: TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'ankle_mobility',
    ),
    mustContain: {'Mobilidade de tornozelo na parede'},
    mustExclude: {'Leg press'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-MOBILITY-WRIST-001',
    description: 'wrist mobility keeps wrist circles',
    selection: TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'wrist_mobility',
    ),
    mustContain: {'Mobilidade de punhos'},
    mustExclude: {'Wrist curl'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-MOBILITY-NECK-001',
    description: 'neck mobility keeps cervical control',
    selection: TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'neck_mobility',
    ),
    mustContain: {'Alongamento cervical leve'},
    mustExclude: {'Encolhimento de ombros com barra'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'BW-MOBILITY-RECOVERY-001',
    description: 'stretching keeps equipment-free stretching',
    selection: TrainingSelection(
      regionKey: 'mobility_recovery',
      groupKey: 'stretching',
    ),
    mustContain: {'Alongamento peitoral'},
    mustExclude: {'Supino com barra'},
    location: 'Casa',
    equipment: _homeBase,
  ),
  _ManualReviewCase(
    id: 'DOJO-KARATE-001',
    description: 'dojo Karate keeps Karate drills',
    selection: TrainingSelection(
      regionKey: 'martial_arts',
      groupKey: 'karate',
      subgroupKey: 'karate_technical',
    ),
    mustContain: {'Kihon', 'Sombra de Karate'},
    mustExclude: {'Shrimp / fuga de anca'},
    location: 'Dojo / Artes marciais',
    equipment: {'bodyweight', 'floor', 'wall', 'tatami'},
  ),
  _ManualReviewCase(
    id: 'DOJO-JIUJITSU-001',
    description: 'dojo Jiu-Jitsu keeps grappling drills',
    selection: TrainingSelection(
      regionKey: 'martial_arts',
      groupKey: 'jiu_jitsu',
      subgroupKey: 'jiu_jitsu_technical',
    ),
    mustContain: {'Shrimp / fuga de anca', 'Technical stand-up'},
    mustExclude: {'Kihon'},
    location: 'Dojo / Artes marciais',
    equipment: {'bodyweight', 'floor', 'wall', 'tatami'},
  ),
  _ManualReviewCase(
    id: 'DOJO-CONDITIONING-001',
    description: 'dojo conditioning keeps catalogued martial conditioning',
    selection: TrainingSelection(
      regionKey: 'martial_arts',
      groupKey: 'martial_conditioning',
    ),
    mustContain: {'Condicionamento leve para Karate', 'Sprawl'},
    mustExclude: {'Supino com barra'},
    location: 'Dojo / Artes marciais',
    equipment: {'bodyweight', 'floor', 'wall', 'tatami'},
  ),
  _ManualReviewCase(
    id: 'DOJO-GRIP-001',
    description: 'dojo grappling grip keeps the Jiu-Jitsu grip drill',
    selection: TrainingSelection(
      regionKey: 'martial_arts',
      groupKey: 'grappling_grip',
    ),
    mustContain: {'Força de pega para Jiu-Jitsu'},
    mustExclude: {'Wrist curl'},
    location: 'Dojo / Artes marciais',
    equipment: {'bodyweight', 'floor', 'wall', 'tatami'},
  ),
  _ManualReviewCase(
    id: 'DOJO-MOBILITY-001',
    description: 'martial mobility keeps Karate and Jiu-Jitsu mobility drills',
    selection: TrainingSelection(
      regionKey: 'martial_arts',
      groupKey: 'martial_mobility',
    ),
    mustContain: {
      'Mobilidade de anca para Karate',
      'Mobilidade de anca para Jiu-Jitsu',
    },
    mustExclude: {'Supino com barra'},
    location: 'Dojo / Artes marciais',
    equipment: {'bodyweight', 'floor', 'wall', 'tatami'},
  ),
  _ManualReviewCase(
    id: 'DOJO-CORE-001',
    description: 'martial core keeps the dedicated Jiu-Jitsu core drill',
    selection: TrainingSelection(
      regionKey: 'martial_arts',
      groupKey: 'martial_core',
    ),
    mustContain: {'Core para Jiu-Jitsu'},
    mustExclude: {'Crunch no cabo'},
    location: 'Dojo / Artes marciais',
    equipment: {'bodyweight', 'floor', 'wall', 'tatami'},
  ),
];

Set<String> _visibleNames(
  TrainingSelection selection, {
  String location = 'Casa',
  Set<String> equipment = const {'bodyweight', 'floor', 'wall'},
}) {
  final persistedExercises = _persistedCatalogExercises();
  return ExerciseFilterService.getAvailableExercises(
    exercises: persistedExercises,
    trainingLocation: location,
    availableEquipmentKeys: equipment,
    selection: selection,
    showAllExercises: false,
  ).map((item) => item.exercise.name).toSet();
}

List<Exercise> _persistedCatalogExercises() => ExerciseCatalogContextService
    .entries
    .map(ExerciseTaxonomyService.enrichCatalogExercise)
    .toList();
