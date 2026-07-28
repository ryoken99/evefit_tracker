import 'package:evefit_tracker/main.dart' as app;
import 'package:evefit_tracker/services/startup_catalog_diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/eft_landing_test_helper.dart';

const _expectLegacyRuntime = bool.fromEnvironment(
  'EVEFIT_EXPECT_LEGACY_RUNTIME',
);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('records deterministic clean-start catalogue diagnostics', (
    tester,
  ) async {
    final startup = Stopwatch()..start();
    app.main();
    await dismissEftLanding(tester);

    final profileGate = find.text('Configura\u00e7\u00e3o inicial');
    final deadline = DateTime.now().add(const Duration(minutes: 12));
    while (DateTime.now().isBefore(deadline)) {
      await tester.pump(const Duration(milliseconds: 100));
      if (profileGate.evaluate().isNotEmpty) break;
    }
    expect(profileGate, findsOneWidget);
    startup.stop();

    final diagnostics = StartupCatalogDiagnostics.snapshot;
    if (_expectLegacyRuntime) {
      expect(diagnostics.legacySeedExecuted, isTrue);
      expect(diagnostics.legacyEntriesProcessed, greaterThan(0));
    } else {
      expect(diagnostics.legacySeedExecuted, isFalse);
      expect(diagnostics.legacyEntriesProcessed, 0);
    }

    // Machine-readable markers consumed by the PowerShell laboratory script.
    // ignore: avoid_print
    print('EVEFIT_STARTUP_TO_USABLE_MS=${startup.elapsedMilliseconds}');
    // ignore: avoid_print
    print(
      'EVEFIT_DATABASE_OPEN_MS='
      '${diagnostics.databaseOpenDuration.inMilliseconds}',
    );
    // ignore: avoid_print
    print(
      'EVEFIT_LEGACY_SEED_DURATION_MS='
      '${diagnostics.legacySeedDuration.inMilliseconds}',
    );
    // ignore: avoid_print
    print(
      'EVEFIT_LEGACY_SEED_INVOCATIONS='
      '${diagnostics.legacySeedInvocations}',
    );
    // ignore: avoid_print
    print(
      'EVEFIT_LEGACY_ENTRIES_PROCESSED='
      '${diagnostics.legacyEntriesProcessed}',
    );
  });
}
