import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/body_measurement.dart';
import '../models/dashboard_widget_config.dart';
import '../models/user_profile.dart';
import '../services/csv_export_service.dart';
import '../services/dashboard_metric_service.dart';
import '../services/dashboard_widget_draft_service.dart';
import '../widgets/progress_chart.dart';
import '../widgets/stat_card.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.database,
    required this.onProfileLocked,
  });

  final AppDatabase database;
  final VoidCallback onProfileLocked;

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
        widget.database.dashboardWidgets(),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = snapshot.data![0] as UserProfile;
        final measurements = snapshot.data![1] as List<BodyMeasurement>;
        final workoutsThisWeek = snapshot.data![2] as int;
        final dashboardWidgets =
            snapshot.data![3] as List<DashboardWidgetConfig>;
        final latest = measurements.isEmpty ? null : measurements.first;
        final days = DateTime.now().difference(profile.startDate).inDays;
        final visibleWidgets = dashboardWidgets
            .where((item) => item.isVisible)
            .take(12)
            .toList();

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
                    tooltip: 'Definições',
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SettingsScreen(
                            database: widget.database,
                            onProfileLocked: widget.onProfileLocked,
                            onProfileChanged: (_) => setState(() {}),
                          ),
                        ),
                      );
                      setState(() {});
                    },
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Perfil: ${widget.database.activeProfile?.name ?? profile.name}',
              ),
              const SizedBox(height: 4),
              Text(
                '${profile.name} · ${profile.heightCm.toStringAsFixed(0)} cm · objetivo ${profile.mainGoal}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
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
                  for (final item in visibleWidgets)
                    StatCard(
                      label: item.title,
                      value: DashboardMetricService.valueFor(
                        item.metricKey,
                        latest,
                        workoutsThisWeek: workoutsThisWeek,
                        daysSinceStart: days,
                      ),
                    ),
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
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () => _editDashboard(dashboardWidgets),
                icon: const Icon(Icons.tune_outlined),
                label: const Text('Editar Dashboard'),
              ),
              const SizedBox(height: 16),
              _metricChart('Peso ao longo do tempo', 'weight', measurements),
              const SizedBox(height: 10),
              _metricChart('IMC ao longo do tempo', 'bmi', measurements),
              const SizedBox(height: 10),
              _metricChart(
                'Gordura corporal ao longo do tempo',
                'body_fat',
                measurements,
              ),
              const SizedBox(height: 10),
              _metricChart(
                'Massa muscular ao longo do tempo',
                'muscle_mass',
                measurements,
              ),
              const SizedBox(height: 10),
              _metricChart('Cintura ao longo do tempo', 'waist', measurements),
              const SizedBox(height: 10),
              _metricChart('Peito ao longo do tempo', 'chest', measurements),
              const SizedBox(height: 10),
              _metricChart(
                'Gordura visceral ao longo do tempo',
                'visceral_fat',
                measurements,
              ),
              const SizedBox(height: 10),
              _metricChart(
                'BMR ao longo do tempo',
                'basal_metabolism',
                measurements,
              ),
              const SizedBox(height: 10),
              _metricChart(
                'Braço contraído ao longo do tempo',
                'avg_biceps_flexed',
                measurements,
              ),
              const SizedBox(height: 10),
              _metricChart(
                'Zona lateral acima da anca ao longo do tempo',
                'side_hip_area',
                measurements,
              ),
              const SizedBox(height: 10),
              _metricChart(
                'Ombros ao longo do tempo',
                'shoulders',
                measurements,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _metricChart(
    String title,
    String metricKey,
    List<BodyMeasurement> measurements,
  ) {
    return ProgressChart(
      title: title,
      values: DashboardMetricService.valuesFor(metricKey, measurements),
    );
  }

  Future<void> _editDashboard(List<DashboardWidgetConfig> widgets) async {
    var draft = DashboardWidgetDraftService.createDraft(widgets);
    final changed = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.82,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Editar Dashboard',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      for (var index = 0; index < draft.length; index++)
                        SwitchListTile(
                          value: draft[index].isVisible,
                          title: Text(draft[index].title),
                          subtitle: Text(draft[index].metricKey),
                          onChanged: (value) => setSheetState(() {
                            draft[index] = DashboardWidgetDraftService.toggle(
                              draft[index],
                              value,
                            );
                          }),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => setSheetState(() {
                            draft = [
                              for (final item in draft)
                                DashboardWidgetDraftService.toggle(
                                  item,
                                  DashboardMetricService.defaultKeys.contains(
                                    item.metricKey,
                                  ),
                                ),
                            ];
                          }),
                          icon: const Icon(Icons.restart_alt),
                          label: const Text('Restaurar padrão'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () async {
                            for (final item in draft) {
                              await widget.database.updateDashboardWidget(item);
                            }
                            if (context.mounted) Navigator.pop(context, true);
                          },
                          icon: const Icon(Icons.save_outlined),
                          label: const Text('Guardar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (changed == true) setState(() {});
  }
}
