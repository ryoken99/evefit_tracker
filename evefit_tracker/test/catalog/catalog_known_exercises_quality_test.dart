import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/catalog_quality/catalog_quality_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final List<Exercise> exercises;

  setUpAll(() {
    exercises = CatalogQualityAudit.currentExercises();
  });

  test('known canonical exercises keep complete identity and content', () {
    for (final canonicalId in const [
      'push_up',
      'glute_bridge',
      'technical_stand_up_lento',
      'adductor_squeeze_leve',
      'treadmill_warmup',
      'treadmill_aerobic_endurance',
      'treadmill_easy_pace',
      'treadmill_moderate_pace',
      'treadmill_intervals',
      'treadmill_hiit',
      'treadmill_walk',
      'treadmill_run',
      'treadmill_incline_walk',
    ]) {
      final matches = exercises.where(
        (item) => item.canonicalId == canonicalId,
      );
      expect(matches, isNotEmpty, reason: '$canonicalId missing');
      for (final exercise in matches) {
        expect(exercise.catalogEntryKey, isNotEmpty);
        expect(exercise.exerciseKey, isNotEmpty);
        expect(exercise.contextKey, isNotEmpty);
        expect(exercise.description.length, greaterThanOrEqualTo(80));
        expect(_stepCount(exercise.executionSteps), greaterThanOrEqualTo(4));
        expect(exercise.breathingTips, isNotEmpty);
        expect(exercise.commonMistakes, isNotEmpty);
        expect(exercise.safetyNotes, isNotEmpty);
        expect(exercise.regression, isNotEmpty);
        expect(exercise.progression, isNotEmpty);
        expect(exercise.adaptationNotes, isNotEmpty);
      }
    }
  });

  test(
    'adductor squeeze leve is beginner-readable and anatomically correct',
    () {
      final exercise = exercises.firstWhere(
        (item) => item.canonicalId == 'adductor_squeeze_leve',
      );
      final text = [
        exercise.description,
        exercise.executionSteps,
        exercise.commonMistakes,
        exercise.regression,
        exercise.progression,
        exercise.adaptationNotes,
      ].join(' ').toLowerCase();

      expect(exercise.muscleGroup.toLowerCase(), contains('adutor'));
      expect(text, contains('bola'));
      expect(text, contains('almofada'));
      expect(text, contains('toalha'));
      expect(text, contains('2 a 5 segundos'));
      expect(text, contains('parte interna das coxas'));
      expect(text, contains('lombar'));
      expect(text, contains('respir'));
      expect(text, contains('forca maxima'));
      expect(text, contains('evita'));
    },
  );

  test('treadmill essentials have treadmill equipment and cardio type', () {
    final ids = {
      'treadmill_warmup',
      'treadmill_cooldown',
      'treadmill_aerobic_endurance',
      'treadmill_easy_pace',
      'treadmill_moderate_pace',
      'treadmill_intervals',
      'treadmill_hiit',
      'treadmill_walk',
      'treadmill_run',
      'treadmill_incline_walk',
    };
    for (final canonicalId in ids) {
      final exercise = exercises.firstWhere(
        (item) => item.canonicalId == canonicalId,
      );
      expect(exercise.primaryType, 'cardio');
      expect(exercise.equipmentKeys, contains('treadmill'));
    }
  });
}

int _stepCount(String value) =>
    RegExp(r'(^|\n)\s*\d+[.)]').allMatches(value).length;
