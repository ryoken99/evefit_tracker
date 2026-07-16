# EveFit v1.1.2 - Release Report

## Preparacao

- Repositorio: `ryoken99/evefit_tracker`
- Branch: `release/v1.1.2-hierarchical-search`
- Commit base: `9768231fb5c2c4c93a997317ee370adeae0ea789`
- Versao anterior: `1.1.1+3`
- Versao alvo: `1.1.2+4`
- VersionName anterior/novo: `1.1.1` -> `1.1.2`
- VersionCode anterior/novo: `3` -> `4`
- Schema e migrations: inalterados

## Escopo confirmado

- Contextos ativos: 5
- Primeiro contexto: `main_training`
- Capacidades ativas: 8
- Conceitos ativos: 0
- Intencoes ativas: 0
- Atributos oficiais ativos: 0
- Exercicios ativos: 0
- Subniveis ativos: 0
- Legacy visivel: nao
- Arvore antiga visivel: nao
- Fluxo: Contexto -> Capacidade -> Conceito -> Intencao -> Exercicios
- Estado terminal atual: vazio de conceitos

Esta versao nao adiciona conceitos, intencoes ou exercicios canonicos.

## Ficheiros alterados

- `.github/workflows/release.yml`
- `evefit_tracker/pubspec.yaml`
- `evefit_tracker/lib/services/clean_base_config.dart`
- `evefit_tracker/lib/screens/settings_screen.dart`
- `evefit_tracker/test/v080/version_metadata_test.dart`
- `evefit_tracker/README.md`
- `evefit_tracker/CHANGELOG.md`
- `evefit_tracker/RELEASE_NOTES.md`
- `evefit_tracker/docs/releases/EveFit_v1.1.2_Hierarchical_Search.md`
- `evefit_tracker/docs/releases/EveFit_v1.1.2_Release_Report.md`
- `evefit_tracker/tool/run_v112_hierarchical_upgrade_test.ps1`

As alteracoes em `lib/` sao apenas literais publicos de versao. Nao existe alteracao funcional no Canonical Core, Dashboard, Goals, Profile, Workouts, Database, migrations ou arquivo legacy.

## Validacao pre-PR

| Gate | Resultado | Duracao |
| --- | --- | ---: |
| `flutter pub get` | PASS | 1.523 s |
| `dart format --set-exit-if-changed .` | PASS, 280 ficheiros, 0 alterados na execucao final | 1.264 s |
| `flutter analyze` | PASS, zero issues | 9.435 s |
| Testes focados | PASS, 45 testes | 6.529 s |
| Suite completa | PASS, 603 testes | 664.882 s |
| Full-app Android | PASS | exit code 0 |
| Upgrade 1.1.1 -> 1.1.2 | PASS | 47.645 s |
| `flutter build apk --release` | PASS | 43.145 s |

O `flutter pub get` indicou 20 versoes mais recentes incompatíveis com as restricoes atuais. Nenhuma dependencia foi atualizada.

Log da suite completa:

`test_artifacts/release/v1.1.2/unit/20260716-120332/flutter_test_full.log`

## Full-app Android

- Dispositivo: `EveFit_Test_Device`
- Android: 16 / API 36 / x86_64
- Entrypoint: aplicacao real
- Resultado: PASS
- Screenshots: 11
- Artefactos: `test_artifacts/workout_exercise_selector_roots/full_app/2026-07-16T111625Z`
- Abrir seletor: 123 ms
- Contexto -> capacidade: 126 ms
- Capacidade -> estado vazio: 115 ms

O fluxo validou Dashboard, criacao e detalhe de treino, cinco contextos, oito capacidades, Aquecimento -> Cardio e condicionamento, Treino principal -> Forca e capacidade muscular, estados vazios, Back, Home, Perfil, Objetivos e Definicoes. Nao foram observadas excecoes Flutter ou Hero, catalogo legacy ou arvore antiga.

## Upgrade 1.1.1 -> 1.1.2

- APK baseline: `dist/test-apks/EveFit-v1.1.1-hierarchical-search-test.apk`
- Baseline confirmado: `1.1.1+3`
- Build atual confirmado: `1.1.2+4`
- Certificado igual entre builds: sim
- Resultado final: PASS
- Artefactos: `test_artifacts/release/v1.1.2/upgrade/2026-07-16T112533Z`

| Tabela | Antes | Depois |
| --- | ---: | ---: |
| `profiles` | 1 | 1 |
| `body_measurements` | 1 | 1 |
| `goals` | 1 | 1 |
| `workouts` | 1 | 1 |
| `workout_sets` | 0 | 0 |
| `workout_exercises` | 0 | 0 |
| `exercises` | 0 | 0 |

As foreign keys permaneceram validas. O perfil, a medicao, o objetivo e o treino foram preservados. O seletor hierarquico abriu depois da atualizacao e o legacy permaneceu invisivel.

Duas execucoes anteriores do harness falharam antes desta validacao: a primeira por tentar localizar o botao antes da estabilizacao da UI e a segunda por encoding de literais acentuados no Windows PowerShell 5. O harness passou a aguardar explicitamente o detalhe do treino e a usar fragmentos ASCII. Nao foi alterado codigo da aplicacao.

## APK pre-PR

- Original: `build/app/outputs/flutter-apk/app-release.apk`
- Copia: `dist/releases/EveFit-v1.1.2-hierarchical-search-release.apk`
- Package: `com.sandro.evefittracker`
- VersionName: `1.1.2`
- VersionCode: `4`
- Tamanho: 54,103,857 bytes (51.60 MiB)
- SHA-256: `5E92934BCA556C93D7D3335C8BFBD5E965F8647E8E83B0AC219C746AB1BBAAF1`
- Certificate subject: `C=US, O=Android, CN=Android Debug`
- Certificate SHA-256: `59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B`
- APK Signature Scheme v2: verificado
- APK Signature Schemes v1/v3/v3.1/v4: nao usados

Este e um release build com a configuracao de assinatura atual do projeto. Nao deve ser tratado como assinatura Play Store sem verificacao adicional.

O APK publicado sera reconstruido e novamente inspecionado a partir do SHA final de `main` depois do merge.

## Dados e compatibilidade

- Dados pessoais preservados: sim
- Treinos preservados: sim
- Historico preservado: sim
- Foreign keys validas: sim
- Schema alterado: nao
- Migrations adicionadas: nao
- Legacy reativado: nao

## Riscos e limitacoes

- A aplicacao ainda nao oferece conceitos, intencoes ou exercicios canonicos depois do passo Capacidade.
- A assinatura atual e um certificado Android Debug usado pela configuracao release existente.
- A comprovacao de upgrade inclui um treino sem exercicios ou series, coerente com o catalogo canonico vazio; nao houve diminuicao de qualquer contagem pessoal.

## Rollback

Os commits de release podem ser revertidos sem migration ou transformacao de dados. Um rollback de codigo preserva integralmente a base existente. A tag e a GitHub Release so serao criadas depois de todos os gates passarem novamente em `main`.

## Estado de publicacao

- Pull Request: pendente
- Quality gate: pendente
- Merge: pendente
- Revalidacao em `main`: pendente
- Tag `v1.1.2`: pendente
- GitHub Release: pendente
