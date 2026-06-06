import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/workout.dart';
import '../models/workout_template.dart';
import '../models/workout_type.dart';
import '../services/training_architecture.dart';
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
    if (!mounted) return;
    var selection = template == null
        ? const TrainingSelection(regionKey: 'full_body')
        : TrainingArchitecture.legacySelectionFor(template.name);
    var type = TrainingArchitecture.labelForSelection(selection);
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
                label: 'Região corporal / domínio',
                value: _regionName(selection.regionKey),
                onTap: () async {
                  final picked = await _pickFromList<TrainingRegion>(
                    title: 'Escolher região',
                    items: TrainingArchitecture.regions,
                    labelFor: (item) => item.name,
                  );
                  if (picked == null) return;
                  setSheetState(() {
                    selection = TrainingSelection(regionKey: picked.key);
                    type = TrainingArchitecture.labelForSelection(selection);
                    workoutName.text = type;
                    workoutTypeId = _typeIdFor(types, type);
                  });
                },
              ),
              const SizedBox(height: 8),
              _ChoiceTile(
                label: 'Grupo principal',
                value: selection.groupKey.isEmpty
                    ? 'Escolher grupo'
                    : _groupName(selection.groupKey),
                enabled: selection.regionKey.isNotEmpty,
                onTap: () async {
                  final groups = TrainingArchitecture.groupsForRegion(
                    selection.regionKey,
                  );
                  final picked = await _pickFromList<TrainingGroup>(
                    title: 'Escolher grupo principal',
                    items: groups,
                    labelFor: (item) => item.name,
                  );
                  if (picked == null) return;
                  setSheetState(() {
                    selection = TrainingSelection(
                      regionKey: picked.regionKey,
                      groupKey: picked.key,
                    );
                    type = TrainingArchitecture.labelForSelection(selection);
                    workoutName.text = type;
                    workoutTypeId = _typeIdFor(types, type);
                  });
                },
              ),
              const SizedBox(height: 8),
              _ChoiceTile(
                label: 'Subgrupo / foco',
                value: selection.subgroupKey.isEmpty
                    ? 'Opcional'
                    : _subgroupName(selection.subgroupKey),
                enabled: selection.groupKey.isNotEmpty,
                onTap: () async {
                  final subgroups = TrainingArchitecture.subgroupsForGroup(
                    selection.groupKey,
                  );
                  final picked = await _pickFromList<TrainingSubgroup>(
                    title: 'Escolher subgrupo',
                    items: subgroups,
                    labelFor: (item) => item.name,
                    allowClear: true,
                  );
                  setSheetState(() {
                    selection = selection.copyWith(
                      subgroupKey: picked?.key ?? '',
                      specificMuscleKey: '',
                    );
                    type = TrainingArchitecture.labelForSelection(selection);
                    workoutName.text = type;
                    workoutTypeId = _typeIdFor(types, type);
                  });
                },
              ),
              const SizedBox(height: 8),
              _ChoiceTile(
                label: 'Músculo específico',
                value: selection.specificMuscleKey.isEmpty
                    ? 'Opcional'
                    : _muscleName(selection.specificMuscleKey),
                enabled: selection.subgroupKey.isNotEmpty,
                onTap: () async {
                  final muscles = TrainingArchitecture.musclesForSubgroup(
                    selection.subgroupKey,
                  );
                  final picked = await _pickFromList<TrainingMuscle>(
                    title: 'Escolher músculo específico',
                    items: muscles,
                    labelFor: (item) => item.name,
                    allowClear: true,
                  );
                  setSheetState(() {
                    selection = selection.copyWith(
                      specificMuscleKey: picked?.key ?? '',
                    );
                    type = TrainingArchitecture.labelForSelection(selection);
                    workoutName.text = type;
                    workoutTypeId = _typeIdFor(types, type);
                  });
                },
              ),
              const SizedBox(height: 8),
              _ChoiceTile(
                label: 'Equipamento/filtro',
                value: selection.equipmentKey.isEmpty
                    ? 'Opcional'
                    : _equipmentName(selection.equipmentKey),
                onTap: () async {
                  final picked = await _pickFromList<TrainingEquipment>(
                    title: 'Escolher equipamento',
                    items: TrainingArchitecture.equipment,
                    labelFor: (item) => item.name,
                    allowClear: true,
                  );
                  setSheetState(() {
                    selection = selection.copyWith(
                      equipmentKey: picked?.key ?? '',
                    );
                  });
                },
              ),
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
                  Text('• $exerciseName'),
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
      if (selection.subgroupKey.isNotEmpty) _subgroupName(selection.subgroupKey),
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
