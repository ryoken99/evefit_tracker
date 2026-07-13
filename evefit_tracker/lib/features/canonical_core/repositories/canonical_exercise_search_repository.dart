import '../models/canonical_core_models.dart';
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
