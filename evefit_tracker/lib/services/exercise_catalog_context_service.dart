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
    regression: details.regression,
    progression: details.progression,
    breathingTips: details.breathingTips,
    postureTips: details.postureTips,
    adaptationNotes: details.adaptationNotes,
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
    final regression = _regressionFor(name, group, equipment);
    final progression = _progressionFor(name, group, equipment);
    final breathing = _breathingFor(name, group);
    final posture = _postureFor(name, group);
    final adaptation = _adaptationFor(name, group);
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
        regression,
        progression,
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
      regression: regression,
      progression: progression,
      breathingTips: breathing,
      postureTips: posture,
      adaptationNotes: adaptation,
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
      return '$group — $text';
    }
    final movement = _movementSummary(name, group).toLowerCase().replaceAll(
      RegExp(r'\.\s*$'),
      '',
    );
    return '$group — $text O objetivo de $name é melhorar ${_primaryTarget(name, group)} através de $movement.';
  }

  static String _ensureStepContract(
    String text,
    String name,
    String group,
    String equipment,
    String regression,
    String progression,
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
    addIfMissing(
      'ritmo recomendado',
      'Ritmo recomendado em $name: usa cerca de dois segundos na fase de esforço, faz uma pausa curta e regressa em dois a três segundos.',
    );
    addIfMissing(
      'como perceber se esta mal feito',
      'Como perceber se $name está mal feito: termina a série se já não conseguires repetir a mesma trajetória, alinhamento e amplitude sem dor.',
    );
    addIfMissing(
      'erro mais comum',
      'Erro mais comum em $name no treino de $group: acelerar para compensar a fadiga e deixar outra zona do corpo assumir o trabalho.',
    );
    addIfMissing('versao mais facil', regression);
    addIfMissing('versao mais dificil', progression);
    return additions.isEmpty ? text : '$text ${additions.join(' ')}';
  }

  static String _regressionFor(String name, String group, String equipment) {
    final n = _n(name);
    if (_has(n, ['press militar com barra em pe'])) {
      return 'Versão mais fácil: pratica o press vertical sentado com encosto e barra leve antes de estabilizar a carga em pé.';
    }
    if (_has(n, ['y raise'])) {
      return 'Versão mais fácil: desenha o Y deitado num banco inclinado, sem carga, parando antes de encolher o pescoço.';
    }
    if (_has(n, ['w raise'])) {
      return 'Versão mais fácil: mantém a forma de W sem carga e faz apenas a retração curta das escápulas.';
    }
    if (_has(n, ['curl 21'])) {
      return 'Versão mais fácil: substitui a sequência 21 por curls completos com halteres leves e descanso normal entre séries.';
    }
    if (group == 'Cardio') {
      return 'Versão mais fácil: pratica $name durante menos tempo, a ritmo em que consigas falar, e aumenta a duração antes da intensidade.';
    }
    if (group == 'Mobilidade') {
      return 'Versão mais fácil: reduz a amplitude de $name e usa parede, banco ou chão como apoio até conseguires respirar sem dor.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Versão mais fácil: executa $name devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.';
    }
    if (_has(n, ['pull-up', 'chin-up', 'dips'])) {
      return 'Versão mais fácil: faz $name com apoio dos pés, elástico ou máquina assistida, mantendo a mesma trajetória articular.';
    }
    if (_has(n, ['flexao', 'flexão'])) {
      return 'Versão mais fácil: faz $name com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.';
    }
    if (_has(n, ['agachamento', 'lunges', 'step-up'])) {
      return 'Versão mais fácil: faz $name sem carga, com menor amplitude e apoio numa parede ou cadeira estável.';
    }
    if (_has(n, ['prancha', 'hollow', 'pallof'])) {
      return 'Versão mais fácil: encurta a alavanca ou a duração de $name e usa menos resistência sem perder a posição das costelas e bacia.';
    }
    return 'Versão mais fácil: faz $name com menos carga ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.';
  }

  static String _progressionFor(String name, String group, String equipment) {
    final n = _n(name);
    if (_has(n, ['press militar com barra em pe'])) {
      return 'Versão mais difícil: aumenta gradualmente a barra mantendo glúteos, costelas e trajetória vertical estáveis em pé.';
    }
    if (_has(n, ['y raise'])) {
      return 'Versão mais difícil: acrescenta halteres leves ao desenho em Y e pausa com polegares apontados para cima.';
    }
    if (_has(n, ['w raise'])) {
      return 'Versão mais difícil: acrescenta elástico leve ao W sem perder retração e rotação externa das escápulas.';
    }
    if (_has(n, ['curl 21'])) {
      return 'Versão mais difícil: aumenta ligeiramente os halteres mantendo sete parciais inferiores, sete superiores e sete completas limpas.';
    }
    if (group == 'Cardio') {
      if (_has(n, ['passadeira'])) {
        return 'Versão mais difícil: aumenta em $name apenas a duração, a inclinação ou a velocidade de cada vez.';
      }
      if (_has(n, ['bicicleta'])) {
        return 'Versão mais difícil: aumenta em $name apenas a duração, a resistência ou a cadência de cada vez.';
      }
      if (_has(n, ['corda'])) {
        return 'Versão mais difícil: aumenta em $name apenas a duração, o ritmo ou a complexidade dos saltos de cada vez.';
      }
      if (_has(n, ['eliptica', 'elíptica'])) {
        return 'Versão mais difícil: aumenta em $name apenas a duração, a resistência ou a cadência de cada vez.';
      }
      return 'Versão mais difícil: aumenta em $name apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.';
    }
    if (group == 'Mobilidade') {
      return 'Versão mais difícil: amplia gradualmente $name ou acrescenta controlo ativo no fim da amplitude, sempre sem dor articular.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Versão mais difícil: liga $name a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.';
    }
    if (_has(n, ['unilateral', 'alternado', 'suitcase'])) {
      return 'Versão mais difícil: aumenta gradualmente a carga ou a pausa de $name sem permitir rotação ou inclinação do tronco.';
    }
    return 'Versão mais difícil: progride $name com pequena subida de carga, pausa mais longa ou descida mais lenta, alterando uma variável por vez.';
  }

  static String _breathingFor(String name, String group) {
    if (group == 'Mobilidade') {
      return 'Respira lentamente durante $name; usa a expiração para relaxar sem forçar mais amplitude.';
    }
    if (group == 'Cardio') {
      return 'Mantém respiração contínua em $name e reduz o ritmo se não conseguires recuperar o padrão respiratório.';
    }
    return 'Inspira na preparação ou no retorno de $name e expira durante o esforço; não prendas a respiração em repetições normais.';
  }

  static String _postureFor(String name, String group) {
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Em $name, conserva uma base estável, pescoço neutro, guarda organizada e espaço seguro para cair ou deslocar.';
    }
    return 'Em $name, mantém os apoios firmes, coluna e pescoço neutros e as articulações a seguir a trajetória indicada.';
  }

  static String _adaptationFor(String name, String group) {
    final n = _n(name);
    if (_has(n, ['pescoco', 'cervical'])) {
      return 'Evita ou adapta $name com tontura, dor irradiada, formigueiro ou diagnóstico cervical; usa apenas força muito leve e orientação clínica quando indicada.';
    }
    if (group == 'Cardio') {
      return 'Adapta duração e intensidade de $name à condição atual; interrompe com dor no peito, tontura ou falta de ar fora do habitual.';
    }
    return 'Evita ou adapta $name se houver dor aguda, instabilidade, perda de força ou limitação clínica que impeça a amplitude descrita sem compensação.';
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
    if (context == 'karate') {
      // Os drills de Karate treinam-se de pé; nenhum exige tatami.
      return 'Peso corporal';
    }
    if (context == 'jiu_jitsu') {
      // Só os drills de solo pedem tatami/tapete; mobilidade, pega, core e
      // condicionamento fazem-se em qualquer piso seguro.
      if (_has(n, [
        'shrimp',
        'ponte de grappling',
        'technical stand-up',
        'guarda',
        'sprawl',
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
    if (_has(_n(name), ['extensao lombar quadrupede'])) {
      return _quadrupedBackExtensionSteps();
    }
    if (_isCore(name, group)) return _coreSteps(name, equipment);
    return _generalSpecificSteps(name, group, equipment);
  }

  static String? _distinctVariantSteps(String name, String equipment) {
    final n = _n(name);
    if (_has(n, ['press militar com barra em pe'])) {
      return '1. Coloca a barra num suporte à altura da parte alta do peito e usa pega simétrica um pouco além dos ombros. 2. Retira a barra, dá um passo curto e fica com pés paralelos, glúteos firmes e costelas sobre a bacia. 3. Começa com a barra à frente dos ombros e antebraços quase verticais. 4. Afasta ligeiramente a cabeça, empurra a barra para cima e volta a colocar a cabeça entre os braços. 5. Termina com a barra sobre o meio do pé sem arquear a lombar. 6. Baixa pelo mesmo caminho até à frente dos ombros. 7. Inspira antes da subida e expira depois de passar a zona mais difícil. 8. Usa menos carga se inclinares o tronco, dobrares punhos ou perderes equilíbrio.';
    }
    if (_has(n, ['y raise'])) {
      return '1. Inclina o tronco ou apoia o peito num banco, deixando braços pendurados e polegares para cima. 2. Mantém pescoço longo, costelas controladas e cotovelos quase estendidos. 3. Eleva os braços na diagonal para formar um Y largo acima da cabeça. 4. Inicia pelas escápulas sem encolher os ombros. 5. Pára quando braços e tronco ficam alinhados ou antes de perder a posição. 6. Baixa durante dois a três segundos até os braços ficarem pendurados. 7. Expira ao desenhar o Y e inspira ao baixar. 8. Faz sem carga se sentires o trapézio superior dominar.';
    }
    if (_has(n, ['w raise'])) {
      return '1. Inclina o tronco ou apoia o peito e começa com cotovelos dobrados junto ao corpo. 2. Vira polegares para cima e mantém punhos sobre a linha dos cotovelos. 3. Aproxima as escápulas e eleva os braços até formarem a letra W. 4. Mantém cotovelos dobrados enquanto rodas os ombros para fora. 5. Pausa sem projetar o queixo nem levantar os ombros. 6. Regressa devagar até aliviar a retração escapular. 7. Expira ao formar o W e inspira no retorno. 8. Reduz carga ou amplitude se sentires pinçamento na frente do ombro.';
    }
    if (_has(n, ['curl 21'])) {
      return '1. Fica alto com halteres leves, palmas para a frente e cotovelos junto às costelas. 2. Sobe sete vezes apenas da extensão quase completa até os cotovelos chegarem a cerca de 90 graus. 3. Sem descanso, faz sete repetições de 90 graus até perto dos ombros. 4. Mantém punhos direitos e não avances os cotovelos durante as parciais superiores. 5. Termina com sete curls completos do fundo ao topo. 6. Desce cada repetição com controlo e pára se precisares de balançar. 7. Expira em cada subida e inspira em cada descida. 8. Escolhe carga bem menor que no curl normal porque a série soma 21 repetições.';
    }
    return null;
  }

  /// Passos escritos individualmente para exercícios cuja variação não fica
  /// bem explicada pelos moldes de família (ex.: agachamento búlgaro precisa
  /// do pé de trás no banco; curl de perna é máquina de posterior de coxa).
  static String? _specificSteps(String name, String group, String equipment) {
    final n = _n(name);
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
          '3. Coloca a carga sobre a anca se usares peso, ou mantém as mãos na borda do apoio. '
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
          '2. Coloca uma carga (halteres ou discos) em cima das coxas, perto dos joelhos, ou usa a máquina própria. '
          '3. Mantém os joelhos dobrados a 90 graus e o tronco direito. '
          '4. Sobe os calcanhares empurrando com a ponta dos pés, levantando a carga com a perna inferior. '
          '5. Faz uma pausa curta no topo. '
          '6. Desce os calcanhares devagar até um alongamento confortável. '
          '7. Expira ao subir e inspira ao descer. '
          '8. Com o joelho dobrado, o esforço concentra-se mais no sóleo, o músculo profundo do gémeo. '
          '9. Segura a carga com as mãos para ela não deslizar das coxas.';
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
          '2. Coloca uma carga leve sobre as coxas, perto dos joelhos, segurando-a com as mãos. '
          '3. Mantém o tronco direito e os pés à largura da anca. '
          '4. Sobe os calcanhares devagar, empurrando com a ponta dos pés. '
          '5. Faz uma pausa curta no topo, sentindo a parte profunda da barriga da perna. '
          '6. Desce os calcanhares em dois a três segundos até tocar no chão. '
          '7. Expira ao subir e inspira ao descer. '
          '8. O joelho dobrado tira trabalho ao gémeo grande e concentra-o no sóleo. '
          '9. Aumenta a carga apenas quando controlares a subida e a descida.';
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
          '3. Puxa a carga para cima, junto ao corpo, levando os cotovelos para fora e para cima. '
          '4. Sobe apenas até os cotovelos ficarem à altura dos ombros ou abaixo, nunca mais alto. '
          '5. Mantém os ombros afastados das orelhas e as escápulas controladas. '
          '6. Desce a carga devagar pelo mesmo caminho, junto ao tronco. '
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
          '2. Começa com os halteres à frente dos ombros, com as palmas viradas para ti, como no fim de um curl. '
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
          '2. Segura o halter com a mão livre, com o braço pendurado e o punho direito. '
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
          '4. Começa com os braços esticados à frente, à altura dos ombros, com os cotovelos quase estendidos. '
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
    if (_has(n, ['hiperextensao no banco romano']) || n == 'hiperextensao lombar') {
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
      return '1. Senta-te num banco ou cadeira com as pernas afastadas e um halter numa mão. '
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
          '2. Segura um halter em cada mão com as palmas para a frente e punhos direitos. '
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
          '2. Deixa os braços pendurados ao lado, com um halter em cada mão e palmas para a frente. '
          '3. Sente o bíceps alongado nessa posição inicial, com os punhos direitos. '
          '4. Sobe os halteres dobrando os cotovelos, sem deixar os cotovelos vir para a frente. '
          '5. Mantém os ombros encostados ao banco durante toda a repetição. '
          '6. Aperta no topo e desce em dois a três segundos até alongar de novo. '
          '7. Expira ao subir e inspira ao descer. '
          '8. Mantém o tronco quieto: o banco existe para impedir compensações. '
          '9. Usa carga menor que no curl em pé, porque o bíceps parte de uma posição alongada.';
    }
    if (_has(n, ['curl isometrico'])) {
      return '1. Fica de pé com um halter em cada mão e os cotovelos junto ao tronco. '
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
          '5. Empurra a corda para baixo estendendo os cotovelos e afasta as pontas no fim. '
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
          '5. Empurra a barra para baixo estendendo os cotovelos até os braços quase esticarem. '
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
          '10. Para adicionar carga, segura uma garrafa de água ou outra carga pequena na mão do lado que desliza.';
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
          '5. Roda depois para o outro lado, com o movimento a vir do tronco e não dos braços. '
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
      return '1. Senta-te com antebraços apoiados nas coxas e palmas viradas para cima. 2. Deixa só as mãos fora do apoio, segurando $equipment com dedos fechados. 3. Baixa os nós dos dedos na direção do chão até sentires alongamento na parte interna do antebraço. 4. Fecha a pega e dobra os punhos para trazer as palmas na direção do antebraço. 5. Sobe apenas pela flexão do punho, sem levantar os antebraços. 6. Mantém cotovelos colados ao apoio. 7. Desce durante 2 segundos e inspira nessa fase. 8. Expira ao fletir os punhos. 9. Termina se aparecer dor na parte da frente do punho.';
    }
    if (_has(n, ['reverse wrist'])) {
      return '1. Senta-te com os antebraços apoiados e palmas viradas para baixo. 2. Segura $equipment com pega leve, deixando os punhos fora do banco ou das coxas. 3. Mantém cotovelos parados e ombros relaxados. 4. Sobe os nós dos dedos para cima, como se quisesses apontar as costas da mão para o teto. 5. Para antes de sentir dor na parte de cima do punho. 6. Baixa a carga devagar até os punhos voltarem a ficar alinhados ou ligeiramente fletidos. 7. Expira ao levantar os nós dos dedos e inspira ao baixar. 8. Usa carga menor se precisares de mexer cotovelos ou ombros para subir.';
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
    if (_has(n, ['mobilidade de tornozelo na parede'])) {
      return '1. Fica de frente para uma parede com um pé a alguns centímetros dela. 2. Mantém o calcanhar desse pé totalmente apoiado no chão. 3. Leva o joelho devagar na direção da parede, alinhado com o segundo ou terceiro dedo do pé. 4. Para quando o calcanhar quiser levantar ou o arco do pé colapsar. 5. Volta o joelho para trás e repete 8 a 12 vezes. 6. Respira de forma calma a cada avanço. 7. Afasta ou aproxima o pé da parede para ajustar a dificuldade. 8. Pára se houver dor no tendão de Aquiles, tornozelo ou frente do pé.';
    }
    if (_has(n, ['circulos de tornozelo'])) {
      return '1. Senta-te ou fica de pé com apoio e tira ligeiramente um pé do chão. 2. Mantém a perna quieta para o movimento vir do tornozelo. 3. Desenha círculos lentos com a ponta do pé, primeiro para dentro e depois para fora. 4. Faz 6 a 10 círculos por direção. 5. Mantém os dedos relaxados, sem enrolar o pé. 6. Respira normalmente durante o movimento. 7. Troca de lado e repete. 8. Reduz o tamanho do círculo se houver dor ou estalidos desconfortáveis.';
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
    if (_has(n, ['extensao lombar quadrupede'])) {
      return 'Abrir a bacia para o lado, afundar entre as omoplatas, atirar o pé para cima, mexer o tronco a cada repetição ou procurar altura em vez de estabilidade.';
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
    if (_has(n, ['extensao lombar quadrupede'])) {
      return 'Mantém o gesto pequeno e silencioso. Interrompe se a bacia rodar sempre, se a lombar apertar, se surgir dor irradiada ou se precisares de impulso para levantar a perna.';
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
