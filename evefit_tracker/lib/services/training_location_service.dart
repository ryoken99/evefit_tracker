class TrainingLocationService {
  const TrainingLocationService._();

  static const options = [
    'Ginásio',
    'Casa',
    'Exterior',
    'Dojo / Artes marciais',
    'Outro',
  ];

  static Set<String> parse(String value) {
    final lower = value.toLowerCase();
    if (lower.contains('gin') && lower.contains('casa')) {
      return {'Ginásio', 'Casa'};
    }
    if (lower.contains('artes') || lower.contains('dojo')) {
      final result = _split(value);
      result.removeWhere((item) => item.toLowerCase().contains('artes'));
      result.add('Dojo / Artes marciais');
      return result;
    }
    return _split(value);
  }

  static String serialize(Set<String> values) {
    final ordered = [
      for (final option in options)
        if (values.contains(option)) option,
    ];
    return ordered.join(', ');
  }

  static bool includesGym(String value) => parse(value).contains('Ginásio');

  static Set<String> _split(String value) {
    return value
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toSet();
  }
}
