import 'dart:io';

import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';

/// For each catalog entry, checks whether the execution steps mention the
/// tokens that define the variation named in the exercise. Entries whose
/// steps never reference the distinguishing token cannot teach a beginner
/// that variation.
void main() {
  final buffer = StringBuffer();
  final tokenRules = <String, List<String>>{
    'bulgaro': ['tras apoiada', 'apoiada atras', 'banco atras', 'peito do pe'],
    'goblet': ['junto ao peito', 'ao peito', 'frente do peito'],
    'sumo': ['mais afastados', 'bem afastados', 'largura larga', 'para fora'],
    'smith': ['smith', 'barra guiada', 'guiada'],
    'unilateral': ['uma perna', 'um braco', 'uma mao', 'um lado', 'perna de cada vez', 'braco de cada vez'],
    'alternado': ['alterna'],
    'inclinado': ['inclinado', 'inclinada'],
    'declinado': ['declinado', 'declinada'],
    'concentrado': ['coxa', 'apoiado'],
    'spider': ['peito apoiado', 'apoia o peito'],
    'sentado': ['senta', 'sentado'],
    'em pe': ['de pe', 'em pe'],
    'deitado': ['deita', 'deitado'],
    'suspenso': ['pendura', 'suspens', 'barra fixa'],
    'isometric': ['segura', 'aguenta', 'mantem', 'parado', 'sem movimento', 'sustenta'],
    'com apoio': ['apoio', 'apoiada', 'apoiado', 'banco', 'cadeira', 'parede'],
    'na maquina': ['maquina'],
    'no cabo': ['cabo', 'polia'],
    'com elastico': ['elastico'],
    'com barra': ['barra'],
    'com halter': ['halter'],
    'com mochila': ['mochila'],
    'com garrafao': ['garrafao'],
    'romeno': ['joelhos pouco', 'joelhos ligeiramente', 'anca para tras'],
    'arqueiro': ['um braco', 'lado', 'estendido'],
    'pega aberta': ['mais larga', 'aberta', 'afastadas'],
    'pega fechada': ['fechada', 'curta', 'estreita', 'proxima'],
    'pega neutra': ['neutra', 'uma para a outra'],
    'walking': ['avanca', 'caminha', 'passo em frente'],
    'wall': ['parede'],
    'banco romano': ['banco romano', 'romano', 'maquina'],
    'no chao': ['chao'],
    'quadrupede': ['maos e joelhos', 'quatro apoios', 'quadrupedia'],
    'hiperextensao': ['estende', 'sobe o tronco', 'eleva o tronco', 'eleva bracos e pernas', 'extensao da anca'],
    'kickback': ['para tras'],
    'crossover': ['cruza'],
    'pullover': ['arco', 'atras da cabeca'],
    'zottman': ['roda'],
    'martelo': ['neutra', 'martelo'],
    'inverso': ['pronada', 'para baixo'],
    '21': ['sete', '21'],
    'arrastado': ['arrasta', 'recuam', 'junto ao tronco'],
    'step-up': ['sobe', 'degrau', 'apoio elevado', 'banco'],
    'leg press': ['plataforma', 'maquina'],
    'extensao de perna': ['maquina', 'estende os joelhos', 'estende o joelho'],
    'curl de perna': ['maquina', 'dobra o joelho', 'dobra os joelhos', 'calcanhar'],
    'hip thrust': ['costas apoiadas', 'apoia as costas', 'ombros apoiados', 'anca para cima', 'eleva a anca'],
    'ponte': ['eleva a anca', 'anca para cima', 'sobe a anca'],
    'abducao': ['afasta', 'para fora', 'lateral'],
    'aducao': ['aproxima', 'para dentro', 'junta'],
    'tibial': ['ponta do pe', 'dedos para cima', 'canela'],
    'soleo': ['joelho fletido', 'joelho dobrado', 'joelhos dobrados'],
    'vacuum': ['para dentro', 'encolhe', 'umbigo'],
    'russian twist': ['roda', 'rotacao'],
    'side bend': ['inclina', 'lado'],
    'face pull': ['rosto', 'cara', 'face'],
    'pull-apart': ['afasta', 'abre'],
    'towel': ['toalha'],
    'pinch': ['pinca', 'polegar'],
    'plate hold': ['disco'],
    'squeeze': ['aperta', 'junta'],
    'arnold': ['roda'],
    'pike': ['anca elevada', 'anca alta', 'v invertido'],
    'scapular': ['escapula', 'omoplata'],
    'dead hang': ['pendura', 'suspens'],
    'chin-up': ['palmas viradas para ti', 'supinada', 'palmas para ti'],
    'burpee': ['prancha', 'agacha'],
    'jumping jacks': ['abre', 'fecha'],
    'mountain climbers': ['joelhos ao peito', 'joelho ao peito', 'alterna'],
    'copenhagen': ['banco', 'perna de cima'],
    'farmer': ['caminha', 'segura'],
    'suitcase': ['um lado', 'uma mao'],
  };

  for (final entry in ExerciseCatalogContextService.entries) {
    final name = _n(entry.name);
    final text = _n(entry.details.executionSteps);
    final missing = <String>[];
    for (final rule in tokenRules.entries) {
      if (name.contains(rule.key) && !rule.value.any(text.contains)) {
        missing.add(rule.key);
      }
    }
    if (missing.isNotEmpty) {
      buffer.writeln('- ${entry.id} ${entry.name} [${entry.group}] falta: $missing');
    }
  }
  File('tool/step_specificity_output.md').writeAsStringSync(buffer.toString());
  stdout.writeln('wrote tool/step_specificity_output.md');
}

String _n(String value) =>
    ExerciseCatalogContextService.stableKey(value).replaceAll('_', ' ');
