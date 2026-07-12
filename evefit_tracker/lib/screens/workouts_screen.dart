import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/workout.dart';
import '../services/clean_base_config.dart';
import '../widgets/workout_card.dart';
import 'workout_detail_screen.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key, required this.database});
  final AppDatabase database;

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  late Future<List<WorkoutEntry>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = widget.database.workouts();
  }

  void _refresh() {
    setState(() {
      _dataFuture = widget.database.workouts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<WorkoutEntry>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    const Text('Erro ao carregar treinos. Tenta novamente.'),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _refresh,
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final workouts = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Treinos',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _addWorkout,
                      icon: const Icon(Icons.add),
                      label: const Text('Criar treino'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (workouts.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Ainda não há treinos guardados. Cria o primeiro treino para começar a acompanhar o teu progresso.',
                    ),
                  ),
                ),
              for (final entry in workouts)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WorkoutDetailScreen(
                            database: widget.database,
                            entry: entry,
                          ),
                        ),
                      );
                      _refresh();
                    },
                    child: WorkoutCard(entry: entry),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addWorkout() async {
    await _openCleanBaseWorkoutForm();
  }

  Future<void> _openCleanBaseWorkoutForm() async {
    var date = DateTime.now();
    final workoutName = TextEditingController(text: 'Treino livre');
    final duration = TextEditingController();
    final notes = TextEditingController();
    final savedEntry = await showModalBottomSheet<WorkoutEntry>(
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
                'Novo treino',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(CleanBaseConfig.filtersRebuildTitle),
                      SizedBox(height: 6),
                      Text(CleanBaseConfig.filtersRebuildMessage),
                    ],
                  ),
                ),
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
                  if (picked != null) {
                    setSheetState(() => date = picked);
                  }
                },
                icon: const Icon(Icons.calendar_today_outlined),
                label: Text(
                  '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: workoutName,
                decoration: const InputDecoration(
                  labelText: 'Nome do treino',
                  prefixIcon: Icon(Icons.edit_outlined),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: duration,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Duracao em minutos',
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
                  final workout = Workout(
                    date: date,
                    workoutType: workoutName.text.trim().isEmpty
                        ? 'Treino livre'
                        : workoutName.text.trim(),
                    muscleGroups: '',
                    durationMinutes: int.tryParse(duration.text),
                    notes: notes.text.trim(),
                  );
                  final id = await widget.database.insertWorkout(workout);
                  final entries = await widget.database.workouts();
                  final entry = entries.firstWhere(
                    (item) => item.workout.id == id,
                    orElse: () => WorkoutEntry(
                      workout: Workout(
                        id: id,
                        date: workout.date,
                        workoutType: workout.workoutType,
                        muscleGroups: workout.muscleGroups,
                        durationMinutes: workout.durationMinutes,
                        notes: workout.notes,
                      ),
                      sets: const [],
                    ),
                  );
                  if (context.mounted) Navigator.pop(context, entry);
                },
                child: const Text('Guardar treino'),
              ),
            ],
          ),
        ),
      ),
    );
    workoutName.dispose();
    duration.dispose();
    notes.dispose();
    if (savedEntry != null && mounted) {
      _refresh();
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              WorkoutDetailScreen(database: widget.database, entry: savedEntry),
        ),
      );
      _refresh();
    }
  }
}
