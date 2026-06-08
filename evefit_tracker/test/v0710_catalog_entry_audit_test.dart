import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_catalog_detail_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/workout_taxonomy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.10 catalog entry audit', () {
    test('audits all 305 seed entries instead of unique names only', () {
      final entries = _catalogEntries();
      final uniqueNames = entries.map((entry) => entry.name).toSet();

      expect(entries.length, 305);
      expect(uniqueNames.length, 294);

      for (final entry in entries) {
        final detail = entry.detail;
        final tags = entry.tags;

        expect(entry.group.trim(), isNotEmpty, reason: entry.id);
        expect(detail.equipment.trim(), isNotEmpty, reason: entry.id);
        expect(detail.secondaryGroups.trim(), isNotEmpty, reason: entry.id);
        expect(detail.description.trim(), isNotEmpty, reason: entry.id);
        expect(detail.executionSteps.trim(), isNotEmpty, reason: entry.id);
        expect(detail.commonMistakes.trim(), isNotEmpty, reason: entry.id);
        expect(detail.safetyNotes.trim(), isNotEmpty, reason: entry.id);
        expect(tags.regionKeys, isNotEmpty, reason: entry.id);
        expect(tags.groupKeys, isNotEmpty, reason: entry.id);
        expect(tags.equipmentKeys, isNotEmpty, reason: entry.id);
        expect(
          _stepCount(detail.executionSteps),
          greaterThanOrEqualTo(5),
          reason: entry.id,
        );
      }
    });

    test('existing names that require equipment are not ambiguous', () {
      final names = _catalogEntries().map((entry) => entry.name).toSet();

      expect(names, isNot(contains('Press militar')));
      expect(names, isNot(contains('Supino inclinado')));
      expect(names, isNot(contains('Remo baixo')));
      expect(names, isNot(contains('Pallof press')));
    });

    test(
      'equipment metadata matches equipment stated in the exercise name',
      () {
        for (final entry in _catalogEntries()) {
          final name = _n(entry.name);
          final equipment = _n(entry.detail.equipment);

          if (name.contains('com halter') || name.contains('com halteres')) {
            expect(equipment, contains('halter'), reason: entry.id);
          }
          if (name.contains('com barra') || name.contains('barra ez')) {
            expect(equipment, contains('barra'), reason: entry.id);
          }
          if (name.contains('no cabo') || name.contains('cabo')) {
            expect(
              equipment.contains('cabo') || equipment.contains('polia'),
              isTrue,
              reason: entry.id,
            );
          }
          if (name.contains('com elastico') || name.contains('elastico')) {
            expect(equipment, contains('elastico'), reason: entry.id);
          }
          if (name.contains('em paralelas')) {
            expect(equipment, contains('paralelas'), reason: entry.id);
          }
          if (name.contains('na maquina') || name.contains('assistidos')) {
            expect(
              equipment.contains('maquina') || equipment.contains('assistida'),
              isTrue,
              reason: entry.id,
            );
          }
        }
      },
    );

    test('bodyweight is not assigned to equipment-dependent entries', () {
      final equipmentDependent = [
        'supino',
        'aberturas',
        'dips',
        'puxada',
        'remo sentado',
        'remo baixo',
        'leg press',
        'chest press',
        'crossover',
        'curl no cabo',
        'triceps no cabo',
        'face pull no cabo',
      ];

      for (final entry in _catalogEntries()) {
        final name = _n(entry.name);
        final equipment = _n(entry.detail.equipment);
        if (equipmentDependent.any(name.contains)) {
          expect(equipment, isNot(contains('peso corporal')), reason: entry.id);
        }
      }
    });

    test('teaching text avoids prohibited generic phrases for every entry', () {
      for (final entry in _catalogEntries()) {
        final text = _n(
          [
            entry.detail.description,
            entry.detail.executionSteps,
            entry.detail.commonMistakes,
            entry.detail.safetyNotes,
          ].join('\n'),
        );

        for (final phrase in _forbiddenPhrases) {
          expect(
            text,
            isNot(contains(_n(phrase))),
            reason: '${entry.id} $phrase',
          );
        }
      }
    });

    test('equipment based exercises explain grip or equipment position', () {
      for (final entry in _catalogEntries()) {
        final equipment = _n(entry.detail.equipment);
        final text = _n(
          '${entry.detail.description} ${entry.detail.executionSteps}',
        );

        if (equipment.contains('halter')) {
          expect(text, contains('halter'), reason: entry.id);
          expect(
            text.contains('segura') ||
                text.contains('agarra') ||
                text.contains('controla'),
            isTrue,
            reason: entry.id,
          );
          expect(text, contains('punho'), reason: entry.id);
        }
        if (equipment.contains('barra') && !equipment.contains('barra fixa')) {
          expect(text, contains('barra'), reason: entry.id);
          expect(
            text.contains('pega') ||
                text.contains('maos') ||
                text.contains('mãos') ||
                text.contains('posicao da barra'),
            isTrue,
            reason: entry.id,
          );
        }
        if (equipment.contains('cabo') || equipment.contains('polia')) {
          expect(
            text.contains('polia') ||
                text.contains('cabo') ||
                text.contains('pega'),
            isTrue,
            reason: entry.id,
          );
        }
        if (entry.group == 'Mobilidade') {
          expect(
            text.contains('segundos') || text.contains('respira'),
            isTrue,
            reason: entry.id,
          );
        }
      }
    });
  });
}

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

List<_Entry> _catalogEntries() {
  final entries = <_Entry>[];
  var id = 1;
  for (final groupEntry in SeedData.exercisesByGroup.entries) {
    for (final name in groupEntry.value) {
      final detail = ExerciseCatalogDetailService.forExercise(
        name: name,
        group: groupEntry.key,
      );
      final exercise = Exercise(
        name: name,
        muscleGroup: groupEntry.key,
        secondaryMuscleGroups: detail.secondaryGroups,
        equipment: detail.equipment,
        description: detail.description,
        executionSteps: detail.executionSteps,
        commonMistakes: detail.commonMistakes,
        safetyNotes: detail.safetyNotes,
        isDefault: true,
      );
      entries.add(
        _Entry(
          id: 'E${id.toString().padLeft(3, '0')} ${groupEntry.key} / $name',
          name: name,
          group: groupEntry.key,
          detail: detail,
          tags: TrainingArchitecture.tagsForExercise(exercise),
        ),
      );
      id++;
    }
  }
  return entries;
}

int _stepCount(String value) => RegExp(r'\d+\.').allMatches(value).length;

String _n(String value) => WorkoutTaxonomy.normalize(value);

class _Entry {
  const _Entry({
    required this.id,
    required this.name,
    required this.group,
    required this.detail,
    required this.tags,
  });

  final String id;
  final String name;
  final String group;
  final ExerciseCatalogDetails detail;
  final ExerciseArchitectureTags tags;
}
