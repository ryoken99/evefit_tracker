# EveFit v1.1.4 — Sete Contextos e Intenções Canónicas

## Objetivo

EveFit v1.1.4 prepara uma pesquisa canónica de treino mais específica sem adicionar exercícios. O seletor passa por Contexto, Capacidade, Conceito e Intenção antes do estado vazio de Exercícios.

## Alterações visíveis

Os contextos ativos são, por esta ordem: Treino principal, Aquecimento, Ativação, Recuperação, Retorno à calma, Prevenção e adaptação, e Retorno à função. Treino principal é uma escolha explícita, nunca uma injeção automática.

Após escolher um contexto, o utilizador escolhe uma das oito capacidades, um conceito compatível e uma intenção contextualizada. A seleção de intenção é explícita e apresenta o breadcrumb completo. As opções avançadas, risco operacional e revisão clínica são apresentados apenas quando o percurso os exige.

## Modelo canónico

O fluxo é:

`Contexto → Capacidade → Conceito → Intenção → Exercícios`

Cada escolha acrescenta um critério à query estruturada. A query final contém apenas `usage_context`, `capability_root`, `training_concept` e `training_intention`. Não contém `exercise_ids`, IDs legacy, `parent_id`, equipamento, ambiente, protocolo ou prescrição.

Os pilares classificam; os atributos oficiais continuam a ser uma camada futura. Contextos, capacidades, conceitos e intenções não criam relações de propriedade entre si: a compatibilidade é definida por percursos tipados e por ligações de intenção específicas do percurso.

## Inventário aprovado

| Elemento | Total |
| --- | ---: |
| Contextos de utilização | 7 |
| Capacidades | 8 |
| Conceitos de treino | 35 |
| Relações capacidade-conceito | 40 |
| Percursos | 280 |
| Percursos compatíveis | 261 |
| Percursos incompatíveis | 19 |
| Intenções globais | 591 |
| Ligações percurso-intenção | 771 |
| Atributos oficiais | 0 |
| Exercícios canónicos | 0 |
| Subníveis | 0 |

As 19 incompatibilidades mantêm a respetiva justificação e não são apresentadas como opções disponíveis. Não existem ainda exercícios aprovados para os percursos concluídos; o estado vazio é intencional e não mostra catálogo legacy nem resultados fictícios.

## Fontes e histórico

As fontes imutáveis v0.4 e v0.4.1 são transformadas em Dart tipado pelo gerador determinístico. O runtime não lê Markdown, não usa a rede e não reconstrói a registry durante a renderização.

Foram validados 693 IDs históricos e 792 ocorrências históricas. O histórico v0.3 foi validado integralmente, mas não é carregado no runtime nem incluído no APK como dados funcionais.

## Dados e compatibilidade

O schema da base de dados mantém-se em 22 e não são adicionadas migrations. As escolhas canónicas são estado transitório de interface. Perfis, medições, objetivos, treinos, séries, referências históricas, preferências, fotos e o arquivo legacy permanecem preservados.

A atualização suportada nesta release é `1.1.3+5 → 1.1.4+6`. A execução final do upgrade é um gate obrigatório de publicação; este documento não declara esse gate concluído antes da respetiva evidência operacional.

## Desempenho

As medições funcionais no AVD `EveFit_Test_Device` Pixel 8 Pro não mostraram regressão reprodutível acima do limiar de investigação de 25%:

| Medição | Main autorizada | Implementação funcional |
| --- | ---: | ---: |
| Perfil pronto | 4.181 ms | 4.349 ms |
| Abrir seletor, smoke limpo | 128 ms | 125 ms |
| Abrir seletor, full-app | 129 ms | 129 ms |
| APK debug | 179.285.322 bytes | 179.301.706 bytes |

A lista global de 591 intenções é virtualizada e os índices de percurso evitam percorrer as 771 ligações em cada frame. A medição, build e inspeção do APK de release são repetidos antes da publicação.

## Validação

A fase funcional registou Fast Gate, PR Gate, quatro shards, Android smoke, fluxo Android completo e validação de instalação existente. A versão de release é `1.1.4+6`; quality gate remoto, upgrade de release, build assinado, inspeção de APK, validação em main e publicação são passos separados e obrigatórios.

## Instalação

Depois da publicação, instalar o APK de release disponibilizado para a tag `v1.1.4`. O package permanece `com.sandro.evefittracker`. O APK usa a configuração de assinatura atual do projeto; a compatibilidade com Play Store não deve ser inferida sem uma verificação específica dessa distribuição.

## Limitações e riscos

- Não existem atributos oficiais, exercícios canónicos nem subníveis.
- Os exercícios compatíveis serão adicionados e validados progressivamente numa missão futura.
- Avisos de risco e revisão clínica são salvaguardas informativas e não substituem diagnóstico, tratamento, reabilitação, critérios clínicos ou autorização de retorno ao desporto.
- A registry gerada é deliberadamente grande; hashes de fonte, geração determinística, APK e tempos de seletor exigem validação em cada release.

## Rollback e próximos passos

O rollback é a reversão normal do merge da funcionalidade ou da release. Não é necessário downgrade de dados porque não há migration nem persistência nova. Os próximos passos possíveis são a aprovação progressiva de atributos, conceitos adicionais, intenções adicionais ou exercícios, sem os iniciar nesta release.
