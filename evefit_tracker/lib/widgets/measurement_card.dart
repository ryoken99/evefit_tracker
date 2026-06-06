import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/body_measurement.dart';
import '../services/dashboard_stats_service.dart';

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
          'Peso: ${_v(measurement.weightKg, 'kg')} · Braço contraído: ${_v(DashboardStatsService.flexedArmCm(measurement), 'cm')}\nOmbros: ${_v(measurement.shouldersCm, 'cm')} · Zona lateral: ${_v(measurement.sideHipAreaCm, 'cm')}',
        ),
        isThreeLine: true,
      ),
    );
  }

  String _v(double? value, String unit) =>
      value == null ? '-' : '${value.toStringAsFixed(1)} $unit';
}
