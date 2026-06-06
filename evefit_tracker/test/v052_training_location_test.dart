import 'package:evefit_tracker/services/training_location_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('serializa múltiplos locais de treino sem duplicados', () {
    final value = TrainingLocationService.serialize({
      'Casa',
      'Dojo / Artes marciais',
      'Exterior',
    });

    expect(value, 'Casa, Exterior, Dojo / Artes marciais');
  });

  test('migra localização antiga Ginásio e casa para duas opções', () {
    final locations = TrainingLocationService.parse('Ginásio e casa');

    expect(locations, {'Ginásio', 'Casa'});
  });
}
