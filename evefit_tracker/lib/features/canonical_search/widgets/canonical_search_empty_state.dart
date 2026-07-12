import 'package:flutter/material.dart';

import '../models/canonical_search_models.dart';

class CanonicalSearchEmptyState extends StatelessWidget {
  const CanonicalSearchEmptyState({super.key, required this.path});

  final List<CanonicalSearchFilterNode> path;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          key: const ValueKey('canonical_search_empty_state'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.construction_outlined, size: 44),
            const SizedBox(height: 16),
            Text(
              'Este catálogo está a ser construído por fases.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Os exercícios desta categoria serão adicionados e validados progressivamente.',
            ),
            const SizedBox(height: 20),
            Text(
              'Caminho escolhido',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 6),
            Text(
              path.map((node) => node.displayNamePtPt).join(' > '),
              key: const ValueKey('canonical_search_empty_path'),
            ),
          ],
        ),
      ),
    );
  }
}
