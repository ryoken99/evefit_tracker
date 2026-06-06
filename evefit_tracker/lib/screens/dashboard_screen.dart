import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/body_measurement.dart';
import '../models/user_profile.dart';
import '../services/csv_export_service.dart';
import '../services/dashboard_stats_service.dart';
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
    return FutureBuilder<List<Object>>(
      future: Future.wait<Object>([
        widget.database.profile(),
        widget.database.measurements(),
        widget.database.workoutsThisWeek(),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final profile = snapshot.data![0] as UserProfile;
        final measurements = snapshot.data![1] as List<BodyMeasurement>;
        final workoutsThisWeek = snapshot.data![2] as int;
        final latest = measurements.isEmpty ? null : measurements.first;
        final days = DateTime.now().difference(profile.startDate).inDays;

        return RefreshIndicator(
          onRefresh: () async => setState(() {}),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'EveFit Tracker',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${profile.name} · ${profile.heightCm.toStringAsFixed(0)} cm · objetivo ${profile.mainGoal}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 14),
              const Text(
                'Objetivo atual: construir V-shape sem perder composição corporal.',
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.flag,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Fase 1: Construção de V-shape',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: MediaQuery.sizeOf(context).width > 620 ? 3 : 2,
                childAspectRatio: 1.45,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  StatCard(
                    label: 'Peso atual',
                    value: _value(latest?.weightKg, 'kg'),
                  ),
                  StatCard(
                    label: 'Braço contraído',
                    value: _value(
                      latest == null
                          ? null
                          : DashboardStatsService.flexedArmCm(latest),
                      'cm',
                    ),
                  ),
                  StatCard(
                    label: 'Ombros',
                    value: _value(latest?.shouldersCm, 'cm'),
                  ),
                  StatCard(
                    label: 'Zona lateral',
                    value: _value(latest?.sideHipAreaCm, 'cm'),
                  ),
                  StatCard(
                    label: 'Treinos esta semana',
                    value: '$workoutsThisWeek',
                  ),
                  StatCard(label: 'Dias desde início', value: '$days'),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () async {
                  final path = await CsvExportService().exportAll(
                    widget.database,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Dados exportados: $path')),
                    );
                  }
                },
                icon: const Icon(Icons.file_download_outlined),
                label: const Text('Exportar dados'),
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
                    .map(DashboardStatsService.flexedArmCm)
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
