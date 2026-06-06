import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../database/seed_data.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../models/workout_set.dart';
import '../widgets/workout_card.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key, required this.database});
  final AppDatabase database;

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addWorkout,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<WorkoutEntry>>(
        future: widget.database.workouts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
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
              if (snapshot.data!.isEmpty)
                const Text('Ainda não há treinos guardados.'),
              for (final entry in snapshot.data!)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: WorkoutCard(entry: entry),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addWorkout() async {
    final exercises = await widget.database.exercises();
    if (!mounted) return;
    var type = SeedData.workoutTypes.first;
    var exercise = exercises.first;
    final duration = TextEditingController();
    final weight = TextEditingController();
    final reps = TextEditingController(text: '10');
    final rpe = TextEditingController(text: '8');
    final notes = TextEditingController();
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
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
                controller: duration,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Duração em minutos',
                ),
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
                  await widget.database.insertWorkoutWithSet(
                    Workout(
                      date: DateTime.now(),
                      workoutType: type,
                      durationMinutes: int.tryParse(duration.text),
                      notes: notes.text,
                    ),
                    WorkoutSet(
                      exerciseId: exercise.id!,
                      setNumber: 1,
                      weightKg: _num(weight),
                      reps: int.tryParse(reps.text) ?? 0,
                      rpe: _num(rpe),
                      notes: notes.text,
                    ),
                  );
                  if (context.mounted) Navigator.pop(context, true);
                },
                child: const Text('Guardar treino'),
              ),
            ],
          ),
        ),
      ),
    );
    for (final c in [duration, weight, reps, rpe, notes]) {
      c.dispose();
    }
    if (saved == true) setState(() {});
  }

  double? _num(TextEditingController controller) =>
      double.tryParse(controller.text.replaceAll(',', '.'));
}
