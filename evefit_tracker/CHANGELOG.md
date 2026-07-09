# v1.0.0 RC

- Congelada a expansao GOOD_V1 do catalogo com 1762 entradas auditadas.
- Totais principais: musculacao 400, cardio 100, artes marciais 360, mobilidade 230, elasticidade 170, recuperacao 147, aquecimento 150, ativacao 110 e prevencao 95.
- Auditoria strict sem critical issues, warnings, wrong-results ou exercicios inacessiveis.
- Checklist manual Pixel criado para validacao antes da release final.
- Builds Android debug/release validados para release candidate.
- Atualizada versao da app para v1.0.0-rc.1.

# v0.9.4

- Criada alfandega permanente dos catalogos com auditoria reutilizavel, modo relatorio e modo `--strict`.
- Adicionados validadores permanentes para identidade canonica, taxonomia, equipamento/local, filtros, conteudo, seguranca e linguagem.
- Gerados inventario completo e gap analysis do catalogo em `build/reports/`.
- Corrigido bug de `Cardio - Passadeira - Resistencia aerobica`, incluindo exercicios essenciais de passadeira.
- Corrigidas descricoes genericas e musculos de `Adductor squeeze leve` e variantes relacionadas.
- Criado comando unico de QA em `tool/run_quality_gate.ps1` e workflow de quality gate para PRs.
- QA, testes e build Android validados para versao testavel v0.9.4.
- Atualizada versao da app para v0.9.4.

# v0.9.3

- Reconstrucao canonica do catalogo de exercicios, separando `canonical_id` de `catalog_entry_key`.
- Catalogo expandido para 1171 entradas, com 1141 canonical IDs unicos e 1192 alias pairs.
- Novos filtros por local, equipamento e contexto, preservando compatibilidade com historico antigo.
- Menus progressivos para musculacao, cardio, artes marciais, mobilidade, elasticidade, recuperacao, aquecimento, ativacao e prevencao.
- Descricoes, execucoes passo a passo, respiracao, erros comuns, cuidados, regressao e progressao completos para iniciantes.
- Migracao segura com base de dados v21, mantendo `catalog_entry_key`, templates, exercicios personalizados e series antigas.
- QA, testes e build Android validados: `flutter analyze`, `flutter test`, APK debug e APK release.
- Atualizada versão da app para v0.9.3.

# v0.9.2

- Expansão do catálogo de exercícios: 315 → 353 (38 novos), fechando lacunas reais identificadas em gap analysis: coifa do ombro (elevação no plano da omoplata), extensão cervical, rotação do tronco com carga (lenhador no cabo), anti-rotação sem equipamento (prancha com toque no ombro), rotadores externos da anca (clamshell), isquiotibiais excêntricos (curl nórdico assistido) e dobradiça unilateral (peso morto unilateral).
- Cardio novo com filtros próprios: remo ergómetro, stepper/escadas e air bike (contínuo + intervalos), subida de escadas no exterior, shadow boxing leve e shuttle runs, com nível de impacto indicado no texto.
- Mobilidade e elasticidade: primeiros alongamentos PNF (isquiotibiais e peitoral), flexores da anca em afundo, borboleta de adutores, tríceps atrás da cabeça, cobra suave e alongamento dinâmico global.
- Artes marciais: Karate ganhou bases (dachi), bloqueios (uke), esquivas/tai-sabaki, joelhadas e trabalho leve ao saco (marcado como exigindo saco de pancada); Jiu-Jitsu ganhou rolamentos, breakfalls (ukemi) e inversão granby, com novos focos técnicos nos filtros.
- Recuperação e prevenção: respiração nasal lenta, foam roller (pernas e costas), bola de massagem, arrefecimentos guiados pós-força e pós-artes marciais e aquecimento dinâmico geral.
- Descrições dos 38 exercícios novos escritas de raiz no modelo canónico (objetivo, 4-7 passos, erros comuns, regressão/progressão, segurança).
- Corrigidos filtros de exercícios existentes: "Mobilidade de ombro com cabo de vassoura" e "Rotação externa da anca no chão" voltaram a aparecer nos filtros; drills marciais deixaram de aparecer em focos técnicos errados.
- Removidas as últimas frases-muleta ("conforme a variação", "indicada pela variação") de 47 exercícios; prancha lateral e face pull com elástico ganharam passos próprios.
- Migração segura (base de dados v20): os novos exercícios entram e os textos atualizam sem tocar em exercícios personalizados, treinos, séries, medidas, fotos ou objetivos.
- 28 novos testes obrigatórios de catálogo e filtros (total: 417 testes).
- Atualizada versão da app para v0.9.2.

# v0.9.1

- Revisão pedagógica completa dos 315 exercícios do catálogo: objetivo curto e específico, execução em lista de 4 a 7 passos, erros comuns em lista e versões mais fácil/difícil concretas.
- Corrigida a linguagem errada de equipamento (exercícios de peso corporal deixaram de falar em "carga"; cada tipo de equipamento tem instruções próprias).
- Flexão diamante, Curl arrastado com halteres e Tate press ensinados corretamente, passo a passo.
- Novo modal de detalhes do exercício com secções (Resumo, Objetivo, Como fazer, Erros comuns, Variações, Segurança) e listas verticais legíveis no telemóvel.
- Migração segura: instalações existentes recebem os textos novos sem tocar em exercícios personalizados, treinos, séries, medidas, fotos ou objetivos.
- Novos testes e quality gate impedem regressões de conteúdo.
- Atualizada versão da app para v0.9.1.

# v0.9.0

- Corrigida a filtragem por músculo específico: focos sem correspondência deixaram de mostrar a região inteira (deltoide posterior, rotadores, lombar, etc.) e focos sem mapa deixaram de ficar vazios (deltoide anterior/lateral, trapézio superior/médio/inferior, romboides, dorsal, pescoço, vastos, isquiotibiais específicos, glúteos, flexores da anca, pés).
- Tags musculares canónicas por entrada do catálogo (ombros, trapézio, pescoço, peito, costas, braços, antebraço, core e pernas) passam a ser a fonte de verdade dos filtros; keywords sobre-abrangentes (adutores, gémeos, serrátil, oblíquos, etc.) removidas.
- Removidas opções sem exercícios reais (coracobraquial, rotadores externos da anca) e adicionados alvos em falta (peitoral menor nos dips, adutores no sumo/Copenhagen, teres menor no face pull).
- Local/equipamento: corda de saltar e cabo de vassoura disponíveis no ginásio; "Corrida em subida" passa a exigir espaço exterior; drills de Karate deixam de exigir tatami; drills de solo de Jiu-Jitsu aceitam tatami ou tapete; mobilidade/pega/core/condicionamento de Jiu-Jitsu ficam disponíveis em qualquer local.
- Textos corrigidos exercício a exercício: Curl de perna, Extensão de perna e Leg press deixaram de usar textos de outras famílias; ~75 exercícios receberam passos de execução específicos escritos de raiz (búlgaro, sumo, goblet, Smith, wall sit, step-up, hip thrust, pontes, abdução/adução, gémeos/sóleo/tibial, peso morto, encolhimentos, presses de ombro, wall slides, pike/scapular push-up, crossover, pullovers, remos, hiperextensões, curls concentrado/spider/inclinado/isométrico, fundos, dips, extensões de tríceps, pega (dead hang, pinch, plate, towel, suitcase, desvios), core (mountain climbers, side bend, vacuum, russian twist, pallof, elevações, hollow, flutter, toe touches, superman, reverse/bicycle crunch), cardio sem equipamento e drills de solo de Jiu-Jitsu).
- Removidas frases-placeholder ("a trajetória específica desta variação") das instruções.
- Novos testes de regressão garantem que todas as opções da UI devolvem exercícios e que os textos ensinam a variação correta.
- Atualizada versão da app para v0.9.0.

# v0.8.0

- Corrigido isolamento de objetivos e milestones por perfil.
- Corrigido isolamento de equipamentos e locais por perfil.
- Corrigidos filtros anatómicos dos exercícios.
- Revistas descrições e execuções individuais dos exercícios.
- Expandido catálogo de exercícios por músculo, equipamento e local.
- Corrigido encoding corrompido.
- Corrigida associação de templates a exercícios.
- Melhoradas validações e testes.
- Atualizada versão da app para v0.8.0.
