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

  static double calculateFrequencyProgress({
    required int completed,
    required int target,
  }) {
    if (target <= 0) return 0;
    return (completed / target).clamp(0, 1);
  }

  static double calculateManualPercent(double? percent) {
    if (percent == null) return 0;
    return (percent / 100).clamp(0, 1);
  }
}
