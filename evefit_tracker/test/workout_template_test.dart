import 'package:evefit_tracker/services/workout_template_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('back biceps forearm template preloads expected exercises', () {
    final template = WorkoutTemplateService.templates.firstWhere(
      (item) => item.name == 'Costas + Bíceps + Antebraço',
    );

    expect(template.exerciseNames, contains('Puxada alta na máquina'));
    expect(template.exerciseNames, contains('Curl martelo'));
    expect(template.exerciseNames, contains('Farmer walk com halteres'));
    expect(template.exerciseNames.length, 7);
  });
}
