import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';
import '../models/exercise.dart';
import '../models/workout_set.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe do treino')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addSet,
        icon: const Icon(Icons.add),
        label: const Text('Adicionar série'),
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
          if (_entry.sets.isEmpty)
            const Text('Ainda não há séries neste treino.'),
          for (final set in _entry.sets)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: ListTile(
                  title: Text(set.exerciseName ?? 'Exercício'),
                  subtitle: Text(
                    'Série ${set.setNumber} · ${set.weightKg?.toStringAsFixed(1) ?? '-'} kg · ${set.reps} reps · RPE ${set.rpe?.toStringAsFixed(1) ?? '-'}'
                    '${set.notes.isEmpty ? '' : '\n${set.notes}'}',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _addSet() async {
    final exercises = await widget.database.exercises();
    if (!mounted || exercises.isEmpty) return;
    var exercise = exercises.first;
    final setNumber = TextEditingController(
      text: '${_entry.totalSetCount + 1}',
    );
    final weight = TextEditingController();
    final reps = TextEditingController(text: '10');
    final rpe = TextEditingController(text: '8');
    final notes = TextEditingController();
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
                'Adicionar série',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Exercise>(
                initialValue: exercise,
                items: exercises
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text('${item.name} · ${item.muscleGroup}'),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    setSheetState(() => exercise = value ?? exercise),
                decoration: const InputDecoration(labelText: 'Exercício'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: setNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Número da série'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: weight,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Peso kg'),
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
                  await widget.database.insertWorkoutSet(
                    WorkoutSet(
                      workoutId: _entry.workout.id,
                      exerciseId: exercise.id!,
                      setNumber: int.tryParse(setNumber.text) ?? 1,
                      weightKg: _num(weight),
                      reps: int.tryParse(reps.text) ?? 0,
                      rpe: _num(rpe),
                      notes: notes.text.trim(),
                    ),
                  );
                  if (context.mounted) Navigator.pop(context, true);
                },
                child: const Text('Guardar série'),
              ),
            ],
          ),
        ),
      ),
    );
    for (final controller in [setNumber, weight, reps, rpe, notes]) {
      controller.dispose();
    }
    if (saved == true) {
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
