import 'dart:io';

import 'package:evefit_tracker/services/clean_base_config.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'clean base keeps legacy catalogue data but disables active visibility',
    () {
      expect(CleanBaseConfig.legacyCatalogueVisible, isFalse);
      expect(CleanBaseConfig.legacyFiltersVisible, isFalse);
      expect(ExerciseCatalogContextService.entries, isNotEmpty);
    },
  );

  test(
    'normal catalogue and filter entry points are guarded by clean base flags',
    () {
      final workoutsScreen = File(
        'lib/screens/workouts_screen.dart',
      ).readAsStringSync();
      final workoutDetail = File(
        'lib/screens/workout_detail_screen.dart',
      ).readAsStringSync();

      expect(
        workoutsScreen,
        contains('if (CleanBaseConfig.legacyFiltersVisible)'),
      );
      expect(
        workoutsScreen,
        contains('if (!CleanBaseConfig.legacyFiltersVisible)'),
      );
      expect(
        workoutDetail,
        contains('if (!CleanBaseConfig.legacyCatalogueVisible)'),
      );
      expect(workoutDetail, contains('CleanBaseConfig.catalogueRebuildTitle'));
    },
  );
}
