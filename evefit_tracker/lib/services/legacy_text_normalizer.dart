class LegacyTextNormalizer {
  const LegacyTextNormalizer._();

  static const _replacements = <String, String>{
    'ÃƒÂ€': 'À',
    'ÃƒÂ': 'Á',
    'ÃƒÂ‚': 'Â',
    'ÃƒÂƒ': 'Ã',
    'ÃƒÂ‡': 'Ç',
    'ÃƒÂ‰': 'É',
    'ÃƒÂŠ': 'Ê',
    'ÃƒÂ': 'Í',
    'ÃƒÂ“': 'Ó',
    'ÃƒÂ”': 'Ô',
    'ÃƒÂ•': 'Õ',
    'ÃƒÂš': 'Ú',
    'ÃƒÂ ': 'à',
    'ÃƒÂ¡': 'á',
    'ÃƒÂ¢': 'â',
    'ÃƒÂ£': 'ã',
    'ÃƒÂ§': 'ç',
    'ÃƒÂ©': 'é',
    'ÃƒÂª': 'ê',
    'ÃƒÂ­': 'í',
    'ÃƒÂ³': 'ó',
    'ÃƒÂ´': 'ô',
    'ÃƒÂµ': 'õ',
    'ÃƒÂº': 'ú',
    'Ã€': 'À',
    'Ã': 'Á',
    'Ã‚': 'Â',
    'Ãƒ': 'Ã',
    'Ã‡': 'Ç',
    'Ã‰': 'É',
    'ÃŠ': 'Ê',
    'Ã': 'Í',
    'Ã“': 'Ó',
    'Ã”': 'Ô',
    'Ã•': 'Õ',
    'Ãš': 'Ú',
    'Ã ': 'à',
    'Ã¡': 'á',
    'Ã¢': 'â',
    'Ã£': 'ã',
    'Ã§': 'ç',
    'Ã©': 'é',
    'Ãª': 'ê',
    'Ã­': 'í',
    'Ã³': 'ó',
    'Ã´': 'ô',
    'Ãµ': 'õ',
    'Ãº': 'ú',
    'Âº': 'º',
    'Âª': 'ª',
    'Â·': '·',
    'â†’': '→',
    'â€œ': '“',
    'â€': '”',
    'â€™': '’',
    'â€“': '–',
    'â€”': '—',
  };

  static String normalize(String value) {
    var result = value;
    for (var pass = 0; pass < 2; pass++) {
      final before = result;
      for (final replacement in _replacements.entries) {
        result = result.replaceAll(replacement.key, replacement.value);
      }
      if (result == before) break;
    }
    return result;
  }
}
