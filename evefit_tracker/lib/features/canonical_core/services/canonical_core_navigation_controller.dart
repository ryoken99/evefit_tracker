import '../data/canonical_registry.dart';
import '../models/canonical_core_models.dart';

class CanonicalCoreNavigationController {
  CanonicalCoreNavigationController({
    this.registry = const CanonicalRegistry(),
  });

  final CanonicalRegistry registry;
  CanonicalPillarAxisDefinition? _selectedAxis;
  CanonicalPillarDefinition? _selectedValue;

  CanonicalPillarAxisDefinition? get selectedAxis => _selectedAxis;
  CanonicalPillarDefinition? get selectedValue => _selectedValue;
  bool get isAtRoot => _selectedAxis == null;

  List<CanonicalPillarDefinition> get availableValues => _selectedAxis == null
      ? const []
      : registry.valuesForAxis(_selectedAxis!.axis);

  void selectAxis(CanonicalPillarAxis axis) {
    _selectedAxis = CanonicalRegistry.axisDefinitions.singleWhere(
      (definition) => definition.axis == axis,
    );
    _selectedValue = null;
  }

  CanonicalSearchQuery selectValue(String id) {
    final axis = _selectedAxis;
    if (axis == null) throw StateError('Select a canonical pillar axis first.');
    final value = registry.valueById[id];
    if (value == null || value.axis != axis.axis) {
      throw StateError('Value $id is not available for ${axis.axis.name}.');
    }
    _selectedValue = value;
    return CanonicalSearchQuery(
      criteria: [CanonicalSearchCriterion(axis: value.axis, valueId: value.id)],
    );
  }

  bool goBack() {
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
  }
}
