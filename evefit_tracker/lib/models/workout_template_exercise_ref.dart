class WorkoutTemplateExerciseRef {
  const WorkoutTemplateExerciseRef({
    this.catalogEntryKey = '',
    this.exerciseKey = '',
    this.contextKey = '',
    required this.legacyName,
  });

  final String catalogEntryKey;
  final String exerciseKey;
  final String contextKey;
  final String legacyName;
}
