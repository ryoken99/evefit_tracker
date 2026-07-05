# 04 - Checklist de validação da ontologia

## Objetivo

Validar se a reconstrução dos catálogos está correta antes de implementar na app.

## Checklist geral

Um catálogo falha se:

```text
começa por filtros em vez de conceitos
duplica exercícios por aparecerem em várias categorias
tem exercícios sem conceito
tem conceitos sem exercícios derivados
tem filtros que misturam tipo, uso e equipamento
tem descrições genéricas
tem músculos sem funções mapeadas
tem cardio sem intensidade
tem artes marciais sem arte ou habilidade
tem recuperação misturada com mobilidade sem contexto
```

## Validação de conceitos

Cada conceito deve ter:

```text
id
nome
domínio
capacidade treinada
estrutura ou habilidade alvo
função
padrão
contexto de uso
equipamentos possíveis
locais possíveis
exercícios derivados
filtros possíveis
```

Falha se:

```text
é apenas o nome de um exercício
é demasiado específico
não gera exercícios
não tem utilidade prática
não tem contexto
```

## Validação de exercícios

Cada exercício deve ter:

```text
id
nome
concept_id
família
variação
primary_type
use_contexts
capacidades treinadas
estruturas principais
padrão
equipamento
locais
intensidade
nível
filtros
objetivo
como fazer
erros comuns
regressão
progressão
cuidados quando necessário
```

Falha se:

```text
não tem concept_id
não tem primary_type
aparece em filtro errado
não aparece em filtro onde devia
usa equipamento incoerente
tem texto genérico
tem passos vagos
tem nome duplicado sem razão
```

## Validação de musculação

Para cada músculo ou estrutura, confirmar:

```text
funções anatómicas listadas
capacidades treináveis listadas
conceitos principais listados
famílias de exercícios listadas
variações reais por equipamento listadas
exercícios de força, hipertrofia e resistência considerados
exercícios isométricos e excêntricos considerados quando fazem sentido
exercícios práticos ou funcionais considerados quando fazem sentido
```

Falha se:

```text
só existe um exercício por músculo
não há diferença entre força, hipertrofia e resistência
não há linha de resistência
não há posição articular
não há equipamento mapeado
```

## Validação de cardio

Cada exercício de cardio deve ter:

```text
modalidade
intensidade
impacto
sistema ou capacidade
duração típica
contexto de uso
equipamento
local
```

Falha se:

```text
não distingue aquecimento de treino principal
não distingue recuperação ativa de cardio leve
não distingue HIIT de resistência contínua
não marca impacto
não marca intensidade
```

Exemplos obrigatórios:

```text
Caminhada leve aparece em Cardio, Aquecimento e Recuperação.
Passadeira sprints aparece em Cardio intenso e Intervalos.
Shadow boxing leve aparece em Artes marciais e Cardio leve.
Shuttle runs aparecem em Cardio intenso e Mudanças de direção.
```

## Validação de artes marciais

Cada exercício marcial deve ter:

```text
arte principal
habilidade
família técnica
contexto
nível
segurança
uso solo ou parceiro
equipamento
local
```

Artes obrigatórias:

```text
Karate
Jiu-Jitsu / BJJ
Boxe
Kickboxing
Muay Thai
Judo
Taekwondo
MMA / Defesa pessoal funcional
```

Falha se:

```text
mistura todas as artes numa lista única
não separa técnica de condicionamento
não explica para iniciantes
promete eficácia irreal em defesa pessoal
não distingue desporto de defesa pessoal
```

Exemplos obrigatórios:

```text
Jab aparece em Boxe, Kickboxing, Muay Thai e MMA / Defesa pessoal.
Sprawl aparece em Jiu-Jitsu / BJJ, Grappling e MMA / Defesa pessoal.
Technical stand-up aparece em Jiu-Jitsu / BJJ e Defesa pessoal.
Low kick aparece em Muay Thai, Kickboxing e MMA.
Ukemi aparece em Judo, Jiu-Jitsu / BJJ e prevenção de quedas.
```

## Validação de mobilidade

Cada exercício de mobilidade deve ter:

```text
articulação
grau de liberdade
amplitude ativa
controlo
posição
contexto
```

Falha se:

```text
é apenas alongamento passivo
não tem articulação alvo
não explica controlo ativo
não distingue mobilidade de elasticidade
```

## Validação de elasticidade

Cada exercício de elasticidade deve ter:

```text
zona ou músculo
direção de alongamento
método
intensidade
contexto
cuidados
```

Métodos aceites:

```text
estático
dinâmico
PNF
passivo
ativo assistido
```

Falha se:

```text
não distingue método
não tem zona alvo
não tem cuidados
é confundido com mobilidade ativa
```

## Validação de recuperação

Cada exercício de recuperação deve ter:

```text
objetivo
método
zona opcional
intensidade baixa
contexto
momento do treino
```

Falha se:

```text
é treino principal disfarçado
não baixa fadiga
não tem objetivo de recuperação
não distingue cooldown de aquecimento
```

## Validação dos filtros

Um filtro é bom quando:

```text
o utilizador percebe o caminho
não mistura conceitos incompatíveis
mostra exercícios úteis
não esconde exercícios relevantes
não cria duplicados
```

Falha se:

```text
um exercício só aparece em “mostrar todos”
um exercício aparece por texto aleatório
um exercício de equipamento específico aparece sem esse equipamento
um exercício de arte marcial aparece na arte errada sem motivo
um cardio leve aparece como treino intenso
```

## Validação das descrições

Cada descrição deve responder:

```text
Para que serve?
Quando usar?
Como fazer?
Que erro evitar?
Como facilitar?
Como dificultar?
Que cuidado ter?
```

Falha se contém:

```text
conforme a variação
exercício genérico
usa a carga indicada
não deixar a carga cair
afastar a carga
descrição genérica
N/A
TODO
```

## Testes mínimos obrigatórios

```text
todos os conceitos têm exercícios derivados
todos os exercícios têm concept_id
todos os exercícios têm primary_type
todos os exercícios têm pelo menos um filtro
todos os exercícios têm equipamento
todos os exercícios têm local
todos os exercícios têm descrição
todos os exercícios têm passos
todos os exercícios têm erros comuns
todos os exercícios cruzados mantêm identidade única
todos os exercícios de defesa pessoal têm aviso realista
```

## Critério de aprovação

A ontologia está aprovada quando:

```text
consegue gerar exercícios
consegue impedir duplicados
consegue explicar cruzamentos
consegue separar tipo, uso e filtro
consegue suportar expansão futura
consegue ser testada por código
```
