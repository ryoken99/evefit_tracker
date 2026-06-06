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
              const SizedBox(height: 12),
              if (photos.isEmpty)
                const Text('Ainda não há fotos de progresso.'),
              for (final photo in photos)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(
                          File(photo.filePath),
                          width: 58,
                          height: 58,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              const Icon(Icons.image_not_supported_outlined),
                        ),
                      ),
                      title: Text(
                        '${photo.photoType} · ${DateFormat('dd/MM/yyyy').format(photo.date)}',
                      ),
                      subtitle: Text(
                        '${photo.weightKg == null ? '' : '${photo.weightKg} kg · '}${photo.notes}',
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
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
    if (source == null) {
      return;
    }
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
    );
    if (picked == null || !mounted) {
      return;
    }
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
