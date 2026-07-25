import '../generated/exercises/canonical_exercise_beginner_content.g.dart';
import '../generated/exercises/canonical_exercise_path_links.g.dart';
import '../generated/exercises/canonical_exercises_registry.g.dart';
import '../models/canonical_core_models.dart';
import '../models/canonical_exercise_models.dart';
import '../validators/canonical_validator.dart';

abstract interface class CanonicalExerciseSearchRepository<TItem> {
  Future<CanonicalSearchResult<TItem>> search(CanonicalSearchQuery query);
}

class EmptyCanonicalExerciseSearchRepository<TItem>
    implements CanonicalExerciseSearchRepository<TItem> {
  const EmptyCanonicalExerciseSearchRepository({
    this.validator = const CanonicalValidator(),
  });

  final CanonicalValidator validator;

  @override
  Future<CanonicalSearchResult<TItem>> search(
    CanonicalSearchQuery query,
  ) async {
    final errors = validator.queryErrors(query);
    return CanonicalSearchResult<TItem>(
      query: query,
      total: 0,
      items: const [],
      status: errors.isEmpty
          ? CanonicalSearchResultStatus.success
          : CanonicalSearchResultStatus.invalidQuery,
    );
  }
}

class GeneratedCanonicalExerciseSearchRepository
    implements CanonicalExerciseSearchRepository<CanonicalResolvedExercise> {
  const GeneratedCanonicalExerciseSearchRepository({
    this.validator = const CanonicalValidator(),
  });

  final CanonicalValidator validator;

  static final Map<String, CanonicalExerciseDefinition> _definitionsById = {
    for (final definition in generatedCanonicalWave1Exercises)
      definition.id: definition,
  };

  static final Map<String, CanonicalExerciseBeginnerContent> _contentById = {
    for (final content in generatedCanonicalWave1BeginnerContent)
      content.exerciseId: content,
  };

  static final Map<
    CanonicalExercisePathKey,
    List<CanonicalExercisePathCompatibility>
  >
  _linksByPath = _buildLinksByPath();

  @override
  Future<CanonicalSearchResult<CanonicalResolvedExercise>> search(
    CanonicalSearchQuery query,
  ) async {
    final errors = validator.queryErrors(query);
    if (query.criteria.length != 4 || errors.isNotEmpty) {
      return CanonicalSearchResult<CanonicalResolvedExercise>(
        query: query,
        total: 0,
        items: const [],
        status: CanonicalSearchResultStatus.invalidQuery,
      );
    }

    final links =
        _linksByPath[CanonicalExercisePathKey.fromQuery(query)] ?? const [];
    final seenIds = <String>{};
    final items = <CanonicalResolvedExercise>[];
    for (final link in links) {
      if (!seenIds.add(link.exerciseId)) continue;
      final definition = _definitionsById[link.exerciseId];
      final content = _contentById[link.exerciseId];
      if (definition == null || content == null) {
        throw StateError(
          'Generated Wave1 exercise join is incomplete for ${link.exerciseId}.',
        );
      }
      items.add(
        CanonicalResolvedExercise(
          definition: definition,
          content: content,
          compatibility: link,
        ),
      );
    }
    return CanonicalSearchResult<CanonicalResolvedExercise>(
      query: query,
      total: items.length,
      items: List.unmodifiable(items),
      status: CanonicalSearchResultStatus.success,
    );
  }

  static Map<CanonicalExercisePathKey, List<CanonicalExercisePathCompatibility>>
  _buildLinksByPath() {
    final result =
        <CanonicalExercisePathKey, List<CanonicalExercisePathCompatibility>>{};
    for (final link in generatedCanonicalWave1PathLinks) {
      result.putIfAbsent(link.pathKey, () => []).add(link);
    }
    return Map<
      CanonicalExercisePathKey,
      List<CanonicalExercisePathCompatibility>
    >.unmodifiable({
      for (final entry in result.entries)
        entry.key: List<CanonicalExercisePathCompatibility>.unmodifiable(
          entry.value,
        ),
    });
  }
}
