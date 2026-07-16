import '../data/canonical_registry.dart';
import '../models/canonical_core_models.dart';
import '../models/canonical_exercise_selection_path.dart';

abstract interface class CanonicalSelectionCompatibilityProvider {
  List<CanonicalPillarDefinition> activeUsageContexts();

  List<CanonicalPillarDefinition> compatibleCapabilities(
    CanonicalExerciseSelectionPath path,
  );

  List<CanonicalPillarDefinition> compatibleTrainingConcepts(
    CanonicalExerciseSelectionPath path,
  );

  List<CanonicalPillarDefinition> compatibleTrainingIntentions(
    CanonicalExerciseSelectionPath path,
  );
}

class RegistryCanonicalSelectionCompatibilityProvider
    implements CanonicalSelectionCompatibilityProvider {
  const RegistryCanonicalSelectionCompatibilityProvider();

  @override
  List<CanonicalPillarDefinition> activeUsageContexts() =>
      CanonicalRegistry.approvedUsageContexts;

  @override
  List<CanonicalPillarDefinition> compatibleCapabilities(
    CanonicalExerciseSelectionPath path,
  ) => path.usageContextId == null
      ? const []
      : CanonicalRegistry.approvedCapabilityRoots;

  @override
  List<CanonicalPillarDefinition> compatibleTrainingConcepts(
    CanonicalExerciseSelectionPath path,
  ) => const [];

  @override
  List<CanonicalPillarDefinition> compatibleTrainingIntentions(
    CanonicalExerciseSelectionPath path,
  ) => const [];
}
