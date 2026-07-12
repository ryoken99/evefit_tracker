class StartupCatalogDiagnosticsSnapshot {
  const StartupCatalogDiagnosticsSnapshot({
    required this.databaseOpenDuration,
    required this.legacySeedDuration,
    required this.legacySeedInvocations,
    required this.legacyEntriesProcessed,
  });

  final Duration databaseOpenDuration;
  final Duration legacySeedDuration;
  final int legacySeedInvocations;
  final int legacyEntriesProcessed;

  bool get legacySeedExecuted => legacySeedInvocations > 0;
}

class StartupCatalogDiagnostics {
  StartupCatalogDiagnostics._();

  static Stopwatch? _databaseOpenStopwatch;
  static final Stopwatch _legacySeedStopwatch = Stopwatch();
  static int _legacySeedInvocations = 0;
  static int _legacyEntriesProcessed = 0;
  static Duration _databaseOpenDuration = Duration.zero;

  static void beginDatabaseOpen() {
    _databaseOpenDuration = Duration.zero;
    _legacySeedStopwatch
      ..stop()
      ..reset();
    _legacySeedInvocations = 0;
    _legacyEntriesProcessed = 0;
    _databaseOpenStopwatch = Stopwatch()..start();
  }

  static void completeDatabaseOpen() {
    final stopwatch = _databaseOpenStopwatch;
    if (stopwatch == null) return;
    stopwatch.stop();
    _databaseOpenDuration = stopwatch.elapsed;
    _databaseOpenStopwatch = null;
  }

  static void beginLegacySeedPass() {
    _legacySeedInvocations++;
    _legacySeedStopwatch.start();
  }

  static void recordLegacyEntryProcessed() {
    _legacyEntriesProcessed++;
  }

  static void completeLegacySeedPass() {
    _legacySeedStopwatch.stop();
  }

  static StartupCatalogDiagnosticsSnapshot get snapshot =>
      StartupCatalogDiagnosticsSnapshot(
        databaseOpenDuration: _databaseOpenDuration,
        legacySeedDuration: _legacySeedStopwatch.elapsed,
        legacySeedInvocations: _legacySeedInvocations,
        legacyEntriesProcessed: _legacyEntriesProcessed,
      );
}
