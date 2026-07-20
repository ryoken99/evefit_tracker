import 'package:flutter/material.dart';

import '../models/training_intention_models.dart';

/// Product copy for resolved training intentions. This intentionally contains
/// no registry identifiers because these widgets are a presentation boundary.
abstract final class TrainingIntentionCopy {
  static const String highRisk = 'Exigência elevada.';
  static const String clinicallyRestrictedRisk =
      'Restrição clínica: depende de elegibilidade, sem decidir o resultado.';
  static const String clinicalReviewRequired = 'Revisão clínica necessária.';
  static const String returnToFunction =
      'No retorno à função, a elegibilidade e a progressão são confirmadas fora desta intenção.';
}

class TrainingIntentionList extends StatefulWidget {
  const TrainingIntentionList({
    super.key,
    required this.title,
    required this.intentions,
    this.onIntentionTap,
    this.padding = const EdgeInsets.all(16),
  });

  /// The host owns the page title and supplies it here.
  final String title;
  final List<CanonicalResolvedPathIntention> intentions;
  final ValueChanged<CanonicalResolvedPathIntention>? onIntentionTap;
  final EdgeInsetsGeometry padding;

  @override
  State<TrainingIntentionList> createState() => _TrainingIntentionListState();
}

class _TrainingIntentionListState extends State<TrainingIntentionList> {
  bool _advancedExpanded = false;

  @override
  Widget build(BuildContext context) {
    final groups = _groupIntentions(widget.intentions);
    final slivers = <Widget>[
      SliverPadding(
        padding: widget.padding,
        sliver: SliverToBoxAdapter(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    ];

    for (final group in groups.visibleGroups) {
      slivers.add(
        _TrainingIntentionGroup(
          title: group.title,
          intentions: group.intentions,
          padding: widget.padding,
          onTap: _openDetail,
        ),
      );
    }

    if (groups.advanced.isNotEmpty) {
      slivers.add(
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            widget.padding.horizontal / 2,
            4,
            widget.padding.horizontal / 2,
            widget.padding.vertical / 2,
          ),
          sliver: SliverToBoxAdapter(
            child: Semantics(
              button: true,
              expanded: _advancedExpanded,
              label: 'Opções avançadas',
              child: TextButton.icon(
                key: const ValueKey('training_intention_advanced_toggle'),
                onPressed: () => setState(() {
                  _advancedExpanded = !_advancedExpanded;
                }),
                icon: Icon(
                  _advancedExpanded ? Icons.expand_less : Icons.expand_more,
                ),
                label: const Text('Opções avançadas'),
              ),
            ),
          ),
        ),
      );
      if (_advancedExpanded) {
        slivers.add(
          _TrainingIntentionGroup(
            title: 'Opções avançadas',
            intentions: groups.advanced,
            padding: widget.padding,
            onTap: _openDetail,
            key: const ValueKey('training_intention_advanced_group'),
          ),
        );
      }
    }

    return CustomScrollView(
      key: const ValueKey('training_intention_list'),
      slivers: slivers,
    );
  }

  void _openDetail(CanonicalResolvedPathIntention intention) {
    widget.onIntentionTap?.call(intention);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => TrainingIntentionDetailSheet(intention: intention),
    );
  }
}

class _TrainingIntentionGroup extends StatelessWidget {
  const _TrainingIntentionGroup({
    super.key,
    required this.title,
    required this.intentions,
    required this.padding,
    required this.onTap,
  });

  final String title;
  final List<CanonicalResolvedPathIntention> intentions;
  final EdgeInsetsGeometry padding;
  final ValueChanged<CanonicalResolvedPathIntention> onTap;

  @override
  Widget build(BuildContext context) => SliverMainAxisGroup(
    slivers: [
      SliverPadding(
        padding: EdgeInsets.fromLTRB(
          padding.horizontal / 2,
          20,
          padding.horizontal / 2,
          8,
        ),
        sliver: SliverToBoxAdapter(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: padding.horizontal / 2),
        sliver: SliverList.builder(
          itemCount: intentions.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TrainingIntentionCard(
              intention: intentions[index],
              onTap: () => onTap(intentions[index]),
            ),
          ),
        ),
      ),
    ],
  );
}

class TrainingIntentionCard extends StatelessWidget {
  const TrainingIntentionCard({
    super.key,
    required this.intention,
    required this.onTap,
  });

  final CanonicalResolvedPathIntention intention;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labels = intention.link.contextualLabelsPtPt;
    final roleLabel = intention.link.role.presentationLabel;
    final effective = EffectiveTrainingIntentionFlags.from(intention);
    final semanticLabel = [
      intention.definition.pillar.displayNamePtPt,
      roleLabel,
      intention.definition.effectPtPt,
      if (labels.isNotEmpty) 'Contexto: ${labels.join(', ')}',
      ...effective.alerts,
    ].join('. ');

    return Semantics(
      button: true,
      enabled: true,
      label: semanticLabel,
      hint: 'Abre o detalhe da intenção',
      child: Card(
        key: ValueKey('training_intention_card_${intention.cardIdentity}'),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _RoleBadge(label: roleLabel),
                    _RiskBadge(risk: effective.risk),
                    ...effective.alerts.map(_AlertBadge.new),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  intention.definition.pillar.displayNamePtPt,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(intention.definition.effectPtPt),
                if (labels.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    labels.first,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrainingIntentionDetailSheet extends StatelessWidget {
  const TrainingIntentionDetailSheet({super.key, required this.intention});

  final CanonicalResolvedPathIntention intention;

  @override
  Widget build(BuildContext context) {
    final definition = intention.definition;
    final path = intention.path;
    final effective = EffectiveTrainingIntentionFlags.from(intention);
    final details = <_DetailRowData>[
      _DetailRowData('Nome', definition.pillar.displayNamePtPt),
      _DetailRowData('Definição', definition.effectPtPt),
      _DetailRowData('Tipo', definition.type.presentationLabel),
      _DetailRowData('Contexto', path.contextNotesPtPt),
      _DetailRowData('Capacidade', definition.primaryTargetPtPt),
      _DetailRowData('Conceito', path.rationalePtPt),
      _DetailRowData(
        'Etiqueta contextual',
        _joinOrFallback(intention.link.contextualLabelsPtPt),
      ),
      _DetailRowData('Papel', intention.link.role.presentationLabel),
      _DetailRowData('Risco', effective.riskLabel),
      _DetailRowData('Revisão', effective.reviewLabel),
      _DetailRowData(
        'Base de evidência',
        definition.evidenceBasis.presentationLabel,
      ),
      _DetailRowData('Limite da evidência', definition.evidenceLimitPtPt),
      _DetailRowData('Segurança', definition.generalSafetyNotePtPt),
    ];

    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 8, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Detalhe da intenção',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Fechar',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                key: ValueKey(
                  'training_intention_detail_${intention.cardIdentity}',
                ),
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                itemCount:
                    details.length +
                    (path.key.usageContextId == 'return_to_function' ? 1 : 0),
                separatorBuilder: (_, _) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  if (index == details.length) {
                    return _ProductNotice(
                      text: TrainingIntentionCopy.returnToFunction,
                    );
                  }
                  final detail = details[index];
                  return _DetailRow(detail: detail);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EffectiveTrainingIntentionFlags {
  const EffectiveTrainingIntentionFlags({
    required this.risk,
    required this.clinicalReviewRequired,
  });

  factory EffectiveTrainingIntentionFlags.from(
    CanonicalResolvedPathIntention intention,
  ) {
    final baseRisk = intention.definition.operationalRiskTier;
    final pathRisk = intention.path.operationalRiskModifier;
    final risk =
        pathRisk == CanonicalPathOperationalRiskModifier.clinicallyRestricted
        ? CanonicalOperationalRiskTier.clinicallyRestricted
        : pathRisk == CanonicalPathOperationalRiskModifier.mayEscalateToHigh &&
              baseRisk != CanonicalOperationalRiskTier.clinicallyRestricted
        ? CanonicalOperationalRiskTier.high
        : baseRisk;
    final clinicalReviewRequired =
        intention.definition.clinicalReviewRequired ==
            CanonicalClinicalReviewRequirement.yes ||
        intention.path.clinicalReviewModifier ==
            CanonicalPathClinicalReviewModifier.required;
    return EffectiveTrainingIntentionFlags(
      risk: risk,
      clinicalReviewRequired: clinicalReviewRequired,
    );
  }

  final CanonicalOperationalRiskTier risk;
  final bool clinicalReviewRequired;

  String get riskLabel => risk.presentationLabel;

  String get reviewLabel => clinicalReviewRequired
      ? TrainingIntentionCopy.clinicalReviewRequired
      : 'Sem revisão clínica obrigatória declarada.';

  List<String> get alerts => [
    if (clinicalReviewRequired) TrainingIntentionCopy.clinicalReviewRequired,
  ];
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    ),
  );
}

class _AlertBadge extends StatelessWidget {
  const _AlertBadge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(label, style: Theme.of(context).textTheme.labelSmall),
      ),
    ),
  );
}

class _RiskBadge extends StatelessWidget {
  const _RiskBadge({required this.risk});

  final CanonicalOperationalRiskTier risk;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final warning =
        risk == CanonicalOperationalRiskTier.high ||
        risk == CanonicalOperationalRiskTier.clinicallyRestricted;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: warning
            ? colorScheme.errorContainer
            : colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          risk.presentationLabel,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}

class _DetailRowData {
  const _DetailRowData(this.label, this.value);

  final String label;
  final String value;
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.detail});

  final _DetailRowData detail;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '${detail.label}: ${detail.value}',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(detail.label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 3),
        Text(detail.value),
      ],
    ),
  );
}

class _ProductNotice extends StatelessWidget {
  const _ProductNotice({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    label: text,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    ),
  );
}

class _IntentionGroup {
  const _IntentionGroup(this.title, this.intentions);

  final String title;
  final List<CanonicalResolvedPathIntention> intentions;
}

class _GroupedIntentions {
  const _GroupedIntentions({
    required this.visibleGroups,
    required this.advanced,
  });

  final List<_IntentionGroup> visibleGroups;
  final List<CanonicalResolvedPathIntention> advanced;
}

_GroupedIntentions _groupIntentions(
  List<CanonicalResolvedPathIntention> intentions,
) {
  List<CanonicalResolvedPathIntention> forRoles(
    Set<CanonicalTrainingIntentionRole> roles,
  ) =>
      intentions
          .where((intention) => roles.contains(intention.link.role))
          .toList()
        ..sort(
          (left, right) =>
              left.link.displayOrder.compareTo(right.link.displayOrder),
        );

  final primary = forRoles({
    CanonicalTrainingIntentionRole.principalCandidate,
    CanonicalTrainingIntentionRole.alternativePrimary,
  });
  final complementary = forRoles({
    CanonicalTrainingIntentionRole.complementary,
  });
  final conditional = forRoles({
    CanonicalTrainingIntentionRole.conditionalComplementary,
  });
  final advanced = forRoles({CanonicalTrainingIntentionRole.hiddenAdvanced});

  return _GroupedIntentions(
    visibleGroups: [
      if (primary.isNotEmpty)
        _IntentionGroup('Principais e alternativas', primary),
      if (complementary.isNotEmpty)
        _IntentionGroup('Complementares', complementary),
      if (conditional.isNotEmpty)
        _IntentionGroup('Complementares condicionais', conditional),
    ],
    advanced: advanced,
  );
}

String _joinOrFallback(List<String> values) =>
    values.isEmpty ? 'Sem etiqueta contextual declarada.' : values.join(', ');

extension on CanonicalTrainingIntentionRole {
  String get presentationLabel => switch (this) {
    CanonicalTrainingIntentionRole.principalCandidate => 'Principal',
    CanonicalTrainingIntentionRole.alternativePrimary =>
      'Alternativa principal',
    CanonicalTrainingIntentionRole.complementary => 'Complementar',
    CanonicalTrainingIntentionRole.conditionalComplementary =>
      'Complementar condicionada',
    CanonicalTrainingIntentionRole.hiddenAdvanced => 'Opção avançada',
  };
}

extension on CanonicalTrainingIntentionType {
  String get presentationLabel => switch (this) {
    CanonicalTrainingIntentionType.adaptationOutcome =>
      'Resultado de adaptação',
    CanonicalTrainingIntentionType.acutePreparation => 'Preparação aguda',
    CanonicalTrainingIntentionType.targetedActivation => 'Ativação direcionada',
    CanonicalTrainingIntentionType.recoveryActivity =>
      'Atividade de recuperação',
    CanonicalTrainingIntentionType.cooldownRegulation =>
      'Regulação do retorno à calma',
    CanonicalTrainingIntentionType.preventionCapacity =>
      'Capacidade preventiva',
    CanonicalTrainingIntentionType.functionalRestoration =>
      'Restauração funcional',
    CanonicalTrainingIntentionType.technicalLearning => 'Aprendizagem técnica',
    CanonicalTrainingIntentionType.selfRegulation => 'Autorregulação',
  };
}

extension on CanonicalOperationalRiskTier {
  String get presentationLabel => switch (this) {
    CanonicalOperationalRiskTier.low => 'Exigência baixa.',
    CanonicalOperationalRiskTier.moderate => 'Exigência moderada.',
    CanonicalOperationalRiskTier.high => TrainingIntentionCopy.highRisk,
    CanonicalOperationalRiskTier.clinicallyRestricted =>
      TrainingIntentionCopy.clinicallyRestrictedRisk,
  };
}

extension on CanonicalEvidenceBasis {
  String get presentationLabel => switch (this) {
    CanonicalEvidenceBasis.strongFamilyEvidence =>
      'Evidência forte para a família de intenções.',
    CanonicalEvidenceBasis.moderateFamilyEvidence =>
      'Evidência moderada para a família de intenções.',
    CanonicalEvidenceBasis.limitedFamilyEvidence =>
      'Evidência limitada para a família de intenções.',
    CanonicalEvidenceBasis.professionalConsensus => 'Consenso profissional.',
    CanonicalEvidenceBasis.productOntologyInference =>
      'Inferência da organização do produto.',
  };
}

extension TrainingIntentionIdentity on CanonicalResolvedPathIntention {
  String get cardIdentity =>
      '${definition.pillar.id}_${path.key.usageContextId}_${path.key.capabilityRootId}_${path.key.trainingConceptId}';
}
