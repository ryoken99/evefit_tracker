import 'package:flutter/material.dart';

import '../data/canonical_registry.dart';
import '../models/canonical_core_models.dart';
import '../repositories/canonical_exercise_search_repository.dart';
import '../services/canonical_core_navigation_controller.dart';
import '../widgets/canonical_core_empty_state.dart';
import '../widgets/canonical_core_icon_resolver.dart';

class CanonicalCoreSearchScreen extends StatefulWidget {
  const CanonicalCoreSearchScreen({
    super.key,
    this.controller,
    this.repository = const EmptyCanonicalExerciseSearchRepository<Object?>(),
  });

  final CanonicalCoreNavigationController? controller;
  final CanonicalExerciseSearchRepository<Object?> repository;

  @override
  State<CanonicalCoreSearchScreen> createState() =>
      _CanonicalCoreSearchScreenState();
}

class _CanonicalCoreSearchScreenState extends State<CanonicalCoreSearchScreen> {
  late final CanonicalCoreNavigationController _controller =
      widget.controller ?? CanonicalCoreNavigationController();
  CanonicalSearchResult<Object?>? _result;
  bool _searching = false;

  void _selectAxis(CanonicalPillarAxis axis) {
    setState(() {
      _controller.selectAxis(axis);
      _result = null;
    });
  }

  Future<void> _selectValue(CanonicalPillarDefinition value) async {
    final query = _controller.selectValue(value.id);
    setState(() {
      _searching = true;
      _result = null;
    });
    final result = await widget.repository.search(query);
    if (!mounted) return;
    setState(() {
      _result = result;
      _searching = false;
    });
  }

  void _goBack() {
    if (!_controller.goBack()) return;
    setState(() {
      _result = null;
      _searching = false;
    });
  }

  void _goHome() {
    setState(() {
      _controller.goToRoot();
      _result = null;
      _searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final atRoot = _controller.isAtRoot;
    return PopScope<void>(
      canPop: atRoot,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Explorar exercícios'),
          leading: atRoot
              ? null
              : IconButton(
                  key: const ValueKey('canonical_core_back'),
                  tooltip: 'Voltar',
                  onPressed: _goBack,
                  icon: const Icon(Icons.arrow_back),
                ),
          actions: [
            if (!atRoot)
              IconButton(
                key: const ValueKey('canonical_core_home'),
                tooltip: 'Explorar exercícios',
                onPressed: _goHome,
                icon: const Icon(Icons.home_outlined),
              ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              _CanonicalCoreBreadcrumb(
                axis: _controller.selectedAxis,
                value: _controller.selectedValue,
                onRootSelected: _goHome,
                onAxisSelected: () {
                  if (_controller.selectedValue != null) _goBack();
                },
              ),
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_controller.isAtRoot) {
      return _CanonicalCoreAxisList(onSelected: _selectAxis);
    }
    if (_controller.selectedValue != null) {
      if (_searching) {
        return const Center(
          child: CircularProgressIndicator(
            key: ValueKey('canonical_core_search_loading'),
          ),
        );
      }
      final result = _result;
      if (result == null ||
          result.status == CanonicalSearchResultStatus.invalidQuery) {
        return const _CanonicalCoreSearchError();
      }
      return CanonicalCoreEmptyState(
        axisDefinition: _controller.selectedAxis!,
        value: _controller.selectedValue!,
        result: result,
      );
    }

    final axis = _controller.selectedAxis!;
    final values = _controller.availableValues;
    if (values.isEmpty) return _VocabularyPendingState(axis: axis.axis);
    return ListView(
      key: ValueKey('canonical_core_axis_values_${axis.axis.contractId}'),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          axis.displayNamePtPt,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        for (final value in values)
          _CanonicalDefinitionCard(
            key: ValueKey('canonical_core_value_${value.id}'),
            iconKey: value.iconKey,
            title: value.displayNamePtPt,
            description: value.descriptionPtPt,
            onTap: () => _selectValue(value),
          ),
      ],
    );
  }
}

class _CanonicalCoreAxisList extends StatelessWidget {
  const _CanonicalCoreAxisList({required this.onSelected});

  final ValueChanged<CanonicalPillarAxis> onSelected;

  @override
  Widget build(BuildContext context) {
    final axes = [...CanonicalRegistry.axisDefinitions]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return ListView(
      key: const ValueKey('canonical_core_root_screen'),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Como queres procurar?',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        for (final axis in axes)
          _CanonicalDefinitionCard(
            key: ValueKey('canonical_core_axis_${axis.axis.contractId}'),
            iconKey: axis.iconKey,
            title: axis.displayNamePtPt,
            description: axis.descriptionPtPt,
            onTap: () => onSelected(axis.axis),
          ),
      ],
    );
  }
}

class _CanonicalDefinitionCard extends StatelessWidget {
  const _CanonicalDefinitionCard({
    super.key,
    required this.iconKey,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final CanonicalCoreIconKey iconKey;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Semantics(
      button: true,
      enabled: true,
      label: title,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(CanonicalCoreIconResolver.resolve(iconKey)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(description),
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

class _VocabularyPendingState extends StatelessWidget {
  const _VocabularyPendingState({required this.axis});

  final CanonicalPillarAxis axis;

  @override
  Widget build(BuildContext context) {
    final intention = axis == CanonicalPillarAxis.trainingIntention;
    return SingleChildScrollView(
      key: ValueKey(
        intention
            ? 'canonical_core_intentions_pending'
            : 'canonical_core_concepts_pending',
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            intention ? 'Intenções de treino' : 'Conceitos de treino',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            intention
                ? 'O vocabulário canónico de intenções ainda está em definição.'
                : 'O vocabulário canónico de conceitos ainda está em definição.',
          ),
          const SizedBox(height: 8),
          Text(
            intention
                ? 'As intenções serão adicionadas e aprovadas progressivamente antes de serem utilizadas na pesquisa.'
                : 'Os conceitos serão adicionados e aprovados progressivamente antes de serem utilizados na pesquisa.',
          ),
        ],
      ),
    );
  }
}

class _CanonicalCoreSearchError extends StatelessWidget {
  const _CanonicalCoreSearchError();

  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      key: ValueKey('canonical_core_search_error'),
      padding: EdgeInsets.all(24),
      child: Text('Não foi possível executar esta pesquisa canónica.'),
    ),
  );
}

class _CanonicalCoreBreadcrumb extends StatelessWidget {
  const _CanonicalCoreBreadcrumb({
    required this.axis,
    required this.value,
    required this.onRootSelected,
    required this.onAxisSelected,
  });

  final CanonicalPillarAxisDefinition? axis;
  final CanonicalPillarDefinition? value;
  final VoidCallback onRootSelected;
  final VoidCallback onAxisSelected;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    key: const ValueKey('canonical_core_breadcrumb'),
    color: Theme.of(context).colorScheme.surfaceContainerHighest,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Wrap(
      spacing: 4,
      runSpacing: 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (axis == null)
          const Text('Explorar exercícios')
        else
          TextButton(
            key: const ValueKey('canonical_core_breadcrumb_root'),
            onPressed: onRootSelected,
            child: const Text('Explorar exercícios'),
          ),
        if (axis != null) ...[
          const Text('>'),
          if (value == null)
            Text(axis!.displayNamePtPt)
          else
            TextButton(
              key: ValueKey(
                'canonical_core_breadcrumb_${axis!.axis.contractId}',
              ),
              onPressed: onAxisSelected,
              child: Text(axis!.displayNamePtPt),
            ),
        ],
        if (value != null) ...[const Text('>'), Text(value!.displayNamePtPt)],
      ],
    ),
  );
}
