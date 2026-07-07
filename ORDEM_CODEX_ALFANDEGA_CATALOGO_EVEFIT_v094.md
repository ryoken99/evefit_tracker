# ORDEM CODEX
# Alfândega permanente de qualidade dos catálogos EveFit
# QA geral, passadeira, descrições, inventário completo e versão testável

## Contexto

Estamos a testar a versão 0.9.3 da EveFit.

Foram encontrados dois problemas reais no dispositivo:

1. O treino `Cardio - Passadeira - Resistência aeróbia` não mostra exercícios.
2. O exercício `Adductor squeeze leve` tem descrição genérica, músculos errados e mistura tokens técnicos/inglês.

Estes problemas mostram que não basta corrigir casos isolados. É preciso criar uma alfândega permanente de qualidade do catálogo.

A partir de agora, qualquer exercício novo ou alterado deve passar por validação automática. Se não cumprir os padrões, `flutter test` ou o comando de auditoria devem falhar.

Trabalhar na branch:

`catalog-rebuild-v092`

Não mexer em `main`.
Não fazer merge.
Não incluir APKs no git.
Não incluir `build/`, `.apk`, `.sha1`, `.codex-remote-attachments/` ou Flutter SDK.

---

## Objetivo final

Criar um sistema permanente de auditoria que garanta que:

1. todos os exercícios aparecem nos filtros corretos
2. nenhum exercício fica escondido por erro
3. todos os exercícios têm músculos reais
4. todos os exercícios têm equipamento e local corretos
5. todas as descrições são úteis para iniciantes absolutos
6. nenhuma execução é genérica
7. não existem tokens técnicos soltos
8. não existem nomes internos colados no texto
9. os cenários principais da app nunca retornam zero exercícios por erro
10. existe um inventário completo dos exercícios atualmente na app
11. conseguimos ver se há lacunas e decidir se o catálogo está completo o suficiente
12. a versão de teste seguinte fica pronta para instalar

---

# PARTE 1
# Definir a alfândega permanente

## Criar documento oficial dos padrões

Criar:

`docs/catalog_quality_standard.md`

Este documento deve definir o contrato de qualidade.

Cada exercício deve ter, no mínimo:

- `canonical_id`
- `catalog_entry_key`
- `exercise_key`
- `context_key`
- `name`
- `aliases`
- `primary_type`
- `secondary_types`
- `contexts`
- `filters`
- `exclusions`
- músculos principais reais
- músculos secundários, quando aplicável
- articulações, quando aplicável
- equipamento obrigatório
- equipamento opcional
- locais compatíveis
- superfície necessária, quando aplicável
- parceiro necessário, quando aplicável
- descrição curta
- descrição longa
- execução passo a passo
- respiração
- sensações corretas
- sensações erradas
- erros comuns
- correções dos erros
- cuidados
- regressão
- progressão
- quando usar
- quando evitar

## Regras obrigatórias de conteúdo

### Regra 1
Tipo de treino nunca pode ser músculo.

Inválido como músculo:

- Ativacao
- Ativação
- Aquecimento
- Recuperacao
- Recuperação
- Prevencao
- Prevenção
- Cardio
- Mobilidade
- Elasticidade
- Artes marciais
- Sistema cardiovascular, quando usado como músculo
- Corpo inteiro, quando usado como músculo em vez de zona

### Regra 2
Descrições não podem conter tokens técnicos soltos.

Proibir ou marcar como crítico quando aparecer:

- `activation`
- `adductors light`
- `target pattern`
- `referencia tecnica`
- `referência técnica`, quando usado como frase genérica
- `zona trabalhada`
- `trajetoria curta`
- `trajetória curta`, quando usado sem instrução real
- `intensidade conservadora e nivel ajustado`
- `nivel ajustado ao praticante`
- `snake_case`
- `canonical_id`
- aliases colados dentro da descrição
- nomes internos do exercício dentro da frase
- inglês solto no meio de texto português

### Regra 3
Execução tem de ensinar uma pessoa que nunca treinou.

Tem de explicar:

- posição inicial
- onde ficam pés, mãos, joelhos, anca, tronco, ombros, cotovelos, punhos, cabeça e olhar, quando aplicável
- onde colocar o equipamento
- que parte do corpo inicia o movimento
- que parte mexe
- que parte estabiliza
- para onde empurrar ou puxar
- até onde ir
- velocidade ou controlo
- como respirar
- onde sentir esforço
- onde não sentir dor
- erros comuns
- como corrigir os erros
- regressão
- progressão
- quando evitar

### Regra 4
Recuperação não pode ser HIIT, sparring, carga pesada ou treino que aumente fadiga.

### Regra 5
Prevenção não pode prometer evitar lesões.

Proibido:
`previne lesões`

Permitido:
`ajuda a melhorar controlo, tolerância e preparação`

### Regra 6
Quedas, ukemi e impacto no solo exigem tatami ou contexto seguro.

### Regra 7
Sparring e técnicas com parceiro não aparecem em treino solo.

### Regra 8
Equipamento e local têm de ser compatíveis.

---

# PARTE 2
# Exemplo mau e exemplo bom para definir o padrão

## Exemplo de exercício mal explicado

Exercício:
`Adductor squeeze leve`

Exemplo mau:

Descrição:
`Entrada para acordar o padrão alvo com baixa fadiga. Trabalha Ativação de glúteos e anca com referencia tecnica ativacao de gluteos e anca activation adductors light adductor squeeze leve, intensidade conservadora e nivel ajustado ao praticante.`

Como fazer:
1. Escolhe um local seguro para ativacao e confirma que tens bola, almofada ou toalha.
2. Usa ativacao de gluteos e anca com referencia ativacao de gluteos e anca activation adductors light adductor squeeze leve.
3. Leva a zona trabalhada por uma trajetoria curta e controlavel.
4. Regressa à posição inicial com controlo.

Porque falha:

- não diz se é deitado, sentado ou em pé
- não diz onde colocar a bola, almofada ou toalha
- não diz o que apertar
- não diz durante quanto tempo
- não diz onde sentir
- não diz onde não sentir dor
- não ensina respiração
- usa tokens ingleses soltos
- usa texto gerado por template
- usa `Ativacao` como músculo
- não explica regressão nem progressão de forma útil

Este tipo de exercício deve falhar a auditoria em modo strict.

## Exemplo de exercício bem explicado

Exercício:
`Adductor squeeze leve`

Descrição curta:
`Ativação leve dos adutores usando uma bola, almofada ou toalha entre os joelhos para aprender a apertar a parte interna das coxas sem compensar com lombar, anca ou glúteos.`

Descrição longa:
`Este exercício serve para acordar os adutores, os músculos da parte interna das coxas, com baixa fadiga. É útil em aquecimento, ativação ou prevenção leve quando queres melhorar controlo da anca e sentir a contração dos adutores antes de treino de pernas, core, mobilidade de anca ou artes marciais. Deve ser feito com força moderada, sem dor e sem prender a respiração.`

Execução passo a passo:
1. Deita-te de costas no chão ou num tapete confortável.
2. Dobra os joelhos e apoia os pés no chão, mais ou menos à largura da anca.
3. Coloca uma bola pequena, uma almofada dobrada ou uma toalha enrolada entre os joelhos.
4. Mantém a cabeça apoiada, os ombros relaxados e o olhar para cima.
5. Antes de começar, deixa a lombar confortável e mantém a barriga ligeiramente firme sem prender a respiração.
6. Aperta suavemente a bola entre os joelhos, como se quisesses aproximar os joelhos um do outro.
7. Mantém o aperto durante 2 a 5 segundos.
8. Deves sentir trabalho na parte interna das coxas.
9. Não apertes com força máxima. O objetivo é ativar, não cansar.
10. Relaxa devagar sem deixar a bola cair.
11. Repete com controlo, mantendo os pés no chão e a respiração calma.

Respiração:
`Expira suavemente enquanto apertas a bola. Inspira enquanto relaxas. Não prendas a respiração.`

Sensações corretas:
`Contração leve a moderada na parte interna das coxas.`

Sensações erradas:
`Dor aguda na virilha, joelho, anca ou lombar. Cãibra forte ou sensação de pinçamento.`

Erros comuns:

- apertar com força máxima
- prender a respiração
- arquear a lombar
- levantar os pés
- apertar os glúteos com força em vez dos adutores
- deixar a bola cair sem controlo

Correções:

- usa uma almofada mais macia
- reduz a força do aperto
- mantém os pés apoiados
- pensa em aproximar os joelhos sem mexer a bacia
- faz menos repetições se começares a compensar

Regressão:
`Usa uma almofada macia e aperta apenas 1 a 2 segundos.`

Progressão:
`Mantém o aperto por 5 a 8 segundos ou faz o exercício em ponte de glúteo, apenas se conseguires manter a lombar e a anca controladas.`

Quando usar:
`Antes de treino de pernas, mobilidade de anca, core, BJJ, Karate ou como ativação leve dos adutores.`

Quando evitar:
`Evita se houver dor aguda na virilha, joelho, anca ou lombar. Não uses para forçar uma lesão.`

Músculos principais:

- adutores

Músculos secundários:

- core leve
- glúteos, apenas como estabilização se aplicável

Equipamento:

- bola pequena, almofada ou toalha

Local:

- casa sem equipamento
- casa equipada
- ginásio
- dojo/tatami, se usado em aquecimento

Este é o nível mínimo aceitável para exercícios de ativação.

---

# PARTE 3
# Motor de auditoria permanente

Criar ou refatorar:

`tool/catalog_audit_report.dart`

A ferramenta deve ter dois modos.

## Modo relatório

Comando:

`dart run tool/catalog_audit_report.dart`

Gerar:

- `build/reports/catalog_audit.md`
- `build/reports/catalog_audit.json`
- `build/reports/catalog_inventory.csv`

O relatório deve mostrar:

- total de exercícios
- total de entradas de catálogo
- total de canonical IDs únicos
- total por domínio
- problemas críticos
- avisos
- exercícios incompletos
- filtros com zero resultados
- textos suspeitos
- músculos inválidos
- equipamentos inválidos
- locais inválidos
- duplicados suspeitos
- exercícios sem caminho de menu/filtro
- exemplos de correção

## Modo strict

Comando:

`dart run tool/catalog_audit_report.dart --strict`

Este comando deve falhar com exit code diferente de zero se encontrar problemas críticos.

Problemas críticos:

- exercício sem `canonical_id`
- exercício sem `catalog_entry_key`
- exercício sem `primary_type`
- exercício sem contexto
- exercício sem local
- exercício sem equipamento
- exercício sem descrição curta
- exercício sem descrição longa
- exercício sem execução passo a passo
- exercício sem respiração
- exercício sem cuidados
- exercício sem regressão
- exercício sem progressão
- exercício sem quando evitar
- músculo inválido
- equipamento inválido
- local inválido
- texto genérico proibido
- inglês perdido em descrição portuguesa
- filtro principal que retorna zero exercícios sem justificação
- duplicado canónico indevido
- exercício sem nenhum caminho útil de menu/filtro

Problemas de aviso:

- descrição curta demais
- descrição longa pouco específica
- execução com poucos passos
- aliases pobres
- músculos secundários ausentes quando parecem necessários
- articulações ausentes em exercícios onde faz sentido
- texto muito parecido em muitos exercícios
- descrição que não menciona equipamento obrigatório
- descrição que não menciona onde sentir esforço

Cada problema deve indicar:

- severidade
- exercício
- canonical_id
- catalog_entry_key
- domínio
- campo afetado
- mensagem
- sugestão de correção

---

# PARTE 4
# Validadores separados

Criar estrutura reutilizável, por exemplo:

`tool/catalog_quality/`

ou, se fizer mais sentido para testes internos:

`lib/services/catalog_quality/`

Criar validadores separados:

1. `canonical_identity_validator.dart`
Valida IDs, aliases, canonical_id, catalog_entry_key e duplicados.

2. `taxonomy_validator.dart`
Valida primary_type, secondary_types, músculos, articulações, domínios e grupos.

3. `equipment_location_validator.dart`
Valida equipamentos, locais, superfícies, apoios e compatibilidade.

4. `filter_reachability_validator.dart`
Valida se cada exercício aparece em pelo menos um caminho útil de menu/filtro.

5. `content_quality_validator.dart`
Valida descrição, execução, respiração, erros, cuidados, regressão, progressão, quando usar e quando evitar.

6. `safety_validator.dart`
Valida regras de segurança:
- recuperação sem HIIT
- queda sem tatami bloqueada
- ukemi sem tatami bloqueado
- sparring sem parceiro bloqueado
- prevenção sem prometer evitar lesões
- pistola de massagem não como treino principal

7. `language_validator.dart`
Valida:
- português limpo
- sem tokens ingleses soltos
- sem snake_case
- sem aliases colados
- sem nomes internos
- sem template genérico

8. `scenario_matrix_validator.dart`
Valida combinações reais da app.

---

# PARTE 5
# Testes permanentes que falham se o catálogo ficar mau

Criar testes:

## 1. Quality gate geral

`test/catalog/catalog_quality_gate_test.dart`

Deve carregar o catálogo real e correr a auditoria em modo strict.

Falhar o teste se houver problemas críticos.

O erro deve imprimir os primeiros 50 problemas e indicar que o relatório completo está em `build/reports/`.

## 2. Matriz de filtros

`test/catalog/catalog_filter_scenario_matrix_test.dart`

Validar que combinações reais retornam exercícios quando devem retornar.

## 3. Exercícios críticos conhecidos

`test/catalog/catalog_known_exercises_quality_test.dart`

Validar casos importantes:

- `push_up`
- `glute_bridge`
- `technical_stand_up_lento`
- `adductor_squeeze_leve`
- exercícios de passadeira

---

# PARTE 6
# Corrigir e adicionar exercícios de passadeira no cardio

Problema real:
`Cardio - Passadeira - Resistência aeróbia` não retorna exercícios.

A bicicleta retorna exercícios equivalentes, por isso passadeira também deve retornar.

## Investigar

Verificar:

1. `passadeira` normaliza para `treadmill`
2. `treadmill` existe como equipamento
3. `treadmill` está disponível quando o treino é passadeira
4. o treino passa o `locationKey` correto
5. o treino passa `equipmentKey` ou capability correto
6. `context_key` de passadeira está correto
7. `focus` de resistência aeróbia não bloqueia passadeira
8. exercícios de passadeira existem no seed
9. filtro não trata passadeira como local incompatível
10. diferença entre bicicleta e passadeira no filtro

## Exercícios mínimos de passadeira a garantir

Adicionar ou corrigir no catálogo estes exercícios de cardio para passadeira:

### 1. Passadeira aquecimento

canonical_id:
`treadmill_warmup`

Nome:
`Passadeira aquecimento`

primary_type:
`cardio`

secondary_types:
`aquecimento`

Contextos:
- cardio
- passadeira
- aquecimento
- baixa_intensidade

Equipamento obrigatório:
`treadmill`

Locais compatíveis:
- ginasio
- casa_equipada, apenas se passadeira estiver disponível

Descrição:
Caminhada ou corrida muito leve na passadeira para aumentar temperatura, preparar articulações e subir a frequência cardíaca sem cansar.

Execução:
1. Sobe para a passadeira com a máquina parada ou em velocidade muito baixa.
2. Prende a chave de segurança, se existir.
3. Começa a caminhar devagar.
4. Mantém o tronco direito, olhar em frente e ombros relaxados.
5. Não te agarres com força aos apoios.
6. Aumenta a velocidade aos poucos até sentires o corpo mais quente.
7. Mantém respiração confortável.
8. Termina com sensação de prontidão, não de fadiga.

Não deve aparecer em:
recuperação intensa, HIIT, treino pesado.

### 2. Passadeira cooldown

canonical_id:
`treadmill_cooldown`

Nome:
`Passadeira cooldown`

primary_type:
`cardio`

secondary_types:
`recuperacao`

Contextos:
- cardio
- passadeira
- cooldown
- recuperacao_leve

Equipamento obrigatório:
`treadmill`

Descrição:
Caminhada leve na passadeira para baixar gradualmente a intensidade depois do treino.

Execução:
1. Reduz a velocidade até uma caminhada confortável.
2. Mantém passos curtos e respiração calma.
3. Não uses inclinação alta.
4. Caminha até a respiração normalizar.
5. Sai da passadeira apenas depois de reduzir a velocidade.

Não deve aparecer em:
HIIT, treino intenso, resistência forte.

### 3. Passadeira resistência aeróbia

canonical_id:
`treadmill_aerobic_endurance`

Nome:
`Passadeira resistência aeróbia`

primary_type:
`cardio`

secondary_types:
`resistencia`

Contextos:
- cardio
- passadeira
- resistencia_aerobia
- zona_2
- ritmo_moderado

Equipamento obrigatório:
`treadmill`

Descrição:
Trabalho contínuo na passadeira para melhorar resistência aeróbia com intensidade controlada e sustentável.

Execução:
1. Começa com 3 a 5 minutos de aquecimento leve.
2. Ajusta a velocidade para um ritmo que consigas manter sem ficar ofegante demais.
3. Mantém o tronco alto, olhar em frente e braços soltos.
4. Pousa os pés de forma natural, sem bater agressivamente.
5. Respira de forma regular.
6. Mantém o ritmo durante o tempo definido.
7. Reduz a velocidade no fim antes de parar.

Onde sentir:
Sistema cardiovascular, pernas a trabalhar de forma moderada.

Onde não sentir:
Dor aguda no joelho, tornozelo, anca ou lombar.

### 4. Passadeira ritmo leve

canonical_id:
`treadmill_easy_pace`

Nome:
`Passadeira ritmo leve`

primary_type:
`cardio`

secondary_types:
`recuperacao`, `aquecimento`

Contextos:
- cardio
- passadeira
- ritmo_leve
- zona_1
- baixa_intensidade

Descrição:
Caminhada ou trote muito leve na passadeira, usado para recuperação ativa, aquecimento ou dias fáceis.

### 5. Passadeira ritmo moderado

canonical_id:
`treadmill_moderate_pace`

Nome:
`Passadeira ritmo moderado`

primary_type:
`cardio`

secondary_types:
`resistencia`

Contextos:
- cardio
- passadeira
- ritmo_moderado
- zona_2

Descrição:
Ritmo contínuo moderado na passadeira, mais exigente que ritmo leve mas ainda controlado.

### 6. Passadeira intervalos

canonical_id:
`treadmill_intervals`

Nome:
`Passadeira intervalos`

primary_type:
`cardio`

secondary_types:
`intervalado`

Contextos:
- cardio
- passadeira
- intervalos

Descrição:
Alternância entre períodos mais rápidos e períodos leves na passadeira.

Regras:
- aparece em intervalos
- não aparece em recuperação leve
- não aparece como cooldown

### 7. HIIT passadeira

canonical_id:
`treadmill_hiit`

Nome:
`HIIT passadeira`

primary_type:
`cardio`

secondary_types:
`hiit`

Contextos:
- cardio
- passadeira
- hiit
- alta_intensidade

Regras:
- aparece apenas quando o foco é HIIT ou alta intensidade
- nunca aparece em recuperação
- nunca aparece em cooldown
- não aparece em resistência aeróbia leve, salvo se o filtro `mostrar todos` estiver ativo

### 8. Caminhada na passadeira

canonical_id:
`treadmill_walk`

Nome:
`Caminhada na passadeira`

primary_type:
`cardio`

secondary_types:
`aquecimento`, `recuperacao`

Contextos:
- cardio
- passadeira
- caminhada
- baixa_intensidade

### 9. Corrida na passadeira

canonical_id:
`treadmill_run`

Nome:
`Corrida na passadeira`

primary_type:
`cardio`

secondary_types:
`resistencia`

Contextos:
- cardio
- passadeira
- corrida
- ritmo_moderado

### 10. Passadeira caminhada com inclinação

canonical_id:
`treadmill_incline_walk`

Nome:
`Passadeira caminhada com inclinação`

primary_type:
`cardio`

secondary_types:
`resistencia`

Contextos:
- cardio
- passadeira
- caminhada
- inclinacao
- resistencia_aerobia

Regras:
- não aparecer em recuperação leve se inclinação for alta
- explicar que inclinação deve ser progressiva

## Testes de passadeira obrigatórios

Criar testes que confirmem:

1. Cardio + Passadeira + Resistência aeróbia retorna exercícios.
2. Cardio + Passadeira + Aquecimento retorna exercícios.
3. Cardio + Passadeira + Intervalos retorna exercícios.
4. Cardio + Passadeira + Ritmo leve retorna exercícios.
5. Bicicleta continua a funcionar.
6. HIIT passadeira não aparece em recuperação.
7. Passadeira não aparece em casa sem equipamento, salvo passadeira disponível.
8. Passadeira aparece em casa equipada se `treadmill` estiver disponível.
9. Passadeira aparece em ginásio.
10. Todos os exercícios de passadeira têm descrição e execução completas.

---

# PARTE 7
# Inventário completo dos exercícios atualmente na app

Gerar inventário completo de todos os exercícios atuais da app.

Criar ficheiros:

`build/reports/catalog_inventory.md`
`build/reports/catalog_inventory.csv`
`build/reports/catalog_inventory.json`

O inventário deve conter, para cada entrada:

- número
- nome
- canonical_id
- catalog_entry_key
- exercise_key
- context_key
- primary_type
- secondary_types
- contexts
- aliases
- músculos principais
- músculos secundários
- equipamento obrigatório
- equipamento opcional
- locais compatíveis
- filtros
- exclusions
- descrição curta, abreviada
- flags de qualidade
- aparece em que cenários/filtros
- problemas encontrados, se houver

Também gerar resumo por domínio:

- musculação
- cardio
- artes marciais
- mobilidade
- elasticidade
- recuperação
- aquecimento
- ativação
- prevenção

## Gap analysis

Depois do inventário, gerar:

`build/reports/catalog_gap_analysis.md`

Comparar o catálogo atual com os ficheiros 10 a 30 e responder:

1. Que áreas estão bem cobertas.
2. Que áreas estão fracas.
3. Que músculos têm poucos exercícios.
4. Que equipamentos têm poucos exercícios.
5. Que locais têm poucos exercícios.
6. Que modalidades marciais estão pouco cobertas.
7. Que tipos de cardio faltam.
8. Que exercícios essenciais parecem faltar.
9. Que exercícios parecem duplicados.
10. Que exercícios devem ser adicionados agora.
11. Que exercícios podem ficar para uma versão futura.

Obrigatório:
Não adicionar centenas de exercícios sem decisão.
Primeiro corrigir QA e passadeira.
Depois listar sugestões de expansão para revisão humana.

A única adição obrigatória nesta ronda é a correção da passadeira e exercícios essenciais de passadeira que faltam.

---

# PARTE 8
# Corrigir descrições genéricas em todo o catálogo

Depois da auditoria encontrar problemas, corrigir todos os casos críticos.

Procurar especialmente nos domínios:

- ativação
- aquecimento
- prevenção
- recuperação
- mobilidade
- elasticidade
- cardio
- artes marciais

Padrões críticos:

- descrições que só dizem `usa o padrão alvo`
- execuções que só dizem `leva a zona trabalhada`
- frases iguais repetidas em muitos exercícios
- inglês solto
- canonical_id dentro do texto
- aliases colados
- músculos iguais ao tipo de treino
- equipamento mencionado mas sem dizer onde colocar
- cardio sem ritmo, postura ou respiração
- artes marciais sem base, guarda, olhar, distância ou segurança
- mobilidade sem dizer articulação que mexe e parte que estabiliza
- elasticidade sem dizer onde sentir alongamento
- recuperação sem dizer baixa intensidade

Corrigir com conteúdo específico, não apenas trocar palavras.

---

# PARTE 9
# Comando único de QA

Criar script:

`tool/run_quality_gate.ps1`

O script deve correr:

```powershell
flutter pub get
flutter analyze
flutter test -r compact
dart run tool/catalog_audit_report.dart --strict
flutter build apk --debug
flutter build apk --release
```

Se qualquer passo falhar, o script falha.

Atualizar README ou docs com o comando:

```powershell
.\tool\run_quality_gate.ps1
```

---

# PARTE 10
# GitHub Actions

Verificar `.github/workflows/`.

Se não existir, criar:

`.github/workflows/flutter_quality_gate.yml`

O workflow deve correr em PR para main:

- checkout
- setup Flutter
- flutter pub get
- flutter analyze
- flutter test
- dart run tool/catalog_audit_report.dart --strict

Não precisa gerar APK em todos os PRs, salvo se já existir prática no projeto.

Objetivo:
impedir merge de catálogo mau.

---

# PARTE 11
# Guia para adicionar exercício novo

Criar:

`docs/how_to_add_exercise.md`

O guia deve explicar:

1. verificar se já existe canonical_id
2. escolher canonical_id novo só se não houver duplicado
3. definir primary_type
4. definir secondary_types
5. definir contexts
6. definir músculos reais
7. definir articulações
8. definir equipamento e local
9. definir filtros e exclusions
10. escrever descrição curta
11. escrever descrição longa
12. escrever execução passo a passo
13. escrever respiração
14. escrever erros e correções
15. escrever cuidados
16. escrever regressão
17. escrever progressão
18. escrever quando usar
19. escrever quando evitar
20. correr quality gate
21. corrigir antes de commit

Incluir o exemplo completo de `adductor_squeeze_leve` como modelo.

---

# PARTE 12
# Validação final e versão testável

Depois de corrigir tudo:

Correr:

```powershell
flutter pub get
flutter analyze
flutter test -r compact
dart run tool/catalog_audit_report.dart --strict
flutter build apk --debug
flutter build apk --release
```

Se falhar:
corrigir e repetir.

Quando passar:

1. atualizar versão para `0.9.4`
2. atualizar `CHANGELOG.md`
3. fazer commit na branch `catalog-rebuild-v092`
4. criar tag `v0.9.4`
5. push da branch e tag
6. não fazer merge para main
7. gerar APK release e debug
8. não incluir APKs no git

Mensagem sugerida:

`Add permanent catalog quality gate and fix cardio catalogue QA`

---

# Entrega final obrigatória

Reportar:

1. problemas encontrados pela auditoria
2. problemas corrigidos
3. total de exercícios auditados
4. total de exercícios na app
5. lista completa exportada para inventory
6. resumo por domínio
7. exercícios de passadeira adicionados/corrigidos
8. exercícios ainda sugeridos para futura expansão
9. total de problemas críticos restantes
10. total de avisos restantes
11. resultado de `flutter analyze`
12. resultado de `flutter test`
13. resultado de `catalog_audit_report --strict`
14. resultado de build debug
15. resultado de build release
16. commit hash
17. tag
18. localização dos APKs
19. confirmação de que APKs não foram commitados

Regra final:
A auditoria só é útil se falhar quando o catálogo fica mau.

Não quero relatório bonito que deixa passar problemas.

Qualquer exercício novo ou alterado que não cumpra os padrões deve fazer os testes falharem.
