import 'dart:convert';
import 'dart:io';

class ProfileSummary {
  const ProfileSummary(
    this.fileMilliseconds,
    this.testMilliseconds,
    this.ignoredLines,
  );

  final Map<String, int> fileMilliseconds;
  final Map<String, int> testMilliseconds;
  final int ignoredLines;

  int get totalMilliseconds => fileMilliseconds.values.fold(0, (a, b) => a + b);

  List<MapEntry<String, int>> get topTenFiles => _top(fileMilliseconds);
  List<MapEntry<String, int>> get topTenTests => _top(testMilliseconds);

  Map<String, Object?> toJson() => <String, Object?>{
    'totalMilliseconds': totalMilliseconds,
    'files': _ordered(fileMilliseconds),
    'tests': _ordered(testMilliseconds),
    'topTenFiles': _top(fileMilliseconds).map(_entryJson).toList(),
    'topTenTests': _top(testMilliseconds).map(_entryJson).toList(),
    'ignoredLines': ignoredLines,
  };
}

List<MapEntry<String, int>> _top(Map<String, int> values) {
  final entries = values.entries.toList();
  entries.sort(
    (a, b) => b.value != a.value
        ? b.value.compareTo(a.value)
        : a.key.compareTo(b.key),
  );
  return entries.take(10).toList();
}

Map<String, int> _ordered(Map<String, int> values) {
  final result = <String, int>{};
  for (final key in values.keys.toList()..sort()) {
    result[key] = values[key]!;
  }
  return result;
}

Map<String, Object> _entryJson(MapEntry<String, int> entry) => <String, Object>{
  'name': entry.key,
  'milliseconds': entry.value,
};

ProfileSummary profileFlutterJsonl(File input) {
  final suitePaths = <int, String>{};
  final testSuites = <int, int>{};
  final testNames = <int, String>{};
  final starts = <int, int>{};
  final files = <String, int>{};
  final tests = <String, int>{};
  var ignored = 0;
  for (final rawLine in _readLines(input)) {
    final line = rawLine.trim();
    if (!line.startsWith('{')) {
      ignored++;
      continue;
    }
    Object? decoded;
    try {
      decoded = jsonDecode(line);
    } on FormatException {
      ignored++;
      continue;
    }
    if (decoded is! Map<String, dynamic>) {
      ignored++;
      continue;
    }
    switch (decoded['type']) {
      case 'suite':
        final suite = decoded['suite'];
        if (suite is Map && suite['id'] is int && suite['path'] is String) {
          suitePaths[suite['id'] as int] = suite['path'] as String;
        }
      case 'testStart':
        final test = decoded['test'];
        if (test is Map &&
            test['id'] is int &&
            test['suiteID'] is int &&
            decoded['time'] is int) {
          final id = test['id'] as int;
          testSuites[id] = test['suiteID'] as int;
          testNames[id] = test['name']?.toString() ?? 'test-$id';
          starts[id] = decoded['time'] as int;
        }
      case 'testDone':
        final id = decoded['testID'];
        final end = decoded['time'];
        if (id is int && end is int && starts.containsKey(id)) {
          final duration = (end - starts[id]!).clamp(0, 1 << 31);
          final suite = testSuites[id];
          if (suite != null && suitePaths.containsKey(suite)) {
            final file = suitePaths[suite]!;
            files[file] = (files[file] ?? 0) + duration;
            final name = '$file :: ${testNames[id]}';
            tests[name] = duration;
          }
        }
    }
  }
  return ProfileSummary(files, tests, ignored);
}

Iterable<String> _readLines(File input) {
  final bytes = input.readAsBytesSync();
  if (bytes.length >= 2 &&
      ((bytes[0] == 0xff && bytes[1] == 0xfe) ||
          (bytes[0] == 0xfe && bytes[1] == 0xff))) {
    final littleEndian = bytes[0] == 0xff;
    final units = <int>[];
    for (var index = 2; index + 1 < bytes.length; index += 2) {
      units.add(
        littleEndian
            ? bytes[index] | (bytes[index + 1] << 8)
            : (bytes[index] << 8) | bytes[index + 1],
      );
    }
    return const LineSplitter().convert(String.fromCharCodes(units));
  }
  return const LineSplitter().convert(utf8.decode(bytes, allowMalformed: true));
}
