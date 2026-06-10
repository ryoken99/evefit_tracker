import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/workout_taxonomy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.14 description templates', () {
    test('catalog has no v0.7.14 prohibited template strings', () {
      final offenders = <String>[];
      for (final entry in ExerciseCatalogContextService.entries) {
        final text = _normalized(
          '${entry.details.description} ${entry.details.executionSteps} '
          '${entry.details.commonMistakes} ${entry.details.safetyNotes}',
        );
        for (final phrase in _prohibitedTemplatePhrases) {
          if (text.contains(_normalized(phrase))) {
            offenders.add('${entry.id} ${entry.name}: $phrase');
          }
        }
      }

      expect(offenders, isEmpty, reason: offenders.take(20).join('\n'));
    });

    test('different catalog descriptions are not near-duplicates', () {
      final nearDuplicates = <String>[];
      final entries = ExerciseCatalogContextService.entries;

      for (var i = 0; i < entries.length; i++) {
        for (var j = i + 1; j < entries.length; j++) {
          final a = entries[i];
          final b = entries[j];
          if (a.catalogEntryKey == b.catalogEntryKey) continue;
          if (_normalized(a.name) == _normalized(b.name)) continue;

          final similarity = _orderedWordSimilarity(
            a.details.description,
            b.details.description,
          );
          if (similarity > 0.60) {
            nearDuplicates.add(
              '${a.id} ${a.name} / ${b.id} ${b.name}: '
              '${similarity.toStringAsFixed(2)}',
            );
          }
        }
      }

      expect(
        nearDuplicates,
        isEmpty,
        reason: nearDuplicates.take(30).join('\n'),
      );
    });

    test('farmer walk and static dumbbell hold teach different actions', () {
      final farmer = _entryByName('Farmer walk');
      final hold = _entryByName('Hold estatico com halteres');
      final farmerText = _normalized(
        '${farmer.details.description} ${farmer.details.executionSteps}',
      );
      final holdText = _normalized(
        '${hold.details.description} ${hold.details.executionSteps}',
      );

      expect(farmerText, contains('caminh'));
      expect(farmerText, contains('passos'));
      expect(holdText, contains('parado'));
      expect(holdText, contains('imovel'));
      expect(_orderedWordSimilarity(farmerText, holdText), lessThanOrEqualTo(0.60));
    });
  });

  group('v0.7.14 recursive complete hierarchy', () {
    test('arms complete exposes recursive child filters in the add modal', () {
      final labels = ExerciseFilterService.contextualFiltersForSelection(
        exercises: ExerciseCatalogContextService.entries
            .map((entry) => entry.toExercise())
            .toList(),
        trainingLocation: 'Ginasio',
        availableEquipmentKeys: {'dumbbells'},
        selection: const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'arms',
          subgroupKey: 'arms_complete',
          equipmentKey: 'dumbbells',
        ),
        showAll: false,
      ).map(_normalized).toSet();

      expect(labels, contains(_normalized('Todos')));
      expect(labels, contains(_normalized('Biceps')));
      expect(labels, contains(_normalized('Braquial')));
      expect(labels, contains(_normalized('Braquiorradial')));
      expect(labels, contains(_normalized('Triceps')));
      expect(labels, contains(_normalized('Flexores do antebraco')));
      expect(labels, contains(_normalized('Extensores do antebraco')));
      expect(labels, contains(_normalized('Punho')));
      expect(labels, contains(_normalized('Mao e dedos')));
      expect(labels, contains(_normalized('Forca de pega')));
      expect(labels, isNot(contains(_normalized('Peito'))));
      expect(labels, isNot(contains(_normalized('Pernas'))));
      expect(labels, isNot(contains(_normalized('Ombros'))));
    });

    test('arms complete with dumbbells aggregates all child branches only', () {
      final visible = _visibleFor(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'arms',
          subgroupKey: 'arms_complete',
          equipmentKey: 'dumbbells',
        ),
        equipment: {'dumbbells'},
      );
      final names = visible.map((exercise) => exercise.name).toSet();
      final normalizedNames = names.map(_normalized).toSet();
      final allTags = visible.map(TrainingArchitecture.tagsForExercise).toList();

      expect(names, contains('Curl com halteres'));
      expect(names, contains('Curl martelo'));
      expect(normalizedNames, contains(_normalized('Extensao francesa com halter')));
      expect(names, contains('Wrist curl'));
      expect(names, contains('Reverse wrist curl'));
      expect(normalizedNames, contains(_normalized('Pronacao com halter')));
      expect(normalizedNames, contains(_normalized('Supinacao com halter')));
      expect(names, contains('Desvio radial com halter'));
      expect(names, contains('Desvio ulnar com halter'));
      expect(names, contains('Farmer walk'));
      expect(normalizedNames, contains(_normalized('Hold estatico com halteres')));

      expect(
        allTags.any((tags) => tags.muscleKeys.contains('brachialis')),
        isTrue,
        reason: 'Braquial missing from arms complete.',
      );
      expect(
        allTags.any((tags) => tags.muscleKeys.contains('brachioradialis')),
        isTrue,
        reason: 'Braquiorradial missing from arms complete.',
      );
      expect(
        allTags.any((tags) => tags.muscleKeys.contains('grip_support')),
        isTrue,
        reason: 'Forca de pega missing from arms complete.',
      );

      expect(names.any((name) => _has(name, 'supino')), isFalse);
      expect(names.any((name) => _has(name, 'aberturas')), isFalse);
      expect(names.any((name) => _has(name, 'elevacao lateral')), isFalse);
      expect(names.any((name) => _has(name, 'agachamento')), isFalse);
    });

    test('legs complete aggregates lower subtree only', () {
      final names = _visibleFor(
        const TrainingSelection(
          regionKey: 'lower',
          groupKey: 'legs',
          subgroupKey: 'legs_complete',
        ),
      ).map((exercise) => exercise.name).toSet();

      expect(names.any((name) => _has(name, 'agachamento')), isTrue);
      expect(names.any((name) => _has(name, 'peso morto romeno')), isTrue);
      expect(names.any((name) => _has(name, 'ponte de gluteo')), isTrue);
      expect(names.any((name) => _has(name, 'aducao de anca')), isTrue);
      expect(names.any((name) => _has(name, 'abducao de anca')), isTrue);
      expect(names.any((name) => _has(name, 'gemeos')), isTrue);
      expect(names.any((name) => _has(name, 'soleo')), isTrue);
      expect(names.any((name) => _has(name, 'tibial')), isTrue);
      expect(names.any((name) => _has(name, 'curl com halteres')), isFalse);
      expect(names.any((name) => _has(name, 'supino')), isFalse);
    });

    test('back shoulders and core complete aggregate descendants only', () {
      final backNames = _visibleFor(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'back',
          subgroupKey: 'back_complete',
        ),
      ).map((exercise) => exercise.name).toSet();
      expect(backNames.any((name) => _has(name, 'puxada')), isTrue);
      expect(backNames.any((name) => _has(name, 'remo')), isTrue);
      expect(backNames.any((name) => _has(name, 'hiperextensao')), isTrue);
      expect(backNames.any((name) => _has(name, 'curl com halteres')), isFalse);
      expect(backNames.any((name) => _has(name, 'supino')), isFalse);

      final shoulderNames = _visibleFor(
        const TrainingSelection(
          regionKey: 'upper',
          groupKey: 'shoulders',
          subgroupKey: 'shoulders_complete',
        ),
      ).map((exercise) => exercise.name).toSet();
      expect(shoulderNames.any((name) => _has(name, 'press militar')), isTrue);
      expect(shoulderNames.any((name) => _has(name, 'elevacao lateral')), isTrue);
      expect(shoulderNames.any((name) => _has(name, 'reverse fly')), isTrue);
      expect(shoulderNames.any((name) => _has(name, 'rotacao externa')), isTrue);
      expect(shoulderNames.any((name) => _has(name, 'agachamento')), isFalse);

      final coreNames = _visibleFor(
        const TrainingSelection(
          regionKey: 'core',
          groupKey: 'core',
          subgroupKey: 'core_complete',
        ),
      ).map((exercise) => exercise.name).toSet();
      expect(coreNames.any((name) => _has(name, 'crunch')), isTrue);
      expect(coreNames.any((name) => _has(name, 'russian twist')), isTrue);
      expect(coreNames.any((name) => _has(name, 'vacuum')), isTrue);
      expect(coreNames.any((name) => _has(name, 'bird dog')), isTrue);
      expect(coreNames.any((name) => _has(name, 'extensao de triceps')), isFalse);
    });
  });
}

List<Exercise> _visibleFor(
  TrainingSelection selection, {
  Set<String> equipment = const {'bodyweight', 'dumbbells', 'barbell', 'bench'},
}) {
  final exercises = ExerciseCatalogContextService.entries
      .map((entry) => entry.toExercise())
      .toList();
  return ExerciseFilterService.getAvailableExercises(
    exercises: exercises,
    trainingLocation: 'Ginasio',
    availableEquipmentKeys: equipment,
    selection: selection,
    showAllExercises: false,
  ).map((item) => item.exercise).toList();
}

ExerciseCatalogEntry _entryByName(String normalizedName) {
  return ExerciseCatalogContextService.entries.firstWhere(
    (entry) => _normalized(entry.name) == _normalized(normalizedName),
  );
}

bool _has(String value, String needle) =>
    WorkoutTaxonomy.normalize(value).contains(WorkoutTaxonomy.normalize(needle));

String _normalized(String value) => WorkoutTaxonomy.normalize(value);

double _orderedWordSimilarity(String left, String right) {
  final a = _words(left);
  final b = _words(right);
  if (a.isEmpty || b.isEmpty) return 0;
  final previous = List<int>.filled(b.length + 1, 0);
  final current = List<int>.filled(b.length + 1, 0);
  var longestContiguousRun = 0;
  for (final aw in a) {
    for (var j = 0; j < b.length; j++) {
      current[j + 1] = aw == b[j] ? previous[j] + 1 : 0;
      if (current[j + 1] > longestContiguousRun) {
        longestContiguousRun = current[j + 1];
      }
    }
    for (var j = 0; j <= b.length; j++) {
      previous[j] = current[j];
      current[j] = 0;
    }
  }
  if (longestContiguousRun < 40) return 0;
  return longestContiguousRun / (a.length < b.length ? a.length : b.length);
}

List<String> _words(String value) => _normalized(value)
    .split(RegExp(r'[^a-z0-9]+'))
    .where((word) => word.length > 3)
    .toList();

const _prohibitedTemplatePhrases = [
  'e um exercicio ou drill para treinar',
  'serve para praticar mover a articulacao principal',
  'mover a articulacao principal de forma controlada no contexto',
  'com o equipamento indicado:',
  'usa esta amplitude: ate onde controlas a ida e o regresso',
  'conforme a articulacao principal',
  'inicia o movimento: mover a articulacao principal',
  'mantem punhos, cotovelos, joelhos ou anca alinhados com a direcao do exercicio, conforme',
  'desde que mantenhas controlo da zona alvo e pares antes de dor ou perda clara de coordenacao',
  'coloca-te numa base estavel para [nome do exercicio], com pes firmes e espaco livre a volta',
  'segura os halteres com a mao fechada, punhos alinhados e carga perto da linha do movimento',
  'organiza peito, costelas e bacia para a coluna ficar neutra, sem encolher os ombros para as orelhas',
  'inspira na fase de preparacao ou descida e expira na fase de maior esforco',
  'regressa devagar ao inicio, mantendo a carga ou o corpo sob controlo ate a repeticao terminar',
  'se fores iniciante, reduz carga, alcance ou inclinacao ate conseguires repetir sem dor e sem balanco',
  'descricao ainda incompleta',
  'sera melhorado numa proxima versao',
  'ajusta pes, maos e carga',
  'faz o movimento principal',
  'mantem boa postura',
  'executa com boa tecnica',
  'amplitude controlada',
  'movimento lento e previsivel',
];
