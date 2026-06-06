import 'package:evefit_tracker/models/profile.dart';
import 'package:evefit_tracker/services/pin_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('PinService accepts only four digit pins', () {
    expect(PinService.isValidPin('1234'), isTrue);
    expect(PinService.isValidPin('123'), isFalse);
    expect(PinService.isValidPin('12345'), isFalse);
    expect(PinService.isValidPin('12a4'), isFalse);
  });

  test('PinService hashes and verifies a pin without storing plain text', () {
    final hash = PinService.hashPin('1234');

    expect(hash, isNot('1234'));
    expect(PinService.verifyPin(pin: '1234', hash: hash), isTrue);
    expect(PinService.verifyPin(pin: '4321', hash: hash), isFalse);
  });

  test('Profile maps to and from database rows', () {
    final profile = Profile(
      id: 1,
      name: 'Sandro',
      pinHash: 'hash',
      createdAt: DateTime(2026, 6, 6),
      updatedAt: DateTime(2026, 6, 7),
      isActive: true,
      notes: 'PIN padrão ativo',
    );

    final restored = Profile.fromMap(profile.toMap());

    expect(restored.id, 1);
    expect(restored.name, 'Sandro');
    expect(restored.isActive, isTrue);
    expect(restored.notes, 'PIN padrão ativo');
  });
}
