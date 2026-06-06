import 'package:evefit_tracker/models/body_measurement.dart';
import 'package:evefit_tracker/services/dashboard_stats_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('flexed arm value uses the average when both biceps exist', () {
    final measurement = BodyMeasurement(
      date: DateTime(2026, 6, 6),
      leftBicepFlexedCm: 31,
      rightBicepFlexedCm: 33,
    );

    expect(DashboardStatsService.flexedArmCm(measurement), 32);
  });

  test('flexed arm value falls back to the available side', () {
    final measurement = BodyMeasurement(
      date: DateTime(2026, 6, 6),
      rightBicepFlexedCm: 34,
    );

    expect(DashboardStatsService.flexedArmCm(measurement), 34);
  });
}
