import 'workout_taxonomy.dart';

class ExerciseCatalogDetails {
  const ExerciseCatalogDetails({
    required this.equipment,
    required this.secondaryGroups,
    required this.description,
    required this.executionSteps,
    required this.commonMistakes,
    required this.safetyNotes,
  });

  final String equipment;
  final String secondaryGroups;
  final String description;
  final String executionSteps;
  final String commonMistakes;
  final String safetyNotes;
}

class ExerciseCatalogDetailService {
  const ExerciseCatalogDetailService._();

  static ExerciseCatalogDetails forExercise({
    required String name,
    required String group,
  }) {
    return ExerciseCatalogDetails(
      equipment: equipmentFor(name),
      secondaryGroups: secondaryGroupsFor(name, group),
      description: descriptionFor(name, group),
      executionSteps: stepsFor(name, group),
      commonMistakes: commonMistakesFor(name, group),
      safetyNotes: safetyNotesFor(name, group),
    );
  }

  static String equipmentFor(String name) {
    final n = _n(name);
    if (_has(n, ['flexao classica', 'flexao aberta', 'flexao arqueiro'])) {
      return 'Peso corporal';
    }
    if (_has(n, ['flexao com joelhos apoiados'])) {
      return 'Peso corporal, tapete / colchonete';
    }
    if (_has(n, ['flexao inclinada', 'flexao declinada'])) {
      return 'Peso corporal, banco / cadeira / apoio';
    }
    if (_has(n, ['agachamento com peso corporal', 'agachamento sumo'])) {
      return 'Peso corporal';
    }
    if (_has(n, ['agachamento para cadeira'])) {
      return 'Peso corporal, banco / cadeira / apoio';
    }
    if (_has(n, ['agachamento com mochila', 'lunges com mochila'])) {
      return 'Mochila com peso';
    }
    if (_has(n, ['agachamento com garrafao'])) return 'Garrafão de água';
    if (_has(n, ['remo invertido em mesa resistente'])) {
      return 'Mesa resistente';
    }
    if (_has(n, ['mobilidade de ombro com cabo de vassoura'])) {
      return 'Cabo de vassoura';
    }
    if (_has(n, ['triceps testa com barra ez'])) return 'Barra EZ';
    if (_has(n, ['curl 21 com halteres', 'curl arrastado com halteres'])) {
      return 'Halteres';
    }
    if (_has(n, [
      'extensao acima da cabeca com halter',
      'press fechado com halteres',
      'tate press',
      'suitcase carry',
      'hold estatico com halteres',
      'rotacao controlada com halter leve',
    ])) {
      return _has(n, ['suitcase carry'])
          ? 'Halteres, espaço livre'
          : 'Halteres';
    }
    if (_has(n, ['agachamento com halteres ao lado'])) return 'Halteres';
    if (_has(n, ['aberturas inclinadas com halteres'])) {
      return 'Halteres, banco inclinado';
    }
    if (_has(n, ['aberturas inclinadas no cabo'])) return 'Cabo / polia';
    if (_has(n, ['aberturas inclinadas com elastico'])) return 'Elásticos';
    if (_has(n, ['supino declinado com halteres'])) {
      return 'Halteres, banco declinado';
    }
    if (_has(n, ['supino declinado com barra'])) {
      return 'Barra, banco declinado';
    }
    if (_has(n, ['supino declinado na maquina'])) return 'Máquina';
    if (_has(n, ['dips para peito em paralelas'])) return 'Paralelas';
    if (_has(n, ['dips assistidos para peito na maquina'])) {
      return 'Máquina assistida de dips';
    }
    if (_has(n, ['extensao francesa com halter'])) return 'Halteres';
    if (_has(n, ['extensao francesa com barra ez'])) return 'Barra EZ';
    if (_has(n, ['extensao francesa no cabo'])) return 'Cabo / polia';
    if (_has(n, ['fundos entre apoios'])) return 'Banco / cadeira / apoio';
    if (_has(n, ['face pull no cabo'])) return 'Cabo alto / polia';
    if (_has(n, ['face pull com elastico'])) return 'Elásticos';
    if (_has(n, ['dips para triceps'])) return 'Paralelas';
    if (_has(n, ['hiperextensao lombar'])) return 'Banco romano / máquina';
    if (_has(n, [
      'agachamento bulgaro',
      'step-up',
      'gemeos sentado',
      'soleo sentado',
    ])) {
      return 'Banco / cadeira / apoio';
    }
    if (_has(n, ['passadeira'])) return 'Passadeira';
    if (_has(n, ['bicicleta'])) return 'Bicicleta';
    if (_has(n, ['eliptica'])) return 'Elíptica';
    if (_has(n, ['corda de saltar', 'hiit corda'])) return 'Corda de saltar';
    if (_has(n, [
      'caminhada exterior',
      'corrida exterior',
      'sprints exterior',
    ])) {
      return 'Espaço exterior';
    }
    if (_has(n, [
      'cabo',
      'crossover',
      'puxada',
      'remo baixo',
      'curl no cabo',
    ])) {
      return 'Cabo / polia';
    }
    if (_has(n, [
      'maquina',
      'chest press',
      'leg press',
      'extensao de perna',
      'curl de perna',
      'aducao de anca',
      'abducao de anca',
      'remo sentado',
    ])) {
      return 'Máquina';
    }
    if (_has(n, [
      'halter',
      'goblet',
      'arnold',
      'elevacao lateral',
      'elevacao frontal',
      'elevacao posterior',
      'reverse fly',
      'y raise',
      'w raise',
      'remo alto leve',
      'curl alternado',
      'curl martelo',
      'curl concentrado',
      'curl inclinado',
      'curl zottman',
      'curl cruzado no corpo',
      'curl spider',
      'curl 21',
      'curl isometrico',
      'squeeze press',
      'kickback de triceps',
      'extensao unilateral',
      'extensao de triceps acima da cabeca',
      'aperto isometrico',
      'wrist curl',
      'reverse wrist',
      'pronacao',
      'supinacao',
      'desvio radial',
      'desvio ulnar',
      'finger curls',
      'farmer walk',
      'farmer hold',
      'remada unilateral',
      'remo unilateral',
    ])) {
      return 'Halteres';
    }
    if (_has(n, ['curl inverso'])) return 'Halteres';
    if (_has(n, [
      'barra ez',
      'com barra',
      'curl com barra',
      'supino inclinado',
      'supino fechado',
      'triceps testa',
      'peso morto tradicional',
      'peso morto romeno',
      'good morning leve',
      'press militar',
    ])) {
      return 'Barra';
    }
    if (_has(n, ['plate hold', 'pinch grip'])) return 'Discos';
    if (_has(n, [
      'chin-up',
      'pull-up',
      'dead hang',
      'elevacao de joelhos suspenso',
      'remo invertido',
      'towel grip',
      'scapular pull-up',
    ])) {
      return n.contains('towel') ? 'Barra fixa, toalha' : 'Barra fixa';
    }
    if (_has(n, [
      'elastico',
      'pull-apart',
      'rotacao externa',
      'rotacao interna',
      'triceps com elastico',
      'curl com elastico',
      'pallof press com elastico',
      'extensao de dedos com elastico',
    ])) {
      return 'Elásticos';
    }
    if (_has(n, ['pallof press'])) return 'Cabo / polia ou elásticos';
    if (_has(n, [
      'jiu-jitsu',
      'grappling',
      'shrimp',
      'technical stand-up',
      'passagem de guarda',
      'drills de guarda',
    ])) {
      return 'Tatami / espaço de artes marciais';
    }
    return 'Peso corporal';
  }

  static String secondaryGroupsFor(String name, String group) {
    final n = _n(name);
    if (group == 'Mobilidade') {
      if (_has(n, ['cervical', 'pescoco', 'chin tuck'])) {
        return 'Trapézio superior, estabilizadores cervicais e controlo da respiração';
      }
      if (_has(n, ['gluteo', 'piriforme', 'pigeon', 'figura 4', '90/90'])) {
        return 'Anca, piriforme, rotadores externos da anca e lombar como estabilizador';
      }
      if (_has(n, ['posterior'])) {
        return 'Anca, gémeos, sóleo e mobilidade da cadeia posterior';
      }
      if (_has(n, ['ombro'])) return 'Escápulas, peitoral e coluna torácica';
      if (_has(n, ['peitoral'])) return 'Ombros, escápulas e respiração';
      if (_has(n, ['dorsal'])) return 'Costas, ombros e respiração';
      if (_has(n, ['toracica', 'cat-cow', 'open book'])) {
        return 'Costas, escápulas, lombar leve e respiração';
      }
      if (_has(n, ['anca'])) return 'Glúteos, flexores da anca e core';
      if (_has(n, ['gemeos'])) return 'Tornozelo, sóleo e planta do pé';
      if (_has(n, ['tornozelo'])) return 'Gémeos, sóleo, pé e equilíbrio';
      if (_has(n, ['punho'])) return 'Antebraço, dedos e cotovelo';
      if (_has(n, ['respiracao', 'relaxamento'])) {
        return 'Diafragma, relaxamento muscular e controlo do ritmo respiratório';
      }
      return 'Respiração, controlo articular e consciência corporal';
    }
    if (group == 'Cardio') {
      return 'Core, pernas, coordenação e sistema cardiovascular';
    }
    if (group == 'Karate') return 'Core, ancas, ombros, coordenação e base';
    if (group == 'Jiu-Jitsu') {
      return 'Core, ancas, pega, pescoço e controlo no solo';
    }
    if (_has(n, [
      'supino',
      'flex',
      'dips para peito',
      'aberturas',
      'chest press',
    ])) {
      return 'Tríceps, deltoide anterior, serrátil anterior e estabilizadores da escápula';
    }
    if (_has(n, ['remo', 'puxada', 'pull-up', 'chin-up'])) {
      return 'Bíceps, braquial, antebraço, trapézio e romboides';
    }
    if (_has(n, ['curl'])) return 'Braquial, braquiorradial, antebraço e punho';
    if (_has(n, ['triceps', 'tricep', 'extensao francesa', 'fundos'])) {
      return 'Ombros, peito como apoio e estabilizadores do cotovelo';
    }
    if (_has(n, ['agachamento', 'lunges', 'step-up', 'wall sit'])) {
      return 'Glúteos, posterior de coxa, adutores e core';
    }
    if (_has(n, ['peso morto', 'good morning', 'curl de perna'])) {
      return 'Glúteos, lombar, posterior de coxa e pega';
    }
    if (_has(n, ['hip thrust', 'ponte', 'kickback de gluteo'])) {
      return 'Posterior de coxa, lombar leve, core e adutores';
    }
    if (_has(n, ['gemeos', 'soleo', 'tibial'])) {
      return 'Tornozelo, pé e equilíbrio';
    }
    if (_has(n, ['prancha', 'crunch', 'dead bug', 'hollow', 'pallof'])) {
      return 'Oblíquos, transverso abdominal, lombar e respiração';
    }
    if (_has(n, [
      'ombro',
      'press militar',
      'elevacao',
      'face pull',
      'reverse fly',
    ])) {
      return 'Trapézio, serrátil anterior, manguito rotador e core';
    }
    if (_has(n, ['pescoco', 'cervical'])) {
      return 'Trapézio superior, escalenos e estabilizadores cervicais';
    }
    return 'Estabilizadores locais, core e articulações próximas ao movimento';
  }

  static String descriptionFor(String name, String group) {
    final n = _n(name);
    if (_has(n, ['flexao classica'])) {
      return '$name é um exercício de peso corporal em que ficas em prancha alta, dobras os braços para aproximar o peito do chão e empurras o corpo de volta para cima. Serve para treinar peito, tríceps, ombros e controlo do tronco sem equipamento.';
    }
    if (_has(n, ['agachamento com peso corporal'])) {
      return '$name é um exercício de pernas em que dobras a anca e os joelhos para baixar o corpo como se fosses sentar, voltando depois a ficar de pé. Serve para treinar quadríceps, glúteos e controlo da anca sem carga externa.';
    }
    if (_has(n, [
      'agachamento com mochila',
      'agachamento com garrafao',
      'lunges com mochila',
    ])) {
      return '$name é uma variação caseira de treino de pernas. Usa uma carga improvisada de forma controlada, mantendo o objeto estável e junto ao corpo para treinar pernas sem transformar o movimento num risco de queda ou escorregamento.';
    }
    if (_has(n, ['remo invertido em mesa resistente'])) {
      return '$name é uma remada de peso corporal feita apenas com uma mesa muito firme. O corpo fica inclinado debaixo da mesa e puxas o peito na direção da borda, treinando costas e pega com atenção máxima à estabilidade do apoio.';
    }
    if (_has(n, ['mobilidade de ombro com cabo de vassoura'])) {
      return '$name usa um bastão leve e estável para explorar mobilidade de ombro sem carga. O objetivo é mover os braços com alcance suave, respiração calma e controlo, sem forçar a articulação.';
    }
    if (_has(n, ['alongamento cervical leve'])) {
      return '$name é um alongamento suave para reduzir tensão no pescoço e melhorar mobilidade cervical. O movimento inclina a cabeça com cuidado para criar uma tensão leve, nunca dor.';
    }
    if (_has(n, ['curl com halteres'])) {
      return '$name é uma flexão do cotovelo feita com halteres para treinar principalmente o bíceps. Serve para aprender a subir a carga sem balançar o tronco e sem dobrar os punhos.';
    }
    if (_has(n, ['dips para peito em paralelas'])) {
      return '$name é um exercício de empurrar em que o corpo desce e sobe entre duas barras paralelas. A inclinação ligeira do tronco aumenta o foco no peito.';
    }
    if (_has(n, ['dips assistidos para peito na maquina'])) {
      return '$name é a variação guiada dos dips para peito. A máquina reduz parte do peso corporal para permitir aprender a descida e a subida com mais controlo.';
    }
    if (_has(n, ['aberturas inclinadas'])) {
      return '$name é uma abertura para peito superior. Os braços afastam e aproximam a carga em arco, com o banco ou vetor inclinado a direcionar o esforço para a parte alta do peitoral.';
    }
    if (_has(n, ['supino declinado'])) {
      return '$name é uma variação de supino para o peito médio e inferior. O tronco fica em declive para mudar a linha de empurrar sem transformar o exercício em peso corporal.';
    }
    if (_has(n, ['extensao francesa'])) {
      return '$name é uma extensão de cotovelo para tríceps, com a carga a descer atrás da cabeça ou numa linha semelhante. O foco é estender o cotovelo sem arquear a lombar.';
    }
    if (_has(n, ['supino com barra'])) {
      return '$name é um exercício de empurrar no banco plano para treinar o peito com uma barra. A barra desce até à zona média ou ligeiramente baixa do peito e sobe numa linha controlada, com omoplatas firmes e pés estáveis no chão.';
    }
    if (_has(n, ['passadeira aquecimento'])) {
      return '$name é uma entrada progressiva no treino cardiovascular. Serve para preparar articulações, respiração, ritmo cardíaco e temperatura corporal antes de caminhar mais rápido, correr ou fazer intervalos.';
    }
    if (_has(n, ['passadeira cooldown'])) {
      return '$name é a redução gradual da intensidade no fim do treino. Serve para evitar parar de repente, deixar a respiração acalmar e sair da passadeira com equilíbrio e sensação de estabilidade.';
    }
    if (_has(n, ['puxada alta pega neutra'])) {
      return '$name é uma puxada vertical na máquina ou polia alta com as palmas viradas uma para a outra. O objetivo é puxar a pega até à parte alta do peito usando dorsais e escápulas, sem levar a barra atrás da nuca.';
    }
    if (group == 'Mobilidade') {
      return '$name é um exercício de mobilidade ou alongamento para a zona indicada pelo nome. Ajuda a ganhar alcance que consegues respirar sem dor, reduzir rigidez e melhorar controlo respiratório sem carga externa.';
    }
    if (group == 'Cardio') {
      return '$name é uma opção cardiovascular para trabalhar resistência, ritmo ou intervalos. A intensidade deve permitir manter técnica, respiração regular e perceção clara de fadiga.';
    }
    if (group == 'Karate') {
      return '$name é um drill de Karate para praticar técnica, base, deslocamento ou condicionamento específico. Pode ser feito individualmente com foco em precisão antes de velocidade.';
    }
    if (group == 'Jiu-Jitsu') {
      return '$name é um drill de Jiu-Jitsu para melhorar mobilidade no solo, base, guarda, pega ou core. O objetivo é repetir o padrão com controlo antes de aumentar ritmo.';
    }
    if (_has(n, ['pescoco', 'cervical', 'chin tuck', 'inclinacao lateral'])) {
      return '$name treina controlo cervical leve. O objetivo é mover ou resistir com pouca força, sentir o pescoço a trabalhar sem dor e aprender a manter ombros relaxados durante o esforço.';
    }
    if (_has(n, ['encolhimento de ombros'])) {
      return '$name treina principalmente o trapézio superior. O movimento eleva os ombros na direção das orelhas e desce de forma controlada, sem rodar a cabeça nem balançar o tronco.';
    }
    if (_has(n, ['curl'])) {
      return '$name treina flexão do cotovelo e músculos do braço. A variação indicada pelo nome define o equipamento e muda a ênfase entre bíceps, braquial, braquiorradial e antebraço.';
    }
    if (_has(n, [
      'supino',
      'chest press',
      'flex',
      'aberturas',
      'squeeze press',
      'crossover',
    ])) {
      return '$name é um exercício de empurrar para peito. Ensina a aproximar ou empurrar a carga mantendo ombros estáveis, cotovelos guiados e esforço principal no peitoral.';
    }
    if (_has(n, [
      'remo',
      'puxada',
      'pull-up',
      'chin-up',
      'pullover',
      'dead hang escapular',
    ])) {
      return '$name é um exercício de puxar para costas. O movimento aproxima a carga ou o corpo usando dorsais e escápulas, com braços a ajudar sem dominar a repetição.';
    }
    if (_has(n, [
      'press militar',
      'arnold',
      'elevacao',
      'face pull',
      'reverse fly',
      'rotacao',
      'pull-apart',
      'wall slides',
      'y raise',
      'w raise',
      'scapular push-up',
      'pike push-up',
      'mobilidade de ombro',
    ])) {
      return '$name trabalha ombros ou estabilidade escapular. O objetivo é mover a carga com escápulas organizadas, pescoço relaxado e controlo do braço inteiro.';
    }
    if (_has(n, ['triceps', 'tríceps', 'fundos', 'supino fechado'])) {
      return '$name treina extensão do cotovelo e força de tríceps. A variação indicada pelo nome muda o apoio, a linha da carga e a exigência no ombro.';
    }
    if (_has(n, [
      'agachamento',
      'lunges',
      'step-up',
      'wall sit',
      'leg press',
      'extensao de perna',
    ])) {
      return '$name treina pernas no padrão de agachar, avançar ou empurrar. O foco é coordenar pés, joelhos e anca para usar quadríceps e glúteos com segurança.';
    }
    if (_has(n, [
      'peso morto',
      'good morning',
      'curl de perna',
      'hiperextensao',
    ])) {
      return '$name treina posterior de coxa e dobradiça da anca. A lombar deve ficar protegida enquanto a anca faz a maior parte do movimento.';
    }
    if (_has(n, ['ponte', 'hip thrust', 'kickback', 'abducao', 'aducao'])) {
      return '$name treina glúteos ou músculos da anca. Serve para aprender a mover a anca com controlo, sentir o esforço na zona alvo e evitar compensar com lombar, joelhos ou impulso.';
    }
    if (_has(n, [
      'prancha',
      'crunch',
      'dead bug',
      'hollow',
      'pallof',
      'bird dog',
      'mountain climbers',
      'russian twist',
      'side bend',
      'vacuum',
      'flutter',
      'toe touches',
      'superman',
    ])) {
      return '$name treina o core para controlar tronco, pélvis e respiração. O foco é criar tensão útil sem prender o ar nem sobrecarregar a lombar.';
    }
    if (_has(n, ['gemeos', 'soleo', 'tibial', 'saltos leves'])) {
      return '$name treina a perna inferior, tornozelo ou pé. Ajuda a controlar subida, descida e estabilidade ao caminhar, correr ou saltar.';
    }
    if (_has(n, [
      'farmer walk',
      'dead hang',
      'aperto isometrico',
      'pronacao',
      'supinacao',
      'pinch grip',
      'plate hold',
      'towel grip',
      'extensao de dedos',
      'desvio radial',
      'desvio ulnar',
      'finger curls',
    ])) {
      return '$name treina antebraço, punho ou força de pega. O foco é controlar a mão e o punho enquanto a carga tenta abrir a pega, rodar o antebraço ou desviar o alinhamento.';
    }
    return '$name trabalha o padrão principal de $group com foco na zona descrita pelo nome. A execução deve explicar a posição inicial, a trajetória do corpo ou da carga, a respiração e o ponto em que deves parar por perda de controlo ou dor.';
  }

  static String stepsFor(String name, String group) {
    final n = _n(name);
    if (_has(n, ['flexao classica'])) {
      return '1. Coloca-te no chão em posição de prancha alta. 2. Apoia as mãos ligeiramente mais largas que os ombros, com dedos apontados para a frente ou ligeiramente para fora. 3. Estica as pernas para trás e apoia a ponta dos pés no chão. 4. Mantém o corpo em linha reta da cabeça aos calcanhares. 5. Contrai ligeiramente abdómen e glúteos para não deixar a anca cair. 6. Olha para o chão um pouco à frente das mãos, sem levantar demasiado a cabeça. 7. Desce devagar dobrando os cotovelos numa diagonal natural, cerca de 30 a 60 graus do tronco. 8. Aproxima o peito do chão até uma distância que controles sem dor. 9. Empurra o chão com as mãos e sobe até quase estender os braços. 10. Inspira ao descer e expira ao subir. 11. Se for difícil, faz com joelhos apoiados ou com as mãos numa superfície elevada.';
    }
    if (_has(n, ['agachamento com peso corporal'])) {
      return '1. Fica de pé com os pés à largura dos ombros ou ligeiramente mais afastados. 2. Aponta os dedos dos pés um pouco para fora se isso deixar a anca mais confortável. 3. Mantém peito aberto, ombros relaxados e olhar em frente. 4. Contrai ligeiramente o abdómen. 5. Inicia o movimento levando a anca para trás e dobrando os joelhos. 6. Desce como se fosses sentar numa cadeira. 7. Mantém os joelhos alinhados com a direção dos pés, sem deixar cair para dentro. 8. Desce até as coxas ficarem perto de paralelas ao chão, ou até onde conseguires sem perder calcanhares no chão. 9. Empurra o chão com os pés e sobe até ficares de pé. 10. Inspira ao descer e expira ao subir. 11. Usa uma cadeira atrás de ti como referência se fores iniciante.';
    }
    if (_has(n, [
      'agachamento com mochila',
      'agachamento com garrafao',
      'lunges com mochila',
    ])) {
      return '1. Confirma que a mochila, garrafão ou carga caseira está fechada, estável e não escorregadia. 2. Segura a carga junto ao tronco ou coloca a mochila bem ajustada às costas. 3. Mantém os pés firmes no chão e cria espaço livre à volta. 4. Dobra anca e joelhos devagar, mantendo a carga sem balançar. 5. Desce só até onde controlas joelhos, anca e coluna. 6. Sobe empurrando o chão, sem deixar o objeto puxar o tronco para a frente. 7. Inspira ao descer e expira ao subir. 8. Para se a carga se mover dentro da mochila, se o garrafão escorregar ou se sentires dor aguda.';
    }
    if (_has(n, ['remo invertido em mesa resistente'])) {
      return '1. Usa apenas uma mesa pesada, estável e que não deslize; não uses mesa leve ou dobrável. 2. Deita-te por baixo da borda e segura a mesa com as mãos à largura dos ombros. 3. Estica as pernas ou dobra os joelhos para facilitar. 4. Mantém corpo em linha reta e ombros afastados das orelhas. 5. Puxa o peito na direção da borda da mesa, juntando ligeiramente as escápulas. 6. Desce devagar até quase estender os braços. 7. Inspira ao descer e expira ao puxar. 8. Para se a mesa mexer, ranger, escorregar ou se a pega não parecer segura.';
    }
    if (_has(n, ['mobilidade de ombro com cabo de vassoura'])) {
      return '1. Segura o cabo de vassoura com as duas mãos, bem mais largo que os ombros. 2. Fica de pé com pés firmes e estáveis, costelas baixas e pescoço relaxado. 3. Leva o bastão devagar à frente e acima da cabeça até sentires alongamento leve nos ombros ou peitoral. 4. Não forces para passar atrás do corpo se houver dor ou bloqueio. 5. Respira devagar durante 15 a 30 segundos ou faz repetições lentas. 6. Regressa pelo mesmo caminho com controlo. 7. Alarga a pega para facilitar e encurta apenas se o movimento ficar confortável.';
    }
    if (_has(n, ['alongamento cervical leve'])) {
      return '1. Senta-te ou fica de pé com a coluna direita e os ombros relaxados. 2. Olha em frente e mantém o queixo nivelado. 3. Inclina a cabeça devagar para o lado, levando a orelha na direção do ombro sem puxar com força. 4. Para quando sentires tensão leve no lado do pescoço e respira lentamente durante 15 a 30 segundos. 5. Regressa ao centro com cuidado e repete para o outro lado. 6. Mantém o tronco quieto e termina se surgir tontura, formigueiro, dor irradiada ou pressão na cabeça.';
    }
    if (_has(n, ['curl com halteres'])) {
      return '1. Fica de pé com os pés à largura da anca. 2. Segura os halteres ao lado do corpo com as palmas viradas para a frente e punhos neutros. 3. Mantém os cotovelos próximos do tronco e o abdómen ligeiramente ativo. 4. Sobe os halteres dobrando os cotovelos sem balançar o tronco. 5. Para perto do topo, contrai o bíceps e não deixes os cotovelos avançarem. 6. Desce devagar até quase estender os braços. 7. Inspira ao descer e expira ao subir.';
    }
    if (_has(n, ['extensao francesa com halter'])) {
      return '1. Senta-te ou fica de pé com os pés firmes. 2. Segura um halter com as duas mãos por uma das cabeças, acima da cabeça, mantendo punhos alinhados. 3. Mantém os cotovelos apontados para a frente e relativamente próximos. 4. Desce o halter atrás da cabeça até sentires alongamento no tríceps, sem perder controlo. 5. Estende os cotovelos para subir a carga sem arquear a lombar. 6. Inspira ao descer e expira ao subir. 7. Usa alcance menor se o ombro ou cotovelo incomodar.';
    }
    if (_has(n, ['dips para peito em paralelas'])) {
      return '1. Sobe para as paralelas com uma mão em cada pega. 2. Estica os braços sem bloquear os cotovelos com força. 3. Mantém os ombros afastados das orelhas e o tronco ligeiramente inclinado para a frente. 4. Dobra os joelhos ou cruza os pés atrás do corpo se for confortável. 5. Desce devagar dobrando os cotovelos até sentires alongamento no peito sem dor no ombro. 6. Empurra as barras para baixo e sobe até quase estender os braços. 7. Inspira ao descer e expira ao subir.';
    }
    if (_has(n, ['dips assistidos para peito na maquina'])) {
      return '1. Ajusta a assistência para conseguires controlar a repetição. 2. Apoia joelhos ou pés na plataforma da máquina e segura as pegas. 3. Inclina ligeiramente o tronco para a frente e baixa os ombros. 4. Desce dobrando os cotovelos até alongamento confortável no peito. 5. Sobe empurrando as pegas sem encolher os ombros. 6. Inspira ao descer e expira ao subir. 7. Reduz a assistência apenas quando o movimento ficar estável.';
    }
    if (_has(n, ['aberturas inclinadas com halteres'])) {
      return '1. Deita-te num banco inclinado entre 20 e 45 graus com um halter em cada mão. 2. Segura os halteres acima do peito superior, palmas viradas uma para a outra e punhos neutros. 3. Mantém cotovelos ligeiramente dobrados durante toda a repetição. 4. Abre os braços em arco até sentires alongamento confortável no peito. 5. Fecha o arco aproximando os halteres sem bater um no outro. 6. Inspira ao abrir e expira ao fechar. 7. Usa carga leve para proteger ombros e cotovelos.';
    }
    if (_has(n, ['aberturas inclinadas no cabo'])) {
      return '1. Coloca as polias baixas ou médias e posiciona um banco inclinado entre elas. 2. Segura uma pega em cada mão com punhos alinhados. 3. Começa com os braços abertos e cotovelos ligeiramente dobrados. 4. Fecha os braços em arco na direção do peito superior. 5. Abre novamente até tensão confortável, sem deixar os cabos puxarem os ombros. 6. Inspira ao abrir e expira ao fechar. 7. Escolhe carga baixa para controlar o retorno.';
    }
    if (_has(n, ['aberturas inclinadas com elastico'])) {
      return '1. Prende o elástico atrás de ti numa altura baixa ou média e senta-te ou fica de pé com tronco ligeiramente inclinado. 2. Segura as pontas com punhos neutros. 3. Mantém cotovelos levemente dobrados e ombros baixos. 4. Fecha os braços em arco para a frente e para cima, focando o peito superior. 5. Reabre devagar até sentir tensão leve. 6. Inspira ao abrir e expira ao fechar. 7. Afasta-te menos do ponto de fixação se a tensão estiver excessiva.';
    }
    if (_has(n, ['supino declinado com halteres'])) {
      return '1. Deita-te no banco declinado com pés presos ou bem apoiados. 2. Segura um halter em cada mão junto ao peito, punhos neutros e cotovelos abaixo da linha dos ombros. 3. Empurra os halteres para cima na direção do peito inferior. 4. Para antes de bater os halteres. 5. Desce até alongamento confortável sem abrir demasiado os cotovelos. 6. Inspira ao descer e expira ao subir. 7. Senta-te com cuidado antes de pousar os halteres.';
    }
    if (_has(n, ['supino declinado com barra'])) {
      return '1. Deita-te no banco declinado com os pés presos e olhos abaixo da barra. 2. Segura a barra com pega um pouco mais larga que os ombros. 3. Retira a barra com ajuda se necessário e mantém punhos alinhados. 4. Desce a barra para a zona baixa do peito com cotovelos guiados. 5. Empurra a barra para cima sem perder apoio das costas no banco. 6. Inspira ao descer e expira ao subir. 7. Usa carga leve até dominares a saída e o retorno ao suporte.';
    }
    if (_has(n, ['supino declinado na maquina'])) {
      return '1. Ajusta o assento para as pegas ficarem na linha baixa do peito. 2. Encosta as costas no apoio e segura as pegas com punhos alinhados. 3. Escolhe uma carga que consigas mover sem tirar os ombros do apoio. 4. Empurra as pegas até quase estender os cotovelos. 5. Regressa devagar até sentir alongamento confortável no peito. 6. Inspira no retorno e expira ao empurrar. 7. Mantém a cabeça apoiada e evita levantar a anca.';
    }
    if (_has(n, ['supino com barra'])) {
      return '1. Deita-te no banco com os olhos aproximadamente debaixo da barra e os pés no chão. 2. Junta ligeiramente as omoplatas, abre o peito e mantém glúteos no banco. 3. Segura a barra com pega um pouco mais larga que os ombros e punhos alinhados por cima dos cotovelos. 4. Tira a barra do suporte com controlo, usando ajuda se a carga for pesada. 5. Desce a barra até à zona média ou ligeiramente baixa do peito, sem abrir totalmente os cotovelos para os lados. 6. Empurra a barra para cima até quase estender os braços, mantendo a trajetória sobre o peito. 7. Inspira antes e durante a descida, expira ao empurrar e volta ao suporte só quando a barra estiver estável.';
    }
    if (_has(n, ['passadeira aquecimento'])) {
      return '1. Começa devagar, numa caminhada fácil em que consegues falar sem esforço. 2. Mantém a intensidade baixa, tronco alto, olhar em frente e mãos livres se te sentires estável. 3. Durante 5 a 10 minutos, aumenta gradualmente a velocidade ou a inclinação leve. 4. Usa este tempo para aquecer tornozelos, joelhos, ancas, respiração e temperatura corporal. 5. Não comeces intenso nem entres logo em corrida ou sprints. 6. Termina o aquecimento quando a respiração estiver mais ativa, mas ainda controlada.';
    }
    if (_has(n, ['passadeira cooldown'])) {
      return '1. No fim da parte principal, reduz a velocidade em vez de parar de repente. 2. Caminha a ritmo fácil durante 3 a 8 minutos. 3. Mantém as passadas curtas e o tronco alto enquanto a respiração acalmar. 4. Se usaste inclinação, baixa a inclinação primeiro e depois reduz a velocidade. 5. Só sai da passadeira quando te sentires estável e sem tontura. 6. Usa os apoios laterais apenas para equilíbrio ao abrandar ou sair.';
    }
    if (_has(n, ['puxada alta pega neutra'])) {
      return '1. Senta-te na máquina de puxada alta e ajusta o apoio das coxas para as pernas ficarem firmes. 2. Agarra a pega neutra com as palmas viradas uma para a outra. 3. Mantém peito ligeiramente aberto, tronco alto e ombros afastados das orelhas. 4. Puxa a pega para baixo até à parte alta do peito, levando os cotovelos para baixo e ligeiramente para trás. 5. Não puxes atrás da nuca e não balances o tronco para iniciar o movimento. 6. Controla a subida até os braços quase estenderem sem deixar os ombros subir para as orelhas. 7. Inspira durante a subida e expira ao puxar.';
    }
    if (group == 'Mobilidade') return _mobilitySteps(name);
    if (group == 'Cardio') return _cardioSteps(name);
    if (group == 'Karate') return _martialSteps(name, 'Karate');
    if (group == 'Jiu-Jitsu') return _martialSteps(name, 'Jiu-Jitsu');
    final equipment = _n(equipmentFor(name));
    if (equipment.contains('halter')) return _dumbbellSteps(name);
    if (equipment.contains('barra') && !equipment.contains('barra fixa')) {
      return _barbellSteps(name);
    }
    if (equipment.contains('cabo') || equipment.contains('polia')) {
      return _cableSteps(name);
    }
    if (equipment.contains('maquina')) return _machineSteps(name);
    if (equipment.contains('barra fixa')) return _pullupBarSteps(name);
    if (equipment.contains('elastico')) return _bandSteps(name);
    return _bodyweightSteps(name);
  }

  static String commonMistakesFor(String name, String group) {
    final n = _n(name);
    if (_has(n, ['flexao classica'])) {
      return 'Deixar a anca cair, levantar demasiado a anca, abrir os cotovelos a noventa graus, descer só a cabeça, fazer repetições rápidas demais, prender a respiração ou perder a linha entre cabeça, tronco e pernas.';
    }
    if (_has(n, ['agachamento com peso corporal'])) {
      return 'Deixar joelhos cair para dentro, levantar calcanhares, arredondar a lombar, descer sem usar a anca, olhar para baixo o tempo todo ou subir sem terminar a extensão da anca.';
    }
    if (_has(n, [
      'agachamento com mochila',
      'agachamento com garrafao',
      'lunges com mochila',
    ])) {
      return 'Usar mochila solta, garrafão escorregadio, carga que balança, pés sem espaço, joelhos a cair para dentro, tronco a inclinar por causa da carga ou continuar quando o objeto deixa de estar estável.';
    }
    if (_has(n, ['remo invertido em mesa resistente'])) {
      return 'Usar mesa leve, dobrável ou escorregadia, puxar com balanço, encolher os ombros, dobrar a anca, largar a pega de repente ou continuar se a mesa mexer.';
    }
    if (_has(n, ['mobilidade de ombro com cabo de vassoura'])) {
      return 'Usar pega demasiado estreita, arquear a lombar, forçar dor no ombro, levantar os ombros para as orelhas, prender a respiração ou mover o bastão depressa.';
    }
    if (_has(n, ['supino com barra'])) {
      return 'Deitar demasiado longe do suporte, deixar os punhos dobrados para trás, abrir os cotovelos a noventa graus, bater a barra no peito, tirar os pés do chão ou tentar guardar a barra sem a alinhar no suporte.';
    }
    if (_has(n, ['passadeira aquecimento'])) {
      return 'Começar a correr sem preparação, aumentar velocidade cedo demais, agarrar os apoios durante todo o tempo, usar inclinação alta logo no início ou terminar ainda com respiração completamente fria.';
    }
    if (_has(n, ['passadeira cooldown'])) {
      return 'Parar a passadeira de repente, saltar para fora ainda ofegante, manter inclinação alta no fim, agarrar os apoios e arrastar os pés ou sair antes de recuperar equilíbrio.';
    }
    if (_has(n, ['puxada alta pega neutra'])) {
      return 'Puxar atrás da nuca, encolher ombros, balançar o tronco para ganhar impulso, deixar o apoio das coxas solto, puxar só com braços ou largar a subida sem controlo.';
    }
    if (group == 'Mobilidade') {
      return 'Forçar dor em vez de tensão leve, prender a respiração, fazer balanços rápidos, perder o apoio da coluna ou tentar aumentar alcance à custa da articulação.';
    }
    if (group == 'Cardio') {
      return 'Começar rápido demais, ignorar aquecimento, perder ritmo respiratório, continuar apesar de tontura ou transformar uma sessão leve em esforço máximo sem planeamento.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Acelerar antes de entender a técnica, torcer joelhos ou ombros sem controlo, prender a respiração, bater no chão com impacto e repetir cansado com má coordenação.';
    }
    if (_has(n, ['curl'])) {
      return 'Balançar o tronco, afastar os cotovelos, dobrar os punhos, subir só metade do caminho, deixar a carga cair e escolher peso que tira o foco do braço.';
    }
    if (_has(n, ['supino', 'aberturas', 'dips', 'flex'])) {
      return 'Encolher ombros, abrir cotovelos em excesso, descer para além do conforto do ombro, perder tensão no tronco e usar uma carga que obriga a encurtar o movimento.';
    }
    if (_has(n, ['agachamento', 'lunges', 'peso morto', 'good morning'])) {
      return 'Arredondar a lombar, deixar joelhos colapsarem, tirar calcanhares do apoio, usar carga acima do controlo e apressar a descida.';
    }
    final equipment = _n(equipmentFor(name));
    if (equipment.contains('halter')) {
      return 'Escolher halteres pesados demais para $name, dobrar os punhos, deixar a carga fugir da linha do movimento, compensar com tronco e perder controlo na descida.';
    }
    if (equipment.contains('barra') && !equipment.contains('barra fixa')) {
      return 'Colocar a pega da barra fora da largura adequada para $name, deixar punhos ou lombar perderem alinhamento, acelerar a descida e aumentar carga antes de dominar a trajetória.';
    }
    if (equipment.contains('cabo') || equipment.contains('polia')) {
      return 'Ficar demasiado longe ou perto da polia, usar balanço do tronco, deixar o cabo puxar a articulação no retorno e escolher carga que impede uma pausa controlada.';
    }
    if (equipment.contains('maquina')) {
      return 'Não ajustar banco ou eixo da máquina, iniciar com carga alta, bater os pesos entre repetições e deixar a máquina guiar uma amplitude desconfortável.';
    }
    if (equipment.contains('barra fixa')) {
      return 'Segurar a barra sem ativar ombros, balançar o corpo, soltar a pega de repente, encolher o pescoço e continuar quando a mão já não controla o apoio.';
    }
    if (equipment.contains('elastico')) {
      return 'Prender o elástico num ponto fraco, começar com tensão excessiva, deixar o elástico puxar punhos ou ombros no retorno e perder a linha do movimento.';
    }
    if (equipment.contains('disco')) {
      return 'Apertar o disco só com as pontas dos dedos sem controlo, inclinar o punho, deixar o disco escorregar e escolher peso que obriga a compensar com ombros.';
    }
    return 'Executar $name depressa demais, perder alinhamento da zona trabalhada, prender a respiração, encurtar o alcance útil e continuar depois de perder controlo.';
  }

  static String safetyNotesFor(String name, String group) {
    final n = _n(name);
    if (_has(n, ['flexao classica'])) {
      return 'Para se sentires dor no ombro, cotovelo ou punho. Reduz a amplitude, apoia os joelhos ou usa uma superfície elevada se ainda não tiveres força para manter a prancha alinhada.';
    }
    if (_has(n, ['agachamento com peso corporal'])) {
      return 'Usa uma cadeira como referência se fores iniciante. Para se sentires dor aguda no joelho, anca ou lombar, ou se não conseguires manter calcanhares e joelhos estáveis.';
    }
    if (_has(n, [
      'agachamento com mochila',
      'agachamento com garrafao',
      'lunges com mochila',
    ])) {
      return 'Usa apenas objetos fechados, estáveis e não escorregadios. Para se a carga se deslocar, se perderes equilíbrio ou se sentires dor aguda no joelho, anca, lombar ou punho.';
    }
    if (_has(n, ['remo invertido em mesa resistente'])) {
      return 'Usa apenas mesa resistente e pesada, em piso que não escorrega. Para imediatamente se a mesa mexer, se a pega falhar ou se houver dor no ombro, cotovelo ou punho.';
    }
    if (_has(n, ['mobilidade de ombro com cabo de vassoura'])) {
      return 'O bastão serve só como guia leve. Para se houver dor aguda, formigueiro, pressão no ombro ou necessidade de arquear a lombar para completar o movimento.';
    }
    if (_has(n, ['supino com barra'])) {
      return 'Usa pins de segurança ou pede ajuda quando a carga for desafiante. Para se houver dor no ombro, cotovelo ou punho, e nunca deixes a barra descer para o pescoço.';
    }
    if (_has(n, ['passadeira aquecimento'])) {
      return 'Mantém intensidade leve a moderada. Reduz a velocidade se sentires falta de coordenação, dor articular, tontura ou respiração demasiado acelerada para o início do treino.';
    }
    if (_has(n, ['passadeira cooldown'])) {
      return 'Não pares de repente depois de esforço intenso. Continua a caminhar até a respiração acalmar e usa os apoios ao sair se houver tontura ou sensação de instabilidade.';
    }
    if (_has(n, ['puxada alta pega neutra'])) {
      return 'Escolhe carga que permita controlar a subida. Evita puxar atrás da nuca e para se houver dor no ombro, cotovelo, punho ou formigueiro no braço.';
    }
    if (_has(n, ['pescoco', 'cervical', 'chin tuck'])) {
      return 'Usa força muito leve. Para se houver dor aguda, tontura, formigueiro, pressão na cabeça, visão turva ou dor a irradiar para ombro e braço.';
    }
    if (_has(n, ['peso morto', 'good morning', 'hiperextensao', 'lombar'])) {
      return 'Começa com carga baixa, mantém a lombar neutra e interrompe se sentires dor aguda, perda de força, formigueiro ou desconforto que aumenta a cada repetição.';
    }
    if (_has(n, [
      'agachamento',
      'supino',
      'dips',
      'aberturas',
      'press militar',
    ])) {
      return 'Usa carga conservadora, aumenta o alcance aos poucos e pede ajuda ou usa suporte quando a carga estiver pesada. Para se houver dor articular no ombro, joelho, cotovelo ou lombar.';
    }
    if (group == 'Cardio' ||
        _has(n, ['hiit', 'sprint', 'sprints', 'burpees'])) {
      return 'Aquece antes, mantém intensidade adequada ao teu nível e para se houver tontura, dor no peito, falta de ar anormal, dor articular ou perda de coordenação.';
    }
    if (group == 'Karate' || group == 'Jiu-Jitsu') {
      return 'Treina em piso seguro, aumenta velocidade só depois de dominar a técnica e para com dor articular, impacto na cabeça, tontura ou sensação de instabilidade.';
    }
    if (group == 'Mobilidade') {
      return 'Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte ou pressão articular.';
    }
    final equipment = _n(equipmentFor(name));
    if (equipment.contains('halter')) {
      return 'Usa halteres que consigas pousar sem ajuda. Mantém punhos alinhados e reduz a carga se surgir dor no punho, cotovelo, ombro ou lombar.';
    }
    if (equipment.contains('barra') && !equipment.contains('barra fixa')) {
      return 'Começa com barra leve, usa suportes ou ajuda quando necessário e para se a barra se afastar da trajetória prevista ou se sentires dor articular.';
    }
    if (equipment.contains('cabo') || equipment.contains('polia')) {
      return 'Confirma que a polia está presa, começa com carga baixa e mantém distância suficiente para controlar o retorno sem puxão no ombro, cotovelo ou punho.';
    }
    if (equipment.contains('maquina')) {
      return 'Ajusta a máquina antes da primeira série e testa com carga leve. Para se o eixo da máquina obrigar dor, dormência ou sensação de pressão articular.';
    }
    if (equipment.contains('barra fixa')) {
      return 'Usa uma barra firme e seca. Desce com apoio se a pega falhar e para se houver dor no ombro, cotovelo, punho ou formigueiro nas mãos.';
    }
    if (equipment.contains('elastico')) {
      return 'Inspeciona o elástico antes de usar, evita apontá-lo para o rosto e reduz a tensão se o retorno puxar punhos, cotovelos ou ombros.';
    }
    if (equipment.contains('disco')) {
      return 'Usa discos com superfície segura para agarrar e mantém os pés fora da zona de queda. Termina a série antes de a pega abrir sem controlo.';
    }
    return 'Controla $name do início ao fim, respira durante o esforço e interrompe se aparecer dor aguda, tontura, formigueiro ou perda de equilíbrio.';
  }

  static String _mobilitySteps(String name) =>
      '1. Coloca-te numa posição confortável para trabalhar $name sem dor. 2. Organiza a coluna e relaxa ombros, mandíbula e mãos. 3. Move devagar até sentires tensão leve na zona alvo, não dor. 4. Respira pelo nariz ou de forma calma durante 15 a 30 segundos. 5. Aumenta ou reduz o alcance usando o apoio das mãos, pés ou chão. 6. Sai da posição lentamente antes de repetir ou trocar de lado.';

  static String _cardioSteps(String name) =>
      '1. Começa com 3 a 5 minutos de ritmo fácil para aquecer. 2. Mantém tronco alto, olhar em frente e respiração regular. 3. Ajusta velocidade, resistência ou cadência para conseguires falar frases curtas no esforço leve a moderado. 4. Mantém o bloco principal entre 5 e 20 minutos, ou intervalos curtos se $name for intenso. 5. Reduz o ritmo durante 2 a 5 minutos no final. 6. Para se a técnica, o equilíbrio ou a respiração ficarem desorganizados.';

  static String _martialSteps(String name, String art) =>
      '1. Começa em base estável de $art, com pés ativos e joelhos ligeiramente fletidos. 2. Define o objetivo técnico de $name antes de aumentar velocidade. 3. Executa a primeira repetição devagar, coordenando anca, tronco, braços e olhar. 4. Regressa à base com controlo e sem cruzar os pés de forma insegura. 5. Respira a cada repetição e mantém maxilar relaxado. 6. Faz séries curtas de 30 a 60 segundos, descansando antes de perder precisão.';

  static String _dumbbellSteps(String name) =>
      '1. Escolhe halteres que consigas controlar do início ao fim. 2. Segura os halteres com punhos neutros, sem deixar a mão dobrar para trás. 3. Coloca pés à largura da anca e ativa ligeiramente o abdómen. 4. Move os halteres até ao ponto em que cotovelos e ombros continuam alinhados e sem dor. 5. Pausa por um instante no ponto de maior esforço. 6. Regressa devagar sem deixar os halteres cair. 7. Inspira na fase de descida ou preparação e expira na fase de subida ou esforço.';

  static String _barbellSteps(String name) =>
      '1. Aproxima-te da barra e escolhe uma pega segura, normalmente à largura dos ombros ou um pouco mais aberta conforme $name. 2. Alinha punhos, cotovelos e tronco antes de tirar a barra do apoio ou do chão. 3. Mantém a barra perto da linha de força do corpo. 4. Sobe, desce ou move a barra só até onde consegues manter lombar, punhos e ombros alinhados, conforme a direção do exercício. 5. Controla a barra na descida e evita bater no suporte. 6. Inspira antes da fase difícil e expira ao terminar o esforço. 7. Usa a barra vazia ou uma carga que permita repetir a mesma trajetória sem perder punhos, ombros e lombar.';

  static String _cableSteps(String name) =>
      '1. Ajusta a polia à altura indicada pela variação de $name. 2. Escolhe uma pega que permita punhos alinhados e ombros relaxados. 3. Dá um passo para criar tensão no cabo antes da primeira repetição. 4. Move a pega até ao ponto em que a articulação alvo continua estável, dobrando ou estendendo os cotovelos conforme o exercício, sem puxar com balanço do tronco. 5. Pausa brevemente no ponto de contração. 6. Deixa o cabo regressar devagar, mantendo tensão. 7. Inspira no retorno e expira quando puxas ou empurras.';

  static String _machineSteps(String name) =>
      '1. Ajusta banco, encosto e pegas para a zona que vai mover ficar alinhada com o eixo da máquina. 2. Seleciona carga leve para testar o caminho da máquina. 3. Segura as pegas com punhos alinhados ou apoia os pés no local indicado. 4. Empurra ou puxa enquanto dobras ou estendes a zona trabalhada, parando antes de a máquina causar dor ou tirar as costas do apoio. 5. Regressa devagar até sentires alongamento ou flexão segura. 6. Inspira no retorno e expira no esforço. 7. Mantém costas e cabeça apoiadas quando a máquina tiver apoio.';

  static String _pullupBarSteps(String name) =>
      '1. Segura a barra fixa com a pega indicada por $name e mãos firmes. 2. Começa pendurado com ombros ativos, sem deixar o pescoço encolher. 3. Organiza costelas e abdómen para evitar balanço excessivo. 4. Puxa, sustenta ou eleva as pernas conforme o exercício, respeitando a amplitude que controlas. 5. Desce ou relaxa devagar sem soltar a barra de repente. 6. Inspira antes da fase difícil e expira durante o esforço. 7. Usa apoio dos pés ou elástico se ainda não controlas o peso corporal.';

  static String _bandSteps(String name) =>
      '1. Prende ou segura o elástico num ponto seguro e na altura adequada para $name. 2. Agarra o elástico com punhos alinhados e tensão leve antes de começar. 3. Afasta-te apenas o suficiente para sentir resistência sem perder controlo. 4. Dobra, estende ou abre os braços conforme o exercício, parando antes de o elástico puxar ombros ou punhos para fora da linha. 5. Pausa no ponto de maior tensão. 6. Regressa devagar até manter tensão leve. 7. Inspira no retorno e expira ao afastar ou puxar o elástico.';

  static String _bodyweightSteps(String name) =>
      '1. Posiciona mãos, pés ou apoios de acordo com $name, usando uma base firme. 2. Alinha cabeça, tronco e anca antes de iniciar. 3. Ativa ligeiramente abdómen e glúteos para proteger lombar. 4. Dobra ou estende as articulações pela amplitude que consegues controlar. 5. Pausa se precisares de reorganizar a posição. 6. Regressa devagar sem cair no chão ou perder equilíbrio. 7. Inspira na fase mais fácil e expira no esforço.';

  static bool _has(String normalizedText, List<String> values) =>
      values.any((value) => normalizedText.contains(_n(value)));

  static String _n(String value) => WorkoutTaxonomy.normalize(value);
}
