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
    final equipment = base.equipment.trim().isEmpty
        ? 'Peso corporal'
        : base.equipment.trim();
    final secondary = base.secondaryGroups.trim().isEmpty
        ? _secondaryFallback(group)
        : base.secondaryGroups.trim();
    return ExerciseCatalogDetails(
      equipment: equipment,
      secondaryGroups: secondary,
      description: _description(name, group, equipment, secondary),
      executionSteps: _steps(name, group, equipment),
      commonMistakes: _mistakes(name, group, equipment),
      safetyNotes: _safety(name, group, equipment),
    );
  }

  static String _description(
    String name,
    String group,
    String equipment,
    String secondary,
  ) {
    final target = _targetFor(name, group);
    final movement = _movementCue(name, group);
    return '$name no contexto $group é um exercício ou drill para treinar $target. '
        'Serve para praticar $movement com o equipamento indicado: $equipment. '
        'Também ajuda $secondary, desde que mantenhas controlo da zona alvo e '
        'pares antes de dor ou perda clara de coordenação.';
  }

  static String _steps(String name, String group, String equipment) {
    if (group == 'Cardio') return _cardioSteps(name, equipment);
    if (group == 'Mobilidade') return _mobilitySteps(name, equipment);
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return _martialSteps(name, group, equipment);
    }
    return _strengthSteps(name, group, equipment);
  }

  static String _strengthSteps(String name, String group, String equipment) {
    final grip = _gripCue(equipment);
    final movement = _movementCue(name, group);
    final amplitude = _amplitudeCue(name, group);
    return '1. Coloca-te numa base estável para $name, com pés firmes e espaço livre à volta. '
        '2. $grip '
        '3. Organiza peito, costelas e bacia para a coluna ficar neutra, sem encolher os ombros para as orelhas. '
        '4. Inicia o movimento: $movement. '
        '5. Usa esta amplitude: $amplitude. '
        '6. Mantém punhos, cotovelos, joelhos ou anca alinhados com a direção do exercício, conforme a articulação principal. '
        '7. Inspira na fase de preparação ou descida e expira na fase de maior esforço. '
        '8. Regressa devagar ao início, mantendo a carga ou o corpo sob controlo até a repetição terminar. '
        '9. Se fores iniciante, reduz carga, alcance ou inclinação até conseguires repetir sem dor e sem balanço.';
  }

  static String _mobilitySteps(String name, String equipment) =>
      '1. Escolhe uma posição confortável e estável para $name, usando $equipment apenas se for indicado. '
      '2. Alinha a coluna de forma neutra e relaxa maxilar, ombros e mãos antes de começar. '
      '3. Move devagar até sentires tensão leve na zona alvo, mantendo a sensação abaixo de dor. '
      '4. Respira devagar durante 15 a 30 segundos ou faz repetições lentas durante 30 a 60 segundos. '
      '5. Mantém o alcance no ponto em que consegues continuar a respirar sem prender o ar. '
      '6. Sai da posição lentamente e repete do outro lado quando o exercício for unilateral. '
      '7. Para se aparecer formigueiro, tontura, pressão articular ou dor que aumenta.';

  static String _cardioSteps(String name, String equipment) =>
      '1. Prepara $equipment e começa $name em intensidade fácil durante 3 a 5 minutos. '
      '2. Mantém tronco alto, olhar em frente e passadas, pedaladas ou saltos com ritmo regular. '
      '3. Ajusta velocidade, inclinação, resistência ou cadência para a intensidade pretendida sem perder coordenação. '
      '4. Mantém a parte principal entre 5 e 20 minutos, ou 20 a 60 segundos por intervalo quando o foco for intervalado. '
      '5. Respira de forma contínua; em esforço moderado deves conseguir dizer frases curtas. '
      '6. Reduz a intensidade durante 2 a 5 minutos no fim antes de parar totalmente. '
      '7. Para se houver tontura, dor no peito, dor articular ou falta de ar fora do normal.';

  static String _martialSteps(String name, String group, String equipment) =>
      '1. Começa em base estável de $group, em $equipment, com joelhos soltos e peso distribuído pelos pés. '
      '2. Define o objetivo técnico de $name antes de aumentar velocidade. '
      '3. Executa a primeira repetição devagar, coordenando pés, anca, tronco, mãos e olhar. '
      '4. Regressa à base sem cruzar os pés de forma insegura nem torcer joelho ou ombro. '
      '5. Respira em cada repetição e mantém maxilar e ombros relaxados. '
      '6. Trabalha blocos de 30 a 60 segundos e descansa antes de perder precisão. '
      '7. Para se houver dor articular, impacto na cabeça, tontura ou perda de orientação.';

  static String _mistakes(String name, String group, String equipment) {
    if (group == 'Cardio') {
      return 'Começar $name com intensidade alta demais, saltar aquecimento, agarrar apoios sem necessidade, perder ritmo respiratório, ignorar dor articular ou transformar uma sessão leve em esforço máximo sem planeamento.';
    }
    if (group == 'Mobilidade') {
      return 'Forçar dor em vez de tensão leve, prender a respiração, fazer balanços rápidos, sair da posição de repente, compensar com a lombar ou tentar ganhar alcance à força.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Acelerar $name antes de entender a técnica, torcer joelhos ou ombros, prender a respiração, perder a base, repetir cansado com má coordenação ou usar impacto desnecessário.';
    }
    return 'Usar $equipment acima do controlo, iniciar $name com balanço, perder alinhamento da articulação principal, encurtar a amplitude útil, prender a respiração ou continuar depois de a zona alvo deixar de controlar o movimento.';
  }

  static String _safety(String name, String group, String equipment) {
    if (_containsAny(name, ['pescoço', 'cervical', 'chin tuck'])) {
      return 'Usa força muito leve no pescoço. Para imediatamente se sentires dor aguda, tontura, formigueiro, pressão na cabeça, visão turva ou dor a irradiar para ombro e braço.';
    }
    if (_containsAny(name, ['peso morto', 'good morning', 'lombar'])) {
      return 'Protege a lombar mantendo a coluna neutra e a carga perto do corpo quando existir carga. Para se aparecer dor aguda, formigueiro, perda de força ou desconforto que aumenta a cada repetição.';
    }
    if (group == 'Cardio') {
      return 'Mantém intensidade adequada ao teu nível. Abranda ou termina $name se houver tontura, dor no peito, falta de ar anormal, dor articular ou perda de coordenação.';
    }
    if (group == 'Mobilidade') {
      return 'Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou sensação de instabilidade.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Treina em piso seguro e aumenta velocidade só depois de controlar $name. Para com dor articular, impacto na cabeça, tontura ou sensação de instabilidade.';
    }
    return 'Usa $equipment de forma controlável e mantém a articulação principal alinhada. Para $name se sentires dor aguda, tontura, formigueiro, perda de equilíbrio ou incapacidade de controlar o retorno.';
  }

  static bool _beginnerUnderstands(ExerciseCatalogDetails details) {
    final text = '${details.description} ${details.executionSteps}';
    final lower = text.toLowerCase();
    return details.description.length > 80 &&
        details.executionSteps.split(RegExp(r'\d+\.')).length >= 6 &&
        (lower.contains('respira') ||
            lower.contains('inspira') ||
            lower.contains('expira')) &&
        details.equipment.trim().isNotEmpty;
  }

  static String _secondaryFallback(String group) {
    if (group == 'Cardio') return 'respiração, coordenação e resistência geral';
    if (group == 'Mobilidade') {
      return 'respiração, controlo articular e postura';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'coordenação, base, core e controlo técnico';
    }
    return 'core, estabilizadores articulares e controlo da carga';
  }

  static String _targetFor(String name, String group) {
    if (group == 'Cardio') {
      return 'resistência cardiovascular, ritmo e tolerância ao esforço';
    }
    if (group == 'Mobilidade') {
      return 'mobilidade, elasticidade e controlo respiratório';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'técnica específica de $group';
    }
    if (_containsAny(name, ['curl'])) return 'braço, cotovelo e antebraço';
    if (_containsAny(name, [
      'supino',
      'flexão',
      'aberturas',
      'chest press',
      'crossover',
      'dips para peito',
    ])) {
      return 'peito e empurrar com ombros estáveis';
    }
    if (_containsAny(name, [
      'remo',
      'puxada',
      'pull-up',
      'pullover',
      'face pull',
    ])) {
      return 'costas, escápulas e puxada controlada';
    }
    if (_containsAny(name, ['agachamento', 'lunges', 'leg press', 'step-up'])) {
      return 'pernas, anca e joelhos';
    }
    if (_containsAny(name, [
      'prancha',
      'crunch',
      'dead bug',
      'hollow',
      'pallof',
      'bird dog',
      'superman',
    ])) {
      return 'core, tronco e estabilidade';
    }
    return group;
  }

  static String _movementCue(String name, String group) {
    if (_containsAny(name, ['curl'])) {
      return 'dobrar e estender o cotovelo sem balançar o tronco';
    }
    if (_containsAny(name, ['supino', 'press', 'flexão', 'dips'])) {
      return 'empurrar a carga ou o corpo mantendo ombros baixos e cotovelos guiados';
    }
    if (_containsAny(name, ['aberturas', 'crossover'])) {
      return 'abrir e fechar os braços em arco sem deixar o ombro avançar com dor';
    }
    if (_containsAny(name, ['remo', 'puxada', 'pull-up', 'face pull'])) {
      return 'puxar levando cotovelos e escápulas na direção indicada pelo exercício';
    }
    if (_containsAny(name, ['agachamento', 'lunges', 'step-up', 'leg press'])) {
      return 'dobrar anca e joelhos mantendo os joelhos alinhados com os pés';
    }
    if (_containsAny(name, [
      'peso morto',
      'good morning',
      'hip thrust',
      'ponte',
    ])) {
      return 'mover a anca com coluna neutra e retorno controlado';
    }
    if (_containsAny(name, ['prancha', 'dead bug', 'hollow', 'pallof'])) {
      return 'resistir ao movimento do tronco enquanto manténs respiração regular';
    }
    if (group == 'Cardio') {
      return 'manter ritmo, intensidade e respiração sem perder coordenação';
    }
    if (group == 'Mobilidade') {
      return 'aumentar alcance com tensão leve e respiração calma';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'repetir o padrão técnico com base estável e controlo';
    }
    return 'mover a articulação principal de forma controlada no contexto $group';
  }

  static String _amplitudeCue(String name, String group) {
    if (_containsAny(name, [
      'alongamento',
      'mobilidade',
      'rotação',
      'inclinação',
    ])) {
      return 'até tensão leve e respirável, nunca até dor';
    }
    if (_containsAny(name, ['supino', 'aberturas', 'dips', 'press'])) {
      return 'até alongamento ou contração confortável no ombro, sem dor na frente da articulação';
    }
    if (_containsAny(name, ['agachamento', 'lunges'])) {
      return 'até onde manténs pés apoiados, joelhos alinhados e coluna neutra';
    }
    if (_containsAny(name, ['curl', 'tríceps', 'triceps'])) {
      return 'até perto de estender e dobrar o cotovelo sem perder punho alinhado';
    }
    if (group == 'Cardio') {
      return 'num ritmo que consigas sustentar pela duração escolhida';
    }
    return 'até onde controlas a ida e o regresso sem dor nem perda de alinhamento';
  }

  static String _gripCue(String equipment) {
    final lower = equipment.toLowerCase();
    if (lower.contains('halter')) {
      return 'Segura os halteres com a mão fechada, punhos alinhados e carga perto da linha do movimento.';
    }
    if (lower.contains('barra') && !lower.contains('barra fixa')) {
      return 'Segura a barra com pega simétrica, punhos alinhados e mãos na largura adequada ao exercício.';
    }
    if (lower.contains('cabo') || lower.contains('polia')) {
      return 'Ajusta a polia, segura a pega com punhos alinhados e cria tensão no cabo antes da primeira repetição.';
    }
    if (lower.contains('máquina') || lower.contains('maquina')) {
      return 'Ajusta banco, encosto ou pegas da máquina para a articulação principal ficar alinhada com o eixo.';
    }
    if (lower.contains('barra fixa')) {
      return 'Segura a barra fixa com mãos firmes e ombros ativos antes de sustentar ou puxar.';
    }
    if (lower.contains('elástico') || lower.contains('elastico')) {
      return 'Prende ou segura o elástico num ponto seguro, com tensão leve e punhos alinhados.';
    }
    return 'Coloca mãos, pés ou apoios numa posição firme e confirma que consegues controlar o corpo antes de começar.';
  }

  static bool _containsAny(String text, List<String> values) {
    final lower = text.toLowerCase();
    return values.any((value) => lower.contains(value.toLowerCase()));
  }
}
