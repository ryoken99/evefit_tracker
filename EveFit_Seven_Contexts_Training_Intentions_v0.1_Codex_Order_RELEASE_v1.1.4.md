# ORDEM COMPLETA AO CODEX

# EVEFIT SETE CONTEXTOS E REGISTO CANÓNICO DE INTENÇÕES v0.1

**Revisão de execução:** inclui integração e publicação final obrigatória como EveFit `v1.1.4` (`1.1.4+6`).

## CADEIA DE COMANDO

- Sandro definiu e aprovou as decisões de produto desta missão.
- EVE consolidou e auditou a ontologia e produziu os documentos canónicos v0.4 e v0.4.1.
- O Planner inspecionou o estado conhecido do repositório, escolheu a arquitetura técnica-base e transformou a decisão numa missão autónoma.
- GPT-5.6 Sol é o cérebro, orquestrador, crítico, auditor e único integrador da execução no Codex.
- O Sol decide autonomamente quantos subagentes ou threads usar, os modelos Luna, Terra ou Sol, reasoning medium, high, xhigh ou max, paralelismo, trabalho sequencial, branches e worktrees.
- Subagentes podem investigar, gerar dados, implementar, testar e documentar trabalho real dentro de contratos explícitos e zonas isoladas.
- Subagentes não podem reinterpretar os 591 IDs, redefinir o produto, ampliar o escopo, alterar main, fazer merge, alterar versão, criar tag, publicar release ou declarar a missão global concluída.
- O Sol deve auditar todas as entregas, rever os diffs, validar as contagens e integrar apenas o trabalho aprovado.
- Sandro autoriza explicitamente o Sol a concluir toda a cadeia, incluindo marcar os PRs prontos, integrar em main, preparar a versão `1.1.4+6`, criar a tag anotada `v1.1.4` e publicar a GitHub Release estável/latest com o APK, mas apenas depois de todos os gates definidos nesta ordem estarem verdes.
- Esta autorização é condicional e não permite ignorar falhas, reduzir testes, contornar branch protection, reescrever histórico, substituir a assinatura ou publicar artefactos não validados.
- Durante a fase funcional, a versão permanece `1.1.3+5`. A alteração para `1.1.4+6` pertence exclusivamente à fase de release posterior à integração funcional.

## /goal

Implementar os sete contextos canónicos ativos e o registo v0.4.1 de 591 intenções globais com 771 relações percurso-intenção, integrar a navegação Contexto -> Capacidade -> Conceito -> Intenção, preservar dados, histórico, zero exercícios e todos os contratos canónicos e, após validação e integração completas, publicar a implementação como EveFit `v1.1.4` com Flutter `1.1.4+6`.

O uso de `/goal` está tecnicamente confirmado pelo Planner porque a missão é grande e persistente, envolve fontes documentais extensas, geração determinística, modelos tipados, 280 percursos, UI, compatibilidade histórica, Android, CI e várias linhas de trabalho isoláveis.

---

## 1. MISSÃO

Implementar na EveFit o percurso canónico:

Contexto
-> Capacidade
-> Conceito de treino
-> Intenção
-> Exercícios compatíveis no futuro

Esta missão termina funcionalmente depois da seleção da intenção.

Ainda existem zero exercícios canónicos aprovados. Depois da seleção da intenção, mostrar um estado vazio de exercícios sem criar sugestões, IDs antigos, resultados artificiais ou catálogo fictício.

Resultados obrigatórios da branch:

- 7 contextos ativos;
- 8 capacidades;
- 35 conceitos globais;
- 40 relações capacidade-conceito;
- 280 percursos contexto-capacidade-conceito;
- 261 percursos compatíveis;
- 19 percursos incompatíveis;
- 591 intenções globais;
- 771 relações percurso-intenção;
- 693 IDs v0.3 mapeados no histórico auditável;
- 792 ocorrências v0.3 preservadas no histórico auditável;
- 0 atributos oficiais;
- 0 exercícios canónicos;
- 0 subníveis;
- legacy invisível;
- árvore antiga invisível;
- dados pessoais e históricos preservados.

Não alterar a versão pública durante a implementação funcional. Depois de o PR funcional ser integrado e confirmado em main, executar a fase de release e alterar exclusivamente para `1.1.4+6`.

---

## 2. FONTES CANÓNICAS OBRIGATÓRIAS

Esta ordem é distribuída juntamente com os seguintes ficheiros:

1. `EveFit_Training_Intentions_Production_Registry_v0.4.md`
2. `EveFit_Training_Intentions_Production_Registry_v0.4.1.md`

SHA-256 obrigatório:

- v0.4: `d9cf51727dc28aa078b7cc55fa0f6246360e86bcba93b40fe34feac9ac7f50ad`
- v0.4.1: `4d6f6d06f8f593f549dfd0ab132ce09f92ec760dfed11966cdd816be3506c0d8`

Antes de executar qualquer transformação:

1. localizar os dois ficheiros fornecidos com esta ordem;
2. calcular SHA-256;
3. confirmar os dois hashes exatos;
4. ler integralmente ambos os documentos;
5. registar os caminhos e hashes no relatório inicial.

Precedência:

- a v0.4 contém a consolidação semântica principal;
- a v0.4.1 é uma correção localizada e prevalece em todos os campos ou decisões corrigidos;
- a v0.4 deve permanecer byte-for-byte inalterada;
- a v0.4.1 não deve ser reconsolidada nem reinterpretada;
- v0.3 e v0.2 são apenas histórico, nunca fontes de produção runtime;
- não recriar, resumir, renomear ou reescrever os 591 IDs.

A autorização de Sandro permite a implementação, os PRs, a integração e a publicação final condicionada como `v1.1.4`. A autorização não transforma a ontologia numa ferramenta de diagnóstico, prescrição clínica ou autorização de retorno e não permite publicar enquanto qualquer gate obrigatório estiver vermelho.

Se qualquer hash divergir, se algum ficheiro estiver truncado ou se a tabela canónica não produzir as contagens fechadas, parar sem alterar código.

---

## 3. ESTADO TÉCNICO CONHECIDO A CONFIRMAR

Repositório:

`ryoken99/evefit_tracker`

Branch principal:

`main`

HEAD remoto conhecido no momento do planeamento:

`b9a570edd934bae92b88c78c0bd9349d2036d4a6`

Esse SHA corresponde ao merge do PR #17, que corrigiu apenas o harness de upgrade da v1.1.3.

Versão conhecida:

`1.1.3+5`

Estado conhecido:

- PR #15 integrado em main;
- PR #16, conceitos canónicos v1.1.3, integrado;
- PR #17, correção do harness de upgrade, integrado;
- nenhum PR aberto no momento da inspeção do Planner;
- 5 contextos ativos atuais;
- 8 capacidades;
- 35 conceitos globais;
- 40 relações capacidade-conceito;
- 0 intenções ativas;
- 0 atributos oficiais;
- 0 exercícios ativos;
- 0 subníveis;
- query e selection path já suportam o eixo `training_intention` como quarto critério;
- controller já possui o passo `trainingIntention` e o passo `results`;
- UI atual mostra estado vazio no passo Intenção;
- Canonical Registry atual é Dart síncrono e tipado;
- `approvedTrainingIntentions` está vazio;
- provider de compatibilidade devolve zero intenções;
- base de dados conhecida está na versão 22;
- não foram encontrados campos canónicos de contexto, capacidade, conceito ou intenção nas tabelas persistidas;
- a seleção canónica conhecida é transitória e não persistida;
- última contagem comunicada: 642 testes, a confirmar;
- versão pública alvo autorizada para o fim da missão: `1.1.4+6`;
- tag alvo: `v1.1.4`;
- APK alvo: `EveFit-v1.1.4-seven-contexts-training-intentions-release.apk`.

O Codex deve confirmar tudo no checkout real. O estado conhecido não substitui inspeção.

---

## 4. PRÉ-CHECK GIT E GITHUB

Executar a partir da raiz Git:

```powershell
gh auth status
git fetch origin --prune --tags
git checkout main
git status --short
git rev-parse HEAD
git rev-parse origin/main
git log -1 --oneline
gh pr list --repo ryoken99/evefit_tracker --state open
gh release view v1.1.3 --repo ryoken99/evefit_tracker
git tag --list v1.1.4
gh release view v1.1.4 --repo ryoken99/evefit_tracker 2>$null
```

Confirmar:

- HEAD local = origin/main;
- main contém PRs #15, #16 e #17;
- versão = `1.1.3+5`;
- não existem alterações tracked inesperadas;
- não existe PR ou branch concorrente incompatível;
- os dois ficheiros untracked conhecidos estão preservados;
- os gates em `docs/engineering/TESTING.md` estão disponíveis;
- o workflow otimizado e os quatro shards estão disponíveis.

Quando origin/main tiver avançado legitimamente depois do SHA conhecido:

1. inspecionar os commits posteriores;
2. confirmar que não introduzem intenções ou alterações incompatíveis;
3. usar o origin/main atual como base;
4. registar o SHA real.

Parar perante conflito de produto, alterações concorrentes ao Canonical Core ou versão inesperada que exija decisão de Sandro.

---

## 5. FICHEIROS NÃO RASTREADOS

Preservar integralmente:

- `../15_ARTES_MARCIAIS_EXERCICIOS_DERIVADOS.md`
- `docs/catalog_reports/v0.9.4/menu_matrix_review_pack.zip`

O segundo caminho pode aparecer como `evefit_tracker/docs/catalog_reports/v0.9.4/menu_matrix_review_pack.zip` conforme a raiz atual.

Não:

- apagar;
- mover;
- renomear;
- modificar;
- adicionar a commits;
- usar como fixture;
- incluir em artefactos;
- limpar com `git clean`;
- usar `git add .`.

---

## 6. BRANCHES, PULL REQUESTS E FASES

A missão tem duas fases Git independentes. Não misturar versionamento público com a implementação funcional.

### 6.1 Fase funcional

Criar a partir de `origin/main` confirmado:

`feature/seven-context-training-intentions-v0.1`

Comandos:

```powershell
git checkout main
git pull --ff-only origin main
git checkout -b feature/seven-context-training-intentions-v0.1
git branch --show-current
git rev-parse HEAD
git status --short
```

PR funcional:

- abrir inicialmente como draft;
- título: `EveFit Seven Contexts & Canonical Training Intentions v0.1`;
- base: `main`;
- manter `1.1.3+5`;
- não incluir changelog, tag, release ou APK nesta branch;
- depois de todos os testes locais e do CI real estarem verdes, o Sol deve rever o head final, marcar o PR ready e integrá-lo em main com merge commit;
- nenhum subagente pode executar essa integração.

### 6.2 Fase de release

Só começar depois de confirmar o merge funcional, atualizar `main` por fast-forward e repetir as verificações canónicas essenciais no SHA integrado.

Criar exclusivamente a partir da main atualizada:

`release/v1.1.4-seven-contexts-training-intentions`

PR de release:

- abrir inicialmente como draft;
- título: `EveFit v1.1.4 — Sete Contextos e Intenções Canónicas`;
- base: `main`;
- alterar a versão Flutter para `1.1.4+6`;
- não alterar o comportamento funcional aprovado;
- incluir apenas metadata, documentação de release, harness de upgrade v1.1.4 e ajustes estritamente necessários ao processo de publicação;
- depois de Release Gate e CI verdes, o Sol deve marcar ready e integrar com merge commit.

A tag, a GitHub Release e o APK só podem ser publicados depois de o PR de release estar integrado em main e o Release Gate pós-merge passar no SHA final.

---

## 7. DECISÃO TÉCNICA DE ARQUITETURA

A arquitetura atual é síncrona, code-backed e usa registos Dart `const`. Para manter o controller e o provider síncronos, evitar parsing assíncrono de 591 registos em runtime e preservar performance, implementar a seguinte estratégia:

### 7.1 Fonte documental imutável

Adicionar ao repositório, byte-for-byte e sem edição:

- `docs/canonical/source/training_intentions/EveFit_Training_Intentions_Production_Registry_v0.4.md`
- `docs/canonical/source/training_intentions/EveFit_Training_Intentions_Production_Registry_v0.4.1.md`

Criar:

- `docs/canonical/source/training_intentions/README.md`

O README deve declarar:

- precedência v0.4.1 sobre v0.4;
- hashes;
- proibição de edição manual dos documentos;
- proibição de parsing Markdown em runtime;
- comando de geração;
- comando de verificação;
- distinção entre fonte documental, output gerado e runtime.

### 7.2 Gerador determinístico de desenvolvimento

Criar uma ferramenta Dart, preferencialmente:

`tool/canonical/generate_training_intentions_registry.dart`

Modos obrigatórios:

- `generate`: gera os outputs;
- `check`: regenera em memória ou diretório temporário e falha quando o output versionado diverge;
- `report`: apresenta hashes, contagens e validações sem alterar ficheiros.

Requisitos do gerador:

- sem rede;
- sem timestamps voláteis nos outputs;
- UTF-8;
- ordem determinística;
- headers com versão da fonte e hashes;
- validação exata dos títulos e cabeçalhos das tabelas;
- falha por número inesperado de colunas;
- falha por linha ambígua;
- falha por ID desconhecido;
- falha por contagem divergente;
- falha por texto canónico vazio;
- não corrigir automaticamente a fonte;
- não normalizar conteúdo PT-PT além de remover marcação Markdown externa e whitespace estrutural;
- preservar Unicode, acentos e pontuação;
- permitir round-trip auditável dos campos canónicos.

Não adicionar uma dependência externa de Markdown sem necessidade comprovada. Um parser específico, fail-closed e coberto por testes é preferível.

### 7.3 Runtime gerado em Dart

Gerar código Dart versionado e formatado em:

`lib/features/canonical_core/generated/training_intentions/`

Estrutura recomendada:

- `training_intentions_registry.g.dart`
- `training_intentions_registry_part_01.g.dart` até ao número necessário, com divisão determinística por quantidade de registos;
- `training_paths_registry.g.dart`
- `training_path_intention_links.g.dart`
- `training_intentions_provenance.g.dart`

O Sol pode adaptar os nomes, mas deve preservar a separação entre:

1. 591 definições globais runtime;
2. 280 percursos runtime;
3. 771 links/ocorrências runtime;
4. proveniência runtime mínima e contagens estruturais.

`training_intentions_provenance.g.dart` pode conter apenas proveniência runtime mínima:

- versão do registo;
- versão do gerador;
- SHA-256 da v0.4;
- SHA-256 da v0.4.1;
- contagens canónicas necessárias para diagnóstico estrutural;
- identificador determinístico da geração.

Não pode conter:

- o mapa completo dos 693 IDs históricos;
- as 792 ocorrências históricas;
- listas de IDs v0.3 por intenção;
- razões de manutenção, consolidação ou renomeação;
- decision ledger;
- texto histórico desnecessário ao funcionamento da aplicação.

Quando não existir utilização runtime legítima para um ficheiro de proveniência separado, o Sol pode colocar esta proveniência mínima exclusivamente nos headers dos outputs gerados e no manifest documental, desde que a rastreabilidade continue verificável.

Não gerar um único ficheiro gigantesco quando a divisão estável melhorar análise, revisão e compilação.

Os ficheiros gerados:

- são commitados;
- não são editados manualmente;
- têm comentário de geração;
- são reproduzíveis byte-for-byte;
- não dependem de parsing Markdown em runtime;
- não dependem de assets ou rede para carregar intenções;
- não transportam o histórico completo v0.3 para o APK.

### 7.4 Manifest auditável

Gerar:

`docs/canonical/generated/training_intentions_v0.4.1_manifest.json`

O manifest deve conter, no mínimo:

- versão do gerador;
- ficheiros-fonte;
- SHA-256 das fontes;
- hashes dos outputs normalizados;
- todas as contagens fechadas;
- contagens por tipo;
- contagens por risco;
- contagens por revisão clínica;
- contagens por papel;
- 59 rótulos contextuais;
- IDs históricos v0.3: 693;
- ocorrências históricas v0.3: 792;
- hash da representação normalizada do mapa histórico;
- resultado da validação integral do mapa histórico;
- confirmação de que todos os IDs históricos possuem destino;
- confirmação de que nenhum destino histórico é inexistente;
- confirmação de que o mapa histórico completo não foi emitido para runtime;
- confirmação de ausência de equipamento e ambiente executáveis;
- confirmação de ausência de IDs legacy nas queries.

O manifest pode referenciar a secção documental onde existe o mapa completo. Não precisa de duplicar integralmente o mapa quando o hash, as contagens, a validação e a fonte imutável preservarem a auditoria.

Sem timestamp variável no conteúdo versionado. Quando for necessária data de execução, colocá-la apenas no relatório humano, não no output determinístico.

### 7.5 Histórico v0.3

O mapeamento integral v0.3 -> v0.4.1 permanece auditável nas fontes e é obrigatoriamente validado pelo gerador.

Validar:

- 693 IDs v0.3 únicos;
- 792 ocorrências históricas;
- todos os IDs com destino;
- nenhum destino inexistente;
- nenhum alias provisório exposto como ID público ativo;
- consistência com os 59 rótulos contextuais;
- hash determinístico da representação normalizada.

O histórico completo v0.3 permanece fora do runtime da aplicação. Isto inclui o mapa integral, as listas de IDs anteriores por intenção, as razões individuais de manutenção, consolidação ou renomeação e o decision ledger.

A ausência do histórico no runtime não elimina nem reduz a auditoria documental. O histórico permanece nas fontes canónicas, no gerador, nos testes do gerador, no manifest, nos relatórios e no Git.

---

## 8. MODELOS TIPADOS

Não sobrecarregar `CanonicalPillarDefinition` com dezenas de campos opcionais.

Implementar modelos específicos, por composição, mantendo uma projeção de pilar para query e navegação.

### 8.1 CanonicalTrainingIntentionDefinition

Criar um modelo imutável e `const` quando possível, contendo:

- `pillar`: `CanonicalPillarDefinition` com eixo `trainingIntention`;
- `type`;
- `effectPtPt`;
- `primaryTargetPtPt`;
- `horizon`;
- contextos compatíveis declarados;
- capacidades compatíveis declaradas;
- conceitos compatíveis declarados;
- `occurrenceCount`;
- papéis possíveis;
- alternativas incompatíveis globais;
- complementares compatíveis globais;
- populações relevantes;
- `evidenceBasis`;
- códigos de fonte;
- limite da evidência PT-PT;
- `reviewState`;
- `clinicalReviewRequired`;
- `operationalRiskTier`;
- nota geral de segurança PT-PT;
- ordem global estável da fonte;
- versão e proveniência runtime mínima do registo.

A definição e o nome devem ser exatamente os da v0.4.1.

Não incluir:

- `equipmentScope`;
- `environmentScope`;
- equipamento obrigatório;
- local obrigatório;
- parceiro obrigatório;
- alvo obrigatório;
- ambiente aquático obrigatório;
- prescrição;
- intensidade concreta;
- progressão concreta.

### 8.2 Enums fechados

Criar enums tipados com IDs contratuais exatos para:

Tipos:

- `adaptation_outcome`
- `acute_preparation`
- `targeted_activation`
- `recovery_activity`
- `cooldown_regulation`
- `prevention_capacity`
- `functional_restoration`
- `technical_learning`
- `self_regulation`

Papéis:

- `principal_candidate`
- `alternative_primary`
- `complementary`
- `conditional_complementary`
- `hidden_advanced`

Risco operacional:

- `low`
- `moderate`
- `high`
- `clinically_restricted`

Evidência:

- `strong_family_evidence`
- `moderate_family_evidence`
- `limited_family_evidence`
- `professional_consensus`
- `product_ontology_inference`

Horizonte:

- `agudo`
- `crónico`
- `agudo e crónico`
- `fase de retorno funcional`

Revisão clínica deve ser representada separadamente por boolean ou enum fechado `yes/no`, sem ser inferida a partir do risco.

### 8.3 Rótulos PT-PT dos tipos

Expor ao utilizador apenas rótulos compreensíveis:

- adaptation_outcome: `Resultado de adaptação`
- acute_preparation: `Preparação aguda`
- targeted_activation: `Ativação direcionada`
- recovery_activity: `Atividade de recuperação`
- cooldown_regulation: `Regulação do retorno à calma`
- prevention_capacity: `Capacidade preventiva`
- functional_restoration: `Restauração funcional`
- technical_learning: `Aprendizagem técnica`
- self_regulation: `Autorregulação`

Não mostrar os IDs internos na UI comum.

---

## 9. MODELO DOS 280 PERCURSOS

Criar `CanonicalTrainingPathDefinition` ou equivalente, com:

- número de origem 1..280;
- `CanonicalTrainingPathKey` composto por contexto, capacidade e conceito;
- estado `compatible` ou `incompatible`;
- racional PT-PT;
- notas contextuais;
- alternativas do percurso;
- complementares do percurso;
- limites;
- progressão separada;
- intensidade/prescrição separadas;
- elegibilidade/segurança;
- modificador de risco operacional;
- modificador de revisão clínica;
- versão/proveniência.

Não tratar o path como parent/child ontológico.

O path é uma combinação de consulta e compatibilidade, não uma árvore proprietária.

### 9.1 Modificador de risco do percurso

Normalizar apenas os quatro estados efetivamente fechados na fonte:

- `inherit_only`
- `may_escalate_to_high`
- `clinically_restricted`
- `not_applicable`

Preservar também o texto canónico original da coluna.

Mapeamento esperado:

- 213 `inherit_only`;
- 8 `may_escalate_to_high`;
- 40 `clinically_restricted`;
- 19 `not_applicable`.

### 9.2 Modificador de revisão clínica

Normalizar:

- `inherit_only`
- `required`
- `not_applicable`

Contagens esperadas:

- 221 `inherit_only`;
- 40 `required`;
- 19 `not_applicable`.

Nenhum modificador pode reduzir o estado da intenção.

---

## 10. LINKS PERCURSO-INTENÇÃO

Criar `CanonicalPathIntentionLink` ou equivalente para exatamente 771 ocorrências.

Cada link contém:

- referência ao path;
- `intentionId` global;
- papel;
- ordem de origem dentro do path;
- rótulos contextuais associados, quando existirem;
- proveniência.

Não duplicar a definição global da intenção.

Não duplicar os metadados do path 771 vezes. Criar uma view resolvida, por exemplo `CanonicalResolvedPathIntention`, que combine:

- definição global;
- link;
- path;
- alternativas e complementares do path;
- limites;
- modificadores de risco e revisão.

A view resolvida deve satisfazer o contrato de apresentação e auditoria sem criar drift entre três cópias dos mesmos dados.

### 10.1 Ordem das ocorrências

Usar a ordem de `Intenções finais` na matriz como `displayOrder` 1..n.

O papel é lido da coluna `Prioridade` e deve corresponder um-para-um à intenção.

Contagens esperadas por papel:

- principal_candidate: 238
- alternative_primary: 74
- complementary: 412
- conditional_complementary: 33
- hidden_advanced: 14

Total: 771.

### 10.2 Rótulos contextuais

Preservar exatamente 59 rótulos contextuais.

Estratégia determinística:

1. ler a secção 13.1 da v0.4;
2. identificar os 59 IDs v0.3 convertidos em rótulo contextual;
3. resolver o nome PT-PT histórico através do mapeamento integral;
4. localizar a ocorrência exata no path através de `Destinos v0.3→v0.4`;
5. associar o rótulo ao link correto;
6. permitir lista de rótulos quando mais de um ID histórico convergir para a mesma ocorrência.

Não inventar rótulos.

Esta resolução ocorre exclusivamente durante a geração e auditoria. O runtime recebe apenas os rótulos contextuais finais necessários aos links, sem o mapa histórico integral nem os IDs v0.3 que lhes deram origem.

Quando a associação não for unívoca, o gerador deve falhar e apresentar o ID, path e candidatos.

---

## 11. CONTAGENS E DISTRIBUIÇÕES FECHADAS

O gerador e o validator devem confirmar:

### Estrutura

- contextos ativos: 7
- capacidades: 8
- conceitos: 35
- relações capacidade-conceito: 40
- percursos: 280
- percursos compatíveis: 261
- percursos incompatíveis: 19
- intenções globais: 591
- links: 771
- IDs v0.3: 693
- ocorrências v0.3: 792
- rótulos contextuais: 59

### Risco

- low: 92
- moderate: 370
- high: 37
- clinically_restricted: 92

### Revisão clínica

- yes: 100
- no: 491

### Tipos

- adaptation_outcome: 100
- acute_preparation: 89
- targeted_activation: 98
- recovery_activity: 56
- cooldown_regulation: 20
- prevention_capacity: 102
- functional_restoration: 92
- technical_learning: 25
- self_regulation: 9

### Evidência

- strong_family_evidence: 35
- moderate_family_evidence: 285
- limited_family_evidence: 160
- professional_consensus: 92
- product_ontology_inference: 19

### Horizontes

- agudo: 263
- crónico: 227
- agudo e crónico: 9
- fase de retorno funcional: 92

### Correções v0.4.1

- definições corrigidas: 17
- nomes corrigidos: 1
- horizontes normalizados: 92
- campos globais de equipamento removidos: 591
- campos globais de ambiente removidos: 591
- agregações materiais removidas dos percursos compatíveis: 261
- agregações ambientais removidas dos percursos compatíveis: 261

O validator deve falhar por qualquer divergência.

---

## 12. SETE CONTEXTOS ATIVOS

Substituir a lista ativa atual por exatamente:

1. `main_training` - Treino principal
2. `warmup` - Aquecimento
3. `activation` - Ativação
4. `recovery` - Recuperação
5. `cooldown` - Retorno à calma
6. `prevention` - Prevenção
7. `return_to_function` - Retorno à função

Treino principal continua explícito e nunca é selecionado por defeito.

Preservar as descrições atuais de `main_training`, `warmup` e `activation`, salvo correção meramente linguística necessária para coerência.

Usar descrições públicas prudentes para os quatro contextos separados:

- recovery: `Atividade deliberadamente leve numa sessão posterior ou mais tarde no mesmo dia, sem prometer acelerar a recuperação fisiológica ou o desempenho futuro.`
- cooldown: `Transição imediata após o esforço para reduzir a exigência e regressar a maior conforto.`
- prevention: `Desenvolvimento de capacidade, controlo ou tolerância perante exigências previsíveis numa pessoa funcional, sem garantir prevenção de lesão.`
- return_to_function: `Recuperação ou reintrodução de uma função reduzida ou interrompida, dependente de critérios de elegibilidade e sem equivaler a reabilitação ou autorização de retorno.`

Atualizar icon keys e resolver com Material Icons existentes. Não adicionar assets e não criar significado canónico baseado nos ícones.

---

## 13. CONTEXTOS ANTIGOS E PERSISTÊNCIA

IDs atuais combinados:

- `recovery_cooldown`
- `prevention_adaptation_return`

Não mapear silenciosamente para novos contextos.

### 13.1 Auditoria obrigatória

Antes de decidir migração, pesquisar em:

- schema DB;
- migrations;
- modelos persistidos;
- SharedPreferences;
- JSON local;
- templates;
- histórico de treinos;
- testes de upgrade;
- exports/imports;
- analytics locais;
- ficheiros de configuração.

Provar se os IDs canónicos são ou não persistidos.

### 13.2 Decisão técnica esperada

No estado conhecido, a seleção canónica é transitória e os IDs não estão persistidos. Quando o checkout real confirmar isso:

- não alterar a versão 22 da DB sem necessidade comprovada por inspeção e migration aditiva validada;
- não criar migration;
- remover os dois contextos da lista ativa;
- preservar o significado histórico através do Git e dos documentos-fonte;
- atualizar testes e documentação;
- não manter os IDs antigos como opções runtime ativas.

### 13.3 Caso inesperado de persistência

Quando forem encontradas referências persistidas:

- não escolher automaticamente entre recovery/cooldown;
- não escolher automaticamente entre prevention/return_to_function;
- preservar as rows antigas;
- excluí-las da navegação ativa;
- manter um display label histórico legível;
- não criar relações novas para os IDs antigos;
- parar antes de criar migration e apresentar uma proposta aditiva e não destrutiva.

A ambiguidade semântica dos contextos combinados exige decisão posterior de Sandro.

---

## 14. PRESERVAR CAPACIDADES, CONCEITOS E RELAÇÕES

Manter exatamente:

- 8 capacidades;
- 35 conceitos globais;
- 40 relações capacidade-conceito.

Não:

- criar conceitos;
- remover conceitos;
- alterar IDs;
- alterar as definições aprovadas;
- duplicar conceitos por contexto;
- criar `parent_id`;
- criar caminhos fixos como entidades proprietárias;
- transformar a ordem visual em dependência ontológica.

---

## 15. REGISTRY E ÍNDICES

Evoluir `CanonicalRegistry` sem criar um segundo registry paralelo.

O registry deve expor:

- 7 contextos ativos;
- 8 capacidades;
- 35 conceitos;
- 591 pilares/projeções de intenção;
- 40 relações capacidade-conceito;
- 280 path definitions;
- 771 path-intention links;
- lookup por ID;
- lookup por path key;
- lookup de links por path;
- lookup de paths por intenção;
- lookup das definições globais.

Construir índices imutáveis uma vez, sem revarrer 591/771 registos em cada rebuild de widget.

Não executar O(591×771) por frame.

Usar Maps e listas não modificáveis, com ordem determinística.

O total de valores de pilar ativos passa a:

8 capacidades + 35 conceitos + 7 contextos + 591 intenções = 641.

Atualizar o validator sem enfraquecer verificações anteriores.

Adicionar uma versão de dados separada, por exemplo:

`canonicalTrainingIntentionRegistryVersion = '0.4.1'`

Não alterar o namespace da query apenas por adicionar dados, porque a query já suporta os quatro eixos. Não usar a versão pública da app como versão do registo.

---

## 16. COMPATIBILIDADE DE CONCEITOS POR PERCURSO

Atualizar `compatibleTrainingConcepts(path)`.

Depois de contexto + capacidade, devolver apenas conceitos cujo path:

- existe nos 280 percursos;
- tem estado `compatible`;
- possui pelo menos um link válido.

Os 19 percursos incompatíveis:

- permanecem no registo auditável;
- têm zero links;
- não aparecem como opção ativa;
- nunca recebem placeholder ou intenção artificial.

Casos obrigatórios:

- recovery + speed_power -> zero conceitos;
- cooldown + speed_power -> zero conceitos;
- activation + flexibility -> apenas `dynamic_lengthening`;
- cooldown + motor_control_coordination -> todos os conceitos compatíveis exceto `reactive_adjustment`;
- recovery/cooldown + technique_skill -> não mostrar `stimulus_response_decision` nem `technical_variability_adaptation`.

Manter as oito capacidades disponíveis depois da seleção do contexto. Uma capacidade pode abrir um estado vazio de conceitos quando não existir percurso compatível.

---

## 17. COMPATIBILIDADE DE INTENÇÕES

Atualizar `compatibleTrainingIntentions(path)` para exigir:

- contexto selecionado;
- capacidade selecionada;
- conceito selecionado;
- path compatible;
- links válidos.

Devolver opções resolvidas contendo:

- definição global;
- papel;
- ordem;
- rótulo contextual;
- metadados do path;
- risco efetivo base/contextual;
- revisão clínica efetiva base/contextual.

Não usar apenas as listas agregadas da definição global para decidir compatibilidade.

A fonte de verdade da ocorrência é o link do path.

---

## 18. QUERY PROGRESSIVA

Preservar a ordem:

1. `usage_context`
2. `capability_root`
3. `training_concept`
4. `training_intention`

Estados:

- contexto selecionado: 1 critério;
- contexto + capacidade: 2 critérios;
- contexto + capacidade + conceito: 3 critérios;
- contexto + capacidade + conceito + intenção: 4 critérios.

Depois da intenção, a query contém exatamente quatro critérios.

Não adicionar:

- `exercise_ids`;
- `parent_id`;
- IDs legacy;
- protocolos;
- prescrição;
- equipamento;
- local;
- atributos inventados.

Adicionar validação path-aware:

- o conceito deve ser compatível com contexto + capacidade;
- a intenção deve possuir link no path selecionado;
- um ID global conhecido não implica compatibilidade universal;
- critérios posteriores sem os anteriores são inválidos;
- eixos duplicados continuam inválidos.

---

## 19. CONTROLLER E ESTADO

Preservar o controller hierárquico existente e completar o passo Intenção.

Confirmar:

- selecionar contexto limpa capacidade, conceito e intenção;
- selecionar capacidade limpa conceito e intenção;
- selecionar conceito limpa intenção;
- selecionar intenção avança para resultados vazios;
- voltar de resultados regressa à lista de intenções;
- voltar da intenção regressa à lista de conceitos;
- voltar do conceito regressa à capacidade;
- voltar da capacidade regressa ao contexto;
- Home limpa o percurso completo;
- system Back segue o mesmo contrato;
- breadcrumb reflete o estado real;
- voltar não duplica critérios;
- uma intenção incompatível não pode ser selecionada;
- Treino principal nunca é implícito.

Adicionar método de navegação para o breadcrumb da intenção, quando necessário.

---

## 20. UI DA LISTA DE INTENÇÕES

Título:

`Que intenção de treino procuras?`

Seleção:

- uma intenção de cada vez;
- não criar combinação automática;
- não criar prescrição.

Agrupamento e ordem:

1. grupo `Principais e alternativas`
   - principal_candidate
   - alternative_primary
2. grupo `Complementares`
   - complementary
3. grupo `Complementares condicionais`
   - conditional_complementary
4. secção expansível `Opções avançadas`
   - hidden_advanced

Dentro de cada papel, preservar a ordem de origem do path.

Rótulos PT-PT dos papéis:

- principal_candidate: `Principal`
- alternative_primary: `Alternativa principal`
- complementary: `Complementar`
- conditional_complementary: `Complementar condicionada`
- hidden_advanced: `Opção avançada`

Todas as opções válidas permanecem acessíveis. `hidden_advanced` significa recolhida numa secção avançada, não eliminada.

Cada card deve mostrar:

- nome;
- definição;
- rótulo contextual quando existir;
- badge de papel discreto;
- alertas apenas quando relevantes;
- ValueKey baseada no ID global e, quando necessário, no path.

Usar `ListView.builder`, `SliverList` ou equivalente virtualizado quando listar vocabulário amplo. Não construir 591 cards simultaneamente na pesquisa global.

---

## 21. RISCO OPERACIONAL E REVISÃO CLÍNICA NA UI

Manter os eixos separados.

### Risco

- low: sem alarme visual;
- moderate: sem alarme visual excessivo;
- high: mostrar `Exigência elevada`;
- clinically_restricted: mostrar `Utilização dependente de critérios de elegibilidade ou avaliação profissional.`

### Revisão clínica

Quando `clinical_review_required = yes`, mostrar:

`Esta intenção requer revisão clínica antes de ser utilizada numa decisão individual.`

Não inferir revisão a partir do risco.

Não inferir risco a partir da revisão.

Não afirmar segurança.

Não bloquear automaticamente com base apenas nestes campos.

### Retorno à função

No contexto `return_to_function`, mostrar uma nota prudente, sem impedir navegação:

`Retorno à função não substitui diagnóstico, reabilitação, critérios clínicos ou autorização de retorno ao desporto.`

Não implementar triagem, diagnóstico, alta, autorização ou prescrição.

---

## 22. DETALHE DA INTENÇÃO

A interface deve permitir consultar os detalhes sem sobrecarregar a lista.

Usar um bottom sheet, dialog, expansão acessível ou padrão já existente.

Mostrar:

- nome;
- definição;
- tipo em PT-PT;
- contexto atual;
- capacidade atual;
- conceito atual;
- rótulo contextual;
- risco relevante;
- revisão clínica;
- evidence basis em linguagem de produto;
- limite da evidência exatamente preservado;
- nota geral de segurança.

Não mostrar por defeito:

- IDs internos;
- códigos de fonte.

Na aplicação runtime:

- não mostrar IDs v0.3;
- não mostrar razões históricas de manutenção, consolidação ou renomeação;
- não carregar esses dados;
- não criar um modo técnico novo para os consultar.

Um modo técnico já existente pode mostrar apenas:

- ID final;
- versão do registo;
- hashes das fontes;
- versão do gerador;
- proveniência runtime mínima;
- contagens ou estado de validação.

A auditoria histórica completa ocorre através das fontes, do manifest e dos relatórios, não da aplicação pública.

---

## 23. ESTADO DEPOIS DA INTENÇÃO

Depois da seleção da intenção, avançar ao passo Resultados e mostrar:

Título:

`Ainda não existem exercícios aprovados para este percurso.`

Texto secundário:

`Os exercícios compatíveis serão adicionados e validados progressivamente.`

Preservar o percurso:

Contexto
> Capacidade
> Conceito
> Intenção

Não consultar catálogo legacy.

Não criar exercício fictício.

Não usar IDs de exercícios antigos.

Não gerar recomendação, dose, protocolo ou prescrição.

---

## 24. PESQUISA GLOBAL POR INTENÇÃO

O ecrã genérico `Explorar exercícios` já possui o eixo `Por intenção`.

Com 591 intenções, não permitir que selecionar uma intenção gere diretamente uma query universal de um único critério para procurar exercícios.

Implementar o seguinte contrato:

1. eixo `Por intenção` lista as 591 intenções globais em ordem determinística e virtualizada;
2. selecionar uma intenção mostra os percursos compatíveis dessa intenção;
3. cada percurso apresenta Contexto > Capacidade > Conceito;
4. os percursos são obtidos dos links reais;
5. ordenar por ordem de contexto, capacidade e conceito/path;
6. selecionar um percurso constrói a query completa com quatro critérios;
7. mostrar o mesmo estado vazio de exercícios;
8. não criar compatibilidade universal implícita.

Pode incluir filtro textual local sobre nome/definição apenas quando necessário para tornar 591 valores utilizáveis. Esse filtro:

- não altera a ontologia;
- não consulta rede;
- não cria ranking semântico;
- usa normalização determinística;
- deve ser testado.

Não fazer pesquisa fuzzy ou IA nesta missão.

---

## 25. EQUIPAMENTO, LOCAL E EXERCÍCIOS

Não incluir em intenção nem em link:

- equipment_scope;
- environment_scope;
- required_equipment;
- optional_equipment;
- alternative_equipment_groups;
- local obrigatório;
- parceiro obrigatório;
- alvo obrigatório;
- ambiente aquático obrigatório.

Quando já existirem entidades de local ou equipamento:

- preservar;
- não reestruturar;
- não usar para ocultar intenções;
- não unir inventários;
- não criar predefinições.

A falta de equipamento poderá ocultar exercícios no futuro, nunca intenções.

Não implementar nesta missão:

- BaseExercisePool real;
- MatchingExercises real;
- catálogo canónico de exercícios;
- fórmulas de disponibilidade;
- elegibilidade individual;
- prescrições.

---

## 26. DADOS E PERFORMANCE

O Markdown nunca é lido pela app em runtime.

O runtime deve usar apenas os dados Dart gerados.

Requisitos de performance:

- construir índices uma vez;
- lookups de path e intenção O(1) ou O(k) sobre a lista final;
- não filtrar 771 links repetidamente por frame;
- não gerar objetos pesados em cada build;
- listas virtualizadas;
- nenhuma leitura de disco/rede ao abrir o seletor;
- medir tempo de arranque e tempo de abertura do seletor antes/depois;
- registar tamanho adicional do APK debug, sem publicar APK;
- investigar regressão reproduzível superior a 25%.

Não sacrificar metadados runtime necessários ao comportamento, segurança, apresentação, evidência ou compatibilidade para reduzir tamanho.

Dados puramente históricos e de auditoria não são metadados runtime obrigatórios. Mantê-los fora do APK não constitui perda de informação quando permanecem integralmente preservados nas fontes e no processo de geração e validação.

Adicionar uma verificação de que a exclusão do histórico completo do runtime não reduz a rastreabilidade documental.

---

## 27. TESTES DO GERADOR

Criar testes para:

- hashes das fontes;
- títulos e headers;
- 591 linhas de intenção;
- 280 paths;
- 261 compatible;
- 19 incompatible;
- 771 links;
- 693 IDs históricos únicos;
- 792 ocorrências históricas;
- todos os IDs históricos com destino;
- nenhum destino histórico inexistente;
- nenhum alias provisório ativo;
- hash determinístico do mapa histórico normalizado;
- consistência integral do mapa com as fontes;
- consistência dos 59 rótulos contextuais;
- falha por ID histórico sem destino;
- falha por destino inexistente;
- falha por duplicação histórica inesperada;
- falha quando o mapa histórico diverge da fonte;
- confirmação de que o mapa completo não é emitido para os ficheiros runtime;
- geração byte-for-byte determinística;
- `check` passa com outputs atualizados;
- `check` falha com output alterado;
- erro claro por fonte truncada;
- erro claro por ID desconhecido;
- erro por coluna removida ou adicionada;
- nenhuma dependência de rede;
- nenhuma data variável em output.

Adicionar teste explícito que inspecione todos os outputs em:

`lib/features/canonical_core/generated/training_intentions/`

e confirme que não contêm:

- o mapa histórico completo;
- listas de IDs v0.3 por intenção;
- razões de manutenção, consolidação ou renomeação;
- decision ledger.

Adicionar teste de round-trip para campos textuais críticos.

---

## 28. TESTES DE MODELOS E REGISTRY

Criar testes para:

- 7 contextos ativos e ordem exata;
- ausência dos dois IDs combinados na navegação ativa;
- 8 capacidades;
- 35 conceitos;
- 40 relações capacidade-conceito;
- 591 intenções;
- 641 valores de pilar ativos;
- IDs globais únicos;
- nomes e definições exatos;
- 9 tipos e distribuições;
- risco e distribuições;
- revisão clínica e distribuições;
- horizontes e distribuições;
- evidence basis e distribuições;
- review_state = `v0.4.1_reviewed` em 591;
- todas as alternativas e complementares referenciam IDs existentes;
- nenhuma definição runtime contém IDs v0.3;
- nenhuma definição runtime contém razão de manutenção, consolidação ou renomeação;
- nenhuma query runtime contém IDs históricos;
- nenhuma lista pública utiliza aliases v0.3;
- a proveniência runtime mínima contém apenas os campos aprovados;
- os 591 IDs finais continuam únicos e completos;
- nenhum campo executável de equipamento ou ambiente;
- nenhum `parent_id`;
- nenhum `exercise_ids`;
- nenhuma definição vazia;
- schema/query namespace preservados conforme decisão técnica.

Casos localizados obrigatórios:

- `develop_muscle_hypertrophy` usa a definição v0.4.1 sem progressão residual;
- `downshift_movement_demand` usa nome e definição v0.4.1;
- `facilitate_transition_to_rest` não fixa movimento contínuo;
- `increase_perceived_task_confidence` usa definição sem `gradualmente` e horizonte `fase de retorno funcional`;
- `release_unnecessary_muscle_tension`, `reduce_perceived_stiffness` e `prepare_required_joint_ranges` não possuem requisitos materiais globais.

---

## 29. TESTES DOS PERCURSOS E LINKS

Validar:

- 7 × 40 = 280 path keys únicos;
- 261 paths com links;
- 19 paths sem links;
- zero duplicação de intenção dentro do mesmo path;
- soma das ocorrências = 771;
- todas as 591 intenções aparecem pelo menos uma vez;
- papéis e ordens correspondem à matriz;
- listas de alternativas/complementares do path são válidas;
- 59 rótulos contextuais estão ligados à ocorrência correta;
- risco e revisão nunca são reduzidos pelo path;
- os 19 motivos são preservados;
- nenhum incompatible é apresentado pela UI.

Executar teste matricial completo dos 280 paths.

---

## 30. TESTES DO PROVIDER E QUERY

Criar testes para:

- todas as combinações contexto + capacidade;
- conceitos filtrados por path compatível;
- exemplos dos 19 incompatíveis;
- intenções devolvidas apenas pelo path exato;
- ordem e agrupamento;
- query 1, 2, 3 e 4 critérios;
- rejeição de intenção global incompatível;
- mudança de contexto/capacidade/conceito limpa estado posterior;
- Home limpa tudo;
- Back preserva escolhas válidas;
- nenhuma query contém equipamento, ambiente, parent ou exercise IDs.

---

## 31. WIDGET TESTS

Cobertura mínima:

1. raiz mostra exatamente sete contextos;
2. Treino principal é explícito;
3. recovery e cooldown são separados;
4. prevention e return_to_function são separados;
5. selecionar contexto mostra oito capacidades;
6. path compatível mostra apenas conceitos válidos;
7. path incompatível mostra vazio de conceitos;
8. selecionar conceito mostra intenções reais;
9. grupos de papéis corretos;
10. hidden_advanced acessível por expansão;
11. selecionar intenção mostra estado vazio de exercícios;
12. breadcrumb inclui quatro escolhas;
13. Back e Home;
14. alertas high e clinically_restricted;
15. nota de revisão clínica;
16. nota de return_to_function;
17. detalhe da intenção;
18. pesquisa global conduz a paths válidos;
19. nenhuma intenção universal implícita;
20. layout estreito;
21. texto ampliado;
22. listas deslocáveis;
23. ausência de overflow;
24. Semantics e ValueKeys;
25. legacy invisível;
26. exercícios inexistentes.

Usar intenções representativas dos quatro riscos, dos nove tipos e dos cinco papéis.

---

## 32. ANDROID SMOKE E FULL-APP

Classificar esta missão como UI/navegação + Canonical Core.

Estender minimamente o Android smoke real para validar:

1. app arranca;
2. perfil disponível ou criado;
3. Treinos abre;
4. treino abre;
5. Adicionar exercício abre;
6. exatamente sete contextos;
7. selecionar Aquecimento;
8. selecionar Cardio e condicionamento;
9. selecionar Locomoção cíclica;
10. lista de intenções real aparece;
11. selecionar uma intenção válida;
12. estado vazio de exercícios aparece;
13. breadcrumb completo;
14. Back funciona;
15. legacy invisível;
16. zero crash;
17. zero exceções Flutter;
18. zero exceções Hero.

Executar uma full-app local dedicada pelo menos uma vez com `-ClearAppData` porque a missão altera quatro passos, vocabulário e compatibilidade.

Incluir cenários adicionais:

- recovery + speed_power sem conceitos;
- return_to_function com intenção clinically_restricted e nota prudente;
- path com hidden_advanced;
- Dashboard, Perfil, Objetivos e Definições continuam acessíveis.

Não transformar o smoke em toda a full-app.

---

## 33. INSTALAÇÃO EXISTENTE, UPGRADE E DADOS

### 33.1 Validação funcional antes da alteração de versão

Na branch funcional, validar atualização sobre uma instalação representativa da main `v1.1.3+5`:

1. instalar APK baseline da v1.1.3 com certificado atual;
2. criar perfil, medição, objetivo e treino;
3. registar contagens;
4. instalar por cima uma build da branch funcional com o mesmo package, versão e assinatura;
5. não limpar dados;
6. abrir a app;
7. confirmar contagens preservadas;
8. confirmar históricos acessíveis;
9. confirmar foreign keys;
10. confirmar sete contextos e intenções;
11. confirmar schema/user_version inalterados quando a auditoria concluiu que não existe persistência canónica.

Este APK é apenas evidência local e não é publicado.

### 33.2 Upgrade oficial da release

Na branch de release e novamente no SHA de main pós-merge, validar obrigatoriamente:

`1.1.3+5 -> 1.1.4+6`

Criar ou adaptar um harness fail-closed específico da v1.1.4, seguindo a arquitetura do harness v1.1.3 já corrigido. O harness deve:

- rejeitar APK baseline que não seja `com.sandro.evefittracker`, versionName `1.1.3`, versionCode `5`;
- rejeitar APK atual que não seja `com.sandro.evefittracker`, versionName `1.1.4`, versionCode `6`;
- verificar APK Signature Scheme v2 ou superior conforme o contrato existente;
- confirmar o mesmo certificado da v1.1.3;
- instalar a v1.1.3, criar dados representativos e instalar a v1.1.4 com `adb install -r`;
- preservar perfil, medições, objetivos, preferências, treinos, workout_exercises, sets, histórico e joins;
- confirmar foreign keys válidas;
- confirmar schema e `user_version` apenas conforme a decisão técnica auditada desta missão;
- confirmar sete contextos ativos, 591 intenções, 771 links e legacy invisível;
- confirmar que a navegação termina no estado vazio de exercícios;
- produzir logs, screenshots, contagens e JSON de evidência em diretório ignorado;
- falhar perante qualquer perda de dados ou incompatibilidade de assinatura.

Parar perante perda de dados, alteração inesperada de schema, incompatibilidade histórica ou assinatura diferente.

---

## 34. PIPELINE DE TESTES

Ler primeiro:

`docs/engineering/TESTING.md`

### 34.1 Fase funcional

Durante a implementação:

- executar Fast Gate após lotes coerentes;
- executar testes focados nos geradores, modelos, provider e UI;
- não executar após cada microedição.

Antes do push funcional:

- atualizar o manifest de shards para todos os novos testes;
- executar PR Gate uma vez;
- executar full-app local dedicada;
- executar a validação de instalação existente descrita na secção 33.1;
- não executar ainda a publicação de release.

Depois do push funcional:

- abrir PR draft;
- aguardar classificação, analyze, contracts, generator check, strict audit, manifest, quatro shards, Android smoke e `quality`;
- corrigir apenas falhas dentro do escopo;
- integrar apenas quando o head final estiver verde e auditado.

### 34.2 Fase de release

Depois do merge funcional:

- criar a branch de release a partir da main atualizada;
- executar Fast Gate após metadata/harness coerentes;
- executar PR Gate local;
- executar Release Gate completo com Android, full-app, build e upgrade `1.1.3+5 -> 1.1.4+6`;
- abrir o PR de release e aguardar o CI real;
- depois do merge de release, repetir o Release Gate completo no SHA final de main antes da tag.

Adicionar `generator --check` a um contract test ou gate existente sem criar duplicação dispendiosa em todos os shards.

---

## 35. DOCUMENTAÇÃO

### 35.1 Documentação funcional

Criar:

- `docs/canonical/Training_Intentions_v0.4.1_Implementation_Report.md`
- `docs/canonical/Seven_Usage_Contexts_v0.1_Compatibility_Report.md`
- `docs/canonical/source/training_intentions/README.md`
- `docs/canonical/generated/training_intentions_v0.4.1_manifest.json`

Atualizar documentação de arquitetura canónica existente apenas quando necessário.

O relatório funcional deve distinguir claramente duas camadas.

Runtime:

- 591 definições finais;
- 280 percursos;
- 771 links;
- proveniência runtime mínima;
- risco;
- revisão clínica;
- compatibilidades.

Auditoria documental:

- 693 IDs v0.3;
- 792 ocorrências históricas;
- mapeamento integral;
- razões de manutenção, consolidação ou renomeação;
- decision ledger;
- hashes;
- relatórios e validações do gerador.

O relatório deve declarar exatamente:

`O histórico v0.3 foi validado integralmente, mas não é carregado no runtime nem incluído no APK como dados funcionais.`

Além disso, deve incluir:

- base SHA;
- fontes e hashes;
- precedência;
- arquitetura atual encontrada;
- decisão de generated Dart;
- ficheiros gerados;
- modelos;
- sete contextos;
- auditoria dos contextos antigos;
- prova de ausência ou presença de persistência;
- 591 intenções;
- 280 paths;
- 771 links;
- 19 incompatíveis;
- 59 rótulos contextuais;
- distribuições;
- UI;
- pesquisa global;
- risco;
- revisão clínica;
- testes;
- Android;
- dados preservados;
- performance;
- limitações;
- rollback;
- riscos restantes.

### 35.2 Documentação de release v1.1.4

Na branch de release criar ou atualizar:

- `CHANGELOG.md`;
- `README.md`;
- `RELEASE_NOTES.md`;
- `.github/workflows/release.yml`;
- testes de metadata de versão;
- `docs/releases/EveFit_v1.1.4_Seven_Contexts_Training_Intentions.md`;
- `docs/releases/EveFit_v1.1.4_Release_Report.md`;
- `docs/releases/EveFit_v1.1.4_Release_Notes.md`.

A documentação de release deve declarar exatamente:

- Flutter `1.1.4+6`;
- package `com.sandro.evefittracker`;
- 7 contextos ativos;
- 8 capacidades;
- 35 conceitos;
- 40 relações capacidade-conceito;
- 280 percursos;
- 261 compatíveis;
- 19 incompatíveis;
- 591 intenções;
- 771 links percurso-intenção;
- 0 atributos oficiais;
- 0 exercícios canónicos;
- 0 subníveis;
- dados e histórico preservados;
- equipamento e local fora da identidade da intenção;
- retorno à função não equivale a reabilitação ou autorização clínica.

Não preencher URLs, hashes, tempos ou resultados antes de existirem. O relatório pode manter campos operacionais pendentes até ao momento da publicação, mas não criar um commit pós-release apenas para registar a própria URL.

---

## 36. ORQUESTRAÇÃO MULTIAGENTE

O Sol deve considerar linhas independentes:

A. Auditoria read-only da arquitetura, persistência e contextos antigos.

B. Gerador, parser, proveniência e manifest.

C. Modelos, registry, paths, links e validator.

D. Provider, controller e query path-aware.

E. UI da intenção, detalhe, agrupamento e pesquisa global.

F. Testes de contrato, matriz e equivalência.

G. Android, full-app e upgrade de instalação.

H. Documentação e auditoria final.

Agentes escritores:

- usam worktrees/branches isoladas;
- recebem zonas não sobrepostas;
- não integram entre si;
- não tocam main;
- não fazem merge, tag ou release; apenas o Sol pode executar essas ações nas fases autorizadas;
- devolvem contrato completo.

O Sol deve integrar sequencialmente quando ficheiros centrais se sobrepuserem.

A geração dos outputs deve ser feita apenas depois de o parser e modelos estarem auditados.

---

## 37. COMMITS

### 37.1 Commits funcionais

Criar commits pequenos e coerentes, por exemplo:

1. `Preserve canonical intention source registries`
2. `Add deterministic training intention generator`
3. `Add typed training intention and path models`
4. `Register seven usage contexts and canonical intentions`
5. `Integrate path-aware intention navigation`
6. `Validate canonical intention registry and Android flow`
7. `Document training intention implementation v0.1`

### 37.2 Commits de release

Depois do merge funcional, na branch de release, criar commits coerentes, por exemplo:

1. `Prepare EveFit v1.1.4 release metadata`
2. `Add v1.1.4 upgrade validation harness`
3. `Document EveFit v1.1.4 release`

O Sol pode adaptar a divisão ao diff real, mas não deve misturar alterações funcionais novas na branch de release.

Não incluir:

- APK;
- `build/`;
- `test_artifacts/`;
- caches;
- ficheiros temporários;
- untracked conhecidos.

---

## 38. REVISÃO DO DIFF

Antes de cada commit, antes de cada push, antes de cada merge e antes da tag:

```powershell
git status --short
git diff --stat
git diff --name-only
git diff
git diff --cached
```

Na branch funcional confirmar que não existem alterações fora do escopo em:

- Dashboard;
- Perfil;
- Objetivos;
- Medições;
- histórico de treino;
- catálogo de exercícios;
- package name;
- versão pública;
- signing;
- tags;
- releases;
- legacy archive.

Na branch de release permitir apenas:

- versão `1.1.4+6`;
- labels de versão;
- metadata e testes de versão;
- changelog, README, release notes e relatórios;
- workflow de release;
- harness de upgrade v1.1.4 e respetivos testes;
- correções mínimas indispensáveis ao Release Gate, documentadas e testadas.

Não usar `git add .`.

---

## 39. PR FUNCIONAL

Fazer push:

```powershell
git push -u origin feature/seven-context-training-intentions-v0.1
```

Abrir PR draft:

Título:

`EveFit Seven Contexts & Canonical Training Intentions v0.1`

Body obrigatório:

- objetivo;
- base SHA;
- fontes e hashes;
- generated Dart;
- sete contextos;
- tratamento dos IDs combinados;
- 8 capacidades;
- 35 conceitos;
- 40 relações;
- 280 paths;
- 261 compatíveis;
- 19 incompatíveis;
- 591 intenções;
- 771 links;
- 59 rótulos contextuais;
- risco/revisão clínica;
- query de quatro critérios;
- UI e pesquisa global;
- zero atributos;
- zero exercícios;
- schema/migration;
- dados preservados;
- Fast Gate;
- PR Gate;
- full-app;
- CI;
- performance;
- versão funcional mantida em `1.1.3+5`;
- publicação posterior autorizada como `v1.1.4`.

---

## 40. QUALITY GATE E MERGE FUNCIONAL

Aguardar:

```powershell
gh pr checks <FEATURE_PR_NUMBER> --watch
```

Confirmar:

- classificação exige Android;
- Analyze verde;
- Contract tests verdes;
- generator check verde;
- Strict catalog audit verde;
- manifest verde;
- shard-1 verde;
- shard-2 verde;
- shard-3 verde;
- shard-4 verde;
- Android smoke verde;
- `quality` verde;
- nenhum teste omitido;
- zero skips novos;
- head estável;
- PR mergeable;
- versão ainda `1.1.3+5`.

Se falhar por código desta missão:

- corrigir dentro do escopo;
- executar Fast Gate e testes focados;
- PR Gate quando necessário;
- push;
- aguardar novo CI.

Quando todos os gates estiverem verdes:

1. rever o diff final completo;
2. confirmar os dois untracked;
3. confirmar que nenhum output gerado indevido está staged;
4. marcar o PR ready;
5. integrar com merge commit;
6. registar o merge SHA;
7. atualizar main por fast-forward;
8. confirmar que `origin/main` contém o head funcional e que o working tree continua seguro.

Comandos conceptuais:

```powershell
gh pr ready <FEATURE_PR_NUMBER>
gh pr merge <FEATURE_PR_NUMBER> --merge
git checkout main
git pull --ff-only origin main
git rev-parse HEAD
```

Não usar squash, rebase ou force-push para esconder a proveniência da implementação.

---

## 41. PREPARAÇÃO DA RELEASE v1.1.4

Criar a branch de release exclusivamente da main que contém o merge funcional:

```powershell
git checkout main
git pull --ff-only origin main
git checkout -b release/v1.1.4-seven-contexts-training-intentions
```

Versão alvo obrigatória:

- Flutter: `1.1.4+6`;
- Android versionName: `1.1.4`;
- Android versionCode: `6`;
- package: `com.sandro.evefittracker`.

Parar quando a main real já tiver versionCode diferente de `5`, quando `v1.1.4` já existir ou quando o próximo versionCode monotónico não puder ser confirmado sem decisão de Sandro.

Atualizar apenas a metadata e documentação necessárias, incluindo o workflow de release e o harness oficial de upgrade. O nome final do APK é:

`EveFit-v1.1.4-seven-contexts-training-intentions-release.apk`

Executar:

```powershell
flutter pub get
dart run tool/testing/evefit_gate.dart fast
dart run tool/testing/evefit_gate.dart pr
```

Obter o APK oficial baseline da release v1.1.3 sem alterar releases existentes:

```powershell
gh release view v1.1.3 --repo ryoken99/evefit_tracker
gh release download v1.1.3 --repo ryoken99/evefit_tracker --pattern "*.apk" --dir test_artifacts/release/v1.1.4/baseline
```

Identificar e validar o APK correto por package, versionName `1.1.3`, versionCode `5` e certificado, sem confiar apenas no nome do ficheiro.

Executar Release Gate completo na branch de release com:

- todos os quatro shards;
- strict audit;
- Android smoke;
- full-app com dados limpos;
- build release;
- upgrade oficial v1.1.3 -> v1.1.4;
- assinatura;
- metadata do APK;
- hash SHA-256;
- git status.

Usar o comando real suportado pelo gate atualizado, equivalente a:

```powershell
dart run tool/testing/evefit_gate.dart release --enable-android --enable-full-app --enable-build --enable-upgrade --baseline-apk <V113_APK>
```

Não publicar ainda.

---

## 42. PR DE RELEASE E MERGE

Fazer push:

```powershell
git push -u origin release/v1.1.4-seven-contexts-training-intentions
```

Abrir PR draft com o título exato:

`EveFit v1.1.4 — Sete Contextos e Intenções Canónicas`

O body deve incluir:

- merge SHA funcional;
- versão `1.1.4+6`;
- inventário canónico completo;
- ausência de exercícios;
- schema/migrations;
- dados preservados;
- resultados de Fast Gate, PR Gate e Release Gate;
- upgrade `1.1.3+5 -> 1.1.4+6`;
- package e certificado;
- nome, tamanho e SHA-256 do APK local validado;
- zero artefactos runtime no commit.

Aguardar o CI real:

```powershell
gh pr checks <RELEASE_PR_NUMBER> --watch
```

Confirmar todos os jobs obrigatórios verdes no head final. Depois:

1. rever o diff;
2. marcar ready;
3. integrar com merge commit;
4. atualizar main;
5. registar o SHA final de main;
6. confirmar `pubspec.yaml` em `1.1.4+6`;
7. confirmar que nenhuma tag foi criada prematuramente.

```powershell
gh pr ready <RELEASE_PR_NUMBER>
gh pr merge <RELEASE_PR_NUMBER> --merge
git checkout main
git pull --ff-only origin main
git rev-parse HEAD
```

---

## 43. RELEASE GATE PÓS-MERGE

No SHA final e limpo de main, repetir o Release Gate completo. Esta repetição é obrigatória porque o artefacto público deve ser construído e validado a partir do commit exato que receberá a tag.

Confirmar novamente:

- source hashes;
- generator check;
- 7/8/35/40/280/261/19/591/771;
- quatro shards e suíte consolidada conforme o Release Gate;
- Android smoke;
- full-app;
- upgrade `1.1.3+5 -> 1.1.4+6`;
- dados e histórico;
- package;
- versionName/versionCode;
- assinatura e certificado;
- ausência de legacy;
- zero exercícios;
- git status sem alterações tracked.

Copiar o APK validado, sem o adicionar ao Git:

```powershell
Copy-Item build/app/outputs/flutter-apk/app-release.apk test_artifacts/release/v1.1.4/EveFit-v1.1.4-seven-contexts-training-intentions-release.apk
```

Registar:

- caminho;
- tamanho em bytes;
- SHA-256;
- package;
- versionName;
- versionCode;
- schemes de assinatura;
- subject e SHA-256 do certificado.

Parar sem tag quando qualquer verificação falhar.

---

## 44. TAG E GITHUB RELEASE v1.1.4

Pré-condições:

- main limpa;
- SHA final registado;
- Release Gate pós-merge verde;
- tag `v1.1.4` inexistente local e remotamente;
- GitHub Release `v1.1.4` inexistente;
- APK candidato local validado e não committed;
- `.github/workflows/release.yml` auditado para criar a release a partir do push da tag;
- tags e releases anteriores intocadas.

A publicação deve usar exatamente um mecanismo. Como o repositório possui o workflow `Build & Release APK` acionado por tags `v*`, não executar `gh release create` em paralelo nem antes do workflow.

Criar tag anotada no SHA final de main:

```powershell
git tag -a v1.1.4 <FINAL_MAIN_SHA> -m "EveFit v1.1.4 — Sete Contextos e Intenções Canónicas"
git push origin v1.1.4
```

Verificar que a tag resolve exatamente para `<FINAL_MAIN_SHA>`.

O push deve acionar o workflow de release atualizado, que deve:

- fazer checkout do commit da tag;
- validar a versão `1.1.4+6`;
- executar as validações previstas no próprio workflow sem substituir o Release Gate local já concluído;
- construir o APK release;
- verificar package, versionName, versionCode e assinatura antes do upload;
- renomear o asset para `EveFit-v1.1.4-seven-contexts-training-intentions-release.apk`;
- criar ou atualizar apenas a release associada à tag `v1.1.4`;
- usar o título `EveFit v1.1.4 — Sete Contextos e Intenções Canónicas`;
- usar as notas aprovadas da v1.1.4;
- criar release estável, não draft e não prerelease.

Identificar o run pelo workflow, tag e `headSha`, não apenas pelo run mais recente:

```powershell
gh run list --repo ryoken99/evefit_tracker --workflow release.yml --event push --limit 20
gh run watch <RELEASE_WORKFLOW_RUN_ID> --repo ryoken99/evefit_tracker --exit-status
```

Parar quando o workflow falhar. Não criar uma release manual para esconder uma falha do workflow.

Depois do workflow verde:

1. confirmar que a release `v1.1.4` existe;
2. confirmar `isDraft=false` e `isPrerelease=false`;
3. confirmar ou definir latest com `gh release edit v1.1.4 --latest` apenas quando necessário;
4. confirmar o asset com o nome exato;
5. descarregar o asset para um diretório ignorado;
6. calcular o SHA-256 do asset descarregado;
7. inspecionar package, versionName `1.1.4`, versionCode `6`, schemes de assinatura e certificado;
8. confirmar que a tag e o release asset correspondem ao SHA final e à versão autorizada;
9. confirmar que v1.1.0, v1.1.1, v1.1.2 e v1.1.3 permanecem inalteradas.

O APK construído pelo runner GitHub pode não ser byte-for-byte igual ao candidato local devido a metadata de build não determinística. Não declarar divergência apenas por hashes diferentes. A equivalência obrigatória é:

- mesmo código/tag;
- mesmo package;
- mesma versionName/versionCode;
- mesmo certificado;
- mesma configuração release;
- validações verdes.

Registar separadamente o hash do APK candidato local e o hash do asset público.

Não criar commit apenas para substituir campos pendentes pela URL da release.

---

## 45. CRITÉRIOS DE ACEITAÇÃO

A missão só está concluída quando todos forem verdadeiros:

- fontes exatas e hashes confirmados;
- v0.4 preservada sem alteração;
- v0.4.1 prevalece;
- runtime não interpreta Markdown;
- gerador determinístico e `check` funcional;
- 7 contextos ativos;
- antigos contextos combinados fora da navegação;
- auditoria de persistência concluída;
- DB preservada por migration aditiva ou inalterada conforme a inspeção real;
- 8 capacidades;
- 35 conceitos;
- 40 relações;
- 280 paths;
- 261 compatíveis;
- 19 incompatíveis sem links e ocultos;
- 591 intenções únicas;
- 771 links;
- 693 IDs históricos confirmados e validados fora do runtime;
- 792 ocorrências históricas confirmadas e validadas fora do runtime;
- mapa histórico integral validado fora do runtime;
- hash normalizado do mapa histórico registado no manifest;
- todos os IDs históricos possuem destino válido;
- nenhum ID histórico nas 591 definições runtime;
- nenhuma razão de manutenção, consolidação ou renomeação nas definições runtime;
- nenhum mapa completo v0.3 no código gerado da aplicação;
- proveniência runtime limitada aos campos aprovados;
- 59 rótulos contextuais;
- rótulo público `Resultado de adaptação` para o ID interno `adaptation_outcome`;
- fontes v0.4 e v0.4.1 byte-for-byte inalteradas;
- todas as distribuições fechadas passam;
- equipamento e ambiente ausentes do modelo executável de intenção;
- risco e revisão clínica separados;
- provider path-aware;
- query com quatro critérios após intenção;
- pesquisa global conduz a paths reais;
- UI agrupa papéis e mantém hidden advanced acessível;
- estado vazio de exercícios correto;
- zero atributos oficiais;
- zero exercícios;
- zero subníveis;
- dados pessoais preservados;
- históricos preservados;
- Fast Gate verde;
- PR Gate verde;
- full-app verde;
- quatro shards verdes;
- Android smoke verde;
- feature quality verde;
- feature PR integrado;
- versão funcional manteve `1.1.3+5` até ao merge;
- release branch criada da main atualizada;
- versão final `1.1.4+6`;
- release quality verde;
- release PR integrado;
- Release Gate pós-merge verde;
- APK final validado;
- tag anotada `v1.1.4` aponta para o SHA final de main;
- GitHub Release `v1.1.4` estável/latest publicada;
- APK anexado com nome, metadata e assinatura confirmados; hashes local e público registados separadamente;
- tags/releases anteriores inalteradas;
- os dois untracked preservados;
- main final limpa.

---

## 46. CONDIÇÕES DE PARAGEM

Parar e reportar quando:

- hash de fonte diverge;
- fonte está truncada;
- parser não produz contagens fechadas;
- qualquer texto canónico fica ambíguo;
- contextual label não pode ser associado univocamente;
- main contém alteração incompatível;
- existe persistência dos contextos combinados que exige escolha semântica;
- é necessária migration destrutiva ou não prevista sem prova de preservação;
- há risco de perda de dados;
- histórico deixa de abrir;
- é necessário criar exercício, atributo ou prescrição;
- equipamento/local teria de entrar na intenção;
- risco e revisão clínica não podem permanecer separados;
- performance degrada materialmente sem solução segura;
- CI omite testes;
- Android falha sem correção dentro do escopo;
- qualquer gate obrigatório permanece vermelho;
- branch protection exige bypass;
- certificado da v1.1.4 difere da v1.1.3;
- package muda;
- versionCode `6` deixa de ser o próximo valor monotónico;
- tag ou release `v1.1.4` já existem inesperadamente;
- APK final não corresponde ao commit/tag;
- GitHub CLI ou permissões impedem uma publicação verificável.

Não ampliar a missão nem publicar parcialmente para contornar um blocker.

---

## 47. ENTREGA DOS SUBAGENTES

Cada agente deve devolver:

1. identificador;
2. modelo;
3. reasoning;
4. papel;
5. missão;
6. branch/worktree;
7. base SHA;
8. final SHA;
9. ficheiros analisados;
10. ficheiros alterados;
11. testes;
12. resultados;
13. contagens;
14. decisões técnicas;
15. riscos;
16. limitações;
17. conflitos;
18. recomendações;
19. merge realizado: não;
20. main alterada: não;
21. versão alterada: não;
22. tag criada: não;
23. release criada: não.

---

## 48. ENTREGA FINAL DO SOL

Responder:

`EveFit v1.1.4 — Sete Contextos e Intenções Canónicas implementada, integrada e publicada.`

Incluir:

1. Feature branch:
2. Feature commit base:
3. Feature commit final:
4. Feature PR:
5. Feature PR estado final:
6. Feature PR head:
7. Feature quality gate:
8. Feature merge SHA:
9. Release branch:
10. Release commit base:
11. Release commit final:
12. Release PR:
13. Release PR estado final:
14. Release PR head:
15. Release quality gate:
16. Release merge SHA:
17. Final main SHA:
18. Agentes e threads:
19. Modelos e reasoning:
20. Worktrees:
21. Resultados aceites/rejeitados:
22. Fontes lidas integralmente:
23. SHA-256 v0.4:
24. SHA-256 v0.4.1:
25. v0.4 preservada:
26. Gerador:
27. Generator check:
28. Outputs gerados:
29. Manifest:
30. Contextos ativos: 7
31. Lista dos contextos:
32. Contextos antigos ativos: não
33. Persistência dos IDs antigos encontrada:
34. Migration criada:
35. DB schema/version:
36. Capacidades: 8
37. Conceitos: 35
38. Relações capacidade-conceito: 40
39. Percursos: 280
40. Percursos compatíveis: 261
41. Percursos incompatíveis: 19
42. Intenções: 591
43. Links percurso-intenção: 771
44. IDs v0.3: 693
45. Ocorrências v0.3: 792
46. Rótulos contextuais: 59
47. Tipos e contagens:
48. Risco e contagens:
49. Revisão clínica yes/no:
50. Papéis e contagens:
51. Equipamento no modelo de intenção: não
52. Ambiente no modelo de intenção: não
53. Query depois de intenção:
54. Pesquisa global por intenção:
55. Estado vazio de exercícios:
56. UI de risco:
57. UI de revisão clínica:
58. Retorno à função:
59. Fast Gate funcional:
60. PR Gate funcional:
61. Testes focados:
62. Total de testes:
63. Quatro shards:
64. Duração dos shards:
65. Android smoke:
66. Full-app:
67. Instalação existente:
68. Fast Gate release:
69. PR Gate release:
70. Release Gate pré-merge:
71. Release Gate pós-merge:
72. Upgrade 1.1.3+5 -> 1.1.4+6:
73. Dados pessoais preservados:
74. Históricos preservados:
75. Performance antes/depois:
76. flutter analyze:
77. Versão final: 1.1.4+6
78. Package:
79. APK nome:
80. APK tamanho:
81. APK candidato local SHA-256:
82. APK público SHA-256:
83. APK signature schemes:
84. Certificado subject:
85. Certificado SHA-256:
86. Tag:
87. Tag commit:
88. Release workflow run:
89. Release URL:
90. Stable/latest:
91. Asset verificado:
92. Releases anteriores preservadas:
93. Documentação:
94. Ficheiros alterados:
95. Código de exercícios alterado: não
96. Atributos adicionados: 0
97. Exercícios adicionados: 0
98. Subníveis adicionados: 0
99. Untracked 1 preservado:
100. Untracked 2 preservado:
101. git status final:
102. Riscos restantes:
103. Histórico v0.3 validado:
104. IDs históricos validados: 693
105. Ocorrências históricas validadas: 792
106. Hash normalizado do mapa histórico:
107. Histórico completo incluído no runtime: não
108. IDs v0.3 nas definições runtime: 0
109. Razões de consolidação nas definições runtime: 0
110. Proveniência runtime:
111. Rótulo público de adaptation_outcome: Resultado de adaptação
112. Testes de separação runtime/auditoria:

---

## 49. RELATÓRIO DE BLOQUEIO

Quando parar por blocker, responder:

`EveFit Seven Contexts & Canonical Training Intentions v0.1 parada por blocker antes da publicação v1.1.4.`

Incluir:

1. Etapa:
2. Tipo de blocker:
3. Comando:
4. Erro:
5. Causa técnica:
6. Fonte ou ID afetado:
7. Contagem afetada:
8. Dados em risco:
9. Histórico afetado:
10. Branch:
11. HEAD:
12. Feature PR:
13. Release PR:
14. Feature merge realizado:
15. Release merge realizado:
16. Tag criada:
17. Release criada:
18. APK publicado:
19. Alterações integradas:
20. Alterações pendentes:
21. Menor solução recomendada:
22. Decisão de produto necessária:
23. git status:

Quando a tag tiver sido criada mas a release falhar, não apagar ou mover a tag automaticamente. Reportar o estado exato e pedir decisão, salvo quando a falha puder ser corrigida sem alterar o commit ou o artefacto validado.

---

## 50. PARAGEM OBRIGATÓRIA

Parar completamente depois de:

- integrar o PR funcional;
- integrar o PR de release;
- executar o Release Gate pós-merge;
- criar a tag anotada `v1.1.4`;
- publicar e verificar a GitHub Release estável/latest;
- anexar e verificar o APK;
- concluir os relatórios;
- entregar o relatório consolidado.

Não:

- iniciar v1.1.5;
- alterar a tag depois de publicada;
- substituir o APK sem nova validação e decisão explícita;
- alterar releases anteriores;
- adicionar atributos oficiais;
- adicionar exercícios;
- implementar localização/inventário;
- implementar prescrição;
- implementar elegibilidade clínica;
- iniciar outra missão.
