import 'package:evefit_tracker/services/catalog_quality/catalog_route_registry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.6 route registry exposes both exercise and menu indexes', () {
    final registry = CatalogRouteRegistry.build();

    expect(registry.exerciseRoutes, isNotEmpty);
    expect(registry.routeExercises, isNotEmpty);
    expect(
      registry.visibleReachableExerciseKeys.length,
      greaterThanOrEqualTo(800),
    );
  });

  test('v0.9.6 mandatory exercises have at least one visible route', () {
    final registry = CatalogRouteRegistry.build();

    for (final key in const {
      'press_militar_com_halteres__ombros',
      'supino_com_barra__peito',
      'prancha__core',
      'agachamento_com_peso_corporal__pernas',
      'passadeira_resistencia_aerobia__cardio',
      'passadeira_intervalos__cardio',
      'kihon__karate',
      'technical_stand_up_lento__mobilidade',
      'mobilidade_de_anca__mobilidade',
      'respiracao_diafragmatica__mobilidade',
    }) {
      expect(
        registry.routesForExercise(key),
        isNotEmpty,
        reason: '$key should be reachable by at least one menu route',
      );
    }
  });
}
