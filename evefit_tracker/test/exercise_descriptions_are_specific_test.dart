import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/services/exercise_catalog_detail_service.dart';
import 'package:evefit_tracker/services/workout_taxonomy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.7 full exercise description audit', () {
    test('audits every unique visible seed exercise', () {
      final catalog = _catalogEntries();
      final uniqueNames = catalog.map((entry) => entry.name).toSet();

      expect(catalog.length, greaterThanOrEqualTo(260));
      expect(uniqueNames.length, greaterThanOrEqualTo(260));

      for (final entry in catalog) {
        final detail = ExerciseCatalogDetailService.forExercise(
          name: entry.name,
          group: entry.group,
        );
        final combined = [
          detail.equipment,
          detail.secondaryGroups,
          detail.description,
          detail.executionSteps,
          detail.commonMistakes,
          detail.safetyNotes,
        ].join('\n');

        expect(entry.group.trim(), isNotEmpty, reason: entry.name);
        expect(detail.equipment.trim(), isNotEmpty, reason: entry.name);
        expect(detail.secondaryGroups.trim(), isNotEmpty, reason: entry.name);
        expect(
          detail.description.trim().length,
          greaterThanOrEqualTo(120),
          reason: entry.name,
        );
        expect(
          detail.executionSteps.trim().length,
          greaterThanOrEqualTo(220),
          reason: entry.name,
        );
        expect(
          detail.commonMistakes.trim().length,
          greaterThanOrEqualTo(80),
          reason: entry.name,
        );
        expect(
          detail.safetyNotes.trim().length,
          greaterThanOrEqualTo(90),
          reason: entry.name,
        );
        expect(
          _stepCount(detail.executionSteps),
          greaterThanOrEqualTo(5),
          reason: entry.name,
        );
        expect(_hasForbiddenText(combined), isFalse, reason: entry.name);

        final normalizedEquipment = WorkoutTaxonomy.normalize(detail.equipment);
        final normalizedSteps = WorkoutTaxonomy.normalize(
          '${detail.description} ${detail.executionSteps}',
        );
        if (normalizedEquipment.contains('halter')) {
          expect(normalizedSteps, contains('halter'), reason: entry.name);
          expect(
            normalizedSteps.contains('segura') ||
                normalizedSteps.contains('agarra') ||
                normalizedSteps.contains('pega'),
            isTrue,
            reason: entry.name,
          );
          expect(normalizedSteps, contains('punho'), reason: entry.name);
        }
        if (normalizedEquipment.contains('barra') &&
            !normalizedEquipment.contains('barra fixa')) {
          expect(
            normalizedSteps.contains('pega') ||
                normalizedSteps.contains('maos') ||
                normalizedSteps.contains('mãos'),
            isTrue,
            reason: entry.name,
          );
          expect(normalizedSteps, contains('barra'), reason: entry.name);
        }
        if (entry.group == 'Mobilidade') {
          expect(
            normalizedSteps.contains('segundos') ||
                normalizedSteps.contains('respira'),
            isTrue,
            reason: entry.name,
          );
        }
        if (_isStrength(entry.group)) {
          expect(normalizedSteps, contains('inspira'), reason: entry.name);
          expect(normalizedSteps, contains('expira'), reason: entry.name);
          expect(
            normalizedSteps.contains('amplitude') ||
                normalizedSteps.contains('desce') ||
                normalizedSteps.contains('sobe') ||
                normalizedSteps.contains('estende') ||
                normalizedSteps.contains('dobra'),
            isTrue,
            reason: entry.name,
          );
        }
      }
    });

    test('ambiguous exercises are split into equipment-specific variants', () {
      final names = _catalogEntries().map((entry) => entry.name).toSet();

      expect(names, isNot(contains('Aberturas inclinadas')));
      expect(names, contains('Aberturas inclinadas com halteres'));
      expect(names, contains('Aberturas inclinadas no cabo'));
      expect(names, contains('Aberturas inclinadas com elástico'));

      expect(names, isNot(contains('Supino declinado')));
      expect(names, contains('Supino declinado com halteres'));
      expect(names, contains('Supino declinado com barra'));
      expect(names, contains('Supino declinado na máquina'));

      expect(names, isNot(contains('Dips para peito')));
      expect(names, contains('Dips para peito em paralelas'));
      expect(names, contains('Dips assistidos para peito na máquina'));

      expect(names, isNot(contains('Extensão francesa')));
      expect(names, contains('Extensão francesa com halter'));
      expect(names, contains('Extensão francesa com barra EZ'));
      expect(names, contains('Extensão francesa no cabo'));
    });

    test('specific problem exercises have correct metadata and instructions', () {
      final full = _detail('Alongamento cervical leve', 'Mobilidade');
      final cervical = WorkoutTaxonomy.normalize(
        '${full.secondaryGroups} ${full.description} ${full.executionSteps} ${full.safetyNotes}',
      );
      expect(cervical, contains('15 a 30 segundos'));
      expect(cervical, contains('respira'));
      expect(cervical, contains('tontura'));
      expect(cervical, contains('formigueiro'));
      expect(cervical, contains('pressao na cabeca'));

      final curl = _detail('Curl com halteres', 'Bíceps');
      final curlText = WorkoutTaxonomy.normalize(curl.executionSteps);
      expect(curl.equipment, 'Halteres');
      expect(curlText, contains('cotovelos proximos do tronco'));
      expect(curlText, contains('punhos neutros'));
      expect(curlText, contains('inspira ao descer'));
      expect(curlText, contains('expira ao subir'));

      final french = _detail('Extensão francesa com halter', 'Tríceps');
      final frenchText = WorkoutTaxonomy.normalize(french.executionSteps);
      expect(french.equipment, 'Halteres');
      expect(frenchText, contains('cotovelos'));
      expect(frenchText, contains('atras da cabeca'));
      expect(frenchText, contains('lombar'));

      final dips = _detail('Dips para peito em paralelas', 'Peito');
      expect(dips.equipment, contains('Paralelas'));
      final dipsText = WorkoutTaxonomy.normalize(dips.executionSteps);
      expect(dipsText, contains('paralelas'));
      expect(dipsText, contains('tronco ligeiramente inclinado'));
      expect(dipsText, contains('ombros afastados das orelhas'));

      final incline = _detail('Aberturas inclinadas com halteres', 'Peito');
      expect(
        WorkoutTaxonomy.normalize(incline.equipment),
        contains('banco inclinado'),
      );
      expect(
        WorkoutTaxonomy.normalize(incline.executionSteps),
        contains('banco inclinado'),
      );
    });

    test('clearly equipped exercises never use bodyweight metadata', () {
      const equippedNameFragments = [
        'supino declinado',
        'aberturas inclinadas',
        'dips para peito',
        'extensao francesa',
        'elevacao lateral',
        'elevacao frontal',
        'elevacao posterior',
        'reverse fly',
        'curl alternado',
        'curl martelo',
        'curl concentrado',
        'curl inclinado',
        'curl inverso',
        'curl spider',
        'curl 21',
        'curl isometrico',
        'extensao de triceps acima da cabeca',
        'dips para triceps',
        'finger curls',
        'pallof press',
        'hiperextensao lombar',
        'step-up',
      ];

      for (final entry in _catalogEntries()) {
        final detail = ExerciseCatalogDetailService.forExercise(
          name: entry.name,
          group: entry.group,
        );
        final normalizedName = WorkoutTaxonomy.normalize(entry.name);
        final normalizedEquipment = WorkoutTaxonomy.normalize(detail.equipment);
        if (equippedNameFragments.any(normalizedName.contains)) {
          expect(
            normalizedEquipment,
            isNot(contains('peso corporal')),
            reason: entry.name,
          );
        }
      }
    });
  });
}

ExerciseCatalogDetails _detail(String name, String group) =>
    ExerciseCatalogDetailService.forExercise(name: name, group: group);

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

int _stepCount(String text) => RegExp(r'(^|\s)\d+\.').allMatches(text).length;

bool _hasForbiddenText(String text) {
  final normalized = WorkoutTaxonomy.normalize(text);
  const forbidden = [
    'descricao ainda incompleta',
    'sera melhorado numa proxima versao',
    'prepara a posicao inicial',
    'confirma que o equipamento esta estavel',
    'faz o movimento principal',
    'volta a posicao inicial com a mesma trajetoria',
    'ajusta pes, maos e carga',
    'executa com boa tecnica',
    'mantem boa postura',
    'amplitude controlada',
    'movimento lento e previsivel',
    'resistencia que muda a trajetoria',
    'foco definido pelo nome',
    'usar impulso, perder o alinhamento',
    'escolhe uma intensidade que consigas controlar',
  ];
  return forbidden.any(normalized.contains);
}

bool _isStrength(String group) =>
    !{'Cardio', 'Karate', 'Jiu-Jitsu', 'Mobilidade'}.contains(group);

class _CatalogEntry {
  const _CatalogEntry(this.name, this.group);
  final String name;
  final String group;
}
