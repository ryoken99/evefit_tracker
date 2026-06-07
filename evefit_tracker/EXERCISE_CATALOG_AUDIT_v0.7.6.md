# EveFit Tracker - Exercise Catalog Audit v0.7.6

Data: 2026-06-07
Branch: codex/v0.7.6-exercise-catalog

## Ficheiros auditados

- `lib/database/seed_data.dart`
- `lib/database/app_database.dart`
- `lib/services/training_architecture.dart`
- `lib/services/exercise_filter_service.dart`
- `lib/services/training_flow.dart`
- `lib/screens/workout_detail_screen.dart`
- `test/v076_exercise_catalog_quality_test.dart`

## Resumo

O catálogo foi revisto com foco exclusivo em exercícios, metadata, filtros e explicações.

Estado inicial encontrado:

- `Supino com halteres` aparecia em `Musculação - Braços completo` porque as tags anatómicas usavam músculos secundários.
- `Mobilidade / elasticidade - Glúteos` e `Mobilidade / elasticidade - Posterior de coxa` podiam ficar sem exercícios.
- O catálogo tinha poucas variações de mobilidade sem equipamento.
- `Encolhimento de ombros` tinha apenas variações com halteres/barra; faltava máquina.
- A UI mostrava placeholder quando campos como secundários estavam vazios.
- Os passos de execução tinham fallback genérico proibido.

## Tabela de auditoria

| ID | Nome | Tipo | Região | Grupo | Subzona | Músculo/foco principal | Secundários | Equipamento | Está correto? | Problema encontrado | Correção feita |
|---|---|---|---|---|---|---|---|---|---|---|---|
| CAT-001 | Supino com halteres | Musculação | Parte superior | Peito | Peito médio/completo | Peito | Tríceps, ombros | Halteres | CORRIGIDO | Entrava em Braços completo por causa de secundários | `tagsForExercise` passou a mapear musculação por foco primário |
| CAT-002 | Aberturas com halteres | Musculação | Parte superior | Peito | Peito médio/completo | Peito | Ombros | Halteres | CORRIGIDO | Podia herdar tags erradas quando secundários coincidiam | Mantido fora de Braços por filtro primário |
| CAT-003 | Flexões | Musculação | Parte superior | Peito | Peito médio | Peito | Tríceps, ombros | Peso corporal | CORRETO | Secundários não devem colocar em Bíceps/Tríceps | Confirmado por testes |
| CAT-004 | Flexões fechadas | Musculação | Parte superior | Braços | Braço | Tríceps | Peito, ombros | Peso corporal | CORRETO | Precisa aparecer em Tríceps peso corporal | Teste criado e passou |
| CAT-005 | Flexões diamante | Musculação | Parte superior | Braços | Braço | Tríceps | Peito, ombros | Peso corporal | CORRIGIDO | Tinha sido adicionada como Peito e Tríceps | Mantida como variação de tríceps no catálogo |
| CAT-006 | Curl com halteres | Musculação | Parte superior | Braços | Braço | Bíceps braquial | Braquial, braquiorradial | Halteres | CORRETO | Precisava continuar a aparecer em Bíceps com halteres | Teste criado e passou |
| CAT-007 | Curl alternado | Musculação | Parte superior | Braços | Braço | Bíceps braquial | Braquial, antebraço | Halteres | CORRETO | Cobertura de bíceps com halteres | Mantido |
| CAT-008 | Curl martelo | Musculação | Parte superior | Braços | Braço | Braquial/braquiorradial | Bíceps | Halteres | CORRETO | Deve ser relacionado, não peito/tríceps | Mantido em braços |
| CAT-009 | Pronação com halter | Musculação | Parte superior | Antebraço/Pega | Punho | Pronadores | Punho, pega | Halteres | CORRETO | Deve aparecer em Braços completo como antebraço relacionado | Confirmado por teste |
| CAT-010 | Supino fechado | Musculação | Parte superior | Braços | Braço | Tríceps | Peito, ombros | Barra, banco | CORRIGIDO | Nome contém supino e podia ser classificado como peito | Exceção adicionada ao classificador de peito |
| CAT-011 | Face pull com elástico | Musculação | Parte superior | Ombros | Deltoide posterior/escápula | Estabilidade escapular | Trapézio médio, rotadores externos | Elásticos | CORRETO | Não pode usar cabo/máquina | Teste garante `bands` e não `high_cable` |
| CAT-012 | Face pull no cabo | Musculação | Parte superior | Ombros/Trapézio | Escápula | Estabilidade escapular | Deltoide posterior, trapézio | Cabo alto / polia | CORRIGIDO | Equipamento genérico podia misturar variações | Equipamento explícito `Cabo alto / polia` |
| CAT-013 | Encolhimento de ombros com halteres | Musculação | Parte superior | Trapézio | Trapézio superior | Trapézio | Pega | Halteres | CORRETO | Equipamento precisa ser explícito | Confirmado |
| CAT-014 | Encolhimento de ombros com barra | Musculação | Parte superior | Trapézio | Trapézio superior | Trapézio | Pega | Barra | CORRETO | Equipamento precisa ser explícito | Confirmado |
| CAT-015 | Encolhimento de ombros na máquina | Musculação | Parte superior | Trapézio | Trapézio superior | Trapézio | Pega | Máquina | CORRIGIDO | Variante ausente | Adicionada |
| CAT-016 | Pike push-up | Musculação | Parte superior | Ombros | Deltoide anterior | Ombros | Tríceps, core | Peso corporal | CORRIGIDO | Exercício útil de ombros ausente | Adicionado e tagueado como ombros |
| CAT-017 | Good morning sem carga | Musculação/Mobilidade | Parte inferior | Posterior de coxa | Posterior | Posterior de coxa | Lombar, glúteos | Peso corporal | CORRIGIDO | Mobilidade/posterior precisava alternativa sem carga | Adicionado |
| CAT-018 | Alongamento glúteos | Mobilidade | Mobilidade e recuperação | Glúteos | Glúteos | Glúteos | Anca, piriforme | Peso corporal | CORRIGIDO | Filtro Glúteos podia ficar vazio | Tag `glute_mobility` adicionada |
| CAT-019 | Alongamento de glúteo sentado | Mobilidade | Mobilidade e recuperação | Glúteos | Glúteos | Glúteos | Anca, piriforme | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-020 | Alongamento figura 4 | Mobilidade | Mobilidade e recuperação | Glúteos | Glúteos | Glúteos/piriforme | Anca | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-021 | Pigeon stretch | Mobilidade | Mobilidade e recuperação | Glúteos | Glúteos | Glúteos/piriforme | Anca | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-022 | Alongamento piriforme | Mobilidade | Mobilidade e recuperação | Glúteos | Glúteos | Piriforme | Anca | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-023 | Mobilidade 90/90 | Mobilidade | Mobilidade e recuperação | Anca/Glúteos | Rotadores externos | Anca | Glúteos | Peso corporal | CORRIGIDO | Não era reconhecido como glúteos | Tag `glute_mobility` por nome |
| CAT-024 | Alongamento posterior de coxa | Mobilidade | Mobilidade e recuperação | Posterior de coxa | Posterior | Posterior de coxa | Gémeos, anca | Peso corporal | CORRIGIDO | Filtro Posterior podia ficar vazio | Tag `hamstring_mobility` adicionada |
| CAT-025 | Alongamento posterior sentado | Mobilidade | Mobilidade e recuperação | Posterior de coxa | Posterior | Posterior de coxa | Gémeos, anca | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-026 | Alongamento posterior em pé | Mobilidade | Mobilidade e recuperação | Posterior de coxa | Posterior | Posterior de coxa | Gémeos, anca | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-027 | Alongamento posterior com perna elevada | Mobilidade | Mobilidade e recuperação | Posterior de coxa | Posterior | Posterior de coxa | Gémeos, anca | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-028 | Mobilidade dinâmica de posterior | Mobilidade | Mobilidade e recuperação | Posterior de coxa | Posterior | Posterior de coxa | Anca | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-029 | Alongamento cervical leve | Mobilidade | Mobilidade e recuperação | Pescoço | Cervical | Pescoço | Trapézio, controlo cervical | Peso corporal | CORRIGIDO | Mostrava placeholder em secundários e passos genéricos | Secundários e passos específicos adicionados; UI sem placeholder |
| CAT-030 | Rotação cervical controlada | Mobilidade | Mobilidade e recuperação | Pescoço | Cervical | Pescoço | Trapézio, controlo cervical | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-031 | Inclinação lateral do pescoço | Mobilidade | Mobilidade e recuperação | Pescoço | Cervical | Pescoço | Trapézio, controlo cervical | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-032 | Chin tuck | Mobilidade | Mobilidade e recuperação | Pescoço | Cervical | Estabilizadores cervicais | Postura da cabeça | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-033 | Wall slides | Mobilidade/Ombros | Mobilidade e recuperação | Ombros | Escápula | Mobilidade de ombro | Serrátil, escápulas | Peso corporal | CORRIGIDO | Nome podia ficar sem tag de mobilidade quando duplicado | Tags de mobilidade por nome |
| CAT-034 | Círculos de ombro | Mobilidade | Mobilidade e recuperação | Ombros | Ombros | Mobilidade de ombro | Escápulas | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-035 | Alongamento posterior do ombro | Mobilidade | Mobilidade e recuperação | Ombros | Ombros | Ombro posterior | Escápulas | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-036 | Mobilidade de ombro com toalha | Mobilidade | Mobilidade e recuperação | Ombros | Ombros | Ombros | Peitoral, dorsal | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-037 | Alongamento peitoral na parede | Mobilidade | Mobilidade e recuperação | Peitoral | Peito | Peitoral | Ombros, escápulas | Peso corporal | CORRIGIDO | Cobertura peitoral insuficiente | Adicionado |
| CAT-038 | Alongamento peitoral no canto | Mobilidade | Mobilidade e recuperação | Peitoral | Peito | Peitoral | Ombros, escápulas | Peso corporal | CORRIGIDO | Cobertura peitoral insuficiente | Adicionado |
| CAT-039 | Rotação torácica no chão | Mobilidade | Mobilidade e recuperação | Coluna torácica | Torácica | Coluna torácica | Costas, escápulas | Peso corporal | CORRIGIDO | Cobertura torácica insuficiente | Adicionado |
| CAT-040 | Cat-cow | Mobilidade | Mobilidade e recuperação | Coluna torácica | Torácica | Coluna | Respiração, lombar | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-041 | Open book | Mobilidade | Mobilidade e recuperação | Coluna torácica | Torácica | Rotação torácica | Ombros, dorsal | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-042 | Alongamento quadríceps em pé | Mobilidade | Mobilidade e recuperação | Quadríceps | Coxa anterior | Quadríceps | Anca | Peso corporal | CORRIGIDO | Zona quadríceps sem opção dedicada | Adicionado |
| CAT-043 | Alongamento quadríceps de lado | Mobilidade | Mobilidade e recuperação | Quadríceps | Coxa anterior | Quadríceps | Anca | Peso corporal | CORRIGIDO | Zona quadríceps sem opção dedicada | Adicionado |
| CAT-044 | Mobilidade de tornozelo na parede | Mobilidade | Mobilidade e recuperação | Tornozelo | Tornozelo | Dorsiflexão | Gémeos, sóleo | Peso corporal | CORRIGIDO | Cobertura tornozelo insuficiente | Adicionado |
| CAT-045 | Círculos de tornozelo | Mobilidade | Mobilidade e recuperação | Tornozelo | Tornozelo | Mobilidade do tornozelo | Pé | Peso corporal | CORRIGIDO | Cobertura tornozelo insuficiente | Adicionado |
| CAT-046 | Mobilidade de punhos | Mobilidade | Mobilidade e recuperação | Punhos | Punho | Punhos | Antebraço | Peso corporal | CORRIGIDO | Zona punhos ausente na mobilidade | Adicionada |
| CAT-047 | Extensão de punhos no chão | Mobilidade | Mobilidade e recuperação | Punhos | Punho | Extensores/flexores do punho | Antebraço | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-048 | Flexão de punhos no chão | Mobilidade | Mobilidade e recuperação | Punhos | Punho | Flexores/extensores do punho | Antebraço | Peso corporal | CORRIGIDO | Exercício ausente | Adicionado |
| CAT-049 | Marcha no lugar | Cardio | Cardio | Sem equipamento | Sem equipamento | Cardio leve | Pernas, core | Peso corporal | CORRIGIDO | Cardio sem equipamento curto | Adicionado |
| CAT-050 | Jumping jacks | Cardio | Cardio | Sem equipamento | Sem equipamento | Cardio sem equipamento | Pernas, ombros | Peso corporal | CORRIGIDO | Cardio sem equipamento curto | Adicionado |
| CAT-051 | Burpees | Cardio | Cardio | Sem equipamento | HIIT | Cardio/HIIT | Core, pernas, peito | Peso corporal | CORRIGIDO | Cardio sem equipamento curto | Adicionado |
| CAT-052 | Skaters | Cardio | Cardio | Sem equipamento | Lateral | Cardio/coordenação | Glúteos, pernas | Peso corporal | CORRIGIDO | Cardio sem equipamento curto | Adicionado |
| CAT-053 | High knees | Cardio | Cardio | Sem equipamento | Intensidade | Cardio/coordenação | Core, flexores da anca | Peso corporal | CORRIGIDO | Cardio sem equipamento curto | Adicionado |
| CAT-054 | Circuito cardio peso corporal | Cardio | Cardio | Sem equipamento | Circuito | Cardio/HIIT | Corpo inteiro | Peso corporal | CORRIGIDO | Cardio sem equipamento curto | Adicionado |
| CAT-055 | Passadeira inclinação moderada | Cardio | Cardio | Passadeira | Resistência aeróbia | Passadeira | Gémeos, glúteos | Passadeira | CORRIGIDO | Faltava nome claro para resistência aeróbia | Adicionado |
| CAT-056 | Passadeira sprints | Cardio | Cardio | Passadeira | Intervalos | Sprints | Pernas, cardio | Passadeira | CORRIGIDO | Foco intervalos precisava opção curta | Adicionado |

## Cobertura preservada

Os grupos já existentes foram mantidos: Pescoço, Trapézio, Ombros, Peito, Costas, Bíceps, Tríceps, Antebraço/Pega, Core, Pernas, Cardio, Karate, Jiu-Jitsu e Mobilidade.

Os exercícios existentes que não aparecem na tabela como `CORRIGIDO` foram revistos contra os ficheiros acima e ficaram como `CORRETO` quando:

- tinham grupo principal coerente;
- tinham equipamento derivável por `_equipmentFor`;
- não dependiam de músculo secundário para aparecer no filtro;
- continuaram cobertos pelos testes históricos v0.5.1 a v0.7.5.

## Validação

- `flutter pub get`: OK
- `flutter analyze`: OK, sem issues
- `flutter test`: OK, 130 testes passados
- `flutter build apk --release`: OK
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- Tamanho confirmado: 54,444,817 bytes

## Limitações conhecidas

- O catálogo foi expandido para os exercícios úteis pedidos, mas ainda não tenta cobrir todos os exercícios possíveis.
- A app continua a guardar metadata do catálogo padrão em campos textuais; a v0.7.6 não refatorou o esquema relacional de `exercise_muscles`/`exercise_focus_map`.
