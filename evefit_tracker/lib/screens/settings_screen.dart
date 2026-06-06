import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../database/app_database.dart';
import '../models/profile.dart';
import '../services/pin_service.dart';
import '../services/training_location_service.dart';
import 'profile_gate_screen.dart';

const appVersionLabel = 'v0.5.2';
const githubRepoUrl = 'https://github.com/ryoken99/evefit_tracker';
const githubLatestReleaseUrl = '$githubRepoUrl/releases/latest';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.database,
    required this.onProfileLocked,
    required this.onProfileChanged,
  });

  final AppDatabase database;
  final VoidCallback onProfileLocked;
  final ValueChanged<Profile> onProfileChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final profile = widget.database.activeProfile;
    return Scaffold(
      appBar: AppBar(title: const Text('Definições')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Versão instalada: $appVersionLabel'),
          const SizedBox(height: 16),
          Text('Atualizações', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () => _openUrl(githubLatestReleaseUrl),
            icon: const Icon(Icons.system_update_alt),
            label: const Text('Ver atualizações v0.5.2'),
          ),
          TextButton.icon(
            onPressed: () => _openUrl(githubRepoUrl),
            icon: const Icon(Icons.open_in_new),
            label: const Text('Abrir GitHub'),
          ),
          const SizedBox(height: 16),
          Text('Perfil ativo', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(profile?.name ?? 'Sem perfil'),
              subtitle: Text(
                [
                  if (profile?.trainingLocation.isNotEmpty == true)
                    profile!.trainingLocation,
                  if (profile?.initialGoals.isNotEmpty == true)
                    profile!.initialGoals,
                  if (profile?.notes.isNotEmpty == true) profile!.notes,
                ].join('\n'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: widget.onProfileLocked,
            icon: const Icon(Icons.switch_account_outlined),
            label: const Text('Trocar perfil'),
          ),
          OutlinedButton.icon(
            onPressed: _createProfile,
            icon: const Icon(Icons.person_add_alt_1_outlined),
            label: const Text('Criar novo perfil'),
          ),
          OutlinedButton.icon(
            onPressed: profile == null ? null : () => _editProfile(profile),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Editar perfil atual'),
          ),
          FilledButton.tonalIcon(
            onPressed: widget.onProfileLocked,
            icon: const Icon(Icons.lock_outline),
            label: const Text('Bloquear perfil'),
          ),
        ],
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<void> _createProfile() async {
    final profile = await showCreateProfileSheet(
      context: context,
      database: widget.database,
    );
    if (profile != null) {
      widget.onProfileChanged(profile);
      if (mounted) setState(() {});
    }
  }

  Future<void> _editProfile(Profile profile) async {
    final name = TextEditingController(text: profile.name);
    final notes = TextEditingController(text: profile.notes.trim());
    final currentPin = TextEditingController();
    final newPin = TextEditingController();
    final confirmPin = TextEditingController();
    final selectedLocations = TrainingLocationService.parse(
      profile.trainingLocation,
    );
    String? error;
    final saved = await showModalBottomSheet<Profile>(
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
                'Editar perfil',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: notes,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Notas'),
              ),
              const SizedBox(height: 16),
              Text(
                'Onde treinas?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              for (final option in TrainingLocationService.options)
                CheckboxListTile(
                  value: selectedLocations.contains(option),
                  title: Text(option),
                  onChanged: (value) => setSheetState(() {
                    if (value == true) {
                      selectedLocations.add(option);
                    } else {
                      selectedLocations.remove(option);
                    }
                  }),
                ),
              const SizedBox(height: 16),
              Text(
                'Alterar PIN',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              _PinField(controller: currentPin, label: 'PIN atual'),
              const SizedBox(height: 10),
              _PinField(controller: newPin, label: 'Novo PIN'),
              const SizedBox(height: 10),
              _PinField(controller: confirmPin, label: 'Confirmar novo PIN'),
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
                  if (name.text.trim().isEmpty) {
                    setSheetState(() => error = 'O nome não pode estar vazio.');
                    return;
                  }
                  var pinHash = profile.pinHash;
                  final wantsPinChange =
                      currentPin.text.isNotEmpty ||
                      newPin.text.isNotEmpty ||
                      confirmPin.text.isNotEmpty;
                  if (wantsPinChange) {
                    final currentOk = await widget.database.verifyProfilePin(
                      profile,
                      currentPin.text,
                    );
                    if (!currentOk) {
                      setSheetState(() => error = 'PIN atual incorreto.');
                      return;
                    }
                    if (!PinService.isValidPin(newPin.text)) {
                      setSheetState(
                        () =>
                            error = 'O novo PIN deve ter exatamente 4 dígitos.',
                      );
                      return;
                    }
                    if (newPin.text != confirmPin.text) {
                      setSheetState(
                        () => error =
                            'O novo PIN e a confirmação devem coincidir.',
                      );
                      return;
                    }
                    pinHash = PinService.hashPin(newPin.text);
                  }
                  final updated = profile.copyWith(
                    name: name.text.trim(),
                    pinHash: pinHash,
                    trainingLocation: TrainingLocationService.serialize(
                      selectedLocations,
                    ),
                    notes: notes.text.trim(),
                    updatedAt: DateTime.now(),
                  );
                  await widget.database.updateProfile(updated);
                  if (context.mounted) Navigator.pop(context, updated);
                },
                child: const Text('Guardar perfil'),
              ),
            ],
          ),
        ),
      ),
    );
    for (final controller in [name, notes, currentPin, newPin, confirmPin]) {
      controller.dispose();
    }
    if (saved != null) {
      widget.onProfileChanged(saved);
      if (mounted) setState(() {});
    }
  }
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
