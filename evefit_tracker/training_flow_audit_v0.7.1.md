# EveFit Tracker v0.7.1 - Auditoria do fluxo de treinos

## Objetivo

Estabilizar a criação de treino para começar por tipo/domínio de treino e garantir que os filtros de exercício respeitam o contexto escolhido antes de chegar à seleção de exercícios.

## Tipos e fluxos testados

- Musculação -> Equipamento disponível -> Região corporal -> Grupo muscular -> Músculo específico.
- Cardio -> Equipamento/modalidade -> Foco cardio.
- Artes marciais -> Arte marcial -> Foco técnico.
- Mobilidade / elasticidade -> Zona/foco.
- Recuperação -> Tipo de recuperação.
- Personalizado -> Nome livre.

## Matriz automática coberta

- Musculação + halteres + parte superior + braços + bíceps.
- Musculação + peso corporal + braços + bíceps.
- Musculação + peso corporal + peito.
- Musculação + peso corporal + braços + tríceps.
- Musculação + peso corporal + Core/Abdominal.
- Cardio + passadeira.
- Cardio + sem equipamento.
- Artes marciais + Karate.
- Artes marciais + Jiu-Jitsu.
- Mobilidade + anca.
- Nomes automáticos por tipo/foco.
- Labels finais por tipo de treino.

## Erros encontrados

- O fluxo anterior começava por região corporal/domínio, o que fazia o utilizador escolher anatomia antes de escolher se o treino era musculação, cardio, artes marciais, mobilidade ou recuperação.
- Cardio específico continuava dependente de escolhas genéricas e podia cair em listas amplas quando a seleção não trazia modalidade clara.
- Abdominal/Core podia ficar vazio quando o perfil não tinha equipamento explícito, porque peso corporal não era considerado disponível por defeito.
- Alguns exercícios de core e bíceps não eram classificados por keywords suficientes.
- Mobilidade por zona, como anca, não recebia tags específicas suficientes.
- O dropdown interno de grupo muscular em "Adicionar exercício" continuava visível mesmo quando o contexto só tinha um grupo útil.

## Correções feitas

- Criado `TrainingFlowSelection` e `TrainingFlow` para representar o novo fluxo por domínio.
- A sheet "Novo treino" agora começa por "Tipo de treino".
- Musculação mostra equipamento, região corporal, grupo muscular e músculo específico.
- Cardio mostra equipamento/modalidade e foco cardio.
- Artes marciais mostra arte marcial e foco técnico contextual.
- Mobilidade mostra "Zona/foco".
- Recuperação mostra "Tipo de recuperação".
- O nome automático passou a incluir tipo e foco, por exemplo `Musculação - Bíceps` e `Cardio - Passadeira - Resistência aeróbia`.
- O fluxo novo converte para a arquitetura antiga (`TrainingSelection`) para preservar treinos existentes e filtros da aba de detalhes.
- Peso corporal e nenhum equipamento passaram a estar sempre disponíveis como base.
- Passadeira, bicicleta, elíptica, corda, caminhada exterior, corrida exterior e HIIT têm mapeamento explícito.
- Karate e Jiu-Jitsu mantêm seleções separadas.
- O dropdown "Grupo muscular" de adicionar exercício fica oculto quando há apenas uma opção contextual real.
- Atualizada a versão para `0.7.1+10` e labels visíveis para `v0.7.1`.

## Exemplos de filtros corretos

- Cardio + Passadeira: mostra apenas exercícios com tags de passadeira quando "Mostrar todos os exercícios" está desligado.
- Cardio + Sem equipamento: mostra HIIT/peso corporal compatível sem exigir equipamento configurado no perfil.
- Musculação + Bíceps + Halteres: mostra curls com halteres e não mostra flexões.
- Musculação + Peito + Peso corporal: mostra flexões.
- Musculação + Core/Abdominal + Peso corporal: mostra prancha, crunch, dead bug, hollow hold e variações de core.
- Karate: mostra Kihon e não mostra drills exclusivos de Jiu-Jitsu.
- Jiu-Jitsu: mostra Shrimp/fuga de anca e não mostra Kihon.
- Mobilidade + Anca: mostra mobilidade de anca.

## Testes criados

- `test/v071_training_flow_test.dart`

Cobertura adicionada:

- Bíceps com halteres mostra curls corretos.
- Bíceps com peso corporal não mostra exercícios de peito/tríceps.
- Peito com peso corporal mostra flexões.
- Tríceps com peso corporal mostra flexões fechadas.
- Passadeira não mostra bicicleta.
- Cardio sem equipamento mostra HIIT peso corporal.
- Karate não mostra Jiu-Jitsu exclusivo.
- Jiu-Jitsu não mostra Karate exclusivo.
- Mobilidade de anca mostra exercício de anca.
- Abdominal/Core mostra exercícios de core com peso corporal.
- Peso corporal está disponível por defeito.
- Nome automático inclui tipo e foco.
- O rótulo final muda por tipo de treino.

## Resultado dos testes

- `flutter analyze`: sem issues.
- `flutter test test/v071_training_flow_test.dart`: 13 testes passados.
- A validação final completa deve incluir `flutter pub get`, `flutter test` e `flutter build apk --release`.
