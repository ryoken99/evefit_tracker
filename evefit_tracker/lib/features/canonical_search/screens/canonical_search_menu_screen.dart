import 'package:flutter/material.dart';

import '../data/canonical_search_menu_data.dart';
import '../models/canonical_search_models.dart';
import '../services/canonical_search_navigation_controller.dart';
import '../widgets/canonical_search_empty_state.dart';

class CanonicalSearchMenuScreen extends StatefulWidget {
  const CanonicalSearchMenuScreen({super.key, this.controller});

  final CanonicalSearchNavigationController? controller;

  @override
  State<CanonicalSearchMenuScreen> createState() =>
      _CanonicalSearchMenuScreenState();
}

class _CanonicalSearchMenuScreenState extends State<CanonicalSearchMenuScreen> {
  late final CanonicalSearchNavigationController _controller =
      widget.controller ?? CanonicalSearchNavigationController();

  void _select(CanonicalSearchFilterNode node) {
    _controller.selectNode(node.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final atRoot = _controller.isAtRoot;
    return PopScope<void>(
      canPop: atRoot,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _controller.goBack()) {
          setState(() {});
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Explorar exercícios'),
          leading: atRoot
              ? null
              : IconButton(
                  key: const ValueKey('canonical_search_back'),
                  tooltip: 'Voltar',
                  onPressed: () => setState(() => _controller.goBack()),
                  icon: const Icon(Icons.arrow_back),
                ),
          actions: [
            if (!atRoot)
              IconButton(
                key: const ValueKey('canonical_search_home'),
                tooltip: 'Explorar exercícios',
                onPressed: () => setState(_controller.goToRoot),
                icon: const Icon(Icons.home_outlined),
              ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              _Breadcrumb(
                path: _controller.path,
                onAncestorSelected: (node) =>
                    setState(() => _controller.goToAncestor(node.id)),
              ),
              Expanded(
                child: _controller.isTerminal
                    ? CanonicalSearchEmptyState(path: _controller.path)
                    : atRoot
                    ? _CanonicalSearchRoot(onSelected: _select)
                    : _CanonicalSearchChildren(
                        nodes: _controller.childNodes,
                        onSelected: _select,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CanonicalSearchRoot extends StatelessWidget {
  const _CanonicalSearchRoot({required this.onSelected});

  final ValueChanged<CanonicalSearchFilterNode> onSelected;

  @override
  Widget build(BuildContext context) {
    final roots =
        CanonicalSearchMenuData.nodes.where((node) => node.depth == 1).toList()
          ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    final capabilities = roots
        .where((node) => node.axis == CanonicalSearchAxis.capabilityRoot)
        .toList();
    final contexts = roots
        .where((node) => node.axis == CanonicalSearchAxis.usageContext)
        .toList();
    return ListView(
      key: const ValueKey('canonical_search_root_screen'),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'O que queres desenvolver?',
          key: const ValueKey('canonical_search_capabilities_section'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        for (final node in capabilities)
          _CanonicalSearchNodeCard(node: node, onSelected: onSelected),
        const SizedBox(height: 20),
        Text(
          'Para que momento ou finalidade?',
          key: const ValueKey('canonical_search_contexts_section'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        for (final node in contexts)
          _CanonicalSearchNodeCard(node: node, onSelected: onSelected),
      ],
    );
  }
}

class _CanonicalSearchChildren extends StatelessWidget {
  const _CanonicalSearchChildren({
    required this.nodes,
    required this.onSelected,
  });

  final List<CanonicalSearchFilterNode> nodes;
  final ValueChanged<CanonicalSearchFilterNode> onSelected;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      for (final node in nodes)
        _CanonicalSearchNodeCard(node: node, onSelected: onSelected),
    ],
  );
}

class _CanonicalSearchNodeCard extends StatelessWidget {
  const _CanonicalSearchNodeCard({
    required this.node,
    required this.onSelected,
  });

  final CanonicalSearchFilterNode node;
  final ValueChanged<CanonicalSearchFilterNode> onSelected;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Semantics(
      button: true,
      enabled: node.isEnabled,
      label: node.displayNamePtPt,
      child: Card(
        child: InkWell(
          key: ValueKey('canonical_search_node_${node.id}'),
          borderRadius: BorderRadius.circular(8),
          onTap: node.isEnabled ? () => onSelected(node) : null,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(CanonicalSearchIconResolver.resolve(node.iconKey)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        node.displayNamePtPt,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(node.descriptionPtPt),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _Breadcrumb extends StatelessWidget {
  const _Breadcrumb({required this.path, required this.onAncestorSelected});

  final List<CanonicalSearchFilterNode> path;
  final ValueChanged<CanonicalSearchFilterNode> onAncestorSelected;

  @override
  Widget build(BuildContext context) {
    final labels = path.isEmpty
        ? const ['Explorar exercícios']
        : ['Explorar exercícios', ...path.map((node) => node.displayNamePtPt)];
    return Container(
      width: double.infinity,
      key: const ValueKey('canonical_search_breadcrumb'),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 4,
        runSpacing: 2,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (var index = 0; index < labels.length; index++) ...[
            if (index > 0) const Text('>'),
            if (index == 0)
              const Text('Explorar exercícios')
            else
              TextButton(
                key: ValueKey(
                  'canonical_search_breadcrumb_${path[index - 1].id}',
                ),
                onPressed: () => onAncestorSelected(path[index - 1]),
                child: Text(labels[index]),
              ),
          ],
        ],
      ),
    );
  }
}
