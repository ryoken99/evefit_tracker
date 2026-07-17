import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/testing/src/profiler.dart';

void main() {
  test('parses JSONL after Flutter preamble and emits a stable JSON schema', () {
    final file = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}evefit-profile-${DateTime.now().microsecondsSinceEpoch}.jsonl',
    );
    addTearDown(() => file.deleteSync());
    file.writeAsStringSync(
      '''Resolving dependencies...\n{"suite":{"id":0,"path":"test/a_test.dart"},"type":"suite","time":0}\n{"test":{"id":1,"name":"works","suiteID":0},"type":"testStart","time":10}\n{"testID":1,"type":"testDone","time":35}\n''',
    );
    final summary = profileFlutterJsonl(file);
    expect(summary.fileMilliseconds['test/a_test.dart'], 25);
    expect(summary.totalMilliseconds, 25);
    expect(summary.ignoredLines, 1);
    final json = summary.toJson();
    expect(
      json.keys,
      containsAll(<String>[
        'totalMilliseconds',
        'files',
        'tests',
        'topTenFiles',
        'topTenTests',
        'ignoredLines',
      ]),
    );
    expect(jsonDecode(jsonEncode(json)), isA<Map<String, dynamic>>());
  });

  test('accepts UTF-16 Flutter event files', () {
    final file = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}evefit-profile-${DateTime.now().microsecondsSinceEpoch}.jsonl',
    );
    addTearDown(() => file.deleteSync());
    final text =
        'Resolving dependencies...\n'
        '{"suite":{"id":0,"path":"test/a_test.dart"},"type":"suite"}\n'
        '{"test":{"id":1,"name":"works","suiteID":0},"type":"testStart","time":0}\n'
        '{"testID":1,"type":"testDone","time":10}\n';
    final bytes = <int>[0xff, 0xfe];
    for (final unit in text.codeUnits) {
      bytes
        ..add(unit & 0xff)
        ..add(unit >> 8);
    }
    file.writeAsBytesSync(bytes);
    expect(profileFlutterJsonl(file).totalMilliseconds, 10);
  });
}
