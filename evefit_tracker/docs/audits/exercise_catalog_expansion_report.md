# Relatório de expansão do catálogo de exercícios (v0.9.2 e v0.9.3)

## Adenda v0.9.3 — cobertura total músculo × equipamento × local

Depois da expansão v0.9.2 (315 → 353), a matriz de cobertura
(`coverage_matrix_v093.md`, gerada por `tool/coverage_matrix.dart`) revelou
células vazias sistemáticas: o kettlebell não tinha um único exercício, e
vários músculos não tinham opção para certas classes de equipamento ou para
treino em casa sem equipamento. A v0.9.3 fecha essas células com **45
exercícios novos (353 → 398)**:

- **Peso corporal (7)**: Elevação Y-T-W deitado no chão, Rotação externa
  isométrica na parede, Rotação interna isométrica na parede, Encolhimento
  isométrico de ombros, Torção de toalha, Afundo lateral, Marcha do psoas
  deitado — todos os músculos passam a ter opção 100% peso corporal, exceto
  três casos fisicamente impossíveis (pinça exige objeto; extensores do
  antebraço têm versão de mobilidade no chão; braquiorradial exige barra
  fixa ou halteres).
- **Kettlebell (8)**: swing, agachamento goblet, peso morto, press de
  ombros, remo, halo, farmer carry, russian twist.
- **Máquina (4)**: press de ombros, curl, extensão de tríceps, gémeos.
- **Cabo (7)**: elevação lateral, elevação frontal, kickback de glúteo,
  abdução de anca, adução de anca, crunch, pull-through.
- **Elástico (15)**: press de peito, press de ombros, elevações lateral e
  frontal, puxada ajoelhada, encolhimento de ombros, agachamento, peso
  morto, curl de perna, ponte de glúteo, abdução de anca, gémeos sentado,
  flexão de punho, extensão de punho — e o Encolhimento de ombros com
  elástico no Trapézio.
- **Halteres/Barra (4)**: remo curvado com halteres, agachamento sumo com
  halteres, gémeos em pé com halteres, hip thrust com barra.
- **Mobilidade (1)**: meios-círculos de pescoço.

Cada um tem ficha completa escrita de raiz (objetivo, passos, erros comuns,
regressão, progressão, músculos, segurança por classe de equipamento) e
aparece nos filtros corretos — validado por inventário (0 inalcançáveis) e
pela suite de 417 testes. Migração segura na base de dados v21. O catálogo
mestre em `docs/catalog/` foi regenerado com os 398.

---

# Relatório da expansão v0.9.2

Resultado das FASES 4-9 da revisão/expansão. Documentos relacionados:
`full_exercise_catalog_inventory.md` (FASE 1), `target_exercise_catalog_reference.md`
(FASE 2) e `exercise_catalog_gap_analysis.md` (FASE 3).

## Totais

- Total de exercícios antes: **315**
- Total de exercícios depois: **353**
- Total de exercícios analisados: **353** (os 315 existentes no inventário FASE 1 + os 38 novos, um a um)
- Total de exercícios adicionados: **38**
- Total de exercícios corrigidos (sem serem novos): **53** (ver lista abaixo)
- Exercícios removidos: **0** (nenhuma remoção teve justificação técnica forte; as quase-duplicações são variações intencionais de equipamento/posição)
- Exercícios movidos de grupo: **0**

## Lista dos exercícios adicionados (38)

Por grupo do catálogo:

- **Pescoço (1)**: Isometria cervical posterior leve
- **Ombros (1)**: Elevação no plano da omoplata
- **Core (2)**: Lenhador no cabo, Prancha com toque no ombro
- **Pernas (3)**: Clamshell, Curl nórdico assistido, Peso morto unilateral com halteres
- **Cardio (9)**: Remo ergómetro ritmo contínuo, Remo ergómetro intervalos, Stepper / escadas ritmo contínuo, Stepper / escadas intervalos, Subida de escadas no exterior, Air bike ritmo contínuo, Air bike intervalos, Shadow boxing leve, Shuttle runs / corrida vaivém
- **Karate (5)**: Treino de bases (dachi), Bloqueios técnicos (uke), Esquivas e tai-sabaki, Joelhadas técnicas, Trabalho leve ao saco
- **Jiu-Jitsu (3)**: Rolamentos de solo, Breakfalls (ukemi), Inversão granby com apoio
- **Mobilidade (14)**: Alongamento PNF de isquiotibiais, Alongamento PNF de peitoral na parede, Alongamento de flexores da anca em afundo, Alongamento borboleta de adutores, Alongamento dinâmico global, Alongamento de tríceps atrás da cabeça, Cobra suave no chão, Respiração nasal lenta, Foam roller para pernas, Foam roller para costas, Bola de massagem para pés e glúteos, Arrefecimento pós-treino de força, Arrefecimento pós-artes marciais, Aquecimento dinâmico geral

## Lista dos exercícios corrigidos (53)

1. **Mobilidade de ombro com cabo de vassoura** — não aparecia em nenhum filtro (equipamento `broomstick` sem chave de peso corporal); agora aparece na mobilidade de ombros.
2. **Rotação externa da anca no chão** — recebia equipamento errado ("Elásticos", regra de ombro); corrigido para peso corporal e agora aparece na mobilidade de anca/glúteos.
3. **Prancha lateral** — herdava os passos da prancha frontal ("olhando para o chão" deitado de lado); passos e erros comuns próprios.
4. **Face pull com elástico** — o 1.º passo mandava usar a polia do cabo; os passos passam a depender do equipamento (elástico vs. cabo).
5. **Shrimp / fuga de anca, Ponte de grappling, Technical stand-up, Sprawl, Drills de guarda (JJ), Drills de passagem de guarda** — equipamento normalizado para "Tatami ou tapete / colchonete" (a regra existia mas nunca era aplicada por causa de uma comparação com underscore); **Mobilidade de anca/ombro para Jiu-Jitsu, Força de pega, Core e Condicionamento leve para Jiu-Jitsu** passaram para "Peso corporal" e ficaram disponíveis em qualquer local seguro (10 exercícios).
6. **47 → 43 exercícios com frases-muleta** ("conforme a variação", "indicada pela variação", "variação escolhida") — instrução concreta em todos: Elevação posterior, Reverse fly, Prancha, Prancha lateral, agachamentos (×7 partilham o molde corrigido), lunges (×4), circuitos/HIIT e cardio exterior (×16), alongamentos de posterior (×7), glúteos (×6), quadríceps (×2), gémeos (×2), punhos (×3).

Nota: os pontos 5 e 6 sobrepõem-se parcialmente (43 + 10 = 53 correções em 51 exercícios distintos + 2 correções de filtro).

## Lacunas resolvidas

Todas as lacunas **GAP** do `exercise_catalog_gap_analysis.md`: OMB-04, PES-02, COR-02, COR-05, GLU-03, PER-04, PER-05, CAR-05, CAR-06, CAR-07, CAR-10, CAR-11, MOB-05, MOB-07, MOB-08, MOB-13, ELA-03, ELA-04, KAR-04, KAR-09, KAR-10, KAR-11, KAR-13, JJ-05, JJ-06, JJ-07, REC-02, REC-03, REC-04, REC-05, REC-08, REC-09, AQU-02 — e as 4 correções **CORRIGIR**.

## Lacunas que ficaram para revisão humana

- Drills com parceiro reais (kumite com contacto, grip fighting a dois, sparring): o catálogo mantém apenas versões a solo/técnicas; treino com parceiro exige supervisão e não é bem descrito por texto estático.
- Elasticidade avançada (espargata/splits, pontes completas): risco elevado para principiantes sem avaliação individual.
- Cardio de natação/ciclismo de estrada: a app não modela piscina nem bicicleta própria como locais/equipamentos.
- Classificação formal de impacto como campo de dados: hoje o impacto (baixo/médio/alto) vai no texto dos exercícios de cardio; um campo estruturado exigiria migração de esquema.

## Decisões tomadas

1. Nenhum exercício removido e nenhum filtro removido (regras críticas do pedido).
2. Novos exercícios entram no fim de cada grupo do seed para minimizar o diff; a identidade estável é o `catalog_entry_key`, não o número E###.
3. Cardio de máquina novo (remo/stepper/air bike) ganhou **modos próprios no fluxo de cardio** em vez de ser escondido em HIIT.
4. Karate e Jiu-Jitsu ganharam **focos técnicos novos** (bases, bloqueios, esquivas, joelhadas, saco; rolamentos, breakfalls, inversões) para que os drills novos apareçam em filtros dedicados.
5. Drills marcados como exigindo material: Trabalho leve ao saco (saco de pancada), Breakfalls/Rolamentos/Granby (tatami ou tapete), foam roller/bola (equipamento de recuperação respetivo).
6. Auxiliares de mobilidade (vassoura, rolo, bola) contam como movimentos de peso corporal para efeitos de filtro, mas a disponibilidade continua a exigir o auxiliar.
7. Migração por upsert idempotente (`refreshCatalogExercises`) na versão 20 da base de dados: novos exercícios entram, textos atualizam, exercícios personalizados e histórico intocados.

## Limitações restantes

- As fichas de músculos principais usam as tags anatómicas internas (chaves em inglês) — são as usadas pelos filtros.
- O nível (iniciante/intermédio/avançado) continua a ser inferido por heurística no inventário; não é um campo do modelo de dados.
- "Casa equipada" nos relatórios significa "todas as chaves de equipamento selecionadas"; a disponibilidade real depende do que o utilizador marcar.

## Fichas completas dos 38 exercícios adicionados

### E005 — Isometria cervical posterior leve

- **Motivo da adição**: O catálogo tinha isometria frontal e lateral mas nenhum exercício para os extensores do pescoço.
- **Lacuna que resolve**: PES-02 extensão cervical (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Musculação
- **Grupo muscular**: Pescoço
- **Músculos principais (tags)**: posterior_neck, cervical_stabilizers
- **Músculos secundários**: Trapézio superior, escalenos e estabilizadores cervicais
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Musculação > neck > neck_complete | Musculação > neck > posterior_neck | Musculação > neck > cervical_stabilizers
- **Objetivo**: Pressão leve da cabeça para trás contra as próprias mãos, sem movimento, para fortalecer a parte de trás do pescoço. Serve para treinar extensores do pescoço e controlo cervical.
- **Execução**:
  - 1. Senta-te ou fica de pé com a coluna direita e o queixo ligeiramente recolhido.
  - 2. Entrelaça as mãos e coloca-as atrás da cabeça.
  - 3. Empurra a cabeça para trás contra as mãos com força muito leve, sem deixar a cabeça mover.
  - 4. Mantém a pressão 5 a 10 segundos a respirar normalmente.
  - 5. Solta devagar, descansa um momento e repete 3 a 5 vezes.
  - 6. Usa apenas a força que consegues manter sem tremer nem prender o ar.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E032 — Elevação no plano da omoplata

- **Motivo da adição**: Único músculo da coifa dos rotadores sem exercício dedicado.
- **Lacuna que resolve**: OMB-04 supraespinhoso (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Musculação
- **Grupo muscular**: Ombros
- **Músculos principais (tags)**: lateral_deltoid, deltoid_lateral, external_rotators, scapular_stabilizers
- **Músculos secundários**: Trapézio, serrátil anterior, manguito rotador e core
- **Equipamento**: Halteres
- **Locais**: Casa equipada | Ginásio
- **Filtros onde aparece**: Musculação > shoulders > shoulders_complete | Musculação > shoulders > lateral_deltoid | Musculação > shoulders > rotator_cuff | Musculação > shoulders > external_rotators | Musculação > shoulders > scapular_stability
- **Objetivo**: Elevação dos halteres na diagonal entre a frente e o lado do corpo, no plano natural da omoplata, mais confortável para o ombro. Serve para treinar deltóide lateral e supraespinhoso.
- **Execução**:
  - 1. Fica de pé e segura um halter leve em cada mão ao lado do corpo, com os polegares a apontar para a frente.
  - 2. Roda os braços cerca de 30 graus para a frente do corpo: é este o plano da omoplata.
  - 3. Eleva os dois braços nessa diagonal até à altura dos ombros, com os cotovelos quase esticados.
  - 4. Pausa um segundo em cima sem encolher os ombros.
  - 5. Baixa os halteres em dois a três segundos até ao lado do corpo.
  - 6. Termina a série antes de precisares de balançar o tronco.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E158 — Lenhador no cabo

- **Motivo da adição**: Não existia rotação do tronco em pé com carga no ginásio.
- **Lacuna que resolve**: COR-05 rotação com carga (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Musculação
- **Grupo muscular**: Core
- **Músculos principais (tags)**: external_obliques, internal_obliques, anti_rotation
- **Músculos secundários**: Oblíquos, glúteos, ombros e estabilidade da anca
- **Equipamento**: Cabo / polia
- **Locais**: Casa equipada | Ginásio
- **Filtros onde aparece**: Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > abdominal_zone > lateral_abs | Musculação > core > abdominal_zone > external_obliques | Musculação > core > abdominal_zone > internal_obliques | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_rotation
- **Objetivo**: Rotação do tronco em diagonal a puxar o cabo de cima para baixo com os braços quase esticados, para treinar os oblíquos com carga. Serve para treinar core, abdominal e estabilidade do tronco.
- **Execução**:
  - 1. Coloca a polia do cabo acima da altura do ombro e segura a pega com as duas mãos.
  - 2. Fica de lado para a máquina, pés à largura dos ombros e joelhos ligeiramente fletidos.
  - 3. Puxa a pega em diagonal, de cima para baixo, até à anca contrária, rodando tronco e anca juntos.
  - 4. Mantém os braços quase esticados: a força vem do tronco, não dos ombros.
  - 5. Regressa devagar pelo mesmo caminho, controlando a rotação.
  - 6. Completa as repetições de um lado antes de trocar.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E159 — Prancha com toque no ombro

- **Motivo da adição**: A anti-rotação dependia de cabo/elástico (pallof); faltava opção pura de peso corporal.
- **Lacuna que resolve**: COR-02 anti-rotação sem equipamento (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Musculação
- **Grupo muscular**: Core
- **Músculos principais (tags)**: anti_rotation, anti_extension, deep_stability
- **Músculos secundários**: Ombros, serrátil anterior, glúteos e estabilidade do punho
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Musculação > core > core_complete | Musculação > core > abdominal_zone | Musculação > core > abdominal_zone > abs_complete | Musculação > core > core_stability_zone | Musculação > core > core_stability_zone > anti_rotation | Musculação > core > core_stability_zone > anti_extension | Musculação > core > core_stability_zone > deep_stability
- **Objetivo**: Prancha alta em que tocas com uma mão no ombro oposto sem deixar a bacia rodar, para treinar o core contra a rotação.
- **Execução**:
  - 1. Começa em prancha alta, mãos debaixo dos ombros e pés um pouco mais afastados que a anca.
  - 2. Contrai abdómen e glúteos antes de mover as mãos.
  - 3. Levanta uma mão e toca no ombro oposto sem deixar a bacia rodar ou balançar.
  - 4. Pousa a mão devagar e repete com a outra, alternando.
  - 5. Faz o movimento lento: um toque a cada um a dois segundos.
  - 6. Termina a série quando a anca começar a rodar apesar do esforço.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E205 — Clamshell

- **Motivo da adição**: Zona pedida na checklist sem exercício de força; importante para joelho e anca saudáveis.
- **Lacuna que resolve**: GLU-03 rotadores externos da anca (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Musculação
- **Grupo muscular**: Pernas
- **Músculos principais (tags)**: abductors, glute_med, glute_min, hip_external_rotators
- **Músculos secundários**: Glúteo médio, glúteo mínimo, rotadores externos da anca e core lateral
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > glute_med | Musculação > legs > upper_leg_hip > glute_min | Musculação > legs > upper_leg_hip > abductors
- **Objetivo**: Abertura e fecho do joelho de cima, deitado de lado com os joelhos dobrados, para fortalecer o glúteo médio e os rotadores externos da anca.
- **Execução**:
  - 1. Deita-te de lado com os joelhos dobrados a cerca de 90 graus e os pés alinhados com as costas.
  - 2. Apoia a cabeça no braço de baixo e coloca a mão de cima na bacia para sentires se ela roda.
  - 3. Mantém os pés juntos e abre o joelho de cima como uma concha.
  - 4. Abre só até onde a bacia fica imóvel; deves sentir o lado do glúteo a trabalhar.
  - 5. Fecha devagar, em cerca de dois segundos, sem deixar os joelhos bater.
  - 6. Faz as repetições todas de um lado e depois vira-te para o outro.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E206 — Curl nórdico assistido

- **Motivo da adição**: Trabalho excêntrico de isquiotibiais sem máquina, com valor de prevenção de lesões.
- **Lacuna que resolve**: PER-04 flexão de joelho sem máquina (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Musculação
- **Grupo muscular**: Pernas
- **Músculos principais (tags)**: biceps_femoris, semitendinosus, semimembranosus
- **Músculos secundários**: Isquiotibiais, gémeos, glúteos e core
- **Equipamento**: Peso corporal, apoio para os pés
- **Locais**: Casa equipada | Ginásio
- **Filtros onde aparece**: Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > hamstrings_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > semitendinosus | Musculação > legs > upper_leg_hip > semimembranosus
- **Objetivo**: Descida lenta do tronco a partir dos joelhos, com os calcanhares presos e as mãos prontas para amparar, para trabalhar os isquiotibiais em travagem. Serve para treinar posterior de coxa em travagem, glúteos e core.
- **Execução**:
  - 1. Ajoelha-te num tapete e prende os calcanhares debaixo de um apoio firme, ou pede a alguém para os segurar.
  - 2. Fica direito dos joelhos à cabeça, com glúteos e abdómen contraídos.
  - 3. Deixa o tronco descer para a frente o mais devagar que conseguires, a travar com a parte de trás das coxas.
  - 4. Quando já não conseguires travar, ampara com as mãos no chão como numa flexão.
  - 5. Empurra com as mãos para voltar ao início e repete.
  - 6. Começa com 3 a 5 repetições; é normal descer pouco nas primeiras semanas.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E207 — Peso morto unilateral com halteres

- **Motivo da adição**: Não existia dobradiça de anca unilateral/equilíbrio no catálogo.
- **Lacuna que resolve**: PER-05 dobradiça unilateral (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Musculação
- **Grupo muscular**: Pernas
- **Músculos principais (tags)**: biceps_femoris, semitendinosus, semimembranosus, glute_max
- **Músculos secundários**: Glúteos, posterior de coxa, lombar, dorsais e pega
- **Equipamento**: Halteres
- **Locais**: Casa equipada | Ginásio
- **Filtros onde aparece**: Musculação > legs > legs_complete | Musculação > legs > upper_leg_hip | Musculação > legs > upper_leg_hip > thigh_complete | Musculação > legs > upper_leg_hip > hamstrings_complete | Musculação > legs > upper_leg_hip > biceps_femoris | Musculação > legs > upper_leg_hip > semitendinosus | Musculação > legs > upper_leg_hip > semimembranosus | Musculação > legs > upper_leg_hip > glute_max
- **Objetivo**: Dobradiça de anca sobre uma perna com o halter na mão oposta, para trabalhar isquiotibiais, glúteos e equilíbrio. Serve para treinar posterior de coxa, glúteos e equilíbrio.
- **Execução**:
  - 1. Fica de pé sobre uma perna e segura o halter na mão do lado contrário, à frente da coxa.
  - 2. Mantém o joelho de apoio ligeiramente fletido e fixa o olhar num ponto no chão.
  - 3. Dobra pela anca e deixa o halter descer rente à perna enquanto a perna livre estica para trás.
  - 4. Desce até sentires alongar a parte de trás da coxa, com as costas direitas e a bacia nivelada.
  - 5. Empurra o chão com o pé de apoio e volta a ficar direito, apertando o glúteo no topo.
  - 6. Faz todas as repetições de um lado antes de trocar de perna e de mão.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E257 — Remo ergómetro ritmo contínuo

- **Motivo da adição**: A app já listava o equipamento `rower` sem nenhum exercício que o usasse.
- **Lacuna que resolve**: CAR-05 remo ergómetro (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Cardio
- **Grupo muscular**: Cardio
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Pernas, costas, braços e core em sequência
- **Equipamento**: Remo ergómetro
- **Locais**: Casa equipada | Ginásio
- **Filtros onde aparece**: Cardio > rower | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- **Objetivo**: Remadas contínuas a ritmo confortável no remo ergómetro, com pernas, tronco e braços em sequência; cardio de impacto baixo para o corpo inteiro. Serve para treinar resistência cardiovascular com pernas, costas e braços.
- **Execução**:
  - 1. Ajusta o apoio dos pés e prende as tiras sobre o meio do peito do pé.
  - 2. Segura a pega com as duas mãos, braços esticados, costas direitas e lombar neutra.
  - 3. Empurra primeiro com as pernas, inclina o tronco ligeiramente atrás e puxa a pega até às costelas, com os cotovelos rentes e as escápulas a fechar.
  - 4. Regressa pela ordem inversa: braços esticam, tronco vai à frente, joelhos dobram.
  - 5. Mantém um ritmo confortável, em que consegues falar, durante 10 a 20 minutos.
  - 6. Termina com 2 a 3 minutos mais lentos para arrefecer.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E258 — Remo ergómetro intervalos

- **Motivo da adição**: Variante intervalada do remo, pedida na especificação de cardio.
- **Lacuna que resolve**: CAR-05 remo ergómetro (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Cardio
- **Grupo muscular**: Cardio
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Pernas, costas, braços e core em sequência
- **Equipamento**: Remo ergómetro
- **Locais**: Casa equipada | Ginásio
- **Filtros onde aparece**: Cardio > rower | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- **Objetivo**: Alternância entre remadas fortes e recuperação suave no remo ergómetro; cardio intervalado de impacto baixo. Serve para treinar resistência cardiovascular com pernas, costas e braços.
- **Execução**:
  - 1. Faz 3 a 5 minutos de remadas leves para aquecer, sempre na ordem pernas, tronco e braços, com a lombar neutra.
  - 2. Rema forte durante 30 a 60 segundos, a puxar a pega até às costelas com os cotovelos rentes ao tronco.
  - 3. Recupera 60 a 90 segundos a remar muito leve, num ritmo de recuperação.
  - 4. Repete o ciclo 4 a 8 vezes conforme o teu nível.
  - 5. Se as costas curvarem ou as escápulas encolherem, encurta o bloco forte em vez de continuares.
  - 6. Termina com 2 a 3 minutos leves.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E259 — Stepper / escadas ritmo contínuo

- **Motivo da adição**: Equipamento `stepper` existia sem exercícios.
- **Lacuna que resolve**: CAR-06 escadas/stepper (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Cardio
- **Grupo muscular**: Cardio
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Glúteos, quadríceps, gémeos e fôlego
- **Equipamento**: Stepper / escadas
- **Locais**: Casa equipada | Ginásio
- **Filtros onde aparece**: Cardio > stairs | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- **Objetivo**: Subida contínua de degraus no stepper a ritmo constante; cardio de impacto baixo focado em pernas e glúteos. Serve para treinar resistência cardiovascular e respiração.
- **Execução**:
  - 1. Sobe para o stepper e segura levemente os apoios, só para equilibrar.
  - 2. Coloca o pé inteiro em cada degrau, não só a ponta.
  - 3. Sobe a ritmo constante, empurrando com o calcanhar e o glúteo.
  - 4. Mantém o tronco direito, sem pendurares o corpo nos braços.
  - 5. Continua 10 a 20 minutos a um ritmo em que consegues falar.
  - 6. Abranda gradualmente nos últimos 2 minutos.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E260 — Stepper / escadas intervalos

- **Motivo da adição**: Variante intervalada do stepper.
- **Lacuna que resolve**: CAR-06 escadas/stepper (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Cardio
- **Grupo muscular**: Cardio
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Glúteos, quadríceps, gémeos e fôlego
- **Equipamento**: Stepper / escadas
- **Locais**: Casa equipada | Ginásio
- **Filtros onde aparece**: Cardio > stairs | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- **Objetivo**: Blocos rápidos e blocos lentos alternados no stepper; cardio intervalado de impacto baixo a médio para pernas e fôlego. Serve para treinar resistência cardiovascular e respiração.
- **Execução**:
  - 1. Aquece 3 a 5 minutos a ritmo lento no stepper.
  - 2. Sobe rápido durante 30 a 60 segundos, sem saltar degraus nem te pendurares nos apoios.
  - 3. Recupera 60 a 90 segundos a ritmo lento.
  - 4. Repete 4 a 8 ciclos conforme o fôlego.
  - 5. Coloca sempre o pé inteiro no degrau, mesmo nos blocos rápidos.
  - 6. Termina com 2 a 3 minutos lentos.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E261 — Subida de escadas no exterior

- **Motivo da adição**: Versão sem máquina do trabalho de escadas, pedida na especificação.
- **Lacuna que resolve**: CAR-06 escadas (exterior) (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Cardio
- **Grupo muscular**: Cardio
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Core, pernas, coordenação, respiração e sistema cardiovascular
- **Equipamento**: Espaço exterior com escadas
- **Locais**: Casa equipada | Exterior / parque
- **Filtros onde aparece**: Cardio > outdoor_run | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- **Objetivo**: Subir escadas reais a passo firme e descer devagar para recuperar; cardio de impacto médio para pernas e fôlego. Serve para treinar resistência cardiovascular e respiração.
- **Execução**:
  - 1. Escolhe escadas com corrimão e piso seguro.
  - 2. Sobe a passo firme e ritmo constante, apoiando o pé inteiro em cada degrau.
  - 3. Usa o corrimão apenas para equilibrar, não para puxar o corpo.
  - 4. Desce devagar: a descida é a tua recuperação.
  - 5. Repete subidas de 30 segundos a 2 minutos até somares 10 a 20 minutos.
  - 6. Pára se o passo começar a falhar ou os joelhos a ceder.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E262 — Air bike ritmo contínuo

- **Motivo da adição**: Equipamento `air_bike` existia sem exercícios.
- **Lacuna que resolve**: CAR-07 air bike (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Cardio
- **Grupo muscular**: Cardio
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Pernas, braços, ombros e fôlego
- **Equipamento**: Air bike
- **Locais**: Casa equipada | Ginásio
- **Filtros onde aparece**: Cardio > air_bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- **Objetivo**: Pedalar e empurrar o guiador da air bike a ritmo constante; cardio de impacto baixo que usa braços e pernas ao mesmo tempo. Serve para treinar resistência cardiovascular e respiração.
- **Execução**:
  - 1. Ajusta o selim para o joelho ficar ligeiramente fletido com o pedal em baixo.
  - 2. Pedala enquanto empurras e puxas o guiador ao ritmo das pernas.
  - 3. Mantém um ritmo constante, em que consegues falar, durante 10 a 20 minutos.
  - 4. Mantém o tronco estável; quem trabalha são os braços e as pernas.
  - 5. Não deixes os joelhos abrir para fora enquanto pedalas.
  - 6. Abranda gradualmente nos últimos 2 minutos.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E263 — Air bike intervalos

- **Motivo da adição**: Variante intervalada da air bike.
- **Lacuna que resolve**: CAR-07 air bike (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Cardio
- **Grupo muscular**: Cardio
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Pernas, braços, ombros e fôlego
- **Equipamento**: Air bike
- **Locais**: Casa equipada | Ginásio
- **Filtros onde aparece**: Cardio > air_bike | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- **Objetivo**: Sprints curtos e recuperações longas na air bike; cardio intervalado exigente e de impacto baixo. Serve para treinar resistência cardiovascular e respiração.
- **Execução**:
  - 1. Aquece 3 a 5 minutos a ritmo leve na air bike.
  - 2. Faz 15 a 30 segundos fortes, a empurrar o guiador e a pedalar com intenção.
  - 3. Recupera 60 a 90 segundos muito leve, sem parar de mexer.
  - 4. Repete 4 a 8 ciclos; a air bike é exigente, começa por menos.
  - 5. Mantém o tronco firme mesmo nos blocos fortes.
  - 6. Termina com 2 a 3 minutos leves.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E264 — Shadow boxing leve

- **Motivo da adição**: Pedido explícito da especificação: cardio de coordenação sem equipamento.
- **Lacuna que resolve**: CAR-10 shadow boxing (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Cardio
- **Grupo muscular**: Cardio
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Core, pernas, coordenação, respiração e sistema cardiovascular
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- **Objetivo**: Combinações leves de socos no ar com deslocamentos suaves; cardio de coordenação de impacto baixo a médio. Serve para treinar resistência cardiovascular e respiração.
- **Execução**:
  - 1. Fica em guarda: pé mais fraco à frente, mãos junto ao queixo, cotovelos fechados.
  - 2. Desloca-te devagar em passos curtos, sem cruzar os pés.
  - 3. Lança socos leves e soltos, voltando sempre com a mão à guarda.
  - 4. Roda ligeiramente a anca em cada soco em vez de esticares só o braço.
  - 5. Trabalha blocos de 1 a 2 minutos a ritmo leve, com 30 a 60 segundos de pausa, num total de 10 a 15 minutos.
  - 6. Mantém os socos leves: o objetivo é fôlego e coordenação, não força.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E265 — Shuttle runs / corrida vaivém

- **Motivo da adição**: Pedido explícito da especificação: mudança de direção e travagem.
- **Lacuna que resolve**: CAR-11 shuttle runs (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Cardio
- **Grupo muscular**: Cardio
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Core, pernas, coordenação, respiração e sistema cardiovascular
- **Equipamento**: Peso corporal, espaço livre
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Cardio > no_equipment | Cardio > hiit | Cardio > aerobic_endurance | Cardio > treadmill_intervals
- **Objetivo**: Corridas curtas de ida e volta entre duas marcas, com travagem e mudança de direção; cardio de impacto alto. Serve para treinar resistência cardiovascular e respiração.
- **Execução**:
  - 1. Marca duas linhas afastadas 5 a 10 metros num piso que não escorregue.
  - 2. Aquece 3 a 5 minutos com corrida leve e mobilidade de anca.
  - 3. Corre com velocidade controlada de uma marca à outra, trava, toca na linha com a mão e volta.
  - 4. Baixa a anca e dá passos curtos ao travar, para protegeres os joelhos.
  - 5. Faz séries de 20 a 40 segundos com pausas de 60 a 90 segundos, 4 a 8 séries.
  - 6. Encurta a distância se a travagem começar a falhar.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E277 — Treino de bases (dachi)

- **Motivo da adição**: Checklist de Karate: posições base (zenkutsu, kiba, kokutsu).
- **Lacuna que resolve**: KAR-04 bases (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Artes marciais
- **Grupo muscular**: Karate
- **Músculos principais (tags)**: karate_technical
- **Músculos secundários**: Base, anca, core, ombros, guarda e coordenação
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Artes marciais > karate > karate_complete | Artes marciais > karate > karate_stances
- **Objetivo**: Passagem lenta e controlada entre as posições base do Karate — zenkutsu, kiba e kokutsu dachi — mantendo a altura da bacia. Serve para treinar técnica de Karate, base e coordenação.
- **Execução**:
  - 1. Desce para zenkutsu-dachi: perna da frente dobrada, perna de trás esticada, tronco vertical.
  - 2. Segura a posição 10 a 20 segundos com o joelho da frente alinhado com o pé.
  - 3. Passa devagar para kiba-dachi: pés largos e paralelos, joelhos abertos, bacia baixa.
  - 4. Passa para kokutsu-dachi: peso atrás, pé da frente leve no chão.
  - 5. Alterna as três bases mantendo a bacia sempre à mesma altura.
  - 6. Faz 5 a 10 transições lentas por série; o objetivo é manter a bacia à mesma altura, com controlo total.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E278 — Bloqueios técnicos (uke)

- **Motivo da adição**: Checklist de Karate: age-uke, soto-uke e gedan-barai.
- **Lacuna que resolve**: KAR-09 bloqueios (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Artes marciais
- **Grupo muscular**: Karate
- **Músculos principais (tags)**: karate_technical
- **Músculos secundários**: Base, anca, core, ombros, guarda e coordenação
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Artes marciais > karate > karate_complete | Artes marciais > karate > karate_blocks
- **Objetivo**: Prática encadeada dos bloqueios fundamentais do Karate (age-uke, soto-uke e gedan-barai), com recolha forte do braço contrário. Serve para treinar técnica de Karate, base e coordenação.
- **Execução**:
  - 1. Fica numa base estável com um punho na anca e o outro braço à frente do corpo.
  - 2. Faz age-uke: o antebraço sobe em diagonal até acima da testa enquanto o punho contrário recolhe à anca.
  - 3. Faz soto-uke: o antebraço varre de fora para dentro até à linha do peito.
  - 4. Faz gedan-barai: o antebraço varre para baixo, protegendo o abdómen e a perna da frente.
  - 5. Coordena sempre a recolha forte do braço contrário: é ela que dá potência ao bloqueio.
  - 6. Repete cada bloqueio 8 a 12 vezes de cada lado; o objetivo é precisão com controlo, primeiro devagar e depois com ritmo.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E279 — Esquivas e tai-sabaki

- **Motivo da adição**: Checklist de Karate: saída da linha de ataque.
- **Lacuna que resolve**: KAR-10 esquivas (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Artes marciais
- **Grupo muscular**: Karate
- **Músculos principais (tags)**: karate_technical
- **Músculos secundários**: Base, anca, core, ombros, guarda e coordenação
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Artes marciais > karate > karate_complete | Artes marciais > karate > karate_evasions
- **Objetivo**: Deslocamentos do corpo para sair da linha de ataque — recuar, sair para o lado e rodar — mantendo a guarda alta. Serve para treinar técnica de Karate, base e coordenação.
- **Execução**:
  - 1. Começa em guarda, numa base estável, com os joelhos ligeiramente fletidos.
  - 2. Treina o recuo: desliza o pé de trás e afasta o tronco sem baixar as mãos.
  - 3. Treina a saída lateral: passo curto para o lado e roda a anca para ficares em ângulo.
  - 4. Treina o tai-sabaki: gira sobre a planta dos pés levando todo o corpo para fora da linha de ataque.
  - 5. Mantém a cabeça sempre ao mesmo nível; esquivar não é saltar nem baixar o olhar.
  - 6. Encadeia 8 a 12 esquivas de cada tipo; o objetivo é sair da linha com controlo, imaginando o ataque a que respondes.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E280 — Joelhadas técnicas

- **Motivo da adição**: Checklist de Karate: hiza-geri.
- **Lacuna que resolve**: KAR-11 joelhadas (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Artes marciais
- **Grupo muscular**: Karate
- **Músculos principais (tags)**: karate_technical
- **Músculos secundários**: Base, anca, core, ombros, guarda e coordenação
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Artes marciais > karate > karate_complete | Artes marciais > karate > karate_knees
- **Objetivo**: Elevação do joelho em linha ao alvo (hiza-geri), com a anca a avançar no final e as mãos a simular o controlo do adversário. Serve para treinar técnica de Karate, base e coordenação.
- **Execução**:
  - 1. Fica em guarda, com uma base firme e o peso ligeiramente na perna da frente.
  - 2. Puxa as mãos para baixo, como se controlasses o alvo à frente do peito.
  - 3. Sobe o joelho de trás em linha reta ao alvo, com a anca a avançar no final.
  - 4. Mantém o pé de apoio firme e o tronco ligeiramente atrás para equilibrar.
  - 5. Regressa à guarda pelo mesmo caminho, sem deixar o pé cair pesado.
  - 6. Faz 8 a 12 joelhadas por perna; o objetivo é subir o joelho com controlo, primeiro devagar e depois com ritmo.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E281 — Trabalho leve ao saco

- **Motivo da adição**: Drill ao saco marcado como tal: usa o equipamento `heavy_bag` já existente na app.
- **Lacuna que resolve**: KAR-13 trabalho ao saco (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Artes marciais
- **Grupo muscular**: Karate
- **Músculos principais (tags)**: karate_technical
- **Músculos secundários**: Base, anca, core, ombros, guarda e coordenação
- **Equipamento**: Saco de pancada
- **Locais**: Casa equipada | Dojo / tatami
- **Filtros onde aparece**: Artes marciais > karate > karate_complete | Artes marciais > karate > karate_bag
- **Objetivo**: Socos e pontapés leves e técnicos ao saco de pancada, com foco na distância e no alinhamento do punho, não na força. Serve para treinar técnica de Karate, base e coordenação.
- **Execução**:
  - 1. Fica em guarda, numa base estável, à distância a que o teu braço esticado toca no saco.
  - 2. Começa com socos diretos leves, tocando no saco com os dois primeiros nós dos dedos.
  - 3. Mantém o punho fechado e alinhado com o antebraço no contacto; se o punho dobrar, bate mais leve.
  - 4. Acrescenta pontapés leves com a canela ou o peito do pé, voltando sempre à guarda.
  - 5. Trabalha rondas de 1 a 2 minutos com 1 minuto de pausa, 4 a 6 rondas.
  - 6. É trabalho técnico: o objetivo é precisão e distância com controlo, não força máxima.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E293 — Rolamentos de solo

- **Motivo da adição**: Checklist de Jiu-Jitsu: rolls para a frente e para trás.
- **Lacuna que resolve**: JJ-05 rolamentos (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Artes marciais
- **Grupo muscular**: Jiu-Jitsu
- **Músculos principais (tags)**: jiu_jitsu_technical
- **Músculos secundários**: Core, anca, pescoço, pega, respiração e controlo no solo
- **Equipamento**: Tatami ou tapete / colchonete
- **Locais**: Casa equipada | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_rolls
- **Objetivo**: Rolamento para a frente e para trás sobre o ombro, com o corpo em bola, para aprenderes a cair e a levantar em segurança. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- **Execução**:
  - 1. Agacha-te no tatami, numa base compacta, com o queixo preso ao peito.
  - 2. Coloca as mãos no chão e empurra com as pernas, rolando sobre um ombro, nunca sobre a cabeça.
  - 3. Deixa as costas redondas passarem na diagonal, do ombro até à anca contrária.
  - 4. Termina agachado, pronto a levantar sem usar as mãos.
  - 5. Para o rolamento atrás, senta-te, rola para trás sobre o mesmo ombro e volta à posição agachada.
  - 6. Faz 4 a 6 rolamentos para cada lado, devagar e em piso acolchoado; o objetivo é um caminho redondo e sem impacto.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E294 — Breakfalls (ukemi)

- **Motivo da adição**: Checklist de Jiu-Jitsu: quedas amortecidas; marcado como exigindo tatami/colchão.
- **Lacuna que resolve**: JJ-06 breakfalls (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Artes marciais
- **Grupo muscular**: Jiu-Jitsu
- **Músculos principais (tags)**: jiu_jitsu_technical
- **Músculos secundários**: Core, anca, pescoço, pega, respiração e controlo no solo
- **Equipamento**: Tatami ou tapete / colchonete
- **Locais**: Casa equipada | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_breakfalls
- **Objetivo**: Quedas amortecidas para trás e para o lado, com o queixo preso ao peito e palmada firme no tatami no momento do impacto. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- **Execução**:
  - 1. Começa deitado de costas com o queixo preso ao peito, para aprenderes a posição final.
  - 2. Bate com as palmas e os antebraços no tatami, com os braços a cerca de 45 graus do corpo.
  - 3. Passa a treinar de cócoras: deixa-te cair para trás e bate com os braços no chão no momento do impacto.
  - 4. Para a queda lateral, desliza uma perna e cai sobre o lado, batendo com o braço desse lado.
  - 5. Nunca aterres sobre o cotovelo nem deixes a cabeça tocar no tatami.
  - 6. Faz 5 a 10 quedas de cada tipo e sobe a altura só quando dominares; o objetivo técnico é proteger sempre a cabeça.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E295 — Inversão granby com apoio

- **Motivo da adição**: Checklist de Jiu-Jitsu: inversões com regressão apoiada.
- **Lacuna que resolve**: JJ-07 inversões (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Artes marciais
- **Grupo muscular**: Jiu-Jitsu
- **Músculos principais (tags)**: jiu_jitsu_technical
- **Músculos secundários**: Core, anca, pescoço, pega, respiração e controlo no solo
- **Equipamento**: Tatami ou tapete / colchonete
- **Locais**: Casa equipada | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Artes marciais > jiu_jitsu > jiu_jitsu_complete | Artes marciais > jiu_jitsu > jiu_jitsu_inversions
- **Objetivo**: Inversão sobre a linha dos ombros, a rolar de um lado para o outro com apoio das mãos, para treinar a rotação de guarda invertida. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- **Execução**:
  - 1. Começa de joelhos com as mãos no tatami e o queixo preso ao peito.
  - 2. Apoia o peso nos ombros e nas mãos, nunca no topo da cabeça.
  - 3. Rola sobre a linha dos ombros levando as pernas por cima do corpo para um dos lados.
  - 4. Usa as mãos no chão para travar e guiar a rotação.
  - 5. Termina sentado ou de joelhos, virado para o lado contrário.
  - 6. Faz 3 a 5 inversões para cada lado, muito devagar; o objetivo técnico é rodar sobre os ombros, e pára se o pescoço carregar peso.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E340 — Alongamento PNF de isquiotibiais

- **Motivo da adição**: Não existia nenhum alongamento contrai-relaxa no catálogo.
- **Lacuna que resolve**: ELA-03 PNF (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Elasticidade
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: respiração, postura, controlo articular e consciência corporal
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > hamstring_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- **Objetivo**: Alongamento contrai-relaxa: empurras a perna contra as mãos durante alguns segundos, soltas e ganhas amplitude nova no posterior da coxa. Serve para treinar flexibilidade do posterior de coxa.
- **Execução**:
  - 1. Deita-te de costas e eleva uma perna quase esticada, segurando atrás da coxa com as mãos ou com uma toalha.
  - 2. Puxa suavemente até sentires alongar a parte de trás da coxa e mantém 10 segundos.
  - 3. Empurra a perna contra as mãos, como se a quisesses baixar, com força moderada durante 5 a 6 segundos.
  - 4. Solta a contração, expira e puxa a perna um pouco mais perto de ti.
  - 5. Repete o ciclo contrai-relaxa 2 a 3 vezes por perna.
  - 6. Mantém a outra perna e a lombar em contacto com o chão todo o tempo.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E341 — Alongamento PNF de peitoral na parede

- **Motivo da adição**: PNF de membro superior, complementa o de isquiotibiais.
- **Lacuna que resolve**: ELA-03 PNF (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Elasticidade
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: escápulas, coluna torácica, peitoral, dorsal e respiração
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > chest_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- **Objetivo**: Alongamento contrai-relaxa do peito: pressionas o antebraço contra a parede, soltas e rodas o tronco um pouco mais. Serve para treinar flexibilidade do peito e do ombro.
- **Execução**:
  - 1. Coloca o antebraço na parede com o cotovelo à altura do ombro.
  - 2. Roda o tronco para o lado contrário até sentires alongar o peito e mantém 10 segundos.
  - 3. Empurra o antebraço contra a parede com força moderada durante 5 a 6 segundos, sem mover o corpo.
  - 4. Solta, expira e roda o tronco um pouco mais.
  - 5. Repete o ciclo 2 a 3 vezes e troca de braço.
  - 6. Mantém os ombros afastados das orelhas durante todo o alongamento.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E342 — Alongamento de flexores da anca em afundo

- **Motivo da adição**: Zona muito treinada (agachamentos, corrida) sem alongamento dedicado.
- **Lacuna que resolve**: MOB-07 flexores da anca (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Mobilidade
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: respiração, postura, controlo articular e consciência corporal
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > hip_mobility | Mobilidade > quadriceps_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- **Objetivo**: Alongamento em afundo com o joelho de trás no chão, levando a bacia à frente para alongar a frente da anca. Serve para treinar mobilidade da frente da anca.
- **Execução**:
  - 1. Ajoelha-te sobre um tapete com um joelho no chão e o outro pé à frente, em afundo.
  - 2. Aperta o glúteo da perna de trás e encolhe ligeiramente a barriga.
  - 3. Leva a bacia para a frente sem deixares a lombar arquear.
  - 4. Sente o alongamento na frente da anca e da coxa da perna de trás.
  - 5. Mantém 20 a 40 segundos a respirar devagar e troca de lado.
  - 6. Para aumentar, eleva o braço do lado do joelho apoiado em direção ao teto.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E343 — Alongamento borboleta de adutores

- **Motivo da adição**: Adutores treinados em força (sumo, Copenhagen) sem alongamento dedicado.
- **Lacuna que resolve**: MOB-08 adutores (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Mobilidade
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: respiração, postura, controlo articular e consciência corporal
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > hip_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- **Objetivo**: Alongamento sentado com as plantas dos pés unidas, deixando os joelhos descer para alongar adutores e virilha. Serve para treinar mobilidade dos adutores e da anca.
- **Execução**:
  - 1. Senta-te no chão com as plantas dos pés unidas e os calcanhares perto da bacia.
  - 2. Segura os pés com as mãos e cresce com a coluna.
  - 3. Deixa os joelhos descer para os lados apenas com o peso das pernas.
  - 4. Para aprofundar, inclina o tronco à frente a partir da anca, sem curvares as costas.
  - 5. Mantém 20 a 40 segundos a respirar devagar.
  - 6. Não empurres os joelhos para baixo com as mãos; deixa o peso fazer o trabalho.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E344 — Alongamento dinâmico global

- **Motivo da adição**: Sequência de aquecimento completa (anca, coluna, isquiotibiais) em falta.
- **Lacuna que resolve**: MOB-13 global dinâmico (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Mobilidade
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: respiração, postura, controlo articular e consciência corporal
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > thoracic_mobility | Mobilidade > hip_mobility | Mobilidade > hamstring_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- **Objetivo**: Sequência dinâmica que liga afundo, rotação do tronco e dobradiça, mobilizando anca, coluna e isquiotibiais num só movimento. Serve para treinar mobilidade geral de anca, coluna e ombros.
- **Execução**:
  - 1. Começa de pé, dá um passo largo à frente e desce em afundo, com as mãos no chão por dentro do pé da frente.
  - 2. Empurra o joelho da frente ligeiramente para fora com o cotovelo.
  - 3. Roda o tronco e estica o braço do lado da perna da frente em direção ao teto, seguindo a mão com o olhar.
  - 4. Volta com a mão ao chão, estica a perna da frente e puxa a ponta do pé para ti.
  - 5. Regressa ao afundo e troca de perna.
  - 6. Faz 4 a 6 repetições lentas por lado, a respirar devagar, como aquecimento.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E345 — Alongamento de tríceps atrás da cabeça

- **Motivo da adição**: Tríceps com 20 exercícios de força e nenhum alongamento.
- **Lacuna que resolve**: ELA-04 tríceps/ombro (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Elasticidade
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Ombros e peito como apoio, com estabilização do tronco
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > shoulder_mobility | Recuperação > light_mobility | Recuperação > light_stretching
- **Objetivo**: Alongamento do braço dobrado atrás da cabeça, com a outra mão a puxar suavemente o cotovelo, para soltar tríceps e ombro.
- **Execução**:
  - 1. De pé ou sentado, sobe um braço e dobra o cotovelo, deixando a mão cair atrás da cabeça.
  - 2. Com a outra mão, segura o cotovelo por cima da cabeça.
  - 3. Puxa suavemente o cotovelo para trás e para o centro até sentires alongar a parte de trás do braço.
  - 4. Mantém a cabeça direita; não deixes o pescoço ir à frente.
  - 5. Segura 20 a 30 segundos a respirar devagar e troca de braço.
  - 6. Para aprofundar, inclina ligeiramente o tronco para o lado contrário.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E346 — Cobra suave no chão

- **Motivo da adição**: Toda a mobilidade de coluna era em flexão/rotação; faltava extensão suave.
- **Lacuna que resolve**: MOB-05 extensão de coluna (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Mobilidade
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: respiração, postura, controlo articular e consciência corporal
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > back_mobility | Mobilidade > thoracic_mobility | Recuperação > light_mobility
- **Objetivo**: Extensão suave da coluna deitado de barriga para baixo, subindo o peito com o apoio dos antebraços sem forçar a lombar. Serve para treinar mobilidade de extensão da coluna.
- **Execução**:
  - 1. Deita-te de barriga para baixo, pernas relaxadas e testa no chão.
  - 2. Apoia os antebraços no chão com os cotovelos debaixo dos ombros.
  - 3. Empurra o chão e levanta o peito devagar, deixando a bacia apoiada.
  - 4. Mantém os glúteos descontraídos e o pescoço comprido, com o olhar em frente.
  - 5. Segura 10 a 20 segundos a respirar devagar e desce com controlo.
  - 6. Se sentires aperto na lombar, sobe menos ou leva os cotovelos mais à frente.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E347 — Respiração nasal lenta

- **Motivo da adição**: Pedido explícito da especificação de recuperação.
- **Lacuna que resolve**: REC-02 respiração nasal (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Recuperação
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Diafragma, músculos respiratórios e sistema nervoso calmo
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > breathing | Recuperação > active_recovery
- **Objetivo**: Respiração calma feita só pelo nariz, com expiração mais longa do que a inspiração, para baixar o ritmo e recuperar. Serve para treinar recuperação e controlo da respiração.
- **Execução**:
  - 1. Senta-te ou deita-te confortável com uma mão na barriga.
  - 2. Fecha a boca e inspira pelo nariz durante cerca de 4 segundos, deixando a barriga crescer.
  - 3. Expira pelo nariz durante 6 a 8 segundos, mais longo do que inspiraste, deixando a barriga descer.
  - 4. Faz uma pausa natural de 1 a 2 segundos antes da próxima inspiração.
  - 5. Continua 3 a 5 minutos, mantendo os ombros descontraídos.
  - 6. Se faltar o ar, encurta os tempos: o ritmo deve ser confortável.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E348 — Foam roller para pernas

- **Motivo da adição**: Equipamento `foam_roller` existia na app sem exercícios.
- **Lacuna que resolve**: REC-03 libertação miofascial (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Recuperação
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Quadríceps, parte de trás das coxas e gémeos
- **Equipamento**: Rolo de espuma (foam roller)
- **Locais**: Casa equipada
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > hamstring_mobility | Mobilidade > quadriceps_mobility | Mobilidade > calf_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > active_recovery
- **Objetivo**: Rolar devagar quadríceps, posteriores da coxa e gémeos sobre o rolo de espuma, parando alguns segundos nos pontos mais sensíveis. Serve para treinar recuperação muscular das pernas.
- **Execução**:
  - 1. Senta-te no chão e coloca o rolo debaixo dos gémeos.
  - 2. Com as mãos atrás a apoiar, rola devagar, subindo e descendo do tornozelo ao joelho, durante 30 a 60 segundos.
  - 3. Passa para a parte de trás das coxas e depois vira-te de barriga para baixo para os quadríceps.
  - 4. Quando encontrares um ponto sensível, pára em cima 10 a 20 segundos a respirar devagar.
  - 5. Evita rolar diretamente sobre o joelho e sobre zonas com dor aguda.
  - 6. Termina quando a zona estiver mais solta; a pressão deve ser desconfortável mas suportável, usando os braços para aliviar peso.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E349 — Foam roller para costas

- **Motivo da adição**: Zona dorsal com rolo, com exclusões de segurança (lombar e pescoço).
- **Lacuna que resolve**: REC-04 libertação miofascial (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Recuperação
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Coluna torácica e músculos das costas
- **Equipamento**: Rolo de espuma (foam roller)
- **Locais**: Casa equipada
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > back_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > active_recovery
- **Objetivo**: Rolar a parte média e alta das costas sobre o rolo, com os braços cruzados e a bacia levantada, evitando a lombar e o pescoço. Serve para treinar recuperação da zona média e alta das costas.
- **Execução**:
  - 1. Deita-te de costas com o rolo atravessado debaixo das omoplatas e os joelhos dobrados.
  - 2. Cruza os braços sobre o peito para afastares as omoplatas.
  - 3. Levanta a bacia do chão e rola devagar entre a base do pescoço e o meio das costas.
  - 4. Pára 10 a 20 segundos nas zonas mais tensas, a respirar devagar.
  - 5. Não roles a lombar nem o pescoço com o rolo.
  - 6. Fica 1 a 2 minutos no total e levanta-te devagar.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E350 — Bola de massagem para pés e glúteos

- **Motivo da adição**: Equipamento `massage_ball` existia sem exercícios.
- **Lacuna que resolve**: REC-05 libertação miofascial (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Recuperação
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: Planta do pé, glúteos e mobilidade geral
- **Equipamento**: Bola de massagem
- **Locais**: Casa equipada
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > glute_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > active_recovery
- **Objetivo**: Pressão lenta da planta do pé e do glúteo sobre uma bola de massagem, à procura de pontos tensos para soltar. Serve para treinar recuperação dos pés e dos glúteos.
- **Execução**:
  - 1. De pé, com uma mão apoiada na parede, coloca a bola debaixo da planta do pé.
  - 2. Rola devagar do calcanhar aos dedos, empurrando com o peso do corpo, durante 30 a 60 segundos.
  - 3. Pára 10 a 20 segundos nos pontos mais sensíveis.
  - 4. Para o glúteo, senta-te no chão com a bola debaixo de uma nádega e as mãos atrás a apoiar.
  - 5. Rola devagar em pequenos círculos e evita pressionar zonas com formigueiro ou dormência.
  - 6. Troca de lado quando a zona se sentir mais solta.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E351 — Arrefecimento pós-treino de força

- **Motivo da adição**: Só existiam cooldowns de máquinas de cardio; faltava rotina pós-força.
- **Lacuna que resolve**: REC-08 arrefecimento por modalidade (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Recuperação
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: respiração, postura, controlo articular e consciência corporal
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > active_recovery
- **Objetivo**: Rotina de fim de treino de força: caminhada muito leve, respiração calma e alongamentos suaves dos músculos trabalhados. Serve para treinar recuperação depois do treino.
- **Execução**:
  - 1. Começa por caminhar 3 a 5 minutos a passo lento até o coração acalmar.
  - 2. Faz 5 respirações lentas: inspira pelo nariz e expira comprido pela boca.
  - 3. Alonga suavemente os músculos que treinaste, 20 a 30 segundos por zona, sem dor.
  - 4. Se o treino foi de corpo inteiro, inclui pelo menos peito, costas, anca e pernas.
  - 5. Solta os ombros e o pescoço com círculos lentos.
  - 6. Termina quando a respiração estiver de novo normal.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E352 — Arrefecimento pós-artes marciais

- **Motivo da adição**: Rotina de arrefecimento específica de artes marciais em falta.
- **Lacuna que resolve**: REC-09 arrefecimento por modalidade (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Recuperação
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: respiração, postura, controlo articular e consciência corporal
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Recuperação > easy_walk | Recuperação > light_mobility | Recuperação > active_recovery
- **Objetivo**: Rotina de fim de treino de artes marciais: marcha lenta, círculos de ombros e anca e alongamentos leves de pernas e costas. Serve para treinar recuperação depois do treino.
- **Execução**:
  - 1. Caminha em marcha lenta 2 a 3 minutos a soltar os braços.
  - 2. Faz círculos lentos de ombros, anca e pescoço.
  - 3. Alonga a anca em afundo suave, 20 a 30 segundos por lado.
  - 4. Alonga a parte de trás das coxas e os adutores sentado, sem forçar.
  - 5. Termina com 5 respirações nasais lentas, com a expiração comprida.
  - 6. Aproveita para notar zonas doridas: são as primeiras a cuidar no próximo treino.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

### E353 — Aquecimento dinâmico geral

- **Motivo da adição**: Rotina guiada de aquecimento sem equipamento em falta.
- **Lacuna que resolve**: AQU-02 aquecimento geral (ver `exercise_catalog_gap_analysis.md`)
- **Área**: Aquecimento
- **Grupo muscular**: Mobilidade
- **Músculos principais (tags)**: (zona de mobilidade/recuperação)
- **Músculos secundários**: respiração, postura, controlo articular e consciência corporal
- **Equipamento**: Peso corporal
- **Locais**: Casa sem equipamento | Casa equipada | Exterior / parque | Dojo / tatami | Ginásio
- **Filtros onde aparece**: Mobilidade > general_mobility | Mobilidade > shoulder_mobility | Mobilidade > hip_mobility | Recuperação > light_mobility
- **Objetivo**: Rotina de aquecimento sem equipamento que mobiliza as articulações de cima para baixo e termina com movimentos que elevam o pulso. Serve para treinar preparação do corpo para o treino.
- **Execução**:
  - 1. Marcha no lugar ou caminha 2 minutos para começares a aquecer.
  - 2. Faz 10 círculos de ombros para trás e 10 para a frente.
  - 3. Faz 10 círculos de anca para cada lado e 10 balanços de perna controlados por perna.
  - 4. Faz 10 agachamentos leves sem carga e 10 afundos curtos alternados.
  - 5. Termina com 20 a 30 segundos de polichinelos ou marcha rápida para elevar o pulso.
  - 6. Ajusta o volume: deves acabar quente e pronto para treinar, não cansado.
- **Testes que validam este exercício**: `test/v092_catalog_expansion_test.dart` (testes 01-28, incl. presença em filtros, locais e "mostrar todos"), `test/catalog/*` (quality gates de pedagogia, família de movimento, equipamento e segurança), `test/v091_content_review_test.dart` (modelo canónico), `test/v091_migration_test.dart` + testes 25-26 (seeds/migração).

