# 28 - Testes, QA e auditoria do catálogo

## Objetivo

Este ficheiro define a auditoria obrigatória antes de importar ou lançar o catálogo na app.

A regra base é:

```text
Um catálogo grande sem testes fica inutilizável.
Cada exercício tem de passar por identidade, filtros, compatibilidade, descrição e segurança.
```

## Testes estruturais

| Área | Teste | Critério de falha |
| --- | --- | --- |
| IDs | exercise_id, concept_id e equipment_id únicos | Falha se houver duplicados ou órfãos. |
| Domínios | primary_type válido e secondary_types válidos | Falha se domínio não existir. |
| Locais | todo exercício tem place_ids | Falha se não aparecer em nenhum local. |
| Equipamento | required ou eq_none obrigatório | Falha se required não existir no catálogo. |
| Filtros | filtros batem com domínio e alvo | Falha se exercício aparece em filtro errado. |
| Músculos | alvos principais e secundários coerentes | Falha se músculo principal estiver errado. |
| Nível | iniciante, intermédio ou avançado | Falha se vazio ou inconsistente. |
| Segurança | safety_flags para contacto, quedas, dor, máquinas e recovery | Falha se exercício arriscado não tem aviso. |
| Descrição | pt-PT completa | Falha se sem passos, erros ou cuidados. |
| Duplicação | aliases e variantes não duplicam exercício | Falha se mesmo movimento tem dois exercise_id. |

## Cenários E2E obrigatórios

| Cenário | Resultado esperado |
| --- | --- |
| Casa sem equipamento + musculação + peito | Mostra flexões e variações sem equipamento. Oculta máquinas e cabos. |
| Ginásio + costas + largura | Mostra lat pulldown, pull-up, pullover. Não prioriza remadas de espessura. |
| Braço + antebraço | Mostra curls de punho, pronação, supinação, pega. Não mostra curls de bíceps como principal. |
| Cardio + baixo impacto | Mostra caminhada, bicicleta, elíptica. Oculta burpees e sprints. |
| BJJ + solo + iniciante | Mostra shrimp, ponte, technical stand-up. Oculta inversões avançadas. |
| Judo + quedas | Exige tatami e ukemi progressivo. |
| Elasticidade + PNF | Mostra aviso de contração leve e não aparece como recuperação leve. |
| Recuperação + dor articular forte | Mostra checklist de segurança, não protocolo agressivo. |
| Aquecimento + sprints | Mostra aquecimento específico e progressivo. |
| Prevenção + ombro | Mostra controlo e tolerância, sem promessa de evitar lesões. |

## Testes por domínio

### Musculação

```text
exercícios aparecem no músculo certo
exercícios compostos aparecem nos músculos secundários apenas como secundários
máquinas só aparecem em locais com máquinas
halteres e barra respeitam equipamento do perfil
costas divide largura, espessura, lombar e escápulas
braços divide bíceps, tríceps, antebraço, punho, mão e dedos
core divide superior, médio, inferior, lateral, anti-extensão e anti-rotação
pernas divide acima e abaixo do joelho
```

### Cardio

```text
baixo impacto oculta saltos agressivos
HIIT exige aquecimento
sprints exigem aquecimento progressivo
recuperação ativa mantém intensidade baixa
passadeira tem caminhada, corrida, inclinação, intervalos e cooldown separados
```

### Artes marciais

```text
cada exercício tem arte principal
cada exercício com parceiro obrigatório fica oculto em solo
quedas exigem tatami
striking com impacto recomenda luvas ou progressão
BJJ inclui solo, guarda, escapes, quedas, pegada e condicionamento
Karate inclui bases, kihon, kata, kumite técnico e saco
MMA e defesa pessoal usam regras realistas de saída e segurança
```

### Mobilidade e elasticidade

```text
mobilidade tem articulação e função
elasticidade tem zona e método
90/90 ativo e passivo não são tratados como a mesma execução
PNF não aparece como recuperação leve
aberturas têm regressões e avisos
```

### Recuperação

```text
intensidade baixa obrigatória
red flags aparecem antes de exercícios
foam roller evita articulações
pistola de massagem tem contraindicações
checklists não aparecem como exercício físico
```

### Aquecimento, ativação e prevenção

```text
aquecimento é progressivo
ativação não gera fadiga relevante
prevenção não promete evitar lesões
sprints e HIIT têm aquecimento específico
artes marciais têm aquecimento específico por modalidade
```

## Auditoria de duplicados

```text
normalizar nomes para snake_case
comparar aliases
comparar padrões de movimento
comparar equipamento e contexto
marcar duplicados como aliases ou variants
manter um único exercise_id canónico
```

## Relatório de auditoria esperado

```text
total_exercises
total_concepts
total_duplicates_found
total_duplicates_fixed
missing_descriptions
missing_equipment
missing_places
missing_safety_flags
invalid_filters
orphan_concepts
orphan_variants
failed_e2e_scenarios
```

## Critérios de aceitação

```text
zero IDs duplicados
zero concepts órfãos
zero exercises sem descrição
zero exercises sem local
zero exercises sem equipamento
zero exercises com filtro inválido
zero exercícios perigosos sem safety_flag
100 por cento dos cenários E2E passam
```

## Próximo ficheiro

```text
29_IMPORTACAO_APP_EVEFIT_ENTREGA_AO_FABEL.md
```
