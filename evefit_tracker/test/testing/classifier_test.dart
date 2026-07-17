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

    test('fails closed for unknown, deleted, and renamed changes', () {
      for (final change in const [
        ChangedFile('assets/unclassified.bin'),
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
  });
}
