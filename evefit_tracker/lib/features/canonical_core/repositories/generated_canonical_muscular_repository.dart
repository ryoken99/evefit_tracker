import '../generated/arm_muscular_registry.g.dart';
import 'canonical_muscular_repository.dart';

class GeneratedCanonicalMuscularRepository
    extends InMemoryCanonicalMuscularRepository {
  GeneratedCanonicalMuscularRepository()
    : super(
        regions: generatedCanonicalMuscleRegions,
        groups: generatedCanonicalMuscleGroups,
        muscles: generatedCanonicalMuscles,
        components: generatedCanonicalMuscleComponents,
        joints: generatedCanonicalMuscleJoints,
        actions: generatedCanonicalMuscleActions,
        families: generatedCanonicalArmExerciseFamilies,
        equipment: generatedCanonicalArmEquipment,
        exercises: generatedCanonicalArmExercises,
        publicContents: generatedCanonicalArmExercisePublicContents,
        variants: generatedCanonicalArmExerciseVariants,
        muscleRelations: generatedCanonicalArmExerciseMuscleRelations,
      );
}
