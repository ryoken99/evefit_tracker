# EveFit Arm Muscular Foundation v0.1

## Estado do relatório

Relatório técnico factual da implementação da fundação muscular e dos principais exercícios de braços. Todos os gates técnicos anteriores ao commit e ao Draft PR foram concluídos.

## Identificação

- Base SHA: `d6345b9c87433f1d1184e40ad12d5c9f62041bf5`
- Branch de trabalho: `feature/arm-muscular-foundation-v0.1`
- Versão preservada: `1.1.6+8`
- Schema preservado: `22`
- Package: `com.sandro.evefittracker`
- PR: criado como Draft após o commit; URL e head são registados no relatório operacional final.
- Commit de integração: o commit que inclui este documento.
- HEAD final: o head do Draft PR, registado no relatório operacional final.

## Fontes e integridade

O bundle de planeamento foi validado antes da implementação:

- Bundle: `EveFit_Arm_Muscular_Implementation_Planning_v0.1.zip`
- SHA-256 do bundle: `73026221DAB1362878281A5FED86D1119244671E94C5CE7F3AA21836DF0E2C41`
- Entradas: 15
- Payloads verificados contra `SHA256SUMS`: 14/14

Fontes canónicas preservadas no repositório:

- Base muscular: `docs/canonical/source/muscular/v0.1.1/EveFit_Muscular_Knowledge_Base_v0.1.1.zip`
- SHA-256: `a1876a1d4bc21ab54b3828774f66a99519a4953dc00191e69475d8c15b8b30b0`
- Catálogo de braços: `docs/canonical/source/exercises/arms/v0.1/EveFit_Principal_Arm_Exercise_Catalogue_v0.1.zip`
- SHA-256: `247b9c6b36e3dd93d7b9c4fc4e6569c2b71eb9c710b8fb2b9ba62ebc86dfd71f`

Os ZIPs foram verificados por CRC, hashes internos, conjunto exato de membros, ausência de path traversal, UTF-8/LF/NFC e ausência de ficheiros duplicados.

## Arquitetura e geração

O módulo está isolado em `lib/features/canonical_core/` e separa modelos, repositório, dados gerados, UI e geração de fontes.

Gerador:

- `tool/canonical/generate_arm_muscular_registry.dart`
- `generate`: PASS
- `check`: PASS
- `report`: PASS
- O gerador valida fontes, contratos, IDs, referências, pais, estados, relações, colisões Wave1, regras de exposição e drift de outputs.

Outputs principais:

- `docs/canonical/generated/arm_muscular_v0.1_manifest.json`
- `lib/features/canonical_core/generated/arm_muscular_registry.g.dart`
- `lib/features/canonical_core/generated/muscular/`
- `lib/features/canonical_core/generated/exercises/arms/`
- O maior output relacional tem 704.912 bytes, abaixo do limite de 750 KiB.

O runtime consome dados tipados gerados através de `GeneratedCanonicalMuscularRepository`; não faz parsing dos ZIPs, não consulta a base de dados, não importa o catálogo legacy e não usa listas fixas de exercícios para representar filtros.

## Counts e projeção

Counts internos validados:

- Regiões: 16
- Grupos musculares: 45
- Músculos: 179
- Componentes: 36
- Articulações: 35
- Ações: 94
- Relações: 365 músculo-articulação, 484 músculo-ação e 394 interações musculares
- Relações totais registadas no gerador: `1243`
- Regras de treinabilidade: 179

Projeção pública:

- Regiões públicas: 2
- Grupos públicos: 7
- Músculos públicos: 23

Braços:

- Entradas internas: 36
- Entradas públicas: 35
- Variantes internas: 85
- Exercícios públicos sem limitação adicional: 29
- Exercícios limitados: 6
- Exercício especialista interno: 1
- Variantes limitadas: 21

Regras e casos obrigatórios preservados:

- `resisted_thumb_opposition` permanece interno e nunca é público.
- `coracobrachialis` permanece visível apenas como entrada honesta sem exercícios.
- `towel_hang` é filho de `dead_hang`.
- As variantes são filtradas como descendentes do exercício/família selecionado.
- A limitação de grip permanece separada da secção de papel muscular.
- Os resultados públicos são deduplicados e apresentados com o papel muscular mais forte.

## UI e fluxo

A entrada UI é condicionada ao conceito `muscular_capacity` e aparece no seletor como `Explorar por anatomia`. O fluxo implementado é:

`Corpo superior -> Braço/Antebraço -> Grupo -> grupo completo ou músculo -> exercícios`

Ecrãs adicionados:

- `MuscularAnatomyBrowserScreen`
- `CanonicalMuscleDetailScreen`
- `CanonicalArmExerciseDetailScreen`

Casos obrigatórios cobertos:

- navegação por breadcrumb, Back, Home e system back;
- projeção 2 regiões / 7 grupos / 23 músculos;
- grupo de bíceps e detalhe muscular;
- `dead_hang` com `towel_hang`;
- `coracobrachialis` com estado vazio explícito;
- exclusão de `resisted_thumb_opposition`;
- detalhes com família, equipamento, músculo primário, articulações e acções em PT-PT;
- aviso/cautela upfront quando aplicável;
- ausência de seleção automática de exercícios para um treino.

## Isolamento e limites

- Relações com os quatro pilares: `0`.
- Alterações ao schema: `0`.
- Migrations: `0`.
- Alterações ao Dashboard: `0`.
- Alterações ao domínio de treinos, persistência de workout, perfil ou legacy: `0`.
- Media: `0`.
- Não foram introduzidos exercícios fora das fontes aprovadas.
- O trabalho não implementa release, catálogo adicional ou expansão ontológica.

## Versão e compatibilidade

A versão pública permanece `1.1.6+8`, o schema permanece `22` e o package permanece `com.sandro.evefittracker`. Não foram alterados manifests, migrations ou contratos de dados históricos.

## Agentes e handoffs

O Sol manteve a integração final e distribuiu subtarefas em worktrees isoladas:

- ATLAS-NEXUS — auditoria de arquitectura, read-only, Terra/high.
- IRIS-FORGE — auditoria UX e implementação UI isolada, Terra/high.
- ORACLE — geração, contratos e outputs de dados, Terra/xhigh.
- AEGIS-ARM-DATA-TEST-001 — testes de fontes, contratos e gerador, Terra/high.
- AEGIS-ARM-UI-TEST-001 — widget tests, acessibilidade e responsividade, Terra/high.
- HELIOS — integração Android, runner e artefactos, Terra/high.
- SCRIBE-ARM-DOC-001 — este relatório, documentação técnica.
- VERITAS — auditoria independente final, Sol/high, read-only: PASS; zero findings críticos, altos ou médios.

Todos os agentes editáveis permaneceram fora da main e não fizeram merge, push, tag ou release. O Sol auditou as entregas antes da integração.

## Findings e estado

- Validador de IDs duplicados: corrigido pelo Sol antes da integração. `_uniqueIds()` compara a cardinalidade original antes de aceitar o `Set`; o teste de regressão confirma falha fechada com `ArmMuscularGeneratorFailure`.
- Scope dos outputs Wave1: restringido para que a verificação cubra apenas os outputs autorizados.
- Harness Android: ajustado para usar o fluxo real da aplicação, parâmetros de branch/commit e artefactos datados.
- Deduplicação de warnings: corrigida para evitar ruído repetido sem ocultar falhas.

O finding do validador de IDs foi resolvido e o teste correspondente passou.

## Validação disponível

Resultados registados:

- `flutter pub get`: PASS.
- `dart format`: PASS nos ficheiros da feature; a verificação final do repositório permanece registada nos gates.
- `flutter analyze`: PASS.
- Testes focados: 20 PASS.
- Shards `canonical_core`: 123 testes PASS.
- Smoke Android final: PASS, run `2026-07-31T225559Z`.
  - Route: 170 ms.
  - Detail: 169 ms.
- Upgrade: PASS, run `1.1.5-2026-07-31T224401Z`.
- Full suite: 747 testes PASS em 175,879 s.
- Fast Gate: PASS em 10,114 s; format, analyze e testes focados.
- PR Gate: PASS em 215,420 s; pub get, format, analyze, quatro shards, manifesto e Android smoke.
- Release build: PASS; 59.763.241 bytes (57,0 MB).

Performance de arranque, mesma metodologia e ambiente:

- Antes: `1815 / 1623 / 1764 ms`; mediana `1764 ms`.
- Depois: `1654 / 1632 / 1600 ms`; mediana `1632 ms`.
- Melhoria: `7.48%`.

O primeiro baseline paralelo encontrou uma colisão de infraestrutura Windows em `NativeAssetsManifest.json`; a repetição sequencial terminou com `247 + 156 + 157 + 167 = 727` testes PASS. O incidente foi tratado como problema de concorrência do harness, não como falha da aplicação.

A fase comparável dos quatro shards passou de aproximadamente 172 s no baseline para 179,048 s no PR Gate, um aumento aproximado de 4,1%, abaixo do limite ADR-20 de 20%.

Auditoria VERITAS final: PASS. A revisão independente confirmou o cumprimento de escopo, ausência de alterações a schema, migrations, versão, Dashboard e legacy, zero ligações aos quatro pilares e proteção dos IDs e regras de publicação. A auditoria usou o diff staged e a evidência consolidada sem repetir as suítes.

## Rollback e riscos

Rollback operacional:

1. interromper a integração antes do merge se qualquer gate obrigatório falhar;
2. remover apenas a branch/commit da feature conforme a política Git do repositório;
3. manter as fontes ZIP e o estado da main inalterados;
4. não executar migrations nem apagar dados históricos.

Riscos restantes:

- A validação Android depende do ambiente `EveFit_Test_Device` e dos artefactos do run indicado.
- O desempenho medido melhora 7.48%; não deve ser interpretado como garantia para hardware fora do ambiente validado.
- A fundação expõe apenas a projecção pública aprovada; conteúdos adicionais continuam fora do escopo.

## Estado de entrega

O código e os dados da fundação concluíram a validação consolidada e a auditoria independente. A entrega segue apenas para commit, push e Draft PR; não inclui merge, alteração de versão, tag ou release.
