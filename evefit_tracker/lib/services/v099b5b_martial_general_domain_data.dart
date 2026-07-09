import 'v100_catalog_domain_data.dart';

class _MartialGeneralSeed {
  const _MartialGeneralSeed(
    this.name,
    this.section,
    this.contextKey,
    this.equipment,
    this.goal,
  );

  final String name;
  final String section;
  final String contextKey;
  final String equipment;
  final String goal;
}

const _safety =
    'Pratica tecnica em ritmo leve. Usa espaco seguro, evita impacto forte e para se houver dor, tontura ou perda de orientacao.';

List<_MartialGeneralSeed> _pair({
  required String base,
  required String section,
  required String contextKey,
  required String equipment,
  required String goal,
  String suffix = 'com pausa',
}) => [
  _MartialGeneralSeed(base, section, contextKey, equipment, goal),
  _MartialGeneralSeed(
    '$base $suffix',
    section,
    contextKey,
    equipment,
    '$goal com pausa curta para consolidar controlo',
  ),
];

final v099b5bMartialGeneralDomainEntries =
    <_MartialGeneralSeed>[
          ..._pair(
            base: 'Shrimp basico no tatami',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'criar espaco com deslocamento da anca no solo',
          ),
          ..._pair(
            base: 'Shrimp alternado',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'alternar saidas de anca para os dois lados',
          ),
          ..._pair(
            base: 'Ponte de anca para BJJ',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'elevar a anca para criar espaco no solo',
          ),
          ..._pair(
            base: 'Ponte e rotacao para saida',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'ligar ponte da anca a rotacao de saida',
          ),
          ..._pair(
            base: 'Technical stand up para BJJ',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'levantar do solo protegendo distancia e base',
          ),
          ..._pair(
            base: 'Granby roll regressivo',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'preparar rolamento de ombro com amplitude baixa',
          ),
          ..._pair(
            base: 'Hip escape em linha',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'repetir hip escape em linha reta',
          ),
          ..._pair(
            base: 'Sit through controlado',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'rodar por baixo do corpo mantendo apoios seguros',
          ),
          ..._pair(
            base: 'Base sentada para levantamento tecnico',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'organizar mao, pe e perna antes de levantar',
          ),
          ..._pair(
            base: 'Mobilidade de guarda sentada',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'mudar apoios em guarda sentada sem cair para tras',
          ),
          ..._pair(
            base: 'Retencao de guarda com deslocamento da anca',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'usar anca e pernas para recuperar alinhamento da guarda',
          ),
          ..._pair(
            base: 'Sprawl controlado',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'levar pernas para tras sem colapsar lombar',
          ),
          ..._pair(
            base: 'Queda tecnica lateral regressiva',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'aprender queda lateral baixa com protecao do ombro',
          ),
          ..._pair(
            base: 'Rolamento para tras regressivo',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'rolar para tras com queixo protegido e pouca velocidade',
          ),
          ..._pair(
            base: 'Rolamento para frente regressivo',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'rolar para frente com entrada baixa e controlo do pescoco',
          ),
          ..._pair(
            base: 'Entrada de double leg sem parceiro',
            section: 'BJJ solo e tatami',
            contextKey: 'jiu_jitsu',
            equipment: 'Tatami e kimono opcional',
            goal: 'praticar mudanca de nivel e passo de entrada sem contacto',
          ),
          ..._pair(
            base: 'Jab no saco com guarda alta',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Saco, aparadores ou peso corporal',
            goal: 'bater jab leve mantendo guarda alta',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Direto no saco com rotacao da anca',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Saco, aparadores ou peso corporal',
            goal: 'coordenar direto com rotacao da anca',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Sequencia jab-direto no saco',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Saco, aparadores ou peso corporal',
            goal: 'encadear jab e direto sem perder base',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Low kick leve no saco',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Saco, aparadores ou peso corporal',
            goal: 'praticar low kick leve com equilibrio',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Mae geri no aparador',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Saco, aparadores ou peso corporal',
            goal: 'aplicar mae geri no aparador com recolha segura',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Mawashi geri baixo no aparador',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Saco, aparadores ou peso corporal',
            goal: 'aplicar mawashi geri baixo com alvo fixo e ritmo leve',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Joelhada frontal no saco',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Saco, aparadores ou peso corporal',
            goal: 'praticar joelhada frontal sem impacto maximo',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Cotovelada tecnica no aparador',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Saco, aparadores ou peso corporal',
            goal: 'praticar cotovelada com trajectoria curta e alvo seguro',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Saida de linha contra avanco simples',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Espaco livre e aparador opcional',
            goal: 'sair da linha de avanco antes de responder',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Guarda de protecao pessoal',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Espaco livre',
            goal: 'organizar maos, queixo e distancia em postura defensiva',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Recuo com maos ativas',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Espaco livre',
            goal: 'recuar mantendo maos ativas e olhar no alvo',
            suffix: 'controlado',
          ),
          ..._pair(
            base: 'Libertacao basica de punho com baixa forca',
            section: 'saco, defesa e condicionamento',
            contextKey: 'defesa_pessoal',
            equipment: 'Parceiro cooperativo opcional',
            goal: 'praticar saida simples de punho com pouca forca e controlo',
            suffix: 'controlado',
          ),
        ]
        .map(
          (seed) => V100CatalogDomainEntryData(
            source: 'GOOD_V1_B5B',
            section: seed.section,
            conceptId: _stableKey(seed.name),
            name: seed.name,
            contextKey: seed.contextKey,
            primaryType: 'artes_marciais',
            equipment: seed.equipment,
            primaryMuscle: seed.contextKey == 'jiu_jitsu'
                ? 'mobilidade no solo'
                : 'condicionamento especifico',
            secondaryMuscles:
                'pernas; core; ombros; costas; coordenacao; controlo de distancia',
            joint: 'anca; joelho; tornozelo; ombro; cotovelo; coluna',
            goal: seed.goal,
            priority: 'B5B',
            safety: _safety,
          ),
        )
        .toList(growable: false);

String _stableKey(String value) => value
    .toLowerCase()
    .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
    .replaceAll(RegExp(r'^_|_$'), '');
