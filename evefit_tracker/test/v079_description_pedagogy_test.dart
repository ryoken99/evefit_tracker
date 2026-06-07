import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/services/exercise_catalog_detail_service.dart';
import 'package:evefit_tracker/services/workout_taxonomy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.9 description pedagogy', () {
    test('classic push-up teaches a beginner the full movement', () {
      final detail = _detail('Flexão clássica', 'Peito');
      final text = _normalized(detail);

      expect(text, contains('prancha'));
      expect(text, contains('maos'));
      expect(text, contains('pes'));
      expect(text, contains('cabeca'));
      expect(text, contains('cotovelos'));
      expect(text, contains('peito'));
      expect(text, contains('desce'));
      expect(text, contains('sobe'));
      expect(text, contains('inspira'));
      expect(text, contains('expira'));
      expect(text, contains('joelhos apoiados'));
      expect(text, contains('dor no ombro'));
      expect(
        detail.executionSteps.split(RegExp(r'\d+\.')).length - 1,
        greaterThanOrEqualTo(10),
      );
    });

    test(
      'bodyweight squat teaches feet knees hips descent ascent breathing',
      () {
        final detail = _detail('Agachamento com peso corporal', 'Pernas');
        final text = _normalized(detail);

        expect(text, contains('pes'));
        expect(text, contains('ombros'));
        expect(text, contains('anca'));
        expect(text, contains('joelhos'));
        expect(text, contains('calcanhares'));
        expect(text, contains('coxa'));
        expect(text, contains('desce'));
        expect(text, contains('sobe'));
        expect(text, contains('inspira'));
        expect(text, contains('expira'));
        expect(text, contains('cadeira'));
        expect(text, contains('dor aguda'));
        expect(
          detail.executionSteps.split(RegExp(r'\d+\.')).length - 1,
          greaterThanOrEqualTo(10),
        );
      },
    );

    test(
      'home alternative exercises include stability and slipping warnings',
      () {
        for (final name in [
          'Agachamento com mochila',
          'Agachamento com garrafão',
          'Lunges com mochila',
          'Remo invertido em mesa resistente',
          'Mobilidade de ombro com cabo de vassoura',
        ]) {
          final detail = _detail(name, _groupFor(name));
          final text = _normalized(detail);

          expect(
            text.contains('estavel') ||
                text.contains('estabilidade') ||
                text.contains('nao escorreg'),
            isTrue,
            reason: name,
          );
          expect(
            text.contains('para') || text.contains('interrompe'),
            isTrue,
            reason: name,
          );
        }
      },
    );

    test('all visible seed exercises keep non-empty teaching fields', () {
      for (final entry in _catalogEntries()) {
        final detail = _detail(entry.name, entry.group);
        expect(detail.equipment.trim(), isNotEmpty, reason: entry.name);
        expect(
          detail.description.trim().length,
          greaterThanOrEqualTo(80),
          reason: entry.name,
        );
        expect(
          detail.executionSteps.split(RegExp(r'\d+\.')).length - 1,
          greaterThanOrEqualTo(5),
          reason: entry.name,
        );
        expect(
          detail.commonMistakes.trim().length,
          greaterThanOrEqualTo(40),
          reason: entry.name,
        );
        expect(
          detail.safetyNotes.trim().length,
          greaterThanOrEqualTo(40),
          reason: entry.name,
        );
      }
    });

    test('no visible exercise contains generic prohibited phrases', () {
      for (final entry in _catalogEntries()) {
        final detail = _detail(entry.name, entry.group);
        final combined = WorkoutTaxonomy.normalize(
          [
            detail.description,
            detail.executionSteps,
            detail.commonMistakes,
            detail.safetyNotes,
          ].join('\n'),
        );

        for (final phrase in _forbiddenPatterns) {
          expect(
            combined,
            isNot(contains(WorkoutTaxonomy.normalize(phrase))),
            reason: '${entry.name} contains "$phrase"',
          );
        }
      }
    });
  });
}

const _forbiddenPatterns = [
  'Ajusta pés, mãos e carga',
  'Faz o movimento principal',
  'Mantém boa postura',
  'Movimento lento e controlado',
  'Amplitude confortável',
  'Começa leve',
  'Executa com boa técnica',
  'Descrição ainda incompleta',
  'será melhorado numa próxima versão',
];

ExerciseCatalogDetails _detail(String name, String group) =>
    ExerciseCatalogDetailService.forExercise(name: name, group: group);

String _normalized(ExerciseCatalogDetails detail) => WorkoutTaxonomy.normalize(
  [
    detail.description,
    detail.executionSteps,
    detail.commonMistakes,
    detail.safetyNotes,
  ].join('\n'),
);

String _groupFor(String name) {
  for (final entry in SeedData.exercisesByGroup.entries) {
    if (entry.value.contains(name)) return entry.key;
  }
  return name.contains('Mobilidade') ? 'Mobilidade' : 'Pernas';
}

List<_CatalogEntry> _catalogEntries() {
  final seen = <String>{};
  final entries = <_CatalogEntry>[];
  for (final entry in SeedData.exercisesByGroup.entries) {
    for (final name in entry.value) {
      if (seen.add(name)) entries.add(_CatalogEntry(name, entry.key));
    }
  }
  return entries;
}

class _CatalogEntry {
  const _CatalogEntry(this.name, this.group);

  final String name;
  final String group;
}
