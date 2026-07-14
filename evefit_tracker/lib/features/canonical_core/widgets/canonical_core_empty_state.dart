import 'package:flutter/material.dart';

import '../models/canonical_core_models.dart';
import 'canonical_core_icon_resolver.dart';

class CanonicalCoreEmptyState extends StatelessWidget {
  const CanonicalCoreEmptyState({
    super.key,
    required this.axisDefinition,
    required this.value,
    required this.result,
    this.rootKey = const ValueKey('canonical_core_empty_state'),
    this.activeCriterionKey = const ValueKey('canonical_core_active_criterion'),
    this.resultTotalKey = const ValueKey('canonical_core_result_total'),
  });

  final CanonicalPillarAxisDefinition axisDefinition;
  final CanonicalPillarDefinition value;
  final CanonicalSearchResult<Object?> result;
  final Key rootKey;
  final Key activeCriterionKey;
  final Key resultTotalKey;

  @override
  Widget build(BuildContext context) {
    final isCapability = value.axis == CanonicalPillarAxis.capabilityRoot;
    return SingleChildScrollView(
      key: rootKey,
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
                'Este catálogo está a ser construído por fases.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                isCapability
                    ? 'Os exercícios compatíveis com esta capacidade serão adicionados e validados progressivamente.'
                    : 'Os exercícios compatíveis com este contexto serão adicionados e validados progressivamente.',
              ),
              const SizedBox(height: 20),
              Text('Pilar', style: Theme.of(context).textTheme.labelLarge),
              Text(
                isCapability ? 'Raiz de capacidade' : 'Contexto de utilização',
              ),
              const SizedBox(height: 12),
              Text('Seleção', style: Theme.of(context).textTheme.labelLarge),
              Text(value.displayNamePtPt),
              const SizedBox(height: 12),
              Text(
                'Critério ativo',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                '${axisDefinition.displayNamePtPt}: ${value.displayNamePtPt}',
                key: activeCriterionKey,
              ),
              const SizedBox(height: 12),
              Text('Resultados: ${result.total}', key: resultTotalKey),
            ],
          ),
        ),
      ),
    );
  }
}
