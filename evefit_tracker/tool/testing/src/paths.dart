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

File safeJsonReportFile(Directory root, String input) {
  final normalized = normalizeRepositoryPath(input);
  if (!normalized.toLowerCase().endsWith('.json')) {
    throw FormatException('JSON report path must end with .json: $input');
  }
  return File(
    '${root.absolute.path}${Platform.pathSeparator}${normalized.replaceAll('/', Platform.pathSeparator)}',
  );
}

File resolveLocalApk(Directory root, String input) {
  final value = input.trim();
  if (value.isEmpty || value.contains('\u0000')) {
    throw FormatException('APK path is empty or invalid');
  }
  if (value.startsWith(r'\\') ||
      value.startsWith('//') ||
      RegExp(r'^[A-Za-z][A-Za-z0-9+.-]*://').hasMatch(value)) {
    throw FormatException('APK path must reference a local file: $input');
  }
  final supplied = File(value);
  final file = supplied.isAbsolute
      ? supplied.absolute
      : File('${root.absolute.path}${Platform.pathSeparator}$value').absolute;
  if (!file.path.toLowerCase().endsWith('.apk')) {
    throw FormatException('APK path must end with .apk: $input');
  }
  if (!file.existsSync()) {
    throw FormatException('APK file does not exist: ${file.path}');
  }
  return file;
}
