# v0.7.9 Exercise Coverage Design

## Goal

Consolidar a base de exercicios da EveFit Tracker para que os filtros "completo", o catalogo, as alternativas caseiras e as descricoes pedagogicas tenham cobertura verificavel e honesta.

## Scope

Esta versao atua no catalogo e nos servicos de metadata/filtro. A UI visual nao sera refeita. Dados locais existentes ficam preservados: novos exercicios sao adicionados ao seed e defaults existentes sao atualizados por migracao, sem apagar treinos, perfis, fotos ou medidas.

## Architecture

- `SeedData.exercisesByGroup` continua a ser a fonte de exercicios default.
- `ExerciseCatalogDetailService` continua a inferir equipamento, secundarios, descricao, passos, erros e seguranca.
- `TrainingArchitecture.tagsForExercise` continua a gerar tags anatomicas/modais usadas pelo filtro.
- `ExerciseFilterService` continua a aplicar selecao de treino + equipamento/local + foco hierarquico.
- Relatorios markdown explicam pesquisa, matriz e auditoria; testes automatizados verificam os pontos que podem regredir.

## Key Decisions

1. Nomes ambiguos deixam de ser a opcao principal do seed novo quando existe variante clara.
2. Exercicios legacy podem continuar em bases antigas para preservar historico, mas o catalogo novo passa a preferir variantes explicitas.
3. Alternativas caseiras entram como exercicios/equipamentos proprios com aviso de estabilidade, nao como "halteres" disfarçados.
4. A v0.7.9 aumenta cobertura real sem tentar prometer todos os exercicios possiveis do mundo.

## Testing

- Testes RED para cobertura de bracos completo com halteres, contagem minima e exclusao de peito/costas/pernas/cardio.
- Testes RED para completo em peito, costas, pernas, core, mobilidade, recuperacao, Karate/Jiu-Jitsu e cardio.
- Testes RED para descricoes de `Flexao classica` e `Agachamento com peso corporal`.
- Testes RED para equipamentos caseiros e nomes ambiguos.
- Suite completa Flutter obrigatoria antes do APK.

## Success Criteria

- Relatorios v0.7.9 existem e incluem numeros finais.
- `flutter pub get`, `flutter analyze`, `flutter test`, `flutter build apk --release` passam.
- APK release existe em `build/app/outputs/flutter-apk/app-release.apk`.
- Release GitHub `v0.7.9` existe com APK anexado.

