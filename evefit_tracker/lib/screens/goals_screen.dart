import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/goal.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key, required this.database});
  final AppDatabase database;

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  static const phases = ['Fase 1', 'Fase 2', 'Fase 3', 'Livre'];
  static const categories = [
    'Costas',
    'Ombros',
    'Peito',
    'Braços',
    'Antebraço/Pega',
    'Core',
    'Pernas',
    'Cardio',
    'Composição corporal',
    'Outro',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openGoalForm(),
        icon: const Icon(Icons.add),
        label: const Text('Criar objetivo'),
      ),
      body: FutureBuilder<List<Goal>>(
        future: widget.database.goals(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final goals = snapshot.data!;
          final grouped = <String, List<Goal>>{};
          for (final goal in goals) {
            grouped.putIfAbsent(goal.phase, () => []).add(goal);
          }
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
                    child: Text(
                      'Ainda não há objetivos neste perfil. Cria o primeiro objetivo para orientar o treino.',
                    ),
                  ),
                ),
              for (final entry in grouped.entries) ...[
                Text(entry.key, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                for (final goal in entry.value)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      child: CheckboxListTile(
                        value: goal.completedAt != null,
                        onChanged: (value) async {
                          await widget.database.setGoalCompleted(
                            goal,
                            value ?? false,
                          );
                          setState(() {});
                        },
                        title: Text(goal.title),
                        subtitle: Text(
                          '${goal.phase} · ${goal.category} · ${goal.completedAt == null ? 'Ativo' : 'Concluído'}'
                          '${goal.description.isEmpty ? '' : '\n${goal.description}'}',
                        ),
                        secondary: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              _openGoalForm(goal: goal);
                            } else if (value == 'delete') {
                              _deleteGoal(goal);
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(value: 'edit', child: Text('Editar')),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Apagar'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 72),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openGoalForm({Goal? goal}) async {
    final title = TextEditingController(text: goal?.title ?? '');
    final description = TextEditingController(text: goal?.description ?? '');
    var phase = goal?.phase ?? phases.first;
    var category = goal?.category ?? categories.last;
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
          child: ListView(
            shrinkWrap: true,
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
                maxLines: 4,
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
              if (error != null) ...[
                const SizedBox(height: 10),
                Text(
                  error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
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
                    isActive: goal?.completedAt == null,
                    createdAt: goal?.createdAt ?? DateTime.now(),
                    completedAt: goal?.completedAt,
                  );
                  if (goal == null) {
                    await widget.database.insertGoal(value);
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
    );
    title.dispose();
    description.dispose();
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
}
