# 13 - Cardio: exercícios derivados

## Objetivo

Este ficheiro transforma os conceitos de cardio do ficheiro `12_CARDIO_CONCEITOS_E_MODALIDADES.md` em exercícios canónicos derivados.

A regra continua a ser:

```text
Um exercício pode aparecer em vários filtros, mas só deve existir uma vez como entidade canónica.
```

## Campos usados

```text
id
nome
concept_id
modalidade
intensidade
impacto
equipamento
locais
contextos de uso
filtros prováveis
nota de modelação
```

---

# Cardio contínuo muito leve

```text
concept_id: very_low_intensity_continuous_cardio
```

Movimento suave para circulação, aquecimento leve, cooldown e recuperação ativa.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `caminhada_muito_leve` | Caminhada muito leve | caminhada | muito leve | baixo | peso corporal | exterior, casa, ginásio | aquecimento, cooldown, recuperação ativa | Cardio > Muito leve; Recuperação > Ativa; Aquecimento > Cardio leve | Entidade única. Não duplicar em recuperação. |
| `marcha_no_lugar_lenta` | Marcha no lugar lenta | marcha | muito leve | baixo | peso corporal | casa, ginásio, dojo | aquecimento, recuperação ativa | Cardio > Muito leve; Casa sem equipamento; Aquecimento > Geral | Boa para pouco espaço. |
| `passadeira_caminhada_muito_leve` | Passadeira caminhada muito leve | passadeira | muito leve | baixo | passadeira | ginásio, casa equipada | aquecimento, cooldown, recuperação ativa | Cardio > Passadeira; Cardio > Muito leve; Recuperação > Cooldown | Variação com equipamento específico. |
| `bicicleta_muito_leve` | Bicicleta muito leve | bicicleta | muito leve | sem impacto | bicicleta | ginásio, casa equipada | aquecimento, cooldown, recuperação ativa | Cardio > Bicicleta; Cardio > Sem impacto; Recuperação > Ativa | Boa para reduzir impacto. |
| `eliptica_muito_leve` | Elíptica muito leve | elíptica | muito leve | baixo | elíptica | ginásio | aquecimento, cooldown | Cardio > Elíptica; Cardio > Muito leve | Máquina de baixo impacto. |
| `air_bike_muito_leve` | Air bike muito leve | air bike | muito leve | sem impacto | air bike | ginásio | aquecimento, cooldown | Cardio > Air bike; Recuperação > Cooldown | Usar sem transformar em HIIT. |

---

# Cardio contínuo leve

```text
concept_id: low_intensity_continuous_cardio
```

Cardio leve sustentável. Pode cruzar com aquecimento e recuperação.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `caminhada_leve` | Caminhada leve | caminhada | leve | baixo | peso corporal | exterior, casa, ginásio | aquecimento, cooldown, recuperação ativa, treino leve | Cardio > Caminhada; Cardio > Leve; Recuperação > Ativa; Aquecimento > Cardio leve | Exercício cruzado principal. |
| `passadeira_caminhada` | Passadeira caminhada | passadeira | leve | baixo | passadeira | ginásio, casa equipada | aquecimento, treino leve, cooldown | Cardio > Passadeira; Cardio > Leve; Aquecimento > Cardio leve | Separar de caminhada exterior por equipamento. |
| `passadeira_caminhada_inclinada_leve` | Passadeira caminhada inclinada leve | passadeira | leve | baixo a médio | passadeira | ginásio, casa equipada | aquecimento, treino leve | Cardio > Passadeira; Cardio > Inclinação; Cardio > Leve | Inclinação aumenta exigência de gémeos e glúteos. |
| `bicicleta_ritmo_leve` | Bicicleta ritmo leve | bicicleta | leve | sem impacto | bicicleta | ginásio, casa equipada | aquecimento, cooldown, recuperação ativa | Cardio > Bicicleta; Cardio > Sem impacto; Recuperação > Ativa | Cruzamento com recuperação. |
| `eliptica_ritmo_leve` | Elíptica ritmo leve | elíptica | leve | baixo | elíptica | ginásio | aquecimento, treino leve, cooldown | Cardio > Elíptica; Cardio > Leve | Alternativa de baixo impacto. |
| `remo_ergometro_ritmo_leve` | Remo ergómetro ritmo leve | remo | leve | baixo | remo ergómetro | ginásio | aquecimento, treino leve, cooldown | Cardio > Remo; Cardio > Leve | Também envolve costas e pernas de forma leve. |
| `air_bike_ritmo_leve` | Air bike ritmo leve | air bike | leve | sem impacto | air bike | ginásio | aquecimento, treino leve, cooldown | Cardio > Air bike; Cardio > Leve | Controlar para não virar intervalado. |
| `shadow_boxing_leve` | Shadow boxing leve | artes marciais | leve | baixo | peso corporal | casa, dojo, ginásio, exterior | aquecimento técnico, cardio leve, coordenação | Artes marciais > Striking > Sombra; Cardio > Leve; Aquecimento > Técnico | Primary type deve ser artes marciais. |

---

# Zona 2 e base aeróbia

```text
concept_id: zone_2_aerobic_base_cardio
```

Esforço respirável, sustentável e controlado.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `caminhada_rapida` | Caminhada rápida | caminhada | leve a moderada | baixo | peso corporal | exterior, passadeira | treino principal, perda de gordura, base aeróbia | Cardio > Zona 2; Cardio > Caminhada | Pode ser zona 2 para iniciantes. |
| `passadeira_inclinacao_moderada` | Passadeira inclinação moderada | passadeira | leve a moderada | baixo a médio | passadeira | ginásio, casa equipada | treino principal, zona 2 | Cardio > Zona 2; Cardio > Passadeira; Cardio > Inclinação | Boa para cardio sem correr. |
| `corrida_leve_controlada` | Corrida leve controlada | corrida | leve a moderada | médio | peso corporal | exterior, passadeira | treino principal, base aeróbia | Cardio > Corrida; Cardio > Zona 2 | Diferenciar de corrida moderada. |
| `bicicleta_ritmo_moderado_controlado` | Bicicleta ritmo moderado controlado | bicicleta | leve a moderada | sem impacto | bicicleta | ginásio, casa equipada | treino principal, zona 2 | Cardio > Bicicleta; Cardio > Zona 2 | Boa para poupar articulações. |
| `eliptica_ritmo_moderado` | Elíptica ritmo moderado | elíptica | moderada | baixo | elíptica | ginásio | treino principal, zona 2 | Cardio > Elíptica; Cardio > Zona 2 | Baixo impacto. |
| `remo_ergometro_continuo_leve_moderado` | Remo ergómetro contínuo leve a moderado | remo | leve a moderada | baixo | remo ergómetro | ginásio | treino principal, zona 2 | Cardio > Remo; Cardio > Zona 2 | Exige técnica de remada. |
| `air_bike_continuo_leve_moderado` | Air bike contínuo leve a moderado | air bike | leve a moderada | sem impacto | air bike | ginásio | treino principal, zona 2 | Cardio > Air bike; Cardio > Zona 2 | Manter ritmo sem sprintar. |
| `subida_escadas_moderada` | Subida de escadas moderada | escadas | moderada | médio | escadas ou stepper | ginásio, exterior | treino principal, base aeróbia | Cardio > Escadas; Cardio > Zona 2 | Mais carga em pernas. |

---

# Cardio contínuo moderado

```text
concept_id: moderate_intensity_continuous_cardio
```

Treino principal de resistência com esforço claro mas sustentável.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `corrida_exterior_moderada` | Corrida exterior moderada | corrida | moderada | médio | peso corporal | exterior | treino principal, resistência | Cardio > Corrida; Cardio > Moderado; Exterior | Não classificar como recuperação. |
| `passadeira_corrida_leve_moderada` | Passadeira corrida leve a moderada | passadeira | moderada | médio | passadeira | ginásio, casa equipada | treino principal | Cardio > Passadeira; Cardio > Corrida; Cardio > Moderado | Variação controlada por equipamento. |
| `bicicleta_ritmo_moderado` | Bicicleta ritmo moderado | bicicleta | moderada | sem impacto | bicicleta | ginásio, casa equipada | treino principal | Cardio > Bicicleta; Cardio > Moderado | Baixo impacto. |
| `eliptica_ritmo_moderado_continuo` | Elíptica ritmo moderado contínuo | elíptica | moderada | baixo | elíptica | ginásio | treino principal | Cardio > Elíptica; Cardio > Moderado | Boa alternativa a corrida. |
| `remo_ergometro_ritmo_continuo_moderado` | Remo ergómetro ritmo contínuo moderado | remo | moderada | baixo | remo ergómetro | ginásio | treino principal, resistência | Cardio > Remo; Cardio > Moderado | Técnica influencia muito a fadiga. |
| `stepper_ritmo_continuo` | Stepper ritmo contínuo | escadas | moderada | baixo a médio | stepper | ginásio | treino principal | Cardio > Escadas / Stepper; Cardio > Moderado | Foco forte em pernas. |
| `air_bike_ritmo_continuo_moderado` | Air bike ritmo contínuo moderado | air bike | moderada | sem impacto | air bike | ginásio | treino principal | Cardio > Air bike; Cardio > Moderado | Usar como resistência, não HIIT. |
| `caminhada_exterior_rapida` | Caminhada exterior rápida | caminhada | moderada | baixo | peso corporal | exterior | treino principal, perda de gordura | Cardio > Caminhada; Exterior; Cardio > Moderado | Pode ser treino principal para iniciantes. |

---

# Cardio de limiar

```text
concept_id: threshold_cardio
```

Esforço forte e sustentável, mais avançado.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `corrida_tempo` | Corrida tempo | corrida | moderada alta | médio | peso corporal | exterior, passadeira | treino principal avançado | Cardio > Limiar; Cardio > Corrida | Exige controlo de ritmo. |
| `passadeira_ritmo_forte_continuo` | Passadeira ritmo forte contínuo | passadeira | moderada alta | médio | passadeira | ginásio, casa equipada | treino principal avançado | Cardio > Passadeira; Cardio > Limiar | Não classificar como cooldown. |
| `bicicleta_ritmo_forte` | Bicicleta ritmo forte | bicicleta | moderada alta | sem impacto | bicicleta | ginásio, casa equipada | treino principal avançado | Cardio > Bicicleta; Cardio > Limiar | Menos impacto que corrida. |
| `remo_ergometro_ritmo_forte` | Remo ergómetro ritmo forte | remo | moderada alta | baixo | remo ergómetro | ginásio | treino principal avançado | Cardio > Remo; Cardio > Limiar | Exige técnica e lombar estável. |
| `air_bike_ritmo_forte` | Air bike ritmo forte | air bike | alta | sem impacto | air bike | ginásio | treino principal avançado | Cardio > Air bike; Cardio > Limiar | Muito exigente metabolicamente. |
| `eliptica_ritmo_forte` | Elíptica ritmo forte | elíptica | moderada alta | baixo | elíptica | ginásio | treino principal avançado | Cardio > Elíptica; Cardio > Limiar | Opção forte de baixo impacto. |
| `rounds_longos_saco_ritmo_forte` | Rounds longos no saco a ritmo forte controlado | striking | moderada alta | médio | saco de pancada | dojo, ginásio | condicionamento específico | Artes marciais > Saco; Cardio > Limiar; Cardio > Artes marciais | Primary type pode ser artes marciais. |

---

# Intervalos moderados

```text
concept_id: moderate_interval_cardio
```

Alternância de esforço moderado com recuperação parcial.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `passadeira_intervalada_moderada` | Passadeira intervalada moderada | passadeira | moderada intervalada | médio | passadeira | ginásio, casa equipada | treino principal | Cardio > Intervalado; Cardio > Passadeira | Preparação para HIIT. |
| `bicicleta_intervalos_moderados` | Bicicleta intervalos moderados | bicicleta | moderada intervalada | sem impacto | bicicleta | ginásio, casa equipada | treino principal | Cardio > Intervalado; Cardio > Bicicleta | Boa opção de baixo impacto. |
| `eliptica_intervalos_moderados` | Elíptica intervalos moderados | elíptica | moderada intervalada | baixo | elíptica | ginásio | treino principal | Cardio > Intervalado; Cardio > Elíptica | Alternativa a corrida. |
| `remo_ergometro_intervalos_moderados` | Remo ergómetro intervalos moderados | remo | moderada intervalada | baixo | remo ergómetro | ginásio | treino principal | Cardio > Intervalado; Cardio > Remo | Exige manter técnica. |
| `air_bike_intervalos_moderados` | Air bike intervalos moderados | air bike | moderada intervalada | sem impacto | air bike | ginásio | treino principal | Cardio > Intervalado; Cardio > Air bike | Antes de HIIT pesado. |
| `corda_intervalos_leves_moderados` | Corda intervalos leves a moderados | corda | leve a moderada intervalada | médio | corda | casa, ginásio, dojo, exterior | aquecimento, treino principal | Cardio > Corda; Cardio > Intervalado | Depende de técnica. |
| `caminhada_rapida_alternada_caminhada_leve` | Caminhada rápida alternada com caminhada leve | caminhada | moderada intervalada | baixo | peso corporal | exterior, passadeira | treino principal iniciante | Cardio > Intervalado; Cardio > Caminhada | Intervalos seguros para iniciar. |

---

# HIIT cardiovascular

```text
concept_id: high_intensity_interval_cardio
```

Blocos de esforço alto com pausas ou alternância clara.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `hiit_peso_corporal` | HIIT peso corporal | circuito | alta intervalada | variável | peso corporal | casa, ginásio, exterior | treino principal, finisher | Cardio > HIIT; Casa sem equipamento | Não aparece em recuperação. |
| `hiit_passadeira` | HIIT passadeira | passadeira | alta intervalada | médio a alto | passadeira | ginásio, casa equipada | treino principal, finisher | Cardio > HIIT; Cardio > Passadeira | Diferente de passadeira intervalada moderada. |
| `hiit_bicicleta` | HIIT bicicleta | bicicleta | alta intervalada | sem impacto | bicicleta | ginásio, casa equipada | treino principal, finisher | Cardio > HIIT; Cardio > Bicicleta | Baixo impacto mas alta fadiga. |
| `hiit_corda` | HIIT corda | corda | alta intervalada | médio a alto | corda | casa, ginásio, dojo, exterior | treino principal, finisher | Cardio > HIIT; Cardio > Corda | Exige técnica e tornozelos preparados. |
| `hiit_air_bike` | HIIT air bike | air bike | alta intervalada | sem impacto | air bike | ginásio | treino principal, finisher | Cardio > HIIT; Cardio > Air bike | Muito exigente. |
| `hiit_remo_ergometro` | HIIT remo ergómetro | remo | alta intervalada | baixo | remo ergómetro | ginásio | treino principal, finisher | Cardio > HIIT; Cardio > Remo | Técnica é crítica. |
| `burpees_intervalados` | Burpees intervalados | peso corporal | alta intervalada | alto | peso corporal | casa, ginásio, exterior | HIIT, finisher | Cardio > HIIT; Cardio > Peso corporal | Cruza resistência muscular. |
| `mountain_climbers_intervalados` | Mountain climbers intervalados | peso corporal | alta intervalada | médio | peso corporal | casa, ginásio | HIIT, finisher | Cardio > HIIT; Core dinâmico | Cruza core. |
| `jumping_jacks_intervalados` | Jumping jacks intervalados | peso corporal | alta intervalada | médio | peso corporal | casa, ginásio, exterior | HIIT, aquecimento intenso | Cardio > HIIT; Cardio > Peso corporal | Pode ter versão leve fora de HIIT. |
| `skaters_intervalados` | Skaters intervalados | peso corporal | alta intervalada | médio a alto | peso corporal | casa, ginásio, exterior | HIIT, agilidade | Cardio > HIIT; Cardio > Mudanças de direção | Exige controlo de joelho. |

---

# Sprints

```text
concept_id: sprint_cardio
```

Esforço máximo ou quase máximo. Deve ter progressão cuidadosa.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `sprints_exterior` | Sprints exterior | corrida | máxima | alto | peso corporal | exterior | treino principal avançado, finisher | Cardio > Sprints; Exterior | Alto risco se mal aquecido. |
| `passadeira_sprints` | Passadeira sprints | passadeira | máxima | alto | passadeira | ginásio, casa equipada | treino principal avançado, finisher | Cardio > Sprints; Cardio > Passadeira | Cuidado com segurança na passadeira. |
| `corrida_em_subida` | Corrida em subida | corrida | alta | médio a alto | peso corporal | exterior | treino principal, potência | Cardio > Sprints; Cardio > Subidas | Menos velocidade, mais força de pernas. |
| `sprints_em_subida` | Sprints em subida | corrida | máxima | alto | peso corporal | exterior | treino avançado | Cardio > Sprints; Exterior > Subidas | Exigente para posterior de coxa e gémeos. |
| `air_bike_sprints` | Air bike sprints | air bike | máxima | sem impacto | air bike | ginásio | finisher avançado | Cardio > Sprints; Cardio > Air bike | Sem impacto mas brutal metabolicamente. |
| `bicicleta_sprints` | Bicicleta sprints | bicicleta | máxima | sem impacto | bicicleta | ginásio, casa equipada | treino avançado, finisher | Cardio > Sprints; Cardio > Bicicleta | Alternativa de baixo impacto. |
| `shuttle_sprints` | Shuttle sprints | mudança de direção | máxima | alto | peso corporal | exterior, ginásio, dojo | agilidade, condicionamento avançado | Cardio > Sprints; Cardio > Mudanças de direção | Alto stress em joelhos e tornozelos. |

---

# Mudanças de direção e agilidade

```text
concept_id: change_of_direction_cardio
```

Cardio com aceleração, travagem, lateralidade e coordenação.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `shuttle_runs` | Shuttle runs / corrida vaivém | mudança de direção | moderada a alta | alto | peso corporal, cones opcionais | exterior, ginásio, dojo | treino principal, artes marciais | Cardio > Mudanças de direção; Artes marciais > Footwork | Entidade única. |
| `corrida_vaivem_leve` | Corrida vaivém leve | mudança de direção | leve a moderada | médio | peso corporal, cones opcionais | exterior, ginásio, dojo | aquecimento, coordenação | Cardio > Mudanças de direção; Aquecimento > Dinâmico | Versão iniciante. |
| `skaters` | Skaters | lateralidade | moderada a alta | médio | peso corporal | casa, ginásio, exterior | cardio, agilidade | Cardio > Mudanças de direção; Cardio > Peso corporal | Também trabalha glúteo médio. |
| `deslocamentos_laterais_por_tempo` | Deslocamentos laterais por tempo | lateralidade | leve a alta | médio | peso corporal | dojo, ginásio, exterior | aquecimento, artes marciais, cardio | Cardio > Mudanças de direção; Artes marciais > Footwork | Cruza artes marciais. |
| `footwork_em_linhas` | Footwork em linhas | footwork | leve a moderada | baixo a médio | peso corporal | casa, dojo, ginásio | coordenação, aquecimento, artes marciais | Cardio > Coordenação; Artes marciais > Footwork | Primary type pode ser artes marciais. |
| `sprints_com_mudanca_direcao` | Sprints com mudança de direção | mudança de direção | alta | alto | peso corporal, cones opcionais | exterior, ginásio, dojo | condicionamento avançado | Cardio > Sprints; Cardio > Mudanças de direção | Exige progressão. |

---

# Cardio com corda

```text
concept_id: jump_rope_cardio
```

Ritmo, coordenação, gémeos, tornozelo e condição cardiovascular.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `corda_saltar_ritmo_leve` | Corda de saltar ritmo leve | corda | leve | médio | corda | casa, ginásio, dojo, exterior | aquecimento, treino leve | Cardio > Corda; Aquecimento > Cardio leve | Técnica base. |
| `corda_saltar_ritmo_moderado` | Corda de saltar ritmo moderado | corda | moderada | médio | corda | casa, ginásio, dojo, exterior | treino principal | Cardio > Corda; Cardio > Moderado | Trabalho contínuo. |
| `corda_saltar_intervalos` | Corda de saltar intervalos | corda | moderada a alta intervalada | médio a alto | corda | casa, ginásio, dojo, exterior | treino principal, finisher | Cardio > Corda; Cardio > Intervalado | Variação intervalada. |
| `corda_pes_alternados` | Corda de saltar pés alternados | corda | leve a moderada | médio | corda | casa, ginásio, dojo | aquecimento, coordenação | Cardio > Corda; Cardio > Coordenação | Boa para artes marciais. |
| `corda_joelhos_altos` | Corda de saltar joelhos altos | corda | alta | alto | corda | ginásio, dojo, exterior | treino principal, finisher | Cardio > Corda; Cardio > Alto | Mais exigente para flexores da anca. |
| `corda_double_unders` | Corda de saltar double unders | corda | alta | alto | corda | ginásio, dojo, exterior | técnica avançada, HIIT | Cardio > Corda; Cardio > Avançado | Não é iniciante. |

---

# Máquinas de baixo impacto

```text
concept_id: low_impact_machine_cardio
```

Cardio com menor stress articular, ajustável por intensidade.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `bicicleta_intervalos` | Bicicleta intervalos | bicicleta | moderada a alta | sem impacto | bicicleta | ginásio, casa equipada | treino principal | Cardio > Bicicleta; Cardio > Intervalado | Pode ser moderado ou HIIT dependendo prescrição. |
| `bicicleta_resistencia` | Bicicleta resistência | bicicleta | moderada | sem impacto | bicicleta | ginásio, casa equipada | treino principal | Cardio > Bicicleta; Cardio > Resistência | Foco em duração. |
| `bicicleta_aquecimento` | Bicicleta aquecimento | bicicleta | leve | sem impacto | bicicleta | ginásio, casa equipada | aquecimento | Aquecimento > Cardio leve; Cardio > Bicicleta | Não duplicar com bicicleta leve se a app usar contexto. |
| `bicicleta_cooldown` | Bicicleta cooldown | bicicleta | muito leve a leve | sem impacto | bicicleta | ginásio, casa equipada | cooldown, recuperação | Recuperação > Cooldown; Cardio > Bicicleta | Variação por contexto. |
| `eliptica_intervalos` | Elíptica intervalos | elíptica | moderada a alta | baixo | elíptica | ginásio | treino principal | Cardio > Elíptica; Cardio > Intervalado | Baixo impacto. |
| `eliptica_resistencia` | Elíptica resistência | elíptica | moderada | baixo | elíptica | ginásio | treino principal | Cardio > Elíptica; Cardio > Resistência | Ritmo contínuo. |
| `eliptica_aquecimento` | Elíptica aquecimento | elíptica | leve | baixo | elíptica | ginásio | aquecimento | Aquecimento > Cardio leve; Cardio > Elíptica | Contexto de aquecimento. |
| `eliptica_cooldown` | Elíptica cooldown | elíptica | muito leve a leve | baixo | elíptica | ginásio | cooldown | Recuperação > Cooldown; Cardio > Elíptica | Contexto de recuperação. |
| `remo_ergometro_intervalos` | Remo ergómetro intervalos | remo | moderada a alta | baixo | remo ergómetro | ginásio | treino principal | Cardio > Remo; Cardio > Intervalado | Técnica importante. |
| `air_bike_intervalos` | Air bike intervalos | air bike | moderada a alta | sem impacto | air bike | ginásio | treino principal | Cardio > Air bike; Cardio > Intervalado | Pode escalar para HIIT. |

---

# Passadeira

```text
concept_id: treadmill_cardio
```

Plataforma para caminhada, corrida, inclinação, intervalos e sprints.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `passadeira_aquecimento` | Passadeira aquecimento | passadeira | leve | baixo | passadeira | ginásio, casa equipada | aquecimento | Aquecimento > Cardio leve; Cardio > Passadeira | Contexto específico. |
| `passadeira_caminhada_rapida` | Passadeira caminhada rápida | passadeira | moderada | baixo | passadeira | ginásio, casa equipada | treino principal, aquecimento forte | Cardio > Passadeira; Cardio > Caminhada | Variação por ritmo. |
| `passadeira_inclinacao` | Passadeira inclinação | passadeira | leve a alta | baixo a médio | passadeira | ginásio, casa equipada | treino principal | Cardio > Passadeira; Cardio > Inclinação | Separar de corrida. |
| `passadeira_corrida_leve` | Passadeira corrida leve | passadeira | leve a moderada | médio | passadeira | ginásio, casa equipada | treino principal | Cardio > Passadeira; Cardio > Corrida | Pode ser zona 2. |
| `passadeira_corrida_intervalada` | Passadeira corrida intervalada | passadeira | moderada a alta intervalada | médio a alto | passadeira | ginásio, casa equipada | treino principal | Cardio > Passadeira; Cardio > Intervalado | Não é automaticamente sprint. |
| `passadeira_cooldown` | Passadeira cooldown | passadeira | muito leve a leve | baixo | passadeira | ginásio, casa equipada | cooldown, recuperação | Recuperação > Cooldown; Cardio > Passadeira | Não aparece em HIIT. |

---

# Cardio exterior

```text
concept_id: outdoor_locomotion_cardio
```

Locomoção em ambiente real com variação de terreno.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `caminhada_exterior_leve` | Caminhada exterior leve | caminhada | leve | baixo | peso corporal | exterior | aquecimento, recuperação ativa, treino leve | Cardio > Exterior; Cardio > Caminhada; Recuperação > Ativa | Cruzamento com recuperação. |
| `caminhada_exterior_moderada` | Caminhada exterior moderada | caminhada | moderada | baixo | peso corporal | exterior | treino principal | Cardio > Exterior; Cardio > Caminhada | Treino principal leve/moderado. |
| `caminhada_exterior_em_subida` | Caminhada exterior em subida | caminhada | moderada | baixo a médio | peso corporal | exterior | treino principal | Cardio > Exterior; Cardio > Subidas | Mais pernas e glúteos. |
| `corrida_exterior_leve` | Corrida exterior leve | corrida | leve a moderada | médio | peso corporal | exterior | treino principal, zona 2 | Cardio > Exterior; Cardio > Corrida; Cardio > Zona 2 | Ritmo controlado. |
| `corrida_exterior_intervalada` | Corrida exterior intervalada | corrida | moderada a alta intervalada | médio a alto | peso corporal | exterior | treino principal | Cardio > Exterior; Cardio > Intervalado | Separar de sprint. |
| `subida_escadas_exterior` | Subida de escadas no exterior | escadas | moderada a alta | médio | escadas | exterior | treino principal, condicionamento | Cardio > Exterior; Cardio > Escadas | Foco em pernas. |

---

# Circuitos cardiovasculares com peso corporal

```text
concept_id: bodyweight_cardio_circuit
```

Movimentos corporais combinados para aumentar frequência cardíaca.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `circuito_cardio_peso_corporal` | Circuito cardio peso corporal | circuito | moderada a alta | variável | peso corporal | casa, ginásio, exterior | treino principal, finisher | Cardio > Circuitos; Casa sem equipamento | Conjunto de exercícios, não um único padrão. |
| `circuito_cardio_leve` | Circuito cardio leve | circuito | leve | baixo a médio | peso corporal | casa, ginásio, dojo | aquecimento, treino leve | Cardio > Circuitos; Aquecimento > Dinâmico | Não é HIIT. |
| `hiit_simples` | HIIT simples | circuito | alta intervalada | variável | peso corporal | casa, ginásio, exterior | HIIT, finisher | Cardio > HIIT; Cardio > Circuitos | Modelo genérico de HIIT. |
| `jumping_jacks` | Jumping jacks | peso corporal | leve a alta | médio | peso corporal | casa, ginásio, exterior | aquecimento, cardio, HIIT se intervalado | Cardio > Peso corporal; Aquecimento > Dinâmico | A intensidade define o contexto. |
| `burpees` | Burpees | peso corporal | alta | alto | peso corporal | casa, ginásio, exterior | HIIT, finisher, condicionamento | Cardio > Peso corporal; Cardio > HIIT | Cruza força-resistência. |
| `mountain_climbers` | Mountain climbers | peso corporal | moderada a alta | médio | peso corporal | casa, ginásio | cardio, core dinâmico, HIIT | Cardio > Peso corporal; Core > Dinâmico | Cruza core. |
| `high_knees` | High knees | peso corporal | moderada a alta | médio a alto | peso corporal | casa, ginásio, exterior | aquecimento, cardio, HIIT | Cardio > Peso corporal; Cardio > Alto | Envolve flexores da anca. |

---

# Cardio técnico de striking

```text
concept_id: striking_technical_cardio
```

Exercícios de striking prescritos por tempo, rounds ou ritmo.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `shadow_boxing_por_rounds` | Shadow boxing por rounds | striking | leve a alta | baixo | peso corporal | casa, dojo, ginásio, exterior | aquecimento técnico, treino principal | Artes marciais > Striking > Sombra; Cardio > Artes marciais | Primary type artes marciais. |
| `shadow_boxing_com_footwork` | Shadow boxing com footwork | striking | leve a moderada | baixo a médio | peso corporal | casa, dojo, ginásio | coordenação, aquecimento, cardio técnico | Artes marciais > Footwork; Cardio > Artes marciais | Cruza footwork. |
| `rounds_saco_ritmo_leve` | Rounds no saco ritmo leve | saco | leve | médio | saco de pancada, luvas | dojo, ginásio | aquecimento técnico | Artes marciais > Saco; Cardio > Leve | Foco em técnica e aquecimento. |
| `rounds_saco_ritmo_moderado` | Rounds no saco ritmo moderado | saco | moderada | médio | saco de pancada, luvas | dojo, ginásio | treino principal, condicionamento | Artes marciais > Saco; Cardio > Artes marciais | Técnico e cardiovascular. |
| `rounds_saco_ritmo_forte` | Rounds no saco ritmo forte | saco | alta | médio a alto | saco de pancada, luvas | dojo, ginásio | condicionamento, finisher | Artes marciais > Saco; Cardio > Alto | Não é para recuperação. |
| `combinacoes_por_tempo` | Combinações por tempo | striking | moderada a alta | baixo a médio | peso corporal ou saco | casa, dojo, ginásio | técnica, cardio específico | Artes marciais > Combinações; Cardio > Artes marciais | Detalhar por arte no ficheiro de artes marciais. |
| `pontapes_por_tempo` | Pontapés por tempo | striking | moderada a alta | médio | peso corporal, saco opcional | dojo, ginásio, casa | técnica, cardio específico | Artes marciais > Pontapés; Cardio > Artes marciais | Cruza Karate, Kickboxing, Muay Thai e Taekwondo. |

---

# Cardio técnico de grappling

```text
concept_id: grappling_technical_cardio
```

Movimentos de solo e grappling feitos por tempo ou intervalos.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `shrimp_por_tempo` | Shrimp por tempo | grappling | leve a moderada | baixo | peso corporal, tatami opcional | dojo, tatami, casa, ginásio | aquecimento técnico, cardio técnico | Artes marciais > Jiu-Jitsu > Shrimp; Cardio > Artes marciais | Primary type artes marciais. |
| `technical_stand_up_por_tempo` | Technical stand-up por tempo | grappling | leve a moderada | baixo | peso corporal | dojo, tatami, casa, ginásio | técnica, defesa pessoal, cardio técnico | Artes marciais > Defesa pessoal > Levantar do chão; Cardio > Artes marciais | Cruzamento forte com defesa pessoal. |
| `sprawls_intervalados` | Sprawls intervalados | grappling | moderada a alta | médio | peso corporal | dojo, tatami, ginásio, casa | defesa de queda, condicionamento | Artes marciais > Jiu-Jitsu > Sprawl; Cardio > Intervalado | Cruzamento com MMA funcional. |
| `rolamentos_solo_por_tempo` | Rolamentos de solo por tempo | grappling | leve a moderada | baixo | tatami opcional | dojo, tatami, ginásio | aquecimento técnico | Artes marciais > Jiu-Jitsu > Rolamentos; Cardio > Artes marciais | Exige espaço e segurança. |
| `drills_guarda_por_tempo` | Drills de guarda por tempo | grappling | leve a moderada | baixo | tatami opcional | dojo, tatami, casa | técnica, cardio específico | Artes marciais > Jiu-Jitsu > Guarda; Cardio > Artes marciais | Pode ser solo ou com parceiro. |
| `drills_passagem_por_tempo` | Drills de passagem por tempo | grappling | moderada | baixo a médio | tatami opcional | dojo, tatami | técnica, condicionamento | Artes marciais > Jiu-Jitsu > Passagem; Cardio > Artes marciais | Melhor com parceiro ou sequência definida. |
| `ponte_grappling_repeticoes_rapidas` | Ponte de grappling por repetições rápidas | grappling | moderada | baixo | peso corporal, tatami opcional | dojo, tatami, casa | aquecimento técnico, condicionamento | Artes marciais > Jiu-Jitsu > Ponte; Cardio > Artes marciais | Cruza core e glúteos. |

---

# Cooldown cardiovascular

```text
concept_id: cardiovascular_cooldown
```

Redução gradual de intensidade após treino.

| ID | Exercício | Modalidade | Intensidade | Impacto | Equipamento | Locais | Contextos | Filtros prováveis | Nota |
|---|---|---|---|---|---|---|---|---|---|
| `caminhada_leve_pos_treino` | Caminhada leve pós-treino | caminhada | muito leve a leve | baixo | peso corporal | exterior, casa, ginásio | cooldown, recuperação | Recuperação > Cooldown; Cardio > Muito leve | Pode apontar para caminhada leve como entidade base. |
| `passadeira_cooldown_leve` | Passadeira cooldown leve | passadeira | muito leve a leve | baixo | passadeira | ginásio, casa equipada | cooldown | Cardio > Passadeira; Recuperação > Cooldown | Contexto de fim de treino. |
| `bicicleta_cooldown_leve` | Bicicleta cooldown leve | bicicleta | muito leve a leve | sem impacto | bicicleta | ginásio, casa equipada | cooldown | Cardio > Bicicleta; Recuperação > Cooldown | Bom sem impacto. |
| `eliptica_cooldown_leve` | Elíptica cooldown leve | elíptica | muito leve a leve | baixo | elíptica | ginásio | cooldown | Cardio > Elíptica; Recuperação > Cooldown | Fim de treino suave. |
| `remo_ergometro_cooldown_leve` | Remo ergómetro cooldown leve | remo | muito leve a leve | baixo | remo ergómetro | ginásio | cooldown | Cardio > Remo; Recuperação > Cooldown | Manter técnica leve. |
| `air_bike_cooldown_leve` | Air bike cooldown leve | air bike | muito leve a leve | sem impacto | air bike | ginásio | cooldown | Cardio > Air bike; Recuperação > Cooldown | Não virar sprint. |

---

# Contagem

Este ficheiro contém `122` exercícios derivados de cardio.

# Regras finais de duplicação

## Cardio leve

```text
Caminhada leve, bicicleta leve, elíptica leve e passadeira cooldown podem aparecer em Cardio, Aquecimento e Recuperação.
Mas devem manter uma entidade canónica única.
```

## Cardio marcial

```text
Shadow boxing, rounds no saco, sprawls e technical stand-up por tempo devem existir principalmente em Artes marciais.
Aparecem em Cardio quando a prescrição é por tempo, rounds, intensidade ou condicionamento.
```

## HIIT

```text
HIIT precisa de intensidade alta e estrutura intervalada.
Circuito leve não é HIIT.
Cooldown nunca é HIIT.
```

## Sprints

```text
Sprints devem ter aviso de impacto, aquecimento obrigatório e progressão cuidadosa.
Não devem ser sugeridos como recuperação, cooldown ou treino iniciante sem regressão.
```

# Próximo ficheiro

O próximo ficheiro deve ser:

```text
14_ARTES_MARCIAIS_ESTRUTURA_CONCEITOS.md
```

Esse ficheiro deve definir a arquitetura conceptual das artes marciais:

```text
Karate
Jiu-Jitsu / BJJ
Boxe
Kickboxing
Muay Thai
Judo
Taekwondo
MMA / Defesa pessoal funcional
```