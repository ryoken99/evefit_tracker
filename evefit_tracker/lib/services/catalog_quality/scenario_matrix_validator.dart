import '../../models/exercise.dart';
import '../../services/exercise_filter_service.dart';
import '../../services/training_flow.dart';
import 'catalog_quality_models.dart';

class ScenarioMatrixValidator {
  const ScenarioMatrixValidator();

  List<CatalogScenarioResult> run(List<Exercise> exercises) {
    return [
      _scenario(
        name: 'Cardio - Passadeira - Resistencia aerobica',
        exercises: exercises,
        flow: const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
          cardioFocusKey: 'aerobic_endurance',
        ),
        location: 'Ginasio',
        equipment: {'treadmill'},
        expected: {
          'Passadeira resistência aeróbia',
          'Passadeira ritmo moderado',
          'Corrida na passadeira',
          'Passadeira caminhada com inclinação',
        },
      ),
      _scenario(
        name: 'Cardio - Passadeira - Aquecimento',
        exercises: exercises,
        flow: const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
          cardioFocusKey: 'treadmill_warmup',
        ),
        location: 'Ginasio',
        equipment: {'treadmill'},
        expected: {'Passadeira aquecimento', 'Caminhada na passadeira'},
      ),
      _scenario(
        name: 'Cardio - Passadeira - Ritmo leve',
        exercises: exercises,
        flow: const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
          cardioFocusKey: 'treadmill_easy_pace',
        ),
        location: 'Ginasio',
        equipment: {'treadmill'},
        expected: {'Passadeira ritmo leve', 'Caminhada na passadeira'},
      ),
      _scenario(
        name: 'Cardio - Passadeira - Intervalos',
        exercises: exercises,
        flow: const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
          cardioFocusKey: 'treadmill_intervals',
        ),
        location: 'Ginasio',
        equipment: {'treadmill'},
        expected: {'Passadeira intervalos', 'HIIT passadeira'},
      ),
      _scenario(
        name: 'Cardio - Bicicleta continua disponivel',
        exercises: exercises,
        flow: const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'bike',
          cardioFocusKey: 'aerobic_endurance',
        ),
        location: 'Ginasio',
        equipment: {'bike'},
        expected: {'Bicicleta ritmo leve'},
      ),
      _scenario(
        name: 'Casa sem passadeira nao mostra passadeira',
        exercises: exercises,
        flow: const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
          cardioFocusKey: 'aerobic_endurance',
        ),
        location: 'Casa',
        equipment: const {},
        expected: const {},
        mustBeEmpty: true,
      ),
      _scenario(
        name: 'Casa equipada com passadeira mostra passadeira',
        exercises: exercises,
        flow: const TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: 'treadmill',
          cardioFocusKey: 'aerobic_endurance',
        ),
        location: 'Casa',
        equipment: {'treadmill'},
        expected: {'Passadeira resistência aeróbia'},
      ),
    ];
  }

  List<CatalogIssue> validate(List<Exercise> exercises) {
    final issues = <CatalogIssue>[];
    for (final scenario in run(exercises)) {
      if (!scenario.passed) {
        issues.add(
          CatalogIssue(
            severity: CatalogIssueSeverity.critical,
            code: 'filter_scenario_failed',
            message:
                '${scenario.name} falhou; count=${scenario.count}, expected=${scenario.expectedNames.join(', ')}',
          ),
        );
      }
    }
    final recoveryHiit = exercises.where(
      (exercise) =>
          exercise.primaryType == 'recuperacao' &&
          exercise.name.toLowerCase().contains('hiit passadeira'),
    );
    if (recoveryHiit.isNotEmpty) {
      issues.add(
        CatalogIssue(
          severity: CatalogIssueSeverity.critical,
          code: 'hiit_treadmill_in_recovery',
          message: 'HIIT passadeira aparece em contexto de recuperacao.',
          exercise: recoveryHiit.first,
        ),
      );
    }
    return issues;
  }

  CatalogScenarioResult _scenario({
    required String name,
    required List<Exercise> exercises,
    required TrainingFlowSelection flow,
    required String location,
    required Set<String> equipment,
    required Set<String> expected,
    bool mustBeEmpty = false,
  }) {
    final selection = TrainingFlow.toTrainingSelection(flow);
    final names = ExerciseFilterService.getAvailableExercises(
      exercises: exercises,
      trainingLocation: location,
      availableEquipmentKeys: equipment,
      selection: selection,
      showAllExercises: false,
    ).map((item) => item.exercise.name).toList()..sort();
    return CatalogScenarioResult(
      name: name,
      count: names.length,
      exerciseNames: names,
      expectedNames: expected,
      mustBeEmpty: mustBeEmpty,
    );
  }
}
