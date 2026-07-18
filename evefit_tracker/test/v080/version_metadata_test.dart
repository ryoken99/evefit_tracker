import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v1.1.3 canonical training concepts public version metadata', () {
    test('app surface and release tooling identify v1.1.3 build 5', () {
      final pubspec = _contents('pubspec.yaml');
      final settings = _contents('lib/screens/settings_screen.dart');
      final cleanBaseConfig = _contents('lib/services/clean_base_config.dart');
      final readme = _contents('README.md');
      final workflow = _contents('../.github/workflows/release.yml');
      final changelog = _contents('CHANGELOG.md');
      final releaseNotes = _contents('RELEASE_NOTES.md');

      expect(
        pubspec,
        contains(RegExp(r'^version: 1\.1\.3\+5$', multiLine: true)),
      );
      expect(pubspec, isNot(contains('1.0.0-rc.1')));
      expect(
        settings,
        contains('appVersionLabel = CleanBaseConfig.versionLabel'),
      );
      expect(
        cleanBaseConfig,
        contains('EveFit v1.1.3 - Conceitos Canónicos de Treino'),
      );
      expect(settings, contains('Ver atualiza'));
      expect(settings, contains('v1.1.3'));
      expect(readme, contains('v1.1.3'));
      expect(readme, contains('1.1.3+5'));
      expect(workflow, contains("default: 'v1.1.3'"));
      expect(workflow, contains('### Novidades v1.1.3'));
      expect(
        workflow,
        contains('EveFit-v1.1.3-canonical-training-concepts-release.apk'),
      );
      expect(changelog, contains('# EveFit v1.1.3'));
      expect(releaseNotes, contains('# EveFit v1.1.3'));
      expect(changelog, contains('# EveFit v1.1.2'));
      expect(releaseNotes, contains('# EveFit v1.1.2'));
      expect(changelog, contains('# EveFit v1.1.1'));
      expect(releaseNotes, contains('# EveFit v1.1.1'));
      expect(changelog, contains('# EveFit v1.1.0'));
      expect(releaseNotes, contains('# EveFit v1.1.0'));
      expect(changelog, contains('# v1.0.0 RC'));
      expect(releaseNotes, contains('# v1.0.0 RC'));
      expect(changelog, contains('# v0.9.4'));
      expect(releaseNotes, contains('# v0.9.4'));
    });

    test('release notes contain the required integrity summary', () {
      final documents = [
        _contents('CHANGELOG.md'),
        _contents('RELEASE_NOTES.md'),
      ];
      const requiredLines = [
        'Corrigido isolamento de objetivos e milestones por perfil.',
        'Corrigido isolamento de equipamentos e locais por perfil.',
        'Corrigidos filtros anat',
        'Revistas descri',
        'Expandido cat',
        'Corrigido encoding corrompido.',
        'Corrigida associa',
        'Melhoradas valida',
        'Atualizada vers',
        'v0.8.0.',
        'v0.9.0.',
        'v0.9.1.',
        'v0.9.2.',
        'v0.9.3.',
        'Atualizada versao da app para v0.9.4.',
        'Atualizada versao da app para v1.0.0-rc.1.',
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
