# APP_REQUIREMENTS_AUDIT_v0.7.5

Auditoria iniciada em 2026-06-07 antes de alterar código funcional.

Evidência de base:
- Branch inicial: `codex/v0.7.3-muscle-hierarchy`; branch de trabalho: `codex/v0.7.5-full-audit`.
- Releases GitHub existentes: v0.1.0 a v0.7.3 confirmadas com `gh release list --repo ryoken99/evefit_tracker --limit 20`.
- Versão antes da v0.7.5: `pubspec.yaml` com `version: 0.7.3+12`; `settings_screen.dart` com `v0.7.3`.
- Teste base antes de correções: `C:\tools\flutter\bin\flutter.bat test` passou com 106 testes.
- Relatórios anteriores existentes: `training_filter_audit_v0.6.0.md`, `training_architecture_audit_v0.7.0.md`, `training_flow_audit_v0.7.1.md`, `training_flow_audit_v0.7.2.md`, `training_muscle_hierarchy_audit_v0.7.3.md`.

Estados usados: FEITO, PARCIAL, NÃO FEITO, COM BUG, CORRIGIDO, ADIADO COM JUSTIFICAÇÃO.

| ID | Área | Requisito | Estado inicial | Evidência | Correção feita | Teste | Estado final |
| --- | --- | --- | --- | --- | --- | --- | --- |
| APK-01 | APK e release | APK release gerado no caminho correto | FEITO | Release v0.7.3 existia; APK anterior em `build/app/outputs/flutter-apk/app-release.apk` | `flutter build apk --release` gerou `build/app/outputs/flutter-apk/app-release.apk` com 54.362.897 bytes | `Get-ChildItem build\app\outputs\flutter-apk\` | CORRIGIDO |
| APK-02 | APK e release | Versão atualizada para v0.7.5 | COM BUG | `pubspec.yaml:19` estava `0.7.3+12`; `settings_screen.dart:12` estava `v0.7.3` | `pubspec.yaml` atualizado para `0.7.5+13`; labels de Settings atualizados para `v0.7.5` | `rg "^version:|v0.7.5"` | CORRIGIDO |
| APK-03 | APK e release | GitHub Release criada e APK anexado | NÃO FEITO | `gh release list` mostrava até v0.7.3, não v0.7.5 | Release criada em `https://github.com/ryoken99/evefit_tracker/releases/tag/v0.7.5` com `app-release.apk` anexado | `gh release create v0.7.5 ...`; `gh release view v0.7.5` | CORRIGIDO |
| APK-04 | APK e release | Botão de atualização e versão visível | COM BUG | `settings_screen.dart:41-48` mostrava `v0.7.3` | `appVersionLabel` e botão alterados para `v0.7.5` | `rg "v0.7.5" lib/screens/settings_screen.dart` | CORRIGIDO |
| PERF-01 | Perfis | App inicia sem dados pessoais públicos | FEITO | `AppDatabase._ensureDefaultProfile` cria perfil genérico `Utilizador` só local; `ProfileGateScreen` pede seleção/PIN | Nenhuma | `profile_pin_test.dart`, leitura de `app_database.dart` | FEITO |
| PERF-02 | Perfis | Cada utilizador cria perfil próprio | FEITO | `profile_gate_screen.dart` inclui criação de perfil; `AppDatabase.createProfile` | Nenhuma | `profile_pin_test.dart` parcial | FEITO |
| PERF-03 | Perfis | Múltiplos perfis, troca de perfil, dados separados | FEITO | Tabelas têm `profile_id`; métodos filtram por `_requireProfileId()` | Nenhuma | `model_mapping_test.dart`, leitura DB | FEITO |
| PERF-04 | Perfis | PIN de 4 dígitos com hash | FEITO | `PinService.validatePin`, `hashPin`, `verifyPin`; `profiles.pin_hash` | Nenhuma | `profile_pin_test.dart` | FEITO |
| PERF-05 | Perfis | Editar perfil e alterar PIN | FEITO | `settings_screen.dart:154-366` tem edição e alteração de PIN | Nenhuma | Sem widget test dedicado | PARCIAL |
| PERF-06 | Perfis | Locais, equipamento e objetivos gerais editáveis | FEITO | `settings_screen.dart` usa `TrainingLocationService` e `ProfilePreferencesService` | Nenhuma | `v072_profile_preferences_test.dart` | FEITO |
| ONB-01 | Onboarding | Passo 1 dados do perfil | FEITO | `profile_gate_screen.dart` tem nome, PIN, confirmação, altura, nascimento, sexo, notas | Nenhuma | Leitura + PIN tests | FEITO |
| ONB-02 | Onboarding | Passo 2 locais de treino com múltipla escolha e outro | FEITO | `profile_gate_screen.dart` e `TrainingLocationService` com múltiplas localizações/custom | Nenhuma | `v052_training_location_test.dart`, `v072_profile_preferences_test.dart` | FEITO |
| ONB-03 | Onboarding | Passo 3 equipamento por categorias e outro | FEITO | `ProfilePreferencesService.equipmentSections` organiza categorias e inclui Outro | Nenhuma | `v072_profile_preferences_test.dart` | FEITO |
| ONB-04 | Onboarding | Passo 4 objetivos gerais por categorias e outro | FEITO | `ProfilePreferencesService.generalGoalSections` inclui categorias e Outro | Nenhuma | `v072_profile_preferences_test.dart` | FEITO |
| ONB-05 | Onboarding | Peso corporal disponível por defeito | FEITO | `ExerciseFilterService._matchesEquipment` adiciona `bodyweight` e `none`; default flow bodyweight | Nenhuma | `v071_training_flow_test.dart`, `v073_muscle_hierarchy_test.dart` | FEITO |
| DASH-01 | Dashboard | Dashboard editável, guardar, cancelar, restaurar padrão | FEITO | `dashboard_screen.dart:230-309` edita draft e só persiste ao guardar | Nenhuma | `v051_dashboard_draft_test.dart` | FEITO |
| DASH-02 | Dashboard | Gráficos, cartões e mensagens sem dados | FEITO | `ProgressChart` mostra mensagem sem dados; `dashboard_screen.dart` usa cartões e gráficos | Nenhuma | `dashboard_metric_test.dart`, `dashboard_stats_test.dart` | FEITO |
| DASH-03 | Dashboard | Dados por perfil | FEITO | `AppDatabase.dashboardWidgets`, `measurements`, `workoutsThisWeek` usam profile ativo | Nenhuma | Leitura DB + testes de métricas | FEITO |
| DADOS-01 | Dados | Aba chamada Dados | FEITO | `measurements_screen.dart:36` e `v053_body_data_test.dart` | Nenhuma | `v053_body_data_test.dart` | FEITO |
| DADOS-02 | Dados | Balança, composição, IMC, altura, idade, sexo fórmulas | PARCIAL | `BodyMeasurement` e `BodyDataService` cobrem IMC/idade/rácios; sexo de referência existe no perfil mas fórmulas atuais não usam sexo | Mantido; sem nova fórmula pedida nesta hotfix | `v053_body_data_test.dart` | PARCIAL |
| DADOS-03 | Dados | Medidas completas, dobras, rácios, nulls, secções dobráveis | FEITO | `measurements_screen.dart`, `BodyMeasurement.toMap`, `_num` retorna null, `ExpansionTile` | Nenhuma | `model_mapping_test.dart`, `v053_body_data_test.dart` | FEITO |
| DADOS-04 | Dados | Dados filtrados por perfil | FEITO | `AppDatabase.measurements` filtra `profile_id` | Nenhuma | Leitura DB | FEITO |
| FOTO-01 | Fotos | Adicionar foto, thumbnail, ver maior, apagar com confirmação | FEITO | `photos_screen.dart` usa `ImagePicker`, `Image.file`, detalhe e confirmação | Nenhuma | Leitura UI; sem widget test dedicado | PARCIAL |
| FOTO-02 | Fotos | Notas, tipo, dados por perfil, cancelamento sem erro | FEITO | `_addPhoto` retorna se `source == null` ou `picked == null`; DB filtra por profile | Nenhuma | Leitura UI/DB | FEITO |
| OBJ-01 | Objetivos | Objetivos gerais do perfil separados de progresso | FEITO | Gerais em `Profile.initialGoals`; progresso em `goals`/`goal_milestones` | Nenhuma | `v072_profile_preferences_test.dart`, `goal_progress_test.dart` | FEITO |
| OBJ-02 | Objetivos | Criar, editar, apagar, concluir, reativar | PARCIAL | `goals_screen.dart` cria/edita/apaga e checkbox conclui/reativa; arquivar separado não existe | Adiado sem quebrar app: pedido v0.7.5 foca correções de coerência, apagar/concluir cobre fluxo atual | Leitura + `goal_progress_test.dart` | ADIADO COM JUSTIFICAÇÃO |
| OBJ-03 | Objetivos | Modo simples/avançado, milestones manuais/auto, barra, gráfico | FEITO | `goals_screen.dart` tem switch avançado, milestones e `ProgressChart` | Nenhuma | `goal_progress_test.dart`, leitura UI | FEITO |
| TREINO-01 | Treinos | Criar, editar, apagar, detalhe | FEITO | `workouts_screen.dart`, `workout_detail_screen.dart` | Nenhuma | `workout_entry_test.dart` parcial | FEITO |
| TREINO-02 | Treinos | Adicionar exercício, explicação, série, editar/apagar série, peso/reps/RPE/notas | FEITO | `workout_detail_screen.dart:335-691` | Nenhuma | Leitura UI/modelos | FEITO |
| TREINO-03 | Treinos | Templates personalizados e histórico por perfil | FEITO | `workout_template_service.dart`, tabelas `workout_templates`, `AppDatabase.workouts` filtra profile | Nenhuma | `workout_template_test.dart` | FEITO |
| FLOW-01 | Fluxo treino | Criação começa por Musculação/Cardio/Artes/Mobilidade/Recuperação/Personalizado | FEITO | `TrainingFlow.types` e `workouts_screen.dart:199` | Nenhuma | `v071_training_flow_test.dart` | FEITO |
| MUSC-01 | Musculação | Ordem tipo -> equipamento -> região -> grupo -> subzona -> músculo -> exercícios | PARCIAL | UI tinha ordem geral, mas parte inferior mostrava grupos anatómicos antes da subzona sintética | `workouts_screen.dart` passa a mostrar grupo sintético `Pernas`; `TrainingFlow.strengthSubzonesForGroup('lower')` devolve subzonas obrigatórias | `v075_full_audit_regression_test.dart` | CORRIGIDO |
| MUSC-02 | Musculação | Completo salta filtro seguinte | FEITO | `TrainingFlow._completeStrengthKeys` e `requiresStrengthSpecificFocus` | Nenhuma | `v073_muscle_hierarchy_test.dart` | FEITO |
| INF-01 | Parte inferior | Parte inferior usa subzona antes de músculo | COM BUG | `_strengthGroupsForRegion('lower')` retornava grupos `hips_glutes`, `quadriceps`, etc. antes de `Pernas completo/Acima/Abaixo` | `_strengthGroupsForRegion('lower')` agora retorna `Pernas`; subzonas vêm de `TrainingFlow.strengthSubzonesForGroup('lower')` | `lower body exposes leg subzones before specific muscles` | CORRIGIDO |
| INF-02 | Parte inferior | Acima/abaixo do joelho incluem músculos pedidos | FEITO | `TrainingFlow._strengthSpecificBySubzone` contém vastos, posteriores, glúteos, adutores, abdutores, gémeos, sóleo, tibial, tornozelo | Nenhuma | `v073_muscle_hierarchy_test.dart`; reforço v0.7.5 | FEITO |
| CARD-01 | Cardio | Ordem modalidade -> objetivo/foco -> exercícios | PARCIAL | UI tem modalidade e foco; não há campo separado objetivo cardio | Mantido como foco simplificado sem quebrar fluxo | `v071_training_flow_test.dart`; novo v0.7.5 | PARCIAL |
| CARD-02 | Cardio | Modalidades compatíveis com perfil | FEITO | `TrainingFlow.availableCardioModes` usa localização/equipamento | Nenhuma | `v072_training_flow_profile_test.dart` | FEITO |
| CARD-03 | Cardio | Passadeira resistência não mostra HIIT | COM BUG | `_cardioSelection` tratava `aerobic_endurance` como `treadmill` geral, permitindo `HIIT passadeira` | `treadmill_aerobic` e `treadmill_intervals` separados em `TrainingFlow` e `ExerciseFilterService` | `treadmill aerobic endurance excludes HIIT intervals and sprints` | CORRIGIDO |
| CARD-04 | Cardio | Label não usa Grupo muscular | FEITO | `TrainingFlow.finalFocusLabel('cardio')` retorna `Foco cardio` | Nenhuma | `v071_training_flow_test.dart` | FEITO |
| ART-01 | Artes marciais | Karate/Jiu-Jitsu têm foco técnico real | COM BUG | `workouts_screen.dart:413-420` mostrava foco desativado repetindo a arte | `TrainingFlow.martialFocusLabels`, `martialFocusOptions` e UI de foco técnico selecionável | Testes Karate/Jiu-Jitsu v0.7.5 | CORRIGIDO |
| ART-02 | Artes marciais | Não misturar exclusivos Karate/Jiu-Jitsu | FEITO | `TrainingFlow._martialSelection`, `TrainingArchitecture.tagsForExercise` | Nenhuma | `v052_filter_test.dart`, `v071_training_flow_test.dart` | FEITO |
| MOB-01 | Mobilidade | Zonas pedidas e label Zona/foco | FEITO | `TrainingFlow.mobilityLabels` e `finalFocusLabel` | Nenhuma | `v071_training_flow_test.dart` | FEITO |
| REC-01 | Recuperação | Alongamentos leves mostra exercícios sem equipamento | COM BUG | `SeedData.Mobilidade` só tinha poucos alongamentos; filtro `stretching` não era explicitamente tagueado no `TrainingArchitecture` | Seeds adicionam alongamentos leves; `light_stretching` filtra por keywords; tags de alongamento/respiração reforçadas | `recovery light stretching shows bodyweight stretches` | CORRIGIDO |
| PERS-01 | Personalizado | Filtros opcionais e sem escolha mostra compatível com equipamento | COM BUG | `TrainingFlow.toTrainingSelection` usava `custom/custom_workout`, restringindo a exercícios tagueados como custom | `custom` sem filtros agora devolve seleção vazia; UI expõe equipamento/região/grupo/subzona/músculo opcionais | `custom flow without optional filters respects available equipment` | CORRIGIDO |
| PERS-02 | Personalizado | Mostrar todos mostra todos e marca indisponíveis | FEITO | `ExerciseFilterService.getAvailableExercises(showAllExercises: true)` retorna todos com motivo | Nenhuma | `v070_training_architecture_test.dart` | FEITO |
| CAT-01 | Catálogo | Exercícios têm nome, tipo/grupo, metadata, descrição, passos, erros, segurança | PARCIAL | `Exercise` tem campos; seeds usam helpers, mas alguns metadados genéricos e bugs conhecidos | Metadata corrigida para Face pull; alongamentos adicionados; migração v10 refresca defaults; notas de segurança específicas confirmadas | `all visible exercises have description steps and equipment`; leitura `_safetyNotesFor` | CORRIGIDO |
| CAT-02 | Catálogo | Face pull com elástico usa Elásticos e cabo separado | COM BUG | `_equipmentFor` classificava qualquer `face pull` como `Cabo ou máquina`; seed tinha `Face pull` e `Face pull com elástico` | Seed usa `Face pull no cabo` e `Face pull com elástico`; `_equipmentFor` testa elásticos antes de cabo; migração oculta default ambíguo antigo | `face pull catalog separates cable and elastic variants` | CORRIGIDO |
| CAT-03 | Catálogo | Shrugs/encolhimentos têm equipamento | FEITO | Seed tem `Encolhimento de ombros com halteres` e `com barra`; `_equipmentFor` reconhece halter/barra | Reforçar teste | Novo teste v0.7.5 | FEITO |
| EQ-01 | Equipamento | Casa sem cabo/barra fixa/passadeira bloqueia esses exercícios | FEITO | `_matchesEquipment` usa equipamento real fora de ginásio | Nenhuma | `v070_training_architecture_test.dart`, `v072_training_flow_profile_test.dart` | FEITO |
| EQ-02 | Equipamento | Ginásio pode equipamento completo mas respeita tipo | FEITO | `_matchesEquipment` libera ginásio, filtro anatómico continua aplicado | Nenhuma | `v052_filter_test.dart`, `v070_training_architecture_test.dart` | FEITO |
| EQ-03 | Equipamento | Dojo/Exterior respeitam local | FEITO | `_matchesEquipment` tem regras específicas para dojo/exterior | Nenhuma | Testes existentes parciais | FEITO |
| LABEL-01 | Labels | UI não mostra keys internas proibidas | PARCIAL | `TrainingFlow` usava labels PT, mas fallbacks podiam devolver key via `_architectureName` | `_architectureName` agora procura labels reais em músculos, subgrupos, grupos, regiões e equipamento; teste de nomes automáticos sem keys | `automatic workout names do not expose internal keys` | CORRIGIDO |
| LABEL-02 | Labels | Nomes automáticos em português com contexto | FEITO | `TrainingFlow.suggestedWorkoutName` | Reforçar com teste de keys | `v071_training_flow_test.dart`; novo v0.7.5 | FEITO |
| EXPL-01 | Explicações | Info do exercício mostra descrição, passos, erros, segurança | FEITO | `workout_detail_screen.dart:538-553` | Nenhuma | Leitura UI | FEITO |
| EXPL-02 | Explicações | Exercícios de risco têm segurança reforçada | PARCIAL | `_safetyNotesFor` tem lógica específica para cervical/pescoço, lombar, peso morto, agachamento, HIIT, sprints, Karate e Jiu-Jitsu | Confirmado e mantido; migração v10 refresca defaults | Leitura `_safetyNotesFor`; metadata test | FEITO |
| TEST-01 | Testes | Suíte existente executa sem falhas antes da v0.7.5 e após correções | FEITO | `flutter test` passou 106 testes na linha de base | Após v0.7.5, `flutter test` passou 120 testes | Linha de base 106/106; final 120/120 | FEITO |
| TEST-02 | Testes | Novos testes v0.7.5 obrigatórios | NÃO FEITO | Não existia `test/v075_full_audit_regression_test.dart` | Criado com 14 testes cobrindo hierarquia, cardio, artes marciais, recuperação, personalizado, metadata e labels | `flutter test` passou 120 testes após correções | CORRIGIDO |
| MIG-01 | Migrações | Não apagar dados existentes | FEITO | Migrações usam `ALTER TABLE`/backfill; comentários indicam não remover dados | Nenhuma | Leitura `app_database.dart` | FEITO |

## Estado inicial resumido

Bloqueios reais encontrados antes de editar código e estado atual:
- v0.7.5 não estava versionada; corrigido para `0.7.5+13` e `v0.7.5`.
- Parte inferior apresentava grupos musculares antes da subzona obrigatória; corrigido.
- Cardio Passadeira + Resistência aeróbia não distinguia HIIT/intervalos; corrigido.
- Artes marciais não tinham foco técnico selecionável; corrigido.
- Recuperação/Alongamentos leves precisava garantir exercícios sem equipamento; corrigido.
- Personalizado restringia indevidamente por `custom_workout`; corrigido.
- Face pull com elástico caía como cabo/máquina por ordem de matching; corrigido.
- Faltava suíte v0.7.5 específica; criada e integrada.
- APK v0.7.5 foi gerado localmente e anexado à release GitHub v0.7.5.
