import 'package:flutter/material.dart';

import '../models/canonical_muscular_models.dart';
import '../repositories/canonical_muscular_repository.dart';

class CanonicalArmExerciseDetailScreen extends StatefulWidget {
  const CanonicalArmExerciseDetailScreen({
    super.key,
    required this.repository,
    required this.result,
  });

  final CanonicalMuscularRepository repository;
  final CanonicalArmExerciseResult result;

  @override
  State<CanonicalArmExerciseDetailScreen> createState() =>
      _CanonicalArmExerciseDetailScreenState();
}

class _CanonicalArmExerciseDetailScreenState
    extends State<CanonicalArmExerciseDetailScreen> {
  CanonicalArmExerciseVariant? _selectedVariant;

  CanonicalArmExercise get _exercise => widget.result.exercise;
  CanonicalArmExercisePublicContent get _content => widget.result.content;

  @override
  Widget build(BuildContext context) {
    final family = widget.repository.familyById(_exercise.familyId);
    final equipment = _equipmentNames(
      _selectedVariant?.equipmentIds ?? _exercise.requiredEquipmentIds,
    );
    final jointNames =
        _exercise.jointIds
            .map(widget.repository.jointById)
            .whereType<CanonicalMuscleJoint>()
            .map((joint) => joint.namePtPt)
            .toSet()
            .toList()
          ..sort();
    final actionNames =
        _exercise.actionIds
            .map(widget.repository.actionById)
            .whereType<CanonicalMuscleAction>()
            .map((action) => action.namePtPt)
            .toSet()
            .toList()
          ..sort();
    return Scaffold(
      appBar: AppBar(title: Text(_exercise.namePtPt)),
      body: SafeArea(
        child: ListView(
          key: const ValueKey('canonical_arm_exercise_detail_screen'),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Semantics(
              header: true,
              child: Text(
                _exercise.namePtPt,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (_exercise.hasLimits || _selectedVariant?.hasLimits == true)
              _LimitNotice(
                reason: _exercise.hasLimits
                    ? _content.limitReasonPtPt
                    : _selectedVariant?.mechanicalJustificationPtPt ?? '',
                cautions: _content.cautionsPtPt,
                stopSigns: _exercise.stopConditionsPtPt,
              ),
            if (_selectedVariant != null)
              _VariantPanel(variant: _selectedVariant!),
            _DetailSection('Objetivo', paragraphs: [_content.objectivePtPt]),
            _DetailSection(
              'Descrição',
              paragraphs: [
                _exercise.shortDescriptionPtPt,
                _exercise.technicalDescriptionPtPt,
              ],
            ),
            _DetailSection(
              'Família',
              paragraphs: [family?.namePtPt ?? _exercise.familyId],
            ),
            _DetailSection(
              'Equipamento',
              bullets: [
                ...equipment,
                ..._equipmentNames(
                  _exercise.optionalEquipmentIds,
                ).map((item) => 'Opcional: $item'),
                ..._equipmentNames(
                  _exercise.alternativeEquipmentIds,
                ).map((item) => 'Alternativa: $item'),
                ..._content.equipmentPtPt,
              ],
            ),
            _DetailSection(
              'Preparação e posição inicial',
              bullets: [..._exercise.setupPtPt, _exercise.startPositionPtPt],
            ),
            _DetailSection(
              'Execução e trajetória',
              paragraphs: [
                _exercise.movementPtPt,
                _exercise.endPositionPtPt,
                _exercise.trajectoryPtPt,
              ],
              bullets: _content.instructionsPtPt,
            ),
            _DetailSection('Pontos de controlo', bullets: _exercise.cuesPtPt),
            _DetailSection(
              'Erros comuns',
              bullets: [
                ..._exercise.commonErrorsPtPt,
                ..._content.commonErrorsPtPt,
              ],
            ),
            _DetailSection(
              'Papéis musculares',
              bullets: [
                if (_content.primaryMusclesPtPt.isNotEmpty)
                  'Alvo principal: ${_content.primaryMusclesPtPt.join(', ')}.',
                if (_content.secondaryMusclesPtPt.isNotEmpty)
                  'Participação relevante: ${_content.secondaryMusclesPtPt.join(', ')}.',
                if (_content.potentialGripLimitersPtPt.isNotEmpty)
                  'Potenciais limitadores de pega: ${_content.potentialGripLimitersPtPt.join(', ')}.',
              ],
            ),
            _DetailSection(
              'Articulações e ações',
              bullets: [
                if (jointNames.isNotEmpty)
                  'Articulações: ${jointNames.join(', ')}.',
                if (actionNames.isNotEmpty) 'Ações: ${actionNames.join(', ')}.',
              ],
            ),
            _DetailSection(
              'Cuidados e sinais para parar',
              bullets: [
                ..._exercise.generalCautionsPtPt,
                ..._content.cautionsPtPt,
                ..._exercise.stopConditionsPtPt,
              ],
            ),
            _DetailSection(
              'Alternativas simples',
              bullets: _content.simpleAlternativesPtPt,
            ),
            _DetailSection(
              'Proveniência e limites',
              paragraphs: [
                'Fontes: ${_exercise.sourceIds.join(', ')}.',
                if (_exercise.specialistReviewPtPt.trim().isNotEmpty)
                  _exercise.specialistReviewPtPt,
              ],
            ),
            if (widget.result.variants.isNotEmpty) ...[
              const SizedBox(height: 20),
              Semantics(
                header: true,
                child: Text(
                  'Variantes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              for (final variant in widget.result.variants)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    key: ValueKey(
                      'canonical_arm_exercise_variant_${variant.id}',
                    ),
                    title: Text(variant.namePtPt),
                    subtitle: Text(variant.changesPtPt),
                    trailing: Icon(
                      _selectedVariant?.id == variant.id
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                    ),
                    onTap: () => setState(() => _selectedVariant = variant),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  List<String> _equipmentNames(List<String> ids) => [
    for (final id in ids) widget.repository.equipmentById(id)?.namePtPt ?? id,
  ];
}

class _LimitNotice extends StatelessWidget {
  const _LimitNotice({
    required this.reason,
    required this.cautions,
    required this.stopSigns,
  });
  final String reason;
  final List<String> cautions;
  final List<String> stopSigns;

  @override
  Widget build(BuildContext context) {
    final warnings = <String>{
      for (final value in [...cautions, ...stopSigns])
        if (value.trim().isNotEmpty) value.trim(),
    };
    return Semantics(
      container: true,
      label: 'Exercício com limites e cuidados específicos',
      child: Container(
        key: const ValueKey('canonical_arm_exercise_detail_limit_notice'),
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.error),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exercício com limites',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (reason.trim().isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(reason),
            ],
            for (final value in warnings)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text('- $value'),
              ),
          ],
        ),
      ),
    );
  }
}

class _VariantPanel extends StatelessWidget {
  const _VariantPanel({required this.variant});
  final CanonicalArmExerciseVariant variant;

  @override
  Widget build(BuildContext context) => Container(
    key: const ValueKey('canonical_arm_exercise_detail_variant_panel'),
    margin: const EdgeInsets.only(top: 16),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(variant.namePtPt, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 6),
        Text(variant.changesPtPt),
        const SizedBox(height: 6),
        Text(variant.mechanicalJustificationPtPt),
      ],
    ),
  );
}

class _DetailSection extends StatelessWidget {
  const _DetailSection(
    this.title, {
    this.paragraphs = const [],
    this.bullets = const [],
  });
  final String title;
  final List<String> paragraphs;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    final hasContent =
        paragraphs.any((item) => item.trim().isNotEmpty) ||
        bullets.any((item) => item.trim().isNotEmpty);
    if (!hasContent) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 8),
          for (final paragraph in paragraphs.where(
            (item) => item.trim().isNotEmpty,
          ))
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(paragraph),
            ),
          for (final bullet in bullets.where((item) => item.trim().isNotEmpty))
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('- '),
                  Expanded(child: Text(bullet)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
