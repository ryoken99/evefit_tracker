import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';
import '../models/body_measurement.dart';
import '../services/body_data_service.dart';
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
                'Dados',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Regista valores de balança, composição corporal, medidas e dados avançados opcionais.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              if (measurements.isEmpty)
                const Text('Ainda não existem registos corporais.'),
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
              DateFormat('dd/MM/yyyy').format(measurement.date),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            for (final section in _detailSections(measurement))
              if (section.rows.isNotEmpty)
                _DetailSection(title: section.title, rows: section.rows),
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
                          title: const Text('Apagar registo'),
                          content: const Text(
                            'Tens a certeza que queres apagar este registo corporal?',
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
    final fields = _MeasurementFields(
      measurement,
      profileHeightCm: widget.database.activeProfile?.heightCm,
    );
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
              measurement == null
                  ? 'Novo registo corporal'
                  : 'Editar registo corporal',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            Text(
              'Campos vazios ficam por preencher. As referências são estimativas gerais e não substituem avaliação médica ou profissional.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            for (final section in _formSections)
              _FormSection(section: section, fields: fields),
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
                measurement == null ? 'Guardar dados' : 'Guardar alterações',
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

  List<_DetailSectionData> _detailSections(BodyMeasurement measurement) {
    final values = _MeasurementFields.valuesFrom(measurement);
    return _formSections
        .where((section) => section.title != 'Notas')
        .map(
          (section) => _DetailSectionData(
            section.title,
            section.fields
                .map((field) {
                  final value = values[field.key];
                  if (value == null || value.isEmpty) return null;
                  return _DetailRowData(field.label, '$value${field.unitText}');
                })
                .whereType<_DetailRowData>()
                .toList(),
          ),
        )
        .toList();
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({required this.section, required this.fields});
  final _SectionSpec section;
  final _MeasurementFields fields;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      initiallyExpanded: section.initiallyExpanded,
      title: Text(section.title),
      children: [
        for (final field in section.fields)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: field.isText
                ? TextField(
                    controller: fields.controller(field.key),
                    decoration: InputDecoration(labelText: field.label),
                  )
                : _NumberField(
                    label: field.label,
                    controller: fields.controller(field.key),
                  ),
          ),
        if (section.title == 'Notas')
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: fields.notes,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Notas'),
            ),
          ),
      ],
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.rows});
  final String title;
  final List<_DetailRowData> rows;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          for (final row in rows)
            _DetailRow(label: row.label, value: row.value),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
          ),
          Text(value),
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
  _MeasurementFields(BodyMeasurement? measurement, {double? profileHeightCm})
    : notes = TextEditingController(text: measurement?.notes ?? '') {
    final values = valuesFrom(measurement);
    if ((values['height_cm'] ?? '').isEmpty && profileHeightCm != null) {
      values['height_cm'] = profileHeightCm.toString();
    }
    for (final field in _allFields) {
      _controllers[field.key] = TextEditingController(
        text: values[field.key] ?? '',
      );
    }
  }

  final TextEditingController notes;
  final Map<String, TextEditingController> _controllers = {};

  TextEditingController controller(String key) => _controllers[key]!;

  BodyMeasurement toMeasurement(BodyMeasurement? existing) {
    final height = _num('height_cm');
    final weight = _num('weight_kg');
    final waist = _num('waist_cm');
    final hips = _num('hips_cm');
    return BodyMeasurement(
      id: existing?.id,
      profileId: existing?.profileId,
      date: existing?.date ?? DateTime.now(),
      heightCm: height,
      weightKg: weight,
      bmi: _num('scale_bmi'),
      scaleBmi: _num('scale_bmi'),
      calculatedBmi: BodyDataService.calculateBmi(
        weightKg: weight,
        heightCm: height,
      ),
      bodyScore: _num('body_score'),
      bodyFatPercentage: _num('body_fat_percentage'),
      fatMassKg: _num('fat_mass_kg'),
      fatFreeBodyWeightKg: _num('fat_free_body_weight_kg'),
      muscleMassKg: _num('muscle_mass_kg'),
      musclePercentage: _num('muscle_percentage'),
      skeletalMuscleMassKg: _num('skeletal_muscle_mass_kg'),
      boneMassKg: _num('bone_mass_kg'),
      bodyWaterPercentage: _num('body_water_percentage'),
      proteinPercentage: _num('protein_percentage'),
      subcutaneousFatPercentage: _num('subcutaneous_fat_percentage'),
      visceralFat: _num('visceral_fat'),
      basalMetabolismKcal: _num('basal_metabolism_kcal'),
      bodyAge: _num('body_age'),
      standardWeightKg: _num('standard_weight_kg'),
      weightControlKg: _num('weight_control_kg'),
      fatControlKg: _num('fat_control_kg'),
      muscleControlKg: _num('muscle_control_kg'),
      restingHeartRateBpm: _num('resting_heart_rate_bpm'),
      bodyType: _text('body_type'),
      neckCm: _num('neck_cm'),
      shouldersCm: _num('shoulders_cm'),
      upperChestCm: _num('upper_chest_cm'),
      midChestCm: _num('mid_chest_cm'),
      lowerChestCm: _num('lower_chest_cm'),
      chestCm: _num('chest_cm'),
      backWidthCm: _num('back_width_cm'),
      waistCm: waist,
      abdomenCm: _num('abdomen_cm'),
      sideHipAreaCm: _num('side_hip_area_cm'),
      hipsCm: hips,
      glutesCm: _num('glutes_cm'),
      waistToHipRatio: BodyDataService.waistToHipRatio(
        waistCm: waist,
        hipsCm: hips,
      ),
      waistToHeightRatio: BodyDataService.waistToHeightRatio(
        waistCm: waist,
        heightCm: height,
      ),
      leftBicepRelaxedCm: _num('left_bicep_relaxed_cm'),
      leftBicepFlexedCm: _num('left_bicep_flexed_cm'),
      rightBicepRelaxedCm: _num('right_bicep_relaxed_cm'),
      rightBicepFlexedCm: _num('right_bicep_flexed_cm'),
      leftForearmCm: _num('left_forearm_cm'),
      rightForearmCm: _num('right_forearm_cm'),
      leftWristCm: _num('left_wrist_cm'),
      rightWristCm: _num('right_wrist_cm'),
      leftHandCm: _num('left_hand_cm'),
      rightHandCm: _num('right_hand_cm'),
      leftUpperThighCm: _num('left_upper_thigh_cm'),
      leftMidThighCm: _num('left_mid_thigh_cm'),
      rightUpperThighCm: _num('right_upper_thigh_cm'),
      rightMidThighCm: _num('right_mid_thigh_cm'),
      leftCalfCm: _num('left_calf_cm'),
      rightCalfCm: _num('right_calf_cm'),
      leftAnkleCm: _num('left_ankle_cm'),
      rightAnkleCm: _num('right_ankle_cm'),
      skinfoldChestMm: _num('chest_skinfold_mm'),
      skinfoldAbdominalMm: _num('abdominal_skinfold_mm'),
      skinfoldSuprailiacMm: _num('suprailiac_skinfold_mm'),
      skinfoldSubscapularMm: _num('subscapular_skinfold_mm'),
      skinfoldTricepsMm: _num('triceps_skinfold_mm'),
      skinfoldMidaxillaryMm: _num('midaxillary_skinfold_mm'),
      skinfoldThighMm: _num('thigh_skinfold_mm'),
      bicepsSkinfoldMm: _num('biceps_skinfold_mm'),
      medialCalfSkinfoldMm: _num('medial_calf_skinfold_mm'),
      notes: notes.text.trim(),
    );
  }

  void dispose() {
    for (final controller in [..._controllers.values, notes]) {
      controller.dispose();
    }
  }

  double? _num(String key) {
    final text = _text(key).replaceAll(',', '.');
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }

  String _text(String key) => controller(key).text.trim();

  static Map<String, String> valuesFrom(BodyMeasurement? measurement) {
    if (measurement == null) return {};
    String n(double? value) => value?.toString() ?? '';
    return {
      'height_cm': n(measurement.heightCm),
      'weight_kg': n(measurement.weightKg),
      'scale_bmi': n(measurement.scaleBmi ?? measurement.bmi),
      'calculated_bmi': n(measurement.calculatedBmi),
      'body_score': n(measurement.bodyScore),
      'body_fat_percentage': n(measurement.bodyFatPercentage),
      'fat_mass_kg': n(measurement.fatMassKg),
      'fat_free_body_weight_kg': n(measurement.fatFreeBodyWeightKg),
      'muscle_mass_kg': n(measurement.muscleMassKg),
      'muscle_percentage': n(measurement.musclePercentage),
      'skeletal_muscle_mass_kg': n(measurement.skeletalMuscleMassKg),
      'bone_mass_kg': n(measurement.boneMassKg),
      'body_water_percentage': n(measurement.bodyWaterPercentage),
      'protein_percentage': n(measurement.proteinPercentage),
      'subcutaneous_fat_percentage': n(measurement.subcutaneousFatPercentage),
      'visceral_fat': n(measurement.visceralFat),
      'basal_metabolism_kcal': n(measurement.basalMetabolismKcal),
      'body_age': n(measurement.bodyAge),
      'standard_weight_kg': n(measurement.standardWeightKg),
      'weight_control_kg': n(measurement.weightControlKg),
      'fat_control_kg': n(measurement.fatControlKg),
      'muscle_control_kg': n(measurement.muscleControlKg),
      'resting_heart_rate_bpm': n(measurement.restingHeartRateBpm),
      'body_type': measurement.bodyType,
      'neck_cm': n(measurement.neckCm),
      'shoulders_cm': n(measurement.shouldersCm),
      'upper_chest_cm': n(measurement.upperChestCm),
      'mid_chest_cm': n(measurement.midChestCm),
      'lower_chest_cm': n(measurement.lowerChestCm),
      'chest_cm': n(measurement.chestCm),
      'back_width_cm': n(measurement.backWidthCm),
      'waist_cm': n(measurement.waistCm),
      'abdomen_cm': n(measurement.abdomenCm),
      'side_hip_area_cm': n(measurement.sideHipAreaCm),
      'hips_cm': n(measurement.hipsCm),
      'glutes_cm': n(measurement.glutesCm),
      'waist_to_hip_ratio': n(measurement.waistToHipRatio),
      'waist_to_height_ratio': n(measurement.waistToHeightRatio),
      'left_bicep_relaxed_cm': n(measurement.leftBicepRelaxedCm),
      'left_bicep_flexed_cm': n(measurement.leftBicepFlexedCm),
      'right_bicep_relaxed_cm': n(measurement.rightBicepRelaxedCm),
      'right_bicep_flexed_cm': n(measurement.rightBicepFlexedCm),
      'left_forearm_cm': n(measurement.leftForearmCm),
      'right_forearm_cm': n(measurement.rightForearmCm),
      'left_wrist_cm': n(measurement.leftWristCm),
      'right_wrist_cm': n(measurement.rightWristCm),
      'left_hand_cm': n(measurement.leftHandCm),
      'right_hand_cm': n(measurement.rightHandCm),
      'left_upper_thigh_cm': n(measurement.leftUpperThighCm),
      'left_mid_thigh_cm': n(measurement.leftMidThighCm),
      'right_upper_thigh_cm': n(measurement.rightUpperThighCm),
      'right_mid_thigh_cm': n(measurement.rightMidThighCm),
      'left_calf_cm': n(measurement.leftCalfCm),
      'right_calf_cm': n(measurement.rightCalfCm),
      'left_ankle_cm': n(measurement.leftAnkleCm),
      'right_ankle_cm': n(measurement.rightAnkleCm),
      'chest_skinfold_mm': n(measurement.skinfoldChestMm),
      'abdominal_skinfold_mm': n(measurement.skinfoldAbdominalMm),
      'suprailiac_skinfold_mm': n(measurement.skinfoldSuprailiacMm),
      'subscapular_skinfold_mm': n(measurement.skinfoldSubscapularMm),
      'triceps_skinfold_mm': n(measurement.skinfoldTricepsMm),
      'biceps_skinfold_mm': n(measurement.bicepsSkinfoldMm),
      'midaxillary_skinfold_mm': n(measurement.skinfoldMidaxillaryMm),
      'thigh_skinfold_mm': n(measurement.skinfoldThighMm),
      'medial_calf_skinfold_mm': n(measurement.medialCalfSkinfoldMm),
    };
  }
}

class _SectionSpec {
  const _SectionSpec({
    required this.title,
    required this.fields,
    this.initiallyExpanded = false,
  });
  final String title;
  final List<_FieldSpec> fields;
  final bool initiallyExpanded;
}

class _FieldSpec {
  const _FieldSpec(this.key, this.label, {this.unit = '', this.isText = false});
  final String key;
  final String label;
  final String unit;
  final bool isText;

  String get unitText => unit.isEmpty ? '' : ' $unit';
}

class _DetailSectionData {
  const _DetailSectionData(this.title, this.rows);
  final String title;
  final List<_DetailRowData> rows;
}

class _DetailRowData {
  const _DetailRowData(this.label, this.value);
  final String label;
  final String value;
}

const _formSections = [
  _SectionSpec(
    title: 'Resumo',
    initiallyExpanded: true,
    fields: [
      _FieldSpec('height_cm', 'Altura', unit: 'cm'),
      _FieldSpec('weight_kg', 'Peso', unit: 'kg'),
      _FieldSpec('scale_bmi', 'IMC da balança'),
      _FieldSpec('body_score', 'Body score / pontuação corporal'),
      _FieldSpec(
        'resting_heart_rate_bpm',
        'Frequência cardíaca em repouso',
        unit: 'bpm',
      ),
      _FieldSpec('body_type', 'Tipo corporal', isText: true),
    ],
  ),
  _SectionSpec(
    title: 'Balança / composição corporal',
    fields: [
      _FieldSpec(
        'body_fat_percentage',
        'Percentagem de gordura corporal',
        unit: '%',
      ),
      _FieldSpec('fat_mass_kg', 'Massa gorda', unit: 'kg'),
      _FieldSpec(
        'fat_free_body_weight_kg',
        'Massa livre de gordura / peso sem gordura',
        unit: 'kg',
      ),
      _FieldSpec('muscle_mass_kg', 'Massa muscular', unit: 'kg'),
      _FieldSpec('muscle_percentage', 'Percentagem muscular', unit: '%'),
      _FieldSpec(
        'skeletal_muscle_mass_kg',
        'Massa muscular esquelética',
        unit: 'kg',
      ),
      _FieldSpec('bone_mass_kg', 'Massa óssea', unit: 'kg'),
      _FieldSpec('body_water_percentage', 'Água corporal', unit: '%'),
      _FieldSpec('protein_percentage', 'Proteína corporal', unit: '%'),
      _FieldSpec(
        'subcutaneous_fat_percentage',
        'Gordura subcutânea',
        unit: '%',
      ),
      _FieldSpec('visceral_fat', 'Gordura visceral / rating visceral'),
      _FieldSpec(
        'basal_metabolism_kcal',
        'Metabolismo basal / BMR',
        unit: 'kcal',
      ),
      _FieldSpec('body_age', 'Idade corporal / metabólica'),
      _FieldSpec('standard_weight_kg', 'Peso padrão sugerido', unit: 'kg'),
      _FieldSpec('weight_control_kg', 'Controlo de peso sugerido', unit: 'kg'),
      _FieldSpec('fat_control_kg', 'Controlo de gordura sugerido', unit: 'kg'),
      _FieldSpec('muscle_control_kg', 'Controlo muscular sugerido', unit: 'kg'),
    ],
  ),
  _SectionSpec(
    title: 'Tronco',
    fields: [
      _FieldSpec('neck_cm', 'Pescoço', unit: 'cm'),
      _FieldSpec('shoulders_cm', 'Ombros', unit: 'cm'),
      _FieldSpec('upper_chest_cm', 'Peito alto', unit: 'cm'),
      _FieldSpec('mid_chest_cm', 'Peito médio', unit: 'cm'),
      _FieldSpec('lower_chest_cm', 'Peito baixo', unit: 'cm'),
      _FieldSpec('chest_cm', 'Peito total', unit: 'cm'),
      _FieldSpec('back_width_cm', 'Costas / largura dorsal', unit: 'cm'),
      _FieldSpec('waist_cm', 'Cintura', unit: 'cm'),
      _FieldSpec('abdomen_cm', 'Abdómen ao nível do umbigo', unit: 'cm'),
      _FieldSpec('side_hip_area_cm', 'Zona lateral acima da anca', unit: 'cm'),
      _FieldSpec('hips_cm', 'Anca', unit: 'cm'),
      _FieldSpec('glutes_cm', 'Glúteos', unit: 'cm'),
      _FieldSpec('waist_to_hip_ratio', 'Relação cintura/anca'),
      _FieldSpec('waist_to_height_ratio', 'Relação cintura/altura'),
    ],
  ),
  _SectionSpec(
    title: 'Braços e mãos',
    fields: [
      _FieldSpec(
        'left_bicep_relaxed_cm',
        'Braço esquerdo relaxado',
        unit: 'cm',
      ),
      _FieldSpec(
        'left_bicep_flexed_cm',
        'Braço esquerdo contraído',
        unit: 'cm',
      ),
      _FieldSpec(
        'right_bicep_relaxed_cm',
        'Braço direito relaxado',
        unit: 'cm',
      ),
      _FieldSpec(
        'right_bicep_flexed_cm',
        'Braço direito contraído',
        unit: 'cm',
      ),
      _FieldSpec('left_forearm_cm', 'Antebraço esquerdo', unit: 'cm'),
      _FieldSpec('right_forearm_cm', 'Antebraço direito', unit: 'cm'),
      _FieldSpec('left_wrist_cm', 'Punho esquerdo', unit: 'cm'),
      _FieldSpec('right_wrist_cm', 'Punho direito', unit: 'cm'),
      _FieldSpec('left_hand_cm', 'Mão esquerda', unit: 'cm'),
      _FieldSpec('right_hand_cm', 'Mão direita', unit: 'cm'),
    ],
  ),
  _SectionSpec(
    title: 'Pernas',
    fields: [
      _FieldSpec('left_upper_thigh_cm', 'Coxa esquerda alta', unit: 'cm'),
      _FieldSpec('left_mid_thigh_cm', 'Coxa esquerda média', unit: 'cm'),
      _FieldSpec('right_upper_thigh_cm', 'Coxa direita alta', unit: 'cm'),
      _FieldSpec('right_mid_thigh_cm', 'Coxa direita média', unit: 'cm'),
      _FieldSpec('left_calf_cm', 'Gémeo esquerdo', unit: 'cm'),
      _FieldSpec('right_calf_cm', 'Gémeo direito', unit: 'cm'),
      _FieldSpec('left_ankle_cm', 'Tornozelo esquerdo', unit: 'cm'),
      _FieldSpec('right_ankle_cm', 'Tornozelo direito', unit: 'cm'),
    ],
  ),
  _SectionSpec(
    title: 'Dobras cutâneas',
    fields: [
      _FieldSpec('chest_skinfold_mm', 'Dobra peitoral', unit: 'mm'),
      _FieldSpec('abdominal_skinfold_mm', 'Dobra abdominal', unit: 'mm'),
      _FieldSpec('suprailiac_skinfold_mm', 'Dobra supra-ilíaca', unit: 'mm'),
      _FieldSpec('subscapular_skinfold_mm', 'Dobra subescapular', unit: 'mm'),
      _FieldSpec('triceps_skinfold_mm', 'Dobra tricipital', unit: 'mm'),
      _FieldSpec('biceps_skinfold_mm', 'Dobra bicipital', unit: 'mm'),
      _FieldSpec('midaxillary_skinfold_mm', 'Dobra axilar média', unit: 'mm'),
      _FieldSpec('thigh_skinfold_mm', 'Dobra coxa', unit: 'mm'),
      _FieldSpec('medial_calf_skinfold_mm', 'Dobra gémeo medial', unit: 'mm'),
    ],
  ),
  _SectionSpec(title: 'Notas', fields: []),
];

final _allFields = [
  for (final section in _formSections)
    for (final field in section.fields) field,
];
