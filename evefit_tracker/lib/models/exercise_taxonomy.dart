class ExerciseTaxonomy {
  const ExerciseTaxonomy({
    required this.regionKeys,
    required this.groupKeys,
    required this.subgroupKeys,
    required this.primaryMuscleKey,
    required this.secondaryMuscleKeys,
    required this.equipmentKeys,
    required this.movementPattern,
    required this.difficulty,
    this.forceType = '',
    this.laterality = '',
    this.goalTags = const {},
  });

  final Set<String> regionKeys;
  final Set<String> groupKeys;
  final Set<String> subgroupKeys;
  final String primaryMuscleKey;
  final Set<String> secondaryMuscleKeys;
  final Set<String> equipmentKeys;
  final String movementPattern;
  final String difficulty;
  final String forceType;
  final String laterality;
  final Set<String> goalTags;

  Set<String> get allMuscleKeys => {
    if (primaryMuscleKey.isNotEmpty) primaryMuscleKey,
    ...secondaryMuscleKeys,
  };

  static Set<String> parseKeys(Object? value) {
    if (value is! String || value.trim().isEmpty) return <String>{};
    return value
        .split(',')
        .map((key) => key.trim())
        .where((key) => key.isNotEmpty)
        .toSet();
  }

  static String serializeKeys(Iterable<String> values) {
    final keys =
        values
            .map((key) => key.trim())
            .where((key) => key.isNotEmpty)
            .toSet()
            .toList()
          ..sort();
    return keys.join(',');
  }
}
