import 'dart:math' as math;

class BodyDataService {
  const BodyDataService._();

  static double? calculateBmi({double? weightKg, double? heightCm}) {
    if (weightKg == null ||
        heightCm == null ||
        weightKg <= 0 ||
        heightCm <= 0) {
      return null;
    }
    final meters = heightCm / 100;
    return _round(weightKg / math.pow(meters, 2), decimals: 1);
  }

  static int? calculateAge({DateTime? birthDate, DateTime? today}) {
    if (birthDate == null) return null;
    final now = today ?? DateTime.now();
    var age = now.year - birthDate.year;
    final birthdayPassed =
        now.month > birthDate.month ||
        (now.month == birthDate.month && now.day >= birthDate.day);
    if (!birthdayPassed) age -= 1;
    return age < 0 ? null : age;
  }

  static double? waistToHipRatio({double? waistCm, double? hipsCm}) {
    if (waistCm == null || hipsCm == null || waistCm <= 0 || hipsCm <= 0) {
      return null;
    }
    return _round(waistCm / hipsCm, decimals: 2);
  }

  static double? waistToHeightRatio({double? waistCm, double? heightCm}) {
    if (waistCm == null || heightCm == null || waistCm <= 0 || heightCm <= 0) {
      return null;
    }
    return _round(waistCm / heightCm, decimals: 2);
  }

  static double _round(double value, {required int decimals}) {
    final factor = math.pow(10, decimals).toDouble();
    return (value * factor).round() / factor;
  }
}
