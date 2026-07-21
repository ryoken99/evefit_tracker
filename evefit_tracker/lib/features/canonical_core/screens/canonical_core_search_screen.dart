import 'package:flutter/material.dart';

import '../data/canonical_registry.dart';
import '../models/canonical_core_models.dart';
import '../models/training_intention_models.dart';
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

  void _selectGlobalIntention(CanonicalPillarDefinition intention) {
    setState(() {
      _controller.selectGlobalIntention(intention.id);
      _result = null;
    });
  }

  Future<void> _selectGlobalIntentionPath(
    CanonicalTrainingPathDefinition path,
  ) async {
    final query = _controller.selectGlobalIntentionPath(path);
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
                globalIntention: _controller.selectedGlobalIntention,
                globalIntentionPath: _controller.selectedGlobalIntentionPath,
                registry: _controller.registry,
                onRootSelected: _goHome,
                onAxisSelected: () => setState(_controller.goToAxis),
                onGlobalIntentionSelected: () =>
                    setState(_controller.goToGlobalIntentionPaths),
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
    final axis = _controller.selectedAxis!;
    if (axis.axis == CanonicalPillarAxis.trainingIntention) {
      return _buildGlobalIntentionContent(axis);
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

  Widget _buildGlobalIntentionContent(CanonicalPillarAxisDefinition axis) {
    final intention = _controller.selectedGlobalIntention;
    if (intention == null) {
      return _CanonicalGlobalIntentionList(
        intentions: _controller.availableValues,
        onSelected: _selectGlobalIntention,
      );
    }
    final path = _controller.selectedGlobalIntentionPath;
    if (path == null) {
      return _CanonicalGlobalIntentionPathList(
        registry: _controller.registry,
        intention: intention,
        paths: _controller.compatiblePathsForGlobalIntention(intention.id),
        onSelected: _selectGlobalIntentionPath,
      );
    }
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
    return _CanonicalGlobalIntentionEmptyState(
      registry: _controller.registry,
      axis: axis,
      intention: intention,
      path: path,
    );
  }
}

class _CanonicalGlobalIntentionList extends StatelessWidget {
  const _CanonicalGlobalIntentionList({
    required this.intentions,
    required this.onSelected,
  });

  final List<CanonicalPillarDefinition> intentions;
  final ValueChanged<CanonicalPillarDefinition> onSelected;

  @override
  Widget build(BuildContext context) => ListView.builder(
    key: const ValueKey('canonical_core_global_intentions'),
    padding: const EdgeInsets.all(16),
    itemCount: intentions.length + 2,
    itemBuilder: (context, index) {
      if (index == 0) {
        return Text(
          'Intenções de treino',
          style: Theme.of(context).textTheme.titleLarge,
        );
      }
      if (index == 1) return const SizedBox(height: 12);
      final intention = intentions[index - 2];
      return _CanonicalDefinitionCard(
        key: ValueKey('canonical_core_intention_${intention.id}'),
        iconKey: intention.iconKey,
        title: intention.displayNamePtPt,
        description: intention.descriptionPtPt,
        onTap: () => onSelected(intention),
      );
    },
  );
}

class _CanonicalGlobalIntentionPathList extends StatelessWidget {
  const _CanonicalGlobalIntentionPathList({
    required this.registry,
    required this.intention,
    required this.paths,
    required this.onSelected,
  });

  final CanonicalRegistry registry;
  final CanonicalPillarDefinition intention;
  final List<CanonicalTrainingPathDefinition> paths;
  final ValueChanged<CanonicalTrainingPathDefinition> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const ValueKey('canonical_core_global_intention_paths'),
      padding: const EdgeInsets.all(16),
      itemCount: paths.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text(
            intention.displayNamePtPt,
            style: Theme.of(context).textTheme.titleLarge,
          );
        }
        if (index == 1) return const SizedBox(height: 12);
        final path = paths[index - 2];
        return _CanonicalDefinitionCard(
          key: ValueKey('canonical_core_path_${path.key.contractId}'),
          iconKey: CanonicalCoreIconKey.intentionAxis,
          title: _canonicalPathDisplayName(registry, path),
          description: 'Percurso compatível',
          onTap: () => onSelected(path),
        );
      },
    );
  }
}

class _CanonicalGlobalIntentionEmptyState extends StatelessWidget {
  const _CanonicalGlobalIntentionEmptyState({
    required this.registry,
    required this.axis,
    required this.intention,
    required this.path,
  });

  final CanonicalRegistry registry;
  final CanonicalPillarAxisDefinition axis;
  final CanonicalPillarDefinition intention;
  final CanonicalTrainingPathDefinition path;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    key: const ValueKey('canonical_core_global_intention_empty_state'),
    padding: const EdgeInsets.all(24),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              CanonicalCoreIconResolver.resolve(
                CanonicalCoreIconKey.emptySearch,
              ),
              size: 44,
            ),
            const SizedBox(height: 16),
            Text(
              'Ainda não existem exercícios aprovados para este percurso.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Os exercícios compatíveis serão adicionados e validados progressivamente.',
            ),
            const SizedBox(height: 20),
            Text('Intenção', style: Theme.of(context).textTheme.labelLarge),
            Text(intention.displayNamePtPt),
            const SizedBox(height: 12),
            Text('Percurso', style: Theme.of(context).textTheme.labelLarge),
            Text(_canonicalPathDisplayName(registry, path)),
            const SizedBox(height: 12),
            Text(
              'Critérios ativos',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text('${axis.displayNamePtPt}: ${intention.displayNamePtPt}'),
          ],
        ),
      ),
    ),
  );
}

String _canonicalPathDisplayName(
  CanonicalRegistry registry,
  CanonicalTrainingPathDefinition path,
) {
  final values = registry.valueById;
  return [
    values[path.key.usageContextId]!.displayNamePtPt,
    values[path.key.capabilityRootId]!.displayNamePtPt,
    values[path.key.trainingConceptId]!.displayNamePtPt,
  ].join(' > ');
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
    required this.globalIntention,
    required this.globalIntentionPath,
    required this.registry,
    required this.onRootSelected,
    required this.onAxisSelected,
    required this.onGlobalIntentionSelected,
  });

  final CanonicalPillarAxisDefinition? axis;
  final CanonicalPillarDefinition? value;
  final CanonicalPillarDefinition? globalIntention;
  final CanonicalTrainingPathDefinition? globalIntentionPath;
  final CanonicalRegistry registry;
  final VoidCallback onRootSelected;
  final VoidCallback onAxisSelected;
  final VoidCallback onGlobalIntentionSelected;

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
          if (value == null && globalIntention == null)
            Text(
              axis!.displayNamePtPt,
              key: ValueKey(
                'canonical_core_breadcrumb_${axis!.axis.contractId}',
              ),
            )
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
        if (globalIntention != null) ...[
          const Text('>'),
          if (globalIntentionPath == null)
            Text(
              globalIntention!.displayNamePtPt,
              key: ValueKey(
                'canonical_core_breadcrumb_intention_${globalIntention!.id}',
              ),
            )
          else
            TextButton(
              key: ValueKey(
                'canonical_core_breadcrumb_intention_${globalIntention!.id}',
              ),
              onPressed: onGlobalIntentionSelected,
              child: Text(globalIntention!.displayNamePtPt),
            ),
        ],
        if (globalIntentionPath != null) ...[
          const Text('>'),
          Text(
            _canonicalPathDisplayName(registry, globalIntentionPath!),
            key: ValueKey(
              'canonical_core_breadcrumb_path_${globalIntentionPath!.key.contractId}',
            ),
          ),
        ],
      ],
    ),
  );
}
