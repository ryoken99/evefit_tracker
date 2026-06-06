import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';
import '../database/seed_data.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../models/workout_exercise.dart';
import '../models/workout_set.dart';
import '../models/workout_type.dart';
import '../services/exercise_filter_service.dart';

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
  static const filters = [
    'Todos',
    'Costas',
    'Ombros',
    'Peito',
    'Bíceps',
    'Tríceps',
    'Antebraço/Pega',
    'Core',
    'Pernas',
    'Cardio',
    'Outro',
  ];

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
                items: SeedData.workoutTypes
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
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
    final selected = await _pickExercise();
    if (selected == null) return;
    await widget.database.insertWorkoutExercise(
      WorkoutExercise(workoutId: _entry.workout.id!, exerciseId: selected.id!),
    );
    await _reload();
    if (mounted) {
      await _openSetForm(exerciseId: selected.id!, exerciseName: selected.name);
    }
  }

  Future<Exercise?> _pickExercise() async {
    final exercises = await widget.database.exercises();
    final profile = widget.database.activeProfile;
    final equipment = await widget.database.availableEquipmentKeys();
    if (!mounted || exercises.isEmpty) return null;
    var query = '';
    var filter = filters.first;
    var showAll = false;
    final workoutType = WorkoutType(
      id: _entry.workout.workoutTypeId,
      name: _entry.workout.workoutType,
      muscleGroups: _entry.workout.muscleGroups,
      isDefault: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return showModalBottomSheet<Exercise>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          final base = ExerciseFilterService.filter(
            exercises: exercises,
            trainingLocation: profile?.trainingLocation ?? '',
            availableEquipmentKeys: equipment,
            workoutType: workoutType,
            showAllWithoutEquipment: showAll,
          );
          final visible = base.where((exercise) {
            final matchesQuery = exercise.name.toLowerCase().contains(
              query.toLowerCase(),
            );
            return matchesQuery && _matchesFilter(exercise, filter);
          }).toList();
          return Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              0,
              16,
              MediaQuery.viewInsetsOf(context).bottom + 16,
            ),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.78,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adicionar exercício',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Pesquisar exercício',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => setSheetState(() => query = value),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: showAll,
                    title: const Text('Mostrar todos os exercícios'),
                    onChanged: (value) => setSheetState(() => showAll = value),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: filter,
                    items: filters
                        .map(
                          (item) =>
                              DropdownMenuItem(value: item, child: Text(item)),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setSheetState(() => filter = value ?? filters.first),
                    decoration: const InputDecoration(
                      labelText: 'Grupo muscular',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: visible.isEmpty
                        ? const Center(
                            child: Text('Nenhum exercício encontrado.'),
                          )
                        : ListView.builder(
                            itemCount: visible.length,
                            itemBuilder: (context, index) {
                              final exercise = visible[index];
                              return ListTile(
                                title: Text(exercise.name),
                                subtitle: Text(
                                  exercise.description.isEmpty
                                      ? exercise.muscleGroup
                                      : '${exercise.muscleGroup} · ${exercise.equipment}',
                                ),
                                trailing: IconButton(
                                  tooltip: 'Explicação',
                                  icon: const Icon(Icons.info_outline),
                                  onPressed: () => _showExerciseInfo(exercise),
                                ),
                                onTap: () => Navigator.pop(context, exercise),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _matchesFilter(Exercise exercise, String filter) {
    if (filter == 'Todos') return true;
    final group = exercise.muscleGroup.toLowerCase();
    final name = exercise.name.toLowerCase();
    return switch (filter) {
      'Bíceps' => group.contains('bíceps'),
      'Tríceps' => group.contains('tríceps'),
      'Antebraço/Pega' => group.contains('antebraço') || group.contains('pega'),
      'Core' => group.contains('core') || group.contains('abdominal'),
      'Cardio' => name.contains('passadeira') || group.contains('cardio'),
      'Outro' => false,
      _ => group.contains(filter.toLowerCase()),
    };
  }

  void _showExerciseInfo(Exercise exercise) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(exercise.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoLine('Grupo principal', exercise.muscleGroup),
              _InfoLine('Grupos secundários', exercise.secondaryMuscleGroups),
              _InfoLine('Equipamento', exercise.equipment),
              _InfoLine('Descrição', exercise.description),
              _InfoLine('Execução', exercise.executionSteps),
              _InfoLine('Erros comuns', exercise.commonMistakes),
              _InfoLine('Segurança', exercise.safetyNotes),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
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

class _InfoLine extends StatelessWidget {
  const _InfoLine(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = value.trim().isEmpty
        ? 'Descrição ainda incompleta. Este exercício será melhorado numa próxima versão.'
        : value.trim();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 2),
          Text(text),
        ],
      ),
    );
  }
}
