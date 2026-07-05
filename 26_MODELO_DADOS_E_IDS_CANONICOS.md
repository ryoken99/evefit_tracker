# 26 - Modelo de dados e IDs canónicos

## Objetivo

Este ficheiro define o modelo de dados mínimo para importar o catálogo reconstruído para a EveFit sem duplicados.

A regra base é:

```text
Conceito gera exercícios.
Exercício é entidade canónica.
Variação muda equipamento, posição, pega, intensidade ou contexto.
Alias muda nome, não cria exercício novo.
```

## Entidades principais

| Entidade | Função | Campos mínimos |
| --- | --- | --- |
| domain_types | Domínios principais | id, name, description, default_flow |
| concepts | Conceitos treináveis | concept_id, domain, name, explanation, parent_id, tags |
| exercises | Exercícios canónicos | exercise_id, concept_id, name, primary_type, level, safety_level |
| exercise_variants | Variações | variant_id, exercise_id, variation_name, equipment_id, notes |
| exercise_aliases | Sinónimos e nomes alternativos | alias_id, exercise_id, alias, language, source |
| muscles | Músculos e zonas | muscle_id, region, group, subgroup, name |
| articulations | Articulações e funções | joint_id, region, name, functions |
| equipment | Equipamento | equipment_id, name, category, locations, safety_notes |
| places | Locais | place_id, name, compatible_equipment, notes |
| filters | Filtros | filter_id, domain, name, values, order_index |
| exercise_targets | Alvos do exercício | exercise_id, target_id, target_type, role |
| exercise_equipment | Equipamento por exercício | exercise_id, equipment_id, requirement |
| exercise_places | Locais por exercício | exercise_id, place_id, compatibility |
| instructions | Descrições e execução | exercise_id, locale, objective, setup, steps, errors, safety |
| safety_rules | Regras de segurança | rule_id, applies_to, severity, message, action |
| test_cases | Testes do catálogo | test_id, domain, scenario, expected_result |

## Regras de IDs

| Tipo de ID | Regra | Exemplo |
| --- | --- | --- |
| concept_id | snake_case, começa pelo domínio ou função | mobility_hip_internal_rotation_control |
| exercise_id | snake_case, nome canónico sem equipamento salvo quando o equipamento define o exercício | glute_bridge_activation |
| variant_id | exercise_id + variação principal | glute_bridge_activation_mini_band |
| equipment_id | prefixo eq_ | eq_dumbbells |
| place_id | prefixo place_ | place_home_equipped |
| filter_id | prefixo filter_ | filter_muscle_region |
| safety_rule_id | prefixo safety_ | safety_no_neck_aggressive_rotation |

## Ordem de importação

| Ordem | Tabela | Motivo |
| --- | --- | --- |
| 1 | places | Locais precisam existir antes de compatibilidades. |
| 2 | equipment | Equipamento precisa existir antes dos exercícios. |
| 3 | domains e filters | Define fluxos e valores possíveis. |
| 4 | muscles e articulations | Alvos anatómicos. |
| 5 | concepts | Conceitos geram exercícios. |
| 6 | exercises | Entidades canónicas. |
| 7 | targets, equipment, places | Relações do exercício. |
| 8 | aliases e variants | Sinónimos e variações. |
| 9 | instructions | Descrição pedagógica. |
| 10 | safety_rules e tests | Validação final. |

## Esquema canónico de exercício

```json
{
  "exercise_id": "glute_bridge_activation",
  "concept_id": "activation_glute_max_bridge",
  "name_pt": "Glute bridge de ativação",
  "primary_type": "ativacao",
  "secondary_types": ["prevenção", "musculação"],
  "level": "iniciante",
  "movement_family": "ponte de anca",
  "targets": [
    {"target_type": "muscle", "target_id": "gluteus_maximus", "role": "principal"},
    {"target_type": "muscle", "target_id": "core", "role": "secundario"}
  ],
  "equipment": [
    {"equipment_id": "eq_none", "requirement": "required"},
    {"equipment_id": "eq_floor_mat", "requirement": "optional"}
  ],
  "places": ["place_home_no_equipment", "place_home_equipped", "place_gym"],
  "safety_flags": ["no_lumbar_overextension"],
  "filters": ["Ativação > Glúteos", "Prevenção > Anca"]
}
```

## Esquema canónico de descrição

```json
{
  "exercise_id": "glute_bridge_activation",
  "locale": "pt-PT",
  "objective": "Ativar glúteos e preparar extensão da anca antes do treino principal.",
  "setup": "Deita-te de costas com joelhos fletidos e pés no chão.",
  "steps": [
    "Mantém costelas controladas.",
    "Sobe a anca contraindo glúteos.",
    "Pausa um segundo no topo.",
    "Desce com controlo."
  ],
  "breathing": "Expira suavemente ao subir e inspira ao descer.",
  "common_errors": ["Arquear a lombar", "Fazer até à fadiga", "Deixar joelhos colapsarem"],
  "easier": "Fazer menos repetições e sem pausa no topo.",
  "harder": "Adicionar mini band ou pausa maior, mantendo baixa fadiga.",
  "safety": "Parar se houver dor lombar."
}
```

## Regras de duplicação

```text
Nomes diferentes não criam exercícios novos.
Equipamento diferente só cria variante quando a mecânica continua igual.
Equipamento diferente cria exercício novo quando muda o padrão principal.
Contexto diferente não cria exercício novo se execução for igual.
Domínio cruzado usa secondary_types.
```

## Exemplos

```text
Wall slides em aquecimento e mobilidade = mesmo exercício, contextos diferentes.
Glute bridge de ativação e hip thrust pesado = exercícios diferentes.
Caminhada leve de aquecimento e caminhada leve de recuperação = mesma entidade se execução for igual, prescrição diferente.
Sprawl lento de mobilidade e sprawls intervalados = exercícios diferentes por intensidade e objetivo.
```

## Testes obrigatórios

```text
nenhum exercise_id duplicado
nenhum concept_id órfão
nenhum exercício sem primary_type
nenhum exercício sem local compatível
nenhum exercício sem equipamento required ou eq_none
nenhum alias cria duplicado
nenhum variant_id existe sem exercise_id
todo target_id existe
toda safety_flag tem regra
todo exercício tem descrição pt-PT antes de aparecer ao utilizador
```

## Próximo ficheiro

```text
27_DESCRICOES_EXECUCOES_TEMPLATES_E_PROMPTS.md
```
