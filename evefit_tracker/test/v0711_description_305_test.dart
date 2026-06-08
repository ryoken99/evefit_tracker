import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:flutter_test/flutter_test.dart';

const _forbiddenPhrases = [
  'Ajusta pés, mãos e carga',
  'Faz o movimento principal',
  'Volta à posição inicial com a mesma trajetória',
  'Começa leve, progride gradualmente',
  'Movimento lento e previsível',
  'Amplitude controlada',
  'Mantém boa postura',
  'Executa com boa técnica',
  'Usar pressa',
  'Compensar com outra zona do corpo',
  'Resistência que muda a trajetória',
  'Descrição ainda incompleta',
  'Será melhorado numa próxima versão',
];

void main() {
  group('v0.7.11 beginner-readable descriptions for 305 entries', () {
    test('all 305 entries have complete individual explanation fields', () {
      final entries = ExerciseCatalogContextService.entries;
      expect(entries, hasLength(305));

      for (final entry in entries) {
        final details = entry.details;
        expect(
          details.description.trim(),
          isNotEmpty,
          reason: entry.catalogEntryKey,
        );
        expect(
          details.executionSteps.trim(),
          isNotEmpty,
          reason: entry.catalogEntryKey,
        );
        expect(
          details.commonMistakes.trim(),
          isNotEmpty,
          reason: entry.catalogEntryKey,
        );
        expect(
          details.safetyNotes.trim(),
          isNotEmpty,
          reason: entry.catalogEntryKey,
        );
        expect(
          details.equipment.trim(),
          isNotEmpty,
          reason: entry.catalogEntryKey,
        );
        expect(
          details.secondaryGroups.trim(),
          isNotEmpty,
          reason: entry.catalogEntryKey,
        );
        expect(
          entry.beginnerUnderstands,
          isTrue,
          reason: entry.catalogEntryKey,
        );
      }
    });

    test('no entry uses forbidden generic phrases or family-only fallback', () {
      for (final entry in ExerciseCatalogContextService.entries) {
        final text = [
          entry.details.description,
          entry.details.executionSteps,
          entry.details.commonMistakes,
          entry.details.safetyNotes,
        ].join('\n');
        for (final phrase in _forbiddenPhrases) {
          expect(
            text,
            isNot(contains(phrase)),
            reason: '${entry.catalogEntryKey} contains "$phrase"',
          );
        }
        expect(
          entry.dependsOnlyOnGenericFallback,
          isFalse,
          reason: entry.catalogEntryKey,
        );
      }
      expect(ExerciseCatalogContextService.genericFallbackOnlyEntries, isEmpty);
    });

    test('entry explanations include modality-specific teaching cues', () {
      final entries = ExerciseCatalogContextService.entries;

      for (final entry in entries.where(
        (entry) => entry.group == 'Mobilidade',
      )) {
        final steps = entry.details.executionSteps.toLowerCase();
        expect(
          steps,
          anyOf(contains('segundos'), contains('respira')),
          reason: entry.catalogEntryKey,
        );
      }

      for (final entry in entries.where((entry) => entry.group == 'Cardio')) {
        final steps = entry.details.executionSteps.toLowerCase();
        expect(steps, contains('intens'), reason: entry.catalogEntryKey);
        expect(
          steps,
          anyOf(contains('minuto'), contains('segundo')),
          reason: entry.catalogEntryKey,
        );
      }

      for (final entry in entries.where(
        (entry) => entry.group == 'Karate' || entry.group == 'Jiu-Jitsu',
      )) {
        final steps = entry.details.executionSteps.toLowerCase();
        expect(
          steps,
          anyOf(contains('base'), contains('objetivo técnico')),
          reason: entry.catalogEntryKey,
        );
      }
    });
  });
}
