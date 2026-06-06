import '../models/body_measurement.dart';

class DashboardStatsService {
  static double? flexedArmCm(BodyMeasurement measurement) {
    final left = measurement.leftBicepFlexedCm;
    final right = measurement.rightBicepFlexedCm;
    if (left != null && right != null) {
      return (left + right) / 2;
    }
    return right ?? left;
  }
}
