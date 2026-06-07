# DESCRIPTION_PEDAGOGY_REVIEW_v0.7.9

Versao: v0.7.9

## Objetivo

Rever o catalogo para que as descricoes nao sejam apenas validas tecnicamente, mas tambem uteis para uma pessoa iniciante. A v0.7.9 focou-se em remover nomes ambiguos, reforcar o passo a passo e garantir que os testes percorrem o catalogo visivel.

## Criterios aplicados

Cada exercicio visivel deve ter:

- Nome coerente com o equipamento.
- Grupo/foco principal preenchido.
- Equipamento preenchido.
- Descricao com pelo menos o que e o movimento e para que serve.
- Execucao com pelo menos 5 passos.
- Erros comuns especificos.
- Seguranca especifica ao tipo de exercicio.
- Sem placeholders ou frases genericas proibidas.

## Frases proibidas verificadas por teste

Os testes v0.7.7, v0.7.8 e v0.7.9 continuam a falhar se aparecerem frases como:

- `Descricao ainda incompleta`.
- `sera melhorado numa proxima versao`.
- `prepara a posicao inicial`.
- `confirma que o equipamento esta estavel`.
- `faz o movimento principal`.
- `executa com boa tecnica`.
- `mantem boa postura`.
- `amplitude confortavel`.
- `ajusta pes, maos e carga`.

## Descricoes e geradores reescritos

| Area | Alteracao |
|---|---|
| Flexao classica | Passos detalham maos, pes, linha de prancha, cotovelos, descida, subida, respiracao, regressao para joelhos ou superficie elevada. |
| Agachamento com peso corporal | Passos detalham pes, joelhos, anca, calcanhares, profundidade segura, subida e respiracao. |
| Agachamento com mochila/garrafao/lunges com mochila | Texto especifico para carga caseira, estabilidade, pega e avisos de seguranca. |
| Remo invertido em mesa resistente | Texto exige mesa resistente, teste de estabilidade, corpo em linha e seguranca antes de carregar peso. |
| Mobilidade de ombro com cabo de vassoura | Texto explica uso do cabo como guia de mobilidade, tempo, respiracao e sem forcar dor. |
| Barra | Gerador passou a explicar pega, punhos, linha da barra, subida/descida/movimento, respiracao e carga leve. |
| Cabo | Gerador passou a explicar altura da polia, pega, tensao, dobrar/estender quando aplicavel e retorno controlado. |
| Maquina | Gerador passou a explicar ajuste, eixo articular, pegas/apoios, dobrar/estender e retorno sem perder apoio. |
| Elastico | Gerador passou a explicar ponto de fixacao, punhos, tensao, dobrar/estender/abrir os bracos e retorno. |

Contagem honesta:

- 5 exercicios/familias receberam texto especifico novo.
- 4 geradores por equipamento foram reescritos para cobrir dezenas de exercicios sem voltar a placeholders.
- 32 nomes foram adicionados/remapeados para melhorar coerencia entre nome, equipamento e descricao.

## Exemplos antes/depois

| Caso | Antes | Depois |
|---|---|---|
| Flexoes | Nome ambiguo e familia pouco especifica. | `Flexao classica`, `Flexao com joelhos apoiados`, `Flexao inclinada`, `Flexao declinada`, `Flexao aberta`, `Flexao arqueiro`. |
| Agachamento | Nome ambiguo. | `Agachamento com peso corporal`, `Agachamento para cadeira`, `Agachamento com halteres ao lado`, `Agachamento com mochila`, `Agachamento com garrafao`, `Agachamento na maquina Smith`. |
| Bracos completo | Lista com menos variantes de punho/pega e triceps com halteres. | Inclui curls, extensoes, press fechado, Tate press, wrist curl, desvios, carries, holds e rotacao com halter leve. |
| Alternativas caseiras | Misturadas como substituicoes. | Tratadas como equipamentos proprios e marcadas no perfil/filtro. |

## Testes de pedagogia

| Teste | Cobertura |
|---|---|
| `exercise_descriptions_are_specific_test.dart` | Percorre o catalogo visivel, valida descricao, passos, seguranca, equipamento, grupo, frases proibidas e coerencia por equipamento. |
| `v078_exercise_pedagogy_test.dart` | Garante detalhes por familia/equipamento: barra, halteres, cabo/maquina, mobilidade, cardio e artes marciais. |
| `v079_description_pedagogy_test.dart` | Adiciona criterio v0.7.9: flexao classica, agachamento, mobilidade, cardio, artes marciais e ausencia de frases proibidas. |

Resultado final: `flutter test` passou com 156 testes.

## Limitacoes conhecidas

- Nem todos os 294 exercicios tem uma descricao manual unica escrita linha a linha; parte do catalogo usa geradores pedagogicos por equipamento/familia com testes fortes.
- A v0.7.9 melhora muito a legibilidade, mas uma versao futura pode transformar mais geradores em descricoes totalmente manuais para exercicios de maior risco.
- A app ainda nao inclui imagens, videos ou validacao biomecanica individual.
