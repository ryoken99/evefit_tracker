import 'dart:io';

import 'package:evefit_tracker/features/canonical_core/generated/training_intentions/training_intentions_provenance.g.dart';
import 'package:evefit_tracker/features/canonical_core/generated/training_intentions/training_intentions_registry.g.dart';
import 'package:evefit_tracker/features/canonical_core/generated/training_intentions/training_path_intention_links.g.dart';
import 'package:evefit_tracker/features/canonical_core/generated/training_intentions/training_paths_registry.g.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/models/training_intention_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('generated training intentions retain the closed runtime contract', () {
    final definitions = generatedCanonicalTrainingIntentionDefinitions;
    final paths = generatedCanonicalTrainingPaths;
    final links = generatedCanonicalPathIntentionLinks;

    expect(definitions, hasLength(591));
    expect(paths, hasLength(280));
    expect(links, hasLength(771));
    expect(
      definitions.map((definition) => definition.pillar.id).toSet(),
      hasLength(591),
    );
    expect(
      definitions.map((definition) => definition.pillar.axis),
      everyElement(CanonicalPillarAxis.trainingIntention),
    );
    expect(
      definitions.map((definition) => definition.pillar.status),
      everyElement(CanonicalDefinitionStatus.approved),
    );
    expect(
      definitions.map((definition) => definition.sourceOrder),
      List<int>.generate(591, (index) => index + 1),
    );
    expect(
      paths.map((path) => path.sourceNumber),
      List<int>.generate(280, (index) => index + 1),
    );
    expect(
      paths.where(
        (path) => path.status == CanonicalTrainingPathStatus.compatible,
      ),
      hasLength(261),
    );
    expect(
      paths.where(
        (path) => path.status == CanonicalTrainingPathStatus.incompatible,
      ),
      hasLength(19),
    );

    final definitionIds = definitions
        .map((definition) => definition.pillar.id)
        .toSet();
    final definitionsById = {
      for (final definition in definitions) definition.pillar.id: definition,
    };
    final pathsBySourceNumber = {
      for (final path in paths) path.sourceNumber: path,
    };
    expect(
      links.every((link) => definitionIds.contains(link.intentionId)),
      isTrue,
    );
    expect(
      links.every(
        (link) =>
            paths.any((path) => path.sourceNumber == link.pathSourceNumber),
      ),
      isTrue,
    );
    for (final definition in definitions) {
      expect(
        definition.globallyIncompatibleAlternativeIds.every(
          definitionIds.contains,
        ),
        isTrue,
        reason: definition.pillar.id,
      );
      expect(
        definition.globallyCompatibleComplementaryIds.every(
          definitionIds.contains,
        ),
        isTrue,
        reason: definition.pillar.id,
      );
    }
    for (final link in links) {
      final definition = definitionsById[link.intentionId]!;
      final path = pathsBySourceNumber[link.pathSourceNumber]!;
      expect(
        definition.declaredUsageContextIds.contains(path.key.usageContextId),
        isTrue,
        reason: '${link.pathSourceNumber}/${link.intentionId}',
      );
      expect(
        definition.declaredCapabilityRootIds.contains(
          path.key.capabilityRootId,
        ),
        isTrue,
        reason: '${link.pathSourceNumber}/${link.intentionId}',
      );
      expect(
        definition.declaredTrainingConceptIds.contains(
          path.key.trainingConceptId,
        ),
        isTrue,
        reason: '${link.pathSourceNumber}/${link.intentionId}',
      );
    }
  });

  test('every source role count is preserved by its emitted links', () async {
    final source = await File(
      'docs/canonical/source/training_intentions/'
      'EveFit_Training_Intentions_Production_Registry_v0.4.1.md',
    ).readAsString();
    final sourceRoleCounts = <String, Map<String, int>>{};
    for (final row in _tableRows(
      source,
      '## 20. Registo final das 591 intenções',
    )) {
      final id = RegExp(r'^`([a-z0-9_]+)`$').firstMatch(row[0])!.group(1)!;
      final occurrence = row[7].split('; ');
      final expectedTotal = int.parse(occurrence[0]);
      final roleCounts = <String, int>{};
      for (final roleCount in occurrence[1].split(', ')) {
        final parts = roleCount.split(':');
        roleCounts[parts[0]] = int.parse(parts[1]);
      }
      expect(
        roleCounts.values.reduce((left, right) => left + right),
        expectedTotal,
        reason: id,
      );
      sourceRoleCounts[id] = roleCounts;
    }

    final emittedRoleCounts = <String, Map<String, int>>{};
    for (final link in generatedCanonicalPathIntentionLinks) {
      final counts = emittedRoleCounts.putIfAbsent(
        link.intentionId,
        () => <String, int>{},
      );
      final role = link.role.contractId;
      counts[role] = (counts[role] ?? 0) + 1;
    }

    expect(sourceRoleCounts, hasLength(591));
    expect(emittedRoleCounts, hasLength(591));
    for (final entry in sourceRoleCounts.entries) {
      expect(
        emittedRoleCounts[entry.key],
        equals(entry.value),
        reason: entry.key,
      );
    }
  });

  test('enum contract IDs, display labels, and distributions are exact', () {
    expect(
      CanonicalTrainingIntentionType.adaptationOutcome.contractId,
      'adaptation_outcome',
    );
    expect(
      CanonicalTrainingIntentionType.adaptationOutcome.displayNamePtPt,
      'Resultado de adaptação',
    );
    expect(
      _distribution(
        generatedCanonicalTrainingIntentionDefinitions.map(
          (definition) => definition.type.contractId,
        ),
      ),
      const {
        'adaptation_outcome': 100,
        'acute_preparation': 89,
        'targeted_activation': 98,
        'recovery_activity': 56,
        'cooldown_regulation': 20,
        'prevention_capacity': 102,
        'functional_restoration': 92,
        'technical_learning': 25,
        'self_regulation': 9,
      },
    );
    expect(
      _distribution(
        generatedCanonicalTrainingIntentionDefinitions.map(
          (definition) => definition.operationalRiskTier.contractId,
        ),
      ),
      const {
        'low': 92,
        'moderate': 370,
        'high': 37,
        'clinically_restricted': 92,
      },
    );
    expect(
      _distribution(
        generatedCanonicalTrainingIntentionDefinitions.map(
          (definition) => definition.clinicalReviewRequired.contractId,
        ),
      ),
      const {'yes': 100, 'no': 491},
    );
    expect(
      _distribution(
        generatedCanonicalPathIntentionLinks.map(
          (link) => link.role.contractId,
        ),
      ),
      const {
        'principal_candidate': 238,
        'alternative_primary': 74,
        'complementary': 412,
        'conditional_complementary': 33,
        'hidden_advanced': 14,
      },
    );
  });

  test(
    'runtime provenance is minimal and historic IDs stay out of generated Dart',
    () async {
      expect(generatedTrainingIntentionsRegistryVersion, '0.4.1');
      expect(generatedTrainingIntentionsGeneratorVersion, '1.0.0');
      expect(
        generatedTrainingIntentionsV04Sha256,
        'd9cf51727dc28aa078b7cc55fa0f6246360e86bcba93b40fe34feac9ac7f50ad',
      );
      expect(
        generatedTrainingIntentionsV041Sha256,
        '4d6f6d06f8f593f549dfd0ab132ce09f92ec760dfed11966cdd816be3506c0d8',
      );
      expect(
        generatedTrainingIntentionsStructuralCounts['historic_v03_ids'],
        693,
      );
      expect(
        generatedTrainingIntentionsStructuralCounts['historic_v03_occurrences'],
        792,
      );

      final labels = generatedCanonicalPathIntentionLinks
          .expand((link) => link.contextualLabelsPtPt)
          .toSet();
      final labelOccurrences = generatedCanonicalPathIntentionLinks
          .expand((link) => link.contextualLabelsPtPt)
          .length;
      expect(labels, hasLength(59));
      expect(labelOccurrences, 66);
      expect(labels.every((label) => !label.contains('_')), isTrue);

      final files = Directory(
        'lib/features/canonical_core/generated/training_intentions',
      ).listSync().whereType<File>();
      for (final file in files) {
        final content = await file.readAsString();
        expect(content.contains('v0.3'), isFalse, reason: file.path);
        expect(content.contains('decision ledger'), isFalse, reason: file.path);
        expect(content.contains('equipmentScope'), isFalse, reason: file.path);
        expect(
          content.contains('environmentScope'),
          isFalse,
          reason: file.path,
        );
      }
    },
  );
}

List<List<String>> _tableRows(String source, String heading) {
  final lines = source.split('\n');
  final headingIndex = lines.indexOf(heading);
  expect(headingIndex, isNonNegative, reason: heading);
  final sectionEnd = lines.indexWhere(
    (line) => line.startsWith('#'),
    headingIndex + 1,
  );
  final end = sectionEnd < 0 ? lines.length : sectionEnd;
  final headerIndex = lines.indexWhere(
    (line) => line.startsWith('|'),
    headingIndex + 1,
  );
  final rows = <List<String>>[];
  for (var index = headerIndex + 2; index < end; index++) {
    if (!lines[index].startsWith('|')) {
      break;
    }
    rows.add(
      lines[index]
          .substring(1, lines[index].length - 1)
          .split('|')
          .map((cell) => cell.trim())
          .toList(),
    );
  }
  return rows;
}

Map<String, int> _distribution(Iterable<String> values) {
  final result = <String, int>{};
  for (final value in values) {
    result[value] = (result[value] ?? 0) + 1;
  }
  return result;
}
