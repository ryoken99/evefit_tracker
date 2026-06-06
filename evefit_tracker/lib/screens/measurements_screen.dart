import 'package:flutter/material.dart';

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
        onPressed: _addMeasurement,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<BodyMeasurement>>(
        future: widget.database.measurements(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
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
              for (final item in snapshot.data!)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MeasurementCard(measurement: item),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addMeasurement() async {
    final fields = <String, TextEditingController>{
      'Peso': TextEditingController(),
      'Gordura corporal %': TextEditingController(),
      'Massa muscular': TextEditingController(),
      'Bíceps esquerdo relaxado': TextEditingController(),
      'Bíceps esquerdo contraído': TextEditingController(),
      'Bíceps direito relaxado': TextEditingController(),
      'Bíceps direito contraído': TextEditingController(),
      'Ombros': TextEditingController(),
      'Peito': TextEditingController(),
      'Cintura': TextEditingController(),
      'Zona lateral acima da anca': TextEditingController(),
      'Abdómen': TextEditingController(),
      'Anca': TextEditingController(),
      'Coxa esquerda': TextEditingController(),
      'Coxa direita': TextEditingController(),
      'Gémeo esquerdo': TextEditingController(),
      'Gémeo direito': TextEditingController(),
      'Notas': TextEditingController(),
    };
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('Nova medição', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            for (final entry in fields.entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: entry.value,
                  keyboardType: entry.key == 'Notas'
                      ? TextInputType.multiline
                      : const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: entry.key),
                ),
              ),
            FilledButton(
              onPressed: () async {
                await widget.database.insertMeasurement(
                  BodyMeasurement(
                    date: DateTime.now(),
                    weightKg: _num(fields['Peso']),
                    bodyFatPercentage: _num(fields['Gordura corporal %']),
                    muscleMassKg: _num(fields['Massa muscular']),
                    leftBicepRelaxedCm: _num(
                      fields['Bíceps esquerdo relaxado'],
                    ),
                    leftBicepFlexedCm: _num(
                      fields['Bíceps esquerdo contraído'],
                    ),
                    rightBicepRelaxedCm: _num(
                      fields['Bíceps direito relaxado'],
                    ),
                    rightBicepFlexedCm: _num(
                      fields['Bíceps direito contraído'],
                    ),
                    shouldersCm: _num(fields['Ombros']),
                    chestCm: _num(fields['Peito']),
                    waistCm: _num(fields['Cintura']),
                    sideHipAreaCm: _num(fields['Zona lateral acima da anca']),
                    abdomenCm: _num(fields['Abdómen']),
                    hipsCm: _num(fields['Anca']),
                    leftThighCm: _num(fields['Coxa esquerda']),
                    rightThighCm: _num(fields['Coxa direita']),
                    leftCalfCm: _num(fields['Gémeo esquerdo']),
                    rightCalfCm: _num(fields['Gémeo direito']),
                    notes: fields['Notas']!.text,
                  ),
                );
                if (context.mounted) Navigator.pop(context, true);
              },
              child: const Text('Guardar medição'),
            ),
          ],
        ),
      ),
    );
    for (final c in fields.values) {
      c.dispose();
    }
    if (saved == true) setState(() {});
  }

  double? _num(TextEditingController? controller) =>
      double.tryParse(controller?.text.replaceAll(',', '.') ?? '');
}
