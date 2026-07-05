# 02 - Modelo de exercício canónico

## Objetivo

Este documento define como representar um exercício concreto depois de ele derivar de um conceito treinável.

O exercício canónico é a entidade que aparece no histórico, nos treinos, nos filtros e nas descrições da app.

## Regra principal

```text
Um exercício pode aparecer em vários filtros.
Mas só deve existir uma vez como entidade canónica.
```

## Campos oficiais

```text
id
nome
concept_id
familia
variacao
primary_type
secondary_types
use_contexts
capacidades_treinadas
estruturas_principais
estruturas_secundarias
padrao_de_movimento
equipamento
locais
intensidade
impacto
nivel
arte_marcial
filtros
nao_aparece_em
objetivo
quando_usar
como_fazer
erros_comuns
versao_mais_facil
versao_mais_dificil
cuidados
notas_de_modelacao
```

## Regras para primary_type

O primary_type responde:

```text
O que este exercício é principalmente?
```

Exemplos:

```text
Flexão diamante -> musculacao_forca
Corrida intervalada -> cardio
Mobilidade 90/90 -> mobilidade
Alongamento borboleta -> elasticidade
Technical stand-up -> artes_marciais
Foam roller para pernas -> recuperacao
Aquecimento dinâmico geral -> aquecimento_ativacao_prevencao
```

## Regras para secondary_types

O secondary_types responde:

```text
Onde mais este exercício também é útil?
```

Exemplo:

```text
Shadow boxing leve
primary_type: artes_marciais
secondary_types:
  - cardio
  - aquecimento_ativacao_prevencao
```

## Regras para use_contexts

O use_contexts responde:

```text
Quando devo usar este exercício?
```

Exemplos:

```text
aquecimento
treino_principal
finisher
cooldown
recuperacao_ativa
ativacao
pre_habilitacao
tecnica
condicionamento
defesa_pessoal
```

## Duplicados

Não duplicar só porque muda o filtro.

Errado:

```text
Caminhada leve em Cardio.
Caminhada leve em Recuperação.
Caminhada leve em Aquecimento.
```

Correto:

```text
caminhada_leve
primary_type: cardio
secondary_types:
  - recuperacao
  - aquecimento_ativacao_prevencao
use_contexts:
  - aquecimento
  - cooldown
  - recuperacao_ativa
```

## Quando uma variação vira exercício novo

Vira exercício novo quando muda uma destas dimensões de forma relevante:

```text
equipamento
linha de resistência
posição corporal
amplitude principal
músculo dominante
padrão técnico
risco
nível
contexto desportivo
modalidade
intensidade estrutural
```

Exemplos que devem ser exercícios diferentes:

```text
Supino com barra
Supino com halteres
Supino inclinado com halteres
Supino declinado com barra
Supino fechado
Chest press
```

Exemplos que normalmente são modificadores:

```text
supino com pausa
supino tempo 3 segundos
supino com carga leve
supino com 12 repetições
```

## Exemplo: Curl martelo com halteres

```yaml
id: curl_martelo_com_halteres
nome: Curl martelo com halteres
concept_id: elbow_flexion_neutral_grip_resistance
familia: curl
variacao: com_halteres_pega_neutra

primary_type: musculacao_forca
secondary_types: []

use_contexts:
  - treino_principal
  - acessorio
  - hipertrofia
  - forca_de_braco

capacidades_treinadas:
  - hipertrofia
  - forca
  - resistencia_muscular

estruturas_principais:
  - braquial
  - braquiorradial

estruturas_secundarias:
  - biceps_braquial
  - antebraco

padrao_de_movimento:
  - flexao_do_cotovelo

equipamento:
  - halteres

locais:
  - casa_equipada
  - ginasio

intensidade:
  - leve
  - moderada
  - alta

impacto:
  - sem_impacto

nivel:
  - iniciante

filtros:
  - Musculação > Braços > Braquial
  - Musculação > Braços > Bíceps
  - Musculação > Antebraço / Pega > Braquiorradial
  - Equipamento > Halteres

objetivo: Trabalhar braquial e braquiorradial, com apoio do bíceps, para força e volume do braço.

como_fazer:
  - Fica de pé com um halter em cada mão e palmas viradas uma para a outra.
  - Mantém os cotovelos perto do tronco.
  - Sobe os halteres dobrando os cotovelos sem balançar o corpo.
  - Para perto do topo sem deixar os cotovelos avançarem demasiado.
  - Desce devagar até quase estender os braços.
  - Mantém a pega neutra durante toda a repetição.

erros_comuns:
  - Balançar o tronco para subir a carga.
  - Deixar os cotovelos afastarem muito.
  - Rodar os punhos durante o movimento.
  - Descer sem controlo.

versao_mais_facil: Faz alternado, um braço de cada vez, com carga leve.
versao_mais_dificil: Faz a descida mais lenta ou segura 1 segundo no topo.
cuidados: Evita dor no cotovelo ou punho. Reduz a carga se perderes controlo.
```

## Exemplo: Caminhada leve

```yaml
id: caminhada_leve
nome: Caminhada leve
concept_id: low_intensity_continuous_cardio
familia: caminhada
variacao: leve

primary_type: cardio
secondary_types:
  - recuperacao
  - aquecimento_ativacao_prevencao

use_contexts:
  - aquecimento
  - cooldown
  - recuperacao_ativa
  - treino_principal_leve

capacidades_treinadas:
  - base_aerobia
  - circulacao
  - recuperacao_ativa

estruturas_principais:
  - sistema_cardiorrespiratorio
  - membros_inferiores

padrao_de_movimento:
  - locomocao_continua

equipamento:
  - peso_corporal
  - espaco_exterior
  - passadeira_opcional

locais:
  - casa_sem_equipamento
  - exterior
  - ginasio

intensidade:
  - leve

impacto:
  - baixo

nivel:
  - iniciante

filtros:
  - Cardio > Baixa intensidade
  - Aquecimento > Cardio leve
  - Recuperação > Recuperação ativa
  - Exterior > Caminhada
```

## Regras de descrição

Cada descrição deve ensinar um iniciante.

Não usar:

```text
exercício genérico
conforme a variação
usa a carga indicada
não deixar a carga cair
afastar a carga
```

Usar:

```text
o que trabalha
como posicionar o corpo
como executar
onde sentir o movimento
como respirar
que erro evitar
como facilitar
como dificultar
```

## Critério final

Um exercício está completo quando tem:

```text
id estável
concept_id
primary_type
use_contexts
estruturas principais
padrão
equipamento
locais
filtros
objetivo claro
passos úteis
erros comuns
regressão
progressão
cuidados quando necessário
```
