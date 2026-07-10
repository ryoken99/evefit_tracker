import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/dashboard_data_snapshot.dart';
import '../models/dashboard_widget_config.dart';
import '../models/dashboard_view_model.dart';
import '../services/csv_export_service.dart';
import '../services/dashboard_composition_service.dart';
import '../services/profile_preferences_service.dart';
import '../widgets/dashboard_editor_sheet.dart';
import '../widgets/dashboard_empty_state.dart';
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
  late Future<DashboardDataSnapshot> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData();
  }

  Future<DashboardDataSnapshot> _loadData() async {
    final profile = await widget.database.profile();
    final measurements = await widget.database.measurements();
    final preferences = await widget.database.dashboardWidgets();
    return DashboardDataSnapshot(
      profile: profile,
      selectedGoals: ProfilePreferencesService.parseGeneralGoals(
        widget.database.activeProfile?.initialGoals ?? profile.mainGoal,
      ),
      measurements: measurements,
      workoutsThisWeek: await widget.database.workoutsThisWeek(),
      dashboardPreferences: preferences,
    );
  }

  Future<void> _refresh() async {
    final next = _loadData();
    setState(() {
      _dataFuture = next;
    });
    await next;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<DashboardDataSnapshot>(
    future: _dataFuture,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: FilledButton(
            onPressed: _refresh,
            child: const Text('Tentar novamente'),
          ),
        );
      }
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      final data = snapshot.data!;
      final viewModel = DashboardCompositionService.compose(data);
      return RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'EveFit Tracker',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Definições',
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SettingsScreen(
                          database: widget.database,
                          onProfileLocked: widget.onProfileLocked,
                          onProfileChanged: (_) {
                            _refresh();
                          },
                        ),
                      ),
                    );
                    await _refresh();
                  },
                ),
              ],
            ),
            Text(
              'Perfil: ${widget.database.activeProfile?.name ?? data.profile.name}',
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _editDashboard(data, viewModel),
              icon: const Icon(Icons.tune_outlined),
              label: const Text('Editar Dashboard'),
            ),
            const SizedBox(height: 12),
            if (viewModel.emptyState != DashboardEmptyState.none)
              DashboardEmptyStatePanel(state: viewModel.emptyState),
            if (viewModel.visibleMetricItems
                .where((item) => item.supportsCard)
                .isNotEmpty)
              GridView.count(
                crossAxisCount: MediaQuery.sizeOf(context).width > 620 ? 3 : 2,
                childAspectRatio: 1.45,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  for (final item in viewModel.visibleMetricItems.where(
                    (item) => item.supportsCard,
                  ))
                    StatCard(
                      label: item.title,
                      value: item.formattedCurrentValue,
                    ),
                ],
              ),
            for (final item in viewModel.visibleMetricItems.where(
              (item) => item.supportsChart,
            )) ...[
              const SizedBox(height: 10),
              ProgressChart(
                title: item.chartTitle,
                values: item.chartValues,
                emptyMessage:
                    'Ainda não existem registos suficientes para apresentar evolução.',
              ),
            ],
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
          ],
        ),
      );
    },
  );

  Future<void> _editDashboard(
    DashboardDataSnapshot data,
    DashboardViewModel viewModel,
  ) async {
    final changed = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => DashboardEditorSheet(
        options: viewModel.editorMetricOptions,
        onSave: (options) => _savePreferences(data, options),
      ),
    );
    if (changed == true) await _refresh();
  }

  Future<void> _savePreferences(
    DashboardDataSnapshot data,
    List<DashboardEditorMetricOption> options,
  ) async {
    final byKey = {
      for (final preference in data.dashboardPreferences)
        preference.metricKey: preference,
    };
    final profileId = widget.database.activeProfileId!;
    final now = DateTime.now();
    await widget.database.saveExplicitDashboardWidgets([
      for (final option in options)
        DashboardWidgetConfig(
          id: byKey[option.metricKey]?.id,
          profileId: profileId,
          metricKey: option.metricKey,
          title: option.title,
          isVisible: option.isEnabled,
          sortOrder: option.sortOrder,
          createdAt: byKey[option.metricKey]?.createdAt ?? now,
          updatedAt: now,
          explicitlyConfiguredAt: now,
        ),
    ]);
  }
}
