import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/models/workout.dart';
import 'package:evefit_tracker/models/workout_set.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('WorkoutEntry reports unique exercise count and total set count', () {
    final entry = WorkoutEntry(
      workout: Workout(
        id: 1,
        date: DateTime(2026, 6, 6),
        workoutType: 'Costas + Ombros',
      ),
      sets: [
        WorkoutSet(exerciseId: 10, setNumber: 1, reps: 10),
        WorkoutSet(exerciseId: 10, setNumber: 2, reps: 8),
        WorkoutSet(exerciseId: 12, setNumber: 1, reps: 12),
      ],
    );

    expect(entry.exerciseCount, 2);
    expect(entry.totalSetCount, 3);
  });
}
