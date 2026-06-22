import 'package:evefit_tracker/services/profile_display_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('undefined height never renders as 0 cm', () {
    expect(ProfileDisplayService.heightLabel(null), 'altura por definir');
    expect(ProfileDisplayService.heightLabel(0), 'altura por definir');
    expect(ProfileDisplayService.heightLabel(181.2), '181 cm');
  });
}
