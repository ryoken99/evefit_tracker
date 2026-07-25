# EveFit v1.1.5 - Hotfix Linux do verificador de APK

## Escopo

Esta correção trata exclusivamente a falha do workflow de release:

`apksigner did not return the signer SHA-256 certificate digest.`

- Branch: `fix/release-apksigner-linux-parser-v1.1.5`
- Base: `fea71d2d142b88703963118b2769bb7f2a0784f6`
- PR de origem: `#21`, merged
- Workflow falhado: run `30137627848`, job `89624620398`
- Versão preservada: `1.1.5+7`
- Certificado aprovado: `59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B`

Não foram alteradas funcionalidades da app, exercícios, relações, conteúdo
público, schema SQLite, migrations, package name, applicationId, signing,
workouts ou dados do utilizador.

## Causa reproduzida

O runner que executou o workflow usou a imagem
`ubuntu-24.04/20260720.247.2`. O manifesto oficial dessa imagem contém Android
Build Tools `37.0.0`, `36.1.0`, `36.0.0` e versões anteriores. O verificador
seleciona deliberadamente a versão mais alta.

Build Tools 36.0.0 produz:

```text
Signer #1 certificate SHA-256 digest: 59042d19...
```

Build Tools 37.0.0 produz:

```text
Number of signers: 1
V2 Signer: certificate SHA-256 digest: 59042d19...
```

O parser anterior reconhecia apenas a designação `Signer #1`. A alteração para
`V2 Signer:` foi reproduzida com o `apksigner` 37.0.0 real e explica a mensagem
de digest ausente. A saída foi capturada separando stdout, stderr, exit code,
versão, diretório de Build Tools e representação hexadecimal dos bytes.

Artefactos locais ignorados pelo Git:

- `test_artifacts/release/v1.1.5/linux-reproduction/apksigner37-capture-*`
- `test_artifacts/release/v1.1.5/linux-reproduction/clean-build-3448-persistent-*`

## Correção

O parser agora:

- normaliza LF, CRLF e espaços periféricos linha a linha;
- aceita as designações observadas `Signer #1` e `V2 Signer:`;
- aceita digest contínuo ou separado por dois-pontos, em qualquer case;
- exige exatamente 64 caracteres hexadecimais após normalização;
- exige exatamente um signer;
- rejeita ausência, formato inválido, SHA-1 isolado, digests contraditórios e
  múltiplos signers;
- continua a exigir APK Signature Scheme v2 igual a `true`;
- continua a validar package, versionName, versionCode e certificado aprovado;
- inclui versão do `apksigner` e linhas não sensíveis de stdout/stderr nos erros
  de extração.

O workflow continua a verificar o APK antes de o preparar e publicar. Foi
adicionado diagnóstico seguro da versão das Build Tools e um integration test
obrigatório, executado com o APK e Android SDK reais antes do upload.

## Testes

Foram cobertos:

- saída Linux 37.0.0 capturada e formato Windows anterior;
- LF, CRLF, espaços, stdout, stderr e linhas adicionais;
- digest contínuo, com dois-pontos, maiúsculas e minúsculas;
- digest ausente, curto, longo, inválido e SHA-1 sem SHA-256;
- v2 ausente, falso ou contraditório;
- package, versionName, versionCode e certificado incorretos;
- digests contraditórios e múltiplos signers;
- diagnóstico seguro com origem do stream e versão;
- execução real do `aapt` e `apksigner`.

Resultados locais:

- `flutter pub get`: passou
- `dart format --set-exit-if-changed .`: passou, 340 ficheiros sem alterações
- `flutter analyze`: passou, zero issues
- testes focados do verificador: 13 passaram
- Fast Gate: passou
- PR Gate: passou
- suíte manifestada: 714 testes passaram em quatro shards
- Android smoke: passou no `EveFit_Test_Device`
- build release: passou
- verificação Windows, Build Tools 36.0.0: passou
- verificação Linux, Build Tools 37.0.0: passou
- teste negativo com certificado diferente: rejeitado com exit code 1

O primeiro PR Gate executado passou os quatro shards e falhou apenas porque o
novo integration test ainda não estava no manifesto. O teste foi adicionado ao
shard 4; a validação do manifesto e o PR Gate completo passaram na repetição.

## APK validado

- Caminho: `build/app/outputs/flutter-apk/app-release.apk`
- Tamanho: `57,707,549` bytes
- SHA-256: `9D146D9F1168A3402FFA471D8BEFA22430791F2C925F05450A29FDA1FAFA1B0D`
- Package: `com.sandro.evefittracker`
- versionName: `1.1.5`
- versionCode: `7`
- APK Signature Scheme v2: `true`
- Certificado SHA-256:
  `59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B`

## Ficheiros

Alterados:

- `.github/workflows/release.yml`
- `tool/release/release_apk_verifier.dart`
- `test/release/release_apk_verifier_test.dart`
- `tool/testing/test_shards.json`

Criados:

- `test/release/release_apk_verifier_integration_test.dart`
- `docs/releases/EveFit_v1.1.5_Apk_Verifier_Linux_Hotfix_Report.md`

## Estado remoto e publicação

O PR corretivo, a respetiva quality gate e os SHAs de integração são registados
no relatório operacional final depois da execução remota.

Nesta fase:

- a tag `v1.1.5` não é movida, apagada nem recriada;
- a release `v1.1.5` permanece inexistente;
- nenhum asset é publicado;
- o run falhado antigo não é repetido.

## Riscos e rollback

O parser permanece fail-closed. Uma futura designação de signer não observada,
um certificado diferente ou uma assinatura sem v2 continua a bloquear a
release com diagnóstico explícito.

Uma build efetuada num runner limpo sem acesso à chave debug aprovada gera um
certificado efémero diferente. Depois deste hotfix, essa situação deixa de ser
mascarada como erro de parsing e passa a falhar corretamente por certificado
incompatível. Disponibilizar a chave aprovada ao CI é uma decisão operacional de
signing fora do escopo desta correção e continua obrigatório antes de uma nova
execução por tag, caso o runner de release não possua essa chave.

Rollback seguro: reverter o merge do PR corretivo. Não existe alteração de
dados, schema, versão, tag ou release para desfazer.
