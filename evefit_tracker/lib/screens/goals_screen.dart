import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/goal.dart';
import '../models/goal_milestone.dart';
import '../services/dashboard_metric_service.dart';
import '../services/goal_progress_service.dart';
import '../widgets/progress_chart.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key, required this.database});

  final AppDatabase database;

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  static const phases = ['Base', 'Fase 1', 'Fase 2', 'Fase 3', 'Livre'];
  static const categories = [
    'Composição corporal',
    'Treino',
    'Força',
    'Cardio',
    'Mobilidade',
    'Karate',
    'Jiu-Jitsu',
    'Outro',
  ];
  static const periodicities = [
    'Único',
    'Diário',
    'Semanal',
    'Mensal',
    'Trimestral',
    'Livre',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openGoalForm(),
        icon: const Icon(Icons.add),
        label: const Text('Criar objetivo'),
      ),
      body: FutureBuilder<List<Object>>(
        future: Future.wait<Object>([
          widget.database.goals(),
          widget.database.measurements(),
          widget.database.workoutsThisWeek(),
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final goals = snapshot.data![0] as List<Goal>;
          final measurements = snapshot.data![1] as List;
          final workoutsThisWeek = snapshot.data![2] as int;
          final latest = measurements.isEmpty ? null : measurements.first;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Objetivos',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (goals.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Ainda não há objetivos neste perfil.'),
                  ),
                ),
              for (final goal in goals)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FutureBuilder<List<GoalMilestone>>(
                    future: widget.database.goalMilestones(goal.id!),
                    builder: (context, milestonesSnapshot) {
                      final currentMetric =
                          DashboardMetricService.numericValueFor(
                            goal.metricKey,
                            latest,
                          );
                      final progress = _progressFor(
                        goal,
                        currentMetric,
                        workoutsThisWeek,
                      );
                      return _GoalCard(
                        goal: goal,
                        progress: progress,
                        currentValue: currentMetric ?? goal.currentValue,
                        milestones: milestonesSnapshot.data ?? const [],
                        onToggle: (completed) async {
                          await widget.database.setGoalCompleted(
                            goal,
                            completed,
                          );
                          setState(() {});
                        },
                        onEdit: () => _openGoalForm(goal: goal),
                        onDelete: () => _deleteGoal(goal),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 72),
            ],
          );
        },
      ),
    );
  }

  double _progressFor(Goal goal, double? currentMetric, int workoutsThisWeek) {
    if (goal.metricKey == 'frequency_week') {
      return GoalProgressService.calculateFrequencyProgress(
        completed: workoutsThisWeek,
        target: goal.frequencyTarget ?? 0,
      );
    }
    if (goal.metricKey == 'manual') {
      return GoalProgressService.calculateManualPercent(goal.manualProgress);
    }
    return GoalProgressService.calculateProgress(
      initialValue: goal.initialValue,
      currentValue: currentMetric ?? goal.currentValue,
      targetValue: goal.targetValue,
    );
  }

  Future<void> _openGoalForm({Goal? goal}) async {
    final title = TextEditingController(text: goal?.title ?? '');
    final description = TextEditingController(text: goal?.description ?? '');
    final initial = TextEditingController(
      text: goal?.initialValue?.toString() ?? '',
    );
    final current = TextEditingController(
      text: goal?.currentValue?.toString() ?? '',
    );
    final target = TextEditingController(
      text: goal?.targetValue?.toString() ?? '',
    );
    final unit = TextEditingController(text: goal?.unit ?? '');
    final manual = TextEditingController(
      text: goal?.manualProgress?.toString() ?? '',
    );
    final frequency = TextEditingController(
      text: goal?.frequencyTarget?.toString() ?? '',
    );
    final notes = TextEditingController(text: goal?.notes ?? '');
    final milestoneText = TextEditingController();
    var phase = goal?.phase ?? phases.first;
    var category = goal?.category ?? categories.last;
    var metricKey = goal?.metricKey ?? 'manual';
    var periodicity = goal?.periodicity ?? 'Livre';
    String? error;

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            MediaQuery.viewInsetsOf(context).bottom + 16,
          ),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.86,
            child: ListView(
              children: [
                Text(
                  goal == null ? 'Criar objetivo' : 'Editar objetivo',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: title,
                  decoration: const InputDecoration(labelText: 'Título'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: description,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: phase,
                  items: phases
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setSheetState(() => phase = value ?? phase),
                  decoration: const InputDecoration(labelText: 'Fase'),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: category,
                  items: categories
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setSheetState(() => category = value ?? category),
                  decoration: const InputDecoration(labelText: 'Categoria'),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: metricKey,
                  items: [
                    const DropdownMenuItem(
                      value: 'manual',
                      child: Text('Manual'),
                    ),
                    const DropdownMenuItem(
                      value: 'frequency_week',
                      child: Text('Treinos por semana'),
                    ),
                    for (final metric in DashboardMetricService.definitions)
                      DropdownMenuItem(
                        value: metric.key,
                        child: Text(metric.title),
                      ),
                  ],
                  onChanged: (value) =>
                      setSheetState(() => metricKey = value ?? metricKey),
                  decoration: const InputDecoration(
                    labelText: 'Métrica associada',
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: periodicity,
                  items: periodicities
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setSheetState(() => periodicity = value ?? periodicity),
                  decoration: const InputDecoration(labelText: 'Periodicidade'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _NumberField('Valor inicial', initial)),
                    const SizedBox(width: 8),
                    Expanded(child: _NumberField('Valor atual', current)),
                    const SizedBox(width: 8),
                    Expanded(child: _NumberField('Valor alvo', target)),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: unit,
                  decoration: const InputDecoration(labelText: 'Unidade'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: manual,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Progresso manual %',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: frequency,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Alvo de frequência',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: milestoneText,
                  decoration: const InputDecoration(
                    labelText: 'Milestones separados por vírgula',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: notes,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Notas'),
                ),
                if (error != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () async {
                    if (title.text.trim().isEmpty) {
                      setSheetState(
                        () => error = 'O título não pode estar vazio.',
                      );
                      return;
                    }
                    final value = Goal(
                      id: goal?.id,
                      profileId: goal?.profileId,
                      title: title.text.trim(),
                      description: description.text.trim(),
                      phase: phase,
                      category: category,
                      metricKey: metricKey,
                      initialValue: _num(initial.text),
                      currentValue: _num(current.text),
                      targetValue: _num(target.text),
                      unit: unit.text.trim(),
                      periodicity: periodicity,
                      frequencyTarget: int.tryParse(frequency.text.trim()),
                      manualProgress: _num(manual.text),
                      notes: notes.text.trim(),
                      isActive: goal?.completedAt == null,
                      createdAt: goal?.createdAt ?? DateTime.now(),
                      completedAt: goal?.completedAt,
                    );
                    final goalId = goal == null
                        ? await widget.database.insertGoal(value)
                        : goal.id!;
                    if (goal == null) {
                      final milestones = milestoneText.text
                          .split(',')
                          .map((item) => item.trim())
                          .where((item) => item.isNotEmpty)
                          .toList();
                      for (var i = 0; i < milestones.length; i++) {
                        await widget.database.insertGoalMilestone(
                          GoalMilestone(
                            goalId: goalId,
                            title: milestones[i],
                            targetValue: _num(milestones[i].split(' ').first),
                            unit: unit.text.trim(),
                            status: i == 0 ? 'in_progress' : 'locked',
                            sortOrder: i,
                            createdAt: DateTime.now(),
                          ),
                        );
                      }
                    } else {
                      await widget.database.updateGoal(value);
                    }
                    if (context.mounted) Navigator.pop(context, true);
                  },
                  child: Text(
                    goal == null ? 'Criar objetivo' : 'Guardar objetivo',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    for (final controller in [
      title,
      description,
      initial,
      current,
      target,
      unit,
      manual,
      frequency,
      notes,
      milestoneText,
    ]) {
      controller.dispose();
    }
    if (saved == true) setState(() {});
  }

  Future<void> _deleteGoal(Goal goal) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apagar objetivo'),
        content: const Text('Tens a certeza que queres apagar este objetivo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Apagar'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await widget.database.deleteGoal(goal.id!);
      setState(() {});
    }
  }

  double? _num(String text) {
    final normalized = text.trim().replaceAll(',', '.');
    if (normalized.isEmpty) return null;
    return double.tryParse(normalized);
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.goal,
    required this.progress,
    required this.currentValue,
    required this.milestones,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final Goal goal;
  final double progress;
  final double? currentValue;
  final List<GoalMilestone> milestones;
  final ValueChanged<bool> onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).clamp(0, 100).toStringAsFixed(0);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    goal.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Checkbox(
                  value: goal.completedAt != null,
                  onChanged: (value) => onToggle(value ?? false),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') onEdit();
                    if (value == 'delete') onDelete();
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'edit', child: Text('Editar')),
                    PopupMenuItem(value: 'delete', child: Text('Apagar')),
                  ],
                ),
              ],
            ),
            Text('${goal.phase} · ${goal.category} · ${goal.periodicity}'),
            if (goal.description.isNotEmpty) Text(goal.description),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 6),
            Text(
              '$percent% · atual ${currentValue?.toStringAsFixed(1) ?? '-'} ${goal.unit}',
            ),
            if (milestones.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final milestone in milestones)
                    Chip(
                      label: Text(milestone.title),
                      avatar: Icon(
                        milestone.status == 'completed'
                            ? Icons.check_circle
                            : milestone.status == 'in_progress'
                            ? Icons.radio_button_checked
                            : Icons.lock_outline,
                        size: 18,
                      ),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 10),
            ProgressChart(
              title: 'Gráfico da métrica',
              values: currentValue == null
                  ? const []
                  : [goal.initialValue, currentValue, goal.targetValue],
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField(this.label, this.controller);

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
    );
  }
}
