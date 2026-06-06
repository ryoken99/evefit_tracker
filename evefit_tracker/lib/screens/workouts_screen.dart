import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../models/workout.dart';
import '../models/workout_template.dart';
import '../models/workout_type.dart';
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
    var type = template?.name ?? (types.isEmpty ? 'Outro' : types.first.name);
    int? workoutTypeId = _typeIdFor(types, type);
    var date = DateTime.now();
    var selectedGroups = <String>{};
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
              InputDecorator(
                decoration: const InputDecoration(labelText: 'Tipo de treino'),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(type),
                  subtitle: Text(
                    WorkoutTaxonomy.sectionFor(type)?.title ?? 'Personalizado',
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_down),
                  onTap: () async {
                    final picked = await _pickWorkoutType(types);
                    if (picked == null) return;
                    setSheetState(() {
                      type = picked.name;
                      workoutTypeId = picked.id;
                    });
                  },
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
                          ? _typeGroupsFor(types, type)
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
                    workoutType: type,
                    workoutTypeId: workoutTypeId,
                    muscleGroups: selectedGroups.isEmpty
                        ? _typeGroupsFor(types, type)
                        : selectedGroups.join(', '),
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

  Future<WorkoutType?> _pickWorkoutType(List<WorkoutType> databaseTypes) async {
    final now = DateTime.now();
    final byName = {
      for (final type in databaseTypes) type.name: type,
      for (final name in WorkoutTaxonomy.defaultTypeNames)
        name: WorkoutType(
          name: name,
          muscleGroups: WorkoutTaxonomy.groupsFor(name).join(', '),
          isDefault: true,
          createdAt: now,
          updatedAt: now,
        ),
    };
    var query = '';
    return showModalBottomSheet<WorkoutType>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          final normalizedQuery = WorkoutTaxonomy.normalize(query);
          bool matches(String name) {
            if (normalizedQuery.isEmpty) return true;
            final section = WorkoutTaxonomy.sectionFor(name)?.title ?? '';
            return WorkoutTaxonomy.normalize(
              '$section $name',
            ).contains(normalizedQuery);
          }

          final customTypes =
              byName.values
                  .where(
                    (type) => WorkoutTaxonomy.sectionFor(type.name) == null,
                  )
                  .where((type) => matches(type.name))
                  .toList()
                ..sort((a, b) => a.name.compareTo(b.name));

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                0,
                16,
                MediaQuery.viewInsetsOf(context).bottom + 16,
              ),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.82,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selecionar tipo de treino',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Pesquisar tipo',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) =>
                          setSheetState(() => query = value.trim()),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView(
                        children: [
                          for (final section in WorkoutTaxonomy.sections) ...[
                            if (section.types.any(matches)) ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  bottom: 4,
                                ),
                                child: Text(
                                  section.title,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              for (final name in section.types.where(matches))
                                ListTile(
                                  dense: true,
                                  title: Text(name),
                                  onTap: () =>
                                      Navigator.pop(context, byName[name]),
                                ),
                            ],
                          ],
                          if (customTypes.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 4,
                              ),
                              child: Text(
                                'Personalizado',
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            for (final type in customTypes)
                              ListTile(
                                dense: true,
                                title: Text(type.name),
                                onTap: () => Navigator.pop(context, type),
                              ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
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
