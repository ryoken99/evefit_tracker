import 'package:evefit_tracker/services/v099b6b_mobility_flexibility_domain_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('v0.9.9B6B keeps mobility active and flexibility sustained', () {
    final mobilityEntries = v099b6bMobilityFlexibilityDomainEntries.where(
      (entry) => entry.primaryType == 'mobilidade',
    );
    final flexibilityEntries = v099b6bMobilityFlexibilityDomainEntries.where(
      (entry) => entry.primaryType == 'elasticidade',
    );

    for (final entry in mobilityEntries) {
      expect(
        entry.safety.toLowerCase(),
        contains('movimento ativo'),
        reason: '${entry.name} must describe active mobility',
      );
      expect(
        entry.name.toLowerCase().startsWith('alongamento'),
        isFalse,
        reason: '${entry.name} must not be classified as stretching',
      );
    }

    for (final entry in flexibilityEntries) {
      expect(
        entry.safety.toLowerCase(),
        contains('alongamento confortavel'),
        reason: '${entry.name} must describe sustained stretching',
      );
      expect(
        entry.safety.toLowerCase(),
        isNot(contains('curar')),
        reason: '${entry.name} must not promise pain or stiffness cures',
      );
    }
  });
}
