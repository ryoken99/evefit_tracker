import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.entry});
  final WorkoutEntry entry;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy').format(entry.workout.date);
    return Card(
      child: ListTile(
        title: Text(entry.workout.workoutType),
        subtitle: Text(
          '$date · ${entry.workout.durationMinutes ?? 0} min\n${entry.sets.map((s) => '${s.exerciseName}: ${s.weightKg ?? 0} kg x ${s.reps} reps RPE ${s.rpe ?? '-'}').join('\n')}',
        ),
        isThreeLine: true,
      ),
    );
  }
}
