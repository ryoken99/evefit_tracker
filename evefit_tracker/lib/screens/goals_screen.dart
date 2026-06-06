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
                    builder: (context, milestoneSnapshot) {
                      final currentMetric =
                          DashboardMetricService.numericValueFor(
                            goal.metricKey,
                            latest,
                          );
                      return _GoalCard(
                        goal: goal,
                        currentValue: currentMetric ?? goal.currentValue,
                        progress: _progressFor(
                          goal,
                          currentMetric,
                          workoutsThisWeek,
                        ),
                        milestones: milestoneSnapshot.data ?? const [],
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
    final milestoneName = TextEditingController();
    final milestoneValue = TextEditingController();
    final milestoneDrafts = <_MilestoneDraft>[];
    var advanced = false;
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
            height: MediaQuery.sizeOf(context).height * 0.88,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        goal == null ? 'Criar objetivo' : 'Editar objetivo',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Cria um objetivo para acompanhar a tua evolução. Podes ligar o objetivo a uma medida, ao peso, à frequência de treino ou controlar manualmente.',
                      ),
                      const SizedBox(height: 12),
                      _SectionTitle('1. O que queres melhorar?'),
                      TextField(
                        controller: title,
                        decoration: const InputDecoration(
                          labelText: 'Título do objetivo',
                          hintText: 'Ex: Treinar 4 vezes por semana',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: description,
                        minLines: 2,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Descrição opcional',
                        ),
                      ),
                      const SizedBox(height: 14),
                      _SectionTitle('2. Métrica associada'),
                      DropdownButtonFormField<String>(
                        initialValue: metricKey,
                        items: [
                          const DropdownMenuItem(
                            value: 'manual',
                            child: Text('Objetivo manual'),
                          ),
                          const DropdownMenuItem(
                            value: 'frequency_week',
                            child: Text('Frequência de treino'),
                          ),
                          for (final metric
                              in DashboardMetricService.definitions)
                            DropdownMenuItem(
                              value: metric.key,
                              child: Text(metric.title),
                            ),
                        ],
                        onChanged: (value) =>
                            setSheetState(() => metricKey = value ?? metricKey),
                        decoration: const InputDecoration(labelText: 'Métrica'),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: periodicity,
                        items: periodicities
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setSheetState(
                          () => periodicity = value ?? periodicity,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Periodicidade',
                        ),
                      ),
                      const SizedBox(height: 14),
                      _SectionTitle('3. Valores do objetivo'),
                      Row(
                        children: [
                          Expanded(child: _NumberField('Inicial', initial)),
                          const SizedBox(width: 8),
                          Expanded(child: _NumberField('Alvo', target)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: unit,
                        decoration: const InputDecoration(labelText: 'Unidade'),
                      ),
                      const SizedBox(height: 14),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: advanced,
                        title: const Text('Modo avançado'),
                        subtitle: const Text(
                          'Mostra valor atual manual, progresso manual, categoria, fase e notas técnicas.',
                        ),
                        onChanged: (value) =>
                            setSheetState(() => advanced = value),
                      ),
                      if (advanced) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _NumberField('Valor atual', current),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _NumberField('Progresso %', manual),
                            ),
                          ],
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
                        DropdownButtonFormField<String>(
                          initialValue: phase,
                          items: phases
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
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
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: (value) =>
                              setSheetState(() => category = value ?? category),
                          decoration: const InputDecoration(
                            labelText: 'Categoria',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: notes,
                          minLines: 2,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Notas técnicas',
                          ),
                        ),
                      ],
                      const SizedBox(height: 14),
                      _SectionTitle('4. Milestones'),
                      const Text(
                        'Milestones são pequenos marcos até ao objetivo final.',
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final item in milestoneDrafts)
                            Chip(
                              label: Text(
                                item.value == null
                                    ? item.name
                                    : '${item.name} · ${item.value}',
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: milestoneName,
                              decoration: const InputDecoration(
                                labelText: 'Nome do marco',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 96,
                            child: TextField(
                              controller: milestoneValue,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: const InputDecoration(
                                labelText: 'Valor',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: () => setSheetState(() {
                              final value = _num(milestoneValue.text);
                              final name = milestoneName.text.trim();
                              if (name.isNotEmpty || value != null) {
                                milestoneDrafts.add(
                                  _MilestoneDraft(
                                    name.isEmpty
                                        ? '${value!.toStringAsFixed(1)} ${unit.text}'
                                        : name,
                                    value,
                                  ),
                                );
                                milestoneName.clear();
                                milestoneValue.clear();
                              }
                            }),
                            icon: const Icon(Icons.add),
                            label: const Text('Adicionar marco'),
                          ),
                          TextButton.icon(
                            onPressed: () => setSheetState(() {
                              milestoneDrafts
                                ..clear()
                                ..addAll(
                                  _generateMilestones(
                                    _num(initial.text),
                                    _num(target.text),
                                    unit.text,
                                  ),
                                );
                            }),
                            icon: const Icon(Icons.auto_awesome),
                            label: const Text('Gerar milestones'),
                          ),
                        ],
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
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                FilledButton.icon(
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
                      for (var i = 0; i < milestoneDrafts.length; i++) {
                        final milestone = milestoneDrafts[i];
                        await widget.database.insertGoalMilestone(
                          GoalMilestone(
                            goalId: goalId,
                            title: milestone.name,
                            targetValue: milestone.value,
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
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Guardar objetivo'),
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
      milestoneName,
      milestoneValue,
    ]) {
      controller.dispose();
    }
    if (saved == true) setState(() {});
  }

  List<_MilestoneDraft> _generateMilestones(
    double? initial,
    double? target,
    String unit,
  ) {
    if (initial == null || target == null || initial == target) return const [];
    final step = (target - initial) / 5;
    return [
      for (var i = 1; i <= 5; i++)
        _MilestoneDraft(
          '${(initial + step * i).toStringAsFixed(1)} $unit'.trim(),
          initial + step * i,
        ),
    ];
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
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

class _MilestoneDraft {
  const _MilestoneDraft(this.name, this.value);

  final String name;
  final double? value;
}
