# Relatório de validação dos filtros (v0.9.2)

Validação da FASE 10: cada exercício aparece nos filtros corretos
(músculo/área, local e equipamento), aparece em "mostrar todos" e não aparece
em filtros errados. Fonte programática: `tool/full_catalog_inventory.dart`
(secção "Filtros onde aparece" por exercício) e os testes referidos abaixo.

## Totais

- Total de exercícios antes: 315
- Total de exercícios depois: 353
- Total de exercícios analisados: 353
- Total de exercícios adicionados: 38
- Total de exercícios corrigidos (filtros): 2 diretos + 10 de equipamento marcial + precisão dos focos técnicos (ver abaixo)
- Seleções de UI avaliadas: **189** (musculação por subzona/foco, 13 modos de cardio, 29 focos de artes marciais, 13 zonas de mobilidade, 5 tipos de recuperação)
- Exercícios inalcançáveis por qualquer filtro: **0** (eram 2 antes desta revisão)
- Combinações válidas com zero resultados: **0** (quality gate `full_combinatorics`)

## Matriz de validação

Cada exercício foi avaliado contra as 189 seleções em quatro cenários
(Ginásio; Casa com todo o equipamento; Exterior/parque; Dojo com tatami) e em
cinco cenários de local sem seleção anatómica. O resultado por exercício está
na secção "Lista completa" de `full_exercise_catalog_inventory.md`
(campos "Locais possíveis" e "Filtros onde aparece").

### Novos filtros introduzidos

- **Cardio**: modos "Remo ergómetro", "Stepper / escadas" e "Air bike",
  visíveis no ginásio (ou com o equipamento selecionado em casa), com
  seleções, tags e chaves de equipamento próprias.
- **Karate**: focos "Bases (dachi)", "Bloqueios", "Esquivas / tai-sabaki",
  "Joelhadas" e "Trabalho ao saco".
- **Jiu-Jitsu**: focos "Rolamentos", "Breakfalls / ukemi" e "Inversões".

### Correções de filtros a exercícios existentes

1. **Mobilidade de ombro com cabo de vassoura** — o equipamento `broomstick`
   não incluía a chave `bodyweight` exigida pelas seleções de mobilidade;
   os auxiliares de mobilidade (vassoura, rolo, bola) passam a contar como
   movimentos de peso corporal, mantendo o requisito do auxiliar na
   disponibilidade. Agora aparece em "Mobilidade > Ombros".
2. **Rotação externa da anca no chão** — recebia equipamento de uma regra de
   ombro ("Elásticos"); corrigido para "Peso corporal". Agora aparece em
   "Mobilidade > Anca" e "Mobilidade > Glúteos".
3. **Precisão dos focos técnicos marciais** — os focos de Karate/Jiu-Jitsu
   passam a ser correspondidos apenas pelo NOME do drill (as tags anatómicas
   continuam a valer primeiro). Antes, um drill entrava num foco só porque a
   descrição mencionava uma palavra (ex.: trabalho ao saco aparecia em
   "Guarda" por causa do texto). Aliases novos garantem que Sprawl continua
   em "Condicionamento" e os drills de mobilidade/pega/core nos focos certos.
4. **Equipamento marcial** — a regra que dava "Tatami ou tapete / colchonete"
   aos drills de solo de Jiu-Jitsu nunca disparava (comparação
   `'jiu_jitsu'` vs. `'jiu jitsu'`); ativada, os drills de solo pedem
   tatami/tapete e a mobilidade/pega/core/condicionamento ficam em qualquer
   local, como o comentário do código sempre documentou.

### Regras verificadas (testes automáticos)

| Verificação | Teste |
|---|---|
| Todas as subzonas/focos de musculação devolvem exercícios no ginásio | `test/v081_filter_and_text_review_test.dart` |
| Todas as combinações válidas da UI devolvem resultados | `test/filters/full_filter_combinatorics_test.dart` |
| Novos exercícios nos filtros corretos (halteres, casa, cardio, mobilidade, elasticidade, artes marciais, recuperação, dojo) | `test/v092_catalog_expansion_test.dart` testes 15-23 |
| Híbridos não aparecem em filtros errados (lenhador ∉ ombros, saco ∉ guarda) | `test/v092_catalog_expansion_test.dart` teste 24 |
| "Mostrar todos" devolve os 353 | `test/v092_catalog_expansion_test.dart` teste 28 |
| Matriz manual de filtros v0.8.0 continua válida | `test/v080/manual_filter_matrix_test.dart` |

## Decisões tomadas

- "Subida de escadas no exterior" aparece no modo "Corrida exterior" (é o
  modo de cardio exterior de esforço contínuo); criar um modo exclusivo para
  escadas exteriores duplicaria a UI para um único exercício.
- "Shadow boxing leve" e "Shuttle runs" vivem em "Sem equipamento"/"HIIT";
  o shadow boxing também responde à modalidade "Condicionamento para artes
  marciais".
- O quality gate de combinatórias marcial inclui `heavy_bag` no equipamento
  do dojo, para validar o foco "Trabalho ao saco" (o exercício continua
  indisponível se o utilizador não tiver saco).

## Lacunas resolvidas / pendentes

- Resolvidas: as duas órfãs de filtro (acima) e a ausência de filtros para
  remo/escadas/air bike.
- Para revisão humana: nenhum caso pendente; a matriz completa está no
  inventário FASE 1 e é regenerável com `dart run tool/full_catalog_inventory.dart`.

## Limitações restantes

- A validação usa os mesmos serviços da app (não a UI real); os testes de
  widget cobrem o modal, mas não navegam todos os 189 caminhos da UI.
- "Casa equipada" assume todas as chaves de equipamento selecionadas.
