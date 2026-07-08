import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:flutter_test/flutter_test.dart';

const _expectedB4AActivationNames = <String>[
  'Clamshell com mini band',
  'Clamshell com mini band regressivo',
  'Clamshell com mini band com pausa curta',
  'Clamshell com mini band em ritmo lento',
  'Abducao lateral de anca deitado',
  'Abducao lateral de anca deitado regressivo',
  'Abducao lateral de anca deitado com pausa curta',
  'Abducao lateral de anca deitado em ritmo lento',
  'Ponte de gluteos com mini band',
  'Ponte de gluteos com mini band regressivo',
  'Ponte de gluteos com mini band com pausa curta',
  'Ponte de gluteos com mini band em ritmo lento',
  'Ponte unilateral regressiva',
  'Ponte unilateral regressiva regressivo',
  'Ponte unilateral regressiva com pausa curta',
  'Ponte unilateral regressiva em ritmo lento',
  'Monster walk curto',
  'Monster walk curto regressivo',
  'Monster walk curto com pausa curta',
  'Monster walk curto em ritmo lento',
  'Lateral band walk controlado',
  'Lateral band walk regressivo',
  'Dead bug com expiracao guiada',
  'Dead bug com expiracao regressivo',
  'Dead bug com expiracao com pausa curta',
  'Dead bug com expiracao em ritmo lento',
  'Bird dog com pausa',
  'Bird dog com pausa regressivo',
  'Bird dog com pausa com pausa curta',
  'Bird dog com pausa em ritmo lento',
  'Pallof press leve com elastico',
  'Pallof press leve com elastico regressivo',
  'Pallof press leve com elastico com pausa curta',
  'Pallof press leve com elastico em ritmo lento',
  'Prancha curta com joelhos',
  'Prancha curta com joelhos regressivo',
  'Prancha curta com joelhos com pausa curta',
  'Prancha curta com joelhos em ritmo lento',
  'Scapular push-up regressivo',
  'Scapular push-up regressivo nivel inicial',
  'Scapular push-up regressivo com pausa curta',
  'Scapular push-up regressivo em ritmo lento',
  'Tibial raise na parede leve',
  'Tibial raise na parede leve regressivo',
  'Tibial raise na parede leve com pausa curta',
  'Tibial raise na parede leve em ritmo lento',
  'Short foot controlado',
  'Short foot controlado regressivo',
  'Short foot controlado com pausa curta',
  'Short foot controlado em ritmo lento',
  'Elevacao de calcanhar isometrica baixa',
  'Elevacao de calcanhar isometrica baixa regressivo',
  'Elevacao de calcanhar isometrica baixa com pausa curta',
  'Elevacao de calcanhar isometrica baixa em ritmo lento',
  'Inversao de tornozelo com elastico leve',
  'Inversao de tornozelo com elastico leve regressivo',
  'Inversao de tornozelo com elastico leve com pausa curta',
  'Inversao de tornozelo com elastico leve em ritmo lento',
];

void main() {
  test('v0.9.9B4A adds 58 GOOD_V1 activation exercises with routes', () {
    final entriesByNameAndContext = {
      for (final entry in ExerciseCatalogContextService.entries)
        '${entry.name}__${entry.contextKey}': entry,
    };
    final registry = CatalogRouteRegistry.build();

    expect(_expectedB4AActivationNames, hasLength(58));

    for (final name in _expectedB4AActivationNames) {
      final entry = entriesByNameAndContext['${name}__ativacao'];
      expect(entry, isNotNull, reason: '$name must exist in B4A lot');
      final exercise = entry!.toExercise();
      expect(exercise.primaryType, 'ativacao', reason: name);
      expect(exercise.canonicalId, entry.exerciseKey, reason: name);

      final routes = registry.routesForExercise(entry.catalogEntryKey);
      expect(routes, isNotEmpty, reason: '$name must be reachable');
      expect(
        routes.any((route) => route.typeKey == 'activation'),
        isTrue,
        reason: '$name must have an activation route',
      );
    }
  });
}
