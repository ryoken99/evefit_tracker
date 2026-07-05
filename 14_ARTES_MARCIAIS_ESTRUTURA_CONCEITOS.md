# 14 - Artes marciais: estrutura e conceitos

## Objetivo

Este ficheiro define a arquitetura conceptual das artes marciais na EveFit.

A regra base é:

```text
Cada arte marcial mantém a sua identidade própria.
A categoria MMA / Defesa pessoal funcional reaproveita apenas o que é simples, útil, transferível e realista.
```

Este ficheiro ainda não é a lista final de exercícios. Ele define os conceitos técnicos que depois vão gerar exercícios derivados.

## Artes incluídas

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

## Modelo de classificação

Cada exercício marcial deve ter:

```text
primary_type: artes_marciais
arte_principal
artes_secundarias
familia_tecnica
habilidade
conceito_tecnico
contextos_de_uso
equipamento
locais
nivel
seguranca
filtros
```

## Habilidades transversais

Estas habilidades podem aparecer em várias artes, mas não devem criar exercícios duplicados:

```text
postura
guarda
distância
footwork
ataque linear
ataque circular
defesa
bloqueio
esquiva
clinch
queda
defesa de queda
chão
levantamento
controlo
fuga
timing
coordenação
condicionamento específico
mobilidade específica
```

## Regra para exercícios cruzados

Um exercício como jab, sprawl ou technical stand-up pode aparecer em várias áreas, mas deve manter uma entidade canónica única.

Exemplo:

```yaml
id: technical_stand_up
primary_type: artes_marciais
arte_principal: Jiu-Jitsu / BJJ
artes_secundarias:
  - MMA / Defesa pessoal funcional
filtros:
  - Artes marciais > Jiu-Jitsu / BJJ > Movimentação no solo
  - Artes marciais > MMA / Defesa pessoal funcional > Levantar do chão
```

## Regra de segurança para defesa pessoal

A app não deve prometer vitória numa luta real.

A formulação correta é:

```text
proteger
criar distância
sair da posição
levantar com segurança
fugir
pedir ajuda
sobreviver
```

A formulação errada é:

```text
faz isto e ganhas uma luta real
```

---

# Karate

## Identidade

Arte de striking com foco em base, distância, alinhamento, explosão, timing, golpes lineares, pontapés, bloqueios, kata e kumite.

## Prioridades para iniciantes

```text
aprender postura e base antes de velocidade
entender guarda, distância e deslocamento
aprender socos e pontapés com controlo
separar kihon, kata e aplicação prática
evitar força sem técnica
```

## Famílias conceptuais

| Concept ID | Conceito | Explicação para iniciante |
|---|---|---|
| `karate_stance_alignment` | Alinhamento de base | Colocar pés, joelhos, anca e tronco para gerar estabilidade. |
| `karate_front_stance` | Zenkutsu dachi | Base frontal para avanço, pressão e golpes retos. |
| `karate_back_stance` | Kokutsu dachi | Base recuada para defesa, controlo de peso e transições. |
| `karate_horse_stance` | Kiba dachi | Base lateral para força de pernas e estabilidade. |
| `karate_fighting_guard` | Guarda de kumite | Postura móvel para distância e reação. |
| `karate_linear_step` | Deslocamento linear | Avançar e recuar mantendo base e equilíbrio. |
| `karate_angle_step` | Entrada em ângulo | Sair da linha direta e criar ângulo de ataque. |
| `karate_tai_sabaki` | Tai sabaki | Rodar e sair da linha de ataque. |
| `karate_distance_management` | Gestão de distância | Entrar, sair e controlar o espaço antes do golpe. |
| `karate_oi_zuki` | Oi zuki | Soco avançando com coordenação de base e anca. |
| `karate_gyaku_zuki` | Gyaku zuki | Soco contrário com rotação de anca. |
| `karate_kizami_zuki` | Kizami zuki | Soco frontal rápido para entrada e controlo de distância. |
| `karate_mae_geri` | Mae geri | Pontapé frontal para linha média, distância e interrupção. |
| `karate_mawashi_geri` | Mawashi geri | Pontapé circular com rotação da anca. |
| `karate_yoko_geri` | Yoko geri | Pontapé lateral para empurrar ou atacar em linha lateral. |
| `karate_age_uke` | Age uke | Bloqueio ascendente. |
| `karate_soto_uke` | Soto uke | Bloqueio de fora para dentro. |
| `karate_uchi_uke` | Uchi uke | Bloqueio de dentro para fora. |
| `karate_gedan_barai` | Gedan barai | Defesa baixa e limpeza de linha. |
| `karate_kihon_single` | Kihon isolado | Repetir técnica base com alinhamento e intenção. |
| `karate_kihon_combo` | Kihon em combinação | Unir deslocamento, defesa e ataque. |
| `karate_kata_sequence` | Sequência de kata | Aprender padrões formais com ritmo e direção. |
| `karate_bunkai_basic` | Bunkai básico | Entender aplicação simples de movimentos do kata. |
| `karate_kumite_technical` | Kumite técnico | Treinar distância, reação e entrada com controlo. |
| `karate_shadow` | Sombra de Karate | Treinar combinações sem contacto. |
| `karate_bag_light` | Trabalho leve ao saco | Aplicar técnica com impacto controlado. |

## Filtros recomendados

```text
Artes marciais > Karate
  > Bases
  > Deslocamentos
  > Guarda
  > Socos
  > Pontapés
  > Bloqueios
  > Kihon
  > Kata
  > Kumite técnico
  > Sombra
  > Saco
  > Condicionamento específico
  > Mobilidade específica
```

---

# Jiu-Jitsu / BJJ

## Identidade

Arte de grappling com foco em controlo, solo, guarda, escapes, passagem, transições, submissões, posição e sobrevivência.

## Prioridades para iniciantes

```text
aprender a mover a anca no chão
aprender a defender antes de atacar
entender posições antes de submissões
aprender a levantar em segurança
treinar quedas e ukemi com cuidado
```

## Famílias conceptuais

| Concept ID | Conceito | Explicação para iniciante |
|---|---|---|
| `bjj_shrimp` | Shrimp / fuga de anca | Criar espaço usando anca e pernas. |
| `bjj_bridge` | Ponte de grappling | Gerar força com pernas e anca para escapar ou desequilibrar. |
| `bjj_technical_stand_up` | Technical stand-up | Levantar do chão mantendo distância e proteção. |
| `bjj_granby_basic` | Granby básico | Inversão controlada para recuperar guarda ou sair de pressão. |
| `bjj_hip_switch` | Troca de anca | Mudar direção e ângulo no chão. |
| `bjj_closed_guard` | Guarda fechada | Controlar distância com pernas e tronco. |
| `bjj_open_guard_frames` | Guarda aberta com frames | Usar braços e pernas para manter espaço. |
| `bjj_guard_retention` | Retenção de guarda | Impedir passagem usando anca, joelhos e frames. |
| `bjj_recover_guard` | Recuperar guarda | Voltar a pôr pernas entre o corpo e o adversário. |
| `bjj_frames` | Frames | Criar estrutura com braços e ossos sem gastar força excessiva. |
| `bjj_pressure_passing` | Passagem por pressão | Controlar pernas e tronco para passar com peso. |
| `bjj_mobility_passing` | Passagem por mobilidade | Passar usando ângulos, velocidade e reação. |
| `bjj_side_control` | Controlo lateral | Controlar tronco e cabeça após passar guarda. |
| `bjj_mount_control` | Montada | Controlar por cima com peso e equilíbrio. |
| `bjj_back_control` | Controlo das costas | Controlar o adversário por trás com segurança. |
| `bjj_side_escape` | Escape do controlo lateral | Criar espaço, repor frames e recuperar guarda. |
| `bjj_mount_escape_bridge_roll` | Escape de montada com ponte e rotação | Desequilibrar e inverter posição. |
| `bjj_mount_escape_elbow_knee` | Escape cotovelo-joelho | Criar espaço para recuperar meia guarda ou guarda. |
| `bjj_sprawl` | Sprawl | Defender entrada às pernas afastando a anca. |
| `bjj_penetration_step` | Passo de entrada | Entrar para queda com joelho, postura e direção. |
| `bjj_single_leg_basic` | Single leg básico | Controlar uma perna e desequilibrar. |
| `bjj_double_leg_basic` | Double leg básico | Entrar às duas pernas com postura protegida. |
| `bjj_breakfall_basic` | Breakfall / ukemi básico | Cair com segurança e reduzir impacto. |
| `bjj_grip_fighting` | Grip fighting | Disputar e quebrar pegadas. |
| `bjj_towel_grip` | Pega com toalha | Desenvolver força de pega transferível para kimono. |

## Filtros recomendados

```text
Artes marciais > Jiu-Jitsu / BJJ
  > Movimentação no solo
  > Guarda
  > Retenção de guarda
  > Passagem
  > Controlo posicional
  > Escapes
  > Quedas
  > Defesa de quedas
  > Ukemi
  > Pegada
  > Condicionamento específico
  > Mobilidade específica
```

---

# Boxe

## Identidade

Arte de striking focada em mãos, guarda, footwork, distância, ritmo, defesa, esquiva e combinações de socos.

## Prioridades para iniciantes

```text
aprender guarda antes de combinações
aprender jab e direto com equilíbrio
não cruzar os pés no footwork
defender depois de atacar
não bater forte antes de controlar punhos, ombros e tronco
```

## Famílias conceptuais

| Concept ID | Conceito | Explicação para iniciante |
|---|---|---|
| `boxing_stance` | Base de boxe | Posição de pés, joelhos, anca e tronco para atacar e defender. |
| `boxing_high_guard` | Guarda alta | Proteger cabeça e linha central. |
| `boxing_chin_position` | Queixo protegido | Reduzir exposição ao golpe direto. |
| `boxing_weight_distribution` | Distribuição de peso | Manter equilíbrio para bater e mover. |
| `boxing_step_drag` | Step-drag | Mover sem cruzar os pés. |
| `boxing_pivot` | Pivot | Rodar para criar ângulo. |
| `boxing_in_out` | Entrar e sair | Controlar distância antes e depois do golpe. |
| `boxing_lateral_step` | Passo lateral | Sair da linha de ataque. |
| `boxing_jab` | Jab | Soco frontal rápido para medir, interromper e preparar. |
| `boxing_cross` | Direto / cross | Soco forte da mão de trás com rotação. |
| `boxing_hook` | Gancho | Ataque circular curto ou médio. |
| `boxing_uppercut` | Uppercut | Ataque ascendente em curta distância. |
| `boxing_body_shot` | Golpe ao corpo | Atacar tronco sem expor a cabeça. |
| `boxing_parry` | Parry | Desviar soco com pequena ação da mão. |
| `boxing_block` | Bloqueio | Receber impacto na guarda com estrutura. |
| `boxing_slip` | Slip | Sair da linha do soco com cabeça e tronco. |
| `boxing_roll` | Roll | Passar por baixo de golpes circulares. |
| `boxing_cover_exit` | Cobrir e sair | Proteger e reposicionar. |
| `boxing_one_two` | 1-2 | Jab e direto como combinação base. |
| `boxing_shadow_rounds` | Sombra de boxe | Treinar técnica sem contacto. |
| `boxing_bag_rounds` | Rounds no saco | Aplicar ritmo, distância e impacto controlado. |

## Filtros recomendados

```text
Artes marciais > Boxe
  > Base
  > Guarda
  > Footwork
  > Jab
  > Direto
  > Gancho
  > Uppercut
  > Defesa
  > Esquivas
  > Combinações
  > Sombra
  > Saco
```

---

# Kickboxing

## Identidade

Striking que combina socos e pontapés, com foco em combinações mão-perna, distância, ritmo, defesa e condicionamento.

## Prioridades para iniciantes

```text
aprender base que permita socar e pontapear
não pontapear sem recuperar guarda
entender distância de mãos e pernas
treinar combinações simples antes de sequências longas
controlar rotação da anca e equilíbrio
```

## Famílias conceptuais

| Concept ID | Conceito | Explicação para iniciante |
|---|---|---|
| `kickboxing_stance` | Base de kickboxing | Postura adaptada a socos e pontapés. |
| `kickboxing_guard` | Guarda de kickboxing | Proteção alta com prontidão para pontapear. |
| `kickboxing_hands_kicks_range` | Distância mãos-pernas | Saber quando usar soco ou pontapé. |
| `kickboxing_balance_after_kick` | Equilíbrio após pontapé | Voltar à base sem ficar exposto. |
| `kickboxing_jab` | Jab | Entrada e medição de distância. |
| `kickboxing_cross` | Direto | Golpe forte de mão de trás. |
| `kickboxing_hook` | Gancho | Ataque circular. |
| `kickboxing_uppercut` | Uppercut | Ataque ascendente de curta distância. |
| `kickboxing_low_kick` | Low kick | Pontapé à perna. |
| `kickboxing_middle_kick` | Middle kick | Pontapé ao tronco. |
| `kickboxing_high_kick` | High kick | Pontapé alto com controlo. |
| `kickboxing_front_kick` | Front kick | Pontapé frontal para distância. |
| `kickboxing_side_kick` | Side kick | Pontapé lateral para distância e interrupção. |
| `kickboxing_punch_to_kick` | Mão para perna | Usar socos para preparar pontapé. |
| `kickboxing_kick_to_punch` | Perna para mão | Usar pontapé para entrar com socos. |
| `kickboxing_check_low_kick` | Check de low kick | Defender pontapé baixo com canela. |
| `kickboxing_angle_exit` | Sair em ângulo | Evitar linha de ataque e responder. |
| `kickboxing_bag_combinations` | Combinações no saco | Trabalhar ritmo e impacto com segurança. |

## Filtros recomendados

```text
Artes marciais > Kickboxing
  > Base
  > Guarda
  > Footwork
  > Socos
  > Pontapés baixos
  > Pontapés médios
  > Pontapés altos
  > Combinações mão-perna
  > Defesa
  > Saco
```

---

# Muay Thai

## Identidade

Striking com socos, pontapés, joelhos, cotovelos, clinch, equilíbrio, pressão e impacto.

## Prioridades para iniciantes

```text
aprender base mais estável e guarda alta
controlar low kick, teep e middle kick
respeitar progressão de impacto
não treinar cotovelos e clinch sem segurança
aprender defesa de pontapés e equilíbrio
```

## Famílias conceptuais

| Concept ID | Conceito | Explicação para iniciante |
|---|---|---|
| `muay_thai_stance` | Base de Muay Thai | Postura estável para pontapés, checks e clinch. |
| `muay_thai_high_guard` | Guarda alta | Proteção forte contra golpes. |
| `muay_thai_weight_shift` | Transferência de peso | Preparar checks, pontapés e joelhos. |
| `muay_thai_balance_recovery` | Recuperar equilíbrio | Voltar à base depois de impacto. |
| `muay_thai_low_kick` | Low kick | Pontapé baixo com rotação de anca. |
| `muay_thai_middle_kick` | Middle kick | Pontapé ao tronco com canela. |
| `muay_thai_teep` | Teep | Pontapé frontal para distância e interrupção. |
| `muay_thai_check` | Check | Defesa com canela contra pontapé baixo ou médio. |
| `muay_thai_jab_cross` | Jab e direto | Mãos base para entrar e preparar golpes. |
| `muay_thai_elbow_basic` | Cotovelada básica | Golpe curto de proximidade. |
| `muay_thai_knee_straight` | Joelhada direta | Ataque de curta ou média distância. |
| `muay_thai_knee_clinch` | Joelhada em clinch | Usar controlo do tronco para atacar. |
| `muay_thai_clinch_posture` | Postura de clinch | Controlar cabeça, braços e equilíbrio. |
| `muay_thai_clinch_entry` | Entrada para clinch | Entrar sem expor a cabeça. |
| `muay_thai_clinch_turn` | Virar no clinch | Desequilibrar e mudar ângulo. |
| `muay_thai_clinch_escape` | Sair do clinch | Recuperar distância e guarda. |
| `muay_thai_bag_rounds` | Rounds no saco | Trabalhar golpes com impacto controlado. |
| `muay_thai_teep_drills` | Drills de teep | Treinar distância e controlo. |
| `muay_thai_check_drills` | Drills de check | Treinar defesa e reação. |

## Filtros recomendados

```text
Artes marciais > Muay Thai
  > Base
  > Guarda
  > Low kick
  > Middle kick
  > Teep
  > Joelhadas
  > Cotoveladas
  > Clinch
  > Defesa de pontapés
  > Saco
  > Condicionamento específico
```

---

# Judo

## Identidade

Arte de grappling em pé com foco em queda segura, pegada, desequilíbrio, entradas, projeções e controlo.

## Prioridades para iniciantes

```text
aprender ukemi antes de projeções
entender pegada e postura
aprender kuzushi antes de força
treinar entradas sem projetar primeiro
usar progressão e superfície segura
```

## Famílias conceptuais

| Concept ID | Conceito | Explicação para iniciante |
|---|---|---|
| `judo_back_breakfall` | Ukemi para trás | Cair para trás com segurança. |
| `judo_side_breakfall` | Ukemi lateral | Cair de lado reduzindo impacto. |
| `judo_forward_roll` | Rolamento frontal | Dissipar energia em queda para a frente. |
| `judo_fall_recovery` | Levantar após queda | Voltar à base com segurança. |
| `judo_natural_posture` | Postura natural | Base equilibrada e pronta. |
| `judo_kumi_kata` | Kumi kata | Luta de pegadas. |
| `judo_grip_break` | Quebra de pegada | Remover controlo do adversário. |
| `judo_posture_control` | Controlo de postura | Evitar ser puxado ou dobrado facilmente. |
| `judo_kuzushi_forward` | Desequilíbrio para a frente | Criar queda retirando base. |
| `judo_kuzushi_backward` | Desequilíbrio para trás | Levar o peso para trás. |
| `judo_uchikomi` | Uchikomi | Entrada repetida sem projeção completa. |
| `judo_osoto_gari` | O soto gari | Grande ceifa externa. |
| `judo_ogoshi` | O goshi | Projeção de anca básica. |
| `judo_de_ashi_barai` | De ashi barai | Varredura do pé avançado. |
| `judo_seoi_nage_basic` | Seoi nage básico | Projeção de ombro com progressão segura. |
| `judo_kesa_gatame` | Kesa gatame | Controlo lateral com braço e cabeça. |
| `judo_hold_escape` | Escape de imobilização | Criar espaço e girar. |
| `judo_throw_to_hold` | Transição queda para controlo | Após projetar, controlar sem perder posição. |

## Filtros recomendados

```text
Artes marciais > Judo
  > Ukemi
  > Pegadas
  > Postura
  > Kuzushi
  > Entradas
  > Projeções básicas
  > Defesa de queda
  > Controlo no chão
```

---

# Taekwondo

## Identidade

Arte de striking com forte foco em pontapés, distância, velocidade, equilíbrio, mobilidade de anca e controlo de perna.

## Prioridades para iniciantes

```text
aprender equilíbrio antes de pontapés altos
controlar câmara e recolha da perna
não forçar amplitude sem mobilidade
treinar pontapés baixos e médios antes de altos
manter guarda mesmo durante pontapés
```

## Famílias conceptuais

| Concept ID | Conceito | Explicação para iniciante |
|---|---|---|
| `taekwondo_stance` | Base de Taekwondo | Postura móvel e preparada para pontapés. |
| `taekwondo_guard` | Guarda | Proteção enquanto se controla distância. |
| `taekwondo_bounce_step` | Bounce step | Movimento leve para gerir distância. |
| `taekwondo_range_control` | Controlo de distância | Entrar e sair do alcance de pontapé. |
| `taekwondo_front_kick` | Pontapé frontal | Ataque linear com câmara e extensão. |
| `taekwondo_roundhouse_kick` | Pontapé circular | Ataque circular com rotação de anca. |
| `taekwondo_side_kick` | Pontapé lateral | Ataque lateral com extensão de anca. |
| `taekwondo_back_kick` | Pontapé para trás | Ataque com rotação e visão de alvo. |
| `taekwondo_axe_kick` | Pontapé descendente | Ataque descendente com controlo de amplitude. |
| `taekwondo_chamber_control` | Controlo de câmara | Levantar e manter joelho antes da extensão. |
| `taekwondo_rechamber` | Recolha do pontapé | Voltar a perna sem cair ou expor. |
| `taekwondo_balance_hold` | Equilíbrio em uma perna | Estabilizar anca, pé e core. |
| `taekwondo_kick_height_progression` | Progressão de altura | Subir alvo sem perder técnica. |
| `taekwondo_kick_combinations` | Sequências de pontapés | Unir pontapés com equilíbrio. |
| `taekwondo_rounds_kicks` | Rounds de pontapés | Trabalhar resistência técnica. |
| `taekwondo_shadow_kicking` | Sombra de pontapés | Treinar sem impacto. |

## Filtros recomendados

```text
Artes marciais > Taekwondo
  > Base
  > Guarda
  > Footwork
  > Pontapé frontal
  > Pontapé circular
  > Pontapé lateral
  > Pontapé atrás
  > Equilíbrio
  > Mobilidade de anca
  > Flexibilidade específica
  > Sequências de pontapés
```

---

# MMA / Defesa pessoal funcional

## Identidade

Categoria funcional que junta princípios simples, úteis e transferíveis para proteção, distância, saída, sobrevivência e fuga.

Isto não é MMA competitivo puro e não é fantasia de defesa pessoal. O objetivo não é ganhar uma luta. O objetivo é aumentar hipóteses de sair de uma situação perigosa.

## Prioridades para iniciantes

```text
evitar e desescalar vem antes de lutar
proteger a cabeça e criar distância
sair da linha de ataque
levantar do chão em segurança
fugir quando houver oportunidade
não ensinar técnicas de baixa probabilidade como solução principal
```

## Famílias conceptuais

| Concept ID | Conceito | Explicação para iniciante |
|---|---|---|
| `self_defense_awareness` | Consciência de distância | Perceber proximidade, saídas e risco. |
| `self_defense_non_aggressive_guard` | Guarda não agressiva | Mãos prontas sem escalar visualmente a situação. |
| `self_defense_basic_guard` | Guarda defensiva básica | Proteger cabeça e tronco. |
| `self_defense_exit_footwork` | Footwork de saída | Criar distância e ângulo para fugir. |
| `self_defense_boundary_setting` | Barreira verbal e física | Comunicar limite mantendo proteção. |
| `self_defense_cover_shell` | Cobertura básica | Proteger cabeça sob pressão. |
| `self_defense_move_off_line` | Sair da linha | Não ficar no centro do ataque. |
| `self_defense_simple_parry` | Desvio simples | Redirecionar golpe sem movimento grande. |
| `self_defense_defensive_clinch` | Entrada defensiva para clinch | Reduzir dano quando não dá para sair. |
| `self_defense_counter_to_escape` | Contra-ataque para fugir | Usar resposta simples só para criar saída. |
| `self_defense_wrist_grab_release` | Saída de agarre no pulso | Libertar pela linha fraca da pegada. |
| `self_defense_clinch_frame` | Frame no clinch | Criar espaço com antebraços e postura. |
| `self_defense_clinch_escape` | Sair do clinch | Recuperar distância e sair. |
| `self_defense_sprawl` | Sprawl funcional | Defender entrada às pernas. |
| `self_defense_breakfall` | Queda segura funcional | Reduzir dano ao cair. |
| `self_defense_ground_frames` | Frames no chão | Criar espaço entre corpo e ameaça. |
| `self_defense_technical_stand_up` | Technical stand-up funcional | Levantar protegendo cabeça e distância. |
| `self_defense_palm_strike` | Palm strike | Golpe simples com palma para criar espaço. |
| `self_defense_low_kick_simple` | Low kick simples | Ataque baixo para interromper avanço, quando aplicável. |
| `self_defense_knee_simple` | Joelhada simples | Golpe curto em clinch para criar saída. |
| `self_defense_push_and_exit` | Empurrar e sair | Criar espaço e fugir. |
| `self_defense_escape_priority` | Prioridade de fuga | Treinar decisão de sair em vez de continuar. |
| `self_defense_multiple_attackers_rule` | Regra de múltiplas ameaças | Não ir voluntariamente para o chão. |
| `self_defense_wall_escape` | Sair da parede | Não ficar preso numa barreira. |

## Filtros recomendados

```text
Artes marciais > MMA / Defesa pessoal funcional
  > Consciência e distância
  > Guarda básica
  > Footwork de saída
  > Defesa contra socos
  > Defesa contra agarrões
  > Clinch defensivo
  > Defesa de queda
  > Chão
  > Levantar do chão
  > Golpes simples de emergência
  > Fuga
  > Cenários realistas
```

---

# Mapa de cruzamentos importantes

| Conceito | Arte principal | Também aparece em | Motivo |
|---|---|---|---|
| Jab | Boxe | Kickboxing, Muay Thai, MMA / Defesa pessoal funcional | Golpe linear simples para distância, entrada e interrupção. |
| Direto / cross | Boxe | Kickboxing, Muay Thai, MMA / Defesa pessoal funcional | Golpe forte de mão de trás com transferência de peso. |
| Low kick | Muay Thai | Kickboxing, MMA / Defesa pessoal funcional | Ataque simples à perna, útil em striking. |
| Teep / pontapé frontal | Muay Thai | Kickboxing, Taekwondo, Karate, MMA / Defesa pessoal funcional | Criar distância e interromper avanço. |
| Sprawl | Jiu-Jitsu / BJJ | MMA / Defesa pessoal funcional | Defesa simples contra entrada às pernas. |
| Technical stand-up | Jiu-Jitsu / BJJ | MMA / Defesa pessoal funcional | Levantar do chão protegendo cabeça e distância. |
| Ukemi / breakfall | Judo | Jiu-Jitsu / BJJ, Defesa pessoal funcional, Prevenção | Reduzir dano ao cair. |
| Clinch defensivo | Muay Thai | MMA / Defesa pessoal funcional, Judo, BJJ | Controlar proximidade quando não dá para fugir imediatamente. |
| Footwork de saída | Boxe | Karate, Kickboxing, MMA / Defesa pessoal funcional | Criar ângulo e distância. |
| Frames no chão | Jiu-Jitsu / BJJ | MMA / Defesa pessoal funcional | Criar espaço sem depender só de força. |

---

# Filtros globais recomendados

```text
Artes marciais
  > Karate
  > Jiu-Jitsu / BJJ
  > Boxe
  > Kickboxing
  > Muay Thai
  > Judo
  > Taekwondo
  > MMA / Defesa pessoal funcional

Artes marciais > Tipo
  > Striking
  > Grappling
  > Quedas
  > Defesa pessoal
  > Condicionamento
  > Mobilidade específica

Artes marciais > Contexto
  > Técnica
  > Aquecimento técnico
  > Treino principal
  > Condicionamento
  > Saco / alvo
  > Solo
  > Com parceiro
  > Defesa pessoal funcional
```

---

# Regras para descrições pedagógicas

Cada exercício marcial deve explicar:

```text
objetivo
posição inicial
como fazer passo a passo
o que sentir ou controlar
erros comuns
versão mais fácil
versão mais difícil
cuidados de segurança
aplicação técnica
limitações
```

Para defesa pessoal, acrescentar:

```text
objetivo realista
como criar distância
como sair da posição
quando fugir
o que não prometer
```

---

# Testes obrigatórios

```text
todo exercício marcial tem arte principal
todo exercício marcial tem família técnica
todo exercício marcial tem nível
todo exercício marcial tem contexto de uso
todo exercício de defesa pessoal tem aviso realista
todo exercício de saco ou contacto tem cuidado de segurança
todo exercício de queda tem progressão e superfície segura
todo exercício cruzado mantém identidade única
todo exercício que aparece em MMA / Defesa pessoal funcional explica porque é útil
```

---

# Contagem

Este ficheiro define 167 conceitos técnicos de artes marciais.

# Próximo ficheiro

O próximo ficheiro deve ser:

```text
15_ARTES_MARCIAIS_EXERCICIOS_DERIVADOS.md
```

Esse ficheiro deve transformar estes conceitos em exercícios concretos, com:

```text
concept_id
exercício
arte principal
artes secundárias
família técnica
nível
equipamento
local
contextos
filtros
notas de segurança
```
