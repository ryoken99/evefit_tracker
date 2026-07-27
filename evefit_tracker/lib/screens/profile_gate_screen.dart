import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../database/app_database.dart';
import '../models/profile.dart';
import '../services/pin_service.dart';
import '../services/profile_preferences_service.dart';
import '../services/training_location_service.dart';
import '../theme/eft_visual_identity.dart';

const _profileGateGradient = EftVisualIdentity.profileGradient;
const _profileGateForeground = EftVisualIdentity.foreground;
const _profileGateSecondary = EftVisualIdentity.secondaryForeground;
const _profileGateSurface = EftVisualIdentity.surface;
const _profileGateCardSurface = EftVisualIdentity.cardSurface;
const _profileGateBorder = EftVisualIdentity.border;

class ProfileGateScreen extends StatefulWidget {
  const ProfileGateScreen({
    super.key,
    required this.database,
    required this.onUnlocked,
    this.profilesLoader,
  });

  final AppDatabase database;
  final ValueChanged<Profile> onUnlocked;
  final Future<List<Profile>> Function()? profilesLoader;

  @override
  State<ProfileGateScreen> createState() => _ProfileGateScreenState();
}

class _ProfileGateScreenState extends State<ProfileGateScreen> {
  late Future<List<Profile>> _profilesFuture;

  @override
  void initState() {
    super.initState();
    _profilesFuture = _loadProfiles();
  }

  Future<List<Profile>> _loadProfiles() {
    return widget.profilesLoader?.call() ?? widget.database.profiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        key: const ValueKey('profile_gate_background'),
        decoration: const BoxDecoration(gradient: _profileGateGradient),
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.32, -0.76),
                  radius: 0.84,
                  colors: [
                    EftVisualIdentity.circuit.withValues(alpha: 0.09),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: FutureBuilder<List<Profile>>(
                    future: _profilesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 480),
                              child: _ProfileGateSurface(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      size: 40,
                                      color: _profileGateForeground,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Não foi possível carregar os perfis.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: _profileGateForeground,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Verifica a base de dados local e tenta novamente.',
                                      style: TextStyle(
                                        color: _profileGateSecondary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    FilledButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          _profilesFuture = _loadProfiles();
                                        });
                                      },
                                      icon: const Icon(Icons.refresh),
                                      label: const Text('Tentar novamente'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      if (!snapshot.hasData) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 480),
                              child: const SizedBox(
                                width: double.infinity,
                                child: _ProfileGateSurface(
                                  padding: EdgeInsets.fromLTRB(20, 18, 20, 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Escolher perfil',
                                        style: TextStyle(
                                          color: _profileGateForeground,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'A preparar os perfis...',
                                        style: TextStyle(
                                          color: _profileGateSecondary,
                                          height: 1.35,
                                        ),
                                      ),
                                      SizedBox(height: 18),
                                      LinearProgressIndicator(
                                        minHeight: 3,
                                        color: EftVisualIdentity.gold,
                                        backgroundColor: _profileGateBorder,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      final profiles = snapshot.data!;
                      if (profiles.isEmpty) {
                        return _CreateFirstProfile(
                          database: widget.database,
                          onCreated: widget.onUnlocked,
                        );
                      }
                      return ListView(
                        padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                        children: [
                          _ProfileGateSurface(
                            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Escolher perfil',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: _profileGateForeground,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Seleciona o perfil e introduz o PIN de 4 dígitos.',
                                  style: TextStyle(
                                    color: _profileGateSecondary,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          for (final profile in profiles)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Card(
                                color: _profileGateCardSurface,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: _profileGateBorder,
                                  ),
                                ),
                                child: ListTile(
                                  key: ValueKey('profile_option_${profile.id}'),
                                  minVerticalPadding: 16,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 4,
                                  ),
                                  leading: const _ProfileGateIcon(
                                    icon: Icons.person_outline,
                                  ),
                                  title: Text(
                                    profile.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: _profileGateForeground,
                                          fontWeight: FontWeight.w700,
                                          height: 1.25,
                                        ),
                                    maxLines: 2,
                                  ),
                                  subtitle: profile.trainingLocation.isEmpty
                                      ? null
                                      : Text(
                                          profile.trainingLocation,
                                          style: const TextStyle(
                                            color: _profileGateSecondary,
                                            height: 1.35,
                                          ),
                                        ),
                                  trailing: const _ProfileGateIcon(
                                    icon: Icons.lock_open_outlined,
                                  ),
                                  onTap: () => _unlock(profile),
                                ),
                              ),
                            ),
                          const SizedBox(height: 6),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: _profileGateSurface,
                              foregroundColor: _profileGateForeground,
                              side: const BorderSide(color: _profileGateBorder),
                              minimumSize: const Size.fromHeight(56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () async {
                              final created = await showCreateProfileSheet(
                                context: context,
                                database: widget.database,
                              );
                              if (created != null) {
                                widget.onUnlocked(created);
                              } else {
                                setState(() {
                                  _profilesFuture = _loadProfiles();
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _unlock(Profile profile) async {
    var enteredPin = '';
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(profile.name),
        content: TextField(
          key: const ValueKey('profile_unlock_pin'),
          onChanged: (value) => enteredPin = value,
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
            key: const ValueKey('profile_unlock_submit'),
            onPressed: () async {
              final valid = await widget.database.verifyProfilePin(
                profile,
                enteredPin,
              );
              if (context.mounted) Navigator.pop(context, valid);
            },
            child: const Text('Entrar'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await widget.database.setActiveProfile(profile);
      widget.onUnlocked(profile);
    } else if (ok == false && mounted) {
      final locked = await widget.database.isPinLocked(profile);
      if (!mounted) return;
      final message = locked
          ? 'Muitas tentativas. Tenta novamente dentro de 1 minuto.'
          : 'Código incorreto.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
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
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      children: [
        _ProfileGateSurface(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Configuração inicial',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: _profileGateForeground,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Cria o teu perfil local. A app não traz perfis pessoais pré-criados.',
                style: TextStyle(color: _profileGateSecondary, height: 1.35),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: _profileGateSurface,
            foregroundColor: _profileGateForeground,
            side: const BorderSide(color: _profileGateBorder),
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () async {
            final profile = await showCreateProfileSheet(
              context: context,
              database: database,
            );
            if (profile != null) onCreated(profile);
          },
          icon: const Icon(Icons.person_add_alt_1_outlined),
          label: const Text('Começar'),
        ),
      ],
    );
  }
}

class _ProfileGateSurface extends StatelessWidget {
  const _ProfileGateSurface({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _profileGateSurface,
        border: Border.all(color: _profileGateBorder),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class _ProfileGateIcon extends StatelessWidget {
  const _ProfileGateIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: EftVisualIdentity.circuit.withValues(alpha: 0.12),
          border: Border.all(
            color: EftVisualIdentity.circuit.withValues(alpha: 0.28),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: _profileGateForeground),
      ),
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
  final height = TextEditingController();
  final notes = TextEditingController();
  var step = 0;
  final selectedLocations = <String>{'Ginásio'};
  var sex = '';
  var activityLevel = '';
  DateTime? birthDate;
  final selectedEquipment = <String, String>{};
  final selectedGoals = <String>{};
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
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.86,
          child: ListView(
            children: [
              Text(
                'Configuração inicial',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 6),
              Text('Passo ${step + 1} de 4'),
              const SizedBox(height: 12),
              if (step == 0)
                _ProfileStep(
                  name: name,
                  pin: pin,
                  confirmPin: confirmPin,
                  height: height,
                  notes: notes,
                  sex: sex,
                  activityLevel: activityLevel,
                  birthDate: birthDate,
                  onSexChanged: (value) => setSheetState(() => sex = value),
                  onActivityChanged: (value) =>
                      setSheetState(() => activityLevel = value),
                  onBirthDateChanged: (value) =>
                      setSheetState(() => birthDate = value),
                )
              else if (step == 1)
                _TrainingLocationStep(
                  selectedLocations: selectedLocations,
                  onChanged: () => setSheetState(() {}),
                )
              else if (step == 2)
                _EquipmentStep(
                  hasGym: selectedLocations.contains('Ginásio'),
                  selectedEquipment: selectedEquipment,
                  onChanged: () => setSheetState(() {}),
                )
              else
                _GoalStep(
                  selectedGoals: selectedGoals,
                  onChanged: () => setSheetState(() {}),
                ),
              if (error != null) ...[
                const SizedBox(height: 10),
                Text(
                  error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  if (step > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setSheetState(() {
                          error = null;
                          step -= 1;
                        }),
                        child: const Text('Voltar'),
                      ),
                    ),
                  if (step > 0) const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        if (step == 0) {
                          if (name.text.trim().isEmpty) {
                            setSheetState(
                              () => error = 'O nome não pode estar vazio.',
                            );
                            return;
                          }
                          if (!PinService.isValidPin(pin.text)) {
                            setSheetState(
                              () => error =
                                  'O PIN deve ter exatamente 4 dígitos.',
                            );
                            return;
                          }
                          if (pin.text != confirmPin.text) {
                            setSheetState(
                              () => error =
                                  'O PIN e a confirmação devem coincidir.',
                            );
                            return;
                          }
                        }
                        if (step == 1 && selectedLocations.isEmpty) {
                          setSheetState(
                            () => error = 'Escolhe pelo menos um local.',
                          );
                          return;
                        }
                        if (step < 3) {
                          setSheetState(() {
                            error = null;
                            step += 1;
                          });
                          return;
                        }
                        final hasGym = selectedLocations.contains('Ginásio');
                        final profile = await database.createProfile(
                          name: name.text.trim(),
                          pin: pin.text,
                          heightCm: _optionalDouble(height.text),
                          birthDate: birthDate,
                          sex: sex,
                          activityLevel: activityLevel,
                          trainingLocations: selectedLocations.toList(),
                          initialGoals: selectedGoals.toList(),
                          availableEquipment: hasGym
                              ? AppDatabase.defaultEquipment
                              : selectedEquipment,
                          notes: notes.text,
                        );
                        if (context.mounted) Navigator.pop(context, profile);
                      },
                      child: Text(step < 3 ? 'Continuar' : 'Criar perfil'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
  for (final controller in [name, pin, confirmPin, height, notes]) {
    controller.dispose();
  }
  return created;
}

class _ProfileStep extends StatelessWidget {
  const _ProfileStep({
    required this.name,
    required this.pin,
    required this.confirmPin,
    required this.height,
    required this.notes,
    required this.sex,
    required this.activityLevel,
    required this.birthDate,
    required this.onSexChanged,
    required this.onActivityChanged,
    required this.onBirthDateChanged,
  });

  final TextEditingController name;
  final TextEditingController pin;
  final TextEditingController confirmPin;
  final TextEditingController height;
  final TextEditingController notes;
  final String sex;
  final String activityLevel;
  final DateTime? birthDate;
  final ValueChanged<String> onSexChanged;
  final ValueChanged<String> onActivityChanged;
  final ValueChanged<DateTime> onBirthDateChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          controller: height,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Altura opcional'),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          initialValue: sex.isEmpty ? null : sex,
          items: const ['Feminino', 'Masculino', 'Outro', 'Prefiro não indicar']
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: (value) => onSexChanged(value ?? ''),
          decoration: const InputDecoration(labelText: 'Sexo opcional'),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          initialValue: activityLevel.isEmpty ? null : activityLevel,
          items:
              const ['Sedentário', 'Leve', 'Moderado', 'Ativo', 'Muito ativo']
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
          onChanged: (value) => onActivityChanged(value ?? ''),
          decoration: const InputDecoration(labelText: 'Nível de atividade'),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) onBirthDateChanged(picked);
          },
          icon: const Icon(Icons.cake_outlined),
          label: Text(
            birthDate == null
                ? 'Data de nascimento opcional'
                : '${birthDate!.day.toString().padLeft(2, '0')}/${birthDate!.month.toString().padLeft(2, '0')}/${birthDate!.year}',
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: notes,
          minLines: 2,
          maxLines: 4,
          decoration: const InputDecoration(labelText: 'Notas opcionais'),
        ),
      ],
    );
  }
}

class _TrainingLocationStep extends StatelessWidget {
  const _TrainingLocationStep({
    required this.selectedLocations,
    required this.onChanged,
  });

  final Set<String> selectedLocations;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Onde treinas? Podes escolher mais do que um local.'),
        const SizedBox(height: 8),
        for (final option in TrainingLocationService.options)
          CheckboxListTile(
            value: selectedLocations.contains(option),
            title: Text(option),
            onChanged: (value) {
              if (value == true) {
                selectedLocations.add(option);
              } else {
                selectedLocations.remove(option);
              }
              onChanged();
            },
          ),
      ],
    );
  }
}

class _EquipmentStep extends StatelessWidget {
  const _EquipmentStep({
    required this.hasGym,
    required this.selectedEquipment,
    required this.onChanged,
  });

  final bool hasGym;
  final Map<String, String> selectedEquipment;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hasGym
              ? 'Ginásio selecionado: os equipamentos de ginásio ficam disponíveis. Se também treinas noutros locais, podes marcar equipamento adicional.'
              : 'Que equipamento tens disponível?',
        ),
        const SizedBox(height: 8),
        for (final section in ProfilePreferencesService.equipmentSections) ...[
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Text(
              section.title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          for (final option in section.options)
            CheckboxListTile(
              value: hasGym || selectedEquipment.containsKey(option.key),
              title: Text(option.name),
              onChanged: hasGym
                  ? null
                  : (value) {
                      if (value == true) {
                        selectedEquipment[option.key] = option.name;
                      } else {
                        selectedEquipment.remove(option.key);
                      }
                      onChanged();
                    },
            ),
        ],
      ],
    );
  }
}

class _GoalStep extends StatelessWidget {
  const _GoalStep({required this.selectedGoals, required this.onChanged});

  final Set<String> selectedGoals;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Escolhe objetivos iniciais.'),
        const SizedBox(height: 8),
        for (final section
            in ProfilePreferencesService.generalGoalSections) ...[
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Text(
              section.title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          for (final goal in section.options)
            CheckboxListTile(
              value: selectedGoals.contains(goal),
              title: Text(goal),
              onChanged: (value) {
                if (value == true) {
                  selectedGoals.add(goal);
                } else {
                  selectedGoals.remove(goal);
                }
                onChanged();
              },
            ),
        ],
      ],
    );
  }
}

double? _optionalDouble(String text) {
  final normalized = text.trim().replaceAll(',', '.');
  if (normalized.isEmpty) return null;
  return double.tryParse(normalized);
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
