# EveFit Tracker v0.9.2

Aplicacao Flutter local-first para acompanhar evolucao fisica, treinos, dados corporais, fotos de progresso e objetivos.

## Estado atual

- MVP Android implementado.
- SQLite local sem perfil pessoal pré-criado.
- Navegacao com 5 separadores: Dashboard, Treinos, Dados, Fotos e Objetivos.
- Formulario Dados para registar balanca, composicao corporal, medidas, dobras cutaneas e notas.
- Graficos simples com `fl_chart`.
- Exportacao CSV simples.
- Release pública atual: v0.9.2.
- Aba Medidas renomeada para Dados.
- Dados de balanca e composicao corporal expandidos.
- IMC calculado, idade/altura no perfil e racios cintura/anca e cintura/altura preparados.
- Dobras cutaneas opcionais em seccao propria.
- Locais de treino com multipla escolha.
- Objetivos com formulario mais simples e modo avancado opcional.
- Filtros especificos para Passadeira, Bicicleta, Eliptica, Karate e Jiu-Jitsu.
- Onboarding inicial para novos utilizadores.
- Filtro de exercícios por local de treino e equipamento disponível.
- Dashboard editável com edição em rascunho e gravação explícita.
- Objetivos com progresso, periodicidade e milestones.
- Dashboard editavel por perfil com metricas configuraveis.
- Tipos de treino e templates personalizados.
- Grupos musculares e catalogo de exercicios expandidos com descricao tecnica.
- Medidas corporais expandidas e objetivos preparados para progresso por metrica.
- Error handling em todos os ecrãs com FutureBuilder (mensagem de erro + botão de retry).
- Futures cacheados em initState para evitar queries desnecessárias à base de dados.
- Proteção contra brute-force do PIN: bloqueio de 1 minuto após 5 tentativas falhadas.
- Catálogo reorganizado: duplicados removidos, novo grupo Lombar, hierarquia corrigida.
- 20+ músculos adicionados ao sistema de filtros de treino.

## Stack

- Flutter / Dart
- SQLite com `sqflite`
- `path_provider`, `image_picker`, `fl_chart`, `intl`, `csv`

## Validacao feita

```powershell
flutter analyze
flutter test
flutter build apk --release --build-name 0.9.2
```

Android/iOS podem exigir um `--build-number` técnico crescente. Esse número
não altera a versão pública, o nome da release nem a identificação da app,
que permanecem `0.9.2`/`v0.9.2`.

## Package Android

`com.sandro.evefittracker`

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
