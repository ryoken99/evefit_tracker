# EveFit catalog quality standard

Este documento define a alfandega permanente dos catalogos EveFit. Qualquer exercicio novo ou alterado deve passar o quality gate antes de entrar na app.

## Campos obrigatorios

Cada entrada de catalogo precisa de:

- `canonical_id`, `exercise_key`, `context_key` e `catalog_entry_key`.
- `primary_type`, `secondary_types`, `contexts`, filtros e exclusoes quando aplicavel.
- Musculos ou zonas reais, equipamento compativel e locais compativeis.
- Descricao curta/longa compreensivel para iniciantes absolutos.
- Execucao passo a passo, respiracao, erros comuns, correcoes, cuidados, regressao, progressao e quando evitar/adaptar.

## Regras criticas

- Tipo de treino nao e musculo. `Ativacao`, `Aquecimento`, `Recuperacao` e `Prevencao` nao podem ser `muscleGroup`.
- Texto visivel nao pode conter tokens internos, `snake_case`, ingles solto ou frases gericas como "referencia tecnica", "zona trabalhada" ou "target pattern".
- Recuperacao nao pode recomendar HIIT, sprint, sparring ou intensidade maxima.
- Prevencao nao pode prometer prevenir lesoes.
- Exercicios de passadeira precisam de equipamento `treadmill` e nao podem aparecer como treino sem equipamento.
- Cenario importante de filtro nao pode ficar vazio por erro.

## Comando obrigatorio

```powershell
.\tool\run_quality_gate.ps1
```

O comando corre `flutter pub get`, `flutter analyze`, `flutter test -r compact` e `dart run tool/catalog_audit_report.dart --strict`.

