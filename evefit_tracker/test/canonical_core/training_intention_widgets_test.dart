import 'package:evefit_tracker/features/canonical_core/models/canonical_core_models.dart';
import 'package:evefit_tracker/features/canonical_core/models/training_intention_models.dart';
import 'package:evefit_tracker/features/canonical_core/widgets/training_intention_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the exact mandatory product copy', () {
    expect(TrainingIntentionCopy.highRisk, 'Exigência elevada');
    expect(
      TrainingIntentionCopy.clinicallyRestrictedRisk,
      'Utilização dependente de critérios de elegibilidade ou avaliação profissional.',
    );
    expect(
      TrainingIntentionCopy.clinicalReviewRequired,
      'Esta intenção requer revisão clínica antes de ser utilizada numa decisão individual.',
    );
    expect(
      TrainingIntentionCopy.returnToFunction,
      'Retorno à função não substitui diagnóstico, reabilitação, critérios clínicos ou autorização de retorno ao desporto.',
    );
  });

  final items = <CanonicalResolvedPathIntention>[
    _item(role: CanonicalTrainingIntentionRole.principalCandidate, order: 2),
    _item(role: CanonicalTrainingIntentionRole.alternativePrimary, order: 1),
    _item(role: CanonicalTrainingIntentionRole.complementary, order: 1),
    _item(
      role: CanonicalTrainingIntentionRole.conditionalComplementary,
      order: 1,
    ),
    _item(role: CanonicalTrainingIntentionRole.hiddenAdvanced, order: 1),
  ];

  testWidgets('groups all five roles and keeps link display order', (
    tester,
  ) async {
    await _pump(tester, items);

    expect(find.text('Principais e alternativas'), findsOneWidget);
    expect(find.text('Complementares'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Alternativa principal')).dy,
      lessThan(tester.getTopLeft(find.text('Principal')).dy),
    );
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('training_intention_advanced_toggle')),
      180,
    );
    expect(
      find.byKey(const ValueKey('training_intention_advanced_toggle')),
      findsOneWidget,
    );
    expect(find.text('Opção avançada'), findsNothing);
  });

  testWidgets('keeps advanced options collapsed until expanded', (
    tester,
  ) async {
    await _pump(tester, items);

    expect(find.text('Opção avançada'), findsNothing);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('training_intention_advanced_toggle')),
      180,
    );
    await tester.tap(
      find.byKey(const ValueKey('training_intention_advanced_toggle')),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('training_intention_advanced_group')),
      180,
    );
    expect(
      find.byKey(const ValueKey('training_intention_advanced_group')),
      findsOneWidget,
    );
    expect(find.text('Opção avançada'), findsOneWidget);
  });

  testWidgets(
    'shows exact risk and review copy only in their applicable cards',
    (tester) async {
      await _pump(tester, [
        _item(risk: CanonicalOperationalRiskTier.low),
        _item(risk: CanonicalOperationalRiskTier.moderate, order: 2),
        _item(risk: CanonicalOperationalRiskTier.high, order: 3),
        _item(
          risk: CanonicalOperationalRiskTier.low,
          riskModifier:
              CanonicalPathOperationalRiskModifier.clinicallyRestricted,
          order: 4,
        ),
      ]);

      expect(find.text(TrainingIntentionCopy.highRisk), findsOneWidget);
      expect(
        find.text(TrainingIntentionCopy.clinicallyRestrictedRisk),
        findsOneWidget,
      );
      expect(
        find.text(TrainingIntentionCopy.clinicalReviewRequired),
        findsNothing,
      );
      expect(
        EffectiveTrainingIntentionFlags.from(
          _item(
            risk: CanonicalOperationalRiskTier.moderate,
            riskModifier:
                CanonicalPathOperationalRiskModifier.mayEscalateToHigh,
          ),
        ).risk,
        CanonicalOperationalRiskTier.high,
      );
    },
  );

  testWidgets(
    'shows clinical and return-to-function notes in accessible detail',
    (tester) async {
      final item = _item(
        review: CanonicalClinicalReviewRequirement.yes,
        usageContextId: 'return_to_function',
      );
      await _pump(tester, [item]);

      await tester.tap(
        find.byKey(ValueKey('training_intention_card_${item.cardIdentity}')),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(TrainingIntentionCopy.clinicalReviewRequired),
        findsWidgets,
      );
      await tester.scrollUntilVisible(
        find.text(TrainingIntentionCopy.returnToFunction),
        180,
        scrollable: find.byType(Scrollable).last,
      );
      expect(find.text(TrainingIntentionCopy.returnToFunction), findsOneWidget);
      expect(find.text('Base de evidência'), findsOneWidget);
      expect(find.text('Segurança'), findsOneWidget);
      expect(find.text('demo_intention'), findsNothing);
    },
  );

  testWidgets(
    'provides stable card keys, semantics, and narrow large-text layout',
    (tester) async {
      final item = _item(
        labels: [
          'Etiqueta longa para confirmar quebra de linha segura',
          'Segunda etiqueta',
        ],
        review: CanonicalClinicalReviewRequirement.yes,
      );
      await tester.binding.setSurfaceSize(const Size(320, 568));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await _pump(tester, [item], textScaleFactor: 1.6);

      final card = find.byKey(
        ValueKey('training_intention_card_${item.cardIdentity}'),
      );
      expect(card, findsOneWidget);
      expect(
        find.bySemanticsLabel(RegExp('Intenção de demonstração')),
        findsWidgets,
      );
      expect(tester.takeException(), isNull);
    },
  );
}

Future<void> _pump(
  WidgetTester tester,
  List<CanonicalResolvedPathIntention> items, {
  double textScaleFactor = 1,
}) => tester.pumpWidget(
  MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(textScaleFactor)),
      child: Scaffold(
        body: TrainingIntentionList(title: 'Intenções', intentions: items),
      ),
    ),
  ),
);

CanonicalResolvedPathIntention _item({
  CanonicalTrainingIntentionRole role =
      CanonicalTrainingIntentionRole.principalCandidate,
  CanonicalOperationalRiskTier risk = CanonicalOperationalRiskTier.low,
  CanonicalPathOperationalRiskModifier riskModifier =
      CanonicalPathOperationalRiskModifier.inheritOnly,
  CanonicalClinicalReviewRequirement review =
      CanonicalClinicalReviewRequirement.no,
  String usageContextId = 'main_training',
  List<String> labels = const ['Etiqueta contextual'],
  int order = 1,
}) => CanonicalResolvedPathIntention(
  definition: CanonicalTrainingIntentionDefinition(
    pillar: const CanonicalPillarDefinition(
      id: 'demo_intention',
      axis: CanonicalPillarAxis.trainingIntention,
      displayNamePtPt: 'Intenção de demonstração',
      descriptionPtPt: 'Definição do pilar',
      status: CanonicalDefinitionStatus.approved,
      displayOrder: 1,
      iconKey: CanonicalCoreIconKey.intentionAxis,
    ),
    type: CanonicalTrainingIntentionType.adaptationOutcome,
    effectPtPt: 'Definição de apresentação sem prescrição.',
    primaryTargetPtPt: 'Capacidade de demonstração',
    horizon: CanonicalTrainingHorizon.chronic,
    declaredUsageContextIds: const [],
    declaredCapabilityRootIds: const [],
    declaredTrainingConceptIds: const [],
    occurrenceCount: 1,
    possibleRoles: const [],
    globallyIncompatibleAlternativeIds: const [],
    globallyCompatibleComplementaryIds: const [],
    relevantPopulationPtPt: const [],
    evidenceBasis: CanonicalEvidenceBasis.moderateFamilyEvidence,
    sourceCodes: const ['hidden'],
    evidenceLimitPtPt: 'Limite de evidência de demonstração.',
    reviewState: 'approved',
    clinicalReviewRequired: review,
    operationalRiskTier: risk,
    generalSafetyNotePtPt: 'Nota de segurança de demonstração.',
    sourceOrder: 1,
    sourceRegistryVersion: 'test',
    runtimeProvenanceId: 'test',
  ),
  path: CanonicalTrainingPathDefinition(
    sourceNumber: 1,
    key: CanonicalTrainingPathKey(
      usageContextId: usageContextId,
      capabilityRootId: 'capacity',
      trainingConceptId: 'concept',
    ),
    status: CanonicalTrainingPathStatus.compatible,
    rationalePtPt: 'Conceito em linguagem de produto.',
    contextNotesPtPt: 'Contexto em linguagem de produto.',
    alternativesAndComplementariesPtPt: '',
    limitsPtPt: '',
    progressionPtPt: '',
    intensityAndPrescriptionPtPt: '',
    eligibilityAndSafetyPtPt: '',
    operationalRiskModifier: riskModifier,
    operationalRiskModifierPtPt: '',
    clinicalReviewModifier: CanonicalPathClinicalReviewModifier.inheritOnly,
    clinicalReviewModifierPtPt: '',
    sourceRegistryVersion: 'test',
    runtimeProvenanceId: 'test',
  ),
  link: CanonicalPathIntentionLink(
    pathSourceNumber: 1,
    intentionId: 'demo_intention',
    role: role,
    displayOrder: order,
    contextualLabelsPtPt: labels,
    sourceRegistryVersion: 'test',
    runtimeProvenanceId: 'test',
  ),
);
