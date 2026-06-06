# EveFit Tracker v0.7.0 - Auditoria da arquitetura de treinos

## Nova hierarquia criada

A aba Treinos passou a usar uma camada central em `TrainingArchitecture`, separando:

Região corporal / domínio -> grupo principal -> subgrupo / foco -> músculo específico -> equipamento disponível -> exercícios compatíveis.

A pesquisa alternativa por equipamento também ficou preparada pela mesma camada: equipamento -> região -> grupo -> exercícios possíveis.

## Regiões

- Corpo inteiro
- Parte superior
- Parte inferior
- Core
- Cardio
- Artes marciais
- Mobilidade e recuperação
- Personalizado

## Grupos

- Parte superior: Pescoço; Trapézio / cintura escapular; Peito; Costas; Ombros; Braços; Antebraço / punho / mão.
- Parte inferior: Anca / glúteos; Quadríceps; Posterior de coxa; Adutores; Abdutores; Gémeos / sóleo; Tibial anterior; Pés / tornozelo.
- Core: Abdominal; Oblíquos; Transverso abdominal; Lombar; Estabilidade do core; Anti-rotação; Anti-extensão; Anti-flexão lateral.
- Cardio: Cardio geral; Máquina de cardio; Corda de saltar; Exterior; HIIT.
- Artes marciais: Karate; Jiu-Jitsu; Condicionamento para artes marciais; Mobilidade para artes marciais; Força de pega para grappling; Core para artes marciais.
- Mobilidade e recuperação: Mobilidade geral; Mobilidade de ombros; Mobilidade de anca; Mobilidade de tornozelo; Mobilidade torácica; Alongamentos; Recuperação ativa; Respiração; Postura.
- Personalizado: Treino personalizado.

## Subgrupos

- Braço anterior
- Braço posterior
- Força de pega
- Peito
- Costas largura
- Costas espessura
- Deltoides
- Glúteos
- Quadríceps
- Posterior de coxa
- Gémeos e sóleo
- Adutores
- Abdutores
- Core completo
- Passadeira
- Bicicleta
- Elíptica
- Corda de saltar
- Caminhada exterior
- Corrida exterior
- HIIT
- Karate técnico
- Jiu-Jitsu técnico

## Músculos específicos e capacidades

- Bíceps, braquial, braquiorradial.
- Tríceps cabeça longa, cabeça lateral e cabeça medial.
- Pega de suporte e pega de pinça.
- Peito superior, médio e inferior.
- Dorsal / latíssimo do dorso e romboides.
- Deltoide lateral.
- Glúteo máximo e glúteo médio.
- Reto femoral, vasto lateral e bíceps femoral.
- Gémeos e sóleo.
- Reto abdominal e anti-extensão.
- Resistência aeróbia.
- Karate técnico e Jiu-Jitsu técnico.

## Equipamentos

Peso corporal, halteres, barra, discos, banco, máquina multifunções, cabo alto, cabo baixo, máquinas de ginásio, barra fixa, elásticos, kettlebell, passadeira, bicicleta, elíptica, corda de saltar, saco de pancada, tatami / espaço de artes marciais, espaço exterior, nenhum equipamento e outro.

## Exercícios por equipamento

- Peso corporal: flexões, flexões fechadas, agachamento, lunges, walking lunges, prancha, prancha lateral, crunch, reverse crunch, elevação de pernas, dead bug, hollow hold, mountain climbers, bird dog, superman, ponte de glúteo, wall sit, gémeos em pé, scapular push-up, mobilidade e alongamentos.
- Halteres: curls, press militar, elevações, reverse fly, supino com halteres, aberturas, pullover, remo unilateral, agachamento goblet, peso morto romeno com halteres, farmer walk, wrist curl, pronação/supinação, desvios do punho e encolhimento.
- Barra / discos: curl com barra, supino, supino fechado, press militar, remo, peso morto romeno/tradicional, agachamento com barra, good morning, encolhimento com barra, tríceps testa, extensão francesa, plate hold e pinch grip.
- Cabo / máquina: puxadas, remadas, pullover no cabo, face pull, crossover, extensões de tríceps, curl no cabo, Pallof press e kickback no cabo.
- Banco: supinos, aberturas inclinadas, curl inclinado, agachamento búlgaro, step-up, fundos entre apoios e hip thrust.
- Barra fixa: dead hang, chin-up, pull-up, scapular pull-up, elevação de joelhos suspenso e towel grip hold.
- Elásticos: rotações do ombro, face pull, pull-apart, extensão de dedos, Pallof press, remo, curl e tríceps com elástico.
- Cardio: passadeira, bicicleta, elíptica, corda, caminhada exterior, corrida exterior, sprints e HIIT exterior.
- Dojo / artes marciais: Kihon, Kata, Kumite, sombra de Karate, deslocamentos, guarda, pontapés, socos, shrimp, ponte de grappling, technical stand-up, passagens de guarda, mobilidade e condicionamento leve.

## Exercícios por grupo muscular

- Braços: curls, chin-up, extensões de tríceps, fundos, flexões fechadas e variações com cabo/elástico.
- Antebraço / pega: wrist curl, reverse wrist curl, farmer walk, dead hang, pinch grip, plate hold, towel grip hold, finger curls e desvios do punho.
- Peito: flexões, supinos, aberturas, squeeze press, chest press, dips para peito e crossover.
- Costas: puxadas, remadas, pull-up/chin-up, pullover, face pull e hiperextensão.
- Ombros: press militar, Arnold press, elevações, reverse fly, rotações e Y/W raise.
- Parte inferior: agachamentos, lunges, step-up, leg press, peso morto, curl de perna, ponte, hip thrust, adução/abdução, gémeos e tibial.
- Core: prancha, crunches, elevação de pernas, dead bug, hollow hold, mountain climbers, Pallof, Russian twist, bird dog e variações.
- Cardio: passadeira, bicicleta, elíptica, corda, caminhada/corrida exterior e HIIT.
- Artes marciais: Karate, Jiu-Jitsu, mobilidade, core e condicionamento específico.

## Erros encontrados na arquitetura antiga

- Regiões, grupos musculares, músculos específicos, equipamentos e modalidades estavam no mesmo nível.
- O nome do tipo de treino era usado como principal contrato de filtro.
- Equipamento podia ser confundido com grupo anatómico.
- Passadeira, bicicleta, elíptica e corda dependiam de correspondência textual de cardio.
- Treinos antigos não guardavam região/grupo/subgrupo/músculo/equipamento.
- A UI de criação ainda era centrada no conceito de tipo de treino, mesmo após a organização por secções.

## Correções feitas

- Criada `TrainingArchitecture` com regiões, grupos, subgrupos, músculos/capacidades e equipamentos.
- Criada `TrainingSelection` para representar a seleção anatómica/função/equipamento.
- Criada API central `ExerciseFilterService.getAvailableExercises(...)`.
- `Mostrar todos os exercícios` passou a devolver todos os exercícios com `isAvailable` e motivo de indisponibilidade.
- O formulário Novo treino passou a usar etapas pequenas: data, região, grupo, subgrupo, músculo, equipamento, nome editável, duração, notas e template.
- O treino passou a persistir `workout_region_key`, `workout_group_key`, `workout_subgroup_key`, `workout_specific_muscle_key` e `workout_equipment_key`.
- A migração v0.7.0 cria tabelas `body_regions`, `workout_focuses`, `equipment`, `exercise_equipment`, `exercise_muscles` e `exercise_focus_map`.
- Tipos antigos são mapeados para a nova arquitetura sem apagar histórico.
- O catálogo seed foi expandido por equipamento e grupo muscular.
- A versão foi atualizada para `0.7.0+9` e a app mostra `v0.7.0`.

## Testes automáticos criados

Arquivo: `test/v070_training_architecture_test.dart`

- Hierarquia região -> grupo -> subgrupo -> músculo.
- Catálogo de equipamentos base.
- Braços completo inclui bíceps, tríceps, braquial, braquiorradial, antebraço e pega.
- Bíceps não mostra tríceps.
- Tríceps não mostra bíceps.
- Antebraço/Pega não mostra supino.
- Peito não mostra pernas.
- Costas não mostra curl de bíceps isolado.
- Ombros não mostra supino como exercício principal.
- Pernas completo mostra quadríceps, posterior, glúteos, gémeos, adutores e abdutores.
- Quadríceps não mostra curl de bíceps.
- Glúteos não mostra peito.
- Core não mostra bíceps.
- Passadeira, bicicleta e elíptica ficam isoladas por modalidade.
- Cardio geral mostra várias modalidades.
- Karate e Jiu-Jitsu não misturam drills exclusivos.
- Casa com halteres mostra halteres/peso corporal e exclui cabo.
- Casa com/sem passadeira filtra passadeira corretamente.
- Ginásio respeita subcategoria mesmo com equipamento completo.
- Mostrar todos ignora filtros mas marca indisponíveis.
- Exercícios apresentados têm descrição, passos e equipamento.

## Resultado dos testes

- `flutter pub get`: concluído.
- `flutter analyze`: sem issues.
- `flutter test`: 69 testes passaram.
- `flutter build apk --release`: APK release gerado em `build\app\outputs\flutter-apk\app-release.apk`.
- `Get-ChildItem build\app\outputs\flutter-apk\`: confirmou `app-release.apk` com 54,182,673 bytes.

## Limitações conhecidas

- As novas tabelas normalizadas são criadas e semeadas como base arquitetural, mas o filtro runtime ainda usa a camada de serviço `TrainingArchitecture` para manter compatibilidade com dados antigos e evitar migração destrutiva.
- A vista alternativa por equipamento está preparada pela seleção opcional de equipamento e pelo catálogo de equipamentos, mas ainda não tem um ecrã dedicado separado do fluxo principal.
- O catálogo foi expandido para a lista mínima obrigatória, mas exercícios personalizados antigos continuam a depender dos campos textuais preenchidos pelo utilizador.
