import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/workout_taxonomy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.9.1 complete beginner teaching contract', () {
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

    test('every execution is a vertical list of 4 to 7 concrete steps', () {
      for (final entry in ExerciseCatalogContextService.entries) {
        final steps = entry.details.executionSteps;
        final lines = steps
            .split('\n')
            .where((line) => line.trim().isNotEmpty)
            .toList();
        expect(
          lines.length,
          inInclusiveRange(4, 7),
          reason: '${entry.id} ${entry.name}',
        );
        for (final line in lines) {
          expect(
            line.replaceFirst(RegExp(r'^\d{1,2}\.\s*'), '').length,
            lessThanOrEqualTo(180),
            reason: '${entry.id} ${entry.name}: "$line"',
          );
        }
        final breathing = WorkoutTaxonomy.normalize(
          '$steps ${entry.details.breathingTips}',
        );
        expect(
          breathing,
          anyOf(
            contains('respira'),
            contains('inspira'),
            contains('expira'),
          ),
          reason: entry.id,
        );
      }
    });

    test('guidance remains entry-specific rather than copied verbatim', () {
      final descriptions = <String, String>{};
      final executions = <String, String>{};
      for (final entry in ExerciseCatalogContextService.entries) {
        final previousDescription =
            descriptions[entry.details.description.toLowerCase()];
        expect(
          previousDescription,
          isNull,
          reason:
              '${entry.id} ${entry.name} repete a descrição de '
              '$previousDescription',
        );
        descriptions[entry.details.description.toLowerCase()] = entry.name;

        final stepsKey = entry.details.executionSteps.toLowerCase();
        final previousExecution = executions[stepsKey];
        // Entradas com o mesmo nome em contextos diferentes são o mesmo
        // exercício e podem partilhar a execução; nomes diferentes não.
        if (previousExecution != null) {
          expect(
            previousExecution,
            entry.name,
            reason:
                '${entry.id} ${entry.name} repete a execução de '
                '$previousExecution',
          );
        }
        executions[stepsKey] = entry.name;
      }
    });
  });
}
