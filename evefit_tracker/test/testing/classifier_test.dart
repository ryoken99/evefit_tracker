import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/testing/src/classifier.dart';
import '../../tool/testing/src/models.dart';
import '../../tool/testing/src/paths.dart';

void main() {
  group('changed-file classifier', () {
    test('applies release precedence before pipeline and UI paths', () {
      final result = classifyChangedFiles(const [
        ChangedFile('lib/screens/home_screen.dart'),
        ChangedFile('tool/testing/evefit_gate.dart'),
        ChangedFile('pubspec.yaml'),
      ]);
      expect(result.failsClosed, isFalse);
      expect(
        result.classes,
        containsAll(<ChangeClass>[
          ChangeClass.release,
          ChangeClass.pipelineTests,
          ChangeClass.uiNavigation,
        ]),
      );
    });

    test('classifies known non-UI and database/startup Dart paths', () {
      final result = classifyChangedFiles(const [
        ChangedFile('lib/services/report_service.dart'),
        ChangedFile('lib/data/database/app_database.dart'),
      ]);
      expect(result.classes, contains(ChangeClass.dartNonUi));
      expect(result.classes, contains(ChangeClass.databaseStartup));
    });

    test(
      'classifies integration tests and the Android smoke runner as UI navigation',
      () {
        final result = classifyChangedFiles(const [
          ChangedFile('integration_test/workout_flow_test.dart'),
          ChangedFile('tool/run_android_smoke.ps1'),
        ]);
        expect(result.failsClosed, isFalse);
        expect(result.classes, equals(<ChangeClass>{ChangeClass.uiNavigation}));
        expect(
          classifyChangedFiles(const [
            ChangedFile('tool/unknown_runner.ps1'),
          ]).failsClosed,
          isTrue,
        );
      },
    );

    test('fails closed for unknown, deleted, and renamed changes', () {
      for (final change in const [
        ChangedFile('assets/unclassified.bin'),
        ChangedFile('lib/a.dart', status: ChangeStatus.unknown),
        ChangedFile('lib/a.dart', status: ChangeStatus.deleted),
        ChangedFile('lib/a.dart', status: ChangeStatus.renamed),
      ]) {
        expect(classifyChangedFiles([change]).failsClosed, isTrue);
      }
    });
  });

  group('repository path normalization', () {
    test('normalizes Windows separators', () {
      expect(
        normalizeRepositoryPath(r'test\testing\gate_test.dart'),
        'test/testing/gate_test.dart',
      );
    });

    test('rejects absolute and escaping paths', () {
      for (final path in const [
        r'C:\repo\test.dart',
        '/repo/test.dart',
        '../test.dart',
        'test/../test.dart',
        'file:///tmp/a.dart',
      ]) {
        expect(() => normalizeRepositoryPath(path), throwsFormatException);
      }
    });

    test('validates safe repository JSON report paths', () {
      final root = Directory.systemTemp.createTempSync('evefit-report-path-');
      addTearDown(() => root.deleteSync(recursive: true));
      expect(
        safeJsonReportFile(root, '.dart_tool/reports/gate.json').path,
        endsWith('gate.json'),
      );
      expect(
        () => safeJsonReportFile(root, '../outside.json'),
        throwsFormatException,
      );
      expect(
        () => safeJsonReportFile(root, 'report.txt'),
        throwsFormatException,
      );
    });
  });
}
