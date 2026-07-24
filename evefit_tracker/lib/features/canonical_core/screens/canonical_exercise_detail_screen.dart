import 'package:flutter/material.dart';

import '../models/canonical_exercise_models.dart';

class CanonicalExerciseDetailScreen extends StatelessWidget {
  const CanonicalExerciseDetailScreen({super.key, required this.exercise});

  final CanonicalResolvedExercise exercise;

  @override
  Widget build(BuildContext context) {
    final definition = exercise.definition;
    final content = exercise.content;
    final sections = <Widget>[
      _DetailHeading(
        key: const ValueKey('canonical_exercise_detail_name'),
        text: definition.namePtPt,
        level: 1,
      ),
      if (definition.identity.isVariant)
        const _PublicBadge(label: 'Variante', icon: Icons.call_split_outlined),
      if (definition.safety.operationalRiskTier ==
          CanonicalExerciseRiskTier.high)
        _HighRiskNotice(exercise: exercise),
      _DetailSection(
        title: 'O que é',
        paragraphs: [
          content.shortDescriptionPtPt,
          content.beginnerDefinitionPtPt,
          content.whyThisMovementExistsPtPt,
          if (content.variantExplanation case final variant?)
            'Nesta variante, ${variant.whatChangesPtPt}',
          if (content.variantExplanation case final variant?)
            variant.whatStaysTheSamePtPt,
          if (content.variantExplanation case final variant?)
            variant.whySeparatePtPt,
        ],
      ),
      _DetailSection(
        title: 'O que vais fazer',
        paragraphs: [content.whatYouWillDoPtPt],
      ),
      _DetailSection(
        title: 'Antes de começar',
        bullets: [
          ...content.beforeYouStartPtPt,
          ...content.bodyReadinessCheckPtPt,
        ],
      ),
      _DetailSection(
        title: 'Equipamento necessário',
        bullets: content.equipmentSetupPtPt,
        paragraphs: _materialRequirementLabels(definition.material),
      ),
      _DetailSection(
        title: 'Preparação do espaço',
        bullets: content.environmentSetupPtPt,
      ),
      _DetailSection(
        title: 'Posição inicial',
        paragraphs: [content.startingPositionPtPt],
        bullets: content.startingPositionChecklistPtPt,
      ),
      _DetailSection(
        title: 'Como executar',
        numberedItems: content.executionStepsPtPt,
      ),
      _MovementPhasesSection(phases: content.movementPhasesPtPt),
      _DetailSection(
        title: 'Como respirar',
        paragraphs: [content.breathingGuidancePtPt],
      ),
      _DetailSection(
        title: 'O que deves sentir',
        bullets: content.expectedSensationsPtPt,
      ),
      _DetailSection(
        title: 'Sinais inesperados ou de alerta',
        bullets: [
          ...content.unexpectedOrWarningSensationsPtPt,
          ...content.stopOrReduceSignsPtPt,
        ],
      ),
      _DetailSection(
        title: 'Pontos de controlo',
        bullets: content.principalCuesPtPt,
      ),
      _CommonErrorsSection(errors: content.commonErrorsPtPt),
      _DetailSection(
        title: 'Como simplificar',
        bullets: content.beginnerSimplificationsPtPt,
      ),
      _DetailSection(
        title: 'Quando não deves executar sozinho',
        paragraphs: [content.supervisionGuidancePtPt],
      ),
      _DetailSection(
        title: 'Como terminar',
        paragraphs: [content.endingTheExercisePtPt],
      ),
      _DetailSection(
        title: 'Segurança',
        paragraphs: [
          content.safetyNotePtPt,
          content.equipmentSafetyPtPt,
          content.environmentSafetyPtPt,
        ],
      ),
      _DetailSection(
        title: 'Evidência e limites',
        paragraphs: [content.confidencePtPt],
        bullets: content.limitationsPtPt,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(definition.namePtPt)),
      body: SafeArea(
        child: ListView(
          key: const ValueKey('canonical_exercise_detail_screen'),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            for (final section in sections)
              if (section is! _DetailSection || section.hasContent) section,
          ],
        ),
      ),
    );
  }
}

List<String> _materialRequirementLabels(
  CanonicalExerciseMaterialRequirements material,
) => [
  if (material.noEquipmentSupported) 'Pode ser realizado sem equipamento.',
  if (material.partnerRequired) 'Requer parceiro.',
  if (material.targetRequired) 'Requer um alvo adequado.',
  if (material.spotterRequired) 'Requer uma pessoa a assegurar a execução.',
  if (material.supervisionRequirement == 'required')
    'Requer supervisão.'
  else if (material.supervisionRequirement == 'recommended')
    'É recomendada supervisão.',
];

class _HighRiskNotice extends StatelessWidget {
  const _HighRiskNotice({required this.exercise});

  final CanonicalResolvedExercise exercise;

  @override
  Widget build(BuildContext context) {
    final definition = exercise.definition;
    final content = exercise.content;
    return Semantics(
      container: true,
      label: 'Aviso de exigência elevada',
      child: Container(
        key: const ValueKey('canonical_exercise_detail_high_risk'),
        margin: const EdgeInsets.only(top: 12, bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.error),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _DetailHeading(text: 'Exigência elevada', level: 2),
            const SizedBox(height: 8),
            const Text(
              'Confirma os pré-requisitos, o espaço e a supervisão antes de executar.',
            ),
            const SizedBox(height: 10),
            _BulletList(
              items: [
                ...definition.safety.eligibilityPrerequisites,
                ...content.environmentSetupPtPt,
                content.supervisionGuidancePtPt,
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Pára ou reduz perante:',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            _BulletList(items: content.stopOrReduceSignsPtPt),
          ],
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    this.paragraphs = const [],
    this.bullets = const [],
    this.numberedItems = const [],
  });

  final String title;
  final List<String> paragraphs;
  final List<String> bullets;
  final List<String> numberedItems;

  bool get hasContent =>
      paragraphs.any(_isPublicValue) ||
      bullets.any(_isPublicValue) ||
      numberedItems.any(_isPublicValue);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailHeading(text: title, level: 2),
        const SizedBox(height: 8),
        for (final paragraph in paragraphs.where(_isPublicValue)) ...[
          Text(paragraph),
          const SizedBox(height: 8),
        ],
        if (bullets.any(_isPublicValue))
          _BulletList(items: bullets.where(_isPublicValue).toList()),
        if (numberedItems.any(_isPublicValue))
          _NumberedList(items: numberedItems.where(_isPublicValue).toList()),
      ],
    ),
  );
}

class _MovementPhasesSection extends StatelessWidget {
  const _MovementPhasesSection({required this.phases});

  final List<CanonicalExerciseMovementPhase> phases;

  @override
  Widget build(BuildContext context) {
    if (phases.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _DetailHeading(text: 'Fases do movimento', level: 2),
          const SizedBox(height: 8),
          for (final phase in phases) ...[
            Text(
              phase.namePtPt,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(phase.descriptionPtPt),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _CommonErrorsSection extends StatelessWidget {
  const _CommonErrorsSection({required this.errors});

  final List<CanonicalExerciseCommonError> errors;

  @override
  Widget build(BuildContext context) {
    if (errors.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _DetailHeading(text: 'Erros comuns e correções', level: 2),
          const SizedBox(height: 8),
          for (final error in errors) ...[
            Text(
              error.errorPtPt,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text('Como reconhecer: ${error.howToRecognisePtPt}'),
            const SizedBox(height: 2),
            Text('Correção: ${error.correctionPtPt}'),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _DetailHeading extends StatelessWidget {
  const _DetailHeading({super.key, required this.text, required this.level});

  final String text;
  final int level;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(
      text,
      style: level == 1
          ? Theme.of(context).textTheme.headlineSmall
          : Theme.of(context).textTheme.titleLarge,
    ),
  );
}

class _PublicBadge extends StatelessWidget {
  const _PublicBadge({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerLeft,
    child: Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    ),
  );
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final item in items.where(_isPublicValue))
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• '),
              Expanded(child: Text(item)),
            ],
          ),
        ),
    ],
  );
}

class _NumberedList extends StatelessWidget {
  const _NumberedList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final entry in items.asMap().entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 28, child: Text('${entry.key + 1}.')),
              Expanded(child: Text(entry.value)),
            ],
          ),
        ),
    ],
  );
}

bool _isPublicValue(String value) {
  final normalized = value.trim();
  return normalized.isNotEmpty &&
      normalized != 'not_applicable' &&
      normalized != 'omitted_by_scope';
}
