import '../data/canonical_search_menu_data.dart';
import '../models/canonical_search_models.dart';

class CanonicalSearchNavigationController {
  CanonicalSearchNavigationController({List<CanonicalSearchFilterNode>? nodes})
    : _nodes = nodes ?? CanonicalSearchMenuData.nodes,
      _pathIds = <String>[];

  final List<CanonicalSearchFilterNode> _nodes;
  final List<String> _pathIds;

  List<CanonicalSearchFilterNode> get path =>
      List.unmodifiable(_pathIds.map((id) => _byId[id]!));

  List<CanonicalSearchFilterNode> get childNodes {
    final parentId = _pathIds.isEmpty ? null : _pathIds.last;
    return _nodes
        .where((node) => node.parentId == parentId && node.isEnabled)
        .toList()
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
  }

  CanonicalSearchFilterNode? get currentNode =>
      _pathIds.isEmpty ? null : _byId[_pathIds.last];

  bool get isTerminal => currentNode?.isTerminal ?? false;
  bool get isAtRoot => _pathIds.isEmpty;

  List<CanonicalSearchCondition> get effectiveQueryConditions {
    final conditions = <CanonicalSearchCondition>[];
    final activePath = path;
    if (activePath.isNotEmpty &&
        activePath.first.axis == CanonicalSearchAxis.capabilityRoot) {
      conditions.add(
        const CanonicalSearchCondition(
          field: CanonicalSearchQueryField.usageContext,
          operator: CanonicalSearchQueryOperator.equals,
          value: 'main_training',
        ),
      );
    }
    for (final node in activePath) {
      conditions.addAll(node.queryContract.conditions);
    }
    return List.unmodifiable(conditions);
  }

  void selectNode(String id) {
    final node = _byId[id];
    if (node == null) throw StateError('Unknown canonical search node: $id.');
    final expectedParent = _pathIds.isEmpty ? null : _pathIds.last;
    if (node.parentId != expectedParent) {
      throw StateError('Node $id is not a child of the current search path.');
    }
    if (!node.isEnabled) return;
    _pathIds.add(id);
  }

  bool goBack() {
    if (_pathIds.isEmpty) return false;
    _pathIds.removeLast();
    return true;
  }

  void goToRoot() => _pathIds.clear();

  void goToAncestor(String id) {
    final index = _pathIds.indexOf(id);
    if (index < 0) throw StateError('Node $id is not in the current path.');
    _pathIds.removeRange(index + 1, _pathIds.length);
  }

  Map<String, CanonicalSearchFilterNode> get _byId => {
    for (final node in _nodes) node.id: node,
  };
}
