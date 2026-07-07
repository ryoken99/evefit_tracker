// ignore_for_file: avoid_print

import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/models/exercise.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';

void main() {
  final before = SeedData.exercisesByGroup.values.fold<int>(
    0,
    (sum, names) => sum + names.length,
  );
  final entries = ExerciseCatalogContextService.entries;
  final exercises = entries.map((entry) => entry.toExercise()).toList();
  final uniqueCanonicalIds = exercises.map((item) => item.canonicalId).toSet();
  final domains = _countBy(exercises, (item) => item.primaryType);
  final aliasPairs = _aliasPairs(exercises);
  final incomplete = exercises
      .where((item) => !_isComplete(item))
      .map((item) => '${item.canonicalId} / ${item.catalogEntryKey}')
      .toList();

  print('# EveFit catalog audit report');
  print('');
  print('## Catalog counts');
  print('- before_seed_entries: $before');
  print('- after_catalog_entries: ${entries.length}');
  print('- unique_canonical_ids: ${uniqueCanonicalIds.length}');
  print(
    '- context_entries_sharing_canonical_id: '
    '${entries.length - uniqueCanonicalIds.length}',
  );
  print('- alias_pairs: ${aliasPairs.length}');
  print('');
  print('## Domains');
  for (final key in _domainOrder) {
    print('- $key: ${domains[key] ?? 0}');
  }
  final otherDomains = domains.keys.where((key) => !_domainOrder.contains(key));
  for (final key in otherDomains) {
    print('- $key: ${domains[key] ?? 0}');
  }
  print('');
  print('## Description completeness');
  print('- total_exercises: ${exercises.length}');
  print(
    '- short_description_present: '
    '${_count(exercises, (item) => item.description.trim().isNotEmpty)}',
  );
  print(
    '- long_description_130_chars: '
    '${_count(exercises, (item) => item.description.trim().length >= 130)}',
  );
  print(
    '- execution_step_by_step: '
    '${_count(exercises, (item) => _stepCount(item.executionSteps) >= 4)}',
  );
  print(
    '- breathing: '
    '${_count(exercises, (item) => item.breathingTips.trim().isNotEmpty)}',
  );
  print(
    '- common_mistakes: '
    '${_count(exercises, (item) => item.commonMistakes.trim().isNotEmpty)}',
  );
  print(
    '- corrections_posture_tips: '
    '${_count(exercises, (item) => item.postureTips.trim().isNotEmpty)}',
  );
  print(
    '- safety_care: '
    '${_count(exercises, (item) => item.safetyNotes.trim().isNotEmpty)}',
  );
  print(
    '- regression: '
    '${_count(exercises, (item) => item.regression.trim().isNotEmpty)}',
  );
  print(
    '- progression: '
    '${_count(exercises, (item) => item.progression.trim().isNotEmpty)}',
  );
  print(
    '- when_to_use_textual: '
    '${_count(exercises, (item) => item.description.contains('Serve para'))}',
  );
  print(
    '- when_to_avoid_textual: '
    '${_count(exercises, (item) => item.adaptationNotes.trim().isNotEmpty)}',
  );
  print('- incomplete_exercises: ${incomplete.length}');
  for (final item in incomplete.take(50)) {
    print('  - $item');
  }
  print('');
  print('## Ten canonical examples');
  for (final canonicalId in _canonicalExamples(exercises)) {
    final group = exercises
        .where((item) => item.canonicalId == canonicalId)
        .toList();
    if (group.isEmpty) continue;
    final first = group.first;
    print('- canonical_id: ${first.canonicalId}');
    print('  name: ${first.name}');
    print('  primary_type: ${first.primaryType}');
    print('  secondary_types: ${_join(first.secondaryTypes)}');
    print('  contexts: ${_join(group.map((item) => item.contextKey).toSet())}');
    print('  equipment: ${_join(group.map((item) => item.equipment).toSet())}');
    print('  locations: ${_locationsFor(group)}');
    print('  aliases: ${_join(first.aliases)}');
  }
  print('');
  print('## Five beginner-ready examples');
  for (final item in _beginnerExamples(exercises)) {
    print('- ${item.canonicalId} / ${item.name}');
    print('  description: ${item.description}');
    print('  execution: ${item.executionSteps}');
    print('  breathing: ${item.breathingTips}');
    print('  mistakes: ${item.commonMistakes}');
    print('  safety: ${item.safetyNotes}');
    print('  regression: ${item.regression}');
    print('  progression: ${item.progression}');
    print('  when_avoid: ${item.adaptationNotes}');
  }
  print('');
  print('## Alias map samples');
  for (final pair in aliasPairs.take(80)) {
    print(
      '- ${pair.alias} -> ${pair.canonicalId}'
      ' (${pair.catalogEntryKey})',
    );
  }
}

const _domainOrder = <String>[
  'musculacao',
  'cardio',
  'artes_marciais',
  'mobilidade',
  'elasticidade',
  'recuperacao',
  'aquecimento',
  'ativacao',
  'prevencao',
];

const _exampleCanonicalIds = <String>[
  'push_up',
  'glute_bridge',
  'technical_stand_up_lento',
  'agachamento_livre',
  'supino_reto_com_barra',
  'caminhada_na_passadeira',
  'corrida_leve',
  'mobilidade_de_anca_90_90',
  'respiracao_diafragmatica',
  'prancha_frontal',
];

Map<String, int> _countBy(
  Iterable<Exercise> exercises,
  String Function(Exercise exercise) keyOf,
) {
  final result = <String, int>{};
  for (final exercise in exercises) {
    final key = keyOf(exercise).trim();
    result[key] = (result[key] ?? 0) + 1;
  }
  return result;
}

int _count(Iterable<Exercise> exercises, bool Function(Exercise item) test) =>
    exercises.where(test).length;

bool _isComplete(Exercise item) =>
    item.description.trim().isNotEmpty &&
    item.executionSteps.trim().isNotEmpty &&
    item.commonMistakes.trim().isNotEmpty &&
    item.safetyNotes.trim().isNotEmpty &&
    item.regression.trim().isNotEmpty &&
    item.progression.trim().isNotEmpty &&
    item.breathingTips.trim().isNotEmpty &&
    item.postureTips.trim().isNotEmpty &&
    item.adaptationNotes.trim().isNotEmpty;

int _stepCount(String value) => RegExp(r'\d+\.').allMatches(value).length;

List<_AliasPair> _aliasPairs(List<Exercise> exercises) {
  final seen = <String>{};
  final result = <_AliasPair>[];
  for (final exercise in exercises) {
    for (final alias in exercise.aliases) {
      if (alias == exercise.canonicalId) continue;
      final key = '${exercise.canonicalId}|$alias|${exercise.catalogEntryKey}';
      if (!seen.add(key)) continue;
      result.add(
        _AliasPair(
          alias: alias,
          canonicalId: exercise.canonicalId,
          catalogEntryKey: exercise.catalogEntryKey,
        ),
      );
    }
  }
  result.sort((a, b) {
    final byCanonical = a.canonicalId.compareTo(b.canonicalId);
    if (byCanonical != 0) return byCanonical;
    return a.alias.compareTo(b.alias);
  });
  return result;
}

List<String> _canonicalExamples(List<Exercise> exercises) {
  final available = exercises.map((item) => item.canonicalId).toSet();
  final result = <String>[];
  for (final canonicalId in _exampleCanonicalIds) {
    if (available.contains(canonicalId)) result.add(canonicalId);
  }
  for (final domain in _domainOrder) {
    final match = exercises.firstWhere(
      (item) =>
          item.primaryType == domain && !result.contains(item.canonicalId),
      orElse: () => exercises.first,
    );
    if (!result.contains(match.canonicalId)) result.add(match.canonicalId);
    if (result.length >= 10) return result.take(10).toList();
  }
  for (final item in exercises) {
    if (!result.contains(item.canonicalId)) result.add(item.canonicalId);
    if (result.length >= 10) break;
  }
  return result.take(10).toList();
}

String _join(Iterable<String> values) {
  final cleaned = values.where((value) => value.trim().isNotEmpty).toSet();
  if (cleaned.isEmpty) return '-';
  final sorted = cleaned.toList()..sort();
  return sorted.join(', ');
}

String _locationsFor(List<Exercise> group) {
  final contexts = group.map((item) => item.contextKey).toSet();
  if (contexts.any((item) => _martialContexts.contains(item))) {
    return 'Dojo/Tatami';
  }
  if (contexts.contains('cardio')) return 'Casa/Ginasio/Exterior';
  if (contexts.any(_preparationContexts.contains)) {
    return 'Casa/Ginasio/Clinica/Trabalho';
  }
  return 'Casa/Ginasio';
}

List<Exercise> _beginnerExamples(List<Exercise> exercises) {
  final result = <Exercise>[];
  for (final canonicalId in [
    'push_up',
    'glute_bridge',
    'technical_stand_up_lento',
    'caminhada_na_passadeira',
    'mobilidade_de_anca_90_90',
  ]) {
    final match = exercises
        .where((item) => item.canonicalId == canonicalId && _isComplete(item))
        .toList();
    if (match.isNotEmpty) result.add(match.first);
  }
  if (result.length >= 5) return result.take(5).toList();
  result.addAll(exercises.where(_isComplete).take(5 - result.length));
  return result.take(5).toList();
}

const _martialContexts = <String>{
  'karate',
  'jiu_jitsu',
  'boxe',
  'kickboxing',
  'muay_thai',
  'judo',
  'taekwondo',
  'defesa_pessoal',
  'artes_marciais',
};

const _preparationContexts = <String>{
  'mobilidade',
  'elasticidade',
  'recuperacao',
  'aquecimento',
  'ativacao',
  'prevencao',
};

class _AliasPair {
  const _AliasPair({
    required this.alias,
    required this.canonicalId,
    required this.catalogEntryKey,
  });

  final String alias;
  final String canonicalId;
  final String catalogEntryKey;
}
