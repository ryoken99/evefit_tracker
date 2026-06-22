class ProfileDisplayService {
  const ProfileDisplayService._();

  static String heightLabel(double? heightCm) {
    if (heightCm == null || heightCm <= 0) return 'altura por definir';
    return '${heightCm.toStringAsFixed(0)} cm';
  }
}
