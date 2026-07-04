# Relatório de revisão das descrições (v0.9.2)

Confirmação da FASE 11: as descrições foram revistas uma a uma. Este
relatório cobre o delta da expansão v0.9.2; a reescrita integral dos 315
exercícios pré-existentes para o modelo canónico foi feita e documentada na
revisão v0.9.1 (`docs/audits/exercise_content_rewrite_report.md`) e foi
**re-auditada** nesta fase pelo inventário FASE 1.

## Totais

- Total de exercícios antes: 315
- Total de exercícios depois: 353
- Total de exercícios analisados (um a um, via inventário + quality gates): **353**
- Total de exercícios com descrição escrita de raiz nesta fase: **38** (todos os novos)
- Total de exercícios corrigidos nesta fase: **51** com texto alterado (47 com frases-muleta + Prancha lateral + Face pull com elástico + Rotação externa da anca no chão + drills de Jiu-Jitsu com equipamento normalizado)
- Exercícios com placeholders, frases proibidas ou descrição genérica após a revisão: **0** (secções "Problemas detetados" do inventário FASE 1 e quality gates)

## Modelo canónico aplicado (igual ao v0.9.1)

- Objetivo: 1-2 frases, 60-280 caracteres, específico do movimento.
- Execução: 4-7 passos numerados em lista vertical, ≤180 caracteres por passo,
  com posição inicial, trajetória, respiração e fim/retorno.
- Erros comuns: 3-5 itens em lista.
- Regressão e progressão concretas (sem prefixos genéricos).
- Segurança com sinais de paragem; dicas de respiração/postura/adaptação.
- Frases proibidas banidas (lista v0.9.1 + "conforme a variação",
  "indicada pela variação", "variação escolhida").

## Descrições escritas de raiz (38)

Cada exercício novo tem objetivo, passos, erros comuns, regressão,
progressão e músculos-alvo escritos individualmente (nenhum texto de
template). As fichas completas, com o texto final de objetivo e execução,
estão em `exercise_catalog_expansion_report.md`. Destaques de escrita:

- **Curl nórdico assistido** ensina a travagem excêntrica e o amparo com as
  mãos; regressão limita a amplitude, progressão reduz a ajuda.
- **Breakfalls (ukemi)** progride de deitado → cócoras → queda, com regra
  explícita de proteger a cabeça e nunca aterrar no cotovelo.
- **Alongamentos PNF** explicam o ciclo contrai-relaxa com tempos (10 s de
  alongamento, 5-6 s de contração moderada, 2-3 ciclos).
- **Foam roller / bola de massagem** definem zonas proibidas (lombar,
  pescoço, osso) e o tempo por zona.
- **Cardio novo** indica sempre ritmo/intensidade, duração e o nível de
  impacto no objetivo (baixo/médio/alto).
- **Drills marciais** indicam base, objetivo técnico e material necessário
  (saco, tatami) quando aplicável.

## Correções a textos existentes (51)

1. Frases-muleta removidas de 47 exercícios e substituídas por instrução
   concreta (listados no inventário FASE 1 pré-correção): Elevação
   posterior, Reverse fly, Prancha, Prancha lateral, Agachamento com peso
   corporal/halteres ao lado/barra/mochila/garrafão, Lunges (todas as
   variantes), Walking lunges, Circuito cardio peso corporal, Caminhada e
   Corrida exterior (9 entradas), HIIT (4 entradas), Circuito cardio leve,
   Alongamentos de posterior (7), glúteos (6), quadríceps (2), gémeos (2) e
   punhos (3).
2. **Prancha lateral**: passos próprios (deixou de "olhar para o chão"
   deitada de lado) e erros comuns específicos.
3. **Face pull com elástico**: passos dependem do equipamento; deixou de
   mandar usar a polia do cabo.
4. **Rotação externa da anca no chão**: equipamento e músculos secundários
   corrigidos (era tratada como rotação externa de ombro com elástico).
5. **Drills de Jiu-Jitsu**: texto de equipamento normalizado (solo pede
   tatami/tapete; mobilidade/pega/core/condicionamento em qualquer piso).

## Validação (quality gates e testes)

- `test/v092_catalog_expansion_test.dart` — testes 05-14 (objetivo, execução,
  passos, comprimentos, placeholders, frases proibidas, linguagem de
  carga/equipamento) sobre os 353.
- `test/v091_content_review_test.dart` — modelo canónico completo.
- `test/catalog/exercise_pedagogy_quality_test.dart` — posição inicial,
  trajetória, respiração, retorno e sinais de paragem em todas as entradas.
- `test/catalog/movement_family_requirements_test.dart` — cues por família
  (novas exclusões: curl nórdico não é curl de bíceps; alongamento de
  tríceps não é extensão com carga).
- `test/catalog/equipment_description_consistency_test.dart` — linguagem de
  equipamento coerente com o metadado.
- `test/v0714_template_and_hierarchy_test.dart` — limites de similaridade
  entre textos.

## Lacunas resolvidas / para revisão humana

- Resolvidas: todas as pendências de texto identificadas na FASE 1
  (0 problemas em todas as categorias do inventário final).
- Para revisão humana: nomes de exercícios mantêm termos técnicos
  estabelecidos (dachi, ukemi, granby, PNF); as descrições explicam-nos, mas
  um glossário na app poderia ajudar principiantes.

## Decisões tomadas

- As descrições dos 315 exercícios v0.9.1 não foram reescritas do zero uma
  segunda vez: já cumpriam o modelo canónico (validado pelo inventário e
  pelos testes); foram corrigidos os 51 textos com problemas reais.
- Textos de segurança das novas subfamílias (PNF, libertação miofascial,
  respiração/arrefecimento, alongamentos novos) foram separados do texto
  genérico de mobilidade para respeitar o limite de reutilização (≤45).

## Limitações restantes

- Dicas de respiração/postura/adaptação continuam parcialmente partilhadas
  por família de movimento (dentro dos limites dos quality gates).
- O inventário classifica o nível por heurística; não substitui prescrição
  individual.
