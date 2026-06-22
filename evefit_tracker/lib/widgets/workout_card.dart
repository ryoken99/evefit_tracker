import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';
import '../services/training_architecture.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.entry});

  final WorkoutEntry entry;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy').format(entry.workout.date);
    final currentGroups = TrainingArchitecture.summaryForSelection(
      TrainingSelection(
        regionKey: entry.workout.regionKey,
        groupKey: entry.workout.groupKey,
        subgroupKey: entry.workout.subgroupKey,
        specificMuscleKey: entry.workout.specificMuscleKey,
        equipmentKey: entry.workout.equipmentKey,
      ),
    );
    final muscleGroups = currentGroups.isEmpty
        ? entry.workout.muscleGroups
        : currentGroups;
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
