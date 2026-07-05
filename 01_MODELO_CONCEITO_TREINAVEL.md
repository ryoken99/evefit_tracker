# 01 - Modelo de conceito treinável

## Objetivo

Este documento define o formato oficial de um conceito treinável.

Um conceito treinável é a unidade base do catálogo. Exercícios concretos derivam dele.

## Definição

```text
Conceito treinável = combinação de capacidade, estrutura ou habilidade, função, padrão, contexto e método.
```

Exemplo:

```text
Flexão do cotovelo com pega supinada contra resistência.
```

Isto pode gerar:

```text
Curl com barra
Curl com halteres
Curl no cabo
Curl com elástico
Curl na máquina
```

## Campos oficiais

### id

Identificador estável e único.

Regras:

```text
usar snake_case
não usar acentos
não usar espaços
não depender do equipamento quando o conceito é mais geral
não mudar depois de criado
```

Exemplo:

```text
elbow_flexion_supinated_resistance
```

### nome

Nome humano do conceito.

Exemplo:

```text
Flexão do cotovelo com pega supinada contra resistência
```

### dominio

Valores principais:

```text
musculacao_forca
cardio
mobilidade
elasticidade
artes_marciais
recuperacao
aquecimento_ativacao_prevencao
```

### capacidades_treinadas

Força:

```text
forca_maxima
hipertrofia
resistencia_muscular
potencia
forca_pratica
forca_de_trabalho
forca_isometrica
forca_excentrica
controlo_motor
estabilidade_articular
robustez_tendinosa
```

Cardio:

```text
base_aerobia
zona_2
vo2_maximo
limiar
sprint
intervalos
recuperacao_ativa
condicionamento
mudancas_de_direcao
```

Artes marciais:

```text
distancia
guarda
ataque
defesa
footwork
clinch
chao
queda
fuga
timing
coordenacao
```

### estrutura_alvo

A estrutura corporal, sistema ou habilidade principal.

Exemplos:

```text
biceps_braquial
sistema_cardiorrespiratorio
anca
posterior_de_coxa
guarda_de_boxe
technical_stand_up
```

### estruturas_secundarias

Estruturas ou habilidades secundárias.

Exemplo:

```text
braquial
braquiorradial
antebraco
core
escapula
```

### funcao

Função anatómica, energética ou técnica.

Exemplos:

```text
flexao_do_cotovelo
supinacao_do_antebraco
extensao_da_anca
rotacao_externa_da_anca
resistencia_aerobia
protecao_da_cabeca
criar_distancia
```

### padrao

Padrão de movimento ou técnico.

```text
puxar_vertical
empurrar_horizontal
flexao_do_cotovelo
dobradica_de_anca
locomocao_continua
intervalos_alta_intensidade
ataque_linear_com_mao
defesa_de_queda
```

### posicao

Posição relevante do corpo ou articulação.

```text
em_pe
sentado
deitado
quadrupede
ombro_atras_do_tronco
ombro_a_frente_do_tronco
guarda_em_pe
chao_sentado
```

### linha_de_resistencia

Como a resistência ou exigência atua.

```text
gravidade_vertical
cabo_baixo
cabo_alto
elastico_horizontal
elastico_diagonal
peso_corporal
maquina_guiada
impacto_no_solo
resistencia_do_adversario
```

### tipo_de_contracao

```text
concentrica
excentrica
isometrica
dinamica
estatica
ativa
passiva
assistida
pnf
```

### contexto_de_uso

```text
aquecimento
treino_principal
finisher
cooldown
recuperacao_ativa
ativacao
pre_habilitacao
tecnica
defesa_pessoal
condicionamento
```

### intensidade

```text
muito_leve
leve
moderada
alta
maxima
variavel
```

### impacto

```text
sem_impacto
baixo
medio
alto
variavel
```

### nivel

```text
iniciante
intermedio
avancado
especializado
```

### equipamentos_possiveis

Equipamentos que podem implementar o conceito.

### locais_possiveis

Locais plausíveis.

```text
casa_sem_equipamento
casa_equipada
ginasio
exterior
dojo
tatami
```

### exercicios_derivados

Lista de exercícios concretos que implementam o conceito.

### filtros_possiveis

Caminhos da app onde este conceito pode aparecer.

### notas_de_modelacao

Explicação breve de decisões importantes.

## Exemplo: bíceps

```yaml
id: elbow_flexion_supinated_resistance
nome: Flexão do cotovelo com pega supinada contra resistência
dominio: musculacao_forca

capacidades_treinadas:
  - hipertrofia
  - forca
  - resistencia_muscular
  - controlo_motor

estrutura_alvo:
  - biceps_braquial

estruturas_secundarias:
  - braquial
  - braquiorradial
  - antebraco

funcao:
  - flexao_do_cotovelo
  - supinacao_do_antebraco

padrao:
  - flexao_do_cotovelo

posicao:
  - em_pe
  - sentado
  - ombro_neutro

linha_de_resistencia:
  - gravidade_vertical
  - cabo_baixo
  - elastico

tipo_de_contracao:
  - concentrica
  - excentrica
  - isometrica

contexto_de_uso:
  - treino_principal
  - acessorio
  - hipertrofia

intensidade:
  - leve
  - moderada
  - alta

impacto:
  - sem_impacto

nivel:
  - iniciante

equipamentos_possiveis:
  - barra
  - halteres
  - cabo
  - elastico
  - maquina

locais_possiveis:
  - casa_equipada
  - ginasio

exercicios_derivados:
  - curl_com_barra
  - curl_com_halteres
  - curl_no_cabo
  - curl_com_elastico
  - curl_na_maquina

filtros_possiveis:
  - Musculação > Braços > Bíceps
  - Musculação > Braços > Braquial
  - Equipamento > Halteres
  - Equipamento > Barra
  - Equipamento > Cabo
```

## Exemplo: cardio leve

```yaml
id: low_intensity_continuous_cardio
nome: Cardio contínuo leve de baixo impacto
dominio: cardio

capacidades_treinadas:
  - base_aerobia
  - recuperacao_ativa
  - aquecimento_cardiorrespiratorio

estrutura_alvo:
  - sistema_cardiorrespiratorio

funcao:
  - manter_esforco_continuo
  - aumentar_circulacao
  - controlar_frequencia_cardiaca

padrao:
  - locomocao_continua
  - ritmo_estavel

contexto_de_uso:
  - aquecimento
  - treino_principal_leve
  - cooldown
  - recuperacao_ativa

intensidade:
  - leve

impacto:
  - baixo
  - sem_impacto

nivel:
  - iniciante

equipamentos_possiveis:
  - peso_corporal
  - passadeira
  - bicicleta
  - eliptica
  - air_bike

locais_possiveis:
  - casa_sem_equipamento
  - casa_equipada
  - ginasio
  - exterior

exercicios_derivados:
  - caminhada_leve
  - passadeira_caminhada
  - bicicleta_ritmo_leve
  - eliptica_ritmo_leve
  - air_bike_ritmo_leve

filtros_possiveis:
  - Cardio > Leve
  - Aquecimento > Cardio leve
  - Recuperação > Recuperação ativa
```

## Exemplo: technical stand-up

```yaml
id: technical_stand_up_ground_escape
nome: Levantar do chão mantendo distância e proteção
dominio: artes_marciais

capacidades_treinadas:
  - levantar_em_seguranca
  - criar_distancia
  - defesa_pessoal
  - controlo_postural

estrutura_alvo:
  - habilidade_de_chao
  - core
  - anca
  - membros_superiores

funcao:
  - proteger_cabeca
  - afastar_adversario
  - levantar_sem_expor_o_rosto

padrao:
  - transicao_chao_para_pe

posicao:
  - sentado_no_chao
  - mao_de_apoio
  - perna_de_barreira

contexto_de_uso:
  - tecnica
  - defesa_pessoal
  - aquecimento_tecnico

intensidade:
  - leve
  - moderada

impacto:
  - baixo

nivel:
  - iniciante

equipamentos_possiveis:
  - peso_corporal
  - tatami
  - tapete

locais_possiveis:
  - casa_sem_equipamento
  - dojo
  - tatami
  - ginasio

exercicios_derivados:
  - technical_stand_up
  - technical_stand_up_com_recuo
  - technical_stand_up_com_guarda

filtros_possiveis:
  - Artes marciais > Jiu-Jitsu / BJJ > Technical stand-up
  - Artes marciais > MMA / Defesa pessoal > Levantar do chão
  - Aquecimento > Técnico
```

## Regras de validação

Um conceito não é válido se:

```text
não tem domínio
não tem capacidade treinada
não tem função
não tem padrão
não tem pelo menos um exercício derivado
não tem contexto de uso
não tem filtros possíveis
não explica porque existe
```

Um conceito também falha se for demasiado específico.

Errado:

```text
Curl com halteres de 8 kg feito sentado numa terça-feira.
```

Correto:

```text
Flexão do cotovelo com pega supinada contra resistência.
```
