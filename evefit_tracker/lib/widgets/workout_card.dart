import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.entry});

  final WorkoutEntry entry;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy').format(entry.workout.date);
    final muscleGroups = entry.workout.muscleGroups;
    return Card(
      child: ListTile(
        title: Text(entry.workout.workoutType),
        subtitle: Text(
          '$date · ${entry.workout.durationMinutes ?? 0} min · ${entry.exerciseCount} exercícios · ${entry.totalSetCount} séries'
          '${muscleGroups.isEmpty ? '' : '\n$muscleGroups'}'
          '${entry.workout.notes.isEmpty ? '' : '\n${entry.workout.notes}'}',
        ),
        isThreeLine: entry.workout.notes.isNotEmpty || muscleGroups.isNotEmpty,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
