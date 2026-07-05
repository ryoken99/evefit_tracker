# 24 - Locais e equipamentos: mapa global

## Objetivo

Este ficheiro consolida os locais, equipamentos, objetos auxiliares e regras de compatibilidade para todos os domínios do catálogo EveFit.

A regra base é:

```text
O exercício é canónico.
O local e o equipamento são filtros de visibilidade.
O perfil do utilizador decide o que aparece primeiro.
```

## Locais canónicos

| Place ID | Local | Equipamento típico | Domínios fortes | Regra de visibilidade |
| --- | --- | --- | --- | --- |
| place_home_no_equipment | Casa sem equipamento | sem equipamento, tapete opcional, parede, cadeira | mobilidade, elasticidade, recuperação, aquecimento, peso corporal | Não mostrar exercícios que exigem máquina, barra fixa, saco ou parceiro obrigatório. |
| place_home_equipped | Casa equipada | halteres, barra, discos, elásticos, banco, barra fixa, corda, tapete | musculação, cardio leve, mobilidade, prevenção | Depende do perfil de equipamento do utilizador. |
| place_gym | Ginásio | máquinas, cabos, halteres, barras, bancos, cardio machines | todos os domínios exceto tatami específico | Mostrar maior variedade e variantes de máquina. |
| place_dojo | Dojo | tatami, espaço livre, saco, pads, kimono, parceiro | artes marciais, aquecimento, mobilidade, recuperação | Contacto, quedas e sparring só com contexto seguro. |
| place_tatami | Tatami | tatami, parceiro opcional | BJJ, Judo, quedas, solo, recuperação pós-artes marciais | Obrigatório para ukemi, quedas e drills com risco de impacto. |
| place_outdoor | Exterior | rua, parque, escadas, pista, espaço aberto | cardio, corrida, sprints, caminhada, footwork | Verificar terreno, segurança e clima. |
| place_work_travel | Trabalho ou viagem | sem equipamento, parede, cadeira, toalha | recuperação, mobilidade leve, alongamento, postura | Foco em sessões curtas e discretas. |
| place_clinic | Clínica ou fisioterapia | equipamento clínico, supervisão | reabilitação, recuperação, avaliação | Não misturar com prescrição médica sem profissional. |

## Equipamentos canónicos

| Equipment ID | Nome | Categoria | Domínios | Locais compatíveis | Notas |
| --- | --- | --- | --- | --- | --- |
| eq_none | Sem equipamento | base | todos | casa, ginásio, dojo, exterior | Sempre compatível quando o exercício não requer objeto. |
| eq_floor_mat | Tapete | apoio | mobilidade, core, BJJ, recuperação | casa, ginásio, dojo | Recomendado para solo, joelhos, punhos e alongamentos. |
| eq_wall | Parede | apoio | mobilidade, recuperação, prehab | casa, ginásio, trabalho | Útil para wall slides, knee to wall, apoio de equilíbrio. |
| eq_chair | Cadeira | apoio | mobilidade, recuperação, musculação leve | casa, trabalho | Útil para regressões e alongamentos. |
| eq_bench | Banco | apoio | musculação, mobilidade, prehab | ginásio, casa equipada | Banco plano ou inclinado deve ser variante. |
| eq_towel | Toalha | auxiliar | mobilidade, elasticidade, pega, BJJ | casa, ginásio, dojo | Pode substituir strap, kimono ou apoio leve. |
| eq_broomstick | Cabo de vassoura | auxiliar | mobilidade, aquecimento, técnica | casa, ginásio | Bom para ombros, hinge drill e alinhamento. |
| eq_mini_band | Mini band | elástico | ativação, prehab, glúteos, ombros | casa equipada, ginásio | Resistência leve a moderada. |
| eq_long_band | Elástico longo | elástico | musculação, prehab, mobilidade, aquecimento | casa equipada, ginásio | Pode substituir cabos em várias variantes. |
| eq_dumbbells | Halteres | peso livre | musculação, prehab, aquecimento | ginásio, casa equipada | Compatível com variantes unilateral, bilateral, sentado e em pé. |
| eq_barbell | Barra | peso livre | musculação | ginásio, casa equipada | Exige discos e espaço seguro. |
| eq_plates | Discos | peso livre | musculação, cargas | ginásio, casa equipada | Podem ser carga adicional ou equipamento independente. |
| eq_kettlebell | Kettlebell | peso livre | musculação, carry, aquecimento | ginásio, casa equipada | Útil para carries, swings, goblet squat. |
| eq_cable_machine | Cabo | máquina | musculação, prehab | ginásio | Mostrar só em ginásio ou casa equipada com polia. |
| eq_pullup_bar | Barra fixa | estrutura | costas, pega, escápulas, core | ginásio, exterior, casa equipada | Exige segurança da fixação. |
| eq_squat_rack | Rack | estrutura | musculação pesada | ginásio, casa equipada | Necessário para agachamento pesado e variantes com barra. |
| eq_smith_machine | Smith machine | máquina | musculação | ginásio | Variante separada da barra livre. |
| eq_leg_press | Leg press | máquina | musculação pernas | ginásio | Filtro pernas, quadríceps, glúteos. |
| eq_leg_extension | Leg extension | máquina | quadríceps | ginásio | Isolamento de quadríceps. |
| eq_leg_curl | Leg curl | máquina | posterior de coxa | ginásio | Sentado ou deitado como variantes. |
| eq_chest_press_machine | Máquina de chest press | máquina | peito, tríceps, ombros | ginásio | Variante de empurrar horizontal. |
| eq_lat_pulldown | Lat pulldown | máquina | costas largura, bíceps | ginásio | Pega deve ser variante. |
| eq_row_machine | Máquina de remada | máquina | costas espessura | ginásio | Sentada, peito apoiado ou convergente. |
| eq_treadmill | Passadeira | cardio machine | cardio, aquecimento, recuperação | ginásio, casa equipada | Modalidades caminhada, corrida, inclinação, sprints. |
| eq_bike | Bicicleta | cardio machine | cardio, recuperação, aquecimento | ginásio, casa equipada | Vertical, reclinada ou spin como variantes. |
| eq_elliptical | Elíptica | cardio machine | baixo impacto | ginásio | Boa para recuperação e cardio contínuo. |
| eq_rower | Remo ergómetro | cardio machine | cardio, aquecimento, recuperação | ginásio | Exige técnica mínima para não sobrecarregar lombar. |
| eq_air_bike | Air bike | cardio machine | cardio, HIIT, cooldown | ginásio | Pode ser leve ou muito intenso. |
| eq_jump_rope | Corda | cardio | cardio, aquecimento, artes marciais | casa, ginásio, dojo, exterior | Exige pés, tornozelos e espaço. |
| eq_boxing_bag | Saco | artes marciais | striking, cardio técnico | dojo, ginásio, casa equipada | Exige luvas ou progressão de impacto. |
| eq_pads | Pads ou paos | artes marciais | striking, pontapés, técnica | dojo, ginásio | Normalmente exige parceiro. |
| eq_gloves | Luvas | proteção | boxe, kickboxing, saco, sparring | dojo, ginásio | Necessárias para impacto mais intenso. |
| eq_wraps | Ligaduras | proteção | striking, saco | dojo, ginásio | Proteção de punho e mão. |
| eq_gi | Kimono | artes marciais | BJJ, Judo, pegada | dojo, tatami | Exercícios no-gi devem ser variantes. |
| eq_partner | Parceiro | humano | artes marciais, assistência, PNF | dojo, ginásio, casa com segurança | Marcar como obrigatório ou opcional. |
| eq_foam_roller | Foam roller | recuperação | recuperação, mobilidade leve | casa equipada, ginásio | Evitar articulações e coluna sensível. |
| eq_massage_ball | Bola de massagem | recuperação | pés, glúteos, peitoral, antebraço | casa equipada, ginásio | Pressão moderada. |
| eq_massage_gun | Pistola de massagem | recuperação | músculos grandes | casa equipada, ginásio | Evitar pescoço anterior, articulações e dor aguda. |
| eq_heat_pack | Saco térmico | recuperação | calor, rigidez | casa | Evitar queimaduras. |
| eq_ice_pack | Gelo ou bolsa fria | recuperação | frio local | casa | Não aplicar diretamente na pele. |
| eq_yoga_block | Bloco de yoga | apoio | mobilidade, elasticidade, recuperação | casa equipada, ginásio | Regressões e apoios. |
| eq_timer | Temporizador | medição | cardio, artes marciais, recuperação | todos | Rounds, holds, descansos e intervalos. |
| eq_hr_monitor | Monitor de frequência cardíaca | medição | cardio, recuperação | ginásio, exterior, casa | Opcional para zonas de intensidade. |

## Matriz local versus equipamento

| Local | Mostrar por defeito | Ocultar por defeito | Priorizar |
| --- | --- | --- | --- |
| Casa sem equipamento | Sem equipamento, parede, cadeira, tapete, toalha | máquinas, rack, cabos, saco pesado sem suporte seguro | mobilidade, recuperação, core, peso corporal, aquecimento |
| Casa equipada | halteres, barra, discos, elásticos, banco, corda, barra fixa se existir | máquinas comerciais não existentes no perfil | musculação, cardio leve, prehab, mobilidade |
| Ginásio | máquinas, pesos livres, cardio machines, cabos | tatami se não existir, parceiro se não houver contexto | todos os treinos estruturados |
| Dojo | tatami, parceiro, pads, saco, kimono | máquinas de musculação salvo dojo equipado | artes marciais, mobilidade, recuperação pós-aula |
| Exterior | sem equipamento, corda, escadas, barra pública | máquinas, tatami, cargas pesadas sem segurança | corrida, caminhada, sprints, footwork |

## Regras para equipamento editável no perfil

```text
O utilizador pode ter vários locais ativos.
Cada local pode ter uma lista própria de equipamentos.
O mesmo equipamento pode existir em vários locais.
Um exercício sem equipamento aparece em todos os locais compatíveis.
Um exercício com equipamento obrigatório só aparece se esse equipamento existir no local escolhido.
Um exercício com equipamento opcional aparece, mas mostra alternativa sem equipamento quando existir.
```

## Estados de equipamento

```text
required = exercício precisa do equipamento
optional = exercício melhora com o equipamento mas pode ser feito sem ele
alternative = equipamento substitui outro, como elástico em vez de cabo
support = equipamento só apoia ou facilita, como parede, cadeira ou bloco
protective = equipamento de proteção, como luvas, ligaduras, tatami
measurement = equipamento mede tempo, carga, ritmo ou frequência cardíaca
```

## Regras de segurança por equipamento

```text
barra fixa exige fixação segura
barra e discos exigem espaço e controlo de carga
saco exige suporte seguro e proteção de mãos
pads exigem parceiro e controlo
kimono exige cuidado com dedos e pegada
foam roller não deve rolar articulações ou pescoço
pistola de massagem não deve ser usada em cabeça, pescoço anterior, coluna direta ou articulações
gelo não deve tocar diretamente na pele
tatami é obrigatório para quedas, ukemi e projeções
```

## Testes obrigatórios

```text
todo exercício tem equipment_required ou equipment_optional
todo exercício tem pelo menos um local compatível
todo equipamento tem categoria
todo equipamento tem domínio compatível
todo equipamento de proteção aparece como recomendação quando há impacto
todo exercício de queda exige tatami ou superfície segura
todo exercício com parceiro obrigatório não aparece em treino solo
todo exercício com máquina só aparece em ginásio ou local com esse equipamento no perfil
```

## Próximo ficheiro

```text
25_FILTROS_COMPATIBILIDADE_E_REGRAS_DE_VISIBILIDADE.md
```
