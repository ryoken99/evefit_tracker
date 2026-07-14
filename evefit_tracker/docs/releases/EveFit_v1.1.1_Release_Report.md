# EveFit v1.1.1 - Release Report

## Proveniência

- PR Canonical Core: [#10](https://github.com/ryoken99/evefit_tracker/pull/10)
- Head PR #10: `75951c17fc973a45028fc6549d6d40690b2d02aa`
- Merge PR #10: `85993339e802706f3d266fbcca08d7aae2c1c79a`
- Branch de release: `release/v1.1.1-canonical-core`
- PR de release: [#11](https://github.com/ryoken99/evefit_tracker/pull/11)
- Head de código validado antes da documentação: `461b472`
- Head final de release: por determinar depois do commit documental
- Merge de release: por determinar
- Main final: por determinar
- Tag: `v1.1.1` por criar
- URL: `https://github.com/ryoken99/evefit_tracker/releases/tag/v1.1.1`

## Versão e Android

- VersionName: `1.1.1`
- VersionCode anterior: `2`
- VersionCode final: `3`
- Package: `com.sandro.evefittracker`
- Certificado validado: Android Debug, SHA-256 `59042d19d9b0cea872a34cd0d1fd3a268f322b8819d1d6e3849b5761db17230b`
- APK: `EveFit-v1.1.1-canonical-core-release.apk`
- APK candidato da branch: 54.103.789 bytes, SHA-256 `7ef90cc7098b9bbe96ea96ea569dc24e6d67754842f0590c785c6f70a6a7e8ae`
- APK final: será reconstruído e medido a partir da main final

## Escopo canónico

- Eixos: 4
- Raízes: 8
- Contextos: 4
- Valores classificatórios: 12
- Intenções: 0
- Conceitos: 0
- Atributos: 0
- Subníveis: 0
- Exercícios: 0
- `main_training`: ausente
- `exercise_ids`: ausente
- Legacy no runtime: ausente

## Compatibilidade

- Schema e migrations: inalterados
- Dados pessoais: preservados no upgrade oficial v1.1.0 para v1.1.1
- Contagens antes/depois: perfis `1/1`, medições `1/1`, objetivos `1/1`, treinos `1/1`, sets `0/0`, workout exercises `0/0`, exercises `0/0`
- Foreign keys: válidas, zero violações
- Históricos v1.1.0 permitidos: treino preservado e aberto; a instalação limpa oficial não continha exercícios ativos
- Tag e release v1.1.0: inalteradas

## Gates

- `flutter pub get`: passou
- `dart format --set-exit-if-changed .`: passou, 273 ficheiros sem alterações no gate final
- `flutter analyze`: passou, zero issues
- Testes focados: 31 passaram (20 Canonical Core, 9 Clean Base, 2 metadata)
- Suíte completa: 585 passaram em 21m15s
- Full-app clean install: 3/3 runs passaram, exit code 0
- Upgrade v1.1.0 para v1.1.1: passou com APK oficial, `adb install -r` e dados preservados
- Build debug: passou
- Build release: passou
- Quality gate PR #10: passou em 13m55s
- Quality gate release: pendente
- Quality gate main final: pendente

## Performance

Ambiente: `EveFit_Test_Device`, Android 16/API 36, x86_64, debug, commit de
versão `10b155f`:

| Run | Primeiro ecrã | Explorar | Capacidade | Vazio capacidade | Contexto | Vazio contexto |
|---|---:|---:|---:|---:|---:|---:|
| 1 | 6213 ms | 119 ms | 357 ms | 119 ms | 117 ms | 106 ms |
| 2 | 1409 ms | 115 ms | 352 ms | 116 ms | 117 ms | 119 ms |
| 3 | 1501 ms | 114 ms | 356 ms | 120 ms | 115 ms | 110 ms |
| Mediana | **1501 ms** | **115 ms** | **356 ms** | **119 ms** | **117 ms** | **110 ms** |
| Pior | **6213 ms** | **119 ms** | **357 ms** | **120 ms** | **117 ms** | **119 ms** |

O primeiro arranque foi um outlier não reproduzido. A mediana de 1501 ms e os
tempos de pesquisa mantêm a referência da v1.1.0, sem regressão consistente.

## Artefactos de validação

- Full-app: `test_artifacts/canonical_core/full_app/2026-07-14T011436Z/`
- Full-app: `test_artifacts/canonical_core/full_app/2026-07-14T011554Z/`
- Full-app: `test_artifacts/canonical_core/full_app/2026-07-14T011637Z/`
- Upgrade: `test_artifacts/release/v1.1.1/upgrade/2026-07-14T012823Z/`
- Suíte: `test_artifacts/release/v1.1.1/unit/flutter_test_full_branch_retry.log`

O primeiro invólucro da suíte atingiu o timeout operacional de 20 minutos no
teste pesado de near-duplicates. O processo órfão foi terminado e a mesma suíte,
sem alterações ou redução de cobertura, passou com limite de 45 minutos.

## Riscos conhecidos

- A pesquisa permanece vazia por decisão de produto.
- Intenções, conceitos e atributos dependem de aprovação futura.
- O APK usa a configuração de assinatura debug existente e não deve ser assumido
  como build Play Store sem verificação adicional.
