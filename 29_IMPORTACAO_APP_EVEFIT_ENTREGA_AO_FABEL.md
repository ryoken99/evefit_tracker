# 29 - Importação na app EveFit e entrega ao Fabel

## Objetivo

Este ficheiro é a ordem final para implementar o catálogo na app, usando todos os ficheiros anteriores.

A regra base é:

```text
Não adicionar exercícios soltos sem conceito.
Não criar filtros sem regra de compatibilidade.
Não publicar exercício sem descrição, execução e segurança.
```

## Ordem de trabalho

| Fase | Ação | Resultado |
| --- | --- | --- |
| 1 | Ler ficheiros 10 a 23 | Entender conceitos e exercícios já definidos. |
| 2 | Importar 24 | Criar locais, equipamentos e compatibilidade. |
| 3 | Importar 25 | Implementar filtros e regras de visibilidade. |
| 4 | Importar 26 | Criar modelo de dados, IDs e relações. |
| 5 | Importar 27 | Gerar descrições e execução por template. |
| 6 | Importar 28 | Implementar testes e auditoria. |
| 7 | Corrigir catálogo | Resolver duplicados, campos vazios e filtros errados. |
| 8 | Testar app | Validar fluxos em UI e dados. |
| 9 | Entregar relatório | Listar mudanças, falhas corrigidas e pendências. |

## Ordem completa para o Fabel

```text
1. Ler todos os ficheiros Markdown do pacote.
2. Tratar os ficheiros 10, 12, 14, 16, 18, 20 e 22 como mapas conceptuais.
3. Tratar os ficheiros 11, 13, 15, 17, 19, 21 e 23 como listas de exercícios derivados.
4. Usar o ficheiro 24 para criar locais, equipamentos e compatibilidades.
5. Usar o ficheiro 25 para implementar filtros e regras de visibilidade.
6. Usar o ficheiro 26 para criar ou ajustar o modelo de dados.
7. Usar o ficheiro 27 para regenerar descrições e execuções uma a uma.
8. Usar o ficheiro 28 para criar testes e auditoria.
9. Não avançar para UI final enquanto existirem IDs duplicados, descrições em falta ou filtros inválidos.
10. Entregar relatório final com contagens, testes e pendências.
```

## Requisitos de implementação

```text
primary_type e secondary_types obrigatórios
equipment_required ou eq_none obrigatório
place_ids obrigatórios
level obrigatório
safety_flags quando aplicável
filters derivados das regras do ficheiro 25
aliases para nomes alternativos
variants para equipamento, pega, posição ou intensidade
instructions pt-PT completas
```

## Regras de UI

```text
O primeiro ecrã escolhe domínio do treino.
Cada domínio abre um fluxo próprio.
Musculação usa hierarquia região -> grupo -> subgrupo -> músculo.
Completo permite saltar filtros abaixo.
Cardio começa por modalidade, impacto e intensidade.
Artes marciais começa por arte, família técnica, contacto e parceiro.
Mobilidade começa por articulação e função.
Elasticidade começa por zona e método.
Recuperação começa por objetivo e segurança.
Aquecimento começa pelo treino que vem a seguir.
```

## Critérios de aceitação

| Área | Critério |
| --- | --- |
| Catálogo | Todos os exercícios importados com IDs estáveis. |
| Filtros | Todos os domínios abrem fluxo correto. |
| Locais | Casa, ginásio, dojo, exterior e trabalho filtram corretamente. |
| Equipamento | Required, optional, support e protective funcionam. |
| Descrição | Todos os exercícios têm ficha pt-PT completa. |
| Segurança | Quedas, contacto, dor e recuperação têm avisos. |
| Testes | Testes de integridade e E2E passam. |
| Relatório | Entrega inclui contagens e lista de correções. |

## Relatório final que o Fabel deve gerar

```text
Resumo do que foi importado
Número de conceitos por domínio
Número de exercícios por domínio
Número de equipamentos
Número de locais
Número de filtros
Duplicados detetados e resolvidos
Exercícios sem descrição, se existirem
Testes que passaram
Testes que falharam
Pendências reais
Screenshots ou logs dos fluxos principais
```

## Proibição explícita

```text
Não gerar descrições genéricas.
Não meter todos os exercícios em todos os filtros.
Não tratar mobilidade como alongamento passivo.
Não tratar recuperação como treino intenso.
Não tratar prevenção como promessa de ausência de lesões.
Não mostrar exercícios com equipamento indisponível.
Não esconder antebraço, punho, mão e dedos dentro de bíceps.
Não esconder lombar e escápulas dentro de costas sem subfiltros.
Não avançar se testes E2E falharem.
```

## Próximo ficheiro

```text
30_INDICE_GLOBAL_E_ROADMAP_FINAL.md
```
