import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/testing/src/git_changes.dart';
import '../../tool/testing/src/models.dart';

void main() {
  late Directory gitRoot;
  late Directory projectRoot;

  setUp(() {
    gitRoot = Directory.systemTemp.createTempSync('evefit-git-changes-');
    projectRoot = Directory(
      '${gitRoot.path}${Platform.pathSeparator}evefit_tracker',
    )..createSync();
  });

  tearDown(() => gitRoot.deleteSync(recursive: true));

  test(
    'discovers add modify delete and rename with a monorepo prefix',
    () async {
      final runner = FakeGitRunner([
        GitProcessOutput(0, '${gitRoot.path}\n', ''),
        const GitProcessOutput(
          0,
          'A\u0000evefit_tracker/lib/new.dart\u0000'
              'M\u0000evefit_tracker/lib/service.dart\u0000'
              'D\u0000evefit_tracker/lib/old.dart\u0000'
              'R100\u0000evefit_tracker/lib/before.dart\u0000'
              'evefit_tracker/lib/after.dart\u0000',
          '',
        ),
      ]);
      final result = await discoverGitChanges(
        projectRoot,
        baseRef: 'origin/main',
        runner: runner,
      );
      expect(result.succeeded, isTrue);
      expect(result.files.map((file) => file.path), [
        'lib/new.dart',
        'lib/service.dart',
        'lib/old.dart',
        'lib/after.dart',
      ]);
      expect(result.files.map((file) => file.status), [
        ChangeStatus.added,
        ChangeStatus.modified,
        ChangeStatus.deleted,
        ChangeStatus.renamed,
      ]);
      expect(runner.arguments.last, [
        'diff',
        '--name-status',
        '--find-renames',
        '-z',
        'origin/main',
      ]);
    },
  );

  test(
    'allows approved repository paths and rejects other parent paths',
    () async {
      final approved = await discoverGitChanges(
        projectRoot,
        baseRef: 'origin/main',
        runner: FakeGitRunner([
          GitProcessOutput(0, '${gitRoot.path}\n', ''),
          const GitProcessOutput(
            0,
            'M\u0000.github/workflows/test.yml\u0000'
                'M\u0000.gitattributes\u0000'
                'M\u0000README.md\u0000',
            '',
          ),
        ]),
      );
      expect(approved.succeeded, isTrue);
      expect(approved.files.map((file) => file.path), [
        '.github/workflows/test.yml',
        '.gitattributes',
        'README.md',
      ]);

      final rejected = await discoverGitChanges(
        projectRoot,
        baseRef: 'origin/main',
        runner: FakeGitRunner([
          GitProcessOutput(0, '${gitRoot.path}\n', ''),
          const GitProcessOutput(0, 'M\u0000notes/private.txt\u0000', ''),
        ]),
      );
      expect(rejected.exitCode, exitPolicy);
      expect(rejected.reason, contains('not approved'));
    },
  );

  test('explicit flags take precedence and preserve statuses', () async {
    final runner = FakeGitRunner(const []);
    final result = await resolveChangedFiles(
      const [
        'fast',
        '--added',
        'lib/new.dart',
        '--changed',
        'lib/service.dart',
        '--base-ref',
        'missing-ref',
      ],
      projectRoot,
      runner: runner,
    );
    expect(result.source, 'explicit');
    expect(result.files.map((file) => file.status), [
      ChangeStatus.added,
      ChangeStatus.modified,
    ]);
    expect(runner.arguments, isEmpty);
  });

  test(
    'invalid ref, unavailable Git, and empty diff return stable failures',
    () async {
      final invalid = await discoverGitChanges(
        projectRoot,
        baseRef: 'missing-ref',
        runner: FakeGitRunner([
          GitProcessOutput(0, '${gitRoot.path}\n', ''),
          const GitProcessOutput(128, '', 'fatal: bad revision'),
        ]),
      );
      expect(invalid.exitCode, exitPolicy);
      expect(invalid.reason, contains('missing-ref'));

      final unavailable = await discoverGitChanges(
        projectRoot,
        baseRef: 'origin/main',
        runner: FakeGitRunner([ProcessException('git', const [], 'not found')]),
      );
      expect(unavailable.exitCode, exitEnvironment);
      expect(unavailable.reason, contains('Git is unavailable'));

      final empty = await discoverGitChanges(
        projectRoot,
        baseRef: 'origin/main',
        runner: FakeGitRunner([
          GitProcessOutput(0, '${gitRoot.path}\n', ''),
          const GitProcessOutput(0, '', ''),
        ]),
      );
      expect(empty.exitCode, exitPolicy);
      expect(empty.reason, contains('diff is empty'));
    },
  );
}

class FakeGitRunner implements GitProcessRunner {
  FakeGitRunner(List<Object> results) : _results = [...results];

  final List<Object> _results;
  final List<List<String>> arguments = [];

  @override
  Future<GitProcessOutput> run(
    List<String> arguments, {
    required Directory workingDirectory,
  }) async {
    this.arguments.add([...arguments]);
    if (_results.isEmpty) {
      throw StateError('Unexpected Git invocation');
    }
    final result = _results.removeAt(0);
    if (result is ProcessException) throw result;
    return result as GitProcessOutput;
  }
}
