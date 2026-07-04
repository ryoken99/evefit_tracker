# Inventário de conteúdo dos exercícios (v0.9.1)

Gerado por `tool/exercise_content_inventory.dart`.

Origem dos dados: os exercícios são definidos em `lib/database/seed_data.dart` (`SeedData.exercisesByGroup`), materializados por `lib/services/exercise_catalog_context_service.dart` (`ExerciseCatalogContextService._buildEntries`, textos em `_entrySpecificDetails`) com equipamento/músculos secundários base em `lib/services/exercise_catalog_detail_service.dart`. As tags anatómicas vêm de `lib/services/training_architecture.dart` (`tagsForExercise`).

## Totais

- Total de exercícios encontrados: **315**
- Nomes únicos: 309

### Por tipo (FASE 2)

- peso_corporal: 64
- halteres: 55
- cardio: 49
- mobilidade: 26
- artes_marciais: 22
- elastico: 19
- barra: 18
- cabo: 18
- alongamento: 18
- isometria: 13
- maquina: 13

### Por grupo muscular

- Pescoço: 4
- Trapézio: 5
- Ombros: 21
- Peito: 23
- Costas: 19
- Lombar: 8
- Bíceps: 17
- Tríceps: 20
- Antebraço/Pega: 19
- Core: 19
- Pernas: 45
- Cardio: 49
- Karate: 11
- Jiu-Jitsu: 11
- Mobilidade: 44

### Por equipamento

- Peso corporal: 113
- Halteres: 45
- Elásticos: 20
- Cabo / polia: 15
- Barra: 13
- Passadeira: 11
- Tatami / espaço de artes marciais: 10
- Máquina: 10
- Espaço exterior: 9
- Barra fixa: 7
- Bicicleta: 7
- Halteres, banco ou chão estável: 6
- Corda de saltar: 6
- Elíptica: 6
- Banco / cadeira / apoio: 6
- Cabo alto / polia: 3
- Peso corporal, banco / cadeira / apoio: 3
- Paralelas: 2
- Discos: 2
- Halteres, banco inclinado ou apoio estável: 2
- Barra ou barra EZ: 2
- Barra EZ: 2
- Mochila com peso: 2
- Banco romano / máquina: 2
- Halteres, espaço livre: 1
- Cabo de vassoura: 1
- Garrafão de água: 1
- Banco / cadeira / apoio estável: 1
- Mesa resistente: 1
- Máquina assistida de dips: 1
- Halteres, banco inclinado: 1
- Barra, banco declinado: 1
- Halteres, banco declinado: 1
- Peso corporal, tapete / colchonete: 1
- Barra fixa, toalha: 1

### Exercícios sem descrição (0)

- (nenhum)

### Descrições acima de 280 caracteres (0)

- (nenhum)

### Linguagem proibida (0)

- (nenhum)

### Execução mal formatada (parágrafo numerado colado) (0)

- (nenhum)

### Execução com mais de 7 passos (0)

- (nenhum)

### Execução com menos de 4 passos (0)

- (nenhum)

### Passos acima de 180 caracteres (0)

- (nenhum)

### Textos repetidos entre exercícios (0)

- (nenhum)

### Marcados para revisão manual (tipo ambíguo) (0)

- (nenhum)

### Precisam de revisão completa (0)

- (nenhum)

## Lista completa de exercícios

### E001 — Isometria cervical frontal leve

- Chave estável: `isometria_cervical_frontal_leve__pescoco`
- Grupo principal: Pescoço
- Grupos secundários: Trapézio superior, escalenos e estabilizadores cervicais
- Músculos principais (tags): anterior_neck, cervical_stabilizers
- Equipamento: Peso corporal
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Pescoço"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (134 chars): Pressão isométrica leve da testa contra a mão para ativar flexores cervicais sem mover a cabeça. Serve para treinar controlo cervical.
- Execução (7 passos):
  - Coloca-te numa posição estável, com espaço livre e Peso corporal preparado.
  - Coloca a palma da mão na testa e empurra a cabeça contra ela, sem deixar a cabeça mexer.
  - Organiza pés, tronco e cabeça antes de iniciar a repetição; mantém ombros afastados das orelhas e punhos alinhados quando as mãos participarem.
  - Executa a ação do exercício devagar até à amplitude em que controlas o músculo ou articulação trabalhados.
  - Pausa um instante no ponto de maior esforço sem prender a respiração.
  - Regressa devagar ao início, controlando o corpo até à posição de partida.
  - Reduz a dificuldade ou a amplitude se perderes alinhamento, equilíbrio ou controlo.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Usa força muito leve. Para imediatamente com tontura, formigueiro, dor irradiada, pressão na cabeça, visão turva ou dor aguda no pescoço.

### E002 — Isometria cervical lateral leve

- Chave estável: `isometria_cervical_lateral_leve__pescoco`
- Grupo principal: Pescoço
- Grupos secundários: Trapézio superior, escalenos e estabilizadores cervicais
- Músculos principais (tags): lateral_neck, cervical_stabilizers
- Equipamento: Peso corporal
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Pescoço"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (86 chars): Inclinação ou pressão lateral leve da cabeça para trabalhar controlo cervical de lado.
- Execução (7 passos):
  - Coloca-te numa posição estável, com espaço livre e Peso corporal preparado.
  - Coloca a palma da mão ao lado da cabeça e empurra contra ela, sem deixar a cabeça inclinar.
  - Organiza pés, tronco e cabeça antes de iniciar a repetição; mantém ombros afastados das orelhas e punhos alinhados quando as mãos participarem.
  - Executa a ação do exercício devagar até à amplitude em que controlas o músculo ou articulação trabalhados.
  - Pausa um instante no ponto de maior esforço sem prender a respiração.
  - Regressa devagar ao início, controlando o corpo até à posição de partida.
  - Reduz a dificuldade ou a amplitude se perderes alinhamento, equilíbrio ou controlo.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Usa força muito leve. Para imediatamente com tontura, formigueiro, dor irradiada, pressão na cabeça, visão turva ou dor aguda no pescoço.

### E003 — Chin tuck

- Chave estável: `chin_tuck__pescoco`
- Grupo principal: Pescoço
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): anterior_neck, posterior_neck, cervical_stabilizers
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pescoço"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (123 chars): Recuar suavemente o queixo para alinhar cabeça e pescoço, como criar uma papada leve. Serve para treinar controlo cervical.
- Execução (7 passos):
  - Coloca-te numa posição estável, com espaço livre e Peso corporal preparado.
  - Recua o queixo devagar, como se quisesses criar um duplo queixo, sem inclinar a cabeça para baixo.
  - Organiza pés, tronco e cabeça antes de iniciar a repetição; mantém ombros afastados das orelhas e punhos alinhados quando as mãos participarem.
  - Executa a ação do exercício devagar até à amplitude em que controlas o músculo ou articulação trabalhados.
  - Pausa um instante no ponto de maior esforço sem prender a respiração.
  - Regressa devagar ao início, controlando o corpo até à posição de partida.
  - Reduz a dificuldade ou a amplitude se perderes alinhamento, equilíbrio ou controlo.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Usa força muito leve. Para imediatamente com tontura, formigueiro, dor irradiada, pressão na cabeça, visão turva ou dor aguda no pescoço.

### E004 — Rotação cervical controlada

- Chave estável: `rotacao_cervical_controlada__pescoco`
- Grupo principal: Pescoço
- Grupos secundários: Trapézio superior, escalenos e estabilizadores cervicais
- Músculos principais (tags): posterior_neck, lateral_neck, cervical_stabilizers
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pescoço"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (108 chars): Rotação lenta da cabeça para olhar para cada lado sem puxar o pescoço. Serve para treinar controlo cervical.
- Execução (7 passos):
  - Coloca-te numa posição estável, com espaço livre e Peso corporal preparado.
  - Roda a cabeça devagar para um lado, como se olhasses por cima do ombro, e volta ao centro antes de trocar.
  - Organiza pés, tronco e cabeça antes de iniciar a repetição; mantém ombros afastados das orelhas e punhos alinhados quando as mãos participarem.
  - Executa a ação do exercício devagar até à amplitude em que controlas o músculo ou articulação trabalhados.
  - Pausa um instante no ponto de maior esforço sem prender a respiração.
  - Regressa devagar ao início, controlando o corpo até à posição de partida.
  - Reduz a dificuldade ou a amplitude se perderes alinhamento, equilíbrio ou controlo.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Usa força muito leve. Para imediatamente com tontura, formigueiro, dor irradiada, pressão na cabeça, visão turva ou dor aguda no pescoço.

### E005 — Encolhimento de ombros com halteres

- Chave estável: `encolhimento_de_ombros_com_halteres__trapezio`
- Grupo principal: Trapézio
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): upper_traps
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Trapézio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (92 chars): Elevação dos ombros com um halter em cada mão ao lado do corpo, focada no trapézio superior.
- Execução (7 passos):
  - Segura um halter em cada mão ao lado do corpo, com os braços estendidos.
  - Fica de pé com os pés à largura da anca, tronco direito e abdómen ligeiramente ativo.
  - Mantém os punhos direitos e os cotovelos quase esticados durante todo o movimento.
  - Sobe os ombros na direção das orelhas, o mais alto que conseguires sem dobrar os braços.
  - Faz uma pausa de um segundo no topo, apertando o trapézio.
  - Desce os ombros devagar até ao ponto inicial, deixando-os alongar.
  - Não rodes os ombros em círculo nem uses impulso das pernas; mantém o pescoço relaxado e o olhar em frente.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E006 — Encolhimento de ombros com barra

- Chave estável: `encolhimento_de_ombros_com_barra__trapezio`
- Grupo principal: Trapézio
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): upper_traps
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Trapézio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (130 chars): Elevação dos ombros com uma barra segura à frente das coxas, que permite mais peso no trapézio. Serve para o treinar com controlo.
- Execução (7 passos):
  - Segura uma barra à frente das coxas com pega simétrica, à largura dos ombros.
  - Fica de pé com os pés à largura da anca, tronco direito e abdómen ligeiramente ativo.
  - Mantém os punhos direitos e os cotovelos quase esticados durante todo o movimento.
  - Sobe os ombros na direção das orelhas, o mais alto que conseguires sem dobrar os braços.
  - Faz uma pausa de um segundo no topo, apertando o trapézio.
  - Desce os ombros devagar até ao ponto inicial, deixando-os alongar.
  - Não rodes os ombros em círculo nem uses impulso das pernas; mantém o pescoço relaxado e o olhar em frente.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E007 — Encolhimento de ombros na máquina

- Chave estável: `encolhimento_de_ombros_na_maquina__trapezio`
- Grupo principal: Trapézio
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): upper_traps
- Equipamento: Máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Trapézio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (122 chars): Elevação dos ombros na máquina de encolhimentos, com trajetória guiada e apoio estável. Serve para o treinar com controlo.
- Execução (7 passos):
  - Ajusta a máquina de encolhimentos e segura as pegas com os braços estendidos ao lado do corpo.
  - Fica de pé com os pés à largura da anca, tronco direito e abdómen ligeiramente ativo.
  - Mantém os punhos direitos e os cotovelos quase esticados durante todo o movimento.
  - Sobe os ombros na direção das orelhas, o mais alto que conseguires sem dobrar os braços.
  - Faz uma pausa de um segundo no topo, apertando o trapézio.
  - Desce os ombros devagar até ao ponto inicial, deixando-os alongar.
  - Não rodes os ombros em círculo nem uses impulso das pernas; mantém o pescoço relaxado e o olhar em frente.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E008 — Remo alto leve

- Chave estável: `remo_alto_leve__trapezio`
- Grupo principal: Trapézio
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): upper_traps, mid_traps, lateral_deltoid
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Trapézio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (157 chars): Puxada alta leve com cotovelos a subir até uma altura confortável para trabalhar trapézio e ombros sem forçar. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Segura os halteres ou a barra à frente das coxas, com pega à largura dos ombros e punhos direitos.
  - Fica de pé com o tronco direito e o abdómen ativo.
  - Puxa o peso para cima, junto ao corpo, levando os cotovelos para fora e para cima.
  - Sobe apenas até os cotovelos ficarem à altura dos ombros ou abaixo, nunca mais alto.
  - Mantém os ombros afastados das orelhas e as escápulas controladas; desce o peso devagar pelo mesmo caminho, junto ao tronco.
  - Usa carga leve: este movimento é para trapézio e ombros, não para força máxima.
  - Para se sentires beliscar ou dor na frente do ombro, ou se a lombar arquear.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E009 — Face pull no cabo

- Chave estável: `face_pull_no_cabo__trapezio`
- Grupo principal: Trapézio
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): mid_traps, lower_traps, rhomboids, posterior_deltoid
- Equipamento: Cabo alto / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Trapézio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (208 chars): Puxada em direção ao rosto com cotovelos altos para treinar deltoide posterior, romboides e controlo das escápulas. Serve para treinar costas, escápulas e dorsal. Nesta lista, conta para o treino de trapézio.
- Execução (7 passos):
  - Coloca a polia do cabo na posição alta, à altura do rosto, ou prende lá o elástico.
  - Segura a corda ou pega com as palmas viradas uma para a outra.
  - Dá um passo atrás até haver tensão e fica com tronco alto.
  - Puxa a corda em direção ao rosto, separando ligeiramente as mãos.
  - Leva os cotovelos para trás e para fora, juntando as escápulas sem encolher o pescoço.
  - Para quando as mãos ficam perto das orelhas ou bochechas.
  - Volta devagar até os braços estenderem sem perder tensão.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E010 — Press militar com barra em pé

- Chave estável: `press_militar_com_barra_em_pe__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): anterior_deltoid, lateral_deltoid, deltoid_lateral
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (158 chars): Press vertical com barra feito de pé, exigindo que pernas e core estabilizem a carga acima da cabeça. Serve para treinar ombros e estabilizadores escapulares.
- Execução (7 passos):
  - Coloca a barra num suporte à altura da parte alta do peito e usa pega simétrica um pouco além dos ombros.
  - Retira a barra, dá um passo curto e fica com pés paralelos, glúteos firmes e costelas sobre a bacia.
  - Começa com a barra à frente dos ombros, cotovelos ligeiramente à frente da barra e antebraços quase verticais.
  - Afasta ligeiramente a cabeça, empurra a barra para cima e volta a colocar a cabeça entre os braços.
  - Termina com a barra sobre o meio do pé sem arquear a lombar.
  - Baixa pelo mesmo caminho até à frente dos ombros.
  - Usa menos carga se inclinares o tronco, dobrares punhos ou perderes equilíbrio.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Pratica o press vertical sentado com encosto e barra leve antes de estabilizar o peso em pé.
- Versão mais difícil: Aumenta gradualmente a barra mantendo glúteos, costelas e trajetória vertical estáveis em pé.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E011 — Press militar com halteres

- Chave estável: `press_militar_com_halteres__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): anterior_deltoid, lateral_deltoid, deltoid_lateral
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (143 chars): Press vertical com halteres, deixando cada braço estabilizar a sua própria trajetória. Serve para treinar ombros e estabilizadores escapulares.
- Execução (7 passos):
  - Segura um halter em cada mão e leva-os à altura dos ombros, com as palmas para a frente ou ligeiramente viradas uma para a outra.
  - Fica de pé com os pés à largura da anca, ou sentado num banco com encosto, com o abdómen ativo.
  - Mantém os punhos direitos por cima dos cotovelos.
  - Empurra os halteres para cima até os braços ficarem quase estendidos por cima da cabeça.
  - Aproxima ligeiramente os halteres no topo, sem os bater; desce os halteres devagar até à altura dos ombros.
  - Mantém as costelas baixas e a lombar neutra durante toda a série.
  - Usa um banco com encosto se sentires a lombar a arquear de pé.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E012 — Press militar com barra

- Chave estável: `press_militar_com_barra__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): anterior_deltoid, lateral_deltoid, deltoid_lateral
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (138 chars): Press vertical com barra a partir da frente dos ombros, empurrando acima da cabeça em linha controlada. Serve para o treinar com controlo.
- Execução (7 passos):
  - Coloca a barra num suporte à altura da parte alta do peito, ou limpa-a até aos ombros com ajuda.
  - Segura a barra com pega simétrica, um pouco mais aberta que os ombros, e punhos direitos.
  - Fica de pé (ou sentado num banco com encosto) com os pés firmes e o abdómen ativo.
  - Começa com a barra apoiada na frente dos ombros e os cotovelos ligeiramente à frente da barra.
  - Empurra a barra a direito para cima, afastando ligeiramente a cabeça para a deixar passar.
  - Termina com os braços quase estendidos e a barra por cima do meio da cabeça.
  - Desce a barra devagar pelo mesmo caminho até à frente dos ombros; não arquees a lombar nem empurres com as pernas para completar a repetição.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E013 — Arnold press

- Chave estável: `arnold_press__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): anterior_deltoid, lateral_deltoid, deltoid_lateral
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (127 chars): Press de ombros que começa com halteres à frente do peito e roda as palmas durante a subida. Serve para o treinar com controlo.
- Execução (7 passos):
  - Senta-te num banco com encosto ou fica de pé com o abdómen ativo e os pés firmes.
  - Segura os halteres à frente dos ombros, com as palmas viradas para ti, como no fim de um curl.
  - Mantém os punhos direitos e os cotovelos à frente do corpo; empurra os halteres para cima e, ao mesmo tempo, roda as palmas para a frente.
  - Termina com os braços quase estendidos por cima da cabeça e as palmas viradas para a frente.
  - Desce devagar invertendo a rotação, até as palmas voltarem a ficar viradas para ti.
  - Mantém os ombros afastados das orelhas durante a rotação.
  - Usa carga mais leve do que num press normal, porque a rotação exige mais controlo.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E014 — Elevação lateral

- Chave estável: `elevacao_lateral__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): lateral_deltoid, deltoid_lateral
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (94 chars): Elevação dos braços para os lados até perto da linha dos ombros para focar o deltoide lateral.
- Execução (6 passos):
  - Fica de pé e segura um halter em cada mão ao lado do corpo, com os cotovelos ligeiramente dobrados.
  - Mantém punhos neutros e ombros afastados das orelhas.
  - Sobe os braços para os lados até perto da altura dos ombros.
  - Mantém os cotovelos ligeiramente acima ou na linha dos punhos.
  - Desce devagar sem deixar os halteres cair.
  - Usa carga leve se precisares de balançar o tronco.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E015 — Elevação frontal

- Chave estável: `elevacao_frontal__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): anterior_deltoid
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (126 chars): Elevação dos braços à frente do corpo para focar o deltoide anterior. Serve para treinar ombros e estabilizadores escapulares.
- Execução (6 passos):
  - Segura os halteres à frente das coxas com punhos alinhados.
  - Mantém tronco alto e costelas controladas.
  - Sobe um ou ambos os braços à frente até perto da altura dos ombros.
  - Evita encolher os ombros ou arquear a lombar.
  - Desce devagar até à posição inicial.
  - Usa amplitude menor se houver desconforto no ombro.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E016 — Elevação posterior

- Chave estável: `elevacao_posterior__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): posterior_deltoid, scapular_stabilizers, mid_traps
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (144 chars): Abertura dos braços para trás com o tronco inclinado, para isolar o deltoide posterior. Serve para treinar ombros e estabilizadores escapulares.
- Execução (7 passos):
  - Fica com o tronco inclinado à frente ou apoia o peito num banco inclinado.
  - Inclina o tronco à frente com a lombar neutra e deixa os braços pendurados.
  - Segura halteres leves com os braços pendurados e o pescoço relaxado.
  - Abre os braços na direção indicada pela variação, focando ombros posteriores e escápulas.
  - Mantém cotovelos ligeiramente dobrados e punhos neutros.
  - Para antes de encolher o pescoço; desce devagar.
  - Usa carga leve para não transformar em balanço.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E017 — Reverse fly

- Chave estável: `reverse_fly__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): posterior_deltoid, scapular_stabilizers, mid_traps
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (130 chars): Abertura invertida com halteres e peito apoiado ou tronco inclinado, que junta as omoplatas e trabalha a parte de trás dos ombros.
- Execução (7 passos):
  - Fica com o tronco inclinado à frente ou apoia o peito num banco inclinado.
  - Se tiveres banco inclinado, apoia lá o peito para eliminar o balanço do tronco.
  - Segura halteres leves com os braços pendurados e o pescoço relaxado.
  - Abre os braços na direção indicada pela variação, focando ombros posteriores e escápulas.
  - Mantém cotovelos ligeiramente dobrados e punhos neutros.
  - Para antes de encolher o pescoço; desce devagar.
  - Usa carga leve para não transformar em balanço.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E018 — Face pull no cabo

- Chave estável: `face_pull_no_cabo__ombros`
- Grupo principal: Ombros
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): posterior_deltoid, scapular_stabilizers, mid_traps, rhomboids
- Equipamento: Cabo alto / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (206 chars): Puxada em direção ao rosto com cotovelos altos para treinar deltoide posterior, romboides e controlo das escápulas. Serve para treinar costas, escápulas e dorsal. Nesta lista, conta para o treino de ombros.
- Execução (7 passos):
  - Coloca a polia do cabo na posição alta, à altura do rosto, ou prende lá o elástico.
  - Segura a corda ou pega com as palmas viradas uma para a outra.
  - Dá um passo atrás até haver tensão e fica com tronco alto.
  - Puxa a corda em direção ao rosto, separando ligeiramente as mãos.
  - Leva os cotovelos para trás e para fora, juntando as escápulas sem encolher o pescoço.
  - Para quando as mãos ficam perto das orelhas ou bochechas.
  - Volta devagar até os braços estenderem sem perder tensão.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E019 — Face pull com elástico

- Chave estável: `face_pull_com_elastico__ombros`
- Grupo principal: Ombros
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): posterior_deltoid, scapular_stabilizers, mid_traps, rhomboids
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (162 chars): Puxada em direção ao rosto com cotovelos altos para treinar deltoide posterior, romboides e controlo das escápulas. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Coloca a polia do cabo na posição alta, à altura do rosto, ou prende lá o elástico.
  - Prende o elástico num ponto firme à altura do rosto e afasta-te até criar tensão.
  - Segura a corda ou pega com as palmas viradas uma para a outra.
  - Dá um passo atrás até haver tensão e fica com tronco alto.
  - Puxa a corda em direção ao rosto, separando ligeiramente as mãos.
  - Leva os cotovelos para trás e para fora, juntando as escápulas sem encolher o pescoço.
  - Para quando as mãos ficam perto das orelhas ou bochechas; volta devagar até os braços estenderem sem perder tensão.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E020 — Pull-apart

- Chave estável: `pull_apart__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): posterior_deltoid, scapular_stabilizers, mid_traps
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Abrir um elástico à frente do peito para aproximar escápulas e ativar deltoide posterior. Serve para treinar ombros e estabilizadores escapulares.
- Execução (6 passos):
  - Fica em base estável com Elásticos controlado.
  - Mantém tronco alto, abdómen ativo e ombros afastados das orelhas.
  - Leva o peso ou os braços pela trajetória do exercício sem perder punhos alinhados.
  - Para na amplitude em que controlas o ombro sem dor.
  - Regressa devagar, controlando o retorno.
  - Reduz o peso se precisares de inclinar o tronco ou encolher o pescoço.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E021 — Mobilidade de ombro com elástico

- Chave estável: `mobilidade_de_ombro_com_elastico__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): scapular_stabilizers, external_rotators
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (129 chars): Exercício de Ombros com movimento específico de Mobilidade de ombro com elástico, feito para controlar a área trabalhada sem dor.
- Execução (7 passos):
  - Segura um elástico à frente do corpo com as duas mãos, bem mais afastadas que os ombros.
  - Fica de pé com o tronco direito, costelas baixas e pescoço relaxado.
  - Mantém uma tensão leve no elástico durante todo o movimento.
  - Leva o elástico devagar à frente e acima da cabeça, com os braços quase esticados.
  - Se a mobilidade permitir sem dor, continua o arco até atrás da cabeça; regressa pelo mesmo caminho com controlo.
  - Alarga a pega para facilitar; encurta apenas quando o movimento ficar confortável.
  - Para se sentires beliscar no ombro, formigueiro ou necessidade de arquear a lombar.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E022 — Wall slides

- Chave estável: `wall_slides__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): scapular_stabilizers, serratus_anterior, lower_traps
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (155 chars): Deslizamento dos braços na parede para treinar rotação superior da escápula e mobilidade de ombro. Serve para treinar ombros e estabilizadores escapulares.
- Execução (7 passos):
  - Encosta as costas a uma parede, com os pés meio passo à frente e os joelhos suaves.
  - Encosta a lombar, as omoplatas e, se conseguires, a parte de trás da cabeça à parede.
  - Dobra os cotovelos a 90 graus e encosta os antebraços e as costas das mãos à parede, como um guarda-redes.
  - Desliza os braços lentamente pela parede para cima, mantendo antebraços e mãos em contacto.
  - Sobe apenas até onde consegues manter o contacto sem arquear a lombar.
  - Desliza de volta para baixo, levando os cotovelos na direção das costelas.
  - Mantém os ombros afastados das orelhas e o pescoço relaxado; faz 6 a 10 repetições lentas, com atenção à zona das omoplatas.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E023 — Rotação externa

- Chave estável: `rotacao_externa__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): external_rotators, teres_minor, scapular_stabilizers
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (135 chars): Rotação do ombro para fora com cotovelo fixo, fortalecendo o manguito rotador. Serve para treinar ombros e estabilizadores escapulares.
- Execução (6 passos):
  - Fica de pé ou sentado e mantém o cotovelo colado ao corpo, dobrado a 90 graus, com o antebraço à frente da barriga.
  - Segura o elástico ou a pega com o punho direito.
  - Roda o antebraço para fora, afastando a mão da barriga sem descolar o cotovelo.
  - Usa uma amplitude pequena e sem dor, sentindo a parte de trás do ombro.
  - Regressa devagar ao centro, controlando a resistência.
  - Escolhe uma resistência muito leve.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E024 — Rotação externa com elástico

- Chave estável: `rotacao_externa_com_elastico__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): external_rotators, teres_minor, scapular_stabilizers
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (128 chars): Rotação externa do ombro contra elástico, com cotovelo colado ao corpo. Serve para treinar ombros e estabilizadores escapulares.
- Execução (7 passos):
  - Fica de pé ou sentado e mantém o cotovelo colado ao corpo, dobrado a 90 graus, com o antebraço à frente da barriga.
  - Prende o elástico à altura do cotovelo e fica de lado para o ponto de fixação.
  - Segura o elástico ou a pega com o punho direito.
  - Roda o antebraço para fora, afastando a mão da barriga sem descolar o cotovelo.
  - Usa uma amplitude pequena e sem dor, sentindo a parte de trás do ombro.
  - Regressa devagar ao centro, controlando a resistência.
  - Escolhe uma resistência muito leve.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E025 — Rotação interna

- Chave estável: `rotacao_interna__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): internal_rotators, scapular_stabilizers
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (149 chars): Rotação do ombro para dentro contra resistência leve, controlando o cotovelo junto ao corpo. Serve para treinar ombros e estabilizadores escapulares.
- Execução (6 passos):
  - Fica de pé ou sentado e mantém o cotovelo colado ao corpo, dobrado a 90 graus, com o antebraço apontado para fora.
  - Segura o elástico ou a pega com o punho direito.
  - Roda o antebraço para dentro, trazendo a mão em direção à barriga sem descolar o cotovelo.
  - Usa uma amplitude pequena e sem dor.
  - Regressa devagar à posição inicial, resistindo à tração.
  - Escolhe uma resistência muito leve.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E026 — Rotação interna com elástico

- Chave estável: `rotacao_interna_com_elastico__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): internal_rotators, scapular_stabilizers
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (137 chars): Rotação interna do ombro contra elástico, puxando a mão para a linha do abdómen. Serve para treinar ombros e estabilizadores escapulares.
- Execução (7 passos):
  - Fica de pé ou sentado e mantém o cotovelo colado ao corpo, dobrado a 90 graus, com o antebraço apontado para fora.
  - Prende o elástico à altura do cotovelo e fica com esse lado virado para o ponto de fixação.
  - Segura o elástico ou a pega com o punho direito.
  - Roda o antebraço para dentro, trazendo a mão em direção à barriga sem descolar o cotovelo.
  - Usa uma amplitude pequena e sem dor.
  - Regressa devagar à posição inicial, resistindo à tração.
  - Escolhe uma resistência muito leve.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E027 — Y raise

- Chave estável: `y_raise__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): lower_traps, scapular_stabilizers
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (145 chars): Elevação dos braços em forma de Y para trabalhar trapézio inferior e controlo escapular. Serve para treinar ombros e estabilizadores escapulares.
- Execução (7 passos):
  - Fica com o tronco inclinado ou apoia o peito num banco e segura halteres leves com os braços pendurados e polegares para cima.
  - Mantém pescoço longo, costelas controladas e cotovelos quase estendidos.
  - Eleva os braços na diagonal para formar um Y largo acima da cabeça.
  - Inicia pelas escápulas sem encolher os ombros.
  - Pára quando braços e tronco ficam alinhados ou antes de perder a posição.
  - Baixa durante dois a três segundos até os braços ficarem pendurados.
  - Faz sem carga se sentires o trapézio superior dominar.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Desenha o Y deitado num banco inclinado, sem peso, parando antes de encolher o pescoço.
- Versão mais difícil: Acrescenta halteres leves ao desenho em Y e pausa com os polegares apontados para cima.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E028 — W raise

- Chave estável: `w_raise__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): mid_traps, external_rotators, scapular_stabilizers
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (151 chars): Elevação com cotovelos dobrados em forma de W para ativar trapézio médio e rotadores externos. Serve para treinar ombros e estabilizadores escapulares.
- Execução (7 passos):
  - Fica com o tronco inclinado ou apoia o peito num banco e segura halteres leves com os cotovelos dobrados junto ao corpo.
  - Vira polegares para cima e mantém punhos sobre a linha dos cotovelos.
  - Aproxima as escápulas e eleva os braços até formarem a letra W.
  - Mantém cotovelos dobrados enquanto rodas os ombros para fora.
  - Pausa sem projetar o queixo nem levantar os ombros.
  - Regressa devagar até aliviar a retração escapular.
  - Reduz carga ou amplitude se sentires pinçamento na frente do ombro.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Mantém a forma de W sem peso e faz apenas a retração curta das escápulas.
- Versão mais difícil: Acrescenta um elástico leve ao W sem perder a retração e a rotação externa das escápulas.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E029 — Scapular push-up

- Chave estável: `scapular_push_up__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): serratus_anterior, scapular_stabilizers
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Flexão escapular em prancha, arredondando e aproximando as escápulas sem dobrar cotovelos. Serve para treinar ombros e estabilizadores escapulares.
- Execução (7 passos):
  - Coloca-te em prancha alta, com as mãos por baixo dos ombros e o corpo em linha reta.
  - Mantém os cotovelos esticados durante todo o exercício: o movimento vem só das omoplatas.
  - Ativa o abdómen e os glúteos para a anca não descair.
  - Deixa o peito descer alguns centímetros aproximando as omoplatas uma da outra.
  - Depois empurra o chão afastando as omoplatas, arredondando ligeiramente a parte alta das costas.
  - Mantém o pescoço comprido e o olhar no chão; faz o movimento devagar, sentindo as omoplatas a deslizar.
  - Apoia os joelhos no chão para facilitar se a prancha for exigente.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E030 — Pike push-up

- Chave estável: `pike_push_up__ombros`
- Grupo principal: Ombros
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): anterior_deltoid, lateral_deltoid, serratus_anterior
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Ombros"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (83 chars): Flexão com anca elevada para transformar o empurrar em trabalho vertical de ombros.
- Execução (7 passos):
  - Começa em prancha alta e caminha com os pés na direção das mãos até a anca subir bem alto, formando um V invertido.
  - Mantém as mãos à largura dos ombros, os braços esticados e o olhar entre os pés.
  - Distribui o peso sobre os ombros e mantém o abdómen ativo.
  - Dobra os cotovelos e leva o topo da cabeça na direção do chão, entre as mãos.
  - Desce devagar até perto do chão, guiando os cotovelos numa diagonal natural; empurra o chão com as mãos e volta a estender os braços.
  - Mantém a anca alta durante toda a repetição: o esforço deve ficar nos ombros.
  - Aproxima menos os pés das mãos para facilitar, ou eleva os pés para dificultar.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E031 — Flexão clássica

- Chave estável: `flexao_classica__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): mid_chest, upper_chest, lower_chest, serratus_anterior
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (127 chars): Flexão de braços em prancha alta, aproximando o peito do chão e empurrando o corpo de volta. Serve para o treinar com controlo.
- Execução (7 passos):
  - Coloca mãos ligeiramente mais largas que os ombros; coloca pés no chão e corpo em posição de prancha.
  - Mantém abdómen ativo, glúteos ligeiramente contraídos e cabeça alinhada com a coluna.
  - Desce dobrando os cotovelos, levando o peito na direção do chão ou do apoio.
  - Mantém cotovelos controlados, sem abrir de forma agressiva para os lados.
  - Para quando o peito chegar perto do apoio ou quando perderes alinhamento.
  - Empurra o chão para voltar à posição inicial.
  - Reduz a dificuldade elevando as mãos ou apoiando joelhos se a lombar cair.
- Erros comuns: Abrir demasiado os cotovelos. | Deixar a anca cair ou subir em pico. | Dobrar os punhos. | Descer o corpo sem controlo. | Encurtar a amplitude.
- Versão mais fácil: Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E032 — Flexão com joelhos apoiados

- Chave estável: `flexao_com_joelhos_apoiados__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): mid_chest, upper_chest, lower_chest, serratus_anterior
- Equipamento: Peso corporal, tapete / colchonete
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (115 chars): Flexão com joelhos apoiados, mais leve, para aprender a linha do corpo. Serve para treinar peito, ombros e tríceps.
- Execução (7 passos):
  - Coloca mãos ligeiramente mais largas que os ombros.
  - Coloca joelhos apoiados no chão e corpo em linha dos joelhos à cabeça.
  - Mantém abdómen ativo, glúteos ligeiramente contraídos e cabeça alinhada com a coluna.
  - Desce dobrando os cotovelos, levando o peito na direção do chão ou do apoio.
  - Mantém cotovelos controlados, sem abrir de forma agressiva para os lados.
  - Para quando o peito chegar perto do apoio ou quando perderes alinhamento; empurra o chão para voltar à posição inicial.
  - Reduz a dificuldade elevando as mãos ou apoiando joelhos se a lombar cair.
- Erros comuns: Abrir demasiado os cotovelos. | Deixar a anca cair ou subir em pico. | Dobrar os punhos. | Descer o corpo sem controlo. | Encurtar a amplitude.
- Versão mais fácil: Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E033 — Flexão inclinada

- Chave estável: `flexao_inclinada__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): lower_chest, mid_chest, serratus_anterior
- Equipamento: Peso corporal, banco / cadeira / apoio
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Flexão com mãos elevadas num apoio, mais leve para o tronco, ideal para aprender o padrão de empurrar. Serve para treinar peito, ombros e tríceps.
- Execução (7 passos):
  - Coloca mãos ligeiramente mais largas que os ombros; coloca mãos num apoio alto e pés no chão.
  - Mantém abdómen ativo, glúteos ligeiramente contraídos e cabeça alinhada com a coluna.
  - Desce dobrando os cotovelos, levando o peito na direção do chão ou do apoio.
  - Mantém cotovelos controlados, sem abrir de forma agressiva para os lados.
  - Para quando o peito chegar perto do apoio ou quando perderes alinhamento.
  - Empurra o chão para voltar à posição inicial.
  - Reduz a dificuldade elevando as mãos ou apoiando joelhos se a lombar cair.
- Erros comuns: Abrir demasiado os cotovelos. | Deixar a anca cair ou subir em pico. | Dobrar os punhos. | Descer o corpo sem controlo. | Encurtar a amplitude.
- Versão mais fácil: Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E034 — Flexão declinada

- Chave estável: `flexao_declinada__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): upper_chest, serratus_anterior
- Equipamento: Peso corporal, banco / cadeira / apoio
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (114 chars): Flexão com pés elevados, aumentando a exigência no peito superior e nos ombros. Serve para o treinar com controlo.
- Execução (7 passos):
  - Coloca mãos ligeiramente mais largas que os ombros; coloca pés num apoio alto e mãos no chão.
  - Mantém abdómen ativo, glúteos ligeiramente contraídos e cabeça alinhada com a coluna.
  - Desce dobrando os cotovelos, levando o peito na direção do chão ou do apoio.
  - Mantém cotovelos controlados, sem abrir de forma agressiva para os lados.
  - Para quando o peito chegar perto do apoio ou quando perderes alinhamento.
  - Empurra o chão para voltar à posição inicial.
  - Reduz a dificuldade elevando as mãos ou apoiando joelhos se a lombar cair.
- Erros comuns: Abrir demasiado os cotovelos. | Deixar a anca cair ou subir em pico. | Dobrar os punhos. | Descer o corpo sem controlo. | Encurtar a amplitude.
- Versão mais fácil: Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E035 — Flexão aberta

- Chave estável: `flexao_aberta__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): mid_chest, upper_chest, lower_chest, serratus_anterior
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (79 chars): Flexão com mãos mais afastadas para aumentar o braço de alavanca sobre o peito.
- Execução (7 passos):
  - Coloca mãos bem mais abertas que os ombros; coloca pés no chão e corpo em posição de prancha.
  - Mantém abdómen ativo, glúteos ligeiramente contraídos e cabeça alinhada com a coluna.
  - Desce dobrando os cotovelos, levando o peito na direção do chão ou do apoio.
  - Mantém cotovelos controlados, sem abrir de forma agressiva para os lados.
  - Para quando o peito chegar perto do apoio ou quando perderes alinhamento.
  - Empurra o chão para voltar à posição inicial.
  - Reduz a dificuldade elevando as mãos ou apoiando joelhos se a lombar cair.
- Erros comuns: Abrir demasiado os cotovelos. | Deixar a anca cair ou subir em pico. | Dobrar os punhos. | Descer o corpo sem controlo. | Encurtar a amplitude.
- Versão mais fácil: Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E036 — Flexão arqueiro

- Chave estável: `flexao_arqueiro__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): mid_chest, upper_chest, lower_chest, serratus_anterior
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (141 chars): Flexão assimétrica em que o corpo se desloca para um lado enquanto o outro braço ajuda estendido. Serve para treinar peito, ombros e tríceps.
- Execução (7 passos):
  - Coloca mãos ligeiramente mais largas que os ombros.
  - Desloca o peso do corpo para um dos lados; o braço contrário fica quase esticado a ajudar.
  - Coloca pés no chão e corpo em posição de prancha; mantém abdómen ativo, glúteos ligeiramente contraídos e cabeça alinhada com a coluna.
  - Desce dobrando os cotovelos, levando o peito na direção do chão ou do apoio.
  - Mantém cotovelos controlados, sem abrir de forma agressiva para os lados.
  - Para quando o peito chegar perto do apoio ou quando perderes alinhamento; empurra o chão para voltar à posição inicial.
  - Reduz a dificuldade elevando as mãos ou apoiando joelhos se a lombar cair.
- Erros comuns: Abrir demasiado os cotovelos. | Deixar a anca cair ou subir em pico. | Dobrar os punhos. | Descer o corpo sem controlo. | Encurtar a amplitude.
- Versão mais fácil: Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E037 — Supino com barra

- Chave estável: `supino_com_barra__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): mid_chest, upper_chest, lower_chest
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (121 chars): Supino horizontal com barra, empurrando a carga do peito até quase estender os braços. Serve para o treinar com controlo.
- Execução (7 passos):
  - Posiciona-te no banco, chão ou máquina com pés bem apoiados.
  - Segura Barra com pega firme, punhos alinhados e cotovelos por baixo do peso.
  - Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso.
  - Desce o peso até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina.
  - Mantém cotovelos guiados, sem abrir completamente para os lados.
  - Empurra a carga para cima até quase estender os braços.
  - Pára se perderes o controlo da carga ou se sentires dor no ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E038 — Supino com halteres

- Chave estável: `supino_com_halteres__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): mid_chest, upper_chest, lower_chest
- Equipamento: Halteres, banco ou chão estável
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (136 chars): Supino horizontal com halteres, permitindo que cada braço controle a sua própria trajetória. Serve para treinar peito, ombros e tríceps.
- Execução (7 passos):
  - Posiciona-te no banco, chão ou máquina com pés bem apoiados.
  - Segura Halteres, banco ou chão estável com pega firme, punhos alinhados e cotovelos por baixo do peso.
  - Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso.
  - Desce o peso até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina.
  - Mantém cotovelos guiados, sem abrir completamente para os lados.
  - Empurra a carga para cima até quase estender os braços.
  - Pára se perderes o controlo da carga ou se sentires dor no ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E039 — Supino inclinado com halteres

- Chave estável: `supino_inclinado_com_halteres__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): upper_chest, serratus_anterior
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (118 chars): Supino em banco inclinado com um halter em cada mão, deixando cada braço guiar a sua trajetória para o peito superior.
- Execução (7 passos):
  - Posiciona-te no banco, chão ou máquina com pés bem apoiados.
  - Segura Halteres com pega firme, punhos alinhados e cotovelos por baixo do peso.
  - Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso.
  - Desce o peso até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina.
  - Mantém cotovelos guiados, sem abrir completamente para os lados.
  - Empurra a carga para cima até quase estender os braços.
  - Pára se perderes o controlo da carga ou se sentires dor no ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E040 — Supino inclinado com barra

- Chave estável: `supino_inclinado_com_barra__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): upper_chest, serratus_anterior
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Supino em banco inclinado com barra, empurrando o peso numa linha fixa a partir do peito superior. Serve para o treinar com controlo.
- Execução (7 passos):
  - Posiciona-te no banco, chão ou máquina com pés bem apoiados.
  - Ajusta o banco a 30 a 45 graus de inclinação antes de te deitares.
  - Segura Barra com pega firme, punhos alinhados e cotovelos por baixo do peso.
  - Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso.
  - Desce o peso até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina.
  - Mantém cotovelos guiados, sem abrir completamente para os lados; empurra a carga para cima até quase estender os braços.
  - Pára se perderes o controlo da carga ou se sentires dor no ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E041 — Supino declinado com halteres

- Chave estável: `supino_declinado_com_halteres__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): lower_chest
- Equipamento: Halteres, banco declinado
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (99 chars): Supino em banco declinado com halteres, com cada braço a controlar a descida para o peito inferior.
- Execução (7 passos):
  - Posiciona-te no banco, chão ou máquina com pés bem apoiados.
  - Segura Halteres, banco declinado com pega firme, punhos alinhados e cotovelos por baixo do peso.
  - Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso.
  - Desce o peso até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina.
  - Mantém cotovelos guiados, sem abrir completamente para os lados.
  - Empurra a carga para cima até quase estender os braços.
  - Pára se perderes o controlo da carga ou se sentires dor no ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E042 — Supino declinado com barra

- Chave estável: `supino_declinado_com_barra__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): lower_chest
- Equipamento: Barra, banco declinado
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (91 chars): Supino em banco declinado com barra, para carregar o peito inferior com trajetória estável.
- Execução (7 passos):
  - Posiciona-te no banco, chão ou máquina com pés bem apoiados.
  - Segura Barra, banco declinado com pega firme, punhos alinhados e cotovelos por baixo do peso.
  - Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso.
  - Desce o peso até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina.
  - Mantém cotovelos guiados, sem abrir completamente para os lados.
  - Empurra a carga para cima até quase estender os braços.
  - Pára se perderes o controlo da carga ou se sentires dor no ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E043 — Supino declinado na máquina

- Chave estável: `supino_declinado_na_maquina__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): lower_chest
- Equipamento: Máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (124 chars): Press declinado guiado pela máquina, com costas apoiadas e pegas na linha baixa do peito. Serve para o treinar com controlo.
- Execução (7 passos):
  - Posiciona-te no banco, chão ou máquina com pés bem apoiados.
  - Ajusta o assento para as pegas ficarem alinhadas com a parte baixa do peito.
  - Segura Máquina com pega firme, punhos alinhados e cotovelos por baixo do peso.
  - Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso.
  - Desce o peso até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina.
  - Mantém cotovelos guiados, sem abrir completamente para os lados; empurra a carga para cima até quase estender os braços.
  - Pára se perderes o controlo da carga ou se sentires dor no ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E044 — Aberturas com halteres

- Chave estável: `aberturas_com_halteres__peito`
- Grupo principal: Peito
- Grupos secundários: Deltoide anterior, bíceps como estabilizador e escápulas
- Músculos principais (tags): mid_chest, upper_chest, lower_chest
- Equipamento: Halteres, banco ou chão estável
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (118 chars): Abertura de peito com halteres em arco amplo, sem transformar o exercício em press. Serve para o treinar com controlo.
- Execução (7 passos):
  - Deita-te ou posiciona-te de forma estável e segura Halteres, banco ou chão estável com pega firme.
  - Começa com braços à frente do peito e cotovelos ligeiramente dobrados.
  - Mantém essa pequena dobra dos cotovelos durante toda a repetição.
  - Abre os braços em arco até sentires alongamento confortável no peito, sem dor no ombro.
  - Fecha o arco aproximando as mãos à frente do peito, sem bater as cargas.
  - Mantém ombros baixos e escápulas controladas.
  - Usa carga leve, porque este exercício exige mais controlo do que força bruta.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E045 — Aberturas inclinadas com halteres

- Chave estável: `aberturas_inclinadas_com_halteres__peito`
- Grupo principal: Peito
- Grupos secundários: Deltoide anterior, bíceps como estabilizador e escápulas
- Músculos principais (tags): mid_chest, upper_chest, lower_chest
- Equipamento: Halteres, banco inclinado
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (113 chars): Abertura em arco com halteres num banco inclinado, alongando o peito superior. Serve para o treinar com controlo.
- Execução (7 passos):
  - Deita-te ou posiciona-te de forma estável e segura Halteres, banco inclinado com pega firme.
  - Começa com braços à frente do peito e cotovelos ligeiramente dobrados.
  - Mantém essa pequena dobra dos cotovelos durante toda a repetição.
  - Abre os braços em arco até sentires alongamento confortável no peito, sem dor no ombro.
  - Fecha o arco aproximando as mãos à frente do peito, sem bater as cargas.
  - Mantém ombros baixos e escápulas controladas.
  - Usa carga leve, porque este exercício exige mais controlo do que força bruta.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E046 — Aberturas inclinadas no cabo

- Chave estável: `aberturas_inclinadas_no_cabo__peito`
- Grupo principal: Peito
- Grupos secundários: Deltoide anterior, bíceps como estabilizador e escápulas
- Músculos principais (tags): mid_chest, upper_chest, lower_chest
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (120 chars): Abertura em arco nas polias, com tensão constante do cabo dirigida ao peito superior. Serve para o treinar com controlo.
- Execução (7 passos):
  - Deita-te ou posiciona-te de forma estável e segura Cabo / polia com pega firme.
  - Começa com braços à frente do peito e cotovelos ligeiramente dobrados.
  - Mantém essa pequena dobra dos cotovelos durante toda a repetição.
  - Abre os braços em arco até sentires alongamento confortável no peito, sem dor no ombro.
  - Fecha o arco aproximando as mãos à frente do peito, sem bater as cargas.
  - Mantém ombros baixos e escápulas controladas.
  - Usa carga leve, porque este exercício exige mais controlo do que força bruta.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E047 — Aberturas inclinadas com elástico

- Chave estável: `aberturas_inclinadas_com_elastico__peito`
- Grupo principal: Peito
- Grupos secundários: Deltoide anterior, bíceps como estabilizador e escápulas
- Músculos principais (tags): mid_chest, upper_chest, lower_chest
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (95 chars): Abertura em arco contra elásticos presos atrás de ti, fechando os braços para o peito superior.
- Execução (7 passos):
  - Deita-te ou posiciona-te de forma estável e segura Elásticos com pega firme.
  - Começa com braços à frente do peito e cotovelos ligeiramente dobrados.
  - Mantém essa pequena dobra dos cotovelos durante toda a repetição.
  - Abre os braços em arco até sentires alongamento confortável no peito, sem dor no ombro.
  - Fecha o arco aproximando as mãos à frente do peito, sem bater as cargas.
  - Mantém ombros baixos e escápulas controladas.
  - Usa carga leve, porque este exercício exige mais controlo do que força bruta.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E048 — Squeeze press

- Chave estável: `squeeze_press__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): mid_chest, upper_chest, lower_chest
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (86 chars): Press com halteres juntos, apertando-os enquanto empurras para manter tensão no peito.
- Execução (7 passos):
  - Posiciona-te no banco, chão ou máquina com pés bem apoiados.
  - Mantém os halteres encostados um ao outro e aperta-os durante toda a repetição.
  - Segura Halteres com pega firme, punhos alinhados e cotovelos por baixo do peso.
  - Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso.
  - Desce o peso até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina.
  - Mantém cotovelos guiados, sem abrir completamente para os lados; empurra a carga para cima até quase estender os braços.
  - Pára se perderes o controlo da carga ou se sentires dor no ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E049 — Chest press

- Chave estável: `chest_press__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): mid_chest, upper_chest, lower_chest
- Equipamento: Máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (111 chars): Empurrar numa máquina guiada de peito, com costas apoiadas e pegas à frente. Serve para o treinar com controlo.
- Execução (7 passos):
  - Posiciona-te no banco, chão ou máquina com pés bem apoiados.
  - Ajusta o assento para as pegas ficarem à frente do meio do peito.
  - Segura Máquina com pega firme, punhos alinhados e cotovelos por baixo do peso.
  - Junta ligeiramente as omoplatas e mantém peito aberto sem arquear a lombar em excesso.
  - Desce o peso até uma amplitude confortável, normalmente perto do peito ou da linha indicada pela máquina.
  - Mantém cotovelos guiados, sem abrir completamente para os lados; empurra a carga para cima até quase estender os braços.
  - Pára se perderes o controlo da carga ou se sentires dor no ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E050 — Dips para peito em paralelas

- Chave estável: `dips_para_peito_em_paralelas__peito`
- Grupo principal: Peito
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): lower_chest, pectoralis_minor
- Equipamento: Paralelas
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (75 chars): Descida e subida nas paralelas com tronco inclinado para dar foco ao peito.
- Execução (5 passos):
  - Sobe para as paralelas com uma mão em cada pega e os braços esticados.
  - Inclina o tronco ligeiramente à frente e dobra os joelhos atrás do corpo.
  - Desce dobrando os cotovelos até sentires alongamento no peito, sem dor no ombro.
  - Empurra as barras para baixo com as mãos e sobe até quase estender os braços.
  - Mantém os ombros afastados das orelhas durante todo o movimento.
- Erros comuns: Abrir demasiado os cotovelos. | Deixar a anca cair ou subir em pico. | Dobrar os punhos. | Descer o corpo sem controlo. | Encurtar a amplitude.
- Versão mais fácil: Faz com apoio dos pés, elástico ou máquina assistida, mantendo a mesma trajetória articular.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E051 — Dips assistidos para peito na máquina

- Chave estável: `dips_assistidos_para_peito_na_maquina__peito`
- Grupo principal: Peito
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): lower_chest, pectoralis_minor
- Equipamento: Máquina assistida de dips
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Exercício de Peito com movimento específico de Dips assistidos para peito na máquina, feito para controlar a área trabalhada sem dor.
- Execução (6 passos):
  - Ajusta a assistência da máquina para conseguires controlar a descida e a subida.
  - Apoia os joelhos ou os pés na plataforma e segura as pegas com punhos firmes.
  - Inclina o tronco ligeiramente à frente e baixa os ombros.
  - Desce dobrando os cotovelos até um alongamento confortável no peito.
  - Empurra as pegas e sobe até quase estender os braços, sem encolher os ombros.
  - Reduz a assistência apenas quando o movimento ficar estável.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Faz com apoio dos pés, elástico ou máquina assistida, mantendo a mesma trajetória articular.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E052 — Crossover no cabo

- Chave estável: `crossover_no_cabo__peito`
- Grupo principal: Peito
- Grupos secundários: Deltoide anterior, bíceps como estabilizador e escápulas
- Músculos principais (tags): mid_chest, lower_chest, pectoralis_minor
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (84 chars): Cruzamento de cabos à frente do corpo para juntar os braços pela contração do peito.
- Execução (7 passos):
  - Ajusta as duas polias do cabo acima da altura dos ombros e escolhe carga leve.
  - Segura uma pega em cada mão e dá um passo em frente para o meio, com um pé à frente do outro.
  - Começa com os braços abertos ao lado, cotovelos ligeiramente dobrados e tronco firme.
  - Puxa as pegas para a frente e para baixo, cruzando ligeiramente as mãos à frente da anca ou do peito.
  - Mantém a mesma dobra dos cotovelos: o movimento é um arco, não um press; aperta o peito por um segundo no ponto em que as mãos se cruzam.
  - Deixa os braços abrir devagar até sentir alongamento confortável no peito.
  - Não deixes o cabo puxar os ombros para trás de repente no retorno.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E053 — Pullover com halter

- Chave estável: `pullover_com_halter__peito`
- Grupo principal: Peito
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): mid_chest, serratus_anterior
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Peito"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (186 chars): Movimento em arco dos braços acima do tronco para trabalhar dorsal ou peito conforme o contexto. Serve para treinar costas, escápulas e dorsal. Nesta lista, conta para o treino de peito.
- Execução (7 passos):
  - Deita-te num banco (ou no chão) com os pés firmes e a lombar neutra.
  - Segura um halter com as duas mãos por baixo da cabeça de cima, com os braços quase esticados sobre o peito.
  - Mantém os cotovelos ligeiramente dobrados e apontados para a frente, mais próximos que na versão para costas.
  - Desce o halter em arco para trás da cabeça até sentir alongamento no peito e nas costelas.
  - Não deixes a lombar arquear nem as costelas abrir.
  - Puxa o halter de volta pelo mesmo arco, apertando o peito ao passar por cima do rosto.
  - Faz o movimento devagar, sem balanço; usa carga leve e pega firme para o halter não escapar.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E054 — Puxada alta

- Chave estável: `puxada_alta__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): lats, teres_major, vertical_pulls, rhomboids
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (149 chars): Puxada vertical na polia alta, descendo a barra até à parte alta do peito com os cotovelos para baixo. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Ajusta o corpo ou a máquina para conseguires puxar com coluna neutra.
  - Agarra a barra com pega um pouco mais larga que os ombros e palmas para a frente.
  - Segura Cabo / polia com pega firme e punhos alinhados; antes de puxar, baixa os ombros e sente as escápulas prontas a mexer.
  - Puxa levando os cotovelos para trás ou para baixo, conforme o tipo de remada ou puxada.
  - Mantém o peito aberto e evita atirar o tronco para trás para ganhar força.
  - Para quando as costas contraem sem perder a posição da lombar.
  - Volta devagar até os braços alongarem sem soltar totalmente as escápulas.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E055 — Puxada alta pega aberta

- Chave estável: `puxada_alta_pega_aberta__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): lats, teres_major, vertical_pulls, rhomboids
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (97 chars): Puxada vertical com mãos afastadas para enfatizar a largura das costas e a descida dos cotovelos.
- Execução (7 passos):
  - Ajusta o corpo ou a máquina para conseguires puxar com coluna neutra.
  - Agarra a barra com as mãos bem mais afastadas que os ombros, para pedir mais à largura das costas.
  - Segura Cabo / polia com pega firme e punhos alinhados; antes de puxar, baixa os ombros e sente as escápulas prontas a mexer.
  - Puxa levando os cotovelos para trás ou para baixo, conforme o tipo de remada ou puxada.
  - Mantém o peito aberto e evita atirar o tronco para trás para ganhar força.
  - Para quando as costas contraem sem perder a posição da lombar.
  - Volta devagar até os braços alongarem sem soltar totalmente as escápulas.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E056 — Puxada alta pega neutra

- Chave estável: `puxada_alta_pega_neutra__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): lats, teres_major, vertical_pulls, rhomboids
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Puxada vertical com palmas viradas uma para a outra, facilitando cotovelos próximos e dorsal ativo. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Ajusta o corpo ou a máquina para conseguires puxar com coluna neutra.
  - Usa a pega em que as palmas ficam viradas uma para a outra, com os cotovelos a descer junto ao tronco.
  - Segura Cabo / polia com pega firme e punhos alinhados; antes de puxar, baixa os ombros e sente as escápulas prontas a mexer.
  - Puxa levando os cotovelos para trás ou para baixo, conforme o tipo de remada ou puxada.
  - Mantém o peito aberto e evita atirar o tronco para trás para ganhar força.
  - Para quando as costas contraem sem perder a posição da lombar.
  - Volta devagar até os braços alongarem sem soltar totalmente as escápulas.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E057 — Puxada alta pega fechada

- Chave estável: `puxada_alta_pega_fechada__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): lats, teres_major, vertical_pulls, rhomboids
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (134 chars): Puxada vertical com pega curta para sentir dorsal e braços a trabalhar perto do tronco. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Ajusta o corpo ou a máquina para conseguires puxar com coluna neutra.
  - Agarra a pega curta com as mãos próximas, para os cotovelos trabalharem colados ao corpo.
  - Segura Cabo / polia com pega firme e punhos alinhados; antes de puxar, baixa os ombros e sente as escápulas prontas a mexer.
  - Puxa levando os cotovelos para trás ou para baixo, conforme o tipo de remada ou puxada.
  - Mantém o peito aberto e evita atirar o tronco para trás para ganhar força.
  - Para quando as costas contraem sem perder a posição da lombar.
  - Volta devagar até os braços alongarem sem soltar totalmente as escápulas.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E058 — Remo baixo no cabo

- Chave estável: `remo_baixo_no_cabo__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): rhomboids, mid_traps, lats, horizontal_rows
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Puxada horizontal na polia baixa, sentado, levando a pega à cintura com os cotovelos junto ao corpo. Serve para treinar costas, escápulas e dorsal.
- Execução (6 passos):
  - Senta-te na polia baixa com os pés nos apoios e os joelhos ligeiramente dobrados.
  - Agarra a pega com as duas mãos e endireita o tronco, com o peito aberto.
  - Antes de puxar, baixa os ombros e sente as escápulas prontas a mexer.
  - Puxa a pega até à cintura, levando os cotovelos para trás junto ao corpo.
  - Junta as escápulas por um segundo, sem inclinar o tronco para trás.
  - Deixa a pega voltar devagar à frente, mantendo o cabo em tensão e a lombar direita.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E059 — Remo sentado

- Chave estável: `remo_sentado__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): rhomboids, mid_traps, lats, horizontal_rows
- Equipamento: Máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (144 chars): Remada na máquina de remo sentado, com peito apoiado ou tronco firme, puxando as pegas para trás. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Ajusta o corpo ou a máquina para conseguires puxar com coluna neutra.
  - Segura Máquina com pega firme e punhos alinhados.
  - Antes de puxar, baixa os ombros e sente as escápulas prontas a mexer.
  - Puxa levando os cotovelos para trás ou para baixo, conforme o tipo de remada ou puxada.
  - Mantém o peito aberto e evita atirar o tronco para trás para ganhar força.
  - Para quando as costas contraem sem perder a posição da lombar.
  - Volta devagar até os braços alongarem sem soltar totalmente as escápulas.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E060 — Remo unilateral com halter

- Chave estável: `remo_unilateral_com_halter__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): rhomboids, mid_traps, lats, horizontal_rows
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Remada com um halter e apoio no banco, puxando o peso para a anca um lado de cada vez. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Coloca um joelho e a mão do mesmo lado em cima de um banco estável; o outro pé fica no chão.
  - Segura o halter com a mão livre, com pega firme, o braço pendurado e o punho direito.
  - Mantém as costas planas, paralelas ao chão, e o pescoço alinhado com a coluna.
  - Antes de puxar, baixa o ombro do lado que trabalha, ativando a escápula.
  - Puxa o halter para cima, levando o cotovelo para trás junto ao tronco, na direção da anca; aperta as costas no topo sem rodar o tronco para cima.
  - Desce o halter devagar até o braço alongar por completo; completa as repetições de um lado antes de trocar; 1
  - Mantém a lombar neutra: se as costas arredondarem, reduz a carga.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Aumenta gradualmente o peso ou a pausa sem permitir rotação ou inclinação do tronco.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E061 — Remo com barra

- Chave estável: `remo_com_barra__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): rhomboids, mid_traps, lats, horizontal_rows
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (130 chars): Remada com barra e tronco inclinado, puxando o peso para a zona baixa das costelas. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Ajusta o corpo ou a máquina para conseguires puxar com coluna neutra.
  - Segura Barra com pega firme e punhos alinhados.
  - Antes de puxar, baixa os ombros e sente as escápulas prontas a mexer.
  - Puxa levando os cotovelos para trás ou para baixo, conforme o tipo de remada ou puxada.
  - Mantém o peito aberto e evita atirar o tronco para trás para ganhar força.
  - Para quando as costas contraem sem perder a posição da lombar.
  - Volta devagar até os braços alongarem sem soltar totalmente as escápulas.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E062 — Remo invertido

- Chave estável: `remo_invertido__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): rhomboids, mid_traps, lats, horizontal_rows
- Equipamento: Barra fixa
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (128 chars): Remada com o peso do corpo por baixo de uma barra baixa, puxando o peito à barra. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Coloca uma barra fixa baixa, argolas ou TRX à altura da cintura, num suporte firme.
  - Deita-te por baixo e segura a barra com pega um pouco mais larga que os ombros e punhos direitos.
  - Estica o corpo em linha reta, com os calcanhares no chão e os braços esticados.
  - Ativa o abdómen e os glúteos para a anca não descair; antes de puxar, junta ligeiramente as omoplatas.
  - Puxa o peito na direção da barra, levando os cotovelos para trás junto ao corpo.
  - Desce devagar até os braços esticarem, sem perder a linha do corpo; mantém a lombar neutra e o pescoço comprido; 1
  - Para facilitar, sobe a barra ou dobra os joelhos; para dificultar, baixa a barra.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E063 — Remo invertido em mesa resistente

- Chave estável: `remo_invertido_em_mesa_resistente__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): rhomboids, mid_traps, lats, horizontal_rows
- Equipamento: Mesa resistente
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (130 chars): Remada de peso corporal por baixo de uma mesa muito firme, puxando o peito à borda. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Ajusta o corpo ou a máquina para conseguires puxar com coluna neutra.
  - Segura Mesa resistente com pega firme e punhos alinhados.
  - Antes de puxar, baixa os ombros e sente as escápulas prontas a mexer.
  - Puxa levando os cotovelos para trás ou para baixo, conforme o tipo de remada ou puxada.
  - Mantém o peito aberto e evita atirar o tronco para trás para ganhar força.
  - Para quando as costas contraem sem perder a posição da lombar.
  - Volta devagar até os braços alongarem sem soltar totalmente as escápulas.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E064 — Pull-up

- Chave estável: `pull_up__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): lats, teres_major, vertical_pulls, rhomboids
- Equipamento: Barra fixa
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (148 chars): Puxada vertical do corpo na barra fixa com palmas para a frente, subindo o queixo em direção à barra. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Segura a barra fixa com a pega adequada ao Pull-up.
  - Começa pendurado com braços quase esticados, abdómen ativo e pernas controladas.
  - Baixa os ombros antes de puxar, ativando as escápulas.
  - Puxa o peito na direção da barra levando os cotovelos para baixo.
  - Sobe até o queixo se aproximar da barra ou até à amplitude que controlas.
  - Desce devagar até quase estender os braços, sem cair pendurado.
  - Usa assistência se precisares de balançar ou dar impulso.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Faz com apoio dos pés, elástico ou máquina assistida, mantendo a mesma trajetória articular.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E065 — Scapular pull-up

- Chave estável: `scapular_pull_up__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): scapular_stabilizers, lower_traps, lats
- Equipamento: Barra fixa
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (150 chars): Puxada curta só das escápulas na barra fixa, sem dobrar os cotovelos, para ativar o controlo escapular. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Segura a barra fixa com mãos firmes, à largura dos ombros ou um pouco mais abertas.
  - Faz repetições curtas: puxa as escápulas para baixo, segura um segundo e deixa-as subir de novo.
  - Pendura o corpo com braços esticados e pés fora do chão ou apoiados para facilitar.
  - Começa com ombros controlados, sem deixar o pescoço esmagado entre eles.
  - Puxa as escápulas para baixo e ligeiramente para trás, como se quisesses afastar os ombros das orelhas.
  - Não dobres os cotovelos; o movimento é pequeno e vem das escápulas; segura 1 a 2 segundos e volta devagar ao alongamento controlado.
  - Pára se houver dor no ombro, formigueiro nos dedos ou perda súbita de pega.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Faz com apoio dos pés, elástico ou máquina assistida, mantendo a mesma trajetória articular.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E066 — Dead hang escapular

- Chave estável: `dead_hang_escapular__costas`
- Grupo principal: Costas
- Grupos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Músculos principais (tags): scapular_stabilizers, lower_traps, lats
- Equipamento: Barra fixa
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (153 chars): Suspensão na barra alternando ombros soltos e escápulas ativas, para aprender a organizar os ombros. Serve para treinar força de pega, dedos e antebraço.
- Execução (7 passos):
  - Segura a barra fixa com mãos firmes, à largura dos ombros ou um pouco mais abertas.
  - Alterna cinco segundos pendurado com os ombros soltos e cinco segundos com as escápulas ativas.
  - Pendura o corpo com braços esticados e pés fora do chão ou apoiados para facilitar.
  - Começa com ombros controlados, sem deixar o pescoço esmagado entre eles.
  - Puxa as escápulas para baixo e ligeiramente para trás, como se quisesses afastar os ombros das orelhas.
  - Não dobres os cotovelos; o movimento é pequeno e vem das escápulas; segura 1 a 2 segundos e volta devagar ao alongamento controlado.
  - Pára se houver dor no ombro, formigueiro nos dedos ou perda súbita de pega.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E067 — Face pull no cabo

- Chave estável: `face_pull_no_cabo__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): rhomboids, mid_traps, posterior_deltoid, teres_minor
- Equipamento: Cabo alto / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (206 chars): Puxada em direção ao rosto com cotovelos altos para treinar deltoide posterior, romboides e controlo das escápulas. Serve para treinar costas, escápulas e dorsal. Nesta lista, conta para o treino de costas.
- Execução (7 passos):
  - Coloca a polia do cabo na posição alta, à altura do rosto, ou prende lá o elástico.
  - Segura a corda ou pega com as palmas viradas uma para a outra.
  - Dá um passo atrás até haver tensão e fica com tronco alto.
  - Puxa a corda em direção ao rosto, separando ligeiramente as mãos.
  - Leva os cotovelos para trás e para fora, juntando as escápulas sem encolher o pescoço.
  - Para quando as mãos ficam perto das orelhas ou bochechas.
  - Volta devagar até os braços estenderem sem perder tensão.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E068 — Pullover no cabo

- Chave estável: `pullover_no_cabo__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): lats, teres_major
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (143 chars): Movimento em arco dos braços acima do tronco para trabalhar dorsal ou peito conforme o contexto. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Coloca a polia na posição alta e prende uma barra reta ou corda.
  - Segura a pega com as duas mãos, dá um ou dois passos atrás e inclina o tronco ligeiramente à frente.
  - Começa com os braços esticados acima da cabeça, na linha do cabo, com os cotovelos quase estendidos.
  - Puxa a pega para baixo num arco largo, com os braços esticados, até às coxas.
  - Sente as costas e os dorsais a puxar, não os braços a dobrar; mantém o tronco quieto e a lombar neutra durante todo o arco.
  - Deixa a pega subir devagar pelo mesmo arco, mantendo tensão no cabo.
  - Reduz a carga se os cotovelos dobrarem para completar a repetição.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E069 — Pullover com halter

- Chave estável: `pullover_com_halter__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): lats, teres_major
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (187 chars): Movimento em arco dos braços acima do tronco para trabalhar dorsal ou peito conforme o contexto. Serve para treinar costas, escápulas e dorsal. Nesta lista, conta para o treino de costas.
- Execução (7 passos):
  - Deita-te num banco (ou no chão) com os pés firmes e a lombar neutra.
  - Segura um halter com as duas mãos por baixo da cabeça de cima, com os braços quase esticados sobre o peito.
  - Ativa o abdómen para as costelas não abrirem.
  - Leva o halter devagar em arco para trás da cabeça, mantendo a mesma dobra leve dos cotovelos.
  - Desce até sentir alongamento nas costas e nos dorsais, sem dor no ombro.
  - Puxa o halter de volta pelo mesmo arco até por cima do peito, sentindo os dorsais a trabalhar.
  - Mantém a lombar apoiada: se ela arquear, encurta o arco; usa carga leve e pega firme para o halter não escapar por cima do rosto.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E070 — Good morning sem carga

- Chave estável: `good_morning_sem_carga__costas`
- Grupo principal: Costas
- Grupos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Músculos principais (tags): erectors
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (205 chars): Inclinação do tronco pela anca, sem qualquer peso, para aprender a dobrar com a coluna neutra. Serve para treinar posterior de coxa, glúteos e lombar controlada. Nesta lista, conta para o treino de costas.
- Execução (7 passos):
  - Fica com os pés firmes à largura da anca e, se o exercício usar peso, mantém-no colado ao corpo.
  - Mantém peito aberto, coluna neutra e joelhos ligeiramente fletidos.
  - Começa levando a anca para trás, como se fosses fechar uma porta com os glúteos.
  - Deixa as mãos, ou o peso, descerem junto às pernas, sem afastar do corpo.
  - Para quando sentires alongamento no posterior de coxa sem arredondar a lombar.
  - Regressa apertando glúteos e estendendo a anca até ficar alto novamente.
  - Pára se a lombar perder posição, se houver dor aguda ou formigueiro.
- Erros comuns: Arredondar a lombar. | Dobrar demasiado os joelhos. | Não levar a anca para trás. | Subir puxando só pelas costas.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém a coluna neutra durante a dobradiça da anca. Para com dor lombar aguda, formigueiro ou perda de força.

### E071 — Puxada com braços esticados

- Chave estável: `puxada_com_bracos_esticados__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): lats, teres_major
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (159 chars): Puxada na polia alta com os braços quase estendidos, descendo a barra em arco até às coxas para isolar o dorsal. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Coloca a polia na posição alta e prende uma barra reta ou corda; segura a pega com as duas mãos à largura dos ombros e dá um passo atrás.
  - Inclina o tronco ligeiramente à frente, com a lombar neutra e o abdómen ativo.
  - Começa com os braços esticados à frente, na linha do cabo, com os cotovelos quase estendidos.
  - Puxa a barra para baixo num arco, com os braços sempre esticados, até às coxas.
  - Sente os dorsais, dos lados das costas, a fazer o trabalho, e as escápulas a descer.
  - Deixa a barra subir devagar pelo mesmo arco, mantendo tensão.
  - Se os cotovelos dobrarem muito, o exercício vira um tríceps: reduz a carga.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E072 — Remo com elástico

- Chave estável: `remo_com_elastico__costas`
- Grupo principal: Costas
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): rhomboids, mid_traps, lats, horizontal_rows
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Costas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (130 chars): Remada sentado no chão com o elástico preso aos pés, puxando as pontas às costelas. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Senta-te no chão com as pernas estendidas e passa o elástico à volta dos dois pés.
  - Segura uma ponta em cada mão com pega firme, braços esticados e tensão leve no elástico.
  - Mantém o tronco direito, a lombar neutra e o peito aberto.
  - Antes de puxar, baixa os ombros e junta ligeiramente as omoplatas.
  - Puxa as pontas na direção das costelas, levando os cotovelos para trás junto ao corpo.
  - Aperta as costas por um segundo com as escápulas juntas; deixa os braços voltar devagar à frente, mantendo alguma tensão.
  - Não inclines o tronco para trás para ganhar força: o movimento é só dos braços e costas.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E073 — Hiperextensão lombar

- Chave estável: `hiperextensao_lombar__lombar`
- Grupo principal: Lombar
- Grupos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Músculos principais (tags): erectors, quadratus_lumborum
- Equipamento: Banco romano / máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Lombar"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (159 chars): Extensão do tronco na máquina ou banco de hiperextensões, subindo até à linha reta do corpo. Serve para treinar posterior de coxa, glúteos e lombar controlada.
- Execução (6 passos):
  - Ajusta a máquina ou o banco de hiperextensões para a almofada apoiar a parte de cima das coxas.
  - Prende os pés nos apoios e cruza os braços à frente do peito.
  - Desce o tronco devagar, dobrando pela anca, até um alongamento confortável atrás das coxas.
  - Sobe o tronco apertando glúteos e posteriores até à linha reta do corpo, sem passar dela.
  - Mantém a coluna neutra durante todo o movimento, sem enrolar nem hiperestender.
  - Usa uma amplitude menor se sentires pressão na lombar.
- Erros comuns: Arredondar a lombar. | Afastar o peso do corpo. | Dobrar demasiado os joelhos. | Não levar a anca para trás. | Subir puxando só pelas costas.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém a coluna neutra e o peso perto do corpo. Para com dor lombar aguda, formigueiro, perda de força ou incapacidade de controlar a anca.

### E074 — Hiperextensão no chão

- Chave estável: `hiperextensao_no_chao__lombar`
- Grupo principal: Lombar
- Grupos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Músculos principais (tags): erectors, quadratus_lumborum
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Lombar"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (156 chars): Elevação curta do peito deitado de barriga para baixo, ativando a lombar sem equipamento. Serve para treinar posterior de coxa, glúteos e lombar controlada.
- Execução (7 passos):
  - Deita-te de barriga para baixo num tapete, com as pernas estendidas e a testa perto do chão.
  - Coloca as mãos ao lado da cabeça ou estende os braços à frente.
  - Ativa levemente os glúteos e o abdómen antes de subir.
  - Eleva o peito e a cabeça alguns centímetros do chão, num movimento pequeno e controlado.
  - Mantém o olhar para o chão para o pescoço ficar alinhado.
  - Faz uma pausa de um a dois segundos no topo; desce devagar até quase tocar no chão.
  - Procura altura pequena e estável: não é preciso subir muito para a lombar trabalhar.
- Erros comuns: Arredondar a lombar. | Dobrar demasiado os joelhos. | Não levar a anca para trás. | Subir puxando só pelas costas.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém a coluna neutra durante a dobradiça da anca. Para com dor lombar aguda, formigueiro ou perda de força.

### E075 — Hiperextensão no banco romano

- Chave estável: `hiperextensao_no_banco_romano__lombar`
- Grupo principal: Lombar
- Grupos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Músculos principais (tags): erectors, quadratus_lumborum
- Equipamento: Banco romano / máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Lombar"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (156 chars): Extensão do tronco no banco romano, com a almofada na anca e descida profunda controlada. Serve para treinar posterior de coxa, glúteos e lombar controlada.
- Execução (7 passos):
  - Ajusta o banco romano para a almofada apoiar a parte de cima das coxas, abaixo da crista da anca.
  - Prende os pés nos apoios e cruza os braços à frente do peito.
  - Começa com o corpo em linha reta, da cabeça aos calcanhares.
  - Desce o tronco devagar, dobrando pela anca, até sentir alongamento atrás das coxas.
  - Mantém a coluna neutra: dobra pela anca, não enrolando a lombar.
  - Sobe o tronco apertando glúteos e posteriores até voltar à linha reta, sem passar dela.
  - Não hiperestendas a lombar no topo nem uses impulso; usa amplitude menor se sentires pressão na lombar.
- Erros comuns: Arredondar a lombar. | Afastar o peso do corpo. | Dobrar demasiado os joelhos. | Não levar a anca para trás. | Subir puxando só pelas costas.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém a coluna neutra e o peso perto do corpo. Para com dor lombar aguda, formigueiro, perda de força ou incapacidade de controlar a anca.

### E076 — Superman isométrico

- Chave estável: `superman_isometrico__lombar`
- Grupo principal: Lombar
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): erectors, quadratus_lumborum
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Lombar"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (152 chars): Sustentação parada com braços, peito e pernas elevados do chão, para resistência da lombar. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Deita-te de barriga para baixo num tapete, com os braços estendidos à frente e as pernas esticadas.
  - Mantém o olhar para o chão e o pescoço comprido.
  - Eleva ao mesmo tempo os braços, o peito e as pernas alguns centímetros do chão.
  - Aperta os glúteos e a zona lombar sem prender a respiração.
  - Mantém a posição parado durante 10 a 20 segundos.
  - Desce braços e pernas devagar até relaxar no chão; descansa alguns segundos antes de repetir.
  - Para se sentires apertar na lombar; eleva menos ou levanta apenas braços ou pernas.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E077 — Extensão lombar quadrupede

- Chave estável: `extensao_lombar_quadrupede__lombar`
- Grupo principal: Lombar
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): erectors, quadratus_lumborum
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Lombar"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (123 chars): Exercício de Lombar com movimento específico de Extensão lombar quadrupede, feito para controlar a área trabalhada sem dor.
- Execução (6 passos):
  - Apoia mãos e joelhos no tapete, com punhos debaixo dos ombros e joelhos debaixo da anca.
  - Mantém o olhar no chão, costelas recolhidas e barriga levemente ativa.
  - Ao expirar, desliza um pé para trás até a perna ficar longa sem rodar a bacia.
  - Faz uma pausa curta com o tronco quieto e o glúteo ativo.
  - Recolhe o joelho pelo mesmo caminho, sem tocar no chão com impacto.
  - Alterna lados ou completa a série mantendo a coluna neutra.
- Erros comuns: Abrir a bacia para o lado. | Afundar entre as omoplatas. | Atirar o pé para cima. | Procurar altura em vez de estabilidade.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém o gesto pequeno e silencioso. Interrompe se a bacia rodar sempre, se a lombar apertar, se surgir dor irradiada ou se precisares de impulso para levantar a perna.

### E078 — Good morning com barra

- Chave estável: `good_morning_com_barra__lombar`
- Grupo principal: Lombar
- Grupos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Músculos principais (tags): erectors, quadratus_lumborum
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Lombar"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (162 chars): Dobradiça de anca com barra apoiada nas costas, inclinando o tronco à frente com coluna neutra. Serve para treinar posterior de coxa, glúteos e lombar controlada.
- Execução (7 passos):
  - Fica com os pés firmes à largura da anca e, se o exercício usar peso, mantém-no colado ao corpo.
  - Apoia a barra na parte alta das costas, nunca no pescoço, com pega firme; mantém peito aberto, coluna neutra e joelhos ligeiramente fletidos.
  - Começa levando a anca para trás, como se fosses fechar uma porta com os glúteos.
  - Deixa as mãos, ou o peso, descerem junto às pernas, sem afastar do corpo.
  - Para quando sentires alongamento no posterior de coxa sem arredondar a lombar.
  - Regressa apertando glúteos e estendendo a anca até ficar alto novamente.
  - Pára se a lombar perder posição, se houver dor aguda ou formigueiro.
- Erros comuns: Arredondar a lombar. | Afastar o peso do corpo. | Dobrar demasiado os joelhos. | Não levar a anca para trás. | Subir puxando só pelas costas.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém a coluna neutra e o peso perto do corpo. Para com dor lombar aguda, formigueiro, perda de força ou incapacidade de controlar a anca.

### E079 — Good morning leve isométrico

- Chave estável: `good_morning_leve_isometrico__lombar`
- Grupo principal: Lombar
- Grupos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Músculos principais (tags): erectors, quadratus_lumborum
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Lombar"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (100 chars): Inclinação do tronco pela anca mantida parada alguns segundos, para resistência da cadeia posterior.
- Execução (7 passos):
  - Fica de pé com os pés à largura da anca e as mãos atrás da cabeça ou uma barra muito leve nos ombros.
  - Dobra ligeiramente os joelhos e mantém a coluna neutra.
  - Inclina o tronco à frente dobrando pela anca, até cerca de 30 a 45 graus.
  - Para nessa posição e aguenta parado 5 a 15 segundos.
  - Mantém o peso nos calcanhares e a anca para trás.
  - Sobe apertando os glúteos até ficar direito; descansa e repete.
  - Sai da posição se a lombar começar a arredondar ou a tremer.
- Erros comuns: Arredondar a lombar. | Afastar o peso do corpo. | Dobrar demasiado os joelhos. | Não levar a anca para trás. | Subir puxando só pelas costas.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém a coluna neutra e o peso perto do corpo. Para com dor lombar aguda, formigueiro, perda de força ou incapacidade de controlar a anca.

### E080 — Extensão lombar com elástico

- Chave estável: `extensao_lombar_com_elastico__lombar`
- Grupo principal: Lombar
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): erectors, quadratus_lumborum
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Lombar"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (125 chars): Exercício de Lombar com movimento específico de Extensão lombar com elástico, feito para controlar a área trabalhada sem dor.
- Execução (7 passos):
  - Senta-te no chão ou numa cadeira e passa o elástico à volta dos pés ou de um ponto baixo firme.
  - Segura as pontas junto ao peito com as duas mãos.
  - Começa com o tronco ligeiramente inclinado à frente, com a coluna neutra.
  - Endireita o tronco devagar contra a resistência do elástico, dobrando pela anca.
  - Para quando o tronco ficar direito, sem inclinar para trás; volta devagar à inclinação inicial, controlando o elástico.
  - Mantém o movimento pequeno e suave, sentindo a lombar e os glúteos.
  - Reduz a tensão se precisares de puxar com os braços ou encolher os ombros.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E081 — Curl com barra

- Chave estável: `curl_com_barra__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Flexão dos cotovelos com barra, subindo o peso à frente do corpo com pega supinada. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (7 passos):
  - Fica de pé ou sentado com pés firmes, peito alto e abdómen ligeiramente ativo.
  - Segura Barra com a pega da variação, mantendo punhos direitos e ombros relaxados.
  - Encosta os cotovelos ao lado do tronco ou mantém-nos ligeiramente à frente se a variação pedir.
  - Sobe o peso dobrando apenas os cotovelos, sem atirar a anca para a frente nem inclinar as costas.
  - Para perto do topo quando o antebraço se aproxima do braço e sentes contração no braço.
  - Desce durante 2 a 3 segundos até quase estender os cotovelos, mantendo punhos alinhados.
  - Reduz a carga se os ombros subirem, os cotovelos fugirem ou o tronco balançar.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E082 — Curl com halteres

- Chave estável: `curl_com_halteres__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (148 chars): Flexão dos cotovelos com um halter em cada mão, subindo os dois lados ao mesmo tempo. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (7 passos):
  - Fica de pé ou sentado com pés firmes, peito alto e abdómen ligeiramente ativo.
  - Segura Halteres com a pega da variação, mantendo punhos direitos e ombros relaxados.
  - Encosta os cotovelos ao lado do tronco ou mantém-nos ligeiramente à frente se a variação pedir.
  - Sobe o peso dobrando apenas os cotovelos, sem atirar a anca para a frente nem inclinar as costas.
  - Para perto do topo quando o antebraço se aproxima do braço e sentes contração no braço.
  - Desce durante 2 a 3 segundos até quase estender os cotovelos, mantendo punhos alinhados.
  - Reduz a carga se os ombros subirem, os cotovelos fugirem ou o tronco balançar.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E083 — Curl alternado

- Chave estável: `curl_alternado__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (148 chars): Curl feito um braço de cada vez para controlar melhor cada cotovelo e evitar balanço. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (7 passos):
  - Fica de pé ou sentado com pés firmes, peito alto e abdómen ligeiramente ativo; sobe um braço de cada vez e alterna os lados, mantendo o outro halter em baixo.
  - Segura Halteres com a pega da variação, mantendo punhos direitos e ombros relaxados.
  - Encosta os cotovelos ao lado do tronco ou mantém-nos ligeiramente à frente se a variação pedir.
  - Sobe o peso dobrando apenas os cotovelos, sem atirar a anca para a frente nem inclinar as costas.
  - Para perto do topo quando o antebraço se aproxima do braço e sentes contração no braço.
  - Desce durante 2 a 3 segundos até quase estender os cotovelos, mantendo punhos alinhados.
  - Reduz a carga se os ombros subirem, os cotovelos fugirem ou o tronco balançar.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Aumenta gradualmente o peso ou a pausa sem permitir rotação ou inclinação do tronco.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E084 — Curl martelo

- Chave estável: `curl_martelo__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço, punho e pega
- Músculos principais (tags): biceps, brachialis, brachioradialis
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (110 chars): Curl de cotovelo com pega neutra, mantendo o polegar virado para cima para desafiar braquial e braquiorradial.
- Execução (7 passos):
  - Fica alto, pés firmes e Halteres ao lado do corpo.
  - Usa pega neutra, palmas viradas uma para a outra, como se segurasses dois martelos.
  - Mantém cotovelos perto do tronco e ombros relaxados.
  - Sobe os halteres em linha reta até perto dos ombros, sem rodar as palmas para cima.
  - Sente o esforço no braquial, braquiorradial e bíceps.
  - Desce lentamente até quase estender os braços.
  - Não balances o tronco para conseguir a repetição.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E085 — Curl concentrado

- Chave estável: `curl_concentrado__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (137 chars): Curl sentado com o braço apoiado na coxa para isolar a flexão do cotovelo. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (7 passos):
  - Senta-te num banco ou cadeira com as pernas afastadas e segura um halter com pega firme.
  - Apoia a parte de trás desse braço na parte interna da coxa do mesmo lado.
  - Deixa o braço pendurado com o halter, punho direito e palma para a frente.
  - Mantém o tronco inclinado à frente e a outra mão apoiada na outra coxa.
  - Sobe o halter dobrando só o cotovelo, sem mexer o ombro nem o tronco.
  - Aperta o bíceps no topo por um segundo; desce em dois a três segundos até o braço quase esticar.
  - Completa as repetições de um braço antes de trocar; 1; a coxa serve de apoio fixo: se o cotovelo sair dela, reduz a carga.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E086 — Curl inclinado com halteres

- Chave estável: `curl_inclinado_com_halteres__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Halteres, banco inclinado ou apoio estável
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (80 chars): Curl em banco inclinado, começando com o braço mais atrás para alongar o bíceps.
- Execução (7 passos):
  - Ajusta um banco inclinado entre 45 e 60 graus e senta-te com as costas e a cabeça apoiadas.
  - Deixa os braços pendurados ao lado e segura um halter em cada mão com pega firme, palmas para a frente.
  - Sente o bíceps alongado nessa posição inicial, com os punhos direitos.
  - Sobe os halteres dobrando os cotovelos, sem deixar os cotovelos vir para a frente.
  - Mantém os ombros encostados ao banco durante toda a repetição; aperta no topo e desce em dois a três segundos até alongar de novo.
  - Mantém o tronco quieto: o banco existe para impedir compensações.
  - Usa carga menor que no curl em pé, porque o bíceps parte de uma posição alongada.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E087 — Curl inverso

- Chave estável: `curl_inverso__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, extensores do antebraço, punho e pega
- Músculos principais (tags): brachialis, brachioradialis
- Equipamento: Barra ou barra EZ
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (137 chars): Curl com pega pronada, palmas para baixo, que troca parte do foco do bíceps para o antebraço. Nesta lista, conta para o treino de bíceps.
- Execução (7 passos):
  - Fica de pé com pés à largura da anca, joelhos soltos e tronco alto.
  - Segura Barra ou barra EZ à frente das coxas com pega pronada: palmas viradas para baixo e nós dos dedos para a frente.
  - Mantém os punhos alinhados, cotovelos junto ao tronco e ombros afastados das orelhas.
  - Sobe o peso dobrando os cotovelos sem rodar os punhos para cima.
  - Para quando os antebraços ficarem perto da horizontal ou quando começares a perder a pega pronada.
  - Desce devagar até quase estender os cotovelos, sem deixar os halteres cair.
  - Usa carga leve se sentires tensão excessiva no punho, porque este exercício é mais duro para antebraço e braquiorradial.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E088 — Curl inverso com halteres

- Chave estável: `curl_inverso_com_halteres__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, extensores do antebraço, punho e pega
- Músculos principais (tags): brachialis, brachioradialis
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (93 chars): Curl com pega pronada, palmas para baixo, que troca parte do foco do bíceps para o antebraço.
- Execução (7 passos):
  - Fica de pé com pés à largura da anca, joelhos soltos e tronco alto.
  - Segura Halteres à frente das coxas com pega pronada: palmas viradas para baixo e nós dos dedos para a frente.
  - Mantém os punhos alinhados, cotovelos junto ao tronco e ombros afastados das orelhas.
  - Sobe o peso dobrando os cotovelos sem rodar os punhos para cima.
  - Para quando os antebraços ficarem perto da horizontal ou quando começares a perder a pega pronada.
  - Desce devagar até quase estender os cotovelos, sem deixar os halteres cair.
  - Usa carga leve se sentires tensão excessiva no punho, porque este exercício é mais duro para antebraço e braquiorradial.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E089 — Curl Zottman

- Chave estável: `curl_zottman__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço, punho e pega
- Músculos principais (tags): biceps, brachialis, brachioradialis
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (94 chars): Curl que sobe com palma para cima e desce com palma para baixo, combinando bíceps e antebraço.
- Execução (7 passos):
  - Fica de pé com Halteres nas mãos, palmas viradas para a frente.
  - Sobe como num curl normal, mantendo cotovelos perto do tronco.
  - No topo, roda os punhos devagar até as palmas ficarem viradas para baixo.
  - Desce nessa pega pronada durante 2 a 3 segundos.
  - No fundo, volta a rodar as palmas para a frente antes da repetição seguinte.
  - Mantém punhos alinhados e ombros quietos.
  - Usa carga leve porque a descida em pronação exige muito do antebraço.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E090 — Curl cruzado no corpo

- Chave estável: `curl_cruzado_no_corpo__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço, punho e pega
- Músculos principais (tags): biceps, brachialis, brachioradialis
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Curl diagonal em que o halter sobe em direção ao ombro oposto, mantendo pega neutra. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (7 passos):
  - Fica de pé com pés firmes, tronco alto e um halter em cada mão.
  - Usa pega neutra, com as palmas viradas uma para a outra e punhos direitos.
  - Mantém o cotovelo do lado que trabalha perto das costelas.
  - Sobe o halter em diagonal em direção ao peito ou ombro oposto, como se cruzasses a linha do corpo.
  - Não rode o tronco e não leves o ombro para a frente para ganhar altura.
  - Desce pelo mesmo caminho diagonal até quase estender o cotovelo.
  - Alterna lados com controlo e pára a série se o punho deixar de ficar alinhado.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E091 — Curl spider

- Chave estável: `curl_spider__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Halteres, banco inclinado ou apoio estável
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (135 chars): Curl com peito apoiado, impedindo o tronco de ajudar a levantar a carga. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (7 passos):
  - Deita-te de barriga para baixo num banco inclinado, com o peito apoiado e os braços pendurados.
  - Segura um halter em cada mão com pega firme, palmas para a frente e punhos direitos.
  - Deixa os braços verticais, perpendiculares ao chão.
  - Sobe os halteres dobrando apenas os cotovelos, sem balançar os ombros.
  - O peito apoiado impede o tronco de ajudar: todo o esforço fica no bíceps.
  - Aperta no topo por um segundo; desce devagar até os braços quase esticarem.
  - Usa carga leve: sem impulso, o exercício é mais difícil do que parece.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E092 — Curl no cabo

- Chave estável: `curl_no_cabo__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Flexão dos cotovelos na polia baixa, com tensão constante do cabo do início ao fim. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (7 passos):
  - Coloca a polia baixa e prende uma barra reta, corda ou pega adequada.
  - Fica de frente para a polia, pés firmes, cabo já com ligeira tensão.
  - Segura a pega com punhos alinhados e cotovelos junto ao tronco.
  - Sobe a pega dobrando os cotovelos, sem deixar o cabo puxar os ombros para a frente.
  - Contraí no topo sem encostar a pega ao peito.
  - Desce devagar até quase estender os cotovelos, sem deixar as placas baterem.
  - Afasta-te ou aproxima-te da polia até a tensão ficar constante e controlável.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E093 — Curl com elástico

- Chave estável: `curl_com_elastico__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (163 chars): Flexão dos cotovelos contra um elástico pisado ou preso em baixo, com resistência a crescer no topo. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (7 passos):
  - Fica de pé ou sentado com pés firmes, peito alto e abdómen ligeiramente ativo.
  - Segura Elásticos com a pega da variação, mantendo punhos direitos e ombros relaxados.
  - Encosta os cotovelos ao lado do tronco ou mantém-nos ligeiramente à frente se a variação pedir.
  - Sobe o peso dobrando apenas os cotovelos, sem atirar a anca para a frente nem inclinar as costas.
  - Para perto do topo quando o antebraço se aproxima do braço e sentes contração no braço.
  - Desce durante 2 a 3 segundos até quase estender os cotovelos, mantendo punhos alinhados.
  - Reduz a carga se os ombros subirem, os cotovelos fugirem ou o tronco balançar.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E094 — Curl 21 com halteres

- Chave estável: `curl_21_com_halteres__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (149 chars): Sequência de curl com parciais inferiores, parciais superiores e repetições completas. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (7 passos):
  - Fica alto e segura halteres leves com pega firme, palmas para a frente e cotovelos junto às costelas.
  - Sobe sete vezes apenas da extensão quase completa até os cotovelos chegarem a cerca de 90 graus.
  - Sem descanso, faz sete repetições de 90 graus até perto dos ombros.
  - Mantém punhos direitos e não avances os cotovelos durante as parciais superiores.
  - Termina com sete curls completos do fundo ao topo.
  - Desce cada repetição com controlo e pára se precisares de balançar.
  - Escolhe carga bem menor que no curl normal porque a série soma 21 repetições.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Substitui a sequência 21 por curls completos com halteres leves e descanso normal entre séries.
- Versão mais difícil: Aumenta ligeiramente os halteres mantendo sete parciais inferiores, sete superiores e sete completas limpas.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E095 — Curl arrastado com halteres

- Chave estável: `curl_arrastado_com_halteres__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Curl em que os cotovelos recuam e a carga sobe perto do tronco, como se arrastasse. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (6 passos):
  - Fica de pé e segura um halter em cada mão à frente das coxas, com pega firme e palmas para a frente.
  - Mantém o tronco direito, os ombros relaxados e o abdómen levemente ativo.
  - Sobe os halteres colados ao tronco, deixando os cotovelos recuar, como se arrastasses o peso pelo corpo.
  - Para quando os halteres chegarem à base do peito, com os cotovelos atrás da linha do tronco.
  - Sente o bíceps a contrair no topo, sem encolher os ombros nem balançar o corpo.
  - Desce os halteres devagar pelo mesmo caminho, junto ao tronco.
- Erros comuns: Transformar o movimento num curl normal, sem recuar os cotovelos. | Balançar o tronco para subir os halteres. | Encolher os ombros durante a subida. | Afastar os halteres do tronco. | Descer depressa e sem controlo.
- Versão mais fácil: Usa halteres mais leves ou faz curls normais até dominares o recuo dos cotovelos.
- Versão mais difícil: Sobe ligeiramente os halteres ou faz a descida em três a quatro segundos.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E096 — Curl isométrico

- Chave estável: `curl_isometrico__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Braquial, braquiorradial, antebraço e estabilizadores do punho
- Músculos principais (tags): biceps, brachialis
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Curl mantido parado num ângulo definido para treinar tensão sem movimento repetido. Serve para treinar bíceps braquial, braquial e braquiorradial.
- Execução (7 passos):
  - Fica de pé, segura um halter em cada mão com pega firme e mantém os cotovelos junto ao tronco.
  - Sobe os halteres até os cotovelos ficarem dobrados a cerca de 90 graus.
  - Para nessa posição, com os punhos direitos e os antebraços paralelos ao chão.
  - Aguenta parado 15 a 30 segundos, mantendo o tronco direito.
  - Não deixes os cotovelos abrir nem os ombros subir.
  - Desce os halteres devagar no fim do tempo; descansa antes de repetir.
  - Termina a série quando os braços tremerem ao ponto de perder o ângulo.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém os punhos alinhados e os cotovelos junto ao tronco. Reduz o peso ou para se houver dor no cotovelo ou no punho.

### E097 — Chin-up

- Chave estável: `chin_up__biceps`
- Grupo principal: Bíceps
- Grupos secundários: Bíceps, braquial, antebraço, trapézio e romboides
- Músculos principais (tags): biceps, brachialis, lats, vertical_pulls
- Equipamento: Barra fixa
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Bíceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (137 chars): Puxada vertical do corpo na barra fixa com palmas viradas para ti, envolvendo mais bíceps. Serve para treinar costas, escápulas e dorsal.
- Execução (7 passos):
  - Segura a barra fixa com a pega adequada ao Chin-up.
  - Começa pendurado com braços quase esticados, abdómen ativo e pernas controladas.
  - Baixa os ombros antes de puxar, ativando as escápulas.
  - Puxa o peito na direção da barra levando os cotovelos para baixo.
  - Sobe até o queixo se aproximar da barra ou até à amplitude que controlas.
  - Desce devagar até quase estender os braços, sem cair pendurado.
  - Usa assistência se precisares de balançar ou dar impulso.
- Erros comuns: Puxar com balanço do tronco. | Encolher os ombros. | Arredondar a lombar. | Puxar atrás da nuca. | Largar a fase de retorno sem controlo.
- Versão mais fácil: Faz com apoio dos pés, elástico ou máquina assistida, mantendo a mesma trajetória articular.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E098 — Extensão de tríceps no cabo

- Chave estável: `extensao_de_triceps_no_cabo__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_lateral, triceps_medial
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Extensão dos cotovelos na polia alta, empurrando a barra para baixo com os cotovelos colados ao tronco. Serve para treinar tríceps.
- Execução (7 passos):
  - Coloca a polia na posição alta e prende uma barra reta ou pega curta.
  - Segura a pega com as palmas para baixo e punhos direitos.
  - Fica de pé de frente para o cabo, com o tronco quase direito e o abdómen ativo.
  - Cola os cotovelos ao lado do tronco durante toda a série.
  - Desce a barra estendendo os cotovelos até os braços quase esticarem; faz uma pausa curta em baixo, apertando o tríceps.
  - Deixa a barra subir devagar até os antebraços ficarem paralelos ao chão.
  - Mantém a lombar neutra e não uses o peso do tronco para empurrar.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E099 — Extensão acima da cabeça com halter

- Chave estável: `extensao_acima_da_cabeca_com_halter__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_medial
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (114 chars): Extensão com um halter seguro pelas duas mãos acima da cabeça, descendo atrás da nuca. Serve para treinar tríceps.
- Execução (7 passos):
  - Senta-te ou fica de pé com pés firmes e abdómen ativo.
  - Segura um único halter na vertical, com as duas mãos sobrepostas por baixo da cabeça de cima.
  - Segura Halteres acima da cabeça com pega firme e punhos alinhados.
  - Mantém cotovelos apontados para a frente e próximos, sem abrir demasiado; desce o peso atrás da cabeça dobrando apenas os cotovelos.
  - Para quando sentires alongamento confortável no tríceps, sem dor no ombro.
  - Estende os cotovelos para subir, mantendo costelas baixas e lombar neutra.
  - Reduz a carga se os cotovelos abrirem ou a lombar arquear.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E100 — Tríceps testa com barra EZ

- Chave estável: `triceps_testa_com_barra_ez__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_medial
- Equipamento: Barra EZ
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (128 chars): Extensão deitada com barra EZ, descendo o peso à testa e esticando os cotovelos sem mexer os ombros. Serve para treinar tríceps.
- Execução (7 passos):
  - Deita-te num banco ou no chão e segura o peso acima do peito com pega firme.
  - Agarra a barra EZ com pega na zona ondulada, com as palmas ligeiramente viradas uma para a outra.
  - Mantém punhos alinhados e braços ligeiramente inclinados para trás.
  - Dobra os cotovelos levando a carga em direção à testa ou ligeiramente atrás da cabeça.
  - Mantém os cotovelos apontados para cima, sem abrirem para os lados.
  - Estende os cotovelos até quase bloquear, contraindo o tríceps.
  - Usa carga leve e controla a descida; pára se sentires dor no cotovelo ou ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E101 — Tríceps testa com halteres

- Chave estável: `triceps_testa_com_halteres__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_medial
- Equipamento: Halteres, banco ou chão estável
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Extensão deitada com halteres em pega neutra, descendo o peso à testa com os cotovelos apontados ao teto. Serve para treinar tríceps.
- Execução (7 passos):
  - Deita-te num banco ou no chão e segura o peso acima do peito com pega firme.
  - Usa pega neutra, com as palmas dos halteres viradas uma para a outra, e desce à linha da testa.
  - Mantém punhos alinhados e braços ligeiramente inclinados para trás.
  - Dobra os cotovelos levando a carga em direção à testa ou ligeiramente atrás da cabeça.
  - Mantém os cotovelos apontados para cima, sem abrirem para os lados.
  - Estende os cotovelos até quase bloquear, contraindo o tríceps.
  - Usa carga leve e controla a descida; pára se sentires dor no cotovelo ou ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E102 — Extensão de tríceps deitado com halteres

- Chave estável: `extensao_de_triceps_deitado_com_halteres__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_medial
- Equipamento: Halteres, banco ou chão estável
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (90 chars): Extensão deitada com halteres, descendo o peso atrás da cabeça para alongar bem o tríceps.
- Execução (7 passos):
  - Deita-te num banco ou no chão e segura o peso acima do peito com pega firme.
  - Desce os halteres para trás da cabeça, e não para a testa, para alongar mais o tríceps.
  - Mantém punhos alinhados e braços ligeiramente inclinados para trás.
  - Dobra os cotovelos levando a carga em direção à testa ou ligeiramente atrás da cabeça.
  - Mantém os cotovelos apontados para cima, sem abrirem para os lados.
  - Estende os cotovelos até quase bloquear, contraindo o tríceps.
  - Usa carga leve e controla a descida; pára se sentires dor no cotovelo ou ombro.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E103 — Supino fechado

- Chave estável: `supino_fechado__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_lateral, triceps_medial
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (128 chars): Supino com barra e pega estreita, que transforma o empurrar em trabalho dominante de tríceps. Serve para o treinar com controlo.
- Execução (7 passos):
  - Deita-te num banco ou no chão com a barra acima do peito.
  - Usa pega mais fechada que num supino normal e punhos alinhados.
  - Mantém cotovelos relativamente perto do tronco.
  - Desce a barra para a zona média do peito com controlo.
  - Empurra para cima focando a extensão dos cotovelos e o tríceps.
  - Não deixes os ombros subir para as orelhas.
  - Usa carga menor se os punhos dobrarem ou os cotovelos abrirem demais.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E104 — Press fechado com halteres

- Chave estável: `press_fechado_com_halteres__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_lateral, triceps_medial
- Equipamento: Halteres, banco ou chão estável
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (122 chars): Press deitado com halteres juntos em pega neutra, empurrando com os cotovelos perto do tronco. Serve para treinar tríceps.
- Execução (7 passos):
  - Deita-te num banco ou no chão com a barra acima do peito.
  - Mantém os halteres juntos, em pega neutra, encostados um ao outro durante toda a repetição.
  - Usa pega mais fechada que num supino normal e punhos alinhados.
  - Mantém cotovelos relativamente perto do tronco; desce a barra para a zona média do peito com controlo.
  - Empurra para cima focando a extensão dos cotovelos e o tríceps.
  - Não deixes os ombros subir para as orelhas.
  - Usa carga menor se os punhos dobrarem ou os cotovelos abrirem demais.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E105 — Tate press

- Chave estável: `tate_press__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_lateral, triceps_medial
- Equipamento: Halteres, banco ou chão estável
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (100 chars): Extensão de tríceps deitado em que os halteres descem ao peito com os cotovelos abertos para o lado.
- Execução (6 passos):
  - Deita-te num banco ou no chão e segura um halter em cada mão, braços esticados por cima do peito.
  - Vira as palmas para a frente, na direção dos pés, e mantém os punhos firmes.
  - Dobra os cotovelos para fora, deixando-os abertos ao lado, e desce os halteres em direção ao meio do peito.
  - Para com as pontas dos halteres quase a tocar no peito, sem apoiar.
  - Estende os cotovelos para empurrar os halteres de volta ao topo, mantendo os ombros quietos.
  - Não transformes o movimento num supino: só os cotovelos dobram e esticam.
- Erros comuns: Transformar o movimento num supino fechado, movendo os ombros. | Deixar os cotovelos fechar junto ao tronco. | Bater com os halteres no peito. | Dobrar os punhos com a carga em cima. | Usar halteres pesados demais para controlar a descida.
- Versão mais fácil: Usa halteres muito leves ou treina primeiro a extensão francesa com um só halter.
- Versão mais difícil: Sobe ligeiramente os halteres ou acrescenta uma pausa de um segundo perto do peito.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E106 — Fundos entre apoios

- Chave estável: `fundos_entre_apoios__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_lateral, triceps_medial
- Equipamento: Banco / cadeira / apoio
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (120 chars): Descida e subida do corpo com as mãos na borda de um banco, dobrando os cotovelos para trás. Serve para treinar tríceps.
- Execução (7 passos):
  - Senta-te na borda de um banco ou cadeira estável e apoia as mãos na borda, ao lado da anca, com os dedos para a frente.
  - Desliza a anca para fora do apoio, mantendo os joelhos dobrados e os pés no chão.
  - Mantém os ombros afastados das orelhas e o peito aberto; desce o corpo dobrando os cotovelos para trás, mantendo-os próximos do tronco.
  - Desce até os cotovelos ficarem perto de 90 graus, sem dor no ombro.
  - Empurra o apoio com as mãos e sobe até os braços quase esticarem; mantém a anca perto do banco durante todo o movimento.
  - Estica as pernas à frente para dificultar; dobra-as mais para facilitar.
  - 1; para se sentires beliscar na frente do ombro ou dor na lombar.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Encurtar a descida do corpo.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Guia os cotovelos sem os abrir em excesso. Para com dor no cotovelo, no ombro ou na lombar.

### E107 — Flexão fechada

- Chave estável: `flexao_fechada__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_lateral, triceps_medial
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Flexão com as mãos mais juntas que os ombros, que carrega mais o tríceps do que a flexão normal. Serve para o treinar com controlo.
- Execução (7 passos):
  - Coloca mãos à largura dos ombros ou ligeiramente mais juntas, por baixo do peito.
  - Coloca pés no chão e corpo em posição de prancha.
  - Mantém abdómen ativo, glúteos ligeiramente contraídos e cabeça alinhada com a coluna.
  - Desce dobrando os cotovelos, levando o peito na direção do chão ou do apoio.
  - Mantém cotovelos controlados, sem abrir de forma agressiva para os lados.
  - Para quando o peito chegar perto do apoio ou quando perderes alinhamento; empurra o chão para voltar à posição inicial.
  - Reduz a dificuldade elevando as mãos ou apoiando joelhos se a lombar cair.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Encurtar a descida do corpo.
- Versão mais fácil: Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E108 — Flexão diamante

- Chave estável: `flexao_diamante__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_lateral, triceps_medial
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (106 chars): Flexão com as mãos unidas em diamante debaixo do peito, a variação de flexão mais exigente para o tríceps.
- Execução (5 passos):
  - Coloca-te em prancha, com o corpo alinhado da cabeça aos pés e os pés juntos ou pouco afastados.
  - Junta as mãos debaixo do peito, formando um diamante com os polegares e os indicadores.
  - Mantém os cotovelos próximos do tronco e o abdómen ativo.
  - Desce o corpo de forma controlada até o peito se aproximar das mãos.
  - Empurra o chão até voltares à posição inicial, sem deixar a lombar cair.
- Erros comuns: Abrir demasiado os cotovelos para os lados. | Colocar as mãos demasiado à frente do peito. | Perder o alinhamento do corpo e deixar a anca cair. | Descer sem controlo.
- Versão mais fácil: Faz com os joelhos no chão ou com as mãos apoiadas numa superfície elevada.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta em baixo ou eleva os pés num apoio estável.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E109 — Kickback de tríceps

- Chave estável: `kickback_de_triceps__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_lateral, triceps_medial
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (100 chars): Extensão do cotovelo com halter e tronco inclinado, levando o peso para trás até o tríceps contrair.
- Execução (7 passos):
  - Inclina o tronco à frente com coluna neutra e apoia uma mão num banco se precisares.
  - Apoia a mão livre num banco ou na coxa e segura o halter com pega neutra.
  - Segura o halter ou pega do cabo com o cotovelo dobrado a cerca de 90 graus.
  - Cola o braço ao lado do tronco, com o cotovelo apontado para trás.
  - Estende o cotovelo até o braço ficar quase direito, sem mexer o ombro.
  - Pausa um instante contraindo o tríceps; desce o antebraço devagar até voltar aos 90 graus.
  - Usa carga leve se o cotovelo cair ou se tiveres de balançar.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E110 — Kickback no cabo

- Chave estável: `kickback_no_cabo__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_lateral, triceps_medial
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (117 chars): Extensão do cotovelo na polia baixa com o tronco inclinado, com tensão constante do cabo. Serve para treinar tríceps.
- Execução (7 passos):
  - Inclina o tronco à frente com coluna neutra e apoia uma mão num banco se precisares.
  - Coloca a polia na posição baixa e fica de costas ligeiramente inclinado para o cabo.
  - Segura o halter ou pega do cabo com o cotovelo dobrado a cerca de 90 graus.
  - Cola o braço ao lado do tronco, com o cotovelo apontado para trás.
  - Estende o cotovelo até o braço ficar quase direito, sem mexer o ombro.
  - Pausa um instante contraindo o tríceps; desce o antebraço devagar até voltar aos 90 graus.
  - Usa carga leve se o cotovelo cair ou se tiveres de balançar.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E111 — Extensão unilateral de tríceps

- Chave estável: `extensao_unilateral_de_triceps__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_lateral, triceps_medial
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (114 chars): Extensão de um braço de cada vez com halter acima da cabeça, descendo o peso por trás. Serve para treinar tríceps.
- Execução (7 passos):
  - Fica de pé ou sentado com um halter leve numa mão; sobe esse braço até ficar vertical, com o halter por cima da cabeça e a pega firme.
  - Usa a outra mão para apoiar o cotovelo do braço que trabalha, se ajudar.
  - Dobra o cotovelo e desce o halter devagar por trás da cabeça.
  - Mantém o cotovelo apontado para a frente e junto à cabeça, sem abrir para o lado.
  - Estende o cotovelo e sobe o halter até o braço ficar quase direito.
  - Mantém as costelas baixas e a lombar neutra; completa as repetições de um braço antes de trocar; 1
  - Usa carga leve: um braço sozinho controla pior a descida.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Aumenta gradualmente o peso ou a pausa sem permitir rotação ou inclinação do tronco.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E112 — Extensão francesa com halter

- Chave estável: `extensao_francesa_com_halter__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_medial
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (123 chars): Extensão francesa com halter único, alongando a cabeça longa do tríceps atrás da cabeça. Serve para o treinar com controlo.
- Execução (7 passos):
  - Senta-te ou fica de pé com pés firmes e abdómen ativo.
  - Podes fazer o movimento sentado ou deitado; mantém os cotovelos apontados para a frente todo o tempo.
  - Segura Halteres acima da cabeça com pega firme e punhos alinhados.
  - Mantém cotovelos apontados para a frente e próximos, sem abrir demasiado; desce o peso atrás da cabeça dobrando apenas os cotovelos.
  - Para quando sentires alongamento confortável no tríceps, sem dor no ombro.
  - Estende os cotovelos para subir, mantendo costelas baixas e lombar neutra.
  - Reduz a carga se os cotovelos abrirem ou a lombar arquear.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E113 — Extensão francesa com barra EZ

- Chave estável: `extensao_francesa_com_barra_ez__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_medial
- Equipamento: Barra EZ
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (126 chars): Extensão francesa com barra EZ, com pega ondulada que alivia os punhos na descida atrás da cabeça. Serve para treinar tríceps.
- Execução (7 passos):
  - Senta-te ou fica de pé com pés firmes e abdómen ativo.
  - Segura Barra EZ acima da cabeça com pega firme e punhos alinhados.
  - Mantém cotovelos apontados para a frente e próximos, sem abrir demasiado.
  - Desce o peso atrás da cabeça dobrando apenas os cotovelos.
  - Para quando sentires alongamento confortável no tríceps, sem dor no ombro.
  - Estende os cotovelos para subir, mantendo costelas baixas e lombar neutra.
  - Reduz a carga se os cotovelos abrirem ou a lombar arquear.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E114 — Extensão francesa no cabo

- Chave estável: `extensao_francesa_no_cabo__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_medial
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (116 chars): Extensão francesa na polia, de costas para o cabo, com tensão constante atrás da cabeça. Serve para treinar tríceps.
- Execução (7 passos):
  - Senta-te ou fica de pé com pés firmes e abdómen ativo.
  - Coloca a polia na posição baixa, fica de costas para o cabo e segura a corda com pega firme atrás da cabeça.
  - Segura Cabo / polia acima da cabeça com pega firme e punhos alinhados.
  - Mantém cotovelos apontados para a frente e próximos, sem abrir demasiado; desce o peso atrás da cabeça dobrando apenas os cotovelos.
  - Para quando sentires alongamento confortável no tríceps, sem dor no ombro.
  - Estende os cotovelos para subir, mantendo costelas baixas e lombar neutra.
  - Reduz a carga se os cotovelos abrirem ou a lombar arquear.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E115 — Dips para tríceps

- Chave estável: `dips_para_triceps__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_long, triceps_lateral, triceps_medial
- Equipamento: Paralelas
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (100 chars): Descida e subida do corpo nas paralelas com o tronco vertical, para concentrar o esforço no tríceps.
- Execução (7 passos):
  - Sobe para as paralelas com uma mão em cada pega e os braços esticados.
  - Mantém o tronco o mais vertical possível: quanto mais direito, mais tríceps e menos peito.
  - Mantém os ombros afastados das orelhas e as pernas dobradas ou cruzadas atrás.
  - Desce dobrando os cotovelos para trás, junto ao corpo; desce até os cotovelos chegarem perto de 90 graus, sem dor no ombro.
  - Empurra as barras para baixo e sobe até quase estender os braços; mantém os punhos direitos e a pega firme.
  - Usa máquina assistida ou elástico nos joelhos se ainda não controlares o peso do corpo.
  - 1; mantém a lombar neutra, sem balançar as pernas para ganhar impulso.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Encurtar a descida do corpo.
- Versão mais fácil: Faz com apoio dos pés, elástico ou máquina assistida, mantendo a mesma trajetória articular.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Guia os cotovelos sem os abrir em excesso. Para com dor no cotovelo, no ombro ou na lombar.

### E116 — Tríceps no cabo com corda

- Chave estável: `triceps_no_cabo_com_corda__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_lateral, triceps_medial
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (124 chars): Extensão dos cotovelos na polia alta com corda, afastando as pontas em baixo para contrair mais. Serve para treinar tríceps.
- Execução (7 passos):
  - Coloca a polia na posição alta e prende a corda de duas pontas; segura uma ponta em cada mão com pega neutra e punhos direitos.
  - Fica de pé de frente para o cabo, com um pé ligeiramente à frente e o tronco quase direito.
  - Cola os cotovelos ao lado do tronco: eles não devem mexer durante a repetição.
  - Desce a corda estendendo os cotovelos e afasta as pontas das mãos no fim.
  - Aperta o tríceps por um segundo com os braços quase estendidos.
  - Deixa a corda subir devagar até os antebraços passarem a horizontal, sem os cotovelos levantarem.
  - Mantém a lombar neutra e os ombros afastados das orelhas; 1; reduz a carga se os cotovelos abrirem ou o tronco inclinar para pressionar.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E117 — Tríceps com elástico

- Chave estável: `triceps_com_elastico__triceps`
- Grupo principal: Tríceps
- Grupos secundários: Ombros e peito como apoio, com estabilização do tronco
- Músculos principais (tags): triceps_lateral, triceps_medial
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Tríceps"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (117 chars): Extensão dos cotovelos contra um elástico preso em cima, empurrando as pontas para baixo. Serve para treinar tríceps.
- Execução (7 passos):
  - Coloca-te numa base firme e segura Elásticos com pega firme e punhos alinhados.
  - Mantém o braço estável para que o movimento venha sobretudo do cotovelo.
  - Dobra o cotovelo, descendo a mão até um alongamento controlado no tríceps.
  - Estende o cotovelo até quase endireitar o braço.
  - Mantém ombros baixos e costelas controladas.
  - Regressa devagar, controlando o retorno.
  - Reduz o peso se houver dor no cotovelo, ombro ou punho.
- Erros comuns: Abrir demasiado os cotovelos. | Mexer o ombro em vez do cotovelo. | Arquear a lombar. | Usar peso excessivo. | Encurtar a descida.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Guia os cotovelos sem os abrir em excesso e usa um peso controlável. Para com dor no cotovelo, no ombro ou na lombar.

### E118 — Wrist curl

- Chave estável: `wrist_curl__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Músculos principais (tags): forearm_flexors, wrist
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (152 chars): Flexão do punho com antebraços apoiados, levando a palma na direção do antebraço sem mexer o cotovelo. Serve para treinar flexores do antebraço e dedos.
- Execução (7 passos):
  - Senta-te com antebraços apoiados nas coxas e palmas viradas para cima.
  - Deixa só as mãos fora do apoio, segurando Halteres com dedos fechados.
  - Baixa os nós dos dedos na direção do chão até sentires alongamento na parte interna do antebraço.
  - Fecha a pega e dobra os punhos para trazer as palmas na direção do antebraço.
  - Sobe apenas pela flexão do punho, sem levantar os antebraços.
  - Mantém cotovelos colados ao apoio; desce durante 2 segundos e inspira nessa fase.
  - Termina se aparecer dor na parte da frente do punho.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E119 — Reverse wrist curl

- Chave estável: `reverse_wrist_curl__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Músculos principais (tags): forearm_extensors, wrist
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (144 chars): Extensão do punho com antebraços apoiados, levantando os nós dos dedos contra a resistência. Serve para treinar extensores do antebraço e punho.
- Execução (7 passos):
  - Senta-te com os antebraços apoiados e palmas viradas para baixo.
  - Segura Halteres com pega leve, deixando os punhos fora do banco ou das coxas.
  - Mantém cotovelos parados e ombros relaxados.
  - Sobe os nós dos dedos para cima, como se quisesses apontar as costas da mão para o teto.
  - Para antes de sentir dor na parte de cima do punho.
  - Baixa a carga devagar até os punhos voltarem a ficar alinhados ou ligeiramente fletidos.
  - Usa carga menor se precisares de mexer cotovelos ou ombros para subir.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E120 — Farmer walk

- Chave estável: `farmer_walk__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Músculos principais (tags): grip_support, forearm_flexors
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (188 chars): Caminhada carregada em que seguras dois halteres ao lado do corpo e percorres uma distância curta sem deixar a pega ou a postura ceder. Serve para treinar força de pega, dedos e antebraço.
- Execução (7 passos):
  - Coloca os halteres ou cargas ao lado dos pés.
  - Agacha ligeiramente, pega nas cargas com punhos direitos e levanta-te com coluna neutra.
  - Mantém peito alto, ombros baixos e abdómen ativo.
  - Caminha devagar com passos curtos, sem deixar a carga bater nas pernas.
  - Mantém os punhos alinhados e aperta as pegas sem encolher os ombros.
  - Pousa as cargas dobrando joelhos e anca, não arredondando a lombar.
  - Pára se a pega começar a abrir ou se perderes postura.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E121 — Farmer hold

- Chave estável: `farmer_hold__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Músculos principais (tags): grip_support, forearm_flexors
- Equipamento: Halteres
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (155 chars): Hold bilateral parado em que seguras cargas ao lado do corpo como num farmer walk, mas sem dar passos. Serve para treinar força de pega, dedos e antebraço.
- Execução (7 passos):
  - Segura os halteres ao lado do corpo com as mãos fechadas e punhos direitos.
  - Usa halteres pesados que só consigas segurar 10 a 30 segundos com boa postura.
  - Fica de pé com pés à largura da anca, peito alto e ombros afastados das orelhas.
  - Aperta as pegas como se quisesses marcar os dedos no metal.
  - Mantém os braços esticados sem bloquear agressivamente os cotovelos.
  - Aguenta 10 a 30 segundos, respirando sem prender o ar; pousa os halteres antes de a pega falhar completamente.
  - Usa carga menor se os punhos dobrarem ou se o tronco inclinar.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E122 — Dead hang

- Chave estável: `dead_hang__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Músculos principais (tags): grip_support, forearm_flexors
- Equipamento: Barra fixa
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (144 chars): Suspensão parada na barra fixa para fortalecer a pega, os dedos e a resistência dos ombros. Serve para treinar força de pega, dedos e antebraço.
- Execução (7 passos):
  - Coloca-te por baixo de uma barra fixa firme e seca; usa um apoio para chegar lá se for alta.
  - Segura a barra com as duas mãos à largura dos ombros, com a pega completa (polegar à volta da barra).
  - Tira os pés do apoio e fica pendurado com os braços esticados; mantém os ombros ativos, sem deixar o pescoço esmagar entre eles.
  - Mantém o corpo quieto, sem balançar, com o abdómen levemente ativo.
  - Aguenta 10 a 30 segundos, respirando devagar e de forma contínua.
  - Para descer, apoia os pés primeiro e só depois solta a pega; descansa as mãos entre séries.
  - Termina antes de a pega falhar por completo, para não caíres de repente.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E123 — Aperto isométrico

- Chave estável: `aperto_isometrico__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Músculos principais (tags): grip_support, fingers, forearm_flexors
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (83 chars): Contração de aperto sustentada, focada em fechar a mão com força sem mover o braço.
- Execução (6 passos):
  - Segura um halter em posição vertical pela cabeça, uma bola firme ou a pega de um grip trainer.
  - Fica com o braço ao lado do corpo ou com o cotovelo dobrado a 90 graus, punho direito.
  - Aperta a mão com força quase máxima, como se quisesses deixar marca nos dedos.
  - Mantém o aperto durante 10 a 20 segundos sem dobrar o punho nem encolher o ombro.
  - Solta devagar e abre bem os dedos durante alguns segundos.
  - Troca de mão e repete.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E124 — Curl inverso

- Chave estável: `curl_inverso__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Braquial, braquiorradial, extensores do antebraço, punho e pega
- Músculos principais (tags): brachioradialis, forearm_extensors, wrist
- Equipamento: Barra ou barra EZ
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Curl com pega pronada, palmas para baixo, que troca parte do foco do bíceps para o antebraço. Nesta lista, conta para o treino de antebraço e pega.
- Execução (7 passos):
  - Fica de pé com pés à largura da anca, joelhos soltos e tronco alto.
  - Segura Barra ou barra EZ à frente das coxas com pega pronada: palmas viradas para baixo e nós dos dedos para a frente.
  - Mantém os punhos alinhados, cotovelos junto ao tronco e ombros afastados das orelhas.
  - Sobe o peso dobrando os cotovelos sem rodar os punhos para cima.
  - Para quando os antebraços ficarem perto da horizontal ou quando começares a perder a pega pronada.
  - Desce devagar até quase estender os cotovelos, sem deixar os halteres cair.
  - Usa carga leve se sentires tensão excessiva no punho, porque este exercício é mais duro para antebraço e braquiorradial.
- Erros comuns: Balançar o tronco para subir o peso. | Deixar os cotovelos fugir para a frente ou para trás. | Dobrar os punhos durante a repetição. | Subir só metade do caminho. | Deixar o peso descer sem controlo.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E125 — Pronação com halter

- Chave estável: `pronacao_com_halter__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Músculos principais (tags): pronators, wrist
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Rotação do antebraço para virar a palma para baixo usando um halter leve como alavanca. Serve para treinar pronadores do antebraço.
- Execução (7 passos):
  - Senta-te com o cotovelo apoiado a 90 graus e o antebraço estável.
  - Segura um halter leve por uma ponta, como uma alavanca curta.
  - Começa com a palma virada para dentro.
  - Roda devagar até a palma apontar para baixo.
  - Mantém cotovelo parado e punho alinhado.
  - Volta à posição inicial sem deixar o peso cair.
  - Usa carga muito leve, porque a alavanca aumenta o esforço.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E126 — Supinação com halter

- Chave estável: `supinacao_com_halter__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Músculos principais (tags): supinators, wrist
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Rotação do antebraço para virar a palma para cima com controlo do cotovelo e do punho. Serve para treinar supinadores do antebraço.
- Execução (7 passos):
  - Apoia o cotovelo a 90 graus e segura um halter leve por uma ponta.
  - Começa com a palma virada para dentro ou ligeiramente para baixo.
  - Roda o antebraço devagar até a palma apontar para cima.
  - Mantém cotovelo colado ao apoio e punho direito.
  - Controla a volta sem bater no fim da amplitude.
  - Trabalha devagar, sem usar o ombro para rodar.
  - Pára se houver dor no cotovelo ou punho.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E127 — Pinch grip

- Chave estável: `pinch_grip__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Músculos principais (tags): pinch_grip, fingers
- Equipamento: Discos
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (152 chars): Segurar discos em pinça, apertando com polegar e dedos sem fechar a mão à volta de uma pega grossa. Serve para treinar força de pega, dedos e antebraço.
- Execução (7 passos):
  - Escolhe um ou dois discos lisos e limpos, com peso leve para começar.
  - Coloca o disco em pé no chão ou num banco, à tua frente.
  - Agarra a borda do disco em pinça: o polegar de um lado, os outros dedos do outro.
  - Levanta o disco e mantém-no ao lado do corpo, com o braço esticado e o punho direito.
  - Aperta com força constante: só a pressão dos dedos segura o disco.
  - Aguenta 10 a 30 segundos, respirando de forma contínua; pousa o disco com controlo, dobrando as pernas e não a lombar.
  - Mantém os pés fora da linha de queda do disco; troca de mão e repete; termina antes de o disco escorregar.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E128 — Plate hold

- Chave estável: `plate_hold__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Músculos principais (tags): pinch_grip, fingers
- Equipamento: Discos
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (136 chars): Segurar um ou mais discos pela borda durante tempo definido, sem deixar escorregar. Serve para treinar força de pega, dedos e antebraço.
- Execução (7 passos):
  - Escolhe um disco com peso confortável e pega nele pela borda com uma ou duas mãos.
  - Fica de pé com o tronco direito, os ombros baixos e os pés à largura da anca.
  - Segura o disco ao lado do corpo ou à frente, com os dedos a agarrar a borda e o punho direito.
  - Aperta a borda com força constante durante 15 a 45 segundos.
  - Mantém o braço quieto e o abdómen ativo para o tronco não inclinar.
  - Pousa o disco com controlo antes de a pega abrir sozinha.
  - Descansa e troca de mão se usares só uma; mantém os pés afastados da zona onde o disco cairia.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E129 — Towel grip hold

- Chave estável: `towel_grip_hold__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Músculos principais (tags): grip_support, fingers, forearm_flexors
- Equipamento: Barra fixa, toalha
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (151 chars): Suspensão ou suporte numa toalha, exigindo que os dedos agarrem tecido em vez de uma barra rígida. Serve para treinar força de pega, dedos e antebraço.
- Execução (7 passos):
  - Pendura uma toalha resistente por cima de uma barra fixa firme, com as duas pontas ao mesmo nível.
  - Agarra uma ponta da toalha com cada mão, apertando o tecido com todos os dedos.
  - Tira o peso dos pés aos poucos: começa com os pés apoiados se for a primeira vez.
  - Fica suspenso ou semi-suspenso com os braços quase esticados e mantém os ombros ativos.
  - Aperta o tecido com força constante; a toalha exige mais dos dedos do que a barra.
  - Aguenta 5 a 20 segundos, respirando devagar; apoia os pés antes de soltar as mãos.
  - Descansa bem entre séries: a pega em tecido cansa depressa; termina antes de as mãos abrirem de repente.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E130 — Finger curls

- Chave estável: `finger_curls__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Músculos principais (tags): fingers, forearm_flexors
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Flexão dos dedos em que a carga rola para a ponta dos dedos e volta para a palma. Serve para treinar flexores do antebraço e dedos.
- Execução (7 passos):
  - Senta-te com antebraços apoiados e palmas viradas para cima.
  - Segura halteres leves junto aos dedos.
  - Deixa os halteres rolar cuidadosamente para a ponta dos dedos sem abrir a mão por completo.
  - Fecha os dedos novamente até a carga voltar para a palma.
  - Mantém punhos neutros e antebraços apoiados.
  - Faz repetições lentas, sem deixar o halter escapar.
  - Usa carga muito leve e termina antes de perder a pega.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E131 — Extensão de dedos com elástico

- Chave estável: `extensao_de_dedos_com_elastico__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): fingers, forearm_extensors
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Abertura dos dedos contra um elástico para equilibrar o trabalho de fechar a mão. Serve para treinar extensores do antebraço e punho.
- Execução (7 passos):
  - Coloca-te numa posição estável e segura Elásticos com punhos alinhados.
  - Define se o foco é segurar, rodar ou mover o punho antes de começar.
  - Mantém cotovelos controlados e ombros relaxados.
  - Executa a ação devagar, sem deixar a carga puxar o punho para uma posição dolorosa.
  - Pausa brevemente no ponto de maior esforço.
  - Regressa com controlo à posição inicial.
  - Usa carga leve se sentires dor, formigueiro ou perda de pega.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E132 — Desvio radial com halter

- Chave estável: `desvio_radial_com_halter__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Músculos principais (tags): wrist
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (74 chars): Inclinação do punho para o lado do polegar, feita devagar com halter leve.
- Execução (7 passos):
  - Senta-te ou fica de pé com um halter leve numa mão, segurando-o por uma das pontas.
  - Deixa o braço ao lado do corpo com o polegar virado para a frente.
  - Mantém o cotovelo e o ombro quietos: só o punho trabalha.
  - Inclina o punho para cima, na direção do polegar, levantando a ponta do halter.
  - Usa uma amplitude pequena e sem dor; faz uma pausa curta no topo.
  - Desce devagar até à posição inicial.
  - Usa carga muito leve: a alavanca do halter multiplica o esforço no punho.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E133 — Desvio ulnar com halter

- Chave estável: `desvio_ulnar_com_halter__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Dedos, punho, cotovelo e músculos estabilizadores do antebraço
- Músculos principais (tags): wrist
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (101 chars): Inclinação do punho para o lado do dedo mínimo, controlando uma carga pequena sem torcer o antebraço.
- Execução (7 passos):
  - Senta-te ou fica de pé com um halter leve numa mão, segurando-o pela ponta com o peso atrás da mão.
  - Deixa o braço ao lado do corpo com o polegar virado para a frente.
  - Mantém o cotovelo e o ombro quietos: o movimento é só do punho.
  - Inclina o punho para trás e para baixo, na direção do dedo mínimo.
  - Usa uma amplitude pequena e controlada, sem dor.
  - Faz uma pausa curta no fim do movimento; volta devagar à posição inicial.
  - Usa carga muito leve e pega firme para o halter não rodar na mão.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E134 — Suitcase carry

- Chave estável: `suitcase_carry__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): grip_support, forearm_flexors, anti_lateral_flexion, deep_stability
- Equipamento: Halteres, espaço livre
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (130 chars): Caminhada unilateral carregada; uma carga fica num lado do corpo e o tronco resiste a inclinar. Serve para treinar Antebraço/Pega.
- Execução (7 passos):
  - Coloca um halter ou carga no chão ao lado de um dos teus pés.
  - Agacha dobrando joelhos e anca, agarra a pega com uma mão e levanta-te com a coluna neutra.
  - Fica de pé com a carga só de um lado, como quem segura uma mala.
  - Endireita o tronco: os ombros nivelados, sem inclinar para o lado da carga nem para o contrário.
  - Caminha devagar em linha reta, com passos curtos e o abdómen ativo.
  - Mantém o punho direito e a pega firme durante todo o percurso.
  - Percorre 10 a 20 metros, pousa a carga com controlo e troca de lado; termina se o tronco começar a inclinar ou a pega a abrir.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Aumenta gradualmente o peso ou a pausa sem permitir rotação ou inclinação do tronco.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E135 — Hold estático com halteres

- Chave estável: `hold_estatico_com_halteres__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Músculos principais (tags): grip_support, forearm_flexors
- Equipamento: Halteres
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (155 chars): Hold parado de pega em que ficas imóvel a segurar halteres ao lado do corpo durante um tempo definido. Serve para treinar força de pega, dedos e antebraço.
- Execução (7 passos):
  - Segura os halteres ao lado do corpo com as mãos fechadas e punhos direitos.
  - Escolhe halteres moderados: o objetivo é aguentar 30 a 45 segundos, mais tempo que num farmer hold pesado.
  - Fica de pé com pés à largura da anca, peito alto e ombros afastados das orelhas.
  - Aperta as pegas como se quisesses marcar os dedos no metal.
  - Mantém os braços esticados sem bloquear agressivamente os cotovelos.
  - Aguenta 10 a 30 segundos, respirando sem prender o ar; pousa os halteres antes de a pega falhar completamente.
  - Usa carga menor se os punhos dobrarem ou se o tronco inclinar.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E136 — Rotação controlada com halter leve

- Chave estável: `rotacao_controlada_com_halter_leve__antebraco_pega`
- Grupo principal: Antebraço/Pega
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): wrist
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Antebraço/Pega"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (91 chars): Rotação curta e deliberada do punho com halter leve para ganhar controlo, não força máxima.
- Execução (7 passos):
  - Coloca-te numa posição estável e segura Halteres com punhos alinhados.
  - Define se o foco é segurar, rodar ou mover o punho antes de começar.
  - Mantém cotovelos controlados e ombros relaxados.
  - Executa a ação devagar, sem deixar a carga puxar o punho para uma posição dolorosa.
  - Pausa brevemente no ponto de maior esforço.
  - Regressa com controlo à posição inicial.
  - Usa carga leve se sentires dor, formigueiro ou perda de pega.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E137 — Prancha

- Chave estável: `prancha__core`
- Grupo principal: Core
- Grupos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Músculos principais (tags): anti_extension, deep_stability, transverse_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (118 chars): Suporte em linha reta para resistir à extensão da lombar. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Apoia antebraços ou mãos no chão, conforme a variação.
  - Estica as pernas e fica em linha da cabeça aos calcanhares.
  - Contrai abdómen e glúteos sem levantar demasiado a anca.
  - Mantém pescoço neutro, olhando para o chão.
  - Aguenta 10 a 40 segundos com boa forma.
  - Termina se a lombar começar a cair.
  - Para facilitar, apoia joelhos no chão.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Encurta a alavanca ou a duração e usa menos resistência sem perder a posição das costelas e da bacia.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E138 — Prancha lateral

- Chave estável: `prancha_lateral__core`
- Grupo principal: Core
- Grupos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Músculos principais (tags): external_obliques, internal_obliques, anti_lateral_flexion, deep_stability
- Equipamento: Peso corporal
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (135 chars): Suporte lateral do corpo para resistir à queda da anca e treinar oblíquos. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Apoia antebraços ou mãos no chão, conforme a variação.
  - Vira o corpo de lado, apoia o antebraço por baixo do ombro e empilha os pés ou cruza-os.
  - Estica as pernas e fica em linha da cabeça aos calcanhares.
  - Contrai abdómen e glúteos sem levantar demasiado a anca.
  - Mantém pescoço neutro, olhando para o chão.
  - Aguenta 10 a 40 segundos com boa forma.
  - Termina se a lombar começar a cair; para facilitar, apoia joelhos no chão.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Encurta a alavanca ou a duração e usa menos resistência sem perder a posição das costelas e da bacia.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E139 — Crunch

- Chave estável: `crunch__core`
- Grupo principal: Core
- Grupos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Músculos principais (tags): rectus_abdominis, transverse_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Flexão curta do tronco deitado, aproximando as costelas da bacia sem puxar o pescoço. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Deita-te de barriga para cima com joelhos fletidos ou pernas na posição da variação.
  - Mantém lombar confortável e queixo ligeiramente recolhido.
  - Sobe a parte alta do tronco aproximando costelas da bacia.
  - Não puxes o pescoço com as mãos.
  - Pausa brevemente no topo.
  - Desce devagar até ombros quase tocarem no chão.
  - Reduz amplitude se houver tensão no pescoço.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E140 — Reverse crunch

- Chave estável: `reverse_crunch__core`
- Grupo principal: Core
- Grupos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Músculos principais (tags): rectus_abdominis, transverse_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Enrolar a bacia para aproximar joelhos do tronco sem balançar as pernas. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Deita-te de costas com os joelhos dobrados a 90 graus e as canelas paralelas ao chão.
  - Coloca as mãos ao lado do corpo, com as palmas no chão; encosta a lombar ao chão ativando o abdómen.
  - Enrola a bacia para cima, levando os joelhos na direção do peito.
  - As ancas sobem ligeiramente do chão no fim do movimento; não uses impulso das pernas.
  - Faz uma pausa curta em cima; desce a bacia devagar até os joelhos voltarem à vertical.
  - Mantém o pescoço e os ombros relaxados no chão; 1
  - Faz o movimento pequeno e lento: o objetivo é enrolar, não balançar.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E141 — Elevação de pernas

- Chave estável: `elevacao_de_pernas__core`
- Grupo principal: Core
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): rectus_abdominis, transverse_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Subida e descida das pernas deitado de costas, com a lombar sempre encostada ao chão. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Deita-te de costas num tapete, com as pernas estendidas e as mãos ao lado do corpo ou debaixo da bacia.
  - Encosta a lombar ao chão ativando o abdómen antes de mexer as pernas.
  - Eleva as duas pernas juntas até perto da vertical, com os joelhos quase esticados.
  - Desce as pernas devagar, juntas, na direção do chão; para a descida no ponto em que a lombar começar a arquear.
  - Volta a subir as pernas sem impulso nem balanço; dobra os joelhos para facilitar o exercício.
  - Mantém o pescoço relaxado e os ombros no chão; 1
  - Termina a série quando a lombar deixar de conseguir ficar encostada.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E142 — Elevação de joelhos suspenso

- Chave estável: `elevacao_de_joelhos_suspenso__core`
- Grupo principal: Core
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): rectus_abdominis, transverse_abdominis
- Equipamento: Barra fixa
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Elevação dos joelhos ao peito suspenso na barra fixa, enrolando ligeiramente a bacia. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Segura uma barra fixa firme com as duas mãos à largura dos ombros e fica pendurado.
  - Ativa os ombros e o abdómen para o corpo não balançar.
  - Sobe os dois joelhos juntos na direção do peito, enrolando ligeiramente a bacia no fim.
  - Sobe até os joelhos passarem a altura da anca, ou mais alto se controlares.
  - Faz uma pausa curta no topo; desce as pernas devagar até ficarem esticadas, sem balancear.
  - Se balançares, para, estabiliza e só depois continua.
  - Termina antes de a pega falhar; desce com apoio dos pés se possível.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E143 — Dead bug

- Chave estável: `dead_bug__core`
- Grupo principal: Core
- Grupos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Músculos principais (tags): anti_extension, deep_stability, transverse_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (128 chars): Alternar braço e perna enquanto a lombar se mantém estável no chão. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (6 passos):
  - Deita-te de costas com os braços apontados ao teto e os joelhos dobrados a 90 graus no ar.
  - Encosta a lombar ao chão ativando o abdómen antes de mexer.
  - Estende devagar um braço atrás da cabeça e a perna contrária à frente, sem tocar no chão.
  - Mantém a lombar encostada durante toda a extensão.
  - Regressa ao centro com controlo e alterna os lados.
  - Usa menor amplitude se a lombar levantar.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E144 — Hollow hold

- Chave estável: `hollow_hold__core`
- Grupo principal: Core
- Grupos secundários: Antebraço, punho, dedos, trapézio, core e controlo da pega
- Músculos principais (tags): anti_extension, deep_stability, transverse_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (140 chars): Posição em concha com braços e pernas afastados para treinar tensão abdominal contínua. Serve para treinar força de pega, dedos e antebraço.
- Execução (7 passos):
  - Deita-te de costas num tapete com as pernas estendidas e os braços ao lado do corpo.
  - Encosta a lombar ao chão ativando o abdómen: esta é a regra principal do exercício.
  - Eleva os ombros e a cabeça alguns centímetros do chão; eleva as pernas esticadas a um palmo ou dois do chão.
  - Se controlares, estende os braços atrás da cabeça para dificultar; o corpo fica em forma de canoa, curvado e firme.
  - Mantém 10 a 30 segundos, respirando de forma curta e contínua, sem prender o ar.
  - Desce devagar e descansa; dobra os joelhos ou mantém os braços à frente para facilitar.
  - 1; termina no momento em que a lombar descolar do chão.
- Erros comuns: Dobrar os punhos sem controlo. | Usar peso pesado demais. | Deixar a pega abrir de repente. | Encolher os ombros. | Continuar com dor no punho.
- Versão mais fácil: Encurta a alavanca ou a duração e usa menos resistência sem perder a posição das costelas e da bacia.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Trabalha a pega com punhos direitos e termina antes de a mão abrir sozinha. Para com dor no punho ou formigueiro nos dedos.

### E145 — Mountain climbers

- Chave estável: `mountain_climbers__core`
- Grupo principal: Core
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): rectus_abdominis, transverse_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (120 chars): Levar joelhos alternados ao peito em prancha, misturando core e ritmo cardiovascular. Serve para o treinar com controlo.
- Execução (7 passos):
  - Coloca-te em prancha alta, com as mãos por baixo dos ombros e o corpo em linha reta.
  - Ativa o abdómen e mantém a anca à altura dos ombros, sem subir em pico.
  - Leva um joelho na direção do peito, mantendo o pé de trás firme.
  - Troca as pernas num pequeno salto, levando o outro joelho ao peito.
  - Continua a alternar os joelhos num ritmo que consegues controlar; mantém as mãos a empurrar o chão e os ombros por cima dos punhos.
  - Começa devagar e aumenta o ritmo só se a anca não saltar; trabalha 20 a 40 segundos por série; 1
  - Para se a lombar descair ou os ombros saírem da linha das mãos.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E146 — Pallof press no cabo

- Chave estável: `pallof_press_no_cabo__core`
- Grupo principal: Core
- Grupos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Músculos principais (tags): anti_rotation, deep_stability
- Equipamento: Cabo / polia
- Tipo (FASE 2): cabo
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (151 chars): Anti-rotação na polia à altura do peito: estendes os braços e resistes à torção do tronco. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Coloca a polia à altura do peito, segura a pega e afasta-te para o lado até haver tensão no cabo.
  - Fica de lado para o ponto de fixação, com os pés à largura dos ombros e joelhos suaves.
  - Segura a pega ou o elástico com as duas mãos junto ao peito; ativa o abdómen e mantém a bacia e os ombros virados para a frente.
  - Empurra as mãos em linha reta à frente do peito, estendendo os braços.
  - A resistência vai tentar rodar o teu tronco: resiste sem deixar rodar.
  - Mantém os braços estendidos 2 a 3 segundos e volta com as mãos ao peito devagar.
  - Completa as repetições de um lado e vira-te para trabalhar o outro; 1; reduz a tensão se a anca rodar ou os ombros subirem.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Encurta a alavanca ou a duração e usa menos resistência sem perder a posição das costelas e da bacia.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E147 — Pallof press com elástico

- Chave estável: `pallof_press_com_elastico__core`
- Grupo principal: Core
- Grupos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Músculos principais (tags): anti_rotation, deep_stability
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (149 chars): Anti-rotação com elástico preso ao lado: estendes os braços e impedes o tronco de rodar. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Prende um elástico num ponto firme à altura do peito e afasta-te para o lado até haver tensão.
  - Fica de lado para o ponto de fixação, com os pés à largura dos ombros e joelhos suaves.
  - Segura a pega ou o elástico com as duas mãos junto ao peito; ativa o abdómen e mantém a bacia e os ombros virados para a frente.
  - Empurra as mãos em linha reta à frente do peito, estendendo os braços.
  - A resistência vai tentar rodar o teu tronco: resiste sem deixar rodar.
  - Mantém os braços estendidos 2 a 3 segundos e volta com as mãos ao peito devagar.
  - Completa as repetições de um lado e vira-te para trabalhar o outro; 1; reduz a tensão se a anca rodar ou os ombros subirem.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Encurta a alavanca ou a duração e usa menos resistência sem perder a posição das costelas e da bacia.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E148 — Russian twist

- Chave estável: `russian_twist__core`
- Grupo principal: Core
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): external_obliques, internal_obliques, rectus_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (157 chars): Rotação alternada do tronco sentado, com o tronco inclinado atrás e os pés apoiados ou elevados. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Senta-te no chão com os joelhos dobrados e os pés apoiados ou ligeiramente elevados.
  - Inclina o tronco para trás até sentir o abdómen a trabalhar, mantendo as costas direitas.
  - Junta as mãos à frente do peito, com ou sem carga leve.
  - Roda o tronco para um lado, levando as mãos na direção do chão ao lado da anca.
  - Roda depois para o outro lado, voltando a passar pelo centro com controlo.
  - Mantém o peito aberto e o queixo neutro; faz as rotações devagar, sem balancear as pernas.
  - Apoia os pés no chão para facilitar; eleva-os para dificultar.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E149 — Bicycle crunch

- Chave estável: `bicycle_crunch__core`
- Grupo principal: Core
- Grupos secundários: Oblíquos, transverso abdominal, lombar e respiração
- Músculos principais (tags): external_obliques, internal_obliques, rectus_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (145 chars): Flexão com rotação alternada, levando o cotovelo ao joelho contrário como a pedalar. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Deita-te de costas com as mãos ao lado da cabeça e as pernas elevadas, joelhos dobrados.
  - Encosta a lombar ao chão e recolhe ligeiramente o queixo.
  - Sobe os ombros do chão e roda o tronco levando um cotovelo na direção do joelho contrário.
  - Ao mesmo tempo, estende a outra perna à frente, sem a deixar cair no chão.
  - Troca de lado num movimento contínuo, como a pedalar; roda a partir do tronco, sem puxar o pescoço com as mãos.
  - Faz o movimento devagar e com pausa curta em cada lado; estende menos a perna se a lombar arquear; 1
  - Termina quando o pescoço começar a fazer o trabalho do abdómen.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E150 — Bird dog

- Chave estável: `bird_dog__core`
- Grupo principal: Core
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): erectors, deep_stability
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (127 chars): Estender braço e perna opostos em quatro apoios sem rodar a bacia. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (6 passos):
  - Coloca-te em quatro apoios, com os punhos por baixo dos ombros e os joelhos por baixo da anca.
  - Ativa o abdómen e mantém o olhar no chão.
  - Estende ao mesmo tempo um braço em frente e a perna contrária atrás, até ficarem na linha do tronco.
  - Mantém a bacia nivelada, sem rodar para o lado.
  - Sustém um a dois segundos e regressa com controlo.
  - Alterna os lados sem pressa.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E151 — Side bend

- Chave estável: `side_bend__core`
- Grupo principal: Core
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): external_obliques, internal_obliques
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (150 chars): Inclinação lateral do tronco em pé, descendo a mão pela perna para trabalhar os oblíquos. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Fica de pé com os pés à largura da anca e os braços ao lado do corpo.
  - Coloca uma mão atrás da cabeça e deixa a outra esticada junto à perna.
  - Mantém o tronco direito, sem inclinar para a frente nem para trás.
  - Inclina o tronco devagar para o lado do braço esticado, deslizando a mão pela perna.
  - Desce só até sentir alongamento no lado contrário da cintura; volta a subir usando os músculos do lado contrário, até ficar direito.
  - Não rodes o tronco nem deixes a anca fugir para o lado; completa as repetições de um lado antes de trocar; 1
  - Para dificultar, segura uma garrafa de água cheia na mão do lado que desliza.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E152 — Vacuum abdominal

- Chave estável: `vacuum_abdominal__core`
- Grupo principal: Core
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): transverse_abdominis, deep_stability
- Equipamento: Peso corporal
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (137 chars): Contração respiratória profunda para puxar suavemente o abdómen para dentro. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (6 passos):
  - Fica de pé, sentado ou em quatro apoios, com a coluna neutra.
  - No fim da expiração, puxa o umbigo para dentro e para cima, como se quisesses encostá-lo à coluna.
  - Mantém essa contração 5 a 15 segundos, sem encolher os ombros.
  - Relaxa a barriga devagar.
  - Descansa uma respiração completa e repete.
  - Evita este exercício se estiveres com tensão alta não controlada ou tonturas.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E153 — Flutter kicks

- Chave estável: `flutter_kicks__core`
- Grupo principal: Core
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): rectus_abdominis, transverse_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (145 chars): Batimentos curtos e alternados das pernas deitado de costas, com a lombar encostada. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Deita-te de costas com as pernas estendidas e as mãos ao lado do corpo ou debaixo da bacia.
  - Encosta a lombar ao chão ativando o abdómen; eleva as duas pernas a um palmo ou dois do chão.
  - Bate as pernas alternadamente para cima e para baixo, em movimentos pequenos e rápidos, como a nadar.
  - Mantém os joelhos quase esticados e os tornozelos relaxados.
  - Mantém os ombros e o pescoço descontraídos no chão; trabalha 15 a 30 segundos por série.
  - Sobe as pernas um pouco mais alto se a lombar arquear; 1
  - Termina quando deixares de conseguir manter a lombar encostada.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E154 — Toe touches

- Chave estável: `toe_touches__core`
- Grupo principal: Core
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): rectus_abdominis, transverse_abdominis
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (143 chars): Subida curta dos ombros com as mãos em direção aos pés, com as pernas na vertical. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Deita-te de costas com as pernas elevadas na vertical e os joelhos quase esticados.
  - Estende os braços na direção dos pés, com as mãos apontadas ao teto.
  - Encosta a lombar ao chão e recolhe ligeiramente o queixo.
  - Sobe os ombros do chão levando as mãos na direção dos dedos dos pés.
  - O movimento é curto: sobe só até as omoplatas saírem do chão.
  - Faz uma pausa de um segundo no topo, apertando o abdómen; desce devagar até os ombros tocarem no chão.
  - Não puxes o pescoço com as mãos nem balances as pernas; 1; dobra ligeiramente os joelhos se os posteriores repuxarem.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E155 — Superman

- Chave estável: `superman__core`
- Grupo principal: Core
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): erectors
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Core"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (158 chars): Repetições de elevação de braços e pernas deitado de barriga para baixo, para a cadeia posterior. Serve para treinar core, abdominal e estabilidade do tronco.
- Execução (7 passos):
  - Deita-te de barriga para baixo num tapete, com os braços estendidos à frente e as pernas esticadas.
  - Mantém o olhar para o chão e o pescoço comprido.
  - Eleva ao mesmo tempo braços, peito e pernas alguns centímetros do chão.
  - Aperta os glúteos e a lombar no topo do movimento.
  - Faz uma pausa de um a dois segundos em cima; desce devagar até relaxar no chão.
  - Procura um movimento pequeno e controlado, não altura máxima.
  - Levanta só os braços ou só as pernas para facilitar; 1; para se sentires apertar ou dor na lombar.
- Erros comuns: Deixar a lombar arquear ou descolar do apoio. | Puxar o pescoço com as mãos. | Usar impulso em vez de controlo. | Prender a respiração. | Encurtar a amplitude útil.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E156 — Agachamento com peso corporal

- Chave estável: `agachamento_com_peso_corporal__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (149 chars): Agachamento sem equipamento, descendo a anca como se fosses sentar e voltando a subir. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Fica com pés à largura dos ombros ou ligeiramente mais abertos, conforme a variação.
  - Posiciona Peso corporal de forma segura: ao peito, aos lados, nas costas ou sem carga.
  - Mantém peito aberto, abdómen ativo e olhar em frente ou ligeiramente para baixo.
  - Inicia levando a anca para trás e dobrando joelhos ao mesmo tempo.
  - Mantém joelhos alinhados com os pés, sem caírem para dentro.
  - Desce até onde consegues manter calcanhares apoiados e coluna neutra.
  - Sobe empurrando o chão e estendendo anca e joelhos.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Descer mais do que consegues controlar. | Prender a respiração.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E157 — Agachamento para cadeira

- Chave estável: `agachamento_para_cadeira__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Peso corporal, banco / cadeira / apoio
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (159 chars): Agachamento com uma cadeira atrás como referência de profundidade, tocando levemente no assento. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Coloca uma cadeira estável atrás de ti, com o assento virado para as tuas pernas.
  - Fica de pé com os pés à largura dos ombros e os dedos ligeiramente para fora.
  - Mantém o peito aberto, o tronco direito e o abdómen ativo.
  - Desce levando a anca para trás e dobrando os joelhos, como se fosses sentar-te.
  - Toca levemente com os glúteos no assento sem descarregar todo o peso.
  - Mantém os joelhos alinhados com os pés e os calcanhares no chão; sobe empurrando o chão com os pés, sem impulso do tronco.
  - Se precisares de mais confiança, senta-te por completo e levanta-te sem usar as mãos.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Descer mais do que consegues controlar. | Prender a respiração.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E158 — Agachamento goblet

- Chave estável: `agachamento_goblet__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (161 chars): Agachamento a segurar um halter na vertical junto ao peito, o que ajuda a manter o tronco direito. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Segura um halter na vertical junto ao peito, com as duas mãos por baixo da cabeça de cima, como se fosse uma taça.
  - Fica de pé com os pés à largura dos ombros e as pontas ligeiramente para fora.
  - Mantém os cotovelos apontados para baixo e o halter sempre colado ao peito.
  - Desce dobrando joelhos e anca, como se fosses sentar.
  - Deixa os cotovelos passar por dentro dos joelhos na parte baixa.
  - Mantém o tronco direito e os calcanhares no chão; sobe empurrando o chão e estendendo anca e joelhos.
  - Escolhe uma pega firme para o halter não escorregar do peito.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Posicionar mal o peso antes de começar. | Descer mais do que consegues controlar.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E159 — Agachamento com halteres ao lado

- Chave estável: `agachamento_com_halteres_ao_lado__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (143 chars): Agachamento com um halter em cada mão ao lado do corpo, para carregar sem barra. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Fica com pés à largura dos ombros ou ligeiramente mais abertos, conforme a variação.
  - Posiciona Halteres de forma segura: ao peito, aos lados, nas costas ou sem carga.
  - Mantém peito aberto, abdómen ativo e olhar em frente ou ligeiramente para baixo.
  - Inicia levando a anca para trás e dobrando joelhos ao mesmo tempo.
  - Mantém joelhos alinhados com os pés, sem caírem para dentro.
  - Desce até onde consegues manter calcanhares apoiados e coluna neutra.
  - Sobe empurrando o chão e estendendo anca e joelhos.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Posicionar mal o peso antes de começar. | Descer mais do que consegues controlar.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E160 — Agachamento com barra

- Chave estável: `agachamento_com_barra__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (156 chars): Agachamento com barra apoiada na parte alta das costas, para treinar as pernas com mais peso. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Fica com pés à largura dos ombros ou ligeiramente mais abertos, conforme a variação.
  - Apoia a barra na parte de cima das costas e segura-a com pega firme e simétrica.
  - Posiciona Barra de forma segura: ao peito, aos lados, nas costas ou sem carga.
  - Mantém peito aberto, abdómen ativo e olhar em frente ou ligeiramente para baixo.
  - Inicia levando a anca para trás e dobrando joelhos ao mesmo tempo.
  - Mantém joelhos alinhados com os pés, sem caírem para dentro.
  - Desce até onde consegues manter calcanhares apoiados e coluna neutra; sobe empurrando o chão e estendendo anca e joelhos.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Posicionar mal o peso antes de começar. | Descer mais do que consegues controlar.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E161 — Agachamento com mochila

- Chave estável: `agachamento_com_mochila__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Mochila com peso
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (134 chars): Agachamento caseiro com uma mochila carregada e bem ajustada às costas. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Fica com pés à largura dos ombros ou ligeiramente mais abertos, conforme a variação.
  - Posiciona Mochila com peso de forma segura: ao peito, aos lados, nas costas ou sem carga.
  - Mantém peito aberto, abdómen ativo e olhar em frente ou ligeiramente para baixo.
  - Inicia levando a anca para trás e dobrando joelhos ao mesmo tempo.
  - Mantém joelhos alinhados com os pés, sem caírem para dentro.
  - Desce até onde consegues manter calcanhares apoiados e coluna neutra.
  - Sobe empurrando o chão e estendendo anca e joelhos.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Posicionar mal o peso antes de começar. | Descer mais do que consegues controlar.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E162 — Agachamento com garrafão

- Chave estável: `agachamento_com_garrafao__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Garrafão de água
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (150 chars): Agachamento caseiro segurando um garrafão de água junto ao peito, como um goblet squat. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Fica com pés à largura dos ombros ou ligeiramente mais abertos, conforme a variação.
  - Posiciona Garrafão de água de forma segura: ao peito, aos lados, nas costas ou sem carga.
  - Mantém peito aberto, abdómen ativo e olhar em frente ou ligeiramente para baixo.
  - Inicia levando a anca para trás e dobrando joelhos ao mesmo tempo.
  - Mantém joelhos alinhados com os pés, sem caírem para dentro.
  - Desce até onde consegues manter calcanhares apoiados e coluna neutra.
  - Sobe empurrando o chão e estendendo anca e joelhos.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Posicionar mal o peso antes de começar. | Descer mais do que consegues controlar.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E163 — Agachamento sumo

- Chave estável: `agachamento_sumo__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, adductors
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (199 chars): Agachamento com os pés bem mais afastados que os ombros e as pontas dos pés viradas para fora, dando mais trabalho a adutores e glúteos. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Fica de pé com os pés bem mais afastados que a largura dos ombros.
  - Aponta as pontas dos pés para fora, num ângulo confortável de 30 a 45 graus.
  - Mantém o tronco direito, o peito aberto e o abdómen ligeiramente ativo.
  - Desce dobrando os joelhos e levando a anca para baixo e para trás.
  - Empurra os joelhos para fora, na direção das pontas dos pés, durante toda a descida.
  - Desce até onde consegues manter os calcanhares no chão e as costas direitas.
  - Sente a parte interna das coxas e os glúteos a alongar na descida; sobe empurrando o chão com os pés inteiros e apertando os glúteos.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Descer mais do que consegues controlar. | Prender a respiração.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E164 — Agachamento na máquina Smith

- Chave estável: `agachamento_na_maquina_smith__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (149 chars): Agachamento na barra guiada da máquina Smith, que fixa a trajetória vertical da carga. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Ajusta a barra da máquina Smith à altura dos ombros e coloca as travas de segurança um pouco abaixo da posição final da descida.
  - Entra por baixo da barra e apoia-a na parte de cima das costas, nunca no pescoço.
  - Segura a barra com pega simétrica e roda-a para destravar.
  - Coloca os pés à largura dos ombros, ligeiramente à frente da linha da barra.
  - Mantém o tronco firme e o abdómen ativo, deixando a máquina guiar a trajetória vertical.
  - Desce dobrando joelhos e anca até onde manténs os calcanhares apoiados e a lombar neutra.
  - Sobe empurrando o chão com os pés inteiros; no fim, roda a barra para a travar de novo no suporte antes de sair.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Posicionar mal o peso antes de começar. | Descer mais do que consegues controlar.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E165 — Agachamento búlgaro

- Chave estável: `agachamento_bulgaro__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Equipamento: Banco / cadeira / apoio
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (169 chars): Agachamento unilateral com o pé de trás apoiado num banco, exigindo equilíbrio e força da perna da frente. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Coloca um banco ou cadeira estável atrás de ti e fica de costas para ele, a cerca de um passo grande de distância.
  - Apoia o peito do pé de trás em cima do banco, com o pé da frente inteiro no chão.
  - Cruza os braços à frente do peito ou deixa-os ao lado do corpo para equilibrar.
  - Mantém o tronco direito, o abdómen ativo e a anca virada para a frente.
  - Desce dobrando o joelho da perna da frente, como um agachamento só com essa perna.
  - Mantém o joelho da frente alinhado com o pé, sem cair para dentro; desce até onde controlas o equilíbrio, sem bater com o joelho de trás no chão.
  - Empurra o chão com o pé da frente para subir; 1; completa as repetições de um lado antes de trocar de perna.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Descer mais do que consegues controlar. | Prender a respiração.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E166 — Agachamento búlgaro com apoio

- Chave estável: `agachamento_bulgaro_com_apoio__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Equipamento: Banco / cadeira / apoio
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (154 chars): Agachamento búlgaro com uma mão apoiada na parede para ganhar equilíbrio enquanto aprendes. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Coloca um banco ou cadeira estável atrás de ti e fica de costas para ele, a cerca de um passo grande de distância.
  - Apoia o peito do pé de trás em cima do banco, com o pé da frente inteiro no chão.
  - Fica ao lado de uma parede ou apoio estável e pousa lá uma mão para equilibrar.
  - Mantém o tronco direito, o abdómen ativo e a anca virada para a frente.
  - Desce dobrando o joelho da perna da frente, como um agachamento só com essa perna.
  - Mantém o joelho da frente alinhado com o pé, sem cair para dentro; desce até onde controlas o equilíbrio, sem bater com o joelho de trás no chão.
  - Empurra o chão com o pé da frente para subir; 1; completa as repetições de um lado antes de trocar de perna.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Descer mais do que consegues controlar. | Prender a respiração.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E167 — Extensão de perna

- Chave estável: `extensao_de_perna__pernas`
- Grupo principal: Pernas
- Grupos secundários: Estabilizadores do joelho e controlo da anca
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (132 chars): Extensão dos joelhos sentado na máquina, empurrando o rolo com a frente das pernas até quase esticar. Serve para treinar quadríceps.
- Execução (7 passos):
  - Senta-te na máquina de extensão de perna e encosta bem as costas no apoio.
  - Ajusta o encosto para os joelhos ficarem alinhados com o eixo de rotação da máquina.
  - Coloca o rolo acolchoado sobre a parte da frente dos tornozelos; segura as pegas laterais para estabilizar o tronco.
  - Estende os joelhos devagar, levantando o rolo até as pernas ficarem quase direitas.
  - Faz uma pausa curta no topo, contraindo a frente das coxas.
  - Desce o rolo em dois a três segundos, sem deixar as placas bater.
  - Não arranques com impulso da anca nem levantes os glúteos do assento.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Posicionar mal o peso antes de começar. | Descer mais do que consegues controlar.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E168 — Leg press

- Chave estável: `leg_press__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores e gémeos
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (168 chars): Empurrar a plataforma da máquina com os pés, dobrando e estendendo joelhos e anca com as costas apoiadas. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Senta-te na máquina de leg press com as costas e a cabeça bem apoiadas no encosto.
  - Coloca os pés na plataforma à largura dos ombros, com os pés inteiros apoiados.
  - Ajusta o assento para os joelhos começarem dobrados perto de 90 graus; segura as pegas laterais para manter o tronco estável.
  - Empurra a plataforma estendendo joelhos e anca, sem bloquear os joelhos com força no fim.
  - Solta as travas de segurança apenas quando já estiveres a suster a carga.
  - Desce a plataforma devagar, dobrando os joelhos na direção do peito até onde a lombar se mantém apoiada.
  - Não deixes a anca ou a lombar descolar do assento na parte baixa; 1; no fim, trava a plataforma antes de tirar os pés.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Posicionar mal o peso antes de começar. | Descer mais do que consegues controlar.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E169 — Step-up

- Chave estável: `step_up__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Equipamento: Banco / cadeira / apoio
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Subida controlada para um apoio elevado, usando uma perna de cada vez. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Coloca-te de frente para um degrau, caixa ou banco estável, à altura do joelho ou abaixo.
  - Apoia o pé inteiro de uma perna em cima do apoio; mantém o tronco direito e o abdómen ativo.
  - Empurra o apoio com o pé de cima e sobe até estender a perna, sem dar impulso com a perna de baixo.
  - Mantém o joelho da perna que trabalha alinhado com o pé; toca com o pé livre em cima ou mantém-no no ar por um instante.
  - Desce devagar pelo mesmo caminho, controlando a perna de apoio.
  - Completa as repetições de uma perna antes de trocar, ou alterna com controlo.
  - 1; usa a anca e o glúteo para travar a descida, sem deixar o corpo cair.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Descer mais do que consegues controlar. | Prender a respiração.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E170 — Wall sit

- Chave estável: `wall_sit__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max
- Equipamento: Peso corporal
- Tipo (FASE 2): isometria
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (151 chars): Agachamento isométrico encostado à parede, mantendo joelhos fletidos sem subir e descer. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Encosta as costas inteiras a uma parede lisa e dá um ou dois passos com os pés para a frente.
  - Desliza o tronco pela parede até os joelhos ficarem dobrados perto de 90 graus.
  - Mantém os pés à largura da anca, apontados para a frente, e os joelhos alinhados com os pés.
  - Mantém a lombar e as omoplatas em contacto com a parede; apoia as mãos nas coxas ou deixa os braços ao lado, sem empurrar os joelhos.
  - Aguenta a posição parado, sem subir nem descer, durante 15 a 45 segundos.
  - Para subir, empurra o chão com os pés e desliza o tronco pela parede para cima.
  - Termina se os joelhos começarem a tremer para dentro ou se perderes o apoio das costas.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Descer mais do que consegues controlar. | Prender a respiração.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E171 — Lunges

- Chave estável: `lunges__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (153 chars): Afundo no lugar: um passo à frente, descida dos dois joelhos e regresso à posição inicial. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Fica de pé com tronco alto e Peso corporal controlado.
  - Dá um passo à frente, atrás ou em movimento, conforme a variação.
  - Desce dobrando os dois joelhos, mantendo o joelho da frente alinhado com o pé.
  - Mantém a anca estável e o tronco sem cair para a frente.
  - Desce até amplitude confortável, sem bater o joelho de trás no chão.
  - Empurra o chão com o pé da frente para voltar ou avançar.
  - Reduz a passada se perderes equilíbrio ou sentires dor no joelho.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Descer mais do que consegues controlar. | Prender a respiração.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E172 — Lunges com halteres

- Chave estável: `lunges_com_halteres__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (140 chars): Afundo com um halter em cada mão ao lado do corpo, mantendo o tronco direito. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Fica de pé com tronco alto e Halteres controlado.
  - Segura um halter em cada mão ao lado do corpo, com pega firme e punhos direitos.
  - Dá um passo à frente, atrás ou em movimento, conforme a variação.
  - Desce dobrando os dois joelhos, mantendo o joelho da frente alinhado com o pé.
  - Mantém a anca estável e o tronco sem cair para a frente.
  - Desce até amplitude confortável, sem bater o joelho de trás no chão.
  - Empurra o chão com o pé da frente para voltar ou avançar; reduz a passada se perderes equilíbrio ou sentires dor no joelho.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Posicionar mal o peso antes de começar. | Descer mais do que consegues controlar.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E173 — Lunges com mochila

- Chave estável: `lunges_com_mochila__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Equipamento: Mochila com peso
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (144 chars): Afundo caseiro com mochila carregada às costas, sem deixar o peso puxar o tronco. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Fica de pé com tronco alto e Mochila com peso controlado.
  - Dá um passo à frente, atrás ou em movimento, conforme a variação.
  - Desce dobrando os dois joelhos, mantendo o joelho da frente alinhado com o pé.
  - Mantém a anca estável e o tronco sem cair para a frente.
  - Desce até amplitude confortável, sem bater o joelho de trás no chão.
  - Empurra o chão com o pé da frente para voltar ou avançar.
  - Reduz a passada se perderes equilíbrio ou sentires dor no joelho.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Posicionar mal o peso antes de começar. | Descer mais do que consegues controlar.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E174 — Walking lunges

- Chave estável: `walking_lunges__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, adutores, gémeos e core
- Músculos principais (tags): rectus_femoris, vastus_lateralis, vastus_medialis, vastus_intermedius, glute_max, glute_med
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Afundos em deslocamento, avançando um passo a cada repetição e alternando as pernas. Serve para treinar quadríceps, glúteos e estabilidade da anca.
- Execução (7 passos):
  - Fica de pé com tronco alto e Peso corporal controlado.
  - Em vez de voltares atrás, traz a perna de trás para a frente e avança para o passo seguinte.
  - Dá um passo à frente, atrás ou em movimento, conforme a variação.
  - Desce dobrando os dois joelhos, mantendo o joelho da frente alinhado com o pé.
  - Mantém a anca estável e o tronco sem cair para a frente.
  - Desce até amplitude confortável, sem bater o joelho de trás no chão.
  - Empurra o chão com o pé da frente para voltar ou avançar; reduz a passada se perderes equilíbrio ou sentires dor no joelho.
- Erros comuns: Deixar os joelhos cair para dentro. | Levantar os calcanhares do chão. | Deixar o tronco colapsar à frente. | Descer mais do que consegues controlar. | Prender a respiração.
- Versão mais fácil: Faz sem peso adicional, com menor amplitude e apoio numa parede ou cadeira estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém joelhos alinhados com os pés e coluna controlada. Para com dor aguda no joelho, anca, tornozelo ou lombar.

### E175 — Peso morto tradicional

- Chave estável: `peso_morto_tradicional__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Músculos principais (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (152 chars): Levantamento do chão com flexão de anca e joelhos, mantendo a carga perto das pernas. Serve para treinar posterior de coxa, glúteos e lombar controlada.
- Execução (7 passos):
  - Coloca a barra no chão sobre o meio dos pés, com os pés à largura da anca.
  - Dobra a anca e os joelhos para descer e agarra a barra com pega simétrica, um pouco mais aberta que as pernas.
  - Baixa a anca até as canelas quase tocarem na barra, com o peito aberto e a coluna neutra.
  - Aperta a barra, ativa o abdómen e tira a folga dos braços antes de puxar; empurra o chão com os pés e sobe, mantendo a barra colada às pernas.
  - Estende joelhos e anca ao mesmo tempo até ficares de pé, sem inclinar para trás.
  - Desce pelo mesmo caminho, levando a anca para trás e dobrando os joelhos, com a lombar neutra.
  - Pousa a barra com controlo no chão entre repetições; 1; usa carga leve até dominares a posição inicial e a descida.
- Erros comuns: Arredondar a lombar. | Afastar o peso do corpo. | Dobrar demasiado os joelhos. | Não levar a anca para trás. | Subir puxando só pelas costas.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém a coluna neutra e o peso perto do corpo. Para com dor lombar aguda, formigueiro, perda de força ou incapacidade de controlar a anca.

### E176 — Peso morto romeno com halteres

- Chave estável: `peso_morto_romeno_com_halteres__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Músculos principais (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Equipamento: Halteres
- Tipo (FASE 2): halteres
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (86 chars): Dobradiça de anca com joelhos pouco fletidos para alongar posterior de coxa e glúteos.
- Execução (7 passos):
  - Fica com os pés firmes à largura da anca e, se o exercício usar peso, mantém-no colado ao corpo.
  - Segura os halteres à frente das coxas com pega firme, palmas viradas para ti.
  - Mantém peito aberto, coluna neutra e joelhos ligeiramente fletidos.
  - Começa levando a anca para trás, como se fosses fechar uma porta com os glúteos.
  - Deixa as mãos, ou o peso, descerem junto às pernas, sem afastar do corpo.
  - Para quando sentires alongamento no posterior de coxa sem arredondar a lombar.
  - Regressa apertando glúteos e estendendo a anca até ficar alto novamente; pára se a lombar perder posição, se houver dor aguda ou formigueiro.
- Erros comuns: Arredondar a lombar. | Afastar o peso do corpo. | Dobrar demasiado os joelhos. | Não levar a anca para trás. | Subir puxando só pelas costas.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém a coluna neutra e o peso perto do corpo. Para com dor lombar aguda, formigueiro, perda de força ou incapacidade de controlar a anca.

### E177 — Curl de perna

- Chave estável: `curl_de_perna__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, gémeos e estabilizadores do joelho
- Músculos principais (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Equipamento: Máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (112 chars): Flexão dos joelhos na máquina, puxando os calcanhares na direção dos glúteos para trabalhar o posterior de coxa.
- Execução (7 passos):
  - Ajusta a máquina de curl de perna para os joelhos ficarem alinhados com o eixo de rotação.
  - Deita-te ou senta-te conforme a máquina, com o rolo acolchoado atrás dos tornozelos.
  - Segura as pegas e mantém a anca colada ao apoio; dobra os joelhos puxando os calcanhares na direção dos glúteos.
  - Faz uma pausa curta no ponto de maior flexão, sentindo a parte de trás das coxas.
  - Regressa em dois a três segundos até as pernas ficarem quase estendidas.
  - Não deixes a anca levantar nem a lombar arquear para completar a repetição.
  - Reduz a carga se precisares de impulso ou se a bacia saltar do apoio.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E178 — Good morning leve

- Chave estável: `good_morning_leve__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Músculos principais (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Equipamento: Barra
- Tipo (FASE 2): barra
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (168 chars): Dobradiça de anca com barra vazia ou muito leve, para aprender a inclinar o tronco com coluna neutra. Serve para treinar posterior de coxa, glúteos e lombar controlada.
- Execução (7 passos):
  - Fica com os pés firmes à largura da anca e, se o exercício usar peso, mantém-no colado ao corpo.
  - Usa a barra vazia ou muito leve, apoiada na parte alta das costas, nunca no pescoço.
  - Mantém peito aberto, coluna neutra e joelhos ligeiramente fletidos.
  - Começa levando a anca para trás, como se fosses fechar uma porta com os glúteos.
  - Deixa as mãos, ou o peso, descerem junto às pernas, sem afastar do corpo.
  - Para quando sentires alongamento no posterior de coxa sem arredondar a lombar.
  - Regressa apertando glúteos e estendendo a anca até ficar alto novamente; pára se a lombar perder posição, se houver dor aguda ou formigueiro.
- Erros comuns: Arredondar a lombar. | Afastar o peso do corpo. | Dobrar demasiado os joelhos. | Não levar a anca para trás. | Subir puxando só pelas costas.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Mantém a coluna neutra e o peso perto do corpo. Para com dor lombar aguda, formigueiro, perda de força ou incapacidade de controlar a anca.

### E179 — Good morning sem carga

- Chave estável: `good_morning_sem_carga__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteos, posterior de coxa, lombar, dorsais e pega
- Músculos principais (tags): biceps_femoris, semitendinosus, semimembranosus, glute_max
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (205 chars): Inclinação do tronco pela anca, sem qualquer peso, para aprender a dobrar com a coluna neutra. Serve para treinar posterior de coxa, glúteos e lombar controlada. Nesta lista, conta para o treino de pernas.
- Execução (7 passos):
  - Fica com os pés firmes à largura da anca e, se o exercício usar peso, mantém-no colado ao corpo.
  - Mantém peito aberto, coluna neutra e joelhos ligeiramente fletidos.
  - Começa levando a anca para trás, como se fosses fechar uma porta com os glúteos.
  - Deixa as mãos, ou o peso, descerem junto às pernas, sem afastar do corpo.
  - Para quando sentires alongamento no posterior de coxa sem arredondar a lombar.
  - Regressa apertando glúteos e estendendo a anca até ficar alto novamente.
  - Pára se a lombar perder posição, se houver dor aguda ou formigueiro.
- Erros comuns: Arredondar a lombar. | Dobrar demasiado os joelhos. | Não levar a anca para trás. | Subir puxando só pelas costas.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Mantém a coluna neutra durante a dobradiça da anca. Para com dor lombar aguda, formigueiro ou perda de força.

### E180 — Ponte de glúteo

- Chave estável: `ponte_de_gluteo__pernas`
- Grupo principal: Pernas
- Grupos secundários: Posterior de coxa, lombar leve, core e adutores
- Músculos principais (tags): glute_max, glute_med, biceps_femoris
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (182 chars): Exercício de Pernas com movimento específico de Ponte de glúteo, feito para controlar a área trabalhada sem dor. Serve para treinar glúteos, com apoio do posterior de coxa e do core.
- Execução (7 passos):
  - Deita-te de costas no chão ou tapete, com os joelhos dobrados e os pés apoiados à largura da anca.
  - Deixa os calcanhares a um palmo dos glúteos e os braços ao lado do corpo.
  - Ativa o abdómen para a lombar ficar neutra.
  - Empurra o chão com os calcanhares e eleva a anca até formar uma linha dos ombros aos joelhos.
  - Aperta os glúteos no topo durante um a dois segundos, sem arquear a lombar.
  - Desce a anca devagar sem tocar com força no chão; mantém os joelhos alinhados com os pés durante todo o movimento.
  - Para tornar mais difícil, faz uma pausa mais longa no topo.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E181 — Hip thrust

- Chave estável: `hip_thrust__pernas`
- Grupo principal: Pernas
- Grupos secundários: Posterior de coxa, lombar leve, core e adutores
- Músculos principais (tags): glute_max, glute_med, biceps_femoris
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (177 chars): Exercício de Pernas com movimento específico de Hip thrust, feito para controlar a área trabalhada sem dor. Serve para treinar glúteos, com apoio do posterior de coxa e do core.
- Execução (7 passos):
  - Senta-te no chão com a parte de cima das costas encostada a um banco estável.
  - Apoia a zona abaixo das omoplatas na borda e dobra os joelhos com os pés à largura da anca.
  - Se usares peso extra, apoia-o sobre a anca; sem peso, mantém as mãos na borda do apoio.
  - Recolhe ligeiramente o queixo e ativa o abdómen.
  - Empurra o chão com os calcanhares e eleva a anca até o tronco e as coxas ficarem alinhados.
  - Aperta os glúteos no topo sem arquear a lombar nem empurrar com a cabeça; desce a anca devagar até quase tocar no chão.
  - Mantém os joelhos alinhados com os pés e o apoio firme para não deslizar.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E182 — Hip thrust com apoio

- Chave estável: `hip_thrust_com_apoio__pernas`
- Grupo principal: Pernas
- Grupos secundários: Posterior de coxa, lombar leve, core e adutores
- Músculos principais (tags): glute_max, glute_med, biceps_femoris
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (187 chars): Exercício de Pernas com movimento específico de Hip thrust com apoio, feito para controlar a área trabalhada sem dor. Serve para treinar glúteos, com apoio do posterior de coxa e do core.
- Execução (7 passos):
  - Senta-te no chão com a parte de cima das costas encostada a um banco, sofá ou apoio estável da altura dos joelhos.
  - Apoia a zona abaixo das omoplatas na borda e dobra os joelhos com os pés à largura da anca.
  - Se usares peso extra, apoia-o sobre a anca; sem peso, mantém as mãos na borda do apoio.
  - Recolhe ligeiramente o queixo e ativa o abdómen.
  - Empurra o chão com os calcanhares e eleva a anca até o tronco e as coxas ficarem alinhados.
  - Aperta os glúteos no topo sem arquear a lombar nem empurrar com a cabeça; desce a anca devagar até quase tocar no chão.
  - Mantém os joelhos alinhados com os pés e o apoio firme para não deslizar.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E183 — Abdução de anca

- Chave estável: `abducao_de_anca__pernas`
- Grupo principal: Pernas
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): abductors, glute_med, glute_min
- Equipamento: Máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (130 chars): Afastar as pernas contra a resistência da máquina, usando a parte lateral da anca e os glúteos. Serve para o treinar com controlo.
- Execução (7 passos):
  - Senta-te na máquina abdutora com as costas apoiadas no encosto.
  - Coloca as pernas por dentro dos apoios acolchoados, com os pés nos descansos.
  - Começa com as pernas juntas e segura as pegas laterais.
  - Afasta as pernas empurrando os apoios para fora com a parte lateral da anca e os glúteos.
  - Abre até uma amplitude confortável, sem inclinar o tronco para trás.
  - Faz uma pausa curta na posição aberta; deixa as pernas voltar devagar ao centro, sem as placas baterem.
  - Mantém a bacia quieta no assento durante toda a série.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E184 — Adução de anca

- Chave estável: `aducao_de_anca__pernas`
- Grupo principal: Pernas
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): adductors
- Equipamento: Máquina
- Tipo (FASE 2): maquina
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (126 chars): Aproximar as pernas contra a resistência da máquina, apertando a parte interna das coxas. Serve para treinar adutores da coxa.
- Execução (7 passos):
  - Senta-te na máquina adutora com as costas apoiadas no encosto.
  - Coloca as pernas por fora dos apoios acolchoados, com os pés nos descansos.
  - Ajusta a abertura inicial para sentir alongamento leve na parte interna das coxas, sem dor.
  - Segura as pegas laterais e mantém o tronco quieto.
  - Aproxima as pernas uma da outra apertando a parte interna das coxas; faz uma pausa curta com as pernas juntas.
  - Deixa as pernas abrir devagar, em dois a três segundos, sem soltar o controlo.
  - Reduz a abertura ou a carga se sentires repuxar na virilha.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E185 — Kickback de glúteo

- Chave estável: `kickback_de_gluteo__pernas`
- Grupo principal: Pernas
- Grupos secundários: Posterior de coxa, lombar leve, core e adutores
- Músculos principais (tags): glute_max, glute_med, biceps_femoris
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (172 chars): Extensão da anca em quatro apoios, empurrando o calcanhar para trás e para cima até o glúteo contrair. Serve para treinar glúteos, com apoio do posterior de coxa e do core.
- Execução (7 passos):
  - Apoia mãos e joelhos no chão ou tapete, com os punhos por baixo dos ombros e os joelhos por baixo da anca.
  - Ativa o abdómen e mantém a lombar neutra e o olhar no chão.
  - Leva uma perna para trás e para cima, empurrando com o calcanhar, com o joelho dobrado a 90 graus.
  - Sobe apenas até a coxa ficar alinhada com o tronco, sem rodar a bacia nem arquear a lombar.
  - Aperta o glúteo no topo durante um segundo; recolhe o joelho devagar pelo mesmo caminho, sem tocar com impacto no chão.
  - Completa as repetições de um lado antes de trocar.
  - Usa amplitude menor se sentires a lombar a trabalhar em vez do glúteo.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E186 — Gémeos em pé

- Chave estável: `gemeos_em_pe__pernas`
- Grupo principal: Pernas
- Grupos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Músculos principais (tags): calves, ankle
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (81 chars): Elevação dos calcanhares em pé, subindo à ponta dos pés para trabalhar os gémeos.
- Execução (7 passos):
  - Fica de pé com a parte da frente dos pés num degrau estável ou no chão, com os calcanhares livres.
  - Apoia uma mão numa parede ou corrimão apenas para equilíbrio.
  - Mantém os joelhos esticados sem bloquear com força e o tronco direito.
  - Sobe os calcanhares o mais alto que conseguires, ficando na ponta dos pés.
  - Faz uma pausa de um segundo no topo, sentindo a barriga das pernas.
  - Desce os calcanhares devagar, em dois a três segundos, até sentir alongamento leve.
  - Não deixes os tornozelos cair para dentro nem para fora; sobe sempre pela mesma linha, empurrando com o dedo grande do pé.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E187 — Gémeos sentado

- Chave estável: `gemeos_sentado__pernas`
- Grupo principal: Pernas
- Grupos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Músculos principais (tags): calves, soleus, ankle
- Equipamento: Banco / cadeira / apoio
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (129 chars): Elevação dos calcanhares sentado, com os joelhos dobrados para pedir mais ao sóleo. Serve para treinar gémeos, sóleo e tornozelo.
- Execução (7 passos):
  - Senta-te num banco ou cadeira estável com os pés apoiados no chão ou num degrau baixo.
  - Para mais dificuldade, pousa um objeto pesado e estável sobre as coxas, perto dos joelhos.
  - Mantém os joelhos dobrados a 90 graus e o tronco direito.
  - Sobe os calcanhares empurrando com a ponta dos pés, usando a parte inferior das pernas.
  - Faz uma pausa curta no topo; desce os calcanhares devagar até um alongamento confortável.
  - Com o joelho dobrado, o esforço concentra-se mais no sóleo, o músculo profundo do gémeo.
  - Se usares um objeto sobre as coxas, segura-o com as mãos para não deslizar.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E188 — Elevação de gémeos unilateral

- Chave estável: `elevacao_de_gemeos_unilateral__pernas`
- Grupo principal: Pernas
- Grupos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Músculos principais (tags): calves, ankle
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (139 chars): Elevação do calcanhar numa perna de cada vez, para corrigir diferenças de força e equilíbrio. Serve para treinar gémeos, sóleo e tornozelo.
- Execução (7 passos):
  - Fica de pé sobre uma perna, com a outra dobrada atrás ou apoiada levemente.
  - Apoia uma mão numa parede ou apoio estável para equilibrar.
  - Mantém o joelho da perna de apoio esticado sem bloquear e o tronco direito.
  - Sobe o calcanhar dessa perna o mais alto possível, ficando na ponta do pé.
  - Faz uma pausa de um segundo no topo; desce devagar, em dois a três segundos, até alongamento leve.
  - Completa as repetições de uma perna antes de trocar.
  - Reduz a amplitude se o tornozelo balançar para os lados.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Aumenta gradualmente o peso ou a pausa sem permitir rotação ou inclinação do tronco.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E189 — Sóleo sentado

- Chave estável: `soleo_sentado__pernas`
- Grupo principal: Pernas
- Grupos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Músculos principais (tags): soleus, calves, ankle
- Equipamento: Banco / cadeira / apoio
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (115 chars): Elevação do calcanhar com joelho fletido para dar mais foco ao sóleo. Serve para treinar gémeos, sóleo e tornozelo.
- Execução (7 passos):
  - Senta-te num banco ou cadeira com os joelhos dobrados a 90 graus e os pés no chão.
  - Para mais resistência, pousa um objeto leve sobre as coxas, segurando-o com as mãos.
  - Mantém o tronco direito e os pés à largura da anca; sobe os calcanhares devagar, empurrando com a ponta dos pés.
  - Faz uma pausa curta no topo, sentindo a parte profunda da barriga da perna.
  - Desce os calcanhares em dois a três segundos até tocar no chão.
  - O joelho dobrado tira trabalho ao gémeo grande e concentra-o no sóleo.
  - Aumenta a resistência apenas quando controlares a subida e a descida.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E190 — Saltos leves

- Chave estável: `saltos_leves__pernas`
- Grupo principal: Pernas
- Grupos secundários: Estabilizadores locais, core e articulações próximas ao movimento
- Músculos principais (tags): calves, soleus, ankle, ankle_stability
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (109 chars): Exercício de Pernas com movimento específico de Saltos leves, feito para controlar a área trabalhada sem dor.
- Execução (7 passos):
  - Fica de pé com os pés à largura da anca e os joelhos ligeiramente dobrados.
  - Mantém o tronco direito e os braços soltos ao lado do corpo.
  - Salta baixo, apenas alguns centímetros do chão, usando os tornozelos como mola.
  - Aterra na parte da frente dos pés e deixa os calcanhares tocar levemente no chão.
  - Aterra em silêncio, com os joelhos suaves, sem os deixar cair para dentro.
  - Mantém um ritmo constante e confortável, como saltitar no lugar; faz blocos curtos de 15 a 30 segundos com pausas.
  - Para se sentires dor no tendão de Aquiles, tornozelos ou canelas.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E191 — Elevação tibial

- Chave estável: `elevacao_tibial__pernas`
- Grupo principal: Pernas
- Grupos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Músculos principais (tags): tibialis_anterior, ankle, feet
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (100 chars): Elevação da ponta do pé para treinar a parte da frente da perna. Serve para treinar tibial anterior.
- Execução (7 passos):
  - Encosta as costas a uma parede e afasta os pés meio passo para a frente.
  - Mantém os calcanhares no chão e o corpo ligeiramente inclinado na parede.
  - Levanta as pontas dos dois pés na direção das canelas, o mais alto que conseguires.
  - Sente a parte da frente das canelas a trabalhar; faz uma pausa curta no topo.
  - Desce as pontas dos pés devagar, sem bater no chão.
  - Mantém os joelhos esticados sem bloquear.
  - Afasta mais os pés da parede para aumentar a dificuldade.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E192 — Short foot / doming

- Chave estável: `short_foot_doming__pernas`
- Grupo principal: Pernas
- Grupos secundários: Arco plantar, dedos, tornozelo, tibial posterior e equilíbrio
- Músculos principais (tags): feet, ankle
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (162 chars): Contração curta dos músculos intrínsecos do pé que aproxima suavemente a base do dedo grande do calcanhar sem enrolar os dedos. Serve para o treinar com controlo.
- Execução (7 passos):
  - Senta-te ou fica de pé descalço, com calcanhar, base do dedo grande e base do dedo pequeno no chão.
  - Mantém os dedos compridos e relaxados, sem os enrolar.
  - Aproxima suavemente a base do dedo grande do calcanhar para elevar um pouco o arco plantar.
  - Mantém os três pontos do pé no chão e o joelho alinhado com o segundo dedo.
  - Sustém a contração durante 5 a 10 segundos sem prender a respiração.
  - Relaxa devagar até o arco voltar à posição inicial.
  - Reduz a força se os dedos enrolarem, o pé rodar para fora ou surgir cãibra.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E193 — Flexão ativa dos dedos do pé

- Chave estável: `flexao_ativa_dos_dedos_do_pe__pernas`
- Grupo principal: Pernas
- Grupos secundários: Arco plantar, dedos, tornozelo, tibial posterior e equilíbrio
- Músculos principais (tags): feet, ankle
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (196 chars): Flexão e abertura deliberada dos dedos do pé, mantendo o calcanhar e a base do dedo grande em contacto com o chão. Serve para treinar músculos intrínsecos do pé, arco plantar e controlo dos dedos.
- Execução (7 passos):
  - Senta-te descalço com o pé inteiro apoiado no chão e o tornozelo por baixo do joelho.
  - Abre e alonga os dedos sem levantar o calcanhar.
  - Pressiona as pontas dos dedos contra o chão sem os dobrar até criar dor.
  - Flete os dedos suavemente enquanto o arco e o calcanhar permanecem estáveis.
  - Pausa dois segundos e confirma que o joelho não rodou.
  - Estende e afasta novamente os dedos com controlo.
  - Pára se aparecer cãibra persistente, dor nos dedos ou compensação do tornozelo.
- Erros comuns: Abrir demasiado os cotovelos. | Deixar a anca cair ou subir em pico. | Dobrar os punhos. | Descer o corpo sem controlo. | Encurtar a amplitude.
- Versão mais fácil: Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Protege ombros e punhos usando uma amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do movimento.

### E194 — Dorsiflexão do tornozelo com elástico

- Chave estável: `dorsiflexao_do_tornozelo_com_elastico__pernas`
- Grupo principal: Pernas
- Grupos secundários: Tornozelo, músculos do pé, perónio/fibulares, tibial posterior e equilíbrio
- Músculos principais (tags): tibialis_anterior, ankle, feet
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (166 chars): Elevação da ponta do pé contra elástico, aproximando os dedos da canela sem rodar o joelho ou a anca. Serve para treinar tibial anterior e dorsiflexores do tornozelo.
- Execução (7 passos):
  - Senta-te com a perna apoiada e prende o elástico num ponto baixo à frente do pé.
  - Coloca o elástico sobre o peito do pé, deixando os dedos livres e o calcanhar no chão.
  - Alinha joelho, tornozelo e segundo dedo sem rodar a anca.
  - Puxa a ponta do pé para a canela sem levantar o calcanhar.
  - Pausa um segundo quando sentires a frente da canela a trabalhar.
  - Deixa o pé descer em dois a três segundos sem o elástico puxar de repente.
  - Usa menos tensão se os dedos apertarem, o joelho mexer ou o tornozelo inclinar.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E195 — Inversão do tornozelo com elástico

- Chave estável: `inversao_do_tornozelo_com_elastico__pernas`
- Grupo principal: Pernas
- Grupos secundários: Tornozelo, músculos do pé, perónio/fibulares, tibial posterior e equilíbrio
- Músculos principais (tags): ankle, feet, ankle_stability
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (171 chars): Rotação controlada da planta do pé para dentro contra elástico, com a perna imóvel e amplitude pequena. Serve para treinar tibial posterior e controlo medial do tornozelo.
- Execução (7 passos):
  - Senta-te e prende o elástico ao lado exterior do pé que vai trabalhar.
  - Passa o elástico pela parte da frente do pé e mantém calcanhar apoiado.
  - Alinha a perna e segura o joelho para ele não acompanhar o movimento.
  - Vira lentamente a planta do pé para dentro numa amplitude pequena e sem dor.
  - Mantém os dedos relaxados e pausa um segundo.
  - Regressa em dois a três segundos até o pé ficar neutro.
  - Reduz a tensão se o joelho rodar ou surgir dor na face interna do tornozelo.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E196 — Eversão do tornozelo com elástico

- Chave estável: `eversao_do_tornozelo_com_elastico__pernas`
- Grupo principal: Pernas
- Grupos secundários: Tornozelo, músculos do pé, perónio/fibulares, tibial posterior e equilíbrio
- Músculos principais (tags): ankle, feet, ankle_stability
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (173 chars): Rotação controlada da planta do pé para fora contra elástico, isolando o tornozelo sem mover o joelho. Serve para treinar músculos fibulares e controlo lateral do tornozelo.
- Execução (7 passos):
  - Senta-te e prende o elástico ao lado interior do pé que vai trabalhar.
  - Passa o elástico pela parte da frente do pé, com o calcanhar apoiado.
  - Mantém joelho e anca imóveis e os dedos relaxados.
  - Vira a planta do pé para fora sem levantar ou arrastar o calcanhar.
  - Pausa um segundo sentindo a zona lateral da perna.
  - Regressa devagar à posição neutra sem deixar o elástico puxar.
  - Usa menor amplitude se houver desconforto lateral ou se a perna rodar.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E197 — Flexão da anca em pé com elástico

- Chave estável: `flexao_da_anca_em_pe_com_elastico__pernas`
- Grupo principal: Pernas
- Grupos secundários: Reto femoral, core, glúteo médio da perna de apoio e equilíbrio
- Músculos principais (tags): hip_flexors, rectus_femoris
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (154 chars): Elevação do joelho contra elástico pela flexão da anca, mantendo a bacia nivelada e o tronco vertical. Serve para treinar flexores da anca e reto femoral.
- Execução (7 passos):
  - Prende o elástico num ponto baixo atrás de ti e coloca-o à volta do pé ou tornozelo.
  - Fica alto junto a uma parede para apoio, com pés paralelos e bacia nivelada.
  - Ativa ligeiramente o abdómen sem inclinar o tronco para trás.
  - Eleva o joelho à frente pela anca até à altura que controlas.
  - Pausa um segundo sem rodar a bacia nem encolher o ombro de apoio.
  - Baixa o pé em dois a três segundos até tocar no chão.
  - Reduz a resistência se precisares de balançar ou arquear a lombar.
- Erros comuns: Abrir demasiado os cotovelos. | Perder a posição das escápulas. | Dobrar os punhos. | Arquear a lombar em excesso. | Descer o peso sem controlo.
- Versão mais fácil: Faz com as mãos num apoio mais alto ou com os joelhos apoiados, sem perder o alinhamento cabeça–anca.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Protege ombros e punhos com um peso controlável e amplitude sem dor. Para com dor aguda no ombro, dormência no braço ou perda de controlo do peso.

### E198 — Copenhagen plank com apoio

- Chave estável: `copenhagen_plank_com_apoio__pernas`
- Grupo principal: Pernas
- Grupos secundários: Adutores, oblíquos, glúteo médio, ombro de apoio e core
- Músculos principais (tags): adductors, anti_lateral_flexion, deep_stability
- Equipamento: Banco / cadeira / apoio estável
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (169 chars): Prancha lateral com a perna superior apoiada num banco e a inferior a ajudar, treinando adutores e resistência à inclinação do tronco. Serve para o treinar com controlo.
- Execução (7 passos):
  - Deita-te de lado com o antebraço por baixo do ombro e um banco estável junto aos pés.
  - Apoia a parte interna do joelho da perna de cima no banco; mantém a perna de baixo no chão para ajudar.
  - Alinha cabeça, costelas e bacia e aponta os dois joelhos para a frente.
  - Pressiona o joelho de cima contra o banco e eleva a anca alguns centímetros.
  - Mantém 5 a 15 segundos sem deixar o ombro colapsar ou a bacia rodar.
  - Baixa a anca devagar e descansa antes de repetir do outro lado.
  - Usa a perna de baixo no chão e menor duração se sentires esforço excessivo na virilha.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E199 — Extensão terminal do joelho com elástico

- Chave estável: `extensao_terminal_do_joelho_com_elastico__pernas`
- Grupo principal: Pernas
- Grupos secundários: Quadríceps, vasto medial, glúteos e estabilidade do joelho
- Músculos principais (tags): vastus_medialis, rectus_femoris
- Equipamento: Elásticos
- Tipo (FASE 2): elastico
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Extensão dos últimos graus do joelho contra elástico, apertando o quadríceps sem deslocar a bacia. Serve para o treinar com controlo.
- Execução (7 passos):
  - Prende o elástico atrás do joelho a um ponto firme e coloca-o na dobra posterior da perna.
  - Recua até haver tensão com o joelho ligeiramente fletido e o pé inteiro no chão.
  - Alinha anca, joelho e segundo dedo do pé sem rodar a bacia.
  - Estende o joelho pressionando-o para trás até a perna ficar direita, sem hiperextender.
  - Contrai o quadríceps durante um a dois segundos.
  - Deixa o joelho fletir lentamente sem o pé ou a anca mexerem.
  - Reduz a tensão se o joelho colapsar para dentro ou surgir dor articular.
- Erros comuns: Usar peso acima do que controlas. | Perder o alinhamento durante a repetição. | Encurtar a amplitude útil. | Prender a respiração. | Continuar quando o músculo alvo já não controla o movimento.
- Versão mais fácil: Usa menos peso ou resistência, menor amplitude e um apoio estável, mantendo a trajetória descrita.
- Versão mais difícil: Sobe ligeiramente o peso, alonga a pausa ou desce mais devagar, alterando uma variável de cada vez.
- Segurança: Usa um peso e uma amplitude que consigas controlar. Para se houver dor aguda, tontura, formigueiro, perda de equilíbrio ou perda de controlo.

### E200 — Abdução de anca deitada

- Chave estável: `abducao_de_anca_deitada__pernas`
- Grupo principal: Pernas
- Grupos secundários: Glúteo médio, glúteo mínimo, abdutores da anca e core lateral
- Músculos principais (tags): abductors, glute_med, glute_min
- Equipamento: Peso corporal
- Tipo (FASE 2): peso_corporal
- Origem: seed `SeedData.exercisesByGroup["Pernas"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (163 chars): Elevação lateral da perna de cima, deitado de lado, sem rodar a bacia nem apontar os dedos para o teto. Serve para treinar glúteo médio, glúteo mínimo e abdutores.
- Execução (7 passos):
  - Deita-te de lado com a perna de baixo dobrada e a de cima estendida.
  - Alinha cabeça, ombros, bacia e calcanhar de cima; usa a mão no chão para equilíbrio.
  - Mantém a bacia empilhada e roda ligeiramente os dedos do pé para a frente ou para baixo.
  - Eleva a perna de cima 20 a 30 centímetros sem inclinar o tronco.
  - Pausa quando sentires a lateral da anca, não a frente da coxa.
  - Baixa em dois a três segundos sem deixar a perna cair.
  - Reduz a amplitude se a bacia rodar para trás ou a lombar apertar.
- Erros comuns: Perder o alinhamento do corpo. | Encurtar a amplitude útil. | Prender a respiração. | Continuar depois de perder o controlo do movimento.
- Versão mais fácil: Reduz a amplitude, o tempo ou o número de repetições e usa um apoio estável.
- Versão mais difícil: Desce mais devagar, faz uma pausa curta no ponto mais difícil ou acrescenta repetições controladas.
- Segurança: Controla o movimento do início ao fim e usa uma amplitude que domines. Para se houver dor aguda, tontura, formigueiro ou perda de equilíbrio.

### E201 — Marcha no lugar

- Chave estável: `marcha_no_lugar__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (136 chars): Marcha parada elevando alternadamente os pés para aquecer sem sair do sítio. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Fica de pé com o tronco direito e os braços soltos ao lado do corpo.
  - Marcha no lugar elevando um joelho de cada vez, a uma altura confortável.
  - Pousa o pé inteiro com suavidade a cada passo.
  - Balança os braços de forma natural, como numa caminhada.
  - Mantém os ombros relaxados e o olhar em frente.
  - Aumenta o ritmo ou a altura dos joelhos para intensificar.
  - Marcha 1 a 3 minutos como aquecimento ou pausa ativa; baixa o ritmo gradualmente antes de parar.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.

### E202 — Jumping jacks

- Chave estável: `jumping_jacks__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (135 chars): Abrir e fechar braços e pernas em saltos leves para aquecer e ganhar ritmo. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Fica de pé com os pés juntos e os braços ao lado do corpo.
  - Salta abrindo as pernas para os lados e, ao mesmo tempo, sobe os braços por cima da cabeça.
  - Aterra com os pés um pouco mais afastados que os ombros e os joelhos suaves.
  - Salta de novo fechando as pernas e descendo os braços ao lado do corpo.
  - Aterra sempre na parte da frente dos pés, em silêncio; mantém o tronco direito e o abdómen levemente ativo.
  - Começa devagar e aumenta o ritmo aos poucos; trabalha 20 a 60 segundos por bloco; 1
  - Faz o movimento a caminhar (abrir e fechar sem saltar) para reduzir o impacto.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.

### E203 — Burpees

- Chave estável: `burpees__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (162 chars): Sequência de agachar, apoiar mãos, ir à prancha e voltar a levantar para elevar a frequência cardíaca. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Fica de pé com espaço livre.
  - Agacha e coloca as mãos no chão.
  - Leva os pés para trás até prancha.
  - Faz flexão apenas se a variação pedir e conseguires controlar.
  - Traz os pés para perto das mãos.
  - Levanta-te ou salta baixo.
  - Trabalha em blocos de 20 a 40 segundos a ritmo calmo, respira a cada repetição e abranda se perderes a postura.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.

### E204 — Skaters

- Chave estável: `skaters__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (125 chars): Saltos laterais alternados que treinam cardio e controlo de anca. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Fica de pé com os pés à largura da anca e os joelhos ligeiramente dobrados.
  - Salta para o lado com uma perna, aterrando nesse pé com o joelho suave.
  - Deixa a outra perna cruzar por trás, sem apoiar ou tocando só com a ponta.
  - Balança os braços ao ritmo, como um patinador; salta de seguida para o outro lado, empurrando com a perna de apoio.
  - Aterra sempre em silêncio, com o joelho alinhado com o pé.
  - Começa com saltos curtos e aumenta a distância aos poucos; trabalha 20 a 40 segundos por bloco; 1
  - Reduz a distância do salto se o joelho cair para dentro na aterragem.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.

### E205 — High knees

- Chave estável: `high_knees__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Corrida no lugar com joelhos altos para aumentar cadência e respiração. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Fica de pé com o tronco direito e o olhar em frente; corre no lugar elevando um joelho de cada vez até à altura da anca.
  - Aterra na parte da frente dos pés, com passos leves e rápidos.
  - Usa os braços dobrados a 90 graus, a bombear ao ritmo da corrida.
  - Mantém o abdómen ativo para o tronco não inclinar para trás.
  - Começa com joelhos à altura média e sobe conforme o controlo; trabalha 15 a 30 segundos por bloco.
  - Marcha no lugar elevando os joelhos, sem correr, para reduzir o impacto.
  - 1; para se perderes a postura ou o ritmo respiratório.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.

### E206 — Circuito cardio peso corporal

- Chave estável: `circuito_cardio_peso_corporal__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (145 chars): Sequência de cardio sem equipamento alternando movimentos de corpo inteiro por tempo. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Encadeia 4 a 6 exercícios sem equipamento, 30 a 45 segundos em cada, com pausas curtas.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Mantém a intensidade adequada ao teu nível. Abranda ou termina se houver tontura, dor no peito, falta de ar fora do normal ou perda de coordenação.

### E207 — Passadeira caminhada

- Chave estável: `passadeira_caminhada__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (145 chars): Caminhada em passadeira a ritmo confortável, em que consegues falar frases completas. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Sobe para a passadeira e começa devagar.
  - Escolhe uma velocidade em que consegues conversar em frases completas.
  - Ajusta a velocidade para caminhada ou corrida leve.
  - Mantém tronco alto, olhar em frente e passadas controladas.
  - Evita aterrar muito à frente do corpo.
  - Mantém 5 a 20 minutos num ritmo sustentável.
  - Reduz velocidade no fim antes de sair.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E208 — Passadeira caminhada rápida

- Chave estável: `passadeira_caminhada_rapida__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (143 chars): Caminhada vigorosa em passadeira, com passo vivo em que só consegues frases curtas. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Sobe para a passadeira e começa devagar.
  - Sobe a velocidade até um passo vivo em que só consegues dizer frases curtas.
  - Ajusta a velocidade para caminhada ou corrida leve.
  - Mantém tronco alto, olhar em frente e passadas controladas.
  - Evita aterrar muito à frente do corpo.
  - Mantém 5 a 20 minutos num ritmo sustentável.
  - Reduz velocidade no fim antes de sair.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E209 — Passadeira corrida leve

- Chave estável: `passadeira_corrida_leve__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (120 chars): Corrida suave em passadeira, a ritmo contínuo e conversável. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Sobe para a passadeira e começa devagar.
  - Passa para um trote suave e contínuo, sem encurtar a respiração.
  - Ajusta a velocidade para caminhada ou corrida leve.
  - Mantém tronco alto, olhar em frente e passadas controladas.
  - Evita aterrar muito à frente do corpo.
  - Mantém 5 a 20 minutos num ritmo sustentável.
  - Reduz velocidade no fim antes de sair.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E210 — Passadeira corrida intervalada

- Chave estável: `passadeira_corrida_intervalada__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (140 chars): Alternância de corrida rápida e trote leve na passadeira, em blocos programados. Serve para treinar resistência cardiovascular e respiração.
- Execução (6 passos):
  - Aquece 5 a 10 minutos na passadeira, em caminhada ou corrida leve.
  - Escolhe uma velocidade forte mas controlável para o intervalo.
  - Corre 20 a 60 segundos mantendo tronco alto e passada estável.
  - Recupera em caminhada ou trote leve durante 60 a 120 segundos.
  - Repete poucos blocos no início.
  - Faz 3 a 8 minutos de cooldown no fim.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E211 — Passadeira inclinação

- Chave estável: `passadeira_inclinacao__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (144 chars): Caminhada em subida na passadeira, com inclinação leve para ativar glúteos e gémeos. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa na passadeira em caminhada fácil com inclinação baixa.
  - Usa inclinação leve, de 3 a 6 por cento, mantendo a velocidade de caminhada.
  - Aumenta a inclinação gradualmente sem agarrar os apoios.
  - Mantém tronco alto e passada curta, empurrando o chão com glúteos e gémeos.
  - Usa velocidade mais baixa do que numa caminhada plana.
  - Mantém 5 a 20 minutos conforme o nível.
  - Baixa a inclinação antes de terminar.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E212 — Passadeira inclinação moderada

- Chave estável: `passadeira_inclinacao_moderada__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (141 chars): Caminhada em subida com inclinação média, mais exigente para pernas e respiração. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa na passadeira em caminhada fácil com inclinação baixa.
  - Sobe a inclinação para 6 a 10 por cento e reduz ligeiramente a velocidade.
  - Aumenta a inclinação gradualmente sem agarrar os apoios.
  - Mantém tronco alto e passada curta, empurrando o chão com glúteos e gémeos.
  - Usa velocidade mais baixa do que numa caminhada plana.
  - Mantém 5 a 20 minutos conforme o nível.
  - Baixa a inclinação antes de terminar.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E213 — Passadeira sprints

- Chave estável: `passadeira_sprints__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (140 chars): Tiros curtos e fortes na passadeira, com recuperação completa entre cada sprint. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Aquece 5 a 10 minutos na passadeira, em caminhada ou corrida leve.
  - Faz tiros de 10 a 20 segundos quase no máximo e recupera por completo entre cada um.
  - Escolhe uma velocidade forte mas controlável para o intervalo.
  - Corre 20 a 60 segundos mantendo tronco alto e passada estável.
  - Recupera em caminhada ou trote leve durante 60 a 120 segundos.
  - Repete poucos blocos no início.
  - Faz 3 a 8 minutos de cooldown no fim.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E214 — Passadeira sprints intervalados

- Chave estável: `passadeira_sprints_intervalados__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (134 chars): Série programada de sprints na passadeira com pausas ativas cronometradas. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Aquece 5 a 10 minutos na passadeira, em caminhada ou corrida leve.
  - Programa blocos: 15 a 30 segundos fortes seguidos de 60 a 90 segundos a caminhar.
  - Escolhe uma velocidade forte mas controlável para o intervalo.
  - Corre 20 a 60 segundos mantendo tronco alto e passada estável.
  - Recupera em caminhada ou trote leve durante 60 a 120 segundos.
  - Repete poucos blocos no início.
  - Faz 3 a 8 minutos de cooldown no fim.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E215 — Passadeira aquecimento

- Chave estável: `passadeira_aquecimento__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (149 chars): Caminhada fácil na passadeira para subir a temperatura corporal antes da parte principal. Serve para treinar resistência cardiovascular e respiração.
- Execução (6 passos):
  - Sobe para a passadeira e começa numa caminhada muito fácil.
  - Mantém tronco alto, olhar em frente e passos curtos.
  - Caminha 5 a 10 minutos, aumentando a velocidade aos poucos.
  - Usa inclinação baixa ou zero se ainda estás a aquecer.
  - Não comeces logo em corrida, sprint ou inclinação forte.
  - Termina quando sentires corpo quente e respiração ativa, mas controlada.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E216 — Passadeira cooldown

- Chave estável: `passadeira_cooldown__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (148 chars): Caminhada muito leve na passadeira para baixar gradualmente respiração e ritmo cardíaco. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Depois da parte principal, reduz a velocidade gradualmente.
  - Se usaste inclinação, baixa primeiro a inclinação.
  - Caminha 3 a 8 minutos a ritmo fácil.
  - Mantém passadas curtas e tronco alto enquanto a respiração desacelera.
  - Usa os apoios apenas para equilíbrio, não para suportar o peso.
  - Sai só quando a passadeira estiver lenta ou parada.
  - Pára se houver tontura, dor no peito ou desequilíbrio.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E217 — Bicicleta ritmo leve

- Chave estável: `bicicleta_ritmo_leve__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Bicicleta
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (109 chars): Pedalada suave e contínua, com resistência baixa e respiração confortável. Serve para o treinar com controlo.
- Execução (7 passos):
  - Ajusta o selim antes de começar.
  - Mantém resistência baixa e cadência confortável, a conseguir conversar.
  - Pedala com resistência leve a moderada.
  - Mantém cadência regular e joelhos a seguir a linha dos pés.
  - Usa o guiador sem encolher os ombros.
  - Mantém 5 a 20 minutos conforme objetivo.
  - Reduz resistência nos últimos minutos.
- Erros comuns: Pedalar com o selim mal ajustado. | Usar resistência alta demais para o teu nível. | Deixar os joelhos abrir para fora. | Encolher os ombros contra o guiador. | Parar de repente depois de esforço forte.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E218 — Bicicleta ritmo moderado

- Chave estável: `bicicleta_ritmo_moderado__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Bicicleta
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (117 chars): Pedalada contínua a ritmo médio, com resistência que aquece as pernas sem esgotar. Serve para o treinar com controlo.
- Execução (7 passos):
  - Ajusta o selim antes de começar.
  - Usa resistência média, com as pernas a aquecer mas sem perder o ritmo da respiração.
  - Pedala com resistência leve a moderada.
  - Mantém cadência regular e joelhos a seguir a linha dos pés.
  - Usa o guiador sem encolher os ombros.
  - Mantém 5 a 20 minutos conforme objetivo.
  - Reduz resistência nos últimos minutos.
- Erros comuns: Pedalar com o selim mal ajustado. | Usar resistência alta demais para o teu nível. | Deixar os joelhos abrir para fora. | Encolher os ombros contra o guiador. | Parar de repente depois de esforço forte.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E219 — Bicicleta intervalos

- Chave estável: `bicicleta_intervalos__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Bicicleta
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (120 chars): Alternar pedaladas fortes e recuperações leves na bicicleta. Serve para treinar resistência cardiovascular e respiração.
- Execução (6 passos):
  - Ajusta selim e aquece 5 a 10 minutos com resistência leve.
  - Aumenta resistência ou cadência para um bloco forte de 20 a 60 segundos.
  - Mantém joelhos alinhados e não saltes no selim.
  - Recupera 60 a 120 segundos com resistência baixa.
  - Repete poucos blocos no início.
  - Faz cooldown fácil no fim.
- Erros comuns: Pedalar com o selim mal ajustado. | Usar resistência alta demais para o teu nível. | Deixar os joelhos abrir para fora. | Encolher os ombros contra o guiador. | Parar de repente depois de esforço forte.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E220 — Bicicleta resistência

- Chave estável: `bicicleta_resistencia__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Bicicleta
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (87 chars): Pedalada com resistência alta e cadência mais lenta, para força de pernas na bicicleta.
- Execução (7 passos):
  - Ajusta o selim antes de começar.
  - Sobe a resistência até a pedalada ficar pesada e desce a cadência, sem balançar a anca.
  - Pedala com resistência leve a moderada.
  - Mantém cadência regular e joelhos a seguir a linha dos pés.
  - Usa o guiador sem encolher os ombros.
  - Mantém 5 a 20 minutos conforme objetivo.
  - Reduz resistência nos últimos minutos.
- Erros comuns: Pedalar com o selim mal ajustado. | Usar resistência alta demais para o teu nível. | Deixar os joelhos abrir para fora. | Encolher os ombros contra o guiador. | Parar de repente depois de esforço forte.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E221 — Bicicleta aquecimento

- Chave estável: `bicicleta_aquecimento__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Bicicleta
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Pedalada leve para preparar joelhos, anca e respiração antes do treino. Serve para treinar resistência cardiovascular e respiração.
- Execução (6 passos):
  - Ajusta o selim para o joelho ficar ligeiramente fletido no ponto baixo da pedalada.
  - Começa com resistência baixa.
  - Pedala 5 a 10 minutos com cadência confortável.
  - Mantém tronco alto e ombros relaxados.
  - Aumenta resistência apenas um pouco no fim do aquecimento.
  - Avança para a parte principal quando as pernas estiverem quentes.
- Erros comuns: Pedalar com o selim mal ajustado. | Usar resistência alta demais para o teu nível. | Deixar os joelhos abrir para fora. | Encolher os ombros contra o guiador. | Parar de repente depois de esforço forte.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E222 — Bicicleta cooldown

- Chave estável: `bicicleta_cooldown__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Bicicleta
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (121 chars): Pedalada fácil para recuperar depois de esforço mais intenso. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Senta-te bem no selim da bicicleta e baixa a resistência para nível fácil.
  - Pedala 3 a 8 minutos com cadência confortável.
  - Mantém tronco alto, ombros relaxados e mãos leves no guiador.
  - Deixa a respiração e a frequência cardíaca descerem gradualmente.
  - Não pares de pedalar de repente depois de esforço forte.
  - Termina quando te sentires estável.
  - Sai com cuidado, especialmente se as pernas estiverem pesadas.
- Erros comuns: Pedalar com o selim mal ajustado. | Usar resistência alta demais para o teu nível. | Deixar os joelhos abrir para fora. | Encolher os ombros contra o guiador. | Parar de repente depois de esforço forte.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E223 — Elíptica ritmo leve

- Chave estável: `eliptica_ritmo_leve__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Elíptica
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (142 chars): Movimento contínuo suave na elíptica, de baixo impacto, para aquecer ou recuperar. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Sobe para a elíptica segurando os apoios.
  - Mantém resistência baixa e movimento fluido, sem pressa.
  - Começa com resistência leve e movimento fluido.
  - Mantém tronco alto, pés apoiados e ombros relaxados.
  - Empurra e puxa os braços apenas se a máquina tiver pegas móveis.
  - Mantém ritmo contínuo por 5 a 20 minutos ou blocos intervalados.
  - Reduz resistência e ritmo no fim antes de sair.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E224 — Elíptica ritmo moderado

- Chave estável: `eliptica_ritmo_moderado__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Elíptica
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Trabalho contínuo a ritmo médio na elíptica, coordenando pernas e braços. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Sobe para a elíptica segurando os apoios.
  - Usa resistência média e um ritmo constante que aqueça pernas e braços.
  - Começa com resistência leve e movimento fluido.
  - Mantém tronco alto, pés apoiados e ombros relaxados.
  - Empurra e puxa os braços apenas se a máquina tiver pegas móveis.
  - Mantém ritmo contínuo por 5 a 20 minutos ou blocos intervalados.
  - Reduz resistência e ritmo no fim antes de sair.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E225 — Elíptica intervalos

- Chave estável: `eliptica_intervalos__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Elíptica
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (140 chars): Alternância de blocos rápidos e lentos na elíptica, mantendo o movimento fluido. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Sobe para a elíptica segurando os apoios.
  - Alterna 30 a 60 segundos rápidos com 60 a 90 segundos lentos, sem parar o movimento.
  - Começa com resistência leve e movimento fluido.
  - Mantém tronco alto, pés apoiados e ombros relaxados.
  - Empurra e puxa os braços apenas se a máquina tiver pegas móveis.
  - Mantém ritmo contínuo por 5 a 20 minutos ou blocos intervalados.
  - Reduz resistência e ritmo no fim antes de sair.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E226 — Elíptica resistência

- Chave estável: `eliptica_resistencia__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Elíptica
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (88 chars): Elíptica com resistência alta e cadência controlada, para mais força e menos velocidade.
- Execução (7 passos):
  - Sobe para a elíptica segurando os apoios.
  - Sobe a resistência e baixa a cadência, empurrando e puxando com força controlada.
  - Começa com resistência leve e movimento fluido.
  - Mantém tronco alto, pés apoiados e ombros relaxados.
  - Empurra e puxa os braços apenas se a máquina tiver pegas móveis.
  - Mantém ritmo contínuo por 5 a 20 minutos ou blocos intervalados.
  - Reduz resistência e ritmo no fim antes de sair.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E227 — Elíptica aquecimento

- Chave estável: `eliptica_aquecimento__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Elíptica
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (148 chars): Entrada progressiva na elíptica para preparar articulações e respiração antes do treino. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Sobe para a elíptica segurando os apoios.
  - Começa muito leve e aumenta o ritmo aos poucos durante 5 a 10 minutos.
  - Começa com resistência leve e movimento fluido.
  - Mantém tronco alto, pés apoiados e ombros relaxados.
  - Empurra e puxa os braços apenas se a máquina tiver pegas móveis.
  - Mantém ritmo contínuo por 5 a 20 minutos ou blocos intervalados.
  - Reduz resistência e ritmo no fim antes de sair.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E228 — Elíptica cooldown

- Chave estável: `eliptica_cooldown__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Elíptica
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (140 chars): Redução gradual do ritmo na elíptica no fim do treino, até a respiração acalmar. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Sobe para a elíptica segurando os apoios.
  - Reduz a resistência e o ritmo gradualmente durante 3 a 8 minutos.
  - Começa com resistência leve e movimento fluido.
  - Mantém tronco alto, pés apoiados e ombros relaxados.
  - Empurra e puxa os braços apenas se a máquina tiver pegas móveis.
  - Mantém ritmo contínuo por 5 a 20 minutos ou blocos intervalados.
  - Reduz resistência e ritmo no fim antes de sair.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E229 — Corda de saltar ritmo leve

- Chave estável: `corda_de_saltar_ritmo_leve__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Corda de saltar
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (123 chars): Saltos baixos e contínuos à corda, a ritmo calmo e sustentável. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Segura uma pega em cada mão com cotovelos próximos do corpo.
  - Mantém saltos baixos e contínuos, a um ritmo calmo que consigas sustentar.
  - Mantém a corda atrás dos pés antes da primeira volta; roda a corda principalmente pelos punhos, não pelos ombros.
  - Salta baixo, apenas o suficiente para a corda passar; faz saltos baixos com os dois pés ou alterna de forma simples.
  - Aterra na parte da frente dos pés com joelhos ligeiramente flexionados.
  - Faz blocos de 30 a 60 segundos no início, respirando em ritmo constante.
  - Pára se tropeçares repetidamente, se os gémeos ficarem rígidos ou se perderes coordenação.
- Erros comuns: Rodar a corda pelos ombros em vez dos punhos. | Saltar demasiado alto. | Aterrar com as pernas rígidas. | Olhar para baixo e perder a postura. | Continuar depois de tropeçar repetidamente.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a complexidade dos saltos de cada vez.
- Segurança: Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.

### E230 — Corda de saltar intervalos

- Chave estável: `corda_de_saltar_intervalos__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Corda de saltar
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (138 chars): Saltos de corda em blocos rápidos alternados com pausas curtas de recuperação. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Segura uma pega em cada mão com cotovelos próximos do corpo.
  - Alterna 20 a 40 segundos a saltar com 20 a 40 segundos de pausa a caminhar.
  - Mantém a corda atrás dos pés antes da primeira volta; roda a corda principalmente pelos punhos, não pelos ombros.
  - Salta baixo, apenas o suficiente para a corda passar; faz saltos baixos com os dois pés ou alterna de forma simples.
  - Aterra na parte da frente dos pés com joelhos ligeiramente flexionados.
  - Faz blocos de 30 a 60 segundos no início, respirando em ritmo constante.
  - Pára se tropeçares repetidamente, se os gémeos ficarem rígidos ou se perderes coordenação.
- Erros comuns: Rodar a corda pelos ombros em vez dos punhos. | Saltar demasiado alto. | Aterrar com as pernas rígidas. | Olhar para baixo e perder a postura. | Continuar depois de tropeçar repetidamente.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a complexidade dos saltos de cada vez.
- Segurança: Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.

### E231 — Corda de saltar pés alternados

- Chave estável: `corda_de_saltar_pes_alternados__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Corda de saltar
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (136 chars): Saltos de corda alternando pé direito e esquerdo como corrida leve no lugar. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Segura uma pega em cada mão com cotovelos próximos do corpo.
  - Mantém a corda atrás dos pés antes da primeira volta; roda a corda principalmente pelos punhos, não pelos ombros.
  - Salta baixo, apenas o suficiente para a corda passar.
  - alterna pé direito e pé esquerdo como uma corrida leve no sítio.
  - Aterra na parte da frente dos pés com joelhos ligeiramente flexionados.
  - Faz blocos de 30 a 60 segundos no início, respirando em ritmo constante.
  - Pára se tropeçares repetidamente, se os gémeos ficarem rígidos ou se perderes coordenação.
- Erros comuns: Rodar a corda pelos ombros em vez dos punhos. | Saltar demasiado alto. | Aterrar com as pernas rígidas. | Olhar para baixo e perder a postura. | Continuar depois de tropeçar repetidamente.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a complexidade dos saltos de cada vez.
- Segurança: Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.

### E232 — Corda de saltar joelhos altos

- Chave estável: `corda_de_saltar_joelhos_altos__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Corda de saltar
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Saltos de corda elevando os joelhos mais alto para aumentar intensidade e coordenação. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Segura uma pega em cada mão com cotovelos próximos do corpo.
  - Mantém a corda atrás dos pés antes da primeira volta; roda a corda principalmente pelos punhos, não pelos ombros.
  - Salta baixo, apenas o suficiente para a corda passar.
  - eleva os joelhos um pouco mais a cada salto, sem perder ritmo.
  - Aterra na parte da frente dos pés com joelhos ligeiramente flexionados.
  - Faz blocos de 30 a 60 segundos no início, respirando em ritmo constante.
  - Pára se tropeçares repetidamente, se os gémeos ficarem rígidos ou se perderes coordenação.
- Erros comuns: Rodar a corda pelos ombros em vez dos punhos. | Saltar demasiado alto. | Aterrar com as pernas rígidas. | Olhar para baixo e perder a postura. | Continuar depois de tropeçar repetidamente.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a complexidade dos saltos de cada vez.
- Segurança: Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.

### E233 — Corda de saltar double unders

- Chave estável: `corda_de_saltar_double_unders__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Corda de saltar
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (143 chars): Variação avançada em que a corda passa duas vezes por baixo dos pés no mesmo salto. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Segura uma pega em cada mão com cotovelos próximos do corpo.
  - Mantém a corda atrás dos pés antes da primeira volta; roda a corda principalmente pelos punhos, não pelos ombros.
  - Salta baixo, apenas o suficiente para a corda passar.
  - faz a corda passar duas vezes por cada salto, apenas se já dominas o salto simples.
  - Aterra na parte da frente dos pés com joelhos ligeiramente flexionados.
  - Faz blocos de 30 a 60 segundos no início, respirando em ritmo constante.
  - Pára se tropeçares repetidamente, se os gémeos ficarem rígidos ou se perderes coordenação.
- Erros comuns: Rodar a corda pelos ombros em vez dos punhos. | Saltar demasiado alto. | Aterrar com as pernas rígidas. | Olhar para baixo e perder a postura. | Continuar depois de tropeçar repetidamente.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a complexidade dos saltos de cada vez.
- Segurança: Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.

### E234 — Caminhada exterior leve

- Chave estável: `caminhada_exterior_leve__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Espaço exterior
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (140 chars): Caminhada tranquila ao ar livre, a ritmo em que consegues conversar sem esforço. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Escolhe um percurso plano e caminha a um ritmo em que consegues conversar.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.

### E235 — Caminhada exterior moderada

- Chave estável: `caminhada_exterior_moderada__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Espaço exterior
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (150 chars): Caminhada firme ao ar livre, com passo decidido que aquece o corpo e acelera a respiração. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Acelera para um passo firme e decidido, com os braços a acompanhar.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.

### E236 — Caminhada exterior rápida

- Chave estável: `caminhada_exterior_rapida__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Espaço exterior
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (134 chars): Caminhada ao ar livre em ritmo vivo, sem transformar a passada em corrida. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Caminha quase no limite da marcha, sem transformar o passo em corrida.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.

### E237 — Caminhada exterior em subida

- Chave estável: `caminhada_exterior_em_subida__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Espaço exterior
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (135 chars): Caminhada ao ar livre numa subida, usando passos curtos e esforço contínuo. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Procura uma subida constante e usa passos mais curtos, inclinando pouco o tronco.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.

### E238 — Corrida exterior leve

- Chave estável: `corrida_exterior_leve__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Espaço exterior
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (136 chars): Corrida no exterior com passada, direção e intensidade adaptadas ao terreno. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Corre a um ritmo conversável, com passada curta e relaxada.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.

### E239 — Corrida exterior moderada

- Chave estável: `corrida_exterior_moderada__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Espaço exterior
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (149 chars): Corrida ao ar livre em ritmo sustentável, mais forte que corrida leve e abaixo de sprint. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Sobe o ritmo até só conseguires frases curtas, mantendo a passada estável.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.

### E240 — Corrida exterior intervalada

- Chave estável: `corrida_exterior_intervalada__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Espaço exterior
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (142 chars): Corrida ao ar livre alternando blocos rápidos e recuperação em caminhada ou trote. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Alterna 1 a 3 minutos rápidos com trote ou caminhada até recuperares.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.

### E241 — Sprints exterior

- Chave estável: `sprints_exterior__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Espaço exterior
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Sprints curtos no exterior com aceleração progressiva e descanso amplo. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Faz tiros de 10 a 20 segundos quase no máximo, com recuperação completa entre eles.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.

### E242 — Corrida em subida

- Chave estável: `corrida_em_subida__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Espaço exterior
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (141 chars): Corrida em terreno inclinado para aumentar esforço sem depender só da velocidade. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Escolhe uma subida curta, sobe a correr com passos curtos e desce a caminhar.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Escolhe piso regular e atenção ao trânsito. Abranda ou termina com tontura, dor no peito, dor articular ou falta de ar fora do normal.

### E243 — HIIT peso corporal

- Chave estável: `hiit_peso_corporal__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (141 chars): Circuito intervalado sem equipamento com exercícios curtos e recuperações claras. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Monta um circuito de 3 a 5 exercícios simples e trabalha 20 a 40 segundos em cada um.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Mantém a intensidade adequada ao teu nível. Abranda ou termina se houver tontura, dor no peito, falta de ar fora do normal ou perda de coordenação.

### E244 — HIIT cardio

- Chave estável: `hiit_cardio__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (138 chars): Intervalos de cardio para subir a frequência cardíaca mantendo técnica segura. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Alterna blocos fortes de 20 a 40 segundos com recuperações ativas de 40 a 80 segundos.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Mantém a intensidade adequada ao teu nível. Abranda ou termina se houver tontura, dor no peito, falta de ar fora do normal ou perda de coordenação.

### E245 — HIIT passadeira

- Chave estável: `hiit_passadeira__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Passadeira
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (148 chars): Intervalos intensos na passadeira: blocos rápidos alternados com recuperação a caminhar. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Aquece 5 a 10 minutos na passadeira, em caminhada ou corrida leve.
  - Alterna 20 a 40 segundos rápidos com 40 a 80 segundos de caminhada de recuperação.
  - Escolhe uma velocidade forte mas controlável para o intervalo.
  - Corre 20 a 60 segundos mantendo tronco alto e passada estável.
  - Recupera em caminhada ou trote leve durante 60 a 120 segundos.
  - Repete poucos blocos no início.
  - Faz 3 a 8 minutos de cooldown no fim.
- Erros comuns: Começar rápido demais, sem aquecer. | Agarrar os apoios para compensar o ritmo. | Dar passadas longas demais. | Olhar para os pés em vez de olhar em frente. | Sair da passadeira sem abrandar primeiro.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a inclinação ou a velocidade de cada vez.
- Segurança: Segura os apoios da passadeira apenas para equilibrar e abranda antes de sair. Para com tontura, dor no peito ou falta de ar fora do normal.

### E246 — HIIT bicicleta

- Chave estável: `hiit_bicicleta__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Bicicleta
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (152 chars): Intervalos intensos na bicicleta: blocos fortes de pedalada alternados com recuperação leve. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Ajusta selim e aquece 5 a 10 minutos com resistência leve.
  - Alterna 20 a 40 segundos de pedalada forte com 60 a 90 segundos muito leves.
  - Aumenta resistência ou cadência para um bloco forte de 20 a 60 segundos.
  - Mantém joelhos alinhados e não saltes no selim.
  - Recupera 60 a 120 segundos com resistência baixa.
  - Repete poucos blocos no início.
  - Faz cooldown fácil no fim.
- Erros comuns: Pedalar com o selim mal ajustado. | Usar resistência alta demais para o teu nível. | Deixar os joelhos abrir para fora. | Encolher os ombros contra o guiador. | Parar de repente depois de esforço forte.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, a resistência ou a cadência de cada vez.
- Segurança: Ajusta a máquina ao teu corpo antes de acelerar. Abranda ou termina com tontura, dor no peito, dor no joelho ou falta de ar fora do normal.

### E247 — HIIT corda

- Chave estável: `hiit_corda__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Corda de saltar
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (143 chars): Intervalos intensos à corda: blocos rápidos de saltos alternados com pausas curtas. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Segura uma pega em cada mão com cotovelos próximos do corpo.
  - Faz blocos quase máximos de 20 a 30 segundos com pausas curtas de recuperação.
  - Mantém a corda atrás dos pés antes da primeira volta; roda a corda principalmente pelos punhos, não pelos ombros.
  - Salta baixo, apenas o suficiente para a corda passar; faz saltos baixos com os dois pés ou alterna de forma simples.
  - Aterra na parte da frente dos pés com joelhos ligeiramente flexionados.
  - Faz blocos de 30 a 60 segundos no início, respirando em ritmo constante.
  - Pára se tropeçares repetidamente, se os gémeos ficarem rígidos ou se perderes coordenação.
- Erros comuns: Rodar a corda pelos ombros em vez dos punhos. | Saltar demasiado alto. | Aterrar com as pernas rígidas. | Olhar para baixo e perder a postura. | Continuar depois de tropeçar repetidamente.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a complexidade dos saltos de cada vez.
- Segurança: Aterra em silêncio, com os joelhos suaves. Para com dor nos tornozelos, joelhos ou canelas, tontura ou falta de ar fora do normal.

### E248 — HIIT simples

- Chave estável: `hiit_simples__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (151 chars): Intervalos básicos de esforço e pausa, escolhendo movimentos simples e fáceis de controlar. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Escolhe um só movimento fácil de controlar e alterna esforço e pausa em blocos iguais.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Mantém a intensidade adequada ao teu nível. Abranda ou termina se houver tontura, dor no peito, falta de ar fora do normal ou perda de coordenação.

### E249 — Circuito cardio leve

- Chave estável: `circuito_cardio_leve__cardio`
- Grupo principal: Cardio
- Grupos secundários: Core, pernas, coordenação, respiração e sistema cardiovascular
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): cardio
- Origem: seed `SeedData.exercisesByGroup["Cardio"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Circuito de baixa intensidade para aquecer ou recuperar sem impacto alto. Serve para treinar resistência cardiovascular e respiração.
- Execução (7 passos):
  - Começa em pé com espaço livre e postura alta.
  - Encadeia movimentos suaves a baixa intensidade, sem saltos, durante 10 a 20 minutos.
  - Executa a variação escolhida em ritmo fácil nos primeiros 30 a 60 segundos.
  - Mantém joelhos suaves, pés a aterrar com controlo e abdómen ativo.
  - Aumenta intensidade só se a coordenação continuar limpa.
  - Trabalha 20 a 60 segundos por bloco ou 5 a 20 minutos em ritmo contínuo.
  - Abranda antes de parar totalmente.
- Erros comuns: Aumentar a intensidade antes de dominar a técnica. | Saltar o aquecimento. | Perder o ritmo da respiração. | Aterrar sem controlo. | Continuar com dor articular.
- Versão mais fácil: Pratica durante menos tempo, a um ritmo em que consigas falar, e aumenta a duração antes da intensidade.
- Versão mais difícil: Aumenta apenas a duração, o ritmo ou a dificuldade do percurso de cada vez.
- Segurança: Mantém a intensidade adequada ao teu nível. Abranda ou termina se houver tontura, dor no peito, falta de ar fora do normal ou perda de coordenação.

### E250 — Kihon

- Chave estável: `kihon__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (116 chars): Repetição técnica de bases, socos, defesas ou pontapés fundamentais com controlo. Serve para o treinar com controlo.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Define o objetivo do Kihon antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa.
  - Aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E251 — Kata

- Chave estável: `kata__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (113 chars): Sequência formal de técnicas de Karate com direção, ritmo, postura e controlo. Serve para o treinar com controlo.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Define o objetivo do Kata antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa.
  - Aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E252 — Kumite técnico

- Chave estável: `kumite_tecnico__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (126 chars): Drill técnico de combate para distância, guarda e reação controlada. Serve para treinar técnica de Karate, base e coordenação.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Define o objetivo do Kumite técnico antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa.
  - Aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E253 — Sombra de Karate

- Chave estável: `sombra_de_karate__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (119 chars): Simulação individual de combate, combinando deslocamento, técnicas no ar e controlo. Serve para o treinar com controlo.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Define o objetivo do Sombra de Karate antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa.
  - Aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E254 — Drills de deslocamento

- Chave estável: `drills_de_deslocamento__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (144 chars): Trabalho de pés para entrar, sair e mudar ângulo sem cruzar a base, mantendo controlo. Serve para treinar técnica de Karate, base e coordenação.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Define o objetivo do Drills de deslocamento antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa.
  - Aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E255 — Drills de guarda

- Chave estável: `drills_de_guarda__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (195 chars): Repetições de entrada e saída de guarda para organizar mãos, cotovelos, distância e controlo. Serve para treinar técnica de Karate, base e coordenação. Nesta lista, conta para o treino de karate.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Trabalha a retenção: enquadra com os pés, gere a distância e recupera a guarda quando a perderes.
  - Define o objetivo do Drills de guarda antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa; aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E256 — Pontapés técnicos

- Chave estável: `pontapes_tecnicos__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (126 chars): Pontapés técnicos com câmara, extensão, recolha da perna e controlo. Serve para treinar técnica de Karate, base e coordenação.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Define o objetivo do Pontapés técnicos antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa.
  - Aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E257 — Socos técnicos

- Chave estável: `socos_tecnicos__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (122 chars): Socos técnicos coordenando punho, anca, tronco, base e controlo. Serve para treinar técnica de Karate, base e coordenação.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Define o objetivo do Socos técnicos antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa.
  - Aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E258 — Mobilidade de anca para Karate

- Chave estável: `mobilidade_de_anca_para_karate__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (134 chars): Sequência de mobilidade de anca orientada aos pontapés e às bases do Karate. Serve para treinar técnica de Karate, base e coordenação.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Define o objetivo do Mobilidade de anca para Karate antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa.
  - Aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E259 — Mobilidade de ombro para Karate

- Chave estável: `mobilidade_de_ombro_para_karate__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Sequência de mobilidade de ombros orientada à guarda e aos socos do Karate. Serve para treinar técnica de Karate, base e coordenação.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Define o objetivo do Mobilidade de ombro para Karate antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa.
  - Aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E260 — Condicionamento leve para Karate

- Chave estável: `condicionamento_leve_para_karate__karate`
- Grupo principal: Karate
- Grupos secundários: Base, anca, core, ombros, guarda e coordenação
- Músculos principais (tags): karate_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Karate"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Circuito leve de resistência com movimentos de Karate, para aguentar treinos mais longos. Serve para treinar técnica de Karate, base e coordenação.
- Execução (7 passos):
  - Começa em base de Karate com pés firmes, joelhos soltos e guarda organizada.
  - Define o objetivo do Condicionamento leve para Karate antes de acelerar: técnica, deslocamento, golpe ou coordenação.
  - Executa devagar, coordenando pés, anca, tronco, ombros e mãos.
  - Mantém o olhar na direção da técnica e regressa à guarda depois de cada repetição.
  - Trabalha blocos curtos de 30 a 60 segundos com técnica limpa.
  - Aumenta velocidade só se manténs equilíbrio e controlo.
  - Pára se houver dor articular, tontura ou perda de orientação.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E261 — Shrimp / fuga de anca

- Chave estável: `shrimp_fuga_de_anca__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Tatami / espaço de artes marciais
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (129 chars): Fuga de anca no solo para criar espaço e recuperar guarda. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- Execução (7 passos):
  - Deita-te de costas no tatami ou tapete, com os joelhos dobrados e os pés apoiados; o objetivo é criar espaço e recuperar a guarda.
  - Mantém as mãos à frente do peito, como se protegesses a guarda contra um adversário.
  - Vira-te ligeiramente para um lado e apoia bem o pé da perna de cima.
  - Empurra o chão com esse pé e com o ombro de baixo, levantando a anca.
  - Ao mesmo tempo, dispara a anca para trás, afastando-a do lado para onde olhaste.
  - Termina deitado de lado, encolhido, com espaço criado, em base controlada; volta ao centro com controlo e repete para o outro lado.
  - Faz o movimento devagar até fixares o padrão; a velocidade vem depois; 1; para se o pescoço ou a lombar começarem a forçar.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E262 — Ponte de grappling

- Chave estável: `ponte_de_grappling__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Tatami / espaço de artes marciais
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (132 chars): Ponte de grappling para elevar a anca e desequilibrar pressão. Serve para treinar glúteos, com apoio do posterior de coxa e do core.
- Execução (7 passos):
  - Deita-te de costas no tatami ou tapete, com os joelhos dobrados e os pés perto dos glúteos; o objetivo é desequilibrar um adversário por cima.
  - Mantém os braços dobrados junto ao peito, a proteger a guarda.
  - Apoia bem os dois pés e, se for a ponte com viragem, também um ombro.
  - Empurra o chão com os pés e dispara a anca para cima, o mais alto que conseguires.
  - Rola o peso para um ombro, olhando por cima dele, como se quisesses virar alguém.
  - Mantém o controlo do pescoço: o apoio é no ombro, não na cabeça.
  - Desce a anca com controlo e volta à base inicial; alterna os lados da viragem; 1; para se sentires pressão no pescoço ou na lombar.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E263 — Technical stand-up

- Chave estável: `technical_stand_up__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Tatami / espaço de artes marciais
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (137 chars): Subida técnica do chão mantendo uma mão protegida e a perna livre. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- Execução (7 passos):
  - Começa sentado no tatami ou tapete, com uma mão atrás no chão e o pé do lado contrário apoiado; o objetivo é levantar-te protegido.
  - Mantém a outra mão à frente, em guarda, a proteger a cara; apoia com força a mão de trás e o pé da frente no chão.
  - Levanta a anca e passa a perna livre por baixo do corpo, para trás.
  - Pousa esse pé atrás, ficando numa base estável, com um pé à frente e outro atrás.
  - Sobe o tronco e termina de pé, com a guarda organizada e o olhar em frente.
  - Inverte o movimento para voltar a sentar com controlo; alterna o lado do apoio a cada repetição; 1
  - Faz devagar até o padrão sair sem pensar; só depois acelera.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E264 — Sprawl

- Chave estável: `sprawl__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Peso corporal
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (177 chars): Defesa de entrada às pernas: a anca cai para trás e as pernas disparam atrás, terminando com o peito alto. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- Execução (7 passos):
  - Começa de pé numa base de luta, com os joelhos fletidos e a guarda à frente; o objetivo é defender uma entrada às pernas.
  - Deixa cair a anca para baixo e para trás, atirando as pernas esticadas para trás.
  - Apoia as mãos ou os antebraços no chão à frente do peito; termina com a anca baixa e pesada contra o chão e as pernas afastadas atrás.
  - Mantém o peito alto e o olhar em frente, sem deixar os joelhos tocar primeiro.
  - Recolhe as pernas com um salto curto e volta à base de pé, com a guarda organizada.
  - Faz devagar no início, com controlo da descida; repete em séries curtas de 20 a 40 segundos; 1
  - Para se a lombar ou os ombros perderem o controlo da queda.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E265 — Drills de guarda

- Chave estável: `drills_de_guarda__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Tatami / espaço de artes marciais
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (175 chars): Drill de guarda para gerir pernas, anca, pega e distância. Serve para treinar retenção de guarda, distância e movimento de anca. Nesta lista, conta para o treino de jiu-jitsu.
- Execução (7 passos):
  - Começa no tatami ou numa superfície segura, com espaço à volta.
  - Trabalha a retenção: enquadra com os pés, gere a distância e recupera a guarda quando a perderes.
  - Define o objetivo técnico e a posição inicial: guarda, ponte, fuga de anca, base ou passagem.
  - Move primeiro devagar, usando anca, core e apoios das mãos ou pés.
  - Mantém queixo protegido, pescoço longo e respiração controlada; regressa à posição inicial sem cair desorganizado.
  - Repete durante 30 a 60 segundos mantendo precisão; aumenta ritmo só se a técnica continuar limpa.
  - Pára com dor no pescoço, ombro, joelho ou tontura.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E266 — Drills de passagem de guarda

- Chave estável: `drills_de_passagem_de_guarda__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Tatami / espaço de artes marciais
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (151 chars): Repetição de passos, pressão e controlo de anca para passar as pernas do adversário. Serve para treinar passagem de guarda, pressão e controlo da anca.
- Execução (7 passos):
  - Começa no tatami ou numa superfície segura, com espaço à volta.
  - Trabalha a passagem: controla as pernas do adversário imaginário, pressiona e passa para o lado.
  - Define o objetivo técnico e a posição inicial: guarda, ponte, fuga de anca, base ou passagem.
  - Move primeiro devagar, usando anca, core e apoios das mãos ou pés.
  - Mantém queixo protegido, pescoço longo e respiração controlada; regressa à posição inicial sem cair desorganizado.
  - Repete durante 30 a 60 segundos mantendo precisão; aumenta ritmo só se a técnica continuar limpa.
  - Pára com dor no pescoço, ombro, joelho ou tontura.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E267 — Mobilidade de anca para Jiu-Jitsu

- Chave estável: `mobilidade_de_anca_para_jiu_jitsu__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Tatami / espaço de artes marciais
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (141 chars): Mobilidade de anca orientada à guarda e às fugas de anca do Jiu-Jitsu. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- Execução (7 passos):
  - Começa no tatami ou numa superfície segura, com espaço à volta.
  - Encadeia círculos de anca, fugas de anca lentas e aberturas de guarda sentado no chão.
  - Define o objetivo técnico e a posição inicial: guarda, ponte, fuga de anca, base ou passagem.
  - Move primeiro devagar, usando anca, core e apoios das mãos ou pés.
  - Mantém queixo protegido, pescoço longo e respiração controlada; regressa à posição inicial sem cair desorganizado.
  - Repete durante 30 a 60 segundos mantendo precisão; aumenta ritmo só se a técnica continuar limpa.
  - Pára com dor no pescoço, ombro, joelho ou tontura.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E268 — Mobilidade de ombro para Jiu-Jitsu

- Chave estável: `mobilidade_de_ombro_para_jiu_jitsu__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Tatami / espaço de artes marciais
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Mobilidade de ombros orientada às pegas e ao trabalho de solo do Jiu-Jitsu. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- Execução (7 passos):
  - Começa no tatami ou numa superfície segura, com espaço à volta.
  - Encadeia círculos de braços, mãos atrás das costas como nas pegas e rotações suaves dos ombros.
  - Define o objetivo técnico e a posição inicial: guarda, ponte, fuga de anca, base ou passagem.
  - Move primeiro devagar, usando anca, core e apoios das mãos ou pés.
  - Mantém queixo protegido, pescoço longo e respiração controlada; regressa à posição inicial sem cair desorganizado.
  - Repete durante 30 a 60 segundos mantendo precisão; aumenta ritmo só se a técnica continuar limpa.
  - Pára com dor no pescoço, ombro, joelho ou tontura.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E269 — Força de pega para Jiu-Jitsu

- Chave estável: `forca_de_pega_para_jiu_jitsu__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Tatami / espaço de artes marciais
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (139 chars): Trabalho de pega aplicado a kimono, punhos ou controlo de grappling. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- Execução (7 passos):
  - Começa no tatami ou numa superfície segura, com espaço à volta.
  - Aperta uma toalha ou o teu próprio punho em pegas fortes de 5 a 10 segundos enquanto te moves no solo.
  - Define o objetivo técnico e a posição inicial: guarda, ponte, fuga de anca, base ou passagem.
  - Move primeiro devagar, usando anca, core e apoios das mãos ou pés.
  - Mantém queixo protegido, pescoço longo e respiração controlada; regressa à posição inicial sem cair desorganizado.
  - Repete durante 30 a 60 segundos mantendo precisão; aumenta ritmo só se a técnica continuar limpa.
  - Pára com dor no pescoço, ombro, joelho ou tontura.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E270 — Core para Jiu-Jitsu

- Chave estável: `core_para_jiu_jitsu__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Tatami / espaço de artes marciais
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (143 chars): Drill de core no solo para proteger coluna e transferir força pela anca. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- Execução (7 passos):
  - Começa no tatami ou numa superfície segura, com espaço à volta.
  - Liga pontes, posições de hollow e rotações de tronco no chão, mantendo o queixo protegido.
  - Define o objetivo técnico e a posição inicial: guarda, ponte, fuga de anca, base ou passagem.
  - Move primeiro devagar, usando anca, core e apoios das mãos ou pés.
  - Mantém queixo protegido, pescoço longo e respiração controlada; regressa à posição inicial sem cair desorganizado.
  - Repete durante 30 a 60 segundos mantendo precisão; aumenta ritmo só se a técnica continuar limpa.
  - Pára com dor no pescoço, ombro, joelho ou tontura.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E271 — Condicionamento leve para Jiu-Jitsu

- Chave estável: `condicionamento_leve_para_jiu_jitsu__jiu_jitsu`
- Grupo principal: Jiu-Jitsu
- Grupos secundários: Core, anca, pescoço, pega, respiração e controlo no solo
- Músculos principais (tags): jiu_jitsu_technical
- Equipamento: Tatami / espaço de artes marciais
- Tipo (FASE 2): artes_marciais
- Origem: seed `SeedData.exercisesByGroup["Jiu-Jitsu"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (154 chars): Circuito leve com movimentos de solo do Jiu-Jitsu, para ganhar fôlego sem parceiro. Serve para treinar movimentação de Jiu-Jitsu, anca e controlo no solo.
- Execução (7 passos):
  - Começa no tatami ou numa superfície segura, com espaço à volta.
  - Define o objetivo técnico e a posição inicial: guarda, ponte, fuga de anca, base ou passagem.
  - Move primeiro devagar, usando anca, core e apoios das mãos ou pés.
  - Mantém queixo protegido, pescoço longo e respiração controlada.
  - Regressa à posição inicial sem cair desorganizado.
  - Repete durante 30 a 60 segundos mantendo precisão; aumenta ritmo só se a técnica continuar limpa.
  - Pára com dor no pescoço, ombro, joelho ou tontura.
- Erros comuns: Acelerar antes de controlar a técnica. | Perder a base ou cruzar os pés de forma insegura. | Prender a respiração. | Torcer joelhos ou ombros sem controlo. | Repetir cansado com má coordenação.
- Versão mais fácil: Executa devagar, sem resistência de parceiro e por partes, regressando à base entre repetições.
- Versão mais difícil: Liga o drill a uma sequência, aumenta a velocidade ou adiciona resistência progressiva de um parceiro treinado.
- Segurança: Treina em piso seguro e aumenta velocidade só depois de controlar a técnica. Para com dor articular, impacto na cabeça, tontura ou instabilidade.

### E272 — Mobilidade torácica

- Chave estável: `mobilidade_toracica__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (135 chars): Mobilização suave da coluna torácica com rotações e extensões controladas. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca-te na posição indicada, com coluna confortável e respiração calma.
  - Sentado ou em quatro apoios, roda a parte alta das costas de um lado para o outro devagar.
  - Organiza ombros afastados das orelhas antes de mexer.
  - Move braços, escápulas ou coluna torácica devagar até amplitude confortável.
  - Não forces a frente do ombro nem a lombar.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas.
  - Regressa devagar à posição inicial; pára se houver dor aguda ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E273 — Mobilidade de ombro

- Chave estável: `mobilidade_de_ombro__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (158 chars): Movimentos ativos do braço e da escápula em várias direções, para ganhar amplitude útil no ombro. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca-te na posição indicada, com coluna confortável e respiração calma.
  - Organiza ombros afastados das orelhas antes de mexer.
  - Move braços, escápulas ou coluna torácica devagar até amplitude confortável.
  - Não forces a frente do ombro nem a lombar.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas.
  - Regressa devagar à posição inicial.
  - Pára se houver dor aguda ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E274 — Mobilidade de anca

- Chave estável: `mobilidade_de_anca__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (137 chars): Movimentos suaves da bacia e da anca para ganhar rotação, flexão e controlo. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Entra numa posição confortável e estável.
  - Explora círculos e báscula da bacia em amplitudes confortáveis, de pé ou em quatro apoios.
  - Identifica a zona que deve alongar ou mexer.
  - Avança devagar até tensão leve e respirável.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições controladas.
  - Não uses balanços rápidos; regressa lentamente à posição inicial.
  - Pára se houver dor aguda, tontura ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E275 — Círculos de ombro

- Chave estável: `circulos_de_ombro__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (149 chars): Círculos lentos e amplos com os ombros para soltar a articulação e aquecer as escápulas. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca-te na posição indicada, com coluna confortável e respiração calma.
  - Desenha círculos lentos e amplos com os ombros, primeiro para trás e depois para a frente.
  - Organiza ombros afastados das orelhas antes de mexer.
  - Move braços, escápulas ou coluna torácica devagar até amplitude confortável.
  - Não forces a frente do ombro nem a lombar.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas.
  - Regressa devagar à posição inicial; pára se houver dor aguda ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E276 — Alongamento posterior do ombro

- Chave estável: `alongamento_posterior_do_ombro__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (145 chars): Cruzar o braço à frente do peito para alongar deltoide posterior e cápsula do ombro. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Fica de pé ou sentado com o tronco direito.
  - Leva um braço esticado à frente do peito, na horizontal, em direção ao ombro contrário.
  - Com a outra mão, puxa suavemente o braço contra o peito, segurando acima do cotovelo.
  - Mantém o ombro do braço alongado baixo, longe da orelha.
  - Segura 20 a 30 segundos, respirando devagar, sentindo a parte de trás do ombro.
  - Solta devagar e troca de lado.
  - Não rodes o tronco para aumentar o alcance à força.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E277 — Mobilidade de ombro com toalha

- Chave estável: `mobilidade_de_ombro_com_toalha__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (119 chars): Mobilidade de ombro usando uma toalha esticada entre as mãos como guia de amplitude. Serve para o treinar com controlo.
- Execução (7 passos):
  - Coloca-te na posição indicada, com coluna confortável e respiração calma.
  - Segura uma toalha esticada entre as mãos, bem mais largas que os ombros, como guia.
  - Organiza ombros afastados das orelhas antes de mexer.
  - Move braços, escápulas ou coluna torácica devagar até amplitude confortável.
  - Não forces a frente do ombro nem a lombar.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas.
  - Regressa devagar à posição inicial; pára se houver dor aguda ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E278 — Mobilidade de ombro com cabo de vassoura

- Chave estável: `mobilidade_de_ombro_com_cabo_de_vassoura__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Cabo de vassoura
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (106 chars): Mobilidade de ombro guiada por um bastão leve seguro com as duas mãos, para controlar o arco do movimento.
- Execução (7 passos):
  - Coloca-te na posição indicada, com coluna confortável e respiração calma.
  - Segura o cabo de vassoura com as duas mãos, bem mais afastadas que os ombros, como guia leve.
  - Organiza ombros afastados das orelhas antes de mexer.
  - Move braços, escápulas ou coluna torácica devagar até amplitude confortável.
  - Não forces a frente do ombro nem a lombar.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas.
  - Regressa devagar à posição inicial; pára se houver dor aguda ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E279 — Alongamento peitoral

- Chave estável: `alongamento_peitoral__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (136 chars): Abrir o braço e rodar o tronco para sentir tensão suave na frente do peito. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca-te na posição indicada, com coluna confortável e respiração calma.
  - Abre o braço para o lado à altura do ombro e roda o tronco para o lado contrário.
  - Organiza ombros afastados das orelhas antes de mexer.
  - Move braços, escápulas ou coluna torácica devagar até amplitude confortável.
  - Não forces a frente do ombro nem a lombar.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas.
  - Regressa devagar à posição inicial; pára se houver dor aguda ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E280 — Alongamento peitoral na parede

- Chave estável: `alongamento_peitoral_na_parede__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (138 chars): Apoiar um antebraço na parede e rodar o tronco para abrir o peito desse lado. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca-te na posição indicada, com coluna confortável e respiração calma.
  - Apoia o antebraço na parede com o cotovelo à altura do ombro e roda o tronco para o lado contrário.
  - Organiza ombros afastados das orelhas antes de mexer.
  - Move braços, escápulas ou coluna torácica devagar até amplitude confortável.
  - Não forces a frente do ombro nem a lombar.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas.
  - Regressa devagar à posição inicial; pára se houver dor aguda ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E281 — Alongamento peitoral no canto

- Chave estável: `alongamento_peitoral_no_canto__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (133 chars): Usar o canto da parede para abrir os dois lados do peito ao mesmo tempo. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca-te na posição indicada, com coluna confortável e respiração calma.
  - Coloca um antebraço em cada parede do canto e deixa o peito avançar devagar.
  - Organiza ombros afastados das orelhas antes de mexer.
  - Move braços, escápulas ou coluna torácica devagar até amplitude confortável.
  - Não forces a frente do ombro nem a lombar.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas.
  - Regressa devagar à posição inicial; pára se houver dor aguda ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E282 — Alongamento dorsal

- Chave estável: `alongamento_dorsal__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Afastar braços e tronco para alongar dorsal e zona lateral das costas. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca-te na posição indicada, com coluna confortável e respiração calma.
  - Agarra um apoio à frente, deixa a anca recuar e o tronco descer entre os braços.
  - Organiza ombros afastados das orelhas antes de mexer.
  - Move braços, escápulas ou coluna torácica devagar até amplitude confortável.
  - Não forces a frente do ombro nem a lombar.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas.
  - Regressa devagar à posição inicial; pára se houver dor aguda ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E283 — Rotação torácica no chão

- Chave estável: `rotacao_toracica_no_chao__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (156 chars): Rotação do tronco deitado de lado, abrindo o braço de cima em arco enquanto a anca fica quieta. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (6 passos):
  - Deita-te de lado com os joelhos dobrados a 90 graus e os braços esticados à frente, mãos juntas.
  - Mantém os joelhos colados um ao outro e no chão durante todo o movimento.
  - Abre o braço de cima em arco por cima do corpo, rodando o tronco para o outro lado.
  - Segue a mão com o olhar, expira ao abrir e deixa o peito abrir para o teto.
  - Vai só até onde os joelhos ficam quietos e não há dor.
  - Regressa pelo mesmo arco devagar e repete 6 a 8 vezes antes de trocar de lado.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E284 — Cat-cow

- Chave estável: `cat_cow__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (150 chars): Alternância em quatro apoios entre arquear e arredondar a coluna, ao ritmo da respiração. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca-te em quatro apoios, com os punhos por baixo dos ombros e os joelhos por baixo da anca.
  - Ao inspirar, deixa a barriga descer, abre o peito e olha ligeiramente para cima.
  - Ao expirar, empurra o chão, arredonda as costas para o teto e deixa a cabeça descair.
  - Alterna entre as duas posições devagar, ao ritmo da respiração.
  - Move a coluna toda, do fundo das costas ao pescoço, sem forçar nenhum ponto.
  - Faz 6 a 10 ciclos completos.
  - Para se sentires dor aguda em algum segmento da coluna.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E285 — Open book

- Chave estável: `open_book__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (154 chars): Rotação torácica deitado de lado com joelhos dobrados, abrindo o braço de cima como um livro. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Deita-te de lado com os joelhos dobrados à frente da anca e os braços esticados à frente, mãos juntas.
  - Mantém os joelhos no chão, um em cima do outro, durante todo o exercício.
  - Abre o braço de cima como a capa de um livro, rodando o tronco para trás.
  - Segue a mão com o olhar até onde for confortável.
  - Segura dois a três segundos na posição aberta, respirando devagar.
  - Fecha o livro devagar, voltando a juntar as mãos.
  - Faz 6 a 8 repetições e troca de lado.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E286 — Alongamento posterior de coxa

- Chave estável: `alongamento_posterior_de_coxa__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (128 chars): Alongamento estático focado na parte de trás da coxa, sem balanços. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Senta-te ou fica de pé conforme a variação.
  - Mantém joelhos esticados mas não bloqueados com força.
  - Inclina o tronco pela anca, não enrolando a lombar em excesso.
  - Leva as mãos em direção aos pés apenas até tensão confortável atrás da coxa.
  - Respira devagar durante 20 a 40 segundos.
  - Sai da posição lentamente; repete sem balanços.
  - Dobra ligeiramente joelhos se houver dor ou puxão forte.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E287 — Alongamento posterior sentado

- Chave estável: `alongamento_posterior_sentado__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (142 chars): Sentar com pernas estendidas e inclinar pela anca para alongar posterior de coxa. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Senta-te ou fica de pé conforme a variação.
  - Senta-te com as pernas estendidas e inclina o tronco pela anca em direção aos pés.
  - Mantém joelhos esticados mas não bloqueados com força.
  - Inclina o tronco pela anca, não enrolando a lombar em excesso.
  - Leva as mãos em direção aos pés apenas até tensão confortável atrás da coxa.
  - Respira devagar durante 20 a 40 segundos; sai da posição lentamente; repete sem balanços.
  - Dobra ligeiramente joelhos se houver dor ou puxão forte.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E288 — Alongamento posterior em pé

- Chave estável: `alongamento_posterior_em_pe__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (137 chars): Ficar de pé e inclinar o tronco pela anca até sentir tensão atrás das coxas. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Senta-te ou fica de pé conforme a variação.
  - De pé, dobra pela anca com os joelhos quase esticados e deixa as mãos descer pelas pernas.
  - Mantém joelhos esticados mas não bloqueados com força.
  - Inclina o tronco pela anca, não enrolando a lombar em excesso.
  - Leva as mãos em direção aos pés apenas até tensão confortável atrás da coxa.
  - Respira devagar durante 20 a 40 segundos; sai da posição lentamente; repete sem balanços.
  - Dobra ligeiramente joelhos se houver dor ou puxão forte.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E289 — Tocar nos pés sentado

- Chave estável: `tocar_nos_pes_sentado__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (142 chars): Inclinação sentada em direção aos pés para alongar posterior de coxa sem balanço. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Senta-te ou fica de pé conforme a variação.
  - Sentado com as pernas esticadas, desliza as mãos pelas pernas em direção aos pés.
  - Mantém joelhos esticados mas não bloqueados com força.
  - Inclina o tronco pela anca, não enrolando a lombar em excesso.
  - Leva as mãos em direção aos pés apenas até tensão confortável atrás da coxa.
  - Respira devagar durante 20 a 40 segundos; sai da posição lentamente; repete sem balanços.
  - Dobra ligeiramente joelhos se houver dor ou puxão forte.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E290 — Tocar nos pés em pé

- Chave estável: `tocar_nos_pes_em_pe__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Inclinação em pé para aproximar mãos dos pés mantendo tensão leve na cadeia posterior. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Senta-te ou fica de pé conforme a variação.
  - De pé, deixa o tronco descer devagar em direção aos pés, dobrando pela anca.
  - Mantém joelhos esticados mas não bloqueados com força.
  - Inclina o tronco pela anca, não enrolando a lombar em excesso.
  - Leva as mãos em direção aos pés apenas até tensão confortável atrás da coxa.
  - Respira devagar durante 20 a 40 segundos; sai da posição lentamente; repete sem balanços.
  - Dobra ligeiramente joelhos se houver dor ou puxão forte.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E291 — Alongamento posterior com perna elevada

- Chave estável: `alongamento_posterior_com_perna_elevada__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Colocar uma perna num apoio e inclinar pela anca para alongar a parte de trás da coxa. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Senta-te ou fica de pé conforme a variação.
  - Coloca o calcanhar num apoio à altura da anca ou abaixo e inclina o tronco pela anca.
  - Mantém joelhos esticados mas não bloqueados com força.
  - Inclina o tronco pela anca, não enrolando a lombar em excesso.
  - Leva as mãos em direção aos pés apenas até tensão confortável atrás da coxa.
  - Respira devagar durante 20 a 40 segundos; sai da posição lentamente; repete sem balanços.
  - Dobra ligeiramente joelhos se houver dor ou puxão forte.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E292 — Mobilidade dinâmica de posterior

- Chave estável: `mobilidade_dinamica_de_posterior__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: posterior de coxa, gémeos, anca e cadeia posterior
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Movimentos ativos de alongar e voltar para preparar posterior de coxa antes do treino. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Senta-te ou fica de pé conforme a variação.
  - Alterna entre alongar e voltar, em movimentos lentos e contínuos, sem manter a posição.
  - Mantém joelhos esticados mas não bloqueados com força.
  - Inclina o tronco pela anca, não enrolando a lombar em excesso.
  - Leva as mãos em direção aos pés apenas até tensão confortável atrás da coxa.
  - Respira devagar durante 20 a 40 segundos; sai da posição lentamente; repete sem balanços.
  - Dobra ligeiramente joelhos se houver dor ou puxão forte.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E293 — Alongamento glúteos

- Chave estável: `alongamento_gluteos__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: anca, piriforme, rotadores externos da anca e lombar
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (152 chars): Alongamento do glúteo deitado, puxando um joelho na direção do peito ou do ombro contrário. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca a perna na posição indicada pela variação, com a anca apoiada e estável.
  - Deitado de costas, puxa um joelho na direção do ombro contrário até sentir o glúteo.
  - Mantém coluna longa e mãos no chão ou na perna para equilíbrio.
  - Inclina o tronco ligeiramente até sentir tensão no glúteo ou piriforme.
  - Não forces o joelho para baixo com violência; mantém 20 a 40 segundos respirando devagar.
  - Sai da posição com as mãos a ajudar; troca de lado.
  - Pára se houver dor no joelho ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E294 — Alongamento de glúteo sentado

- Chave estável: `alongamento_de_gluteo_sentado__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: anca, piriforme, rotadores externos da anca e lombar
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (154 chars): Alongamento do glúteo sentado numa cadeira, com o tornozelo cruzado sobre o joelho contrário. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca a perna na posição indicada pela variação, com a anca apoiada e estável.
  - Sentado numa cadeira, cruza o tornozelo sobre o joelho contrário e inclina o tronco à frente.
  - Mantém coluna longa e mãos no chão ou na perna para equilíbrio.
  - Inclina o tronco ligeiramente até sentir tensão no glúteo ou piriforme.
  - Não forces o joelho para baixo com violência; mantém 20 a 40 segundos respirando devagar.
  - Sai da posição com as mãos a ajudar; troca de lado.
  - Pára se houver dor no joelho ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E295 — Alongamento figura 4

- Chave estável: `alongamento_figura_4__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: anca, piriforme, rotadores externos da anca e lombar
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Alongamento de glúteo com uma perna cruzada em quatro para libertar rotadores da anca. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca a perna na posição indicada pela variação, com a anca apoiada e estável.
  - Deitado de costas, cruza um tornozelo sobre o joelho contrário e puxa essa coxa ao peito.
  - Mantém coluna longa e mãos no chão ou na perna para equilíbrio.
  - Inclina o tronco ligeiramente até sentir tensão no glúteo ou piriforme.
  - Não forces o joelho para baixo com violência; mantém 20 a 40 segundos respirando devagar.
  - Sai da posição com as mãos a ajudar; troca de lado.
  - Pára se houver dor no joelho ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E296 — Pigeon stretch

- Chave estável: `pigeon_stretch__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: anca, piriforme, rotadores externos da anca e lombar
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (132 chars): Posição no chão com uma perna à frente para alongar glúteo e piriforme. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca a perna na posição indicada pela variação, com a anca apoiada e estável.
  - Leva uma perna dobrada à frente no chão e estica a outra para trás, com a anca nivelada.
  - Mantém coluna longa e mãos no chão ou na perna para equilíbrio.
  - Inclina o tronco ligeiramente até sentir tensão no glúteo ou piriforme.
  - Não forces o joelho para baixo com violência; mantém 20 a 40 segundos respirando devagar.
  - Sai da posição com as mãos a ajudar; troca de lado.
  - Pára se houver dor no joelho ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E297 — Alongamento piriforme

- Chave estável: `alongamento_piriforme__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: anca, piriforme, rotadores externos da anca e lombar
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (150 chars): Alongamento profundo do piriforme deitado, cruzando uma perna e puxando a coxa contrária. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca a perna na posição indicada pela variação, com a anca apoiada e estável.
  - Deitado de costas, cruza uma perna sobre a outra e puxa a coxa de baixo ao peito.
  - Mantém coluna longa e mãos no chão ou na perna para equilíbrio.
  - Inclina o tronco ligeiramente até sentir tensão no glúteo ou piriforme.
  - Não forces o joelho para baixo com violência; mantém 20 a 40 segundos respirando devagar.
  - Sai da posição com as mãos a ajudar; troca de lado.
  - Pára se houver dor no joelho ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E298 — Rotação externa da anca no chão

- Chave estável: `rotacao_externa_da_anca_no_chao__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: Trapézio, serrátil anterior, manguito rotador e core
- Músculos principais (tags): 
- Equipamento: Elásticos
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (158 chars): Alongamento no chão que roda a anca para fora, abrindo o joelho para o lado para soltar os rotadores. Serve para treinar ombros e estabilizadores escapulares.
- Execução (7 passos):
  - Entra numa posição confortável e estável.
  - Sentado ou deitado, deixa o joelho abrir para o lado com a planta do pé apoiada.
  - Identifica a zona que deve alongar ou mexer.
  - Avança devagar até tensão leve e respirável.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições controladas.
  - Não uses balanços rápidos; regressa lentamente à posição inicial.
  - Pára se houver dor aguda, tontura ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E299 — Mobilidade 90/90

- Chave estável: `mobilidade_90_90__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: anca, piriforme, rotadores externos da anca e lombar
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (130 chars): Troca controlada entre rotações de anca com joelhos dobrados no chão. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca a perna na posição indicada pela variação, com a anca apoiada e estável.
  - Senta-te com uma perna dobrada à frente e outra dobrada para trás, ambas perto de 90 graus.
  - Mantém coluna longa e mãos no chão ou na perna para equilíbrio.
  - Inclina o tronco ligeiramente até sentir tensão no glúteo ou piriforme.
  - Não forces o joelho para baixo com violência; mantém 20 a 40 segundos respirando devagar.
  - Sai da posição com as mãos a ajudar; troca de lado.
  - Pára se houver dor no joelho ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E300 — Mobilidade dinâmica de anca

- Chave estável: `mobilidade_dinamica_de_anca__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (141 chars): Sequência ativa de anca com mudanças de posição para preparar treino ou corrida. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Entra numa posição confortável e estável.
  - Encadeia movimentos lentos de anca, trocando de posição sem manter alongamentos parados.
  - Identifica a zona que deve alongar ou mexer.
  - Avança devagar até tensão leve e respirável.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições controladas.
  - Não uses balanços rápidos; regressa lentamente à posição inicial.
  - Pára se houver dor aguda, tontura ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E301 — Alongamento quadríceps em pé

- Chave estável: `alongamento_quadriceps_em_pe__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (154 chars): Alongamento da frente da coxa em pé, levando o calcanhar ao glúteo com apoio para equilibrar. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Fica de pé com apoio ou deita-te de lado conforme a variação.
  - De pé com apoio de uma mão, leva o calcanhar ao glúteo e segura o pé.
  - Dobra o joelho e leva o calcanhar na direção do glúteo.
  - Segura o pé ou tornozelo sem torcer o joelho.
  - Mantém joelhos próximos e bacia ligeiramente encaixada.
  - Sente alongamento na frente da coxa durante 20 a 40 segundos.
  - Solta o pé com cuidado e troca de lado; não forces se houver dor no joelho.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E302 — Alongamento quadríceps de lado

- Chave estável: `alongamento_quadriceps_de_lado__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (146 chars): Alongamento da frente da coxa deitado de lado, segurando o pé de cima atrás do corpo. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Fica de pé com apoio ou deita-te de lado conforme a variação.
  - Deitado de lado, segura o pé de cima atrás do corpo e empurra a anca à frente.
  - Dobra o joelho e leva o calcanhar na direção do glúteo.
  - Segura o pé ou tornozelo sem torcer o joelho.
  - Mantém joelhos próximos e bacia ligeiramente encaixada.
  - Sente alongamento na frente da coxa durante 20 a 40 segundos.
  - Solta o pé com cuidado e troca de lado; não forces se houver dor no joelho.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E303 — Alongamento gémeos

- Chave estável: `alongamento_gemeos__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (139 chars): Alongamento estático da barriga da perna, com a perna de trás esticada e o calcanhar no chão. Serve para treinar gémeos, sóleo e tornozelo.
- Execução (7 passos):
  - Coloca o pé no chão ou contra a parede conforme a variação.
  - Dá um passo atrás, mantém essa perna esticada com o calcanhar no chão e avança o corpo.
  - Mantém o calcanhar apoiado quando o objetivo for gémeos ou tornozelo.
  - Leva o joelho ou o tronco devagar até sentir tensão confortável.
  - Não deixes o arco do pé colapsar para dentro.
  - Mantém 20 a 40 segundos ou faz repetições lentas; troca de lado.
  - Pára se houver dor no tendão de Aquiles ou tornozelo.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E304 — Alongamento gémeos na parede

- Chave estável: `alongamento_gemeos_na_parede__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: Tornozelo, pé, equilíbrio e controlo do joelho
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (115 chars): Alongamento dos gémeos com as mãos na parede e a ponta do pé apoiada contra ela. Serve para o treinar com controlo.
- Execução (7 passos):
  - Coloca o pé no chão ou contra a parede conforme a variação.
  - Apoia a ponta do pé na parede com o calcanhar no chão e aproxima o corpo da parede.
  - Mantém o calcanhar apoiado quando o objetivo for gémeos ou tornozelo.
  - Leva o joelho ou o tronco devagar até sentir tensão confortável.
  - Não deixes o arco do pé colapsar para dentro.
  - Mantém 20 a 40 segundos ou faz repetições lentas; troca de lado.
  - Pára se houver dor no tendão de Aquiles ou tornozelo.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E305 — Mobilidade de tornozelo na parede

- Chave estável: `mobilidade_de_tornozelo_na_parede__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: gémeos, sóleo, pé e equilíbrio
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (147 chars): Avanço do joelho em direção à parede com o calcanhar no chão, para ganhar dorsiflexão. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Fica de frente para uma parede com um pé a alguns centímetros dela.
  - Mantém o calcanhar desse pé totalmente apoiado no chão.
  - Leva o joelho devagar na direção da parede, alinhado com o segundo ou terceiro dedo do pé.
  - Para quando o calcanhar quiser levantar ou o arco do pé colapsar.
  - Volta o joelho para trás, mantendo a respiração calma, e repete 8 a 12 vezes.
  - Afasta ou aproxima o pé da parede para ajustar a dificuldade.
  - Pára se houver dor no tendão de Aquiles, tornozelo ou frente do pé.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E306 — Círculos de tornozelo

- Chave estável: `circulos_de_tornozelo__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: gémeos, sóleo, pé e equilíbrio
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (141 chars): Círculos lentos com a ponta do pé em ambas as direções, para soltar o tornozelo. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Senta-te ou fica de pé com apoio e tira ligeiramente um pé do chão.
  - Mantém a perna quieta e a respiração calma: o movimento vem só do tornozelo.
  - Desenha círculos lentos com a ponta do pé, primeiro para dentro e depois para fora.
  - Faz 6 a 10 círculos por direção.
  - Mantém os dedos relaxados, sem enrolar o pé.
  - Troca de lado e repete.
  - Reduz o tamanho do círculo se houver dor ou estalidos desconfortáveis.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E307 — Mobilidade de punhos

- Chave estável: `mobilidade_de_punhos__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: antebraço, dedos e cotovelo
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (149 chars): Sequência suave de flexão, extensão e círculos dos punhos, útil antes de apoiar as mãos. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Apoia mãos no chão ou à frente do corpo conforme a variação.
  - Faz círculos lentos, flexão e extensão dos punhos, alternando as direções.
  - Mantém cotovelos esticados sem bloquear com força.
  - Inclina o peso devagar até sentir tensão no antebraço ou punho.
  - Não forces se houver dor pontiaguda.
  - Mantém 15 a 30 segundos ou faz pequenas oscilações lentas.
  - Sai da posição devagar; abana as mãos levemente no fim.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E308 — Extensão de punhos no chão

- Chave estável: `extensao_de_punhos_no_chao__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: antebraço, dedos e cotovelo
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (144 chars): Mobilização dos punhos em extensão, com as palmas no chão e os dedos para a frente. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Apoia mãos no chão ou à frente do corpo conforme a variação.
  - Apoia as palmas no chão com os dedos virados para a frente e inclina o peso devagar.
  - Mantém cotovelos esticados sem bloquear com força.
  - Inclina o peso devagar até sentir tensão no antebraço ou punho.
  - Não forces se houver dor pontiaguda.
  - Mantém 15 a 30 segundos ou faz pequenas oscilações lentas.
  - Sai da posição devagar; abana as mãos levemente no fim.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E309 — Flexão de punhos no chão

- Chave estável: `flexao_de_punhos_no_chao__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: Tríceps, deltoide anterior, serrátil anterior e core
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (118 chars): Mobilização dos punhos em flexão, com as costas das mãos apoiadas no chão. Serve para treinar peito, ombros e tríceps.
- Execução (7 passos):
  - Apoia mãos no chão ou à frente do corpo conforme a variação.
  - Apoia as costas das mãos no chão com os dedos virados para ti e inclina o peso devagar.
  - Mantém cotovelos esticados sem bloquear com força.
  - Inclina o peso devagar até sentir tensão no antebraço ou punho.
  - Não forces se houver dor pontiaguda.
  - Mantém 15 a 30 segundos ou faz pequenas oscilações lentas.
  - Sai da posição devagar; abana as mãos levemente no fim.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E310 — Alongamento cervical leve

- Chave estável: `alongamento_cervical_leve__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: trapézio superior, estabilizadores cervicais e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): alongamento
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (142 chars): Movimento cervical suave para ganhar controlo sem forçar articulações do pescoço. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Senta-te ou fica de pé com coluna alta e ombros relaxados.
  - Mantém o olhar em frente e o maxilar solto.
  - Move a cabeça devagar na direção indicada pelo exercício, sem puxões.
  - Pára numa tensão leve, nunca em dor.
  - Mantém 15 a 30 segundos ou faz 5 a 8 repetições lentas.
  - Regressa ao centro antes de trocar de lado.
  - Termina se houver tontura, formigueiro ou dor a irradiar.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Usa força muito leve. Para imediatamente com tontura, formigueiro, dor irradiada, pressão na cabeça, visão turva ou dor aguda no pescoço.

### E311 — Mobilidade leve de ombros

- Chave estável: `mobilidade_leve_de_ombros__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: escápulas, coluna torácica, peitoral, dorsal e respiração
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (132 chars): Movimentos fáceis de ombros para recuperar amplitude sem carga nem dor. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Coloca-te na posição indicada, com coluna confortável e respiração calma.
  - Usa amplitudes pequenas e confortáveis, sem procurar o limite do alcance.
  - Organiza ombros afastados das orelhas antes de mexer.
  - Move braços, escápulas ou coluna torácica devagar até amplitude confortável.
  - Não forces a frente do ombro nem a lombar.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições lentas.
  - Regressa devagar à posição inicial; pára se houver dor aguda ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E312 — Mobilidade leve de anca

- Chave estável: `mobilidade_leve_de_anca__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (142 chars): Movimentos fáceis da anca em amplitudes pequenas, para dias leves ou recuperação. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Entra numa posição confortável e estável.
  - Usa amplitudes pequenas e confortáveis da anca, sem forçar o alcance.
  - Identifica a zona que deve alongar ou mexer.
  - Avança devagar até tensão leve e respirável.
  - Mantém 15 a 40 segundos ou faz 6 a 10 repetições controladas.
  - Não uses balanços rápidos; regressa lentamente à posição inicial.
  - Pára se houver dor aguda, tontura ou formigueiro.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E313 — Respiração diafragmática

- Chave estável: `respiracao_diafragmatica__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Respiração lenta pelo diafragma para reduzir tensão e recuperar ritmo. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Deita-te de costas com os joelhos dobrados, ou senta-te com as costas apoiadas.
  - Pousa uma mão no peito e a outra na barriga.
  - Inspira devagar pelo nariz, deixando a barriga empurrar a mão para cima; o peito quase não mexe.
  - Expira lentamente pela boca, deixando a barriga descer, mais tempo a expirar do que a inspirar.
  - Mantém os ombros e o maxilar relaxados.
  - Repete durante 1 a 3 minutos, a um ritmo calmo.
  - Se sentires tontura, volta ao teu ritmo natural de respiração.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E314 — Caminhada leve

- Chave estável: `caminhada_leve__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (113 chars): Caminhada fácil para circulação e recuperação ativa. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (6 passos):
  - Escolhe um percurso plano e seguro e começa a caminhar devagar.
  - Caminha a um ritmo tranquilo, em que consegues conversar sem esforço.
  - Mantém o tronco alto, a respiração tranquila e os braços a balançar naturalmente.
  - Pousa o pé do calcanhar para a ponta, com passos confortáveis.
  - Continua durante 10 a 30 minutos, conforme a energia do dia.
  - Termina de forma gradual, abrandando nos últimos minutos.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

### E315 — Relaxamento deitado

- Chave estável: `relaxamento_deitado__mobilidade`
- Grupo principal: Mobilidade
- Grupos secundários: respiração, postura, controlo articular e consciência corporal
- Músculos principais (tags): 
- Equipamento: Peso corporal
- Tipo (FASE 2): mobilidade
- Origem: seed `SeedData.exercisesByGroup["Mobilidade"]` → `ExerciseCatalogContextService._entrySpecificDetails`
- Objetivo/descrição (131 chars): Posição de descanso no chão para baixar tensão e controlar respiração. Serve para treinar mobilidade da zona indicada e respiração.
- Execução (7 passos):
  - Deita-te de costas num tapete, com as pernas estendidas ou os joelhos apoiados numa almofada.
  - Deixa os braços descansar ao lado do corpo, com as palmas para cima.
  - Fecha os olhos e respira devagar pelo nariz.
  - Percorre o corpo mentalmente, relaxando maxilar, ombros, mãos, barriga e pernas.
  - Fica na posição 2 a 5 minutos, sem pressa.
  - Para sair, rola para o lado e levanta-te devagar.
  - Usa esta posição no fim do treino ou em dias de recuperação.
- Erros comuns: Forçar até à dor em vez de tensão leve. | Fazer balanços rápidos. | Prender a respiração. | Compensar com a lombar ou com os ombros. | Sair da posição de repente.
- Versão mais fácil: Reduz a amplitude e usa parede, banco ou chão como apoio até conseguires respirar sem dor.
- Versão mais difícil: Amplia gradualmente a amplitude ou acrescenta controlo ativo no fim do alcance, sempre sem dor articular.
- Segurança: Procura tensão leve e respirável. Para se a sensação virar dor aguda, dormência, formigueiro, cãibra forte, pressão articular ou instabilidade.

