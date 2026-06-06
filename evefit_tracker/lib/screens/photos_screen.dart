import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';
import '../models/progress_photo.dart';
import '../services/photo_storage_service.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key, required this.database});
  final AppDatabase database;

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  static const types = [
    'Frente',
    'Lado esquerdo',
    'Lado direito',
    'Costas',
    'Pose de braço',
    'Outro',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addPhoto,
        child: const Icon(Icons.add_a_photo_outlined),
      ),
      body: FutureBuilder<List<ProgressPhoto>>(
        future: widget.database.photos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final photos = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Fotos',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Preparado para comparação futura: mantém fotos por data e tipo.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              if (photos.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Ainda não há fotos de progresso. Adiciona uma foto frontal, lateral ou de costas para acompanhar a evolução.',
                    ),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => _openPhoto(photo),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.file(
                                File(photo.filePath),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    photo.photoType,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(photo.date),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openPhoto(ProgressPhoto photo) async {
    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) =>
            _PhotoDetailScreen(database: widget.database, photo: photo),
      ),
    );
    if (changed == true) {
      setState(() {});
    }
  }

  Future<void> _addPhoto() async {
    var type = types.first;
    final weight = TextEditingController();
    final notes = TextEditingController();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Escolher da galeria'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Tirar foto'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
    );
    if (picked == null || !mounted) return;
    final saved = await showModalBottomSheet<bool>(
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
                'Guardar foto',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: type,
                items: types
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: (value) => setSheetState(() => type = value ?? type),
                decoration: const InputDecoration(labelText: 'Tipo'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: weight,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Peso opcional'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: notes,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Notas'),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () async {
                  final path = await PhotoStorageService().copyIntoAppStorage(
                    picked.path,
                  );
                  await widget.database.insertPhoto(
                    ProgressPhoto(
                      date: DateTime.now(),
                      photoType: type,
                      filePath: path,
                      weightKg: double.tryParse(
                        weight.text.replaceAll(',', '.'),
                      ),
                      notes: notes.text.trim(),
                    ),
                  );
                  if (context.mounted) Navigator.pop(context, true);
                },
                child: const Text('Guardar foto'),
              ),
            ],
          ),
        ),
      ),
    );
    weight.dispose();
    notes.dispose();
    if (saved == true) {
      setState(() {});
    }
  }
}

class _PhotoDetailScreen extends StatefulWidget {
  const _PhotoDetailScreen({required this.database, required this.photo});
  final AppDatabase database;
  final ProgressPhoto photo;

  @override
  State<_PhotoDetailScreen> createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends State<_PhotoDetailScreen> {
  late ProgressPhoto _photo = widget.photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_photo.photoType),
        actions: [
          IconButton(
            tooltip: 'Editar notas',
            onPressed: _editNotes,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Apagar foto',
            onPressed: _deletePhoto,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(_photo.filePath),
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const SizedBox(
                height: 240,
                child: Center(child: Icon(Icons.image_not_supported_outlined)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(DateFormat('dd/MM/yyyy').format(_photo.date)),
          if (_photo.weightKg != null) Text('${_photo.weightKg} kg'),
          const SizedBox(height: 8),
          Text(_photo.notes.isEmpty ? 'Sem notas.' : _photo.notes),
        ],
      ),
    );
  }

  Future<void> _editNotes() async {
    final notes = TextEditingController(text: _photo.notes);
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('Editar notas', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            TextField(
              controller: notes,
              minLines: 3,
              maxLines: 6,
              decoration: const InputDecoration(labelText: 'Notas'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () async {
                final updated = ProgressPhoto(
                  id: _photo.id,
                  date: _photo.date,
                  photoType: _photo.photoType,
                  filePath: _photo.filePath,
                  weightKg: _photo.weightKg,
                  notes: notes.text.trim(),
                );
                await widget.database.updatePhoto(updated);
                if (context.mounted) Navigator.pop(context, true);
                setState(() => _photo = updated);
              },
              child: const Text('Guardar notas'),
            ),
          ],
        ),
      ),
    );
    notes.dispose();
    if (saved == true && mounted) {
      setState(() {});
    }
  }

  Future<void> _deletePhoto() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apagar foto'),
        content: const Text('Tens a certeza que queres apagar esta foto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Apagar'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await widget.database.deletePhoto(_photo.id!);
      final file = File(_photo.filePath);
      if (await file.exists()) {
        await file.delete();
      }
      if (mounted) Navigator.pop(context, true);
    }
  }
}
