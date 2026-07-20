import '../data/canonical_registry.dart';
import '../models/canonical_core_models.dart';
import '../models/training_intention_models.dart';

class CanonicalCoreNavigationController {
  CanonicalCoreNavigationController({
    this.registry = const CanonicalRegistry(),
  });

  final CanonicalRegistry registry;
  CanonicalPillarAxisDefinition? _selectedAxis;
  CanonicalPillarDefinition? _selectedValue;
  CanonicalPillarDefinition? _selectedGlobalIntention;
  CanonicalTrainingPathDefinition? _selectedGlobalIntentionPath;

  CanonicalPillarAxisDefinition? get selectedAxis => _selectedAxis;
  CanonicalPillarDefinition? get selectedValue => _selectedValue;
  CanonicalPillarDefinition? get selectedGlobalIntention =>
      _selectedGlobalIntention;
  CanonicalTrainingPathDefinition? get selectedGlobalIntentionPath =>
      _selectedGlobalIntentionPath;
  bool get isAtRoot => _selectedAxis == null;

  List<CanonicalPillarDefinition> get availableValues => _selectedAxis == null
      ? const []
      : registry.valuesForAxis(_selectedAxis!.axis);

  void selectAxis(CanonicalPillarAxis axis) {
    _selectedAxis = CanonicalRegistry.axisDefinitions.singleWhere(
      (definition) => definition.axis == axis,
    );
    _selectedValue = null;
    _selectedGlobalIntention = null;
    _selectedGlobalIntentionPath = null;
  }

  CanonicalSearchQuery selectValue(String id) {
    final axis = _selectedAxis;
    if (axis == null) throw StateError('Select a canonical pillar axis first.');
    if (axis.axis == CanonicalPillarAxis.trainingIntention) {
      throw StateError(
        'A training intention must be selected through a compatible path.',
      );
    }
    final value = registry.valueById[id];
    if (value == null || value.axis != axis.axis) {
      throw StateError('Value $id is not available for ${axis.axis.name}.');
    }
    _selectedValue = value;
    return CanonicalSearchQuery(
      criteria: [CanonicalSearchCriterion(axis: value.axis, valueId: value.id)],
    );
  }

  void selectGlobalIntention(String id) {
    final axis = _selectedAxis;
    if (axis?.axis != CanonicalPillarAxis.trainingIntention) {
      throw StateError('Select the training intention axis first.');
    }
    final intention = registry.valueById[id];
    if (intention?.axis != CanonicalPillarAxis.trainingIntention) {
      throw StateError('Training intention $id is not available.');
    }
    _selectedGlobalIntention = intention;
    _selectedGlobalIntentionPath = null;
  }

  List<CanonicalTrainingPathDefinition> compatiblePathsForGlobalIntention(
    String intentionId,
  ) {
    final intention = registry.valueById[intentionId];
    if (intention?.axis != CanonicalPillarAxis.trainingIntention) {
      throw StateError('Training intention $intentionId is not available.');
    }
    final values = registry.valueById;
    final paths = registry
        .pathsForIntention(intentionId)
        .where((path) => path.status == CanonicalTrainingPathStatus.compatible)
        .toList(growable: false);
    return List<CanonicalTrainingPathDefinition>.unmodifiable(
      paths..sort((left, right) {
        final leftIds = [
          left.key.usageContextId,
          left.key.capabilityRootId,
          left.key.trainingConceptId,
        ];
        final rightIds = [
          right.key.usageContextId,
          right.key.capabilityRootId,
          right.key.trainingConceptId,
        ];
        for (var index = 0; index < leftIds.length; index++) {
          final comparison = values[leftIds[index]]!.displayOrder.compareTo(
            values[rightIds[index]]!.displayOrder,
          );
          if (comparison != 0) return comparison;
        }
        return left.sourceNumber.compareTo(right.sourceNumber);
      }),
    );
  }

  CanonicalSearchQuery selectGlobalIntentionPath(
    CanonicalTrainingPathDefinition path,
  ) {
    final intention = _selectedGlobalIntention;
    if (intention == null) {
      throw StateError('Select a training intention first.');
    }
    if (path.status != CanonicalTrainingPathStatus.compatible ||
        !registry.pathsForIntention(intention.id).contains(path)) {
      throw StateError('Path ${path.key.contractId} is not compatible.');
    }
    _selectedGlobalIntentionPath = path;
    return CanonicalSearchQuery(
      criteria: [
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.usageContext,
          valueId: path.key.usageContextId,
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.capabilityRoot,
          valueId: path.key.capabilityRootId,
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingConcept,
          valueId: path.key.trainingConceptId,
        ),
        CanonicalSearchCriterion(
          axis: CanonicalPillarAxis.trainingIntention,
          valueId: intention.id,
        ),
      ],
    );
  }

  bool goBack() {
    if (_selectedGlobalIntentionPath != null) {
      _selectedGlobalIntentionPath = null;
      return true;
    }
    if (_selectedGlobalIntention != null) {
      _selectedGlobalIntention = null;
      return true;
    }
    if (_selectedValue != null) {
      _selectedValue = null;
      return true;
    }
    if (_selectedAxis != null) {
      _selectedAxis = null;
      return true;
    }
    return false;
  }

  void goToRoot() {
    _selectedAxis = null;
    _selectedValue = null;
    _selectedGlobalIntention = null;
    _selectedGlobalIntentionPath = null;
  }

  void goToAxis() {
    _selectedValue = null;
    _selectedGlobalIntention = null;
    _selectedGlobalIntentionPath = null;
  }

  void goToGlobalIntentionPaths() {
    _selectedGlobalIntentionPath = null;
  }
}
