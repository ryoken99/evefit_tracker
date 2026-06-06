import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../database/app_database.dart';
import '../models/profile.dart';
import '../services/pin_service.dart';

class ProfileGateScreen extends StatefulWidget {
  const ProfileGateScreen({
    super.key,
    required this.database,
    required this.onUnlocked,
  });

  final AppDatabase database;
  final ValueChanged<Profile> onUnlocked;

  @override
  State<ProfileGateScreen> createState() => _ProfileGateScreenState();
}

class _ProfileGateScreenState extends State<ProfileGateScreen> {
  late Future<List<Profile>> _profilesFuture = widget.database.profiles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Profile>>(
          future: _profilesFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final profiles = snapshot.data!;
            if (profiles.isEmpty) {
              return _CreateFirstProfile(
                database: widget.database,
                onCreated: widget.onUnlocked,
              );
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Escolher perfil',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Seleciona o perfil e introduz o PIN de 4 dígitos.'),
                const SizedBox(height: 16),
                for (final profile in profiles)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: Text(profile.name),
                        subtitle: profile.notes.isEmpty
                            ? null
                            : Text(
                                profile.notes.replaceAll(
                                  'PIN_PADRAO_1234',
                                  'PIN padrão ativo',
                                ),
                              ),
                        trailing: const Icon(Icons.lock_open_outlined),
                        onTap: () => _unlock(profile),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () async {
                    final created = await showCreateProfileSheet(
                      context: context,
                      database: widget.database,
                    );
                    if (created != null) {
                      widget.onUnlocked(created);
                    } else {
                      setState(() {
                        _profilesFuture = widget.database.profiles();
                      });
                    }
                  },
                  icon: const Icon(Icons.person_add_alt_1_outlined),
                  label: const Text('Criar novo perfil'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _unlock(Profile profile) async {
    final pin = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(profile.name),
        content: TextField(
          controller: pin,
          autofocus: true,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 4,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
          ],
          decoration: const InputDecoration(labelText: 'PIN'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              final valid = await widget.database.verifyProfilePin(
                profile,
                pin.text,
              );
              if (context.mounted) Navigator.pop(context, valid);
            },
            child: const Text('Entrar'),
          ),
        ],
      ),
    );
    pin.dispose();
    if (ok == true) {
      await widget.database.setActiveProfile(profile);
      widget.onUnlocked(profile);
    } else if (ok == false && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Código incorreto.')));
    }
  }
}

class _CreateFirstProfile extends StatelessWidget {
  const _CreateFirstProfile({required this.database, required this.onCreated});
  final AppDatabase database;
  final ValueChanged<Profile> onCreated;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Criar primeiro perfil',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Cria um perfil local com PIN de 4 dígitos.'),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () async {
            final profile = await showCreateProfileSheet(
              context: context,
              database: database,
            );
            if (profile != null) onCreated(profile);
          },
          icon: const Icon(Icons.person_add_alt_1_outlined),
          label: const Text('Criar perfil'),
        ),
      ],
    );
  }
}

Future<Profile?> showCreateProfileSheet({
  required BuildContext context,
  required AppDatabase database,
}) async {
  final name = TextEditingController();
  final pin = TextEditingController();
  final confirmPin = TextEditingController();
  final notes = TextEditingController();
  String? error;
  final created = await showModalBottomSheet<Profile>(
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
              'Criar novo perfil',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Nome do perfil'),
            ),
            const SizedBox(height: 10),
            _PinField(controller: pin, label: 'PIN de 4 dígitos'),
            const SizedBox(height: 10),
            _PinField(controller: confirmPin, label: 'Confirmar PIN'),
            const SizedBox(height: 10),
            TextField(
              controller: notes,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Notas opcionais'),
            ),
            if (error != null) ...[
              const SizedBox(height: 10),
              Text(
                error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () async {
                final profileName = name.text.trim();
                if (profileName.isEmpty) {
                  setSheetState(() => error = 'O nome não pode estar vazio.');
                  return;
                }
                if (!PinService.isValidPin(pin.text)) {
                  setSheetState(
                    () => error = 'O PIN deve ter exatamente 4 dígitos.',
                  );
                  return;
                }
                if (pin.text != confirmPin.text) {
                  setSheetState(
                    () => error = 'O PIN e a confirmação devem coincidir.',
                  );
                  return;
                }
                final profile = await database.createProfile(
                  name: profileName,
                  pin: pin.text,
                  notes: notes.text,
                );
                if (context.mounted) Navigator.pop(context, profile);
              },
              child: const Text('Criar perfil'),
            ),
          ],
        ),
      ),
    ),
  );
  name.dispose();
  pin.dispose();
  confirmPin.dispose();
  notes.dispose();
  return created;
}

class _PinField extends StatelessWidget {
  const _PinField({required this.controller, required this.label});
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      keyboardType: TextInputType.number,
      maxLength: 4,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      decoration: InputDecoration(labelText: label, counterText: ''),
    );
  }
}
