# 30 - Índice global e roadmap final

## Objetivo

Este ficheiro fecha o pacote de reconstrução do catálogo EveFit.

A regra base é:

```text
Conceitos primeiro.
Exercícios derivados depois.
Compatibilidade, filtros, descrições e testes no fim.
```

## Índice dos ficheiros

| Ficheiro | Nome | Função |
| --- | --- | --- |
| 10 | MUSCULACAO_CONCEITOS_POR_MUSCULO | Mapa conceptual de musculação por músculos, funções e famílias. |
| 11 | MUSCULACAO_EXERCICIOS_DERIVADOS | Exercícios derivados de musculação. |
| 12 | CARDIO_CONCEITOS_E_MODALIDADES | Sistemas, intensidades e modalidades de cardio. |
| 13 | CARDIO_EXERCICIOS_DERIVADOS | Exercícios e variantes de cardio. |
| 14 | ARTES_MARCIAIS_ESTRUTURA_CONCEITOS | Mapa conceptual de artes marciais. |
| 15 | ARTES_MARCIAIS_EXERCICIOS_DERIVADOS | Exercícios técnicos derivados de artes marciais. |
| 16 | MOBILIDADE_CONCEITOS_POR_ARTICULACAO | Conceitos de mobilidade por articulação. |
| 17 | MOBILIDADE_EXERCICIOS_DERIVADOS | Exercícios de mobilidade. |
| 18 | ELASTICIDADE_CONCEITOS_POR_ZONA | Conceitos de elasticidade por zona. |
| 19 | ELASTICIDADE_EXERCICIOS_DERIVADOS | Alongamentos e progressões. |
| 20 | RECUPERACAO_CONCEITOS_E_METODOS | Conceitos e métodos de recuperação. |
| 21 | RECUPERACAO_EXERCICIOS_DERIVADOS | Protocolos de recuperação. |
| 22 | AQUECIMENTO_ATIVACAO_PREVENCAO_CONCEITOS | Conceitos de preparação, ativação e prevenção. |
| 23 | AQUECIMENTO_ATIVACAO_PREVENCAO_EXERCICIOS_DERIVADOS | Exercícios, protocolos e checklists de preparação. |
| 24 | LOCAIS_E_EQUIPAMENTOS_MAPA_GLOBAL | Locais, equipamentos e compatibilidade. |
| 25 | FILTROS_COMPATIBILIDADE_E_REGRAS_DE_VISIBILIDADE | Regras de filtros e lógica da UI. |
| 26 | MODELO_DADOS_E_IDS_CANONICOS | Modelo de dados e IDs estáveis. |
| 27 | DESCRICOES_EXECUCOES_TEMPLATES_E_PROMPTS | Templates para descrições e execução. |
| 28 | TESTES_QA_E_AUDITORIA_CATALOGO | Testes, QA, auditoria e cenários E2E. |
| 29 | IMPORTACAO_APP_EVEFIT_ENTREGA_AO_FABEL | Ordem de implementação para Fabel. |

## Como usar o pacote

```text
1. Ler os mapas conceptuais.
2. Verificar se os exercícios derivados cobrem os conceitos.
3. Aplicar locais e equipamentos.
4. Aplicar filtros e regras de visibilidade.
5. Criar o modelo de dados.
6. Gerar descrições completas.
7. Correr auditoria.
8. Implementar na app.
9. Validar com cenários E2E.
```

## Roadmap de implementação

```text
Milestone 1: dados base
- domínios
- locais
- equipamentos
- filtros
- hierarquia muscular
- articulações

Milestone 2: catálogo
- conceitos
- exercícios
- aliases
- variantes
- alvos principais e secundários

Milestone 3: UI
- fluxo por domínio
- filtros encadeados
- completo para saltar subfiltros
- perfil de equipamento e locais

Milestone 4: descrições
- fichas completas pt-PT
- execução passo a passo
- erros comuns
- segurança

Milestone 5: testes
- integridade
- filtros
- compatibilidade
- E2E
- relatório final
```

## Critério de pacote completo

```text
Todos os domínios principais estão cobertos.
Todos os exercícios têm origem em conceitos.
Todos os locais e equipamentos têm regras.
Todos os filtros têm lógica.
Todos os exercícios têm descrição e segurança.
Todos os cenários críticos têm testes.
O Fabel tem uma ordem de implementação clara.
```

## Próximo passo recomendado

```text
Converter estes ficheiros em seed data estruturado, como JSON, SQLite ou Kotlin data classes.
Depois implementar importação automática e testes de integridade na app.
```

## Fecho

Este pacote não é apenas uma lista de exercícios. É uma arquitetura para gerar, filtrar, explicar, validar e manter o catálogo da EveFit sem cair em duplicação, descrições genéricas ou filtros errados.
