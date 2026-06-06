class GoalProgressService {
  const GoalProgressService._();

  static double calculateProgress({
    required double? initialValue,
    required double? currentValue,
    required double? targetValue,
    double? manualProgress,
  }) {
    if (manualProgress != null) {
      return manualProgress.clamp(0, 1);
    }
    if (initialValue == null || currentValue == null || targetValue == null) {
      return 0;
    }
    final total = targetValue - initialValue;
    if (total == 0) {
      return currentValue == targetValue ? 1 : 0;
    }
    final progress = (currentValue - initialValue) / total;
    return progress.clamp(0, 1);
  }
}
