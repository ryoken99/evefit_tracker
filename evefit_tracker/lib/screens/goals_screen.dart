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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Goal>>(
      future: widget.database.goals(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final grouped = <String, List<Goal>>{};
        for (final goal in snapshot.data!) {
          grouped.putIfAbsent(goal.phase, () => []).add(goal);
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Objetivos',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
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
                        '${goal.phase} · ${goal.completedAt == null ? 'Ativo' : 'Concluído'}',
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
            ],
          ],
        );
      },
    );
  }
}
