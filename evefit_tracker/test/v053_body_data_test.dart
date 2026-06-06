import 'package:evefit_tracker/models/body_measurement.dart';
import 'package:evefit_tracker/services/body_data_service.dart';
import 'package:evefit_tracker/services/dashboard_metric_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:evefit_tracker/app.dart';
import 'package:evefit_tracker/database/app_database.dart';

void main() {
  test('calcula IMC, idade e rácios quando existem dados suficientes', () {
    final birthDate = DateTime(1990, 6, 6);

    expect(BodyDataService.calculateBmi(weightKg: 80, heightCm: 180), 24.7);
    expect(
      BodyDataService.calculateAge(
        birthDate: birthDate,
        today: DateTime(2026, 6, 6),
      ),
      36,
    );
    expect(BodyDataService.waistToHipRatio(waistCm: 80, hipsCm: 100), 0.8);
    expect(
      BodyDataService.waistToHeightRatio(waistCm: 80, heightCm: 180),
      0.44,
    );
  });

  test('BodyMeasurement guarda campos novos de balança e dobras cutâneas', () {
    final measurement = BodyMeasurement(
      date: DateTime(2026, 6, 6),
      heightCm: 180,
      scaleBmi: 24.6,
      calculatedBmi: 24.7,
      bodyScore: 82,
      fatMassKg: 12.5,
      fatFreeBodyWeightKg: 67.5,
      skeletalMuscleMassKg: 36.2,
      standardWeightKg: 75,
      weightControlKg: -5,
      fatControlKg: -3,
      muscleControlKg: 1.2,
      restingHeartRateBpm: 58,
      bodyType: 'Atlético',
      waistToHipRatio: 0.8,
      waistToHeightRatio: 0.44,
      bicepsSkinfoldMm: 5,
      medialCalfSkinfoldMm: 7,
    );

    final restored = BodyMeasurement.fromMap(measurement.toMap());

    expect(restored.heightCm, 180);
    expect(restored.scaleBmi, 24.6);
    expect(restored.calculatedBmi, 24.7);
    expect(restored.bodyScore, 82);
    expect(restored.fatMassKg, 12.5);
    expect(restored.fatFreeBodyWeightKg, 67.5);
    expect(restored.skeletalMuscleMassKg, 36.2);
    expect(restored.standardWeightKg, 75);
    expect(restored.restingHeartRateBpm, 58);
    expect(restored.bodyType, 'Atlético');
    expect(restored.waistToHipRatio, 0.8);
    expect(restored.waistToHeightRatio, 0.44);
    expect(restored.bicepsSkinfoldMm, 5);
    expect(restored.medialCalfSkinfoldMm, 7);
  });

  test('dashboard lê novos dados corporais e usa IMC calculado primeiro', () {
    final measurement = BodyMeasurement(
      date: DateTime(2026, 6, 6),
      scaleBmi: 24.6,
      calculatedBmi: 24.7,
      waistToHipRatio: 0.8,
      restingHeartRateBpm: 58,
    );

    expect(DashboardMetricService.valueFor('bmi', measurement), '24.7');
    expect(DashboardMetricService.valueFor('scale_bmi', measurement), '24.6');
    expect(
      DashboardMetricService.valueFor('waist_to_hip_ratio', measurement),
      '0.8',
    );
    expect(
      DashboardMetricService.valueFor('resting_heart_rate', measurement),
      '58.0 bpm',
    );
  });

  testWidgets('a navegação principal mostra a aba Dados', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EveFitHome(
          database: AppDatabase.instance,
          onProfileLocked: () {},
        ),
      ),
    );

    expect(find.text('Dados'), findsOneWidget);
    expect(find.text('Medidas'), findsNothing);
  });
}
