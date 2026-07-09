import 'v100_catalog_domain_data.dart';

class _B4BPreventionSeed {
  const _B4BPreventionSeed(
    this.name,
    this.section,
    this.equipment,
    this.primaryMuscle,
    this.secondaryMuscles,
    this.joint,
    this.goal,
  );

  final String name;
  final String section;
  final String equipment;
  final String primaryMuscle;
  final String secondaryMuscles;
  final String joint;
  final String goal;
}

const _safety =
    'Trabalho leve de tolerancia e controlo. Nao promete prevenir lesoes; adapta se houver dor, fadiga invulgar ou perda de tecnica.';

const _kneeEquipment =
    'Peso corporal, mini band, degrau baixo, caixa e elastico opcional';
const _shoulderEquipment =
    'Elastico leve, parede, toalha, banco e peso corporal';

List<_B4BPreventionSeed> _family({
  required String base,
  required String section,
  required String equipment,
  required String primaryMuscle,
  required String secondaryMuscles,
  required String joint,
  required String goal,
  bool includeSlow = true,
}) {
  final variants = <String>[
    base,
    '$base regressivo',
    '$base com pausa curta',
    if (includeSlow) '$base em ritmo lento',
  ];
  return [
    for (final name in variants)
      _B4BPreventionSeed(
        name,
        section,
        equipment,
        primaryMuscle,
        secondaryMuscles,
        joint,
        _goalForVariant(name, goal),
      ),
  ];
}

String _goalForVariant(String name, String baseGoal) {
  final lower = name.toLowerCase();
  if (lower.contains('regressivo')) {
    return 'reduzir exigencia de $baseGoal mantendo alinhamento e controlo';
  }
  if (lower.contains('pausa curta')) {
    return 'pausar brevemente em $baseGoal sem aumentar desconforto';
  }
  if (lower.contains('ritmo lento')) {
    return 'controlar devagar $baseGoal com tecnica limpa';
  }
  return baseGoal;
}

final v099b4bPreventionDomainEntries =
    <_B4BPreventionSeed>[
          ..._family(
            base: 'Step-down baixo controlado',
            section: 'joelho, anca e lombar',
            equipment: _kneeEquipment,
            primaryMuscle: 'quadriceps',
            secondaryMuscles: 'gluteo medio; gluteo maximo; gemeos; core',
            joint: 'joelho; anca; tornozelo',
            goal: 'descer de um degrau baixo com joelho alinhado',
          ),
          ..._family(
            base: 'Agachamento a caixa com amplitude confortavel',
            section: 'joelho, anca e lombar',
            equipment: _kneeEquipment,
            primaryMuscle: 'quadriceps e gluteos',
            secondaryMuscles: 'isquiotibiais; adutores; core; gemeos',
            joint: 'joelho; anca; coluna; tornozelo',
            goal: 'sentar e levantar de uma caixa com amplitude toleravel',
          ),
          ..._family(
            base: 'Split squat curto assistido',
            section: 'joelho, anca e lombar',
            equipment: _kneeEquipment,
            primaryMuscle: 'quadriceps e gluteos',
            secondaryMuscles: 'adutores; isquiotibiais; gemeos; core',
            joint: 'joelho; anca; tornozelo',
            goal: 'controlar uma base dividida curta com apoio opcional',
          ),
          ..._family(
            base: 'Terminal knee extension com elastico',
            section: 'joelho, anca e lombar',
            equipment: _kneeEquipment,
            primaryMuscle: 'quadriceps',
            secondaryMuscles: 'vasto medial; gluteos; gemeos',
            joint: 'joelho',
            goal: 'estender o joelho contra elastico leve com controlo',
          ),
          ..._family(
            base: 'Wall sit curto',
            section: 'joelho, anca e lombar',
            equipment: _kneeEquipment,
            primaryMuscle: 'quadriceps',
            secondaryMuscles: 'gluteos; adutores; gemeos; core',
            joint: 'joelho; anca; tornozelo',
            goal: 'sustentar posicao curta na parede com joelhos alinhados',
          ),
          ..._family(
            base: 'Ponte de gluteos para suporte do joelho',
            section: 'joelho, anca e lombar',
            equipment: _kneeEquipment,
            primaryMuscle: 'gluteo maximo',
            secondaryMuscles:
                'gluteo medio; isquiotibiais; core; quadriceps leve',
            joint: 'anca; joelho; coluna',
            goal: 'usar extensao da anca para melhorar controlo da perna',
          ),
          ..._family(
            base: 'Rotacao externa com elastico junto ao corpo',
            section: 'ombro, escapulas e articulacoes pequenas',
            equipment: _shoulderEquipment,
            primaryMuscle: 'rotadores externos do ombro',
            secondaryMuscles:
                'infraespinhoso; redondo menor; deltoide posterior; escapulas',
            joint: 'ombro; escapula; cotovelo',
            goal: 'rodar o ombro para fora com cotovelo junto ao corpo',
          ),
          ..._family(
            base: 'Rotacao interna com elastico leve',
            section: 'ombro, escapulas e articulacoes pequenas',
            equipment: _shoulderEquipment,
            primaryMuscle: 'rotadores internos do ombro',
            secondaryMuscles:
                'subescapular; peitoral maior; grande dorsal; escapulas',
            joint: 'ombro; escapula; cotovelo',
            goal: 'rodar o ombro para dentro contra elastico leve',
          ),
          ..._family(
            base: 'Wall slide com elastico',
            section: 'ombro, escapulas e articulacoes pequenas',
            equipment: _shoulderEquipment,
            primaryMuscle: 'serratil anterior',
            secondaryMuscles:
                'trapezio inferior; rotadores externos; deltoides',
            joint: 'escapula; ombro; coluna toracica',
            goal: 'deslizar os bracos na parede mantendo escapulas controladas',
          ),
          ..._family(
            base: 'Face pull leve',
            section: 'ombro, escapulas e articulacoes pequenas',
            equipment: _shoulderEquipment,
            primaryMuscle: 'deltoide posterior e trapezio medio',
            secondaryMuscles:
                'rotadores externos; romboides; trapezio inferior',
            joint: 'ombro; escapula; cotovelo',
            goal: 'puxar elastico para a face com cotovelos altos e controlo',
          ),
          ..._family(
            base: 'Serratus wall slide',
            section: 'ombro, escapulas e articulacoes pequenas',
            equipment: _shoulderEquipment,
            primaryMuscle: 'serratil anterior',
            secondaryMuscles:
                'trapezio inferior; rotadores externos; core leve',
            joint: 'escapula; ombro; coluna toracica',
            goal: 'ativar serratil com deslizamento leve na parede',
          ),
          ..._family(
            base: 'Scapular push-up regressivo',
            section: 'ombro, escapulas e articulacoes pequenas',
            equipment: _shoulderEquipment,
            primaryMuscle: 'serratil anterior',
            secondaryMuscles:
                'trapezio medio; trapezio inferior; peitoral menor; core leve',
            joint: 'escapula; ombro; cotovelo',
            goal: 'controlar protracao e retracao escapular em apoio facil',
          ),
          ..._family(
            base: 'Y-T-W no banco sem carga',
            section: 'ombro, escapulas e articulacoes pequenas',
            equipment: _shoulderEquipment,
            primaryMuscle: 'trapezio inferior e deltoide posterior',
            secondaryMuscles: 'trapezio medio; romboides; rotadores externos',
            joint: 'escapula; ombro; coluna toracica',
            goal: 'praticar padroes Y, T e W sem carga para controlo escapular',
            includeSlow: false,
          ),
        ]
        .map(
          (seed) => V100CatalogDomainEntryData(
            source: 'GOOD_V1_B4B',
            section: seed.section,
            conceptId: _stableKey(seed.name),
            name: seed.name,
            contextKey: 'prevencao',
            primaryType: 'prevencao',
            equipment: seed.equipment,
            primaryMuscle: seed.primaryMuscle,
            secondaryMuscles: seed.secondaryMuscles,
            joint: seed.joint,
            goal: seed.goal,
            priority: 'B4B',
            safety: _safety,
          ),
        )
        .toList(growable: false);

String _stableKey(String value) => value
    .toLowerCase()
    .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
    .replaceAll(RegExp(r'^_|_$'), '');
