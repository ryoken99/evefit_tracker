# EveFit Tracker v1.1.5

Aplicacao Flutter local-first para acompanhar evolucao fisica, treinos, dados corporais, fotos de progresso e objetivos.

## Estado atual

- MVP Android implementado.
- SQLite local sem perfil pessoal pré-criado.
- Navegacao com 5 separadores: Dashboard, Treinos, Dados, Fotos e Objetivos.
- Formulario Dados para registar balanca, composicao corporal, medidas, dobras cutaneas e notas.
- Graficos simples com `fl_chart`.
- Exportacao CSV simples.
- Versão de release: v1.1.5 - Primeiros Exercícios Canónicos (`1.1.5+7`).
- Pesquisa canónica hierárquica com 7 contextos explícitos, 8 capacidades, 35 conceitos globais e 40 relações capacidade-conceito.
- Matriz canónica: 280 percursos, 261 compatíveis, 19 incompatíveis, 591 intenções globais e 771 ligações de intenção por percurso.
- Fluxo ativo: Contexto → Capacidade → Conceito → Intenção → Exercícios.
- A Wave1 disponibiliza 49 exercícios canónicos não musculares em 54 percursos aprovados, sem os adicionar diretamente aos treinos.
- A query é progressiva e contém apenas `usage_context`, `capability_root`, `training_concept` e `training_intention`; não contém `exercise_ids`, IDs legacy nem relações de propriedade.
- As 693 identidades e 792 ocorrências históricas foram auditadas, mas não são dados funcionais em runtime.
- Catálogo legacy fora do runtime, com fontes preservadas em arquivo histórico.
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

## Validacao da v1.1.5

```powershell
flutter pub get
dart format --set-exit-if-changed .
flutter analyze --no-fatal-infos
flutter test
flutter build apk --release
```

O Fast Gate funcional, o PR Gate funcional, os shards, Android smoke, full-app e
validação de instalação existente foram concluídos na fase funcional. A release
só é publicada depois de repetir os gates de release, a atualização
`1.1.3+5 → 1.1.5+7` e `1.1.4+6 → 1.1.5+7`, a inspeção da assinatura e a validação final em main.
O versionamento de release alvo é `1.1.5+7`: `1.1.5` é a versão pública e `7`
é o versionCode Android monotónico.

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
