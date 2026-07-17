import 'dart:io';

import 'models.dart';
import 'paths.dart';

class GitProcessOutput {
  const GitProcessOutput(this.exitCode, this.stdout, this.stderr);

  final int exitCode;
  final String stdout;
  final String stderr;
}

abstract interface class GitProcessRunner {
  Future<GitProcessOutput> run(
    List<String> arguments, {
    required Directory workingDirectory,
  });
}

class SystemGitProcessRunner implements GitProcessRunner {
  const SystemGitProcessRunner();

  @override
  Future<GitProcessOutput> run(
    List<String> arguments, {
    required Directory workingDirectory,
  }) async {
    final result = await Process.run(
      'git',
      arguments,
      workingDirectory: workingDirectory.path,
    );
    return GitProcessOutput(
      result.exitCode,
      result.stdout.toString(),
      result.stderr.toString(),
    );
  }
}

class ChangeResolution {
  const ChangeResolution({
    required this.files,
    required this.source,
    required this.exitCode,
    this.baseRef,
    this.gitRoot,
    this.reason,
  });

  final List<ChangedFile> files;
  final String source;
  final int exitCode;
  final String? baseRef;
  final String? gitRoot;
  final String? reason;

  bool get succeeded => exitCode == exitPass;

  Map<String, Object?> toJson() => <String, Object?>{
    'source': source,
    'baseRef': baseRef,
    'gitRoot': gitRoot,
    'files': files
        .map(
          (file) => <String, String>{
            'path': file.path,
            'status': file.status.name,
          },
        )
        .toList(),
    'exitCode': exitCode,
    'reason': reason,
  };
}

Future<ChangeResolution> resolveChangedFiles(
  List<String> arguments,
  Directory projectRoot, {
  GitProcessRunner runner = const SystemGitProcessRunner(),
}) async {
  final explicit = parseExplicitChanges(arguments);
  if (explicit.isNotEmpty) {
    return ChangeResolution(
      files: explicit,
      source: 'explicit',
      exitCode: exitPass,
    );
  }
  final baseRef = _baseRef(arguments);
  return discoverGitChanges(projectRoot, baseRef: baseRef, runner: runner);
}

List<ChangedFile> parseExplicitChanges(List<String> arguments) {
  const statuses = <String, ChangeStatus>{
    '--changed': ChangeStatus.modified,
    '--added': ChangeStatus.added,
    '--deleted': ChangeStatus.deleted,
    '--renamed': ChangeStatus.renamed,
  };
  final changes = <ChangedFile>[];
  for (var index = 0; index < arguments.length; index++) {
    final status = statuses[arguments[index]];
    if (status == null) continue;
    if (index + 1 >= arguments.length ||
        arguments[index + 1].startsWith('--')) {
      throw FormatException('${arguments[index]} requires a path');
    }
    changes.add(ChangedFile(arguments[++index], status: status));
  }
  return changes;
}

Future<ChangeResolution> discoverGitChanges(
  Directory projectRoot, {
  required String baseRef,
  GitProcessRunner runner = const SystemGitProcessRunner(),
}) async {
  _validateBaseRef(baseRef);
  try {
    final rootResult = await runner.run(const [
      'rev-parse',
      '--show-toplevel',
    ], workingDirectory: projectRoot);
    if (rootResult.exitCode != 0) {
      return ChangeResolution(
        files: const [],
        source: 'git',
        baseRef: baseRef,
        exitCode: exitEnvironment,
        reason: _message('Git repository is unavailable', rootResult.stderr),
      );
    }
    final gitRootPath = rootResult.stdout.trim();
    if (gitRootPath.isEmpty) {
      return ChangeResolution(
        files: const [],
        source: 'git',
        baseRef: baseRef,
        exitCode: exitEnvironment,
        reason: 'Git returned an empty repository root',
      );
    }
    final gitRoot = Directory(gitRootPath);
    final prefix = _projectPrefix(gitRoot, projectRoot);
    final diffResult = await runner.run([
      'diff',
      '--name-status',
      '--find-renames',
      '-z',
      baseRef,
      'HEAD',
    ], workingDirectory: projectRoot);
    if (diffResult.exitCode != 0) {
      return ChangeResolution(
        files: const [],
        source: 'git',
        baseRef: baseRef,
        gitRoot: gitRoot.absolute.path,
        exitCode: exitPolicy,
        reason: _message(
          'Git base ref is invalid or cannot be diffed: $baseRef',
          diffResult.stderr,
        ),
      );
    }
    if (diffResult.stdout.isEmpty) {
      return ChangeResolution(
        files: const [],
        source: 'git',
        baseRef: baseRef,
        gitRoot: gitRoot.absolute.path,
        exitCode: exitPolicy,
        reason: 'Git diff is empty for $baseRef..HEAD',
      );
    }
    final files = _parseNameStatus(diffResult.stdout, prefix);
    if (files.isEmpty) {
      return ChangeResolution(
        files: const [],
        source: 'git',
        baseRef: baseRef,
        gitRoot: gitRoot.absolute.path,
        exitCode: exitPolicy,
        reason: 'Git diff did not contain any changed paths for $baseRef..HEAD',
      );
    }
    return ChangeResolution(
      files: files,
      source: 'git',
      baseRef: baseRef,
      gitRoot: gitRoot.absolute.path,
      exitCode: exitPass,
    );
  } on ProcessException catch (error) {
    return ChangeResolution(
      files: const [],
      source: 'git',
      baseRef: baseRef,
      exitCode: exitEnvironment,
      reason: 'Git is unavailable: ${error.message}',
    );
  } on FormatException catch (error) {
    return ChangeResolution(
      files: const [],
      source: 'git',
      baseRef: baseRef,
      exitCode: exitPolicy,
      reason: error.message,
    );
  }
}

String _baseRef(List<String> arguments) {
  final indexes = <int>[];
  for (var index = 0; index < arguments.length; index++) {
    if (arguments[index] == '--base-ref') indexes.add(index);
  }
  if (indexes.isEmpty) {
    return 'origin/main';
  }
  if (indexes.length > 1) {
    throw const FormatException('--base-ref may be supplied only once');
  }
  final index = indexes.single;
  if (index + 1 >= arguments.length || arguments[index + 1].startsWith('--')) {
    throw const FormatException('--base-ref requires a Git ref');
  }
  final value = arguments[index + 1];
  _validateBaseRef(value);
  return value;
}

void _validateBaseRef(String value) {
  if (value.trim().isEmpty ||
      value.startsWith('-') ||
      value.contains('\u0000') ||
      RegExp(r'\s').hasMatch(value)) {
    throw FormatException('Unsafe or empty Git base ref: $value');
  }
}

String _projectPrefix(Directory gitRoot, Directory projectRoot) {
  final root = gitRoot.absolute.path
      .replaceAll('\\', '/')
      .replaceAll(RegExp(r'/$'), '');
  final project = projectRoot.absolute.path
      .replaceAll('\\', '/')
      .replaceAll(RegExp(r'/$'), '');
  final comparedRoot = Platform.isWindows ? root.toLowerCase() : root;
  final comparedProject = Platform.isWindows ? project.toLowerCase() : project;
  if (comparedProject == comparedRoot) return '';
  if (!comparedProject.startsWith('$comparedRoot/')) {
    throw FormatException(
      'Project root is outside the Git repository: $project',
    );
  }
  return project.substring(root.length + 1);
}

List<ChangedFile> _parseNameStatus(String output, String projectPrefix) {
  final tokens = output.split('\u0000');
  while (tokens.isNotEmpty && tokens.last.isEmpty) {
    tokens.removeLast();
  }
  final files = <ChangedFile>[];
  var index = 0;
  while (index < tokens.length) {
    var statusToken = tokens[index++];
    String? firstPath;
    final tab = statusToken.indexOf('\t');
    if (tab >= 0) {
      firstPath = statusToken.substring(tab + 1);
      statusToken = statusToken.substring(0, tab);
    } else {
      if (index >= tokens.length) {
        throw FormatException(
          'Malformed Git name-status output after $statusToken',
        );
      }
      firstPath = tokens[index++];
    }
    final status = _status(statusToken);
    var selectedPath = firstPath;
    if (statusToken.startsWith('R') || statusToken.startsWith('C')) {
      if (index >= tokens.length) {
        throw FormatException(
          'Malformed Git rename/copy output after $firstPath',
        );
      }
      final secondPath = tokens[index++];
      _normalizeGitPath(firstPath, projectPrefix);
      selectedPath = secondPath;
    }
    files.add(
      ChangedFile(
        _normalizeGitPath(selectedPath, projectPrefix),
        status: status,
      ),
    );
  }
  return files;
}

ChangeStatus _status(String token) {
  if (token == 'A') return ChangeStatus.added;
  if (token == 'M') return ChangeStatus.modified;
  if (token == 'D') return ChangeStatus.deleted;
  if (token.startsWith('R')) return ChangeStatus.renamed;
  return ChangeStatus.unknown;
}

String _normalizeGitPath(String input, String projectPrefix) {
  var path = input.replaceAll('\\', '/');
  if (path.startsWith('./')) path = path.substring(2);
  if (projectPrefix.isNotEmpty) {
    final prefix = projectPrefix.replaceAll('\\', '/');
    final comparedPath = Platform.isWindows ? path.toLowerCase() : path;
    final comparedPrefix = Platform.isWindows ? prefix.toLowerCase() : prefix;
    if (!comparedPath.startsWith('$comparedPrefix/')) {
      throw FormatException('Changed path is outside the project root: $input');
    }
    path = path.substring(prefix.length + 1);
  }
  return normalizeRepositoryPath(path);
}

String _message(String prefix, String detail) {
  final value = detail.trim();
  return value.isEmpty ? prefix : '$prefix: $value';
}
