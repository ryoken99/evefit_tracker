import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/workout.dart';
import '../models/workout_template.dart';
import '../models/workout_type.dart';
import '../services/training_architecture.dart';
import '../services/training_flow.dart';
import '../services/workout_taxonomy.dart';
import '../services/workout_template_service.dart';
import '../widgets/workout_card.dart';
import 'workout_detail_screen.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key, required this.database});
  final AppDatabase database;

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<WorkoutEntry>>(
        future: widget.database.workouts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final workouts = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Treinos',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _addWorkout,
                      icon: const Icon(Icons.add),
                      label: const Text('Criar treino'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _createFromTemplate,
                      icon: const Icon(Icons.bolt_outlined),
                      label: const Text('Criar a partir de template'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (workouts.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Ainda não há treinos guardados. Cria o primeiro treino para começar a acompanhar o teu progresso.',
                    ),
                  ),
                ),
              for (final entry in workouts)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WorkoutDetailScreen(
                            database: widget.database,
                            entry: entry,
                          ),
                        ),
                      );
                      setState(() {});
                    },
                    child: WorkoutCard(entry: entry),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addWorkout() async {
    await _openWorkoutForm();
  }

  Future<void> _createFromTemplate() async {
    final template = await showModalBottomSheet<WorkoutTemplate>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'Escolher template',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            for (final item in WorkoutTemplateService.templates)
              ListTile(
                title: Text(item.name),
                subtitle: Text('${item.exerciseNames.length} exercícios'),
                onTap: () => Navigator.pop(context, item),
              ),
          ],
        ),
      ),
    );
    if (template == null) {
      return;
    }
    await _openWorkoutForm(template: template);
  }

  Future<void> _openWorkoutForm({WorkoutTemplate? template}) async {
    final types = await widget.database.workoutTypes();
    final customTemplates = await widget.database.workoutTemplates();
    final profileEquipment = await widget.database.availableEquipmentKeys();
    final profileLocation =
        widget.database.activeProfile?.trainingLocation ?? '';
    if (!mounted) return;
    var flow = template == null
        ? const TrainingFlowSelection(
            typeKey: 'strength',
            equipmentKey: 'bodyweight',
            regionKey: 'full_body',
          )
        : _flowForLegacyTemplate(template.name);
    var selection = TrainingFlow.toTrainingSelection(flow);
    var type = TrainingFlow.suggestedWorkoutName(flow);
    int? workoutTypeId = _typeIdFor(types, type);
    var date = DateTime.now();
    var selectedGroups = <String>{};
    final workoutName = TextEditingController(text: type);
    final duration = TextEditingController();
    final notes = TextEditingController();
    final savedEntry = await showModalBottomSheet<WorkoutEntry>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            MediaQuery.viewInsetsOf(context).bottom + 16,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                template == null ? 'Novo treino' : 'Novo treino por template',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(const Duration(days: 1)),
                  );
                  if (picked != null) {
                    setSheetState(() => date = picked);
                  }
                },
                icon: const Icon(Icons.calendar_today_outlined),
                label: Text(
                  '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
                ),
              ),
              const SizedBox(height: 10),
              _ChoiceTile(
                label: 'Tipo de treino',
                value: _flowTypeName(flow.typeKey),
                onTap: () async {
                  final picked = await _pickFromList<MapEntry<String, String>>(
                    title: 'Escolher tipo de treino',
                    items: TrainingFlow.types.entries.toList(),
                    labelFor: (item) => item.value,
                  );
                  if (picked == null) return;
                  setSheetState(() {
                    flow = _defaultFlowForType(picked.key);
                    selection = TrainingFlow.toTrainingSelection(flow);
                    type = TrainingFlow.suggestedWorkoutName(flow);
                    workoutName.text = type;
                    workoutTypeId = _typeIdFor(types, type);
                  });
                },
              ),
              const SizedBox(height: 8),
              if (flow.typeKey == 'strength') ...[
                _ChoiceTile(
                  label: 'Equipamento disponível',
                  value: flow.equipmentKey.isEmpty
                      ? 'Peso corporal'
                      : _equipmentName(flow.equipmentKey),
                  onTap: () async {
                    final picked = await _pickFromList<TrainingEquipment>(
                      title: 'Escolher equipamento',
                      items: _availableStrengthEquipment(profileEquipment),
                      labelFor: (item) => item.name,
                    );
                    if (picked == null) return;
                    setSheetState(() {
                      flow = flow.copyWith(equipmentKey: picked.key);
                      selection = TrainingFlow.toTrainingSelection(flow);
                      type = TrainingFlow.suggestedWorkoutName(flow);
                      workoutName.text = type;
                    });
                  },
                ),
                const SizedBox(height: 8),
                _ChoiceTile(
                  label: 'Região corporal',
                  value: _regionName(flow.regionKey),
                  onTap: () async {
                    final picked = await _pickFromList<TrainingRegion>(
                      title: 'Escolher região corporal',
                      items: _strengthRegions(),
                      labelFor: (item) => item.name,
                    );
                    if (picked == null) return;
                    setSheetState(() {
                      flow = flow.copyWith(
                        regionKey: picked.key,
                        groupKey: '',
                        subzoneKey: '',
                        focusKey: '',
                      );
                      selection = TrainingFlow.toTrainingSelection(flow);
                      type = TrainingFlow.suggestedWorkoutName(flow);
                      workoutName.text = type;
                      workoutTypeId = _typeIdFor(types, type);
                    });
                  },
                ),
                const SizedBox(height: 8),
                _ChoiceTile(
                  label: 'Grupo muscular',
                  value: flow.groupKey.isEmpty
                      ? 'Opcional'
                      : _groupName(flow.groupKey),
                  enabled: _strengthGroupsForRegion(flow.regionKey).isNotEmpty,
                  onTap: () async {
                    final picked = await _pickFromList<TrainingGroup>(
                      title: 'Escolher grupo muscular',
                      items: _strengthGroupsForRegion(flow.regionKey),
                      labelFor: (item) => item.name,
                      allowClear: true,
                    );
                    setSheetState(() {
                      flow = flow.copyWith(
                        groupKey: picked?.key ?? '',
                        subzoneKey: '',
                        focusKey: '',
                      );
                      selection = TrainingFlow.toTrainingSelection(flow);
                      type = TrainingFlow.suggestedWorkoutName(flow);
                      workoutName.text = type;
                      workoutTypeId = _typeIdFor(types, type);
                    });
                  },
                ),
                const SizedBox(height: 8),
                _ChoiceTile(
                  label: 'Subzona anatómica',
                  value: flow.subzoneKey.isEmpty
                      ? 'Opcional'
                      : _strengthFocusName(flow.subzoneKey),
                  enabled: _strengthSubzoneOptions(flow).isNotEmpty,
                  onTap: () async {
                    final picked =
                        await _pickFromList<MapEntry<String, String>>(
                          title: 'Escolher subzona anatómica',
                          items: _strengthSubzoneOptions(flow),
                          labelFor: (item) => item.value,
                          allowClear: true,
                        );
                    setSheetState(() {
                      flow = flow.copyWith(
                        subzoneKey: picked?.key ?? '',
                        focusKey: '',
                      );
                      selection = TrainingFlow.toTrainingSelection(flow);
                      type = TrainingFlow.suggestedWorkoutName(flow);
                      workoutName.text = type;
                      workoutTypeId = _typeIdFor(types, type);
                    });
                  },
                ),
                if (TrainingFlow.requiresStrengthSpecificFocus(
                  _strengthHierarchyGroupKey(flow),
                  flow.subzoneKey,
                )) ...[
                  const SizedBox(height: 8),
                  _ChoiceTile(
                    label: TrainingFlow.finalFocusLabel(flow.typeKey),
                    value: flow.focusKey.isEmpty
                        ? 'Opcional'
                        : _strengthFocusName(flow.focusKey),
                    enabled: _strengthSpecificOptions(flow).isNotEmpty,
                    onTap: () async {
                      final picked =
                          await _pickFromList<MapEntry<String, String>>(
                            title: 'Escolher músculo específico/foco',
                            items: _strengthSpecificOptions(flow),
                            labelFor: (item) => item.value,
                            allowClear: true,
                          );
                      setSheetState(() {
                        flow = flow.copyWith(focusKey: picked?.key ?? '');
                        selection = TrainingFlow.toTrainingSelection(flow);
                        type = TrainingFlow.suggestedWorkoutName(flow);
                        workoutName.text = type;
                        workoutTypeId = _typeIdFor(types, type);
                      });
                    },
                  ),
                ],
              ] else if (flow.typeKey == 'cardio') ...[
                _ChoiceTile(
                  label: 'Equipamento/modalidade',
                  value: _cardioModeName(flow),
                  onTap: () async {
                    final picked =
                        await _pickFromList<MapEntry<String, String>>(
                          title: 'Escolher modalidade',
                          items: _cardioModeOptions(
                            profileLocation,
                            profileEquipment,
                          ),
                          labelFor: (item) => item.value,
                        );
                    if (picked == null) return;
                    setSheetState(() {
                      flow = flow.copyWith(
                        equipmentKey: _equipmentKeyForCardioMode(picked.key),
                        cardioFocusKey: picked.key,
                      );
                      selection = TrainingFlow.toTrainingSelection(flow);
                      type = TrainingFlow.suggestedWorkoutName(flow);
                      workoutName.text = type;
                      workoutTypeId = _typeIdFor(types, type);
                    });
                  },
                ),
                const SizedBox(height: 8),
                _ChoiceTile(
                  label: TrainingFlow.finalFocusLabel(flow.typeKey),
                  value: _cardioFocusName(flow.cardioFocusKey),
                  onTap: () async {
                    final picked =
                        await _pickFromList<MapEntry<String, String>>(
                          title: 'Escolher foco cardio',
                          items: _cardioFocusOptions(flow.equipmentKey),
                          labelFor: (item) => item.value,
                        );
                    if (picked == null) return;
                    setSheetState(() {
                      flow = flow.copyWith(cardioFocusKey: picked.key);
                      selection = TrainingFlow.toTrainingSelection(flow);
                      type = TrainingFlow.suggestedWorkoutName(flow);
                      workoutName.text = type;
                      workoutTypeId = _typeIdFor(types, type);
                    });
                  },
                ),
              ] else if (flow.typeKey == 'martial_arts') ...[
                _ChoiceTile(
                  label: 'Arte marcial',
                  value: _martialName(flow.martialArtKey),
                  onTap: () async {
                    final picked =
                        await _pickFromList<MapEntry<String, String>>(
                          title: 'Escolher arte marcial',
                          items: TrainingFlow.martialLabels.entries.toList(),
                          labelFor: (item) => item.value,
                        );
                    if (picked == null) return;
                    setSheetState(() {
                      flow = flow.copyWith(martialArtKey: picked.key);
                      selection = TrainingFlow.toTrainingSelection(flow);
                      type = TrainingFlow.suggestedWorkoutName(flow);
                      workoutName.text = type;
                      workoutTypeId = _typeIdFor(types, type);
                    });
                  },
                ),
                const SizedBox(height: 8),
                _ChoiceTile(
                  label: TrainingFlow.finalFocusLabel(flow.typeKey),
                  value: _martialName(flow.martialArtKey),
                  enabled: false,
                  onTap: () {},
                ),
              ] else if (flow.typeKey == 'mobility') ...[
                _ChoiceTile(
                  label: TrainingFlow.finalFocusLabel(flow.typeKey),
                  value: _mobilityName(flow.mobilityZoneKey),
                  onTap: () async {
                    final picked =
                        await _pickFromList<MapEntry<String, String>>(
                          title: 'Escolher zona/foco',
                          items: TrainingFlow.mobilityLabels.entries.toList(),
                          labelFor: (item) => item.value,
                        );
                    if (picked == null) return;
                    setSheetState(() {
                      flow = flow.copyWith(mobilityZoneKey: picked.key);
                      selection = TrainingFlow.toTrainingSelection(flow);
                      type = TrainingFlow.suggestedWorkoutName(flow);
                      workoutName.text = type;
                      workoutTypeId = _typeIdFor(types, type);
                    });
                  },
                ),
              ] else if (flow.typeKey == 'recovery') ...[
                _ChoiceTile(
                  label: TrainingFlow.finalFocusLabel(flow.typeKey),
                  value: _recoveryName(flow.recoveryKey),
                  onTap: () async {
                    final picked =
                        await _pickFromList<MapEntry<String, String>>(
                          title: 'Escolher tipo de recuperação',
                          items: TrainingFlow.recoveryLabels.entries.toList(),
                          labelFor: (item) => item.value,
                        );
                    if (picked == null) return;
                    setSheetState(() {
                      flow = flow.copyWith(recoveryKey: picked.key);
                      selection = TrainingFlow.toTrainingSelection(flow);
                      type = TrainingFlow.suggestedWorkoutName(flow);
                      workoutName.text = type;
                      workoutTypeId = _typeIdFor(types, type);
                    });
                  },
                ),
              ],
              const SizedBox(height: 10),
              TextField(
                controller: workoutName,
                decoration: const InputDecoration(
                  labelText: 'Nome do treino',
                  prefixIcon: Icon(Icons.edit_outlined),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () async {
                  final created = await _createWorkoutType();
                  if (created != null) {
                    setSheetState(() {
                      type = created.name;
                      workoutTypeId = created.id;
                    });
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Criar tipo personalizado'),
              ),
              if (customTemplates.isNotEmpty) ...[
                const SizedBox(height: 8),
                DropdownButtonFormField<CustomWorkoutTemplate>(
                  items: customTemplates
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setSheetState(() {
                      type = value.name;
                      selectedGroups = value.muscleGroups
                          .split(',')
                          .where((item) => item.trim().isNotEmpty)
                          .map((item) => item.trim())
                          .toSet();
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Template personalizado',
                  ),
                ),
              ],
              const SizedBox(height: 10),
              TextField(
                controller: duration,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Duração em minutos',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: notes,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Notas'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () async {
                  final templateName = await _askTemplateName();
                  if (templateName == null) return;
                  await widget.database.insertWorkoutTemplate(
                    CustomWorkoutTemplate(
                      profileId: widget.database.activeProfileId!,
                      name: templateName,
                      description: notes.text.trim(),
                      workoutTypeId: workoutTypeId,
                      muscleGroups: selectedGroups.isEmpty
                          ? _groupsForSelection(selection, types, type)
                          : selectedGroups.join(', '),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Template guardado.')),
                    );
                  }
                },
                icon: const Icon(Icons.save_outlined),
                label: const Text('Guardar como template personalizado'),
              ),
              if (template != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Exercícios pré-carregados',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                for (final exerciseName in template.exerciseNames)
                  Text('⬢ $exerciseName'),
              ],
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () async {
                  final workout = Workout(
                    date: date,
                    workoutType: workoutName.text.trim().isEmpty
                        ? type
                        : workoutName.text.trim(),
                    workoutTypeId: workoutTypeId,
                    muscleGroups: selectedGroups.isEmpty
                        ? _groupsForSelection(selection, types, type)
                        : selectedGroups.join(', '),
                    regionKey: selection.regionKey,
                    groupKey: selection.groupKey,
                    subgroupKey: selection.subgroupKey,
                    specificMuscleKey: selection.specificMuscleKey,
                    equipmentKey: selection.equipmentKey,
                    durationMinutes: int.tryParse(duration.text),
                    notes: notes.text.trim(),
                  );
                  final id = template == null
                      ? await widget.database.insertWorkout(workout)
                      : await widget.database.insertWorkoutFromTemplate(
                          workout: workout,
                          exerciseNames: template.exerciseNames,
                        );
                  final entries = await widget.database.workouts();
                  final entry = entries.firstWhere(
                    (item) => item.workout.id == id,
                    orElse: () => WorkoutEntry(
                      workout: Workout(
                        id: id,
                        date: workout.date,
                        workoutType: workout.workoutType,
                        muscleGroups: workout.muscleGroups,
                        regionKey: workout.regionKey,
                        groupKey: workout.groupKey,
                        subgroupKey: workout.subgroupKey,
                        specificMuscleKey: workout.specificMuscleKey,
                        equipmentKey: workout.equipmentKey,
                        durationMinutes: workout.durationMinutes,
                        notes: workout.notes,
                      ),
                      sets: const [],
                    ),
                  );
                  if (context.mounted) Navigator.pop(context, entry);
                },
                child: const Text('Guardar treino'),
              ),
            ],
          ),
        ),
      ),
    );
    workoutName.dispose();
    duration.dispose();
    notes.dispose();
    if (savedEntry != null && mounted) {
      setState(() {});
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              WorkoutDetailScreen(database: widget.database, entry: savedEntry),
        ),
      );
      setState(() {});
    }
  }

  int? _typeIdFor(List<WorkoutType> types, String name) {
    for (final type in types) {
      if (type.name == name) return type.id;
    }
    return null;
  }

  TrainingFlowSelection _defaultFlowForType(String typeKey) {
    return switch (typeKey) {
      'strength' => const TrainingFlowSelection(
        typeKey: 'strength',
        equipmentKey: 'bodyweight',
        regionKey: 'full_body',
      ),
      'cardio' => const TrainingFlowSelection(
        typeKey: 'cardio',
        equipmentKey: 'bodyweight',
        cardioFocusKey: 'no_equipment',
      ),
      'martial_arts' => const TrainingFlowSelection(
        typeKey: 'martial_arts',
        martialArtKey: 'karate',
      ),
      'mobility' => const TrainingFlowSelection(
        typeKey: 'mobility',
        mobilityZoneKey: 'general_mobility',
      ),
      'recovery' => const TrainingFlowSelection(
        typeKey: 'recovery',
        recoveryKey: 'easy_walk',
      ),
      _ => const TrainingFlowSelection(typeKey: 'custom'),
    };
  }

  TrainingFlowSelection _flowForLegacyTemplate(String name) {
    final legacy = TrainingArchitecture.legacySelectionFor(name);
    if (legacy.regionKey == 'cardio') {
      return TrainingFlowSelection(
        typeKey: 'cardio',
        equipmentKey: legacy.equipmentKey.isEmpty
            ? legacy.subgroupKey
            : legacy.equipmentKey,
        cardioFocusKey: legacy.subgroupKey.isEmpty
            ? 'no_equipment'
            : legacy.subgroupKey,
      );
    }
    if (legacy.regionKey == 'martial_arts') {
      return TrainingFlowSelection(
        typeKey: 'martial_arts',
        martialArtKey: legacy.groupKey == 'jiu_jitsu' ? 'jiu_jitsu' : 'karate',
      );
    }
    if (legacy.regionKey == 'mobility_recovery') {
      return TrainingFlowSelection(
        typeKey: 'mobility',
        mobilityZoneKey: legacy.groupKey.isEmpty
            ? 'general_mobility'
            : legacy.groupKey,
      );
    }
    return TrainingFlowSelection(
      typeKey: 'strength',
      equipmentKey: legacy.equipmentKey.isEmpty
          ? 'bodyweight'
          : legacy.equipmentKey,
      regionKey: legacy.regionKey.isEmpty ? 'full_body' : legacy.regionKey,
      groupKey: legacy.groupKey,
    );
  }

  String _flowTypeName(String key) =>
      TrainingFlow.types[key] ?? TrainingFlow.types['custom']!;

  List<TrainingRegion> _strengthRegions() {
    const keys = {'full_body', 'upper', 'lower', 'core'};
    return TrainingArchitecture.regions
        .where((item) => keys.contains(item.key))
        .toList();
  }

  List<TrainingGroup> _strengthGroupsForRegion(String regionKey) {
    if (regionKey == 'full_body') {
      return const [];
    }
    return TrainingArchitecture.groupsForRegion(regionKey);
  }

  List<TrainingEquipment> _availableStrengthEquipment(Set<String> equipment) {
    final effective = {'bodyweight', 'none', ...equipment};
    return TrainingArchitecture.equipment
        .where((item) => effective.contains(item.key))
        .toList();
  }

  String _strengthHierarchyGroupKey(TrainingFlowSelection flow) {
    if (flow.regionKey == 'core') return 'core';
    if (flow.regionKey == 'lower') return 'legs';
    return flow.groupKey;
  }

  List<MapEntry<String, String>> _strengthSubzoneOptions(
    TrainingFlowSelection flow,
  ) {
    return TrainingFlow.strengthSubzonesForGroup(
      _strengthHierarchyGroupKey(flow),
    );
  }

  List<MapEntry<String, String>> _strengthSpecificOptions(
    TrainingFlowSelection flow,
  ) {
    return TrainingFlow.strengthSpecificOptions(
      _strengthHierarchyGroupKey(flow),
      flow.subzoneKey,
    );
  }

  String _strengthFocusName(String key) =>
      TrainingFlow.strengthFocusLabels[key] ?? key;

  List<MapEntry<String, String>> _cardioModeOptions(
    String trainingLocation,
    Set<String> equipment,
  ) {
    return TrainingFlow.availableCardioModes(
      trainingLocation: trainingLocation,
      availableEquipmentKeys: equipment,
    );
  }

  List<MapEntry<String, String>> _cardioFocusOptions(String equipmentKey) {
    final keys = switch (equipmentKey) {
      'treadmill' => ['treadmill', 'aerobic_endurance', 'hiit'],
      'bike' => ['bike', 'aerobic_endurance', 'hiit'],
      'elliptical' => ['elliptical', 'aerobic_endurance'],
      'jump_rope' => ['jump_rope', 'hiit'],
      'outdoor_space' => ['outdoor_walk', 'outdoor_run', 'hiit'],
      _ => ['no_equipment', 'hiit'],
    };
    return keys
        .map((key) => MapEntry(key, TrainingFlow.cardioLabels[key]!))
        .toList();
  }

  String _equipmentKeyForCardioMode(String modeKey) {
    return switch (modeKey) {
      'no_equipment' || 'hiit' => 'bodyweight',
      'outdoor_walk' || 'outdoor_run' => 'outdoor_space',
      _ => modeKey,
    };
  }

  String _cardioModeName(TrainingFlowSelection flow) {
    if (flow.cardioFocusKey == 'no_equipment') {
      return TrainingFlow.cardioLabels['no_equipment']!;
    }
    if (flow.cardioFocusKey == 'outdoor_walk' ||
        flow.cardioFocusKey == 'outdoor_run' ||
        flow.cardioFocusKey == 'hiit') {
      return TrainingFlow.cardioLabels[flow.cardioFocusKey]!;
    }
    return TrainingFlow.cardioLabels[flow.equipmentKey] ??
        _equipmentName(flow.equipmentKey);
  }

  String _cardioFocusName(String key) =>
      TrainingFlow.cardioLabels[key] ?? 'Sem equipamento';

  String _martialName(String key) =>
      TrainingFlow.martialLabels[key] ?? 'Karate';

  String _mobilityName(String key) =>
      TrainingFlow.mobilityLabels[key] ?? 'Geral';

  String _recoveryName(String key) =>
      TrainingFlow.recoveryLabels[key] ?? 'Caminhada leve';

  String _typeGroupsFor(List<WorkoutType> types, String name) {
    for (final type in types) {
      if (type.name == name && type.muscleGroups.trim().isNotEmpty) {
        return type.muscleGroups;
      }
    }
    return WorkoutTaxonomy.groupsFor(name).join(', ');
  }

  String _groupsForSelection(
    TrainingSelection selection,
    List<WorkoutType> types,
    String fallbackType,
  ) {
    final values = [
      if (selection.regionKey.isNotEmpty) _regionName(selection.regionKey),
      if (selection.groupKey.isNotEmpty) _groupName(selection.groupKey),
      if (selection.subgroupKey.isNotEmpty)
        _subgroupName(selection.subgroupKey),
      if (selection.specificMuscleKey.isNotEmpty)
        _muscleName(selection.specificMuscleKey),
      if (selection.equipmentKey.isNotEmpty)
        _equipmentName(selection.equipmentKey),
    ].where((item) => item.isNotEmpty).join(', ');
    if (values.isNotEmpty) return values;
    return _typeGroupsFor(types, fallbackType);
  }

  Future<T?> _pickFromList<T>({
    required String title,
    required List<T> items,
    required String Function(T item) labelFor,
    bool allowClear = false,
  }) async {
    if (items.isEmpty && !allowClear) return null;
    return showModalBottomSheet<T?>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            if (allowClear)
              ListTile(
                leading: const Icon(Icons.clear),
                title: const Text('Sem filtro específico'),
                onTap: () => Navigator.pop(context),
              ),
            for (final item in items)
              ListTile(
                title: Text(labelFor(item)),
                onTap: () => Navigator.pop(context, item),
              ),
          ],
        ),
      ),
    );
  }

  String _regionName(String key) {
    return TrainingArchitecture.regions
        .firstWhere(
          (item) => item.key == key,
          orElse: () => TrainingArchitecture.regions.first,
        )
        .name;
  }

  String _groupName(String key) {
    return TrainingArchitecture.groups
        .firstWhere(
          (item) => item.key == key,
          orElse: () => TrainingArchitecture.groups.first,
        )
        .name;
  }

  String _subgroupName(String key) {
    return TrainingArchitecture.subgroups
        .firstWhere(
          (item) => item.key == key,
          orElse: () => TrainingArchitecture.subgroups.first,
        )
        .name;
  }

  String _muscleName(String key) {
    return TrainingArchitecture.muscles
        .firstWhere(
          (item) => item.key == key,
          orElse: () => TrainingArchitecture.muscles.first,
        )
        .name;
  }

  String _equipmentName(String key) {
    return TrainingArchitecture.equipment
        .firstWhere(
          (item) => item.key == key,
          orElse: () => TrainingArchitecture.equipment.first,
        )
        .name;
  }

  Future<String?> _askTemplateName() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo template'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nome do template'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.isEmpty) return null;
    return name;
  }

  Future<WorkoutType?> _createWorkoutType() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo tipo de treino'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nome'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Criar'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.isEmpty) return null;
    final id = await widget.database.insertWorkoutType(name);
    return WorkoutType(
      id: id,
      profileId: widget.database.activeProfileId,
      name: name,
      isDefault: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.label,
    required this.value,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final String value;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(labelText: label),
      child: ListTile(
        enabled: enabled,
        contentPadding: EdgeInsets.zero,
        title: Text(value),
        trailing: const Icon(Icons.keyboard_arrow_down),
        onTap: enabled ? onTap : null,
      ),
    );
  }
}
