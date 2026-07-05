# 12 - Cardio: conceitos, modalidades, intensidades e usos

## Objetivo

Este ficheiro reconstrói o catálogo de cardio da EveFit a partir de conceitos treináveis.

A regra base é:

```text
Cardio não é uma lista de máquinas.
Cardio é treino de sistemas energéticos, intensidade, duração, impacto, modalidade e contexto de uso.
```

Um exercício concreto de cardio só deve existir depois de sabermos que conceito ele representa.

Exemplo:

```text
Conceito: cardio contínuo leve de baixo impacto
Exercícios derivados: caminhada leve, bicicleta leve, elíptica leve, passadeira caminhada, air bike leve
```

---

# Modelo conceptual do cardio

## Camadas de decisão

Cada exercício de cardio deve ser classificado por:

```text
sistema energético
capacidade treinada
intensidade
duração
impacto
modalidade
contexto de uso
equipamento
local
filtro visível da app
```

## Sistemas energéticos

```text
aeróbio leve
aeróbio moderado
aeróbio alto
anaeróbio lático
anaeróbio alático
misto
recuperativo
```

## Capacidades treináveis

```text
base aeróbia
zona 2
resistência contínua
limiar aeróbio
limiar anaeróbio
VO2 máximo
capacidade intervalada
sprint
potência anaeróbia
recuperação entre esforços
tolerância à fadiga
mudanças de direção
condicionamento geral
condicionamento para artes marciais
aquecimento cardiovascular
cooldown
recuperação ativa
perda de gordura
coordenação rítmica
```

## Intensidades

```text
muito leve
leve
moderada
moderada alta
alta
máxima
intervalada
variável
```

## Impacto

```text
sem impacto
baixo impacto
médio impacto
alto impacto
impacto variável
```

## Contextos de uso

```text
aquecimento
treino principal
finisher
cooldown
recuperação ativa
dia de descanso
condicionamento geral
condicionamento específico
perda de gordura
preparação para artes marciais
```

---

# Modalidades principais

## Sem equipamento

```text
marcha no lugar
caminhada exterior
corrida exterior
high knees
jumping jacks
burpees
skaters
mountain climbers
shuttle runs
sprints
shadow boxing
circuitos peso corporal
```

## Máquinas de cardio

```text
passadeira
bicicleta
elíptica
remo ergómetro
stepper / escadas
air bike
```

## Equipamento simples

```text
corda de saltar
saco de pancada, quando usado por rounds
paos / aparadores, quando usados por rounds
```

## Exterior

```text
caminhada
corrida
subidas
escadas
sprints
shuttle runs
corrida em subida
```

## Artes marciais como cardio

```text
shadow boxing leve
shadow boxing por rounds
rounds no saco
footwork por tempo
sprawls intervalados
pontapés por tempo
combinações por rounds
```

---

# Conceitos principais de cardio

## 1. Cardio contínuo muito leve

```text
concept_id: very_low_intensity_continuous_cardio
```

Objetivo: manter movimento suave, aumentar circulação e preparar o corpo sem fadiga relevante.

Capacidades:

```text
circulação leve
recuperação ativa
aquecimento cardiovascular suave
controlo respiratório
```

Intensidade:

```text
muito leve
```

Impacto:

```text
sem impacto
baixo impacto
```

Contextos:

```text
aquecimento
cooldown
recuperação ativa
dia de descanso
retorno ao movimento
```

Exercícios derivados:

```text
caminhada muito leve
marcha no lugar lenta
bicicleta muito leve
elíptica muito leve
air bike muito leve
passadeira caminhada muito leve
```

Nota: deve aparecer em Cardio, Recuperação e Aquecimento. Não deve aparecer como treino intenso.

---

## 2. Cardio contínuo leve de baixo impacto

```text
concept_id: low_intensity_continuous_cardio
```

Objetivo: criar movimento cardiovascular leve, sustentável e fácil de recuperar.

Capacidades:

```text
base aeróbia inicial
recuperação ativa
aquecimento cardiovascular
circulação
perda de gordura em baixa intensidade
```

Intensidade:

```text
leve
```

Impacto:

```text
baixo impacto
sem impacto, dependendo da modalidade
```

Contextos:

```text
aquecimento
treino principal leve
cooldown
recuperação ativa
dia de descanso
```

Exercícios derivados:

```text
caminhada leve
passadeira caminhada
passadeira caminhada inclinada leve
bicicleta ritmo leve
elíptica ritmo leve
remo ergómetro ritmo leve
air bike ritmo leve
corda de saltar ritmo muito leve, se tecnicamente possível
shadow boxing leve
```

Nota: caminhada leve é o exemplo principal de exercício cruzado entre cardio, aquecimento e recuperação.

---

## 3. Zona 2

```text
concept_id: zone_2_aerobic_base_cardio
```

Objetivo: construir base aeróbia sustentável, com esforço controlado e respirável.

Capacidades:

```text
base aeróbia
eficiência cardiovascular
resistência contínua
recuperação entre treinos
capacidade de manter ritmo
```

Intensidade:

```text
leve a moderada
```

Impacto:

```text
baixo, médio ou sem impacto conforme modalidade
```

Contextos:

```text
treino principal
condicionamento geral
perda de gordura
base para artes marciais
dia leve
```

Exercícios derivados:

```text
caminhada rápida
passadeira inclinação moderada
corrida leve controlada
bicicleta ritmo moderado controlado
elíptica ritmo moderado
remo ergómetro ritmo contínuo leve a moderado
air bike ritmo contínuo leve a moderado
subida de escadas moderada
```

Nota: zona 2 não deve ser definida apenas por máquina. A app pode permitir prescrição por sensação: respiração acelerada mas controlável, sem esforço máximo.

---

## 4. Cardio contínuo moderado

```text
concept_id: moderate_intensity_continuous_cardio
```

Objetivo: melhorar resistência cardiovascular com esforço claro mas sustentável.

Capacidades:

```text
resistência contínua
tolerância à fadiga
capacidade aeróbia moderada
ritmo estável
```

Intensidade:

```text
moderada
```

Impacto:

```text
baixo a médio
```

Contextos:

```text
treino principal
condicionamento geral
perda de gordura
resistência
```

Exercícios derivados:

```text
corrida exterior moderada
passadeira corrida leve a moderada
bicicleta ritmo moderado
elíptica ritmo moderado
remo ergómetro ritmo contínuo moderado
stepper ritmo contínuo
air bike ritmo contínuo moderado
caminhada exterior rápida
```

Nota: este bloco já é treino principal. Não deve aparecer como recuperação por defeito.

---

## 5. Cardio de limiar

```text
concept_id: threshold_cardio
```

Objetivo: treinar a capacidade de manter esforço forte, perto do limite sustentável.

Capacidades:

```text
limiar aeróbio alto
limiar anaeróbio
tolerância à fadiga
ritmo forte sustentável
controlo de esforço
```

Intensidade:

```text
moderada alta
alta
```

Impacto:

```text
variável
```

Contextos:

```text
treino principal
condicionamento avançado
performance
```

Exercícios derivados:

```text
corrida tempo
passadeira ritmo forte contínuo
bicicleta ritmo forte
remo ergómetro ritmo forte
air bike ritmo forte
elíptica ritmo forte
rounds longos no saco a ritmo controlado forte
```

Nota: este conceito é mais avançado e não deve ser recomendado como recuperação.

---

## 6. Intervalos moderados

```text
concept_id: moderate_interval_cardio
```

Objetivo: alternar períodos de esforço moderado com recuperação parcial.

Capacidades:

```text
capacidade intervalada
recuperação entre esforços
resistência cardiovascular
controlo de ritmo
```

Intensidade:

```text
moderada
intervalada
```

Impacto:

```text
baixo a médio
```

Contextos:

```text
treino principal
condicionamento geral
preparação para HIIT
```

Exercícios derivados:

```text
passadeira intervalada moderada
bicicleta intervalos moderados
elíptica intervalos moderados
remo ergómetro intervalos moderados
air bike intervalos moderados
corda de saltar intervalos leves a moderados
caminhada rápida alternada com caminhada leve
```

Nota: este bloco é importante para iniciantes antes de entrarem em HIIT pesado.

---

## 7. HIIT cardiovascular

```text
concept_id: high_intensity_interval_cardio
```

Objetivo: treinar esforço alto em blocos curtos ou médios com pausas.

Capacidades:

```text
VO2 máximo
capacidade anaeróbia
tolerância à fadiga
recuperação entre esforços
potência cardiovascular
```

Intensidade:

```text
alta
intervalada
```

Impacto:

```text
variável
```

Contextos:

```text
treino principal
finisher
condicionamento
perda de gordura
```

Exercícios derivados:

```text
HIIT peso corporal
HIIT passadeira
HIIT bicicleta
HIIT corda
HIIT air bike
HIIT remo ergómetro
burpees intervalados
mountain climbers intervalados
jumping jacks intervalados
skaters intervalados
```

Nota: HIIT não é qualquer circuito cansativo. Deve ter intensidade alta e descanso ou alternância clara.

---

## 8. Sprints

```text
concept_id: sprint_cardio
```

Objetivo: treinar esforço máximo ou quase máximo por períodos curtos.

Capacidades:

```text
potência anaeróbia
velocidade
explosividade
capacidade alática
recuperação entre esforços máximos
```

Intensidade:

```text
máxima
alta
```

Impacto:

```text
alto
```

Contextos:

```text
treino principal
condicionamento avançado
finisher avançado
performance
```

Exercícios derivados:

```text
sprints exterior
passadeira sprints
corrida em subida
sprints em subida
air bike sprints
bicicleta sprints
shuttle sprints
```

Nota: sprints são mais exigentes para tendões, gémeos, posterior de coxa e articulações. Devem ter progressão cuidadosa.

---

## 9. Mudanças de direção e agilidade cardiovascular

```text
concept_id: change_of_direction_cardio
```

Objetivo: treinar cardio com aceleração, desaceleração, coordenação e mudança de direção.

Capacidades:

```text
mudanças de direção
agilidade
coordenação
capacidade anaeróbia
condicionamento para desporto
controlo de travagem
```

Intensidade:

```text
moderada
alta
variável
```

Impacto:

```text
médio
alto
```

Contextos:

```text
treino principal
condicionamento específico
artes marciais
performance
```

Exercícios derivados:

```text
shuttle runs
corrida vaivém
skaters
deslocamentos laterais por tempo
footwork em linhas
sprints com mudança de direção
```

Nota: este conceito deve cruzar cardio, artes marciais e preparação física.

---

## 10. Cardio com corda

```text
concept_id: jump_rope_cardio
```

Objetivo: treinar ritmo, coordenação, resistência cardiovascular e elasticidade leve do tornozelo.

Capacidades:

```text
coordenação rítmica
resistência cardiovascular
capacidade intervalada
resistência de gémeos
footwork leve
```

Intensidade:

```text
leve
moderada
alta
intervalada
```

Impacto:

```text
médio
alto, se intenso
```

Contextos:

```text
aquecimento
treino principal
finisher
condicionamento para artes marciais
```

Exercícios derivados:

```text
corda de saltar ritmo leve
corda de saltar ritmo moderado
corda de saltar intervalos
corda de saltar pés alternados
corda de saltar joelhos altos
corda de saltar double unders
```

Nota: a corda deve ter progressões técnicas. Double unders não são iniciante.

---

## 11. Cardio em máquina de baixo impacto

```text
concept_id: low_impact_machine_cardio
```

Objetivo: treinar sistema cardiovascular reduzindo impacto articular.

Capacidades:

```text
base aeróbia
resistência contínua
recuperação ativa
condicionamento geral
```

Intensidade:

```text
leve
moderada
alta, dependendo da máquina
```

Impacto:

```text
sem impacto
baixo impacto
```

Contextos:

```text
aquecimento
treino principal
cooldown
recuperação ativa
```

Exercícios derivados:

```text
bicicleta ritmo leve
bicicleta ritmo moderado
bicicleta intervalos
elíptica ritmo leve
elíptica ritmo moderado
elíptica intervalos
remo ergómetro ritmo contínuo
remo ergómetro intervalos
air bike ritmo contínuo
air bike intervalos
```

Nota: bloco importante para utilizadores com dores, fadiga, excesso de impacto ou recuperação.

---

## 12. Cardio em passadeira

```text
concept_id: treadmill_cardio
```

Objetivo: treinar caminhada ou corrida em ambiente controlado.

Capacidades:

```text
base aeróbia
resistência contínua
intervalos
inclinação
sprints
aquecimento
cooldown
```

Intensidade:

```text
muito leve
leve
moderada
alta
intervalada
```

Impacto:

```text
baixo a alto
```

Contextos:

```text
aquecimento
treino principal
finisher
cooldown
recuperação ativa
```

Exercícios derivados:

```text
passadeira aquecimento
passadeira caminhada
passadeira caminhada rápida
passadeira caminhada inclinada
passadeira inclinação moderada
passadeira corrida leve
passadeira corrida intervalada
passadeira sprints
passadeira cooldown
```

Nota: a passadeira não é um conceito único. É uma plataforma que implementa vários conceitos de cardio.

---

## 13. Cardio exterior

```text
concept_id: outdoor_locomotion_cardio
```

Objetivo: treinar locomoção real em ambiente exterior, com variação natural de piso, inclinação e ritmo.

Capacidades:

```text
base aeróbia
resistência
ritmo
mudanças de terreno
sprints
subidas
```

Intensidade:

```text
leve
moderada
alta
variável
```

Impacto:

```text
baixo
médio
alto
```

Contextos:

```text
treino principal
recuperação ativa
aquecimento
perda de gordura
condicionamento
```

Exercícios derivados:

```text
caminhada exterior leve
caminhada exterior moderada
caminhada exterior rápida
caminhada exterior em subida
corrida exterior leve
corrida exterior moderada
corrida exterior intervalada
sprints exterior
corrida em subida
subida de escadas no exterior
```

Nota: exterior deve ser local, modalidade e contexto.

---

## 14. Circuitos cardiovasculares com peso corporal

```text
concept_id: bodyweight_cardio_circuit
```

Objetivo: treinar cardio com movimentos corporais alternados.

Capacidades:

```text
condicionamento geral
resistência muscular
capacidade cardiovascular
coordenação
tolerância à fadiga
```

Intensidade:

```text
leve
moderada
alta
variável
```

Impacto:

```text
baixo
médio
alto
```

Contextos:

```text
treino principal
finisher
condicionamento
aquecimento, se leve
```

Exercícios derivados:

```text
circuito cardio peso corporal
circuito cardio leve
HIIT simples
jumping jacks
burpees
mountain climbers
skaters
high knees
```

Nota: um circuito pode ser cardio, força-resistência ou HIIT. A diferença vem de intensidade, descanso e seleção de movimentos.

---

## 15. Cardio técnico de striking

```text
concept_id: striking_technical_cardio
```

Objetivo: treinar cardio com técnica de golpes, ritmo, coordenação e deslocamento.

Capacidades:

```text
condicionamento para artes marciais
coordenação
ritmo
footwork
resistência específica
controlo respiratório em striking
```

Intensidade:

```text
leve
moderada
alta
variável
```

Impacto:

```text
baixo
médio
```

Contextos:

```text
aquecimento técnico
treino principal
condicionamento específico
artes marciais
finisher
```

Exercícios derivados:

```text
shadow boxing leve
shadow boxing por rounds
shadow boxing com footwork
rounds no saco ritmo leve
rounds no saco ritmo moderado
rounds no saco ritmo forte
combinações por tempo
pontapés por tempo
```

Nota: este bloco tem primary_type artes_marciais quando o foco é técnica. Pode ter secondary_type cardio quando a prescrição é por tempo, rounds ou intensidade.

---

## 16. Cardio técnico de grappling

```text
concept_id: grappling_technical_cardio
```

Objetivo: treinar cardio com padrões de solo, transições e movimentos de grappling.

Capacidades:

```text
condicionamento para grappling
resistência específica
mobilidade dinâmica
coordenação
capacidade intervalada
core dinâmico
```

Intensidade:

```text
leve
moderada
alta
variável
```

Impacto:

```text
baixo
médio
```

Contextos:

```text
aquecimento técnico
treino principal
condicionamento específico
artes marciais
finisher
```

Exercícios derivados:

```text
shrimp por tempo
technical stand-up por tempo
sprawls intervalados
rolamentos de solo por tempo
drills de guarda por tempo
drills de passagem por tempo
ponte de grappling por repetições rápidas
```

Nota: estes exercícios devem existir principalmente em artes marciais, mas podem aparecer em cardio específico e condicionamento.

---

## 17. Cooldown cardiovascular

```text
concept_id: cardiovascular_cooldown
```

Objetivo: reduzir gradualmente intensidade e frequência cardíaca após treino.

Capacidades:

```text
recuperação
controlo respiratório
redução gradual de esforço
circulação leve
```

Intensidade:

```text
muito leve
leve
```

Impacto:

```text
sem impacto
baixo impacto
```

Contextos:

```text
cooldown
pós-treino
recuperação
```

Exercícios derivados:

```text
passadeira cooldown
bicicleta cooldown
elíptica cooldown
caminhada leve pós-treino
remo ergómetro cooldown leve
air bike cooldown leve
```

Nota: cooldown não deve ser confundido com treino principal. Pode usar as mesmas modalidades, mas com objetivo diferente.

---

# Filtros recomendados para a app

## Por intensidade

```text
Cardio
  > Muito leve
  > Leve
  > Moderado
  > Moderado alto
  > Alto
  > Máximo / sprints
  > Intervalado
```

## Por objetivo

```text
Cardio
  > Aquecimento
  > Base aeróbia
  > Zona 2
  > Resistência
  > HIIT
  > Sprints
  > Perda de gordura
  > Recuperação ativa
  > Cooldown
  > Condicionamento para artes marciais
```

## Por modalidade

```text
Cardio
  > Caminhada
  > Corrida
  > Passadeira
  > Bicicleta
  > Elíptica
  > Remo
  > Corda
  > Escadas / stepper
  > Air bike
  > Circuitos
  > Exterior
  > Artes marciais
```

## Por impacto

```text
Cardio
  > Sem impacto
  > Baixo impacto
  > Médio impacto
  > Alto impacto
```

## Por local

```text
Cardio
  > Casa sem equipamento
  > Casa equipada
  > Ginásio
  > Exterior
  > Dojo / tatami
```

---

# Regras de cruzamento

## Cardio que também é aquecimento

Exemplos:

```text
caminhada leve
passadeira aquecimento
bicicleta ritmo leve
corda ritmo leve
shadow boxing leve
marcha no lugar
```

Critério:

```text
intensidade leve
baixa fadiga
prepara o corpo para treino posterior
```

## Cardio que também é recuperação

Exemplos:

```text
caminhada leve
bicicleta muito leve
elíptica muito leve
passadeira cooldown
air bike muito leve
```

Critério:

```text
intensidade muito leve ou leve
ajuda circulação
não aumenta fadiga de forma relevante
```

## Cardio que também é artes marciais

Exemplos:

```text
shadow boxing
rounds no saco
sprawls intervalados
technical stand-up por tempo
footwork por rounds
pontapés por tempo
```

Critério:

```text
tem habilidade marcial real
usa estrutura de rounds, tempo ou esforço cardiovascular
```

## Cardio que também é resistência muscular

Exemplos:

```text
burpees
mountain climbers
circuitos peso corporal
farmer walk rápido, se usado por tempo
```

Critério:

```text
também cria fadiga muscular local
mas a prescrição principal pode ser cardiovascular
```

---

# Exemplos canónicos

## Caminhada leve

```yaml
id: caminhada_leve
concept_id: low_intensity_continuous_cardio
primary_type: cardio
secondary_types:
  - recuperacao
  - aquecimento_ativacao_prevencao
use_contexts:
  - aquecimento
  - cooldown
  - recuperacao_ativa
  - treino_principal_leve
intensidade:
  - leve
impacto:
  - baixo
equipamento:
  - peso_corporal
locais:
  - exterior
  - casa_sem_equipamento
  - ginasio
filtros:
  - Cardio > Leve
  - Cardio > Caminhada
  - Aquecimento > Cardio leve
  - Recuperação > Recuperação ativa
```

## Passadeira sprints

```yaml
id: passadeira_sprints
concept_id: sprint_cardio
primary_type: cardio
secondary_types:
  - condicionamento
use_contexts:
  - treino_principal
  - finisher_avancado
intensidade:
  - alta
  - maxima
impacto:
  - alto
equipamento:
  - passadeira
locais:
  - ginasio
  - casa_equipada
filtros:
  - Cardio > Alta intensidade
  - Cardio > Sprints
  - Cardio > Passadeira
```

## Shadow boxing leve

```yaml
id: shadow_boxing_leve
concept_id: striking_technical_cardio
primary_type: artes_marciais
secondary_types:
  - cardio
  - aquecimento_ativacao_prevencao
use_contexts:
  - aquecimento_tecnico
  - cardio_leve
  - coordenacao
intensidade:
  - leve
impacto:
  - baixo
equipamento:
  - peso_corporal
locais:
  - casa_sem_equipamento
  - dojo
  - exterior
  - ginasio
filtros:
  - Artes marciais > Striking > Sombra
  - Cardio > Leve
  - Cardio > Artes marciais
  - Aquecimento > Técnico
```

## Sprawls intervalados

```yaml
id: sprawls_intervalados
concept_id: grappling_technical_cardio
primary_type: artes_marciais
secondary_types:
  - cardio
  - condicionamento
use_contexts:
  - treino_principal
  - condicionamento_para_grappling
  - finisher
intensidade:
  - moderada
  - alta
impacto:
  - medio
equipamento:
  - peso_corporal
locais:
  - dojo
  - tatami
  - ginasio
  - casa_sem_equipamento
filtros:
  - Artes marciais > Jiu-Jitsu / BJJ > Sprawl
  - Artes marciais > MMA / Defesa pessoal > Defesa de queda
  - Cardio > Artes marciais
  - Cardio > Intervalado
```

---

# Regras para descrições de cardio

Cada exercício de cardio deve explicar:

```text
objetivo
intensidade esperada
respiração esperada
duração típica
como começar
como manter o ritmo
quando parar ou reduzir
como facilitar
como dificultar
cuidados
```

Exemplo correto:

```text
Objetivo:
Criar movimento cardiovascular leve sem acumular fadiga.

Como fazer:
1. Caminha a um ritmo confortável.
2. Mantém respiração controlada.
3. Mantém postura alta e passada natural.
4. Continua durante o tempo definido.
5. Reduz o ritmo se começares a ficar ofegante.

Erros comuns:
- Começar depressa demais.
- Transformar recuperação em treino intenso.
- Caminhar com postura colapsada.
```

Descrição errada:

```text
Faz caminhada para melhorar o cardio.
```

Isto é genérico demais e não ensina nada.

---

# Testes obrigatórios para cardio

O catálogo de cardio deve validar:

```text
todo exercício de cardio tem concept_id
todo exercício de cardio tem intensidade
todo exercício de cardio tem impacto
todo exercício de cardio tem modalidade
todo exercício de cardio tem contexto de uso
todo exercício de cardio tem local
todo exercício de cardio tem equipamento ou sem equipamento
todo cardio leve cruzado com recuperação mantém identidade única
todo cardio marcial cruza com artes marciais sem duplicar
todo HIIT tem indicação de alta intensidade ou intervalado
todo sprint tem aviso de impacto alto ou progressão cuidadosa
```

Casos de teste específicos:

```text
caminhada_leve aparece em Cardio, Aquecimento e Recuperação
passadeira_sprints aparece em Cardio > Sprints e Cardio > Passadeira
shadow_boxing_leve aparece em Artes marciais, Cardio leve e Aquecimento técnico
sprawls_intervalados aparece em Jiu-Jitsu, MMA funcional e Cardio intervalado
bicicleta_ritmo_leve aparece em Cardio, Recuperação e Aquecimento
HIIT_peso_corporal não aparece como recuperação
cooldown_passadeira não aparece como HIIT
```

---

# Critério de conclusão deste ficheiro

Este ficheiro define os conceitos de cardio, as modalidades, as intensidades e as regras de cruzamento.

O próximo ficheiro deve transformar estes conceitos em lista de exercícios derivados:

```text
13_CARDIO_EXERCICIOS_DERIVADOS.md
```

Esse próximo ficheiro deve conter:

```text
concept_id
exercício derivado
modalidade
intensidade
impacto
equipamento
local
contextos de uso
filtros prováveis
notas de duplicação
```
