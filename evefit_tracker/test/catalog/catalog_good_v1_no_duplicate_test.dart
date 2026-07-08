import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GOOD_V1 catalog has no duplicate catalog entries or name contexts', () {
    final catalogKeys = <String>{};
    final nameContexts = <String>{};

    for (final entry in ExerciseCatalogContextService.entries) {
      expect(
        catalogKeys.add(entry.catalogEntryKey),
        isTrue,
        reason: 'Duplicate catalog entry key: ${entry.catalogEntryKey}',
      );
      expect(
        nameContexts.add('${entry.exerciseKey}__${entry.contextKey}'),
        isTrue,
        reason: 'Duplicate exercise/context: ${entry.name}',
      );
    }
  });
}
