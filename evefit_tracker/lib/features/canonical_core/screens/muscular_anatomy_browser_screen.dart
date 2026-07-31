import 'package:flutter/material.dart';

import '../models/canonical_muscular_models.dart';
import '../repositories/canonical_muscular_repository.dart';
import 'canonical_arm_exercise_detail_screen.dart';
import 'canonical_muscle_detail_screen.dart';

/// Isolated anatomy browser for the approved arm and forearm public projection.
/// It deliberately has no workout-selection or four-pillar side effects.
class MuscularAnatomyBrowserScreen extends StatefulWidget {
  const MuscularAnatomyBrowserScreen({super.key, required this.repository});

  final CanonicalMuscularRepository repository;

  @override
  State<MuscularAnatomyBrowserScreen> createState() =>
      _MuscularAnatomyBrowserScreenState();
}

enum _AnatomyStep { upperBody, region, group, focus, results }

class _MuscularAnatomyBrowserScreenState
    extends State<MuscularAnatomyBrowserScreen> {
  _AnatomyStep _step = _AnatomyStep.upperBody;
  CanonicalMuscleRegion? _region;
  CanonicalMuscleGroup? _group;
  CanonicalMuscle? _muscle;

  bool get _atRoot => _step == _AnatomyStep.upperBody;

  void _goBack() {
    setState(() {
      switch (_step) {
        case _AnatomyStep.upperBody:
          return;
        case _AnatomyStep.region:
          _step = _AnatomyStep.upperBody;
          _region = null;
        case _AnatomyStep.group:
          _step = _AnatomyStep.region;
          _group = null;
        case _AnatomyStep.focus:
          _step = _AnatomyStep.group;
          _muscle = null;
        case _AnatomyStep.results:
          _step = _AnatomyStep.focus;
      }
    });
  }

  void _goHome() => setState(() {
    _step = _AnatomyStep.upperBody;
    _region = null;
    _group = null;
    _muscle = null;
  });

  @override
  Widget build(BuildContext context) => PopScope<void>(
    canPop: _atRoot,
    onPopInvokedWithResult: (didPop, _) {
      if (!didPop) _goBack();
    },
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Explorar por anatomia'),
        leading: _atRoot
            ? null
            : IconButton(
                key: const ValueKey('muscular_anatomy_browser_back'),
                tooltip: 'Voltar',
                onPressed: _goBack,
                icon: const Icon(Icons.arrow_back),
              ),
        actions: [
          if (!_atRoot)
            IconButton(
              key: const ValueKey('muscular_anatomy_browser_home'),
              tooltip: 'Regressar ao início',
              onPressed: _goHome,
              icon: const Icon(Icons.home_outlined),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          key: const ValueKey('muscular_anatomy_browser_root'),
          children: [
            _Breadcrumb(
              step: _step,
              region: _region,
              group: _group,
              muscle: _muscle,
              onUpperBody: _goHome,
              onRegion: () => setState(() {
                _step = _AnatomyStep.group;
                _muscle = null;
              }),
              onGroup: () => setState(() {
                _step = _AnatomyStep.focus;
                _muscle = null;
              }),
              onFocus: () => setState(() => _step = _AnatomyStep.focus),
            ),
            const Divider(height: 1),
            Expanded(child: _buildStep()),
          ],
        ),
      ),
    ),
  );

  Widget _buildStep() => switch (_step) {
    _AnatomyStep.upperBody => _upperBody(),
    _AnatomyStep.region => _regions(),
    _AnatomyStep.group => _groups(),
    _AnatomyStep.focus => _focus(),
    _AnatomyStep.results => _results(),
  };

  Widget _upperBody() => _AnatomyList(
    title: 'Que zona do corpo superior queres explorar?',
    children: [
      _AnatomyCard(
        key: const ValueKey('muscular_anatomy_region_upper_body'),
        icon: Icons.accessibility_new_outlined,
        title: 'Corpo superior',
        description: 'Explora grupos e músculos do braço e antebraço.',
        onTap: () => setState(() => _step = _AnatomyStep.region),
      ),
    ],
  );

  Widget _regions() => _AnatomyList(
    title: 'Escolhe uma região',
    children: [
      for (final region in widget.repository.publicRegions)
        _AnatomyCard(
          key: ValueKey('muscular_anatomy_region_${region.id}'),
          icon: region.id == 'arm'
              ? Icons.front_hand_outlined
              : Icons.pan_tool_outlined,
          title: region.namePtPt,
          description: 'Explora os grupos musculares desta região.',
          onTap: () => setState(() {
            _region = region;
            _step = _AnatomyStep.group;
          }),
        ),
    ],
  );

  Widget _groups() {
    final region = _region;
    if (region == null) return const SizedBox.shrink();
    return _AnatomyList(
      title: region.namePtPt,
      children: [
        for (final group in widget.repository.groupsForRegion(region.id))
          _AnatomyCard(
            key: ValueKey('muscular_anatomy_group_${group.id}'),
            icon: Icons.account_tree_outlined,
            title: group.namePtPt,
            description: _groupDescription(group),
            onTap: () => setState(() {
              _group = group;
              _step = _AnatomyStep.focus;
            }),
          ),
      ],
    );
  }

  String _groupDescription(CanonicalMuscleGroup group) {
    final muscleCount = widget.repository.musclesForGroup(group.id).length;
    final exerciseCount = widget.repository.exercisesForGroup(group.id).length;
    return '$muscleCount músculos • $exerciseCount exercícios principais';
  }

  Widget _focus() {
    final group = _group;
    if (group == null) return const SizedBox.shrink();
    final muscles = widget.repository.musclesForGroup(group.id);
    return _AnatomyList(
      title: group.namePtPt,
      children: [
        _AnatomyCard(
          key: ValueKey('muscular_anatomy_focus_${group.id}_complete'),
          icon: Icons.groups_2_outlined,
          title: '${group.namePtPt} completo',
          description: 'Mostra exercícios relacionados com todo o grupo.',
          onTap: () => setState(() {
            _muscle = null;
            _step = _AnatomyStep.results;
          }),
        ),
        for (final muscle in muscles)
          _AnatomyCard(
            key: ValueKey('muscular_anatomy_muscle_${muscle.id}'),
            icon: Icons.info_outline,
            title: muscle.namePtPt,
            description: muscle.descriptionPtPt,
            trailing: IconButton(
              tooltip: 'Ver detalhe muscular',
              onPressed: () => _openMuscle(muscle),
              icon: const Icon(Icons.arrow_outward),
            ),
            onTap: () => setState(() {
              _muscle = muscle;
              _step = _AnatomyStep.results;
            }),
          ),
      ],
    );
  }

  Widget _results() {
    final group = _group;
    if (group == null) return const SizedBox.shrink();
    final muscle = _muscle;
    final results = muscle == null
        ? widget.repository.exercisesForGroup(group.id)
        : widget.repository.exercisesForMuscle(muscle.id);
    if (results.isEmpty) {
      return ListView(
        key: const ValueKey('muscular_anatomy_results'),
        padding: const EdgeInsets.all(24),
        children: [
          Icon(
            Icons.info_outline,
            size: 48,
            color: Theme.of(context).hintColor,
          ),
          const SizedBox(height: 16),
          Text(
            muscle == null ? group.namePtPt : muscle.namePtPt,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          const Text(
            'Ainda não existem exercícios canónicos aprovados para esta seleção.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'A informação anatómica permanece disponível sem sugerir resultados fictícios.',
            textAlign: TextAlign.center,
          ),
          if (muscle != null) ...[
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => _openMuscle(muscle),
              icon: const Icon(Icons.info_outline),
              label: const Text('Ver detalhe muscular'),
            ),
          ],
        ],
      );
    }
    final grouped =
        <CanonicalArmExerciseSection, List<CanonicalArmExerciseResult>>{};
    for (final result in results) {
      (grouped[result.section] ??= []).add(result);
    }
    return ListView(
      key: const ValueKey('muscular_anatomy_results'),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          muscle == null ? group.namePtPt : muscle.namePtPt,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        if (muscle != null)
          OutlinedButton.icon(
            onPressed: () => _openMuscle(muscle),
            icon: const Icon(Icons.info_outline),
            label: const Text('Ver detalhe muscular'),
          ),
        for (final section in CanonicalArmExerciseSection.values)
          if (grouped[section] case final values? when values.isNotEmpty) ...[
            const SizedBox(height: 20),
            Semantics(
              header: true,
              child: Text(
                _sectionTitle(section),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            for (final result in values)
              _AnatomyCard(
                key: ValueKey(
                  'muscular_anatomy_exercise_${result.exercise.id}',
                ),
                icon: Icons.fitness_center_outlined,
                title: result.content.namePtPt,
                description: _exerciseDescription(result),
                badge: result.exercise.hasLimits ? 'Com limites' : null,
                actionLabel: 'Ver detalhes',
                onTap: () => _openExercise(result),
              ),
          ],
      ],
    );
  }

  String _sectionTitle(CanonicalArmExerciseSection section) =>
      switch (section) {
        CanonicalArmExerciseSection.primaryTarget => 'Alvo principal',
        CanonicalArmExerciseSection.relevantParticipation =>
          'Participação relevante',
        CanonicalArmExerciseSection.stabilization => 'Estabilização',
        CanonicalArmExerciseSection.gripLimiter =>
          'Potencial limitador de pega',
      };

  String _exerciseDescription(CanonicalArmExerciseResult result) {
    final family = widget.repository.familyById(result.exercise.familyId);
    final equipment = result.exercise.requiredEquipmentIds
        .map(widget.repository.equipmentById)
        .whereType<CanonicalArmEquipment>()
        .map((value) => value.namePtPt)
        .join(', ');
    return [
      result.content.objectivePtPt,
      family?.namePtPt ?? result.exercise.familyId,
      if (equipment.isNotEmpty) equipment,
      if (result.content.primaryMusclesPtPt.isNotEmpty)
        'Alvo: ${result.content.primaryMusclesPtPt.join(', ')}',
      '${result.variants.length} variantes',
    ].join('\n');
  }

  Future<void> _openMuscle(CanonicalMuscle muscle) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => CanonicalMuscleDetailScreen(
            repository: widget.repository,
            muscle: muscle,
          ),
        ),
      );

  Future<void> _openExercise(CanonicalArmExerciseResult result) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => CanonicalArmExerciseDetailScreen(
            repository: widget.repository,
            result: result,
          ),
        ),
      );
}

class _Breadcrumb extends StatelessWidget {
  const _Breadcrumb({
    required this.step,
    required this.region,
    required this.group,
    required this.muscle,
    required this.onUpperBody,
    required this.onRegion,
    required this.onGroup,
    required this.onFocus,
  });

  final _AnatomyStep step;
  final CanonicalMuscleRegion? region;
  final CanonicalMuscleGroup? group;
  final CanonicalMuscle? muscle;
  final VoidCallback onUpperBody;
  final VoidCallback onRegion;
  final VoidCallback onGroup;
  final VoidCallback onFocus;

  @override
  Widget build(BuildContext context) {
    final crumbs = <Widget>[
      _crumb('Corpo superior', 'upper_body', onUpperBody),
      if (region != null) _crumb(region!.namePtPt, region!.id, onRegion),
      if (group != null) _crumb(group!.namePtPt, group!.id, onGroup),
      if (step == _AnatomyStep.results)
        _crumb(
          muscle?.namePtPt ?? '${group?.namePtPt} completo',
          'focus',
          onFocus,
        ),
    ];
    return SingleChildScrollView(
      key: const ValueKey('muscular_anatomy_breadcrumb'),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          for (var index = 0; index < crumbs.length; index++) ...[
            if (index > 0)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.chevron_right, size: 18),
              ),
            crumbs[index],
          ],
        ],
      ),
    );
  }

  Widget _crumb(String text, String id, VoidCallback onPressed) => TextButton(
    key: ValueKey('muscular_anatomy_breadcrumb_$id'),
    onPressed: onPressed,
    child: Text(text),
  );
}

class _AnatomyList extends StatelessWidget {
  const _AnatomyList({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Semantics(
        header: true,
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
      const SizedBox(height: 16),
      ...children,
    ],
  );
}

class _AnatomyCard extends StatelessWidget {
  const _AnatomyCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.trailing,
    this.badge,
    this.actionLabel,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final Widget? trailing;
  final String? badge;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: '$title. $description',
    child: Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    if (badge != null) ...[
                      const SizedBox(height: 4),
                      Chip(
                        label: Text(badge!),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      description,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (actionLabel != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        actionLabel!,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing ??
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.chevron_right),
                  ),
            ],
          ),
        ),
      ),
    ),
  );
}
