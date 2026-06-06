# EveFit Tracker

Aplicacao Flutter local-first para acompanhar evolucao fisica, treinos, medidas corporais, fotos de progresso e objetivos.

## Estado atual

- MVP Android implementado.
- SQLite local com seed inicial do Sandro.
- Navegacao com 5 separadores: Dashboard, Treinos, Medidas, Fotos e Objetivos.
- Formularios para adicionar medidas, criar treino basico com exercicio/serie e guardar fotos.
- Graficos simples com `fl_chart`.
- Exportacao CSV simples.
- APK release v0.3.0 gerado localmente em `build/app/outputs/flutter-apk/app-release.apk`.

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
