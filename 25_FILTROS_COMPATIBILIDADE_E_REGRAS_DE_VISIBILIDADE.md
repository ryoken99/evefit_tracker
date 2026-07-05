# 25 - Filtros, compatibilidade e regras de visibilidade

## Objetivo

Este ficheiro define como a app decide que exercícios aparecem em cada fluxo.

A regra base é:

```text
Primeiro escolhe-se o domínio.
Depois aparecem apenas filtros relevantes para esse domínio.
Nenhum filtro deve mostrar exercícios incompatíveis com local, equipamento, nível ou segurança.
```

## Filtros globais

| Filtro | Nome | Valores principais | Regra |
| --- | --- | --- | --- |
| domain | Tipo de treino | musculação, cardio, artes marciais, mobilidade, elasticidade, recuperação, aquecimento, personalizado | primeiro passo obrigatório |
| location | Local | casa sem equipamento, casa equipada, ginásio, dojo, tatami, exterior, trabalho | filtra equipamentos e exercícios |
| equipment | Equipamento | sem equipamento, halteres, barra, elástico, máquinas, passadeira, saco, tatami | pode ser perfil ou escolha manual |
| level | Nível | iniciante, intermédio, avançado | oculta exercícios perigosos ou técnicos demais |
| intensity | Intensidade | muito leve, leve, moderada, alta, máxima | principal em cardio, recuperação e HIIT |
| impact | Impacto | baixo, médio, alto, contacto, queda | principal em cardio e artes marciais |
| partner | Parceiro | solo, parceiro opcional, parceiro obrigatório | principal em artes marciais, PNF e assistência |
| safety | Segurança | sem restrição, cuidado, contraindicado no contexto | aplica exclusões |

## Fluxos por domínio

| Domínio | Ordem recomendada | Nota |
| --- | --- | --- |
| Musculação | local -> equipamento -> região -> grupo -> subgrupo -> músculo -> conceito -> exercício | Completo pode saltar grupo, subgrupo ou músculo. |
| Cardio | local -> modalidade -> impacto -> intensidade -> duração -> exercício | Modalidade vem antes de equipamento quando faz sentido. |
| Artes marciais | local -> arte -> família técnica -> contacto -> parceiro -> nível -> exercício | Contacto e quedas exigem segurança. |
| Mobilidade | local -> articulação -> função -> objetivo -> nível -> exercício | Ativo, assistido ou flow são filtros. |
| Elasticidade | local -> zona -> método -> objetivo -> intensidade -> exercício | Estático, dinâmico, PNF e abertura devem separar. |
| Recuperação | objetivo -> zona ou sistema -> método -> intensidade -> segurança -> protocolo | Sempre filtrar red flags antes. |
| Aquecimento | treino alvo -> padrão -> zona -> método -> duração -> exercício | Depende do treino que vem a seguir. |
| Personalizado | local -> objetivo livre -> filtros manuais -> exercício | Deve manter compatibilidade e segurança. |

## Hierarquia muscular obrigatória para musculação

| Região | Subdivisões | Regra |
| --- | --- | --- |
| Costas | completo, largura, espessura, lombar, escápulas | costas completas pode mostrar puxadas, remadas, lombar leve e escápulas |
| Peito | completo, superior, médio, inferior, adução horizontal | peito completo inclui empurrar horizontal e variantes |
| Ombros | completo, anterior, lateral, posterior, manguito, escápulas | manguito e escápula podem cruzar prevenção |
| Braços | bíceps, braquial, tríceps, antebraço, punho, mão, dedos | antebraço, punho e mão não devem ficar escondidos dentro de bíceps |
| Core | superior, médio, inferior, lateral, anti-extensão, anti-rotação | core completo mostra padrões e zonas |
| Pernas | glúteos, quadríceps, posterior, adutores, abdutores, flexores da anca, gémeos, sóleo, tibial, tornozelo, pé | perna acima e abaixo do joelho devem estar separadas |

## Regras de visibilidade

| Regra | Campo | Comportamento |
| --- | --- | --- |
| R1 | primary_type | Mostrar se primary_type é igual ao domínio selecionado. |
| R2 | secondary_types | Mostrar como cruzado se secondary_types contém o domínio selecionado. |
| R3 | equipment_required | Ocultar se o equipamento obrigatório não existe no local/perfil. |
| R4 | equipment_optional | Mostrar com etiqueta de opcional e alternativa se existir. |
| R5 | place_ids | Mostrar só nos locais compatíveis. |
| R6 | complete_filter | Quando o utilizador escolhe completo, saltar filtros abaixo mas manter compatibilidade. |
| R7 | level | Exercícios avançados não aparecem para iniciante salvo pesquisa manual com aviso. |
| R8 | safety_flags | Sinais de alerta ocultam ou avisam antes de sugerir. |
| R9 | partner_required | Ocultar em treino solo. |
| R10 | contact_required | Ocultar contacto se o contexto não permite impacto ou parceiro. |

## Lógica de completo

```text
Se o utilizador escolhe completo numa região, a app não deve obrigar a escolher subgrupo.
Exemplo: Costas > completo mostra puxadas, remadas, escápulas e lombar leve.
Se o utilizador escolhe Costas > largura, mostra apenas conceitos de largura.
Se o utilizador escolhe Braços > antebraço, não deve mostrar curls de bíceps como resultado principal.
```

## Lógica de prioridades

```text
1. Segurança e contraindicações
2. Local
3. Equipamento obrigatório
4. Domínio principal
5. Objetivo do treino
6. Nível
7. Equipamento opcional
8. Preferências do utilizador
9. Histórico recente de treino
```

## Regras por domínio

### Musculação

```text
Nunca mostrar exercícios por músculo se o músculo não é principal nem secundário relevante.
Não mostrar máquinas quando o local não tem máquinas.
Não mostrar exercícios de braço quando o filtro é antebraço, salvo se antebraço for foco real.
Séries de aproximação ficam em aquecimento, mas podem cruzar musculação.
```

### Cardio

```text
Modalidade vem antes de exercício.
Intensidade define se é recuperação, cardio contínuo, HIIT ou sprint.
Impacto baixo deve ocultar saltos, sprints e mudanças agressivas de direção.
```

### Artes marciais

```text
Arte selecionada define famílias técnicas.
Parceiro obrigatório só aparece em contexto com parceiro.
Quedas exigem tatami ou superfície segura.
Sparring e contacto exigem avisos e progressão.
```

### Mobilidade e elasticidade

```text
Mobilidade usa articulação e função.
Elasticidade usa zona, método e intensidade.
O mesmo nome pode aparecer em ambos só se a execução for diferente.
```

### Recuperação

```text
Recuperação começa pelo objetivo ou sintoma leve.
Red flags devem aparecer antes de exercícios.
HIIT, PNF intenso e carga alta nunca são recuperação.
```

## Testes obrigatórios

```text
o filtro completo salta níveis abaixo sem perder segurança
o filtro casa sem equipamento não mostra máquinas
o filtro ginásio mostra máquinas e pesos livres
o filtro dojo mostra artes marciais e tatami
o filtro BJJ mostra solo, pega, escapes, guarda e quedas seguras
o filtro cardio baixo impacto oculta burpees, sprints e saltos altos
o filtro recuperação oculta treinos intensos
o filtro iniciante oculta avançado salvo pesquisa manual com aviso
o filtro parceiro obrigatório não aparece em treino solo
todo exercício cruzado mantém identidade única
```

## Próximo ficheiro

```text
26_MODELO_DADOS_E_IDS_CANONICOS.md
```
