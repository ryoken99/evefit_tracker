import '../data/canonical_registry.dart';
import '../models/canonical_core_models.dart';
import '../models/canonical_exercise_selection_path.dart';
import '../models/training_intention_models.dart';

abstract interface class CanonicalSelectionCompatibilityProvider {
  List<CanonicalPillarDefinition> activeUsageContexts();

  List<CanonicalPillarDefinition> compatibleCapabilities(
    CanonicalExerciseSelectionPath path,
  );

  List<CanonicalPillarDefinition> compatibleTrainingConcepts(
    CanonicalExerciseSelectionPath path,
  );

  List<CanonicalResolvedPathIntention> compatibleTrainingIntentions(
    CanonicalExerciseSelectionPath path,
  );
}

class RegistryCanonicalSelectionCompatibilityProvider
    implements CanonicalSelectionCompatibilityProvider {
  const RegistryCanonicalSelectionCompatibilityProvider({
    this.registry = const CanonicalRegistry(),
  });

  final CanonicalRegistry registry;

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
  ) {
    if (path.usageContextId == null) return const [];
    final capabilityId = path.capabilityRootId;
    return capabilityId == null
        ? const []
        : registry.trainingConceptsForPath(path.usageContextId!, capabilityId);
  }

  @override
  List<CanonicalResolvedPathIntention> compatibleTrainingIntentions(
    CanonicalExerciseSelectionPath path,
  ) {
    final key = path.trainingPathKey;
    return key == null || !registry.hasCompatibleResolvedOptions(key)
        ? const []
        : registry.resolvedOptionsForPath(key);
  }
}
