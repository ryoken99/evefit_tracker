import 'package:evefit_tracker/features/canonical_core/repositories/generated_canonical_muscular_repository.dart';
import 'package:evefit_tracker/features/canonical_core/screens/canonical_arm_exercise_detail_screen.dart';
import 'package:evefit_tracker/features/canonical_core/screens/canonical_muscle_detail_screen.dart';
import 'package:evefit_tracker/features/canonical_core/screens/muscular_anatomy_browser_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = GeneratedCanonicalMuscularRepository();

  testWidgets('upper body is an explicit root before arm and forearm', (
    tester,
  ) async {
    await _pumpBrowser(tester, repository);

    expect(
      find.byKey(const ValueKey('muscular_anatomy_region_upper_body')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('muscular_anatomy_region_arm')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('muscular_anatomy_region_forearm')),
      findsNothing,
    );

    await tester.tap(
      find.byKey(const ValueKey('muscular_anatomy_region_upper_body')),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('muscular_anatomy_region_arm')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('muscular_anatomy_region_forearm')),
      findsOneWidget,
    );
    expect(repository.publicRegions, hasLength(2));
    expect(
      repository.publicRegions.expand(
        (region) => repository.groupsForRegion(region.id),
      ),
      hasLength(7),
    );
    expect(
      repository.publicRegions
          .expand((region) => repository.groupsForRegion(region.id))
          .expand((group) => repository.musclesForGroup(group.id))
          .map((muscle) => muscle.id)
          .toSet(),
      hasLength(23),
    );
  });

  testWidgets(
    'group complete results are deduplicated and classified by role',
    (tester) async {
      await _openFocus(tester, repository, 'arm', 'anterior_arm');

      expect(
        find.byKey(
          const ValueKey('muscular_anatomy_focus_anterior_arm_complete'),
        ),
        findsOneWidget,
      );
      await tester.tap(
        find.byKey(
          const ValueKey('muscular_anatomy_focus_anterior_arm_complete'),
        ),
      );
      await tester.pumpAndSettle();

      final results = repository.exercisesForGroup('anterior_arm');
      expect(results, isNotEmpty);
      expect(
        results.map((result) => result.exercise.id).toSet(),
        hasLength(results.length),
      );
      expect(
        find.byKey(
          ValueKey('muscular_anatomy_exercise_${results.first.exercise.id}'),
        ),
        findsOneWidget,
      );
      expect(find.text('Alvo principal'), findsOneWidget);
      expect(find.text('Oposição resistida do polegar'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('coracobrachialis has an honest empty state and muscle detail', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 10000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final muscle = repository.muscleById('coracobrachialis');
    expect(muscle, isNotNull);
    expect(repository.exercisesForMuscle(muscle!.id), isEmpty);
    await tester.pumpWidget(
      MaterialApp(
        home: CanonicalMuscleDetailScreen(
          repository: repository,
          muscle: muscle,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('canonical_muscle_detail_screen')),
      findsOneWidget,
    );
    expect(find.text('Coracobraquial'), findsWidgets);
    expect(
      find.text(
        'Ainda não existem exercícios canónicos aprovados para este músculo.',
      ),
      findsOneWidget,
    );
    expect(find.text('Oposição resistida do polegar'), findsNothing);
  });

  testWidgets('breadcrumb, home and system back preserve browser navigation', (
    tester,
  ) async {
    await _openFocus(tester, repository, 'forearm', 'posterior_forearm_deep');

    expect(
      find.byKey(const ValueKey('muscular_anatomy_breadcrumb')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('muscular_anatomy_breadcrumb_upper_body')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('muscular_anatomy_breadcrumb_forearm')),
      findsOneWidget,
    );

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      find.byKey(
        const ValueKey('muscular_anatomy_group_posterior_forearm_deep'),
      ),
      findsOneWidget,
    );

    await tester.tap(
      find.byKey(const ValueKey('muscular_anatomy_browser_home')),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('muscular_anatomy_region_upper_body')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('muscular_anatomy_browser_home')),
      findsNothing,
    );
  });

  testWidgets(
    'limited dead hang exposes caution and towel hang updates variant panel',
    (tester) async {
      tester.view.physicalSize = const Size(800, 10000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final result = repository.exerciseById('dead_hang');
      expect(result, isNotNull);
      expect(result!.exercise.hasLimits, isTrue);
      expect(
        result.variants
            .where((variant) => variant.id == 'towel_hang')
            .single
            .parentExerciseId,
        'dead_hang',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CanonicalArmExerciseDetailScreen(
            repository: repository,
            result: result,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final limitNotice = find.byKey(
        const ValueKey('canonical_arm_exercise_detail_limit_notice'),
      );
      expect(limitNotice, findsOneWidget);
      expect(
        find.descendant(
          of: limitNotice,
          matching: find.text(
            '- Parar se surgir dor articular aguda, dormência, perda súbita de força ou alteração clara da técnica.',
          ),
        ),
        findsOneWidget,
      );
      final semantics = tester.widget<Semantics>(
        find.ancestor(of: limitNotice, matching: find.byType(Semantics)).first,
      );
      expect(
        semantics.properties.label,
        'Exercício com limites e cuidados específicos',
      );
      final towelHang = find.byKey(
        const ValueKey('canonical_arm_exercise_variant_towel_hang'),
      );
      expect(towelHang, findsOneWidget);

      await tester.tap(towelHang);
      await tester.pumpAndSettle();
      expect(
        find.byKey(
          const ValueKey('canonical_arm_exercise_detail_variant_panel'),
        ),
        findsOneWidget,
      );
      expect(find.text('Suspensão em toalha'), findsWidgets);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'browser remains scrollable with small, tall, landscape and large text',
    (tester) async {
      for (final configuration in const [
        (Size(320, 568), 1.6),
        (Size(430, 932), 1.0),
        (Size(932, 430), 1.6),
      ]) {
        tester.view.physicalSize = configuration.$1;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          KeyedSubtree(
            key: ValueKey('responsive_${configuration.$1}_${configuration.$2}'),
            child: MaterialApp(
              home: MediaQuery(
                data: MediaQueryData(
                  size: configuration.$1,
                  textScaler: TextScaler.linear(configuration.$2),
                ),
                child: MuscularAnatomyBrowserScreen(repository: repository),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await _tapVisible(
          tester,
          find.byKey(const ValueKey('muscular_anatomy_region_upper_body')),
        );
        await _tapVisible(
          tester,
          find.byKey(const ValueKey('muscular_anatomy_region_forearm')),
        );
        final group = find.byKey(
          const ValueKey('muscular_anatomy_group_anterior_forearm_superficial'),
          skipOffstage: false,
        );
        await _bringIntoViewport(tester, group);
        expect(group, findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    },
  );
}

Future<void> _pumpBrowser(
  WidgetTester tester,
  GeneratedCanonicalMuscularRepository repository,
) async {
  await tester.pumpWidget(
    MaterialApp(home: MuscularAnatomyBrowserScreen(repository: repository)),
  );
  await tester.pumpAndSettle();
}

Future<void> _openFocus(
  WidgetTester tester,
  GeneratedCanonicalMuscularRepository repository,
  String regionId,
  String groupId,
) async {
  await _pumpBrowser(tester, repository);
  await _tapVisible(
    tester,
    find.byKey(const ValueKey('muscular_anatomy_region_upper_body')),
  );
  await _tapVisible(
    tester,
    find.byKey(ValueKey('muscular_anatomy_region_$regionId')),
  );
  await _tapVisible(
    tester,
    find.byKey(ValueKey('muscular_anatomy_group_$groupId')),
  );
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await _bringIntoViewport(tester, finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _bringIntoViewport(
  WidgetTester tester,
  Finder target, {
  Finder? scrollable,
}) async {
  final scrollableFinder = scrollable == null
      ? find.byType(Scrollable).last
      : find.descendant(of: scrollable, matching: find.byType(Scrollable));
  final height = tester.view.physicalSize.height;
  for (var attempt = 0; attempt < 30; attempt++) {
    if (target.evaluate().isNotEmpty) {
      final center = tester.getCenter(target.first);
      if (center.dy >= 24 && center.dy <= height - 24) return;
      final state = tester.state<ScrollableState>(scrollableFinder);
      final delta = center.dy < 24
          ? center.dy - height * 0.35
          : center.dy - height * 0.65;
      final targetOffset = (state.position.pixels + delta).clamp(
        0.0,
        state.position.maxScrollExtent,
      );
      state.position.jumpTo(targetOffset);
      await tester.pumpAndSettle();
      continue;
    }
    await tester.drag(scrollableFinder, const Offset(0, -220));
    await tester.pumpAndSettle();
  }
  expect(target, findsOneWidget);
}
