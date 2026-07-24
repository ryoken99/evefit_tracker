import 'package:flutter/material.dart';

import '../models/canonical_core_models.dart';
import '../models/canonical_exercise_models.dart';
import '../models/training_intention_models.dart';
import '../services/hierarchical_canonical_search_controller.dart';
import '../widgets/canonical_core_icon_resolver.dart';
import '../widgets/training_intention_widgets.dart';
import 'canonical_exercise_detail_screen.dart';

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
  Future<CanonicalSearchResult<CanonicalResolvedExercise>>? _resultsFuture;

  bool get _atRoot =>
      _controller.step == HierarchicalCanonicalSearchStep.usageContext;

  void _selectUsageContext(CanonicalPillarDefinition definition) {
    setState(() {
      _resultsFuture = null;
      _controller.selectUsageContext(definition.id);
    });
  }

  void _selectCapabilityRoot(CanonicalPillarDefinition definition) {
    setState(() {
      _resultsFuture = null;
      _controller.selectCapabilityRoot(definition.id);
    });
  }

  void _selectTrainingIntention(CanonicalResolvedPathIntention option) {
    setState(() {
      _controller.selectTrainingIntention(option.definition.pillar.id);
      _resultsFuture = _controller.searchSelectedExercises();
    });
  }

  void _goBack() {
    setState(() => _controller.goBack());
  }

  void _goHome() {
    setState(() {
      _resultsFuture = null;
      _controller.goToRoot();
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
              onConceptPressed: () {
                setState(_controller.goToTrainingConcept);
              },
              onIntentionPressed: () {
                setState(_controller.goToTrainingIntention);
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
      _buildTrainingIntentions(),
    HierarchicalCanonicalSearchStep.results => _buildResults(),
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
          setState(() {
            _resultsFuture = null;
            _controller.selectTrainingConcept(definition.id);
          });
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

  Widget _buildTrainingIntentions() => TrainingIntentionList(
    key: const ValueKey('workout_exercise_selector_intentions'),
    title: 'Que intenção de treino procuras?',
    intentions: _controller.compatibleTrainingIntentions,
    onIntentionTap: _selectTrainingIntention,
  );

  Widget _buildResults() {
    final future = _resultsFuture ??= _controller.searchSelectedExercises();
    return FutureBuilder<CanonicalSearchResult<CanonicalResolvedExercise>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            key: ValueKey('workout_exercise_selector_results_loading'),
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError ||
            snapshot.data?.status == CanonicalSearchResultStatus.invalidQuery) {
          return _WorkoutExerciseSelectorResultsError(onBack: _goBack);
        }
        final exercises = snapshot.data?.items ?? const [];
        if (exercises.isEmpty) {
          return _WorkoutExerciseSelectorResultsEmpty(controller: _controller);
        }
        return _WorkoutExerciseSelectorResultsList(
          controller: _controller,
          exercises: exercises,
          onOpen: _openExercise,
        );
      },
    );
  }

  void _openExercise(CanonicalResolvedExercise exercise) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CanonicalExerciseDetailScreen(exercise: exercise),
      ),
    );
  }
}

class _WorkoutExerciseSelectorResultsEmpty extends StatelessWidget {
  const _WorkoutExerciseSelectorResultsEmpty({required this.controller});

  final HierarchicalCanonicalSearchController controller;

  @override
  Widget build(BuildContext context) => ListView(
    key: const ValueKey('workout_exercise_selector_results_empty'),
    padding: const EdgeInsets.all(24),
    children: [
      const SizedBox(height: 32),
      const Icon(Icons.search_off_outlined, size: 48),
      const SizedBox(height: 16),
      Text(
        'Ainda não existem exercícios aprovados para este percurso.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      const Text(
        'Os exercícios compatíveis serão adicionados e validados progressivamente.',
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 24),
      _WorkoutExerciseSelectorEmptyPath(controller: controller),
    ],
  );
}

class _WorkoutExerciseSelectorResultsError extends StatelessWidget {
  const _WorkoutExerciseSelectorResultsError({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Center(
    key: const ValueKey('workout_exercise_selector_results_error'),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: 16),
          Text(
            'Não foi possível apresentar os exercícios deste percurso.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Volta à intenção e tenta novamente.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Voltar à intenção'),
          ),
        ],
      ),
    ),
  );
}

class _WorkoutExerciseSelectorResultsList extends StatelessWidget {
  const _WorkoutExerciseSelectorResultsList({
    required this.controller,
    required this.exercises,
    required this.onOpen,
  });

  final HierarchicalCanonicalSearchController controller;
  final List<CanonicalResolvedExercise> exercises;
  final ValueChanged<CanonicalResolvedExercise> onOpen;

  @override
  Widget build(BuildContext context) => ListView(
    key: const ValueKey('workout_exercise_selector_results_list'),
    padding: const EdgeInsets.all(16),
    children: [
      Text(
        'Exercícios disponíveis',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 12),
      _WorkoutExerciseSelectorEmptyPath(controller: controller),
      const SizedBox(height: 16),
      for (final exercise in exercises)
        _CanonicalExerciseResultCard(
          key: ValueKey(
            'workout_exercise_selector_exercise_${exercise.definition.id}',
          ),
          exercise: exercise,
          onOpen: () => onOpen(exercise),
        ),
    ],
  );
}

class _CanonicalExerciseResultCard extends StatelessWidget {
  const _CanonicalExerciseResultCard({
    super.key,
    required this.exercise,
    required this.onOpen,
  });

  final CanonicalResolvedExercise exercise;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final definition = exercise.definition;
    final content = exercise.content;
    final highRisk =
        definition.safety.operationalRiskTier == CanonicalExerciseRiskTier.high;
    final requirements = <String>[
      if (definition.material.partnerRequired) 'Parceiro necessário',
      if (definition.material.targetRequired) 'Alvo necessário',
      if (definition.material.spotterRequired) 'Pessoa de apoio necessária',
      if (definition.material.supervisionRequirement == 'required')
        'Supervisão necessária'
      else if (definition.material.supervisionRequirement == 'recommended')
        'Supervisão recomendada',
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Semantics(
        button: true,
        label: 'Ver detalhes de ${definition.namePtPt}',
        child: Card(
          child: InkWell(
            onTap: onOpen,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          definition.namePtPt,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(content.shortDescriptionPtPt),
                  if (definition.identity.isVariant || highRisk) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        if (definition.identity.isVariant)
                          const Chip(
                            label: Text('Variante'),
                            visualDensity: VisualDensity.compact,
                          ),
                        if (highRisk)
                          const Chip(
                            avatar: Icon(
                              Icons.warning_amber_outlined,
                              size: 18,
                            ),
                            label: Text('Exigência elevada'),
                            visualDensity: VisualDensity.compact,
                          ),
                      ],
                    ),
                  ],
                  if (content.equipmentSetupPtPt.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      content.equipmentSetupPtPt.first,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  if (requirements.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      requirements.join(' • '),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      key: ValueKey(
                        'workout_exercise_selector_view_${definition.id}',
                      ),
                      onPressed: onOpen,
                      child: const Text('Ver detalhes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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
      HierarchicalCanonicalSearchStep.results => (5, 'Exercícios'),
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
    required this.onConceptPressed,
    required this.onIntentionPressed,
  });

  final HierarchicalCanonicalSearchController controller;
  final VoidCallback onContextPressed;
  final VoidCallback onCapabilityPressed;
  final VoidCallback onConceptPressed;
  final VoidCallback onIntentionPressed;

  @override
  Widget build(BuildContext context) {
    final contextDefinition = controller.selectedUsageContext;
    final capabilityDefinition = controller.selectedCapabilityRoot;
    final conceptDefinition = controller.selectedTrainingConcept;
    final intentionDefinition = controller.selectedTrainingIntention;
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
    if (conceptDefinition != null) {
      if (children.isNotEmpty) children.add(const Text('>'));
      children.add(
        TextButton(
          key: const ValueKey('workout_exercise_selector_breadcrumb_concept'),
          onPressed: onConceptPressed,
          child: Text(conceptDefinition.displayNamePtPt),
        ),
      );
    }
    if (intentionDefinition != null) {
      if (children.isNotEmpty) children.add(const Text('>'));
      children.add(
        TextButton(
          key: const ValueKey('workout_exercise_selector_breadcrumb_intention'),
          onPressed: onIntentionPressed,
          child: Text(intentionDefinition.displayNamePtPt),
        ),
      );
    }
    final currentLabel = switch (controller.step) {
      HierarchicalCanonicalSearchStep.usageContext => 'A escolher contexto',
      HierarchicalCanonicalSearchStep.capabilityRoot => 'A escolher capacidade',
      HierarchicalCanonicalSearchStep.trainingConcept => 'A escolher conceito',
      HierarchicalCanonicalSearchStep.trainingIntention =>
        'A escolher intenção',
      HierarchicalCanonicalSearchStep.results => 'Exercícios',
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
  Widget build(BuildContext context) {
    final path = [
      controller.selectedUsageContext?.displayNamePtPt,
      controller.selectedCapabilityRoot?.displayNamePtPt,
      controller.selectedTrainingConcept?.displayNamePtPt,
      controller.selectedTrainingIntention?.displayNamePtPt,
    ].whereType<String>().toList(growable: false);
    return Semantics(
      label: 'Percurso selecionado',
      child: Container(
        key: const ValueKey('workout_exercise_selector_empty_path'),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          path
              .asMap()
              .entries
              .map((entry) {
                return entry.key == 0 ? entry.value : '> ${entry.value}';
              })
              .join('\n'),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
