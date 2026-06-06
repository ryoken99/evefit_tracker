import 'package:evefit_tracker/models/body_measurement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('BodyMeasurement maps to and from SQLite rows', () {
    final measurement = BodyMeasurement(
      id: 7,
      date: DateTime(2026, 6, 6),
      weightKg: 55.2,
      leftBicepFlexedCm: 31.5,
      rightBicepFlexedCm: 32.5,
      shouldersCm: 41,
      sideHipAreaCm: 78,
      notes: 'Teste',
    );

    final restored = BodyMeasurement.fromMap(measurement.toMap());

    expect(restored.id, 7);
    expect(restored.weightKg, 55.2);
    expect(restored.rightBicepFlexedCm, 32.5);
    expect(restored.notes, 'Teste');
  });
}
