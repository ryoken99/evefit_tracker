# DESCRIPTION_PATTERN_FIXES_v0.7.8

Versao auditada: v0.7.8

## Objetivo

Remover ou bloquear padroes de descricao demasiado genericos que ainda podiam aparecer em exercicios visiveis.

## Padroes proibidos verificados

Total de frases/padroes genericos bloqueados/removidos do catalogo visivel: 12

| Padrao | Estado |
|---|---|
| Ajusta pes, maos e carga | BLOQUEADO |
| Faz o movimento principal | BLOQUEADO |
| Volta a posicao inicial com a mesma trajetoria | BLOQUEADO |
| Comeca leve, progride gradualmente | BLOQUEADO |
| Interrompe o exercicio se surgir dor aguda, tontura ou perda de controlo tecnico | BLOQUEADO |
| Movimento lento e previsivel | BLOQUEADO |
| Amplitude controlada | BLOQUEADO |
| Usar pressa | BLOQUEADO |
| Compensar com outra zona do corpo | BLOQUEADO |
| Resistencia que muda a trajetoria | BLOQUEADO |
| Mantem boa postura | BLOQUEADO |
| Executa com boa tecnica | BLOQUEADO |

## Correcoes diretas

| Ficheiro | Correcao |
|---|---|
| `lib/services/exercise_catalog_detail_service.dart` | Substituida instrucao generica de progressao em exercicios com barra por uma indicacao concreta: usar barra vazia/carga que permita repetir a trajetoria sem perder punhos, ombros e lombar. |
| `lib/services/exercise_catalog_detail_service.dart` | Reescritas as descricoes especificas de `Supino com barra`, `Passadeira aquecimento`, `Passadeira cooldown` e `Puxada alta pega neutra`. |
| `test/v078_exercise_pedagogy_test.dart` | Criado teste que percorre todos os exercicios unicos do catalogo e falha se algum padrao proibido aparecer. |

## Verificacoes executadas

Comando de varredura em codigo de producao:

`rg -n "Comeca leve|Amplitude controlada|Movimento lento|Usar pressa|Faz o movimento principal|Mantem boa postura|Executa com boa tecnica|Descricao ainda incompleta" lib`

Resultado: sem ocorrencias em `lib`.

Teste automatico:

`flutter test test/v078_complete_aggregation_test.dart test/v078_exercise_pedagogy_test.dart` -> 12 testes passaram.

## Estado final

O catalogo visivel fica protegido por teste automatizado contra os padroes genericos acima. Qualquer reintroducao desses textos em descricao, execucao, erros comuns ou seguranca deve quebrar `v078_exercise_pedagogy_test.dart`.

