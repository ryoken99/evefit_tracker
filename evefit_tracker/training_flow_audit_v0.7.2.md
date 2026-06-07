# EveFit Tracker v0.7.2 - Auditoria do perfil e fluxo de treinos

## Problemas corrigidos

- O perfil podia ser criado com locais/equipamento, mas a edição posterior não permitia gerir equipamento disponível nem objetivos gerais.
- A lista de locais era curta e descartava locais personalizados na serialização.
- O equipamento do onboarding aparecia como lista única, sem secções.
- Os objetivos gerais do perfil estavam misturados visualmente com a ideia de objetivos mensuráveis.
- A criação de treino ainda oferecia equipamento/modalidades que podiam não existir no perfil.
- O modal "Adicionar exercício" reaproveitava grupos soltos e podia mostrar filtros irrelevantes para Core, Passadeira ou Bíceps.
- Core/Abdominal ficava frágil quando chegava com `groupKey: abdominal`.

## Novo fluxo por tipo de treino

- Musculação continua com equipamento, região corporal, grupo muscular e músculo/foco.
- Cardio agora restringe modalidades a equipamento/local do perfil por `TrainingFlow.availableCardioModes`.
- Artes marciais mantém Karate e Jiu-Jitsu separados.
- Mobilidade usa `Zona/foco`.
- Recuperação usa `Tipo de recuperação`.
- Personalizado mantém nome/foco livre.

## Alterações no perfil editável

- A edição de perfil passa a ter secções para dados pessoais, locais de treino, equipamento disponível, objetivos gerais e PIN.
- Locais de treino suportados: Ginásio, Casa, Exterior, Dojo / Artes marciais, Parque, Hotel / viagem, Trabalho / pausa rápida, Piscina, Fisioterapia / reabilitação e Outro.
- Locais personalizados passam a sobreviver a parse/serialize.

## Alterações em equipamento editável

- Criado `ProfilePreferencesService.equipmentSections`.
- Equipamento organizado por Básico, Pesos livres, Calistenia, Máquinas e cabos, Cardio, Artes marciais, Recuperação e mobilidade.
- A edição de perfil grava disponibilidade por `profile_equipment` usando `AppDatabase.updateProfileEquipment`.
- Peso corporal e nenhum equipamento continuam tratados como base.

## Alterações em objetivos gerais

- Criado catálogo de objetivos gerais por categorias.
- Objetivos gerais continuam guardados no perfil em `initialGoals`, separados dos objetivos mensuráveis da aba Objetivos.
- Criados helpers para adicionar, editar e desativar objetivos gerais no perfil.

## Correções no Core/Abdominal

- `contextualFiltersForSelection` relaxa seleções de Core com `groupKey: abdominal` para não devolver lista vazia.
- Core/Abdominal mantém exercícios de peso corporal como prancha, crunch, hollow hold, Russian twist, Vacuum abdominal e Bird dog.

## Correções nos filtros

- Criado `ExerciseFilterService.contextualFiltersForSelection`.
- Core mostra filtros contextuais como Reto abdominal, Oblíquos, Transverso abdominal, Anti-extensão e Estabilidade do core.
- Passadeira mostra filtros de caminhada, intervalos, inclinação, aquecimento e cooldown quando existirem exercícios correspondentes.
- Bíceps mostra filtros contextuais de Bíceps, Braquial e Braquiorradial.
- "Mostrar todos os exercícios" continua a ignorar filtros, mantendo indicação de indisponibilidade por equipamento/local.

## Testes criados

- `test/v072_profile_preferences_test.dart`
- `test/v072_training_flow_profile_test.dart`

Cobertura adicionada:

- Onboarding suporta múltiplos locais obrigatórios.
- Locais personalizados sobrevivem à serialização.
- Helpers de edição adicionam/removem locais.
- Catálogo de equipamento é agrupado e contém equipamento pedido.
- Helpers de edição adicionam/removem equipamento.
- Objetivos gerais podem ser adicionados, editados e desativados.
- Adicionar passadeira desbloqueia passadeira; remover bloqueia passadeira.
- Barra fixa desbloqueia Chin-up e Dead hang nos contextos corretos.
- Modalidades cardio respeitam equipamento do perfil.
- Filtros contextuais para Core, Passadeira e Bíceps.

## Resultado dos testes

- `flutter test test/v072_profile_preferences_test.dart test/v072_training_flow_profile_test.dart`: 12 testes passados.
- Validação final obrigatória: `flutter pub get`, `flutter analyze`, `flutter test` e `flutter build apk --release`.

## Limitações conhecidas

- Objetivos gerais continuam persistidos em texto no perfil para preservar compatibilidade com dados existentes; não foi criada uma nova tabela dedicada.
- O campo "Outro" no onboarding/edição preserva valores personalizados já serializados, mas a UI ainda usa seleção simples em vez de um editor avançado de múltiplos valores personalizados.
- Modalidades de cardio como remo ergómetro, stepper e air bike estão no catálogo de equipamento, mas ainda dependem de exercícios correspondentes no seed para aparecerem como lista de exercícios.
