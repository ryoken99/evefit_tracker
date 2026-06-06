import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/body_measurement.dart';

class MeasurementCard extends StatelessWidget {
  const MeasurementCard({super.key, required this.measurement});
  final BodyMeasurement measurement;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy').format(measurement.date);
    return Card(
      child: ListTile(
        title: Text(date),
        subtitle: Text(
          'Peso: ${_v(measurement.weightKg, 'kg')} · Braço: ${_v(measurement.rightBicepFlexedCm, 'cm')} · Ombros: ${_v(measurement.shouldersCm, 'cm')}',
        ),
        trailing: Text(_v(measurement.sideHipAreaCm, 'cm')),
      ),
    );
  }

  String _v(double? value, String unit) =>
      value == null ? '-' : '${value.toStringAsFixed(1)} $unit';
}
