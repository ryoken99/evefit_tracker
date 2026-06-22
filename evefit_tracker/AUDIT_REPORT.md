# AUDIT_REPORT — v0.8.0

Data: 2026-06-22
Repositório: `ryoken99/evefit_tracker`  
Branch: `feature/v0.8.0-profile-equipment-catalog-integrity`  
Estado: implementação concluída; verificação final registada no fim deste relatório.

## Linha de base

- Repositório confirmado por `git remote get-url origin`: `https://github.com/ryoken99/evefit_tracker.git`.
- Branch confirmada por `git branch --show-current`; a `main` não foi alterada.
- Primeira tentativa de `flutter analyze`: falhou porque `flutter` não estava no `PATH`. Erro: `flutter : The term 'flutter' is not recognized...`. Classificação: ambiente.
- Repetição com `C:\tools\flutter\bin\flutter.bat analyze`: `No issues found!`.
- Teste inicial com `C:\tools\flutter\bin\flutter.bat test`: 208 testes, `All tests passed!`.

## Bugs encontrados e corrigidos

| ID | Estado | Correção |
|---|---|---|
| V080-01 | FIXED | Goals e milestones protegidos pelo `profile_id` ativo, incluindo leitura, criação, alteração, conclusão e eliminação. |
| V080-02 | FIXED | Exportação inclui apenas goals e milestones do perfil ativo. |
| V080-03 | FIXED | `updateProfileEquipment` usa as localizações reais do perfil ativo. |
| V080-04 | FIXED | `bodyweight` é sempre uma capacidade disponível. |
| V080-05 | FIXED | Equipamento canónico centralizado; `jump_rope` tem uma identidade única. |
| V080-06 | FIXED | Filtros anatómicos usam taxonomia persistida antes de qualquer fallback legado. |
| V080-07 | FIXED | Exercícios têm regiões, grupos, subgrupos, músculo principal/secundários, equipamento, padrão, dificuldade, força, lateralidade e objetivos. |
| V080-08 | FIXED | Templates usam `catalogEntryKey`/chaves estáveis; nome só é fallback legado quando não é ambíguo. |
| V080-09 | FIXED | Customs pertencem ao perfil; defaults globais são ocultados por perfil sem delete destrutivo. |
| V080-10 | FIXED | Migração idempotente normaliza mojibake conhecido sem apagar ou reidentificar dados; seed legado de produção também foi normalizado. |
| V080-11 | FIXED | Tentativas de PIN e `locked_until` persistem em `profile_security` por perfil. |
| V080-12 | FIXED | `workouts()` carrega sets e exercícios em duas queries batch e agrupa por `workout_id`. |
| V080-13 | FIXED | Altura ausente/zero apresenta `altura por definir`, nunca `0 cm`. |
| V080-14 | FIXED | `updateDashboardWidgets` grava todo o dashboard numa única transação e faz rollback em ID inválido. |
| V080-15 | FIXED | Chaves antigas mostram `Foco antigo`, `Equipamento removido` ou `Métrica removida`, nunca o primeiro item. |
| V080-16 | FIXED | Versão pública, Settings, README, workflow, changelog e release notes apontam para v0.8.0. |
| V080-17 | FIXED | Catálogo expandido para 314 entradas e contrato pedagógico completo aplicado a todas. |

## Testes adicionados na v0.8.0

- Isolamento de goals/milestones e exportação entre dois perfis.
- Isolamento de equipamento/local e matrizes casa, ginásio, exterior e dojo.
- Taxonomia anatómica completa e falsos positivos com nomes deliberadamente enganadores.
- Identidade estável de templates e propriedade de exercícios custom/default.
- Migração aditiva, normalização de encoding e preservação de IDs/relações.
- Integridade pedagógica das 314 entradas, 11 passos mínimos e ausência de descrições/execuções duplicadas.
- Expansão de pé, tornozelo, flexores da anca, adutores, abdutores e quadríceps.
- Dashboard transacional, altura desconhecida, chaves desconhecidas e PIN persistente.
- Metadados públicos da versão v0.8.0.

## Bugs adiados

Nenhum bug funcional identificado nesta auditoria ficou aberto. O refactor estrutural completo do `AppDatabase` foi deliberadamente adiado por ser dívida técnica e não uma correção segura para esta release.

## Riscos de regressão restantes

- A taxonomia de exercícios custom antigos continua a usar fallback legado quando não possui metadados explícitos.
- Recomendações de exercício não substituem avaliação clínica; dor, lesão e limitações individuais exigem adaptação profissional.
- Os relatórios históricos de releases anteriores foram preservados como evidência; não são superfícies públicas nem identificação da release atual.
- O catálogo representa opções reais e úteis para cada grupo pedido, não todas as variações possíveis ou nomes comerciais existentes.

## Dívida técnica e plano futuro

`AppDatabase` ainda concentra schema, migrações, seed e repositórios. Próxima extração recomendada:

1. migradores versionados separados;
2. `ProfileRepository`, `GoalRepository`, `WorkoutRepository` e `ExerciseRepository`;
3. contexto explícito e imutável do perfil ativo;
4. métricas de queries/tempo com bases grandes;
5. revisão editorial clínica periódica do catálogo.

## Preservação de dados

- Nenhuma tabela ou dado do utilizador é apagado pela migração.
- IDs de exercícios existentes e relações de treinos/templates são preservados.
- Defaults novos são inseridos/atualizados por identidade estável.
- Ocultação de exercício default é local ao perfil.

## Verificação final

- `C:\tools\flutter\bin\flutter.bat analyze`: `No issues found! (ran in 2.8s)`.
- `C:\tools\flutter\bin\flutter.bat test`: 250 testes, `All tests passed!`, zero falhas.
- A suite completa detetou durante a implementação duas regressões de especificidade cardio, três pares com texto demasiado semelhante e dois cues ausentes no Curl 21; as causas foram corrigidas no gerador e a suite completa foi repetida com sucesso.
