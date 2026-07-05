# 00 - Mapa conceptual de treino EveFit

## Objetivo

Este documento define a base para reconstruir os catálogos da EveFit a partir de conceitos treináveis.

Regra principal:

```text
Não mapear infinitas variações de exercícios.
Mapear os conceitos treináveis que geram exercícios.
```

Um exercício concreto é uma implementação de um conceito. O catálogo começa pelo conceito e só depois gera exercícios, variações, equipamentos, locais e filtros.

## Problema que este modelo resolve

O catálogo antigo mistura tipo de treino, objetivo, filtro da app e nome concreto do exercício.

Exemplo:

```text
Shadow boxing leve
- Pode ser artes marciais.
- Pode ser cardio leve.
- Pode ser aquecimento.
- Pode ser defesa pessoal.
```

Isto não deve criar quatro exercícios duplicados.

O correto:

```text
Um exercício canónico.
Vários contextos de uso.
Vários filtros.
Uma identidade única.
```

## Unidade central

```text
Conceito treinável
```

Um conceito treinável descreve uma capacidade, função, padrão ou habilidade que pode ser desenvolvida.

Exemplos:

```text
Flexão do cotovelo com pega supinada contra resistência.
Cardio contínuo leve de baixo impacto.
Mobilidade ativa de rotação externa da anca.
Alongamento passivo de isquiotibiais.
Technical stand-up para levantar do chão em segurança.
Jab linear para controlo de distância.
```

## Diferenças essenciais

### Domínio

O grande mundo do treino.

```text
Musculação / força
Cardio
Mobilidade
Elasticidade / alongamentos
Artes marciais
Recuperação
Aquecimento / ativação / prevenção
```

### Capacidade treinável

Aquilo que se quer desenvolver.

Força:

```text
força máxima
hipertrofia
resistência muscular
potência
força prática
força de trabalho
força de pega
estabilidade articular
controlo motor
força isométrica
força excêntrica
resistência postural
robustez tendinosa
```

Cardio:

```text
base aeróbia
zona 2
limiar anaeróbio
VO2 máximo
sprints
recuperação ativa
aquecimento cardiovascular
tolerância à fadiga
capacidade intervalada
mudanças de direção
```

Artes marciais:

```text
guarda
distância
footwork
ataque linear
ataque circular
defesa
esquiva
bloqueio
clinch
queda
defesa de queda
chão
levantamento
controlo
fuga
timing
coordenação
```

### Conceito

A ideia treinável por trás de um ou mais exercícios.

Exemplo:

```text
Flexão do cotovelo com pega neutra contra resistência.
```

### Exercício

Uma implementação concreta do conceito.

Exemplos:

```text
Curl martelo com halteres.
Curl martelo no cabo.
Curl martelo com elástico.
```

### Variação

Uma alteração suficientemente importante para justificar um exercício próprio.

Muda pelo menos uma destas coisas:

```text
equipamento
posição corporal
linha de resistência
músculo dominante
amplitude
risco técnico
contexto desportivo
filtro principal
```

### Modificador

Uma alteração que normalmente não vira exercício separado.

Exemplos:

```text
tempo lento
pausa em baixo
mais repetições
menos carga
amplitude ligeiramente reduzida
pegada ligeiramente mais aberta
```

## Camadas de classificação

Cada exercício deve ter:

```text
primary_type
secondary_types
use_contexts
filters
```

### primary_type

O que o exercício é principalmente.

Exemplo:

```text
Flexão diamante
primary_type: musculação_força
```

### secondary_types

Outros domínios onde o exercício também pode aparecer.

Exemplo:

```text
Shadow boxing leve
primary_type: artes_marciais
secondary_types: cardio, aquecimento
```

### use_contexts

Quando ou para que momento do treino o exercício serve.

```text
aquecimento
treino_principal
finisher
cooldown
recuperação_ativa
pré_habilitação
ativação
técnica
condicionamento
defesa_pessoal
```

### filters

Caminhos visíveis na app.

```text
Artes marciais > Boxe > Jab
Artes marciais > MMA / Defesa pessoal > Distância
Cardio > Leve > Aquecimento
```

## Regra de identidade única

Errado:

```text
Shadow boxing leve em Cardio.
Shadow boxing leve em Artes marciais.
Shadow boxing leve em Aquecimento.
```

Correto:

```text
shadow_boxing_leve
primary_type: artes_marciais
secondary_types: cardio, aquecimento
use_contexts: técnica, aquecimento, cardio leve
filters:
  - Artes marciais > Striking > Sombra
  - Cardio > Baixa intensidade > Sem equipamento
  - Aquecimento > Cardio leve
```

## Ordem correta de reconstrução

```text
1. Mapear domínios.
2. Mapear capacidades treináveis.
3. Mapear estruturas ou sistemas.
4. Mapear funções.
5. Mapear padrões.
6. Criar conceitos treináveis.
7. Gerar famílias de exercícios.
8. Gerar exercícios concretos.
9. Separar variações reais de modificadores.
10. Mapear equipamentos.
11. Mapear locais.
12. Mapear filtros visíveis.
13. Escrever descrições pedagógicas.
14. Criar testes.
```

## Musculação / força

A musculação começa por músculo, função e capacidade.

```text
Músculo ou estrutura
  > Função anatómica
    > Capacidade treinável
      > Padrão de movimento
        > Conceito treinável
          > Famílias de exercícios
            > Exercícios concretos
              > Variações
```

Exemplo com bíceps:

```text
Bíceps braquial
  Funções:
    - flexão do cotovelo
    - supinação do antebraço
    - ajuda na flexão do ombro

  Conceitos:
    - flexão do cotovelo com pega supinada
    - flexão do cotovelo com supinação durante o movimento
    - flexão do cotovelo com ombro atrás do tronco
    - flexão do cotovelo com ombro à frente do tronco
    - flexão do cotovelo em amplitude alongada
    - flexão do cotovelo em amplitude encurtada
    - flexão isométrica do cotovelo
    - flexão excêntrica controlada
    - puxada vertical com flexão forte do cotovelo
```

O objetivo não é ter um exercício por músculo. O objetivo é cobrir os conceitos que esse músculo permite treinar.

## Cardio

Cardio deve ser mapeado por sistema, intensidade, impacto, modalidade e uso.

```text
Sistema energético
  > Intensidade
    > Duração
      > Impacto
        > Modalidade
          > Contexto de uso
            > Exercícios concretos
```

Capacidades:

```text
base aeróbia
zona 2
resistência contínua
limiar
VO2 máximo
sprint
intervalos
recuperação ativa
aquecimento cardiovascular
condicionamento específico
mudanças de direção
tolerância à fadiga
```

Exemplo:

```text
Conceito: Cardio contínuo leve de baixo impacto
Exercícios:
  - caminhada leve
  - bicicleta leve
  - elíptica leve
  - passadeira caminhada
  - air bike leve
```

O mesmo cardio pode aparecer em aquecimento, treino principal leve ou recuperação. A diferença vem do contexto, duração e intensidade.

## Mobilidade

Mobilidade é controlo ativo de amplitude articular.

```text
Articulação
  > Grau de liberdade
    > Amplitude ativa
      > Controlo
        > Posição
          > Tarefa específica
            > Exercícios concretos
```

Exemplo de anca:

```text
Funções:
  - flexão
  - extensão
  - abdução
  - adução
  - rotação interna
  - rotação externa

Conceitos:
  - mobilidade ativa de rotação externa
  - mobilidade ativa de rotação interna
  - controlo de anca em 90/90
  - mobilidade para agachamento
  - mobilidade para pontapés
  - mobilidade para guarda no chão
```

## Elasticidade / alongamentos

Elasticidade é tolerância e ganho de amplitude de tecido.

```text
Zona ou músculo
  > Tipo de tecido
    > Direção de alongamento
      > Método
        > Intensidade
          > Contexto
            > Exercícios concretos
```

Métodos:

```text
alongamento estático
alongamento dinâmico
PNF
ativo assistido
passivo
relaxamento em posição alongada
```

## Recuperação

Recuperação deve ser mapeada por objetivo e método.

```text
Objetivo de recuperação
  > Método
    > Zona
      > Intensidade
        > Momento do treino
          > Exercícios concretos
```

Objetivos:

```text
baixar frequência cardíaca
relaxar sistema nervoso
aumentar circulação leve
reduzir rigidez
recuperar zona específica
baixar dor ligeira
melhorar sensação de movimento
cooldown
descanso ativo
```

## Artes marciais

Artes marciais devem ser mapeadas por habilidade e arte.

Artes suportadas:

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

```text
Arte
  > Família técnica
    > Habilidade
      > Conceito técnico
        > Drill
          > Exercícios concretos
            > Variações
```

Habilidades transversais:

```text
postura
guarda
distância
footwork
ataque
defesa
esquiva
bloqueio
clinch
queda
defesa de queda
chão
levantamento
controlo
fuga
timing
coordenação
```

## MMA / Defesa pessoal funcional

O objetivo realista é:

```text
evitar
desescalar
proteger
criar distância
sair da posição
levantar do chão
fugir
pedir ajuda
sobreviver
```

Conceitos principais:

```text
consciência de distância
posição defensiva básica
proteger a cabeça
sair da linha de ataque
criar espaço
clinch defensivo
defesa contra agarrões
defesa de queda básica
sprawl
technical stand-up
sobrevivência no chão
levantar em segurança
fuga
```

## Critério de qualidade final

Um catálogo está correto quando responde:

```text
Que conceito estou a treinar?
Que capacidade estou a desenvolver?
Que estrutura, sistema ou habilidade está envolvida?
Que exercício concretiza esse conceito?
Que variações são reais?
Que modificadores não precisam virar exercícios?
Onde aparece na app?
Porque aparece nesses filtros?
Porque não aparece noutros?
```
