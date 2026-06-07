import 'package:evefit_tracker/models/profile.dart';
import 'package:evefit_tracker/services/profile_preferences_service.dart';
import 'package:evefit_tracker/services/training_location_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('v0.7.2 profile locations', () {
    test(
      'onboarding catalog supports multiple required training locations',
      () {
        expect(
          TrainingLocationService.options,
          containsAll([
            'Ginásio',
            'Casa',
            'Exterior',
            'Dojo / Artes marciais',
            'Parque',
            'Hotel / viagem',
            'Trabalho / pausa rápida',
            'Piscina',
            'Fisioterapia / reabilitação',
            'Outro',
          ]),
        );
      },
    );

    test('custom locations survive serialization', () {
      final value = TrainingLocationService.serialize({
        'Casa',
        'Dojo / Artes marciais',
        'Piscina',
        'Garagem',
      });

      expect(value, 'Casa, Dojo / Artes marciais, Piscina, Garagem');
      expect(TrainingLocationService.parse(value), {
        'Casa',
        'Dojo / Artes marciais',
        'Piscina',
        'Garagem',
      });
    });

    test('edit profile helpers add and remove locations', () {
      final locations = ProfilePreferencesService.toggleLocation(
        {'Casa'},
        'Dojo / Artes marciais',
        true,
      );
      expect(locations, {'Casa', 'Dojo / Artes marciais'});

      final removed = ProfilePreferencesService.toggleLocation(
        locations,
        'Casa',
        false,
      );
      expect(removed, {'Dojo / Artes marciais'});
    });
  });

  group('v0.7.2 profile equipment', () {
    test('equipment catalog is grouped and includes requested equipment', () {
      final names = ProfilePreferencesService.equipmentSections
          .expand((section) => section.options)
          .map((option) => option.name)
          .toSet();

      expect(
        names,
        containsAll([
          'Peso corporal',
          'Espaço livre',
          'Halteres',
          'Barra',
          'Discos',
          'Barra fixa',
          'Passadeira',
          'Bicicleta',
          'Elíptica',
          'Remo ergómetro',
          'Tatami / espaço de artes marciais',
          'Foam roller',
          'Bola de massagem',
        ]),
      );
    });

    test('edit profile helpers add and remove equipment', () {
      final added = ProfilePreferencesService.toggleEquipment(
        const {},
        const ProfileEquipmentOption(key: 'treadmill', name: 'Passadeira'),
        true,
      );
      expect(added, {'treadmill': 'Passadeira'});

      final removed = ProfilePreferencesService.toggleEquipment(
        added,
        const ProfileEquipmentOption(key: 'treadmill', name: 'Passadeira'),
        false,
      );
      expect(removed, isEmpty);
    });
  });

  group('v0.7.2 general goals', () {
    test('general goals are added, edited and deactivated on the profile', () {
      final profile = Profile(
        id: 1,
        name: 'Sandro',
        pinHash: 'hash',
        createdAt: DateTime(2026, 6, 7),
        updatedAt: DateTime(2026, 6, 7),
        isActive: true,
        initialGoals: 'Ganhar massa muscular',
      );

      final added = ProfilePreferencesService.addGeneralGoal(
        profile,
        'Construir V-shape',
      );
      expect(ProfilePreferencesService.parseGeneralGoals(added.initialGoals), [
        'Ganhar massa muscular',
        'Construir V-shape',
      ]);

      final edited = ProfilePreferencesService.editGeneralGoal(
        added,
        'Construir V-shape',
        'Definir abdominal',
      );
      expect(ProfilePreferencesService.parseGeneralGoals(edited.initialGoals), [
        'Ganhar massa muscular',
        'Definir abdominal',
      ]);

      final deactivated = ProfilePreferencesService.deactivateGeneralGoal(
        edited,
        'Ganhar massa muscular',
      );
      expect(
        ProfilePreferencesService.parseGeneralGoals(deactivated.initialGoals),
        ['Definir abdominal'],
      );
    });
  });
}
