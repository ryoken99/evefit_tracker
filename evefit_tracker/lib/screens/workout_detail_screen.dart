import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';
import '../features/canonical_core/screens/canonical_core_search_screen.dart';
import '../models/workout.dart';
import '../models/workout_set.dart';
import '../services/workout_taxonomy.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({
    super.key,
    required this.database,
    required this.entry,
  });
  final AppDatabase database;
  final WorkoutEntry entry;

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  late WorkoutEntry _entry = widget.entry;

  @override
  Widget build(BuildContext context) {
    final workout = _entry.workout;
    final blocks = _exerciseBlocks();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe do treino'),
        actions: [
          IconButton(
            tooltip: 'Editar treino',
            onPressed: _editWorkout,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Apagar treino',
            onPressed: _deleteWorkout,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const ValueKey('workout_detail_add_exercise'),
        heroTag: 'workout_detail_add_exercise_fab',
        onPressed: _addExercise,
        icon: const Icon(Icons.add),
        label: const Text('Adicionar exercício'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.workoutType,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  Text(DateFormat('dd/MM/yyyy').format(workout.date)),
                  Text('${workout.durationMinutes ?? 0} minutos'),
                  if (workout.notes.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(workout.notes),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    '${_entry.exerciseCount} exercícios · ${_entry.totalSetCount} séries',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (blocks.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Ainda não há exercícios neste treino. Adiciona um exercício para começares a registar séries.',
                ),
              ),
            ),
          for (final block in blocks)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        block.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      if (block.muscleGroup != null)
                        Text(
                          block.muscleGroup!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                        ),
                      const SizedBox(height: 10),
                      if (block.sets.isEmpty)
                        const Text('Sem séries preenchidas.'),
                      for (final set in block.sets)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('Série ${set.setNumber}'),
                          subtitle: Text(
                            '${set.weightKg?.toStringAsFixed(1) ?? '-'} kg · ${set.reps} reps · RPE ${set.rpe?.toStringAsFixed(1) ?? '-'}'
                            '${set.notes.isEmpty ? '' : '\n${set.notes}'}',
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                tooltip: 'Editar série',
                                onPressed: () => _openSetForm(
                                  exerciseId: block.exerciseId,
                                  exerciseName: block.name,
                                  existing: set,
                                ),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              IconButton(
                                tooltip: 'Apagar série',
                                onPressed: () => _deleteSet(set),
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 6),
                      OutlinedButton.icon(
                        onPressed: () => _openSetForm(
                          exerciseId: block.exerciseId,
                          exerciseName: block.name,
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Adicionar nova série'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 72),
        ],
      ),
    );
  }

  List<_ExerciseBlock> _exerciseBlocks() {
    final map = <int, _ExerciseBlock>{};
    for (final exercise in _entry.exercises) {
      map[exercise.exerciseId] = _ExerciseBlock(
        exerciseId: exercise.exerciseId,
        name: exercise.exerciseName ?? 'Exercício',
        muscleGroup: exercise.muscleGroup,
        sets: [],
      );
    }
    for (final set in _entry.sets) {
      final current = map[set.exerciseId];
      if (current == null) {
        map[set.exerciseId] = _ExerciseBlock(
          exerciseId: set.exerciseId,
          name: set.exerciseName ?? 'Exercício',
          sets: [set],
        );
      } else {
        current.sets.add(set);
      }
    }
    return map.values.toList();
  }

  Future<void> _editWorkout() async {
    var type = _entry.workout.workoutType;
    var date = _entry.workout.date;
    final typeOptions = {type, ...WorkoutTaxonomy.defaultTypeNames}.toList();
    final duration = TextEditingController(
      text: _entry.workout.durationMinutes?.toString() ?? '',
    );
    final notes = TextEditingController(text: _entry.workout.notes);
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
                'Editar treino',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(const Duration(days: 1)),
                  );
                  if (picked != null) setSheetState(() => date = picked);
                },
                icon: const Icon(Icons.calendar_today_outlined),
                label: Text(DateFormat('dd/MM/yyyy').format(date)),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                initialValue: type,
                items: typeOptions
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(WorkoutTaxonomy.displayWithSection(item)),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setSheetState(() => type = value ?? type),
                decoration: const InputDecoration(labelText: 'Tipo de treino'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: duration,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Duração em minutos',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: notes,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Notas'),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () async {
                  await widget.database.updateWorkout(
                    Workout(
                      id: _entry.workout.id,
                      date: date,
                      workoutType: type,
                      workoutTypeId: _entry.workout.workoutTypeId,
                      muscleGroups: WorkoutTaxonomy.groupsFor(type).isEmpty
                          ? _entry.workout.muscleGroups
                          : WorkoutTaxonomy.groupsFor(type).join(', '),
                      regionKey: _entry.workout.regionKey,
                      groupKey: _entry.workout.groupKey,
                      subgroupKey: _entry.workout.subgroupKey,
                      specificMuscleKey: _entry.workout.specificMuscleKey,
                      equipmentKey: _entry.workout.equipmentKey,
                      durationMinutes: int.tryParse(duration.text),
                      notes: notes.text.trim(),
                    ),
                  );
                  if (context.mounted) Navigator.pop(context, true);
                },
                child: const Text('Guardar alterações'),
              ),
            ],
          ),
        ),
      ),
    );
    duration.dispose();
    notes.dispose();
    if (saved == true) await _reload();
  }

  Future<void> _deleteWorkout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apagar treino'),
        content: const Text('Tens a certeza que queres apagar este treino?'),
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
      await widget.database.deleteWorkout(_entry.workout.id!);
      if (mounted) Navigator.pop(context, true);
    }
  }

  Future<void> _addExercise() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(builder: (_) => const CanonicalCoreSearchScreen()),
    );
  }

  Future<void> _openSetForm({
    required int exerciseId,
    required String exerciseName,
    WorkoutSet? existing,
  }) async {
    final setsForExercise = _entry.sets
        .where((set) => set.exerciseId == exerciseId)
        .toList();
    final nextSetNumber = setsForExercise.length + 1;
    final setNumber = TextEditingController(
      text: (existing?.setNumber ?? nextSetNumber).toString(),
    );
    final weight = TextEditingController(
      text: existing?.weightKg?.toString() ?? '',
    );
    final reps = TextEditingController(text: existing?.reps.toString() ?? '');
    final rpe = TextEditingController(text: existing?.rpe?.toString() ?? '');
    final notes = TextEditingController(text: existing?.notes ?? '');
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => Padding(
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
              existing == null ? 'Adicionar série' : 'Editar série',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(exerciseName),
            const SizedBox(height: 12),
            TextField(
              controller: setNumber,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Número da série'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: weight,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Peso em kg'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: reps,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Repetições'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: rpe,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'RPE 1 a 10'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: notes,
              decoration: const InputDecoration(labelText: 'Notas opcionais'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () async {
                final set = WorkoutSet(
                  id: existing?.id,
                  workoutId: _entry.workout.id,
                  exerciseId: exerciseId,
                  setNumber: int.tryParse(setNumber.text) ?? nextSetNumber,
                  weightKg: _num(weight),
                  reps: int.tryParse(reps.text) ?? 0,
                  rpe: _num(rpe),
                  notes: notes.text.trim(),
                );
                if (existing == null) {
                  await widget.database.insertWorkoutSet(set);
                } else {
                  await widget.database.updateWorkoutSet(set);
                }
                if (context.mounted) Navigator.pop(context, true);
              },
              child: Text(
                existing == null ? 'Guardar série' : 'Guardar alterações',
              ),
            ),
          ],
        ),
      ),
    );
    for (final controller in [setNumber, weight, reps, rpe, notes]) {
      controller.dispose();
    }
    if (saved == true) await _reload();
  }

  Future<void> _deleteSet(WorkoutSet set) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apagar série'),
        content: const Text('Tens a certeza que queres apagar esta série?'),
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
      await widget.database.deleteWorkoutSet(set.id!);
      await _reload();
    }
  }

  Future<void> _reload() async {
    final workouts = await widget.database.workouts();
    final updated = workouts.firstWhere(
      (entry) => entry.workout.id == _entry.workout.id,
      orElse: () => _entry,
    );
    setState(() => _entry = updated);
  }

  double? _num(TextEditingController controller) {
    final text = controller.text.trim().replaceAll(',', '.');
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }
}

class _ExerciseBlock {
  _ExerciseBlock({
    required this.exerciseId,
    required this.name,
    this.muscleGroup,
    required this.sets,
  });

  final int exerciseId;
  final String name;
  final String? muscleGroup;
  final List<WorkoutSet> sets;
}
