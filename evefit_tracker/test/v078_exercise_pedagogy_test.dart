import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/services/exercise_catalog_detail_service.dart';
import 'package:evefit_tracker/services/workout_taxonomy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.8 exercise pedagogy', () {
    test('catalog details do not use prohibited generic patterns', () {
      for (final entry in _catalogEntries()) {
        final detail = ExerciseCatalogDetailService.forExercise(
          name: entry.name,
          group: entry.group,
        );
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

    test(
      'supino com barra teaches bench setup bar path breathing and safety',
      () {
        final detail = _detail('Supino com barra', 'Peito');
        final text = _normalized(detail);

        expect(text, contains('banco'));
        expect(text, contains('olhos'));
        expect(text, contains('pes no chao'));
        expect(text, contains('omoplatas'));
        expect(text, contains('peito'));
        expect(text, contains('pega'));
        expect(text, contains('punhos'));
        expect(text, contains('suporte'));
        expect(text, contains('desce'));
        expect(text, contains('zona media'));
        expect(text, contains('cotovelos'));
        expect(text, contains('inspira'));
        expect(text, contains('expira'));
        expect(text, contains('ajuda'));
      },
    );

    test('treadmill warm-up and cooldown teach different goals', () {
      final warmup = _detail('Passadeira aquecimento', 'Cardio');
      final cooldown = _detail('Passadeira cooldown', 'Cardio');
      final warmupText = _normalized(warmup);
      final cooldownText = _normalized(cooldown);

      expect(warmupText, contains('5 a 10 minutos'));
      expect(warmupText, contains('aumenta gradualmente'));
      expect(warmupText, contains('temperatura corporal'));
      expect(warmupText, contains('nao comeces intenso'));

      expect(cooldownText, contains('3 a 8 minutos'));
      expect(cooldownText, contains('reduz'));
      expect(cooldownText, contains('nao pares de repente'));
      expect(cooldownText, contains('respiracao acalmar'));
      expect(cooldownText, isNot(contains('ignorar aquecimento')));
      expect(warmup.executionSteps, isNot(equals(cooldown.executionSteps)));
    });

    test(
      'neutral grip lat pulldown teaches machine setup and controlled pull',
      () {
        final detail = _detail('Puxada alta pega neutra', 'Costas');
        final text = _normalized(detail);

        expect(text, contains('apoio das coxas'));
        expect(text, contains('pega neutra'));
        expect(text, contains('palmas viradas uma para a outra'));
        expect(text, contains('peito'));
        expect(text, contains('ombros afastados das orelhas'));
        expect(text, contains('parte alta do peito'));
        expect(text, contains('nao puxes atras da nuca'));
        expect(text, contains('controla a subida'));
        expect(text, contains('nao balances'));
      },
    );

    test(
      'exercise families include teaching details required by equipment/type',
      () {
        for (final entry in _catalogEntries()) {
          final detail = ExerciseCatalogDetailService.forExercise(
            name: entry.name,
            group: entry.group,
          );
          final text = WorkoutTaxonomy.normalize(
            '${detail.description} ${detail.executionSteps}',
          );
          final equipment = WorkoutTaxonomy.normalize(detail.equipment);

          if (equipment.contains('barra') &&
              !equipment.contains('barra fixa') &&
              entry.group != 'Cardio') {
            expect(
              text.contains('pega') || text.contains('posicao da barra'),
              isTrue,
              reason: entry.name,
            );
          }
          if (equipment.contains('halter')) {
            expect(text, contains('halter'), reason: entry.name);
            expect(
              text.contains('segura') || text.contains('controla'),
              isTrue,
              reason: entry.name,
            );
          }
          if (equipment.contains('cabo') ||
              equipment.contains('polia') ||
              equipment.contains('maquina')) {
            expect(
              text.contains('polia') ||
                  text.contains('pega') ||
                  text.contains('ajusta'),
              isTrue,
              reason: entry.name,
            );
          }
          if (entry.group == 'Mobilidade') {
            expect(text, contains('15 a 30 segundos'), reason: entry.name);
            expect(text, contains('respira'), reason: entry.name);
          }
          if (_isStrength(entry.group)) {
            expect(text, contains('inspira'), reason: entry.name);
            expect(text, contains('expira'), reason: entry.name);
            expect(
              text.contains('amplitude') ||
                  text.contains('desce') ||
                  text.contains('sobe') ||
                  text.contains('dobra') ||
                  text.contains('estende'),
              isTrue,
              reason: entry.name,
            );
          }
          if (entry.group == 'Cardio') {
            expect(text, contains('intensidade'), reason: entry.name);
            expect(
              text.contains('minutos') || text.contains('segundos'),
              isTrue,
              reason: entry.name,
            );
          }
          if (entry.group == 'Karate' || entry.group == 'Jiu-Jitsu') {
            expect(
              text.contains('base') || text.contains('objetivo tecnico'),
              isTrue,
              reason: entry.name,
            );
          }
        }
      },
    );
  });
}

const _forbiddenPatterns = [
  'Ajusta pés, mãos e carga',
  'Faz o movimento principal',
  'Volta à posição inicial com a mesma trajetória',
  'Começa leve, progride gradualmente',
  'Interrompe o exercício se surgir dor aguda, tontura ou perda de controlo técnico',
  'Movimento lento e previsível',
  'Amplitude controlada',
  'Usar pressa',
  'Compensar com outra zona do corpo',
  'Resistência que muda a trajetória',
  'Mantém boa postura',
  'Executa com boa técnica',
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

bool _isStrength(String group) =>
    !{'Cardio', 'Karate', 'Jiu-Jitsu', 'Mobilidade'}.contains(group);

class _CatalogEntry {
  const _CatalogEntry(this.name, this.group);

  final String name;
  final String group;
}
