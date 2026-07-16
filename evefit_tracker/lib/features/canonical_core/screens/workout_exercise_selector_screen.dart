import 'package:flutter/material.dart';

import '../models/canonical_core_models.dart';
import '../services/hierarchical_canonical_search_controller.dart';
import '../widgets/canonical_core_icon_resolver.dart';

class WorkoutExerciseSelectorScreen extends StatefulWidget {
  const WorkoutExerciseSelectorScreen({super.key, this.controller});

  final HierarchicalCanonicalSearchController? controller;

  @override
  State<WorkoutExerciseSelectorScreen> createState() =>
      _WorkoutExerciseSelectorScreenState();
}

class _WorkoutExerciseSelectorScreenState
    extends State<WorkoutExerciseSelectorScreen> {
  late final HierarchicalCanonicalSearchController _controller =
      widget.controller ?? HierarchicalCanonicalSearchController();

  bool get _atRoot =>
      _controller.step == HierarchicalCanonicalSearchStep.usageContext;

  void _selectUsageContext(CanonicalPillarDefinition definition) {
    setState(() => _controller.selectUsageContext(definition.id));
  }

  void _selectCapabilityRoot(CanonicalPillarDefinition definition) {
    setState(() => _controller.selectCapabilityRoot(definition.id));
  }

  void _goBack() {
    setState(() => _controller.goBack());
  }

  void _goHome() {
    setState(_controller.goToRoot);
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
              tooltip: 'Regressar ao início',
              onPressed: _goHome,
              icon: const Icon(Icons.home_outlined),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          key: const ValueKey('workout_exercise_selector_root'),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _WorkoutExerciseSelectorProgress(step: _controller.step),
            _WorkoutExerciseSelectorBreadcrumb(
              controller: _controller,
              onContextPressed: () {
                setState(_controller.goToUsageContext);
              },
              onCapabilityPressed: () {
                setState(_controller.goToCapabilityRoot);
              },
            ),
            const Divider(height: 1),
            Expanded(child: _buildCurrentStep()),
          ],
        ),
      ),
    ),
  );

  Widget _buildCurrentStep() => switch (_controller.step) {
    HierarchicalCanonicalSearchStep.usageContext => _buildUsageContexts(),
    HierarchicalCanonicalSearchStep.capabilityRoot => _buildCapabilities(),
    HierarchicalCanonicalSearchStep.trainingConcept => _buildTrainingConcepts(),
    HierarchicalCanonicalSearchStep.trainingIntention =>
      _buildUnavailableFutureStep(
        'Que resultado específico procuras?',
        'Ainda não existem intenções de treino aprovadas.',
      ),
    HierarchicalCanonicalSearchStep.results => _buildUnavailableFutureStep(
      'Exercícios correspondentes',
      'Ainda não existem exercícios canónicos ativos.',
    ),
  };

  Widget _buildUsageContexts() => _WorkoutExerciseSelectorList(
    key: const ValueKey('workout_exercise_selector_contexts'),
    title: 'Em que contexto vais utilizar o exercício?',
    definitions: _controller.activeUsageContexts,
    selectedId: _controller.path.usageContextId,
    keyPrefix: 'workout_exercise_selector_context_',
    onSelected: _selectUsageContext,
  );

  Widget _buildCapabilities() => _WorkoutExerciseSelectorList(
    key: const ValueKey('workout_exercise_selector_capabilities'),
    title: 'Que capacidade queres trabalhar?',
    definitions: _controller.compatibleCapabilities,
    selectedId: _controller.path.capabilityRootId,
    keyPrefix: 'workout_exercise_selector_capability_',
    onSelected: _selectCapabilityRoot,
  );

  Widget _buildTrainingConcepts() {
    final concepts = _controller.compatibleTrainingConcepts;
    if (concepts.isNotEmpty) {
      return _WorkoutExerciseSelectorList(
        key: const ValueKey('workout_exercise_selector_concepts'),
        title: 'Que tipo de trabalho funcional procuras?',
        definitions: concepts,
        selectedId: _controller.path.trainingConceptId,
        keyPrefix: 'workout_exercise_selector_concept_',
        onSelected: (definition) {
          setState(() => _controller.selectTrainingConcept(definition.id));
        },
      );
    }
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          'Que tipo de trabalho funcional procuras?',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 32),
        const Icon(Icons.account_tree_outlined, size: 48),
        const SizedBox(height: 16),
        Text(
          'Ainda não existem conceitos de treino aprovados.',
          key: const ValueKey('workout_exercise_selector_concept_empty'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Os conceitos compatíveis com esta seleção serão adicionados e validados progressivamente.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        _WorkoutExerciseSelectorEmptyPath(controller: _controller),
      ],
    );
  }

  Widget _buildUnavailableFutureStep(String title, String message) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text(title), const SizedBox(height: 8), Text(message)],
      ),
    ),
  );
}

class _WorkoutExerciseSelectorProgress extends StatelessWidget {
  const _WorkoutExerciseSelectorProgress({required this.step});

  final HierarchicalCanonicalSearchStep step;

  @override
  Widget build(BuildContext context) {
    final (number, label) = switch (step) {
      HierarchicalCanonicalSearchStep.usageContext => (1, 'Contexto'),
      HierarchicalCanonicalSearchStep.capabilityRoot => (2, 'Capacidade'),
      HierarchicalCanonicalSearchStep.trainingConcept => (
        3,
        'Conceito de treino',
      ),
      HierarchicalCanonicalSearchStep.trainingIntention => (4, 'Intenção'),
      HierarchicalCanonicalSearchStep.results => (5, 'Resultados'),
    };
    return Padding(
      key: const ValueKey('workout_exercise_selector_step'),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Text(
        'Passo $number de 5: $label',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

class _WorkoutExerciseSelectorBreadcrumb extends StatelessWidget {
  const _WorkoutExerciseSelectorBreadcrumb({
    required this.controller,
    required this.onContextPressed,
    required this.onCapabilityPressed,
  });

  final HierarchicalCanonicalSearchController controller;
  final VoidCallback onContextPressed;
  final VoidCallback onCapabilityPressed;

  @override
  Widget build(BuildContext context) {
    final contextDefinition = controller.selectedUsageContext;
    final capabilityDefinition = controller.selectedCapabilityRoot;
    final children = <Widget>[];
    if (contextDefinition != null) {
      children.add(
        TextButton(
          key: const ValueKey('workout_exercise_selector_breadcrumb_context'),
          onPressed: onContextPressed,
          child: Text(contextDefinition.displayNamePtPt),
        ),
      );
    }
    if (capabilityDefinition != null) {
      if (children.isNotEmpty) children.add(const Text('>'));
      children.add(
        TextButton(
          key: const ValueKey(
            'workout_exercise_selector_breadcrumb_capability',
          ),
          onPressed: onCapabilityPressed,
          child: Text(capabilityDefinition.displayNamePtPt),
        ),
      );
    }
    final currentLabel = switch (controller.step) {
      HierarchicalCanonicalSearchStep.usageContext => 'A escolher contexto',
      HierarchicalCanonicalSearchStep.capabilityRoot => 'A escolher capacidade',
      HierarchicalCanonicalSearchStep.trainingConcept => 'A escolher conceito',
      HierarchicalCanonicalSearchStep.trainingIntention =>
        'A escolher intenção',
      HierarchicalCanonicalSearchStep.results => 'Resultados',
    };
    if (children.isNotEmpty) children.add(const Text('>'));
    children.add(
      Text(
        currentLabel,
        key: const ValueKey('workout_exercise_selector_breadcrumb_current'),
      ),
    );
    return SingleChildScrollView(
      key: const ValueKey('workout_exercise_selector_breadcrumb'),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: children),
    );
  }
}

class _WorkoutExerciseSelectorList extends StatelessWidget {
  const _WorkoutExerciseSelectorList({
    super.key,
    required this.title,
    required this.definitions,
    required this.selectedId,
    required this.keyPrefix,
    required this.onSelected,
  });

  final String title;
  final List<CanonicalPillarDefinition> definitions;
  final String? selectedId;
  final String keyPrefix;
  final ValueChanged<CanonicalPillarDefinition> onSelected;

  @override
  Widget build(BuildContext context) => ListView(
    key: key,
    padding: const EdgeInsets.all(16),
    children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      for (final definition in definitions)
        _WorkoutExerciseSelectorCard(
          key: ValueKey('$keyPrefix${definition.id}'),
          definition: definition,
          selected: definition.id == selectedId,
          onTap: () => onSelected(definition),
        ),
    ],
  );
}

class _WorkoutExerciseSelectorCard extends StatelessWidget {
  const _WorkoutExerciseSelectorCard({
    super.key,
    required this.definition,
    required this.selected,
    required this.onTap,
  });

  final CanonicalPillarDefinition definition;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Semantics(
      button: true,
      enabled: true,
      selected: selected,
      label: definition.displayNamePtPt,
      child: Card(
        color: selected
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
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
                Icon(selected ? Icons.check_circle : Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _WorkoutExerciseSelectorEmptyPath extends StatelessWidget {
  const _WorkoutExerciseSelectorEmptyPath({required this.controller});

  final HierarchicalCanonicalSearchController controller;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Percurso selecionado',
    child: Container(
      key: const ValueKey('workout_exercise_selector_empty_path'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${controller.selectedUsageContext!.displayNamePtPt}\n'
        '> ${controller.selectedCapabilityRoot!.displayNamePtPt}',
        textAlign: TextAlign.center,
      ),
    ),
  );
}
