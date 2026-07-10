import 'package:flutter/material.dart';

import '../models/dashboard_view_model.dart';

class DashboardEditorSheet extends StatefulWidget {
  const DashboardEditorSheet({
    super.key,
    required this.options,
    required this.onSave,
  });

  final List<DashboardEditorMetricOption> options;
  final Future<void> Function(List<DashboardEditorMetricOption>) onSave;

  @override
  State<DashboardEditorSheet> createState() => _DashboardEditorSheetState();
}

class _DashboardEditorSheetState extends State<DashboardEditorSheet> {
  late List<DashboardEditorMetricOption> _options;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _options = List.of(widget.options);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await widget.onSave(_options);
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SizedBox(
      height: MediaQuery.sizeOf(context).height * .82,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Editar Dashboard',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                TextButton(
                  onPressed: _saving
                      ? null
                      : () => Navigator.pop(context, false),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _options.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Seleciona objetivos no perfil para veres métricas disponíveis.',
                      ),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      for (var index = 0; index < _options.length; index++)
                        SwitchListTile(
                          value: _options[index].isEnabled,
                          title: Text(_options[index].title),
                          subtitle: Text(_options[index].metricKey),
                          onChanged: _saving
                              ? null
                              : (value) => setState(() {
                                  _options[index] = _options[index].copyWith(
                                    isEnabled: value,
                                  );
                                }),
                        ),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving || _options.isEmpty
                        ? null
                        : () => setState(() {
                            _options = [
                              for (final option in _options)
                                option.copyWith(isEnabled: true),
                            ];
                          }),
                    child: const Text('Ativar todas'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving || _options.isEmpty
                        ? null
                        : () => setState(() {
                            _options = [
                              for (final option in _options)
                                option.copyWith(isEnabled: false),
                            ];
                          }),
                    child: const Text('Desativar todas'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: _saving || _options.isEmpty ? null : _save,
                    child: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
