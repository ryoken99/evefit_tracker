import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';
import '../models/body_measurement.dart';
import '../widgets/measurement_card.dart';

class MeasurementsScreen extends StatefulWidget {
  const MeasurementsScreen({super.key, required this.database});
  final AppDatabase database;

  @override
  State<MeasurementsScreen> createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends State<MeasurementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openMeasurementForm(),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<BodyMeasurement>>(
        future: widget.database.measurements(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final measurements = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Medidas',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              for (final item in measurements)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => _openMeasurementDetails(item),
                    child: MeasurementCard(measurement: item),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openMeasurementDetails(BodyMeasurement measurement) async {
    final changed = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd/MM/yyyy').format(measurement.date),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Peso: ${_value(measurement.weightKg, 'kg')}'),
            Text(
              'Braço contraído: ${_value(measurement.rightBicepFlexedCm ?? measurement.leftBicepFlexedCm, 'cm')}',
            ),
            Text('Ombros: ${_value(measurement.shouldersCm, 'cm')}'),
            Text('Zona lateral: ${_value(measurement.sideHipAreaCm, 'cm')}'),
            if (measurement.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(measurement.notes),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                      await _openMeasurementForm(measurement: measurement);
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Apagar medição'),
                          content: const Text(
                            'Tens a certeza que queres apagar esta medição?',
                          ),
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
                        await widget.database.deleteMeasurement(
                          measurement.id!,
                        );
                        if (context.mounted) {
                          Navigator.pop(context, true);
                        }
                      }
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Apagar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    if (changed == true) {
      setState(() {});
    }
  }

  Future<void> _openMeasurementForm({BodyMeasurement? measurement}) async {
    final fields = _MeasurementFields(measurement);
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
            Text(
              measurement == null ? 'Nova medição' : 'Editar medição',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _Section(
              title: 'Peso e composição',
              children: [
                _NumberField(label: 'Peso', controller: fields.weight),
                _NumberField(
                  label: 'Gordura corporal %',
                  controller: fields.bodyFat,
                ),
                _NumberField(
                  label: 'Massa muscular',
                  controller: fields.muscleMass,
                ),
              ],
            ),
            _Section(
              title: 'Braços',
              children: [
                _NumberField(
                  label: 'Bíceps esquerdo relaxado',
                  controller: fields.leftRelaxed,
                ),
                _NumberField(
                  label: 'Bíceps esquerdo contraído',
                  controller: fields.leftFlexed,
                ),
                _NumberField(
                  label: 'Bíceps direito relaxado',
                  controller: fields.rightRelaxed,
                ),
                _NumberField(
                  label: 'Bíceps direito contraído',
                  controller: fields.rightFlexed,
                ),
              ],
            ),
            _Section(
              title: 'Tronco',
              children: [
                _NumberField(label: 'Ombros', controller: fields.shoulders),
                _NumberField(label: 'Peito', controller: fields.chest),
                _NumberField(label: 'Cintura', controller: fields.waist),
                _NumberField(
                  label: 'Zona lateral acima da anca',
                  controller: fields.sideHip,
                ),
                _NumberField(label: 'Abdómen', controller: fields.abdomen),
                _NumberField(label: 'Anca', controller: fields.hips),
              ],
            ),
            _Section(
              title: 'Pernas',
              children: [
                _NumberField(
                  label: 'Coxa esquerda',
                  controller: fields.leftThigh,
                ),
                _NumberField(
                  label: 'Coxa direita',
                  controller: fields.rightThigh,
                ),
                _NumberField(
                  label: 'Gémeo esquerdo',
                  controller: fields.leftCalf,
                ),
                _NumberField(
                  label: 'Gémeo direito',
                  controller: fields.rightCalf,
                ),
              ],
            ),
            _Section(
              title: 'Notas',
              children: [
                TextField(
                  controller: fields.notes,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: 'Notas'),
                ),
              ],
            ),
            FilledButton(
              onPressed: () async {
                final value = fields.toMeasurement(measurement);
                if (measurement == null) {
                  await widget.database.insertMeasurement(value);
                } else {
                  await widget.database.updateMeasurement(value);
                }
                if (context.mounted) Navigator.pop(context, true);
              },
              child: Text(
                measurement == null ? 'Guardar medição' : 'Guardar alterações',
              ),
            ),
          ],
        ),
      ),
    );
    fields.dispose();
    if (saved == true) {
      setState(() {});
    }
  }

  String _value(double? value, String unit) =>
      value == null ? '-' : '${value.toStringAsFixed(1)} $unit';
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...children.map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({required this.label, required this.controller});
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
    );
  }
}

class _MeasurementFields {
  _MeasurementFields(BodyMeasurement? measurement)
    : weight = _controller(measurement?.weightKg),
      bodyFat = _controller(measurement?.bodyFatPercentage),
      muscleMass = _controller(measurement?.muscleMassKg),
      leftRelaxed = _controller(measurement?.leftBicepRelaxedCm),
      leftFlexed = _controller(measurement?.leftBicepFlexedCm),
      rightRelaxed = _controller(measurement?.rightBicepRelaxedCm),
      rightFlexed = _controller(measurement?.rightBicepFlexedCm),
      shoulders = _controller(measurement?.shouldersCm),
      chest = _controller(measurement?.chestCm),
      waist = _controller(measurement?.waistCm),
      sideHip = _controller(measurement?.sideHipAreaCm),
      abdomen = _controller(measurement?.abdomenCm),
      hips = _controller(measurement?.hipsCm),
      leftThigh = _controller(measurement?.leftThighCm),
      rightThigh = _controller(measurement?.rightThighCm),
      leftCalf = _controller(measurement?.leftCalfCm),
      rightCalf = _controller(measurement?.rightCalfCm),
      notes = TextEditingController(text: measurement?.notes ?? '');

  final TextEditingController weight;
  final TextEditingController bodyFat;
  final TextEditingController muscleMass;
  final TextEditingController leftRelaxed;
  final TextEditingController leftFlexed;
  final TextEditingController rightRelaxed;
  final TextEditingController rightFlexed;
  final TextEditingController shoulders;
  final TextEditingController chest;
  final TextEditingController waist;
  final TextEditingController sideHip;
  final TextEditingController abdomen;
  final TextEditingController hips;
  final TextEditingController leftThigh;
  final TextEditingController rightThigh;
  final TextEditingController leftCalf;
  final TextEditingController rightCalf;
  final TextEditingController notes;

  BodyMeasurement toMeasurement(BodyMeasurement? existing) {
    return BodyMeasurement(
      id: existing?.id,
      date: existing?.date ?? DateTime.now(),
      weightKg: _num(weight),
      bodyFatPercentage: _num(bodyFat),
      muscleMassKg: _num(muscleMass),
      leftBicepRelaxedCm: _num(leftRelaxed),
      leftBicepFlexedCm: _num(leftFlexed),
      rightBicepRelaxedCm: _num(rightRelaxed),
      rightBicepFlexedCm: _num(rightFlexed),
      shouldersCm: _num(shoulders),
      chestCm: _num(chest),
      waistCm: _num(waist),
      sideHipAreaCm: _num(sideHip),
      abdomenCm: _num(abdomen),
      hipsCm: _num(hips),
      leftThighCm: _num(leftThigh),
      rightThighCm: _num(rightThigh),
      leftCalfCm: _num(leftCalf),
      rightCalfCm: _num(rightCalf),
      notes: notes.text.trim(),
    );
  }

  void dispose() {
    for (final controller in [
      weight,
      bodyFat,
      muscleMass,
      leftRelaxed,
      leftFlexed,
      rightRelaxed,
      rightFlexed,
      shoulders,
      chest,
      waist,
      sideHip,
      abdomen,
      hips,
      leftThigh,
      rightThigh,
      leftCalf,
      rightCalf,
      notes,
    ]) {
      controller.dispose();
    }
  }

  static TextEditingController _controller(double? value) =>
      TextEditingController(text: value?.toString() ?? '');

  static double? _num(TextEditingController controller) {
    final text = controller.text.trim().replaceAll(',', '.');
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }
}
