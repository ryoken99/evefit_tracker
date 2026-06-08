# v0.7.12 Quality Gates Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Criar quality gates permanentes que fazem `flutter test` falhar quando o catalogo, descricoes, seguranca, filtros ou combinacoes de treino ficam incoerentes.

**Architecture:** A v0.7.12 adiciona uma camada reutilizavel em `lib/services/catalog_quality_gate_service.dart`. Os testes usam essa camada para validar as 305 entradas e as matrizes de filtros; `tool/catalog_quality_gate_report_v0712.dart` usa a mesma fonte para gerar os relatorios obrigatorios.

**Tech Stack:** Flutter/Dart, `flutter_test`, services Dart puros, relatorios Markdown gerados por `dart run`.

---

### Task 1: Baseline e RED dos quality gates de texto

**Files:**
- Create: `test/catalog/catalog_integrity_test.dart`
- Create: `test/catalog/exercise_pedagogy_quality_test.dart`
- Create: `test/catalog/movement_family_requirements_test.dart`
- Create: `test/catalog/equipment_description_consistency_test.dart`
- Create: `test/catalog/cardio_specificity_test.dart`
- Create: `test/catalog/safety_risk_quality_test.dart`
- Modify later: `lib/services/exercise_catalog_context_service.dart`

- [x] **Step 1: Run baseline**

Run:

```powershell
& 'C:\tools\flutter\bin\flutter.bat' test
```

Expected: `All tests passed!` with the pre-v0.7.12 count.

- [ ] **Step 2: Write RED text tests**

Create tests that iterate `ExerciseCatalogContextService.entries` and fail when any entry has empty identity, empty description fields, forbidden phrases such as `no contexto`, `equipamento indicado`, `move a articulacao principal`, mixed cardio modality language, too few steps, generic safety, or missing movement-family cues.

- [ ] **Step 3: Verify RED**

Run:

```powershell
& 'C:\tools\flutter\bin\flutter.bat' test test\catalog
```

Expected: FAIL on current generated v0.7.11 wording, especially generic description/cardio phrases.

---

### Task 2: Implement reusable quality gate service

**Files:**
- Create: `lib/services/catalog_quality_gate_service.dart`
- Modify tests from Task 1 to use the service

- [ ] **Step 1: Add validation result types**

Create Dart classes:

```dart
class QualityGateFailure {
  const QualityGateFailure({
    required this.area,
    required this.entryId,
    required this.name,
    required this.message,
  });
  final String area;
  final String entryId;
  final String name;
  final String message;
}
```

Add methods for catalog integrity, pedagogy, movement family, equipment-text consistency, cardio specificity, safety quality, duplicate context clarity, muscle metadata consistency, and filter matrices.

- [ ] **Step 2: Make tests assert no failures**

Each test should call the relevant method and use:

```dart
expect(failures, isEmpty, reason: failures.take(20).map((f) => f.toString()).join('\n'));
```

- [ ] **Step 3: Keep gates strict but objective**

Use deterministic string/metadata checks. Avoid hiding failures with broad whitelists. Any exception must include a named exercise and rationale in the report.

---

### Task 3: Correct generated catalog explanations

**Files:**
- Modify: `lib/services/exercise_catalog_context_service.dart`

- [ ] **Step 1: Replace prohibited generic wording**

Remove final text containing the forbidden/suspicious phrases from the generated default explanations. In particular, remove `no contexto`, `equipamento indicado`, `passadas, pedaladas ou saltos`, `velocidade, inclinacao, resistencia ou cadencia`, `dobrar e estender o cotovelo`, and `mover a articulacao principal`.

- [ ] **Step 2: Generate modality-specific steps**

Split cardio steps by exercise/equipment:

```dart
if treadmill: mention passadeira, velocidade, inclinacao when relevant, passada, duracao, intensidade.
if bike: mention selim, resistencia, cadencia, pedalar, duracao.
if jump rope: mention corda, pegas, punhos, saltos baixos, aterragem.
if elliptical: mention eliptica, apoios, resistencia, cadencia, duracao.
```

- [ ] **Step 3: Generate family-specific strength steps**

Use name/equipment cues for curls, triceps extensions, presses/supinos, rows/pulls, squats, hinges, bodyweight core, mobility, and martial arts.

- [ ] **Step 4: Re-run RED tests until GREEN**

Run the new catalog tests, then the full suite.

---

### Task 4: Add filter/combinatorics quality gates

**Files:**
- Create: `test/filters/anatomy_filter_matrix_test.dart`
- Create: `test/filters/equipment_filter_matrix_test.dart`
- Create: `test/filters/training_type_filter_matrix_test.dart`
- Create: `test/filters/full_filter_combinatorics_test.dart`
- Create: `test/filters/show_all_exercises_test.dart`
- Create: `test/catalog/duplicate_context_clarity_test.dart`
- Create: `test/catalog/muscle_metadata_consistency_test.dart`
- Create: `test/regression/manual_findings_regression_test.dart`
- Modify if required: `lib/services/exercise_filter_service.dart`
- Modify if required: `lib/services/training_architecture.dart`

- [ ] **Step 1: Generate valid UI combinations**

Use `TrainingFlow` and explicit representative cases to cover strength, cardio, martial arts, mobility, recovery and custom flows. Include every required manual regression case.

- [ ] **Step 2: Assert no branch leakage**

For each combination, verify returned exercises match `TrainingArchitecture.tagsForExercise`, profile equipment, and expected branch behavior.

- [ ] **Step 3: Assert show-all behavior**

When `showAllExercises` is true, verify unavailable items carry a clear unavailable reason and still have complete metadata.

- [ ] **Step 4: Correct filter/tag regressions**

Only change `exercise_filter_service.dart` or `training_architecture.dart` when a quality gate exposes real leakage or missing child aggregation.

---

### Task 5: Reports, version, validation and release

**Files:**
- Create: `tool/catalog_quality_gate_report_v0712.dart`
- Create generated: `QUALITY_GATE_REPORT_v0.7.12.md`
- Create generated: `FILTER_COMBINATORICS_MATRIX_v0.7.12.md`
- Create generated: `EXERCISE_TEXT_QUALITY_MATRIX_v0.7.12.md`
- Modify: `pubspec.yaml`
- Modify: `lib/screens/settings_screen.dart`

- [ ] **Step 1: Generate reports from the same service as tests**

The reports must include totals for catalog entries, unique exercises, filter combinations tested, equipment/profile simulations, description/execution/safety validation, failures found, failures corrected and failures remaining.

- [ ] **Step 2: Update version**

Set:

```yaml
version: 0.7.12+20
```

Set UI label to `v0.7.12` and update button text to `Ver atualizações v0.7.12`.

- [ ] **Step 3: Verify**

Run:

```powershell
& 'C:\tools\flutter\bin\flutter.bat' pub get
& 'C:\tools\flutter\bin\flutter.bat' analyze
& 'C:\tools\flutter\bin\flutter.bat' test
& 'C:\tools\flutter\bin\flutter.bat' build apk --release
Get-ChildItem build\app\outputs\flutter-apk\
```

- [ ] **Step 4: Commit, push, release**

Commit message:

```text
Release v0.7.12 catalog quality gates
```

Create GitHub release `v0.7.12` with `build/app/outputs/flutter-apk/app-release.apk`.

---

### Self-Review

- Spec coverage: covers catalog integrity, pedagogy, movement families, anatomy filters, equipment filters, training type filters, combinatorics, show-all, duplicate contexts, muscle metadata, equipment-description consistency, cardio specificity, safety risk, manual regressions, reports, version, APK, release.
- Placeholder scan: no `TBD`, no unspecified test steps, no unbounded refactor.
- Type consistency: tests and reports use `CatalogQualityGateService` and existing `ExerciseCatalogContextService`, `TrainingFlow`, `ExerciseFilterService`, `TrainingArchitecture`.
