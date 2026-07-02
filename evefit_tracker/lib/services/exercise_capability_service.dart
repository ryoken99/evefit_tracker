import '../models/exercise.dart';
import 'equipment_catalog_service.dart';
import 'exercise_catalog_context_service.dart';
import 'training_architecture.dart';

class ExerciseCapabilityService {
  const ExerciseCapabilityService._();

  static const _benchAlternatives = <String>{
    'bench',
    'adjustable_bench',
    'flat_bench',
    'incline_bench',
    'decline_bench',
  };

  static const _inclineSupportAlternatives = <String>{
    'wall',
    'chair_support',
    'stable_step',
    'sturdy_table',
    ..._benchAlternatives,
  };

  static const _raisedSupportAlternatives = <String>{
    'chair_support',
    'stable_step',
    'sturdy_table',
    ..._benchAlternatives,
  };

  static const _supportRequirements = <String, Set<String>>{
    'flexao_inclinada': _raisedSupportAlternatives,
    'flexao_declinada': _raisedSupportAlternatives,
    'fundos_entre_apoios': {
      'chair_support',
      'stable_step',
      ..._benchAlternatives,
    },
    'agachamento_para_cadeira': {'chair_support'},
    'step_up': {'chair_support', 'stable_step', ..._benchAlternatives},
    'agachamento_bulgaro': {'chair_support', ..._benchAlternatives},
    'agachamento_bulgaro_com_apoio': {'chair_support', ..._benchAlternatives},
    'gemeos_sentado': {'chair_support', ..._benchAlternatives},
    'soleo_sentado': {'chair_support', ..._benchAlternatives},
    'hip_thrust_com_apoio': {
      'chair_support',
      'stable_step',
      ..._benchAlternatives,
    },
    'copenhagen_plank_com_apoio': {'chair_support', ..._benchAlternatives},
    'remo_invertido': {'sturdy_table', 'pullup_bar', 'rings', 'trx'},
    'remo_invertido_em_mesa_resistente': {'sturdy_table'},
    'wall_sit': {'wall'},
    'wall_slides': {'wall'},
    'elevacao_tibial': {'wall'},
  };

  static final Set<String> _bodyweightWithSupport = <String>{
    ..._supportRequirements.keys,
    'dips_para_peito_em_paralelas',
    'dips_para_triceps',
  };

  static Set<String> availableCapabilities({
    required String trainingLocation,
    required Set<String> selectedEquipmentKeys,
  }) {
    final result = EquipmentCatalogService.availableKeys(
      trainingLocations: {trainingLocation},
      selectedEquipmentKeys: selectedEquipmentKeys,
    );
    if (result.contains('floor')) result.add('free_space');
    if (result.any(_benchAlternatives.contains)) {
      result.addAll(_benchAlternatives);
    }
    if (result.contains('adjustable_cable')) {
      result.addAll({'high_cable', 'low_cable'});
    }
    return result;
  }

  static List<Set<String>> requirementGroups(Exercise exercise) {
    final exerciseKey = _exerciseKey(exercise);
    final equipmentKeys = <String>{
      ...TrainingArchitecture.tagsForExercise(exercise).equipmentKeys,
    };
    if (equipmentKeys.contains('pullup_bar')) {
      equipmentKeys.remove('barbell');
    }
    final groups = <Set<String>>[];
    final support = _supportRequirements[exerciseKey];
    if (support != null) groups.add(support);

    final handled = <String>{
      'bodyweight',
      'none',
      'floor',
      'free_space',
      if (support != null) ..._inclineSupportAlternatives,
    };

    if (equipmentKeys.contains('high_cable') &&
        equipmentKeys.contains('low_cable')) {
      groups.add({'high_cable', 'low_cable', 'adjustable_cable'});
      handled.addAll({'high_cable', 'low_cable', 'adjustable_cable'});
    }

    for (final key in equipmentKeys.difference(handled)) {
      if (_benchAlternatives.contains(key)) {
        if (!groups.any((group) => group == _benchAlternatives)) {
          groups.add(_benchAlternatives);
        }
      } else if (key == 'tatami') {
        // Drills de solo aceitam tatami ou um tapete/colchonete.
        groups.add({'tatami', 'mat'});
      } else if (key == 'mat') {
        groups.add({'mat', 'floor'});
      } else if (key == 'high_cable') {
        groups.add({'high_cable', 'adjustable_cable'});
      } else if (key == 'low_cable') {
        groups.add({'low_cable', 'adjustable_cable'});
      } else {
        groups.add({key});
      }
    }
    return groups;
  }

  static bool isAvailable({
    required Exercise exercise,
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
    String selectedEquipmentKey = '',
  }) {
    final available = availableCapabilities(
      trainingLocation: trainingLocation,
      selectedEquipmentKeys: availableEquipmentKeys,
    );
    if (!_matchesSelectedEquipment(exercise, selectedEquipmentKey)) {
      return false;
    }
    return requirementGroups(
      exercise,
    ).every((alternatives) => alternatives.any(available.contains));
  }

  static List<String> missingCapabilityNames({
    required Exercise exercise,
    required String trainingLocation,
    required Set<String> availableEquipmentKeys,
  }) {
    final available = availableCapabilities(
      trainingLocation: trainingLocation,
      selectedEquipmentKeys: availableEquipmentKeys,
    );
    return requirementGroups(exercise)
        .where((alternatives) => !alternatives.any(available.contains))
        .map(_requirementLabel)
        .toList(growable: false);
  }

  static bool _matchesSelectedEquipment(
    Exercise exercise,
    String selectedEquipmentKey,
  ) {
    if (selectedEquipmentKey.isEmpty) return true;
    final exerciseKey = _exerciseKey(exercise);
    final equipment = TrainingArchitecture.tagsForExercise(
      exercise,
    ).equipmentKeys;
    if (selectedEquipmentKey == 'bodyweight') {
      return equipment.contains('bodyweight') ||
          _bodyweightWithSupport.contains(exerciseKey);
    }
    if (selectedEquipmentKey == 'bench') {
      return equipment.any(_benchAlternatives.contains);
    }
    if (selectedEquipmentKey == 'high_cable' ||
        selectedEquipmentKey == 'low_cable' ||
        selectedEquipmentKey == 'adjustable_cable') {
      return equipment.any(
        {'high_cable', 'low_cable', 'adjustable_cable'}.contains,
      );
    }
    return equipment.contains(selectedEquipmentKey);
  }

  static String _exerciseKey(Exercise exercise) => exercise.exerciseKey.isEmpty
      ? ExerciseCatalogContextService.stableKey(exercise.name)
      : exercise.exerciseKey;

  static String _requirementLabel(Set<String> alternatives) {
    if (alternatives == _benchAlternatives ||
        alternatives == _inclineSupportAlternatives ||
        alternatives == _raisedSupportAlternatives) {
      return 'apoio estável/banco';
    }
    final labels =
        alternatives
            .map((key) => EquipmentCatalogService.definitions[key]?.name ?? key)
            .toList()
          ..sort();
    return labels.join(' ou ');
  }
}
