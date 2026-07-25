import 'dart:io';

import 'package:evefit_tracker/services/clean_base_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('clean base disables the complete legacy runtime', () {
    expect(CleanBaseConfig.legacyCatalogueVisible, isFalse);
    expect(CleanBaseConfig.legacyFiltersVisible, isFalse);
    expect(CleanBaseConfig.legacySeedEnabled, isFalse);
    expect(CleanBaseConfig.legacyCatalogueRuntimeEnabled, isFalse);
    expect(CleanBaseConfig.legacyFiltersRuntimeEnabled, isFalse);
    expect(CleanBaseConfig.canonicalSearchMenuVisible, isTrue);
    expect(CleanBaseConfig.canonicalCatalogueHasActiveExercises, isTrue);
  });

  test('canonical menu replaces catalogue and filter entry points', () {
    final workoutsScreen = File(
      'lib/screens/workouts_screen.dart',
    ).readAsStringSync();
    final workoutDetail = File(
      'lib/screens/workout_detail_screen.dart',
    ).readAsStringSync();

    expect(workoutsScreen, isNot(contains('legacyFiltersVisible')));
    expect(workoutDetail, isNot(contains('legacyCatalogueVisible')));
    expect(workoutDetail, isNot(contains('ExerciseFilterService')));
    expect(workoutDetail, contains('WorkoutExerciseSelectorScreen'));
  });
}
