import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.11 catalog context source of truth', () {
    test('preserves 305 catalog entries and 294 unique exercise names', () {
      final entries = ExerciseCatalogContextService.entries;
      final uniqueNames = entries.map((entry) => entry.name).toSet();

      expect(entries, hasLength(305));
      expect(uniqueNames, hasLength(294));
      expect(
        entries.map((entry) => entry.catalogEntryKey).toSet(),
        hasLength(305),
      );
    });

    test('duplicate visible names keep explicit context keys', () {
      final duplicates = ExerciseCatalogContextService.duplicateContextsByName;

      expect(
        duplicates['Face pull no cabo'],
        containsAll(['Trapézio', 'Ombros', 'Costas']),
      );
      expect(
        duplicates['Pullover com halter'],
        containsAll(['Peito', 'Costas']),
      );
      expect(
        duplicates['Good morning sem carga'],
        containsAll(['Costas', 'Pernas']),
      );
      expect(
        duplicates['Curl inverso'],
        containsAll(['Bíceps', 'Antebraço/Pega']),
      );
      expect(
        duplicates['Drills de guarda'],
        containsAll(['Karate', 'Jiu-Jitsu']),
      );
    });

    test('exercise model carries stable catalog identity fields', () {
      final entry = ExerciseCatalogContextService.entryFor(
        name: 'Face pull no cabo',
        group: 'Ombros',
      );
      final exercise = entry.toExercise(id: 10);

      expect(exercise.id, 10);
      expect(exercise.name, 'Face pull no cabo');
      expect(exercise.muscleGroup, 'Ombros');
      expect(exercise.exerciseKey, 'face_pull_no_cabo');
      expect(exercise.contextKey, 'ombros');
      expect(exercise.catalogEntryKey, 'face_pull_no_cabo__ombros');
    });
  });
}
