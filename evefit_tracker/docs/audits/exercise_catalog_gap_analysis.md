# Gap analysis do catálogo de exercícios (FASE 3)

> **Estado final (v0.9.2)**: todos os GAP e CORRIGIR deste documento foram
> resolvidos — 38 exercícios adicionados e 4 correções aplicadas. Ver
> `exercise_catalog_expansion_report.md`, `exercise_filter_validation_report.md`
> e `exercise_description_rewrite_report.md`.

Comparação entre o catálogo real (315 exercícios — ver
`full_exercise_catalog_inventory.md`) e o catálogo ideal de referência
(`target_exercise_catalog_reference.md`). Estado por slot:

- **COBERTO** — já existe pelo menos um exercício adequado por ambiente exigido.
- **GAP** — não existe; proposta de novo exercício.
- **CORRIGIR** — existe mas tem um problema (filtro, texto ou marcação).

## 1. Musculação

### Peito
- PEI-01 a PEI-04 — COBERTO (flexões ×6, supinos ×7, aberturas ×4, squeeze/chest press, dips ×2, crossover, pullover).
- PEI-05 serrátil — COBERTO (Scapular push-up, Wall slides).

### Costas
- COS-01 a COS-06 — COBERTO (puxadas ×4, remos ×6, pullovers, scapular pull-up, dead hang escapular, good morning, hiperextensões, superman).

### Ombros
- OMB-01/02/03/05/06/07 — COBERTO.
- OMB-04 supraespinhoso — **GAP** → **Elevação no plano da omoplata** (scaption, halteres leves; casa + ginásio).

### Braços
- BRA-01 a BRA-08 — COBERTO (17 bíceps + 20 tríceps cobrem todas as cabeças e ambientes).

### Antebraço, punho, mãos
- ANT-01 a ANT-08 — COBERTO (19 exercícios: wrist curls, desvios, pronação/supinação, pinch, towel, finger curls, extensão de dedos, carries).

### Core
- COR-01/03/04/06/07/08 — COBERTO.
- COR-02 anti-rotação sem equipamento — parcialmente coberto (bird dog); **GAP** → **Prancha com toque no ombro** (anti-rotação pura sem equipamento, regressão clara da prancha).
- COR-05 rotação com carga — parcialmente coberto (russian twist); **GAP** → **Lenhador no cabo** (rotação em pé com carga, ginásio).

### Glúteos e anca
- GLU-01/02/04/05 — COBERTO.
- GLU-03 rotadores externos — **GAP** → **Clamshell** (sem equipamento, casa) + **CORRIGIR**: "Rotação externa da anca no chão" (E298) não aparece em nenhum filtro da UI.

### Pernas
- PER-01/02/03/06/07/08/09 — COBERTO (45 exercícios de pernas).
- PER-04 flexão de joelho sem máquina — **GAP** → **Curl nórdico assistido** (excêntrico de isquiotibiais, casa/dojo).
- PER-05 dobradiça unilateral / equilíbrio — **GAP** → **Peso morto unilateral com halteres**.

### Trapézio e pescoço
- TRA-01, PES-01/03/04 — COBERTO.
- PES-02 extensão cervical — **GAP** → **Isometria cervical posterior leve** (o catálogo tem frontal e lateral, falta posterior).

## 2. Cardio

- CAR-01/02/03/04/08/09/12 — COBERTO (49 exercícios: passadeira ×10, bicicleta ×6, elíptica ×6, corda ×5, exterior ×9, sem equipamento ×9).
- CAR-05 remo ergómetro — **GAP** → **Remo ergómetro ritmo contínuo** + **Remo ergómetro intervalos** (equipamento `rower` já existe na app e não tem um único exercício).
- CAR-06 escadas/stepper — **GAP** → **Stepper / escadas ritmo contínuo** + **Stepper / escadas intervalos** (equipamento `stepper` existe sem exercícios) + **Subida de escadas no exterior**.
- CAR-07 air bike — **GAP** → **Air bike ritmo contínuo** + **Air bike intervalos** (equipamento `air_bike` existe sem exercícios).
- CAR-10 shadow boxing — **GAP** → **Shadow boxing leve** (cardio de coordenação sem equipamento, impacto baixo/médio).
- CAR-11 shuttle runs — **GAP** → **Shuttle runs / corrida vaivém** (exterior/espaço livre, impacto alto).
- Transversal — **CORRIGIR**: classificar o impacto (baixo/médio/alto) no texto dos exercícios de cardio novos e garantir coerência nos existentes.

## 3-4. Mobilidade e elasticidade

- MOB-01/02/03/04/06/09/10/11/12 — COBERTO (44 exercícios de mobilidade).
- MOB-05 extensão de coluna — **GAP** → **Cobra suave no chão**.
- MOB-07 flexores da anca — **GAP** → **Alongamento de flexores da anca em afundo** (zona muito treinada sem alongamento dedicado).
- MOB-08 adutores — **GAP** → **Alongamento borboleta de adutores**.
- MOB-13 global dinâmico — **GAP** → **Alongamento dinâmico global** (world's greatest stretch, aquecimento completo).
- ELA-03 PNF — **GAP** → **Alongamento PNF de isquiotibiais** + **Alongamento PNF de peitoral na parede** (não existe nenhum alongamento contrai-relaxa).
- ELA-04 tríceps/ombro — **GAP** → **Alongamento de tríceps atrás da cabeça**.
- **CORRIGIR**: "Mobilidade de ombro com cabo de vassoura" (E278) não aparece em nenhum filtro da UI.

## 5. Artes marciais

### Karate (11 atuais)
- KAR-01/02/03/05/06/07/08/12/14 — COBERTO.
- KAR-04 bases (dachi) — **GAP** → **Treino de bases (dachi)**.
- KAR-09 bloqueios — **GAP** → **Bloqueios técnicos (uke)**.
- KAR-10 esquivas — **GAP** → **Esquivas e tai-sabaki**.
- KAR-11 joelhadas — **GAP** → **Joelhadas técnicas**.
- KAR-13 saco — **GAP** → **Trabalho leve ao saco** (marcado: requer saco de pancada, equipamento `heavy_bag` já existente).

### Jiu-Jitsu (11 atuais)
- JJ-01/02/03/04/08/09/10/11 — COBERTO.
- JJ-05 rolamentos — **GAP** → **Rolamentos de solo** (frente e trás).
- JJ-06 breakfalls — **GAP** → **Breakfalls (ukemi)** (marcado: tatami/colchão).
- JJ-07 inversões — **GAP** → **Inversão granby com apoio**.

## 6-7. Recuperação, prevenção, aquecimento e arrefecimento

- REC-01/06/07/10, AQU-01/03 — COBERTO (respiração diafragmática, caminhada leve, relaxamento, cooldowns de máquina, aquecimentos de máquina, mobilidade dinâmica).
- REC-02 respiração nasal — **GAP** → **Respiração nasal lenta**.
- REC-03 rolo pernas — **GAP** → **Foam roller para pernas** (equipamento `foam_roller` existe na app sem exercícios).
- REC-04 rolo costas — **GAP** → **Foam roller para costas**.
- REC-05 bola de massagem — **GAP** → **Bola de massagem para pés e glúteos** (equipamento `massage_ball` existe sem exercícios).
- REC-08 arrefecimento pós-força — **GAP** → **Arrefecimento pós-treino de força** (rotina guiada).
- REC-09 arrefecimento pós-artes marciais — **GAP** → **Arrefecimento pós-artes marciais** (rotina guiada).
- AQU-02 aquecimento dinâmico geral — **GAP** → **Aquecimento dinâmico geral** (rotina guiada sem equipamento).

## Resumo das decisões

### Novos exercícios a adicionar (38)

| # | Exercício | Grupo | Slot | Justificação curta |
|---|-----------|-------|------|--------------------|
| 1 | Elevação no plano da omoplata | Ombros | OMB-04 | Único slot da coifa sem exercício dedicado (supraespinhoso) |
| 2 | Isometria cervical posterior leve | Pescoço | PES-02 | Extensão cervical em falta (há frontal e lateral) |
| 3 | Lenhador no cabo | Core | COR-05 | Rotação com carga em pé inexistente no ginásio |
| 4 | Prancha com toque no ombro | Core | COR-02 | Anti-rotação pura sem equipamento |
| 5 | Clamshell | Pernas | GLU-03 | Rotadores externos da anca sem exercício de força |
| 6 | Curl nórdico assistido | Pernas | PER-04 | Isquiotibiais excêntrico sem máquina (prevenção) |
| 7 | Peso morto unilateral com halteres | Pernas | PER-05 | Dobradiça unilateral/equilíbrio em falta |
| 8 | Remo ergómetro ritmo contínuo | Cardio | CAR-05 | Máquina `rower` existe sem exercícios |
| 9 | Remo ergómetro intervalos | Cardio | CAR-05 | Variante intervalada do remo |
| 10 | Stepper / escadas ritmo contínuo | Cardio | CAR-06 | Máquina `stepper` existe sem exercícios |
| 11 | Stepper / escadas intervalos | Cardio | CAR-06 | Variante intervalada do stepper |
| 12 | Subida de escadas no exterior | Cardio | CAR-06 | Versão exterior de escadas |
| 13 | Air bike ritmo contínuo | Cardio | CAR-07 | Máquina `air_bike` existe sem exercícios |
| 14 | Air bike intervalos | Cardio | CAR-07 | Variante intervalada da air bike |
| 15 | Shadow boxing leve | Cardio | CAR-10 | Pedido explícito; cardio de coordenação sem equipamento |
| 16 | Shuttle runs / corrida vaivém | Cardio | CAR-11 | Pedido explícito; mudança de direção |
| 17 | Alongamento PNF de isquiotibiais | Mobilidade | ELA-03 | Não existe nenhum alongamento PNF |
| 18 | Alongamento PNF de peitoral na parede | Mobilidade | ELA-03 | PNF de membro superior |
| 19 | Alongamento de flexores da anca em afundo | Mobilidade | MOB-07 | Zona sem alongamento dedicado |
| 20 | Alongamento borboleta de adutores | Mobilidade | MOB-08 | Adutores sem alongamento dedicado |
| 21 | Alongamento dinâmico global | Mobilidade | MOB-13 | Aquecimento dinâmico completo |
| 22 | Alongamento de tríceps atrás da cabeça | Mobilidade | ELA-04 | Tríceps/ombro sem alongamento |
| 23 | Cobra suave no chão | Mobilidade | MOB-05 | Extensão de coluna em falta |
| 24 | Treino de bases (dachi) | Karate | KAR-04 | Checklist do utilizador: bases |
| 25 | Bloqueios técnicos (uke) | Karate | KAR-09 | Checklist do utilizador: bloqueios |
| 26 | Esquivas e tai-sabaki | Karate | KAR-10 | Checklist do utilizador: esquivas |
| 27 | Joelhadas técnicas | Karate | KAR-11 | Checklist do utilizador: joelhadas |
| 28 | Trabalho leve ao saco | Karate | KAR-13 | Drill ao saco, marcado como tal (usa equipamento `heavy_bag` existente) |
| 29 | Rolamentos de solo | Jiu-Jitsu | JJ-05 | Checklist do utilizador: rolls |
| 30 | Breakfalls (ukemi) | Jiu-Jitsu | JJ-06 | Checklist do utilizador: breakfalls |
| 31 | Inversão granby com apoio | Jiu-Jitsu | JJ-07 | Checklist do utilizador: inversões |
| 32 | Respiração nasal lenta | Mobilidade | REC-02 | Pedido explícito |
| 33 | Foam roller para pernas | Mobilidade | REC-03 | Equipamento `foam_roller` existe sem exercícios |
| 34 | Foam roller para costas | Mobilidade | REC-04 | Idem, zona dorsal |
| 35 | Bola de massagem para pés e glúteos | Mobilidade | REC-05 | Equipamento `massage_ball` existe sem exercícios |
| 36 | Arrefecimento pós-treino de força | Mobilidade | REC-08 | Cooldown por modalidade em falta |
| 37 | Arrefecimento pós-artes marciais | Mobilidade | REC-09 | Cooldown por modalidade em falta |
| 38 | Aquecimento dinâmico geral | Mobilidade | AQU-02 | Rotina de aquecimento sem equipamento em falta |

Total final previsto: **315 + 38 = 353 exercícios**.

### Correções a exercícios existentes (sem remoções)

1. **E278 Mobilidade de ombro com cabo de vassoura** — integrar no filtro de mobilidade de ombros (hoje não aparece em nenhum filtro).
2. **E298 Rotação externa da anca no chão** — integrar nos filtros de mobilidade de anca/glúteos (hoje não aparece em nenhum filtro).
3. **47 exercícios com muletas de texto** ("conforme a variação", "indicada pela variação", "variação escolhida") — substituir por instrução direta (lista no inventário FASE 1).
4. **Prancha lateral (E138)** — passos herdados da prancha frontal ("em linha da cabeça aos calcanhares" duplicado, "olhando para o chão" deitado de lado); reescrever passos específicos.

### Exercícios a remover

Nenhum. Não foi encontrada justificação técnica forte para remover exercícios;
os quase-duplicados identificados no inventário são variações intencionais de
equipamento/posição, cada uma com texto próprio.

### Novos equipamentos

Nenhum: todo o equipamento necessário já existe no catálogo de equipamentos
(`heavy_bag` "Saco de pancada", `foam_roller`, `massage_ball`, `rower`,
`stepper`, `air_bike`). O que falta são exercícios que os usem e filtros que
os mostrem.
