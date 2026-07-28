# EveFit v1.1.6 - Relatório de release

## Preparação

- Branch: `feature/evefit-v1.1.6-eft-landing`
- Base funcional da branch: `84578b18123b7a5622565b5929064caed2bf97fb`
- `origin/main` inicial: `11eb4a5801a128eba9e04ecbe193b033dc4f71c2`
- Versão anterior: `1.1.5+7`
- Versão alvo: `1.1.6+8`
- Package: `com.sandro.evefittracker`
- Certificado SHA-256: `59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B`
- Schema SQLite: `22`, inalterado

## Escopo

- Landing EFT integrada no arranque real.
- Fundo de perfis coordenado sem EFT.
- Transição de 280 ms, anulada quando o sistema pede redução de movimento.
- Estado em memória impede reapresentação por rebuild, rotação ou regresso do background.
- Sem alterações de ontologia, catálogo, treino, schema, migrations ou lógica persistida dos perfis.

## Assets

| Asset | Dimensões | Bytes | SHA-256 |
|---|---:|---:|---|
| `assets/branding/eft_landing_background.jpg` | 941 x 1672 | 532766 | `E539DA410230A5D2E5BAAE6F6496C8BB6C76E80DFF4E650E1A48CDD77E1A0C70` |
| `assets/branding/eft_profile_background.jpg` | 941 x 1672 | 538480 | `4D222CF0F2B838D9E8D391E39F062199A4DAF33581B30682AFD3BED70DAF5BA3` |

O total comprimido é `1071246` bytes. A descodificação RGBA máxima combinada é aproximadamente 12 MiB. O segundo asset só é pré-carregado depois do primeiro frame da landing.

## Validação local do candidato

| Gate | Resultado | Evidência |
|---|---|---|
| Widget tests landing/perfis | 12 testes passaram | execução focada local |
| Fast Gate | 57 testes passaram; format e analyze verdes | `.dart_tool/evefit_gate_logs/2026-07-28T11-13-04.282890Z/` |
| Flutter analyze final | sem issues | `.dart_tool/evefit_gate_logs/2026-07-28T11-35-58.691402Z/analyze.log` |
| PR Gate final | passou | `.dart_tool/evefit_gate_logs/2026-07-28T11-35-58.691402Z/` |
| Suíte final no PR Gate | 727 testes, quatro shards: 247 + 156 + 157 + 167 | `test-shard-1.log` a `test-shard-4.log` no diretório do PR Gate |
| Manifest validation | passou, exit code 0 | `manifest-validation.log` no diretório do PR Gate |
| Android smoke final | passou, exit code 0, 25.127 ms | `test_artifacts/test_ci_performance/android_smoke/2026-07-28T113920Z/` |
| Upgrade `1.1.5+7 → 1.1.6+8` | passou | `test_artifacts/release/v1.1.6/upgrade/1.1.5-2026-07-28T113016Z/` |
| Build release | passou | `build/app/outputs/flutter-apk/app-release.apk` |
| Verificação APK | passou | package, versão, versionCode, v2 e certificado validados pelo verificador do projeto |
| Auditoria VERITAS | arte, fluxo, versão, APK e upgrade confirmados; dois blockers documentais foram corrigidos | performance persistida e este relatório reconciliado |
| CI do PR | executado apenas depois do push | merge e publicação permanecem bloqueados até todos os checks ficarem verdes |

O PR Gate final foi executado sobre o código cumulativo, incluindo a adaptação landscape e a correção do integration test. O smoke abriu a app real, confirmou a landing EFT, reutilizou o perfil de laboratório, abriu o seletor canónico, confirmou sete contextos e regressou ao treino sem exceções. A criação de perfil com dados limpos foi validada no smoke anterior.

## Performance

Ambiente: `EveFit_Test_Device`, Android 16/API 36, x86_64, APK release, dados preservados, processo terminado antes de cada arranque. A métrica comparável é `am start -W TotalTime`.

| Versão | Runs (ms) | Mediana | Pior |
|---|---|---:|---:|
| `1.1.5+7` pública | 843, 912, 924 | 912 ms | 924 ms |
| `1.1.6+8` candidata | 907, 939, 900 | 907 ms | 939 ms |

- Variação da mediana: `-0,55%`.
- Exceções fatais, ANR, OOM e `E/flutter`: zero nas três runs do candidato.
- As três capturas feitas 350 ms depois de `am start -W` mostram a landing renderizada.
- O aviso `Skipped ... frames` foi intermitente no AVD nas duas versões: uma run na v1.1.5 e duas runs na v1.1.6. Não foi observada uma regressão consistente nem frame vazio no candidato, mas o aviso fica registado como risco residual do emulador.

Artefactos:

- Baseline: `test_artifacts/release/v1.1.6/performance/baseline-v1.1.5-2026-07-28T115005Z/`
- Candidato final: `test_artifacts/release/v1.1.6/performance/final-target-2026-07-28T115050Z/`

## Upgrade e dados

O teste instalou a v1.1.5 pública e atualizou por cima para a v1.1.6 sem limpar dados.

- `user_version`: 22 → 22
- schema: idêntico
- violações de foreign keys: 0 → 0
- profiles: 1 → 1
- body_measurements: 1 → 1
- goals: 1 → 1
- workouts: 1 → 1
- workout_exercises: 1 → 1
- workout_sets: 1 → 1
- exercises históricos: 1 → 1
- marcadores de perfil, medição, objetivo, treino, exercício, set, preferências e join histórico: preservados
- dashboard_widgets: 1 → 57 por composição normal da versão atual, sem perda

## APK candidato

- Ficheiro: `EveFit-v1.1.6-eft-landing-release.apk`
- Caminho local: `dist/releases/EveFit-v1.1.6-eft-landing-release.apk`
- Bytes: `58992433`
- Tamanho: `56,26 MiB`
- SHA-256: `E889AE74F644A633A0BBC84904171FE3412845BB9B402754876AB2CF2CE23CA5`
- Package: `com.sandro.evefittracker`
- versionName: `1.1.6`
- versionCode: `8`
- APK Signature Scheme v2: `true`
- Certificado SHA-256: `59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B`

## Evidência visual

- Landing portrait: `test_artifacts/release/v1.1.6/visual/2026-07-28T112354Z/01_landing_portrait.png`
- Seleção de perfil: `test_artifacts/release/v1.1.6/visual/2026-07-28T112354Z/02_profile_selection_portrait.png`
- Landscape/wide final: `test_artifacts/release/v1.1.6/visual/2026-07-28T112354Z/05_landing_wide_viewport.png`
- Landing depois do upgrade: `test_artifacts/release/v1.1.6/upgrade/1.1.5-2026-07-28T113016Z/screenshots/00_eft_landing_after_upgrade.png`

`03_landing_landscape.png` antecede a correção de enquadramento e `04_landing_landscape_corrected.png` é portrait; nenhum deles é usado como evidência final landscape.

## Acessibilidade

- Semântica de botão, nome da ação, toque alternativo, áreas de toque, texto ampliado, ecrã pequeno, ecrã alto, landscape, nomes longos e redução de movimento têm cobertura automatizada.
- O CTA continua nativo em Flutter e não está incorporado na imagem.
- Não foi executada uma sessão manual de TalkBack; este ponto permanece como limitação de validação manual, sem bloquear a semântica automatizada verde.

## Auditoria de escopo

- Dashboard: inalterado.
- Base de dados e migrations: inalteradas.
- Ontologia, catálogo e domínio de treino: inalterados.
- Lógica persistida de perfis e PIN: inalterada.
- Os dois ficheiros untracked conhecidos permanecem fora do stage e dos commits.
- APK, `build/`, `.dart_tool/`, `dist/` e `test_artifacts/` permanecem fora do Git.

## Riscos restantes

- A imagem portrait é apresentada com side-fill escurecido em ecrãs landscape muito largos para preservar todo o lettering EFT sem deformação.
- O warning de frames do AVD é intermitente também na baseline; deve continuar a ser observado em hardware físico.
- TalkBack foi validado por contrato semântico automatizado, não por sessão manual.

## Rollback

O rollback de código consiste em reverter os commits da v1.1.6. A atualização não altera schema nem dados e não requer rollback destrutivo. A tag e a release só serão criadas depois de CI verde e revalidação da main integrada.

## Estado

Candidato local aprovado para PR. Merge, tag e publicação dependem de CI verde, ausência de novos findings altos/críticos e revalidação final da main.
