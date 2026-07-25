import '../data/canonical_registry.dart';
import '../models/canonical_core_models.dart';
import '../models/canonical_exercise_selection_path.dart';
import '../models/canonical_exercise_models.dart';
import '../models/training_intention_models.dart';
import '../repositories/canonical_exercise_search_repository.dart';
import 'canonical_selection_compatibility_provider.dart';

enum HierarchicalCanonicalSearchStep {
  usageContext,
  capabilityRoot,
  trainingConcept,
  trainingIntention,
  results,
}

class HierarchicalCanonicalSearchController {
  HierarchicalCanonicalSearchController({
    this.compatibilityProvider =
        const RegistryCanonicalSelectionCompatibilityProvider(),
    this.exerciseRepository =
        const GeneratedCanonicalExerciseSearchRepository(),
  });

  final CanonicalSelectionCompatibilityProvider compatibilityProvider;
  final CanonicalExerciseSearchRepository<CanonicalResolvedExercise>
  exerciseRepository;

  CanonicalExerciseSelectionPath _path = const CanonicalExerciseSelectionPath();
  HierarchicalCanonicalSearchStep _step =
      HierarchicalCanonicalSearchStep.usageContext;

  CanonicalExerciseSelectionPath get path => _path;
  HierarchicalCanonicalSearchStep get step => _step;
  CanonicalSearchQuery get currentQuery => _path.toQuery();

  List<CanonicalPillarDefinition> get activeUsageContexts =>
      compatibilityProvider.activeUsageContexts();

  List<CanonicalPillarDefinition> get compatibleCapabilities =>
      compatibilityProvider.compatibleCapabilities(_path);

  List<CanonicalPillarDefinition> get compatibleTrainingConcepts =>
      compatibilityProvider.compatibleTrainingConcepts(_path);

  List<CanonicalResolvedPathIntention> get compatibleTrainingIntentions =>
      compatibilityProvider.compatibleTrainingIntentions(_path);

  CanonicalPillarDefinition? get selectedUsageContext =>
      _definition(_path.usageContextId);

  CanonicalPillarDefinition? get selectedCapabilityRoot =>
      _definition(_path.capabilityRootId);

  CanonicalPillarDefinition? get selectedTrainingConcept =>
      _definition(_path.trainingConceptId);

  CanonicalPillarDefinition? get selectedTrainingIntention =>
      _definition(_path.trainingIntentionId);

  Future<CanonicalSearchResult<CanonicalResolvedExercise>>
  searchSelectedExercises() => exerciseRepository.search(currentQuery);

  void selectUsageContext(String id) {
    _requireOption(activeUsageContexts, id);
    _path = _path.selectUsageContext(id);
    _step = HierarchicalCanonicalSearchStep.capabilityRoot;
  }

  void selectCapabilityRoot(String id) {
    if (_path.usageContextId == null) {
      throw StateError('A usage context must be selected first.');
    }
    _requireOption(compatibleCapabilities, id);
    _path = _path.selectCapabilityRoot(id);
    _step = HierarchicalCanonicalSearchStep.trainingConcept;
  }

  void selectTrainingConcept(String id) {
    if (_path.capabilityRootId == null) {
      throw StateError('A capability root must be selected first.');
    }
    _requireOption(compatibleTrainingConcepts, id);
    _path = _path.selectTrainingConcept(id);
    _step = HierarchicalCanonicalSearchStep.trainingIntention;
  }

  void selectTrainingIntention(String id) {
    if (_path.trainingConceptId == null) {
      throw StateError('A training concept must be selected first.');
    }
    if (!compatibleTrainingIntentions.any(
      (option) => option.definition.pillar.id == id,
    )) {
      throw StateError('Canonical intention $id is not active for this path.');
    }
    _path = _path.selectTrainingIntention(id);
    _step = HierarchicalCanonicalSearchStep.results;
  }

  bool goBack() {
    switch (_step) {
      case HierarchicalCanonicalSearchStep.usageContext:
        return false;
      case HierarchicalCanonicalSearchStep.capabilityRoot:
        _step = HierarchicalCanonicalSearchStep.usageContext;
        return true;
      case HierarchicalCanonicalSearchStep.trainingConcept:
        _step = HierarchicalCanonicalSearchStep.capabilityRoot;
        return true;
      case HierarchicalCanonicalSearchStep.trainingIntention:
        _step = HierarchicalCanonicalSearchStep.trainingConcept;
        return true;
      case HierarchicalCanonicalSearchStep.results:
        _step = HierarchicalCanonicalSearchStep.trainingIntention;
        return true;
    }
  }

  void goToUsageContext() {
    _step = HierarchicalCanonicalSearchStep.usageContext;
  }

  void goToCapabilityRoot() {
    if (_path.usageContextId == null) return;
    _step = HierarchicalCanonicalSearchStep.capabilityRoot;
  }

  void goToTrainingConcept() {
    if (_path.capabilityRootId == null) return;
    _step = HierarchicalCanonicalSearchStep.trainingConcept;
  }

  void goToTrainingIntention() {
    if (_path.trainingConceptId == null) return;
    _step = HierarchicalCanonicalSearchStep.trainingIntention;
  }

  void goToRoot() {
    _path = const CanonicalExerciseSelectionPath();
    _step = HierarchicalCanonicalSearchStep.usageContext;
  }

  void clear() => goToRoot();

  void goHome() => goToRoot();

  CanonicalPillarDefinition? _definition(String? id) =>
      id == null ? null : const CanonicalRegistry().valueById[id];

  void _requireOption(List<CanonicalPillarDefinition> values, String id) {
    if (!values.any((value) => value.id == id)) {
      throw StateError('Canonical option $id is not active for this step.');
    }
  }
}
