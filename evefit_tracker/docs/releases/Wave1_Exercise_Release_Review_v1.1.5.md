# EveFit Wave1 Exercise Release Review v1.1.5

## 1. Pull Request

- PR: [#21 - EveFit Wave1 - 49 exercicios canonicos nao musculares](https://github.com/ryoken99/evefit_tracker/pull/21)
- Estado inicial: aberto, draft, mergeable e checks verdes.
- Estado final, merge SHA e release: preenchidos no relatorio operacional depois dos gates remotos.

## 2. Branch

- Branch: `feature/wave1-non-muscular-exercises-v0.1`
- Base: `origin/main`
- SHA base: `f34ed6952cf2a384c167a09b2902d764d090da03`

## 3. SHAs

- Head inicial revisto: `0979326180fc37c04c5df1cfef7becd45554c0e7`
- Head final: pendente do commit de correcoes.
- Main final: pendente do merge.

## 4. Revisao independente

Foram executadas oito revisoes read-only independentes, todas auditadas pelo
Sol:

| Area | Resultado |
| --- | --- |
| A. Fontes e integridade | Hashes, checksums internos, ZIPs, UTF-8, NFC, joins e contagens passaram. Finding low: o diagnostico auxiliar de combining marks nao substitui uma normalizacao Unicode geral; nao houve divergencia nas fontes aprovadas. |
| B. Relacoes e ontologia | Contagens, roles, variantes e percursos passaram. Finding low: cobertura incompleta de queries invalidas. Corrigido com casos incompletos, invertidos, duplicados e desconhecidos. |
| C. UI e navegacao | Finding high: confidence tecnico visivel em parte do conteudo. Finding medium: duas acoes semanticas concorrentes no card. Finding low: falta de renderizacao integral dos 49 no viewport alvo. Todos corrigidos. |
| D. Conteudo publico PT-PT | Findings high: valores tecnicos de confidence e `Implementacao realizada: nao`. Findings medium: auditoria publica incompleta e duas incorrecoes gramaticais. Todos corrigidos na projecao publica gerada. |
| E. Seguranca e risco | Distribuicao 22 low, 18 moderate e 9 high confirmada. Finding editorial: valor cru `sim`; removido da projecao publica. Avisos e niveis de risco nao foram reduzidos. |
| F. Exclusoes e falha fechada | Findings medium: flag de exercicios ativos ainda falsa e validacao apenas do ID da relacao. Corrigidos com flag verdadeira e unicidade do tuple completo, incluindo ausencia de sobreposicao active/deferred. |
| G. Persistencia e migrations | Sem findings. Zero escrita em workouts, schema 22, zero migration e historico isolado. |
| H. Testes, performance e release | Findings high: versao/release ainda 1.1.4 e upgrades 1.1.3/1.1.4 ausentes. Findings medium: workflow sem verificacao pos-upload. Corrigidos com 1.1.5+7, harness duplo e verificacao do asset publicado. |

Depois das correcoes nao permanecem findings blocker ou high abertos.

## 5. Correcoes

- A projecao publica gerada remove sentinelas, enums e notas editoriais internas.
- Duas frases PT-PT foram corrigidas sem alterar os ZIPs ou a especificacao.
- O confidence publico conserva apenas texto narrativo apropriado.
- Cada card de exercicio possui uma unica acao semantica.
- As queries invalidas e os tuples de relacao falham fechados.
- A flag Clean Base reconhece os 49 exercicios ativos sem reativar legacy.
- Foi adicionada renderizacao controlada dos 49 detalhes no viewport logico do
  Google Pixel 8 Pro (`448 x 998`).
- O harness de upgrade valida tanto 1.1.3+5 como 1.1.4+6, sem desinstalacao
  entre baseline e 1.1.5.
- O workflow verifica package, versao, certificado, checksum e igualdade do
  asset descarregado depois da publicacao.

## 6. Contagem real das secoes

- Cabecalho: 1 bloco estrutural.
- Conteudo publico aprovado: 18 secoes possiveis, na ordem canonica.
- Aviso high-risk: bloco condicional separado, mostrado antes das instrucoes.
- O aviso high-risk nao conta como uma das 18 secoes de conteudo.
- Assim, existem 19 blocos estruturais base (cabecalho + 18 secoes) e 20 num
  high-risk quando o aviso separado esta presente. Campos nao aplicaveis
  continuam omitidos sem criar secoes artificiais.

## 7. Exercicios e relacoes

- Exercicios: 49.
- Tipos: 38 canonical exercise, 8 technique drill e 3 variants.
- IDs, nomes e conteudos detalhados unicos: 49.
- Relacoes publicas ativas: 88.
- Percursos: 54.
- Intencoes abrangidas: 50.
- Roles: 34 principal candidate, 44 alternative primary e 10 complementary.
- Variantes: `sled_resisted_sprint`, `supine_hamstring_strap_stretch` e
  `treadmill_walking`, cada uma com a base aprovada preservada.

## 8. Exclusoes

- 66 relacoes conditional permanecem desativadas e fora do provider publico.
- 52 pending review, 25 specialist review, 159 candidatos musculares e 13
  relacoes conditional de exercicios nao aprovados permanecem excluidos.
- Nao existe fallback legacy, prescricao, media, dose ou acao de adicionar ao
  treino.

## 9. Risco

- Distribuicao: 22 low, 18 moderate e 9 high.
- Os nove high-risk mantem aviso anterior as instrucoes, supervisao,
  pre-requisitos, espaco e saida segura aplicaveis.
- Nenhum nivel ou aviso foi reduzido e nao foi introduzido aconselhamento
  clinico.

## 10. Versao, schema e dados

- Version name: `1.1.5`.
- Version code: `7`.
- Flutter: `1.1.5+7`.
- Package: `com.sandro.evefittracker`.
- Schema SQLite: `22`, inalterado.
- Migrations: zero.
- Dashboard, Goals, Profile, logica de workouts e historico: sem alteracao
  funcional.

## 11. Fontes e gerador

| Fonte | SHA-256 |
| --- | --- |
| Pacote tecnico | `3393bde5d0d3980e823240effac9213ff6f6d3e90148990628e2e216f9287b71` |
| Conteudo publico | `35296706fd2abb6f821324f80c8aafc091a944fba9007e3fb933f2046da3b279` |
| Especificacao canonica | `9c6c65caa36e785bd82c4d8e4f5d37e1d21e3a974f9676d80658a82d10d9911c` |

Os tres blobs aprovados permanecem inalterados. `report`, `generate`, `check`
e uma segunda geracao passaram; seis outputs efetivamente gerados foram
comparados byte a byte e foram deterministas.

## 12. Testes e analyze

- Baseline pre-correcao: 20 testes Wave1 e analyze passaram.
- Testes de contratos de versao/release/Clean Base: 23 passaram.
- Canonical core completo: 102 passaram.
- Fast Gate final: passou em 10,062 s.
- PR Gate final: passou em 201,962 s.
- Shards: 705 testes (`247 + 144 + 157 + 157`), todos verdes.
- Manifest: passou.
- `flutter analyze`: passou, zero issues.
- Nao foram adicionados skips.

## 13. Android

- Dispositivo: `EveFit_Test_Device`, perfil Google Pixel 8 Pro.
- Android smoke final: passou em 29,246 s.
- Full-app com `app.main()`: passou com exit code 0.
- Validou instalacao limpa, perfil, treino, sete contextos, lista Wave1,
  variante high-risk, detalhe longo, vazios, Back, Home, Dashboard, Perfil,
  Objetivos e Treinos.
- Excecoes Flutter/Hero e legacy visivel: zero.
- Artefactos full-app:
  `test_artifacts/workout_exercise_selector_roots/full_app/2026-07-25T001651Z/`.

## 14. Upgrades

- `1.1.3+5 -> 1.1.5+7`: passou.
- `1.1.4+6 -> 1.1.5+7`: passou.
- Instalacao efetuada com `adb install -r`, sem desinstalacao entre versoes.
- Profiles, body measurements, goals, workouts, workout exercises e workout
  sets permaneceram `1 -> 1`.
- Preferencia de Dashboard e join com exercicio historico permaneceram
  acessiveis.
- Foreign keys validas; schema e `user_version` permaneceram 22.
- Artefactos:
  `test_artifacts/release/v1.1.5/upgrade/1.1.3-2026-07-25T002556Z/` e
  `test_artifacts/release/v1.1.5/upgrade/1.1.4-2026-07-25T002810Z/`.

## 15. Performance

- Baseline main: 2126, 2155 e 2147 ms; mediana 2147 ms.
- Wave1 revista: 2230, 2100 e 2286 ms; mediana 2230 ms.
- Diferenca: +83 ms, +3,87%.
- Dispersao Wave1: 186 ms entre minimo e maximo.
- Legacy seed invocations: 0; legacy entries processed: 0.
- Resultado: abaixo do limiar de investigacao de 5% e do bloqueio de 10%.

## 16. Build e assinatura

- `flutter build apk --release`: passou.
- APK local:
  `test_artifacts/release/v1.1.5/EveFit-v1.1.5-wave1-non-muscular-exercises-release.apk`.
- Tamanho: 57 707 549 bytes (55,03 MiB).
- SHA-256: `9D146D9F1168A3402FFA471D8BEFA22430791F2C925F05450A29FDA1FAFA1B0D`.
- APK Signature Scheme v2: verdadeiro.
- Certificado: `C=US, O=Android, CN=Android Debug`.
- Certificado SHA-256:
  `59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B`.
- A classificacao correta e release build com a configuracao de assinatura
  atual; nao e apresentada como assinatura Play Store.

## 17. Merge, tag, release e asset

- Head final: pendente.
- Merge SHA: pendente.
- Tag: `v1.1.5`, pendente.
- GitHub Release: `EveFit v1.1.5`, pendente.
- Asset e validacao pos-release: pendentes dos gates remoto e de main.

## 18. Untracked preservados

- `15_ARTES_MARCIAIS_EXERCICIOS_DERIVADOS.md`
- `docs/catalog_reports/v0.9.4/menu_matrix_review_pack.zip`

Nenhum foi lido como fonte, alterado, adicionado ao stage ou incluido no APK.

## 19. Limitacoes

- As 66 relacoes conditional permanecem indisponiveis.
- Conteudo muscular, media e prescricao permanecem fora do ambito.
- Os exercicios ainda nao podem ser adicionados diretamente a um treino.
- Equipamento e ambiente sao informativos, nao filtros.
- O diagnostico auxiliar de combining marks nao e uma biblioteca geral de
  normalizacao Unicode; os blobs concretos aprovados passaram a validacao NFC.

## 20. Rollback

Antes da publicacao, suspender o merge/release quando um gate falhar. Depois do
merge, usar `git revert` dos commits da Wave1 e das correcoes; nao reescrever
main. Como nao existe migration, seed ou escrita nos workouts, o rollback nao
exige downgrade de schema e nao elimina dados pessoais ou historicos. Se o
problema estiver apenas no asset publicado, substituir apenas o asset depois
de repetir hash, identidade e assinatura, sem mover a tag.
