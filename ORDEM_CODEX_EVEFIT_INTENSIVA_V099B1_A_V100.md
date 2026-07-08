# ORDEM MESTRA CODEX EVEFIT
## Roadmap intensivo v0.9.9B1 até v1.0.0

Documento para Codex.

Esta ordem substitui qualquer instrução anterior que aponte para uma v1.0 mínima. A partir deste ponto, o objetivo é uma v1.0 boa, sólida, útil e difícil de partir.

---

# 0. Estado atual aprovado

Fases já concluídas e aceites tecnicamente:

```text
v0.9.5
FAIL_WRONG_RESULTS: 192 -> 0

v0.9.6
Exercícios inacessíveis: 891 -> 0
Usáveis limpos: 224 -> 1178

v0.9.7
Caminhos vazios: todos com decisão explícita
Mensagens genéricas nos vazios auditados: 1026 -> 0

v0.9.8
1178 exercícios analisados
A: 536
B: 642
C: 0
D: 0
E: 0

v0.9.9A
Auditoria e proposta inicial, mas proposta rejeitada por erros de mapeamento

v0.9.9A2
Nova proposta GOOD_V1 aceite como base
587 exercícios propostos
Total esperado: 1178 + 587 = 1765

v0.9.9B0
Hardening crítico concluído
Permissões iOS corrigidas
SQLite foreign keys ativadas
Auditoria de órfãos criada
APKs removidos do índice Git
toMap(forUpdate: true) aplicado em modelos críticos
Erros de gravação/fotos melhorados
Profile gate com retry
Tabs com IndexedStack
```

Estado atual do catálogo:

```text
Total atual: 1178
Meta GOOD_V1: 1765
Exercícios novos previstos: 587
```

Distribuição da proposta GOOD_V1:

```text
musculação: +193
cardio: +35
artes marciais: +128
mobilidade: +37
elasticidade: +38
recuperação: +28
aquecimento: +19
ativação: +58
prevenção: +51
```

Objetivo final:

```text
v1.0 com cerca de 1765 exercícios reais
0 wrong-results
0 inacessíveis
0 menus silenciosamente vazios
0 descrições fracas visíveis
0 exercícios com mapeamento anatómico errado
0 exercícios novos sem rota
0 exercícios novos sem segurança
0 exercícios novos com nomes genéricos
```

---

# 1. Ordem imperativa

Não queremos uma v1.0 mínima. Queremos uma v1.0 boa.

Nunca sacrificar qualidade por velocidade.

Nunca implementar em massa.

Nunca saltar fase.

Nunca adicionar exercícios sem plano, teste, relatório e auditoria after.

Cada fase tem de seguir esta sequência:

```text
1. Confirmar branch
2. Fazer push da branch anterior
3. Criar branch nova
4. Ler proposta GOOD_V1
5. Criar plano do lote
6. Verificar duplicados antes de implementar
7. Implementar lote pequeno
8. Atualizar rotas, filtros, aliases e contextos
9. Criar ou atualizar testes
10. Gerar relatório after
11. Correr validação completa
12. Fazer commit
13. Reportar métricas
14. Parar
15. Esperar aprovação humana
```

Saltou um destes passos? A fase não está concluída.

---

# 2. Regras absolutas

## 2.1 Proibições

Não fazer:

```text
Não adicionar exercícios fora da proposta GOOD_V1.
Não adicionar todos os 587 exercícios de uma vez.
Não inventar nomes genéricos.
Não criar "proposta 001", "variation 002", "exercise generic".
Não associar músculos aleatórios a equipamentos.
Não duplicar exercício existente com nome ligeiramente diferente.
Não esconder menus para fazer testes passar.
Não apagar exercícios existentes para reduzir falhas.
Não transformar falhas reais em warnings.
Não baixar thresholds para passar testes.
Não mexer em Shukokai sem aprovação explícita do Sandro.
Não fazer merge para main antes da release final aprovada.
Não commitar APKs.
Não commitar build/.
Não alterar versão para 1.0.0 antes da fase final.
```

## 2.2 Permissões

Pode fazer:

```text
Criar exercícios novos aprovados no GOOD_V1.
Criar rotas e aliases necessários para esses exercícios.
Corrigir filtros se o exercício novo revelar uma falha real.
Adicionar testes.
Adicionar relatórios.
Melhorar validações.
Corrigir pequenos bugs que bloqueiem a fase, desde que reportados.
```

## 2.3 Regra de paragem

No fim de cada fase:

```text
Parar.
Reportar.
Não avançar para a fase seguinte.
```

---

# 3. Padrão obrigatório para cada exercício novo

Cada exercício novo tem de ser uma entrada real, útil e concreta.

## 3.1 Campos mínimos obrigatórios

Cada exercício novo deve ter, respeitando o modelo existente da app:

```text
canonical_id único
nome real em PT-PT
categoria
subcategoria
tipo primário
local compatível
equipamento compatível
músculo principal correto
músculos secundários corretos
articulação principal, quando aplicável
objetivo simples
descrição concreta
posição inicial
execução passo a passo
cadência ou ritmo
respiração
sensação esperada
erros comuns
regressão
progressão
segurança e cuidados
quando evitar ou adaptar
rotas de menu válidas
aliases úteis
contextos corretos
nível de dificuldade, se o modelo suportar
```

## 3.2 Qualidade mínima de texto

Cada exercício novo tem de explicar a execução como se a pessoa fosse iniciante.

Formato recomendado:

```text
Objetivo:
Explicar para que serve o exercício numa frase simples.

Posição inicial:
Dizer onde a pessoa fica, como ajusta o equipamento e como alinha o corpo.

Execução:
1. Preparar a postura.
2. Iniciar o movimento de forma controlada.
3. Chegar ao fim da amplitude útil sem compensar.
4. Voltar à posição inicial com controlo.

Respiração:
Dizer quando inspira e quando expira.

Erros comuns:
Listar 3 a 5 erros reais.

Regressão:
Uma versão mais fácil.

Progressão:
Uma versão mais difícil.

Cuidados:
Riscos, dores, limitações, adaptação.

Quando evitar:
Dor aguda, instabilidade, tontura, limitação articular ou indicação profissional.
```

## 3.3 Linguagem de segurança

Para prevenção, recuperação, dor e reabilitação, usar linguagem segura.

Permitido:

```text
pode ajudar
pode apoiar
trabalho complementar
preparação gradual
tolerância progressiva
evitar se houver dor aguda
procurar profissional se a dor persistir
```

Proibido:

```text
cura dor
previne lesões garantidamente
corrige lesões
substitui fisioterapia
trata patologia
resolve problema médico
```

---

# 4. Exemplos corretos e incorretos

## 4.1 Leg extension

Correto:

```text
Nome: Extensão de pernas na máquina
Categoria: Musculação
Local: Ginásio
Equipamento: leg_extension
Grupo principal: Quadríceps
Articulação: Joelho
Menu: Musculação > Ginásio > Máquinas > Pernas

Descrição:
Exercício de isolamento para quadríceps, feito na máquina de extensão de pernas, com foco em controlar a extensão do joelho sem embalar o tronco.

Execução:
1. Ajusta o encosto para manter as costas apoiadas.
2. Alinha o eixo da máquina com o joelho.
3. Coloca o rolo acima do peito do pé ou na zona inferior da canela.
4. Estende os joelhos de forma controlada sem bater no fim da amplitude.
5. Desce devagar até voltares à posição inicial.

Respiração:
Expira ao estender as pernas e inspira ao descer.

Erros comuns:
Usar balanço.
Levantar a bacia.
Travar o joelho com força.
Descer rápido demais.
Usar carga que reduz o controlo.

Regressão:
Reduzir carga e amplitude.

Progressão:
Pausa de 1 segundo no topo ou cadência mais lenta.

Cuidados:
Evitar se houver dor aguda no joelho.
```

Incorreto:

```text
Leg extension - isquiotibiais/joelho
```

Motivo: músculo principal errado.

## 4.2 Lat pulldown

Correto:

```text
Nome: Puxada alta à frente
Categoria: Musculação
Local: Ginásio
Equipamento: lat_pulldown
Grupo principal: Dorsais
Secundários: Bíceps, redondo maior, trapézio médio/inferior
Menu: Musculação > Ginásio > Máquinas/Cabos > Costas

Descrição:
Puxada vertical para costas, feita com controlo escapular e sem inclinar demasiado o tronco.

Execução:
1. Ajusta o apoio das coxas.
2. Segura a barra com pega confortável.
3. Começa com os braços estendidos e ombros controlados.
4. Puxa a barra em direção à parte superior do peito.
5. Mantém os cotovelos a descer para baixo e ligeiramente para trás.
6. Volta a subir com controlo.

Respiração:
Expira ao puxar e inspira ao subir.

Erros comuns:
Puxar atrás da nuca sem necessidade.
Inclinar demasiado para trás.
Usar balanço.
Encolher os ombros.
Perder controlo na subida.
```

Incorreto:

```text
lat pulldown - peitoral/ombro
```

Motivo: grupo principal errado.

## 4.3 Face pull

Correto:

```text
Nome: Face pull no cabo
Categoria: Musculação
Local: Ginásio
Equipamento: cable_machine
Grupo principal: Deltoide posterior, trapézio médio/inferior, rotadores externos
Secundários: Romboides
Menu: Musculação > Ginásio > Cabos > Ombros/Costas superiores

Descrição:
Exercício para controlo escapular e deltoide posterior, puxando a corda em direção ao rosto com cotovelos abertos e ombros baixos.

Execução:
1. Ajusta o cabo à altura do rosto ou ligeiramente acima.
2. Segura a corda com as duas mãos.
3. Dá um passo atrás e mantém o tronco estável.
4. Puxa a corda em direção ao rosto, separando as mãos.
5. Mantém os ombros baixos e as escápulas controladas.
6. Volta devagar à posição inicial.
```

Incorreto:

```text
face pull - peitoral
```

Motivo: foco anatómico errado.

## 4.4 Ab wheel

Correto:

```text
Nome: Ab wheel rollout ajoelhado
Categoria: Musculação
Local: Casa equipada ou ginásio
Equipamento: ab_wheel
Grupo principal: Core anterior
Secundários: Serrátil, ombros, grande dorsal como estabilizador
Menu: Musculação > Core > Ab wheel

Descrição:
Exercício anti-extensão para o core, feito com joelhos no chão e movimento controlado para evitar colapsar a lombar.

Execução:
1. Fica de joelhos com a roda à frente do corpo.
2. Contrai glúteos e abdómen antes de rolar.
3. Avança a roda devagar até ao limite em que consegues manter a lombar neutra.
4. Pausa brevemente.
5. Regressa puxando a roda com controlo, sem sentar nos calcanhares.
```

Incorreto:

```text
ab wheel - glúteos/anca
```

Motivo: músculo principal errado.

---

# 5. Validação obrigatória em todas as fases

Correr sempre:

```bash
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
flutter test -r compact
dart run tool/catalog_audit_report.dart --strict
flutter build apk --debug
flutter build apk --release
```

Critérios permanentes:

```text
0 críticos
0 warnings
0 FAIL_WRONG_RESULTS
0 exercícios inacessíveis
0 canonical_id duplicados
0 exercícios novos sem rota
0 exercícios novos fora da categoria da fase
0 descrições D/E
0 APKs commitados
```

---

# 6. Estrutura de relatórios por fase

Cada fase tem de criar dois grupos de relatórios:

## 6.1 Plano antes de implementar

Formato:

```text
docs/catalog_reports/v0.9.9/<fase>_plan.md
docs/catalog_reports/v0.9.9/<fase>_plan.csv
docs/catalog_reports/v0.9.9/<fase>_plan.json
```

Cada linha:

```text
exercise_name
canonical_id_proposed
category
subcategory
menu_route
equipment
location
primary_muscle
secondary_muscles
joint
goal
priority
reason_to_add
coverage_gap
existing_similar_exercise
duplicate_risk
implementation_decision
```

## 6.2 Relatório after

Formato:

```text
docs/catalog_reports/v0.9.9/<fase>_after.md
docs/catalog_reports/v0.9.9/<fase>_after.csv
docs/catalog_reports/v0.9.9/<fase>_after.json
```

Cada relatório after deve mostrar:

```text
total antes
total depois
exercícios adicionados
total por categoria
total por equipamento
total por grupo muscular
total por prioridade
wrong-results depois
inacessíveis depois
qualidade A/B/C/D/E depois
duplicados encontrados
ficheiros alterados
testes executados
builds executados
decisões pendentes
```

---

# 7. Roadmap de implementação

A partir daqui, executar fase por fase.

---

# 8. v0.9.9B1
## Musculação lote 1: máquinas, cabos e grandes bases

Branch:

```bash
catalog-strength-expansion-v099b1
```

Criar a partir de:

```bash
release-hardening-v099b0
```

## 8.1 Objetivo

Adicionar apenas 50 a 70 exercícios de musculação GOOD_V1.

Prioridade:

```text
máquinas de pernas
cabos de costas
puxadas
remadas
supino e variações com banco
ombros em máquina/cabo/halteres
core e pega funcional em pequena quantidade
```

Não adicionar todos os 193 exercícios de musculação.

## 8.2 Equipamentos prioritários

```text
leg_press
leg_extension
leg_curl
smith_machine
lat_pulldown
cable_machine
bench
barbell
dumbbells
pull_up_bar
ab_wheel
trx
rings
medicine_ball
sandbag
```

## 8.3 Exemplos de exercícios aceitáveis neste lote

```text
Leg press 45 graus
Leg press horizontal
Extensão de pernas na máquina
Curl de pernas sentado
Curl de pernas deitado
Agachamento na Smith machine
Peso morto romeno na Smith machine
Puxada alta à frente
Puxada alta pega neutra
Puxada unilateral no cabo
Remo sentado no cabo
Remo baixo com pega neutra
Remo alto no cabo para deltoide posterior
Supino plano com barra
Supino inclinado com halteres
Chest press na máquina
Cable fly médio
Cable fly baixo para peito superior
Shoulder press na máquina
Elevação lateral no cabo
Face pull no cabo
Reverse fly na máquina
Ab wheel rollout ajoelhado
Farmer carry com halteres
TRX row
Ring support hold
```

## 8.4 Plano obrigatório antes de implementar

Criar:

```text
docs/catalog_reports/v0.9.9/v099b1_strength_lot_plan.md
docs/catalog_reports/v0.9.9/v099b1_strength_lot_plan.csv
docs/catalog_reports/v0.9.9/v099b1_strength_lot_plan.json
```

O plano deve escolher 50 a 70 exercícios da proposta GOOD_V1.

Antes de implementar, verificar:

```text
existe exercício igual no catálogo?
existe variação quase igual?
o nome é claro?
o equipamento existe?
o menu existe?
o músculo principal está correto?
o exercício tem valor real?
```

## 8.5 Implementação

Adicionar os exercícios no local do catálogo que respeita a arquitetura existente.

Atualizar:

```text
catálogo
aliases
contextos
rotas
filtros, apenas se necessário
testes
relatórios
```

Não usar templates fracos. Cada exercício tem de ter conteúdo concreto.

## 8.6 Testes

Criar ou atualizar:

```text
test/catalog/catalog_strength_expansion_v099b1_test.dart
test/catalog/catalog_strength_equipment_contract_test.dart
test/catalog/catalog_strength_no_duplicate_test.dart
```

Testes devem garantir:

```text
cada exercício novo aparece em pelo menos uma rota correta
nenhum exercício novo aparece em rota incompatível
equipamento bate certo
músculo principal bate certo
canonical_id é único
qualidade textual não é D/E
wrong-results continuam 0
inacessíveis continuam 0
```

## 8.7 Relatório after

Criar:

```text
docs/catalog_reports/v0.9.9/v099b1_strength_after.md
docs/catalog_reports/v0.9.9/v099b1_strength_after.csv
docs/catalog_reports/v0.9.9/v099b1_strength_after.json
```

## 8.8 Commit

```bash
Add first good v1 strength expansion lot
```

Parar após commit e validação.

---

# 9. v0.9.9B2
## Musculação lote 2: pesos livres, puxadas, variações úteis

Branch:

```bash
catalog-strength-expansion-v099b2
```

Criar a partir de:

```bash
catalog-strength-expansion-v099b1
```

## 9.1 Objetivo

Adicionar mais 60 a 70 exercícios de musculação GOOD_V1.

Foco:

```text
halteres
barra
banco
peso corporal
barra fixa
elástico
kettlebell
core
unilaterais úteis
costas, peito, ombros, pernas
```

## 9.2 Exemplos aceitáveis

```text
Remo unilateral com halter apoiado no banco
Remo inclinado com barra
Remo peito apoiado com halteres
Supino inclinado com barra
Supino declinado com halteres
Press Arnold
Elevação lateral sentado
Elevação lateral inclinado
Curl bíceps inclinado
Curl martelo alternado
Curl spider
Tríceps testa com barra EZ
Extensão tríceps acima da cabeça com halter
Agachamento goblet
Bulgarian split squat
Step-up com halteres
Peso morto romeno com halteres
Hip thrust com barra
Elevação de gémeos em pé com halteres
Pull-up assistido
Chin-up assistido
Dead bug com carga leve
Hollow hold
Pallof press com elástico
Kettlebell deadlift
Kettlebell swing técnico leve
```

## 9.3 Cuidados

Não criar variações inúteis só para aumentar número.

Aceitar variação apenas se mudar pelo menos uma destas coisas:

```text
equipamento
ângulo
pega
apoio
unilateral/bilateral
foco muscular real
nível de dificuldade
contexto de uso
```

## 9.4 Relatórios

Criar:

```text
docs/catalog_reports/v0.9.9/v099b2_strength_lot_plan.md/csv/json
docs/catalog_reports/v0.9.9/v099b2_strength_after.md/csv/json
```

## 9.5 Testes

Criar ou atualizar:

```text
test/catalog/catalog_strength_expansion_v099b2_test.dart
test/catalog/catalog_free_weight_contract_test.dart
test/catalog/catalog_strength_variant_value_test.dart
```

## 9.6 Commit

```bash
Add second good v1 strength expansion lot
```

Parar.

---

# 10. v0.9.9B3
## Musculação lote 3: completar meta de musculação

Branch:

```bash
catalog-strength-expansion-v099b3
```

Criar a partir de:

```bash
catalog-strength-expansion-v099b2
```

## 10.1 Objetivo

Adicionar o restante de musculação até completar os +193 exercícios aprovados.

Meta:

```text
Musculação antes do plano: 207
Depois de B1 + B2 + B3: 400
```

## 10.2 Foco

Completar lacunas que sobrarem:

```text
antebraço
pega
trapézio
lombar
pescoço seguro
gémeos
adutores
abdutores
core lateral
core anti-rotação
costas superiores
deltoide posterior
glúteos
variações funcionais com sandbag/medicine ball/TRX/argolas
```

## 10.3 Regras para pescoço e lombar

Exercícios de pescoço e lombar têm maior risco.

Obrigatório:

```text
carga baixa
movimento controlado
sem dor
sem amplitude forçada
linguagem conservadora
regressão clara
quando evitar claro
```

Não usar:

```text
carga pesada no pescoço
promessa de corrigir postura
hiperextensão lombar agressiva
```

## 10.4 Relatórios

Criar:

```text
docs/catalog_reports/v0.9.9/v099b3_strength_lot_plan.md/csv/json
docs/catalog_reports/v0.9.9/v099b3_strength_after.md/csv/json
docs/catalog_reports/v0.9.9/v099_strength_total_after.md/csv/json
```

O relatório total de musculação deve confirmar:

```text
musculação total: 400
exercícios de musculação novos: 193
duplicados: 0
wrong-results: 0
inacessíveis: 0
D/E: 0
```

## 10.5 Testes

Criar ou atualizar:

```text
test/catalog/catalog_strength_final_coverage_test.dart
test/catalog/catalog_strength_total_good_v1_test.dart
test/catalog/catalog_strength_safety_edge_cases_test.dart
```

## 10.6 Commit

```bash
Complete good v1 strength expansion
```

Parar.

---

# 11. v0.9.9B4A
## Ativação

Branch:

```bash
catalog-activation-expansion-v099b4a
```

Criar a partir de:

```bash
catalog-strength-expansion-v099b3
```

## 11.1 Objetivo

Adicionar +58 exercícios de ativação GOOD_V1.

Meta:

```text
Ativação: 52 -> 110
```

## 11.2 Focos obrigatórios

```text
glúteos
core
escápulas
ombros
adutores
abdutores
anca
tornozelo
punhos
pescoço
```

## 11.3 Exemplos aceitáveis

```text
Ponte de glúteos com pausa
Clamshell com elástico
Monster walk com elástico
Dead bug de ativação
Bird dog controlado
Wall slide escapular
Scapular push-up
Rotação externa com elástico
Adductor squeeze leve
Marcha com miniband
Elevação de gémeos lenta de ativação
Mobilização ativa do tornozelo na parede
Extensão de punho isométrica leve
Chin tuck leve
```

## 11.4 Regras

Ativação não é musculação pesada.

Cada exercício deve ter:

```text
intensidade baixa a moderada
foco em controlo
pouca fadiga
uso antes de treino ou como preparação
linguagem sem promessas médicas
```

## 11.5 Relatórios

Criar:

```text
docs/catalog_reports/v0.9.9/v099b4a_activation_plan.md/csv/json
docs/catalog_reports/v0.9.9/v099b4a_activation_after.md/csv/json
```

## 11.6 Testes

Criar:

```text
test/catalog/catalog_activation_expansion_v099b4a_test.dart
test/catalog/catalog_activation_intensity_contract_test.dart
```

## 11.7 Commit

```bash
Add good v1 activation expansion
```

Parar.

---

# 12. v0.9.9B4B
## Prevenção

Branch:

```bash
catalog-prevention-expansion-v099b4b
```

Criar a partir de:

```bash
catalog-activation-expansion-v099b4a
```

## 12.1 Objetivo

Adicionar +51 exercícios de prevenção GOOD_V1.

Meta:

```text
Prevenção: 44 -> 95
```

## 12.2 Focos obrigatórios

```text
joelho
ombro
lombar
tornozelo
punho
pescoço
anca
cotovelo
escápulas
```

## 12.3 Exemplos aceitáveis

```text
Step-down controlado
Spanish squat isométrico leve
Elevação tibial na parede
Equilíbrio unipodal
Rotação externa com elástico
Y-T-W leve no banco
McGill curl-up modificado
Side plank curto
Hip airplane assistido
Pronação/supinação do antebraço leve
Extensão excêntrica de punho leve
Chin tuck isométrico leve
```

## 12.4 Linguagem obrigatória

Não usar "previne lesões" como garantia.

Usar:

```text
pode ajudar na preparação
trabalho complementar
controlo gradual
reforço leve
tolerância progressiva
não substitui avaliação profissional
```

## 12.5 Relatórios

Criar:

```text
docs/catalog_reports/v0.9.9/v099b4b_prevention_plan.md/csv/json
docs/catalog_reports/v0.9.9/v099b4b_prevention_after.md/csv/json
```

## 12.6 Testes

Criar:

```text
test/catalog/catalog_prevention_expansion_v099b4b_test.dart
test/catalog/catalog_prevention_medical_claims_test.dart
test/catalog/catalog_prevention_safety_language_test.dart
```

## 12.7 Commit

```bash
Add good v1 prevention expansion
```

Parar.

---

# 13. v0.9.9B5A
## Artes marciais gerais: Karate geral

Branch:

```bash
catalog-martial-karate-v099b5a
```

Criar a partir de:

```bash
catalog-prevention-expansion-v099b4b
```

## 13.1 Objetivo

Adicionar parte dos +128 exercícios de artes marciais GOOD_V1, começando por Karate geral.

Não adicionar Shukokai.

## 13.2 Focos de Karate geral

```text
kihon
bases
deslocamentos
socos
defesas
pontapés
kata por blocos
kumite técnico
bunkai básico genérico
sombra de karate
controlo de distância
entrada e saída
```

## 13.3 Exemplos aceitáveis

```text
Zenkutsu dachi com transição controlada
Kokutsu dachi com troca de peso
Kiba dachi com deslocamento lateral
Oi zuki com avanço por fases
Gyaku zuki com recuperação de guarda
Kizami zuki de entrada
Mae geri ao alvo baixo
Mawashi geri baixo técnico
Yoko geri por fases
Age uke com base
Soto uke com recuo
Gedan barai com gyaku zuki
Kata por blocos de 3 movimentos
Kumite técnico de entrada e saída
Bunkai básico de defesa e contra-ataque
```

## 13.4 Regras

Cada exercício marcial deve ter:

```text
modalidade correta
local correto, dojo ou casa se for solo
equipamento correto, se houver
foco técnico claro
nível de contacto
segurança
quando evitar
```

Não confundir:

```text
Karate geral
Shukokai
Kickboxing
Muay Thai
Taekwondo
defesa pessoal
```

## 13.5 Relatórios

Criar:

```text
docs/catalog_reports/v0.9.9/v099b5a_karate_plan.md/csv/json
docs/catalog_reports/v0.9.9/v099b5a_karate_after.md/csv/json
```

## 13.6 Testes

Criar:

```text
test/catalog/catalog_martial_karate_expansion_v099b5a_test.dart
test/catalog/catalog_karate_not_shukokai_test.dart
```

## 13.7 Commit

```bash
Add good v1 general karate expansion
```

Parar.

---

# 14. v0.9.9B5B
## Artes marciais gerais: BJJ, defesa pessoal e condicionamento

Branch:

```bash
catalog-martial-bjj-defense-v099b5b
```

Criar a partir de:

```bash
catalog-martial-karate-v099b5a
```

## 14.1 Objetivo

Completar os +128 exercícios de artes marciais GOOD_V1 sem Shukokai.

Focos:

```text
BJJ solo
BJJ tatami
drills de base
quedas básicas seguras
levantamento técnico
mobilidade marcial
defesa pessoal geral
saco/aparadores
condicionamento marcial
```

## 14.2 Exemplos aceitáveis

```text
Technical stand-up controlado
Shrimp escape por repetições
Bridge and roll drill
Granby roll progressivo
Hip escape em linha
Ponte de grappling com pausa
Entrada de double leg sem impacto
Sprawl técnico controlado
Queda lateral amortecida básica
Queda para trás progressiva
Guarda sentada para technical stand-up
Drill de distância em defesa pessoal
Palm strike ao aparador
Joelhada ao aparador controlada
Round de saco técnico leve
Footwork defensivo em sombra
```

## 14.3 Regras de segurança

Não ensinar agressão real de forma perigosa.

Defesa pessoal deve ser descrita como:

```text
controlo de distância
saída
proteção
posicionamento
redução de risco
treino técnico controlado
```

Evitar:

```text
promessas de neutralizar agressor
técnicas perigosas sem contexto
linguagem violenta
instruções de dano
```

## 14.4 Relatórios

Criar:

```text
docs/catalog_reports/v0.9.9/v099b5b_bjj_defense_plan.md/csv/json
docs/catalog_reports/v0.9.9/v099b5b_bjj_defense_after.md/csv/json
docs/catalog_reports/v0.9.9/v099_martial_total_after.md/csv/json
```

## 14.5 Testes

Criar:

```text
test/catalog/catalog_martial_bjj_defense_v099b5b_test.dart
test/catalog/catalog_martial_safety_contract_test.dart
test/catalog/catalog_martial_total_good_v1_test.dart
```

## 14.6 Commit

```bash
Complete good v1 martial arts expansion
```

Parar.

---

# 15. v0.9.9B6A
## Cardio, aquecimento e recuperação

Branch:

```bash
catalog-cardio-warmup-recovery-v099b6a
```

Criar a partir de:

```bash
catalog-martial-bjj-defense-v099b5b
```

## 15.1 Objetivo

Adicionar:

```text
cardio: +35
aquecimento: +19
recuperação: +28
```

## 15.2 Cardio

Cobrir:

```text
passadeira
bicicleta
corda
caminhada
corrida
baixo impacto
HIIT peso corporal
intervalos
resistência aeróbia
cooldown cardio
```

Exemplos:

```text
Passadeira caminhada inclinada leve
Passadeira intervalos 1:1 moderados
Corrida exterior fácil
Caminhada rápida exterior
Bicicleta cadência constante
Bicicleta intervalos leves
Corda saltos básicos
Corda alternada leve
HIIT baixo impacto sem saltos
Step jacks baixo impacto
```

## 15.3 Aquecimento

Cobrir:

```text
antes de musculação
antes de cardio
antes de Karate
antes de BJJ
membros superiores
membros inferiores
corpo inteiro
articulações principais
```

## 15.4 Recuperação

Cobrir:

```text
respiração
cooldown
caminhada leve
mobilidade leve
foam roller
bola de massagem
relaxamento pós-treino
deload
```

## 15.5 Regras

Recuperação não pode devolver exercício intenso.

Cardio HIIT não pode aparecer em recuperação.

Aquecimento não pode parecer treino principal pesado.

## 15.6 Relatórios

Criar:

```text
docs/catalog_reports/v0.9.9/v099b6a_cardio_warmup_recovery_plan.md/csv/json
docs/catalog_reports/v0.9.9/v099b6a_cardio_warmup_recovery_after.md/csv/json
```

## 15.7 Testes

Criar:

```text
test/catalog/catalog_cardio_expansion_v099b6a_test.dart
test/catalog/catalog_warmup_expansion_v099b6a_test.dart
test/catalog/catalog_recovery_expansion_v099b6a_test.dart
test/catalog/catalog_recovery_no_intensity_regression_test.dart
```

## 15.8 Commit

```bash
Add good v1 cardio warmup and recovery expansion
```

Parar.

---

# 16. v0.9.9B6B
## Mobilidade e elasticidade

Branch:

```bash
catalog-mobility-flexibility-v099b6b
```

Criar a partir de:

```bash
catalog-cardio-warmup-recovery-v099b6a
```

## 16.1 Objetivo

Adicionar:

```text
mobilidade: +37
elasticidade: +38
```

## 16.2 Mobilidade

Cobrir:

```text
anca
ombro
coluna torácica
lombar
tornozelo
punho
pescoço
joelho
escápula
```

Exemplos:

```text
90/90 hip switch controlado
Mobilidade de anca em meio ajoelhado
CARs de ombro controlados
Open book torácico
Rotação torácica em quadrupedia
Dorsiflexão do tornozelo na parede
Mobilidade de punho em quadrupedia
Chin tuck com rotação leve
Deslizamento escapular na parede
```

## 16.3 Elasticidade

Cobrir:

```text
posterior da coxa
flexores da anca
adutores
glúteos
gémeos
peito
dorsais
ombros
pescoço
antebraços
```

Exemplos:

```text
Alongamento posterior da coxa com toalha
Alongamento flexor da anca em meio ajoelhado
Alongamento adutor frog stretch leve
Alongamento glúteo figura 4
Alongamento gémeo na parede
Alongamento peitoral na porta
Alongamento dorsal em banco
Alongamento posterior do ombro
Alongamento flexores do punho
```

## 16.4 Regras

Mobilidade é movimento ativo/controlado.

Elasticidade é alongamento sustentado ou progressivo.

Não misturar sem contexto.

Não prometer curar rigidez ou dor.

## 16.5 Relatórios

Criar:

```text
docs/catalog_reports/v0.9.9/v099b6b_mobility_flexibility_plan.md/csv/json
docs/catalog_reports/v0.9.9/v099b6b_mobility_flexibility_after.md/csv/json
```

## 16.6 Testes

Criar:

```text
test/catalog/catalog_mobility_expansion_v099b6b_test.dart
test/catalog/catalog_flexibility_expansion_v099b6b_test.dart
test/catalog/catalog_mobility_flexibility_separation_test.dart
```

## 16.7 Commit

```bash
Add good v1 mobility and flexibility expansion
```

Parar.

---

# 17. v0.9.9B7
## Auditoria total da expansão GOOD_V1

Branch:

```bash
catalog-good-v1-total-audit-v099b7
```

Criar a partir de:

```bash
catalog-mobility-flexibility-v099b6b
```

## 17.1 Objetivo

Confirmar que a expansão completa foi bem feita.

Meta esperada:

```text
Total: 1765
Musculação: 400
Cardio: 100
Artes marciais: 360
Mobilidade: 230
Elasticidade: 170
Recuperação: 150
Aquecimento: 150
Ativação: 110
Prevenção: 95
```

## 17.2 O que auditar

```text
totais por categoria
totais por subcategoria
totais por equipamento
totais por local
totais por grupo muscular
totais por prioridade
rotas
aliases
filtros
wrong-results
inacessíveis
eixos sem decisão
mensagens vazias
qualidade A/B/C/D/E
duplicados
canonical IDs
tokens internos
promessas médicas
linguagem genérica
```

## 17.3 Relatórios

Criar:

```text
docs/catalog_reports/v0.9.9/v099b7_good_v1_total_audit.md
docs/catalog_reports/v0.9.9/v099b7_good_v1_total_audit.csv
docs/catalog_reports/v0.9.9/v099b7_good_v1_total_audit.json

docs/catalog_reports/v0.9.9/v099b7_category_totals.md
docs/catalog_reports/v0.9.9/v099b7_category_totals.csv
docs/catalog_reports/v0.9.9/v099b7_category_totals.json

docs/catalog_reports/v0.9.9/v099b7_manual_review_pack.md
docs/catalog_reports/v0.9.9/v099b7_manual_review_pack.csv
docs/catalog_reports/v0.9.9/v099b7_manual_review_pack.json
```

## 17.4 Testes

Criar ou atualizar:

```text
test/catalog/catalog_good_v1_total_count_test.dart
test/catalog/catalog_good_v1_category_targets_test.dart
test/catalog/catalog_good_v1_no_duplicate_test.dart
test/catalog/catalog_good_v1_no_wrong_results_test.dart
test/catalog/catalog_good_v1_all_reachable_test.dart
test/catalog/catalog_good_v1_content_quality_test.dart
```

## 17.5 Critérios

A fase só passa se:

```text
total entre 1750 e 1800
todos os exercícios acessíveis
wrong-results 0
D/E 0
duplicados 0
warnings 0
críticos 0
APKs fora do Git
builds passam
```

## 17.6 Commit

```bash
Audit complete good v1 catalog expansion
```

Parar.

---

# 18. v0.9.9C
## Correções finais antes da release candidate

Branch:

```bash
release-prep-v099c
```

Criar a partir de:

```bash
catalog-good-v1-total-audit-v099b7
```

## 18.1 Objetivo

Não adicionar conteúdo novo, exceto se for necessário para corrigir uma lacuna crítica detetada na auditoria B7.

Foco:

```text
corrigir bugs
corrigir rotas
corrigir textos problemáticos
corrigir filtros
corrigir menus
corrigir testes frágeis
corrigir documentação
preparar release
```

## 18.2 Proibições

```text
Não expandir catálogo por gosto.
Não adicionar Shukokai.
Não mexer em estrutura grande da app.
Não alterar versão para 1.0.0 ainda.
Não fazer merge para main ainda.
```

## 18.3 Checklist manual obrigatório

Criar checklist:

```text
docs/catalog_reports/v0.9.9/v099c_manual_pixel_checklist.md
```

Deve incluir testes manuais:

```text
Musculação > Ginásio > Máquinas > Pernas > Leg press
Musculação > Ginásio > Máquinas > Pernas > Leg extension
Musculação > Ginásio > Cabos > Costas > Puxada alta
Musculação > Ginásio > Banco > Peito > Supino
Musculação > Casa equipada > Core > Ab wheel
Cardio > Passadeira > Resistência aeróbia
Cardio > Peso corporal > HIIT
Artes marciais > Dojo > Karate > Karate completo
Artes marciais > Tatami > Jiu-Jitsu
Mobilidade > Anca
Mobilidade > Ombro
Elasticidade > Posterior da coxa
Recuperação > Respiração
Aquecimento > Antes de Karate
Ativação > Adutores
Prevenção > Joelho
Pesquisa por supino
Pesquisa por prancha
Pesquisa por passadeira
Pesquisa por Kihon
Pesquisa por technical stand-up
```

## 18.4 Relatórios

Criar:

```text
docs/catalog_reports/v0.9.9/v099c_release_prep_after.md/csv/json
```

## 18.5 Commit

```bash
Prepare good v1 catalog for release candidate
```

Parar.

---

# 19. v1.0.0 RC
## Release candidate

Branch:

```bash
release-v100-rc
```

Criar a partir de:

```bash
release-prep-v099c
```

## 19.1 Objetivo

Congelar features.

Não adicionar exercícios.

Não alterar catálogo sem bug crítico.

## 19.2 Atualizar versão

Só nesta fase:

```text
pubspec.yaml -> 1.0.0-rc.1
CHANGELOG.md -> EveFit v1.0.0 RC
```

## 19.3 Auditoria final RC

Criar:

```text
docs/catalog_reports/v1.0.0/v100_rc_audit.md
docs/catalog_reports/v1.0.0/v100_rc_audit.csv
docs/catalog_reports/v1.0.0/v100_rc_audit.json
```

Incluir:

```text
total de exercícios
total por categoria
total por subcategoria
total por equipamento
wrong-results
inacessíveis
menus vazios
decisões de menus vazios
qualidade A/B/C/D/E
duplicados
testes
builds
estado do Git
APKs rastreados
```

## 19.4 Validação RC

Correr:

```bash
flutter clean
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
flutter test -r compact
dart run tool/catalog_audit_report.dart --strict
flutter build apk --debug
flutter build apk --release
```

## 19.5 Teste no Pixel

Instalar APK release e executar checklist manual.

Criar:

```text
docs/catalog_reports/v1.0.0/v100_rc_pixel_test.md
```

Resultado por item:

```text
PASS
FAIL
NEEDS_FIX
NOT_TESTED
```

## 19.6 Commit

```bash
Prepare EveFit v1.0.0 release candidate
```

Parar.

---

# 20. v1.0.0 final
## Release final

Branch:

```bash
release-v100
```

Criar a partir de:

```bash
release-v100-rc
```

## 20.1 Só avançar se RC estiver aprovado

Não avançar se existir:

```text
FAIL
NEEDS_FIX
wrong-results
inacessíveis
D/E
críticos
warnings
APK rastreado
build quebrada
```

## 20.2 Atualizar versão final

```text
pubspec.yaml -> 1.0.0
CHANGELOG.md -> EveFit v1.0.0
```

## 20.3 Relatório final

Criar:

```text
docs/catalog_reports/v1.0.0/v100_release_audit.md
docs/catalog_reports/v1.0.0/v100_release_audit.csv
docs/catalog_reports/v1.0.0/v100_release_audit.json
```

Deve confirmar:

```text
total final: cerca de 1765
wrong-results: 0
inacessíveis: 0
D/E: 0
críticos: 0
warnings: 0
build debug: passou
build release: passou
teste manual: aprovado
APKs fora do Git
```

## 20.4 Git final

Comandos esperados, depois de aprovação humana:

```bash
git status --short
git push origin release-v100
```

Depois, apenas com aprovação:

```bash
git checkout main
git pull origin main
git merge --no-ff release-v100
git push origin main
git tag v1.0.0
git push origin v1.0.0
```

## 20.5 GitHub Release

Criar release:

```text
Título: EveFit v1.0.0

Notas:
- Catálogo GOOD_V1 com cerca de 1765 exercícios
- Wrong-results eliminados
- Exercícios acessíveis por rotas válidas
- Menus vazios com decisões explícitas
- Qualidade textual validada
- Hardening crítico aplicado
- Builds debug e release validadas
```

Anexar APK release na release do GitHub, não no repositório.

## 20.6 Commit

```bash
Release EveFit v1.0.0
```

---

# 21. Modelo de resposta final que o Codex deve usar em todas as fases

No fim de cada fase, responder neste formato:

```text
Fase <nome> concluída e parada. Não avancei para <fase seguinte>.

1. Commit:
2. Branch atual:
3. Branch anterior pushed:
4. Exercícios adicionados:
5. Total antes:
6. Total depois:
7. Categoria principal antes/depois:
8. Por equipamento:
9. Por grupo muscular:
10. Por prioridade:
11. Duplicados encontrados:
12. Wrong-results depois:
13. Inacessíveis depois:
14. Qualidade A/B/C/D/E depois:
15. Relatórios criados:
16. Ficheiros alterados:
17. Testes executados:
18. Builds:
19. Confirmação: não adicionei fora da fase.
20. Confirmação: não apaguei exercícios.
21. Confirmação: não escondi menus.
22. Confirmação: não mexi em Shukokai, salvo se a fase for explicitamente Shukokai.
23. Confirmação: não fiz merge para main.
24. git status --short final:
```

Sem esta resposta, a fase não fica aceite.

---

# 22. Critério final da v1.0

A v1.0 só está pronta quando isto for verdadeiro:

```text
A app tem cerca de 1765 exercícios reais.
Cada exercício tem nome real.
Cada exercício tem músculos corretos.
Cada exercício tem equipamento correto.
Cada exercício tem rotas corretas.
Cada exercício é acessível.
Nenhum filtro devolve coisa errada.
Nenhum menu visível engana o utilizador.
Nenhuma descrição visível é fraca.
Nenhum exercício de prevenção faz promessa médica.
Nenhum APK está commitado.
Todas as validações passam.
O Pixel test passa.
A release está tagada.
```

Esta é a definição de feito.

Não aceitar menos que isto para v1.0.
