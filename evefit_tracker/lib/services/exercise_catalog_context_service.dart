import '../database/seed_data.dart';
import '../models/exercise.dart';
import 'canonical_exercise_identity_service.dart';
import 'exercise_catalog_detail_service.dart';
import 'v100_catalog_domain_data.dart';

class ExerciseCatalogEntry {
  const ExerciseCatalogEntry({
    required this.id,
    required this.name,
    required this.group,
    required this.exerciseKey,
    required this.contextKey,
    required this.catalogEntryKey,
    required this.details,
    required this.beginnerUnderstands,
    required this.dependsOnlyOnGenericFallback,
  });

  final String id;
  final String name;
  final String group;
  final String exerciseKey;
  final String contextKey;
  final String catalogEntryKey;
  final ExerciseCatalogDetails details;
  final bool beginnerUnderstands;
  final bool dependsOnlyOnGenericFallback;

  Exercise toExercise({int? id}) {
    final identity = CanonicalExerciseIdentityService.forCatalogEntry(
      name: name,
      group: group,
      exerciseKey: exerciseKey,
      contextKey: contextKey,
    );
    return Exercise(
      id: id,
      name: name,
      muscleGroup: group,
      isDefault: true,
      secondaryMuscleGroups: details.secondaryGroups,
      equipment: details.equipment,
      description: details.description,
      executionSteps: details.executionSteps,
      commonMistakes: details.commonMistakes,
      safetyNotes: details.safetyNotes,
      regression: details.regression,
      progression: details.progression,
      breathingTips: details.breathingTips,
      postureTips: details.postureTips,
      adaptationNotes: details.adaptationNotes,
      canonicalId: identity.canonicalId,
      aliases: identity.aliases,
      primaryType: identity.primaryType,
      secondaryTypes: identity.secondaryTypes,
      exerciseKey: exerciseKey,
      contextKey: contextKey,
      catalogEntryKey: catalogEntryKey,
    );
  }
}

class ExerciseCatalogContextService {
  const ExerciseCatalogContextService._();

  static final List<ExerciseCatalogEntry> entries = _buildEntries();

  static Map<String, List<String>> get duplicateContextsByName {
    final contexts = <String, List<String>>{};
    for (final entry in entries) {
      contexts.putIfAbsent(entry.name, () => []).add(entry.group);
    }
    contexts.removeWhere((_, value) => value.length < 2);
    return contexts;
  }

  static List<ExerciseCatalogEntry> get genericFallbackOnlyEntries =>
      entries.where((entry) => entry.dependsOnlyOnGenericFallback).toList();

  static ExerciseCatalogEntry entryFor({
    required String name,
    required String group,
  }) {
    return entries.firstWhere(
      (entry) => entry.name == name && entry.group == group,
      orElse: () => throw StateError('Catalog entry not found: $name / $group'),
    );
  }

  static ExerciseCatalogEntry? entryForExercise(Exercise exercise) {
    if (exercise.catalogEntryKey.isNotEmpty) {
      for (final entry in entries) {
        if (entry.catalogEntryKey == exercise.catalogEntryKey) return entry;
      }
    }
    return null;
  }

  static List<ExerciseCatalogEntry> entriesForName(String name) =>
      entries.where((entry) => entry.name == name).toList();

  static List<ExerciseCatalogEntry> _buildEntries() {
    final result = <ExerciseCatalogEntry>[];
    var index = 1;
    for (final groupEntry in SeedData.exercisesByGroup.entries) {
      final group = groupEntry.key;
      for (final name in groupEntry.value) {
        final exerciseKey = stableKey(name);
        final contextKey = stableKey(group);
        final baseDetails = ExerciseCatalogDetailService.forExercise(
          name: name,
          group: group,
        );
        final details = _entrySpecificDetails(
          name: name,
          group: group,
          base: baseDetails,
        );
        result.add(
          ExerciseCatalogEntry(
            id: 'E${index.toString().padLeft(3, '0')}',
            name: name,
            group: group,
            exerciseKey: exerciseKey,
            contextKey: contextKey,
            catalogEntryKey: '${exerciseKey}__$contextKey',
            details: details,
            beginnerUnderstands: _beginnerUnderstands(details),
            dependsOnlyOnGenericFallback: false,
          ),
        );
        index++;
      }
    }
    for (final data in v100CatalogDomainEntries) {
      final exerciseKey = stableKey(data.name);
      final contextKey = data.contextKey;
      final alreadyHasNameContext = result.any(
        (entry) =>
            entry.exerciseKey == exerciseKey && entry.contextKey == contextKey,
      );
      if (alreadyHasNameContext) continue;
      final catalogEntryKey = _uniqueCatalogEntryKey(
        base: '${exerciseKey}__$contextKey',
        conceptId: data.conceptId,
        existing: result.map((entry) => entry.catalogEntryKey).toSet(),
      );
      final details = _derivedDomainDetails(data);
      result.add(
        ExerciseCatalogEntry(
          id: 'E${index.toString().padLeft(3, '0')}',
          name: data.name,
          group: _displayGroupForContext(contextKey),
          exerciseKey: exerciseKey,
          contextKey: contextKey,
          catalogEntryKey: catalogEntryKey,
          details: details,
          beginnerUnderstands: _beginnerUnderstands(details),
          dependsOnlyOnGenericFallback: false,
        ),
      );
      index++;
    }
    return List.unmodifiable(result);
  }

  static String _uniqueCatalogEntryKey({
    required String base,
    required String conceptId,
    required Set<String> existing,
  }) {
    if (!existing.contains(base)) return base;
    final candidate = '${base}__${stableKey(conceptId)}';
    if (!existing.contains(candidate)) return candidate;
    var index = 2;
    while (existing.contains('${candidate}_$index')) {
      index++;
    }
    return '${candidate}_$index';
  }

  static String _displayGroupForContext(String contextKey) =>
      switch (contextKey) {
        'boxe' => 'Boxe',
        'kickboxing' => 'Kickboxing',
        'muay_thai' => 'Muay Thai',
        'judo' => 'Judo',
        'taekwondo' => 'Taekwondo',
        'defesa_pessoal' => 'Defesa pessoal',
        'karate' => 'Karate',
        'jiu_jitsu' => 'Jiu-Jitsu',
        'mobilidade' => 'Mobilidade',
        'elasticidade' => 'Elasticidade',
        'recuperacao' => 'Recuperacao',
        'aquecimento' => 'Aquecimento',
        'ativacao' => 'Ativacao',
        'prevencao' => 'Prevencao',
        _ => 'Artes marciais',
      };

  static ExerciseCatalogDetails _derivedDomainDetails(
    V100CatalogDomainEntryData data,
  ) {
    final group = _displayGroupForContext(data.contextKey);
    final action = data.primaryType == 'recuperacao'
        ? 'reduzir fadiga e recuperar sem acrescentar esforco relevante'
        : data.primaryType == 'elasticidade'
        ? 'ganhar tolerancia progressiva numa posicao alongada'
        : data.primaryType == 'mobilidade'
        ? 'melhorar controlo ativo e amplitude confortavel'
        : data.primaryType == 'aquecimento'
        ? 'preparar o corpo para treinar sem cansar'
        : data.primaryType == 'ativacao'
        ? 'acordar o padrao alvo com baixa fadiga'
        : data.primaryType == 'prevencao'
        ? 'melhorar controlo e tolerancia sem prometer evitar lesoes'
        : 'praticar tecnica, base, distancia e controlo antes da velocidade';
    final equipment = _derivedEquipmentLabel(data);
    final section = _safeLoadLanguage(data.section, equipment);
    final signature = _signatureFor(data, equipment);
    final description =
        'Entrada para $action. Trabalha $section '
        'com referencia tecnica $signature, intensidade conservadora e nivel ajustado ao praticante.';
    final safety = _derivedSafetyText(data);
    final regressionName = _safeLoadLanguage(data.name, equipment);
    return ExerciseCatalogDetails(
      equipment: equipment,
      secondaryGroups: data.section.trim().isEmpty ? group : data.section,
      description: description.length <= 280
          ? description
          : '${description.substring(0, 277).trimRight()}...',
      executionSteps: _derivedDomainSteps(data),
      commonMistakes:
          'Acelerar antes de controlar $section.\n'
          'Procurar amplitude ou intensidade maxima cedo demais.\n'
          'Ignorar dor, tontura ou perda de postura.',
      safetyNotes: safety,
      regression:
          'Reduz amplitude, velocidade, duracao ou complexidade ate conseguires repetir $regressionName com controlo.',
      progression:
          'Aumenta apenas uma variavel de cada vez: duracao, amplitude, complexidade tecnica ou resistencia.',
      breathingTips:
          'Respira de forma continua; expira nos momentos de maior esforco e volta a um ritmo calmo se ficares ofegante.',
      postureTips:
          'Mantem apoios estaveis, olhar controlado e articulacoes alinhadas com a direcao do movimento.',
      adaptationNotes:
          'Evita ou adapta quando houver dor aguda, tontura, instabilidade ou quando o local/equipamento necessario nao estiver disponivel.',
    );
  }

  static String _derivedEquipmentLabel(V100CatalogDomainEntryData data) {
    final value = data.equipment.trim();
    if (value.isEmpty || _n(value) == 'sem equipamento') {
      return 'Peso corporal';
    }
    return value;
  }

  static String _derivedSafetyText(V100CatalogDomainEntryData data) {
    final equipment = _derivedEquipmentLabel(data);
    final source = data.safety.trim();
    final prefix = _safeLoadLanguage(
      source.isEmpty
          ? 'Mantem intensidade baixa a moderada e tecnica controlada.'
          : source,
      equipment,
    );
    return '$prefix Para, interrompe ou abranda se houver dor aguda, tontura, formigueiro, falta de ar anormal, instabilidade ou perda de controlo.';
  }

  static String _derivedDomainSteps(V100CatalogDomainEntryData data) {
    final group = _displayGroupForContext(data.contextKey).toLowerCase();
    final equipment = _derivedEquipmentLabel(data);
    final equipmentCue = _derivedEquipmentCue(equipment);
    final movementCue = _derivedMovementCue(data);
    final familyCue = _derivedFamilyCue(data);
    final dosingCue = data.contextKey == 'mobilidade'
        ? ' Usa 20 a 40 segundos, 3 a 6 ciclos ou 5 a 10 repeticoes por lado.'
        : '';
    final sectionCue = stableKey(data.section).replaceAll('_', ' ');
    final conceptCue = _signatureFor(data, equipment);
    final specificCue = [
      movementCue,
      familyCue,
    ].where((cue) => cue.trim().isNotEmpty).join(' ');
    return [
      '1. Escolhe um local seguro para $group e confirma que tens $equipment antes de comecar.',
      '2. Usa ${_stepCue(_safeLoadLanguage(sectionCue, equipment), 48)} com referencia ${_stepCue(_safeLoadLanguage(conceptCue, equipment), 86)}.',
      '3. Leva a zona trabalhada por uma trajetoria curta, controlavel e com respiracao continua.$dosingCue',
      '4. $equipmentCue',
      if (specificCue.isNotEmpty) '5. $specificCue',
      '${specificCue.isNotEmpty ? 6 : 5}. Regressa a posicao inicial com controlo e faz uma pausa curta se a tecnica piorar.',
      '${specificCue.isNotEmpty ? 7 : 6}. Termina a serie com boa postura e reduz volume se houver fadiga, dor aguda ou perda de equilibrio.',
    ].join('\n');
  }

  static String _derivedMovementCue(V100CatalogDomainEntryData data) {
    if (!_isMartialContext(data.contextKey)) return '';
    if (data.contextKey == 'jiu_jitsu') {
      return 'Mantem base, guarda, ombros e cotovelos organizados; o objetivo e controlo tecnico antes da velocidade.';
    }
    return 'Mantem base e guarda organizadas; o objetivo e controlo tecnico, distancia segura e respiracao continua.';
  }

  static String _derivedFamilyCue(V100CatalogDomainEntryData data) {
    final name = _n(data.name);
    if (_has(name, ['supino', 'press', 'flexao', 'dips'])) {
      return 'Organiza pes, ombros e cotovelos; empurra sem perder a respiracao.';
    }
    if (_has(name, ['triceps', 'tricep', 'extensao francesa'])) {
      return 'Mantem a pega simples, cotovelos estaveis e lombar neutra; estende e desce sem prender a respiracao.';
    }
    if (_has(name, ['curl']) &&
        !_has(name, ['wrist', 'finger', 'nordico', 'curl de perna'])) {
      return 'Controla a pega, cotovelos, punhos e tronco; sobe e desce sem prender a respiracao.';
    }
    if (_has(name, ['remo', 'puxada', 'pull-up', 'chin-up', 'face pull'])) {
      return 'Confirma a pega, estabiliza tronco e lombar, aproxima escapulas e puxa pelos cotovelos.';
    }
    if (_has(name, ['agachamento', 'lunges', 'leg press', 'step-up'])) {
      return 'Mantem pes firmes, joelhos alinhados, anca livre e tronco estavel enquanto desce.';
    }
    if (_has(name, ['peso morto', 'good morning'])) {
      return 'Dobra pela anca com coluna e lombar neutras, joelhos suaves e respiracao continua.';
    }
    return '';
  }

  static bool _isMartialContext(String contextKey) => const {
    'artes_marciais',
    'karate',
    'jiu_jitsu',
    'boxe',
    'kickboxing',
    'muay_thai',
    'judo',
    'taekwondo',
    'defesa_pessoal',
  }.contains(contextKey);

  static String _signatureFor(
    V100CatalogDomainEntryData data,
    String equipment,
  ) {
    final base = stableKey(
      '${data.section} ${data.conceptId}',
    ).replaceAll('_', ' ');
    final name = stableKey(data.name).replaceAll('_', ' ');
    final signature = base.contains(name) ? base : '$base $name';
    return _safeLoadLanguage(signature, equipment);
  }

  static String _safeLoadLanguage(String text, String equipment) {
    if (!_isBodyweightLike(equipment)) return text;
    return text
        .replaceAll(RegExp(r'\bcargas\b', caseSensitive: false), 'esforcos')
        .replaceAll(RegExp(r'\bcarga\b', caseSensitive: false), 'esforco')
        .replaceAll(
          RegExp(r'\bbarras?\b', caseSensitive: false),
          'treino anterior',
        )
        .replaceAll(
          RegExp(r'\bpassadeira\b', caseSensitive: false),
          'corrida anterior',
        )
        .replaceAll(RegExp(r'\bhalteres?\b', caseSensitive: false), 'apoio')
        .replaceAll(RegExp(r'\bcabos?\b', caseSensitive: false), 'apoio')
        .replaceAll(RegExp(r'\bpolias?\b', caseSensitive: false), 'apoio')
        .replaceAll(RegExp(r'\bmaquinas?\b', caseSensitive: false), 'apoio');
  }

  static String _shortCue(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    final words = text.split(RegExp(r'\s+'));
    final selected = <String>[];
    for (final word in words.reversed) {
      final candidate = [word, ...selected].join(' ');
      if (candidate.length > maxLength) break;
      selected.insert(0, word);
    }
    return selected.isEmpty
        ? text.substring(0, maxLength).trimRight()
        : selected.join(' ');
  }

  static String _stepCue(String text, int maxLength) {
    final cue = _shortCue(text, maxLength);
    return RegExp(r'\d$').hasMatch(cue) ? '$cue sequencia' : cue;
  }

  static bool _isBodyweightLike(String equipment) {
    final normalized = _n(equipment);
    const loaded = [
      'halter',
      'barra',
      'cabo',
      'polia',
      'maquina',
      'disco',
      'kettlebell',
      'mochila',
      'garrafao',
      'elastico',
    ];
    return !loaded.any(normalized.contains);
  }

  static String _derivedEquipmentCue(String equipment) {
    final normalized = _n(equipment);
    if (normalized == 'peso corporal') {
      return 'Mantem os apoios firmes, distribui o peso com controlo e respira sem prender o ar.';
    }
    final cues = <String>[];
    if (normalized.contains('halter')) {
      cues.add('segura o halter com pega firme e punhos alinhados');
    }
    if (normalized.contains('barra') && !normalized.contains('barra fixa')) {
      cues.add('coloca a barra numa posicao estavel e confirma a pega');
    }
    if (normalized.contains('cabo') || normalized.contains('polia')) {
      cues.add('ajusta a polia, confirma o cabo e segura a pega');
    }
    if (normalized.contains('maquina')) {
      cues.add('ajusta a maquina, o assento ou o encosto antes de repetir');
    }
    if (normalized.contains('passadeira')) {
      cues.add('usa a passadeira com velocidade e inclinacao conservadoras');
    }
    if (normalized.contains('bicicleta')) {
      cues.add(
        'ajusta o selim e pedala com resistencia e cadencia confortaveis',
      );
    }
    if (normalized.contains('corda')) {
      cues.add('segura as pegas da corda com punhos alinhados e salta baixo');
    }
    if (cues.isEmpty) {
      return 'Confirma o equipamento, segura-o com controlo quando existir e respira sem prender o ar.';
    }
    return '${cues.join('; ')}.';
  }

  static String stableKey(String value) {
    var text = value.toLowerCase();
    const replacements = {
      'á': 'a',
      'à': 'a',
      'ã': 'a',
      'â': 'a',
      'ä': 'a',
      'é': 'e',
      'ê': 'e',
      'è': 'e',
      'í': 'i',
      'ó': 'o',
      'õ': 'o',
      'ô': 'o',
      'ú': 'u',
      'ç': 'c',
      'Á': 'a',
      'Ã¡': 'a',
      'Ã£': 'a',
      'Ã¢': 'a',
      'Ã©': 'e',
      'Ãª': 'e',
      'Ã­': 'i',
      'Ã³': 'o',
      'Ãµ': 'o',
      'Ãº': 'u',
      'Ã§': 'c',
      'Ã‰': 'e',
      'Ã‡': 'c',
    };
    for (final entry in replacements.entries) {
      text = text.replaceAll(entry.key, entry.value);
    }
    return text
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
  }

  static ExerciseCatalogDetails _entrySpecificDetails({
    required String name,
    required String group,
    required ExerciseCatalogDetails base,
  }) {
    final equipment = _equipmentOverride(name, group, base.equipment);
    final secondary = _secondaryFor(name, group, base.secondaryGroups);
    final regression = _regressionFor(name, group, equipment);
    final progression = _progressionFor(name, group, equipment);
    return ExerciseCatalogDetails(
      equipment: equipment,
      secondaryGroups: secondary,
      description: _beginnerDescriptionFor(name, group),
      executionSteps: _canonicalSteps(_stepsFor(name, group, equipment), name),
      commonMistakes: _canonicalMistakes(_mistakesFor(name, group, equipment)),
      safetyNotes: _safetyFor(name, group, equipment),
      regression: regression,
      progression: progression,
      breathingTips: _breathingFor(name, group),
      postureTips: _postureFor(name, group),
      adaptationNotes: _adaptationFor(name, group),
    );
  }

  /// Passo extra, específico da variação, injetado a seguir ao primeiro passo
  /// quando a família de movimento partilha a base da execução.
  static String _beginnerDescriptionFor(String name, String group) {
    final base = _objectiveFor(name, group);
    if (base.length >= 130) return base;
    final text =
        '$base Ensina a organizar a posicao inicial, perceber a zona que deve trabalhar e ajustar amplitude, ritmo ou apoio para aprender sem dor.';
    return text.length <= 280
        ? text
        : '${text.substring(0, 277).trimRight()}...';
  }

  static const Map<String, String> _variationStepByName = {
    'extensao francesa no cabo':
        'Coloca a polia na posição baixa, fica de costas para o cabo e segura a corda com pega firme atrás da cabeça.',
    'agachamento com barra':
        'Apoia a barra na parte de cima das costas e segura-a com pega firme e simétrica.',
    'lunges com halteres':
        'Segura um halter em cada mão ao lado do corpo, com pega firme e punhos direitos.',
    'peso morto romeno com halteres':
        'Segura os halteres à frente das coxas com pega firme, palmas viradas para ti.',
    'chin tuck':
        'Recua o queixo devagar, como se quisesses criar um duplo queixo, sem inclinar a cabeça para baixo.',
    'rotacao cervical controlada':
        'Roda a cabeça devagar para um lado, como se olhasses por cima do ombro, e volta ao centro antes de trocar.',
    'extensao acima da cabeca com halter':
        'Segura um único halter na vertical, com as duas mãos sobrepostas por baixo da cabeça de cima.',
    'extensao francesa com halter':
        'Podes fazer o movimento sentado ou deitado; mantém os cotovelos apontados para a frente todo o tempo.',
    'mobilidade de anca para jiu-jitsu':
        'Encadeia círculos de anca, fugas de anca lentas e aberturas de guarda sentado no chão.',
    'mobilidade de ombro para jiu-jitsu':
        'Encadeia círculos de braços, mãos atrás das costas como nas pegas e rotações suaves dos ombros.',
    'drills de guarda':
        'Trabalha a retenção: enquadra com os pés, gere a distância e recupera a guarda quando a perderes.',
    'drills de passagem de guarda':
        'Trabalha a passagem: controla as pernas do adversário imaginário, pressiona e passa para o lado.',
    'forca de pega para jiu-jitsu':
        'Aperta uma toalha ou o teu próprio punho em pegas fortes de 5 a 10 segundos enquanto te moves no solo.',
    'core para jiu-jitsu':
        'Liga pontes, posições de hollow e rotações de tronco no chão, mantendo o queixo protegido.',
    'isometria cervical frontal leve':
        'Coloca a palma da mão na testa e empurra a cabeça contra ela, sem deixar a cabeça mexer.',
    'isometria cervical lateral leve':
        'Coloca a palma da mão ao lado da cabeça e empurra contra ela, sem deixar a cabeça inclinar.',
    'scapular pull-up':
        'Faz repetições curtas: puxa as escápulas para baixo, segura um segundo e deixa-as subir de novo.',
    'dead hang escapular':
        'Alterna cinco segundos pendurado com os ombros soltos e cinco segundos com as escápulas ativas.',
    'mobilidade de ombro com cabo de vassoura':
        'Segura o cabo de vassoura com as duas mãos, bem mais afastadas que os ombros, como guia leve.',
    'farmer hold':
        'Usa halteres pesados que só consigas segurar 10 a 30 segundos com boa postura.',
    'reverse fly':
        'Se tiveres banco inclinado, apoia lá o peito para eliminar o balanço do tronco.',
    'elevacao posterior':
        'Inclina o tronco à frente com a lombar neutra e deixa os braços pendurados.',
    'rotacao externa com elastico':
        'Prende o elástico à altura do cotovelo e fica de lado para o ponto de fixação.',
    'rotacao interna com elastico':
        'Prende o elástico à altura do cotovelo e fica com esse lado virado para o ponto de fixação.',
    'flexao arqueiro':
        'Desloca o peso do corpo para um dos lados; o braço contrário fica quase esticado a ajudar.',
    'supino inclinado com barra':
        'Ajusta o banco a 30 a 45 graus de inclinação antes de te deitares.',
    'squeeze press':
        'Mantém os halteres encostados um ao outro e aperta-os durante toda a repetição.',
    'supino declinado na maquina':
        'Ajusta o assento para as pegas ficarem alinhadas com a parte baixa do peito.',
    'chest press':
        'Ajusta o assento para as pegas ficarem à frente do meio do peito.',
    'puxada alta':
        'Agarra a barra com pega um pouco mais larga que os ombros e palmas para a frente.',
    'puxada alta pega aberta':
        'Agarra a barra com as mãos bem mais afastadas que os ombros, para pedir mais à largura das costas.',
    'puxada alta pega neutra':
        'Usa a pega em que as palmas ficam viradas uma para a outra, com os cotovelos a descer junto ao tronco.',
    'puxada alta pega fechada':
        'Agarra a pega curta com as mãos próximas, para os cotovelos trabalharem colados ao corpo.',
    'good morning com barra':
        'Apoia a barra na parte alta das costas, nunca no pescoço, com pega firme.',
    'good morning leve':
        'Usa a barra vazia ou muito leve, apoiada na parte alta das costas, nunca no pescoço.',
    'curl alternado':
        'Sobe um braço de cada vez e alterna os lados, mantendo o outro halter em baixo.',
    'triceps testa com barra ez':
        'Agarra a barra EZ com pega na zona ondulada, com as palmas ligeiramente viradas uma para a outra.',
    'triceps testa com halteres':
        'Usa pega neutra, com as palmas dos halteres viradas uma para a outra, e desce à linha da testa.',
    'extensao de triceps deitado com halteres':
        'Desce os halteres para trás da cabeça, e não para a testa, para alongar mais o tríceps.',
    'press fechado com halteres':
        'Mantém os halteres juntos, em pega neutra, encostados um ao outro durante toda a repetição.',
    'kickback no cabo':
        'Coloca a polia na posição baixa e fica de costas ligeiramente inclinado para o cabo.',
    'kickback de triceps':
        'Apoia a mão livre num banco ou na coxa e segura o halter com pega neutra.',
    'hold estatico com halteres':
        'Escolhe halteres moderados: o objetivo é aguentar 30 a 45 segundos, mais tempo que num farmer hold pesado.',
    'walking lunges':
        'Em vez de voltares atrás, traz a perna de trás para a frente e avança para o passo seguinte.',
    'prancha lateral':
        'Vira o corpo de lado, apoia o antebraço por baixo do ombro e empilha os pés ou cruza-os.',
    'passadeira caminhada':
        'Escolhe uma velocidade em que consegues conversar em frases completas.',
    'passadeira caminhada rapida':
        'Sobe a velocidade até um passo vivo em que só consegues dizer frases curtas.',
    'passadeira corrida leve':
        'Passa para um trote suave e contínuo, sem encurtar a respiração.',
    'passadeira sprints':
        'Faz tiros de 10 a 20 segundos quase no máximo e recupera por completo entre cada um.',
    'passadeira sprints intervalados':
        'Programa blocos: 15 a 30 segundos fortes seguidos de 60 a 90 segundos a caminhar.',
    'hiit passadeira':
        'Alterna 20 a 40 segundos rápidos com 40 a 80 segundos de caminhada de recuperação.',
    'passadeira inclinacao':
        'Usa inclinação leve, de 3 a 6 por cento, mantendo a velocidade de caminhada.',
    'passadeira inclinacao moderada':
        'Sobe a inclinação para 6 a 10 por cento e reduz ligeiramente a velocidade.',
    'bicicleta ritmo leve':
        'Mantém resistência baixa e cadência confortável, a conseguir conversar.',
    'bicicleta ritmo moderado':
        'Usa resistência média, com as pernas a aquecer mas sem perder o ritmo da respiração.',
    'bicicleta resistencia':
        'Sobe a resistência até a pedalada ficar pesada e desce a cadência, sem balançar a anca.',
    'hiit bicicleta':
        'Alterna 20 a 40 segundos de pedalada forte com 60 a 90 segundos muito leves.',
    'eliptica ritmo leve':
        'Mantém resistência baixa e movimento fluido, sem pressa.',
    'eliptica ritmo moderado':
        'Usa resistência média e um ritmo constante que aqueça pernas e braços.',
    'eliptica intervalos':
        'Alterna 30 a 60 segundos rápidos com 60 a 90 segundos lentos, sem parar o movimento.',
    'eliptica resistencia':
        'Sobe a resistência e baixa a cadência, empurrando e puxando com força controlada.',
    'eliptica aquecimento':
        'Começa muito leve e aumenta o ritmo aos poucos durante 5 a 10 minutos.',
    'eliptica cooldown':
        'Reduz a resistência e o ritmo gradualmente durante 3 a 8 minutos.',
    'corda de saltar ritmo leve':
        'Mantém saltos baixos e contínuos, a um ritmo calmo que consigas sustentar.',
    'corda de saltar intervalos':
        'Alterna 20 a 40 segundos a saltar com 20 a 40 segundos de pausa a caminhar.',
    'hiit corda':
        'Faz blocos quase máximos de 20 a 30 segundos com pausas curtas de recuperação.',
    'alongamento peitoral na parede':
        'Apoia o antebraço na parede com o cotovelo à altura do ombro e roda o tronco para o lado contrário.',
    'alongamento peitoral no canto':
        'Coloca um antebraço em cada parede do canto e deixa o peito avançar devagar.',
    'alongamento posterior sentado':
        'Senta-te com as pernas estendidas e inclina o tronco pela anca em direção aos pés.',
    'alongamento posterior em pe':
        'De pé, dobra pela anca com os joelhos quase esticados e deixa as mãos descer pelas pernas.',
    'alongamento posterior com perna elevada':
        'Coloca o calcanhar num apoio à altura da anca ou abaixo e inclina o tronco pela anca.',
    'tocar nos pes sentado':
        'Sentado com as pernas esticadas, desliza as mãos pelas pernas em direção aos pés.',
    'tocar nos pes em pe':
        'De pé, deixa o tronco descer devagar em direção aos pés, dobrando pela anca.',
    'mobilidade dinamica de posterior':
        'Alterna entre alongar e voltar, em movimentos lentos e contínuos, sem manter a posição.',
    'alongamento figura 4':
        'Deitado de costas, cruza um tornozelo sobre o joelho contrário e puxa essa coxa ao peito.',
    'pigeon stretch':
        'Leva uma perna dobrada à frente no chão e estica a outra para trás, com a anca nivelada.',
    'alongamento de gluteo sentado':
        'Sentado numa cadeira, cruza o tornozelo sobre o joelho contrário e inclina o tronco à frente.',
    'alongamento piriforme':
        'Deitado de costas, cruza uma perna sobre a outra e puxa a coxa de baixo ao peito.',
    'mobilidade 90/90':
        'Senta-te com uma perna dobrada à frente e outra dobrada para trás, ambas perto de 90 graus.',
    'alongamento gluteos':
        'Deitado de costas, puxa um joelho na direção do ombro contrário até sentir o glúteo.',
    'alongamento quadriceps em pe':
        'De pé com apoio de uma mão, leva o calcanhar ao glúteo e segura o pé.',
    'alongamento quadriceps de lado':
        'Deitado de lado, segura o pé de cima atrás do corpo e empurra a anca à frente.',
    'alongamento gemeos':
        'Dá um passo atrás, mantém essa perna esticada com o calcanhar no chão e avança o corpo.',
    'alongamento gemeos na parede':
        'Apoia a ponta do pé na parede com o calcanhar no chão e aproxima o corpo da parede.',
    'extensao de punhos no chao':
        'Apoia as palmas no chão com os dedos virados para a frente e inclina o peso devagar.',
    'flexao de punhos no chao':
        'Apoia as costas das mãos no chão com os dedos virados para ti e inclina o peso devagar.',
    'mobilidade de punhos':
        'Faz círculos lentos, flexão e extensão dos punhos, alternando as direções.',
    'mobilidade de ombro com toalha':
        'Segura uma toalha esticada entre as mãos, bem mais largas que os ombros, como guia.',
    'circulos de ombro':
        'Desenha círculos lentos e amplos com os ombros, primeiro para trás e depois para a frente.',
    'mobilidade leve de ombros':
        'Usa amplitudes pequenas e confortáveis, sem procurar o limite do alcance.',
    'mobilidade dinamica de anca':
        'Encadeia movimentos lentos de anca, trocando de posição sem manter alongamentos parados.',
    'mobilidade leve de anca':
        'Usa amplitudes pequenas e confortáveis da anca, sem forçar o alcance.',
    'rotacao externa da anca no chao':
        'Sentado ou deitado, deixa o joelho abrir para o lado com a planta do pé apoiada.',
    'mobilidade de anca':
        'Explora círculos e báscula da bacia em amplitudes confortáveis, de pé ou em quatro apoios.',
    'mobilidade toracica':
        'Sentado ou em quatro apoios, roda a parte alta das costas de um lado para o outro devagar.',
    'alongamento dorsal':
        'Agarra um apoio à frente, deixa a anca recuar e o tronco descer entre os braços.',
    'alongamento peitoral':
        'Abre o braço para o lado à altura do ombro e roda o tronco para o lado contrário.',
    'caminhada exterior leve':
        'Escolhe um percurso plano e caminha a um ritmo em que consegues conversar.',
    'caminhada exterior moderada':
        'Acelera para um passo firme e decidido, com os braços a acompanhar.',
    'caminhada exterior rapida':
        'Caminha quase no limite da marcha, sem transformar o passo em corrida.',
    'caminhada exterior em subida':
        'Procura uma subida constante e usa passos mais curtos, inclinando pouco o tronco.',
    'corrida exterior leve':
        'Corre a um ritmo conversável, com passada curta e relaxada.',
    'corrida exterior moderada':
        'Sobe o ritmo até só conseguires frases curtas, mantendo a passada estável.',
    'corrida exterior intervalada':
        'Alterna 1 a 3 minutos rápidos com trote ou caminhada até recuperares.',
    'sprints exterior':
        'Faz tiros de 10 a 20 segundos quase no máximo, com recuperação completa entre eles.',
    'corrida em subida':
        'Escolhe uma subida curta, sobe a correr com passos curtos e desce a caminhar.',
    'hiit peso corporal':
        'Monta um circuito de 3 a 5 exercícios simples e trabalha 20 a 40 segundos em cada um.',
    'hiit cardio':
        'Alterna blocos fortes de 20 a 40 segundos com recuperações ativas de 40 a 80 segundos.',
    'hiit simples':
        'Escolhe um só movimento fácil de controlar e alterna esforço e pausa em blocos iguais.',
    'circuito cardio peso corporal':
        'Encadeia 4 a 6 exercícios sem equipamento, 30 a 45 segundos em cada, com pausas curtas.',
    'circuito cardio leve':
        'Encadeia movimentos suaves a baixa intensidade, sem saltos, durante 10 a 20 minutos.',
  };

  // Chaves normalizadas (os mapas usam nomes legíveis com hífenes/acentos).
  static final Map<String, _NamedSummary> _summaryByNameNormalized = {
    for (final entry in _summaryByName.entries) _n(entry.key): entry.value,
  };

  static final Map<String, String> _variationStepsNormalized = {
    for (final entry in _variationStepByName.entries)
      _n(entry.key): entry.value,
  };

  /// Objetivo curto (1-2 frases, máximo 280 caracteres), específico ao
  /// exercício. O resumo anatómico (grupo, músculos, equipamento) é mostrado
  /// à parte no modal, por isso não é repetido aqui.
  static String _objectiveFor(String name, String group) {
    final movement = _movementSummary(name, group).trim();
    final target = _primaryTarget(name, group).trim();
    var text = _capitalize(movement);
    if (!text.endsWith('.')) text = '$text.';
    final normalizedText = _n(text);
    final firstTargetWord = _n(target).split(' ').first;
    final repeatsTarget =
        firstTargetWord.length >= 4 && normalizedText.contains(firstTargetWord);
    final hasPurposeCue = _has(normalizedText, [
      'serve',
      'treinar',
      'trabalha',
      'fortalec',
      'foca',
      'isola',
      'melhorar',
      'para ',
    ]);
    if (!repeatsTarget) {
      text = '$text Serve para treinar $target.';
    } else if (!hasPurposeCue) {
      text = '$text Serve para o treinar com controlo.';
    }
    if (_isDuplicateName(name)) {
      final contextClause =
          ' Nesta lista, conta para o treino de '
          '${group == 'Antebraço/Pega' ? 'antebraço e pega' : group.toLowerCase()}.';
      if (text.length + contextClause.length <= 280) {
        text = '$text$contextClause';
      }
    }
    if (text.length > 280) {
      final firstSentenceEnd = text.indexOf('. ');
      if (firstSentenceEnd > 0) text = text.substring(0, firstSentenceEnd + 1);
    }
    return text;
  }

  static bool _isDuplicateName(String name) =>
      _duplicateNames.contains(name.toLowerCase());

  static final Set<String> _duplicateNames = () {
    final counts = <String, int>{};
    for (final groupEntry in SeedData.exercisesByGroup.entries) {
      for (final name in groupEntry.value) {
        counts[name.toLowerCase()] = (counts[name.toLowerCase()] ?? 0) + 1;
      }
    }
    return counts.entries
        .where((item) => item.value > 1)
        .map((item) => item.key)
        .toSet();
  }();

  static String _capitalize(String value) =>
      value.isEmpty ? value : value[0].toUpperCase() + value.substring(1);

  static String _lowercaseFirst(String value) =>
      value.isEmpty ? value : value[0].toLowerCase() + value.substring(1);

  /// Converte a execução gerada num bloco de 4 a 7 passos numerados, um por
  /// linha, com no máximo 180 caracteres por passo. Passos puramente de
  /// respiração saem da lista (a respiração tem secção própria no modal).
  static String _canonicalSteps(String raw, String name) {
    var steps = raw
        .split(RegExp(r'\s*(?=\d{1,2}\.\s)'))
        .map((line) => line.replaceFirst(RegExp(r'^\d{1,2}\.\s*'), '').trim())
        .where((line) => line.isNotEmpty)
        .toList();
    final variation = _variationStepsNormalized[_n(name)];
    if (variation != null &&
        steps.length > 1 &&
        !_n(steps.join(' ')).contains(_n(variation).substring(0, 24))) {
      steps.insert(1, variation);
    }
    steps = steps.where((step) {
      final normalized = _n(step);
      final isPureBreathing =
          RegExp(r'^(inspira|expira|respira)').hasMatch(normalized) &&
          step.length < 80 &&
          !RegExp(r'\d').hasMatch(step);
      return !isPureBreathing;
    }).toList();
    while (steps.length > 7) {
      var bestIndex = -1;
      var bestLength = 1 << 30;
      for (var i = 0; i < steps.length - 1; i++) {
        final combined = steps[i].length + steps[i + 1].length + 2;
        if (combined < bestLength) {
          bestLength = combined;
          bestIndex = i;
        }
      }
      if (bestIndex < 0 || bestLength > 178) break;
      final merged =
          '${steps[bestIndex].replaceFirst(RegExp(r'\.$'), '')}; '
          '${_lowercaseFirst(steps[bestIndex + 1])}';
      steps
        ..removeAt(bestIndex + 1)
        ..[bestIndex] = merged;
    }
    return [
      for (var i = 0; i < steps.length; i++) '${i + 1}. ${steps[i]}',
    ].join('\n');
  }

  /// Converte os erros comuns num bloco de 3 a 5 itens, um por linha.
  static String _canonicalMistakes(List<String> mistakes) {
    final items = mistakes
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .take(5)
        .map((item) {
          var text = _capitalize(item);
          if (!text.endsWith('.')) text = '$text.';
          return text;
        })
        .toList();
    return items.join('\n');
  }

  static String _regressionFor(String name, String group, String equipment) {
    final n = _n(name);
    if (_has(n, ['isometria cervical posterior'])) {
      return 'Usa apenas dois dedos de cada mão e sustenta a pressão por 3 a 5 segundos.';
    }
    if (_has(n, ['plano da omoplata'])) {
      return 'Faz o movimento sem halteres, só a desenhar a diagonal, até a subida sair sem encolher os ombros.';
    }
    if (_has(n, ['lenhador'])) {
      return 'Baixa a carga e encurta a diagonal, rodando só até onde a lombar fica neutra.';
    }
    if (_has(n, ['toque no ombro'])) {
      return 'Afasta mais os pés ou faz a prancha com as mãos num apoio elevado antes de tocar no ombro.';
    }
    if (_has(n, ['clamshell'])) {
      return 'Abre menos o joelho e faz menos repetições, mantendo a bacia encostada à mão de controlo.';
    }
    if (_has(n, ['curl nordico'])) {
      return 'Trava só nos primeiros graus da descida e usa as mãos cedo, ou substitui por curl de perna leve.';
    }
    if (_has(n, ['peso morto unilateral'])) {
      return 'Apoia a ponta do pé livre no chão atrás de ti, em vez de a elevar, e usa um halter mais leve.';
    }
    if (_has(n, ['pnf de isquiotibiais'])) {
      return 'Salta a fase de contração e faz apenas o alongamento suave com a toalha.';
    }
    if (_has(n, ['pnf de peitoral'])) {
      return 'Salta a fase de contração e mantém só o alongamento parado na parede.';
    }
    if (_has(n, ['respiracao nasal'])) {
      return 'Encurta para inspirar 3 segundos e expirar 4, ou respira normalmente entre ciclos.';
    }
    if (_has(n, ['foam roller'])) {
      return 'Apoia mais peso nos braços para reduzir a pressão do rolo e rola zonas maiores sem parar em pontos.';
    }
    if (_has(n, ['bola de massagem'])) {
      return 'Usa a bola contra a parede em vez de no chão, para controlares melhor a pressão.';
    }
    if (_has(n, ['flexao diamante'])) {
      return 'Faz com os joelhos no chão ou com as mãos apoiadas numa superfície elevada.';
    }
    if (_has(n, ['curl arrastado'])) {
      return 'Usa halteres mais leves ou faz curls normais até dominares o recuo dos cotovelos.';
    }
    if (_has(n, ['tate press'])) {
      return 'Usa halteres muito leves ou treina primeiro a extensão francesa com um só halter.';
    }
    if (_has(n, ['press militar com barra em pe'])) {
      return 'Pratica o press vertical sentado com encosto e barra leve antes de estabilizar o peso em pé.';
    }
    if (_has(n, ['y raise'])) {
      return 'Desenha o Y deitado num banco inclinado, sem peso, parando antes de encolher o pescoço.';
    }
    if (_has(n, ['w raise'])) {
      return 'Mantém a forma de W sem peso e faz apenas a retração curta das escápulas.';
    }
    if (_has(n, ['curl 21'])) {
      return 'Substitui a sequência 21 por curls completos com halteres leves e descanso normal entre séries.';
    }
    if (group == 'Cardio') {
      return 'Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.';
    }
    if (group == 'Mobilidade') {
      return 'Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.';
    }
    if (_has(n, ['pull-up', 'chin-up', 'dips'])) {
      return 'Faz com apoio dos pés, elástico ou máquina assistida, mantendo a mesma trajetória articular.';
    }
    if (_has(n, ['flexao', 'flexão'])) {
      return 'Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.';
    }
    if (_has(n, ['agachamento', 'lunges', 'step-up'])) {
      return 'Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.';
    }
    if (_has(n, ['prancha', 'hollow', 'pallof'])) {
      return 'Encurta a alavanca ou a duração e usa menos resistência sem perder a posição das costelas e da bacia.';
    }
    if (_isBodyweightEquipment(equipment)) {
      return 'Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.';
    }
    return 'Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.';
  }

  static String _progressionFor(String name, String group, String equipment) {
    final n = _n(name);
    if (_has(n, ['isometria cervical posterior'])) {
      return 'Aumenta a duração de cada pressão até 10 segundos antes de aumentares a força.';
    }
    if (_has(n, ['plano da omoplata'])) {
      return 'Sobe ligeiramente os halteres ou acrescenta uma pausa de dois segundos no topo.';
    }
    if (_has(n, ['lenhador'])) {
      return 'Aumenta a carga aos poucos ou faz a diagonal de baixo para cima, que exige mais controlo.';
    }
    if (_has(n, ['toque no ombro'])) {
      return 'Aproxima os pés um do outro ou faz uma pausa de dois segundos com a mão no ombro.';
    }
    if (_has(n, ['clamshell'])) {
      return 'Coloca um elástico à volta dos joelhos ou faz uma pausa de dois segundos com o joelho aberto.';
    }
    if (_has(n, ['curl nordico'])) {
      return 'Desce cada vez mais baixo antes de amparar com as mãos e reduz a ajuda do empurrão na subida.';
    }
    if (_has(n, ['peso morto unilateral'])) {
      return 'Aumenta o halter aos poucos ou desce em três segundos mantendo a bacia nivelada.';
    }
    if (_has(n, ['pnf de isquiotibiais'])) {
      return 'Acrescenta um ciclo contrai-relaxa ou mantém a nova amplitude ativamente sem as mãos por 5 segundos.';
    }
    if (_has(n, ['pnf de peitoral'])) {
      return 'Acrescenta um ciclo contrai-relaxa ou afasta ligeiramente mais o pé da parede.';
    }
    if (_has(n, ['respiracao nasal'])) {
      return 'Alonga a expiração até 10 segundos ou acrescenta uma pausa confortável de 2 a 4 segundos após expirar.';
    }
    if (_has(n, ['foam roller'])) {
      return 'Rola mais devagar, pára mais tempo nos pontos tensos ou apoia menos peso nos braços.';
    }
    if (_has(n, ['bola de massagem'])) {
      return 'Passa da parede para o chão ou fica mais tempo em cada ponto tenso, sempre sem dor forte.';
    }
    if (_has(n, ['flexao diamante'])) {
      return 'Desce mais devagar, faz uma pausa curta em baixo ou eleva os pés num apoio estável.';
    }
    if (_has(n, ['curl arrastado'])) {
      return 'Sobe ligeiramente os halteres ou faz a descida em três a quatro segundos.';
    }
    if (_has(n, ['tate press'])) {
      return 'Sobe ligeiramente os halteres ou acrescenta uma pausa de um segundo perto do peito.';
    }
    if (_has(n, ['press militar com barra em pe'])) {
      return 'Aumenta gradualmente a barra mantendo glúteos, costelas e trajetória vertical estáveis em pé.';
    }
    if (_has(n, ['y raise'])) {
      return 'Acrescenta halteres leves ao desenho em Y e pausa com os polegares apontados para cima.';
    }
    if (_has(n, ['w raise'])) {
      return 'Acrescenta um elástico leve ao W sem perder a retração e a rotação externa das escápulas.';
    }
    if (_has(n, ['curl 21'])) {
      return 'Aumenta ligeiramente os halteres mantendo sete parciais inferiores, sete superiores e sete completas limpas.';
    }
    if (group == 'Cardio') {
      if (_has(n, ['passadeira'])) {
        return 'Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.';
      }
      if (_has(n, ['bicicleta', 'eliptica', 'elíptica'])) {
        return 'Aumenta apenas a duração, a resistência ou a cadência de cada vez.';
      }
      if (_has(n, ['corda'])) {
        return 'Aumenta apenas a duração, o ritmo ou a complexidade dos saltos de cada vez.';
      }
      return 'Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.';
    }
    if (group == 'Mobilidade') {
      return 'Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.';
    }
    if (_has(n, ['unilateral', 'alternado', 'suitcase'])) {
      return 'Aumenta gradualmente o peso ou a pausa sem permitir rotação ou inclinação do tronco.';
    }
    if (_isBodyweightEquipment(equipment)) {
      return 'Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.';
    }
    return 'Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.';
  }

  static String _breathingFor(String name, String group) {
    if (group == 'Mobilidade') {
      return 'Respira lentamente e usa a expiração para relaxar a zona alongada, sem forçar mais amplitude.';
    }
    if (group == 'Cardio') {
      return 'Mantém a respiração contínua e reduz o ritmo se não conseguires recuperar o padrão respiratório.';
    }
    if (_isIsometricHold(name)) {
      return 'Respira de forma curta e contínua durante a sustentação; nunca prendas o ar.';
    }
    return 'Inspira na fase de preparação ou de retorno e expira durante o esforço, sem prender a respiração.';
  }

  static bool _isIsometricHold(String name) => _has(_n(name), [
    'isometr',
    'prancha',
    'hold',
    'wall sit',
    'dead hang',
    'vacuum',
  ]);

  static String _postureFor(String name, String group) {
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Conserva uma base estável, pescoço neutro, guarda organizada e espaço seguro para cair ou deslocar.';
    }
    return 'Mantém os apoios firmes, a coluna e o pescoço neutros e as articulações a seguir a trajetória descrita nos passos.';
  }

  static String _adaptationFor(String name, String group) {
    final n = _n(name);
    if (_has(n, ['pescoco', 'cervical'])) {
      return 'Evita ou adapta este exercício com tontura, dor irradiada, formigueiro ou diagnóstico cervical; usa apenas força muito leve.';
    }
    if (group == 'Cardio') {
      return 'Adapta a duração e a intensidade à tua condição atual; interrompe com dor no peito, tontura ou falta de ar fora do habitual.';
    }
    return 'Evita ou adapta este exercício se houver dor aguda, instabilidade, perda de força ou limitação clínica que impeça a amplitude sem compensar.';
  }

  static String _equipmentOverride(
    String name,
    String group,
    String baseEquipment,
  ) {
    final n = _n(name);
    final context = _n(group);
    if (context == 'karate') {
      // Os drills de Karate treinam-se de pé; nenhum exige tatami. A única
      // exceção é o trabalho ao saco, que exige o saco de pancada.
      if (_has(n, ['trabalho leve ao saco'])) return 'Saco de pancada';
      return 'Peso corporal';
    }
    // `_n` troca '-' por espaço, por isso o grupo "Jiu-Jitsu" normaliza para
    // 'jiu jitsu' (sem underscore).
    if (context == 'jiu jitsu') {
      // Só os drills de solo pedem tatami/tapete; mobilidade, pega, core e
      // condicionamento fazem-se em qualquer piso seguro.
      if (_has(n, [
        'shrimp',
        'ponte de grappling',
        'technical stand-up',
        'guarda',
        'sprawl',
        'rolamentos',
        'breakfalls',
        'granby',
      ])) {
        return 'Tatami ou tapete / colchonete';
      }
      return 'Peso corporal';
    }
    if (_has(n, ['copenhagen plank'])) {
      return 'Banco / cadeira / apoio estável';
    }
    if (_has(n, ['abducao de anca deitada'])) return 'Peso corporal';
    if (context.isNotEmpty &&
        _has(n, ['curl inverso']) &&
        !_has(n, ['com halteres'])) {
      return 'Barra ou barra EZ';
    }
    if (_has(n, ['curl inclinado', 'curl spider'])) {
      return 'Halteres, banco inclinado ou apoio estável';
    }
    if (_has(n, ['press fechado com halteres', 'tate press'])) {
      return 'Halteres, banco ou chão estável';
    }
    if (_has(n, [
      'triceps testa com halteres',
      'extensao de triceps deitado',
    ])) {
      return 'Halteres, banco ou chão estável';
    }
    if (_has(n, ['aberturas com halteres', 'supino com halteres'])) {
      return 'Halteres, banco ou chão estável';
    }
    if (_has(n, ['reverse fly', 'elevacao posterior', 'y raise', 'w raise'])) {
      return baseEquipment.trim().isEmpty
          ? 'Halteres ou banco inclinado'
          : baseEquipment.trim();
    }
    return baseEquipment.trim().isEmpty
        ? 'Peso corporal'
        : baseEquipment.trim();
  }

  static String _secondaryFor(String name, String group, String baseSecondary) {
    final n = _n(name);
    if (_has(n, ['lenhador'])) {
      return 'Oblíquos, glúteos, ombros e estabilidade da anca';
    }
    if (_has(n, ['toque no ombro'])) {
      return 'Ombros, serrátil anterior, glúteos e estabilidade do punho';
    }
    if (_has(n, ['clamshell'])) {
      return 'Glúteo médio, glúteo mínimo, rotadores externos da anca e core lateral';
    }
    if (_has(n, ['curl nordico'])) {
      return 'Isquiotibiais, gémeos, glúteos e core';
    }
    if (_has(n, ['remo ergometro'])) {
      return 'Pernas, costas, braços e core em sequência';
    }
    if (_has(n, ['air bike'])) {
      return 'Pernas, braços, ombros e fôlego';
    }
    if (_has(n, ['stepper'])) {
      return 'Glúteos, quadríceps, gémeos e fôlego';
    }
    if (_has(n, ['foam roller para pernas'])) {
      return 'Quadríceps, parte de trás das coxas e gémeos';
    }
    if (_has(n, ['foam roller para costas'])) {
      return 'Coluna torácica e músculos das costas';
    }
    if (_has(n, ['bola de massagem'])) {
      return 'Planta do pé, glúteos e mobilidade geral';
    }
    if (_has(n, ['respiracao nasal'])) {
      return 'Diafragma, músculos respiratórios e sistema nervoso calmo';
    }
    if (_has(n, ['short foot', 'doming', 'dedos do pe'])) {
      return 'Arco plantar, dedos, tornozelo, tibial posterior e equilíbrio';
    }
    if (_has(n, [
      'dorsiflexao',
      'inversao do tornozelo',
      'eversao do tornozelo',
    ])) {
      return 'Tornozelo, músculos do pé, perónio/fibulares, tibial posterior e equilíbrio';
    }
    if (_has(n, ['flexao da anca'])) {
      return 'Reto femoral, core, glúteo médio da perna de apoio e equilíbrio';
    }
    if (_has(n, ['copenhagen'])) {
      return 'Adutores, oblíquos, glúteo médio, ombro de apoio e core';
    }
    if (_has(n, ['extensao terminal do joelho'])) {
      return 'Quadríceps, vasto medial, glúteos e estabilidade do joelho';
    }
    if (_has(n, ['abducao de anca deitada'])) {
      return 'Glúteo médio, glúteo mínimo, abdutores da anca e core lateral';
    }
    if (_has(n, ['curl de perna'])) {
      return 'Glúteos, gémeos e estabilizadores do joelho';
    }
    if (_has(n, ['extensao de perna'])) {
      return 'Estabilizadores do joelho e controlo da anca';
    }
    if (_has(n, ['leg press'])) {
      return 'Glúteos, posterior de coxa, adutores e gémeos';
    }
    if (_isCurl(name)) {
      if (_has(n, ['inverso'])) {
        return 'Braquial, braquiorradial, extensores do antebraço, punho e pega';
      }
      if (_has(n, ['martelo', 'cruzado', 'zottman'])) {
        return 'Braquial, braquiorradial, antebraço, punho e pega';
      }
      return 'Braquial, braquiorradial, antebraço e estabilizadores do punho';
    }
    if (_has(n, [
      'wrist curl',
      'reverse wrist',
      'finger',
      'pronacao',
      'supinacao',
      'desvio radial',
      'desvio ulnar',
    ])) {
      return 'Dedos, punho, cotovelo e músculos estabilizadores do antebraço';
    }
    if (_has(n, [
      'farmer',
      'hold',
      'dead hang',
      'pinch',
      'plate',
      'towel',
      'aperto',
    ])) {
      return 'Antebraço, punho, dedos, trapézio, core e controlo da pega';
    }
    if (_isTriceps(name)) {
      return 'Ombros e peito como apoio, com estabilização do tronco';
    }
    if (_isPushupOrPress(name)) {
      return 'Tríceps, deltoide anterior, serrátil anterior e core';
    }
    if (_isFly(name)) {
      return 'Deltoide anterior, bíceps como estabilizador e escápulas';
    }
    if (_isRowOrPull(name)) {
      return 'Bíceps, braquial, antebraço, trapézio e romboides';
    }
    if (_isShoulder(name)) {
      return 'Trapézio, serrátil anterior, manguito rotador e core';
    }
    if (_isSquat(name) || _isLunge(name)) {
      return 'Glúteos, posterior de coxa, adutores, gémeos e core';
    }
    if (_isHinge(name)) {
      return 'Glúteos, posterior de coxa, lombar, dorsais e pega';
    }
    if (_has(n, ['gemeos', 'soleo', 'tibial'])) {
      return 'Tornozelo, pé, equilíbrio e controlo do joelho';
    }
    if (group == 'Cardio') {
      return 'Core, pernas, coordenação, respiração e sistema cardiovascular';
    }
    if (group == 'Mobilidade') return _mobilitySecondary(name);
    if (group == 'Karate') {
      return 'Base, anca, core, ombros, guarda e coordenação';
    }
    if (group == 'Jiu-Jitsu') {
      return 'Core, anca, pescoço, pega, respiração e controlo no solo';
    }
    return baseSecondary.trim().isEmpty
        ? 'Core, estabilizadores articulares e controlo da carga'
        : baseSecondary.trim();
  }

  static const Map<String, _NamedSummary> _summaryByName = {
    'puxada alta': _NamedSummary(
      'puxada vertical na polia alta, descendo a barra até à parte alta do peito com os cotovelos para baixo.',
    ),
    'puxada com bracos esticados': _NamedSummary(
      'puxada na polia alta com os braços quase estendidos, descendo a barra em arco até às coxas para isolar o dorsal.',
    ),
    'flexao fechada': _NamedSummary(
      'flexão com as mãos mais juntas que os ombros, que carrega mais o tríceps do que a flexão normal.',
    ),
    'flexao diamante': _NamedSummary(
      'flexão com as mãos unidas em diamante debaixo do peito, a variação de flexão mais exigente para o tríceps.',
    ),
    'mobilidade de ombro': _NamedSummary(
      'movimentos ativos do braço e da escápula em várias direções, para ganhar amplitude útil no ombro.',
      contextGroup: 'Mobilidade',
    ),
    'mobilidade de ombro com cabo de vassoura': _NamedSummary(
      'mobilidade de ombro guiada por um bastão leve seguro com as duas mãos, para controlar o arco do movimento.',
    ),
    'encolhimento de ombros com halteres': _NamedSummary(
      'elevação dos ombros com um halter em cada mão ao lado do corpo, focada no trapézio superior.',
    ),
    'encolhimento de ombros com barra': _NamedSummary(
      'elevação dos ombros com uma barra segura à frente das coxas, que permite mais peso no trapézio.',
    ),
    'encolhimento de ombros na maquina': _NamedSummary(
      'elevação dos ombros na máquina de encolhimentos, com trajetória guiada e apoio estável.',
    ),
    'elevacao posterior': _NamedSummary(
      'abertura dos braços para trás com o tronco inclinado, para isolar o deltoide posterior.',
    ),
    'reverse fly': _NamedSummary(
      'abertura invertida com halteres e peito apoiado ou tronco inclinado, que junta as omoplatas e trabalha a parte de trás dos ombros.',
    ),
    'rotacao externa da anca no chao': _NamedSummary(
      'alongamento no chão que roda a anca para fora, abrindo o joelho para o lado para soltar os rotadores.',
    ),
    'supino inclinado com halteres': _NamedSummary(
      'supino em banco inclinado com um halter em cada mão, deixando cada braço guiar a sua trajetória para o peito superior.',
    ),
    'supino inclinado com barra': _NamedSummary(
      'supino em banco inclinado com barra, empurrando o peso numa linha fixa a partir do peito superior.',
    ),
    'supino declinado com halteres': _NamedSummary(
      'supino em banco declinado com halteres, com cada braço a controlar a descida para o peito inferior.',
    ),
    'supino declinado com barra': _NamedSummary(
      'supino em banco declinado com barra, para carregar o peito inferior com trajetória estável.',
    ),
    'supino declinado na maquina': _NamedSummary(
      'press declinado guiado pela máquina, com costas apoiadas e pegas na linha baixa do peito.',
    ),
    'aberturas inclinadas com halteres': _NamedSummary(
      'abertura em arco com halteres num banco inclinado, alongando o peito superior.',
    ),
    'aberturas inclinadas no cabo': _NamedSummary(
      'abertura em arco nas polias, com tensão constante do cabo dirigida ao peito superior.',
    ),
    'aberturas inclinadas com elastico': _NamedSummary(
      'abertura em arco contra elásticos presos atrás de ti, fechando os braços para o peito superior.',
    ),
    'remo baixo no cabo': _NamedSummary(
      'puxada horizontal na polia baixa, sentado, levando a pega à cintura com os cotovelos junto ao corpo.',
    ),
    'remo sentado': _NamedSummary(
      'remada na máquina de remo sentado, com peito apoiado ou tronco firme, puxando as pegas para trás.',
    ),
    'remo unilateral com halter': _NamedSummary(
      'remada com um halter e apoio no banco, puxando o peso para a anca um lado de cada vez.',
    ),
    'remo com barra': _NamedSummary(
      'remada com barra e tronco inclinado, puxando o peso para a zona baixa das costelas.',
    ),
    'remo invertido': _NamedSummary(
      'remada com o peso do corpo por baixo de uma barra baixa, puxando o peito à barra.',
    ),
    'remo invertido em mesa resistente': _NamedSummary(
      'remada de peso corporal por baixo de uma mesa muito firme, puxando o peito à borda.',
    ),
    'remo com elastico': _NamedSummary(
      'remada sentado no chão com o elástico preso aos pés, puxando as pontas às costelas.',
    ),
    'pull-up': _NamedSummary(
      'puxada vertical do corpo na barra fixa com palmas para a frente, subindo o queixo em direção à barra.',
    ),
    'scapular pull-up': _NamedSummary(
      'puxada curta só das escápulas na barra fixa, sem dobrar os cotovelos, para ativar o controlo escapular.',
    ),
    'dead hang escapular': _NamedSummary(
      'suspensão na barra alternando ombros soltos e escápulas ativas, para aprender a organizar os ombros.',
    ),
    'dead hang': _NamedSummary(
      'suspensão parada na barra fixa para fortalecer a pega, os dedos e a resistência dos ombros.',
      contextGroup: 'Antebraço/Pega',
    ),
    'hiperextensao lombar': _NamedSummary(
      'extensão do tronco na máquina ou banco de hiperextensões, subindo até à linha reta do corpo.',
    ),
    'hiperextensao no chao': _NamedSummary(
      'elevação curta do peito deitado de barriga para baixo, ativando a lombar sem equipamento.',
    ),
    'hiperextensao no banco romano': _NamedSummary(
      'extensão do tronco no banco romano, com a almofada na anca e descida profunda controlada.',
    ),
    'superman isometrico': _NamedSummary(
      'sustentação parada com braços, peito e pernas elevados do chão, para resistência da lombar.',
    ),
    'superman': _NamedSummary(
      'repetições de elevação de braços e pernas deitado de barriga para baixo, para a cadeia posterior.',
      contextGroup: 'Core',
    ),
    'good morning sem carga': _NamedSummary(
      'inclinação do tronco pela anca, sem qualquer peso, para aprender a dobrar com a coluna neutra.',
    ),
    'good morning com barra': _NamedSummary(
      'dobradiça de anca com barra apoiada nas costas, inclinando o tronco à frente com coluna neutra.',
    ),
    'good morning leve isometrico': _NamedSummary(
      'inclinação do tronco pela anca mantida parada alguns segundos, para resistência da cadeia posterior.',
    ),
    'good morning leve': _NamedSummary(
      'dobradiça de anca com barra vazia ou muito leve, para aprender a inclinar o tronco com coluna neutra.',
      contextGroup: 'Pernas',
    ),
    'curl com barra': _NamedSummary(
      'flexão dos cotovelos com barra, subindo o peso à frente do corpo com pega supinada.',
    ),
    'curl com halteres': _NamedSummary(
      'flexão dos cotovelos com um halter em cada mão, subindo os dois lados ao mesmo tempo.',
    ),
    'curl no cabo': _NamedSummary(
      'flexão dos cotovelos na polia baixa, com tensão constante do cabo do início ao fim.',
    ),
    'curl com elastico': _NamedSummary(
      'flexão dos cotovelos contra um elástico pisado ou preso em baixo, com resistência a crescer no topo.',
    ),
    'extensao de triceps no cabo': _NamedSummary(
      'extensão dos cotovelos na polia alta, empurrando a barra para baixo com os cotovelos colados ao tronco.',
    ),
    'triceps testa com barra ez': _NamedSummary(
      'extensão deitada com barra EZ, descendo o peso à testa e esticando os cotovelos sem mexer os ombros.',
    ),
    'triceps testa com halteres': _NamedSummary(
      'extensão deitada com halteres em pega neutra, descendo o peso à testa com os cotovelos apontados ao teto.',
    ),
    'extensao de triceps deitado com halteres': _NamedSummary(
      'extensão deitada com halteres, descendo o peso atrás da cabeça para alongar bem o tríceps.',
    ),
    'supino fechado': _NamedSummary(
      'supino com barra e pega estreita, que transforma o empurrar em trabalho dominante de tríceps.',
    ),
    'press fechado com halteres': _NamedSummary(
      'press deitado com halteres juntos em pega neutra, empurrando com os cotovelos perto do tronco.',
    ),
    'tate press': _NamedSummary(
      'extensão de tríceps deitado em que os halteres descem ao peito com os cotovelos abertos para o lado.',
    ),
    'fundos entre apoios': _NamedSummary(
      'descida e subida do corpo com as mãos na borda de um banco, dobrando os cotovelos para trás.',
    ),
    'extensao unilateral de triceps': _NamedSummary(
      'extensão de um braço de cada vez com halter acima da cabeça, descendo o peso por trás.',
    ),
    'dips para triceps': _NamedSummary(
      'descida e subida do corpo nas paralelas com o tronco vertical, para concentrar o esforço no tríceps.',
    ),
    'triceps no cabo com corda': _NamedSummary(
      'extensão dos cotovelos na polia alta com corda, afastando as pontas em baixo para contrair mais.',
    ),
    'triceps com elastico': _NamedSummary(
      'extensão dos cotovelos contra um elástico preso em cima, empurrando as pontas para baixo.',
    ),
    'extensao acima da cabeca com halter': _NamedSummary(
      'extensão com um halter seguro pelas duas mãos acima da cabeça, descendo atrás da nuca.',
    ),
    'extensao francesa com halter': _NamedSummary(
      'extensão francesa com halter único, alongando a cabeça longa do tríceps atrás da cabeça.',
    ),
    'extensao francesa com barra ez': _NamedSummary(
      'extensão francesa com barra EZ, com pega ondulada que alivia os punhos na descida atrás da cabeça.',
    ),
    'extensao francesa no cabo': _NamedSummary(
      'extensão francesa na polia, de costas para o cabo, com tensão constante atrás da cabeça.',
    ),
    'kickback de triceps': _NamedSummary(
      'extensão do cotovelo com halter e tronco inclinado, levando o peso para trás até o tríceps contrair.',
    ),
    'kickback no cabo': _NamedSummary(
      'extensão do cotovelo na polia baixa com o tronco inclinado, com tensão constante do cabo.',
    ),
    'crunch': _NamedSummary(
      'flexão curta do tronco deitado, aproximando as costelas da bacia sem puxar o pescoço.',
    ),
    'bicycle crunch': _NamedSummary(
      'flexão com rotação alternada, levando o cotovelo ao joelho contrário como a pedalar.',
    ),
    'elevacao de pernas': _NamedSummary(
      'subida e descida das pernas deitado de costas, com a lombar sempre encostada ao chão.',
    ),
    'elevacao de joelhos suspenso': _NamedSummary(
      'elevação dos joelhos ao peito suspenso na barra fixa, enrolando ligeiramente a bacia.',
    ),
    'pallof press no cabo': _NamedSummary(
      'anti-rotação na polia à altura do peito: estendes os braços e resistes à torção do tronco.',
    ),
    'pallof press com elastico': _NamedSummary(
      'anti-rotação com elástico preso ao lado: estendes os braços e impedes o tronco de rodar.',
    ),
    'russian twist': _NamedSummary(
      'rotação alternada do tronco sentado, com o tronco inclinado atrás e os pés apoiados ou elevados.',
    ),
    'side bend': _NamedSummary(
      'inclinação lateral do tronco em pé, descendo a mão pela perna para trabalhar os oblíquos.',
    ),
    'flutter kicks': _NamedSummary(
      'batimentos curtos e alternados das pernas deitado de costas, com a lombar encostada.',
    ),
    'toe touches': _NamedSummary(
      'subida curta dos ombros com as mãos em direção aos pés, com as pernas na vertical.',
    ),
    'agachamento com peso corporal': _NamedSummary(
      'agachamento sem equipamento, descendo a anca como se fosses sentar e voltando a subir.',
    ),
    'agachamento para cadeira': _NamedSummary(
      'agachamento com uma cadeira atrás como referência de profundidade, tocando levemente no assento.',
    ),
    'agachamento com halteres ao lado': _NamedSummary(
      'agachamento com um halter em cada mão ao lado do corpo, para carregar sem barra.',
    ),
    'agachamento com barra': _NamedSummary(
      'agachamento com barra apoiada na parte alta das costas, para treinar as pernas com mais peso.',
    ),
    'agachamento com mochila': _NamedSummary(
      'agachamento caseiro com uma mochila carregada e bem ajustada às costas.',
    ),
    'agachamento com garrafao': _NamedSummary(
      'agachamento caseiro segurando um garrafão de água junto ao peito, como um goblet squat.',
    ),
    'agachamento bulgaro': _NamedSummary(
      'agachamento unilateral com o pé de trás apoiado num banco, exigindo equilíbrio e força da perna da frente.',
    ),
    'agachamento bulgaro com apoio': _NamedSummary(
      'agachamento búlgaro com uma mão apoiada na parede para ganhar equilíbrio enquanto aprendes.',
    ),
    'lunges': _NamedSummary(
      'afundo no lugar: um passo à frente, descida dos dois joelhos e regresso à posição inicial.',
    ),
    'lunges com halteres': _NamedSummary(
      'afundo com um halter em cada mão ao lado do corpo, mantendo o tronco direito.',
    ),
    'lunges com mochila': _NamedSummary(
      'afundo caseiro com mochila carregada às costas, sem deixar o peso puxar o tronco.',
    ),
    'walking lunges': _NamedSummary(
      'afundos em deslocamento, avançando um passo a cada repetição e alternando as pernas.',
    ),
    'gemeos em pe': _NamedSummary(
      'elevação dos calcanhares em pé, subindo à ponta dos pés para trabalhar os gémeos.',
    ),
    'gemeos sentado': _NamedSummary(
      'elevação dos calcanhares sentado, com os joelhos dobrados para pedir mais ao sóleo.',
    ),
    'elevacao de gemeos unilateral': _NamedSummary(
      'elevação do calcanhar numa perna de cada vez, para corrigir diferenças de força e equilíbrio.',
    ),
    'alongamento gemeos': _NamedSummary(
      'alongamento estático da barriga da perna, com a perna de trás esticada e o calcanhar no chão.',
    ),
    'alongamento gemeos na parede': _NamedSummary(
      'alongamento dos gémeos com as mãos na parede e a ponta do pé apoiada contra ela.',
    ),
    'passadeira caminhada': _NamedSummary(
      'caminhada em passadeira a ritmo confortável, em que consegues falar frases completas.',
    ),
    'passadeira caminhada rapida': _NamedSummary(
      'caminhada vigorosa em passadeira, com passo vivo em que só consegues frases curtas.',
    ),
    'passadeira corrida leve': _NamedSummary(
      'corrida suave em passadeira, a ritmo contínuo e conversável.',
    ),
    'hiit passadeira': _NamedSummary(
      'intervalos intensos na passadeira: blocos rápidos alternados com recuperação a caminhar.',
    ),
    'passadeira corrida intervalada': _NamedSummary(
      'alternância de corrida rápida e trote leve na passadeira, em blocos programados.',
    ),
    'passadeira sprints': _NamedSummary(
      'tiros curtos e fortes na passadeira, com recuperação completa entre cada sprint.',
    ),
    'passadeira sprints intervalados': _NamedSummary(
      'série programada de sprints na passadeira com pausas ativas cronometradas.',
    ),
    'passadeira inclinacao': _NamedSummary(
      'caminhada em subida na passadeira, com inclinação leve para ativar glúteos e gémeos.',
    ),
    'passadeira inclinacao moderada': _NamedSummary(
      'caminhada em subida com inclinação média, mais exigente para pernas e respiração.',
    ),
    'bicicleta ritmo leve': _NamedSummary(
      'pedalada suave e contínua, com resistência baixa e respiração confortável.',
    ),
    'bicicleta ritmo moderado': _NamedSummary(
      'pedalada contínua a ritmo médio, com resistência que aquece as pernas sem esgotar.',
    ),
    'bicicleta resistencia': _NamedSummary(
      'pedalada com resistência alta e cadência mais lenta, para força de pernas na bicicleta.',
    ),
    'hiit bicicleta': _NamedSummary(
      'intervalos intensos na bicicleta: blocos fortes de pedalada alternados com recuperação leve.',
    ),
    'eliptica ritmo leve': _NamedSummary(
      'movimento contínuo suave na elíptica, de baixo impacto, para aquecer ou recuperar.',
    ),
    'eliptica ritmo moderado': _NamedSummary(
      'trabalho contínuo a ritmo médio na elíptica, coordenando pernas e braços.',
    ),
    'eliptica intervalos': _NamedSummary(
      'alternância de blocos rápidos e lentos na elíptica, mantendo o movimento fluido.',
    ),
    'eliptica resistencia': _NamedSummary(
      'elíptica com resistência alta e cadência controlada, para mais força e menos velocidade.',
    ),
    'eliptica aquecimento': _NamedSummary(
      'entrada progressiva na elíptica para preparar articulações e respiração antes do treino.',
    ),
    'eliptica cooldown': _NamedSummary(
      'redução gradual do ritmo na elíptica no fim do treino, até a respiração acalmar.',
    ),
    'corda de saltar ritmo leve': _NamedSummary(
      'saltos baixos e contínuos à corda, a ritmo calmo e sustentável.',
    ),
    'hiit corda': _NamedSummary(
      'intervalos intensos à corda: blocos rápidos de saltos alternados com pausas curtas.',
    ),
    'caminhada exterior leve': _NamedSummary(
      'caminhada tranquila ao ar livre, a ritmo em que consegues conversar sem esforço.',
    ),
    'caminhada exterior moderada': _NamedSummary(
      'caminhada firme ao ar livre, com passo decidido que aquece o corpo e acelera a respiração.',
    ),
    'mobilidade de anca para karate': _NamedSummary(
      'sequência de mobilidade de anca orientada aos pontapés e às bases do Karate.',
    ),
    'mobilidade de ombro para karate': _NamedSummary(
      'sequência de mobilidade de ombros orientada à guarda e aos socos do Karate.',
    ),
    'condicionamento leve para karate': _NamedSummary(
      'circuito leve de resistência com movimentos de Karate, para aguentar treinos mais longos.',
    ),
    'sprawl': _NamedSummary(
      'defesa de entrada às pernas: a anca cai para trás e as pernas disparam atrás, terminando com o peito alto.',
    ),
    'mobilidade de anca para jiu-jitsu': _NamedSummary(
      'mobilidade de anca orientada à guarda e às fugas de anca do Jiu-Jitsu.',
    ),
    'mobilidade de ombro para jiu-jitsu': _NamedSummary(
      'mobilidade de ombros orientada às pegas e ao trabalho de solo do Jiu-Jitsu.',
    ),
    'condicionamento leve para jiu-jitsu': _NamedSummary(
      'circuito leve com movimentos de solo do Jiu-Jitsu, para ganhar fôlego sem parceiro.',
    ),
    'mobilidade toracica': _NamedSummary(
      'mobilização suave da coluna torácica com rotações e extensões controladas.',
    ),
    'rotacao toracica no chao': _NamedSummary(
      'rotação do tronco deitado de lado, abrindo o braço de cima em arco enquanto a anca fica quieta.',
    ),
    'cat-cow': _NamedSummary(
      'alternância em quatro apoios entre arquear e arredondar a coluna, ao ritmo da respiração.',
    ),
    'open book': _NamedSummary(
      'rotação torácica deitado de lado com joelhos dobrados, abrindo o braço de cima como um livro.',
    ),
    'mobilidade de ombro com toalha': _NamedSummary(
      'mobilidade de ombro usando uma toalha esticada entre as mãos como guia de amplitude.',
    ),
    'circulos de ombro': _NamedSummary(
      'círculos lentos e amplos com os ombros para soltar a articulação e aquecer as escápulas.',
    ),
    'alongamento gluteos': _NamedSummary(
      'alongamento do glúteo deitado, puxando um joelho na direção do peito ou do ombro contrário.',
    ),
    'alongamento de gluteo sentado': _NamedSummary(
      'alongamento do glúteo sentado numa cadeira, com o tornozelo cruzado sobre o joelho contrário.',
    ),
    'alongamento piriforme': _NamedSummary(
      'alongamento profundo do piriforme deitado, cruzando uma perna e puxando a coxa contrária.',
    ),
    'mobilidade leve de anca': _NamedSummary(
      'movimentos fáceis da anca em amplitudes pequenas, para dias leves ou recuperação.',
    ),
    'alongamento quadriceps em pe': _NamedSummary(
      'alongamento da frente da coxa em pé, levando o calcanhar ao glúteo com apoio para equilibrar.',
    ),
    'alongamento quadriceps de lado': _NamedSummary(
      'alongamento da frente da coxa deitado de lado, segurando o pé de cima atrás do corpo.',
    ),
    'mobilidade de tornozelo na parede': _NamedSummary(
      'avanço do joelho em direção à parede com o calcanhar no chão, para ganhar dorsiflexão.',
    ),
    'circulos de tornozelo': _NamedSummary(
      'círculos lentos com a ponta do pé em ambas as direções, para soltar o tornozelo.',
    ),
    'mobilidade de punhos': _NamedSummary(
      'sequência suave de flexão, extensão e círculos dos punhos, útil antes de apoiar as mãos.',
    ),
    'extensao de punhos no chao': _NamedSummary(
      'mobilização dos punhos em extensão, com as palmas no chão e os dedos para a frente.',
    ),
    'flexao de punhos no chao': _NamedSummary(
      'mobilização dos punhos em flexão, com as costas das mãos apoiadas no chão.',
    ),
    'isometria cervical posterior leve': _NamedSummary(
      'pressão leve da cabeça para trás contra as próprias mãos, sem movimento, para fortalecer a parte de trás do pescoço.',
    ),
    'elevacao no plano da omoplata': _NamedSummary(
      'elevação dos halteres na diagonal entre a frente e o lado do corpo, no plano natural da omoplata, mais confortável para o ombro.',
    ),
    'lenhador no cabo': _NamedSummary(
      'rotação do tronco em diagonal a puxar o cabo de cima para baixo com os braços quase esticados, para treinar os oblíquos com carga.',
    ),
    'prancha com toque no ombro': _NamedSummary(
      'prancha alta em que tocas com uma mão no ombro oposto sem deixar a bacia rodar, para treinar o core contra a rotação.',
    ),
    'clamshell': _NamedSummary(
      'abertura e fecho do joelho de cima, deitado de lado com os joelhos dobrados, para fortalecer o glúteo médio e os rotadores externos da anca.',
    ),
    'curl nordico assistido': _NamedSummary(
      'descida lenta do tronco a partir dos joelhos, com os calcanhares presos e as mãos prontas para amparar, para trabalhar os isquiotibiais em travagem.',
    ),
    'peso morto unilateral com halteres': _NamedSummary(
      'dobradiça de anca sobre uma perna com o halter na mão oposta, para trabalhar isquiotibiais, glúteos e equilíbrio.',
    ),
    'remo ergometro ritmo continuo': _NamedSummary(
      'remadas contínuas a ritmo confortável no remo ergómetro, com pernas, tronco e braços em sequência; cardio de impacto baixo para o corpo inteiro.',
    ),
    'remo ergometro intervalos': _NamedSummary(
      'alternância entre remadas fortes e recuperação suave no remo ergómetro; cardio intervalado de impacto baixo.',
    ),
    'stepper escadas ritmo continuo': _NamedSummary(
      'subida contínua de degraus no stepper a ritmo constante; cardio de impacto baixo focado em pernas e glúteos.',
    ),
    'stepper escadas intervalos': _NamedSummary(
      'blocos rápidos e blocos lentos alternados no stepper; cardio intervalado de impacto baixo a médio para pernas e fôlego.',
    ),
    'subida de escadas no exterior': _NamedSummary(
      'subir escadas reais a passo firme e descer devagar para recuperar; cardio de impacto médio para pernas e fôlego.',
    ),
    'air bike ritmo continuo': _NamedSummary(
      'pedalar e empurrar o guiador da air bike a ritmo constante; cardio de impacto baixo que usa braços e pernas ao mesmo tempo.',
    ),
    'air bike intervalos': _NamedSummary(
      'sprints curtos e recuperações longas na air bike; cardio intervalado exigente e de impacto baixo.',
    ),
    'shadow boxing leve': _NamedSummary(
      'combinações leves de socos no ar com deslocamentos suaves; cardio de coordenação de impacto baixo a médio.',
    ),
    'shuttle runs corrida vaivem': _NamedSummary(
      'corridas curtas de ida e volta entre duas marcas, com travagem e mudança de direção; cardio de impacto alto.',
    ),
    'treino de bases dachi': _NamedSummary(
      'passagem lenta e controlada entre as posições base do Karate — zenkutsu, kiba e kokutsu dachi — mantendo a altura da bacia.',
    ),
    'bloqueios tecnicos uke': _NamedSummary(
      'prática encadeada dos bloqueios fundamentais do Karate (age-uke, soto-uke e gedan-barai), com recolha forte do braço contrário.',
    ),
    'esquivas e tai sabaki': _NamedSummary(
      'deslocamentos do corpo para sair da linha de ataque — recuar, sair para o lado e rodar — mantendo a guarda alta.',
    ),
    'joelhadas tecnicas': _NamedSummary(
      'elevação do joelho em linha ao alvo (hiza-geri), com a anca a avançar no final e as mãos a simular o controlo do adversário.',
    ),
    'trabalho leve ao saco': _NamedSummary(
      'socos e pontapés leves e técnicos ao saco de pancada, com foco na distância e no alinhamento do punho, não na força.',
    ),
    'rolamentos de solo': _NamedSummary(
      'rolamento para a frente e para trás sobre o ombro, com o corpo em bola, para aprenderes a cair e a levantar em segurança.',
    ),
    'breakfalls ukemi': _NamedSummary(
      'quedas amortecidas para trás e para o lado, com o queixo preso ao peito e palmada firme no tatami no momento do impacto.',
    ),
    'inversao granby com apoio': _NamedSummary(
      'inversão sobre a linha dos ombros, a rolar de um lado para o outro com apoio das mãos, para treinar a rotação de guarda invertida.',
    ),
    'alongamento pnf de isquiotibiais': _NamedSummary(
      'alongamento contrai-relaxa: empurras a perna contra as mãos durante alguns segundos, soltas e ganhas amplitude nova no posterior da coxa.',
    ),
    'alongamento pnf de peitoral na parede': _NamedSummary(
      'alongamento contrai-relaxa do peito: pressionas o antebraço contra a parede, soltas e rodas o tronco um pouco mais.',
    ),
    'alongamento de flexores da anca em afundo': _NamedSummary(
      'alongamento em afundo com o joelho de trás no chão, levando a bacia à frente para alongar a frente da anca.',
    ),
    'alongamento borboleta de adutores': _NamedSummary(
      'alongamento sentado com as plantas dos pés unidas, deixando os joelhos descer para alongar adutores e virilha.',
    ),
    'alongamento dinamico global': _NamedSummary(
      'sequência dinâmica que liga afundo, rotação do tronco e dobradiça, mobilizando anca, coluna e isquiotibiais num só movimento.',
    ),
    'alongamento de triceps atras da cabeca': _NamedSummary(
      'alongamento do braço dobrado atrás da cabeça, com a outra mão a puxar suavemente o cotovelo, para soltar tríceps e ombro.',
    ),
    'cobra suave no chao': _NamedSummary(
      'extensão suave da coluna deitado de barriga para baixo, subindo o peito com o apoio dos antebraços sem forçar a lombar.',
    ),
    'respiracao nasal lenta': _NamedSummary(
      'respiração calma feita só pelo nariz, com expiração mais longa do que a inspiração, para baixar o ritmo e recuperar.',
    ),
    'foam roller para pernas': _NamedSummary(
      'rolar devagar quadríceps, posteriores da coxa e gémeos sobre o rolo de espuma, parando alguns segundos nos pontos mais sensíveis.',
    ),
    'foam roller para costas': _NamedSummary(
      'rolar a parte média e alta das costas sobre o rolo, com os braços cruzados e a bacia levantada, evitando a lombar e o pescoço.',
    ),
    'bola de massagem para pes e gluteos': _NamedSummary(
      'pressão lenta da planta do pé e do glúteo sobre uma bola de massagem, à procura de pontos tensos para soltar.',
    ),
    'arrefecimento pos treino de forca': _NamedSummary(
      'rotina de fim de treino de força: caminhada muito leve, respiração calma e alongamentos suaves dos músculos trabalhados.',
    ),
    'arrefecimento pos artes marciais': _NamedSummary(
      'rotina de fim de treino de artes marciais: marcha lenta, círculos de ombros e anca e alongamentos leves de pernas e costas.',
    ),
    'aquecimento dinamico geral': _NamedSummary(
      'rotina de aquecimento sem equipamento que mobiliza as articulações de cima para baixo e termina com movimentos que elevam o pulso.',
    ),
  };

  static String _movementSummary(String name, String group) {
    final n = _n(name);
    final exact = _summaryByNameNormalized[_n(name)];
    if (exact != null &&
        (exact.contextGroup == null || exact.contextGroup == group)) {
      return exact.text;
    }
    if (_has(n, ['short foot', 'doming'])) {
      return 'contração curta dos músculos intrínsecos do pé que aproxima suavemente a base do dedo grande do calcanhar sem enrolar os dedos.';
    }
    if (_has(n, ['flexao ativa dos dedos do pe'])) {
      return 'flexão e abertura deliberada dos dedos do pé, mantendo o calcanhar e a base do dedo grande em contacto com o chão.';
    }
    if (_has(n, ['dorsiflexao do tornozelo'])) {
      return 'elevação da ponta do pé contra elástico, aproximando os dedos da canela sem rodar o joelho ou a anca.';
    }
    if (_has(n, ['inversao do tornozelo'])) {
      return 'rotação controlada da planta do pé para dentro contra elástico, com a perna imóvel e amplitude pequena.';
    }
    if (_has(n, ['eversao do tornozelo'])) {
      return 'rotação controlada da planta do pé para fora contra elástico, isolando o tornozelo sem mover o joelho.';
    }
    if (_has(n, ['flexao da anca em pe'])) {
      return 'elevação do joelho contra elástico pela flexão da anca, mantendo a bacia nivelada e o tronco vertical.';
    }
    if (_has(n, ['copenhagen plank'])) {
      return 'prancha lateral com a perna superior apoiada num banco e a inferior a ajudar, treinando adutores e resistência à inclinação do tronco.';
    }
    if (_has(n, ['extensao terminal do joelho'])) {
      return 'extensão dos últimos graus do joelho contra elástico, apertando o quadríceps sem deslocar a bacia.';
    }
    if (_has(n, ['abducao de anca deitada'])) {
      return 'elevação lateral da perna de cima, deitado de lado, sem rodar a bacia nem apontar os dedos para o teto.';
    }
    if (_has(n, ['farmer walk'])) {
      return 'caminhada carregada em que seguras dois halteres ao lado do corpo e percorres uma distância curta sem deixar a pega ou a postura ceder.';
    }
    if (_has(n, ['farmer hold'])) {
      return 'hold bilateral parado em que seguras cargas ao lado do corpo como num farmer walk, mas sem dar passos.';
    }
    if (_has(n, ['hold estatico'])) {
      return 'hold parado de pega em que ficas imóvel a segurar halteres ao lado do corpo durante um tempo definido.';
    }
    if (_has(n, ['aperto isometrico'])) {
      return 'contração de aperto sustentada, focada em fechar a mão com força sem mover o braço.';
    }
    if (_has(n, ['suitcase carry'])) {
      return 'caminhada unilateral carregada; uma carga fica num lado do corpo e o tronco resiste a inclinar.';
    }
    if (_has(n, ['dead hang'])) {
      return 'suspensão na barra fixa para suportar o peso do corpo com mãos, dedos e ombros ativos.';
    }
    if (_has(n, ['pinch grip'])) {
      return 'segurar discos em pinça, apertando com polegar e dedos sem fechar a mão à volta de uma pega grossa.';
    }
    if (_has(n, ['plate hold'])) {
      return 'segurar um ou mais discos pela borda durante tempo definido, sem deixar escorregar.';
    }
    if (_has(n, ['towel grip'])) {
      return 'suspensão ou suporte numa toalha, exigindo que os dedos agarrem tecido em vez de uma barra rígida.';
    }
    if (_has(n, ['reverse wrist'])) {
      return 'extensão do punho com antebraços apoiados, levantando os nós dos dedos contra a resistência.';
    }
    if (_has(n, ['wrist curl'])) {
      return 'flexão do punho com antebraços apoiados, levando a palma na direção do antebraço sem mexer o cotovelo.';
    }
    if (_has(n, ['pronacao'])) {
      return 'rotação do antebraço para virar a palma para baixo usando um halter leve como alavanca.';
    }
    if (_has(n, ['supinacao'])) {
      return 'rotação do antebraço para virar a palma para cima com controlo do cotovelo e do punho.';
    }
    if (_has(n, ['desvio radial'])) {
      return 'inclinação do punho para o lado do polegar, feita devagar com halter leve.';
    }
    if (_has(n, ['desvio ulnar'])) {
      return 'inclinação do punho para o lado do dedo mínimo, controlando uma carga pequena sem torcer o antebraço.';
    }
    if (_has(n, ['finger curls'])) {
      return 'flexão dos dedos em que a carga rola para a ponta dos dedos e volta para a palma.';
    }
    if (_has(n, ['extensao de dedos'])) {
      return 'abertura dos dedos contra um elástico para equilibrar o trabalho de fechar a mão.';
    }
    if (_has(n, ['rotacao controlada com halter'])) {
      return 'rotação curta e deliberada do punho com halter leve para ganhar controlo, não força máxima.';
    }
    if (_has(n, ['curl martelo'])) {
      return 'curl de cotovelo com pega neutra, mantendo o polegar virado para cima para desafiar braquial e braquiorradial.';
    }
    if (_has(n, ['curl inverso'])) {
      return 'curl com pega pronada, palmas para baixo, que troca parte do foco do bíceps para o antebraço.';
    }
    if (_has(n, ['curl zottman'])) {
      return 'curl que sobe com palma para cima e desce com palma para baixo, combinando bíceps e antebraço.';
    }
    if (_has(n, ['curl cruzado'])) {
      return 'curl diagonal em que o halter sobe em direção ao ombro oposto, mantendo pega neutra.';
    }
    if (_has(n, ['curl alternado'])) {
      return 'curl feito um braço de cada vez para controlar melhor cada cotovelo e evitar balanço.';
    }
    if (_has(n, ['curl concentrado'])) {
      return 'curl sentado com o braço apoiado na coxa para isolar a flexão do cotovelo.';
    }
    if (_has(n, ['curl inclinado'])) {
      return 'curl em banco inclinado, começando com o braço mais atrás para alongar o bíceps.';
    }
    if (_has(n, ['curl spider'])) {
      return 'curl com peito apoiado, impedindo o tronco de ajudar a levantar a carga.';
    }
    if (_has(n, ['curl 21'])) {
      return 'sequência de curl com parciais inferiores, parciais superiores e repetições completas.';
    }
    if (_has(n, ['curl arrastado'])) {
      return 'curl em que os cotovelos recuam e a carga sobe perto do tronco, como se arrastasse.';
    }
    if (_has(n, ['curl isometrico'])) {
      return 'curl mantido parado num ângulo definido para treinar tensão sem movimento repetido.';
    }
    if (_isCurl(name)) {
      return 'flexão do cotovelo para aproximar o peso do ombro sem balançar tronco ou ombros.';
    }
    if (_has(n, ['kickback de gluteo'])) {
      return 'extensão da anca em quatro apoios, empurrando o calcanhar para trás e para cima até o glúteo contrair.';
    }
    if (_has(n, ['kickback'])) {
      return 'extensão do cotovelo com o braço junto ao tronco, levando o halter ou a pega para trás até o tríceps contrair.';
    }
    if (_has(n, ['francesa', 'acima da cabeca'])) {
      return 'extensão do cotovelo acima ou atrás da cabeça, alongando a cabeça longa do tríceps antes de subir.';
    }
    if (_isTriceps(name)) {
      return 'extensão do cotovelo para empurrar a resistência, mantendo o braço estável.';
    }
    if (_has(n, ['flexao classica'])) {
      return 'flexão de braços em prancha alta, aproximando o peito do chão e empurrando o corpo de volta.';
    }
    if (_has(n, ['flexao inclinada'])) {
      return 'flexão com mãos elevadas num apoio, mais leve para o tronco, ideal para aprender o padrão de empurrar.';
    }
    if (_has(n, ['flexao declinada'])) {
      return 'flexão com pés elevados, aumentando a exigência no peito superior e nos ombros.';
    }
    if (_has(n, ['flexao aberta'])) {
      return 'flexão com mãos mais afastadas para aumentar o braço de alavanca sobre o peito.';
    }
    if (_has(n, ['flexao arqueiro'])) {
      return 'flexão assimétrica em que o corpo se desloca para um lado enquanto o outro braço ajuda estendido.';
    }
    if (_has(n, ['flexao com joelhos'])) {
      return 'flexão com joelhos apoiados, mais leve, para aprender a linha do corpo.';
    }
    if (_has(n, ['flexao fechada'])) {
      return 'flexão com mãos mais próximas para aumentar o trabalho de tríceps.';
    }
    if (_has(n, ['flexao diamante'])) {
      return 'flexão com mãos em forma de diamante para desafiar tríceps e peito interno.';
    }
    if (_has(n, ['supino inclinado'])) {
      return 'supino num banco inclinado para empurrar a carga a partir da zona superior do peito.';
    }
    if (_has(n, ['supino declinado'])) {
      return 'supino num banco declinado para empurrar a carga com foco maior no peito inferior.';
    }
    if (_has(n, ['supino fechado'])) {
      return 'supino com pega mais estreita para transformar o empurrar em trabalho dominante de tríceps.';
    }
    if (_has(n, ['supino com barra'])) {
      return 'supino horizontal com barra, empurrando a carga do peito até quase estender os braços.';
    }
    if (_has(n, ['supino com halteres'])) {
      return 'supino horizontal com halteres, permitindo que cada braço controle a sua própria trajetória.';
    }
    if (_has(n, ['chest press'])) {
      return 'empurrar numa máquina guiada de peito, com costas apoiadas e pegas à frente.';
    }
    if (_has(n, ['squeeze press'])) {
      return 'press com halteres juntos, apertando-os enquanto empurras para manter tensão no peito.';
    }
    if (_has(n, ['dips para peito'])) {
      return 'descida e subida nas paralelas com tronco inclinado para dar foco ao peito.';
    }
    if (_isPushupOrPress(name)) {
      return 'movimento de empurrar em que peito, ombros e tríceps vencem a resistência à frente do corpo.';
    }
    if (_has(n, ['aberturas inclinadas'])) {
      return 'abertura em banco inclinado, abrindo os braços em arco para alongar o peito superior.';
    }
    if (_has(n, ['aberturas com halteres'])) {
      return 'abertura de peito com halteres em arco amplo, sem transformar o exercício em press.';
    }
    if (_has(n, ['crossover'])) {
      return 'cruzamento de cabos à frente do corpo para juntar os braços pela contração do peito.';
    }
    if (_isFly(name)) {
      return 'abertura em arco, com cotovelos ligeiramente fletidos, para aproximar os braços pela ação do peito.';
    }
    if (_has(n, ['face pull'])) {
      return 'puxada em direção ao rosto com cotovelos altos para treinar deltoide posterior, romboides e controlo das escápulas.';
    }
    if (_has(n, ['puxada alta pega aberta'])) {
      return 'puxada vertical com mãos afastadas para enfatizar a largura das costas e a descida dos cotovelos.';
    }
    if (_has(n, ['puxada alta pega neutra'])) {
      return 'puxada vertical com palmas viradas uma para a outra, facilitando cotovelos próximos e dorsal ativo.';
    }
    if (_has(n, ['puxada alta pega fechada'])) {
      return 'puxada vertical com pega curta para sentir dorsal e braços a trabalhar perto do tronco.';
    }
    if (_has(n, ['puxada'])) {
      return 'puxada vertical em que os cotovelos descem para aproximar a pega do peito e ativar o dorsal.';
    }
    if (_has(n, ['remo alto'])) {
      return 'puxada alta leve com cotovelos a subir até uma altura confortável para trabalhar trapézio e ombros sem forçar.';
    }
    if (_has(n, ['remo'])) {
      return 'puxada horizontal em que os cotovelos vão para trás e as escápulas se aproximam.';
    }
    if (_has(n, ['pullover'])) {
      return 'movimento em arco dos braços acima do tronco para trabalhar dorsal ou peito conforme o contexto.';
    }
    if (_has(n, ['pull-up'])) {
      return 'puxada vertical do corpo na barra fixa com palmas geralmente viradas para fora.';
    }
    if (_has(n, ['chin-up'])) {
      return 'puxada vertical do corpo na barra fixa com palmas viradas para ti, envolvendo mais bíceps.';
    }
    if (_has(n, ['scapular pull-up'])) {
      return 'puxada curta só das escápulas na barra, sem dobrar os cotovelos.';
    }
    if (_has(n, ['dead hang escapular'])) {
      return 'suspensão ativa na barra para alternar ombros longos e escápulas organizadas.';
    }
    if (_has(n, ['puxada com bracos esticados'])) {
      return 'puxada de cabo com braços quase estendidos para sentir o dorsal sem dobrar muito cotovelos.';
    }
    if (_isRowOrPull(name)) {
      return 'puxada controlada para costas, usando escápulas e cotovelos em vez de impulso do tronco.';
    }
    if (_has(n, ['elevacao lateral'])) {
      return 'elevação dos braços para os lados até perto da linha dos ombros para focar o deltoide lateral.';
    }
    if (_has(n, ['elevacao frontal'])) {
      return 'elevação dos braços à frente do corpo para focar o deltoide anterior.';
    }
    if (_has(n, ['elevacao posterior', 'reverse fly'])) {
      return 'abertura para trás com tronco inclinado ou apoio, focada no deltoide posterior.';
    }
    if (_has(n, ['arnold press'])) {
      return 'press de ombros que começa com halteres à frente do peito e roda as palmas durante a subida.';
    }
    if (_has(n, ['press militar com barra em pe'])) {
      return 'press vertical com barra feito de pé, exigindo que pernas e core estabilizem a carga acima da cabeça.';
    }
    if (_has(n, ['press militar com barra'])) {
      return 'press vertical com barra a partir da frente dos ombros, empurrando acima da cabeça em linha controlada.';
    }
    if (_has(n, ['press militar com halteres'])) {
      return 'press vertical com halteres, deixando cada braço estabilizar a sua própria trajetória.';
    }
    if (_has(n, ['press militar'])) {
      return 'press vertical acima da cabeça, empurrando a carga sem arquear a lombar.';
    }
    if (_has(n, ['rotacao externa com elastico'])) {
      return 'rotação externa do ombro contra elástico, com cotovelo colado ao corpo.';
    }
    if (_has(n, ['rotacao externa'])) {
      return 'rotação do ombro para fora com cotovelo fixo, fortalecendo o manguito rotador.';
    }
    if (_has(n, ['rotacao interna com elastico'])) {
      return 'rotação interna do ombro contra elástico, puxando a mão para a linha do abdómen.';
    }
    if (_has(n, ['rotacao interna'])) {
      return 'rotação do ombro para dentro contra resistência leve, controlando o cotovelo junto ao corpo.';
    }
    if (_has(n, ['encolhimento'])) {
      return 'elevação curta dos ombros para cima e ligeiramente para trás, focada no trapézio.';
    }
    if (_has(n, ['y raise'])) {
      return 'elevação dos braços em forma de Y para trabalhar trapézio inferior e controlo escapular.';
    }
    if (_has(n, ['w raise'])) {
      return 'elevação com cotovelos dobrados em forma de W para ativar trapézio médio e rotadores externos.';
    }
    if (_has(n, ['wall slides'])) {
      return 'deslizamento dos braços na parede para treinar rotação superior da escápula e mobilidade de ombro.';
    }
    if (_has(n, ['pull-apart'])) {
      return 'abrir um elástico à frente do peito para aproximar escápulas e ativar deltoide posterior.';
    }
    if (_has(n, ['scapular push-up'])) {
      return 'flexão escapular em prancha, arredondando e aproximando as escápulas sem dobrar cotovelos.';
    }
    if (_has(n, ['pike push-up'])) {
      return 'flexão com anca elevada para transformar o empurrar em trabalho vertical de ombros.';
    }
    if (_isShoulder(name)) {
      return 'movimento de ombro ou escápula para elevar, rodar ou estabilizar o braço com controlo.';
    }
    if (_has(n, ['curl de perna'])) {
      return 'flexão dos joelhos na máquina, puxando os calcanhares na direção dos glúteos para trabalhar o posterior de coxa.';
    }
    if (_has(n, ['extensao de perna'])) {
      return 'extensão dos joelhos sentado na máquina, empurrando o rolo com a frente das pernas até quase esticar.';
    }
    if (_has(n, ['leg press'])) {
      return 'empurrar a plataforma da máquina com os pés, dobrando e estendendo joelhos e anca com as costas apoiadas.';
    }
    if (_has(n, ['aducao de anca'])) {
      return 'aproximar as pernas contra a resistência da máquina, apertando a parte interna das coxas.';
    }
    if (n == 'abducao de anca') {
      return 'afastar as pernas contra a resistência da máquina, usando a parte lateral da anca e os glúteos.';
    }
    if (_has(n, ['agachamento sumo'])) {
      return 'agachamento com os pés bem mais afastados que os ombros e as pontas dos pés viradas para fora, dando mais trabalho a adutores e glúteos.';
    }
    if (_has(n, ['agachamento goblet'])) {
      return 'agachamento a segurar um halter na vertical junto ao peito, o que ajuda a manter o tronco direito.';
    }
    if (_has(n, ['smith'])) {
      return 'agachamento na barra guiada da máquina Smith, que fixa a trajetória vertical da carga.';
    }
    if (_has(n, ['wall sit'])) {
      return 'agachamento isométrico encostado à parede, mantendo joelhos fletidos sem subir e descer.';
    }
    if (_has(n, ['step-up'])) {
      return 'subida controlada para um apoio elevado, usando uma perna de cada vez.';
    }
    if (_has(n, ['agachamento bulgaro'])) {
      return 'agachamento unilateral com a perna de trás apoiada, exigindo equilíbrio e força da perna da frente.';
    }
    if (_isSquat(name)) {
      return 'agachamento ou variação de joelho dominante, descendo a anca como se fosses sentar e voltando a subir.';
    }
    if (_isLunge(name)) {
      return 'passada ou afundo unilateral em que uma perna guia a descida e a subida.';
    }
    if (_has(n, ['peso morto tradicional'])) {
      return 'levantamento do chão com flexão de anca e joelhos, mantendo a carga perto das pernas.';
    }
    if (_has(n, ['peso morto romeno'])) {
      return 'dobradiça de anca com joelhos pouco fletidos para alongar posterior de coxa e glúteos.';
    }
    if (_has(n, ['good morning'])) {
      return 'inclinação do tronco pela anca com carga leve ou sem carga, treinando controlo posterior.';
    }
    if (_isHinge(name)) {
      return 'dobradiça de anca, levando a anca para trás enquanto a coluna se mantém neutra.';
    }
    if (_has(n, ['gemeos'])) {
      return 'elevação do calcanhar para treinar a flexão plantar dos gémeos.';
    }
    if (_has(n, ['soleo'])) {
      return 'elevação do calcanhar com joelho fletido para dar mais foco ao sóleo.';
    }
    if (_has(n, ['tibial'])) {
      return 'elevação da ponta do pé para treinar a parte da frente da perna.';
    }
    if (_isCore(name, group)) return _coreMovementSummary(name);
    if (group == 'Cardio') return _cardioMovementSummary(name);
    if (group == 'Mobilidade') return _mobilityMovementSummary(name);
    if (group == 'Karate') return _karateMovementSummary(name);
    if (group == 'Jiu-Jitsu') return _jiuJitsuMovementSummary(name);
    if (_has(n, ['pescoco', 'cervical', 'chin tuck'])) {
      return _neckMovementSummary(name);
    }
    return 'exercício de $group com movimento específico de $name, feito para controlar a área trabalhada sem dor.';
  }

  static String _coreMovementSummary(String name) {
    final n = _n(name);
    if (_has(n, ['prancha lateral'])) {
      return 'suporte lateral do corpo para resistir à queda da anca e treinar oblíquos.';
    }
    if (_has(n, ['prancha'])) {
      return 'suporte em linha reta para resistir à extensão da lombar.';
    }
    if (_has(n, ['reverse crunch'])) {
      return 'enrolar a bacia para aproximar joelhos do tronco sem balançar as pernas.';
    }
    if (_has(n, ['crunch'])) {
      return 'flexão curta do tronco para aproximar costelas da bacia.';
    }
    if (_has(n, ['elevacao de pernas', 'elevacao de joelhos'])) {
      return 'elevar pernas ou joelhos controlando a bacia e evitando puxar pela lombar.';
    }
    if (_has(n, ['dead bug'])) {
      return 'alternar braço e perna enquanto a lombar se mantém estável no chão.';
    }
    if (_has(n, ['hollow'])) {
      return 'posição em concha com braços e pernas afastados para treinar tensão abdominal contínua.';
    }
    if (_has(n, ['mountain'])) {
      return 'levar joelhos alternados ao peito em prancha, misturando core e ritmo cardiovascular.';
    }
    if (_has(n, ['pallof'])) {
      return 'resistir à rotação enquanto empurras cabo ou elástico à frente do peito.';
    }
    if (_has(n, ['russian', 'bicycle', 'side bend'])) {
      return 'rotação ou inclinação lateral do tronco para desafiar os oblíquos.';
    }
    if (_has(n, ['bird dog'])) {
      return 'estender braço e perna opostos em quatro apoios sem rodar a bacia.';
    }
    if (_has(n, ['vacuum'])) {
      return 'contração respiratória profunda para puxar suavemente o abdómen para dentro.';
    }
    if (_has(n, ['superman'])) {
      return 'elevar braços e pernas do chão para ativar lombar e cadeia posterior.';
    }
    return 'controlo do tronco para estabilizar, fletir ou resistir ao movimento da coluna.';
  }

  static String _cardioMovementSummary(String name) {
    final n = _n(name);
    if (_has(n, ['passadeira aquecimento'])) {
      return 'caminhada fácil na passadeira para subir a temperatura corporal antes da parte principal.';
    }
    if (_has(n, ['passadeira cooldown'])) {
      return 'caminhada muito leve na passadeira para baixar gradualmente respiração e ritmo cardíaco.';
    }
    if (_has(n, ['passadeira caminhada'])) {
      return 'caminhada em passadeira com passada curta e ritmo sustentável.';
    }
    if (_has(n, ['passadeira corrida intervalada', 'passadeira sprints'])) {
      return 'blocos curtos de corrida rápida na passadeira alternados com recuperação.';
    }
    if (_has(n, ['passadeira inclinacao'])) {
      return 'caminhada ou corrida com inclinação moderada para aumentar esforço sem sprint.';
    }
    if (_has(n, ['passadeira'])) {
      return 'corrida leve em passadeira com controlo de velocidade, passada e respiração.';
    }
    if (_has(n, ['bicicleta aquecimento'])) {
      return 'pedalada leve para preparar joelhos, anca e respiração antes do treino.';
    }
    if (_has(n, ['bicicleta cooldown'])) {
      return 'pedalada fácil para recuperar depois de esforço mais intenso.';
    }
    if (_has(n, ['bicicleta intervalos'])) {
      return 'alternar pedaladas fortes e recuperações leves na bicicleta.';
    }
    if (_has(n, ['bicicleta'])) {
      return 'pedalada contínua com cadência e resistência ajustadas ao objetivo.';
    }
    if (_has(n, ['eliptica'])) {
      return 'movimento elíptico contínuo de pernas e braços com baixo impacto articular.';
    }
    if (_has(n, ['corda'])) {
      if (_has(n, ['intervalos'])) {
        return 'saltos de corda em blocos rápidos alternados com pausas curtas de recuperação.';
      }
      if (_has(n, ['pes alternados'])) {
        return 'saltos de corda alternando pé direito e esquerdo como corrida leve no lugar.';
      }
      if (_has(n, ['joelhos altos'])) {
        return 'saltos de corda elevando os joelhos mais alto para aumentar intensidade e coordenação.';
      }
      if (_has(n, ['double unders'])) {
        return 'variação avançada em que a corda passa duas vezes por baixo dos pés no mesmo salto.';
      }
      return 'saltos baixos coordenados com a corda, usando punhos para rodar e pés para aterrar leve.';
    }
    if (_has(n, ['caminhada exterior em subida'])) {
      return 'caminhada ao ar livre numa subida, usando passos curtos e esforço contínuo.';
    }
    if (_has(n, ['caminhada exterior rapida'])) {
      return 'caminhada ao ar livre em ritmo vivo, sem transformar a passada em corrida.';
    }
    if (_has(n, ['caminhada exterior'])) {
      return 'caminhada ao ar livre com ritmo controlado e atenção ao piso.';
    }
    if (_has(n, ['corrida exterior intervalada'])) {
      return 'corrida ao ar livre alternando blocos rápidos e recuperação em caminhada ou trote.';
    }
    if (_has(n, ['sprints exterior'])) {
      return 'sprints curtos no exterior com aceleração progressiva e descanso amplo.';
    }
    if (_has(n, ['corrida em subida'])) {
      return 'corrida em terreno inclinado para aumentar esforço sem depender só da velocidade.';
    }
    if (_has(n, ['corrida exterior moderada'])) {
      return 'corrida ao ar livre em ritmo sustentável, mais forte que corrida leve e abaixo de sprint.';
    }
    if (_has(n, ['corrida exterior'])) {
      return 'corrida no exterior com passada, direção e intensidade adaptadas ao terreno.';
    }
    if (_has(n, ['marcha no lugar'])) {
      return 'marcha parada elevando alternadamente os pés para aquecer sem sair do sítio.';
    }
    if (_has(n, ['hiit peso corporal'])) {
      return 'circuito intervalado sem equipamento com exercícios curtos e recuperações claras.';
    }
    if (_has(n, ['hiit simples'])) {
      return 'intervalos básicos de esforço e pausa, escolhendo movimentos simples e fáceis de controlar.';
    }
    if (_has(n, ['hiit cardio'])) {
      return 'intervalos de cardio para subir a frequência cardíaca mantendo técnica segura.';
    }
    if (_has(n, ['circuito cardio peso corporal'])) {
      return 'sequência de cardio sem equipamento alternando movimentos de corpo inteiro por tempo.';
    }
    if (_has(n, ['circuito cardio leve'])) {
      return 'circuito de baixa intensidade para aquecer ou recuperar sem impacto alto.';
    }
    if (_has(n, ['circuito cardio'])) {
      return 'sequência de vários movimentos de cardio feita por tempo, com transições rápidas.';
    }
    if (_has(n, ['burpees'])) {
      return 'sequência de agachar, apoiar mãos, ir à prancha e voltar a levantar para elevar a frequência cardíaca.';
    }
    if (_has(n, ['jumping jacks'])) {
      return 'abrir e fechar braços e pernas em saltos leves para aquecer e ganhar ritmo.';
    }
    if (_has(n, ['skaters'])) {
      return 'saltos laterais alternados que treinam cardio e controlo de anca.';
    }
    if (_has(n, ['high knees'])) {
      return 'corrida no lugar com joelhos altos para aumentar cadência e respiração.';
    }
    return 'cardio sem equipamento feito em blocos de ritmo, coordenação e respiração controlada.';
  }

  static String _mobilityMovementSummary(String name) {
    final n = _n(name);
    if (_has(n, ['cervical', 'pescoco', 'chin tuck'])) {
      return _neckMovementSummary(name);
    }
    if (_has(n, ['mobilidade leve de ombros'])) {
      return 'movimentos fáceis de ombros para recuperar amplitude sem carga nem dor.';
    }
    if (_has(n, ['mobilidade de ombro'])) {
      return 'movimentos ativos do braço e da escápula para ganhar amplitude útil no ombro.';
    }
    if (_has(n, ['alongamento posterior do ombro'])) {
      return 'cruzar o braço à frente do peito para alongar deltoide posterior e cápsula do ombro.';
    }
    if (_has(n, ['alongamento peitoral no canto'])) {
      return 'usar o canto da parede para abrir os dois lados do peito ao mesmo tempo.';
    }
    if (_has(n, ['alongamento peitoral na parede'])) {
      return 'apoiar um antebraço na parede e rodar o tronco para abrir o peito desse lado.';
    }
    if (_has(n, ['alongamento peitoral'])) {
      return 'abrir o braço e rodar o tronco para sentir tensão suave na frente do peito.';
    }
    if (_has(n, ['alongamento posterior com perna elevada'])) {
      return 'colocar uma perna num apoio e inclinar pela anca para alongar a parte de trás da coxa.';
    }
    if (_has(n, ['mobilidade dinamica de posterior'])) {
      return 'movimentos ativos de alongar e voltar para preparar posterior de coxa antes do treino.';
    }
    if (_has(n, ['alongamento posterior sentado'])) {
      return 'sentar com pernas estendidas e inclinar pela anca para alongar posterior de coxa.';
    }
    if (_has(n, ['alongamento posterior em pe'])) {
      return 'ficar de pé e inclinar o tronco pela anca até sentir tensão atrás das coxas.';
    }
    if (_has(n, ['alongamento posterior de coxa'])) {
      return 'alongamento estático focado na parte de trás da coxa, sem balanços.';
    }
    if (_has(n, ['figura 4'])) {
      return 'alongamento de glúteo com uma perna cruzada em quatro para libertar rotadores da anca.';
    }
    if (_has(n, ['mobilidade de anca'])) {
      return 'movimentos suaves da bacia e da anca para ganhar rotação, flexão e controlo.';
    }
    if (_has(n, ['mobilidade dinamica de anca'])) {
      return 'sequência ativa de anca com mudanças de posição para preparar treino ou corrida.';
    }
    if (_has(n, ['tocar nos pes sentado'])) {
      return 'inclinação sentada em direção aos pés para alongar posterior de coxa sem balanço.';
    }
    if (_has(n, ['tocar nos pes em pe'])) {
      return 'inclinação em pé para aproximar mãos dos pés mantendo tensão leve na cadeia posterior.';
    }
    if (_has(n, ['pigeon'])) {
      return 'posição no chão com uma perna à frente para alongar glúteo e piriforme.';
    }
    if (_has(n, ['90/90'])) {
      return 'troca controlada entre rotações de anca com joelhos dobrados no chão.';
    }
    if (_has(n, ['posterior'])) {
      return 'inclinação pela anca para sentir alongamento atrás da coxa sem forçar a lombar.';
    }
    if (_has(n, ['quadriceps'])) {
      return 'levar o calcanhar ao glúteo para alongar a frente da coxa.';
    }
    if (_has(n, ['dorsal'])) {
      return 'afastar braços e tronco para alongar dorsal e zona lateral das costas.';
    }
    if (_has(n, ['toracica', 'open book', 'cat-cow'])) {
      return 'mobilizar a coluna torácica por rotação, extensão ou flexão suave.';
    }
    if (_has(n, ['tornozelo'])) {
      return 'levar o joelho sobre o pé para melhorar dorsiflexão sem levantar o calcanhar.';
    }
    if (_has(n, ['gemeos'])) {
      return 'alongar a barriga da perna mantendo calcanhar apoiado.';
    }
    if (_has(n, ['punho'])) {
      return 'inclinar o peso sobre as mãos para mobilizar flexão ou extensão do punho.';
    }
    if (_has(n, ['respiracao'])) {
      return 'respiração lenta pelo diafragma para reduzir tensão e recuperar ritmo.';
    }
    if (_has(n, ['caminhada leve'])) {
      return 'caminhada fácil para circulação e recuperação ativa.';
    }
    if (_has(n, ['relaxamento'])) {
      return 'posição de descanso no chão para baixar tensão e controlar respiração.';
    }
    return 'mobilidade suave da zona indicada, procurando tensão leve e controlo respiratório.';
  }

  static String _karateMovementSummary(String name) {
    final n = _n(name);
    if (_has(n, ['kihon'])) {
      return 'repetição técnica de bases, socos, defesas ou pontapés fundamentais com controlo.';
    }
    if (_has(n, ['kata'])) {
      return 'sequência formal de técnicas de Karate com direção, ritmo, postura e controlo.';
    }
    if (_has(n, ['kumite'])) {
      return 'drill técnico de combate para distância, guarda e reação controlada.';
    }
    if (_has(n, ['sombra'])) {
      return 'simulação individual de combate, combinando deslocamento, técnicas no ar e controlo.';
    }
    if (_has(n, ['deslocamento'])) {
      return 'trabalho de pés para entrar, sair e mudar ângulo sem cruzar a base, mantendo controlo.';
    }
    if (_has(n, ['drills de guarda'])) {
      return 'repetições de entrada e saída de guarda para organizar mãos, cotovelos, distância e controlo.';
    }
    if (_has(n, ['guarda'])) {
      return 'organização das mãos, cotovelos e postura para proteger, responder e manter controlo.';
    }
    if (_has(n, ['pontapes'])) {
      return 'pontapés técnicos com câmara, extensão, recolha da perna e controlo.';
    }
    if (_has(n, ['socos'])) {
      return 'socos técnicos coordenando punho, anca, tronco, base e controlo.';
    }
    return 'drill de Karate para praticar base, direção, precisão e controlo antes da velocidade.';
  }

  static String _jiuJitsuMovementSummary(String name) {
    final n = _n(name);
    if (_has(n, ['shrimp', 'fuga de anca'])) {
      return 'fuga de anca no solo para criar espaço e recuperar guarda.';
    }
    if (_has(n, ['ponte'])) {
      return 'ponte de grappling para elevar a anca e desequilibrar pressão.';
    }
    if (_has(n, ['technical stand-up'])) {
      return 'subida técnica do chão mantendo uma mão protegida e a perna livre.';
    }
    if (_has(n, ['passagem de guarda'])) {
      return 'repetição de passos, pressão e controlo de anca para passar as pernas do adversário.';
    }
    if (_has(n, ['guarda'])) {
      return 'drill de guarda para gerir pernas, anca, pega e distância.';
    }
    if (_has(n, ['passagem'])) {
      return 'movimento de passar guarda com base, pressão e controlo de anca.';
    }
    if (_has(n, ['pega'])) {
      return 'trabalho de pega aplicado a kimono, punhos ou controlo de grappling.';
    }
    if (_has(n, ['core'])) {
      return 'drill de core no solo para proteger coluna e transferir força pela anca.';
    }
    return 'drill de Jiu-Jitsu para praticar movimentação no solo, base e controlo corporal.';
  }

  static String _neckMovementSummary(String name) {
    final n = _n(name);
    if (_has(n, ['frontal'])) {
      return 'pressão isométrica leve da testa contra a mão para ativar flexores cervicais sem mover a cabeça.';
    }
    if (_has(n, ['lateral', 'inclinacao'])) {
      return 'inclinação ou pressão lateral leve da cabeça para trabalhar controlo cervical de lado.';
    }
    if (_has(n, ['rotacao'])) {
      return 'rotação lenta da cabeça para olhar para cada lado sem puxar o pescoço.';
    }
    if (_has(n, ['chin tuck'])) {
      return 'recuar suavemente o queixo para alinhar cabeça e pescoço, como criar uma papada leve.';
    }
    return 'movimento cervical suave para ganhar controlo sem forçar articulações do pescoço.';
  }

  static String _primaryTarget(String name, String group) {
    final n = _n(name);
    if (_has(n, ['curl nordico'])) {
      return 'posterior de coxa em travagem, glúteos e core';
    }
    if (_has(n, ['remo ergometro'])) {
      return 'resistência cardiovascular com pernas, costas e braços';
    }
    if (_has(n, ['plano da omoplata'])) {
      return 'deltóide lateral e supraespinhoso';
    }
    if (_has(n, ['clamshell'])) {
      return 'glúteo médio e rotadores externos da anca';
    }
    if (_has(n, ['peso morto unilateral'])) {
      return 'posterior de coxa, glúteos e equilíbrio';
    }
    if (_has(n, ['pnf de isquiotibiais'])) {
      return 'flexibilidade do posterior de coxa';
    }
    if (_has(n, ['pnf de peitoral'])) {
      return 'flexibilidade do peito e do ombro';
    }
    if (_has(n, ['flexores da anca em afundo'])) {
      return 'mobilidade da frente da anca';
    }
    if (_has(n, ['borboleta de adutores'])) {
      return 'mobilidade dos adutores e da anca';
    }
    if (_has(n, ['dinamico global'])) {
      return 'mobilidade geral de anca, coluna e ombros';
    }
    if (_has(n, ['cobra suave'])) return 'mobilidade de extensão da coluna';
    if (_has(n, ['respiracao nasal'])) {
      return 'recuperação e controlo da respiração';
    }
    if (_has(n, ['foam roller para pernas'])) {
      return 'recuperação muscular das pernas';
    }
    if (_has(n, ['foam roller para costas'])) {
      return 'recuperação da zona média e alta das costas';
    }
    if (_has(n, ['bola de massagem'])) {
      return 'recuperação dos pés e dos glúteos';
    }
    if (_has(n, ['arrefecimento pos'])) return 'recuperação depois do treino';
    if (_has(n, ['aquecimento dinamico'])) {
      return 'preparação do corpo para o treino';
    }
    if (_has(n, ['isometria cervical posterior'])) {
      return 'extensores do pescoço e controlo cervical';
    }
    if (_has(n, ['short foot', 'doming', 'dedos do pe'])) {
      return 'músculos intrínsecos do pé, arco plantar e controlo dos dedos';
    }
    if (_has(n, ['dorsiflexao'])) {
      return 'tibial anterior e dorsiflexores do tornozelo';
    }
    if (_has(n, ['inversao do tornozelo'])) {
      return 'tibial posterior e controlo medial do tornozelo';
    }
    if (_has(n, ['eversao do tornozelo'])) {
      return 'músculos fibulares e controlo lateral do tornozelo';
    }
    if (_has(n, ['flexao da anca'])) {
      return 'flexores da anca e reto femoral';
    }
    if (_has(n, ['copenhagen'])) {
      return 'adutores da anca e core anti-flexão lateral';
    }
    if (_has(n, ['extensao terminal do joelho'])) {
      return 'quadríceps, com ênfase no vasto medial';
    }
    if (_has(n, ['abducao de anca deitada'])) {
      return 'glúteo médio, glúteo mínimo e abdutores';
    }
    if (_has(n, [
      'farmer',
      'hold',
      'dead hang',
      'aperto',
      'pinch',
      'plate',
      'towel',
    ])) {
      return 'força de pega, dedos e antebraço';
    }
    if (_has(n, ['reverse wrist', 'extensao de dedos'])) {
      return 'extensores do antebraço e punho';
    }
    if (_has(n, ['wrist curl', 'finger'])) {
      return 'flexores do antebraço e dedos';
    }
    if (_has(n, ['pronacao'])) return 'pronadores do antebraço';
    if (_has(n, ['supinacao'])) return 'supinadores do antebraço';
    if (_has(n, ['desvio', 'rotacao controlada'])) {
      return 'punho e controlo do antebraço';
    }
    if (_has(n, ['martelo', 'braquiorradial'])) {
      return 'braquial e braquiorradial';
    }
    if (_has(n, ['curl de perna'])) return 'posterior de coxa';
    if (_has(n, ['extensao de perna'])) return 'quadríceps';
    if (_has(n, ['aducao de anca'])) return 'adutores da coxa';
    if (_has(n, ['abducao de anca'])) {
      return 'glúteo médio, glúteo mínimo e abdutores';
    }
    if (_isCurl(name)) return 'bíceps braquial, braquial e braquiorradial';
    if (_isTriceps(name)) return 'tríceps';
    if (_isFly(name) || _isPushupOrPress(name)) {
      return 'peito, ombros e tríceps';
    }
    if (_isRowOrPull(name)) return 'costas, escápulas e dorsal';
    if (_isShoulder(name)) return 'ombros e estabilizadores escapulares';
    if (_isSquat(name) || _isLunge(name)) {
      return 'quadríceps, glúteos e estabilidade da anca';
    }
    if (_isHinge(name)) return 'posterior de coxa, glúteos e lombar controlada';
    if (_has(n, ['ponte', 'hip thrust', 'kickback de gluteo'])) {
      return 'glúteos, com apoio do posterior de coxa e do core';
    }
    if (_has(n, ['gemeos', 'soleo'])) return 'gémeos, sóleo e tornozelo';
    if (_has(n, ['tibial'])) return 'tibial anterior';
    if (_isCore(name, group)) return 'core, abdominal e estabilidade do tronco';
    if (group == 'Cardio') return 'resistência cardiovascular e respiração';
    if (group == 'Mobilidade') {
      return 'mobilidade da zona indicada e respiração';
    }
    if (group == 'Karate') return 'técnica de Karate, base e coordenação';
    if (_has(n, ['passagem de guarda'])) {
      return 'passagem de guarda, pressão e controlo da anca';
    }
    if (_has(n, ['drills de guarda'])) {
      return 'retenção de guarda, distância e movimento de anca';
    }
    if (group == 'Jiu-Jitsu') {
      return 'movimentação de Jiu-Jitsu, anca e controlo no solo';
    }
    if (_has(n, ['pescoco', 'cervical', 'chin tuck'])) {
      return 'controlo cervical';
    }
    return group;
  }

  static String _stepsFor(String name, String group, String equipment) {
    final lowerBodyGapSteps = _lowerBodyGapSteps(name);
    if (lowerBodyGapSteps != null) return lowerBodyGapSteps;
    final variantSteps = _distinctVariantSteps(name, equipment);
    if (variantSteps != null) return variantSteps;
    final specific = _specificSteps(name, group, equipment);
    if (specific != null) return specific;
    if (group == 'Cardio') return _cardioSteps(name, equipment);
    if (group == 'Mobilidade') return _mobilitySteps(name, equipment);
    if (group == 'Karate') return _karateSteps(name);
    if (group == 'Jiu-Jitsu') return _jiuJitsuSteps(name);
    if (_has(_n(name), ['curl inverso'])) return _curlInversoSteps(equipment);
    if (_has(_n(name), ['curl cruzado'])) return _crossBodyCurlSteps();
    if (_has(_n(name), ['curl martelo'])) return _hammerCurlSteps(equipment);
    if (_has(_n(name), ['curl zottman'])) return _zottmanSteps(equipment);
    if (_has(_n(name), ['curl no cabo'])) return _cableCurlSteps();
    if (_has(_n(name), ['wrist curl', 'reverse wrist'])) {
      return _forearmGripSteps(name, equipment);
    }
    if (_isCurl(name)) return _curlSteps(name, equipment);
    if (_has(_n(name), ['dead hang escapular', 'scapular pull-up'])) {
      return _scapularHangSteps();
    }
    if (_has(_n(name), ['pull-up', 'chin-up'])) return _pullUpSteps(name);
    if (_isGripOrForearm(name, group)) {
      return _forearmGripSteps(name, equipment);
    }
    // Flexões são peso corporal: ficam antes do ramo de tríceps para nunca
    // receberem instruções com linguagem de carga externa.
    if (_has(_n(name), ['flexao'])) return _pushupSteps(name);
    if (_isTriceps(name)) return _tricepsSteps(name, equipment);
    if (_has(_n(name), [
      'supino',
      'press fechado',
      'chest press',
      'squeeze press',
    ])) {
      return _pressSteps(name, equipment);
    }
    if (_isFly(name)) return _flySteps(name, equipment);
    if (_has(_n(name), ['face pull'])) return _facePullSteps(equipment);
    if (_isRowOrPull(name)) return _rowPullSteps(name, equipment);
    if (_isShoulder(name)) return _shoulderSteps(name, equipment);
    if (_isSquat(name)) return _squatSteps(name, equipment);
    if (_isLunge(name)) return _lungeSteps(name, equipment);
    if (_isHinge(name)) return _hingeSteps(name, equipment);
    if (_has(_n(name), ['gemeos', 'soleo'])) return _calfSteps(name, equipment);
    if (_has(_n(name), ['extensao lombar quadrupede'])) {
      return _quadrupedBackExtensionSteps();
    }
    if (_isCore(name, group)) return _coreSteps(name, equipment);
    return _generalSpecificSteps(name, group, equipment);
  }

  static String? _distinctVariantSteps(String name, String equipment) {
    final n = _n(name);
    if (_has(n, ['press militar com barra em pe'])) {
      return '1. Coloca a barra num suporte à altura da parte alta do peito e usa pega simétrica um pouco além dos ombros. 2. Retira a barra, dá um passo curto e fica com pés paralelos, glúteos firmes e costelas sobre a bacia. 3. Começa com a barra à frente dos ombros, cotovelos ligeiramente à frente da barra e antebraços quase verticais. 4. Afasta ligeiramente a cabeça, empurra a barra para cima e volta a colocar a cabeça entre os braços. 5. Termina com a barra sobre o meio do pé sem arquear a lombar. 6. Baixa pelo mesmo caminho até à frente dos ombros. 7. Inspira antes da subida e expira depois de passar a zona mais difícil. 8. Usa menos carga se inclinares o tronco, dobrares punhos ou perderes equilíbrio.';
    }
    if (_has(n, ['y raise'])) {
      return '1. Fica com o tronco inclinado ou apoia o peito num banco e segura halteres leves com os braços pendurados e polegares para cima. 2. Mantém pescoço longo, costelas controladas e cotovelos quase estendidos. 3. Eleva os braços na diagonal para formar um Y largo acima da cabeça. 4. Inicia pelas escápulas sem encolher os ombros. 5. Pára quando braços e tronco ficam alinhados ou antes de perder a posição. 6. Baixa durante dois a três segundos até os braços ficarem pendurados. 7. Expira ao desenhar o Y e inspira ao baixar. 8. Faz sem carga se sentires o trapézio superior dominar.';
    }
    if (_has(n, ['w raise'])) {
      return '1. Fica com o tronco inclinado ou apoia o peito num banco e segura halteres leves com os cotovelos dobrados junto ao corpo. 2. Vira polegares para cima e mantém punhos sobre a linha dos cotovelos. 3. Aproxima as escápulas e eleva os braços até formarem a letra W. 4. Mantém cotovelos dobrados enquanto rodas os ombros para fora. 5. Pausa sem projetar o queixo nem levantar os ombros. 6. Regressa devagar até aliviar a retração escapular. 7. Expira ao formar o W e inspira no retorno. 8. Reduz carga ou amplitude se sentires pinçamento na frente do ombro.';
    }
    if (_has(n, ['curl 21'])) {
      return '1. Fica alto e segura halteres leves com pega firme, palmas para a frente e cotovelos junto às costelas. 2. Sobe sete vezes apenas da extensão quase completa até os cotovelos chegarem a cerca de 90 graus. 3. Sem descanso, faz sete repetições de 90 graus até perto dos ombros. 4. Mantém punhos direitos e não avances os cotovelos durante as parciais superiores. 5. Termina com sete curls completos do fundo ao topo. 6. Desce cada repetição com controlo e pára se precisares de balançar. 7. Expira em cada subida e inspira em cada descida. 8. Escolhe carga bem menor que no curl normal porque a série soma 21 repetições.';
    }
    return null;
  }

  /// Passos escritos individualmente para exercícios cuja variação não fica
  /// bem explicada pelos moldes de família (ex.: agachamento búlgaro precisa
  /// do pé de trás no banco; curl de perna é máquina de posterior de coxa).
  static String? _specificSteps(String name, String group, String equipment) {
    final n = _n(name);
    if (_has(n, ['prancha lateral'])) {
      return '1. Deita-te de lado com o antebraço no chão e o cotovelo debaixo do ombro. '
          '2. Empilha os pés um sobre o outro, ou cruza-os, e estica as pernas. '
          '3. Eleva a anca até o corpo ficar em linha reta dos pés à cabeça. '
          '4. Contrai o abdómen e o glúteo para a anca não descer nem rodar. '
          '5. Mantém o pescoço comprido, a olhar em frente, e respira curto e contínuo. '
          '6. Aguenta 10 a 40 segundos por lado e desce com controlo. '
          '7. Para facilitar, apoia o joelho de baixo no chão.';
    }
    if (_has(n, ['isometria cervical posterior leve'])) {
      return '1. Senta-te ou fica de pé com a coluna direita e o queixo ligeiramente recolhido. '
          '2. Entrelaça as mãos e coloca-as atrás da cabeça. '
          '3. Empurra a cabeça para trás contra as mãos com força muito leve, sem deixar a cabeça mover. '
          '4. Mantém a pressão 5 a 10 segundos a respirar normalmente. '
          '5. Solta devagar, descansa um momento e repete 3 a 5 vezes. '
          '6. Usa apenas a força que consegues manter sem tremer nem prender o ar.';
    }
    if (_has(n, ['elevacao no plano da omoplata'])) {
      return '1. Fica de pé e segura um halter leve em cada mão ao lado do corpo, com os polegares a apontar para a frente. '
          '2. Roda os braços cerca de 30 graus para a frente do corpo: é este o plano da omoplata. '
          '3. Eleva os dois braços nessa diagonal até à altura dos ombros, com os cotovelos quase esticados. '
          '4. Pausa um segundo em cima sem encolher os ombros. '
          '5. Baixa os halteres em dois a três segundos até ao lado do corpo. '
          '6. Termina a série antes de precisares de balançar o tronco.';
    }
    if (_has(n, ['lenhador no cabo'])) {
      return '1. Coloca a polia do cabo acima da altura do ombro e segura a pega com as duas mãos. '
          '2. Fica de lado para a máquina, pés à largura dos ombros e joelhos ligeiramente fletidos. '
          '3. Puxa a pega em diagonal, de cima para baixo, até à anca contrária, rodando tronco e anca juntos. '
          '4. Mantém os braços quase esticados: a força vem do tronco, não dos ombros. '
          '5. Regressa devagar pelo mesmo caminho, controlando a rotação. '
          '6. Completa as repetições de um lado antes de trocar.';
    }
    if (_has(n, ['prancha com toque no ombro'])) {
      return '1. Começa em prancha alta, mãos debaixo dos ombros e pés um pouco mais afastados que a anca. '
          '2. Contrai abdómen e glúteos antes de mover as mãos. '
          '3. Levanta uma mão e toca no ombro oposto sem deixar a bacia rodar ou balançar. '
          '4. Pousa a mão devagar e repete com a outra, alternando. '
          '5. Faz o movimento lento: um toque a cada um a dois segundos. '
          '6. Termina a série quando a anca começar a rodar apesar do esforço.';
    }
    if (_has(n, ['clamshell'])) {
      return '1. Deita-te de lado com os joelhos dobrados a cerca de 90 graus e os pés alinhados com as costas. '
          '2. Apoia a cabeça no braço de baixo e coloca a mão de cima na bacia para sentires se ela roda. '
          '3. Mantém os pés juntos e abre o joelho de cima como uma concha. '
          '4. Abre só até onde a bacia fica imóvel; deves sentir o lado do glúteo a trabalhar. '
          '5. Fecha devagar, em cerca de dois segundos, sem deixar os joelhos bater. '
          '6. Faz as repetições todas de um lado e depois vira-te para o outro.';
    }
    if (_has(n, ['curl nordico assistido'])) {
      return '1. Ajoelha-te num tapete e prende os calcanhares debaixo de um apoio firme, ou pede a alguém para os segurar. '
          '2. Fica direito dos joelhos à cabeça, com glúteos e abdómen contraídos. '
          '3. Deixa o tronco descer para a frente o mais devagar que conseguires, a travar com a parte de trás das coxas. '
          '4. Quando já não conseguires travar, ampara com as mãos no chão como numa flexão. '
          '5. Empurra com as mãos para voltar ao início e repete. '
          '6. Começa com 3 a 5 repetições; é normal descer pouco nas primeiras semanas.';
    }
    if (_has(n, ['peso morto unilateral com halteres'])) {
      return '1. Fica de pé sobre uma perna e segura o halter na mão do lado contrário, à frente da coxa. '
          '2. Mantém o joelho de apoio ligeiramente fletido e fixa o olhar num ponto no chão. '
          '3. Dobra pela anca e deixa o halter descer rente à perna enquanto a perna livre estica para trás. '
          '4. Desce até sentires alongar a parte de trás da coxa, com as costas direitas e a bacia nivelada. '
          '5. Empurra o chão com o pé de apoio e volta a ficar direito, apertando o glúteo no topo. '
          '6. Faz todas as repetições de um lado antes de trocar de perna e de mão.';
    }
    if (_has(n, ['remo ergometro ritmo continuo'])) {
      return '1. Ajusta o apoio dos pés e prende as tiras sobre o meio do peito do pé. '
          '2. Segura a pega com as duas mãos, braços esticados, costas direitas e lombar neutra. '
          '3. Empurra primeiro com as pernas, inclina o tronco ligeiramente atrás e puxa a pega até às costelas, com os cotovelos rentes e as escápulas a fechar. '
          '4. Regressa pela ordem inversa: braços esticam, tronco vai à frente, joelhos dobram. '
          '5. Mantém um ritmo confortável, em que consegues falar, durante 10 a 20 minutos. '
          '6. Termina com 2 a 3 minutos mais lentos para arrefecer.';
    }
    if (_has(n, ['remo ergometro intervalos'])) {
      return '1. Faz 3 a 5 minutos de remadas leves para aquecer, sempre na ordem pernas, tronco e braços, com a lombar neutra. '
          '2. Rema forte durante 30 a 60 segundos, a puxar a pega até às costelas com os cotovelos rentes ao tronco. '
          '3. Recupera 60 a 90 segundos a remar muito leve, num ritmo de recuperação. '
          '4. Repete o ciclo 4 a 8 vezes conforme o teu nível. '
          '5. Se as costas curvarem ou as escápulas encolherem, encurta o bloco forte em vez de continuares. '
          '6. Termina com 2 a 3 minutos leves.';
    }
    if (_has(n, ['stepper escadas ritmo continuo'])) {
      return '1. Sobe para o stepper e segura levemente os apoios, só para equilibrar. '
          '2. Coloca o pé inteiro em cada degrau, não só a ponta. '
          '3. Sobe a ritmo constante, empurrando com o calcanhar e o glúteo. '
          '4. Mantém o tronco direito, sem pendurares o corpo nos braços. '
          '5. Continua 10 a 20 minutos a um ritmo em que consegues falar. '
          '6. Abranda gradualmente nos últimos 2 minutos.';
    }
    if (_has(n, ['stepper escadas intervalos'])) {
      return '1. Aquece 3 a 5 minutos a ritmo lento no stepper. '
          '2. Sobe rápido durante 30 a 60 segundos, sem saltar degraus nem te pendurares nos apoios. '
          '3. Recupera 60 a 90 segundos a ritmo lento. '
          '4. Repete 4 a 8 ciclos conforme o fôlego. '
          '5. Coloca sempre o pé inteiro no degrau, mesmo nos blocos rápidos. '
          '6. Termina com 2 a 3 minutos lentos.';
    }
    if (_has(n, ['subida de escadas no exterior'])) {
      return '1. Escolhe escadas com corrimão e piso seguro. '
          '2. Sobe a passo firme e ritmo constante, apoiando o pé inteiro em cada degrau. '
          '3. Usa o corrimão apenas para equilibrar, não para puxar o corpo. '
          '4. Desce devagar: a descida é a tua recuperação. '
          '5. Repete subidas de 30 segundos a 2 minutos até somares 10 a 20 minutos. '
          '6. Pára se o passo começar a falhar ou os joelhos a ceder.';
    }
    if (_has(n, ['air bike ritmo continuo'])) {
      return '1. Ajusta o selim para o joelho ficar ligeiramente fletido com o pedal em baixo. '
          '2. Pedala enquanto empurras e puxas o guiador ao ritmo das pernas. '
          '3. Mantém um ritmo constante, em que consegues falar, durante 10 a 20 minutos. '
          '4. Mantém o tronco estável; quem trabalha são os braços e as pernas. '
          '5. Não deixes os joelhos abrir para fora enquanto pedalas. '
          '6. Abranda gradualmente nos últimos 2 minutos.';
    }
    if (_has(n, ['air bike intervalos'])) {
      return '1. Aquece 3 a 5 minutos a ritmo leve na air bike. '
          '2. Faz 15 a 30 segundos fortes, a empurrar o guiador e a pedalar com intenção. '
          '3. Recupera 60 a 90 segundos muito leve, sem parar de mexer. '
          '4. Repete 4 a 8 ciclos; a air bike é exigente, começa por menos. '
          '5. Mantém o tronco firme mesmo nos blocos fortes. '
          '6. Termina com 2 a 3 minutos leves.';
    }
    if (_has(n, ['shadow boxing leve'])) {
      return '1. Fica em guarda: pé mais fraco à frente, mãos junto ao queixo, cotovelos fechados. '
          '2. Desloca-te devagar em passos curtos, sem cruzar os pés. '
          '3. Lança socos leves e soltos, voltando sempre com a mão à guarda. '
          '4. Roda ligeiramente a anca em cada soco em vez de esticares só o braço. '
          '5. Trabalha blocos de 1 a 2 minutos a ritmo leve, com 30 a 60 segundos de pausa, num total de 10 a 15 minutos. '
          '6. Mantém os socos leves: o objetivo é fôlego e coordenação, não força.';
    }
    if (_has(n, ['shuttle runs corrida vaivem'])) {
      return '1. Marca duas linhas afastadas 5 a 10 metros num piso que não escorregue. '
          '2. Aquece 3 a 5 minutos com corrida leve e mobilidade de anca. '
          '3. Corre com velocidade controlada de uma marca à outra, trava, toca na linha com a mão e volta. '
          '4. Baixa a anca e dá passos curtos ao travar, para protegeres os joelhos. '
          '5. Faz séries de 20 a 40 segundos com pausas de 60 a 90 segundos, 4 a 8 séries. '
          '6. Encurta a distância se a travagem começar a falhar.';
    }
    if (_has(n, ['treino de bases dachi'])) {
      return '1. Desce para zenkutsu-dachi: perna da frente dobrada, perna de trás esticada, tronco vertical. '
          '2. Segura a posição 10 a 20 segundos com o joelho da frente alinhado com o pé. '
          '3. Passa devagar para kiba-dachi: pés largos e paralelos, joelhos abertos, bacia baixa. '
          '4. Passa para kokutsu-dachi: peso atrás, pé da frente leve no chão. '
          '5. Alterna as três bases mantendo a bacia sempre à mesma altura. '
          '6. Faz 5 a 10 transições lentas por série; o objetivo é manter a bacia à mesma altura, com controlo total.';
    }
    if (_has(n, ['bloqueios tecnicos uke'])) {
      return '1. Fica numa base estável com um punho na anca e o outro braço à frente do corpo. '
          '2. Faz age-uke: o antebraço sobe em diagonal até acima da testa enquanto o punho contrário recolhe à anca. '
          '3. Faz soto-uke: o antebraço varre de fora para dentro até à linha do peito. '
          '4. Faz gedan-barai: o antebraço varre para baixo, protegendo o abdómen e a perna da frente. '
          '5. Coordena sempre a recolha forte do braço contrário: é ela que dá potência ao bloqueio. '
          '6. Repete cada bloqueio 8 a 12 vezes de cada lado; o objetivo é precisão com controlo, primeiro devagar e depois com ritmo.';
    }
    if (_has(n, ['esquivas e tai sabaki'])) {
      return '1. Começa em guarda, numa base estável, com os joelhos ligeiramente fletidos. '
          '2. Treina o recuo: desliza o pé de trás e afasta o tronco sem baixar as mãos. '
          '3. Treina a saída lateral: passo curto para o lado e roda a anca para ficares em ângulo. '
          '4. Treina o tai-sabaki: gira sobre a planta dos pés levando todo o corpo para fora da linha de ataque. '
          '5. Mantém a cabeça sempre ao mesmo nível; esquivar não é saltar nem baixar o olhar. '
          '6. Encadeia 8 a 12 esquivas de cada tipo; o objetivo é sair da linha com controlo, imaginando o ataque a que respondes.';
    }
    if (_has(n, ['joelhadas tecnicas'])) {
      return '1. Fica em guarda, com uma base firme e o peso ligeiramente na perna da frente. '
          '2. Puxa as mãos para baixo, como se controlasses o alvo à frente do peito. '
          '3. Sobe o joelho de trás em linha reta ao alvo, com a anca a avançar no final. '
          '4. Mantém o pé de apoio firme e o tronco ligeiramente atrás para equilibrar. '
          '5. Regressa à guarda pelo mesmo caminho, sem deixar o pé cair pesado. '
          '6. Faz 8 a 12 joelhadas por perna; o objetivo é subir o joelho com controlo, primeiro devagar e depois com ritmo.';
    }
    if (_has(n, ['trabalho leve ao saco'])) {
      return '1. Fica em guarda, numa base estável, à distância a que o teu braço esticado toca no saco. '
          '2. Começa com socos diretos leves, tocando no saco com os dois primeiros nós dos dedos. '
          '3. Mantém o punho fechado e alinhado com o antebraço no contacto; se o punho dobrar, bate mais leve. '
          '4. Acrescenta pontapés leves com a canela ou o peito do pé, voltando sempre à guarda. '
          '5. Trabalha rondas de 1 a 2 minutos com 1 minuto de pausa, 4 a 6 rondas. '
          '6. É trabalho técnico: o objetivo é precisão e distância com controlo, não força máxima.';
    }
    if (_has(n, ['rolamentos de solo'])) {
      return '1. Agacha-te no tatami, numa base compacta, com o queixo preso ao peito. '
          '2. Coloca as mãos no chão e empurra com as pernas, rolando sobre um ombro, nunca sobre a cabeça. '
          '3. Deixa as costas redondas passarem na diagonal, do ombro até à anca contrária. '
          '4. Termina agachado, pronto a levantar sem usar as mãos. '
          '5. Para o rolamento atrás, senta-te, rola para trás sobre o mesmo ombro e volta à posição agachada. '
          '6. Faz 4 a 6 rolamentos para cada lado, devagar e em piso acolchoado; o objetivo é um caminho redondo e sem impacto.';
    }
    if (_has(n, ['breakfalls ukemi'])) {
      return '1. Começa deitado de costas com o queixo preso ao peito, para aprenderes a posição final. '
          '2. Bate com as palmas e os antebraços no tatami, com os braços a cerca de 45 graus do corpo. '
          '3. Passa a treinar de cócoras: deixa-te cair para trás e bate com os braços no chão no momento do impacto. '
          '4. Para a queda lateral, desliza uma perna e cai sobre o lado, batendo com o braço desse lado. '
          '5. Nunca aterres sobre o cotovelo nem deixes a cabeça tocar no tatami. '
          '6. Faz 5 a 10 quedas de cada tipo e sobe a altura só quando dominares; o objetivo técnico é proteger sempre a cabeça.';
    }
    if (_has(n, ['inversao granby com apoio'])) {
      return '1. Começa de joelhos com as mãos no tatami e o queixo preso ao peito. '
          '2. Apoia o peso nos ombros e nas mãos, nunca no topo da cabeça. '
          '3. Rola sobre a linha dos ombros levando as pernas por cima do corpo para um dos lados. '
          '4. Usa as mãos no chão para travar e guiar a rotação. '
          '5. Termina sentado ou de joelhos, virado para o lado contrário. '
          '6. Faz 3 a 5 inversões para cada lado, muito devagar; o objetivo técnico é rodar sobre os ombros, e pára se o pescoço carregar peso.';
    }
    if (_has(n, ['alongamento pnf de isquiotibiais'])) {
      return '1. Deita-te de costas e eleva uma perna quase esticada, segurando atrás da coxa com as mãos ou com uma toalha. '
          '2. Puxa suavemente até sentires alongar a parte de trás da coxa e mantém 10 segundos. '
          '3. Empurra a perna contra as mãos, como se a quisesses baixar, com força moderada durante 5 a 6 segundos. '
          '4. Solta a contração, expira e puxa a perna um pouco mais perto de ti. '
          '5. Repete o ciclo contrai-relaxa 2 a 3 vezes por perna. '
          '6. Mantém a outra perna e a lombar em contacto com o chão todo o tempo.';
    }
    if (_has(n, ['alongamento pnf de peitoral na parede'])) {
      return '1. Coloca o antebraço na parede com o cotovelo à altura do ombro. '
          '2. Roda o tronco para o lado contrário até sentires alongar o peito e mantém 10 segundos. '
          '3. Empurra o antebraço contra a parede com força moderada durante 5 a 6 segundos, sem mover o corpo. '
          '4. Solta, expira e roda o tronco um pouco mais. '
          '5. Repete o ciclo 2 a 3 vezes e troca de braço. '
          '6. Mantém os ombros afastados das orelhas durante todo o alongamento.';
    }
    if (_has(n, ['alongamento de flexores da anca em afundo'])) {
      return '1. Ajoelha-te sobre um tapete com um joelho no chão e o outro pé à frente, em afundo. '
          '2. Aperta o glúteo da perna de trás e encolhe ligeiramente a barriga. '
          '3. Leva a bacia para a frente sem deixares a lombar arquear. '
          '4. Sente o alongamento na frente da anca e da coxa da perna de trás. '
          '5. Mantém 20 a 40 segundos a respirar devagar e troca de lado. '
          '6. Para aumentar, eleva o braço do lado do joelho apoiado em direção ao teto.';
    }
    if (_has(n, ['alongamento borboleta de adutores'])) {
      return '1. Senta-te no chão com as plantas dos pés unidas e os calcanhares perto da bacia. '
          '2. Segura os pés com as mãos e cresce com a coluna. '
          '3. Deixa os joelhos descer para os lados apenas com o peso das pernas. '
          '4. Para aprofundar, inclina o tronco à frente a partir da anca, sem curvares as costas. '
          '5. Mantém 20 a 40 segundos a respirar devagar. '
          '6. Não empurres os joelhos para baixo com as mãos; deixa o peso fazer o trabalho.';
    }
    if (_has(n, ['alongamento dinamico global'])) {
      return '1. Começa de pé, dá um passo largo à frente e desce em afundo, com as mãos no chão por dentro do pé da frente. '
          '2. Empurra o joelho da frente ligeiramente para fora com o cotovelo. '
          '3. Roda o tronco e estica o braço do lado da perna da frente em direção ao teto, seguindo a mão com o olhar. '
          '4. Volta com a mão ao chão, estica a perna da frente e puxa a ponta do pé para ti. '
          '5. Regressa ao afundo e troca de perna. '
          '6. Faz 4 a 6 repetições lentas por lado, a respirar devagar, como aquecimento.';
    }
    if (_has(n, ['alongamento de triceps atras da cabeca'])) {
      return '1. De pé ou sentado, sobe um braço e dobra o cotovelo, deixando a mão cair atrás da cabeça. '
          '2. Com a outra mão, segura o cotovelo por cima da cabeça. '
          '3. Puxa suavemente o cotovelo para trás e para o centro até sentires alongar a parte de trás do braço. '
          '4. Mantém a cabeça direita; não deixes o pescoço ir à frente. '
          '5. Segura 20 a 30 segundos a respirar devagar e troca de braço. '
          '6. Para aprofundar, inclina ligeiramente o tronco para o lado contrário.';
    }
    if (_has(n, ['cobra suave no chao'])) {
      return '1. Deita-te de barriga para baixo, pernas relaxadas e testa no chão. '
          '2. Apoia os antebraços no chão com os cotovelos debaixo dos ombros. '
          '3. Empurra o chão e levanta o peito devagar, deixando a bacia apoiada. '
          '4. Mantém os glúteos descontraídos e o pescoço comprido, com o olhar em frente. '
          '5. Segura 10 a 20 segundos a respirar devagar e desce com controlo. '
          '6. Se sentires aperto na lombar, sobe menos ou leva os cotovelos mais à frente.';
    }
    if (_has(n, ['respiracao nasal lenta'])) {
      return '1. Senta-te ou deita-te confortável com uma mão na barriga. '
          '2. Fecha a boca e inspira pelo nariz durante cerca de 4 segundos, deixando a barriga crescer. '
          '3. Expira pelo nariz durante 6 a 8 segundos, mais longo do que inspiraste, deixando a barriga descer. '
          '4. Faz uma pausa natural de 1 a 2 segundos antes da próxima inspiração. '
          '5. Continua 3 a 5 minutos, mantendo os ombros descontraídos. '
          '6. Se faltar o ar, encurta os tempos: o ritmo deve ser confortável.';
    }
    if (_has(n, ['foam roller para pernas'])) {
      return '1. Senta-te no chão e coloca o rolo debaixo dos gémeos. '
          '2. Com as mãos atrás a apoiar, rola devagar, subindo e descendo do tornozelo ao joelho, durante 30 a 60 segundos. '
          '3. Passa para a parte de trás das coxas e depois vira-te de barriga para baixo para os quadríceps. '
          '4. Quando encontrares um ponto sensível, pára em cima 10 a 20 segundos a respirar devagar. '
          '5. Evita rolar diretamente sobre o joelho e sobre zonas com dor aguda. '
          '6. Termina quando a zona estiver mais solta; a pressão deve ser desconfortável mas suportável, usando os braços para aliviar peso.';
    }
    if (_has(n, ['foam roller para costas'])) {
      return '1. Deita-te de costas com o rolo atravessado debaixo das omoplatas e os joelhos dobrados. '
          '2. Cruza os braços sobre o peito para afastares as omoplatas. '
          '3. Levanta a bacia do chão e rola devagar entre a base do pescoço e o meio das costas. '
          '4. Pára 10 a 20 segundos nas zonas mais tensas, a respirar devagar. '
          '5. Não roles a lombar nem o pescoço com o rolo. '
          '6. Fica 1 a 2 minutos no total e levanta-te devagar.';
    }
    if (_has(n, ['bola de massagem para pes e gluteos'])) {
      return '1. De pé, com uma mão apoiada na parede, coloca a bola debaixo da planta do pé. '
          '2. Rola devagar do calcanhar aos dedos, empurrando com o peso do corpo, durante 30 a 60 segundos. '
          '3. Pára 10 a 20 segundos nos pontos mais sensíveis. '
          '4. Para o glúteo, senta-te no chão com a bola debaixo de uma nádega e as mãos atrás a apoiar. '
          '5. Rola devagar em pequenos círculos e evita pressionar zonas com formigueiro ou dormência. '
          '6. Troca de lado quando a zona se sentir mais solta.';
    }
    if (_has(n, ['arrefecimento pos treino de forca'])) {
      return '1. Começa por caminhar 3 a 5 minutos a passo lento até o coração acalmar. '
          '2. Faz 5 respirações lentas: inspira pelo nariz e expira comprido pela boca. '
          '3. Alonga suavemente os músculos que treinaste, 20 a 30 segundos por zona, sem dor. '
          '4. Se o treino foi de corpo inteiro, inclui pelo menos peito, costas, anca e pernas. '
          '5. Solta os ombros e o pescoço com círculos lentos. '
          '6. Termina quando a respiração estiver de novo normal.';
    }
    if (_has(n, ['arrefecimento pos artes marciais'])) {
      return '1. Caminha em marcha lenta 2 a 3 minutos a soltar os braços. '
          '2. Faz círculos lentos de ombros, anca e pescoço. '
          '3. Alonga a anca em afundo suave, 20 a 30 segundos por lado. '
          '4. Alonga a parte de trás das coxas e os adutores sentado, sem forçar. '
          '5. Termina com 5 respirações nasais lentas, com a expiração comprida. '
          '6. Aproveita para notar zonas doridas: são as primeiras a cuidar no próximo treino.';
    }
    if (_has(n, ['aquecimento dinamico geral'])) {
      return '1. Marcha no lugar ou caminha 2 minutos para começares a aquecer. '
          '2. Faz 10 círculos de ombros para trás e 10 para a frente. '
          '3. Faz 10 círculos de anca para cada lado e 10 balanços de perna controlados por perna. '
          '4. Faz 10 agachamentos leves sem carga e 10 afundos curtos alternados. '
          '5. Termina com 20 a 30 segundos de polichinelos ou marcha rápida para elevar o pulso. '
          '6. Ajusta o volume: deves acabar quente e pronto para treinar, não cansado.';
    }
    if (_has(n, ['dips para peito em paralelas'])) {
      return '1. Sobe para as paralelas com uma mão em cada pega e os braços esticados. '
          '2. Inclina o tronco ligeiramente à frente e dobra os joelhos atrás do corpo. '
          '3. Desce dobrando os cotovelos até sentires alongamento no peito, sem dor no ombro. '
          '4. Empurra as barras para baixo com as mãos e sobe até quase estender os braços. '
          '5. Mantém os ombros afastados das orelhas durante todo o movimento. '
          '6. Inspira ao descer e expira ao empurrar.';
    }
    if (_has(n, ['dips assistidos para peito'])) {
      return '1. Ajusta a assistência da máquina para conseguires controlar a descida e a subida. '
          '2. Apoia os joelhos ou os pés na plataforma e segura as pegas com punhos firmes. '
          '3. Inclina o tronco ligeiramente à frente e baixa os ombros. '
          '4. Desce dobrando os cotovelos até um alongamento confortável no peito. '
          '5. Empurra as pegas e sobe até quase estender os braços, sem encolher os ombros. '
          '6. Inspira ao descer e expira ao empurrar. '
          '7. Reduz a assistência apenas quando o movimento ficar estável.';
    }
    if (_has(n, ['remo baixo no cabo'])) {
      return '1. Senta-te na polia baixa com os pés nos apoios e os joelhos ligeiramente dobrados. '
          '2. Agarra a pega com as duas mãos e endireita o tronco, com o peito aberto. '
          '3. Antes de puxar, baixa os ombros e sente as escápulas prontas a mexer. '
          '4. Puxa a pega até à cintura, levando os cotovelos para trás junto ao corpo. '
          '5. Junta as escápulas por um segundo, sem inclinar o tronco para trás. '
          '6. Deixa a pega voltar devagar à frente, mantendo o cabo em tensão e a lombar direita. '
          '7. Expira ao puxar e inspira ao voltar.';
    }
    if (_has(n, ['aperto isometrico'])) {
      return '1. Segura um halter em posição vertical pela cabeça, uma bola firme ou a pega de um grip trainer. '
          '2. Fica com o braço ao lado do corpo ou com o cotovelo dobrado a 90 graus, punho direito. '
          '3. Aperta a mão com força quase máxima, como se quisesses deixar marca nos dedos. '
          '4. Mantém o aperto durante 10 a 20 segundos sem dobrar o punho nem encolher o ombro. '
          '5. Solta devagar e abre bem os dedos durante alguns segundos. '
          '6. Troca de mão e repete. '
          '7. Respira de forma contínua durante o aperto, sem prender o ar.';
    }
    if (_has(n, ['alongamento posterior do ombro'])) {
      return '1. Fica de pé ou sentado com o tronco direito. '
          '2. Leva um braço esticado à frente do peito, na horizontal, em direção ao ombro contrário. '
          '3. Com a outra mão, puxa suavemente o braço contra o peito, segurando acima do cotovelo. '
          '4. Mantém o ombro do braço alongado baixo, longe da orelha. '
          '5. Segura 20 a 30 segundos, respirando devagar, sentindo a parte de trás do ombro. '
          '6. Solta devagar e troca de lado. '
          '7. Não rodes o tronco para aumentar o alcance à força.';
    }
    if (_has(n, ['respiracao diafragmatica'])) {
      return '1. Deita-te de costas com os joelhos dobrados, ou senta-te com as costas apoiadas. '
          '2. Pousa uma mão no peito e a outra na barriga. '
          '3. Inspira devagar pelo nariz, deixando a barriga empurrar a mão para cima; o peito quase não mexe. '
          '4. Expira lentamente pela boca, deixando a barriga descer, mais tempo a expirar do que a inspirar. '
          '5. Mantém os ombros e o maxilar relaxados. '
          '6. Repete durante 1 a 3 minutos, a um ritmo calmo. '
          '7. Se sentires tontura, volta ao teu ritmo natural de respiração.';
    }
    if (n == 'caminhada leve') {
      return '1. Escolhe um percurso plano e seguro e começa a caminhar devagar. '
          '2. Caminha a um ritmo tranquilo, em que consegues conversar sem esforço. '
          '3. Mantém o tronco alto, a respiração tranquila e os braços a balançar naturalmente. '
          '4. Pousa o pé do calcanhar para a ponta, com passos confortáveis. '
          '5. Continua durante 10 a 30 minutos, conforme a energia do dia. '
          '6. Termina de forma gradual, abrandando nos últimos minutos. '
          '7. Respira com calma e aproveita para relaxar os ombros.';
    }
    if (_has(n, ['relaxamento deitado'])) {
      return '1. Deita-te de costas num tapete, com as pernas estendidas ou os joelhos apoiados numa almofada. '
          '2. Deixa os braços descansar ao lado do corpo, com as palmas para cima. '
          '3. Fecha os olhos e respira devagar pelo nariz. '
          '4. Percorre o corpo mentalmente, relaxando maxilar, ombros, mãos, barriga e pernas. '
          '5. Fica na posição 2 a 5 minutos, sem pressa. '
          '6. Para sair, rola para o lado e levanta-te devagar. '
          '7. Usa esta posição no fim do treino ou em dias de recuperação.';
    }
    if (_has(n, ['rotacao toracica no chao'])) {
      return '1. Deita-te de lado com os joelhos dobrados a 90 graus e os braços esticados à frente, mãos juntas. '
          '2. Mantém os joelhos colados um ao outro e no chão durante todo o movimento. '
          '3. Abre o braço de cima em arco por cima do corpo, rodando o tronco para o outro lado. '
          '4. Segue a mão com o olhar, expira ao abrir e deixa o peito abrir para o teto. '
          '5. Vai só até onde os joelhos ficam quietos e não há dor. '
          '6. Regressa pelo mesmo arco devagar e repete 6 a 8 vezes antes de trocar de lado. '
          '7. Expira ao abrir o braço e inspira no regresso.';
    }
    if (_has(n, ['cat-cow'])) {
      return '1. Coloca-te em quatro apoios, com os punhos por baixo dos ombros e os joelhos por baixo da anca. '
          '2. Ao inspirar, deixa a barriga descer, abre o peito e olha ligeiramente para cima. '
          '3. Ao expirar, empurra o chão, arredonda as costas para o teto e deixa a cabeça descair. '
          '4. Alterna entre as duas posições devagar, ao ritmo da respiração. '
          '5. Move a coluna toda, do fundo das costas ao pescoço, sem forçar nenhum ponto. '
          '6. Faz 6 a 10 ciclos completos. '
          '7. Para se sentires dor aguda em algum segmento da coluna.';
    }
    if (_has(n, ['open book'])) {
      return '1. Deita-te de lado com os joelhos dobrados à frente da anca e os braços esticados à frente, mãos juntas. '
          '2. Mantém os joelhos no chão, um em cima do outro, durante todo o exercício. '
          '3. Abre o braço de cima como a capa de um livro, rodando o tronco para trás. '
          '4. Segue a mão com o olhar até onde for confortável. '
          '5. Segura dois a três segundos na posição aberta, respirando devagar. '
          '6. Fecha o livro devagar, voltando a juntar as mãos. '
          '7. Faz 6 a 8 repetições e troca de lado.';
    }
    if (_has(n, ['flexao diamante'])) {
      return '1. Coloca-te em prancha, com o corpo alinhado da cabeça aos pés e os pés juntos ou pouco afastados. '
          '2. Junta as mãos debaixo do peito, formando um diamante com os polegares e os indicadores. '
          '3. Mantém os cotovelos próximos do tronco e o abdómen ativo. '
          '4. Desce o corpo de forma controlada até o peito se aproximar das mãos. '
          '5. Empurra o chão até voltares à posição inicial, sem deixar a lombar cair. '
          '6. Inspira ao descer e expira ao empurrar o chão.';
    }
    if (_has(n, ['curl arrastado'])) {
      return '1. Fica de pé e segura um halter em cada mão à frente das coxas, com pega firme e palmas para a frente. '
          '2. Mantém o tronco direito, os ombros relaxados e o abdómen levemente ativo. '
          '3. Sobe os halteres colados ao tronco, deixando os cotovelos recuar, como se arrastasses o peso pelo corpo. '
          '4. Para quando os halteres chegarem à base do peito, com os cotovelos atrás da linha do tronco. '
          '5. Sente o bíceps a contrair no topo, sem encolher os ombros nem balançar o corpo. '
          '6. Desce os halteres devagar pelo mesmo caminho, junto ao tronco. '
          '7. Expira ao subir e inspira ao descer.';
    }
    if (_has(n, ['tate press'])) {
      return '1. Deita-te num banco ou no chão e segura um halter em cada mão, braços esticados por cima do peito. '
          '2. Vira as palmas para a frente, na direção dos pés, e mantém os punhos firmes. '
          '3. Dobra os cotovelos para fora, deixando-os abertos ao lado, e desce os halteres em direção ao meio do peito. '
          '4. Para com as pontas dos halteres quase a tocar no peito, sem apoiar. '
          '5. Estende os cotovelos para empurrar os halteres de volta ao topo, mantendo os ombros quietos. '
          '6. Não transformes o movimento num supino: só os cotovelos dobram e esticam. '
          '7. Inspira ao descer e expira ao estender.';
    }
    // Pernas — agachamentos e variações.
    if (_has(n, ['agachamento bulgaro'])) {
      final support = _has(n, ['com apoio'])
          ? '3. Fica ao lado de uma parede ou apoio estável e pousa lá uma mão para equilibrar. '
          : '3. Cruza os braços à frente do peito ou deixa-os ao lado do corpo para equilibrar. ';
      return '1. Coloca um banco ou cadeira estável atrás de ti e fica de costas para ele, a cerca de um passo grande de distância. '
          '2. Apoia o peito do pé de trás em cima do banco, com o pé da frente inteiro no chão. '
          '$support'
          '4. Mantém o tronco direito, o abdómen ativo e a anca virada para a frente. '
          '5. Desce dobrando o joelho da perna da frente, como um agachamento só com essa perna. '
          '6. Mantém o joelho da frente alinhado com o pé, sem cair para dentro. '
          '7. Desce até onde controlas o equilíbrio, sem bater com o joelho de trás no chão. '
          '8. Empurra o chão com o pé da frente para subir. '
          '9. Inspira ao descer e expira ao subir. '
          '10. Completa as repetições de um lado antes de trocar de perna.';
    }
    if (_has(n, ['agachamento sumo'])) {
      return '1. Fica de pé com os pés bem mais afastados que a largura dos ombros. '
          '2. Aponta as pontas dos pés para fora, num ângulo confortável de 30 a 45 graus. '
          '3. Mantém o tronco direito, o peito aberto e o abdómen ligeiramente ativo. '
          '4. Desce dobrando os joelhos e levando a anca para baixo e para trás. '
          '5. Empurra os joelhos para fora, na direção das pontas dos pés, durante toda a descida. '
          '6. Desce até onde consegues manter os calcanhares no chão e as costas direitas. '
          '7. Sente a parte interna das coxas e os glúteos a alongar na descida. '
          '8. Sobe empurrando o chão com os pés inteiros e apertando os glúteos. '
          '9. Inspira ao descer e expira ao subir.';
    }
    if (_has(n, ['agachamento goblet'])) {
      return '1. Segura um halter na vertical junto ao peito, com as duas mãos por baixo da cabeça de cima, como se fosse uma taça. '
          '2. Fica de pé com os pés à largura dos ombros e as pontas ligeiramente para fora. '
          '3. Mantém os cotovelos apontados para baixo e o halter sempre colado ao peito. '
          '4. Desce dobrando joelhos e anca, como se fosses sentar. '
          '5. Deixa os cotovelos passar por dentro dos joelhos na parte baixa. '
          '6. Mantém o tronco direito e os calcanhares no chão. '
          '7. Sobe empurrando o chão e estendendo anca e joelhos. '
          '8. Inspira ao descer e expira ao subir. '
          '9. Escolhe uma pega firme para o halter não escorregar do peito.';
    }
    if (_has(n, ['agachamento na maquina smith'])) {
      return '1. Ajusta a barra da máquina Smith à altura dos ombros e coloca as travas de segurança um pouco abaixo da posição final da descida. '
          '2. Entra por baixo da barra e apoia-a na parte de cima das costas, nunca no pescoço. '
          '3. Segura a barra com pega simétrica e roda-a para destravar. '
          '4. Coloca os pés à largura dos ombros, ligeiramente à frente da linha da barra. '
          '5. Mantém o tronco firme e o abdómen ativo, deixando a máquina guiar a trajetória vertical. '
          '6. Desce dobrando joelhos e anca até onde manténs os calcanhares apoiados e a lombar neutra. '
          '7. Sobe empurrando o chão com os pés inteiros. '
          '8. Inspira ao descer e expira ao subir. '
          '9. No fim, roda a barra para a travar de novo no suporte antes de sair.';
    }
    if (_has(n, ['agachamento para cadeira'])) {
      return '1. Coloca uma cadeira estável atrás de ti, com o assento virado para as tuas pernas. '
          '2. Fica de pé com os pés à largura dos ombros e os dedos ligeiramente para fora. '
          '3. Mantém o peito aberto, o tronco direito e o abdómen ativo. '
          '4. Desce levando a anca para trás e dobrando os joelhos, como se fosses sentar-te. '
          '5. Toca levemente com os glúteos no assento sem descarregar todo o peso. '
          '6. Mantém os joelhos alinhados com os pés e os calcanhares no chão. '
          '7. Sobe empurrando o chão com os pés, sem impulso do tronco. '
          '8. Inspira ao descer e expira ao subir. '
          '9. Se precisares de mais confiança, senta-te por completo e levanta-te sem usar as mãos.';
    }
    if (_has(n, ['wall sit'])) {
      return '1. Encosta as costas inteiras a uma parede lisa e dá um ou dois passos com os pés para a frente. '
          '2. Desliza o tronco pela parede até os joelhos ficarem dobrados perto de 90 graus. '
          '3. Mantém os pés à largura da anca, apontados para a frente, e os joelhos alinhados com os pés. '
          '4. Mantém a lombar e as omoplatas em contacto com a parede. '
          '5. Apoia as mãos nas coxas ou deixa os braços ao lado, sem empurrar os joelhos. '
          '6. Aguenta a posição parado, sem subir nem descer, durante 15 a 45 segundos. '
          '7. Respira de forma contínua, sem prender o ar. '
          '8. Para subir, empurra o chão com os pés e desliza o tronco pela parede para cima. '
          '9. Termina se os joelhos começarem a tremer para dentro ou se perderes o apoio das costas.';
    }
    if (_has(n, ['step-up'])) {
      return '1. Coloca-te de frente para um degrau, caixa ou banco estável, à altura do joelho ou abaixo. '
          '2. Apoia o pé inteiro de uma perna em cima do apoio. '
          '3. Mantém o tronco direito e o abdómen ativo. '
          '4. Empurra o apoio com o pé de cima e sobe até estender a perna, sem dar impulso com a perna de baixo. '
          '5. Mantém o joelho da perna que trabalha alinhado com o pé. '
          '6. Toca com o pé livre em cima ou mantém-no no ar por um instante. '
          '7. Desce devagar pelo mesmo caminho, controlando a perna de apoio. '
          '8. Expira ao subir e inspira ao descer. '
          '9. Completa as repetições de uma perna antes de trocar, ou alterna com controlo. '
          '10. Usa a anca e o glúteo para travar a descida, sem deixar o corpo cair.';
    }
    if (_has(n, ['extensao de perna'])) {
      return '1. Senta-te na máquina de extensão de perna e encosta bem as costas no apoio. '
          '2. Ajusta o encosto para os joelhos ficarem alinhados com o eixo de rotação da máquina. '
          '3. Coloca o rolo acolchoado sobre a parte da frente dos tornozelos. '
          '4. Segura as pegas laterais para estabilizar o tronco. '
          '5. Estende os joelhos devagar, levantando o rolo até as pernas ficarem quase direitas. '
          '6. Faz uma pausa curta no topo, contraindo a frente das coxas. '
          '7. Desce o rolo em dois a três segundos, sem deixar as placas bater. '
          '8. Expira ao estender e inspira ao descer. '
          '9. Não arranques com impulso da anca nem levantes os glúteos do assento.';
    }
    if (_has(n, ['leg press'])) {
      return '1. Senta-te na máquina de leg press com as costas e a cabeça bem apoiadas no encosto. '
          '2. Coloca os pés na plataforma à largura dos ombros, com os pés inteiros apoiados. '
          '3. Ajusta o assento para os joelhos começarem dobrados perto de 90 graus. '
          '4. Segura as pegas laterais para manter o tronco estável. '
          '5. Empurra a plataforma estendendo joelhos e anca, sem bloquear os joelhos com força no fim. '
          '6. Solta as travas de segurança apenas quando já estiveres a suster a carga. '
          '7. Desce a plataforma devagar, dobrando os joelhos na direção do peito até onde a lombar se mantém apoiada. '
          '8. Não deixes a anca ou a lombar descolar do assento na parte baixa. '
          '9. Inspira ao descer e expira ao empurrar. '
          '10. No fim, trava a plataforma antes de tirar os pés.';
    }
    if (_has(n, ['curl de perna'])) {
      return '1. Ajusta a máquina de curl de perna para os joelhos ficarem alinhados com o eixo de rotação. '
          '2. Deita-te ou senta-te conforme a máquina, com o rolo acolchoado atrás dos tornozelos. '
          '3. Segura as pegas e mantém a anca colada ao apoio. '
          '4. Dobra os joelhos puxando os calcanhares na direção dos glúteos. '
          '5. Faz uma pausa curta no ponto de maior flexão, sentindo a parte de trás das coxas. '
          '6. Regressa em dois a três segundos até as pernas ficarem quase estendidas. '
          '7. Não deixes a anca levantar nem a lombar arquear para completar a repetição. '
          '8. Expira ao dobrar os joelhos e inspira ao regressar. '
          '9. Reduz a carga se precisares de impulso ou se a bacia saltar do apoio.';
    }
    if (_has(n, ['ponte de gluteo'])) {
      return '1. Deita-te de costas no chão ou tapete, com os joelhos dobrados e os pés apoiados à largura da anca. '
          '2. Deixa os calcanhares a um palmo dos glúteos e os braços ao lado do corpo. '
          '3. Ativa o abdómen para a lombar ficar neutra. '
          '4. Empurra o chão com os calcanhares e eleva a anca até formar uma linha dos ombros aos joelhos. '
          '5. Aperta os glúteos no topo durante um a dois segundos, sem arquear a lombar. '
          '6. Desce a anca devagar sem tocar com força no chão. '
          '7. Expira ao subir e inspira ao descer. '
          '8. Mantém os joelhos alinhados com os pés durante todo o movimento. '
          '9. Para tornar mais difícil, faz uma pausa mais longa no topo.';
    }
    if (_has(n, ['hip thrust'])) {
      final support = _has(n, ['com apoio'])
          ? 'um banco, sofá ou apoio estável da altura dos joelhos'
          : 'um banco estável';
      return '1. Senta-te no chão com a parte de cima das costas encostada a $support. '
          '2. Apoia a zona abaixo das omoplatas na borda e dobra os joelhos com os pés à largura da anca. '
          '3. Se usares peso extra, apoia-o sobre a anca; sem peso, mantém as mãos na borda do apoio. '
          '4. Recolhe ligeiramente o queixo e ativa o abdómen. '
          '5. Empurra o chão com os calcanhares e eleva a anca até o tronco e as coxas ficarem alinhados. '
          '6. Aperta os glúteos no topo sem arquear a lombar nem empurrar com a cabeça. '
          '7. Desce a anca devagar até quase tocar no chão. '
          '8. Expira ao subir e inspira ao descer. '
          '9. Mantém os joelhos alinhados com os pés e o apoio firme para não deslizar.';
    }
    if (_has(n, ['kickback de gluteo'])) {
      return '1. Apoia mãos e joelhos no chão ou tapete, com os punhos por baixo dos ombros e os joelhos por baixo da anca. '
          '2. Ativa o abdómen e mantém a lombar neutra e o olhar no chão. '
          '3. Leva uma perna para trás e para cima, empurrando com o calcanhar, com o joelho dobrado a 90 graus. '
          '4. Sobe apenas até a coxa ficar alinhada com o tronco, sem rodar a bacia nem arquear a lombar. '
          '5. Aperta o glúteo no topo durante um segundo. '
          '6. Recolhe o joelho devagar pelo mesmo caminho, sem tocar com impacto no chão. '
          '7. Expira ao levar a perna atrás e inspira ao recolher. '
          '8. Completa as repetições de um lado antes de trocar. '
          '9. Usa amplitude menor se sentires a lombar a trabalhar em vez do glúteo.';
    }
    if (n == 'aducao de anca') {
      return '1. Senta-te na máquina adutora com as costas apoiadas no encosto. '
          '2. Coloca as pernas por fora dos apoios acolchoados, com os pés nos descansos. '
          '3. Ajusta a abertura inicial para sentir alongamento leve na parte interna das coxas, sem dor. '
          '4. Segura as pegas laterais e mantém o tronco quieto. '
          '5. Aproxima as pernas uma da outra apertando a parte interna das coxas. '
          '6. Faz uma pausa curta com as pernas juntas. '
          '7. Deixa as pernas abrir devagar, em dois a três segundos, sem soltar o controlo. '
          '8. Expira ao fechar e inspira ao abrir. '
          '9. Reduz a abertura ou a carga se sentires repuxar na virilha.';
    }
    if (n == 'abducao de anca') {
      return '1. Senta-te na máquina abdutora com as costas apoiadas no encosto. '
          '2. Coloca as pernas por dentro dos apoios acolchoados, com os pés nos descansos. '
          '3. Começa com as pernas juntas e segura as pegas laterais. '
          '4. Afasta as pernas empurrando os apoios para fora com a parte lateral da anca e os glúteos. '
          '5. Abre até uma amplitude confortável, sem inclinar o tronco para trás. '
          '6. Faz uma pausa curta na posição aberta. '
          '7. Deixa as pernas voltar devagar ao centro, sem as placas baterem. '
          '8. Expira ao abrir e inspira ao fechar. '
          '9. Mantém a bacia quieta no assento durante toda a série.';
    }
    if (_has(n, ['gemeos em pe'])) {
      return '1. Fica de pé com a parte da frente dos pés num degrau estável ou no chão, com os calcanhares livres. '
          '2. Apoia uma mão numa parede ou corrimão apenas para equilíbrio. '
          '3. Mantém os joelhos esticados sem bloquear com força e o tronco direito. '
          '4. Sobe os calcanhares o mais alto que conseguires, ficando na ponta dos pés. '
          '5. Faz uma pausa de um segundo no topo, sentindo a barriga das pernas. '
          '6. Desce os calcanhares devagar, em dois a três segundos, até sentir alongamento leve. '
          '7. Expira ao subir e inspira ao descer. '
          '8. Não deixes os tornozelos cair para dentro nem para fora. '
          '9. Sobe sempre pela mesma linha, empurrando com o dedo grande do pé.';
    }
    if (_has(n, ['gemeos sentado'])) {
      return '1. Senta-te num banco ou cadeira estável com os pés apoiados no chão ou num degrau baixo. '
          '2. Para mais dificuldade, pousa um objeto pesado e estável sobre as coxas, perto dos joelhos. '
          '3. Mantém os joelhos dobrados a 90 graus e o tronco direito. '
          '4. Sobe os calcanhares empurrando com a ponta dos pés, usando a parte inferior das pernas. '
          '5. Faz uma pausa curta no topo. '
          '6. Desce os calcanhares devagar até um alongamento confortável. '
          '7. Expira ao subir e inspira ao descer. '
          '8. Com o joelho dobrado, o esforço concentra-se mais no sóleo, o músculo profundo do gémeo. '
          '9. Se usares um objeto sobre as coxas, segura-o com as mãos para não deslizar.';
    }
    if (_has(n, ['elevacao de gemeos unilateral'])) {
      return '1. Fica de pé sobre uma perna, com a outra dobrada atrás ou apoiada levemente. '
          '2. Apoia uma mão numa parede ou apoio estável para equilibrar. '
          '3. Mantém o joelho da perna de apoio esticado sem bloquear e o tronco direito. '
          '4. Sobe o calcanhar dessa perna o mais alto possível, ficando na ponta do pé. '
          '5. Faz uma pausa de um segundo no topo. '
          '6. Desce devagar, em dois a três segundos, até alongamento leve. '
          '7. Expira ao subir e inspira ao descer. '
          '8. Completa as repetições de uma perna antes de trocar. '
          '9. Reduz a amplitude se o tornozelo balançar para os lados.';
    }
    if (_has(n, ['soleo sentado'])) {
      return '1. Senta-te num banco ou cadeira com os joelhos dobrados a 90 graus e os pés no chão. '
          '2. Para mais resistência, pousa um objeto leve sobre as coxas, segurando-o com as mãos. '
          '3. Mantém o tronco direito e os pés à largura da anca. '
          '4. Sobe os calcanhares devagar, empurrando com a ponta dos pés. '
          '5. Faz uma pausa curta no topo, sentindo a parte profunda da barriga da perna. '
          '6. Desce os calcanhares em dois a três segundos até tocar no chão. '
          '7. Expira ao subir e inspira ao descer. '
          '8. O joelho dobrado tira trabalho ao gémeo grande e concentra-o no sóleo. '
          '9. Aumenta a resistência apenas quando controlares a subida e a descida.';
    }
    if (_has(n, ['elevacao tibial'])) {
      return '1. Encosta as costas a uma parede e afasta os pés meio passo para a frente. '
          '2. Mantém os calcanhares no chão e o corpo ligeiramente inclinado na parede. '
          '3. Levanta as pontas dos dois pés na direção das canelas, o mais alto que conseguires. '
          '4. Sente a parte da frente das canelas a trabalhar. '
          '5. Faz uma pausa curta no topo. '
          '6. Desce as pontas dos pés devagar, sem bater no chão. '
          '7. Expira ao levantar e inspira ao descer. '
          '8. Mantém os joelhos esticados sem bloquear. '
          '9. Afasta mais os pés da parede para aumentar a dificuldade.';
    }
    if (_has(n, ['saltos leves'])) {
      return '1. Fica de pé com os pés à largura da anca e os joelhos ligeiramente dobrados. '
          '2. Mantém o tronco direito e os braços soltos ao lado do corpo. '
          '3. Salta baixo, apenas alguns centímetros do chão, usando os tornozelos como mola. '
          '4. Aterra na parte da frente dos pés e deixa os calcanhares tocar levemente no chão. '
          '5. Aterra em silêncio, com os joelhos suaves, sem os deixar cair para dentro. '
          '6. Mantém um ritmo constante e confortável, como saltitar no lugar. '
          '7. Respira de forma contínua durante os saltos. '
          '8. Faz blocos curtos de 15 a 30 segundos com pausas. '
          '9. Para se sentires dor no tendão de Aquiles, tornozelos ou canelas.';
    }
    if (_has(n, ['peso morto tradicional'])) {
      return '1. Coloca a barra no chão sobre o meio dos pés, com os pés à largura da anca. '
          '2. Dobra a anca e os joelhos para descer e agarra a barra com pega simétrica, um pouco mais aberta que as pernas. '
          '3. Baixa a anca até as canelas quase tocarem na barra, com o peito aberto e a coluna neutra. '
          '4. Aperta a barra, ativa o abdómen e tira a folga dos braços antes de puxar. '
          '5. Empurra o chão com os pés e sobe, mantendo a barra colada às pernas. '
          '6. Estende joelhos e anca ao mesmo tempo até ficares de pé, sem inclinar para trás. '
          '7. Desce pelo mesmo caminho, levando a anca para trás e dobrando os joelhos, com a lombar neutra. '
          '8. Pousa a barra com controlo no chão entre repetições. '
          '9. Inspira antes de puxar e expira perto do topo. '
          '10. Usa carga leve até dominares a posição inicial e a descida.';
    }
    // Trapézio e ombros.
    if (_has(n, ['encolhimento de ombros'])) {
      final hold = _has(n, ['na maquina'])
          ? '1. Ajusta a máquina de encolhimentos e segura as pegas com os braços estendidos ao lado do corpo. '
          : _has(n, ['com barra'])
          ? '1. Segura uma barra à frente das coxas com pega simétrica, à largura dos ombros. '
          : '1. Segura um halter em cada mão ao lado do corpo, com os braços estendidos. ';
      return '$hold'
          '2. Fica de pé com os pés à largura da anca, tronco direito e abdómen ligeiramente ativo. '
          '3. Mantém os punhos direitos e os cotovelos quase esticados durante todo o movimento. '
          '4. Sobe os ombros na direção das orelhas, o mais alto que conseguires sem dobrar os braços. '
          '5. Faz uma pausa de um segundo no topo, apertando o trapézio. '
          '6. Desce os ombros devagar até ao ponto inicial, deixando-os alongar. '
          '7. Expira ao subir e inspira ao descer. '
          '8. Não rodes os ombros em círculo nem uses impulso das pernas. '
          '9. Mantém o pescoço relaxado e o olhar em frente.';
    }
    if (_has(n, ['remo alto leve'])) {
      return '1. Segura os halteres ou a barra à frente das coxas, com pega à largura dos ombros e punhos direitos. '
          '2. Fica de pé com o tronco direito e o abdómen ativo. '
          '3. Puxa o peso para cima, junto ao corpo, levando os cotovelos para fora e para cima. '
          '4. Sobe apenas até os cotovelos ficarem à altura dos ombros ou abaixo, nunca mais alto. '
          '5. Mantém os ombros afastados das orelhas e as escápulas controladas. '
          '6. Desce o peso devagar pelo mesmo caminho, junto ao tronco. '
          '7. Expira ao puxar e inspira ao descer. '
          '8. Usa carga leve: este movimento é para trapézio e ombros, não para força máxima. '
          '9. Para se sentires beliscar ou dor na frente do ombro, ou se a lombar arquear.';
    }
    if (n == 'press militar com barra') {
      return '1. Coloca a barra num suporte à altura da parte alta do peito, ou limpa-a até aos ombros com ajuda. '
          '2. Segura a barra com pega simétrica, um pouco mais aberta que os ombros, e punhos direitos. '
          '3. Fica de pé (ou sentado num banco com encosto) com os pés firmes e o abdómen ativo. '
          '4. Começa com a barra apoiada na frente dos ombros e os cotovelos ligeiramente à frente da barra. '
          '5. Empurra a barra a direito para cima, afastando ligeiramente a cabeça para a deixar passar. '
          '6. Termina com os braços quase estendidos e a barra por cima do meio da cabeça. '
          '7. Desce a barra devagar pelo mesmo caminho até à frente dos ombros. '
          '8. Inspira antes de empurrar e expira quando a barra passa a zona mais difícil. '
          '9. Não arquees a lombar nem empurres com as pernas para completar a repetição.';
    }
    if (_has(n, ['press militar com halteres'])) {
      return '1. Segura um halter em cada mão e leva-os à altura dos ombros, com as palmas para a frente ou ligeiramente viradas uma para a outra. '
          '2. Fica de pé com os pés à largura da anca, ou sentado num banco com encosto, com o abdómen ativo. '
          '3. Mantém os punhos direitos por cima dos cotovelos. '
          '4. Empurra os halteres para cima até os braços ficarem quase estendidos por cima da cabeça. '
          '5. Aproxima ligeiramente os halteres no topo, sem os bater. '
          '6. Desce os halteres devagar até à altura dos ombros. '
          '7. Inspira ao descer e expira ao empurrar. '
          '8. Mantém as costelas baixas e a lombar neutra durante toda a série. '
          '9. Usa um banco com encosto se sentires a lombar a arquear de pé.';
    }
    if (_has(n, ['arnold press'])) {
      return '1. Senta-te num banco com encosto ou fica de pé com o abdómen ativo e os pés firmes. '
          '2. Segura os halteres à frente dos ombros, com as palmas viradas para ti, como no fim de um curl. '
          '3. Mantém os punhos direitos e os cotovelos à frente do corpo. '
          '4. Empurra os halteres para cima e, ao mesmo tempo, roda as palmas para a frente. '
          '5. Termina com os braços quase estendidos por cima da cabeça e as palmas viradas para a frente. '
          '6. Desce devagar invertendo a rotação, até as palmas voltarem a ficar viradas para ti. '
          '7. Inspira ao descer e expira ao empurrar. '
          '8. Mantém os ombros afastados das orelhas durante a rotação. '
          '9. Usa carga mais leve do que num press normal, porque a rotação exige mais controlo.';
    }
    if (_has(n, ['wall slides'])) {
      return '1. Encosta as costas a uma parede, com os pés meio passo à frente e os joelhos suaves. '
          '2. Encosta a lombar, as omoplatas e, se conseguires, a parte de trás da cabeça à parede. '
          '3. Dobra os cotovelos a 90 graus e encosta os antebraços e as costas das mãos à parede, como um guarda-redes. '
          '4. Desliza os braços lentamente pela parede para cima, mantendo antebraços e mãos em contacto. '
          '5. Sobe apenas até onde consegues manter o contacto sem arquear a lombar. '
          '6. Desliza de volta para baixo, levando os cotovelos na direção das costelas. '
          '7. Expira ao subir e inspira ao descer. '
          '8. Mantém os ombros afastados das orelhas e o pescoço relaxado. '
          '9. Faz 6 a 10 repetições lentas, com atenção à zona das omoplatas.';
    }
    if (_has(n, ['scapular push-up'])) {
      return '1. Coloca-te em prancha alta, com as mãos por baixo dos ombros e o corpo em linha reta. '
          '2. Mantém os cotovelos esticados durante todo o exercício: o movimento vem só das omoplatas. '
          '3. Ativa o abdómen e os glúteos para a anca não descair. '
          '4. Deixa o peito descer alguns centímetros aproximando as omoplatas uma da outra. '
          '5. Depois empurra o chão afastando as omoplatas, arredondando ligeiramente a parte alta das costas. '
          '6. Mantém o pescoço comprido e o olhar no chão. '
          '7. Inspira ao juntar as omoplatas e expira ao empurrar. '
          '8. Faz o movimento devagar, sentindo as omoplatas a deslizar. '
          '9. Apoia os joelhos no chão para facilitar se a prancha for exigente.';
    }
    if (_has(n, ['pike push-up'])) {
      return '1. Começa em prancha alta e caminha com os pés na direção das mãos até a anca subir bem alto, formando um V invertido. '
          '2. Mantém as mãos à largura dos ombros, os braços esticados e o olhar entre os pés. '
          '3. Distribui o peso sobre os ombros e mantém o abdómen ativo. '
          '4. Dobra os cotovelos e leva o topo da cabeça na direção do chão, entre as mãos. '
          '5. Desce devagar até perto do chão, guiando os cotovelos numa diagonal natural. '
          '6. Empurra o chão com as mãos e volta a estender os braços. '
          '7. Inspira ao descer e expira ao empurrar. '
          '8. Mantém a anca alta durante toda a repetição: o esforço deve ficar nos ombros. '
          '9. Aproxima menos os pés das mãos para facilitar, ou eleva os pés para dificultar.';
    }
    if (_has(n, ['mobilidade de ombro com elastico'])) {
      return '1. Segura um elástico à frente do corpo com as duas mãos, bem mais afastadas que os ombros. '
          '2. Fica de pé com o tronco direito, costelas baixas e pescoço relaxado. '
          '3. Mantém uma tensão leve no elástico durante todo o movimento. '
          '4. Leva o elástico devagar à frente e acima da cabeça, com os braços quase esticados. '
          '5. Se a mobilidade permitir sem dor, continua o arco até atrás da cabeça. '
          '6. Regressa pelo mesmo caminho com controlo. '
          '7. Respira devagar em cada passagem, sem prender o ar. '
          '8. Alarga a pega para facilitar; encurta apenas quando o movimento ficar confortável. '
          '9. Para se sentires beliscar no ombro, formigueiro ou necessidade de arquear a lombar.';
    }
    // Peito.
    if (_has(n, ['crossover no cabo'])) {
      return '1. Ajusta as duas polias do cabo acima da altura dos ombros e escolhe carga leve. '
          '2. Segura uma pega em cada mão e dá um passo em frente para o meio, com um pé à frente do outro. '
          '3. Começa com os braços abertos ao lado, cotovelos ligeiramente dobrados e tronco firme. '
          '4. Puxa as pegas para a frente e para baixo, cruzando ligeiramente as mãos à frente da anca ou do peito. '
          '5. Mantém a mesma dobra dos cotovelos: o movimento é um arco, não um press. '
          '6. Aperta o peito por um segundo no ponto em que as mãos se cruzam. '
          '7. Deixa os braços abrir devagar até sentir alongamento confortável no peito. '
          '8. Expira ao cruzar e inspira ao abrir. '
          '9. Não deixes o cabo puxar os ombros para trás de repente no retorno.';
    }
    if (_has(n, ['pullover'])) {
      final backFocus = _n(group) == 'costas';
      final cableVariant = _has(n, ['no cabo']);
      if (cableVariant) {
        return '1. Coloca a polia na posição alta e prende uma barra reta ou corda. '
            '2. Segura a pega com as duas mãos, dá um ou dois passos atrás e inclina o tronco ligeiramente à frente. '
            '3. Começa com os braços esticados acima da cabeça, na linha do cabo, com os cotovelos quase estendidos. '
            '4. Puxa a pega para baixo num arco largo, com os braços esticados, até às coxas. '
            '5. Sente as costas e os dorsais a puxar, não os braços a dobrar. '
            '6. Mantém o tronco quieto e a lombar neutra durante todo o arco. '
            '7. Deixa a pega subir devagar pelo mesmo arco, mantendo tensão no cabo. '
            '8. Expira ao puxar para baixo e inspira ao subir. '
            '9. Reduz a carga se os cotovelos dobrarem para completar a repetição.';
      }
      if (backFocus) {
        return '1. Deita-te num banco (ou no chão) com os pés firmes e a lombar neutra. '
            '2. Segura um halter com as duas mãos por baixo da cabeça de cima, com os braços quase esticados sobre o peito. '
            '3. Ativa o abdómen para as costelas não abrirem. '
            '4. Leva o halter devagar em arco para trás da cabeça, mantendo a mesma dobra leve dos cotovelos. '
            '5. Desce até sentir alongamento nas costas e nos dorsais, sem dor no ombro. '
            '6. Puxa o halter de volta pelo mesmo arco até por cima do peito, sentindo os dorsais a trabalhar. '
            '7. Inspira ao levar atrás e expira ao puxar de volta. '
            '8. Mantém a lombar apoiada: se ela arquear, encurta o arco. '
            '9. Usa carga leve e pega firme para o halter não escapar por cima do rosto.';
      }
      return '1. Deita-te num banco (ou no chão) com os pés firmes e a lombar neutra. '
          '2. Segura um halter com as duas mãos por baixo da cabeça de cima, com os braços quase esticados sobre o peito. '
          '3. Mantém os cotovelos ligeiramente dobrados e apontados para a frente, mais próximos que na versão para costas. '
          '4. Desce o halter em arco para trás da cabeça até sentir alongamento no peito e nas costelas. '
          '5. Não deixes a lombar arquear nem as costelas abrir. '
          '6. Puxa o halter de volta pelo mesmo arco, apertando o peito ao passar por cima do rosto. '
          '7. Inspira ao descer e expira ao puxar de volta. '
          '8. Faz o movimento devagar, sem balanço. '
          '9. Usa carga leve e pega firme para o halter não escapar.';
    }
    // Costas.
    if (_has(n, ['remo unilateral com halter'])) {
      return '1. Coloca um joelho e a mão do mesmo lado em cima de um banco estável; o outro pé fica no chão. '
          '2. Segura o halter com a mão livre, com pega firme, o braço pendurado e o punho direito. '
          '3. Mantém as costas planas, paralelas ao chão, e o pescoço alinhado com a coluna. '
          '4. Antes de puxar, baixa o ombro do lado que trabalha, ativando a escápula. '
          '5. Puxa o halter para cima, levando o cotovelo para trás junto ao tronco, na direção da anca. '
          '6. Aperta as costas no topo sem rodar o tronco para cima. '
          '7. Desce o halter devagar até o braço alongar por completo. '
          '8. Expira ao puxar e inspira ao descer. '
          '9. Completa as repetições de um lado antes de trocar. '
          '10. Mantém a lombar neutra: se as costas arredondarem, reduz a carga.';
    }
    if (n == 'remo invertido') {
      return '1. Coloca uma barra fixa baixa, argolas ou TRX à altura da cintura, num suporte firme. '
          '2. Deita-te por baixo e segura a barra com pega um pouco mais larga que os ombros e punhos direitos. '
          '3. Estica o corpo em linha reta, com os calcanhares no chão e os braços esticados. '
          '4. Ativa o abdómen e os glúteos para a anca não descair. '
          '5. Antes de puxar, junta ligeiramente as omoplatas. '
          '6. Puxa o peito na direção da barra, levando os cotovelos para trás junto ao corpo. '
          '7. Desce devagar até os braços esticarem, sem perder a linha do corpo. '
          '8. Expira ao puxar e inspira ao descer. '
          '9. Mantém a lombar neutra e o pescoço comprido. '
          '10. Para facilitar, sobe a barra ou dobra os joelhos; para dificultar, baixa a barra.';
    }
    if (_has(n, ['puxada com bracos esticados'])) {
      return '1. Coloca a polia na posição alta e prende uma barra reta ou corda. '
          '2. Segura a pega com as duas mãos à largura dos ombros e dá um passo atrás. '
          '3. Inclina o tronco ligeiramente à frente, com a lombar neutra e o abdómen ativo. '
          '4. Começa com os braços esticados à frente, na linha do cabo, com os cotovelos quase estendidos. '
          '5. Puxa a barra para baixo num arco, com os braços sempre esticados, até às coxas. '
          '6. Sente os dorsais, dos lados das costas, a fazer o trabalho, e as escápulas a descer. '
          '7. Deixa a barra subir devagar pelo mesmo arco, mantendo tensão. '
          '8. Expira ao puxar para baixo e inspira ao subir. '
          '9. Se os cotovelos dobrarem muito, o exercício vira um tríceps: reduz a carga.';
    }
    if (_has(n, ['remo com elastico'])) {
      return '1. Senta-te no chão com as pernas estendidas e passa o elástico à volta dos dois pés. '
          '2. Segura uma ponta em cada mão com pega firme, braços esticados e tensão leve no elástico. '
          '3. Mantém o tronco direito, a lombar neutra e o peito aberto. '
          '4. Antes de puxar, baixa os ombros e junta ligeiramente as omoplatas. '
          '5. Puxa as pontas na direção das costelas, levando os cotovelos para trás junto ao corpo. '
          '6. Aperta as costas por um segundo com as escápulas juntas. '
          '7. Deixa os braços voltar devagar à frente, mantendo alguma tensão. '
          '8. Expira ao puxar e inspira ao voltar. '
          '9. Não inclines o tronco para trás para ganhar força: o movimento é só dos braços e costas.';
    }
    // Lombar.
    if (n == 'hiperextensao lombar') {
      return '1. Ajusta a máquina ou o banco de hiperextensões para a almofada apoiar a parte de cima das coxas. '
          '2. Prende os pés nos apoios e cruza os braços à frente do peito. '
          '3. Desce o tronco devagar, dobrando pela anca, até um alongamento confortável atrás das coxas. '
          '4. Sobe o tronco apertando glúteos e posteriores até à linha reta do corpo, sem passar dela. '
          '5. Mantém a coluna neutra durante todo o movimento, sem enrolar nem hiperestender. '
          '6. Inspira ao descer e expira ao subir. '
          '7. Usa uma amplitude menor se sentires pressão na lombar.';
    }
    if (_has(n, ['hiperextensao no banco romano'])) {
      return '1. Ajusta o banco romano para a almofada apoiar a parte de cima das coxas, abaixo da crista da anca. '
          '2. Prende os pés nos apoios e cruza os braços à frente do peito. '
          '3. Começa com o corpo em linha reta, da cabeça aos calcanhares. '
          '4. Desce o tronco devagar, dobrando pela anca, até sentir alongamento atrás das coxas. '
          '5. Mantém a coluna neutra: dobra pela anca, não enrolando a lombar. '
          '6. Sobe o tronco apertando glúteos e posteriores até voltar à linha reta, sem passar dela. '
          '7. Inspira ao descer e expira ao subir. '
          '8. Não hiperestendas a lombar no topo nem uses impulso. '
          '9. Usa amplitude menor se sentires pressão na lombar.';
    }
    if (_has(n, ['hiperextensao no chao'])) {
      return '1. Deita-te de barriga para baixo num tapete, com as pernas estendidas e a testa perto do chão. '
          '2. Coloca as mãos ao lado da cabeça ou estende os braços à frente. '
          '3. Ativa levemente os glúteos e o abdómen antes de subir. '
          '4. Eleva o peito e a cabeça alguns centímetros do chão, num movimento pequeno e controlado. '
          '5. Mantém o olhar para o chão para o pescoço ficar alinhado. '
          '6. Faz uma pausa de um a dois segundos no topo. '
          '7. Desce devagar até quase tocar no chão. '
          '8. Expira ao subir e inspira ao descer. '
          '9. Procura altura pequena e estável: não é preciso subir muito para a lombar trabalhar.';
    }
    if (_has(n, ['superman isometrico'])) {
      return '1. Deita-te de barriga para baixo num tapete, com os braços estendidos à frente e as pernas esticadas. '
          '2. Mantém o olhar para o chão e o pescoço comprido. '
          '3. Eleva ao mesmo tempo os braços, o peito e as pernas alguns centímetros do chão. '
          '4. Aperta os glúteos e a zona lombar sem prender a respiração. '
          '5. Mantém a posição parado durante 10 a 20 segundos. '
          '6. Respira devagar e de forma contínua durante a sustentação. '
          '7. Desce braços e pernas devagar até relaxar no chão. '
          '8. Descansa alguns segundos antes de repetir. '
          '9. Para se sentires apertar na lombar; eleva menos ou levanta apenas braços ou pernas.';
    }
    if (_has(n, ['extensao lombar com elastico'])) {
      return '1. Senta-te no chão ou numa cadeira e passa o elástico à volta dos pés ou de um ponto baixo firme. '
          '2. Segura as pontas junto ao peito com as duas mãos. '
          '3. Começa com o tronco ligeiramente inclinado à frente, com a coluna neutra. '
          '4. Endireita o tronco devagar contra a resistência do elástico, dobrando pela anca. '
          '5. Para quando o tronco ficar direito, sem inclinar para trás. '
          '6. Volta devagar à inclinação inicial, controlando o elástico. '
          '7. Expira ao endireitar e inspira ao voltar. '
          '8. Mantém o movimento pequeno e suave, sentindo a lombar e os glúteos. '
          '9. Reduz a tensão se precisares de puxar com os braços ou encolher os ombros.';
    }
    if (_has(n, ['good morning leve isometrico'])) {
      return '1. Fica de pé com os pés à largura da anca e as mãos atrás da cabeça ou uma barra muito leve nos ombros. '
          '2. Dobra ligeiramente os joelhos e mantém a coluna neutra. '
          '3. Inclina o tronco à frente dobrando pela anca, até cerca de 30 a 45 graus. '
          '4. Para nessa posição e aguenta parado 5 a 15 segundos. '
          '5. Mantém o peso nos calcanhares e a anca para trás. '
          '6. Respira devagar durante a sustentação, sem prender o ar. '
          '7. Sobe apertando os glúteos até ficar direito. '
          '8. Descansa e repete. '
          '9. Sai da posição se a lombar começar a arredondar ou a tremer.';
    }
    // Bíceps.
    if (_has(n, ['curl concentrado'])) {
      return '1. Senta-te num banco ou cadeira com as pernas afastadas e segura um halter com pega firme. '
          '2. Apoia a parte de trás desse braço na parte interna da coxa do mesmo lado. '
          '3. Deixa o braço pendurado com o halter, punho direito e palma para a frente. '
          '4. Mantém o tronco inclinado à frente e a outra mão apoiada na outra coxa. '
          '5. Sobe o halter dobrando só o cotovelo, sem mexer o ombro nem o tronco. '
          '6. Aperta o bíceps no topo por um segundo. '
          '7. Desce em dois a três segundos até o braço quase esticar. '
          '8. Expira ao subir e inspira ao descer. '
          '9. Completa as repetições de um braço antes de trocar. '
          '10. A coxa serve de apoio fixo: se o cotovelo sair dela, reduz a carga.';
    }
    if (_has(n, ['curl spider'])) {
      return '1. Deita-te de barriga para baixo num banco inclinado, com o peito apoiado e os braços pendurados. '
          '2. Segura um halter em cada mão com pega firme, palmas para a frente e punhos direitos. '
          '3. Deixa os braços verticais, perpendiculares ao chão. '
          '4. Sobe os halteres dobrando apenas os cotovelos, sem balançar os ombros. '
          '5. O peito apoiado impede o tronco de ajudar: todo o esforço fica no bíceps. '
          '6. Aperta no topo por um segundo. '
          '7. Desce devagar até os braços quase esticarem. '
          '8. Expira ao subir e inspira ao descer. '
          '9. Usa carga leve: sem impulso, o exercício é mais difícil do que parece.';
    }
    if (_has(n, ['curl inclinado'])) {
      return '1. Ajusta um banco inclinado entre 45 e 60 graus e senta-te com as costas e a cabeça apoiadas. '
          '2. Deixa os braços pendurados ao lado e segura um halter em cada mão com pega firme, palmas para a frente. '
          '3. Sente o bíceps alongado nessa posição inicial, com os punhos direitos. '
          '4. Sobe os halteres dobrando os cotovelos, sem deixar os cotovelos vir para a frente. '
          '5. Mantém os ombros encostados ao banco durante toda a repetição. '
          '6. Aperta no topo e desce em dois a três segundos até alongar de novo. '
          '7. Expira ao subir e inspira ao descer. '
          '8. Mantém o tronco quieto: o banco existe para impedir compensações. '
          '9. Usa carga menor que no curl em pé, porque o bíceps parte de uma posição alongada.';
    }
    if (_has(n, ['curl isometrico'])) {
      return '1. Fica de pé, segura um halter em cada mão com pega firme e mantém os cotovelos junto ao tronco. '
          '2. Sobe os halteres até os cotovelos ficarem dobrados a cerca de 90 graus. '
          '3. Para nessa posição, com os punhos direitos e os antebraços paralelos ao chão. '
          '4. Aguenta parado 15 a 30 segundos, mantendo o tronco direito. '
          '5. Respira devagar e de forma contínua durante a sustentação. '
          '6. Não deixes os cotovelos abrir nem os ombros subir. '
          '7. Desce os halteres devagar no fim do tempo. '
          '8. Descansa antes de repetir. '
          '9. Termina a série quando os braços tremerem ao ponto de perder o ângulo.';
    }
    // Tríceps.
    if (_has(n, ['fundos entre apoios'])) {
      return '1. Senta-te na borda de um banco ou cadeira estável e apoia as mãos na borda, ao lado da anca, com os dedos para a frente. '
          '2. Desliza a anca para fora do apoio, mantendo os joelhos dobrados e os pés no chão. '
          '3. Mantém os ombros afastados das orelhas e o peito aberto. '
          '4. Desce o corpo dobrando os cotovelos para trás, mantendo-os próximos do tronco. '
          '5. Desce até os cotovelos ficarem perto de 90 graus, sem dor no ombro. '
          '6. Empurra o apoio com as mãos e sobe até os braços quase esticarem. '
          '7. Inspira ao descer e expira ao empurrar. '
          '8. Mantém a anca perto do banco durante todo o movimento. '
          '9. Estica as pernas à frente para dificultar; dobra-as mais para facilitar. '
          '10. Para se sentires beliscar na frente do ombro ou dor na lombar.';
    }
    if (_has(n, ['dips para triceps'])) {
      return '1. Sobe para as paralelas com uma mão em cada pega e os braços esticados. '
          '2. Mantém o tronco o mais vertical possível: quanto mais direito, mais tríceps e menos peito. '
          '3. Mantém os ombros afastados das orelhas e as pernas dobradas ou cruzadas atrás. '
          '4. Desce dobrando os cotovelos para trás, junto ao corpo. '
          '5. Desce até os cotovelos chegarem perto de 90 graus, sem dor no ombro. '
          '6. Empurra as barras para baixo e sobe até quase estender os braços. '
          '7. Inspira ao descer e expira ao subir. '
          '8. Mantém os punhos direitos e a pega firme. '
          '9. Usa máquina assistida ou elástico nos joelhos se ainda não controlares o peso do corpo. '
          '10. Mantém a lombar neutra, sem balançar as pernas para ganhar impulso.';
    }
    if (_has(n, ['extensao unilateral de triceps'])) {
      return '1. Fica de pé ou sentado com um halter leve numa mão. '
          '2. Sobe esse braço até ficar vertical, com o halter por cima da cabeça e a pega firme. '
          '3. Usa a outra mão para apoiar o cotovelo do braço que trabalha, se ajudar. '
          '4. Dobra o cotovelo e desce o halter devagar por trás da cabeça. '
          '5. Mantém o cotovelo apontado para a frente e junto à cabeça, sem abrir para o lado. '
          '6. Estende o cotovelo e sobe o halter até o braço ficar quase direito. '
          '7. Inspira ao descer e expira ao estender. '
          '8. Mantém as costelas baixas e a lombar neutra. '
          '9. Completa as repetições de um braço antes de trocar. '
          '10. Usa carga leve: um braço sozinho controla pior a descida.';
    }
    if (_has(n, ['triceps no cabo com corda'])) {
      return '1. Coloca a polia na posição alta e prende a corda de duas pontas. '
          '2. Segura uma ponta em cada mão com pega neutra e punhos direitos. '
          '3. Fica de pé de frente para o cabo, com um pé ligeiramente à frente e o tronco quase direito. '
          '4. Cola os cotovelos ao lado do tronco: eles não devem mexer durante a repetição. '
          '5. Desce a corda estendendo os cotovelos e afasta as pontas das mãos no fim. '
          '6. Aperta o tríceps por um segundo com os braços quase estendidos. '
          '7. Deixa a corda subir devagar até os antebraços passarem a horizontal, sem os cotovelos levantarem. '
          '8. Expira ao empurrar para baixo e inspira ao subir. '
          '9. Mantém a lombar neutra e os ombros afastados das orelhas. '
          '10. Reduz a carga se os cotovelos abrirem ou o tronco inclinar para pressionar.';
    }
    if (_has(n, ['extensao de triceps no cabo'])) {
      return '1. Coloca a polia na posição alta e prende uma barra reta ou pega curta. '
          '2. Segura a pega com as palmas para baixo e punhos direitos. '
          '3. Fica de pé de frente para o cabo, com o tronco quase direito e o abdómen ativo. '
          '4. Cola os cotovelos ao lado do tronco durante toda a série. '
          '5. Desce a barra estendendo os cotovelos até os braços quase esticarem. '
          '6. Faz uma pausa curta em baixo, apertando o tríceps. '
          '7. Deixa a barra subir devagar até os antebraços ficarem paralelos ao chão. '
          '8. Expira ao empurrar para baixo e inspira ao subir. '
          '9. Mantém a lombar neutra e não uses o peso do tronco para empurrar.';
    }
    // Antebraço / pega.
    if (n == 'dead hang') {
      return '1. Coloca-te por baixo de uma barra fixa firme e seca; usa um apoio para chegar lá se for alta. '
          '2. Segura a barra com as duas mãos à largura dos ombros, com a pega completa (polegar à volta da barra). '
          '3. Tira os pés do apoio e fica pendurado com os braços esticados. '
          '4. Mantém os ombros ativos, sem deixar o pescoço esmagar entre eles. '
          '5. Mantém o corpo quieto, sem balançar, com o abdómen levemente ativo. '
          '6. Aguenta 10 a 30 segundos, respirando devagar e de forma contínua. '
          '7. Para descer, apoia os pés primeiro e só depois solta a pega. '
          '8. Descansa as mãos entre séries. '
          '9. Termina antes de a pega falhar por completo, para não caíres de repente.';
    }
    if (_has(n, ['pinch grip'])) {
      return '1. Escolhe um ou dois discos lisos e limpos, com peso leve para começar. '
          '2. Coloca o disco em pé no chão ou num banco, à tua frente. '
          '3. Agarra a borda do disco em pinça: o polegar de um lado, os outros dedos do outro. '
          '4. Levanta o disco e mantém-no ao lado do corpo, com o braço esticado e o punho direito. '
          '5. Aperta com força constante: só a pressão dos dedos segura o disco. '
          '6. Aguenta 10 a 30 segundos, respirando de forma contínua. '
          '7. Pousa o disco com controlo, dobrando as pernas e não a lombar. '
          '8. Mantém os pés fora da linha de queda do disco. '
          '9. Troca de mão e repete; termina antes de o disco escorregar.';
    }
    if (_has(n, ['plate hold'])) {
      return '1. Escolhe um disco com peso confortável e pega nele pela borda com uma ou duas mãos. '
          '2. Fica de pé com o tronco direito, os ombros baixos e os pés à largura da anca. '
          '3. Segura o disco ao lado do corpo ou à frente, com os dedos a agarrar a borda e o punho direito. '
          '4. Aperta a borda com força constante durante 15 a 45 segundos. '
          '5. Mantém o braço quieto e o abdómen ativo para o tronco não inclinar. '
          '6. Respira de forma contínua, sem prender o ar. '
          '7. Pousa o disco com controlo antes de a pega abrir sozinha. '
          '8. Descansa e troca de mão se usares só uma. '
          '9. Mantém os pés afastados da zona onde o disco cairia.';
    }
    if (_has(n, ['towel grip hold'])) {
      return '1. Pendura uma toalha resistente por cima de uma barra fixa firme, com as duas pontas ao mesmo nível. '
          '2. Agarra uma ponta da toalha com cada mão, apertando o tecido com todos os dedos. '
          '3. Tira o peso dos pés aos poucos: começa com os pés apoiados se for a primeira vez. '
          '4. Fica suspenso ou semi-suspenso com os braços quase esticados e mantém os ombros ativos. '
          '5. Aperta o tecido com força constante; a toalha exige mais dos dedos do que a barra. '
          '6. Aguenta 5 a 20 segundos, respirando devagar. '
          '7. Apoia os pés antes de soltar as mãos. '
          '8. Descansa bem entre séries: a pega em tecido cansa depressa. '
          '9. Termina antes de as mãos abrirem de repente.';
    }
    if (_has(n, ['suitcase carry'])) {
      return '1. Coloca um halter ou carga no chão ao lado de um dos teus pés. '
          '2. Agacha dobrando joelhos e anca, agarra a pega com uma mão e levanta-te com a coluna neutra. '
          '3. Fica de pé com a carga só de um lado, como quem segura uma mala. '
          '4. Endireita o tronco: os ombros nivelados, sem inclinar para o lado da carga nem para o contrário. '
          '5. Caminha devagar em linha reta, com passos curtos e o abdómen ativo. '
          '6. Mantém o punho direito e a pega firme durante todo o percurso. '
          '7. Respira de forma contínua enquanto caminhas. '
          '8. Percorre 10 a 20 metros, pousa a carga com controlo e troca de lado. '
          '9. Termina se o tronco começar a inclinar ou a pega a abrir.';
    }
    if (_has(n, ['desvio radial'])) {
      return '1. Senta-te ou fica de pé com um halter leve numa mão, segurando-o por uma das pontas. '
          '2. Deixa o braço ao lado do corpo com o polegar virado para a frente. '
          '3. Mantém o cotovelo e o ombro quietos: só o punho trabalha. '
          '4. Inclina o punho para cima, na direção do polegar, levantando a ponta do halter. '
          '5. Usa uma amplitude pequena e sem dor. '
          '6. Faz uma pausa curta no topo. '
          '7. Desce devagar até à posição inicial. '
          '8. Expira ao levantar e inspira ao descer. '
          '9. Usa carga muito leve: a alavanca do halter multiplica o esforço no punho.';
    }
    if (_has(n, ['desvio ulnar'])) {
      return '1. Senta-te ou fica de pé com um halter leve numa mão, segurando-o pela ponta com o peso atrás da mão. '
          '2. Deixa o braço ao lado do corpo com o polegar virado para a frente. '
          '3. Mantém o cotovelo e o ombro quietos: o movimento é só do punho. '
          '4. Inclina o punho para trás e para baixo, na direção do dedo mínimo. '
          '5. Usa uma amplitude pequena e controlada, sem dor. '
          '6. Faz uma pausa curta no fim do movimento. '
          '7. Volta devagar à posição inicial. '
          '8. Expira ao inclinar e inspira ao voltar. '
          '9. Usa carga muito leve e pega firme para o halter não rodar na mão.';
    }
    // Core.
    if (_has(n, ['mountain climbers'])) {
      return '1. Coloca-te em prancha alta, com as mãos por baixo dos ombros e o corpo em linha reta. '
          '2. Ativa o abdómen e mantém a anca à altura dos ombros, sem subir em pico. '
          '3. Leva um joelho na direção do peito, mantendo o pé de trás firme. '
          '4. Troca as pernas num pequeno salto, levando o outro joelho ao peito. '
          '5. Continua a alternar os joelhos num ritmo que consegues controlar. '
          '6. Mantém as mãos a empurrar o chão e os ombros por cima dos punhos. '
          '7. Respira de forma contínua, ao ritmo das trocas. '
          '8. Começa devagar e aumenta o ritmo só se a anca não saltar. '
          '9. Trabalha 20 a 40 segundos por série. '
          '10. Para se a lombar descair ou os ombros saírem da linha das mãos.';
    }
    if (_has(n, ['side bend'])) {
      return '1. Fica de pé com os pés à largura da anca e os braços ao lado do corpo. '
          '2. Coloca uma mão atrás da cabeça e deixa a outra esticada junto à perna. '
          '3. Mantém o tronco direito, sem inclinar para a frente nem para trás. '
          '4. Inclina o tronco devagar para o lado do braço esticado, deslizando a mão pela perna. '
          '5. Desce só até sentir alongamento no lado contrário da cintura. '
          '6. Volta a subir usando os músculos do lado contrário, até ficar direito. '
          '7. Expira ao subir e inspira ao inclinar. '
          '8. Não rodes o tronco nem deixes a anca fugir para o lado. '
          '9. Completa as repetições de um lado antes de trocar. '
          '10. Para dificultar, segura uma garrafa de água cheia na mão do lado que desliza.';
    }
    if (_has(n, ['vacuum abdominal'])) {
      return '1. Fica de pé, sentado ou em quatro apoios, com a coluna neutra. '
          '2. Inspira fundo pelo nariz, enchendo a barriga de ar. '
          '3. Expira todo o ar pela boca, devagar. '
          '4. No fim da expiração, puxa o umbigo para dentro e para cima, como se quisesses encostá-lo à coluna. '
          '5. Mantém essa contração 5 a 15 segundos, sem encolher os ombros. '
          '6. Respira superficialmente durante a sustentação se precisares. '
          '7. Relaxa a barriga devagar. '
          '8. Descansa uma respiração completa e repete. '
          '9. Evita este exercício se estiveres com tensão alta não controlada ou tonturas.';
    }
    if (_has(n, ['russian twist'])) {
      return '1. Senta-te no chão com os joelhos dobrados e os pés apoiados ou ligeiramente elevados. '
          '2. Inclina o tronco para trás até sentir o abdómen a trabalhar, mantendo as costas direitas. '
          '3. Junta as mãos à frente do peito, com ou sem carga leve. '
          '4. Roda o tronco para um lado, levando as mãos na direção do chão ao lado da anca. '
          '5. Roda depois para o outro lado, voltando a passar pelo centro com controlo. '
          '6. Mantém o peito aberto e o queixo neutro. '
          '7. Expira em cada rotação e inspira ao passar pelo centro. '
          '8. Faz as rotações devagar, sem balancear as pernas. '
          '9. Apoia os pés no chão para facilitar; eleva-os para dificultar.';
    }
    if (_has(n, ['pallof press'])) {
      final anchor = _has(n, ['elastico'])
          ? '1. Prende um elástico num ponto firme à altura do peito e afasta-te para o lado até haver tensão. '
          : '1. Coloca a polia à altura do peito, segura a pega e afasta-te para o lado até haver tensão no cabo. ';
      return '$anchor'
          '2. Fica de lado para o ponto de fixação, com os pés à largura dos ombros e joelhos suaves. '
          '3. Segura a pega ou o elástico com as duas mãos junto ao peito. '
          '4. Ativa o abdómen e mantém a bacia e os ombros virados para a frente. '
          '5. Empurra as mãos em linha reta à frente do peito, estendendo os braços. '
          '6. A resistência vai tentar rodar o teu tronco: resiste sem deixar rodar. '
          '7. Mantém os braços estendidos 2 a 3 segundos e volta com as mãos ao peito devagar. '
          '8. Expira ao empurrar e inspira ao recolher. '
          '9. Completa as repetições de um lado e vira-te para trabalhar o outro. '
          '10. Reduz a tensão se a anca rodar ou os ombros subirem.';
    }
    if (n == 'elevacao de pernas') {
      return '1. Deita-te de costas num tapete, com as pernas estendidas e as mãos ao lado do corpo ou debaixo da bacia. '
          '2. Encosta a lombar ao chão ativando o abdómen antes de mexer as pernas. '
          '3. Eleva as duas pernas juntas até perto da vertical, com os joelhos quase esticados. '
          '4. Desce as pernas devagar, juntas, na direção do chão. '
          '5. Para a descida no ponto em que a lombar começar a arquear. '
          '6. Volta a subir as pernas sem impulso nem balanço. '
          '7. Expira ao descer as pernas e inspira ao subir. '
          '8. Dobra os joelhos para facilitar o exercício. '
          '9. Mantém o pescoço relaxado e os ombros no chão. '
          '10. Termina a série quando a lombar deixar de conseguir ficar encostada.';
    }
    if (_has(n, ['elevacao de joelhos suspenso'])) {
      return '1. Segura uma barra fixa firme com as duas mãos à largura dos ombros e fica pendurado. '
          '2. Ativa os ombros e o abdómen para o corpo não balançar. '
          '3. Sobe os dois joelhos juntos na direção do peito, enrolando ligeiramente a bacia no fim. '
          '4. Sobe até os joelhos passarem a altura da anca, ou mais alto se controlares. '
          '5. Faz uma pausa curta no topo. '
          '6. Desce as pernas devagar até ficarem esticadas, sem balancear. '
          '7. Expira ao subir os joelhos e inspira ao descer. '
          '8. Se balançares, para, estabiliza e só depois continua. '
          '9. Termina antes de a pega falhar; desce com apoio dos pés se possível.';
    }
    if (_has(n, ['hollow hold'])) {
      return '1. Deita-te de costas num tapete com as pernas estendidas e os braços ao lado do corpo. '
          '2. Encosta a lombar ao chão ativando o abdómen: esta é a regra principal do exercício. '
          '3. Eleva os ombros e a cabeça alguns centímetros do chão. '
          '4. Eleva as pernas esticadas a um palmo ou dois do chão. '
          '5. Se controlares, estende os braços atrás da cabeça para dificultar. '
          '6. O corpo fica em forma de canoa, curvado e firme. '
          '7. Mantém 10 a 30 segundos, respirando de forma curta e contínua, sem prender o ar. '
          '8. Desce devagar e descansa. '
          '9. Dobra os joelhos ou mantém os braços à frente para facilitar. '
          '10. Termina no momento em que a lombar descolar do chão.';
    }
    if (_has(n, ['flutter kicks'])) {
      return '1. Deita-te de costas com as pernas estendidas e as mãos ao lado do corpo ou debaixo da bacia. '
          '2. Encosta a lombar ao chão ativando o abdómen. '
          '3. Eleva as duas pernas a um palmo ou dois do chão. '
          '4. Bate as pernas alternadamente para cima e para baixo, em movimentos pequenos e rápidos, como a nadar. '
          '5. Mantém os joelhos quase esticados e os tornozelos relaxados. '
          '6. Mantém os ombros e o pescoço descontraídos no chão. '
          '7. Respira de forma contínua durante as batidas. '
          '8. Trabalha 15 a 30 segundos por série. '
          '9. Sobe as pernas um pouco mais alto se a lombar arquear. '
          '10. Termina quando deixares de conseguir manter a lombar encostada.';
    }
    if (_has(n, ['toe touches'])) {
      return '1. Deita-te de costas com as pernas elevadas na vertical e os joelhos quase esticados. '
          '2. Estende os braços na direção dos pés, com as mãos apontadas ao teto. '
          '3. Encosta a lombar ao chão e recolhe ligeiramente o queixo. '
          '4. Sobe os ombros do chão levando as mãos na direção dos dedos dos pés. '
          '5. O movimento é curto: sobe só até as omoplatas saírem do chão. '
          '6. Faz uma pausa de um segundo no topo, apertando o abdómen. '
          '7. Desce devagar até os ombros tocarem no chão. '
          '8. Expira ao subir e inspira ao descer. '
          '9. Não puxes o pescoço com as mãos nem balances as pernas. '
          '10. Dobra ligeiramente os joelhos se os posteriores repuxarem.';
    }
    if (n == 'superman') {
      return '1. Deita-te de barriga para baixo num tapete, com os braços estendidos à frente e as pernas esticadas. '
          '2. Mantém o olhar para o chão e o pescoço comprido. '
          '3. Eleva ao mesmo tempo braços, peito e pernas alguns centímetros do chão. '
          '4. Aperta os glúteos e a lombar no topo do movimento. '
          '5. Faz uma pausa de um a dois segundos em cima. '
          '6. Desce devagar até relaxar no chão. '
          '7. Expira ao subir e inspira ao descer. '
          '8. Procura um movimento pequeno e controlado, não altura máxima. '
          '9. Levanta só os braços ou só as pernas para facilitar. '
          '10. Para se sentires apertar ou dor na lombar.';
    }
    if (_has(n, ['reverse crunch'])) {
      return '1. Deita-te de costas com os joelhos dobrados a 90 graus e as canelas paralelas ao chão. '
          '2. Coloca as mãos ao lado do corpo, com as palmas no chão. '
          '3. Encosta a lombar ao chão ativando o abdómen. '
          '4. Enrola a bacia para cima, levando os joelhos na direção do peito. '
          '5. As ancas sobem ligeiramente do chão no fim do movimento; não uses impulso das pernas. '
          '6. Faz uma pausa curta em cima. '
          '7. Desce a bacia devagar até os joelhos voltarem à vertical. '
          '8. Expira ao enrolar e inspira ao descer. '
          '9. Mantém o pescoço e os ombros relaxados no chão. '
          '10. Faz o movimento pequeno e lento: o objetivo é enrolar, não balançar.';
    }
    if (_has(n, ['bicycle crunch'])) {
      return '1. Deita-te de costas com as mãos ao lado da cabeça e as pernas elevadas, joelhos dobrados. '
          '2. Encosta a lombar ao chão e recolhe ligeiramente o queixo. '
          '3. Sobe os ombros do chão e roda o tronco levando um cotovelo na direção do joelho contrário. '
          '4. Ao mesmo tempo, estende a outra perna à frente, sem a deixar cair no chão. '
          '5. Troca de lado num movimento contínuo, como a pedalar. '
          '6. Roda a partir do tronco, sem puxar o pescoço com as mãos. '
          '7. Expira em cada rotação e inspira na troca. '
          '8. Faz o movimento devagar e com pausa curta em cada lado. '
          '9. Estende menos a perna se a lombar arquear. '
          '10. Termina quando o pescoço começar a fazer o trabalho do abdómen.';
    }
    // Cardio sem equipamento.
    if (_has(n, ['jumping jacks'])) {
      return '1. Fica de pé com os pés juntos e os braços ao lado do corpo. '
          '2. Salta abrindo as pernas para os lados e, ao mesmo tempo, sobe os braços por cima da cabeça. '
          '3. Aterra com os pés um pouco mais afastados que os ombros e os joelhos suaves. '
          '4. Salta de novo fechando as pernas e descendo os braços ao lado do corpo. '
          '5. Aterra sempre na parte da frente dos pés, em silêncio. '
          '6. Mantém o tronco direito e o abdómen levemente ativo. '
          '7. Respira de forma contínua ao ritmo dos saltos. '
          '8. Começa devagar e aumenta o ritmo aos poucos. '
          '9. Trabalha 20 a 60 segundos por bloco. '
          '10. Faz o movimento a caminhar (abrir e fechar sem saltar) para reduzir o impacto.';
    }
    if (_has(n, ['skaters'])) {
      return '1. Fica de pé com os pés à largura da anca e os joelhos ligeiramente dobrados. '
          '2. Salta para o lado com uma perna, aterrando nesse pé com o joelho suave. '
          '3. Deixa a outra perna cruzar por trás, sem apoiar ou tocando só com a ponta. '
          '4. Balança os braços ao ritmo, como um patinador. '
          '5. Salta de seguida para o outro lado, empurrando com a perna de apoio. '
          '6. Aterra sempre em silêncio, com o joelho alinhado com o pé. '
          '7. Respira de forma contínua ao ritmo dos saltos. '
          '8. Começa com saltos curtos e aumenta a distância aos poucos. '
          '9. Trabalha 20 a 40 segundos por bloco. '
          '10. Reduz a distância do salto se o joelho cair para dentro na aterragem.';
    }
    if (_has(n, ['high knees'])) {
      return '1. Fica de pé com o tronco direito e o olhar em frente. '
          '2. Corre no lugar elevando um joelho de cada vez até à altura da anca. '
          '3. Aterra na parte da frente dos pés, com passos leves e rápidos. '
          '4. Usa os braços dobrados a 90 graus, a bombear ao ritmo da corrida. '
          '5. Mantém o abdómen ativo para o tronco não inclinar para trás. '
          '6. Respira de forma contínua e ritmada. '
          '7. Começa com joelhos à altura média e sobe conforme o controlo. '
          '8. Trabalha 15 a 30 segundos por bloco. '
          '9. Marcha no lugar elevando os joelhos, sem correr, para reduzir o impacto. '
          '10. Para se perderes a postura ou o ritmo respiratório.';
    }
    if (_has(n, ['marcha no lugar'])) {
      return '1. Fica de pé com o tronco direito e os braços soltos ao lado do corpo. '
          '2. Marcha no lugar elevando um joelho de cada vez, a uma altura confortável. '
          '3. Pousa o pé inteiro com suavidade a cada passo. '
          '4. Balança os braços de forma natural, como numa caminhada. '
          '5. Mantém os ombros relaxados e o olhar em frente. '
          '6. Respira de forma calma e contínua. '
          '7. Aumenta o ritmo ou a altura dos joelhos para intensificar. '
          '8. Marcha 1 a 3 minutos como aquecimento ou pausa ativa. '
          '9. Baixa o ritmo gradualmente antes de parar.';
    }
    // Jiu-Jitsu — drills de solo.
    if (_has(n, ['shrimp', 'fuga de anca'])) {
      return '1. Deita-te de costas no tatami ou tapete, com os joelhos dobrados e os pés apoiados; o objetivo é criar espaço e recuperar a guarda. '
          '2. Mantém as mãos à frente do peito, como se protegesses a guarda contra um adversário. '
          '3. Vira-te ligeiramente para um lado e apoia bem o pé da perna de cima. '
          '4. Empurra o chão com esse pé e com o ombro de baixo, levantando a anca. '
          '5. Ao mesmo tempo, dispara a anca para trás, afastando-a do lado para onde olhaste. '
          '6. Termina deitado de lado, encolhido, com espaço criado, em base controlada. '
          '7. Volta ao centro com controlo e repete para o outro lado. '
          '8. Expira ao empurrar a anca e inspira ao voltar. '
          '9. Faz o movimento devagar até fixares o padrão; a velocidade vem depois. '
          '10. Para se o pescoço ou a lombar começarem a forçar.';
    }
    if (_has(n, ['ponte de grappling'])) {
      return '1. Deita-te de costas no tatami ou tapete, com os joelhos dobrados e os pés perto dos glúteos; o objetivo é desequilibrar um adversário por cima. '
          '2. Mantém os braços dobrados junto ao peito, a proteger a guarda. '
          '3. Apoia bem os dois pés e, se for a ponte com viragem, também um ombro. '
          '4. Empurra o chão com os pés e dispara a anca para cima, o mais alto que conseguires. '
          '5. Rola o peso para um ombro, olhando por cima dele, como se quisesses virar alguém. '
          '6. Mantém o controlo do pescoço: o apoio é no ombro, não na cabeça. '
          '7. Desce a anca com controlo e volta à base inicial. '
          '8. Expira ao subir a ponte e inspira ao descer. '
          '9. Alterna os lados da viragem. '
          '10. Para se sentires pressão no pescoço ou na lombar.';
    }
    if (_has(n, ['technical stand-up'])) {
      return '1. Começa sentado no tatami ou tapete, com uma mão atrás no chão e o pé do lado contrário apoiado; o objetivo é levantar-te protegido. '
          '2. Mantém a outra mão à frente, em guarda, a proteger a cara. '
          '3. Apoia com força a mão de trás e o pé da frente no chão. '
          '4. Levanta a anca e passa a perna livre por baixo do corpo, para trás. '
          '5. Pousa esse pé atrás, ficando numa base estável, com um pé à frente e outro atrás. '
          '6. Sobe o tronco e termina de pé, com a guarda organizada e o olhar em frente. '
          '7. Inverte o movimento para voltar a sentar com controlo. '
          '8. Respira a cada repetição, sem prender o ar. '
          '9. Alterna o lado do apoio a cada repetição. '
          '10. Faz devagar até o padrão sair sem pensar; só depois acelera.';
    }
    if (n == 'sprawl') {
      return '1. Começa de pé numa base de luta, com os joelhos fletidos e a guarda à frente; o objetivo é defender uma entrada às pernas. '
          '2. Deixa cair a anca para baixo e para trás, atirando as pernas esticadas para trás. '
          '3. Apoia as mãos ou os antebraços no chão à frente do peito. '
          '4. Termina com a anca baixa e pesada contra o chão e as pernas afastadas atrás. '
          '5. Mantém o peito alto e o olhar em frente, sem deixar os joelhos tocar primeiro. '
          '6. Recolhe as pernas com um salto curto e volta à base de pé, com a guarda organizada. '
          '7. Expira ao atirar as pernas atrás e inspira ao subir. '
          '8. Faz devagar no início, com controlo da descida. '
          '9. Repete em séries curtas de 20 a 40 segundos. '
          '10. Para se a lombar ou os ombros perderem o controlo da queda.';
    }
    return null;
  }

  static String? _lowerBodyGapSteps(String name) {
    final n = _n(name);
    if (_has(n, ['short foot', 'doming'])) {
      return '1. Senta-te ou fica de pé descalço, com calcanhar, base do dedo grande e base do dedo pequeno no chão. '
          '2. Mantém os dedos compridos e relaxados, sem os enrolar. '
          '3. Aproxima suavemente a base do dedo grande do calcanhar para elevar um pouco o arco plantar. '
          '4. Mantém os três pontos do pé no chão e o joelho alinhado com o segundo dedo. '
          '5. Sustém a contração durante 5 a 10 segundos sem prender a respiração. '
          '6. Relaxa devagar até o arco voltar à posição inicial. '
          '7. Expira ao formar o arco e inspira ao relaxar. '
          '8. Reduz a força se os dedos enrolarem, o pé rodar para fora ou surgir cãibra.';
    }
    if (_has(n, ['flexao ativa dos dedos do pe'])) {
      return '1. Senta-te descalço com o pé inteiro apoiado no chão e o tornozelo por baixo do joelho. '
          '2. Abre e alonga os dedos sem levantar o calcanhar. '
          '3. Pressiona as pontas dos dedos contra o chão sem os dobrar até criar dor. '
          '4. Flete os dedos suavemente enquanto o arco e o calcanhar permanecem estáveis. '
          '5. Pausa dois segundos e confirma que o joelho não rodou. '
          '6. Estende e afasta novamente os dedos com controlo. '
          '7. Respira continuamente e faz cada repetição em três a quatro segundos. '
          '8. Pára se aparecer cãibra persistente, dor nos dedos ou compensação do tornozelo.';
    }
    if (_has(n, ['dorsiflexao do tornozelo'])) {
      return '1. Senta-te com a perna apoiada e prende o elástico num ponto baixo à frente do pé. '
          '2. Coloca o elástico sobre o peito do pé, deixando os dedos livres e o calcanhar no chão. '
          '3. Alinha joelho, tornozelo e segundo dedo sem rodar a anca. '
          '4. Puxa a ponta do pé para a canela sem levantar o calcanhar. '
          '5. Pausa um segundo quando sentires a frente da canela a trabalhar. '
          '6. Deixa o pé descer em dois a três segundos sem o elástico puxar de repente. '
          '7. Expira ao levantar o pé e inspira no retorno. '
          '8. Usa menos tensão se os dedos apertarem, o joelho mexer ou o tornozelo inclinar.';
    }
    if (_has(n, ['inversao do tornozelo'])) {
      return '1. Senta-te e prende o elástico ao lado exterior do pé que vai trabalhar. '
          '2. Passa o elástico pela parte da frente do pé e mantém calcanhar apoiado. '
          '3. Alinha a perna e segura o joelho para ele não acompanhar o movimento. '
          '4. Vira lentamente a planta do pé para dentro numa amplitude pequena e sem dor. '
          '5. Mantém os dedos relaxados e pausa um segundo. '
          '6. Regressa em dois a três segundos até o pé ficar neutro. '
          '7. Expira ao puxar e inspira ao voltar. '
          '8. Reduz a tensão se o joelho rodar ou surgir dor na face interna do tornozelo.';
    }
    if (_has(n, ['eversao do tornozelo'])) {
      return '1. Senta-te e prende o elástico ao lado interior do pé que vai trabalhar. '
          '2. Passa o elástico pela parte da frente do pé, com o calcanhar apoiado. '
          '3. Mantém joelho e anca imóveis e os dedos relaxados. '
          '4. Vira a planta do pé para fora sem levantar ou arrastar o calcanhar. '
          '5. Pausa um segundo sentindo a zona lateral da perna. '
          '6. Regressa devagar à posição neutra sem deixar o elástico puxar. '
          '7. Expira ao afastar e inspira no retorno. '
          '8. Usa menor amplitude se houver desconforto lateral ou se a perna rodar.';
    }
    if (_has(n, ['flexao da anca em pe'])) {
      return '1. Prende o elástico num ponto baixo atrás de ti e coloca-o à volta do pé ou tornozelo. '
          '2. Fica alto junto a uma parede para apoio, com pés paralelos e bacia nivelada. '
          '3. Ativa ligeiramente o abdómen sem inclinar o tronco para trás. '
          '4. Eleva o joelho à frente pela anca até à altura que controlas. '
          '5. Pausa um segundo sem rodar a bacia nem encolher o ombro de apoio. '
          '6. Baixa o pé em dois a três segundos até tocar no chão. '
          '7. Expira ao elevar o joelho e inspira ao baixar. '
          '8. Reduz a resistência se precisares de balançar ou arquear a lombar.';
    }
    if (_has(n, ['copenhagen plank'])) {
      return '1. Deita-te de lado com o antebraço por baixo do ombro e um banco estável junto aos pés. '
          '2. Apoia a parte interna do joelho da perna de cima no banco; mantém a perna de baixo no chão para ajudar. '
          '3. Alinha cabeça, costelas e bacia e aponta os dois joelhos para a frente. '
          '4. Pressiona o joelho de cima contra o banco e eleva a anca alguns centímetros. '
          '5. Mantém 5 a 15 segundos sem deixar o ombro colapsar ou a bacia rodar. '
          '6. Baixa a anca devagar e descansa antes de repetir do outro lado. '
          '7. Respira continuamente durante a sustentação. '
          '8. Usa a perna de baixo no chão e menor duração se sentires esforço excessivo na virilha.';
    }
    if (_has(n, ['extensao terminal do joelho'])) {
      return '1. Prende o elástico atrás do joelho a um ponto firme e coloca-o na dobra posterior da perna. '
          '2. Recua até haver tensão com o joelho ligeiramente fletido e o pé inteiro no chão. '
          '3. Alinha anca, joelho e segundo dedo do pé sem rodar a bacia. '
          '4. Estende o joelho pressionando-o para trás até a perna ficar direita, sem hiperextender. '
          '5. Contrai o quadríceps durante um a dois segundos. '
          '6. Deixa o joelho fletir lentamente sem o pé ou a anca mexerem. '
          '7. Expira ao estender e inspira ao regressar. '
          '8. Reduz a tensão se o joelho colapsar para dentro ou surgir dor articular.';
    }
    if (_has(n, ['abducao de anca deitada'])) {
      return '1. Deita-te de lado com a perna de baixo dobrada e a de cima estendida. '
          '2. Alinha cabeça, ombros, bacia e calcanhar de cima; usa a mão no chão para equilíbrio. '
          '3. Mantém a bacia empilhada e roda ligeiramente os dedos do pé para a frente ou para baixo. '
          '4. Eleva a perna de cima 20 a 30 centímetros sem inclinar o tronco. '
          '5. Pausa quando sentires a lateral da anca, não a frente da coxa. '
          '6. Baixa em dois a três segundos sem deixar a perna cair. '
          '7. Expira ao elevar e inspira ao baixar. '
          '8. Reduz a amplitude se a bacia rodar para trás ou a lombar apertar.';
    }
    return null;
  }

  static String _curlSteps(String name, String equipment) =>
      '1. Fica de pé ou sentado com pés firmes, peito alto e abdómen ligeiramente ativo. '
      '2. Segura $equipment com a pega da variação, mantendo punhos direitos e ombros relaxados. '
      '3. Encosta os cotovelos ao lado do tronco ou mantém-nos ligeiramente à frente se a variação pedir. '
      '4. Sobe o peso dobrando apenas os cotovelos, sem atirar a anca para a frente nem inclinar as costas. '
      '5. Para perto do topo quando o antebraço se aproxima do braço e sentes contração no braço. '
      '6. Desce durante 2 a 3 segundos até quase estender os cotovelos, mantendo punhos alinhados. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Reduz a carga se os ombros subirem, os cotovelos fugirem ou o tronco balançar.';

  static String _curlInversoSteps(String equipment) =>
      '1. Fica de pé com pés à largura da anca, joelhos soltos e tronco alto. '
      '2. Segura $equipment à frente das coxas com pega pronada: palmas viradas para baixo e nós dos dedos para a frente. '
      '3. Mantém os punhos alinhados, cotovelos junto ao tronco e ombros afastados das orelhas. '
      '4. Sobe o peso dobrando os cotovelos sem rodar os punhos para cima. '
      '5. Para quando os antebraços ficarem perto da horizontal ou quando começares a perder a pega pronada. '
      '6. Desce devagar até quase estender os cotovelos, sem deixar os halteres cair. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Usa carga leve se sentires tensão excessiva no punho, porque este exercício é mais duro para antebraço e braquiorradial.';

  static String _crossBodyCurlSteps() =>
      '1. Fica de pé com pés firmes, tronco alto e um halter em cada mão. '
      '2. Usa pega neutra, com as palmas viradas uma para a outra e punhos direitos. '
      '3. Mantém o cotovelo do lado que trabalha perto das costelas. '
      '4. Sobe o halter em diagonal em direção ao peito ou ombro oposto, como se cruzasses a linha do corpo. '
      '5. Não rode o tronco e não leves o ombro para a frente para ganhar altura. '
      '6. Desce pelo mesmo caminho diagonal até quase estender o cotovelo. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Alterna lados com controlo e pára a série se o punho deixar de ficar alinhado.';

  static String _hammerCurlSteps(String equipment) =>
      '1. Fica alto, pés firmes e $equipment ao lado do corpo. '
      '2. Usa pega neutra, palmas viradas uma para a outra, como se segurasses dois martelos. '
      '3. Mantém cotovelos perto do tronco e ombros relaxados. '
      '4. Sobe os halteres em linha reta até perto dos ombros, sem rodar as palmas para cima. '
      '5. Sente o esforço no braquial, braquiorradial e bíceps. '
      '6. Desce lentamente até quase estender os braços. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Não balances o tronco para conseguir a repetição.';

  static String _zottmanSteps(String equipment) =>
      '1. Fica de pé com $equipment nas mãos, palmas viradas para a frente. '
      '2. Sobe como num curl normal, mantendo cotovelos perto do tronco. '
      '3. No topo, roda os punhos devagar até as palmas ficarem viradas para baixo. '
      '4. Desce nessa pega pronada durante 2 a 3 segundos. '
      '5. No fundo, volta a rodar as palmas para a frente antes da repetição seguinte. '
      '6. Mantém punhos alinhados e ombros quietos. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Usa carga leve porque a descida em pronação exige muito do antebraço.';

  static String _cableCurlSteps() =>
      '1. Coloca a polia baixa e prende uma barra reta, corda ou pega adequada. '
      '2. Fica de frente para a polia, pés firmes, cabo já com ligeira tensão. '
      '3. Segura a pega com punhos alinhados e cotovelos junto ao tronco. '
      '4. Sobe a pega dobrando os cotovelos, sem deixar o cabo puxar os ombros para a frente. '
      '5. Contraí no topo sem encostar a pega ao peito. '
      '6. Desce devagar até quase estender os cotovelos, sem deixar as placas baterem. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Afasta-te ou aproxima-te da polia até a tensão ficar constante e controlável.';

  static String _forearmGripSteps(String name, String equipment) {
    final n = _n(name);
    if (_has(n, ['farmer walk', 'suitcase carry'])) {
      return '1. Coloca os halteres ou cargas ao lado dos pés. 2. Agacha ligeiramente, pega nas cargas com punhos direitos e levanta-te com coluna neutra. 3. Mantém peito alto, ombros baixos e abdómen ativo. 4. Caminha devagar com passos curtos, sem deixar a carga bater nas pernas. 5. Mantém os punhos alinhados e aperta as pegas sem encolher os ombros. 6. Pousa as cargas dobrando joelhos e anca, não arredondando a lombar. 7. Respira de forma contínua durante a caminhada. 8. Pára se a pega começar a abrir ou se perderes postura.';
    }
    if (_has(n, ['farmer hold', 'hold estatico', 'aperto'])) {
      return '1. Segura os halteres ao lado do corpo com as mãos fechadas e punhos direitos. 2. Fica de pé com pés à largura da anca, peito alto e ombros afastados das orelhas. 3. Aperta as pegas como se quisesses marcar os dedos no metal. 4. Mantém os braços esticados sem bloquear agressivamente os cotovelos. 5. Aguenta 10 a 30 segundos, respirando sem prender o ar. 6. Pousa os halteres antes de a pega falhar completamente. 7. Usa carga menor se os punhos dobrarem ou se o tronco inclinar.';
    }
    if (_has(n, ['reverse wrist'])) {
      return '1. Senta-te com os antebraços apoiados e palmas viradas para baixo. 2. Segura $equipment com pega leve, deixando os punhos fora do banco ou das coxas. 3. Mantém cotovelos parados e ombros relaxados. 4. Sobe os nós dos dedos para cima, como se quisesses apontar as costas da mão para o teto. 5. Para antes de sentir dor na parte de cima do punho. 6. Baixa a carga devagar até os punhos voltarem a ficar alinhados ou ligeiramente fletidos. 7. Expira ao levantar os nós dos dedos e inspira ao baixar. 8. Usa carga menor se precisares de mexer cotovelos ou ombros para subir.';
    }
    if (_has(n, ['wrist curl'])) {
      return '1. Senta-te com antebraços apoiados nas coxas e palmas viradas para cima. 2. Deixa só as mãos fora do apoio, segurando $equipment com dedos fechados. 3. Baixa os nós dos dedos na direção do chão até sentires alongamento na parte interna do antebraço. 4. Fecha a pega e dobra os punhos para trazer as palmas na direção do antebraço. 5. Sobe apenas pela flexão do punho, sem levantar os antebraços. 6. Mantém cotovelos colados ao apoio. 7. Desce durante 2 segundos e inspira nessa fase. 8. Expira ao fletir os punhos. 9. Termina se aparecer dor na parte da frente do punho.';
    }
    if (_has(n, ['pronacao'])) {
      return '1. Senta-te com o cotovelo apoiado a 90 graus e o antebraço estável. 2. Segura um halter leve por uma ponta, como uma alavanca curta. 3. Começa com a palma virada para dentro. 4. Roda devagar até a palma apontar para baixo. 5. Mantém cotovelo parado e punho alinhado. 6. Volta à posição inicial sem deixar o peso cair. 7. Respira devagar e usa amplitude sem dor. 8. Usa carga muito leve, porque a alavanca aumenta o esforço.';
    }
    if (_has(n, ['supinacao'])) {
      return '1. Apoia o cotovelo a 90 graus e segura um halter leve por uma ponta. 2. Começa com a palma virada para dentro ou ligeiramente para baixo. 3. Roda o antebraço devagar até a palma apontar para cima. 4. Mantém cotovelo colado ao apoio e punho direito. 5. Controla a volta sem bater no fim da amplitude. 6. Respira regularmente. 7. Trabalha devagar, sem usar o ombro para rodar. 8. Pára se houver dor no cotovelo ou punho.';
    }
    if (_has(n, ['finger'])) {
      return '1. Senta-te com antebraços apoiados e palmas viradas para cima. 2. Segura halteres leves junto aos dedos. 3. Deixa os halteres rolar cuidadosamente para a ponta dos dedos sem abrir a mão por completo. 4. Fecha os dedos novamente até a carga voltar para a palma. 5. Mantém punhos neutros e antebraços apoiados. 6. Faz repetições lentas, sem deixar o halter escapar. 7. Respira de forma contínua. 8. Usa carga muito leve e termina antes de perder a pega.';
    }
    return '1. Coloca-te numa posição estável e segura $equipment com punhos alinhados. 2. Define se o foco é segurar, rodar ou mover o punho antes de começar. 3. Mantém cotovelos controlados e ombros relaxados. 4. Executa a ação devagar, sem deixar a carga puxar o punho para uma posição dolorosa. 5. Pausa brevemente no ponto de maior esforço. 6. Regressa com controlo à posição inicial. 7. Respira sem prender o ar. 8. Usa carga leve se sentires dor, formigueiro ou perda de pega.';
  }

  static String _tricepsSteps(String name, String equipment) {
    final n = _n(name);
    if (_has(n, ['kickback'])) {
      return '1. Inclina o tronco à frente com coluna neutra e apoia uma mão num banco se precisares. 2. Segura o halter ou pega do cabo com o cotovelo dobrado a cerca de 90 graus. 3. Cola o braço ao lado do tronco, com o cotovelo apontado para trás. 4. Estende o cotovelo até o braço ficar quase direito, sem mexer o ombro. 5. Pausa um instante contraindo o tríceps. 6. Desce o antebraço devagar até voltar aos 90 graus. 7. Expira ao estender e inspira ao voltar. 8. Usa carga leve se o cotovelo cair ou se tiveres de balançar.';
    }
    if (_has(n, ['acima da cabeca', 'francesa'])) {
      return '1. Senta-te ou fica de pé com pés firmes e abdómen ativo. 2. Segura $equipment acima da cabeça com pega firme e punhos alinhados. 3. Mantém cotovelos apontados para a frente e próximos, sem abrir demasiado. 4. Desce o peso atrás da cabeça dobrando apenas os cotovelos. 5. Para quando sentires alongamento confortável no tríceps, sem dor no ombro. 6. Estende os cotovelos para subir, mantendo costelas baixas e lombar neutra. 7. Inspira ao descer e expira ao subir. 8. Reduz a carga se os cotovelos abrirem ou a lombar arquear.';
    }
    if (_has(n, ['testa', 'deitado'])) {
      return '1. Deita-te num banco ou no chão e segura o peso acima do peito com pega firme. 2. Mantém punhos alinhados e braços ligeiramente inclinados para trás. 3. Dobra os cotovelos levando a carga em direção à testa ou ligeiramente atrás da cabeça. 4. Mantém os cotovelos apontados para cima, sem abrirem para os lados. 5. Estende os cotovelos até quase bloquear, contraindo o tríceps. 6. Inspira ao descer e expira ao estender. 7. Usa carga leve e controla a descida. 8. Pára se sentires dor no cotovelo ou ombro.';
    }
    if (_has(n, ['press fechado', 'supino fechado', 'tate press'])) {
      return '1. Deita-te num banco ou no chão com a barra acima do peito. 2. Usa pega mais fechada que num supino normal e punhos alinhados. 3. Mantém cotovelos relativamente perto do tronco. 4. Desce a barra para a zona média do peito com controlo. 5. Empurra para cima focando a extensão dos cotovelos e o tríceps. 6. Não deixes os ombros subir para as orelhas. 7. Inspira ao descer e expira ao empurrar. 8. Usa carga menor se os punhos dobrarem ou os cotovelos abrirem demais.';
    }
    return '1. Coloca-te numa base firme e segura $equipment com pega firme e punhos alinhados. 2. Mantém o braço estável para que o movimento venha sobretudo do cotovelo. 3. Dobra o cotovelo, descendo a mão até um alongamento controlado no tríceps. 4. Estende o cotovelo até quase endireitar o braço. 5. Mantém ombros baixos e costelas controladas. 6. Regressa devagar, controlando o retorno. 7. Expira ao estender e inspira ao dobrar. 8. Reduz o peso se houver dor no cotovelo, ombro ou punho.';
  }

  static String _pushupSteps(String name) {
    final n = _n(name);
    final handCue = _has(n, ['diamante'])
        ? 'mãos próximas, formando um losango ou triângulo por baixo do peito'
        : _has(n, ['fechada'])
        ? 'mãos à largura dos ombros ou ligeiramente mais juntas, por baixo do peito'
        : _has(n, ['aberta'])
        ? 'mãos bem mais abertas que os ombros'
        : 'mãos ligeiramente mais largas que os ombros';
    final footCue = _has(n, ['joelhos'])
        ? 'joelhos apoiados no chão e corpo em linha dos joelhos à cabeça'
        : _has(n, ['inclinada'])
        ? 'mãos num apoio alto e pés no chão'
        : _has(n, ['declinada'])
        ? 'pés num apoio alto e mãos no chão'
        : 'pés no chão e corpo em posição de prancha';
    return '1. Coloca $handCue. 2. Coloca $footCue. 3. Mantém abdómen ativo, glúteos ligeiramente contraídos e cabeça alinhada com a coluna. 4. Desce dobrando os cotovelos, levando o peito na direção do chão ou do apoio. 5. Mantém cotovelos controlados, sem abrir de forma agressiva para os lados. 6. Para quando o peito chegar perto do apoio ou quando perderes alinhamento. 7. Empurra o chão para voltar à posição inicial. 8. Inspira ao descer e expira ao subir. 9. Reduz a dificuldade elevando as mãos ou apoiando joelhos se a lombar cair.';
  }

  static String _pressSteps(String name, String equipment) =>
      '1. Posiciona-te no banco, chão ou máquina com pés bem apoiados. '
      '2. Segura $equipment com pega firme, punhos alinhados e cotovelos por baixo do peso. '
      '3. Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso. '
      '4. Desce o peso até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina. '
      '5. Mantém cotovelos guiados, sem abrir completamente para os lados. '
      '6. Empurra a carga para cima até quase estender os braços. '
      '7. Inspira ao descer e expira ao empurrar. '
      '8. Pára se perderes o controlo da carga ou se sentires dor no ombro.';

  static String _flySteps(String name, String equipment) =>
      '1. Deita-te ou posiciona-te de forma estável e segura $equipment com pega firme. '
      '2. Começa com braços à frente do peito e cotovelos ligeiramente dobrados. '
      '3. Mantém essa pequena dobra dos cotovelos durante toda a repetição. '
      '4. Abre os braços em arco até sentires alongamento confortável no peito, sem dor no ombro. '
      '5. Fecha o arco aproximando as mãos à frente do peito, sem bater as cargas. '
      '6. Mantém ombros baixos e escápulas controladas. '
      '7. Inspira ao abrir e expira ao fechar. '
      '8. Usa carga leve, porque este exercício exige mais controlo do que força bruta.';

  static String _facePullSteps(String equipment) {
    final elastic = _n(equipment).contains('elastico');
    final anchor = elastic
        ? '1. Prende o elástico num ponto firme à altura do rosto. '
        : '1. Coloca a polia do cabo na posição alta, à altura do rosto. ';
    final grip = elastic
        ? '2. Segura as pontas do elástico com pega firme e as palmas viradas uma para a outra. '
        : '2. Segura a corda com pega firme e as palmas viradas uma para a outra. ';
    final pull = elastic
        ? '4. Puxa o elástico em direção ao rosto, separando ligeiramente as mãos. '
        : '4. Puxa a corda em direção ao rosto, separando ligeiramente as mãos. ';
    return '$anchor'
        '$grip'
        '3. Dá um passo atrás até haver tensão e fica com tronco alto. '
        '$pull'
        '5. Leva os cotovelos para trás e para fora, juntando as escápulas sem encolher o pescoço. '
        '6. Para quando as mãos ficam perto das orelhas ou bochechas. '
        '7. Volta devagar até os braços estenderem sem perder tensão. '
        '8. Expira ao puxar e inspira ao voltar.';
  }

  static String _scapularHangSteps() =>
      '1. Segura a barra fixa com mãos firmes, à largura dos ombros ou um pouco mais abertas. '
      '2. Pendura o corpo com braços esticados e pés fora do chão ou apoiados para facilitar. '
      '3. Começa com ombros controlados, sem deixar o pescoço esmagado entre eles. '
      '4. Puxa as escápulas para baixo e ligeiramente para trás, como se quisesses afastar os ombros das orelhas. '
      '5. Não dobres os cotovelos; o movimento é pequeno e vem das escápulas. '
      '6. Segura 1 a 2 segundos e volta devagar ao alongamento controlado. '
      '7. Respira calmamente durante todo o movimento. '
      '8. Pára se houver dor no ombro, formigueiro nos dedos ou perda súbita de pega.';

  static String _pullUpSteps(String name) =>
      '1. Segura a barra fixa com a pega adequada ao $name. '
      '2. Começa pendurado com braços quase esticados, abdómen ativo e pernas controladas. '
      '3. Baixa os ombros antes de puxar, ativando as escápulas. '
      '4. Puxa o peito na direção da barra levando os cotovelos para baixo. '
      '5. Sobe até o queixo se aproximar da barra ou até à amplitude que controlas. '
      '6. Desce devagar até quase estender os braços, sem cair pendurado. '
      '7. Expira ao puxar e inspira ao descer. '
      '8. Usa assistência se precisares de balançar ou dar impulso.';

  static String _rowPullSteps(String name, String equipment) =>
      '1. Ajusta o corpo ou a máquina para conseguires puxar com coluna neutra. '
      '2. Segura $equipment com pega firme e punhos alinhados. '
      '3. Antes de puxar, baixa os ombros e sente as escápulas prontas a mexer. '
      '4. Puxa levando os cotovelos para trás ou para baixo, conforme o tipo de remada ou puxada. '
      '5. Mantém o peito aberto e evita atirar o tronco para trás para ganhar força. '
      '6. Para quando as costas contraem sem perder a posição da lombar. '
      '7. Volta devagar até os braços alongarem sem soltar totalmente as escápulas. '
      '8. Expira ao puxar e inspira ao voltar.';

  static String _shoulderSteps(String name, String equipment) {
    final n = _n(name);
    if (_has(n, ['elevacao lateral'])) {
      return '1. Fica de pé e segura um halter em cada mão ao lado do corpo, com os cotovelos ligeiramente dobrados. 2. Mantém punhos neutros e ombros afastados das orelhas. 3. Sobe os braços para os lados até perto da altura dos ombros. 4. Mantém os cotovelos ligeiramente acima ou na linha dos punhos. 5. Desce devagar sem deixar os halteres cair. 6. Expira ao subir e inspira ao descer. 7. Usa carga leve se precisares de balançar o tronco.';
    }
    if (_has(n, ['elevacao frontal'])) {
      return '1. Segura os halteres à frente das coxas com punhos alinhados. 2. Mantém tronco alto e costelas controladas. 3. Sobe um ou ambos os braços à frente até perto da altura dos ombros. 4. Evita encolher os ombros ou arquear a lombar. 5. Desce devagar até à posição inicial. 6. Expira ao subir e inspira ao descer. 7. Usa amplitude menor se houver desconforto no ombro.';
    }
    if (_has(n, ['reverse fly', 'elevacao posterior', 'y raise', 'w raise'])) {
      return '1. Fica com o tronco inclinado à frente ou apoia o peito num banco inclinado. 2. Segura halteres leves com os braços pendurados e o pescoço relaxado. 3. Abre os braços para os lados e ligeiramente para trás, até à linha dos ombros, focando ombros posteriores e escápulas. 4. Mantém cotovelos ligeiramente dobrados e punhos neutros. 5. Para antes de encolher o pescoço. 6. Desce devagar. 7. Expira ao abrir e inspira ao voltar. 8. Usa carga leve para não transformar em balanço.';
    }
    if (_has(n, ['rotacao externa'])) {
      return '1. Fica de pé ou sentado e mantém o cotovelo colado ao corpo, dobrado a 90 graus, com o antebraço à frente da barriga. 2. Segura o elástico ou a pega com o punho direito. 3. Roda o antebraço para fora, afastando a mão da barriga sem descolar o cotovelo. 4. Usa uma amplitude pequena e sem dor, sentindo a parte de trás do ombro. 5. Regressa devagar ao centro, controlando a resistência. 6. Escolhe uma resistência muito leve. 7. Expira ao rodar para fora e inspira no retorno.';
    }
    if (_has(n, ['rotacao interna'])) {
      return '1. Fica de pé ou sentado e mantém o cotovelo colado ao corpo, dobrado a 90 graus, com o antebraço apontado para fora. 2. Segura o elástico ou a pega com o punho direito. 3. Roda o antebraço para dentro, trazendo a mão em direção à barriga sem descolar o cotovelo. 4. Usa uma amplitude pequena e sem dor. 5. Regressa devagar à posição inicial, resistindo à tração. 6. Escolhe uma resistência muito leve. 7. Expira ao rodar para dentro e inspira no retorno.';
    }
    return '1. Fica em base estável com $equipment controlado. 2. Mantém tronco alto, abdómen ativo e ombros afastados das orelhas. 3. Leva o peso ou os braços pela trajetória do exercício sem perder punhos alinhados. 4. Para na amplitude em que controlas o ombro sem dor. 5. Regressa devagar, controlando o retorno. 6. Expira na fase de esforço e inspira no retorno. 7. Reduz o peso se precisares de inclinar o tronco ou encolher o pescoço.';
  }

  static String _squatSteps(String name, String equipment) =>
      '1. Fica com os pés à largura dos ombros e as pontas dos pés ligeiramente viradas para fora. '
      '2. Posiciona $equipment de forma segura: ao peito, aos lados, nas costas ou sem carga. '
      '3. Mantém peito aberto, abdómen ativo e olhar em frente ou ligeiramente para baixo. '
      '4. Inicia levando a anca para trás e dobrando joelhos ao mesmo tempo. '
      '5. Mantém joelhos alinhados com os pés, sem caírem para dentro. '
      '6. Desce até onde consegues manter calcanhares apoiados e coluna neutra. '
      '7. Sobe empurrando o chão e estendendo anca e joelhos. '
      '8. Inspira ao descer e expira ao subir.';

  static String _lungeSteps(String name, String equipment) =>
      '1. Fica de pé com tronco alto e $equipment controlado. '
      '2. Dá um passo amplo à frente e mantém os pés à largura da bacia. '
      '3. Desce dobrando os dois joelhos, mantendo o joelho da frente alinhado com o pé. '
      '4. Mantém a anca estável e o tronco sem cair para a frente. '
      '5. Desce até amplitude confortável, sem bater o joelho de trás no chão. '
      '6. Empurra o chão com o pé da frente para voltar ou avançar. '
      '7. Inspira ao descer e expira ao subir. '
      '8. Reduz a passada se perderes equilíbrio ou sentires dor no joelho.';

  static String _hingeSteps(String name, String equipment) =>
      '1. Fica com os pés firmes à largura da anca e, se o exercício usar peso, mantém-no colado ao corpo. '
      '2. Mantém peito aberto, coluna neutra e joelhos ligeiramente fletidos. '
      '3. Começa levando a anca para trás, como se fosses fechar uma porta com os glúteos. '
      '4. Deixa as mãos, ou o peso, descerem junto às pernas, sem afastar do corpo. '
      '5. Para quando sentires alongamento no posterior de coxa sem arredondar a lombar. '
      '6. Regressa apertando glúteos e estendendo a anca até ficar alto novamente. '
      '7. Inspira ao descer e expira ao subir. '
      '8. Pára se a lombar perder posição, se houver dor aguda ou formigueiro.';

  static String _calfSteps(String name, String equipment) =>
      '1. Coloca os pés firmes no chão ou num degrau estável. '
      '2. Mantém joelhos esticados para gémeos ou ligeiramente dobrados para sóleo. '
      '3. Segura $equipment ou um apoio apenas para equilíbrio. '
      '4. Sobe os calcanhares devagar até ficares na ponta dos pés. '
      '5. Pausa um instante no topo. '
      '6. Desce lentamente até sentir alongamento confortável. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Não deixes os tornozelos cair para dentro ou para fora.';

  static String _quadrupedBackExtensionSteps() =>
      '1. Apoia mãos e joelhos no tapete, com punhos debaixo dos ombros e joelhos debaixo da anca. '
      '2. Mantém o olhar no chão, costelas recolhidas e barriga levemente ativa. '
      '3. Inspira parado, sentindo a base dos quatro apoios firme. '
      '4. Ao expirar, desliza um pé para trás até a perna ficar longa sem rodar a bacia. '
      '5. Faz uma pausa curta com o tronco quieto e o glúteo ativo. '
      '6. Recolhe o joelho pelo mesmo caminho, sem tocar no chão com impacto. '
      '7. Alterna lados ou completa a série mantendo a coluna neutra.';

  static String _coreSteps(String name, String equipment) {
    final n = _n(name);
    if (_has(n, ['prancha'])) {
      return '1. Apoia os antebraços no chão com os cotovelos debaixo dos ombros. 2. Estica as pernas e fica em linha da cabeça aos calcanhares. 3. Contrai abdómen e glúteos sem levantar demasiado a anca. 4. Mantém pescoço neutro, olhando para o chão. 5. Respira curto e controlado, sem prender o ar. 6. Aguenta 10 a 40 segundos com boa forma. 7. Termina se a lombar começar a cair. 8. Para facilitar, apoia joelhos no chão.';
    }
    if (_has(n, ['crunch', 'toe touches'])) {
      return '1. Deita-te de barriga para cima com joelhos fletidos ou pernas na posição da variação. 2. Mantém lombar confortável e queixo ligeiramente recolhido. 3. Sobe a parte alta do tronco aproximando costelas da bacia. 4. Não puxes o pescoço com as mãos. 5. Pausa brevemente no topo. 6. Desce devagar até ombros quase tocarem no chão. 7. Expira ao subir e inspira ao descer. 8. Reduz amplitude se houver tensão no pescoço.';
    }
    if (_has(n, ['dead bug'])) {
      return '1. Deita-te de costas com os braços apontados ao teto e os joelhos dobrados a 90 graus no ar. 2. Encosta a lombar ao chão ativando o abdómen antes de mexer. 3. Estende devagar um braço atrás da cabeça e a perna contrária à frente, sem tocar no chão. 4. Mantém a lombar encostada durante toda a extensão. 5. Regressa ao centro com controlo e alterna os lados. 6. Usa menor amplitude se a lombar levantar. 7. Expira ao estender e inspira ao recolher.';
    }
    if (_has(n, ['bird dog'])) {
      return '1. Coloca-te em quatro apoios, com os punhos por baixo dos ombros e os joelhos por baixo da anca. 2. Ativa o abdómen e mantém o olhar no chão. 3. Estende ao mesmo tempo um braço em frente e a perna contrária atrás, até ficarem na linha do tronco. 4. Mantém a bacia nivelada, sem rodar para o lado. 5. Sustém um a dois segundos e regressa com controlo. 6. Alterna os lados sem pressa. 7. Expira ao estender e inspira ao regressar.';
    }
    return '1. Coloca-te na posição inicial do $name com coluna neutra e abdómen ativo. 2. Define se o exercício exige flexão, rotação ou resistência do tronco. 3. Move apenas até onde controlas a lombar. 4. Mantém respiração regular durante cada repetição ou tempo de suporte. 5. Evita puxar o pescoço ou balançar as pernas. 6. Regressa devagar à posição inicial. 7. Expira na fase de esforço e inspira no retorno. 8. Reduz amplitude se a lombar levantar ou houver dor.';
  }

  static String _cardioSteps(String name, String equipment) {
    final n = _n(name);
    if (_has(n, ['passadeira'])) {
      if (_has(n, ['aquecimento'])) {
        return '1. Sobe para a passadeira e começa numa caminhada muito fácil. 2. Mantém tronco alto, olhar em frente e passos curtos. 3. Caminha 5 a 10 minutos, aumentando a velocidade aos poucos. 4. Usa inclinação baixa ou zero se ainda estás a aquecer. 5. Respira de forma confortável, conseguindo falar frases completas. 6. Não comeces logo em corrida, sprint ou inclinação forte. 7. Termina quando sentires corpo quente e respiração ativa, mas controlada.';
      }
      if (_has(n, ['cooldown'])) {
        return '1. Depois da parte principal, reduz a velocidade gradualmente. 2. Se usaste inclinação, baixa primeiro a inclinação. 3. Caminha 3 a 8 minutos a ritmo fácil. 4. Mantém passadas curtas e tronco alto enquanto a respiração desacelera. 5. Usa os apoios apenas para equilíbrio, não para suportar o peso. 6. Sai só quando a passadeira estiver lenta ou parada. 7. Pára se houver tontura, dor no peito ou desequilíbrio.';
      }
      if (_has(n, ['interval', 'sprint', 'hiit'])) {
        return '1. Aquece 5 a 10 minutos na passadeira, em caminhada ou corrida leve. 2. Escolhe uma velocidade forte mas controlável para o intervalo. 3. Corre 20 a 60 segundos mantendo tronco alto e passada estável. 4. Recupera em caminhada ou trote leve durante 60 a 120 segundos. 5. Repete poucos blocos no início. 6. Respira de forma contínua e reduz se perderes técnica. 7. Faz 3 a 8 minutos de cooldown no fim.';
      }
      if (_has(n, ['inclinacao'])) {
        return '1. Começa na passadeira em caminhada fácil com inclinação baixa. 2. Aumenta a inclinação gradualmente sem agarrar os apoios. 3. Mantém tronco alto e passada curta, empurrando o chão com glúteos e gémeos. 4. Usa velocidade mais baixa do que numa caminhada plana. 5. Mantém 5 a 20 minutos conforme o nível. 6. Respira de forma regular. 7. Baixa a inclinação antes de terminar.';
      }
      return '1. Sobe para a passadeira e começa devagar. 2. Ajusta a velocidade para caminhada ou corrida leve. 3. Mantém tronco alto, olhar em frente e passadas controladas. 4. Evita aterrar muito à frente do corpo. 5. Mantém 5 a 20 minutos num ritmo sustentável. 6. Respira de forma contínua, sem prender o ar. 7. Reduz velocidade no fim antes de sair.';
    }
    if (_has(n, ['bicicleta'])) {
      if (_has(n, ['cooldown'])) {
        return '1. Senta-te bem no selim da bicicleta e baixa a resistência para nível fácil. 2. Pedala 3 a 8 minutos com cadência confortável. 3. Mantém tronco alto, ombros relaxados e mãos leves no guiador. 4. Deixa a respiração e a frequência cardíaca descerem gradualmente. 5. Não pares de pedalar de repente depois de esforço forte. 6. Termina quando te sentires estável. 7. Sai com cuidado, especialmente se as pernas estiverem pesadas.';
      }
      if (_has(n, ['aquecimento'])) {
        return '1. Ajusta o selim para o joelho ficar ligeiramente fletido no ponto baixo da pedalada. 2. Começa com resistência baixa. 3. Pedala 5 a 10 minutos com cadência confortável. 4. Mantém tronco alto e ombros relaxados. 5. Aumenta resistência apenas um pouco no fim do aquecimento. 6. Respira de forma fácil. 7. Avança para a parte principal quando as pernas estiverem quentes.';
      }
      if (_has(n, ['interval', 'hiit'])) {
        return '1. Ajusta selim e aquece 5 a 10 minutos com resistência leve. 2. Aumenta resistência ou cadência para um bloco forte de 20 a 60 segundos. 3. Mantém joelhos alinhados e não saltes no selim. 4. Recupera 60 a 120 segundos com resistência baixa. 5. Repete poucos blocos no início. 6. Respira de forma contínua. 7. Faz cooldown fácil no fim.';
      }
      return '1. Ajusta o selim antes de começar. 2. Pedala com resistência leve a moderada. 3. Mantém cadência regular e joelhos a seguir a linha dos pés. 4. Usa o guiador sem encolher os ombros. 5. Mantém 5 a 20 minutos conforme objetivo. 6. Respira de forma contínua. 7. Reduz resistência nos últimos minutos.';
    }
    if (_has(n, ['corda'])) return _jumpRopeSteps(name);
    if (_has(n, ['eliptica'])) {
      return '1. Sobe para a elíptica segurando os apoios. 2. Começa com resistência leve e movimento fluido. 3. Mantém tronco alto, pés apoiados e ombros relaxados. 4. Empurra e puxa os braços apenas se a máquina tiver pegas móveis. 5. Mantém ritmo contínuo por 5 a 20 minutos ou blocos intervalados. 6. Respira de forma regular. 7. Reduz resistência e ritmo no fim antes de sair.';
    }
    if (_has(n, ['burpees'])) {
      return '1. Fica de pé com espaço livre. 2. Agacha e coloca as mãos no chão. 3. Leva os pés para trás até prancha. 4. Faz flexão apenas se a variação pedir e conseguires controlar. 5. Traz os pés para perto das mãos. 6. Levanta-te ou salta baixo. 7. Trabalha em blocos de 20 a 40 segundos a ritmo calmo, respira a cada repetição e abranda se perderes a postura.';
    }
    return '1. Começa em pé com espaço livre e postura alta. 2. Começa em ritmo fácil nos primeiros 30 a 60 segundos para aquecer. 3. Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo. 4. Aumenta intensidade só se a coordenação continuar limpa. 5. Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo. 6. Respira de forma regular. 7. Abranda antes de parar totalmente.';
  }

  static String _jumpRopeSteps(String name) {
    final n = _n(name);
    final variation = _has(n, ['pes alternados'])
        ? 'alterna pé direito e pé esquerdo como uma corrida leve no sítio'
        : _has(n, ['joelhos altos'])
        ? 'eleva os joelhos um pouco mais a cada salto, sem perder ritmo'
        : _has(n, ['double unders'])
        ? 'faz a corda passar duas vezes por cada salto, apenas se já dominas o salto simples'
        : 'faz saltos baixos com os dois pés ou alterna de forma simples';
    return '1. Segura uma pega em cada mão com cotovelos próximos do corpo. 2. Mantém a corda atrás dos pés antes da primeira volta. 3. Roda a corda principalmente pelos punhos, não pelos ombros. 4. Salta baixo, apenas o suficiente para a corda passar. 5. $variation. 6. Aterra na parte da frente dos pés com joelhos ligeiramente flexionados. 7. Faz blocos de 30 a 60 segundos no início, respirando em ritmo constante. 8. Pára se tropeçares repetidamente, se os gémeos ficarem rígidos ou se perderes coordenação.';
  }

  static String _mobilitySteps(String name, String equipment) {
    final n = _n(name);
    if (_has(n, ['cervical', 'pescoco', 'chin tuck'])) {
      return '1. Senta-te ou fica de pé com coluna alta e ombros relaxados. 2. Mantém o olhar em frente e o maxilar solto. 3. Move a cabeça devagar na direção indicada pelo exercício, sem puxões. 4. Pára numa tensão leve, nunca em dor. 5. Mantém 15 a 30 segundos ou faz 5 a 8 repetições lentas. 6. Respira pelo nariz ou de forma calma. 7. Regressa ao centro antes de trocar de lado. 8. Termina se houver tontura, formigueiro ou dor a irradiar.';
    }
    if (_has(n, ['posterior', 'tocar nos pes'])) {
      return '1. Senta-te no chão com as pernas esticadas ou fica de pé com os pés juntos. 2. Mantém joelhos esticados mas não bloqueados com força. 3. Inclina o tronco pela anca, não enrolando a lombar em excesso. 4. Leva as mãos em direção aos pés apenas até tensão confortável atrás da coxa. 5. Respira devagar durante 20 a 40 segundos. 6. Sai da posição lentamente. 7. Repete sem balanços. 8. Dobra ligeiramente joelhos se houver dor ou puxão forte.';
    }
    if (_has(n, ['gluteo', 'piriforme', 'pigeon', 'figura 4', '90/90'])) {
      return '1. Cruza um tornozelo sobre a coxa contrária ou dobra a perna à frente do corpo, com a anca apoiada e estável. 2. Mantém coluna longa e mãos no chão ou na perna para equilíbrio. 3. Inclina o tronco ligeiramente até sentir tensão no glúteo ou piriforme. 4. Não forces o joelho para baixo com violência. 5. Mantém 20 a 40 segundos respirando devagar. 6. Sai da posição com as mãos a ajudar. 7. Troca de lado. 8. Pára se houver dor no joelho ou formigueiro.';
    }
    if (_has(n, ['quadriceps'])) {
      return '1. Fica de pé com uma mão num apoio, ou deita-te de lado se o equilíbrio for difícil. 2. Dobra o joelho e leva o calcanhar na direção do glúteo. 3. Segura o pé ou tornozelo sem torcer o joelho. 4. Mantém joelhos próximos e bacia ligeiramente encaixada. 5. Sente alongamento na frente da coxa durante 20 a 40 segundos. 6. Respira devagar. 7. Solta o pé com cuidado e troca de lado. 8. Não forces se houver dor no joelho.';
    }
    if (_has(n, [
      'ombro',
      'wall slides',
      'peitoral',
      'dorsal',
      'toracica',
      'cat-cow',
      'open book',
    ])) {
      return '1. Coloca-te na posição indicada, com coluna confortável e respiração calma. 2. Organiza ombros afastados das orelhas antes de mexer. 3. Move braços, escápulas ou coluna torácica devagar até amplitude confortável. 4. Não forces a frente do ombro nem a lombar. 5. Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas. 6. Respira durante todo o movimento. 7. Regressa devagar à posição inicial. 8. Pára se houver dor aguda ou formigueiro.';
    }
    if (_has(n, ['mobilidade de tornozelo na parede'])) {
      return '1. Fica de frente para uma parede com um pé a alguns centímetros dela. 2. Mantém o calcanhar desse pé totalmente apoiado no chão. 3. Leva o joelho devagar na direção da parede, alinhado com o segundo ou terceiro dedo do pé. 4. Para quando o calcanhar quiser levantar ou o arco do pé colapsar. 5. Volta o joelho para trás, mantendo a respiração calma, e repete 8 a 12 vezes. 7. Afasta ou aproxima o pé da parede para ajustar a dificuldade. 8. Pára se houver dor no tendão de Aquiles, tornozelo ou frente do pé.';
    }
    if (_has(n, ['circulos de tornozelo'])) {
      return '1. Senta-te ou fica de pé com apoio e tira ligeiramente um pé do chão. 2. Mantém a perna quieta e a respiração calma: o movimento vem só do tornozelo. 3. Desenha círculos lentos com a ponta do pé, primeiro para dentro e depois para fora. 4. Faz 6 a 10 círculos por direção. 5. Mantém os dedos relaxados, sem enrolar o pé. 6. Respira normalmente durante o movimento. 7. Troca de lado e repete. 8. Reduz o tamanho do círculo se houver dor ou estalidos desconfortáveis.';
    }
    if (_has(n, ['tornozelo', 'gemeos'])) {
      return '1. Coloca a ponta do pé contra a parede ou dá um passo atrás com o calcanhar no chão. 2. Mantém o calcanhar apoiado quando o objetivo for gémeos ou tornozelo. 3. Leva o joelho ou o tronco devagar até sentir tensão confortável. 4. Não deixes o arco do pé colapsar para dentro. 5. Mantém 20 a 40 segundos ou faz repetições lentas. 6. Respira calmamente. 7. Troca de lado. 8. Pára se houver dor no tendão de Aquiles ou tornozelo.';
    }
    if (_has(n, ['punho'])) {
      return '1. Ajoelha-te e apoia as mãos no chão à frente dos ombros. 2. Mantém cotovelos esticados sem bloquear com força. 3. Inclina o peso devagar até sentir tensão no antebraço ou punho. 4. Não forces se houver dor pontiaguda. 5. Mantém 15 a 30 segundos ou faz pequenas oscilações lentas. 6. Respira sem prender o ar. 7. Sai da posição devagar. 8. Abana as mãos levemente no fim.';
    }
    return '1. Entra numa posição confortável e estável. 2. Identifica a zona que deve alongar ou mexer. 3. Avança devagar até tensão leve e respirável. 4. Mantém 15 a 40 segundos ou faz 6 a 10 repetições controladas. 5. Não uses balanços rápidos. 6. Respira devagar durante todo o exercício. 7. Regressa lentamente à posição inicial. 8. Pára se houver dor aguda, tontura ou formigueiro.';
  }

  static String _karateSteps(String name) =>
      '1. Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada. '
      '2. Define o objetivo do $name antes de acelerar: técnica, deslocamento, golpe ou coordenação. '
      '3. Executa devagar, coordenando pés, anca, tronco, ombros e mãos. '
      '4. Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição. '
      '5. Respira no momento do esforço sem prender o ar. '
      '6. Trabalha blocos curtos de 30 a 60 segundos com técnica limpa. '
      '7. Aumenta velocidade só se manténs equilíbrio e controlo. '
      '8. Pára se houver dor articular, tontura ou perda de orientação.';

  static String _jiuJitsuSteps(String name) =>
      '1. Começa no tatami ou numa superfície segura, com espaço à volta. '
      '2. Define o objetivo técnico e a posição inicial: guarda, ponte, fuga de anca, base ou passagem. '
      '3. Move primeiro devagar, usando anca, core e apoios das mãos ou pés. '
      '4. Mantém queixo protegido, pescoço longo e respiração controlada. '
      '5. Regressa à posição inicial sem cair desorganizado. '
      '6. Repete durante 30 a 60 segundos mantendo precisão. '
      '7. Aumenta ritmo só se a técnica continuar limpa. '
      '8. Pára com dor no pescoço, ombro, joelho ou tontura.';

  static String _generalSpecificSteps(
    String name,
    String group,
    String equipment,
  ) =>
      '1. Coloca-te numa posição estável, com espaço livre e $equipment preparado. '
      '2. Organiza pés, tronco e cabeça antes de iniciar a repetição. '
      '3. Mantém ombros afastados das orelhas e punhos alinhados quando as mãos participarem. '
      '4. Executa a ação do exercício devagar até à amplitude em que controlas o músculo ou articulação trabalhados. '
      '5. Pausa um instante no ponto de maior esforço sem prender a respiração. '
      '6. Regressa devagar ao início, controlando o corpo até à posição de partida. '
      '7. Expira na fase de esforço e inspira no retorno. '
      '8. Reduz a dificuldade ou a amplitude se perderes alinhamento, equilíbrio ou controlo.';

  static List<String> _mistakesFor(
    String name,
    String group,
    String equipment,
  ) {
    final n = _n(name);
    if (_has(n, ['prancha lateral'])) {
      return [
        'deixar a anca descer ou rodar para trás',
        'apoiar o cotovelo longe da linha do ombro',
        'encolher o pescoço contra o ombro',
        'prender a respiração',
      ];
    }
    if (_has(n, ['isometria cervical posterior'])) {
      return [
        'empurrar com força a mais logo nas primeiras séries',
        'deixar a cabeça deslocar-se para trás em vez de ficar parada',
        'encolher os ombros durante a pressão',
        'prender a respiração',
      ];
    }
    if (_has(n, ['plano da omoplata'])) {
      return [
        'subir os braços acima da linha dos ombros com peso',
        'encolher os ombros durante a subida',
        'usar halteres pesados demais para controlar a descida',
        'balançar o tronco para ajudar',
      ];
    }
    if (_has(n, ['lenhador'])) {
      return [
        'rodar só os braços sem mover o tronco e a anca',
        'arredondar a lombar no fim da descida',
        'dar um puxão em vez de rodar de forma contínua',
        'usar carga alta demais para controlar o retorno',
      ];
    }
    if (_has(n, ['toque no ombro'])) {
      return [
        'deixar a bacia rodar a cada toque',
        'subir a anca para facilitar o movimento',
        'apressar os toques em vez de os fazer lentos',
        'deixar a lombar afundar',
      ];
    }
    if (_has(n, ['clamshell'])) {
      return [
        'deixar a bacia rolar para trás quando o joelho abre',
        'abrir o joelho com impulso',
        'separar os pés um do outro',
        'sentir só a frente da coxa, sinal de posição errada',
      ];
    }
    if (_has(n, ['curl nordico'])) {
      return [
        'dobrar a anca e transformar a descida numa vénia',
        'cair de repente sem travar com as coxas',
        'prender os pés num apoio instável',
        'fazer demasiadas repetições no primeiro treino',
      ];
    }
    if (_has(n, ['peso morto unilateral'])) {
      return [
        'rodar a bacia para cima durante a descida',
        'arredondar as costas para o halter chegar ao chão',
        'bloquear o joelho de apoio totalmente esticado',
        'olhar para a frente e perder o pescoço neutro',
      ];
    }
    if (_has(n, ['remo ergometro'])) {
      return [
        'puxar primeiro com os braços em vez de empurrar com as pernas',
        'arredondar as costas no início da remada',
        'subir a pega até ao queixo em vez das costelas',
        'usar resistência alta demais para manter a técnica',
      ];
    }
    if (_has(n, ['stepper'])) {
      return [
        'apoiar só a ponta do pé no degrau',
        'pendurar o corpo nos apoios das mãos',
        'deixar os joelhos cair para dentro',
        'subir mais rápido do que consegues manter',
      ];
    }
    if (_has(n, ['subida de escadas'])) {
      return [
        'apoiar só a ponta do pé no degrau',
        'puxar o corpo pelo corrimão',
        'descer a correr em vez de recuperar',
        'continuar com o passo já a falhar',
      ];
    }
    if (_has(n, ['air bike'])) {
      return [
        'pedalar só com as pernas e esquecer o guiador',
        'deixar o tronco balançar de um lado para o outro',
        'começar os blocos fortes demasiado rápido',
        'parar de repente no fim em vez de abrandar',
      ];
    }
    if (_has(n, ['shadow boxing'])) {
      return [
        'baixar as mãos depois de cada soco',
        'esticar o cotovelo com força no vazio',
        'cruzar os pés durante os deslocamentos',
        'prender a respiração nas combinações',
      ];
    }
    if (_has(n, ['shuttle runs'])) {
      return [
        'travar com as pernas esticadas',
        'curvar as costas ao tocar na linha',
        'arrancar antes de estares equilibrado',
        'usar piso escorregadio ou irregular',
      ];
    }
    if (_has(n, ['bases dachi'])) {
      return [
        'subir e descer a bacia entre posições',
        'deixar o joelho da frente cair para dentro',
        'inclinar o tronco à frente',
        'encurtar as bases para parecerem mais fáceis',
      ];
    }
    if (_has(n, ['bloqueios tecnicos'])) {
      return [
        'bloquear só com o braço, sem rodar o antebraço',
        'esquecer a recolha do braço contrário',
        'encolher os ombros durante o bloqueio',
        'parar o bloqueio longe da linha do corpo',
      ];
    }
    if (_has(n, ['esquivas e tai'])) {
      return [
        'baixar o olhar ao esquivar',
        'cruzar os pés no deslocamento',
        'baixar as mãos durante a esquiva',
        'saltar em vez de deslizar os pés',
      ];
    }
    if (_has(n, ['joelhadas'])) {
      return [
        'inclinar o tronco demasiado à frente',
        'subir o joelho de lado sem alinhar a anca',
        'deixar o pé de apoio rodar sem controlo',
        'cair pesado depois da joelhada',
      ];
    }
    if (_has(n, ['trabalho leve ao saco'])) {
      return [
        'bater com o punho dobrado',
        'procurar força em vez de técnica',
        'ficar parado colado ao saco',
        'esquecer a guarda depois de cada golpe',
      ];
    }
    if (_has(n, ['rolamentos de solo'])) {
      return [
        'rolar sobre a cabeça em vez do ombro',
        'deixar o queixo descolar do peito',
        'ganhar velocidade antes de dominar o caminho do rolamento',
        'treinar em piso duro',
      ];
    }
    if (_has(n, ['breakfalls'])) {
      return [
        'deixar a cabeça bater no tatami',
        'aterrar sobre o cotovelo ou a mão esticada',
        'bater com os braços tarde demais',
        'aumentar a altura da queda cedo demais',
      ];
    }
    if (_has(n, ['granby'])) {
      return [
        'apoiar o peso no topo da cabeça',
        'rodar com o pescoço em vez da linha dos ombros',
        'fazer a inversão com pressa',
        'treinar sem espaço livre à volta',
      ];
    }
    if (_has(n, ['pnf de isquiotibiais'])) {
      return [
        'puxar a perna até doer',
        'contrair com força máxima em vez de moderada',
        'prender a respiração na contração',
        'dobrar demasiado o joelho e perder o alvo do alongamento',
      ];
    }
    if (_has(n, ['pnf de peitoral'])) {
      return [
        'encolher o ombro contra a orelha',
        'empurrar a parede com força máxima',
        'rodar o tronco com impulso',
        'deixar o cotovelo escorregar abaixo da linha do ombro',
      ];
    }
    if (_has(n, ['flexores da anca em afundo'])) {
      return [
        'deixar a lombar arquear em vez de levar a bacia à frente',
        'apoiar o joelho em piso duro sem proteção',
        'empurrar a bacia com pressa',
        'esquecer de apertar o glúteo da perna de trás',
      ];
    }
    if (_has(n, ['borboleta de adutores'])) {
      return [
        'empurrar os joelhos para baixo com as mãos',
        'curvar as costas para chegar aos pés',
        'forçar com dor na virilha',
        'balançar as pernas depressa',
      ];
    }
    if (_has(n, ['dinamico global'])) {
      return [
        'apressar a sequência sem controlo',
        'deixar o joelho da frente cair para dentro',
        'forçar a rotação com a lombar em vez da coluna alta',
        'saltar entre posições',
      ];
    }
    if (_has(n, ['triceps atras da cabeca'])) {
      return [
        'empurrar a cabeça para a frente com o braço',
        'arquear a lombar para alcançar mais amplitude',
        'puxar o cotovelo até doer',
        'encolher os ombros',
      ];
    }
    if (_has(n, ['cobra suave'])) {
      return [
        'subir o peito com impulso',
        'empurrar a bacia contra o chão com força',
        'dobrar o pescoço para olhar para o teto',
        'manter a posição com desconforto na lombar',
      ];
    }
    if (_has(n, ['respiracao nasal'])) {
      return [
        'forçar tempos longos demais',
        'encher o peito em vez de deixar a barriga crescer',
        'apertar os ombros enquanto respiras',
        'desistir à primeira falta de ar em vez de encurtar os tempos',
      ];
    }
    if (_has(n, ['foam roller para pernas'])) {
      return [
        'rolar depressa para trás e para a frente',
        'passar o rolo por cima do joelho',
        'deixar todo o peso afundar num ponto com dor aguda',
        'rolar a mesma zona muitos minutos seguidos',
      ];
    }
    if (_has(n, ['foam roller para costas'])) {
      return [
        'rolar a lombar com o rolo',
        'rolar o pescoço com o rolo',
        'prender a respiração enquanto rolas',
        'insistir em zonas com dor que irradia',
      ];
    }
    if (_has(n, ['bola de massagem'])) {
      return [
        'pressionar até provocar dor forte',
        'rolar depressa sem procurar pontos tensos',
        'colocar a bola diretamente sobre osso',
        'continuar em zonas com formigueiro ou dormência',
      ];
    }
    if (_has(n, ['arrefecimento pos'])) {
      return [
        'parar de repente e saltar o arrefecimento',
        'alongar com força até doer',
        'fazer os alongamentos aos ressaltos',
        'apressar a rotina sem deixar a respiração baixar',
      ];
    }
    if (_has(n, ['aquecimento dinamico'])) {
      return [
        'começar pelos movimentos mais rápidos',
        'usar amplitudes máximas com o corpo frio',
        'transformar o aquecimento num treino',
        'saltar as zonas que vais treinar a seguir',
      ];
    }
    final bodyweight = _isBodyweightEquipment(equipment);
    if (_has(n, ['flexao diamante'])) {
      return [
        'abrir demasiado os cotovelos para os lados',
        'colocar as mãos demasiado à frente do peito',
        'perder o alinhamento do corpo e deixar a anca cair',
        'descer sem controlo',
      ];
    }
    if (_has(n, ['curl arrastado'])) {
      return [
        'transformar o movimento num curl normal, sem recuar os cotovelos',
        'balançar o tronco para subir os halteres',
        'encolher os ombros durante a subida',
        'afastar os halteres do tronco',
        'descer depressa e sem controlo',
      ];
    }
    if (_has(n, ['tate press'])) {
      return [
        'transformar o movimento num supino fechado, movendo os ombros',
        'deixar os cotovelos fechar junto ao tronco',
        'bater com os halteres no peito',
        'dobrar os punhos com a carga em cima',
        'usar halteres pesados demais para controlar a descida',
      ];
    }
    if (group == 'Cardio') {
      if (_has(n, ['bicicleta'])) {
        return [
          'pedalar com o selim mal ajustado',
          'usar resistência alta demais para o teu nível',
          'deixar os joelhos abrir para fora',
          'encolher os ombros contra o guiador',
          'parar de repente depois de esforço forte',
        ];
      }
      if (_has(n, ['corda'])) {
        return [
          'rodar a corda pelos ombros em vez dos punhos',
          'saltar demasiado alto',
          'aterrar com as pernas rígidas',
          'olhar para baixo e perder a postura',
          'continuar depois de tropeçar repetidamente',
        ];
      }
      if (_has(n, ['passadeira'])) {
        return [
          'começar rápido demais, sem aquecer',
          'agarrar os apoios para compensar o ritmo',
          'dar passadas longas demais',
          'olhar para os pés em vez de olhar em frente',
          'sair da passadeira sem abrandar primeiro',
        ];
      }
      return [
        'aumentar a intensidade antes de dominar a técnica',
        'saltar o aquecimento',
        'perder o ritmo da respiração',
        'aterrar sem controlo',
        'continuar com dor articular',
      ];
    }
    if (group == 'Mobilidade') {
      return [
        'forçar até à dor em vez de tensão leve',
        'fazer balanços rápidos',
        'prender a respiração',
        'compensar com a lombar ou com os ombros',
        'sair da posição de repente',
      ];
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return [
        'acelerar antes de controlar a técnica',
        'perder a base ou cruzar os pés de forma insegura',
        'prender a respiração',
        'torcer joelhos ou ombros sem controlo',
        'repetir cansado com má coordenação',
      ];
    }
    if (_isCurl(name)) {
      return [
        'balançar o tronco para subir o peso',
        'deixar os cotovelos fugir para a frente ou para trás',
        'dobrar os punhos durante a repetição',
        'subir só metade do caminho',
        'deixar o peso descer sem controlo',
      ];
    }
    if (_isTriceps(name)) {
      if (bodyweight) {
        return [
          'abrir demasiado os cotovelos',
          'mexer o ombro em vez do cotovelo',
          'arquear a lombar',
          'encurtar a descida do corpo',
        ];
      }
      return [
        'abrir demasiado os cotovelos',
        'mexer o ombro em vez do cotovelo',
        'arquear a lombar',
        'usar peso excessivo',
        'encurtar a descida',
      ];
    }
    if (_isGripOrForearm(name, group)) {
      return [
        'dobrar os punhos sem controlo',
        'usar peso pesado demais',
        'deixar a pega abrir de repente',
        'encolher os ombros',
        'continuar com dor no punho',
      ];
    }
    if (_isPushupOrPress(name)) {
      if (bodyweight) {
        return [
          'abrir demasiado os cotovelos',
          'deixar a anca cair ou subir em pico',
          'dobrar os punhos',
          'descer o corpo sem controlo',
          'encurtar a amplitude',
        ];
      }
      return [
        'abrir demasiado os cotovelos',
        'perder a posição das escápulas',
        'dobrar os punhos',
        'arquear a lombar em excesso',
        'descer o peso sem controlo',
      ];
    }
    if (_isRowOrPull(name)) {
      return [
        'puxar com balanço do tronco',
        'encolher os ombros',
        'arredondar a lombar',
        'puxar atrás da nuca',
        'largar a fase de retorno sem controlo',
      ];
    }
    if (_isSquat(name) || _isLunge(name)) {
      if (bodyweight) {
        return [
          'deixar os joelhos cair para dentro',
          'levantar os calcanhares do chão',
          'deixar o tronco colapsar à frente',
          'descer mais do que consegues controlar',
          'prender a respiração',
        ];
      }
      return [
        'deixar os joelhos cair para dentro',
        'levantar os calcanhares do chão',
        'deixar o tronco colapsar à frente',
        'posicionar mal o peso antes de começar',
        'descer mais do que consegues controlar',
      ];
    }
    if (_isHinge(name)) {
      if (bodyweight) {
        return [
          'arredondar a lombar',
          'dobrar demasiado os joelhos',
          'não levar a anca para trás',
          'subir puxando só pelas costas',
        ];
      }
      return [
        'arredondar a lombar',
        'afastar o peso do corpo',
        'dobrar demasiado os joelhos',
        'não levar a anca para trás',
        'subir puxando só pelas costas',
      ];
    }
    if (_has(n, ['extensao lombar quadrupede'])) {
      return [
        'abrir a bacia para o lado',
        'afundar entre as omoplatas',
        'atirar o pé para cima',
        'procurar altura em vez de estabilidade',
      ];
    }
    if (_isCore(name, group)) {
      return [
        'deixar a lombar arquear ou descolar do apoio',
        'puxar o pescoço com as mãos',
        'usar impulso em vez de controlo',
        'prender a respiração',
        'encurtar a amplitude útil',
      ];
    }
    if (bodyweight) {
      return [
        'perder o alinhamento do corpo',
        'encurtar a amplitude útil',
        'prender a respiração',
        'continuar depois de perder o controlo do movimento',
      ];
    }
    return [
      'usar peso acima do que controlas',
      'perder o alinhamento durante a repetição',
      'encurtar a amplitude útil',
      'prender a respiração',
      'continuar quando o músculo alvo já não controla o movimento',
    ];
  }

  static bool _isBodyweightEquipment(String equipment) {
    final e = _n(equipment);
    if (_has(e, [
      'halter',
      'barra',
      'cabo',
      'polia',
      'maquina',
      'disco',
      'kettlebell',
      'mochila',
      'garrafao',
      'elastico',
    ])) {
      return false;
    }
    return true;
  }

  static String _safetyFor(String name, String group, String equipment) {
    final n = _n(name);
    if (_has(n, ['pescoco', 'cervical', 'chin tuck'])) {
      return 'Usa força muito leve. Para imediatamente com tontura, formigueiro, dor irradiada, pressão na cabeça, visão turva ou dor aguda no pescoço.';
    }
    if (group == 'Cardio') {
      if (_has(n, ['passadeira'])) {
        return 'Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.';
      }
      if (_has(n, ['bicicleta', 'eliptica'])) {
        return 'Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.';
      }
      if (_has(n, [
        'corda',
        'saltos',
        'jacks',
        'burpees',
        'skaters',
        'knees',
      ])) {
        return 'Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.';
      }
      if (_has(n, ['exterior', 'subida', 'marcha'])) {
        return 'Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.';
      }
      return 'Mantém a intensidade adequada ao teu nível. Abranda ou termina se houver tontura, dor no peito, falta de ar fora do normal ou perda de coordenação.';
    }
    if (group == 'Mobilidade') {
      if (_has(n, ['pnf'])) {
        return 'Contrai com força moderada, nunca máxima, e alonga sem dor. Para com dor aguda, formigueiro, cãibra forte ou dormência.';
      }
      if (_has(n, ['foam roller', 'bola de massagem'])) {
        return 'Evita rolar ossos, articulações, a lombar e o pescoço. Para se a pressão causar dor aguda, formigueiro ou dormência.';
      }
      if (_has(n, [
        'respiracao nasal',
        'arrefecimento pos',
        'aquecimento dinamico',
      ])) {
        return 'Mantém a intensidade muito baixa e o ritmo confortável. Para com tontura, falta de ar fora do normal ou dor.';
      }
      if (_has(n, [
        'flexores da anca em afundo',
        'borboleta',
        'dinamico global',
        'triceps atras da cabeca',
        'cobra suave',
      ])) {
        return 'Alonga até uma tensão confortável, nunca até à dor. Sai devagar da posição e para com formigueiro, dormência ou dor aguda.';
      }
      return 'Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.';
    }
    if (_has(n, ['extensao lombar quadrupede'])) {
      return 'Mantém o gesto pequeno e silencioso. Interrompe se a bacia rodar sempre, se a lombar apertar, se surgir dor irradiada ou se precisares de impulso para levantar a perna.';
    }
    if (_isHinge(name)) {
      return _isBodyweightEquipment(equipment)
          ? 'Mantém a coluna neutra durante a dobradiça da anca. Para com dor lombar aguda, formigueiro ou perda de força.'
          : 'Mantém a coluna neutra e o peso perto do corpo. Para com dor lombar aguda, formigueiro, perda de força ou incapacidade de controlar a anca.';
    }
    if (_isPushupOrPress(name) || _isShoulder(name)) {
      return _isBodyweightEquipment(equipment)
          ? 'Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.'
          : 'Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.';
    }
    if (_isGripOrForearm(name, group)) {
      return 'Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.';
    }
    if (_isCurl(name)) {
      return _isBodyweightEquipment(equipment)
          ? 'Mantém os punhos alinhados e os cotovelos estáveis. Para se houver dor no cotovelo ou no punho.'
          : 'Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.';
    }
    if (_isTriceps(name)) {
      return _isBodyweightEquipment(equipment)
          ? 'Guia os cotovelos sem os abrir em excesso. Para com dor no cotovelo, no ombro ou na lombar.'
          : 'Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.';
    }
    if (_isSquat(name) || _isLunge(name)) {
      return 'Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.';
    }
    return _isBodyweightEquipment(equipment)
        ? 'Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.'
        : 'Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.';
  }

  static bool _beginnerUnderstands(ExerciseCatalogDetails details) {
    final stepLines = details.executionSteps
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .length;
    final breathingText = '${details.executionSteps} ${details.breathingTips}'
        .toLowerCase();
    final lower = '${details.description} ${details.executionSteps}'
        .toLowerCase();
    return details.description.length >= 60 &&
        details.description.length <= 280 &&
        stepLines >= 4 &&
        stepLines <= 7 &&
        (breathingText.contains('respira') ||
            breathingText.contains('inspira') ||
            breathingText.contains('expira')) &&
        details.equipment.trim().isNotEmpty &&
        !lower.contains('no contexto') &&
        !lower.contains('equipamento indicado') &&
        !lower.contains('articulação principal');
  }

  static String _mobilitySecondary(String name) {
    final n = _n(name);
    if (_has(n, ['cervical', 'pescoco', 'chin tuck'])) {
      return 'trapézio superior, estabilizadores cervicais e respiração';
    }
    if (_has(n, ['gluteo', 'piriforme', 'pigeon', 'figura 4', '90/90'])) {
      return 'anca, piriforme, rotadores externos da anca e lombar';
    }
    if (_has(n, ['posterior'])) {
      return 'posterior de coxa, gémeos, anca e cadeia posterior';
    }
    if (_has(n, ['ombro', 'peitoral', 'dorsal', 'toracica'])) {
      return 'escápulas, coluna torácica, peitoral, dorsal e respiração';
    }
    if (_has(n, ['tornozelo', 'gemeos'])) {
      return 'gémeos, sóleo, pé e equilíbrio';
    }
    if (_has(n, ['punho'])) return 'antebraço, dedos e cotovelo';
    return 'respiração, postura, controlo articular e consciência corporal';
  }

  static bool _isCurl(String name) {
    final n = _n(name);
    // "Curl" aqui significa flexão de cotovelo; curl de perna é posterior de
    // coxa e wrist/finger curls pertencem ao antebraço.
    if (_has(n, ['curl de perna', 'wrist', 'finger'])) return false;
    return n.contains('curl');
  }

  static bool _isTriceps(String name) {
    final n = _n(name);
    if (_has(n, ['kickback de gluteo'])) return false;
    return _has(n, [
      'triceps',
      'tricep',
      'extensao francesa',
      'extensao de triceps',
      'extensao acima da cabeca',
      'kickback',
      'tate press',
      'press fechado',
      'supino fechado',
      'fundos entre apoios',
      'flexao fechada',
      'flexao diamante',
      'dips para triceps',
    ]);
  }

  static bool _isGripOrForearm(String name, String group) =>
      group == 'Antebraço/Pega' ||
      _has(_n(name), [
        'wrist',
        'farmer',
        'hold',
        'dead hang',
        'aperto',
        'pronacao',
        'supinacao',
        'pinch',
        'plate',
        'towel',
        'finger',
        'desvio radial',
        'desvio ulnar',
      ]);
  static bool _isPushupOrPress(String name) => _has(_n(name), [
    'flexao',
    'supino',
    'chest press',
    'squeeze press',
    'dips para peito',
    'press fechado',
  ]);
  static bool _isFly(String name) => _has(_n(name), ['aberturas', 'crossover']);
  static bool _isRowOrPull(String name) => _has(_n(name), [
    'remo',
    'puxada',
    'pull-up',
    'chin-up',
    'pullover',
    'face pull',
    'dead hang',
    'scapular pull-up',
    'puxada com bracos',
  ]);
  static bool _isShoulder(String name) => _has(_n(name), [
    'press militar',
    'arnold',
    'elevacao lateral',
    'elevacao frontal',
    'elevacao posterior',
    'reverse fly',
    'y raise',
    'w raise',
    'rotacao externa',
    'rotacao interna',
    'pull-apart',
    'wall slides',
    'scapular push-up',
    'pike push-up',
    'remo alto',
    'encolhimento',
  ]);
  static bool _isSquat(String name) => _has(_n(name), [
    'agachamento',
    'leg press',
    'extensao de perna',
    'wall sit',
    'step-up',
  ]);
  static bool _isLunge(String name) => _has(_n(name), ['lunge', 'lunges']);
  static bool _isHinge(String name) =>
      _has(_n(name), ['peso morto', 'good morning', 'hiperextensao', 'romeno']);
  static bool _isCore(String name, String group) =>
      group == 'Core' ||
      _has(_n(name), [
        'prancha',
        'crunch',
        'dead bug',
        'hollow',
        'mountain',
        'pallof',
        'russian',
        'bicycle',
        'bird dog',
        'side bend',
        'vacuum',
        'flutter',
        'toe touches',
        'superman',
      ]);

  static String _n(String value) => stableKey(value).replaceAll('_', ' ');

  static bool _has(String haystack, List<String> needles) {
    final normalized = _n(haystack);
    return needles.any((needle) => normalized.contains(_n(needle)));
  }
}

class _NamedSummary {
  const _NamedSummary(this.text, {this.contextGroup});

  final String text;
  final String? contextGroup;
}
