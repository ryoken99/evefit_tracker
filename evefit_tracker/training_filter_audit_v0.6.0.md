# EveFit Tracker v0.6.0 - Auditoria da aba Treinos

## Tipos de treino testados

Full Body, Upper Body, Lower Body, Push, Pull, Legs, Peito, Costas, Ombros, Braços, Bíceps, Tríceps, Antebraço/Pega, Trapézio, Pescoço, Core/Abdominal, Lombar, Pernas, Quadríceps, Posterior de coxa, Glúteos, Gémeos, Adutores/Abdutores, Cardio geral, Passadeira, Bicicleta, Elíptica, Corda de saltar, Caminhada exterior, Corrida exterior, HIIT, Karate, Jiu-Jitsu, Condicionamento para artes marciais, Mobilidade para artes marciais, Mobilidade, Alongamentos, Recuperação, Outro, Treino personalizado.

## Erros encontrados

- A lista de tipos de treino era apresentada como uma lista única e extensa, sem secções.
- Tipos específicos dependiam de pesquisa textual ampla e podiam herdar exercícios de cardio genérico.
- O caso Passadeira podia misturar modalidades como bicicleta, elíptica, corda ou circuito genérico quando o texto coincidia com cardio.
- Karate e Jiu-Jitsu não tinham uma taxonomia explícita que impedisse mistura de drills exclusivos.
- Tipos default novos como Lombar, Pernas, Adutores/Abdutores, Condicionamento para artes marciais, Mobilidade para artes marciais e Treino personalizado não estavam na lista predefinida.
- O ecrã de edição usava a lista antiga e podia falhar com tipos personalizados fora de `SeedData`.
- As descrições antigas eram preenchidas por fallback genérico em instalações existentes.

## Correções feitas

- Criada a taxonomia `WorkoutTaxonomy` com secções obrigatórias, tipos default, grupos internos e normalização com acentos.
- O filtro de exercícios passou a aplicar primeiro o tipo de treino e depois equipamento/local.
- `Mostrar todos os exercícios` continua a ser o único bypass total dos filtros.
- Tipos específicos de cardio ficaram separados: Passadeira, Bicicleta, Elíptica, Corda de saltar, Caminhada exterior e Corrida exterior.
- HIIT deixou de herdar todo o cardio; só mostra exercícios marcados como HIIT/circuito HIIT e variações HIIT por equipamento disponível.
- Tipos musculares específicos passaram a filtrar por grupos internos: bíceps, tríceps, peito, costas, ombros, pernas, quadríceps, posterior, glúteos, gémeos, adutores/abdutores, core, lombar, trapézio e pescoço.
- Karate e Jiu-Jitsu foram separados por tags específicas.
- A base seed foi expandida com os exercícios obrigatórios de cardio, musculação, core, artes marciais, mobilidade e recuperação.
- A migração v0.6.0 atualiza tipos e detalhes de exercícios default já existentes sem apagar treinos, perfis, fotos, objetivos ou dados corporais.
- O fluxo Criar treino usa bottom sheet com pesquisa e secções visuais.
- A edição de treino passou a listar tipos com prefixo de secção e preserva tipos personalizados.
- Versão atualizada para `0.6.0+8` e texto `Ver atualizações v0.6.0`.

## Como a lógica de filtro ficou organizada

1. `WorkoutTaxonomy.groupsFor(tipo)` devolve os grupos internos permitidos.
2. `WorkoutTaxonomy.exerciseGroups(...)` classifica cada exercício por nome, grupo principal, grupos secundários e equipamento.
3. `ExerciseFilterService.filter(...)` exclui exercícios fora do tipo de treino.
4. O mesmo serviço aplica equipamento/local: ginásio permite equipamento completo, casa respeita `availableEquipmentKeys`, dojo aceita artes marciais/core/peso corporal/tatami, exterior aceita corrida/caminhada/peso corporal/mobilidade/HIIT exterior.
5. Quando `showAllWithoutEquipment` é verdadeiro, a lista completa é devolvida.

## Exemplos de filtros corretos

- Ginásio + Passadeira mostra apenas exercícios com tag `passadeira`.
- Ginásio + Bicicleta mostra apenas exercícios com tag `bicicleta`.
- Casa + Bíceps + halteres mostra `Curl com halteres` e exclui cabo, máquinas, pernas e cardio.
- Dojo + Jiu-Jitsu mostra `Shrimp / fuga de anca` e exclui `Kihon`.
- Karate mostra drills de Karate e não mostra drills exclusivos de Jiu-Jitsu.
- Cardio geral mostra passadeira, bicicleta, elíptica, corda, caminhada exterior, corrida exterior e HIIT.

## Testes criados

Arquivo: `test/v060_training_filter_test.dart`

- Passadeira só mostra passadeira.
- Bicicleta só mostra bicicleta.
- Elíptica só mostra elíptica.
- Corda de saltar só mostra corda.
- Cardio geral mostra várias modalidades de cardio.
- Bíceps não mostra pernas nem tríceps.
- Tríceps não mostra peito.
- Pernas não mostra braços.
- Karate não mostra Jiu-Jitsu exclusivo.
- Jiu-Jitsu não mostra Karate exclusivo.
- Casa respeita equipamento disponível.
- Dojo exclui máquinas de ginásio.
- Mostrar todos os exercícios ignora filtros.
- Dropdown de grupo muscular usa apenas grupos visíveis.
- Exercícios filtráveis têm descrição, passos e notas de segurança.
- Tipos aparecem nas secções corretas.

## Resultado dos testes e build

- `flutter test test\v060_training_filter_test.dart`: 10 testes passaram.
- `flutter pub get`: concluído.
- `flutter analyze`: sem issues.
- `flutter test`: 43 testes passaram.
- `flutter build apk --release`: APK release gerado em `build\app\outputs\flutter-apk\app-release.apk`.
- `Get-ChildItem build\app\outputs\flutter-apk\`: confirmou `app-release.apk` com 54,051,593 bytes.
