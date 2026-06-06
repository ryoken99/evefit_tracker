import 'package:evefit_tracker/models/body_measurement.dart';
import 'package:evefit_tracker/services/dashboard_metric_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns configured metric value from latest measurement', () {
    final measurement = BodyMeasurement(
      date: DateTime(2026, 6, 6),
      weightKg: 55.5,
      bodyFatPercentage: 13.2,
      rightBicepFlexedCm: 32,
    );

    expect(DashboardMetricService.valueFor('weight', measurement), '55.5 kg');
    expect(DashboardMetricService.valueFor('body_fat', measurement), '13.2 %');
    expect(
      DashboardMetricService.valueFor('avg_biceps_flexed', measurement),
      '32.0 cm',
    );
  });
}
