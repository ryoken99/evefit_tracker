# EveFit v1.1.6 — Landing EFT

## Novidades
- Nova landing page EFT com identidade tecnológica baseada em circuitos eletrónicos.
- Gradiente violeta, azul-escuro e dourado refinado, com nodes azuis luminosos.
- Transição curta para a seleção de perfil.
- Ecrã `Escolher perfil` atualizado com um fundo PCB coordenado sem lettering.
- Legibilidade e consistência reforçadas em diferentes ecrãs e escalas de texto.

## Atualização
- A atualização direta desde `1.1.5+7` preserva perfis, PIN, dados pessoais, treinos e históricos.
- Package Android, schema e migrations não foram alterados.
- Versão: `1.1.6+8`.

# EveFit v1.1.5 — Primeiros exercícios canónicos

## Resumo

- Adicionados 49 exercícios não musculares aprovados.
- As intenções compatíveis passam a apresentar exercícios disponíveis.
- Cada exercício possui uma explicação detalhada em PT-PT para principiantes.
- Foram adicionadas instruções passo a passo, preparação, respiração, erros comuns e segurança.
- Exercícios de exigência elevada apresentam avisos próprios.
- Foram adicionadas três variantes de exercícios.
- Esta versão ainda não adiciona os exercícios diretamente aos treinos.
- Conteúdo muscular, prescrições automáticas e multimédia continuam em preparação.

## Informação técnica

- Versão: `1.1.5+7`.
- 49 exercícios, 88 relações públicas, 50 intenções e 54 percursos.
- 66 relações condicionais permanecem desativadas.
- Schema SQLite 22 e migrations inalterados.
- Atualizações validadas: `1.1.3+5 → 1.1.5+7` e `1.1.4+6 → 1.1.5+7`.

# EveFit v1.1.4 — Sete Contextos e Intenções Canónicas

## Resumo

- Sete contextos explícitos: Treino principal, Aquecimento, Ativação, Recuperação, Retorno à calma, Prevenção e adaptação, e Retorno à função.
- Oito capacidades, 35 conceitos globais e 40 relações capacidade-conceito.
- Matriz de 280 percursos: 261 compatíveis e 19 incompatíveis, todos com decisão explícita.
- 591 intenções globais e 771 ligações contextualizadas, selecionadas apenas depois de Contexto, Capacidade e Conceito.
- Query progressiva com quatro critérios: `usage_context`, `capability_root`, `training_concept` e `training_intention`.
- Estado vazio intencional no passo Exercícios: esta versão não adiciona exercícios canónicos.

## Limites e preservação

- Zero atributos oficiais, zero exercícios canónicos e zero subníveis.
- O catálogo legacy e a árvore antiga continuam fora do runtime.
- As 693 identidades e 792 ocorrências históricas foram auditadas integralmente, mas não são carregadas como dados funcionais.
- Schema 22 e migrations não mudam. Perfis, medições, objetivos, treinos e históricos são preservados.

## Validação de release

- Versão alvo: `1.1.4+6`.
- A atualização `1.1.3+5 → 1.1.4+6`, build release, assinatura, quality gate remoto e validação final em main são gates obrigatórios antes de publicar.
- O APK usa a configuração de assinatura atual do projeto; não deve ser tratado como build Play Store sem verificação adicional.

# EveFit v1.1.3 - Conceitos Canónicos de Treino

## Resumo

- 35 conceitos globais e 40 compatibilidades ordenadas por capacidade.
- Cinco contextos, oito capacidades e a mesma lista por capacidade em cada contexto.
- Conceitos reutilizáveis com ID, nome e definição globais; não são duplicados por contexto ou capacidade.
- Fluxo Contexto → Capacidade → Conceito → estado vazio de Intenção.
- Zero intenções, zero atributos oficiais, zero exercícios e zero subníveis.
- Legacy e árvore antiga permanecem fora do runtime; schema e migrations não são alterados.
- Dados pessoais e históricos devem permanecer preservados.

## Estado operacional

- Versão declarada: `1.1.3+5`.
- Package Android: `com.sandro.evefittracker`.
- Branch, commit final, PR, merge SHA, tag, release e APK: **PENDENTE DO SOL**.
- Testes focados e Fast Gate: **PASSARAM**.
- PR Gate, quality, Android smoke, full-app, upgrade, build e assinatura: **PENDENTES DAS ETAPAS DE RELEASE**.

Esta nota não declara uma release publicada nem inventa resultados, hashes, URLs ou tempos.

# EveFit v1.1.2 — Pesquisa Canónica Hierárquica

- Pesquisa de exercícios organizada pelo fluxo Contexto → Capacidade → Conceito → Intenção → Exercícios.
- Cinco contextos explícitos, com Treino principal como primeiro contexto, e oito capacidades aprovadas.
- Query progressiva, breadcrumb, Back e Home no seletor de exercícios.
- Estado vazio explícito para conceitos ainda não aprovados.
- Catálogo legacy e árvore antiga continuam fora do runtime e invisíveis.
- Perfis, medições, objetivos, treinos e históricos permanecem preservados na atualização desde a v1.1.1.

Esta versão não adiciona conceitos, intenções ou exercícios canónicos.

# EveFit v1.1.1 - Fundação Canónica

- Quatro eixos conceptuais preparados: capacidade, intenção, conceito de treino e contexto.
- Oito raízes de capacidade, quatro contextos e doze valores classificatórios ativos.
- Os 234 subníveis não aprovados saíram do runtime e foram preservados apenas como rascunho NÃO APROVADO.
- A pesquisa continua tipada e vazia, sem subfiltros, `main_training`, `exercise_ids` ou resultados legacy.
- Dados pessoais, treinos e históricos permanecem preservados.

A v1.1.1 não adiciona exercícios, intenções, conceitos ou atributos oficiais. Apenas alinha o runtime com os elementos já aprovados do Script Canónico EveFit.

# EveFit v1.1.0 - Fundação Canónica

- Novo menu canónico com 8 capacidades, 4 contextos e 246 nós.
- Catálogo canónico vazio; esta versão não adiciona exercícios.
- Catálogo legacy removido do runtime e seed legacy desativado.
- Fontes legacy preservadas como arquivo histórico.
- Perfis, medições, objetivos, treinos e históricos preservados.
- Correção das heroTags dos FloatingActionButton.
- Instalação limpa e upgrade Android validados.
- Versionamento atualizado para 1.1.0+2.

# v1.0.0 RC

- Congelada a expansao GOOD_V1 do catalogo com 1762 entradas auditadas.
- Totais principais: musculacao 400, cardio 100, artes marciais 360, mobilidade 230, elasticidade 170, recuperacao 147, aquecimento 150, ativacao 110 e prevencao 95.
- Auditoria strict sem critical issues, warnings, wrong-results ou exercicios inacessiveis.
- Checklist manual Pixel criado para validacao antes da release final.
- Builds Android debug/release validados para release candidate.
- Atualizada versao da app para v1.0.0-rc.1.

# v0.9.4

- Criada alfandega permanente dos catalogos com `dart run tool/catalog_audit_report.dart --strict`.
- Corrigida passadeira em `Cardio - Passadeira - Resistencia aerobica` e adicionadas/corrigidas entradas essenciais de passadeira.
- Corrigido `Adductor squeeze leve` com explicacao real para iniciantes e musculos corretos.
- Adicionados inventario, gap analysis, docs de qualidade e guia para adicionar exercicio novo.
- Validadores agora falham em problemas criticos de IDs, filtros, linguagem, conteudo, seguranca, equipamento e local.
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

- Corrigida a filtragem de exercícios por músculo específico: cada foco anatómico mostra apenas os exercícios certos, tendo em conta o local de treino e o equipamento.
- Corrigida a disponibilidade por local: corda de saltar e cabo de vassoura no ginásio, corrida em subida exige exterior, Karate sem tatami e drills de solo de Jiu-Jitsu com tatami ou tapete.
- Revistos um a um os textos dos exercícios: cerca de 75 exercícios receberam passos de execução específicos escritos de raiz para principiantes.
- Corrigidos exercícios com instruções da família errada (Curl de perna, Extensão de perna, Leg press).
- Removidas frases genéricas das instruções e reforçados os testes de qualidade do catálogo.
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

## Build técnico

A versão pública, o nome da release e o `build-name` são sempre `0.8.0`.
Android/iOS podem exigir um `build-number` inteiro e crescente; nesse caso ele
é fornecido ao comando de build sem acrescentar `+25` ou outro sufixo à versão
pública.
