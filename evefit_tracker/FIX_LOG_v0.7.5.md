# FIX_LOG_v0.7.5

Log técnico da v0.7.5. Este ficheiro foi criado antes das correções funcionais e será atualizado após cada bloco de implementação.

## Linha de base

- Branch base: `codex/v0.7.3-muscle-hierarchy`.
- Branch de trabalho: `codex/v0.7.5-full-audit`.
- Testes existentes antes de alterações funcionais: `flutter test` com SDK explícito passou 106 testes.
- Ambiente: `flutter` não estava no PATH do PowerShell; SDK localizado em `C:\tools\flutter\bin\flutter.bat`.

## Erros encontrados

| ID | Erro | Causa raiz | Estado |
| --- | --- | --- | --- |
| FIX-01 | Versão ainda v0.7.3 | `pubspec.yaml` e `settings_screen.dart` não foram atualizados para v0.7.5 | Corrigido |
| FIX-02 | Parte inferior mostra grupos antes de subzona | `_strengthGroupsForRegion('lower')` lê grupos anatómicos antigos de `TrainingArchitecture.groupsForRegion` | Corrigido |
| FIX-03 | Passadeira + resistência aeróbia pode mostrar HIIT passadeira | `TrainingFlow._cardioSelection` mapeia `aerobic_endurance` para seleção geral de passadeira | Corrigido |
| FIX-04 | Foco técnico de artes marciais repete a arte | UI mostra `_ChoiceTile` desativado com `_martialName(flow.martialArtKey)` | Corrigido |
| FIX-05 | Recuperação + Alongamentos leves pode ficar vazio | Seeds/filtros não garantem tags explícitas para `stretching` e lista mínima de alongamentos | Corrigido |
| FIX-06 | Personalizado filtra por `custom_workout` sem opção | `TrainingFlow.toTrainingSelection` devolve seleção custom restritiva por defeito | Corrigido |
| FIX-07 | Face pull com elástico marcado como cabo/máquina | `_equipmentFor` testa `face pull` antes de `elástico` | Corrigido |
| FIX-08 | Falta teste v0.7.5 de metadata/labels/fluxo | Testes existentes cobrem v0.7.3, mas não os bugs novos | Corrigido |

## Correções feitas

- FIX-01: `pubspec.yaml` atualizado para `0.7.5+13`; `settings_screen.dart` mostra `v0.7.5` e `Ver atualizações v0.7.5`.
- FIX-02: `workouts_screen.dart` usa grupo sintético `Pernas` para `Parte inferior`; `TrainingFlow.strengthSubzonesForGroup('lower')` devolve `Pernas completo`, `Acima do joelho / coxa e anca`, `Abaixo do joelho / perna inferior e pé`.
- FIX-03: `TrainingFlow._cardioSelection` separa `treadmill_aerobic` de `treadmill_intervals`; `ExerciseFilterService` filtra por keywords específicas.
- FIX-04: Artes marciais têm `martialFocusLabels`, `martialFocusOptions`, nome automático com foco e UI selecionável.
- FIX-05: Seeds de mobilidade ganharam alongamentos leves; `light_stretching` filtra alongamentos, mobilidade leve e respiração diafragmática.
- FIX-06: Personalizado sem filtros devolve seleção vazia e filtra só por equipamento/local; UI expõe filtros opcionais removíveis.
- FIX-07: Seeds usam `Face pull no cabo` e `Face pull com elástico`; migração v10 oculta default ambíguo antigo; `_equipmentFor` testa elásticos antes de face pull/cabo.
- FIX-08: Criado `test/v075_full_audit_regression_test.dart` com 14 testes novos.

## Validação

Executado:
- `flutter pub get`: passou.
- `flutter analyze`: passou, `No issues found!`.
- `flutter test test/v075_full_audit_regression_test.dart`: 14/14 passou.
- `flutter test`: 120/120 passou.
- `flutter build apk --release`: passou.
- APK confirmado em `build/app/outputs/flutter-apk/app-release.apk` com 54.362.897 bytes.

Finalização:
- Commit inicial criado: `aae3b84 Release v0.7.5 full requirements audit`.
- Branch publicado: `codex/v0.7.5-full-audit`.
- Release criada: `https://github.com/ryoken99/evefit_tracker/releases/tag/v0.7.5`.
- Este log foi atualizado depois da release para registar a evidência final.
