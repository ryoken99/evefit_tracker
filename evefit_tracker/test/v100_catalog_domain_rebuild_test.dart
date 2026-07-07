import 'package:evefit_tracker/services/equipment_catalog_service.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_taxonomy_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v1.0.0 catalog domain rebuild', () {
    final entries = ExerciseCatalogContextService.entries;
    final exercises = entries
        .map(ExerciseTaxonomyService.enrichCatalogExercise)
        .toList();

    test('every catalog entry keeps canonical and contextual identity', () {
      expect(entries, isNotEmpty);
      final catalogEntryKeys = <String>{};
      for (final exercise in exercises) {
        expect(exercise.canonicalId, isNotEmpty, reason: exercise.name);
        expect(exercise.catalogEntryKey, isNotEmpty, reason: exercise.name);
        expect(exercise.primaryType, isNotEmpty, reason: exercise.name);
        expect(exercise.contextKey, isNotEmpty, reason: exercise.name);
        expect(
          catalogEntryKeys.add(exercise.catalogEntryKey),
          isTrue,
          reason: 'duplicate catalog_entry_key: ${exercise.catalogEntryKey}',
        );
      }
    });

    test('domain contexts from files 10 to 23 are represented explicitly', () {
      final contexts = entries.map((entry) => entry.contextKey).toSet();

      expect(
        contexts,
        containsAll({
          'cardio',
          'karate',
          'jiu_jitsu',
          'boxe',
          'kickboxing',
          'muay_thai',
          'judo',
          'taekwondo',
          'defesa_pessoal',
          'mobilidade',
          'elasticidade',
          'recuperacao',
          'aquecimento',
          'ativacao',
          'prevencao',
        }),
      );
    });

    test(
      'martial arts catalog includes required modalities beyond Karate and BJJ',
      () {
        final martialContexts = exercises
            .where((exercise) => exercise.primaryType == 'artes_marciais')
            .map((exercise) => exercise.contextKey)
            .toSet();

        expect(
          martialContexts,
          containsAll({
            'karate',
            'jiu_jitsu',
            'boxe',
            'kickboxing',
            'muay_thai',
            'judo',
            'taekwondo',
            'defesa_pessoal',
          }),
        );
      },
    );

    test(
      'mobility, elasticity and recovery are not mixed as the same domain',
      () {
        final byType = <String, List<String>>{};
        for (final exercise in exercises) {
          byType.putIfAbsent(exercise.primaryType, () => []).add(exercise.name);
        }

        expect(byType['mobilidade'], isNotNull);
        expect(byType['elasticidade'], isNotNull);
        expect(byType['recuperacao'], isNotNull);
        expect(byType['mobilidade'], isNot(isEmpty));
        expect(byType['elasticidade'], isNot(isEmpty));
        expect(byType['recuperacao'], isNot(isEmpty));

        final recoveryNames = byType['recuperacao']!.join(' ').toLowerCase();
        expect(recoveryNames, isNot(contains('hiit')));
        expect(recoveryNames, isNot(contains('sprint')));
      },
    );

    test(
      'all enriched catalog entries have valid canonical equipment keys',
      () {
        final validEquipmentKeys = EquipmentCatalogService.definitions.keys
            .toSet();
        for (final exercise in exercises) {
          expect(exercise.equipmentKeys, isNotEmpty, reason: exercise.name);
          for (final key in exercise.equipmentKeys) {
            expect(
              validEquipmentKeys,
              contains(key),
              reason: '${exercise.name} has invalid equipment key $key',
            );
          }
        }
      },
    );

    test('technical stand-up keeps one canonical exercise across contexts', () {
      final standUps = exercises
          .where(
            (exercise) => exercise.canonicalId == 'technical_stand_up_lento',
          )
          .toList();

      expect(standUps.length, greaterThanOrEqualTo(3));
      expect(
        standUps.map((exercise) => exercise.contextKey).toSet(),
        containsAll({'jiu_jitsu', 'mobilidade', 'defesa_pessoal'}),
      );
    });
  });
}
