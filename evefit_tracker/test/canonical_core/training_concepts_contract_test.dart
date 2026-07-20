import 'package:evefit_tracker/features/canonical_core/data/canonical_registry.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/models/canonical_exercise_selection_path.dart';
import 'package:evefit_tracker/features/canonical_core/services/canonical_selection_compatibility_provider.dart';
import 'package:evefit_tracker/features/canonical_core/validators/canonical_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const registry = CanonicalRegistry();
  const provider = RegistryCanonicalSelectionCompatibilityProvider();
  const validator = CanonicalValidator();

  test('the 35 global training concepts retain their approved definitions', () {
    const expected = <String, ({String name, String definition})>{
      'overcome_resistance': (
        name: 'Vencer resistência',
        definition:
            'Produzir força suficiente para deslocar o corpo, uma carga ou um implemento contra uma resistência.',
      ),
      'control_resistance': (
        name: 'Controlar resistência',
        definition:
            'Regular, desacelerar ou travar o movimento enquanto uma resistência atua.',
      ),
      'sustain_resistance': (
        name: 'Sustentar resistência',
        definition:
            'Manter uma posição, carga ou tensão contra uma força, sem deslocamento relevante.',
      ),
      'loaded_carry': (
        name: 'Transportar carga',
        definition:
            'Deslocar o corpo enquanto se suporta e controla uma carga.',
      ),
      'cyclic_locomotion': (
        name: 'Locomoção cíclica',
        definition:
            'Deslocar o corpo através da repetição regular de um padrão locomotor.',
      ),
      'cyclic_propulsion': (
        name: 'Propulsão cíclica',
        definition:
            'Produzir repetidamente força para deslocar o corpo, um veículo ou um implemento através de ciclos sucessivos.',
      ),
      'repetitive_rhythmic_movement': (
        name: 'Movimento rítmico repetitivo',
        definition:
            'Repetir regularmente um movimento corporal simples para sustentar esforço.',
      ),
      'repeated_multidirectional_displacement': (
        name: 'Deslocamento multidirecional repetido',
        definition:
            'Deslocar-se repetidamente em várias direções, mudando sentido, trajetória ou orientação.',
      ),
      'repeated_motor_sequence': (
        name: 'Sequência motora repetida',
        definition:
            'Encadear várias ações diferentes numa sequência que se repete continuamente.',
      ),
      'explosive_acceleration': (
        name: 'Aceleração explosiva',
        definition:
            'Aumentar rapidamente a velocidade do corpo, de um segmento corporal ou de um implemento.',
      ),
      'ballistic_projection': (
        name: 'Projeção explosiva',
        definition:
            'Produzir impulso suficiente para lançar o corpo ou um implemento numa trajetória livre.',
      ),
      'elastic_reactive_action': (
        name: 'Ação elástico-reativa',
        definition:
            'Absorver rapidamente energia mecânica e reutilizá-la numa ação imediata de propulsão.',
      ),
      'braking_redirection': (
        name: 'Travagem e redirecionamento',
        definition:
            'Reduzir ou interromper rapidamente o movimento e produzir uma nova aceleração noutra direção.',
      ),
      'active_joint_exploration': (
        name: 'Exploração articular ativa',
        definition:
            'Mover voluntariamente uma articulação através da amplitude disponível, com controlo.',
      ),
      'range_transition': (
        name: 'Transição em amplitude',
        definition:
            'Passar entre posições que exigem diferentes amplitudes articulares.',
      ),
      'integrated_chain_mobility': (
        name: 'Mobilidade integrada em cadeia',
        definition:
            'Combinar o movimento de várias articulações numa ação contínua e coordenada.',
      ),
      'supported_loaded_mobility': (
        name: 'Mobilidade sob suporte ou carga',
        definition:
            'Expressar amplitude enquanto o corpo suporta peso ou controla uma resistência.',
      ),
      'segmental_dissociation': (
        name: 'Dissociação segmentar',
        definition:
            'Mover uma região corporal mantendo outras regiões relativamente estáveis ou independentes.',
      ),
      'sustained_lengthening': (
        name: 'Alongamento sustentado',
        definition:
            'Manter um tecido ou região corporal numa posição alongada durante determinado período.',
      ),
      'dynamic_lengthening': (
        name: 'Alongamento dinâmico',
        definition:
            'Entrar e sair repetidamente de uma amplitude que alonga os tecidos envolvidos.',
      ),
      'assisted_lengthening': (
        name: 'Alongamento assistido',
        definition:
            'Utilizar uma força externa para posicionar ou aprofundar uma região corporal em alongamento.',
      ),
      'postural_stabilization': (
        name: 'Estabilização postural',
        definition:
            'Manter ou recuperar uma organização corporal estável durante uma posição ou movimento.',
      ),
      'base_of_support_control': (
        name: 'Controlo da base de apoio',
        definition:
            'Gerir a relação entre o centro de massa e a base de apoio para conservar ou recuperar equilíbrio.',
      ),
      'rhythm_synchronization': (
        name: 'Ritmo e sincronização',
        definition:
            'Organizar movimentos segundo uma sequência temporal, cadência ou relação coordenada.',
      ),
      'reactive_adjustment': (
        name: 'Ajuste reativo',
        definition:
            'Modificar rapidamente a ação corporal em resposta a uma alteração, perturbação ou estímulo.',
      ),
      'isolated_technical_practice': (
        name: 'Prática técnica isolada',
        definition:
            'Praticar uma ação técnica ou uma parte específica dela fora da situação completa.',
      ),
      'contextual_technical_application': (
        name: 'Aplicação técnica contextualizada',
        definition:
            'Executar uma técnica dentro das condições, relações ou exigências em que deverá ser utilizada.',
      ),
      'target_oriented_precision': (
        name: 'Precisão orientada a alvo',
        definition:
            'Executar uma ação procurando atingir um alvo espacial, temporal ou mecânico definido.',
      ),
      'stimulus_response_decision': (
        name: 'Resposta a estímulo e decisão',
        definition:
            'Escolher e executar uma ação adequada em resposta a informação ou estímulos relevantes.',
      ),
      'technical_variability_adaptation': (
        name: 'Adaptação técnica à variabilidade',
        definition:
            'Preservar a função essencial de uma técnica enquanto se ajusta a mudanças nas condições de execução.',
      ),
      'voluntary_breath_cycle_control': (
        name: 'Controlo voluntário do ciclo respiratório',
        definition:
            'Regular conscientemente a inspiração, expiração, pausas e ritmo respiratório.',
      ),
      'breath_movement_synchronization': (
        name: 'Sincronização entre respiração e movimento',
        definition:
            'Coordenar as fases da respiração com posições, movimentos ou momentos de produção de esforço.',
      ),
      'internal_pressure_management': (
        name: 'Gestão da pressão interna',
        definition:
            'Criar, manter ou libertar pressão interna para apoiar estabilidade, transferência de força ou controlo corporal.',
      ),
      'autonomic_modulation': (
        name: 'Modulação autonómica',
        definition:
            'Utilizar ações respiratórias e corporais para alterar o estado de ativação ou recuperação do organismo.',
      ),
      'interoceptive_monitoring_adjustment': (
        name: 'Monitorização e ajuste interoceptivo',
        definition:
            'Perceber sinais internos do corpo e ajustar conscientemente respiração, tensão, posição ou ritmo.',
      ),
    };

    final concepts = CanonicalRegistry.approvedTrainingConcepts;
    expect(concepts, hasLength(35));
    expect(concepts.map((concept) => concept.id), expected.keys);

    for (var index = 0; index < concepts.length; index++) {
      final concept = concepts[index];
      final definition = expected[concept.id]!;
      expect(concept.axis, CanonicalPillarAxis.trainingConcept);
      expect(concept.displayNamePtPt, definition.name);
      expect(concept.descriptionPtPt, definition.definition);
      expect(concept.status, CanonicalDefinitionStatus.approved);
      expect(concept.displayOrder, index);
      expect(concept.iconKey, CanonicalCoreIconKey.conceptAxis);
      expect(registry.valueById[concept.id], same(concept));
    }
  });

  test('the 40 capability-concept relations retain their exact order', () {
    const expected = <String, List<String>>{
      'muscular_capacity': [
        'overcome_resistance',
        'control_resistance',
        'sustain_resistance',
        'loaded_carry',
      ],
      'cardio_conditioning': [
        'cyclic_locomotion',
        'cyclic_propulsion',
        'repetitive_rhythmic_movement',
        'repeated_multidirectional_displacement',
        'repeated_motor_sequence',
      ],
      'speed_power': [
        'explosive_acceleration',
        'ballistic_projection',
        'elastic_reactive_action',
        'braking_redirection',
        'cyclic_locomotion',
        'repeated_multidirectional_displacement',
      ],
      'mobility': [
        'active_joint_exploration',
        'range_transition',
        'integrated_chain_mobility',
        'supported_loaded_mobility',
        'segmental_dissociation',
      ],
      'flexibility': [
        'sustained_lengthening',
        'dynamic_lengthening',
        'assisted_lengthening',
      ],
      'motor_control_coordination': [
        'postural_stabilization',
        'base_of_support_control',
        'rhythm_synchronization',
        'reactive_adjustment',
        'segmental_dissociation',
        'repeated_motor_sequence',
      ],
      'technique_skill': [
        'isolated_technical_practice',
        'contextual_technical_application',
        'target_oriented_precision',
        'stimulus_response_decision',
        'technical_variability_adaptation',
        'repeated_motor_sequence',
      ],
      'breathing_regulation': [
        'voluntary_breath_cycle_control',
        'breath_movement_synchronization',
        'internal_pressure_management',
        'autonomic_modulation',
        'interoceptive_monitoring_adjustment',
      ],
    };

    expect(CanonicalRegistry.capabilityConceptRelations, hasLength(40));
    expect(
      CanonicalRegistry.capabilityConceptRelations
          .map((relation) => relation.capabilityRootId)
          .toSet(),
      expected.keys.toSet(),
    );

    for (final entry in expected.entries) {
      final relations = registry.relationsForCapability(entry.key);
      expect(
        relations.map((relation) => relation.trainingConceptId),
        entry.value,
      );
      expect(
        relations.map((relation) => relation.displayOrder),
        List.generate(entry.value.length, (index) => index + 1),
      );
      expect(
        relations.map((relation) => relation.schemaVersion),
        everyElement(canonicalCoreSchemaVersion),
      );
      expect(
        registry
            .trainingConceptsForCapability(entry.key)
            .map((concept) => concept.id),
        entry.value,
      );
    }

    expect(
      CanonicalRegistry.capabilityConceptRelations
          .map((relation) => relation.trainingConceptId)
          .toSet(),
      CanonicalRegistry.approvedTrainingConcepts
          .map((concept) => concept.id)
          .toSet(),
    );
  });

  test('reused concepts retain a single global identity', () {
    const expectedCapabilities = <String, List<String>>{
      'repeated_motor_sequence': [
        'cardio_conditioning',
        'motor_control_coordination',
        'technique_skill',
      ],
      'segmental_dissociation': ['mobility', 'motor_control_coordination'],
      'cyclic_locomotion': ['cardio_conditioning', 'speed_power'],
      'repeated_multidirectional_displacement': [
        'cardio_conditioning',
        'speed_power',
      ],
    };

    for (final entry in expectedCapabilities.entries) {
      final globalConcept = registry.valueById[entry.key]!;
      for (final capabilityRootId in entry.value) {
        final relation = registry
            .trainingConceptsForCapability(capabilityRootId)
            .singleWhere((concept) => concept.id == entry.key);
        expect(relation, same(globalConcept));
      }
    }
  });

  test(
    'every context returns only ordered compatible path concepts for each capability',
    () {
      for (final context in CanonicalRegistry.approvedUsageContexts) {
        for (final capability in CanonicalRegistry.approvedCapabilityRoots) {
          final path = CanonicalExerciseSelectionPath(
            usageContextId: context.id,
            capabilityRootId: capability.id,
          );
          final concepts = provider.compatibleTrainingConcepts(path);
          final registryConcepts = registry.trainingConceptsForPath(
            context.id,
            capability.id,
          );

          expect(
            concepts.map((concept) => concept.id),
            registryConcepts.map((concept) => concept.id),
            reason: '${context.id}/${capability.id}',
          );
          for (var index = 0; index < concepts.length; index++) {
            expect(
              concepts[index],
              same(registryConcepts[index]),
              reason: '${context.id}/${capability.id}',
            );
          }
        }
      }
    },
  );

  test('concept compatibility requires context and capability selections', () {
    expect(
      provider.compatibleTrainingConcepts(
        const CanonicalExerciseSelectionPath(
          capabilityRootId: 'cardio_conditioning',
        ),
      ),
      isEmpty,
    );
    expect(
      provider.compatibleTrainingConcepts(
        const CanonicalExerciseSelectionPath(usageContextId: 'warmup'),
      ),
      isEmpty,
    );
  });

  test(
    'three-criterion queries are ordered and selection state is cleared',
    () {
      final selectedCapability = const CanonicalExerciseSelectionPath(
        usageContextId: 'main_training',
      ).selectCapabilityRoot('cardio_conditioning');
      final selectedConcept = selectedCapability.selectTrainingConcept(
        'cyclic_locomotion',
      );
      final query = selectedConcept.toQuery();

      expect(validator.queryErrors(query), isEmpty);
      expect(query.criteria.map((criterion) => criterion.axis), [
        CanonicalPillarAxis.usageContext,
        CanonicalPillarAxis.capabilityRoot,
        CanonicalPillarAxis.trainingConcept,
      ]);
      expect(query.criteria.map((criterion) => criterion.valueId), [
        'main_training',
        'cardio_conditioning',
        'cyclic_locomotion',
      ]);

      final changedCapability = selectedConcept.selectCapabilityRoot(
        'speed_power',
      );
      expect(changedCapability.usageContextId, 'main_training');
      expect(changedCapability.capabilityRootId, 'speed_power');
      expect(changedCapability.trainingConceptId, isNull);
      expect(changedCapability.trainingIntentionId, isNull);

      final changedContext = selectedConcept.selectUsageContext('warmup');
      expect(changedContext.usageContextId, 'warmup');
      expect(changedContext.capabilityRootId, isNull);
      expect(changedContext.trainingConceptId, isNull);
      expect(changedContext.trainingIntentionId, isNull);
    },
  );
}
