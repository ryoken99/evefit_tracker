import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';
import '../database/seed_data.dart';
import '../features/canonical_search/screens/canonical_search_menu_screen.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../models/workout_exercise.dart';
import '../models/workout_set.dart';
import '../services/clean_base_config.dart';
import '../services/exercise_display_service.dart';
import '../services/exercise_filter_service.dart';
import '../services/training_architecture.dart';
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
    final typeOptions = {type, ...SeedData.workoutTypes}.toList();
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
    if (!CleanBaseConfig.legacyCatalogueVisible) {
      if (CleanBaseConfig.canonicalSearchMenuVisible) {
        await Navigator.of(context).push<void>(
          MaterialPageRoute(builder: (_) => const CanonicalSearchMenuScreen()),
        );
        return null;
      }
      await showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (context) => const SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(CleanBaseConfig.catalogueRebuildTitle),
                SizedBox(height: 8),
                Text(CleanBaseConfig.catalogueRebuildMessage),
              ],
            ),
          ),
        ),
      );
      return null;
    }
    final exercises = await widget.database.exercises();
    final profile = widget.database.activeProfile;
    final equipment = await widget.database.availableEquipmentKeys();
    if (!mounted || exercises.isEmpty) return null;
    var query = '';
    var filter = filters.first;
    var showAll = false;
    final selection = _selectionForWorkout(_entry.workout);
    return showModalBottomSheet<Exercise>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          final base = ExerciseFilterService.getAvailableExercises(
            exercises: exercises,
            trainingLocation: profile?.trainingLocation ?? '',
            availableEquipmentKeys: equipment,
            selection: selection,
            showAllExercises: showAll,
          );
          final filterOptions =
              ExerciseFilterService.contextualFiltersForSelection(
                exercises: exercises,
                trainingLocation: profile?.trainingLocation ?? '',
                availableEquipmentKeys: equipment,
                selection: selection,
                showAll: showAll,
              );
          if (!filterOptions.contains(filter)) {
            filter = filterOptions.first;
          }
          final visible = base.where((item) {
            final exercise = item.exercise;
            final matchesQuery = ExerciseFilterService.matchesSearchQuery(
              exercise,
              query,
            );
            return matchesQuery &&
                (showAll || _matchesFilter(exercise, filter));
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
                  if (filterOptions.length > 2) ...[
                    DropdownButtonFormField<String>(
                      initialValue: filter,
                      items: filterOptions
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setSheetState(
                        () => filter = value ?? filterOptions.first,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Grupo muscular',
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  Expanded(
                    child: visible.isEmpty
                        ? const Center(
                            child: Text(
                              ExerciseFilterService.emptyStateMessage,
                            ),
                          )
                        : ListView.builder(
                            itemCount: visible.length,
                            itemBuilder: (context, index) {
                              final item = visible[index];
                              final exercise = item.exercise;
                              return ListTile(
                                enabled: item.isAvailable || showAll,
                                isThreeLine: !item.isAvailable && showAll,
                                title: Text(exercise.name),
                                subtitle: Text(
                                  !item.isAvailable && showAll
                                      ? '${ExerciseDisplayService.subtitleForList(exercise)}\n${item.unavailableReason}'
                                      : ExerciseDisplayService.subtitleForList(
                                          exercise,
                                        ),
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
    final secondary = exercise.secondaryMuscleGroups.toLowerCase();
    final haystack = '$name $group $secondary';
    return switch (filter) {
      'Bíceps' => group.contains('bíceps'),
      'Tríceps' => group.contains('tríceps'),
      'Antebraço/Pega' => group.contains('antebraço') || group.contains('pega'),
      'Core' => group.contains('core') || group.contains('abdominal'),
      'Cardio' => name.contains('passadeira') || group.contains('cardio'),
      'Reto abdominal' =>
        haystack.contains('reto abdominal') || name.contains('crunch'),
      'Oblíquos' => haystack.contains('oblíqu') || name.contains('twist'),
      'Transverso abdominal' =>
        haystack.contains('transverso') || name.contains('vacuum'),
      'Anti-rotação' =>
        haystack.contains('anti-rotação') || name.contains('pallof'),
      'Anti-extensão' =>
        haystack.contains('anti-extensão') ||
            name.contains('hollow') ||
            name.contains('prancha'),
      'Lombar' => haystack.contains('lombar'),
      'Estabilidade do core' =>
        haystack.contains('estabilidade') ||
            name.contains('dead bug') ||
            name.contains('bird dog'),
      'Aquecimento' => name.contains('aquecimento'),
      'Caminhada' => name.contains('caminhada'),
      'Corrida leve' => name.contains('corrida leve'),
      'Intervalos' => name.contains('interval') || name.contains('sprint'),
      'Inclinação' => name.contains('inclinação'),
      'Cooldown' => name.contains('cooldown'),
      'Braquial' => haystack.contains('braquial'),
      'Braquiorradial' => haystack.contains('braquiorradial'),
      'Antebraço relacionado' =>
        haystack.contains('antebraço') || haystack.contains('pega'),
      'Outro' => false,
      _ => group.contains(filter.toLowerCase()),
    };
  }

  TrainingSelection _selectionForWorkout(Workout workout) {
    if (workout.regionKey.isNotEmpty ||
        workout.groupKey.isNotEmpty ||
        workout.subgroupKey.isNotEmpty ||
        workout.specificMuscleKey.isNotEmpty ||
        workout.equipmentKey.isNotEmpty) {
      return TrainingSelection(
        regionKey: workout.regionKey,
        groupKey: workout.groupKey,
        subgroupKey: workout.subgroupKey,
        specificMuscleKey: workout.specificMuscleKey,
        equipmentKey: workout.equipmentKey,
      );
    }
    return TrainingArchitecture.legacySelectionFor(workout.workoutType);
  }

  void _showExerciseInfo(Exercise exercise) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 8, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      exercise.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Fechar',
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                children: [
                  _InfoSection(
                    title: 'Resumo',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _summaryRow(context, 'Grupo', exercise.muscleGroup),
                        _summaryRow(
                          context,
                          'Músculos',
                          ExerciseDisplayService.primaryMuscles(
                            exercise,
                          ).join(', '),
                        ),
                        _summaryRow(context, 'Equipamento', exercise.equipment),
                      ],
                    ),
                  ),
                  _InfoSection(
                    title: 'Objetivo',
                    child: Text(exercise.description),
                  ),
                  _InfoSection(
                    title: 'Como fazer',
                    child: _NumberedList(exercise.executionSteps),
                  ),
                  _InfoSection(
                    title: 'Erros comuns',
                    child: _BulletList(exercise.commonMistakes),
                  ),
                  _InfoSection(
                    title: 'Variações',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _variationRow(
                          context,
                          'Mais fácil',
                          exercise.regression,
                        ),
                        const SizedBox(height: 8),
                        _variationRow(
                          context,
                          'Mais difícil',
                          exercise.progression,
                        ),
                      ],
                    ),
                  ),
                  if (exercise.safetyNotes.trim().isNotEmpty)
                    _InfoSection(
                      title: 'Segurança',
                      child: Text(exercise.safetyNotes),
                    ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      'Mais detalhes',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    childrenPadding: const EdgeInsets.only(bottom: 12),
                    children: [
                      _InfoSection(
                        title: 'Também ajuda',
                        child: Text(
                          ExerciseDisplayService.secondaryMuscles(
                            exercise,
                          ).join(', '),
                        ),
                      ),
                      _InfoSection(
                        title: 'Respiração',
                        child: Text(exercise.breathingTips),
                      ),
                      _InfoSection(
                        title: 'Postura',
                        child: Text(exercise.postureTips),
                      ),
                      _InfoSection(
                        title: 'Quando adaptar ou evitar',
                        child: Text(exercise.adaptationNotes),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 108,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value.trim())),
        ],
      ),
    );
  }

  Widget _variationRow(BuildContext context, String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 2),
        Text(value.trim()),
      ],
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

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

/// Lista numerada vertical para os passos de execução. Aceita passos
/// separados por linha (formato atual) ou o formato antigo em parágrafo.
class _NumberedList extends StatelessWidget {
  const _NumberedList(this.steps);

  final String steps;

  @override
  Widget build(BuildContext context) {
    final lines = steps.contains('\n')
        ? steps.split('\n')
        : steps.split(RegExp(r'\s*(?=\d{1,2}\.\s)'));
    final items = lines
        .map(
          (line) => line.replaceFirst(RegExp(r'^\s*\d{1,2}\.\s*'), '').trim(),
        )
        .where((line) => line.isNotEmpty)
        .toList();
    if (items.isEmpty) return const Text('Sem informação adicional.');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  child: Text(
                    '${i + 1}.',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Expanded(child: Text(items[i])),
              ],
            ),
          ),
      ],
    );
  }
}

/// Lista com marcadores para erros comuns (um item por linha).
class _BulletList extends StatelessWidget {
  const _BulletList(this.items);

  final String items;

  @override
  Widget build(BuildContext context) {
    final lines = items
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    if (lines.isEmpty) return const Text('Sem informação adicional.');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final line in lines)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 4),
                const Text('•  '),
                Expanded(child: Text(line)),
              ],
            ),
          ),
      ],
    );
  }
}
