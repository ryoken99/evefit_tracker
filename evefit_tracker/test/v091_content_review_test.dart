import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/workout_taxonomy.dart';
import 'package:flutter_test/flutter_test.dart';

/// FASE 9 da revisão v0.9.1: valida TODOS os exercícios do catálogo contra o
/// modelo canónico de conteúdo (objetivo, execução em lista, erros comuns,
/// variações, linguagem por tipo de equipamento e frases proibidas).
void main() {
  final entries = ExerciseCatalogContextService.entries;

  String norm(String value) => WorkoutTaxonomy.normalize(value);

  List<String> stepLines(String steps) => steps
      .split('\n')
      .map((line) => line.replaceFirst(RegExp(r'^\s*\d{1,2}\.\s*'), '').trim())
      .where((line) => line.isNotEmpty)
      .toList();

  List<String> mistakeLines(String mistakes) => mistakes
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();

  bool isBodyweight(ExerciseCatalogEntry entry) {
    final equipment = norm(entry.details.equipment);
    const loaded = [
      'halter',
      'barra',
      'cabo',
      'polia',
      'maquina',
      'disco',
      'kettlebell',
      'mochila',
      'garrafao',
      'elastico',
    ];
    return !loaded.any(equipment.contains);
  }

  String fullText(ExerciseCatalogEntry entry) => norm(
    '${entry.details.description} ${entry.details.executionSteps} '
    '${entry.details.commonMistakes} ${entry.details.safetyNotes} '
    '${entry.details.regression} ${entry.details.progression} '
    '${entry.details.breathingTips} ${entry.details.postureTips} '
    '${entry.details.adaptationNotes}',
  );

  group('v0.9.1 canonical content for all 353 catalog entries', () {
    test('catalog exposes all 353 entries', () {
      expect(entries, hasLength(353));
    });

    test('1. every exercise has a non-empty objective', () {
      for (final entry in entries) {
        expect(entry.details.description.trim(), isNotEmpty, reason: entry.id);
      }
    });

    test('2/10. every execution has 4 to 7 steps', () {
      for (final entry in entries) {
        expect(
          stepLines(entry.details.executionSteps).length,
          inInclusiveRange(4, 7),
          reason: '${entry.id} ${entry.name}',
        );
      }
    });

    test('3. execution is never a glued numbered paragraph', () {
      for (final entry in entries) {
        final steps = entry.details.executionSteps;
        final numberedMarks = RegExp(r'\d{1,2}\.\s').allMatches(steps).length;
        if (numberedMarks > 1) {
          expect(
            steps,
            contains('\n'),
            reason:
                '${entry.id} ${entry.name}: execução numerada sem quebras '
                'de linha',
          );
        }
      }
    });

    test('4. bodyweight exercises never use external-load language', () {
      const forbidden = [
        'segura peso corporal',
        'usa peso corporal',
        'desce a carga',
        'afastar a carga',
        'a carga cair',
        'usa carga menor',
      ];
      for (final entry in entries.where(isBodyweight)) {
        final text = fullText(entry);
        for (final phrase in forbidden) {
          expect(
            text,
            isNot(contains(norm(phrase))),
            reason: '${entry.id} ${entry.name}: "$phrase"',
          );
        }
        final cargaMatches = RegExp(r'\bcarga\b').allMatches(text).where((
          match,
        ) {
          final context = text.substring(
            match.start < 24 ? 0 : match.start - 24,
            match.end,
          );
          return !context.contains('sem carga') &&
              !context.contains('carga externa');
        });
        expect(
          cargaMatches,
          isEmpty,
          reason:
              '${entry.id} ${entry.name}: linguagem de carga em exercício '
              'de peso corporal',
        );
      }
    });

    test('5. no placeholders anywhere', () {
      const placeholders = [
        'todo:',
        'n/a',
        'lorem',
        'descricao generica',
        'exercicio generico',
        'placeholder',
      ];
      for (final entry in entries) {
        final text = fullText(entry);
        for (final phrase in placeholders) {
          expect(
            text,
            isNot(contains(norm(phrase))),
            reason: '${entry.id} ${entry.name}: "$phrase"',
          );
        }
      }
    });

    test('6. objective does not repeat the exercise name excessively', () {
      for (final entry in entries) {
        final name = norm(entry.name);
        final description = norm(entry.details.description);
        final occurrences = name.length < 4
            ? 0
            : RegExp(RegExp.escape(name)).allMatches(description).length;
        expect(
          occurrences,
          lessThanOrEqualTo(1),
          reason: '${entry.id} ${entry.name}',
        );
      }
    });

    test('7. text never claims equipment the exercise does not use', () {
      for (final entry in entries) {
        final equipment = norm(entry.details.equipment);
        final steps = norm(entry.details.executionSteps);
        if (!equipment.contains('halter') &&
            !equipment.contains('garrafao') &&
            !equipment.contains('disco')) {
          expect(
            steps,
            isNot(contains('usa halteres')),
            reason: '${entry.id} ${entry.name}',
          );
          expect(
            steps,
            isNot(contains('segura os halteres')),
            reason: '${entry.id} ${entry.name}',
          );
        }
        if (!equipment.contains('barra') || equipment.contains('barra fixa')) {
          expect(
            steps,
            isNot(contains('tira a barra do suporte')),
            reason: '${entry.id} ${entry.name}',
          );
        }
        if (!equipment.contains('cabo') &&
            !equipment.contains('polia') &&
            !equipment.contains('maquina')) {
          expect(
            steps,
            isNot(contains('ajusta a polia')),
            reason: '${entry.id} ${entry.name}',
          );
        }
      }
    });

    test('8. no objective exceeds 280 characters (and has substance)', () {
      for (final entry in entries) {
        expect(
          entry.details.description.length,
          inInclusiveRange(60, 280),
          reason: '${entry.id} ${entry.name}',
        );
      }
    });

    test('9. no step exceeds 180 characters', () {
      for (final entry in entries) {
        for (final line in stepLines(entry.details.executionSteps)) {
          expect(
            line.length,
            lessThanOrEqualTo(180),
            reason: '${entry.id} ${entry.name}: "$line"',
          );
        }
      }
    });

    test('11. common mistakes are a list of 3 to 5 items', () {
      for (final entry in entries) {
        expect(
          mistakeLines(entry.details.commonMistakes).length,
          inInclusiveRange(3, 5),
          reason: '${entry.id} ${entry.name}',
        );
      }
    });

    test('12/13. every exercise has concrete easier and harder versions', () {
      for (final entry in entries) {
        expect(
          entry.details.regression.trim().length,
          greaterThanOrEqualTo(30),
          reason: '${entry.id} ${entry.name}',
        );
        expect(
          entry.details.progression.trim().length,
          greaterThanOrEqualTo(30),
          reason: '${entry.id} ${entry.name}',
        );
        expect(
          entry.details.regression,
          isNot(startsWith('Versão mais fácil:')),
          reason: '${entry.id} ${entry.name}',
        );
        expect(
          entry.details.progression,
          isNot(startsWith('Versão mais difícil:')),
          reason: '${entry.id} ${entry.name}',
        );
      }
    });

    test('global forbidden phrases never appear in any entry', () {
      const forbidden = [
        'segura peso corporal',
        'usa peso corporal',
        'afastar a carga',
        'desce a carga',
        'nao deixar a carga cair',
        'a carga cair',
        'o peso deve permitir punhos',
        'como apoio e core',
        'em flexao diamante',
        'a trajetoria especifica desta variacao',
      ];
      for (final entry in entries) {
        final text = fullText(entry);
        for (final phrase in forbidden) {
          expect(
            text,
            isNot(contains(phrase)),
            reason: '${entry.id} ${entry.name}: "$phrase"',
          );
        }
      }
    });

    test('no two different exercises share objective or execution', () {
      final descriptions = <String, String>{};
      final executions = <String, String>{};
      for (final entry in entries) {
        final descKey = entry.details.description.toLowerCase();
        if (descriptions.containsKey(descKey)) {
          expect(
            descriptions[descKey],
            entry.name,
            reason:
                '${entry.id} ${entry.name} repete a descrição de '
                '${descriptions[descKey]}',
          );
        }
        descriptions[descKey] = entry.name;
        final stepsKey = entry.details.executionSteps.toLowerCase();
        if (executions.containsKey(stepsKey)) {
          expect(
            executions[stepsKey],
            entry.name,
            reason:
                '${entry.id} ${entry.name} repete a execução de '
                '${executions[stepsKey]}',
          );
        }
        executions[stepsKey] = entry.name;
      }
    });
  });

  group('v0.9.1 mandatory case fixes (FASE 6)', () {
    ExerciseCatalogEntry entryFor(String name, String group) =>
        ExerciseCatalogContextService.entryFor(name: name, group: group);

    test('14a. Flexão diamante teaches the diamond push-up', () {
      final entry = entryFor('Flexão diamante', 'Tríceps');
      final steps = norm(entry.details.executionSteps);
      expect(steps, contains('prancha'));
      expect(steps, contains('diamante'));
      expect(steps, contains('cotovelos proximos do tronco'));
      expect(steps, contains('desce o corpo'));
      expect(steps, contains('empurra o chao'));
      expect(steps, contains('abdomen ativo'));
      expect(
        norm(entry.details.regression),
        allOf(contains('joelhos no chao'), contains('superficie elevada')),
      );
      final text = fullText(entry);
      expect(text, isNot(contains('afastar a carga')));
      expect(text, isNot(contains('segura peso corporal')));
      expect(text, isNot(contains('desce a carga')));
      expect(text, isNot(contains(RegExp(r'\bcarga\b'))));
    });

    test('14b. Curl arrastado teaches the drag curl', () {
      final entry = entryFor('Curl arrastado com halteres', 'Bíceps');
      final steps = norm(entry.details.executionSteps);
      expect(steps, contains('colados ao tronco'));
      expect(steps, contains('cotovelos recuar'));
      expect(steps, contains('sem encolher os ombros'));
      expect(steps, contains('balancar o corpo'));
      expect(steps, contains('desce os halteres devagar'));
      expect(norm(entry.details.description), contains('biceps'));
      final lines = stepLines(entry.details.executionSteps);
      expect(
        lines.toSet().length,
        lines.length,
        reason: 'passos repetidos no curl arrastado',
      );
    });

    test('14c. Tate press teaches the tate press, not a close-grip press', () {
      final entry = entryFor('Tate press', 'Tríceps');
      final steps = norm(entry.details.executionSteps);
      expect(steps, contains('deita-te num banco ou no chao'));
      expect(steps, contains('por cima do peito'));
      expect(steps, contains('cotovelos para fora'));
      expect(steps, contains('em direcao ao meio do peito'));
      expect(steps, contains('estende os cotovelos'));
      expect(steps, contains('nao transformes o movimento num supino'));
    });
  });
}
