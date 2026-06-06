import 'dart:convert';

import 'package:crypto/crypto.dart';

class PinService {
  static const _salt = 'evefit-tracker-local-pin-v1';

  static bool isValidPin(String pin) => RegExp(r'^\d{4}$').hasMatch(pin);

  static String hashPin(String pin) {
    final bytes = utf8.encode('$_salt:$pin');
    return sha256.convert(bytes).toString();
  }

  static bool verifyPin({required String pin, required String hash}) {
    if (!isValidPin(pin)) return false;
    return hashPin(pin) == hash;
  }
}
