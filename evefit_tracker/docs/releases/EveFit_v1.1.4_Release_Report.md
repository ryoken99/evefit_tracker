# EveFit v1.1.4 — Release Report

## Preparação

- Base da release: `fdd39c25baf3ab9176651d0f12f9de97911fd03d`.
- Branch de release: `release/v1.1.4-seven-contexts-training-intentions`.
- Versão anterior: `1.1.3+5`.
- Versão alvo: `1.1.4+6`.
- Package Android: `com.sandro.evefittracker`.

Este relatório é preparado antes da publicação. Campos que requerem execução na branch de release, CI remoto, tag ou GitHub Release permanecem explicitamente pendentes até terem evidência operacional.

## Contrato de produto

| Elemento | Total |
| --- | ---: |
| Contextos ativos | 7 |
| Capacidades ativas | 8 |
| Conceitos ativos | 35 |
| Relações capacidade-conceito | 40 |
| Percursos | 280 |
| Percursos compatíveis | 261 |
| Percursos incompatíveis | 19 |
| Intenções globais | 591 |
| Ligações percurso-intenção | 771 |
| Atributos oficiais | 0 |
| Exercícios canónicos | 0 |
| Subníveis | 0 |

O fluxo ativo é `Contexto → Capacidade → Conceito → Intenção → Exercícios`. A query final é progressiva e contém quatro critérios tipados. Não existem `exercise_ids`, IDs legacy, `parent_id`, resultados fictícios ou fallback para o catálogo antigo.

## Integridade e preservação

- Fontes v0.4 e v0.4.1 verificadas contra hashes SHA-256 dos blobs Git brutos.
- 693 IDs e 792 ocorrências históricas validados integralmente.
- O histórico v0.3 não é carregado no runtime nem incluído no APK como dados funcionais.
- Schema 22: inalterado.
- Migrations: nenhuma adicionada.
- Catálogo legacy e árvore antiga: fora do runtime.
- Perfis, medições, objetivos, treinos, séries, preferências, fotos e histórico: preservados por contrato e pela validação funcional de instalação existente.

## Evidência funcional já recolhida

| Gate ou verificação | Resultado |
| --- | --- |
| Geração determinística e hashes de fonte | PASS |
| Fast Gate funcional | PASS, 14,232 s |
| PR Gate funcional | PASS, 275,801 s |
| Shards locais | PASS, 678 testes (`238 + 144 + 149 + 147`) |
| Android smoke em `EveFit_Test_Device` | PASS |
| Fluxo Android completo Pixel 8 Pro | PASS, 11 screenshots, sem exceção Flutter ou Hero |
| Instalação existente v1.1.3+5 | PASS, schema 22 e foreign keys preservadas |
| Build funcional `1.1.3+5` | PASS, apenas como evidência funcional |

Os artefactos locais e os relatórios de implementação permanecem em `test_artifacts/` ignorado e em `docs/canonical/`. Não são anexados ao repositório nem tratados como resultado de release.

## Validação da branch de release

| Gate ou verificação | Resultado |
| --- | --- |
| Metadados públicos | PASS, `1.1.4+6` |
| Fast Gate | PASS, 11,504 s |
| PR Gate | PASS, 281,062 s |
| Shards do PR Gate | PASS, 678 testes (`238 + 144 + 149 + 147`) |
| Release Gate consolidado | PASS, 484,034 s |
| Catalog audit strict | PASS, 43,548 s |
| Android smoke | PASS, 28,571 s |
| Full-app Android | PASS, 38,104 s e 11 screenshots |
| Build APK release | PASS, 6,521 s |
| Upgrade `1.1.3+5 → 1.1.4+6` | PASS, 129,593 s |

O full-app foi executado no `EveFit_Test_Device`, configurado como Pixel 8 Pro, e os artefactos encontram-se em `test_artifacts/workout_exercise_selector_roots/full_app/2026-07-21T014624Z/`. O upgrade está em `test_artifacts/release/v1.1.4/upgrade/2026-07-21T014710Z/` e confirmou schema 22 inalterado, foreign keys válidas, histórico acessível, sete contextos visíveis, confirmação explícita da intenção e legacy invisível.

A primeira execução do Release Gate detetou uma dependência de encoding nos literais PT-PT do novo harness sob Windows PowerShell 5.1. A verificação foi tornada independente de encoding através de fragmentos ASCII únicos limitados a botões Android, ganhou teste de regressão e o Release Gate completo foi repetido desde o início com sucesso.

### APK local validado

- Nome: `EveFit-v1.1.4-seven-contexts-training-intentions-release.apk`.
- Caminho local: `test_artifacts/release/v1.1.4/EveFit-v1.1.4-seven-contexts-training-intentions-release.apk`.
- Package: `com.sandro.evefittracker`.
- Version name: `1.1.4`.
- Version code: `6`.
- Tamanho: `55.282.657` bytes.
- SHA-256: `0030A72EAE5FAC516A8D9AA6D1441393C71137872E591A31B67D44D82834ECB3`.
- Assinatura: APK Signature Scheme v2.
- Certificate subject: `C=US, O=Android, CN=Android Debug`.
- Certificate SHA-256: `59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B`.

Esta é uma build release com a configuração de assinatura atual do projeto. O certificado é compatível com o APK `1.1.3+5` usado no upgrade, mas não deve ser apresentado como assinatura de produção Play Store.

## Desempenho funcional

| Medição | Main autorizada | Implementação funcional | Delta |
| --- | ---: | ---: | ---: |
| Perfil pronto | 4.181 ms | 4.349 ms | +4,02% |
| Abrir seletor, smoke limpo | 128 ms | 125 ms | -2,34% |
| Abrir seletor, full-app | 129 ms | 129 ms | 0,00% |
| APK debug | 179.285.322 bytes | 179.301.706 bytes | +16.384 bytes (+0,009139%) |
| APK release | 54.233.809 bytes | 55.282.657 bytes | +1.048.848 bytes (+1,933938%) |

Não foi observada regressão reprodutível de arranque ou abertura do seletor acima do limiar de investigação de 25%. A medição e inspeção do APK de release foram repetidas na versão `1.1.4+6`.

## Gates pendentes antes de publicar

| Gate | Estado |
| --- | --- |
| Atualizar metadados para `1.1.4+6` | PASS |
| Fast/PR/Release Gate na branch de release | PASS |
| Quality gate remoto do PR de release | PENDENTE |
| Upgrade `1.1.3+5 → 1.1.4+6` | PASS |
| APK release, assinatura, tamanho e SHA-256 | PASS |
| Merge da release e validação repetida em main | PENDENTE |
| Tag anotada `v1.1.4` | PENDENTE |
| GitHub Release estável/latest e asset | PENDENTE |

Nenhum URL de release, tag, hash de APK, certificado ou resultado de CI é declarado antes de estar efetivamente disponível.

## Riscos e rollback

O risco técnico principal é a dimensão da registry gerada. O gerador determinístico, os hashes de fonte, os testes de contagem, o APK e as medições de interface são obrigatórios para reduzir esse risco.

O rollback é um revert normal do merge de funcionalidade ou de release. Não há downgrade de base de dados necessário, porque schema, migrations e dados pessoais não são alterados. Não publicar quando qualquer gate obrigatório estiver vermelho.
