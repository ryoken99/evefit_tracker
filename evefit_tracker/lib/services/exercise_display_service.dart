import '../models/exercise.dart';

class ExerciseDisplayService {
  const ExerciseDisplayService._();

  static String subtitleForList(Exercise exercise) {
    final parts = _limitedMuscleParts(exercise.primaryDisplayMuscles);
    final equipment = exercise.equipment.trim();
    if (equipment.isNotEmpty) parts.add(equipment);
    return parts.join(' · ');
  }

  static List<String> primaryMuscles(Exercise exercise) =>
      _muscleParts(exercise.primaryDisplayMuscles);

  static List<String> secondaryMuscles(Exercise exercise) =>
      _muscleParts(exercise.secondaryMuscleNodes ?? '');

  static List<String> _limitedMuscleParts(String value) {
    final muscles = _muscleParts(value);
    if (muscles.length <= 3) return muscles;
    return [...muscles.take(2), '+${muscles.length - 2}'];
  }

  static List<String> _muscleParts(String value) {
    return value
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }
}
