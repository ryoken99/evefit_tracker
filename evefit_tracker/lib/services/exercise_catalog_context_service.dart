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
    return '$name pertence à família $group e serve para treinar $target. '
        'A tarefa é praticar $movement usando $equipment de forma compatível com o teu nível. '
        'Também ajuda $secondary quando controlas a zona alvo, respiras sem prender o ar '
        'e paras antes de dor, tontura ou perda clara de coordenação.';
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
    if (_containsAny(name, ['curl inverso'])) {
      return _curlInversoSteps(name, equipment);
    }
    if (_containsAny(name, ['curl cruzado no corpo'])) {
      return _crossBodyCurlSteps();
    }
    if (_containsAny(name, ['curl'])) return _curlSteps(name, equipment);
    if (_containsAny(name, ['dead hang'])) return _deadHangSteps();
    if (_containsAny(name, ['tríceps', 'triceps', 'extensão francesa'])) {
      return _tricepsSteps(name, equipment);
    }
    if (_containsAny(name, [
      'remo',
      'puxada',
      'pull-up',
      'chin-up',
      'face pull',
    ])) {
      return _rowPullSteps(name, equipment);
    }
    if (_containsAny(name, ['agachamento', 'lunges', 'leg press', 'step-up'])) {
      return _squatSteps(name, equipment);
    }
    if (_containsAny(name, ['peso morto', 'good morning'])) {
      return _hingeSteps(name, equipment);
    }
    final grip = _gripCue(equipment);
    final movement = _movementCue(name, group);
    final amplitude = _amplitudeCue(name, group);
    return '1. Coloca-te numa base estável para $name, com pés firmes e espaço livre à volta. '
        '2. $grip '
        '3. Organiza tronco, peito, costelas e bacia para a coluna e a lombar ficarem neutras, sem encolher os ombros para as orelhas. '
        '4. Inicia o movimento: $movement. '
        '5. Usa esta amplitude: $amplitude. '
        '6. Mantém punhos, cotovelos, joelhos ou anca alinhados com a direção do exercício, conforme a articulação principal. '
        '7. Inspira na fase de preparação ou descida e expira na fase de maior esforço. '
        '8. Regressa devagar ao início, mantendo a carga ou o corpo sob controlo até a repetição terminar. '
        '9. Se fores iniciante, reduz carga, alcance ou inclinação até conseguires repetir sem dor e sem balanço.';
  }

  static String _curlSteps(String name, String equipment) =>
      '1. Fica de pé ou sentado com o tronco alto, pés firmes e abdómen ligeiramente contraído. '
      '2. Segura $equipment com pega adequada ao $name, punhos alinhados e palmas na direção pedida pela variação. '
      '3. Mantém os cotovelos perto do tronco e evita levar os ombros para a frente. '
      '4. Sobe a carga dobrando o cotovelo, sem balançar o tronco nem empurrar a anca. '
      '5. Para perto do topo quando o antebraço se aproxima do braço e sentes contração no braço. '
      '6. Desce devagar até quase estender os cotovelos, mantendo punhos direitos. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Usa menos carga se precisares de mexer costas, ombros ou punhos para completar a repetição.';

  static String _curlInversoSteps(String name, String equipment) =>
      '1. Fica de pé com pés à largura da anca e tronco estável. '
      '2. Segura $equipment com pega pronada, palmas viradas para baixo e punhos alinhados com os antebraços. '
      '3. Mantém os cotovelos junto ao corpo e os ombros baixos. '
      '4. Sobe a carga dobrando o cotovelo sem rodar os punhos nem balançar o tronco. '
      '5. Para quando o antebraço se aproxima do braço sem perder a pega pronada. '
      '6. Desce devagar até quase estender os cotovelos. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Reduz a carga se sentires dor no punho ou se as palmas deixarem de apontar para baixo.';

  static String _crossBodyCurlSteps() =>
      '1. Fica de pé com pés firmes, tronco alto e ombros relaxados. '
      '2. Segura os halteres com pega neutra, palmas viradas uma para a outra e punhos alinhados. '
      '3. Mantém o cotovelo perto do tronco no lado que vai trabalhar. '
      '4. Sobe o halter em diagonal em direção ao peito ou ao ombro oposto, sem rodar o tronco. '
      '5. Para quando o halter chegar perto da parte alta do peito sem levantar o ombro. '
      '6. Desce devagar pelo mesmo caminho diagonal até quase estender o cotovelo. '
      '7. Expira ao subir e inspira ao descer. '
      '8. Alterna lados com controlo e usa carga menor se o punho perder a linha.';

  static String _deadHangSteps() =>
      '1. Fica por baixo da barra fixa e segura-a com pega firme, mãos à largura dos ombros ou ligeiramente mais abertas. '
      '2. Pendura o corpo com braços esticados, sem relaxar totalmente os ombros. '
      '3. Afasta os ombros das orelhas puxando ligeiramente as escápulas para baixo. '
      '4. Mantém tronco e lombar alinhados, pernas quietas e cotovelos sem dobrar. '
      '5. Respira de forma calma enquanto sustentas a posição por poucos segundos no início. '
      '6. Desce colocando os pés no chão ou num apoio antes de largar a barra. '
      '7. Aumenta o tempo apenas se consegues manter escápulas ativas sem dor. '
      '8. Para se houver dor no ombro, formigueiro nos dedos ou perda de pega.';

  static String _tricepsSteps(String name, String equipment) =>
      '1. Coloca-te numa posição estável para $name, com pés firmes e tronco alto. '
      '2. Segura $equipment com pega firme e punhos alinhados. '
      '3. Posiciona os cotovelos perto da linha do corpo ou apontados para a frente quando a carga fica acima da cabeça. '
      '4. Desce a carga dobrando os cotovelos até sentires alongamento tolerável no tríceps. '
      '5. Estende os cotovelos para voltar a subir ou empurrar, sem abrir demasiado os cotovelos. '
      '6. Mantém a lombar neutra e evita arquear as costas para compensar a carga. '
      '7. Expira ao estender o cotovelo e inspira ao descer. '
      '8. Reduz a carga se o ombro, cotovelo ou punho perder alinhamento.';

  static String _rowPullSteps(String name, String equipment) =>
      '1. Ajusta a posição do corpo para $name com tronco firme e lombar neutra. '
      '2. Segura $equipment com pega firme antes de iniciar a puxada. '
      '3. Mantém ombros afastados das orelhas e escápulas prontas para se moverem para trás ou para baixo. '
      '4. Puxa levando os cotovelos na direção indicada pelo exercício, sem encolher o pescoço. '
      '5. Para quando sentires as costas e escápulas ativas sem perder a posição da lombar. '
      '6. Regressa devagar deixando os braços alongar sem perder controlo do tronco. '
      '7. Expira ao puxar e inspira ao voltar. '
      '8. Reduz carga ou inclinação se precisares de balançar o corpo.';

  static String _squatSteps(String name, String equipment) =>
      '1. Fica com pés firmes, normalmente à largura dos ombros, e segura $equipment com pega e posição adequadas apenas se a variação pedir carga. '
      '2. Mantém tronco alto, abdómen ativo e olhar em frente ou ligeiramente para baixo. '
      '3. Inicia levando a anca para trás e dobrando os joelhos. '
      '4. Mantém joelhos alinhados com a direção dos pés sem deixá-los cair para dentro. '
      '5. Desce até onde consegues manter calcanhares apoiados, anca controlada e lombar neutra. '
      '6. Empurra o chão com os pés para subir. '
      '7. Inspira ao descer e expira ao subir. '
      '8. Usa menor alcance se houver dor no joelho, anca ou lombar.';

  static String _hingeSteps(String name, String equipment) =>
      '1. Fica de pé com pés firmes e $equipment perto do corpo quando houver carga. '
      '2. Segura a carga com pega firme quando existir equipamento e mantém coluna e lombar neutras, peito aberto e joelhos ligeiramente fletidos. '
      '3. Inicia dobrando pela anca, levando a bacia para trás sem arredondar as costas. '
      '4. Deixa a carga ou as mãos descerem junto à linha das pernas. '
      '5. Para quando sentires alongamento no posterior de coxa sem perder a coluna neutra. '
      '6. Regressa empurrando o chão e estendendo a anca até ficar alto novamente. '
      '7. Inspira ao descer e expira ao subir. '
      '8. Para se a lombar doer, se houver formigueiro ou se não conseguires controlar a anca.';

  static String _mobilitySteps(String name, String equipment) =>
      '1. Escolhe uma posição confortável e estável para $name, usando $equipment apenas se for indicado. '
      '2. Alinha a coluna de forma neutra e relaxa maxilar, ombros e mãos antes de começar. '
      '3. Move devagar até sentires tensão leve na zona alvo, mantendo a sensação abaixo de dor. '
      '4. Respira devagar durante 15 a 30 segundos ou faz repetições lentas durante 30 a 60 segundos. '
      '5. Mantém o alcance no ponto em que consegues continuar a respirar sem prender o ar. '
      '6. Regressa devagar ou sai da posição lentamente e repete do outro lado quando o exercício for unilateral. '
      '7. Para se aparecer formigueiro, tontura, pressão articular ou dor que aumenta.';

  static String _cardioSteps(String name, String equipment) {
    if (_containsAny(name, ['passadeira'])) {
      final interval = _containsAny(name, ['interval', 'sprints', 'hiit']);
      final incline = _containsAny(name, ['inclinação', 'inclinacao']);
      return '1. Sobe para a passadeira e confirma que tens espaço para caminhar ou correr sem segurar nos apoios. '
          '2. Começa com velocidade baixa durante 3 a 5 minutos para aquecer. '
          '3. Mantém tronco alto, olhar em frente e passada curta o suficiente para aterrar com controlo. '
          '4. Ajusta a intensidade pela velocidade${incline ? ' e pela inclinação' : ''} de acordo com o foco de $name. '
          '5. ${interval ? 'Alterna blocos fortes com duração de 20 a 60 segundos e recuperação leve antes do bloco seguinte.' : 'Mantém uma duração de 5 a 20 minutos num ritmo em que ainda consegues controlar a respiração.'} '
          '6. Expira e inspira de forma contínua, sem prender o ar enquanto aumentas a intensidade. '
          '7. Reduz a velocidade durante 2 a 5 minutos para cooldown antes de sair. '
          '8. Para se houver tontura, dor no peito, dor articular ou falta de ar fora do normal.';
    }
    if (_containsAny(name, ['bicicleta'])) {
      final interval = _containsAny(name, ['interval', 'hiit']);
      return '1. Senta-te na bicicleta e ajusta o selim para o joelho ficar ligeiramente fletido no ponto mais baixo da pedalada. '
          '2. Apoia as mãos sem encolher os ombros e começa a pedalar com resistência leve. '
          '3. Mantém cadência regular e tronco estável enquanto aqueces durante 3 a 5 minutos. '
          '4. Ajusta a resistência para o foco de $name sem bloquear os joelhos. '
          '5. ${interval ? 'Faz blocos de pedalada mais forte de 20 a 60 segundos e recupera com resistência leve.' : 'Mantém duração de 5 a 20 minutos num esforço sustentável.'} '
          '6. Respira de forma contínua e usa a frequência cardíaca ou a respiração para controlar a intensidade. '
          '7. Para cooldown, reduz resistência e cadência durante 2 a 5 minutos. '
          '8. Para se houver tontura, dor no peito, dormência ou dor no joelho.';
    }
    if (_containsAny(name, ['corda'])) {
      return '1. Segura as pegas da corda com cotovelos próximos do corpo e punhos relaxados. '
          '2. Começa com saltos baixos, aterrando na parte da frente dos pés com joelhos suaves. '
          '3. Roda a corda principalmente pelos punhos, sem grandes círculos com os ombros. '
          '4. Mantém intensidade baixa no início, com duração curta como blocos de 20 a 60 segundos. '
          '5. Se o foco for pés alternados, alterna direito e esquerdo como uma corrida leve no lugar. '
          '6. Respira em ritmo regular e reduz a velocidade antes de perder coordenação. '
          '7. Aterra sempre baixo e silencioso para poupar tornozelos, joelhos e anca. '
          '8. Para se houver dor no tendão, tornozelo, joelho, tontura ou perda de controlo da corda.';
    }
    if (_containsAny(name, ['elíptica', 'eliptica'])) {
      final interval = _containsAny(name, ['interval']);
      return '1. Sobe para a elíptica segurando os apoios e coloca os pés centrados nas plataformas. '
          '2. Começa com resistência leve e cadência baixa durante 3 a 5 minutos. '
          '3. Mantém tronco alto, ombros relaxados e empurra/puxa os apoios sem travar os cotovelos. '
          '4. Ajusta a intensidade pela resistência e pela cadência para o foco de $name sem perder fluidez. '
          '5. ${interval ? 'Alterna blocos mais rápidos com duração de 20 a 60 segundos e recuperação leve.' : 'Mantém duração de 5 a 20 minutos num ritmo sustentável.'} '
          '6. Respira de forma contínua e abranda se deixares de conseguir coordenar braços e pernas. '
          '7. Reduz cadência e resistência durante 2 a 5 minutos no fim. '
          '8. Para se houver tontura, dor no peito, dor articular ou falta de ar fora do normal.';
    }
    return '1. Começa $name com intensidade fácil durante 3 a 5 minutos. '
        '2. Mantém tronco alto, olhar em frente e ritmo compatível com a tua coordenação. '
        '3. Usa uma duração de 5 a 20 minutos, ou blocos de 20 a 60 segundos quando for intervalado. '
        '4. Ajusta a intensidade sem perder controlo dos pés, joelhos, anca e respiração. '
        '5. Respira de forma contínua; em esforço moderado deves conseguir dizer frases curtas. '
        '6. Reduz a intensidade durante 2 a 5 minutos no fim antes de parar totalmente. '
        '7. Para se houver tontura, dor no peito, dor articular ou falta de ar fora do normal.';
  }

  static String _martialSteps(String name, String group, String equipment) =>
      '1. Começa em base estável de $group, em $equipment, com joelhos soltos e peso distribuído pelos pés. '
      '2. Mantém a guarda organizada e define o objetivo técnico de $name antes de aumentar velocidade. '
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
      return 'flexionar o cotovelo para aproximar a carga do ombro e baixar sem balançar o tronco';
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
    return 'guiar a articulação alvo com alcance claro e retorno controlado na família $group';
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
