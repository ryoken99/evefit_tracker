# training_flow_audit_v0.7.5

Auditoria específica da aba Treinos para a v0.7.5.

## Estado antes das correções

Base já existente:
- `TrainingFlow.types` inicia o treino por Musculação, Cardio, Artes marciais, Mobilidade / elasticidade, Recuperação e Personalizado.
- `workouts_screen.dart` já usa fluxo por tipo e grava `workout_region_key`, `workout_group_key`, `workout_subgroup_key`, `workout_specific_muscle_key`, `workout_equipment_key`.
- `ExerciseFilterService.getAvailableExercises` aplica filtro de seleção e equipamento/local, e `showAllExercises` devolve todos com razão de indisponibilidade.
- `TrainingFlow` v0.7.3 já inclui hierarquia anatómica expandida para peito, costas, ombros, braços, core e pernas.

Problemas confirmados e corrigidos:
- Parte inferior: a UI usava `TrainingArchitecture.groupsForRegion('lower')`, que listava `Anca / glúteos`, `Quadríceps`, `Posterior de coxa`, etc. antes de `Pernas completo / Acima do joelho / Abaixo do joelho`. Corrigido com grupo sintético `Pernas` e subzonas obrigatórias.
- Cardio: `aerobic_endurance` em passadeira usava a mesma seleção que passadeira geral, podendo incluir `HIIT passadeira`, corrida intervalada e sprints. Corrigido com focos `treadmill_aerobic` e `treadmill_intervals`.
- Artes marciais: depois de escolher Karate/Jiu-Jitsu, o campo de foco técnico estava desativado e repetia só a arte. Corrigido com lista de focos técnicos por arte.
- Recuperação: `light_stretching` mapeava para `stretching`, mas catálogo/filtro não garantia a lista mínima de alongamentos leves. Corrigido com seeds e filtro específico.
- Personalizado: seleção por defeito `custom/custom_workout` restringia exercícios artificialmente. Corrigido com seleção vazia quando não há filtros e UI de filtros opcionais.
- Metadata: `Face pull com elástico` era capturado por `face pull` antes de `elástico`. Corrigido com variações explícitas e ordem de equipamento.

## Hierarquia desejada por região

### Musculação

Ordem:
1. Tipo de treino
2. Equipamento disponível
3. Região corporal
4. Grupo muscular
5. Subzona anatómica, quando aplicável
6. Músculo específico/foco, quando aplicável
7. Exercícios compatíveis

Atalhos "completo":
- `Pernas completo`, `Braços completo`, `Costas completo`, `Core completo`, `Peito completo`, `Ombros completo`, `Abdominal completo`, `Antebraço completo` não abrem músculo específico obrigatório.

Parte inferior corrigida:
- Região `Parte inferior` deve apresentar o grupo sintético `Pernas`.
- Dentro de `Pernas`: `Pernas completo`, `Acima do joelho / coxa e anca`, `Abaixo do joelho / perna inferior e pé`.
- Só depois disso aparecem músculos específicos como quadríceps, vastos, posteriores, glúteos, adutores, abdutores, gémeos, sóleo, tibial anterior, tornozelo e pés.

### Cardio

Ordem:
1. Tipo de treino
2. Modalidade/equipamento
3. Foco cardio
4. Exercícios

Correção obrigatória:
- `Cardio - Passadeira - Resistência aeróbia` deve incluir caminhada, caminhada rápida, corrida leve, inclinação moderada, aquecimento e cooldown.
- Deve excluir `HIIT passadeira`, corrida intervalada e sprints.
- `Intervalos/HIIT` deve ser o foco que inclui HIIT passadeira, corrida intervalada e sprints.

### Artes marciais

Karate deve expor:
- Karate completo
- Kihon
- Kata
- Kumite técnico
- Sombra de Karate
- Deslocamentos
- Guarda
- Socos técnicos
- Pontapés técnicos
- Mobilidade para Karate
- Condicionamento para Karate

Jiu-Jitsu deve expor:
- Jiu-Jitsu completo
- Shrimp / fuga de anca
- Ponte de grappling
- Technical stand-up
- Guarda
- Passagem de guarda
- Força de pega
- Core para Jiu-Jitsu
- Mobilidade para Jiu-Jitsu
- Condicionamento para Jiu-Jitsu

### Mobilidade / elasticidade

Label correto: `Zona/foco`.

Zonas existentes auditadas:
- Geral
- Pescoço
- Ombros
- Peitoral
- Dorsal
- Coluna torácica
- Anca
- Posterior de coxa
- Glúteos
- Tornozelo
- Gémeos

### Recuperação

`Alongamentos leves` deve mostrar exercícios sem equipamento:
- Alongamento peitoral
- Alongamento dorsal
- Alongamento posterior de coxa
- Alongamento glúteos
- Alongamento gémeos
- Alongamento cervical leve
- Mobilidade leve de ombros
- Mobilidade leve de anca
- Respiração diafragmática

### Personalizado

Sem filtros opcionais selecionados:
- Mostrar exercícios compatíveis com equipamento/local do perfil.

Com `Mostrar todos`:
- Mostrar todos os exercícios.
- Marcar indisponíveis quando faltar equipamento/local.

## Testes v0.7.5 a criar

- Parte inferior usa subzona antes de músculo.
- Pernas completo salta músculo específico.
- Acima do joelho mostra músculos corretos.
- Abaixo do joelho mostra músculos corretos.
- Passadeira resistência não mostra HIIT.
- Passadeira não mostra bicicleta.
- Karate mostra Kihon, Kata e Kumite.
- Jiu-Jitsu não mostra Karate exclusivo.
- Recuperação alongamentos leves mostra alongamentos.
- Personalizado respeita equipamento.
- Face pull com elástico usa Elásticos.
- Shrugs têm equipamento.
- Nenhuma key interna aparece no nome automático.
- Todos os exercícios visíveis têm descrição.
- Todos os exercícios visíveis têm passos.
- Todos os exercícios visíveis têm equipamento.

## Resultado dos testes

- Testes RED executados inicialmente em `test/v075_full_audit_regression_test.dart`: 8 falhas esperadas confirmaram os bugs.
- Após correção: `flutter test test/v075_full_audit_regression_test.dart` passou 14/14.
- Regressão completa após correções: `flutter test` passou 120/120.
- Validação final local: `flutter pub get`, `flutter analyze`, `flutter test` e `flutter build apk --release` passaram.
- APK confirmado: `build/app/outputs/flutter-apk/app-release.apk`.

## Limitações conhecidas

- A auditoria marca algumas áreas como PARCIAL quando a evidência é apenas leitura de UI/DB e não existe teste widget dedicado.
- A v0.7.5 vai priorizar os bugs confirmados e a regressão automatizada sem reescrever a arquitetura.
