import 'package:flutter/material.dart';

import '../models/canonical_muscular_models.dart';
import '../repositories/canonical_muscular_repository.dart';
import 'canonical_arm_exercise_detail_screen.dart';

class CanonicalMuscleDetailScreen extends StatelessWidget {
  const CanonicalMuscleDetailScreen({
    super.key,
    required this.repository,
    required this.muscle,
  });

  final CanonicalMuscularRepository repository;
  final CanonicalMuscle muscle;

  @override
  Widget build(BuildContext context) {
    final results = repository.exercisesForMuscle(muscle.id);
    final components = repository.componentsForMuscle(muscle.id);
    final joints = repository.jointsForMuscle(muscle.id);
    final actions = repository.actionsForMuscle(muscle.id);
    return Scaffold(
      appBar: AppBar(title: Text(muscle.namePtPt)),
      body: SafeArea(
        child: ListView(
          key: const ValueKey('canonical_muscle_detail_screen'),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _Heading(muscle.namePtPt, level: 1),
            _Section(
              'Identificação',
              paragraphs: [
                if (muscle.nameEn.trim().isNotEmpty)
                  'Nome em inglês: ${muscle.nameEn}.',
                if (muscle.nameLatin.trim().isNotEmpty)
                  'Nome anatómico: ${muscle.nameLatin}.',
                muscle.descriptionPtPt,
              ],
            ),
            _Section(
              'Localização',
              paragraphs: [
                'Região: $_regionName.',
                'Grupo: $_groupName.',
                'Origem: ${muscle.originPtPt}',
                'Inserção: ${muscle.insertionPtPt}',
                'Inervação: ${muscle.innervationPtPt}',
                'Arquitetura: ${muscle.architecture}',
              ],
            ),
            _Section(
              'Componentes',
              bullets: [
                for (final component in components)
                  '${component.namePtPt}: ${component.descriptionPtPt}',
              ],
            ),
            _Section(
              'Articulações',
              bullets: [for (final joint in joints) joint.namePtPt],
            ),
            _Section(
              'Ações',
              bullets: [
                for (final action in actions)
                  '${action.namePtPt}: ${action.descriptionPtPt}',
              ],
            ),
            _Section(
              'Ênfase prática e treinabilidade',
              paragraphs: [
                muscle.practicalEmphasis,
                muscle.trainabilitySummaryPtPt,
              ],
            ),
            _Section(
              'Limites e confiança',
              paragraphs: [
                muscle.limitationsPtPt,
                'Confiança: ${muscle.confidence}.',
              ],
            ),
            const _Heading('Exercícios relacionados', level: 2),
            const SizedBox(height: 8),
            if (results.isEmpty)
              const Text(
                'Ainda não existem exercícios canónicos aprovados para este músculo.',
              )
            else
              for (final result in results)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    key: ValueKey(
                      'canonical_muscle_detail_exercise_${result.exercise.id}',
                    ),
                    title: Text(result.content.namePtPt),
                    subtitle: Text(result.content.objectivePtPt),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => CanonicalArmExerciseDetailScreen(
                          repository: repository,
                          result: result,
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  String get _regionName {
    for (final region in repository.publicRegions) {
      if (region.id == muscle.regionId) return region.namePtPt;
    }
    return muscle.regionId;
  }

  String get _groupName {
    for (final group in repository.groupsForRegion(muscle.regionId)) {
      if (group.id == muscle.groupId) return group.namePtPt;
    }
    return muscle.groupId;
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text, {required this.level});
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

class _Section extends StatelessWidget {
  const _Section(
    this.title, {
    this.paragraphs = const [],
    this.bullets = const [],
  });
  final String title;
  final List<String> paragraphs;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    final values = [
      ...paragraphs.where((value) => value.trim().isNotEmpty),
      ...bullets.where((value) => value.trim().isNotEmpty),
    ];
    if (values.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Heading(title, level: 2),
          const SizedBox(height: 8),
          for (final paragraph in paragraphs.where(
            (value) => value.trim().isNotEmpty,
          ))
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(paragraph),
            ),
          for (final bullet in bullets.where(
            (value) => value.trim().isNotEmpty,
          ))
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
