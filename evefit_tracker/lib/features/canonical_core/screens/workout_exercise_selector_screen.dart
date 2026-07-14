import 'package:flutter/material.dart';

import '../data/canonical_registry.dart';
import '../models/canonical_core_models.dart';
import '../repositories/canonical_exercise_search_repository.dart';
import '../services/canonical_core_navigation_controller.dart';
import '../widgets/canonical_core_empty_state.dart';
import '../widgets/canonical_core_icon_resolver.dart';

class WorkoutExerciseSelectorScreen extends StatefulWidget {
  const WorkoutExerciseSelectorScreen({
    super.key,
    this.controller,
    this.repository = const EmptyCanonicalExerciseSearchRepository<Object?>(),
  });

  final CanonicalCoreNavigationController? controller;
  final CanonicalExerciseSearchRepository<Object?> repository;

  @override
  State<WorkoutExerciseSelectorScreen> createState() =>
      _WorkoutExerciseSelectorScreenState();
}

class _WorkoutExerciseSelectorScreenState
    extends State<WorkoutExerciseSelectorScreen> {
  late final CanonicalCoreNavigationController _controller =
      widget.controller ?? CanonicalCoreNavigationController();
  CanonicalSearchResult<Object?>? _result;
  bool _searching = false;
  bool _searchFailed = false;

  bool get _showingContexts =>
      _controller.selectedAxis?.axis == CanonicalPillarAxis.usageContext &&
      _controller.selectedValue == null;

  bool get _showingResult => _controller.selectedValue != null;

  bool get _atRoot => !_showingContexts && !_showingResult;

  Future<void> _selectCapability(CanonicalPillarDefinition value) async {
    _controller.selectAxis(CanonicalPillarAxis.capabilityRoot);
    await _executeSearch(value);
  }

  void _openContexts() {
    setState(() {
      _controller.selectAxis(CanonicalPillarAxis.usageContext);
      _result = null;
      _searching = false;
      _searchFailed = false;
    });
  }

  Future<void> _selectContext(CanonicalPillarDefinition value) async {
    if (_controller.selectedAxis?.axis != CanonicalPillarAxis.usageContext) {
      _controller.selectAxis(CanonicalPillarAxis.usageContext);
    }
    await _executeSearch(value);
  }

  Future<void> _executeSearch(CanonicalPillarDefinition value) async {
    final query = _controller.selectValue(value.id);
    setState(() {
      _searching = true;
      _searchFailed = false;
      _result = null;
    });
    try {
      final result = await widget.repository.search(query);
      if (!mounted) return;
      setState(() {
        _result = result;
        _searching = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _searchFailed = true;
        _searching = false;
      });
    }
  }

  void _goBack() {
    final selected = _controller.selectedValue;
    if (selected != null) {
      _controller.goBack();
      if (selected.axis == CanonicalPillarAxis.capabilityRoot) {
        _controller.goToRoot();
      }
    } else if (_showingContexts) {
      _controller.goToRoot();
    } else {
      return;
    }
    setState(() {
      _result = null;
      _searching = false;
      _searchFailed = false;
    });
  }

  void _goHome() {
    setState(() {
      _controller.goToRoot();
      _result = null;
      _searching = false;
      _searchFailed = false;
    });
  }

  @override
  Widget build(BuildContext context) => PopScope<void>(
    canPop: _atRoot,
    onPopInvokedWithResult: (didPop, _) {
      if (!didPop) _goBack();
    },
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar exercício'),
        leading: _atRoot
            ? null
            : IconButton(
                key: const ValueKey('workout_exercise_selector_back'),
                tooltip: 'Voltar',
                onPressed: _goBack,
                icon: const Icon(Icons.arrow_back),
              ),
        actions: [
          if (!_atRoot)
            IconButton(
              key: const ValueKey('workout_exercise_selector_home'),
              tooltip: 'Voltar às capacidades',
              onPressed: _goHome,
              icon: const Icon(Icons.home_outlined),
            ),
        ],
      ),
      body: SafeArea(child: _buildContent()),
    ),
  );

  Widget _buildContent() {
    if (_showingResult) {
      if (_searching) {
        return const Center(
          child: CircularProgressIndicator(
            key: ValueKey('workout_exercise_selector_search_loading'),
          ),
        );
      }
      final result = _result;
      if (_searchFailed ||
          result == null ||
          result.status == CanonicalSearchResultStatus.invalidQuery) {
        return const _WorkoutExerciseSelectorSearchError();
      }
      final value = _controller.selectedValue!;
      return CanonicalCoreEmptyState(
        rootKey: const ValueKey('workout_exercise_selector_result_empty'),
        activeCriterionKey: const ValueKey(
          'workout_exercise_selector_active_criterion',
        ),
        resultTotalKey: const ValueKey(
          'workout_exercise_selector_result_total',
        ),
        axisDefinition: _axisDefinition(value.axis),
        value: value,
        result: result,
      );
    }
    if (_showingContexts) return _buildContexts();
    return _buildCapabilities();
  }

  Widget _buildCapabilities() {
    final capabilities = [...CanonicalRegistry.approvedCapabilityRoots]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return ListView(
      key: const ValueKey('workout_exercise_selector_root'),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Que capacidade queres trabalhar?',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Column(
          key: const ValueKey('workout_exercise_selector_capabilities'),
          children: [
            for (final capability in capabilities)
              _WorkoutExerciseSelectorCard(
                key: ValueKey(
                  'workout_exercise_selector_capability_${capability.id}',
                ),
                definition: capability,
                onTap: () => _selectCapability(capability),
              ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          key: const ValueKey('workout_exercise_selector_context_entry'),
          onPressed: _openContexts,
          icon: const Icon(Icons.schedule_outlined),
          label: const Text('Procurar por contexto'),
        ),
      ],
    );
  }

  Widget _buildContexts() {
    final contexts = [...CanonicalRegistry.approvedUsageContexts]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return ListView(
      key: const ValueKey('workout_exercise_selector_contexts'),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Procurar por contexto',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        const Text('Escolhe o momento ou finalidade desta pesquisa.'),
        const SizedBox(height: 12),
        for (final usageContext in contexts)
          _WorkoutExerciseSelectorCard(
            key: ValueKey(
              'workout_exercise_selector_context_${usageContext.id}',
            ),
            definition: usageContext,
            onTap: () => _selectContext(usageContext),
          ),
      ],
    );
  }

  CanonicalPillarAxisDefinition _axisDefinition(CanonicalPillarAxis axis) =>
      CanonicalRegistry.axisDefinitions.singleWhere(
        (definition) => definition.axis == axis,
      );
}

class _WorkoutExerciseSelectorCard extends StatelessWidget {
  const _WorkoutExerciseSelectorCard({
    super.key,
    required this.definition,
    required this.onTap,
  });

  final CanonicalPillarDefinition definition;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Semantics(
      button: true,
      enabled: true,
      label: definition.displayNamePtPt,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(CanonicalCoreIconResolver.resolve(definition.iconKey)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        definition.displayNamePtPt,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(definition.descriptionPtPt),
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

class _WorkoutExerciseSelectorSearchError extends StatelessWidget {
  const _WorkoutExerciseSelectorSearchError();

  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      key: ValueKey('workout_exercise_selector_search_error'),
      padding: EdgeInsets.all(24),
      child: Text('Não foi possível executar esta pesquisa canónica.'),
    ),
  );
}
