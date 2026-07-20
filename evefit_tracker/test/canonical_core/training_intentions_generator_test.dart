import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const sourceDirectory = 'docs/canonical/source/training_intentions';
  const generatedDirectory =
      'lib/features/canonical_core/generated/training_intentions';
  const manifestPath =
      'docs/canonical/generated/training_intentions_v0.4.1_manifest.json';

  test(
    'immutable source documents and manifest retain the generator contract',
    () async {
      final v04 = File(
        '$sourceDirectory/'
        'EveFit_Training_Intentions_Production_Registry_v0.4.md',
      );
      final v041 = File(
        '$sourceDirectory/'
        'EveFit_Training_Intentions_Production_Registry_v0.4.1.md',
      );
      expect(await v04.length(), greaterThan(1000000));
      expect(await v041.length(), greaterThan(1000000));
      expect(
        (await v04.readAsLines()).first,
        '# EveFit: Registo de Intenções de Produção v0.4',
      );
      expect(
        (await v041.readAsLines()).first,
        '# EveFit: Registo de Intenções de Produção v0.4.1',
      );

      final manifest =
          jsonDecode(await File(manifestPath).readAsString())
              as Map<String, dynamic>;
      expect(manifest['generator_version'], '1.0.0');
      expect(manifest['registry_version'], '0.4.1');
      expect(
        manifest['generation_id'],
        'training-intentions-v0.4.1-4d6f6d06f8f5',
      );
      expect(
        manifest['source_files']['$sourceDirectory/'
            'EveFit_Training_Intentions_Production_Registry_v0.4.md']['sha256'],
        'd9cf51727dc28aa078b7cc55fa0f6246360e86bcba93b40fe34feac9ac7f50ad',
      );
      expect(
        manifest['source_files']['$sourceDirectory/'
            'EveFit_Training_Intentions_Production_Registry_v0.4.1.md']['sha256'],
        '4d6f6d06f8f593f549dfd0ab132ce09f92ec760dfed11966cdd816be3506c0d8',
      );
      expect(manifest.containsKey('timestamp'), isFalse);
    },
  );

  test(
    'committed generated outputs match the deterministic manifest inventory',
    () async {
      final manifest =
          jsonDecode(await File(manifestPath).readAsString())
              as Map<String, dynamic>;
      final outputHashes =
          manifest['output_hashes_normalized'] as Map<String, dynamic>;
      expect(outputHashes, hasLength(10));
      for (final path in outputHashes.keys) {
        final file = File(path);
        expect(await file.exists(), isTrue, reason: path);
        expect(await file.length(), greaterThan(0), reason: path);
      }

      final generatedFiles = Directory(generatedDirectory)
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'));
      expect(generatedFiles, hasLength(10));
      expect(manifest['counts']['global_intentions'], 591);
      expect(manifest['counts']['path_intention_links'], 771);
      expect(manifest['counts']['historic_v03_ids'], 693);
      expect(manifest['counts']['historic_v03_occurrences'], 792);
      expect(manifest['counts']['contextual_labels'], 59);
      expect(
        manifest['historic_v03_audit']['complete_mapping_emitted_to_runtime'],
        isFalse,
      );
      expect(
        manifest['runtime_separation']['markdown_parsed_at_runtime'],
        isFalse,
      );
      expect(
        manifest['runtime_separation']['executable_equipment_fields_present'],
        isFalse,
      );
      expect(
        manifest['runtime_separation']['executable_environment_fields_present'],
        isFalse,
      );
    },
  );
}
