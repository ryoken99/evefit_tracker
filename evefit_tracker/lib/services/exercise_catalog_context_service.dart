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
    return '$text O objetivo de $name é melhorar ${_primaryTarget(name, group)} através de ${_movementSummary(name, group).toLowerCase()}.';
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
    return _teachingDescription(
      name: name,
      group: group,
      equipment: equipment,
      secondary: secondary,
    );
  }

  static String _teachingDescription({
    required String name,
    required String group,
    required String equipment,
    required String secondary,
  }) {
    final movement = _movementSummary(name, group);
    final target = _primaryTarget(name, group);
    final equipmentCue = _equipmentUseCue(name, equipment);
    final beginnerCue = _beginnerPurposeCue(name, group);
    final variant = stableKey(name).length % 3;
    if (variant == 0) {
      return '$name: $movement Treina principalmente $target. $equipmentCue $beginnerCue Também ajuda $secondary.';
    }
    if (variant == 1) {
      return '$name: $movement $beginnerCue O trabalho principal é $target. $equipmentCue Como apoio, envolve $secondary.';
    }
    return '$name: $movement $equipmentCue O foco principal é $target. $beginnerCue Em segundo plano, participa $secondary.';
  }

  static String _movementSummary(String name, String group) {
    final n = _n(name);
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
    if (_has(n, ['wrist curl'])) {
      return 'flexão do punho com antebraços apoiados, levando a palma na direção do antebraço sem mexer o cotovelo.';
    }
    if (_has(n, ['reverse wrist'])) {
      return 'extensão do punho com antebraços apoiados, levantando os nós dos dedos contra a resistência.';
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
      return 'flexão do cotovelo para aproximar a carga do ombro sem balançar tronco ou ombros.';
    }
    if (_has(n, ['kickback'])) {
      return 'extensão do cotovelo com o braço junto ao tronco, levando a carga para trás até o tríceps contrair.';
    }
    if (_has(n, ['francesa', 'acima da cabeca'])) {
      return 'extensão do cotovelo acima ou atrás da cabeça, alongando a cabeça longa do tríceps antes de subir.';
    }
    if (_isTriceps(name)) {
      return 'extensão do cotovelo para empurrar ou afastar a carga, mantendo o braço estável.';
    }
    if (_has(n, ['flexao classica'])) {
      return 'flexão de braços em prancha alta, aproximando o peito do chão e empurrando o corpo de volta.';
    }
    if (_has(n, ['flexao inclinada'])) {
      return 'flexão com mãos elevadas num apoio, reduzindo a carga para aprender o padrão de empurrar.';
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
      return 'flexão com joelhos apoiados para reduzir a carga e aprender a linha do corpo.';
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
    if (_has(n, ['kihon'])) return 'repetição técnica de bases, socos, defesas ou pontapés fundamentais com controlo.';
    if (_has(n, ['kata'])) return 'sequência formal de técnicas de Karate com direção, ritmo, postura e controlo.';
    if (_has(n, ['kumite'])) return 'drill técnico de combate para distância, guarda e reação controlada.';
    if (_has(n, ['sombra'])) return 'simulação individual de combate, combinando deslocamento, técnicas no ar e controlo.';
    if (_has(n, ['deslocamento'])) return 'trabalho de pés para entrar, sair e mudar ângulo sem cruzar a base, mantendo controlo.';
    if (_has(n, ['drills de guarda'])) {
      return 'repetições de entrada e saída de guarda para organizar mãos, cotovelos, distância e controlo.';
    }
    if (_has(n, ['guarda'])) return 'organização das mãos, cotovelos e postura para proteger, responder e manter controlo.';
    if (_has(n, ['pontapes'])) return 'pontapés técnicos com câmara, extensão, recolha da perna e controlo.';
    if (_has(n, ['socos'])) return 'socos técnicos coordenando punho, anca, tronco, base e controlo.';
    return 'drill de Karate para praticar base, direção, precisão e controlo antes da velocidade.';
  }

  static String _jiuJitsuMovementSummary(String name) {
    final n = _n(name);
    if (_has(n, ['shrimp', 'fuga de anca'])) return 'fuga de anca no solo para criar espaço e recuperar guarda.';
    if (_has(n, ['ponte'])) return 'ponte de grappling para elevar a anca e desequilibrar pressão.';
    if (_has(n, ['technical stand-up'])) return 'subida técnica do chão mantendo uma mão protegida e a perna livre.';
    if (_has(n, ['passagem de guarda'])) {
      return 'repetição de passos, pressão e controlo de anca para passar as pernas do adversário.';
    }
    if (_has(n, ['guarda'])) return 'drill de guarda para gerir pernas, anca, pega e distância.';
    if (_has(n, ['passagem'])) return 'movimento de passar guarda com base, pressão e controlo de anca.';
    if (_has(n, ['pega'])) return 'trabalho de pega aplicado a kimono, punhos ou controlo de grappling.';
    if (_has(n, ['core'])) return 'drill de core no solo para proteger coluna e transferir força pela anca.';
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
    if (_has(n, ['farmer', 'hold', 'dead hang', 'aperto', 'pinch', 'plate', 'towel'])) {
      return 'força de pega, dedos e antebraço';
    }
    if (_has(n, ['wrist curl', 'finger'])) return 'flexores do antebraço e dedos';
    if (_has(n, ['reverse wrist', 'extensao de dedos'])) {
      return 'extensores do antebraço e punho';
    }
    if (_has(n, ['pronacao'])) return 'pronadores do antebraço';
    if (_has(n, ['supinacao'])) return 'supinadores do antebraço';
    if (_has(n, ['desvio', 'rotacao controlada'])) return 'punho e controlo do antebraço';
    if (_has(n, ['martelo', 'braquiorradial'])) return 'braquial e braquiorradial';
    if (_isCurl(name)) return 'bíceps braquial, braquial e braquiorradial';
    if (_isTriceps(name)) return 'tríceps';
    if (_isFly(name) || _isPushupOrPress(name)) return 'peito, ombros e tríceps';
    if (_isRowOrPull(name)) return 'costas, escápulas e dorsal';
    if (_isShoulder(name)) return 'ombros e estabilizadores escapulares';
    if (_isSquat(name) || _isLunge(name)) return 'quadríceps, glúteos e estabilidade da anca';
    if (_isHinge(name)) return 'posterior de coxa, glúteos e lombar controlada';
    if (_has(n, ['gemeos', 'soleo'])) return 'gémeos, sóleo e tornozelo';
    if (_has(n, ['tibial'])) return 'tibial anterior';
    if (_isCore(name, group)) return 'core, abdominal e estabilidade do tronco';
    if (group == 'Cardio') return 'resistência cardiovascular e respiração';
    if (group == 'Mobilidade') return 'mobilidade da zona indicada e respiração';
    if (group == 'Karate') return 'técnica de Karate, base e coordenação';
    if (_has(n, ['passagem de guarda'])) {
      return 'passagem de guarda, pressão e controlo da anca';
    }
    if (_has(n, ['drills de guarda'])) {
      return 'retenção de guarda, distância e movimento de anca';
    }
    if (group == 'Jiu-Jitsu') return 'movimentação de Jiu-Jitsu, anca e controlo no solo';
    if (_has(n, ['pescoco', 'cervical', 'chin tuck'])) return 'controlo cervical';
    return group;
  }

  static String _equipmentUseCue(String name, String equipment) {
    final n = _n(name);
    final e = _n(equipment);
    if (_has(e, ['halter'])) {
      if (_has(n, ['farmer walk', 'suitcase'])) {
        return 'Usa $equipment como carga de transporte, com pega firme.';
      }
      if (_has(n, ['hold', 'aperto'])) {
        return 'Usa $equipment para segurar parado sem largar de repente.';
      }
      if (_has(n, ['pronacao', 'supinacao', 'desvio', 'rotacao'])) {
        return 'Usa $equipment leve como alavanca curta.';
      }
      return 'Usa $equipment com pega firme e punhos neutros.';
    }
    if (_has(e, ['barra']) && !_has(e, ['barra fixa'])) {
      return 'Usa $equipment com pega simétrica.';
    }
    if (_has(e, ['cabo', 'polia'])) {
      return 'Usa $equipment alinhando a polia ao movimento.';
    }
    if (_has(e, ['maquina'])) {
      return 'Usa $equipment ajustando assento ou apoio.';
    }
    if (_has(e, ['barra fixa'])) {
      return 'Usa $equipment com mãos firmes e ombros ativos.';
    }
    if (_has(e, ['elastico'])) {
      return 'Usa $equipment preso de forma segura.';
    }
    if (_has(e, ['passadeira', 'bicicleta', 'eliptica', 'corda'])) {
      return 'Usa $equipment regulando intensidade e duração.';
    }
    return 'Usa $equipment com espaço livre e apoio seguro para a variação escolhida.';
  }

  static String _beginnerPurposeCue(String name, String group) {
    final n = _n(name);
    if (_has(n, ['farmer walk'])) {
      return 'Para iniciantes, a meta é caminhar 10 a 20 metros sem os halteres balançarem.';
    }
    if (_has(n, ['farmer hold', 'hold estatico'])) {
      return 'Para iniciantes, a meta é ficar parado 20 a 30 segundos sem dobrar punhos nem encolher ombros.';
    }
    if (_has(n, ['cervical', 'pescoco', 'chin tuck'])) {
      return 'O movimento deve ser pequeno e suave, parando antes de tontura ou formigueiro.';
    }
    if (group == 'Mobilidade') {
      return 'A sensação correta é tensão leve e respirável, mantida por segundos, não dor.';
    }
    if (group == 'Cardio') {
      return 'A intensidade deve permitir controlar respiração, duração e técnica antes de acelerar.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      if (_has(n, ['passagem de guarda'])) {
        return 'Treina devagar a sequência de grips, ângulo e pressão antes de juntar velocidade.';
      }
      if (_has(n, ['drills de guarda'])) {
        return 'Começa por recuperar enquadramento e distância antes de repetir a troca de lados.';
      }
      return 'Começa devagar para aprender base, direção e coordenação antes de ganhar velocidade.';
    }
    if (_isHinge(name)) {
      return 'Aprende primeiro a dobrar pela anca sem arredondar a lombar.';
    }
    if (_isSquat(name) || _isLunge(name)) {
      return 'A prioridade é joelhos alinhados com os pés e descida que consegues controlar.';
    }
    if (_isCurl(name) || _isTriceps(name) || _isGripOrForearm(name, group)) {
      return 'O peso deve permitir punhos e cotovelos estáveis do início ao fim.';
    }
    return 'Escolhe uma versão em que consigas repetir o movimento mantendo respiração e alinhamento.';
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
      '7. Aumenta velocidade só se manténs equilíbrio e controlo. '
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
