import 'dart:io';

/// Converts repository-relative paths to a portable, checked representation.
String normalizeRepositoryPath(String input) {
  final value = input.trim().replaceAll('\\', '/');
  if (value.isEmpty || value.startsWith('/') || value.startsWith('file:')) {
    throw FormatException('Path must be repository-relative: $input');
  }
  if (RegExp(r'^[A-Za-z]:/').hasMatch(value)) {
    throw FormatException('Absolute Windows path is not allowed: $input');
  }
  final segments = value.split('/');
  if (segments.any(
    (segment) => segment.isEmpty || segment == '.' || segment == '..',
  )) {
    throw FormatException('Path escapes or is not normalized: $input');
  }
  return segments.join('/');
}

String repositoryRelativePath(Directory root, File file) {
  final rootPath = root.absolute.path.replaceAll('\\', '/');
  final filePath = file.absolute.path.replaceAll('\\', '/');
  if (!filePath.startsWith('$rootPath/')) {
    throw FormatException('File is outside repository: ${file.path}');
  }
  return normalizeRepositoryPath(filePath.substring(rootPath.length + 1));
}
