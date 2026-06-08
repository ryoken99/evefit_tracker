import '../models/exercise.dart';
import 'exercise_catalog_context_service.dart';
import 'exercise_filter_service.dart';
import 'training_architecture.dart';
import 'training_flow.dart';

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

  @override
  String toString() => '[$area] $entryId $name: $message';
}

class FilterMatrixRow {
  const FilterMatrixRow({
    required this.type,
    required this.equipment,
    required this.region,
    required this.group,
    required this.subzone,
    required this.focus,
    required this.resultCount,
    required this.status,
  });

  final String type;
  final String equipment;
  final String region;
  final String group;
  final String subzone;
  final String focus;
  final int resultCount;
  final String status;
}

class TextQualityRow {
  const TextQualityRow({
    required this.id,
    required this.name,
    required this.equipment,
    required this.group,
    required this.descriptionOk,
    required this.executionOk,
    required this.mistakesOk,
    required this.safetyOk,
    required this.failures,
  });

  final String id;
  final String name;
  final String equipment;
  final String group;
  final bool descriptionOk;
  final bool executionOk;
  final bool mistakesOk;
  final bool safetyOk;
  final List<String> failures;

  String get status => failures.isEmpty ? 'OK' : 'FALHA';
}

class CatalogQualityGateService {
  const CatalogQualityGateService._();

  static List<ExerciseCatalogEntry> get entries =>
      ExerciseCatalogContextService.entries;

  static int get catalogEntryCount => entries.length;

  static int get uniqueExerciseCount =>
      entries.map((entry) => entry.name).toSet().length;

  static int get filterCombinationCount => filterMatrixRows().length;

  static int get equipmentSimulationCount => _equipmentKeys.length * 2;

  static List<QualityGateFailure> allFailures() => [
    ...catalogIntegrityFailures(),
    ...pedagogyFailures(),
    ...movementFamilyFailures(),
    ...equipmentDescriptionFailures(),
    ...cardioSpecificityFailures(),
    ...safetyRiskFailures(),
    ...duplicateContextFailures(),
    ...muscleMetadataFailures(),
    ...anatomyFilterFailures(),
    ...equipmentFilterFailures(),
    ...trainingTypeFilterFailures(),
    ...fullCombinatoricsFailures(),
    ...showAllFailures(),
    ...manualRegressionFailures(),
  ];

  static String formatFailures(List<QualityGateFailure> failures) {
    if (failures.isEmpty) return '';
    return failures.take(40).map((failure) => failure.toString()).join('\n');
  }

  static List<QualityGateFailure> catalogIntegrityFailures() {
    final failures = <QualityGateFailure>[];
    final keys = <String>{};
    for (final entry in entries) {
      _require(
        failures,
        entry,
        'catalog_integrity',
        entry.id.trim().isNotEmpty,
        'missing stable id',
      );
      _require(
        failures,
        entry,
        'catalog_integrity',
        entry.name.trim().isNotEmpty,
        'missing visible name',
      );
      _require(
        failures,
        entry,
        'catalog_integrity',
        entry.contextKey.trim().isNotEmpty,
        'missing explicit context key',
      );
      _require(
        failures,
        entry,
        'catalog_integrity',
        entry.group.trim().isNotEmpty,
        'missing primary group',
      );
      _require(
        failures,
        entry,
        'catalog_integrity',
        entry.details.equipment.trim().isNotEmpty,
        'missing equipment',
      );
      _require(
        failures,
        entry,
        'catalog_integrity',
        entry.details.description.trim().isNotEmpty,
        'missing description',
      );
      _require(
        failures,
        entry,
        'catalog_integrity',
        entry.details.executionSteps.trim().isNotEmpty,
        'missing execution steps',
      );
      _require(
        failures,
        entry,
        'catalog_integrity',
        entry.details.commonMistakes.trim().isNotEmpty,
        'missing common mistakes',
      );
      _require(
        failures,
        entry,
        'catalog_integrity',
        entry.details.safetyNotes.trim().isNotEmpty,
        'missing safety notes',
      );
      if (!keys.add(entry.catalogEntryKey)) {
        failures.add(_failure(entry, 'catalog_integrity', 'duplicate key'));
      }
      for (final phrase in _forbiddenPhrases) {
        if (_text(entry).contains(_norm(phrase))) {
          failures.add(
            _failure(
              entry,
              'catalog_integrity',
              'contains forbidden phrase "$phrase"',
            ),
          );
        }
      }
    }
    return failures;
  }

  static List<QualityGateFailure> pedagogyFailures() {
    final failures = <QualityGateFailure>[];
    for (final entry in entries) {
      final description = _norm(entry.details.description);
      final steps = _norm(entry.details.executionSteps);
      _require(
        failures,
        entry,
        'pedagogy',
        description.length >= 130,
        'description too short',
      );
      _require(
        failures,
        entry,
        'pedagogy',
        _stepCount(entry) >= 6,
        'fewer than 6 execution steps',
      );
      _require(
        failures,
        entry,
        'pedagogy',
        _hasAny(description, ['serve', 'treinar', 'praticar', 'melhorar']),
        'does not explain purpose',
      );
      _require(
        failures,
        entry,
        'pedagogy',
        _hasAny(steps, ['coloca', 'fica', 'senta', 'sobe', 'começa', 'ajusta']),
        'does not explain initial position',
      );
      _require(
        failures,
        entry,
        'pedagogy',
        _hasAny(steps, ['inspira', 'expira', 'respira']),
        'does not explain breathing',
      );
      _require(
        failures,
        entry,
        'pedagogy',
        _hasAny(steps, [
          'desce',
          'sobe',
          'puxa',
          'empurra',
          'roda',
          'leva',
          'mantem',
          'inclina',
          'salta',
          'pedala',
        ]),
        'does not explain trajectory',
      );
      _require(
        failures,
        entry,
        'pedagogy',
        _hasAny(steps, ['volta', 'regressa', 'reduz', 'desce', 'baixa']),
        'does not explain return or end phase',
      );
      _require(
        failures,
        entry,
        'pedagogy',
        _hasAny(entry.details.commonMistakes, [
          'evitar',
          'perder',
          'deixar',
          'usar',
          'abrir',
          'prender',
          'acelerar',
          'forcar',
          'forçar',
        ]),
        'common mistakes are not specific enough',
      );
      _require(
        failures,
        entry,
        'pedagogy',
        _hasAny(entry.details.safetyNotes, [
          'para',
          'dor',
          'tontura',
          'formigueiro',
          'instabilidade',
          'peito',
          'ombro',
          'joelho',
          'lombar',
        ]),
        'safety does not include stop signals',
      );
      _require(
        failures,
        entry,
        'pedagogy',
        entry.beginnerUnderstands,
        'beginner-understands flag is false',
      );
    }
    return failures;
  }

  static List<QualityGateFailure> movementFamilyFailures() {
    final failures = <QualityGateFailure>[];
    for (final entry in entries) {
      final name = _norm(entry.name);
      final text = _text(entry);
      if (name.contains('curl')) {
        _requireAll(failures, entry, 'movement_family', text, [
          'pega',
          'cotovel',
          'punh',
          'tronco',
          'sobe',
          'desce',
          'respira',
        ]);
      }
      if (name.contains('triceps') ||
          name.contains('tricep') ||
          name.contains('tríceps') ||
          name.contains('extensao francesa')) {
        _requireAll(failures, entry, 'movement_family', text, [
          'cotovel',
          'estende',
          'pega',
          'desce',
          'lombar',
          'respira',
        ]);
      }
      if (_hasAny(name, ['supino', 'press', 'flexao', 'dips'])) {
        _requireAll(failures, entry, 'movement_family', text, [
          'pes',
          'ombro',
          'cotovel',
          'empurra',
          'respira',
        ]);
      }
      if (_hasAny(name, [
        'remo',
        'puxada',
        'pull-up',
        'chin-up',
        'face pull',
      ])) {
        _requireAll(failures, entry, 'movement_family', text, [
          'pega',
          'tronco',
          'escap',
          'cotovel',
          'puxa',
          'lombar',
        ]);
      }
      if (_hasAny(name, ['agachamento', 'lunges', 'leg press', 'step-up'])) {
        _requireAll(failures, entry, 'movement_family', text, [
          'pes',
          'joelh',
          'anca',
          'tronco',
          'desce',
          'respira',
        ]);
      }
      if (_hasAny(name, ['peso morto', 'good morning'])) {
        _requireAll(failures, entry, 'movement_family', text, [
          'anca',
          'coluna',
          'joelh',
          'lombar',
          'respira',
        ]);
      }
      if (entry.group == 'Mobilidade') {
        _requireAll(failures, entry, 'movement_family', text, [
          'zona',
          'segundos',
          'respira',
          'dor',
        ]);
      }
      if (entry.group == 'Karate' || entry.group == 'Jiu-Jitsu') {
        _requireAll(failures, entry, 'movement_family', text, [
          'base',
          'objetivo',
          'guarda',
          'respira',
          'controlo',
        ]);
      }
    }
    return failures;
  }

  static List<QualityGateFailure> equipmentDescriptionFailures() {
    final failures = <QualityGateFailure>[];
    for (final entry in entries) {
      final equipment = _norm(entry.details.equipment);
      final equipmentKeys = TrainingArchitecture.equipmentKeysFor(
        entry.details.equipment,
      );
      final steps = _norm(entry.details.executionSteps);
      if (equipment.contains('halter')) {
        _requireAny(failures, entry, 'equipment_text', steps, ['halter']);
        _requireAny(failures, entry, 'equipment_text', steps, [
          'segura',
          'pega',
        ]);
      }
      if (equipment.contains('barra') && !equipment.contains('barra fixa')) {
        _requireAny(failures, entry, 'equipment_text', steps, ['barra']);
        _requireAny(failures, entry, 'equipment_text', steps, [
          'pega',
          'posicao',
        ]);
      }
      if (equipmentKeys.contains('high_cable') ||
          equipmentKeys.contains('low_cable')) {
        _requireAll(failures, entry, 'equipment_text', steps, [
          'polia',
          'pega',
          'cabo',
        ]);
      }
      if (equipment.contains('maquina')) {
        _requireAny(failures, entry, 'equipment_text', steps, [
          'maquina',
          'assento',
          'encosto',
          'ajusta',
        ]);
      }
      if (equipment.contains('passadeira')) {
        _requireAny(failures, entry, 'equipment_text', steps, ['passadeira']);
        _requireAny(failures, entry, 'equipment_text', steps, [
          'velocidade',
          'inclinacao',
        ]);
      }
      if (equipment.contains('bicicleta')) {
        _requireAny(failures, entry, 'equipment_text', steps, ['selim']);
        _requireAny(failures, entry, 'equipment_text', steps, [
          'resistencia',
          'cadencia',
          'pedala',
        ]);
      }
      if (equipment.contains('corda')) {
        _requireAny(failures, entry, 'equipment_text', steps, ['corda']);
        _requireAny(failures, entry, 'equipment_text', steps, [
          'pegas',
          'punhos',
          'salta',
        ]);
      }
      if (equipment == 'peso corporal') {
        final forbidden = [
          'halter',
          'barra',
          'cabo',
          'polia',
          'maquina',
          'passadeira',
          'bicicleta',
          'eliptica',
        ];
        for (final word in forbidden) {
          if (steps.contains(word)) {
            failures.add(
              _failure(entry, 'equipment_text', 'bodyweight asks for $word'),
            );
          }
        }
      }
    }
    return failures;
  }

  static List<QualityGateFailure> cardioSpecificityFailures() {
    final failures = <QualityGateFailure>[];
    for (final entry in entries.where((entry) => entry.group == 'Cardio')) {
      final name = _norm(entry.name);
      final text = _text(entry);
      if (name.contains('passadeira')) {
        _requireAll(failures, entry, 'cardio_specificity', text, [
          'passadeira',
          'velocidade',
          'duracao',
        ]);
        _rejectAll(failures, entry, 'cardio_specificity', text, [
          'selim',
          'pedalar',
          'cadencia de pedalada',
        ]);
      }
      if (name.contains('bicicleta')) {
        _requireAll(failures, entry, 'cardio_specificity', text, [
          'bicicleta',
          'selim',
          'resistencia',
          'cadencia',
        ]);
        _rejectAll(failures, entry, 'cardio_specificity', text, [
          'passadas',
          'saltos',
          'inclinacao',
        ]);
      }
      if (name.contains('corda')) {
        _requireAll(failures, entry, 'cardio_specificity', text, [
          'corda',
          'pegas',
          'punhos',
          'salta',
        ]);
        _rejectAll(failures, entry, 'cardio_specificity', text, [
          'bicicleta',
          'passadeira',
          'pedalar',
          'selim',
          'inclinacao',
        ]);
      }
      if (name.contains('eliptica')) {
        _requireAll(failures, entry, 'cardio_specificity', text, [
          'eliptica',
          'resistencia',
          'duracao',
        ]);
        _rejectAll(failures, entry, 'cardio_specificity', text, [
          'passadeira',
          'selim',
        ]);
      }
      if (name.contains('cooldown')) {
        _requireAny(failures, entry, 'cardio_specificity', text, [
          'abranda',
          'reduz',
          'recupera',
        ]);
      }
      if (name.contains('interval') || name.contains('hiit')) {
        _requireAny(failures, entry, 'cardio_specificity', text, [
          'interval',
          'blocos',
          'recupera',
        ]);
      }
    }
    return failures;
  }

  static List<QualityGateFailure> safetyRiskFailures() {
    final failures = <QualityGateFailure>[];
    final safetyTexts = <String, int>{};
    for (final entry in entries) {
      final safety = _norm(entry.details.safetyNotes);
      safetyTexts[safety] = (safetyTexts[safety] ?? 0) + 1;
      _require(
        failures,
        entry,
        'safety',
        safety.length >= 70,
        'safety too short',
      );
      _requireAny(failures, entry, 'safety', safety, [
        'para',
        'interrompe',
        'termina',
        'abranda',
      ]);
      _requireAny(failures, entry, 'safety', safety, [
        'dor',
        'tontura',
        'formigueiro',
        'peito',
        'instabilidade',
        'falta de ar',
      ]);
      _rejectAll(failures, entry, 'safety', safety, [
        'garante',
        'substitui tratamento',
      ]);
    }
    for (final entry in entries) {
      final safety = _norm(entry.details.safetyNotes);
      if ((safetyTexts[safety] ?? 0) > 45) {
        failures.add(
          _failure(entry, 'safety', 'safety text reused too broadly'),
        );
      }
    }
    return failures;
  }

  static List<QualityGateFailure> duplicateContextFailures() {
    final failures = <QualityGateFailure>[];
    final seen = <String>{};
    for (final entry in entries) {
      final pair = '${entry.exerciseKey}::${entry.contextKey}';
      if (!seen.add(pair)) {
        failures.add(_failure(entry, 'duplicates', 'same name/context twice'));
      }
    }
    for (final item
        in ExerciseCatalogContextService.duplicateContextsByName.entries) {
      final contexts = item.value.toSet();
      if (contexts.length != item.value.length) {
        failures.add(
          QualityGateFailure(
            area: 'duplicates',
            entryId: item.key,
            name: item.key,
            message: 'duplicate visible name repeats same context',
          ),
        );
      }
    }
    return failures;
  }

  static List<QualityGateFailure> muscleMetadataFailures() {
    final failures = <QualityGateFailure>[];
    for (final entry in entries) {
      final exercise = entry.toExercise();
      final tags = TrainingArchitecture.tagsForExercise(exercise);
      _require(
        failures,
        entry,
        'muscle_metadata',
        tags.regionKeys.isNotEmpty,
        'missing region tags',
      );
      _require(
        failures,
        entry,
        'muscle_metadata',
        tags.groupKeys.isNotEmpty,
        'missing group tags',
      );
      if (entry.group == 'Peito') {
        _require(
          failures,
          entry,
          'muscle_metadata',
          tags.groupKeys.contains('chest'),
          'chest entry missing chest tag',
        );
      }
      if (entry.group == 'Tríceps' || entry.group == 'TrÃ­ceps') {
        _require(
          failures,
          entry,
          'muscle_metadata',
          tags.groupKeys.contains('arms'),
          'triceps entry missing arms tag',
        );
      }
      if (entry.group == 'Antebraço/Pega' || entry.group == 'AntebraÃ§o/Pega') {
        _require(
          failures,
          entry,
          'muscle_metadata',
          tags.groupKeys.contains('forearm_hand'),
          'forearm entry missing forearm tag',
        );
      }
    }
    return failures;
  }

  static List<QualityGateFailure> anatomyFilterFailures() =>
      _filterCaseFailures(_anatomyCases, 'anatomy_filter');

  static List<QualityGateFailure> trainingTypeFilterFailures() =>
      _filterCaseFailures(_trainingTypeCases, 'training_type_filter');

  static List<QualityGateFailure> fullCombinatoricsFailures() =>
      _filterCaseFailures(_allFilterCases, 'full_combinatorics');

  static List<QualityGateFailure> equipmentFilterFailures() {
    final failures = <QualityGateFailure>[];
    final exercises = _catalogExercises;
    for (final equipmentKey in _equipmentKeys) {
      final withKey = ExerciseFilterService.getAvailableExercises(
        exercises: exercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: {equipmentKey},
        selection: const TrainingSelection(),
        showAllExercises: false,
      ).map((item) => item.exercise).toList();
      if (equipmentKey == 'bodyweight' || equipmentKey == 'none') {
        if (withKey.isEmpty) {
          failures.add(
            const QualityGateFailure(
              area: 'equipment_filter',
              entryId: 'bodyweight',
              name: 'bodyweight',
              message: 'bodyweight profile returned no exercises',
            ),
          );
        }
        continue;
      }
      final relevant = entries.where((entry) {
        return TrainingArchitecture.equipmentKeysFor(
          entry.details.equipment,
        ).contains(equipmentKey);
      }).toList();
      if (relevant.isNotEmpty &&
          !withKey.any((exercise) {
            return TrainingArchitecture.tagsForExercise(
              exercise,
            ).equipmentKeys.contains(equipmentKey);
          })) {
        failures.add(
          QualityGateFailure(
            area: 'equipment_filter',
            entryId: equipmentKey,
            name: equipmentKey,
            message: 'equipment profile does not unlock matching exercises',
          ),
        );
      }
    }
    return failures;
  }

  static List<QualityGateFailure> showAllFailures() {
    final failures = <QualityGateFailure>[];
    final visible = ExerciseFilterService.getAvailableExercises(
      exercises: _catalogExercises,
      trainingLocation: 'Casa',
      availableEquipmentKeys: {'bodyweight'},
      selection: const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'cardio_machine',
        subgroupKey: 'treadmill',
        equipmentKey: 'treadmill',
      ),
      showAllExercises: true,
    );
    _require(
      failures,
      null,
      'show_all',
      visible.length == catalogEntryCount,
      'show all did not return all catalog entries',
    );
    for (final item in visible) {
      final exercise = item.exercise;
      if (!item.isAvailable && item.unavailableReason.trim().isEmpty) {
        failures.add(
          QualityGateFailure(
            area: 'show_all',
            entryId: exercise.catalogEntryKey,
            name: exercise.name,
            message: 'unavailable item has empty reason',
          ),
        );
      }
      if (exercise.description.trim().isEmpty ||
          exercise.executionSteps.trim().isEmpty ||
          exercise.equipment.trim().isEmpty) {
        failures.add(
          QualityGateFailure(
            area: 'show_all',
            entryId: exercise.catalogEntryKey,
            name: exercise.name,
            message: 'show-all item has incomplete metadata',
          ),
        );
      }
    }
    return failures;
  }

  static List<QualityGateFailure> manualRegressionFailures() {
    final failures = <QualityGateFailure>[];
    failures.addAll(
      _filterCaseFailures(_manualRegressionCases, 'manual_regression'),
    );
    for (final entry in entries) {
      final name = _norm(entry.name);
      final text = _text(entry);
      if (name.contains('bicicleta cooldown')) {
        _rejectAll(failures, entry, 'manual_regression', text, [
          'passadas',
          'saltos',
          'inclinacao',
        ]);
        _requireAll(failures, entry, 'manual_regression', text, [
          'selim',
          'resistencia',
          'pedalar',
          'cadencia',
        ]);
      }
      if (name.contains('corda de saltar pes alternados')) {
        _rejectAll(failures, entry, 'manual_regression', text, [
          'bicicleta',
          'passadeira',
          'pedalar',
          'selim',
          'inclinacao',
        ]);
        _requireAll(failures, entry, 'manual_regression', text, [
          'corda',
          'pegas',
          'punhos',
          'salta',
          'alternados',
          'aterra',
        ]);
      }
      if (name.contains('dead hang escapular')) {
        _requireAll(failures, entry, 'manual_regression', text, [
          'barra fixa',
          'pendura',
          'bracos esticados',
          'escap',
          'ombros',
          'cotovel',
        ]);
      }
      if (name.contains('curl cruzado no corpo')) {
        _requireAll(failures, entry, 'manual_regression', text, [
          'pega neutra',
          'diagonal',
          'ombro oposto',
          'cotovelo',
        ]);
      }
      if (name == 'curl inverso' || name == 'curl inverso com halteres') {
        _requireAll(failures, entry, 'manual_regression', text, [
          'pega pronada',
          'palmas',
          'punhos alinhados',
          'cotovel',
        ]);
      }
    }
    return failures;
  }

  static List<FilterMatrixRow> filterMatrixRows() {
    return [
      for (final testCase in _allFilterCases)
        FilterMatrixRow(
          type: testCase.type,
          equipment: testCase.equipment.join(', '),
          region: testCase.selection.regionKey,
          group: testCase.selection.groupKey,
          subzone: testCase.selection.subgroupKey,
          focus: testCase.selection.specificMuscleKey,
          resultCount: _visibleFor(testCase).length,
          status: _filterCaseFailures([testCase], 'matrix').isEmpty
              ? (_visibleFor(testCase).isEmpty ? 'ZERO_ESPERADO' : 'OK')
              : 'ERRO',
        ),
    ];
  }

  static List<TextQualityRow> textQualityRows() {
    final failuresByEntry = <String, List<QualityGateFailure>>{};
    for (final failure in [
      ...catalogIntegrityFailures(),
      ...pedagogyFailures(),
      ...movementFamilyFailures(),
      ...equipmentDescriptionFailures(),
      ...cardioSpecificityFailures(),
      ...safetyRiskFailures(),
    ]) {
      failuresByEntry.putIfAbsent(failure.entryId, () => []).add(failure);
    }
    return [
      for (final entry in entries)
        TextQualityRow(
          id: entry.id,
          name: entry.name,
          equipment: entry.details.equipment,
          group: entry.group,
          descriptionOk: entry.details.description.trim().length >= 130,
          executionOk: _stepCount(entry) >= 6,
          mistakesOk: entry.details.commonMistakes.trim().length >= 60,
          safetyOk: entry.details.safetyNotes.trim().length >= 70,
          failures: [
            for (final failure in failuresByEntry[entry.id] ?? const [])
              failure.message,
          ],
        ),
    ];
  }

  static List<QualityGateFailure> _filterCaseFailures(
    List<_FilterCase> cases,
    String area,
  ) {
    final failures = <QualityGateFailure>[];
    for (final testCase in cases) {
      final visible = _visibleFor(testCase);
      final names = visible.map((item) => item.exercise.name).toSet();
      if (!testCase.zeroExpected && visible.isEmpty) {
        failures.add(
          QualityGateFailure(
            area: area,
            entryId: testCase.label,
            name: testCase.label,
            message: 'valid combination returned zero exercises',
          ),
        );
      }
      for (final expected in testCase.expectedNames) {
        if (!names.contains(expected)) {
          failures.add(
            QualityGateFailure(
              area: area,
              entryId: testCase.label,
              name: expected,
              message: 'expected exercise missing',
            ),
          );
        }
      }
      for (final forbidden in testCase.forbiddenNames) {
        if (names.contains(forbidden)) {
          failures.add(
            QualityGateFailure(
              area: area,
              entryId: testCase.label,
              name: forbidden,
              message: 'forbidden exercise leaked into filter',
            ),
          );
        }
      }
      for (final item in visible) {
        if (item.exercise.description.trim().isEmpty ||
            item.exercise.executionSteps.trim().isEmpty ||
            item.exercise.safetyNotes.trim().isEmpty ||
            item.exercise.equipment.trim().isEmpty) {
          failures.add(
            QualityGateFailure(
              area: area,
              entryId: testCase.label,
              name: item.exercise.name,
              message: 'visible exercise has incomplete metadata',
            ),
          );
        }
      }
    }
    return failures;
  }

  static List<ExerciseAvailability> _visibleFor(_FilterCase testCase) {
    return ExerciseFilterService.getAvailableExercises(
      exercises: _catalogExercises,
      trainingLocation: testCase.location,
      availableEquipmentKeys: testCase.equipment,
      selection: testCase.selection,
      showAllExercises: false,
    );
  }

  static List<Exercise> get _catalogExercises =>
      entries.map((entry) => entry.toExercise()).toList();

  static void _require(
    List<QualityGateFailure> failures,
    ExerciseCatalogEntry? entry,
    String area,
    bool condition,
    String message,
  ) {
    if (condition) return;
    if (entry == null) {
      failures.add(
        QualityGateFailure(
          area: area,
          entryId: '-',
          name: '-',
          message: message,
        ),
      );
    } else {
      failures.add(_failure(entry, area, message));
    }
  }

  static QualityGateFailure _failure(
    ExerciseCatalogEntry entry,
    String area,
    String message,
  ) {
    return QualityGateFailure(
      area: area,
      entryId: entry.id,
      name: '${entry.name} (${entry.group})',
      message: message,
    );
  }

  static void _requireAll(
    List<QualityGateFailure> failures,
    ExerciseCatalogEntry entry,
    String area,
    String text,
    List<String> needles,
  ) {
    for (final needle in needles) {
      if (!_norm(text).contains(_norm(needle))) {
        failures.add(_failure(entry, area, 'missing cue "$needle"'));
      }
    }
  }

  static void _requireAny(
    List<QualityGateFailure> failures,
    ExerciseCatalogEntry entry,
    String area,
    String text,
    List<String> needles,
  ) {
    if (!_hasAny(text, needles)) {
      failures.add(
        _failure(entry, area, 'missing any cue ${needles.join('/')}'),
      );
    }
  }

  static void _rejectAll(
    List<QualityGateFailure> failures,
    ExerciseCatalogEntry entry,
    String area,
    String text,
    List<String> needles,
  ) {
    final normalized = _norm(text);
    for (final needle in needles) {
      if (normalized.contains(_norm(needle))) {
        failures.add(_failure(entry, area, 'contains wrong cue "$needle"'));
      }
    }
  }

  static bool _hasAny(String text, List<String> needles) {
    final normalized = _norm(text);
    return needles.any((needle) => normalized.contains(_norm(needle)));
  }

  static int _stepCount(ExerciseCatalogEntry entry) {
    return RegExp(r'\d+\.').allMatches(entry.details.executionSteps).length;
  }

  static String _text(ExerciseCatalogEntry entry) {
    return _norm(
      '${entry.name} ${entry.group} ${entry.details.secondaryGroups} '
      '${entry.details.equipment} ${entry.details.description} '
      '${entry.details.executionSteps} ${entry.details.commonMistakes} '
      '${entry.details.safetyNotes}',
    );
  }

  static String _norm(String value) {
    return ExerciseCatalogContextService.stableKey(value).replaceAll('_', ' ');
  }

  static const _forbiddenPhrases = [
    'no contexto',
    'equipamento indicado',
    'move a articulacao principal',
    'faz o movimento principal',
    'dobrar e estender o cotovelo',
    'passadas pedaladas ou saltos',
    'velocidade inclinacao resistencia ou cadencia',
    'mantem boa postura',
    'executa com boa tecnica',
    'amplitude controlada',
    'movimento lento e previsivel',
    'ajusta pes maos e carga',
    'volta a posicao inicial com a mesma trajetoria',
    'comeca leve progride gradualmente',
    'usar pressa',
    'compensar com outra zona do corpo',
    'descricao ainda incompleta',
    'sera melhorado numa proxima versao',
    'exercicio ou drill para treinar',
    'familia biceps',
    'familia triceps',
    'familia antebraco',
    'zona alvo',
    'articulacao principal',
    'coloca te numa base estavel para',
    'usa esta amplitude',
    'conforme a direcao do exercicio',
    'carga perto da linha do movimento',
  ];

  static const _equipmentKeys = [
    'bodyweight',
    'barbell',
    'plates',
    'dumbbells',
    'bench',
    'machine',
    'high_cable',
    'low_cable',
    'pullup_bar',
    'bands',
    'kettlebell',
    'treadmill',
    'bike',
    'elliptical',
    'jump_rope',
    'heavy_bag',
    'tatami',
    'none',
  ];

  static final _anatomyCases = <_FilterCase>[
    _FilterCase(
      label: 'Brachialis dumbbells',
      type: 'strength',
      location: 'Casa',
      equipment: {'dumbbells'},
      selection: const TrainingSelection(
        regionKey: 'upper',
        groupKey: 'arms',
        subgroupKey: 'anterior_arm',
        specificMuscleKey: 'brachialis',
        equipmentKey: 'dumbbells',
      ),
      expectedNames: [
        'Curl martelo',
        'Curl cruzado no corpo',
        'Curl inverso com halteres',
      ],
      forbiddenNames: [
        'Finger curls',
        'Wrist curl',
        'Reverse wrist curl',
        'Extensão francesa com halter',
        'Kickback de tríceps',
        'Supino com halteres',
        'Aberturas com halteres',
      ],
    ),
    _FilterCase(
      label: 'Arms complete dumbbells',
      type: 'strength',
      location: 'Casa',
      equipment: {'dumbbells', 'bench', 'incline_bench'},
      selection: const TrainingSelection(
        regionKey: 'upper',
        groupKey: 'arms',
        subgroupKey: 'arms_complete',
        equipmentKey: 'dumbbells',
      ),
      expectedNames: [
        'Curl com halteres',
        'Extensão francesa com halter',
        'Wrist curl',
        'Suitcase carry',
      ],
      forbiddenNames: [
        'Supino com halteres',
        'Aberturas com halteres',
        'Remo unilateral com halter',
        'Elevação lateral',
        'Agachamento goblet',
      ],
    ),
  ];

  static final _trainingTypeCases = <_FilterCase>[
    _FilterCase(
      label: 'Treadmill only',
      type: 'cardio',
      location: 'Casa',
      equipment: {'treadmill'},
      selection: const TrainingSelection(
        regionKey: 'cardio',
        groupKey: 'cardio_machine',
        subgroupKey: 'treadmill',
        equipmentKey: 'treadmill',
      ),
      expectedNames: ['Passadeira caminhada', 'Passadeira cooldown'],
      forbiddenNames: ['Bicicleta ritmo leve', 'Elíptica ritmo leve'],
    ),
    _FilterCase(
      label: 'Martial karate',
      type: 'martial_arts',
      location: 'Dojo / Artes marciais',
      equipment: {'tatami'},
      selection: const TrainingSelection(
        regionKey: 'martial_arts',
        groupKey: 'karate',
      ),
      expectedNames: ['Kihon', 'Kata'],
      forbiddenNames: ['Shrimp / fuga de anca', 'Ponte de grappling'],
    ),
    _FilterCase(
      label: 'Mobility glutes',
      type: 'mobility',
      location: 'Casa',
      equipment: {'bodyweight'},
      selection: const TrainingSelection(
        regionKey: 'mobility_recovery',
        groupKey: 'glute_mobility',
      ),
      expectedNames: ['Alongamento figura 4', 'Mobilidade 90/90'],
      forbiddenNames: ['Supino com halteres', 'Passadeira caminhada'],
    ),
    _FilterCase(
      label: 'Recovery stretching',
      type: 'recovery',
      location: 'Casa',
      equipment: {'bodyweight'},
      selection: const TrainingSelection(
        regionKey: 'mobility_recovery',
        groupKey: 'stretching',
        specificMuscleKey: 'light_stretching',
      ),
      expectedNames: ['Alongamento cervical leve'],
      forbiddenNames: ['Supino com halteres'],
    ),
  ];

  static final _manualRegressionCases = <_FilterCase>[
    _anatomyCases.first,
    _anatomyCases[1],
  ];

  static List<_FilterCase> get _allFilterCases {
    final cases = <_FilterCase>[..._anatomyCases, ..._trainingTypeCases];
    const strengthCases = [
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'upper',
        groupKey: 'chest',
        subzoneKey: 'chest_complete',
      ),
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'dumbbells',
        regionKey: 'upper',
        groupKey: 'back',
        subzoneKey: 'back_complete',
      ),
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'dumbbells',
        regionKey: 'upper',
        groupKey: 'shoulders',
        subzoneKey: 'shoulders_complete',
      ),
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'dumbbells',
        regionKey: 'upper',
        groupKey: 'forearm_hand',
        subzoneKey: 'forearm_complete',
      ),
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'core',
        groupKey: 'core',
        subzoneKey: 'core_complete',
      ),
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'core',
        groupKey: 'core',
        subzoneKey: 'abdominal_zone',
        focusKey: 'lower_abs',
      ),
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'core',
        groupKey: 'core',
        subzoneKey: 'abdominal_zone',
        focusKey: 'lateral_abs',
      ),
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'lower',
        groupKey: 'legs',
        subzoneKey: 'legs_complete',
      ),
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'lower',
        groupKey: 'legs',
        subzoneKey: 'upper_leg_hip',
        focusKey: 'hamstrings_complete',
      ),
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'lower',
        groupKey: 'legs',
        subzoneKey: 'upper_leg_hip',
        focusKey: 'glutes_complete',
      ),
      TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'lower',
        groupKey: 'legs',
        subzoneKey: 'lower_leg_foot',
        focusKey: 'lower_leg_complete',
      ),
    ];
    for (final flow in strengthCases) {
      cases.add(
        _FilterCase(
          label: TrainingFlow.suggestedWorkoutName(flow),
          type: flow.typeKey,
          location: 'Casa',
          equipment: {
            flow.equipmentKey,
            'bodyweight',
            'bench',
            'chair_support',
            'mat',
          },
          selection: TrainingFlow.toTrainingSelection(flow),
        ),
      );
    }
    for (final mode in const [
      'no_equipment',
      'treadmill',
      'bike',
      'elliptical',
      'jump_rope',
      'hiit',
    ]) {
      final focusOptions = TrainingFlow.cardioFocusOptionsForEquipment(mode);
      for (final focus in focusOptions.map((entry) => entry.key).toSet()) {
        final flow = TrainingFlowSelection(
          typeKey: 'cardio',
          equipmentKey: mode,
          cardioFocusKey: focus,
        );
        cases.add(
          _FilterCase(
            label: TrainingFlow.suggestedWorkoutName(flow),
            type: flow.typeKey,
            location:
                mode == 'treadmill' || mode == 'bike' || mode == 'elliptical'
                ? 'Ginásio'
                : 'Casa',
            equipment: {
              TrainingFlow.toTrainingSelection(flow).equipmentKey,
              'bodyweight',
            },
            selection: TrainingFlow.toTrainingSelection(flow),
          ),
        );
      }
    }
    for (final art in const ['karate', 'jiu_jitsu']) {
      for (final focus in TrainingFlow.martialFocusOptions(
        art,
      ).map((entry) => entry.key)) {
        final flow = TrainingFlowSelection(
          typeKey: 'martial_arts',
          martialArtKey: art,
          focusKey: focus,
        );
        cases.add(
          _FilterCase(
            label: TrainingFlow.suggestedWorkoutName(flow),
            type: flow.typeKey,
            location: 'Dojo / Artes marciais',
            equipment: {'tatami', 'bodyweight'},
            selection: TrainingFlow.toTrainingSelection(flow),
          ),
        );
      }
    }
    for (final zone in TrainingFlow.mobilityLabels.keys) {
      final flow = TrainingFlowSelection(
        typeKey: 'mobility',
        mobilityZoneKey: zone,
      );
      cases.add(
        _FilterCase(
          label: TrainingFlow.suggestedWorkoutName(flow),
          type: flow.typeKey,
          location: 'Casa',
          equipment: {'bodyweight', 'mat'},
          selection: TrainingFlow.toTrainingSelection(flow),
          zeroExpected: false,
        ),
      );
    }
    for (final recovery in TrainingFlow.recoveryLabels.keys) {
      final flow = TrainingFlowSelection(
        typeKey: 'recovery',
        recoveryKey: recovery,
      );
      cases.add(
        _FilterCase(
          label: TrainingFlow.suggestedWorkoutName(flow),
          type: flow.typeKey,
          location: 'Casa',
          equipment: {'bodyweight', 'mat'},
          selection: TrainingFlow.toTrainingSelection(flow),
        ),
      );
    }
    return cases;
  }
}

class _FilterCase {
  const _FilterCase({
    required this.label,
    required this.type,
    required this.location,
    required this.equipment,
    required this.selection,
    this.expectedNames = const [],
    this.forbiddenNames = const [],
    this.zeroExpected = false,
  });

  final String label;
  final String type;
  final String location;
  final Set<String> equipment;
  final TrainingSelection selection;
  final List<String> expectedNames;
  final List<String> forbiddenNames;
  final bool zeroExpected;
}
