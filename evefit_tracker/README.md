# EveFit Tracker

Aplicacao Flutter local-first para acompanhar evolucao fisica, treinos, dados corporais, fotos de progresso e objetivos.

## Estado atual

- MVP Android implementado.
- SQLite local sem perfil pessoal pré-criado.
- Navegacao com 5 separadores: Dashboard, Treinos, Dados, Fotos e Objetivos.
- Formulario Dados para registar balanca, composicao corporal, medidas, dobras cutaneas e notas.
- Graficos simples com `fl_chart`.
- Exportacao CSV simples.
- APK release v0.5.3 gerado localmente em `build/app/outputs/flutter-apk/app-release.apk`.
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

## Stack

- Flutter / Dart
- SQLite com `sqflite`
- `path_provider`, `image_picker`, `fl_chart`, `intl`, `csv`

## Validacao feita

```powershell
flutter analyze
flutter test
flutter build apk --release
```

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
