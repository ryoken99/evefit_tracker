# 05 - Template de registo de conceito e exercício

## Template de conceito treinável

```yaml
id:
nome:
dominio:

capacidades_treinadas:
  -

estrutura_alvo:
  -

estruturas_secundarias:
  -

funcao:
  -

padrao:
  -

posicao:
  -

linha_de_resistencia:
  -

tipo_de_contracao:
  -

contexto_de_uso:
  -

intensidade:
  -

impacto:
  -

nivel:
  -

equipamentos_possiveis:
  -

locais_possiveis:
  -

exercicios_derivados:
  -

filtros_possiveis:
  -

notas_de_modelacao:
```

## Template de exercício canónico

```yaml
id:
nome:
concept_id:
familia:
variacao:

primary_type:

secondary_types:
  -

use_contexts:
  -

capacidades_treinadas:
  -

estruturas_principais:
  -

estruturas_secundarias:
  -

padrao_de_movimento:
  -

equipamento:
  -

locais:
  -

intensidade:
  -

impacto:
  -

nivel:

arte_marcial:
  -

filtros:
  -

nao_aparece_em:
  -

objetivo:

quando_usar:

como_fazer:
  - 
  - 
  - 
  - 

erros_comuns:
  - 
  - 
  - 

versao_mais_facil:

versao_mais_dificil:

cuidados:

notas_de_modelacao:
```

## Exemplo preenchido: conceito

```yaml
id: elbow_flexion_neutral_grip_resistance
nome: Flexão do cotovelo com pega neutra contra resistência
dominio: musculacao_forca

capacidades_treinadas:
  - hipertrofia
  - forca
  - resistencia_muscular
  - forca_pratica

estrutura_alvo:
  - braquial
  - braquiorradial

estruturas_secundarias:
  - biceps_braquial
  - antebraco

funcao:
  - flexao_do_cotovelo

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
  - forca_de_braco

intensidade:
  - leve
  - moderada
  - alta

impacto:
  - sem_impacto

nivel:
  - iniciante

equipamentos_possiveis:
  - halteres
  - cabo
  - elastico
  - maquina

locais_possiveis:
  - casa_equipada
  - ginasio

exercicios_derivados:
  - curl_martelo_com_halteres
  - curl_martelo_no_cabo
  - curl_martelo_com_elastico

filtros_possiveis:
  - Musculação > Braços > Braquial
  - Musculação > Braços > Bíceps
  - Musculação > Antebraço / Pega > Braquiorradial

notas_de_modelacao: Conceito focado em pega neutra, com maior participação do braquial e braquiorradial.
```

## Exemplo preenchido: exercício

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

nivel: iniciante

arte_marcial: []

filtros:
  - Musculação > Braços > Braquial
  - Musculação > Braços > Bíceps
  - Musculação > Antebraço / Pega > Braquiorradial
  - Equipamento > Halteres

nao_aparece_em:
  - Equipamento > Cabo
  - Equipamento > Barra

objetivo: Trabalhar braquial e braquiorradial, com apoio do bíceps, para força e volume do braço.

quando_usar: Usa como exercício acessório de braço depois dos movimentos principais ou como trabalho direto de braço.

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
notas_de_modelacao: Variação com halteres e pega neutra. Não deve ser confundida com curl supinado.
```

## Template de decisão: variação ou modificador

```text
Pergunta 1: muda o equipamento?
Pergunta 2: muda a linha de resistência?
Pergunta 3: muda a posição corporal?
Pergunta 4: muda o músculo dominante?
Pergunta 5: muda o risco técnico?
Pergunta 6: muda o contexto desportivo?
Pergunta 7: muda o filtro principal?
```

Se a resposta for sim a uma ou mais perguntas fortes, provavelmente é variação.

Se só muda carga, repetições, pausa curta ou tempo, provavelmente é modificador.

## Template de mapeamento cruzado

```yaml
exercicio_id:
primary_type:

secondary_types:
  -

use_contexts:
  -

aparece_em:
  -

nao_aparece_em:
  -

motivo_do_cruzamento:

risco_de_duplicacao:

decisao_final:
```
