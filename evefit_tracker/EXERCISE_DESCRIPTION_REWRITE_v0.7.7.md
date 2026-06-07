# EveFit Tracker - Exercise Description Rewrite v0.7.7

Data: 2026-06-07

## Resumo

- Total de exercícios únicos auditados: 269
- Total de descrições reescritas/revalidadas: 269
- Total de metadata corrigida: 39
- Placeholders removidos/verificados: 269 exercícios sem placeholder
- Exercícios divididos em variantes: 4 nomes antigos ambíguos -> 11 variantes específicas
- Testes criados: 4
- Testes passados na execução completa: 134

## O que mudou

- Criado `lib/services/exercise_catalog_detail_service.dart` como fonte única de equipamento, secundários, descrição, passos, erros comuns e segurança.
- `AppDatabase` passou a usar o novo serviço ao semear e atualizar exercícios padrão.
- Migração v0.7.7 (`version: 12` da base local) semeia variantes novas e esconde nomes antigos ambíguos sem apagar histórico.
- `SeedData` deixou de usar nomes ambíguos para aberturas inclinadas, supino declinado, dips para peito e extensão francesa.
- `TrainingArchitecture` reconhece paralelas, banco inclinado e banco declinado.
- O teste global foi reforçado para impedir que exercícios claramente equipados voltem a aparecer como `Peso corporal`.
- Descrições, erros comuns e segurança deixaram de usar fallback genérico para os exercícios visíveis no catálogo.

## Antes/depois

| Exercício | Antes | Depois |
|---|---|---|
| Alongamento cervical leve | Texto curto e com risco de secundários vazios/placeholder | Explica sentado/em pé, coluna direita, ombros relaxados, inclinação lenta, 15 a 30 segundos, respiração e sinais para parar |
| Aberturas inclinadas | Nome ambíguo e podia receber equipamento errado | Dividido em halteres + banco inclinado, cabo/polia e elástico |
| Dips para peito | Equipamento pouco claro | Dividido em paralelas e máquina assistida, com instrução de tronco inclinado e ombros afastados das orelhas |
| Supino declinado | Nome ambíguo e podia ser interpretado como peso corporal | Dividido em halteres + banco declinado, barra + banco declinado e máquina |
| Extensão francesa | Nome genérico | Dividido em halter, barra EZ e cabo, com cotovelos, descida atrás da cabeça e lombar |
| Curl com halteres | Descrição melhor que antes, mas incompleta | Explica pés, halteres, palmas, cotovelos junto ao tronco, punhos neutros, subida, descida e respiração |
| Elevações de ombro e curls genéricos | Alguns nomes genéricos podiam cair em `Peso corporal` | Metadata ajustada para halteres, barra, paralelas, banco/apoio, cabo ou elásticos conforme o movimento |

## Testes

- `exercise_descriptions_are_specific_test.dart`: auditoria global do catálogo.
- `flutter test`: 134 testes passados.
- `flutter analyze`: sem issues na última execução validada.

## Limitações conhecidas

- O serviço gera texto específico por exercício/família de movimento e contém casos manuais para exercícios críticos. A próxima melhoria estrutural seria guardar uma ficha editorial totalmente estática por exercício em dados versionados.
