import '../models/exercise_taxonomy.dart';

class CanonicalExerciseIdentity {
  const CanonicalExerciseIdentity({
    required this.canonicalId,
    required this.aliases,
    required this.primaryType,
    this.secondaryTypes = const {},
  });

  final String canonicalId;
  final Set<String> aliases;
  final String primaryType;
  final Set<String> secondaryTypes;
}

class CanonicalExerciseIdentityService {
  const CanonicalExerciseIdentityService._();

  static CanonicalExerciseIdentity forCatalogEntry({
    required String name,
    required String group,
    required String exerciseKey,
    required String contextKey,
  }) {
    final override = _overrideFor(exerciseKey);
    final canonicalId = override?.canonicalId ?? exerciseKey;
    final primaryType = override?.primaryType ?? _primaryTypeFor(contextKey);
    final aliases = <String>{
      canonicalId,
      exerciseKey,
      if (contextKey.isNotEmpty) '${exerciseKey}__$contextKey',
      ...?override?.aliases,
    };
    final secondaryTypes = <String>{...?override?.secondaryTypes}
      ..remove(primaryType);

    return CanonicalExerciseIdentity(
      canonicalId: canonicalId,
      aliases: aliases,
      primaryType: primaryType,
      secondaryTypes: secondaryTypes,
    );
  }

  static String serializeKeys(Iterable<String> keys) =>
      ExerciseTaxonomy.serializeKeys(keys);

  static String _primaryTypeFor(String contextKey) {
    if (contextKey == 'cardio') return 'cardio';
    if ({
      'karate',
      'jiu_jitsu',
      'boxe',
      'kickboxing',
      'muay_thai',
      'judo',
      'taekwondo',
      'defesa_pessoal',
      'artes_marciais',
    }.contains(contextKey)) {
      return 'artes_marciais';
    }
    if (contextKey == 'mobilidade') return 'mobilidade';
    if (contextKey == 'elasticidade') return 'elasticidade';
    if (contextKey == 'recuperacao') return 'recuperacao';
    if (contextKey == 'aquecimento') return 'aquecimento';
    if (contextKey == 'ativacao') return 'ativacao';
    if (contextKey == 'prevencao') return 'prevencao';
    return 'musculacao';
  }

  static CanonicalExerciseIdentity? _overrideFor(String exerciseKey) {
    if (exerciseKey.contains('technical_stand_up')) {
      return const CanonicalExerciseIdentity(
        canonicalId: 'technical_stand_up_lento',
        aliases: {'technical_stand_up', 'levantamento_tecnico'},
        primaryType: 'artes_marciais',
        secondaryTypes: {'mobilidade', 'defesa_pessoal'},
      );
    }
    return _overrides[exerciseKey];
  }

  static const Map<String, CanonicalExerciseIdentity> _overrides = {
    'flexao_classica': CanonicalExerciseIdentity(
      canonicalId: 'push_up',
      aliases: {'pushup', 'flexao_classica', 'flexao_bracos'},
      primaryType: 'musculacao',
    ),
    'ponte_de_gluteo': CanonicalExerciseIdentity(
      canonicalId: 'glute_bridge',
      aliases: {'ponte_gluteo', 'ponte_de_gluteo'},
      primaryType: 'musculacao',
    ),
    'technical_stand_up': CanonicalExerciseIdentity(
      canonicalId: 'technical_stand_up_lento',
      aliases: {'technical_stand_up', 'levantamento_tecnico'},
      primaryType: 'artes_marciais',
      secondaryTypes: {'mobilidade', 'defesa_pessoal'},
    ),
  };
}
