import '../models/exercise.dart';
import 'exercise_catalog_context_service.dart';
import 'training_architecture.dart';
import 'workout_taxonomy.dart';

class ExerciseMuscleNodes {
  const ExerciseMuscleNodes({required this.primary, required this.secondary});

  final String primary;
  final String secondary;
}

class ExerciseMuscleNodeService {
  const ExerciseMuscleNodeService._();

  static ExerciseMuscleNodes nodesForCatalogEntry(ExerciseCatalogEntry entry) {
    return nodesForExercise(entry.toExercise());
  }

  static ExerciseMuscleNodes nodesForExercise(Exercise exercise) {
    final key = WorkoutTaxonomy.normalize(exercise.name);
    final group = WorkoutTaxonomy.normalize(exercise.muscleGroup);

    final override = _override(key, group);
    if (override != null) return override;

    final tags = TrainingArchitecture.tagsForExercise(exercise);
    final primary = _namesForMuscles(tags.muscleKeys).toList();
    if (primary.isNotEmpty) {
      return ExerciseMuscleNodes(
        primary: _join(primary),
        secondary: _secondaryFallback(exercise, primary),
      );
    }

    return ExerciseMuscleNodes(
      primary: _primaryByGroup(exercise.muscleGroup),
      secondary: exercise.secondaryMuscleGroups.trim(),
    );
  }

  static ExerciseMuscleNodes? _override(String name, String group) {
    if (name == 'curl martelo') {
      return const ExerciseMuscleNodes(
        primary: 'Braquial, Braquiorradial',
        secondary:
            'Bíceps cabeça longa, Bíceps cabeça curta, Flexores do antebraço',
      );
    }
    if (name == 'curl zottman') {
      return const ExerciseMuscleNodes(
        primary:
            'Bíceps cabeça longa, Bíceps cabeça curta, Braquial, Braquiorradial',
        secondary: 'Extensores do antebraço, Flexores do antebraço',
      );
    }
    if (name == 'curl inverso' || name == 'curl inverso com halteres') {
      return const ExerciseMuscleNodes(
        primary: 'Braquiorradial, Braquial, Extensores do antebraço',
        secondary: 'Bíceps cabeça longa, Bíceps cabeça curta',
      );
    }
    if (name == 'wrist curl') {
      return const ExerciseMuscleNodes(
        primary: 'Flexores do antebraço, Punho',
        secondary: 'Mão e dedos',
      );
    }
    if (name == 'reverse wrist curl') {
      return const ExerciseMuscleNodes(
        primary: 'Extensores do antebraço, Punho',
        secondary: 'Braquiorradial',
      );
    }
    if (name == 'farmer walk') {
      return const ExerciseMuscleNodes(
        primary: 'Força de pega, Flexores do antebraço, Mão e dedos',
        secondary: 'Trapézio superior, Core, Estabilizadores da coluna',
      );
    }
    if (name == 'farmer hold' || name == 'hold estatico com halteres') {
      return const ExerciseMuscleNodes(
        primary: 'Força de pega, Flexores do antebraço, Mão e dedos',
        secondary: 'Trapézio superior, Core, Deltoides',
      );
    }
    if (name == 'triceps testa com halteres' ||
        name == 'triceps testa com barra ez' ||
        name == 'extensao de triceps deitado com halteres' ||
        name == 'extensao francesa com halter' ||
        name == 'extensao francesa com barra ez' ||
        name == 'extensao francesa no cabo') {
      return const ExerciseMuscleNodes(
        primary: 'Tríceps cabeça longa',
        secondary: 'Tríceps cabeça lateral, Tríceps cabeça medial',
      );
    }
    if (name == 'kickback de triceps' || name == 'kickback no cabo') {
      return const ExerciseMuscleNodes(
        primary: 'Tríceps cabeça lateral, Tríceps cabeça medial',
        secondary: 'Tríceps cabeça longa',
      );
    }
    if (group == 'biceps') {
      return const ExerciseMuscleNodes(
        primary: 'Bíceps cabeça longa, Bíceps cabeça curta, Braquial',
        secondary: 'Braquiorradial, Flexores do antebraço',
      );
    }
    if (group == 'triceps') {
      return const ExerciseMuscleNodes(
        primary:
            'Tríceps cabeça longa, Tríceps cabeça lateral, Tríceps cabeça medial',
        secondary: 'Deltoide anterior, Core',
      );
    }
    if (group == 'antebraco pega') {
      return const ExerciseMuscleNodes(
        primary:
            'Força de pega, Flexores do antebraço, Extensores do antebraço',
        secondary: 'Punho, Mão e dedos',
      );
    }
    return null;
  }

  static Iterable<String> _namesForMuscles(Set<String> keys) sync* {
    for (final key in keys) {
      yield switch (key) {
        'biceps' => 'Bíceps',
        'brachialis' => 'Braquial',
        'brachioradialis' => 'Braquiorradial',
        'triceps_long' => 'Tríceps cabeça longa',
        'triceps_lateral' => 'Tríceps cabeça lateral',
        'triceps_medial' => 'Tríceps cabeça medial',
        'grip_support' => 'Força de pega',
        'pinch_grip' => 'Mão e dedos',
        'upper_chest' => 'Peitoral superior',
        'mid_chest' => 'Peitoral médio',
        'lower_chest' => 'Peitoral inferior',
        'serratus_anterior' => 'Serrátil anterior',
        'lats' => 'Grande dorsal',
        'rhomboids' => 'Romboides',
        'deltoid_lateral' => 'Deltoide lateral',
        'anterior_deltoid' => 'Deltoide anterior',
        'posterior_deltoid' => 'Deltoide posterior',
        'scapular_stabilizers' => 'Estabilizadores da escápula',
        'external_rotators' => 'Manguito rotador',
        'internal_rotators' => 'Manguito rotador',
        'upper_traps' => 'Trapézio superior',
        'mid_traps' => 'Trapézio médio',
        'lower_traps' => 'Trapézio inferior',
        'cervical_stabilizers' => 'Estabilizadores cervicais',
        'sternocleidomastoid' => 'Flexores cervicais',
        'glute_max' => 'Glúteo máximo',
        'glute_med' => 'Glúteo médio',
        'glute_min' => 'Glúteo mínimo',
        'piriformis' => 'Abdutores',
        'rectus_femoris' => 'Reto femoral',
        'vastus_lateralis' => 'Vasto lateral',
        'vastus_medialis' => 'Vasto medial',
        'biceps_femoris' => 'Bíceps femoral',
        'semitendinosus' => 'Semitendinoso',
        'semimembranosus' => 'Semimembranoso',
        'adductor_longus' => 'Adutores',
        'adductor_magnus' => 'Adutores',
        'calves' => 'Gémeos',
        'soleus' => 'Sóleo',
        'tibialis_anterior' => 'Tibial anterior',
        'rectus_abdominis' => 'Reto abdominal',
        'transverse_abdominis' => 'Transverso abdominal',
        'external_obliques' => 'Oblíquos',
        'internal_obliques' => 'Oblíquos',
        'erectors' => 'Eretores da espinha',
        'quadratus_lumborum' => 'Quadrado lombar',
        'deep_stability' => 'Multífidos',
        'anti_rotation' => 'Estabilidade do core',
        'anti_extension' => 'Estabilidade do core',
        'aerobic_endurance' => 'Sistema cardiovascular',
        'karate_technical' => 'Coordenação técnica',
        'jiu_jitsu_technical' => 'Coordenação técnica',
        _ => key,
      };
    }
  }

  static String _primaryByGroup(String group) {
    final normalized = WorkoutTaxonomy.normalize(group);
    if (normalized == 'peito') {
      return 'Peitoral superior, Peitoral médio, Peitoral inferior';
    }
    if (normalized == 'costas') return 'Grande dorsal, Romboides';
    if (normalized == 'lombar') {
      return 'Eretores da espinha, Quadrado lombar';
    }
    if (normalized == 'ombros') {
      return 'Deltoide anterior, Deltoide lateral, Deltoide posterior';
    }
    if (normalized == 'trapezio') {
      return 'Trapézio superior, Trapézio médio, Trapézio inferior';
    }
    if (normalized == 'pescoco') {
      return 'Flexores cervicais, Extensores cervicais, Estabilizadores cervicais';
    }
    if (normalized == 'pernas') {
      return 'Reto femoral, Vasto lateral, Glúteo máximo';
    }
    if (normalized == 'core') {
      return 'Reto abdominal, Oblíquos, Transverso abdominal';
    }
    if (normalized == 'cardio') return 'Sistema cardiovascular';
    if (normalized == 'karate') return 'Coordenação técnica';
    if (normalized == 'jiu jitsu') return 'Coordenação técnica';
    if (normalized == 'mobilidade') return 'Mobilidade articular';
    return group;
  }

  static String _secondaryFallback(Exercise exercise, List<String> primary) {
    final raw = exercise.secondaryMuscleGroups.trim();
    if (raw.isEmpty) return '';
    final values = raw
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty && !primary.contains(item))
        .toList();
    return _join(values);
  }

  static String _join(Iterable<String> values) {
    final seen = <String>{};
    final unique = <String>[];
    for (final value in values) {
      final text = value.trim();
      if (text.isEmpty) continue;
      if (seen.add(WorkoutTaxonomy.normalize(text))) unique.add(text);
    }
    return unique.join(', ');
  }
}
