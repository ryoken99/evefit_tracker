import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/body_measurement.dart';
import '../services/csv_export_service.dart';
import '../widgets/progress_chart.dart';
import '../widgets/stat_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.database});
  final AppDatabase database;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        widget.database.profile(),
        widget.database.measurements(),
        widget.database.workoutsThisWeek(),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final profile = snapshot.data![0] as dynamic;
        final measurements = snapshot.data![1] as List<BodyMeasurement>;
        final workoutsThisWeek = snapshot.data![2] as int;
        final latest = measurements.first;
        final first = measurements.last;
        final days = DateTime.now()
            .difference(profile.startDate as DateTime)
            .inDays;
        final weightDelta = (latest.weightKg ?? 0) - (first.weightKg ?? 0);
        return RefreshIndicator(
          onRefresh: () async => setState(() {}),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'EveFit Tracker',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Exportar CSV',
                    onPressed: () async {
                      final path = await CsvExportService().exportAll(
                        widget.database,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('CSV exportado: $path')),
                        );
                      }
                    },
                    icon: const Icon(Icons.file_download_outlined),
                  ),
                ],
              ),
              Text(
                'Sandro · ${profile.heightCm.toStringAsFixed(0)} cm · objetivo ${profile.mainGoal}',
              ),
              const SizedBox(height: 12),
              const Text(
                'Objetivo atual: construir V-shape sem perder composição corporal.',
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: MediaQuery.sizeOf(context).width > 620 ? 3 : 2,
                childAspectRatio: 1.55,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  StatCard(
                    label: 'Peso atual',
                    value: _value(latest.weightKg, 'kg'),
                  ),
                  StatCard(
                    label: 'Variação peso',
                    value:
                        '${weightDelta >= 0 ? '+' : ''}${weightDelta.toStringAsFixed(1)} kg',
                  ),
                  StatCard(
                    label: 'Braço contraído',
                    value: _value(
                      latest.rightBicepFlexedCm ?? latest.leftBicepFlexedCm,
                      'cm',
                    ),
                  ),
                  StatCard(
                    label: 'Ombros',
                    value: _value(latest.shouldersCm, 'cm'),
                  ),
                  StatCard(
                    label: 'Zona lateral',
                    value: _value(latest.sideHipAreaCm, 'cm'),
                  ),
                  StatCard(label: 'Treinos semana', value: '$workoutsThisWeek'),
                  StatCard(label: 'Dias desde início', value: '$days'),
                ],
              ),
              const SizedBox(height: 16),
              ProgressChart(
                title: 'Peso ao longo do tempo',
                values: measurements.map((m) => m.weightKg).toList(),
              ),
              const SizedBox(height: 10),
              ProgressChart(
                title: 'Braço contraído ao longo do tempo',
                values: measurements
                    .map((m) => m.rightBicepFlexedCm ?? m.leftBicepFlexedCm)
                    .toList(),
              ),
              const SizedBox(height: 10),
              ProgressChart(
                title: 'Zona lateral acima da anca ao longo do tempo',
                values: measurements.map((m) => m.sideHipAreaCm).toList(),
              ),
              const SizedBox(height: 10),
              ProgressChart(
                title: 'Ombros ao longo do tempo',
                values: measurements.map((m) => m.shouldersCm).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  String _value(double? value, String unit) =>
      value == null ? '-' : '${value.toStringAsFixed(1)} $unit';
}
