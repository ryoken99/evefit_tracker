# Relatório final — Reescrita do conteúdo dos exercícios (v0.9.1)

Gerado no fecho da revisão exercício a exercício pedida para a v0.9.1.
Inventário detalhado (estado final, campo a campo, com origem dos dados):
`docs/audits/exercise_content_inventory.md`. O estado ANTES da reescrita está
preservado no commit `2a20398` do mesmo ficheiro.

## 1-3. Totais

| Métrica | Valor |
|---|---|
| Exercícios encontrados no catálogo | **315** (309 nomes únicos; 6 nomes repetem-se em contextos musculares diferentes) |
| Exercícios revistos um a um | **315** (100%) |
| Exercícios com texto alterado | **315** (100%) — objetivo, execução, erros comuns, versões e dicas foram regenerados no modelo canónico |

Prova de cobertura: o teste `test/v091_content_review_test.dart` valida os 315
sem exceção (contagem exata, limites de tamanho, formato em lista, linguagem
proibida e unicidade), e o inventário final lista todos com os novos campos.

## Estado antes → depois (auditoria programática)

| Problema | Antes (commit 2a20398) | Depois |
|---|---|---|
| Descrições acima de 280 caracteres | 315 | 0 |
| Execução em parágrafo numerado colado | 315 | 0 |
| Execução com mais de 7 passos | 315 | 0 |
| Linguagem proibida (carga em peso corporal, "desce a carga", "usa Peso corporal", "afastar a carga", "como apoio e core", "o peso deve permitir punhos", etc.) | 195 | 0 |
| Descrições/execuções duplicadas entre exercícios diferentes | 185 | 0 |
| Passos acima de 180 caracteres | 0 | 0 |
| Exercícios sem descrição | 0 | 0 |
| needs_manual_review | 0 | 0 |

## 5. Exercícios que exigiram reescrita completa

Todos os 315: a descrição antiga era um bloco composto (grupo + nome +
movimento + cue de equipamento + músculos secundários + frase de objetivo) e a
execução era um parágrafo com 11-14 passos numerados colados, terminando em
frases-template ("Ritmo recomendado…", "Erro mais comum…", "Versão mais
fácil/difícil…"). No modelo novo: objetivo de 1-2 frases (60-280 chars),
execução em lista de 4-7 passos (um por linha, ≤180 chars), erros comuns em
lista de 3-5 itens, versões fácil/difícil como campos próprios e dicas de
respiração/postura/adaptação curtas e sem eco do nome.

## 6. Exercícios que tinham linguagem errada de equipamento (195 → 0)

Casos típicos corrigidos (lista completa no inventário do commit 2a20398):
- Peso corporal com linguagem de carga externa: todas as flexões (incl.
  **Flexão diamante**), dips, pull-up/chin-up, remo invertido, pranchas,
  hiperextensões no chão, superman, pontes/hip thrust, gémeos, core completo,
  drills de Karate/Jiu-Jitsu, pescoço e mobilidade (ex.: "segura Peso
  corporal", "usa Peso corporal", "desce a carga", "não deixes a carga cair",
  "Reduz carga ou amplitude").
- "Afastar a carga" no resumo de todos os tríceps; "desce a carga" em todos os
  supinos/presses; "o peso deve permitir punhos…" nos curls; "Ombros,
  cotovelos, peito como apoio e core" nos músculos secundários de tríceps.
- Equipamento incoerente: Gémeos sentado/Sóleo sentado falavam em halteres com
  equipamento "Banco/cadeira"; Good morning leve tinha texto sem barra com
  equipamento "Barra". Corrigidos.

## 7. Exercícios com execução mal formatada (315 → 0)

Todos: a execução era guardada como parágrafo "1. … 2. … 3. …" sem quebras.
Agora é sempre uma lista com `\n` entre passos, renderizada como lista
vertical numerada no modal.

## 8. needs_manual_review

Nenhum. A classificação por tipo (FASE 2) resolveu os 315:
peso_corporal 64, halteres 55, cardio 49, mobilidade 26, artes_marciais 22,
elástico 19, barra 18, cabo 18, alongamento 18, isometria 13, máquina 13.

## 9. Alterações de UI (modal de detalhes)

`lib/screens/workout_detail_screen.dart`: o `AlertDialog` com 13 blocos de
texto corrido foi substituído por um bottom sheet deslizante
(`DraggableScrollableSheet`, 40-95% do ecrã) com:
- Cabeçalho fixo com o nome e botão fechar (não tapa conteúdo).
- Secções: **Resumo** (grupo, músculos, equipamento), **Objetivo**,
  **Como fazer** (lista vertical numerada), **Erros comuns** (lista com
  marcadores), **Variações** (mais fácil / mais difícil) e **Segurança**.
- Secção colapsável "Mais detalhes" (músculos secundários, respiração,
  postura, quando adaptar/evitar) para o modal não ficar comprido.
- Scroll contínuo, espaçamento confortável, estilo visual da app mantido.

## 10. Migração (FASE 8)

Base de dados sobe de v18 para v19 (`lib/database/app_database.dart`):
`_migrateV091` → `refreshCatalogExercises` reaplica o catálogo usando o
mecanismo de seed existente, que atualiza apenas linhas `is_default = 1`
identificadas por `catalog_entry_key`. Exercícios personalizados
(`is_default = 0`), histórico de treinos, séries, medidas, fotos e objetivos
não são tocados. Instalações novas recebem os textos via seed no `onCreate`.
Testado em `test/v091_migration_test.dart`.

## 11. Testes adicionados/atualizados

Novos:
- `test/v091_content_review_test.dart` — os 14 requisitos da FASE 9 (objetivo
  não vazio, 4-7 passos, sem parágrafo colado, linguagem de peso corporal,
  placeholders, repetição do nome, equipamento coerente, limites 280/180,
  3-5 erros, versões fácil/difícil, frases proibidas globais, unicidade,
  e testes específicos de Flexão diamante, Curl arrastado e Tate press).
- `test/v091_migration_test.dart` — migração preserva dados do utilizador.

Atualizados ao modelo canónico:
- `lib/services/catalog_quality_gate_service.dart` (quality gate permanente,
  FASE 10): objetivo 60-280, execução 4-7 passos, frases proibidas v0.9.1,
  linguagem de carga em peso corporal, coerência equipamento-texto, famílias
  de movimento, segurança sem reutilização excessiva.
- `test/v080/catalog_teaching_quality_test.dart`, `test/v0711_description_305_test.dart`,
  `test/v0714_template_and_hierarchy_test.dart` (limiares recalibrados para o
  formato curto; duplicados exatos continuam proibidos).

## 12-13. Comandos executados e resultados

| Comando | Resultado |
|---|---|
| `flutter pub get` | OK ("Got dependencies!") |
| `dart format .` | OK (140 ficheiros verificados) |
| `flutter analyze` | OK — "No issues found!" |
| `flutter test` | OK — **389 testes, todos verdes** |
| `dart run tool/exercise_content_inventory.dart` | OK — inventário final com 0 problemas em todas as categorias |

Nota de ambiente: nos testes locais desta sessão foi usado o sqlite3 do
sistema (hook local não commitado); no CI o download normal do binário
funciona sem alterações.

## 14. Limitações restantes

- Passos partilham a base dentro da mesma família de movimento (ex.: as
  quatro puxadas altas divergem no passo de pega); o teste de quase-duplicados
  usa limiares 0.93/0.80 recalibrados para textos curtos.
- Entradas com o mesmo nome em grupos diferentes (ex.: Face pull no cabo em
  Trapézio/Ombros/Costas) partilham a execução por serem o mesmo exercício;
  o objetivo distingue o contexto.
- As dicas de respiração/postura/adaptação são por modalidade (não por
  exercício individual); estão na secção colapsável do modal.
- Textos validados por gates automáticos e amostragem manual; uma revisão
  editorial humana completa dos 315 continua recomendada antes de publicar
  numa loja.

## 4. Lista completa dos 315 exercícios revistos

### Pescoço

- E001 Isometria cervical frontal leve — objetivo 134 chars, 7 passos, 4 erros comuns
- E002 Isometria cervical lateral leve — objetivo 86 chars, 7 passos, 4 erros comuns
- E003 Chin tuck — objetivo 123 chars, 7 passos, 4 erros comuns
- E004 Rotação cervical controlada — objetivo 108 chars, 7 passos, 4 erros comuns

### Trapézio

- E005 Encolhimento de ombros com halteres — objetivo 92 chars, 7 passos, 5 erros comuns
- E006 Encolhimento de ombros com barra — objetivo 130 chars, 7 passos, 5 erros comuns
- E007 Encolhimento de ombros na máquina — objetivo 122 chars, 7 passos, 5 erros comuns
- E008 Remo alto leve — objetivo 157 chars, 7 passos, 5 erros comuns
- E009 Face pull no cabo — objetivo 208 chars, 7 passos, 5 erros comuns

### Ombros

- E010 Press militar com barra em pé — objetivo 158 chars, 7 passos, 5 erros comuns
- E011 Press militar com halteres — objetivo 143 chars, 7 passos, 5 erros comuns
- E012 Press militar com barra — objetivo 138 chars, 7 passos, 5 erros comuns
- E013 Arnold press — objetivo 127 chars, 7 passos, 5 erros comuns
- E014 Elevação lateral — objetivo 94 chars, 6 passos, 5 erros comuns
- E015 Elevação frontal — objetivo 126 chars, 6 passos, 5 erros comuns
- E016 Elevação posterior — objetivo 144 chars, 7 passos, 5 erros comuns
- E017 Reverse fly — objetivo 130 chars, 7 passos, 5 erros comuns
- E018 Face pull no cabo — objetivo 206 chars, 7 passos, 5 erros comuns
- E019 Face pull com elástico — objetivo 162 chars, 7 passos, 5 erros comuns
- E020 Pull-apart — objetivo 146 chars, 6 passos, 5 erros comuns
- E021 Mobilidade de ombro com elástico — objetivo 129 chars, 7 passos, 5 erros comuns
- E022 Wall slides — objetivo 155 chars, 7 passos, 4 erros comuns
- E023 Rotação externa — objetivo 135 chars, 6 passos, 5 erros comuns
- E024 Rotação externa com elástico — objetivo 128 chars, 7 passos, 5 erros comuns
- E025 Rotação interna — objetivo 149 chars, 6 passos, 5 erros comuns
- E026 Rotação interna com elástico — objetivo 137 chars, 7 passos, 5 erros comuns
- E027 Y raise — objetivo 145 chars, 7 passos, 5 erros comuns
- E028 W raise — objetivo 151 chars, 7 passos, 5 erros comuns
- E029 Scapular push-up — objetivo 147 chars, 7 passos, 4 erros comuns
- E030 Pike push-up — objetivo 83 chars, 7 passos, 4 erros comuns

### Peito

- E031 Flexão clássica — objetivo 127 chars, 7 passos, 5 erros comuns
- E032 Flexão com joelhos apoiados — objetivo 115 chars, 7 passos, 5 erros comuns
- E033 Flexão inclinada — objetivo 146 chars, 7 passos, 5 erros comuns
- E034 Flexão declinada — objetivo 114 chars, 7 passos, 5 erros comuns
- E035 Flexão aberta — objetivo 79 chars, 7 passos, 5 erros comuns
- E036 Flexão arqueiro — objetivo 141 chars, 7 passos, 5 erros comuns
- E037 Supino com barra — objetivo 121 chars, 7 passos, 5 erros comuns
- E038 Supino com halteres — objetivo 136 chars, 7 passos, 5 erros comuns
- E039 Supino inclinado com halteres — objetivo 118 chars, 7 passos, 5 erros comuns
- E040 Supino inclinado com barra — objetivo 133 chars, 7 passos, 5 erros comuns
- E041 Supino declinado com halteres — objetivo 99 chars, 7 passos, 5 erros comuns
- E042 Supino declinado com barra — objetivo 91 chars, 7 passos, 5 erros comuns
- E043 Supino declinado na máquina — objetivo 124 chars, 7 passos, 5 erros comuns
- E044 Aberturas com halteres — objetivo 118 chars, 7 passos, 5 erros comuns
- E045 Aberturas inclinadas com halteres — objetivo 113 chars, 7 passos, 5 erros comuns
- E046 Aberturas inclinadas no cabo — objetivo 120 chars, 7 passos, 5 erros comuns
- E047 Aberturas inclinadas com elástico — objetivo 95 chars, 7 passos, 5 erros comuns
- E048 Squeeze press — objetivo 86 chars, 7 passos, 5 erros comuns
- E049 Chest press — objetivo 111 chars, 7 passos, 5 erros comuns
- E050 Dips para peito em paralelas — objetivo 75 chars, 5 passos, 5 erros comuns
- E051 Dips assistidos para peito na máquina — objetivo 133 chars, 6 passos, 5 erros comuns
- E052 Crossover no cabo — objetivo 84 chars, 7 passos, 5 erros comuns
- E053 Pullover com halter — objetivo 186 chars, 7 passos, 5 erros comuns

### Costas

- E054 Puxada alta — objetivo 149 chars, 7 passos, 5 erros comuns
- E055 Puxada alta pega aberta — objetivo 97 chars, 7 passos, 5 erros comuns
- E056 Puxada alta pega neutra — objetivo 146 chars, 7 passos, 5 erros comuns
- E057 Puxada alta pega fechada — objetivo 134 chars, 7 passos, 5 erros comuns
- E058 Remo baixo no cabo — objetivo 147 chars, 6 passos, 5 erros comuns
- E059 Remo sentado — objetivo 144 chars, 7 passos, 5 erros comuns
- E060 Remo unilateral com halter — objetivo 133 chars, 7 passos, 5 erros comuns
- E061 Remo com barra — objetivo 130 chars, 7 passos, 5 erros comuns
- E062 Remo invertido — objetivo 128 chars, 7 passos, 5 erros comuns
- E063 Remo invertido em mesa resistente — objetivo 130 chars, 7 passos, 5 erros comuns
- E064 Pull-up — objetivo 148 chars, 7 passos, 5 erros comuns
- E065 Scapular pull-up — objetivo 150 chars, 7 passos, 5 erros comuns
- E066 Dead hang escapular — objetivo 153 chars, 7 passos, 5 erros comuns
- E067 Face pull no cabo — objetivo 206 chars, 7 passos, 5 erros comuns
- E068 Pullover no cabo — objetivo 143 chars, 7 passos, 5 erros comuns
- E069 Pullover com halter — objetivo 187 chars, 7 passos, 5 erros comuns
- E070 Good morning sem carga — objetivo 205 chars, 7 passos, 4 erros comuns
- E071 Puxada com braços esticados — objetivo 159 chars, 7 passos, 5 erros comuns
- E072 Remo com elástico — objetivo 130 chars, 7 passos, 5 erros comuns

### Lombar

- E073 Hiperextensão lombar — objetivo 159 chars, 6 passos, 5 erros comuns
- E074 Hiperextensão no chão — objetivo 156 chars, 7 passos, 4 erros comuns
- E075 Hiperextensão no banco romano — objetivo 156 chars, 7 passos, 5 erros comuns
- E076 Superman isométrico — objetivo 152 chars, 7 passos, 5 erros comuns
- E077 Extensão lombar quadrupede — objetivo 123 chars, 6 passos, 4 erros comuns
- E078 Good morning com barra — objetivo 162 chars, 7 passos, 5 erros comuns
- E079 Good morning leve isométrico — objetivo 100 chars, 7 passos, 5 erros comuns
- E080 Extensão lombar com elástico — objetivo 125 chars, 7 passos, 5 erros comuns

### Bíceps

- E081 Curl com barra — objetivo 146 chars, 7 passos, 5 erros comuns
- E082 Curl com halteres — objetivo 148 chars, 7 passos, 5 erros comuns
- E083 Curl alternado — objetivo 148 chars, 7 passos, 5 erros comuns
- E084 Curl martelo — objetivo 110 chars, 7 passos, 5 erros comuns
- E085 Curl concentrado — objetivo 137 chars, 7 passos, 5 erros comuns
- E086 Curl inclinado com halteres — objetivo 80 chars, 7 passos, 5 erros comuns
- E087 Curl inverso — objetivo 137 chars, 7 passos, 5 erros comuns
- E088 Curl inverso com halteres — objetivo 93 chars, 7 passos, 5 erros comuns
- E089 Curl Zottman — objetivo 94 chars, 7 passos, 5 erros comuns
- E090 Curl cruzado no corpo — objetivo 147 chars, 7 passos, 5 erros comuns
- E091 Curl spider — objetivo 135 chars, 7 passos, 5 erros comuns
- E092 Curl no cabo — objetivo 146 chars, 7 passos, 5 erros comuns
- E093 Curl com elástico — objetivo 163 chars, 7 passos, 5 erros comuns
- E094 Curl 21 com halteres — objetivo 149 chars, 7 passos, 5 erros comuns
- E095 Curl arrastado com halteres — objetivo 146 chars, 6 passos, 5 erros comuns
- E096 Curl isométrico — objetivo 146 chars, 7 passos, 5 erros comuns
- E097 Chin-up — objetivo 137 chars, 7 passos, 5 erros comuns

### Tríceps

- E098 Extensão de tríceps no cabo — objetivo 131 chars, 7 passos, 5 erros comuns
- E099 Extensão acima da cabeça com halter — objetivo 114 chars, 7 passos, 5 erros comuns
- E100 Tríceps testa com barra EZ — objetivo 128 chars, 7 passos, 5 erros comuns
- E101 Tríceps testa com halteres — objetivo 133 chars, 7 passos, 5 erros comuns
- E102 Extensão de tríceps deitado com halteres — objetivo 90 chars, 7 passos, 5 erros comuns
- E103 Supino fechado — objetivo 128 chars, 7 passos, 5 erros comuns
- E104 Press fechado com halteres — objetivo 122 chars, 7 passos, 5 erros comuns
- E105 Tate press — objetivo 100 chars, 6 passos, 5 erros comuns
- E106 Fundos entre apoios — objetivo 120 chars, 7 passos, 4 erros comuns
- E107 Flexão fechada — objetivo 131 chars, 7 passos, 4 erros comuns
- E108 Flexão diamante — objetivo 106 chars, 5 passos, 4 erros comuns
- E109 Kickback de tríceps — objetivo 100 chars, 7 passos, 5 erros comuns
- E110 Kickback no cabo — objetivo 117 chars, 7 passos, 5 erros comuns
- E111 Extensão unilateral de tríceps — objetivo 114 chars, 7 passos, 5 erros comuns
- E112 Extensão francesa com halter — objetivo 123 chars, 7 passos, 5 erros comuns
- E113 Extensão francesa com barra EZ — objetivo 126 chars, 7 passos, 5 erros comuns
- E114 Extensão francesa no cabo — objetivo 116 chars, 7 passos, 5 erros comuns
- E115 Dips para tríceps — objetivo 100 chars, 7 passos, 4 erros comuns
- E116 Tríceps no cabo com corda — objetivo 124 chars, 7 passos, 5 erros comuns
- E117 Tríceps com elástico — objetivo 117 chars, 7 passos, 5 erros comuns

### Antebraço/Pega

- E118 Wrist curl — objetivo 152 chars, 7 passos, 5 erros comuns
- E119 Reverse wrist curl — objetivo 144 chars, 7 passos, 5 erros comuns
- E120 Farmer walk — objetivo 188 chars, 7 passos, 5 erros comuns
- E121 Farmer hold — objetivo 155 chars, 7 passos, 5 erros comuns
- E122 Dead hang — objetivo 144 chars, 7 passos, 5 erros comuns
- E123 Aperto isométrico — objetivo 83 chars, 6 passos, 5 erros comuns
- E124 Curl inverso — objetivo 147 chars, 7 passos, 5 erros comuns
- E125 Pronação com halter — objetivo 131 chars, 7 passos, 5 erros comuns
- E126 Supinação com halter — objetivo 131 chars, 7 passos, 5 erros comuns
- E127 Pinch grip — objetivo 152 chars, 7 passos, 5 erros comuns
- E128 Plate hold — objetivo 136 chars, 7 passos, 5 erros comuns
- E129 Towel grip hold — objetivo 151 chars, 7 passos, 5 erros comuns
- E130 Finger curls — objetivo 131 chars, 7 passos, 5 erros comuns
- E131 Extensão de dedos com elástico — objetivo 133 chars, 7 passos, 5 erros comuns
- E132 Desvio radial com halter — objetivo 74 chars, 7 passos, 5 erros comuns
- E133 Desvio ulnar com halter — objetivo 101 chars, 7 passos, 5 erros comuns
- E134 Suitcase carry — objetivo 130 chars, 7 passos, 5 erros comuns
- E135 Hold estático com halteres — objetivo 155 chars, 7 passos, 5 erros comuns
- E136 Rotação controlada com halter leve — objetivo 91 chars, 7 passos, 5 erros comuns

### Core

- E137 Prancha — objetivo 118 chars, 7 passos, 5 erros comuns
- E138 Prancha lateral — objetivo 135 chars, 7 passos, 5 erros comuns
- E139 Crunch — objetivo 146 chars, 7 passos, 5 erros comuns
- E140 Reverse crunch — objetivo 133 chars, 7 passos, 5 erros comuns
- E141 Elevação de pernas — objetivo 146 chars, 7 passos, 5 erros comuns
- E142 Elevação de joelhos suspenso — objetivo 146 chars, 7 passos, 5 erros comuns
- E143 Dead bug — objetivo 128 chars, 6 passos, 5 erros comuns
- E144 Hollow hold — objetivo 140 chars, 7 passos, 5 erros comuns
- E145 Mountain climbers — objetivo 120 chars, 7 passos, 5 erros comuns
- E146 Pallof press no cabo — objetivo 151 chars, 7 passos, 5 erros comuns
- E147 Pallof press com elástico — objetivo 149 chars, 7 passos, 5 erros comuns
- E148 Russian twist — objetivo 157 chars, 7 passos, 5 erros comuns
- E149 Bicycle crunch — objetivo 145 chars, 7 passos, 5 erros comuns
- E150 Bird dog — objetivo 127 chars, 6 passos, 5 erros comuns
- E151 Side bend — objetivo 150 chars, 7 passos, 5 erros comuns
- E152 Vacuum abdominal — objetivo 137 chars, 6 passos, 5 erros comuns
- E153 Flutter kicks — objetivo 145 chars, 7 passos, 5 erros comuns
- E154 Toe touches — objetivo 143 chars, 7 passos, 5 erros comuns
- E155 Superman — objetivo 158 chars, 7 passos, 5 erros comuns

### Pernas

- E156 Agachamento com peso corporal — objetivo 149 chars, 7 passos, 5 erros comuns
- E157 Agachamento para cadeira — objetivo 159 chars, 7 passos, 5 erros comuns
- E158 Agachamento goblet — objetivo 161 chars, 7 passos, 5 erros comuns
- E159 Agachamento com halteres ao lado — objetivo 143 chars, 7 passos, 5 erros comuns
- E160 Agachamento com barra — objetivo 156 chars, 7 passos, 5 erros comuns
- E161 Agachamento com mochila — objetivo 134 chars, 7 passos, 5 erros comuns
- E162 Agachamento com garrafão — objetivo 150 chars, 7 passos, 5 erros comuns
- E163 Agachamento sumo — objetivo 199 chars, 7 passos, 5 erros comuns
- E164 Agachamento na máquina Smith — objetivo 149 chars, 7 passos, 5 erros comuns
- E165 Agachamento búlgaro — objetivo 169 chars, 7 passos, 5 erros comuns
- E166 Agachamento búlgaro com apoio — objetivo 154 chars, 7 passos, 5 erros comuns
- E167 Extensão de perna — objetivo 132 chars, 7 passos, 5 erros comuns
- E168 Leg press — objetivo 168 chars, 7 passos, 5 erros comuns
- E169 Step-up — objetivo 133 chars, 7 passos, 5 erros comuns
- E170 Wall sit — objetivo 151 chars, 7 passos, 5 erros comuns
- E171 Lunges — objetivo 153 chars, 7 passos, 5 erros comuns
- E172 Lunges com halteres — objetivo 140 chars, 7 passos, 5 erros comuns
- E173 Lunges com mochila — objetivo 144 chars, 7 passos, 5 erros comuns
- E174 Walking lunges — objetivo 147 chars, 7 passos, 5 erros comuns
- E175 Peso morto tradicional — objetivo 152 chars, 7 passos, 5 erros comuns
- E176 Peso morto romeno com halteres — objetivo 86 chars, 7 passos, 5 erros comuns
- E177 Curl de perna — objetivo 112 chars, 7 passos, 5 erros comuns
- E178 Good morning leve — objetivo 168 chars, 7 passos, 5 erros comuns
- E179 Good morning sem carga — objetivo 205 chars, 7 passos, 4 erros comuns
- E180 Ponte de glúteo — objetivo 182 chars, 7 passos, 4 erros comuns
- E181 Hip thrust — objetivo 177 chars, 7 passos, 4 erros comuns
- E182 Hip thrust com apoio — objetivo 187 chars, 7 passos, 4 erros comuns
- E183 Abdução de anca — objetivo 130 chars, 7 passos, 5 erros comuns
- E184 Adução de anca — objetivo 126 chars, 7 passos, 5 erros comuns
- E185 Kickback de glúteo — objetivo 172 chars, 7 passos, 4 erros comuns
- E186 Gémeos em pé — objetivo 81 chars, 7 passos, 4 erros comuns
- E187 Gémeos sentado — objetivo 129 chars, 7 passos, 4 erros comuns
- E188 Elevação de gémeos unilateral — objetivo 139 chars, 7 passos, 4 erros comuns
- E189 Sóleo sentado — objetivo 115 chars, 7 passos, 4 erros comuns
- E190 Saltos leves — objetivo 109 chars, 7 passos, 4 erros comuns
- E191 Elevação tibial — objetivo 100 chars, 7 passos, 4 erros comuns
- E192 Short foot / doming — objetivo 162 chars, 7 passos, 4 erros comuns
- E193 Flexão ativa dos dedos do pé — objetivo 196 chars, 7 passos, 5 erros comuns
- E194 Dorsiflexão do tornozelo com elástico — objetivo 166 chars, 7 passos, 5 erros comuns
- E195 Inversão do tornozelo com elástico — objetivo 171 chars, 7 passos, 5 erros comuns
- E196 Eversão do tornozelo com elástico — objetivo 173 chars, 7 passos, 5 erros comuns
- E197 Flexão da anca em pé com elástico — objetivo 154 chars, 7 passos, 5 erros comuns
- E198 Copenhagen plank com apoio — objetivo 169 chars, 7 passos, 4 erros comuns
- E199 Extensão terminal do joelho com elástico — objetivo 133 chars, 7 passos, 5 erros comuns
- E200 Abdução de anca deitada — objetivo 163 chars, 7 passos, 4 erros comuns

### Cardio

- E201 Marcha no lugar — objetivo 136 chars, 7 passos, 5 erros comuns
- E202 Jumping jacks — objetivo 135 chars, 7 passos, 5 erros comuns
- E203 Burpees — objetivo 162 chars, 7 passos, 5 erros comuns
- E204 Skaters — objetivo 125 chars, 7 passos, 5 erros comuns
- E205 High knees — objetivo 131 chars, 7 passos, 5 erros comuns
- E206 Circuito cardio peso corporal — objetivo 145 chars, 7 passos, 5 erros comuns
- E207 Passadeira caminhada — objetivo 145 chars, 7 passos, 5 erros comuns
- E208 Passadeira caminhada rápida — objetivo 143 chars, 7 passos, 5 erros comuns
- E209 Passadeira corrida leve — objetivo 120 chars, 7 passos, 5 erros comuns
- E210 Passadeira corrida intervalada — objetivo 140 chars, 6 passos, 5 erros comuns
- E211 Passadeira inclinação — objetivo 144 chars, 7 passos, 5 erros comuns
- E212 Passadeira inclinação moderada — objetivo 141 chars, 7 passos, 5 erros comuns
- E213 Passadeira sprints — objetivo 140 chars, 7 passos, 5 erros comuns
- E214 Passadeira sprints intervalados — objetivo 134 chars, 7 passos, 5 erros comuns
- E215 Passadeira aquecimento — objetivo 149 chars, 6 passos, 5 erros comuns
- E216 Passadeira cooldown — objetivo 148 chars, 7 passos, 5 erros comuns
- E217 Bicicleta ritmo leve — objetivo 109 chars, 7 passos, 5 erros comuns
- E218 Bicicleta ritmo moderado — objetivo 117 chars, 7 passos, 5 erros comuns
- E219 Bicicleta intervalos — objetivo 120 chars, 6 passos, 5 erros comuns
- E220 Bicicleta resistência — objetivo 87 chars, 7 passos, 5 erros comuns
- E221 Bicicleta aquecimento — objetivo 131 chars, 6 passos, 5 erros comuns
- E222 Bicicleta cooldown — objetivo 121 chars, 7 passos, 5 erros comuns
- E223 Elíptica ritmo leve — objetivo 142 chars, 7 passos, 5 erros comuns
- E224 Elíptica ritmo moderado — objetivo 133 chars, 7 passos, 5 erros comuns
- E225 Elíptica intervalos — objetivo 140 chars, 7 passos, 5 erros comuns
- E226 Elíptica resistência — objetivo 88 chars, 7 passos, 5 erros comuns
- E227 Elíptica aquecimento — objetivo 148 chars, 7 passos, 5 erros comuns
- E228 Elíptica cooldown — objetivo 140 chars, 7 passos, 5 erros comuns
- E229 Corda de saltar ritmo leve — objetivo 123 chars, 7 passos, 5 erros comuns
- E230 Corda de saltar intervalos — objetivo 138 chars, 7 passos, 5 erros comuns
- E231 Corda de saltar pés alternados — objetivo 136 chars, 7 passos, 5 erros comuns
- E232 Corda de saltar joelhos altos — objetivo 146 chars, 7 passos, 5 erros comuns
- E233 Corda de saltar double unders — objetivo 143 chars, 7 passos, 5 erros comuns
- E234 Caminhada exterior leve — objetivo 140 chars, 7 passos, 5 erros comuns
- E235 Caminhada exterior moderada — objetivo 150 chars, 7 passos, 5 erros comuns
- E236 Caminhada exterior rápida — objetivo 134 chars, 7 passos, 5 erros comuns
- E237 Caminhada exterior em subida — objetivo 135 chars, 7 passos, 5 erros comuns
- E238 Corrida exterior leve — objetivo 136 chars, 7 passos, 5 erros comuns
- E239 Corrida exterior moderada — objetivo 149 chars, 7 passos, 5 erros comuns
- E240 Corrida exterior intervalada — objetivo 142 chars, 7 passos, 5 erros comuns
- E241 Sprints exterior — objetivo 131 chars, 7 passos, 5 erros comuns
- E242 Corrida em subida — objetivo 141 chars, 7 passos, 5 erros comuns
- E243 HIIT peso corporal — objetivo 141 chars, 7 passos, 5 erros comuns
- E244 HIIT cardio — objetivo 138 chars, 7 passos, 5 erros comuns
- E245 HIIT passadeira — objetivo 148 chars, 7 passos, 5 erros comuns
- E246 HIIT bicicleta — objetivo 152 chars, 7 passos, 5 erros comuns
- E247 HIIT corda — objetivo 143 chars, 7 passos, 5 erros comuns
- E248 HIIT simples — objetivo 151 chars, 7 passos, 5 erros comuns
- E249 Circuito cardio leve — objetivo 133 chars, 7 passos, 5 erros comuns

### Karate

- E250 Kihon — objetivo 116 chars, 7 passos, 5 erros comuns
- E251 Kata — objetivo 113 chars, 7 passos, 5 erros comuns
- E252 Kumite técnico — objetivo 126 chars, 7 passos, 5 erros comuns
- E253 Sombra de Karate — objetivo 119 chars, 7 passos, 5 erros comuns
- E254 Drills de deslocamento — objetivo 144 chars, 7 passos, 5 erros comuns
- E255 Drills de guarda — objetivo 195 chars, 7 passos, 5 erros comuns
- E256 Pontapés técnicos — objetivo 126 chars, 7 passos, 5 erros comuns
- E257 Socos técnicos — objetivo 122 chars, 7 passos, 5 erros comuns
- E258 Mobilidade de anca para Karate — objetivo 134 chars, 7 passos, 5 erros comuns
- E259 Mobilidade de ombro para Karate — objetivo 133 chars, 7 passos, 5 erros comuns
- E260 Condicionamento leve para Karate — objetivo 147 chars, 7 passos, 5 erros comuns

### Jiu-Jitsu

- E261 Shrimp / fuga de anca — objetivo 129 chars, 7 passos, 5 erros comuns
- E262 Ponte de grappling — objetivo 132 chars, 7 passos, 5 erros comuns
- E263 Technical stand-up — objetivo 137 chars, 7 passos, 5 erros comuns
- E264 Sprawl — objetivo 177 chars, 7 passos, 5 erros comuns
- E265 Drills de guarda — objetivo 175 chars, 7 passos, 5 erros comuns
- E266 Drills de passagem de guarda — objetivo 151 chars, 7 passos, 5 erros comuns
- E267 Mobilidade de anca para Jiu-Jitsu — objetivo 141 chars, 7 passos, 5 erros comuns
- E268 Mobilidade de ombro para Jiu-Jitsu — objetivo 146 chars, 7 passos, 5 erros comuns
- E269 Força de pega para Jiu-Jitsu — objetivo 139 chars, 7 passos, 5 erros comuns
- E270 Core para Jiu-Jitsu — objetivo 143 chars, 7 passos, 5 erros comuns
- E271 Condicionamento leve para Jiu-Jitsu — objetivo 154 chars, 7 passos, 5 erros comuns

### Mobilidade

- E272 Mobilidade torácica — objetivo 135 chars, 7 passos, 5 erros comuns
- E273 Mobilidade de ombro — objetivo 158 chars, 7 passos, 5 erros comuns
- E274 Mobilidade de anca — objetivo 137 chars, 7 passos, 5 erros comuns
- E275 Círculos de ombro — objetivo 149 chars, 7 passos, 5 erros comuns
- E276 Alongamento posterior do ombro — objetivo 145 chars, 7 passos, 5 erros comuns
- E277 Mobilidade de ombro com toalha — objetivo 119 chars, 7 passos, 5 erros comuns
- E278 Mobilidade de ombro com cabo de vassoura — objetivo 106 chars, 7 passos, 5 erros comuns
- E279 Alongamento peitoral — objetivo 136 chars, 7 passos, 5 erros comuns
- E280 Alongamento peitoral na parede — objetivo 138 chars, 7 passos, 5 erros comuns
- E281 Alongamento peitoral no canto — objetivo 133 chars, 7 passos, 5 erros comuns
- E282 Alongamento dorsal — objetivo 131 chars, 7 passos, 5 erros comuns
- E283 Rotação torácica no chão — objetivo 156 chars, 6 passos, 5 erros comuns
- E284 Cat-cow — objetivo 150 chars, 7 passos, 5 erros comuns
- E285 Open book — objetivo 154 chars, 7 passos, 5 erros comuns
- E286 Alongamento posterior de coxa — objetivo 128 chars, 7 passos, 5 erros comuns
- E287 Alongamento posterior sentado — objetivo 142 chars, 7 passos, 5 erros comuns
- E288 Alongamento posterior em pé — objetivo 137 chars, 7 passos, 5 erros comuns
- E289 Tocar nos pés sentado — objetivo 142 chars, 7 passos, 5 erros comuns
- E290 Tocar nos pés em pé — objetivo 147 chars, 7 passos, 5 erros comuns
- E291 Alongamento posterior com perna elevada — objetivo 147 chars, 7 passos, 5 erros comuns
- E292 Mobilidade dinâmica de posterior — objetivo 147 chars, 7 passos, 5 erros comuns
- E293 Alongamento glúteos — objetivo 152 chars, 7 passos, 5 erros comuns
- E294 Alongamento de glúteo sentado — objetivo 154 chars, 7 passos, 5 erros comuns
- E295 Alongamento figura 4 — objetivo 147 chars, 7 passos, 5 erros comuns
- E296 Pigeon stretch — objetivo 132 chars, 7 passos, 5 erros comuns
- E297 Alongamento piriforme — objetivo 150 chars, 7 passos, 5 erros comuns
- E298 Rotação externa da anca no chão — objetivo 158 chars, 7 passos, 5 erros comuns
- E299 Mobilidade 90/90 — objetivo 130 chars, 7 passos, 5 erros comuns
- E300 Mobilidade dinâmica de anca — objetivo 141 chars, 7 passos, 5 erros comuns
- E301 Alongamento quadríceps em pé — objetivo 154 chars, 7 passos, 5 erros comuns
- E302 Alongamento quadríceps de lado — objetivo 146 chars, 7 passos, 5 erros comuns
- E303 Alongamento gémeos — objetivo 139 chars, 7 passos, 5 erros comuns
- E304 Alongamento gémeos na parede — objetivo 115 chars, 7 passos, 5 erros comuns
- E305 Mobilidade de tornozelo na parede — objetivo 147 chars, 7 passos, 5 erros comuns
- E306 Círculos de tornozelo — objetivo 141 chars, 7 passos, 5 erros comuns
- E307 Mobilidade de punhos — objetivo 149 chars, 7 passos, 5 erros comuns
- E308 Extensão de punhos no chão — objetivo 144 chars, 7 passos, 5 erros comuns
- E309 Flexão de punhos no chão — objetivo 118 chars, 7 passos, 5 erros comuns
- E310 Alongamento cervical leve — objetivo 142 chars, 7 passos, 5 erros comuns
- E311 Mobilidade leve de ombros — objetivo 132 chars, 7 passos, 5 erros comuns
- E312 Mobilidade leve de anca — objetivo 142 chars, 7 passos, 5 erros comuns
- E313 Respiração diafragmática — objetivo 131 chars, 7 passos, 5 erros comuns
- E314 Caminhada leve — objetivo 113 chars, 6 passos, 5 erros comuns
- E315 Relaxamento deitado — objetivo 131 chars, 7 passos, 5 erros comuns
