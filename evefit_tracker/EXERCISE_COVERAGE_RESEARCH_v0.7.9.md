# EXERCISE_COVERAGE_RESEARCH_v0.7.9

Versao alvo: v0.7.9

Estado antes de alterar codigo de producao:

- Catalogo seed atual: 275 exercicios unicos, 286 entradas totais, 11 duplicados intencionais por grupos/focos.
- Grupos seed atuais: Pescoco, Trapezio, Ombros, Peito, Costas, Biceps, Triceps, Antebraco/Pega, Core, Pernas, Cardio, Karate, Jiu-Jitsu, Mobilidade.
- Problemas confirmados no codigo: nomes ainda ambiguos (`Flexoes`, `Agachamento`), poucas alternativas caseiras explicitas, falta de prova de cobertura por musculo/equipamento, e descricoes genericas por familia que ainda nao ensinam alguns movimentos como uma ficha completa de iniciante.

## Fontes usadas como referencia

As fontes abaixo foram usadas para estruturar a cobertura funcional e validar familias de movimento/equipamento. O texto da app nao copia estas fontes.

- ACE Exercise Library: https://www.acefitness.org/resources/everyone/exercise-library/
- NASM Exercise Library: https://www.nasm.org/resource-center/exercise-library
- CDC adult activity guidance: https://www.cdc.gov/physical-activity-basics/guidelines/adults.html
- Mayo Clinic strength training overview: https://www.mayoclinic.org/healthy-lifestyle/fitness/basics/strength-training/hlv-20049447
- Cleveland Clinic muscle overview: https://my.clevelandclinic.org/health/body/21887-muscle
- NCBI StatPearls rotator cuff anatomy: https://www.ncbi.nlm.nih.gov/books/NBK441844/
- NHS strength and flexibility: https://www.nhs.uk/live-well/exercise/how-to-improve-strength-flexibility/

## Lista anatomica funcional treinavel

Sem face. A app deve cobrir, pelo menos:

| Regiao | Musculos/grupos funcionais |
|---|---|
| Pescoco | Flexores cervicais, extensores cervicais, rotadores cervicais, inclinadores laterais, trapezio superior, estabilizacao cervical. |
| Ombros e cintura escapular | Deltoide anterior, lateral e posterior; manguito rotador; supraespinhoso; infraespinhoso; redondo menor; subescapular; trapezio superior/medio/inferior; romboides; serratil anterior; estabilidade escapular. |
| Peito | Peitoral maior, peito superior, medio e inferior, peitoral menor, serratil anterior. |
| Costas | Dorsal/latissimo, redondo maior, romboides, trapezio medio/inferior, eretores da espinha, lombar, quadrado lombar, largura, espessura, costas superior/media/inferior. |
| Braco | Biceps braquial, braquial, braquiorradial, coracobraquial, triceps cabeca longa/lateral/medial. |
| Antebraco, punho e mao | Flexores/extensores, pronadores/supinadores, desvio radial/ulnar, flexao/extensao do punho, pega geral, pega de pinca, pega de suporte, dedos e mao. |
| Core e tronco | Reto abdominal, abdominal superior/medio/inferior, obliquos externos/internos, transverso abdominal, anti-rotacao, anti-extensao, anti-flexao lateral, lombar, estabilidade profunda, diafragma/respiracao. |
| Anca e gluteos | Gluteo maximo/medio/minimo, flexores da anca, rotadores externos/internos, adutores, abdutores. |
| Coxa | Quadriceps, reto femoral, vasto lateral/medial/intermedio, posterior de coxa, biceps femoral, semitendinoso, semimembranoso. |
| Perna inferior e pe | Gastrocnemio/gemeos, soleo, tibial anterior/posterior, fibulares/peroneais, tornozelo, pe e arco plantar em mobilidade/estabilidade. |

## Equipamentos a considerar

| Categoria | Equipamentos |
|---|---|
| Base | Peso corporal, tapete/chao, espaco livre, parede, banco/cadeira/apoio. |
| Pesos livres | Halteres, barra, discos, kettlebell, saco de areia, colete com peso, tornozeleiras com peso. |
| Bancos/suportes | Banco plano, inclinado, declinado, banco regulavel, paralelas, barra fixa, argolas, TRX/suspensao. |
| Maquinas/cabos | Maquina multifuncoes, cabo alto, cabo baixo, polia ajustavel, lat pulldown, remo sentado, chest press, shoulder press, leg press, extensora, flexora, abdutora, adutora, smith, maquina de gemeos, dips assistida. |
| Cardio | Passadeira, bicicleta, eliptica, remo ergometro, stepper, air bike, corda de saltar, exterior. |
| Artes marciais | Tatami/espaco marcial, saco de pancada, luvas, caneleiras, aparadores, kimono/faixa, boneco de grappling, grip trainer. |
| Recuperacao/mobilidade | Foam roller, bola de massagem, elastico de mobilidade, bloco de yoga, pistola de massagem. |
| Alternativas caseiras | Garrafas de agua, garrafao, mochila com peso/livros, cadeira resistente, degrau/escada estavel, parede, toalha, mesa resistente apenas se segura, cabo de vassoura, balde/garrafao como carga. |

## Matriz alvo resumida por musculo/equipamento

| Musculo/foco | Peso corporal/casa | Halteres | Barra/discos | Cabo/maquina/elastico |
|---|---|---|---|---|
| Peito completo | Flexao classica, inclinada, declinada, aberta, joelhos, diamante/fechada quando foco triceps/peito secundario | Supino halteres, supino inclinado/declinado, aberturas, squeeze press | Supino barra, inclinado, declinado | Chest press, crossover, aberturas cabo/elastico |
| Costas largura | Pull-up/chin-up se barra fixa; pullover com toalha apenas mobilidade | Pullover com halter | Remo/barra como espessura, peso morto como posterior/lombar | Puxada alta, puxada pega neutra/aberta/fechada, pullover cabo |
| Costas espessura | Remo invertido em mesa apenas se segura | Remo unilateral, remo inclinado | Remo com barra | Remo sentado/baixo, remo elastico |
| Ombros | Pike push-up, wall slides, flexao escapular | Press, Arnold, elevacoes, reverse fly, scaption | Press militar barra | Face pull cabo/elastico, rotacoes, shoulder press machine |
| Biceps/braquial/braquiorradial | Chin-up se barra fixa; pouca opcao direta sem equipamento | Curls, martelo, concentrado, inclinado, Zottman, inverso, cruzado, 21, arrastado | Curl barra, inverso barra | Curl cabo, elastico |
| Triceps | Flexao fechada/diamante, fundos banco, dips paralelas | Francesa, acima da cabeca, unilateral, deitado, kickback, press fechado, Tate press | Triceps testa, supino fechado, francesa barra | Triceps cabo, corda, elastico |
| Antebraco/pega | Dead hang se barra fixa, towel grip, aperto isometrico | Wrist/reverse wrist, pronacao/supinacao, desvio radial/ulnar, farmer hold/walk, suitcase carry, hold estatico | Curl inverso barra | Plate hold/pinch, grip trainer, extensao dedos elastico |
| Core | Prancha, lateral, crunch, reverse, dead bug, hollow, bird dog, mountain climbers | Russian twist/side bend com carga quando aplicavel | Rollout com barra se seguro | Pallof cabo/elastico, ab wheel |
| Quadriceps | Agachamento peso corporal, cadeira, wall sit, lunges, step-up | Goblet, halteres ao lado, lunges halteres | Agachamento barra | Leg press, extensora, smith |
| Posterior | Good morning sem carga, ponte/hip hinge | Peso morto romeno halteres | Peso morto romeno/tradicional, good morning | Curl perna |
| Gluteos | Ponte, hip thrust apoio, abducao peso corporal | Hip thrust/ponte com halter, goblet/sumo | Hip thrust/agachamento barra | Kickback cabo, abdutora |
| Gemeos/soleo/tibial | Gemeos em pe, unilateral, tibial na parede | Gemeos com halteres | Gemeos com barra | Maquina gemeos, leg press calf raise |
| Mobilidade geral | Alongamentos e mobilidade sem equipamento para pescoco, ombro, toracica, anca, posterior, gluteos, tornozelo, gemeos, punhos | Carga leve so quando justificavel | Cabo de vassoura/toalha como apoio | Foam roller/bola se disponivel |

## Lacunas encontradas no catalogo atual

| Lacuna | Evidencia atual | Correcao prevista v0.7.9 |
|---|---|---|
| Nomes ambiguos | `Flexoes`, `Agachamento`, `Supino inclinado`, `Curl 21`, `Triceps testa` sem equipamento no nome. | Adicionar variantes explicitas e retirar os ambiguos do seed novo quando houver variante clara. |
| Bracos completo com halteres limitado | Faltam `Curl 21 com halteres`, `Curl arrastado`, `Extensao acima da cabeca com halter`, `Press fechado com halteres`, `Tate press`, `Suitcase carry`, `Hold estatico`. | Adicionar exercicios e mapear para biceps/triceps/antebraco/pega com equipamento correto. |
| Alternativas caseiras fracas | Perfil tem mochila/cadeira/toalha, mas catalogo quase nao usa alternativas seguras. | Adicionar mochila, garrafao, cadeira/degrau, parede, toalha/cabo de vassoura como equipamentos distintos e seguros. |
| Flexoes/agachamentos pouco pedagogicos | Existem descricoes por familia, mas o prompt exige nivel de detalhe de iniciante. | Reescrever `Flexao classica` e `Agachamento com peso corporal` com passos completos. |
| Prova de cobertura muscular incompleta | Relatorios anteriores validam casos criticos, mas nao uma matriz musculo/equipamento. | Criar matriz `MUSCLE_EQUIPMENT_EXERCISE_MATRIX_v0.7.9.md` e testes de cobertura. |
| Maquinas especificas sub-representadas | Catalogo tem maquina generica e poucos nomes de smith/gemeos/dips assistida. | Adicionar algumas variantes de maior impacto e deixar expansao completa para versao futura. |

## O que sera corrigido nesta versao

- Reforco de bracos completo com halteres, incluindo biceps, braquial/braquiorradial, triceps, antebraco, punho e pega.
- Variantes explicitas para flexoes e agachamentos comuns.
- Alternativas caseiras seguras como exercicios proprios, nao substituicoes escondidas.
- Equipamento novo/aliases para garrafas, garrafao, cabo de vassoura, degrau/escada e mesa resistente.
- Descricoes pedagogicas especificas para `Flexao classica`, `Agachamento com peso corporal` e novas variantes caseiras relevantes.
- Testes de cobertura para filtros completo, descricoes, nomes ambiguos e alternativas caseiras.

## O que fica para versoes futuras

- Cobertura completa de todos os equipamentos de ginásio dedicados com variantes unilaterais, pegadas e maquinas por marca: escopo demasiado grande para v0.7.9 sem risco de gerar conteudo superficial.
- Catalogo completo de fisioterapia/reabilitacao por patologia: exige criterio clinico fora do objetivo de treino geral.
- Videos/imagens de execucao: nao faz parte desta versao e exigiria pipeline de assets.

## Estado final apos implementacao

- Catalogo seed final: 294 exercicios unicos, 305 entradas totais e 11 duplicados intencionais por grupos/focos.
- Incremento liquido: +19 exercicios unicos face ao baseline inicial de 275.
- Nomes adicionados ou remapeados nesta versao: 32 nomes explicitos, incluindo variantes de flexao, agachamento, biceps, triceps, antebraco/pega, alternativas caseiras e mobilidade.
- Testes finais: `flutter test` passou com 156 testes.
- Validacao de cobertura: os testes v0.7.9 verificam bracos completo com halteres, agregacao de filtros completo, alternativas caseiras seguras, mobilidade sem equipamento, nomes ambiguos e criterios pedagogicos.

Estado: pesquisa inicial concluida antes de codigo de producao e atualizada com numeros finais apos implementacao.
