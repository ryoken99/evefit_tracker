import '../database/seed_data.dart';
import '../models/exercise.dart';
import 'exercise_catalog_detail_service.dart';

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

  Exercise toExercise({int? id}) => Exercise(
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
    exerciseKey: exerciseKey,
    contextKey: contextKey,
    catalogEntryKey: catalogEntryKey,
  );
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
    return List.unmodifiable(result);
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
    final details = ExerciseCatalogDetails(
      equipment: equipment,
      secondaryGroups: secondary,
      description: _ensureDescriptionContract(
        _descriptionFor(name, group, equipment, secondary),
        name,
        group,
      ),
      executionSteps: _ensureStepContract(
        _stepsFor(name, group, equipment),
        name,
        group,
        equipment,
      ),
      commonMistakes: _ensureMistakeContract(
        _mistakesFor(name, group, equipment),
        name,
        group,
      ),
      safetyNotes: _ensureSafetyContract(
        _safetyFor(name, group, equipment),
        name,
        group,
      ),
    );
    return details;
  }

  static String _ensureDescriptionContract(
    String text,
    String name,
    String group,
  ) {
    final normalized = _n(text);
    if (_has(normalized, ['serve', 'treinar', 'praticar', 'melhorar'])) {
      return text;
    }
    return '$text Serve para treinar $group com foco claro em $name, mantendo controlo da área principal e progressão adequada.';
  }

  static String _ensureStepContract(
    String text,
    String name,
    String group,
    String equipment,
  ) {
    final additions = <String>[];
    final normalized = _n(text);
    final nameKey = _n(name);
    final equipmentKey = _n(equipment);
    var next = RegExp(r'\d+\.').allMatches(text).length + 1;

    void addIfMissing(String cue, String sentence) {
      if (!normalized.contains(_n(cue)) &&
          !additions.join(' ').contains(sentence)) {
        additions.add('${next++}. $sentence');
      }
    }

    if (!_has(normalized, [
      'coloca',
      'fica',
      'senta',
      'sobe',
      'começa',
      'ajusta',
    ])) {
      additions.add(
        '${next++}. Começa numa posição inicial estável antes de aumentar a carga ou a velocidade.',
      );
    }
    if (!normalized.contains('respira')) {
      additions.add(
        '${next++}. Respira de forma contínua, expirando na fase de maior esforço e inspirando no retorno.',
      );
    }
    if (!_has(normalized, ['volta', 'regressa', 'reduz', 'desce', 'baixa'])) {
      additions.add(
        '${next++}. Regressa devagar à posição inicial antes da repetição seguinte.',
      );
    }
    if (group == 'Mobilidade') {
      addIfMissing(
        'zona',
        'Mantém atenção na zona trabalhada e usa apenas tensão leve, nunca dor.',
      );
      if (!_has(normalized, ['segundos', 'respira'])) {
        additions.add(
          '${next++}. Mantém 15 a 30 segundos com respiração lenta e regular.',
        );
      }
    }
    if (group == 'Cardio') {
      addIfMissing(
        'intens',
        'Controla a intensidade pela respiração e pela sensação de esforço.',
      );
      addIfMissing(
        'duração',
        'Mantém uma duração adequada ao foco, usando minutos para trabalho contínuo ou segundos para intervalos.',
      );
      if (_has(nameKey, ['hiit', 'interval', 'sprint'])) {
        if (!_has(normalized, ['interval', 'blocos', 'recupera'])) {
          additions.add(
            '${next++}. Alterna blocos intensos com recuperação leve antes de repetir.',
          );
        }
      }
      if (_has(nameKey, ['passadeira'])) {
        addIfMissing(
          'passadeira',
          'Na passadeira, ajusta velocidade antes de mexer na inclinação.',
        );
        addIfMissing(
          'velocidade',
          'Usa velocidade que permite pisada estável e controlo do tronco.',
        );
      }
      if (_has(nameKey, ['bicicleta'])) {
        addIfMissing(
          'selim',
          'Ajusta o selim para pedalar com joelho ligeiramente fletido.',
        );
        addIfMissing(
          'resistência',
          'Ajusta a resistência sem bloquear joelhos nem balançar a anca.',
        );
        addIfMissing(
          'cadência',
          'Mantém cadência regular e abranda se perderes coordenação.',
        );
      }
      if (_has(nameKey, ['corda'])) {
        addIfMissing(
          'pegas',
          'Segura as pegas da corda com punhos relaxados e cotovelos próximos do corpo.',
        );
        addIfMissing(
          'punhos',
          'Roda a corda principalmente pelos punhos, sem círculos grandes dos ombros.',
        );
        addIfMissing(
          'salta',
          'Salta baixo e aterra de forma silenciosa para proteger tornozelos e joelhos.',
        );
      }
      if (_has(nameKey, ['eliptica', 'elíptica'])) {
        addIfMissing(
          'elíptica',
          'Na elíptica, mantém os pés centrados nas plataformas.',
        );
        addIfMissing(
          'resistência',
          'Ajusta a resistência sem perder fluidez entre braços e pernas.',
        );
      }
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      addIfMissing(
        'objetivo',
        'Define o objetivo técnico antes de aumentar velocidade ou complexidade.',
      );
      addIfMissing(
        'guarda',
        'Mantém guarda organizada e volta sempre à base depois de cada repetição.',
      );
    }
    if (_has(equipmentKey, ['halter'])) {
      addIfMissing(
        'halter',
        'Segura os halteres com punhos alinhados e sem deixar a carga puxar a articulação.',
      );
      if (!_has(normalized, ['segura', 'pega'])) {
        additions.add(
          '${next++}. Usa uma pega firme nos halteres sem apertar ao ponto de criar dor no punho.',
        );
      }
    }
    if (_has(equipmentKey, ['barra']) && !_has(equipmentKey, ['barra fixa'])) {
      addIfMissing(
        'barra',
        'Posiciona a barra de forma estável antes de iniciar a repetição.',
      );
      if (!_has(normalized, ['pega', 'posição', 'posicao'])) {
        additions.add(
          '${next++}. Usa pega simétrica na barra e confirma a posição da barra antes de mover a carga.',
        );
      }
    }
    if (_has(equipmentKey, ['cabo', 'polia'])) {
      addIfMissing(
        'polia',
        'Ajusta a polia à altura correta para a trajetória do exercício.',
      );
      addIfMissing(
        'pega',
        'Segura a pega do cabo com punho neutro e deixa o cabo mover sem puxões.',
      );
      addIfMissing(
        'cabo',
        'Mantém o cabo alinhado com a direção do movimento.',
      );
    }
    if (_has(equipmentKey, ['máquina', 'maquina'])) {
      if (!_has(normalized, ['maquina', 'assento', 'encosto', 'ajusta'])) {
        additions.add(
          '${next++}. Ajusta a máquina, assento ou encosto para alinhar articulações e carga.',
        );
      }
    }
    if (_has(nameKey, ['curl inverso'])) {
      addIfMissing(
        'punhos alinhados',
        'Mantém punhos alinhados e pega pronada durante toda a repetição.',
      );
    }
    if (_has(nameKey, ['press', 'supino', 'flexao', 'flexão', 'dips'])) {
      addIfMissing(
        'pes',
        'Mantém os pés firmes para estabilizar o corpo durante o esforço.',
      );
      addIfMissing(
        'cotovel',
        'Guia os cotovelos sem abrir agressivamente para os lados.',
      );
      addIfMissing(
        'empurra',
        'Empurra a carga ou o chão com controlo, sem bloquear as articulações com força.',
      );
      addIfMissing(
        'ombro',
        'Mantém ombros afastados das orelhas durante a fase de esforço.',
      );
    }
    if (_isTriceps(name)) {
      addIfMissing(
        'desce',
        'Desce a carga ou o corpo com controlo antes de estender novamente o cotovelo.',
      );
    }
    if (_has(nameKey, ['remo', 'puxada', 'pull-up', 'chin-up', 'face pull'])) {
      addIfMissing(
        'tronco',
        'Mantém tronco firme e lombar neutra durante a puxada.',
      );
      addIfMissing(
        'escap',
        'Inicia a puxada organizando as escápulas antes de dobrar os cotovelos.',
      );
      addIfMissing(
        'cotovel',
        'Leva os cotovelos na direção do exercício sem encolher o pescoço.',
      );
    }
    if (_has(nameKey, ['agachamento', 'lunges', 'leg press', 'step-up'])) {
      addIfMissing(
        'pes',
        'Mantém os pés firmes e alinhados com joelhos e anca.',
      );
      addIfMissing('joelh', 'Mantém os joelhos na direção dos pés.');
      addIfMissing('anca', 'Usa a anca para iniciar e controlar a descida.');
    }
    if (_has(nameKey, ['peso morto', 'good morning'])) {
      addIfMissing(
        'anca',
        'Dobra pela anca antes de pensar em descer a carga.',
      );
      addIfMissing(
        'lombar',
        'Mantém lombar neutra e termina se ela começar a arredondar.',
      );
    }
    return additions.isEmpty ? text : '$text ${additions.join(' ')}';
  }

  static String _ensureMistakeContract(String text, String name, String group) {
    if (_has(_n(text), [
      'evitar',
      'perder',
      'deixar',
      'usar',
      'abrir',
      'prender',
      'acelerar',
      'forcar',
      'forçar',
    ])) {
      return text;
    }
    return '$text Evita acelerar, perder alinhamento da área principal, prender a respiração ou usar compensações para terminar $name.';
  }

  static String _ensureSafetyContract(String text, String name, String group) {
    final normalized = _n(text);
    final stopCue = _has(normalized, [
      'para',
      'interrompe',
      'termina',
      'abranda',
    ]);
    final symptomCue = _has(normalized, [
      'dor',
      'tontura',
      'formigueiro',
      'peito',
      'instabilidade',
      'falta de ar',
    ]);
    final base =
        '${stopCue && symptomCue ? text : '$text Para se houver dor, tontura, formigueiro, falta de ar fora do normal ou instabilidade.'} '
        'Contexto específico: $name em $group.';
    return base;
  }

  static String _equipmentOverride(
    String name,
    String group,
    String baseEquipment,
  ) {
    final n = _n(name);
    final context = _n(group);
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
    if (_isTriceps(name)) return 'Ombros, cotovelos, peito como apoio e core';
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

  static String _descriptionFor(
    String name,
    String group,
    String equipment,
    String secondary,
  ) {
    if (group == 'Cardio') {
      return _cardioDescription(name, equipment, secondary);
    }
    if (group == 'Mobilidade') {
      return _mobilityDescription(name, equipment, secondary);
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return '$name é um exercício técnico de $group para praticar coordenação, base, controlo corporal e precisão. Usa $equipment e deve ser feito com velocidade baixa no início, aumentando apenas quando a técnica se mantém limpa. Também trabalha $secondary.';
    }
    if (_isCurl(name)) return _curlDescription(name, equipment, secondary);
    if (_isTriceps(name)) {
      return _tricepsDescription(name, equipment, secondary);
    }
    if (_isPushupOrPress(name)) {
      return _pushDescription(name, equipment, secondary);
    }
    if (_isFly(name)) {
      return '$name é uma abertura para peito: os braços fazem um arco controlado enquanto o peito alonga e contrai. Usa $equipment, carga moderada e cotovelos ligeiramente fletidos para proteger ombros. Também envolve $secondary.';
    }
    if (_isRowOrPull(name)) return _pullDescription(name, equipment, secondary);
    if (_isShoulder(name)) {
      return _shoulderDescription(name, equipment, secondary);
    }
    if (_isSquat(name) || _isLunge(name)) {
      return '$name é um exercício de pernas para treinar a flexão e extensão controlada de joelhos e anca. Usa $equipment, mantendo pés, joelhos e tronco organizados. Também trabalha $secondary.';
    }
    if (_isHinge(name)) {
      return '$name é um padrão de dobradiça de anca: a anca vai para trás, a coluna fica neutra e a força vem dos posteriores, glúteos e lombar controlada. Usa $equipment. Também envolve $secondary.';
    }
    if (_isCore(name, group)) {
      return _coreDescription(name, equipment, secondary);
    }
    if (_isGripOrForearm(name, group)) {
      return '$name treina antebraço, punho, dedos ou força de pega. Usa $equipment e deve ser feito com punhos alinhados, carga controlável e sem dor articular. Também envolve $secondary.';
    }
    return '$name é um exercício de $group feito com $equipment. O objetivo é treinar o músculo ou foco escolhido com posição estável, amplitude confortável, respiração regular e controlo total do retorno. Também envolve $secondary.';
  }

  static String _stepsFor(String name, String group, String equipment) {
    if (group == 'Cardio') return _cardioSteps(name, equipment);
    if (group == 'Mobilidade') return _mobilitySteps(name, equipment);
    if (group == 'Karate') return _karateSteps(name);
    if (group == 'Jiu-Jitsu') return _jiuJitsuSteps(name);
    if (_has(_n(name), ['curl inverso'])) return _curlInversoSteps(equipment);
    if (_has(_n(name), ['curl cruzado'])) return _crossBodyCurlSteps();
    if (_has(_n(name), ['curl martelo'])) return _hammerCurlSteps(equipment);
    if (_has(_n(name), ['curl zottman'])) return _zottmanSteps(equipment);
    if (_has(_n(name), ['curl no cabo'])) return _cableCurlSteps();
    if (_isCurl(name)) return _curlSteps(name, equipment);
    if (_has(_n(name), ['dead hang escapular', 'scapular pull-up'])) {
      return _scapularHangSteps();
    }
    if (_has(_n(name), ['pull-up', 'chin-up'])) return _pullUpSteps(name);
    if (_isGripOrForearm(name, group)) {
      return _forearmGripSteps(name, equipment);
    }
    if (_isTriceps(name)) return _tricepsSteps(name, equipment);
    if (_has(_n(name), ['flexao'])) return _pushupSteps(name);
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
    if (_isCore(name, group)) return _coreSteps(name, equipment);
    return _generalSpecificSteps(name, group, equipment);
  }

  static String _curlDescription(
    String name,
    String equipment,
    String secondary,
  ) {
    final n = _n(name);
    if (_has(n, ['inverso'])) {
      return '$name é uma variação de curl com pega pronada, palmas viradas para baixo. O foco sai um pouco do bíceps e passa mais para braquial, braquiorradial e antebraço. Usa $equipment com carga leve a moderada. Também envolve $secondary.';
    }
    if (_has(n, ['martelo', 'cruzado'])) {
      return '$name é uma variação de curl com pega neutra, parecida com segurar martelos. É muito útil para braquial e braquiorradial, além do bíceps. Usa $equipment e evita balanço do tronco. Também envolve $secondary.';
    }
    if (_has(n, ['zottman'])) {
      return '$name combina subida em curl normal com descida em pega pronada. Treina bíceps na subida e braquial, braquiorradial e antebraço na descida. Usa $equipment leve até dominares a rotação. Também envolve $secondary.';
    }
    return '$name é uma variação de curl para flexionar o cotovelo e aproximar a carga do ombro sem balançar o corpo. Usa $equipment e mantém os cotovelos controlados. Também envolve $secondary.';
  }

  static String _tricepsDescription(
    String name,
    String equipment,
    String secondary,
  ) =>
      '$name é um exercício para estender o cotovelo e treinar o tríceps. Usa $equipment, mantém cotovelos estáveis e evita transformar o movimento em balanço de ombros ou lombar. Também envolve $secondary.';

  static String _pushDescription(
    String name,
    String equipment,
    String secondary,
  ) =>
      '$name é um exercício de empurrar para peito, ombros e tríceps. Usa $equipment e controla a posição das escápulas, cotovelos e punhos para a carga seguir uma trajetória segura. Também envolve $secondary.';

  static String _pullDescription(
    String name,
    String equipment,
    String secondary,
  ) =>
      '$name é um exercício de puxar para costas e escápulas. Usa $equipment, começa com ombros baixos, guia os cotovelos e controla o regresso para não perder tensão. Também envolve $secondary.';

  static String _shoulderDescription(
    String name,
    String equipment,
    String secondary,
  ) =>
      '$name treina ombros, trapézio ou controlo escapular. Usa $equipment com carga que permita manter pescoço relaxado, punhos alinhados e escápulas estáveis. Também envolve $secondary.';

  static String _coreDescription(
    String name,
    String equipment,
    String secondary,
  ) =>
      '$name treina o core para criar estabilidade, flexão, rotação ou resistência do tronco. Usa $equipment e mantém respiração controlada sem deixar a lombar perder a posição. Também envolve $secondary.';

  static String _cardioDescription(
    String name,
    String equipment,
    String secondary,
  ) {
    final n = _n(name);
    if (_has(n, ['passadeira'])) {
      return '$name é uma sessão de passadeira para trabalhar ritmo, passada, respiração e resistência. Usa $equipment, controla velocidade e inclinação conforme o objetivo. Também envolve $secondary.';
    }
    if (_has(n, ['bicicleta'])) {
      return '$name é uma sessão de bicicleta para trabalhar cadência, resistência, respiração e controlo cardiovascular. Usa $equipment, ajusta selim e resistência antes de começar. Também envolve $secondary.';
    }
    if (_has(n, ['corda'])) {
      return '$name é um exercício de corda de saltar para coordenação, ritmo, pés rápidos e capacidade cardiovascular. Usa $equipment, saltos baixos e rotação pelos punhos. Também envolve $secondary.';
    }
    if (_has(n, ['eliptica'])) {
      return '$name é uma sessão de elíptica para resistência cardiovascular com baixo impacto. Usa $equipment, mantém tronco alto e movimento contínuo de braços e pernas. Também envolve $secondary.';
    }
    if (_has(n, ['caminhada', 'corrida', 'sprints'])) {
      return '$name é cardio em exterior para trabalhar resistência, passada e controlo respiratório. Usa $equipment, escolhe piso seguro e ajusta intensidade ao teu nível. Também envolve $secondary.';
    }
    return '$name é cardio de peso corporal para elevar a frequência cardíaca, coordenação e tolerância ao esforço. Usa $equipment e mantém técnica antes de aumentar velocidade. Também envolve $secondary.';
  }

  static String _mobilityDescription(
    String name,
    String equipment,
    String secondary,
  ) =>
      '$name é um exercício de mobilidade ou alongamento para melhorar amplitude útil, aliviar tensão e treinar controlo da região trabalhada. Usa $equipment apenas se ajudar a manter uma posição confortável. Também envolve $secondary.';

  static String _curlSteps(String name, String equipment) =>
      '1. Fica de pé ou sentado com pés firmes, peito alto e abdómen ligeiramente ativo. '
      '2. Segura $equipment com a pega da variação, mantendo punhos direitos e ombros relaxados. '
      '3. Encosta os cotovelos ao lado do tronco ou mantém-nos ligeiramente à frente se a variação pedir. '
      '4. Sobe a carga dobrando apenas os cotovelos, sem atirar a anca para a frente nem inclinar as costas. '
      '5. Para perto do topo quando o antebraço se aproxima do braço e sentes contração no braço. '
      '6. Desce durante 2 a 3 segundos até quase estender os cotovelos, mantendo punhos alinhados. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Reduz a carga se os ombros subirem, os cotovelos fugirem ou o tronco balançar.';

  static String _curlInversoSteps(String equipment) =>
      '1. Fica de pé com pés à largura da anca, joelhos soltos e tronco alto. '
      '2. Segura $equipment à frente das coxas com pega pronada: palmas viradas para baixo e nós dos dedos para a frente. '
      '3. Mantém punhos direitos, cotovelos junto ao tronco e ombros afastados das orelhas. '
      '4. Sobe a carga dobrando os cotovelos sem rodar os punhos para cima. '
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
    if (_has(n, ['wrist curl'])) {
      return '1. Senta-te e apoia os antebraços nas coxas ou num banco, com os punhos fora do apoio. 2. Segura $equipment com palmas viradas para cima. 3. Mantém os antebraços quietos e deixa os punhos descerem devagar. 4. Fecha os dedos na pega e dobra os punhos para cima. 5. Para no topo sem levantar os antebraços. 6. Desce lentamente até alongamento confortável. 7. Respira de forma regular. 8. Usa carga leve para não irritar o punho.';
    }
    if (_has(n, ['reverse wrist'])) {
      return '1. Senta-te com os antebraços apoiados e punhos fora do apoio. 2. Segura $equipment com palmas viradas para baixo. 3. Mantém cotovelos e antebraços imóveis. 4. Eleva os nós dos dedos para cima estendendo os punhos. 5. Pausa um instante no topo sem compensar com os ombros. 6. Baixa lentamente até amplitude confortável. 7. Respira sem prender o ar. 8. Reduz carga se houver dor na parte de cima do punho.';
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
      return '1. Inclina o tronco à frente com coluna neutra e apoia uma mão num banco se precisares. 2. Segura o halter ou pega do cabo com o cotovelo dobrado a cerca de 90 graus. 3. Cola o braço ao lado do tronco, com o cotovelo apontado para trás. 4. Estende o cotovelo até o braço ficar quase direito, sem mexer o ombro. 5. Pausa um instante contraindo o tríceps. 6. Volta devagar até 90 graus. 7. Expira ao estender e inspira ao voltar. 8. Usa carga leve se o cotovelo cair ou se tiveres de balançar.';
    }
    if (_has(n, ['acima da cabeca', 'francesa'])) {
      return '1. Senta-te ou fica de pé com pés firmes e abdómen ativo. 2. Segura $equipment acima da cabeça com punhos alinhados. 3. Mantém cotovelos apontados para a frente e próximos, sem abrir demasiado. 4. Desce a carga atrás da cabeça dobrando apenas os cotovelos. 5. Para quando sentires alongamento confortável no tríceps, sem dor no ombro. 6. Estende os cotovelos para subir, mantendo costelas baixas e lombar neutra. 7. Inspira ao descer e expira ao subir. 8. Reduz a carga se os cotovelos abrirem ou a lombar arquear.';
    }
    if (_has(n, ['testa', 'deitado'])) {
      return '1. Deita-te num banco ou no chão com a carga acima do peito. 2. Mantém punhos alinhados e braços ligeiramente inclinados para trás. 3. Dobra os cotovelos levando a carga em direção à testa ou ligeiramente atrás da cabeça. 4. Mantém os cotovelos apontados para cima, sem abrirem para os lados. 5. Estende os cotovelos até quase bloquear, contraindo o tríceps. 6. Inspira ao descer e expira ao estender. 7. Usa carga leve e controla a descida. 8. Pára se sentires dor no cotovelo ou ombro.';
    }
    if (_has(n, ['press fechado', 'supino fechado', 'tate press'])) {
      return '1. Deita-te num banco ou no chão com a carga acima do peito. 2. Usa pega mais fechada que num supino normal e punhos alinhados. 3. Mantém cotovelos relativamente perto do tronco. 4. Desce a carga para a zona média do peito com controlo. 5. Empurra para cima focando a extensão dos cotovelos e o tríceps. 6. Não deixes os ombros subir para as orelhas. 7. Inspira ao descer e expira ao empurrar. 8. Usa carga menor se os punhos dobrarem ou os cotovelos abrirem demais.';
    }
    return '1. Coloca-te numa base firme e segura $equipment com punhos alinhados. 2. Mantém o braço estável para que o movimento venha sobretudo do cotovelo. 3. Dobra o cotovelo até sentires alongamento controlado no tríceps. 4. Estende o cotovelo até quase endireitar o braço. 5. Mantém ombros baixos e costelas controladas. 6. Regressa devagar sem deixar a carga cair. 7. Expira ao estender e inspira ao dobrar. 8. Reduz a carga se houver dor no cotovelo, ombro ou punho.';
  }

  static String _pushupSteps(String name) {
    final n = _n(name);
    final handCue = _has(n, ['diamante'])
        ? 'mãos próximas, formando um losango ou triângulo por baixo do peito'
        : _has(n, ['aberta'])
        ? 'mãos mais abertas que os ombros'
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
      '2. Segura $equipment com punhos alinhados e cotovelos por baixo ou ligeiramente à frente da carga. '
      '3. Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso. '
      '4. Desce a carga até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina. '
      '5. Mantém cotovelos guiados, sem abrir completamente para os lados. '
      '6. Empurra a carga para cima até quase estender os braços. '
      '7. Inspira ao descer e expira ao empurrar. '
      '8. Pára se perderes o controlo da carga ou se sentires dor no ombro.';

  static String _flySteps(String name, String equipment) =>
      '1. Deita-te ou posiciona-te de forma estável com $equipment nas mãos. '
      '2. Começa com braços à frente do peito e cotovelos ligeiramente dobrados. '
      '3. Mantém essa pequena dobra dos cotovelos durante toda a repetição. '
      '4. Abre os braços em arco até sentires alongamento confortável no peito, sem dor no ombro. '
      '5. Fecha o arco aproximando as mãos à frente do peito, sem bater as cargas. '
      '6. Mantém ombros baixos e escápulas controladas. '
      '7. Inspira ao abrir e expira ao fechar. '
      '8. Usa carga leve, porque este exercício exige mais controlo do que força bruta.';

  static String _facePullSteps(String equipment) =>
      '1. Ajusta o cabo alto ou prende o elástico à altura do rosto. '
      '2. Segura a corda ou pega com as palmas viradas uma para a outra. '
      '3. Dá um passo atrás até haver tensão e fica com tronco alto. '
      '4. Puxa a corda em direção ao rosto, separando ligeiramente as mãos. '
      '5. Leva os cotovelos para trás e para fora, juntando as escápulas sem encolher o pescoço. '
      '6. Para quando as mãos ficam perto das orelhas ou bochechas. '
      '7. Volta devagar até os braços estenderem sem perder tensão. '
      '8. Expira ao puxar e inspira ao voltar.';

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
      return '1. Fica de pé com halteres ao lado do corpo e cotovelos ligeiramente dobrados. 2. Mantém punhos neutros e ombros afastados das orelhas. 3. Sobe os braços para os lados até perto da altura dos ombros. 4. Mantém os cotovelos ligeiramente acima ou na linha dos punhos. 5. Desce devagar sem deixar os halteres cair. 6. Expira ao subir e inspira ao descer. 7. Usa carga leve se precisares de balançar o tronco.';
    }
    if (_has(n, ['elevacao frontal'])) {
      return '1. Segura os halteres à frente das coxas com punhos alinhados. 2. Mantém tronco alto e costelas controladas. 3. Sobe um ou ambos os braços à frente até perto da altura dos ombros. 4. Evita encolher os ombros ou arquear a lombar. 5. Desce devagar até à posição inicial. 6. Expira ao subir e inspira ao descer. 7. Usa amplitude menor se houver desconforto no ombro.';
    }
    if (_has(n, ['reverse fly', 'elevacao posterior', 'y raise', 'w raise'])) {
      return '1. Inclina o tronco à frente ou apoia o peito num banco inclinado. 2. Segura a carga leve com braços pendurados e pescoço relaxado. 3. Abre os braços na direção indicada pela variação, focando ombros posteriores e escápulas. 4. Mantém cotovelos ligeiramente dobrados e punhos neutros. 5. Para antes de encolher o pescoço. 6. Desce devagar. 7. Expira ao abrir e inspira ao voltar. 8. Usa carga leve para não transformar em balanço.';
    }
    if (_has(n, ['rotacao externa', 'rotacao interna'])) {
      return '1. Mantém o cotovelo junto ao corpo a cerca de 90 graus. 2. Segura elástico, cabo ou halter leve com punho alinhado. 3. Roda o antebraço devagar para fora ou para dentro, conforme a variação. 4. Mantém o cotovelo fixo e o ombro baixo. 5. Usa amplitude pequena e sem dor. 6. Regressa devagar ao centro. 7. Respira sem prender o ar. 8. Escolhe resistência muito leve.';
    }
    return '1. Fica em base estável com $equipment controlado. 2. Mantém tronco alto, abdómen ativo e ombros afastados das orelhas. 3. Leva a carga ou os braços pela trajetória do $name sem perder punhos alinhados. 4. Para na amplitude em que controlas o ombro sem dor. 5. Regressa devagar, sem deixar a carga cair. 6. Expira na fase de esforço e inspira no retorno. 7. Reduz carga se precisares de inclinar o tronco ou encolher o pescoço.';
  }

  static String _squatSteps(String name, String equipment) =>
      '1. Fica com pés à largura dos ombros ou ligeiramente mais abertos, conforme a variação. '
      '2. Posiciona $equipment de forma segura: ao peito, aos lados, nas costas ou sem carga. '
      '3. Mantém peito aberto, abdómen ativo e olhar em frente ou ligeiramente para baixo. '
      '4. Inicia levando a anca para trás e dobrando joelhos ao mesmo tempo. '
      '5. Mantém joelhos alinhados com os pés, sem caírem para dentro. '
      '6. Desce até onde consegues manter calcanhares apoiados e coluna neutra. '
      '7. Sobe empurrando o chão e estendendo anca e joelhos. '
      '8. Inspira ao descer e expira ao subir.';

  static String _lungeSteps(String name, String equipment) =>
      '1. Fica de pé com tronco alto e $equipment controlado. '
      '2. Dá um passo à frente, atrás ou em movimento, conforme a variação. '
      '3. Desce dobrando os dois joelhos, mantendo o joelho da frente alinhado com o pé. '
      '4. Mantém a anca estável e o tronco sem cair para a frente. '
      '5. Desce até amplitude confortável, sem bater o joelho de trás no chão. '
      '6. Empurra o chão com o pé da frente para voltar ou avançar. '
      '7. Inspira ao descer e expira ao subir. '
      '8. Reduz a passada se perderes equilíbrio ou sentires dor no joelho.';

  static String _hingeSteps(String name, String equipment) =>
      '1. Fica com pés firmes e $equipment perto do corpo quando houver carga. '
      '2. Mantém peito aberto, coluna neutra e joelhos ligeiramente fletidos. '
      '3. Começa levando a anca para trás, como se fosses fechar uma porta com os glúteos. '
      '4. Deixa a carga ou as mãos descerem junto às pernas, sem afastar demasiado do corpo. '
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

  static String _coreSteps(String name, String equipment) {
    final n = _n(name);
    if (_has(n, ['prancha'])) {
      return '1. Apoia antebraços ou mãos no chão, conforme a variação. 2. Estica as pernas e fica em linha da cabeça aos calcanhares. 3. Contrai abdómen e glúteos sem levantar demasiado a anca. 4. Mantém pescoço neutro, olhando para o chão. 5. Respira curto e controlado, sem prender o ar. 6. Aguenta 10 a 40 segundos com boa forma. 7. Termina se a lombar começar a cair. 8. Para facilitar, apoia joelhos no chão.';
    }
    if (_has(n, ['crunch', 'toe touches'])) {
      return '1. Deita-te de barriga para cima com joelhos fletidos ou pernas na posição da variação. 2. Mantém lombar confortável e queixo ligeiramente recolhido. 3. Sobe a parte alta do tronco aproximando costelas da bacia. 4. Não puxes o pescoço com as mãos. 5. Pausa brevemente no topo. 6. Desce devagar até ombros quase tocarem no chão. 7. Expira ao subir e inspira ao descer. 8. Reduz amplitude se houver tensão no pescoço.';
    }
    if (_has(n, ['dead bug', 'bird dog'])) {
      return '1. Começa em posição controlada: deitado de costas para dead bug ou em quatro apoios para bird dog. 2. Ativa o abdómen antes de mexer braços ou pernas. 3. Estende o braço e a perna indicados sem deixar a lombar arquear. 4. Mantém a bacia estável e respira devagar. 5. Regressa ao centro com controlo. 6. Alterna lados sem pressa. 7. Usa menor amplitude se a lombar mexer. 8. Pára se perderes estabilidade.';
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
        return '1. Aquece 5 a 10 minutos em caminhada ou corrida leve. 2. Escolhe uma velocidade forte mas controlável para o intervalo. 3. Corre 20 a 60 segundos mantendo tronco alto e passada estável. 4. Recupera em caminhada ou trote leve durante 60 a 120 segundos. 5. Repete poucos blocos no início. 6. Respira de forma contínua e reduz se perderes técnica. 7. Faz 3 a 8 minutos de cooldown no fim.';
      }
      if (_has(n, ['inclinacao'])) {
        return '1. Começa em caminhada fácil com inclinação baixa. 2. Aumenta a inclinação gradualmente sem agarrar os apoios. 3. Mantém tronco alto e passada curta, empurrando o chão com glúteos e gémeos. 4. Usa velocidade mais baixa do que numa caminhada plana. 5. Mantém 5 a 20 minutos conforme o nível. 6. Respira de forma regular. 7. Baixa a inclinação antes de terminar.';
      }
      return '1. Sobe para a passadeira e começa devagar. 2. Ajusta a velocidade para caminhada ou corrida leve. 3. Mantém tronco alto, olhar em frente e passadas controladas. 4. Evita aterrar muito à frente do corpo. 5. Mantém 5 a 20 minutos num ritmo sustentável. 6. Respira de forma contínua, sem prender o ar. 7. Reduz velocidade no fim antes de sair.';
    }
    if (_has(n, ['bicicleta'])) {
      if (_has(n, ['cooldown'])) {
        return '1. Senta-te bem na bicicleta e baixa a resistência para nível fácil. 2. Pedala 3 a 8 minutos com cadência confortável. 3. Mantém tronco alto, ombros relaxados e mãos leves no guiador. 4. Deixa a respiração e a frequência cardíaca descerem gradualmente. 5. Não pares de pedalar de repente depois de esforço forte. 6. Termina quando te sentires estável. 7. Sai com cuidado, especialmente se as pernas estiverem pesadas.';
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
      return '1. Fica de pé com espaço livre. 2. Agacha e coloca as mãos no chão. 3. Leva os pés para trás até prancha. 4. Faz flexão apenas se a variação pedir e conseguires controlar. 5. Traz os pés para perto das mãos. 6. Levanta-te ou salta baixo. 7. Respira a cada repetição e abranda se perderes postura.';
    }
    return '1. Começa em pé com espaço livre e postura alta. 2. Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos. 3. Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo. 4. Aumenta intensidade só se a coordenação continuar limpa. 5. Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo. 6. Respira de forma regular. 7. Abranda antes de parar totalmente.';
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
    return '1. Segura uma pega em cada mão com cotovelos próximos do corpo. 2. Mantém a corda atrás dos pés antes da primeira volta. 3. Roda a corda principalmente pelos punhos, não pelos ombros. 4. Salta baixo, apenas o suficiente para a corda passar. 5. $variation. 6. Aterra na parte da frente dos pés com joelhos ligeiramente flexionados. 7. Respira em ritmo constante e faz blocos curtos no início. 8. Pára se tropeçares repetidamente, se os gémeos ficarem rígidos ou se perderes coordenação.';
  }

  static String _mobilitySteps(String name, String equipment) {
    final n = _n(name);
    if (_has(n, ['cervical', 'pescoco', 'chin tuck'])) {
      return '1. Senta-te ou fica de pé com coluna alta e ombros relaxados. 2. Mantém o olhar em frente e o maxilar solto. 3. Move a cabeça devagar na direção indicada pelo exercício, sem puxões. 4. Pára numa tensão leve, nunca em dor. 5. Mantém 15 a 30 segundos ou faz 5 a 8 repetições lentas. 6. Respira pelo nariz ou de forma calma. 7. Regressa ao centro antes de trocar de lado. 8. Termina se houver tontura, formigueiro ou dor a irradiar.';
    }
    if (_has(n, ['posterior', 'tocar nos pes'])) {
      return '1. Senta-te ou fica de pé conforme a variação. 2. Mantém joelhos esticados mas não bloqueados com força. 3. Inclina o tronco pela anca, não enrolando a lombar em excesso. 4. Leva as mãos em direção aos pés apenas até tensão confortável atrás da coxa. 5. Respira devagar durante 20 a 40 segundos. 6. Sai da posição lentamente. 7. Repete sem balanços. 8. Dobra ligeiramente joelhos se houver dor ou puxão forte.';
    }
    if (_has(n, ['gluteo', 'piriforme', 'pigeon', 'figura 4', '90/90'])) {
      return '1. Coloca a perna na posição indicada pela variação, com a anca apoiada e estável. 2. Mantém coluna longa e mãos no chão ou na perna para equilíbrio. 3. Inclina o tronco ligeiramente até sentir tensão no glúteo ou piriforme. 4. Não forces o joelho para baixo com violência. 5. Mantém 20 a 40 segundos respirando devagar. 6. Sai da posição com as mãos a ajudar. 7. Troca de lado. 8. Pára se houver dor no joelho ou formigueiro.';
    }
    if (_has(n, ['quadriceps'])) {
      return '1. Fica de pé com apoio ou deita-te de lado conforme a variação. 2. Dobra o joelho e leva o calcanhar na direção do glúteo. 3. Segura o pé ou tornozelo sem torcer o joelho. 4. Mantém joelhos próximos e bacia ligeiramente encaixada. 5. Sente alongamento na frente da coxa durante 20 a 40 segundos. 6. Respira devagar. 7. Solta o pé com cuidado e troca de lado. 8. Não forces se houver dor no joelho.';
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
    if (_has(n, ['tornozelo', 'gemeos'])) {
      return '1. Coloca o pé no chão ou contra a parede conforme a variação. 2. Mantém o calcanhar apoiado quando o objetivo for gémeos ou tornozelo. 3. Leva o joelho ou o tronco devagar até sentir tensão confortável. 4. Não deixes o arco do pé colapsar para dentro. 5. Mantém 20 a 40 segundos ou faz repetições lentas. 6. Respira calmamente. 7. Troca de lado. 8. Pára se houver dor no tendão de Aquiles ou tornozelo.';
    }
    if (_has(n, ['punho'])) {
      return '1. Apoia mãos no chão ou à frente do corpo conforme a variação. 2. Mantém cotovelos esticados sem bloquear com força. 3. Inclina o peso devagar até sentir tensão no antebraço ou punho. 4. Não forces se houver dor pontiaguda. 5. Mantém 15 a 30 segundos ou faz pequenas oscilações lentas. 6. Respira sem prender o ar. 7. Sai da posição devagar. 8. Abana as mãos levemente no fim.';
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
      '7. Aumenta velocidade só se manténs equilíbrio. '
      '8. Pára se houver dor articular, tontura ou perda de orientação.';

  static String _jiuJitsuSteps(String name) =>
      '1. Começa no tatami ou numa superfície segura, com espaço à volta. '
      '2. Define a posição inicial do $name: guarda, ponte, fuga de anca, base técnica ou passagem. '
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
      '1. Coloca-te numa posição estável para $name, com espaço livre e $equipment preparado. '
      '2. Organiza pés, tronco e cabeça antes de iniciar a repetição. '
      '3. Mantém ombros afastados das orelhas e punhos alinhados quando as mãos participarem. '
      '4. Executa a ação do exercício devagar até à amplitude em que controlas o músculo ou articulação trabalhados. '
      '5. Pausa um instante no ponto de maior esforço sem prender a respiração. '
      '6. Regressa devagar ao início, sem deixar a carga ou o corpo cair. '
      '7. Expira na fase de esforço e inspira no retorno. '
      '8. Reduz carga ou amplitude se perderes alinhamento, equilíbrio ou controlo.';

  static String _mistakesFor(String name, String group, String equipment) {
    final n = _n(name);
    if (group == 'Cardio') {
      if (_has(n, ['bicicleta'])) {
        return 'Selim mal ajustado, resistência alta demais, joelhos a abrir para fora, pedalar aos solavancos, encolher ombros ou parar de repente após esforço forte.';
      }
      if (_has(n, ['corda'])) {
        return 'Rodar a corda pelos ombros, saltar demasiado alto, aterrar com pernas rígidas, olhar para baixo, prender a respiração ou continuar quando tropeças sempre.';
      }
      if (_has(n, ['passadeira'])) {
        return 'Começar rápido demais, agarrar os apoios para compensar, dar passadas longas demais, olhar para os pés, ignorar tontura ou sair sem abrandar.';
      }
      return 'Aumentar intensidade antes da técnica, ignorar aquecimento, perder respiração, aterrar sem controlo ou continuar com dor articular.';
    }
    if (group == 'Mobilidade') {
      return 'Forçar dor, fazer balanços rápidos, prender a respiração, compensar com lombar ou ombros, sair da posição de repente ou tentar ganhar amplitude à força.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Acelerar antes de controlar a técnica, perder base, cruzar pés de forma insegura, prender a respiração, torcer joelhos ou repetir cansado com má coordenação.';
    }
    if (_isCurl(name)) {
      return 'Balançar o tronco, levar cotovelos para trás e para a frente, dobrar os punhos, subir só metade, usar carga excessiva ou deixar a carga cair na descida.';
    }
    if (_isTriceps(name)) {
      return 'Abrir demasiado os cotovelos, mexer o ombro em vez do cotovelo, arquear a lombar, usar carga excessiva ou encurtar a descida.';
    }
    if (_isGripOrForearm(name, group)) {
      return 'Dobrar os punhos sem controlo, usar carga pesada demais, perder pega de repente, encolher ombros, prender a respiração ou continuar com dor no punho.';
    }
    if (_isPushupOrPress(name)) {
      return 'Abrir cotovelos demais, perder posição das escápulas, deixar punhos dobrarem, arquear a lombar, bater a carga ou descer sem controlo.';
    }
    if (_isRowOrPull(name)) {
      return 'Puxar com balanço, encolher ombros, arredondar lombar, puxar atrás da nuca, largar a subida ou transformar a puxada num movimento de bíceps apenas.';
    }
    if (_isSquat(name) || _isLunge(name)) {
      return 'Joelhos a cair para dentro, calcanhares a levantar, tronco a colapsar, carga mal posicionada, descer mais do que controlas ou prender a respiração.';
    }
    if (_isHinge(name)) {
      return 'Arredondar a lombar, afastar a carga do corpo, dobrar demasiado os joelhos, não levar a anca para trás ou subir puxando só pelas costas.';
    }
    return 'Usar carga acima do controlo, perder alinhamento, encurtar amplitude, prender a respiração ou continuar quando o músculo trabalhado já não controla o exercício.';
  }

  static String _safetyFor(String name, String group, String equipment) {
    final n = _n(name);
    if (_has(n, ['pescoco', 'cervical', 'chin tuck'])) {
      return 'Usa força muito leve. Para imediatamente com tontura, formigueiro, dor irradiada, pressão na cabeça, visão turva ou dor aguda no pescoço.';
    }
    if (group == 'Cardio') {
      return 'Mantém intensidade adequada ao teu nível. Abranda ou termina se houver tontura, dor no peito, falta de ar fora do normal, dor articular ou perda de coordenação.';
    }
    if (group == 'Mobilidade') {
      return 'Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.';
    }
    if (_isHinge(name)) {
      return 'Mantém a coluna neutra e a carga perto do corpo. Para com dor lombar aguda, formigueiro, perda de força ou incapacidade de controlar a anca.';
    }
    if (_isPushupOrPress(name) || _isShoulder(name)) {
      return 'Protege ombros e punhos mantendo carga controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo da carga.';
    }
    if (_isGripOrForearm(name, group) || _isCurl(name) || _isTriceps(name)) {
      return 'Mantém punhos e cotovelos alinhados. Reduz carga ou termina se houver dor no cotovelo, punho, formigueiro nos dedos ou perda de pega.';
    }
    if (_isSquat(name) || _isLunge(name)) {
      return 'Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.';
    }
    return 'Usa $equipment apenas com carga e amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.';
  }

  static bool _beginnerUnderstands(ExerciseCatalogDetails details) {
    final text = '${details.description} ${details.executionSteps}';
    final lower = text.toLowerCase();
    return details.description.length > 80 &&
        details.executionSteps.split(RegExp(r'\d+\.')).length >= 6 &&
        (lower.contains('respira') ||
            lower.contains('inspira') ||
            lower.contains('expira')) &&
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

  static bool _isCurl(String name) => _has(_n(name), ['curl']);
  static bool _isTriceps(String name) {
    final n = _n(name);
    if (_has(n, ['kickback de gluteo'])) return false;
    return _has(n, [
      'triceps',
      'tricep',
      'triceps',
      'extensao francesa',
      'extensao de triceps',
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
