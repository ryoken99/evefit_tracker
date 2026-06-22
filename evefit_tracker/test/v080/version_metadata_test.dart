import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.8.0 public version metadata', () {
    test('all current release surfaces identify v0.8.0', () {
      final pubspec = _contents('pubspec.yaml');
      final settings = _contents('lib/screens/settings_screen.dart');
      final readme = _contents('README.md');
      final workflow = _contents('../.github/workflows/release.yml');
      final changelog = _contents('CHANGELOG.md');
      final releaseNotes = _contents('RELEASE_NOTES.md');

      expect(pubspec, contains(RegExp(r'^version: 0\.8\.0$', multiLine: true)));
      expect(pubspec, isNot(contains('0.8.0+25')));
      expect(settings, contains("appVersionLabel = 'v0.8.0'"));
      expect(settings, contains('Ver atualizações v0.8.0'));
      expect(readme, contains('v0.8.0'));
      expect(workflow, contains("default: 'v0.8.0'"));
      expect(workflow, contains('### Novidades v0.8.0'));
      expect(changelog, contains('# v0.8.0'));
      expect(releaseNotes, contains('# v0.8.0'));
    });

    test('release notes contain the required integrity summary', () {
      final documents = [
        _contents('CHANGELOG.md'),
        _contents('RELEASE_NOTES.md'),
      ];
      const requiredLines = [
        'Corrigido isolamento de objetivos e milestones por perfil.',
        'Corrigido isolamento de equipamentos e locais por perfil.',
        'Corrigidos filtros anatómicos dos exercícios.',
        'Revistas descrições e execuções individuais dos exercícios.',
        'Expandido catálogo de exercícios por músculo, equipamento e local.',
        'Corrigido encoding corrompido.',
        'Corrigida associação de templates a exercícios.',
        'Melhoradas validações e testes.',
        'Atualizada versão da app para v0.8.0.',
      ];

      for (final document in documents) {
        for (final line in requiredLines) {
          expect(document, contains(line), reason: line);
        }
      }
    });
  });
}

String _contents(String path) {
  final file = File(path);
  return file.existsSync() ? file.readAsStringSync() : '';
}
