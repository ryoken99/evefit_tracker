import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_exercise_selection_path.dart';
import 'package:evefit_tracker/features/canonical_core/models/training_intention_models.dart';
import 'package:evefit_tracker/features/canonical_core/services/canonical_selection_compatibility_provider.dart';
import 'package:evefit_tracker/features/canonical_core/validators/canonical_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const registry = CanonicalRegistry();
  const provider = RegistryCanonicalSelectionCompatibilityProvider();
  const validator = CanonicalValidator();

  test('registry exposes immutable path and intention indexes', () {
    expect(CanonicalRegistry.trainingIntentionDefinitions, hasLength(591));
    expect(CanonicalRegistry.trainingPaths, hasLength(280));
    expect(CanonicalRegistry.pathIntentionLinks, hasLength(771));
    expect(registry.approvedPillarValues, hasLength(641));

    final path = CanonicalRegistry.trainingPaths.firstWhere(
      (value) => registry.linksForPath(value.key).isNotEmpty,
    );
    expect(registry.pathForKey(path.key), same(path));
    expect(registry.pathForContractId(path.key.contractId), same(path));
    expect(registry.pathByKey[path.key], same(path));
    expect(() => registry.pathByKey[path.key] = path, throwsUnsupportedError);
    expect(
      () => registry
          .linksForPath(path.key)
          .add(
            const CanonicalPathIntentionLink(
              pathSourceNumber: 1,
              intentionId: 'invalid',
              role: CanonicalTrainingIntentionRole.principalCandidate,
              displayOrder: 1,
              contextualLabelsPtPt: <String>[],
              sourceRegistryVersion: 'test',
              runtimeProvenanceId: 'test',
            ),
          ),
      throwsUnsupportedError,
    );
  });

  test('the full 280 path matrix is path-aware and referentially closed', () {
    var compatiblePaths = 0;
    var incompatiblePaths = 0;

    for (final path in CanonicalRegistry.trainingPaths) {
      final selection = CanonicalExerciseSelectionPath(
        usageContextId: path.key.usageContextId,
        capabilityRootId: path.key.capabilityRootId,
        trainingConceptId: path.key.trainingConceptId,
      );
      final links = registry.linksForPath(path.key);
      final resolved = registry.resolvedOptionsForPath(path.key);
      final availableConcepts = provider
          .compatibleTrainingConcepts(
            CanonicalExerciseSelectionPath(
              usageContextId: path.key.usageContextId,
              capabilityRootId: path.key.capabilityRootId,
            ),
          )
          .map((value) => value.id)
          .toSet();
      final isSelectable =
          path.status == CanonicalTrainingPathStatus.compatible &&
          links.isNotEmpty;

      expect(registry.pathForKey(path.key), same(path));
      if (links.isEmpty) {
        expect(registry.linksByPathKey.containsKey(path.key), isFalse);
      } else {
        expect(registry.linksByPathKey[path.key], same(links));
      }
      expect(
        availableConcepts.contains(path.key.trainingConceptId),
        isSelectable,
        reason: path.key.contractId,
      );
      expect(resolved, hasLength(links.length), reason: path.key.contractId);
      expect(
        validator.queryErrors(selection.toQuery()).isEmpty,
        isSelectable,
        reason: path.key.contractId,
      );

      if (path.status == CanonicalTrainingPathStatus.incompatible) {
        incompatiblePaths++;
        expect(links, isEmpty, reason: path.key.contractId);
        expect(resolved, isEmpty, reason: path.key.contractId);
      } else {
        compatiblePaths++;
      }

      if (!isSelectable) continue;
      final options = provider.compatibleTrainingIntentions(selection);
      expect(
        options.map((value) => value.id),
        resolved.map((option) => option.definition.pillar.id),
        reason: path.key.contractId,
      );
      for (var index = 0; index < resolved.length; index++) {
        final option = resolved[index];
        expect(options[index], same(option.definition.pillar));
        expect(
          option.definition.declaredUsageContextIds,
          contains(path.key.usageContextId),
        );
        expect(
          option.definition.declaredCapabilityRootIds,
          contains(path.key.capabilityRootId),
        );
        expect(
          option.definition.declaredTrainingConceptIds,
          contains(path.key.trainingConceptId),
        );
      }
    }

    expect(compatiblePaths, 261);
    expect(incompatiblePaths, 19);
  });

  test('localized incompatible paths stay hidden from concepts', () {
    List<String> conceptsFor(String contextId, String capabilityId) => provider
        .compatibleTrainingConcepts(
          CanonicalExerciseSelectionPath(
            usageContextId: contextId,
            capabilityRootId: capabilityId,
          ),
        )
        .map((value) => value.id)
        .toList(growable: false);

    expect(conceptsFor('recovery', 'speed_power'), isEmpty);
    expect(conceptsFor('cooldown', 'speed_power'), isEmpty);
    expect(conceptsFor('activation', 'flexibility'), ['dynamic_lengthening']);
    expect(
      conceptsFor('cooldown', 'motor_control_coordination'),
      isNot(contains('reactive_adjustment')),
    );
    for (final contextId in ['recovery', 'cooldown']) {
      final concepts = conceptsFor(contextId, 'technique_skill');
      expect(concepts, isNot(contains('stimulus_response_decision')));
      expect(concepts, isNot(contains('technical_variability_adaptation')));
    }
  });
}
