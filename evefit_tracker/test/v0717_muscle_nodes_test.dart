import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_muscle_node_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Curl martelo uses brachialis and brachioradialis as primary nodes', () {
    final nodes = _nodesFor('Curl martelo', 'Bíceps');

    expect(
      nodes.primary,
      allOf(contains('Braquial'), contains('Braquiorradial')),
    );
    expect(nodes.primary.trim(), isNot('Bíceps'));
    expect(
      nodes.secondary,
      allOf(
        contains('Bíceps cabeça longa'),
        contains('Bíceps cabeça curta'),
        contains('Flexores do antebraço'),
      ),
    );
  });

  test('Curl Zottman exposes biceps heads, brachialis and brachioradialis', () {
    final nodes = _nodesFor('Curl Zottman', 'Bíceps');

    expect(
      nodes.primary,
      allOf(
        contains('Bíceps cabeça longa'),
        contains('Bíceps cabeça curta'),
        contains('Braquial'),
        contains('Braquiorradial'),
      ),
    );
    expect(
      nodes.secondary,
      allOf(
        contains('Extensores do antebraço'),
        contains('Flexores do antebraço'),
      ),
    );
  });

  test('forearm and grip exercises expose real forearm nodes', () {
    expect(
      _nodesFor('Wrist curl', 'Antebraço/Pega').primary,
      allOf(contains('Flexores do antebraço'), contains('Punho')),
    );
    expect(
      _nodesFor('Reverse wrist curl', 'Antebraço/Pega').primary,
      allOf(contains('Extensores do antebraço'), contains('Punho')),
    );
    expect(
      _nodesFor('Farmer walk', 'Antebraço/Pega').primary,
      contains('Força de pega'),
    );
    expect(
      _nodesFor('Hold estático com halteres', 'Antebraço/Pega').primary,
      contains('Força de pega'),
    );
  });

  test('triceps exercises expose triceps head specificity', () {
    expect(
      _nodesFor('Tríceps testa com halteres', 'Tríceps').primary,
      contains('Tríceps cabeça longa'),
    );
    expect(
      _nodesFor('Extensão francesa com halter', 'Tríceps').primary,
      contains('Tríceps cabeça longa'),
    );
    expect(
      _nodesFor('Kickback de tríceps', 'Tríceps').primary,
      allOf(
        contains('Tríceps cabeça lateral'),
        contains('Tríceps cabeça medial'),
      ),
    );
  });
}

ExerciseMuscleNodes _nodesFor(String name, String group) {
  final entry = ExerciseCatalogContextService.entryFor(
    name: name,
    group: group,
  );
  return ExerciseMuscleNodeService.nodesForCatalogEntry(entry);
}
