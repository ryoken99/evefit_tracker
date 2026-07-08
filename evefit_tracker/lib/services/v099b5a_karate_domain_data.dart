import 'v100_catalog_domain_data.dart';

class _KarateSeed {
  const _KarateSeed(
    this.name,
    this.section,
    this.equipment,
    this.goal,
    this.priority,
  );

  final String name;
  final String section;
  final String equipment;
  final String goal;
  final String priority;
}

const _safety =
    'Pratica tecnica, sem contacto forte. Mantem alcance confortavel, joelhos alinhados e para se houver dor ou tontura.';

List<_KarateSeed> _kihonFamily(String base, String goal) => [
  _KarateSeed(base, 'Karate geral e kihon', 'Sem equipamento', goal, 'B5A'),
  _KarateSeed(
    '$base em linha',
    'Karate geral e kihon',
    'Sem equipamento',
    'repetir $goal em deslocamento linear com postura consistente',
    'B5A',
  ),
  _KarateSeed(
    '$base com pausa tecnica',
    'Karate geral e kihon',
    'Sem equipamento',
    'pausar pontos-chave de $goal antes de aumentar ritmo',
    'B5A',
  ),
];

List<_KarateSeed> _kataFamily(String base, String goal) => [
  _KarateSeed(
    base,
    'kata e bunkai geral',
    'Sem equipamento ou parceiro opcional',
    goal,
    'B5A',
  ),
  _KarateSeed(
    '$base com contagem lenta',
    'kata e bunkai geral',
    'Sem equipamento ou parceiro opcional',
    'fazer $goal com contagem lenta, intencao clara e sem pressa',
    'B5A',
  ),
];

List<_KarateSeed> _kumiteFamily(String base, String goal) => [
  _KarateSeed(base, 'kumite tecnico', 'Sem equipamento ou cones', goal, 'B5A'),
  _KarateSeed(
    '$base em ritmo leve',
    'kumite tecnico',
    'Sem equipamento ou cones',
    'praticar $goal em ritmo leve, sem contacto e com retorno a guarda',
    'B5A',
  ),
];

final v099b5aKarateDomainEntries =
    <_KarateSeed>[
          ..._kihonFamily(
            'Kihon oi zuki em avanco',
            'soco direto em avanco com base estavel',
          ),
          ..._kihonFamily(
            'Kihon gyaku zuki parado',
            'soco inverso parado com rotacao da anca',
          ),
          ..._kihonFamily(
            'Kihon gedan barai',
            'defesa baixa com trajectoria limpa',
          ),
          ..._kihonFamily(
            'Kihon age uke',
            'defesa alta com cotovelo e ombro controlados',
          ),
          ..._kihonFamily(
            'Kihon soto uke',
            'defesa de fora para dentro com base firme',
          ),
          ..._kihonFamily(
            'Kihon uchi uke',
            'defesa de dentro para fora com tronco estavel',
          ),
          ..._kihonFamily(
            'Kihon mae geri',
            'pontape frontal com camara, extensao e recolha',
          ),
          ..._kihonFamily(
            'Kihon mawashi geri baixo',
            'pontape circular baixo com equilibrio',
          ),
          ..._kihonFamily(
            'Kihon yoko geri keage',
            'pontape lateral ascendente com camara curta',
          ),
          ..._kihonFamily(
            'Combinacao defesa e contra-ataque',
            'ligar uma defesa simples a resposta direta',
          ),
          ..._kihonFamily(
            'Deslocamento zenkutsu dachi',
            'avancar em zenkutsu dachi com eixo estavel',
          ),
          const _KarateSeed(
            'Deslocamento kokutsu dachi',
            'Karate geral e kihon',
            'Sem equipamento',
            'recuar ou ajustar base em kokutsu dachi com peso controlado',
            'B5A',
          ),
          ..._kataFamily(
            'Bloco inicial de kata',
            'o primeiro bloco de um kata generico',
          ),
          ..._kataFamily(
            'Bloco de mudanca de direcao em kata',
            'a mudanca de direcao dentro de kata',
          ),
          ..._kataFamily(
            'Bloco de defesa dupla em kata',
            'duas defesas encadeadas dentro de kata',
          ),
          ..._kataFamily(
            'Bloco de avanco e contra-ataque em kata',
            'avanco seguido de resposta tecnica em kata',
          ),
          ..._kataFamily(
            'Transicao lenta entre posturas de kata',
            'transicoes entre bases sem perder altura nem eixo',
          ),
          ..._kataFamily(
            'Kata por seccoes com pausa',
            'kata dividido em secoes pequenas com pausa tecnica',
          ),
          ..._kataFamily(
            'Bunkai gedan barai contra agarre simples',
            'aplicacao basica de gedan barai contra agarre simples',
          ),
          ..._kataFamily(
            'Bunkai age uke com saida de linha',
            'aplicacao basica de age uke com deslocamento fora da linha',
          ),
          ..._kataFamily(
            'Bunkai soto uke e contra-ataque',
            'aplicacao basica de soto uke seguida de contra-ataque',
          ),
          ..._kumiteFamily(
            'Entrada e saida em guarda',
            'entrar e sair da distancia mantendo guarda',
          ),
          ..._kumiteFamily(
            'Passo deslizante para frente',
            'aproximar com passo deslizante curto',
          ),
          ..._kumiteFamily(
            'Passo deslizante para tras',
            'recuar com passo deslizante mantendo postura',
          ),
          ..._kumiteFamily(
            'Mudanca de angulo apos ataque',
            'sair da linha depois de atacar',
          ),
          ..._kumiteFamily(
            'Entrada gyaku zuki sem contacto',
            'entrar com gyaku zuki controlado sem impacto',
          ),
          ..._kumiteFamily(
            'Finta de ombro e saida lateral',
            'usar finta curta antes de sair lateralmente',
          ),
          ..._kumiteFamily(
            'Controlo de distancia com marca no chao',
            'regular distancia usando referencia no chao',
          ),
          ..._kumiteFamily(
            'Reacao visual a comando',
            'responder a comando visual com deslocamento simples',
          ),
          ..._kumiteFamily(
            'Kumite sombra com um ataque',
            'fazer sombra de kumite com uma acao ofensiva',
          ),
          ..._kumiteFamily(
            'Kumite sombra com defesa e contra',
            'fazer sombra de kumite com defesa e resposta',
          ),
        ]
        .map(
          (seed) => V100CatalogDomainEntryData(
            source: 'GOOD_V1_B5A',
            section: seed.section,
            conceptId: _stableKey(seed.name),
            name: seed.name,
            contextKey: 'karate',
            primaryType: 'artes_marciais',
            equipment: seed.equipment,
            primaryMuscle: 'tecnica de base',
            secondaryMuscles:
                'pernas; core; ombros; coordenacao; controlo de distancia',
            joint: 'anca; joelho; tornozelo; ombro; cotovelo',
            goal: seed.goal,
            priority: seed.priority,
            safety: _safety,
          ),
        )
        .toList(growable: false);

String _stableKey(String value) => value
    .toLowerCase()
    .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
    .replaceAll(RegExp(r'^_|_$'), '');
