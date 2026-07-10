import 'package:flutter/material.dart';

import '../models/dashboard_view_model.dart';

class DashboardEmptyStatePanel extends StatelessWidget {
  const DashboardEmptyStatePanel({super.key, required this.state});

  final DashboardEmptyState state;

  @override
  Widget build(BuildContext context) {
    final message = switch (state) {
      DashboardEmptyState.noGoals =>
        'Ainda não selecionaste objetivos.\n\nEscolhe objetivos no perfil para definir as métricas disponíveis no Dashboard.',
      DashboardEmptyState.noEnabledMetrics =>
        'Não tens métricas ativas no Dashboard.\n\nUsa “Editar Dashboard” para escolher entre as métricas permitidas pelos teus objetivos.',
      DashboardEmptyState.none => '',
    };
    if (message.isEmpty) return const SizedBox.shrink();
    return Card(
      child: Padding(padding: const EdgeInsets.all(16), child: Text(message)),
    );
  }
}
