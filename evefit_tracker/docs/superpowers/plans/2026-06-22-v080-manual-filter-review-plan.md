# v0.8.0 Manual Filter Review Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Correct persisted-catalog complete filters and profile capability matching, prove each reviewed combination with a manual matrix row and matching test, then publish Android build 82 to the existing v0.8.0 release.

**Architecture:** Complete-focus matching is canonical and declarative, evaluated before individual-muscle rejection. Equipment availability is delegated to a capability service that supports all-required dependencies and alternative capability groups. The manual matrix defines expected inclusions/exclusions and every automated regression test references a matrix ID.

**Tech Stack:** Flutter 3.44, Dart 3.12, sqflite/sqflite_common_ffi, flutter_test, Android Gradle build, Android Emulator/ADB, GitHub CLI.

---

## File map

- Create `MANUAL_FILTER_REVIEW.md`: manually adjudicated source-of-truth matrix and Android validation notes.
- Create `lib/services/exercise_capability_service.dart`: canonical capability expansion, requirements and missing-capability explanations.
- Modify `lib/services/equipment_catalog_service.dart`: register floor/wall/support capabilities and location defaults.
- Modify `lib/services/exercise_filter_service.dart`: complete-focus resolver and capability-based availability.
- Modify `lib/screens/workout_detail_screen.dart`: precise empty-state and unavailable messages where needed.
- Create `test/v080/manual_filter_matrix_test.dart`: one named test for each corrective matrix row.
- Modify `test/v080/location_equipment_matrix_test.dart`: explicit profile capability expectations.

### Task 1: Reproduce the persisted-exercise defect

**Files:**
- Create: `MANUAL_FILTER_REVIEW.md`
- Create: `test/v080/manual_filter_matrix_test.dart`

- [ ] **Step 1: Record the first manually adjudicated rows**

Add `BW-CHEST-001`, `BW-ARMS-001`, `BW-CORE-001`, `BW-LEGS-001`, `BW-BACK-001`, and `BW-SHOULDERS-001`. Record representative inclusions, explicit equipment exclusions and the observed pre-fix state.

- [ ] **Step 2: Write the persisted-catalog regression test**

Build exercises with `ExerciseTaxonomyService.enrichCatalogExercise(entry)`, then assert that bodyweight `chest_complete` contains `Flexão clássica`, `Flexão com joelhos apoiados`, and `Flexão aberta`, while excluding supino/cable/machine entries.

```dart
test('BW-CHEST-001 persisted home bodyweight chest complete shows push-ups', () {
  final names = visibleNames(
    focus: 'chest_complete',
    group: 'chest',
    equipment: const {'bodyweight', 'floor', 'wall'},
  );
  expect(names, containsAll({'Flexão clássica', 'Flexão com joelhos apoiados', 'Flexão aberta'}));
  expect(names.any((name) => name.contains('Supino')), isFalse);
});
```

- [ ] **Step 3: Verify RED**

Run `flutter test --no-pub test/v080/manual_filter_matrix_test.dart`. Expected: `BW-CHEST-001` fails because the enriched exercises are rejected by `chest_complete`.

- [ ] **Step 4: Commit the reproduction and initial matrix**

Commit message: `test: reproduce persisted complete-filter failure`.

### Task 2: Implement canonical complete-focus aggregation

**Files:**
- Modify: `lib/services/exercise_filter_service.dart`
- Modify: `test/v080/manual_filter_matrix_test.dart`
- Modify: `MANUAL_FILTER_REVIEW.md`

- [ ] **Step 1: Add a declarative complete-focus map**

Define canonical allowed group/subgroup/muscle descendants for chest, arms, forearm, back, shoulders, traps, neck, core, legs, quadriceps, hamstrings, glutes and lower leg.

```dart
static const _completeFocusAliases = <String, Set<String>>{
  'chest_complete': {'chest', 'chest_primary'},
  'back_complete': {'back', 'back_width', 'back_thickness', 'low_back'},
  'shoulders_complete': {'shoulders', 'deltoids'},
  'core_complete': {'core_stability', 'core_general'},
  'legs_complete': {'legs', 'quadriceps', 'hamstrings', 'hips_glutes', 'adductors', 'abductors', 'calves'},
};
```

- [ ] **Step 2: Evaluate complete aliases before canonical-muscle rejection**

Add `_matchesCompleteFocus(tags, focus)` and call it before `exercise.primaryMuscleKey.isNotEmpty`. Remove the one-off `arms_complete` branch after equivalent coverage exists.

- [ ] **Step 3: Verify GREEN for BW-CHEST-001**

Run the targeted test. Expected: `BW-CHEST-001` passes.

- [ ] **Step 4: Add one explicit test per complete focus/profile row**

Add matrix IDs for bodyweight arms/core/legs/back/shoulders and gym complete focuses. Each test asserts named inclusions and named or category exclusions.

- [ ] **Step 5: Run targeted and existing hierarchy suites**

Run `flutter test --no-pub test/v080/manual_filter_matrix_test.dart test/v078_complete_aggregation_test.dart test/v0714_template_and_hierarchy_test.dart`.

- [ ] **Step 6: Commit**

Commit message: `fix: aggregate canonical complete filters`.

### Task 3: Correct profile capabilities and compound requirements

**Files:**
- Create: `lib/services/exercise_capability_service.dart`
- Modify: `lib/services/equipment_catalog_service.dart`
- Modify: `lib/services/exercise_filter_service.dart`
- Modify: `test/v080/location_equipment_matrix_test.dart`
- Modify: `test/v080/manual_filter_matrix_test.dart`
- Modify: `MANUAL_FILTER_REVIEW.md`

- [ ] **Step 1: Write failing capability tests**

Add individual IDs proving: inclined/declined push-ups require support; dips require support; pull-ups require a bar; inverted row requires table/bar; chair squat requires chair; bodyweight floor movements remain available; gym bench aliases satisfy generic bench requirements.

- [ ] **Step 2: Verify RED**

Run the targeted tests. Expected: support-dependent bodyweight exercises incorrectly pass because current matching uses `any`.

- [ ] **Step 3: Register canonical base capabilities**

Add `floor` and `wall` definitions. `availableKeys` always supplies `bodyweight` and `floor`; supplies `wall` for home/gym/dojo, `outdoor_space` outdoors and `tatami` in dojo. Gym supplies all bench/support families.

- [ ] **Step 4: Implement capability groups**

`ExerciseCapabilityService.requirementGroups(exercise)` returns `List<Set<String>>`: every list item is required, any key inside one set satisfies that requirement. Expand generic bench/cable aliases before comparison.

```dart
static bool isAvailable(Exercise exercise, Set<String> available) {
  final expanded = expandAvailable(available);
  return requirementGroups(exercise)
      .every((alternatives) => alternatives.any(expanded.contains));
}
```

- [ ] **Step 5: Replace `_matchesEquipment` any-match logic**

Retain location-specific cardio/martial decisions but route equipment checks through the capability service. Return the missing canonical capability labels for display.

- [ ] **Step 6: Verify GREEN and update matrix states**

Run the capability/location/manual suites and mark corrected FAIL rows as PASS with the applied correction.

- [ ] **Step 7: Commit**

Commit message: `fix: enforce exercise capability requirements`.

### Task 4: Complete the manual anatomical matrix

**Files:**
- Modify: `MANUAL_FILTER_REVIEW.md`
- Modify: `test/v080/manual_filter_matrix_test.dart`
- Modify: `lib/services/exercise_filter_service.dart`

- [ ] **Step 1: Review nine profiles explicitly**

Populate separate rows for home bodyweight, home support, dumbbells, barbell/plates, bands, pull-up bar, full gym, outdoor and dojo/tatami.

- [ ] **Step 2: Review every requested relevant focus manually**

For each row inspect actual named results, primary anatomy, secondary-only risk, location and required supports. Record expected inclusions and exclusions before adding or changing a test.

- [ ] **Step 3: Add exact matrix-ID tests for every discovered FAIL**

Do not create count-only assertions. Each test names representative exercises that must and must not appear.

- [ ] **Step 4: Apply one minimal anatomical correction per RED test**

Use canonical group/subgroup/muscle tags. Do not add visible-label `contains()` logic for canonical catalogue entries.

- [ ] **Step 5: Run the manual matrix test after each correction cluster**

Expected: all matrix IDs pass and no previously passing row regresses.

- [ ] **Step 6: Commit**

Commit message: `fix: align filters with manual review matrix`.

### Task 5: Validate show-all and empty states

**Files:**
- Modify: `lib/screens/workout_detail_screen.dart`
- Modify: `lib/services/exercise_filter_service.dart`
- Modify: `test/v080/manual_filter_matrix_test.dart`
- Modify: `MANUAL_FILTER_REVIEW.md`

- [ ] **Step 1: Add RED tests for unavailable reasons**

Assert that an anatomically matching pull-up without a bar reports missing equipment/location, while a chest exercise under a back focus reports anatomical mismatch.

- [ ] **Step 2: Implement deterministic explanations**

Expose the missing capability names and retain the anatomical mismatch reason. Update empty-state copy so a legitimate absence is not described merely as “poucos exercícios”.

- [ ] **Step 3: Verify targeted show-all tests**

Run `test/filters/show_all_exercises_test.dart` and the matrix suite.

- [ ] **Step 4: Commit**

Commit message: `fix: explain unavailable exercises precisely`.

### Task 6: Android visual validation

**Files:**
- Modify: `MANUAL_FILTER_REVIEW.md`

- [ ] **Step 1: Install Android emulator tooling if missing**

Use the configured SDK at `C:\tools\android-sdk`; install `emulator` and `system-images;android-36;google_apis;x86_64` through `sdkmanager`, accept licenses, then create the AVD `evefit_pixel_api_36` with the Pixel device definition through `avdmanager`.

- [ ] **Step 2: Launch the AVD hidden and wait for boot completion**

Use `emulator.exe -avd evefit_pixel_api_36 -no-snapshot -no-audio`, then poll `adb shell getprop sys.boot_completed`.

- [ ] **Step 3: Run the app and exercise the required flows**

Create home/no-equipment and gym profiles. Validate chest, arms, core, legs, back and shoulders through the real add-exercise modal.

- [ ] **Step 4: Capture screenshots and record notes**

Save Android screenshots under `docs/manual-filter-review/` and link them from `MANUAL_FILTER_REVIEW.md`. If environment installation is blocked, record the exact command/error and do not claim visual success.

- [ ] **Step 5: Commit**

Commit message: `docs: record Android manual filter validation`.

### Task 7: Full verification, merge and release build 82

**Files:**
- Generated: `build/app/outputs/flutter-apk/EveFit-Tracker-v0.8.0.apk`

- [ ] **Step 1: Run full branch verification**

Run `flutter analyze --no-pub` and `flutter test --no-pub`; require zero failures.

- [ ] **Step 2: Merge hotfix into main**

Return to the main checkout, preserve unrelated APK modifications, merge with `--no-ff`, then rerun `flutter pub get`, `flutter analyze`, and `flutter test`.

- [ ] **Step 3: Confirm public version**

Verify `pubspec.yaml` remains `version: 0.8.0`.

- [ ] **Step 4: Build Android release**

Run `flutter build apk --release --build-name=0.8.0 --build-number=82`, copy to `EveFit-Tracker-v0.8.0.apk`, and calculate SHA-256.

- [ ] **Step 5: Publish and replace the release asset**

Push `main`, keep the existing `v0.8.0` tag, and run `gh release upload v0.8.0 build\app\outputs\flutter-apk\EveFit-Tracker-v0.8.0.apk --repo ryoken99/evefit_tracker --clobber`.

- [ ] **Step 6: Verify remote artifact**

Read release JSON and confirm name, state, size, URL and digest match the local artifact.
