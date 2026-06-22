import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/workout_taxonomy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.8.0 complete beginner teaching contract', () {
    test('every catalog entry has all individual teaching fields', () {
      for (final entry in ExerciseCatalogContextService.entries) {
        final detail = entry.details;
        expect(detail.description.trim(), isNotEmpty, reason: entry.id);
        expect(detail.executionSteps.trim(), isNotEmpty, reason: entry.id);
        expect(detail.commonMistakes.trim(), isNotEmpty, reason: entry.id);
        expect(detail.safetyNotes.trim(), isNotEmpty, reason: entry.id);
        expect(detail.regression.trim(), isNotEmpty, reason: entry.id);
        expect(detail.progression.trim(), isNotEmpty, reason: entry.id);
        expect(detail.breathingTips.trim(), isNotEmpty, reason: entry.id);
        expect(detail.postureTips.trim(), isNotEmpty, reason: entry.id);
        expect(detail.adaptationNotes.trim(), isNotEmpty, reason: entry.id);
      }
    });

    test('every execution has at least eleven concrete numbered steps', () {
      for (final entry in ExerciseCatalogContextService.entries) {
        final steps = entry.details.executionSteps;
        final normalized = WorkoutTaxonomy.normalize(steps);
        expect(
          RegExp(r'\d+\.').allMatches(steps).length,
          greaterThanOrEqualTo(11),
          reason: entry.id,
        );
        for (final cue in [
          'respira',
          'ritmo recomendado',
          'erro mais comum',
          'versao mais facil',
          'versao mais dificil',
        ]) {
          expect(normalized, contains(cue), reason: '${entry.id}: $cue');
        }
        expect(normalized, contains('como perceber'), reason: entry.id);
        expect(normalized, contains('mal feito'), reason: entry.id);
      }
    });

    test('guidance remains entry-specific rather than copied verbatim', () {
      final descriptions = <String>{};
      final executions = <String>{};
      for (final entry in ExerciseCatalogContextService.entries) {
        expect(
          descriptions.add(entry.details.description),
          isTrue,
          reason: 'duplicate description: ${entry.id}',
        );
        expect(
          executions.add(entry.details.executionSteps),
          isTrue,
          reason: 'duplicate execution: ${entry.id}',
        );
      }
    });
  });
}
