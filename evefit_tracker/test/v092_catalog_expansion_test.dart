import 'package:evefit_tracker/database/app_database.dart';
import 'package:evefit_tracker/database/seed_data.dart';
import 'package:evefit_tracker/services/exercise_catalog_context_service.dart';
import 'package:evefit_tracker/services/exercise_filter_service.dart';
import 'package:evefit_tracker/services/training_architecture.dart';
import 'package:evefit_tracker/services/training_flow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// FASE 14 da revisão/expansão do catálogo (v0.9.2): os 28 testes
/// obrigatórios pedidos na especificação, aplicados ao catálogo atual.
void main() {
  final entries = ExerciseCatalogContextService.entries;
  final exercises = entries.map((entry) => entry.toExercise()).toList();

  const newNames = [
    'Isometria cervical posterior leve',
    'Elevação no plano da omoplata',
    'Lenhador no cabo',
    'Prancha com toque no ombro',
    'Clamshell',
    'Curl nórdico assistido',
    'Peso morto unilateral com halteres',
    'Remo ergómetro ritmo contínuo',
    'Remo ergómetro intervalos',
    'Stepper / escadas ritmo contínuo',
    'Stepper / escadas intervalos',
    'Subida de escadas no exterior',
    'Air bike ritmo contínuo',
    'Air bike intervalos',
    'Shadow boxing leve',
    'Shuttle runs / corrida vaivém',
    'Treino de bases (dachi)',
    'Bloqueios técnicos (uke)',
    'Esquivas e tai-sabaki',
    'Joelhadas técnicas',
    'Trabalho leve ao saco',
    'Rolamentos de solo',
    'Breakfalls (ukemi)',
    'Inversão granby com apoio',
    'Alongamento PNF de isquiotibiais',
    'Alongamento PNF de peitoral na parede',
    'Alongamento de flexores da anca em afundo',
    'Alongamento borboleta de adutores',
    'Alongamento dinâmico global',
    'Alongamento de tríceps atrás da cabeça',
    'Cobra suave no chão',
    'Respiração nasal lenta',
    'Foam roller para pernas',
    'Foam roller para costas',
    'Bola de massagem para pés e glúteos',
    'Arrefecimento pós-treino de força',
    'Arrefecimento pós-artes marciais',
    'Aquecimento dinâmico geral',
  ];

  List<String> steps(ExerciseCatalogEntry entry) => entry.details.executionSteps
      .split('\n')
      .where((line) => line.trim().isNotEmpty)
      .toList();

  Set<String> visibleNames({
    String location = 'Ginásio',
    Set<String> equipment = const {},
    TrainingSelection selection = const TrainingSelection(),
    bool showAll = false,
  }) {
    return ExerciseFilterService.getAvailableExercises(
      exercises: exercises,
      trainingLocation: location,
      availableEquipmentKeys: equipment,
      selection: selection,
      showAllExercises: showAll,
    ).map((item) => item.exercise.name).toSet();
  }

  group('v0.9.2 expansão do catálogo — 28 testes obrigatórios', () {
    test('01 todos os exercícios têm grupo principal', () {
      final validGroups = {
        ...SeedData.exercisesByGroup.keys,
        'Boxe',
        'Kickboxing',
        'Muay Thai',
        'Judo',
        'Taekwondo',
        'Defesa pessoal',
        'Elasticidade',
        'Recuperacao',
        'Aquecimento',
        'Ativacao',
        'Prevencao',
        'Artes marciais',
        'Mobilidade geral',
        'Alongamentos',
        'Regeneracao ativa',
        'Preparacao geral',
        'Controlo neuromuscular',
        'Controlo e tolerancia',
        'Gluteos',
        'Gluteos - preparacao',
        'Anca',
        'Anca - preparacao',
        'Anca - regeneracao',
        'Anca - tolerancia',
        'Core - preparacao',
        'Core - regeneracao',
        'Core - tolerancia',
        'Ombros e escapulas',
        'Ombros e escapulas - preparacao',
        'Ombros e escapulas - tolerancia',
        'Joelhos',
        'Joelhos - tolerancia',
        'Tornozelos',
        'Tornozelos - preparacao',
        'Tornozelos - regeneracao',
        'Tornozelos - tolerancia',
        'Adutores',
        'Adutores - preparacao',
        'Adutores - tolerancia',
        'Quadriceps',
        'Isquiotibiais',
        'Antebraco e pegada',
      };
      for (final entry in entries) {
        expect(entry.group.trim(), isNotEmpty, reason: entry.id);
        expect(validGroups, contains(entry.group), reason: entry.id);
      }
    });

    test('02 todos os exercícios têm área (tipo de treino identificável)', () {
      const areaByGroup = {
        'Pescoço': 'musculação',
        'Trapézio': 'musculação',
        'Ombros': 'musculação',
        'Peito': 'musculação',
        'Costas': 'musculação',
        'Lombar': 'musculação',
        'Bíceps': 'musculação',
        'Tríceps': 'musculação',
        'Antebraço/Pega': 'musculação',
        'Core': 'musculação',
        'Pernas': 'musculação',
        'Cardio': 'cardio',
        'Karate': 'artes marciais',
        'Jiu-Jitsu': 'artes marciais',
        'Boxe': 'artes marciais',
        'Kickboxing': 'artes marciais',
        'Muay Thai': 'artes marciais',
        'Judo': 'artes marciais',
        'Taekwondo': 'artes marciais',
        'Defesa pessoal': 'artes marciais',
        'Artes marciais': 'artes marciais',
        'Mobilidade': 'mobilidade/recuperação',
        'Elasticidade': 'mobilidade/recuperação',
        'Recuperacao': 'mobilidade/recuperação',
        'Aquecimento': 'preparação',
        'Ativacao': 'preparação',
        'Prevencao': 'prevenção',
        'Mobilidade geral': 'mobilidade/recuperação',
        'Alongamentos': 'mobilidade/recuperação',
        'Regeneracao ativa': 'mobilidade/recuperação',
        'Preparacao geral': 'preparação',
        'Controlo neuromuscular': 'preparação',
        'Controlo e tolerancia': 'prevenção',
        'Gluteos': 'mobilidade/recuperação',
        'Gluteos - preparacao': 'preparação',
        'Anca': 'mobilidade/recuperação',
        'Anca - preparacao': 'preparação',
        'Anca - regeneracao': 'mobilidade/recuperação',
        'Anca - tolerancia': 'prevenção',
        'Core - preparacao': 'preparação',
        'Core - regeneracao': 'mobilidade/recuperação',
        'Core - tolerancia': 'prevenção',
        'Ombros e escapulas': 'mobilidade/recuperação',
        'Ombros e escapulas - preparacao': 'preparação',
        'Ombros e escapulas - tolerancia': 'prevenção',
        'Joelhos': 'mobilidade/recuperação',
        'Joelhos - tolerancia': 'prevenção',
        'Tornozelos': 'mobilidade/recuperação',
        'Tornozelos - preparacao': 'preparação',
        'Tornozelos - regeneracao': 'mobilidade/recuperação',
        'Tornozelos - tolerancia': 'prevenção',
        'Adutores': 'preparação',
        'Adutores - preparacao': 'preparação',
        'Adutores - tolerancia': 'prevenção',
        'Quadriceps': 'musculação',
        'Isquiotibiais': 'musculação',
        'Antebraco e pegada': 'musculação',
      };
      for (final entry in entries) {
        expect(areaByGroup[entry.group], isNotNull, reason: entry.id);
      }
    });

    test('03 todos os exercícios têm equipamento', () {
      for (final entry in entries) {
        expect(entry.details.equipment.trim(), isNotEmpty, reason: entry.id);
        expect(
          TrainingArchitecture.equipmentKeysFor(entry.details.equipment),
          isNotEmpty,
          reason: entry.id,
        );
      }
    });

    test('04 todos os exercícios têm pelo menos um local possível', () {
      final everywhere = <String>{};
      final allKeys = <String>{
        'dumbbells',
        'barbell',
        'bands',
        'mat',
        'tatami',
        'pullup_bar',
        'chair_support',
        'weighted_backpack',
        'water_jug',
        'sturdy_table',
        'broomstick',
        'foam_roller',
        'massage_ball',
        'heavy_bag',
        'stable_step',
        'outdoor_space',
        'rower',
        'stepper',
        'air_bike',
        'jump_rope',
        'towel',
        'lat_pulldown',
        'low_cable',
        'leg_press',
        'leg_extension',
        'leg_curl',
        'smith_machine',
        'ab_wheel',
      };
      for (final scenario in [
        ('Casa', <String>{}),
        ('Casa', allKeys),
        ('Exterior / parque', <String>{}),
        ('Dojo / artes marciais', {'tatami', 'heavy_bag'}),
        ('Ginásio', <String>{}),
      ]) {
        everywhere.addAll(
          visibleNames(location: scenario.$1, equipment: scenario.$2),
        );
      }
      for (final entry in entries) {
        expect(everywhere, contains(entry.name), reason: entry.id);
      }
    });

    test('05 todos os exercícios têm objetivo', () {
      for (final entry in entries) {
        expect(
          entry.details.description.trim().length,
          greaterThanOrEqualTo(60),
          reason: entry.id,
        );
      }
    });

    test('06 todos os exercícios têm execução', () {
      for (final entry in entries) {
        expect(
          entry.details.executionSteps.trim(),
          isNotEmpty,
          reason: entry.id,
        );
      }
    });

    test('07 todos os exercícios têm pelo menos 4 passos', () {
      for (final entry in entries) {
        expect(steps(entry).length, greaterThanOrEqualTo(4), reason: entry.id);
      }
    });

    test('08 nenhum exercício tem mais de 7 passos principais', () {
      for (final entry in entries) {
        expect(steps(entry).length, lessThanOrEqualTo(7), reason: entry.id);
      }
    });

    test('09 nenhum passo é demasiado longo (máx. 180 caracteres)', () {
      for (final entry in entries) {
        for (final line in steps(entry)) {
          final text = line.replaceFirst(RegExp(r'^\d{1,2}\.\s*'), '');
          expect(
            text.length,
            lessThanOrEqualTo(180),
            reason: '${entry.id}: $line',
          );
        }
      }
    });

    test('10 nenhum objetivo é demasiado longo (máx. 280 caracteres)', () {
      for (final entry in entries) {
        expect(
          entry.details.description.length,
          lessThanOrEqualTo(280),
          reason: entry.id,
        );
      }
    });

    test('11 nenhum exercício tem placeholders', () {
      for (final entry in entries) {
        final text =
            '${entry.details.description} ${entry.details.executionSteps} '
                    '${entry.details.commonMistakes} '
                    '${entry.details.regression} ${entry.details.progression}'
                .toLowerCase();
        for (final placeholder in ['todo:', 'lorem', 'n/a', 'xxx', '???']) {
          expect(
            text.contains(placeholder),
            isFalse,
            reason: '${entry.id} contém "$placeholder"',
          );
        }
      }
    });

    test('12 nenhum exercício tem frases proibidas', () {
      const forbidden = [
        'segura peso corporal',
        'usa peso corporal',
        'afastar a carga',
        'desce a carga',
        'não deixar a carga cair',
        'a carga cair',
        'o peso deve permitir punhos',
        'como apoio e core',
        'em flexão diamante',
        'a trajetória específica desta variação',
        'conforme a variação',
        'indicada pela variação',
        'indicado pela variação',
        'variação escolhida',
        'exercício genérico',
        'descrição genérica',
      ];
      for (final entry in entries) {
        final text =
            '${entry.details.description} ${entry.details.executionSteps} '
                    '${entry.details.commonMistakes} '
                    '${entry.details.safetyNotes} ${entry.details.regression} '
                    '${entry.details.progression}'
                .toLowerCase();
        for (final phrase in forbidden) {
          expect(
            text.contains(phrase),
            isFalse,
            reason: '${entry.id} contém "$phrase"',
          );
        }
      }
    });

    test('13 peso corporal não usa linguagem de carga externa', () {
      for (final entry in entries) {
        final equipment = entry.details.equipment.toLowerCase();
        final isPureBodyweight =
            equipment == 'peso corporal' ||
            equipment.startsWith('peso corporal,');
        if (!isPureBodyweight) continue;
        final text =
            '${entry.details.description} ${entry.details.executionSteps}'
                .toLowerCase();
        final mentionsLoad =
            RegExp(r'\bcarga\b').hasMatch(text) &&
            !text.contains('sem carga') &&
            !text.contains('carga externa');
        expect(mentionsLoad, isFalse, reason: entry.id);
      }
    });

    test('14 nenhum exercício menciona equipamento que não usa', () {
      for (final entry in entries) {
        final equipment = entry.details.equipment.toLowerCase();
        final text =
            '${entry.details.description} ${entry.details.executionSteps}'
                .toLowerCase();
        if (!equipment.contains('halter')) {
          expect(text.contains('usa halteres'), isFalse, reason: entry.id);
        }
        if (!equipment.contains('cabo') && !equipment.contains('polia')) {
          expect(text.contains('polia do cabo'), isFalse, reason: entry.id);
        }
      }
    });

    test('15 nenhum exercício novo fica invisível em "mostrar todos"', () {
      final all = visibleNames(showAll: true);
      for (final name in newNames) {
        expect(all, contains(name));
      }
    });

    test('16 exercícios com halteres aparecem no filtro de halteres', () {
      final withDumbbells = visibleNames(
        selection: const TrainingSelection(equipmentKey: 'dumbbells'),
      );
      expect(withDumbbells, contains('Elevação no plano da omoplata'));
      expect(withDumbbells, contains('Peso morto unilateral com halteres'));
      expect(withDumbbells, isNot(contains('Clamshell')));
    });

    test('17 peso corporal aparece em casa sem equipamento', () {
      final home = visibleNames(location: 'Casa');
      expect(home, contains('Clamshell'));
      expect(home, contains('Prancha com toque no ombro'));
      expect(home, contains('Shadow boxing leve'));
      expect(home, contains('Isometria cervical posterior leve'));
      expect(home, isNot(contains('Lenhador no cabo')));
      expect(home, isNot(contains('Foam roller para pernas')));
    });

    test('18 exercícios de cardio aparecem nos focos de cardio', () {
      Set<String> cardio(String mode) => visibleNames(
        selection: TrainingFlow.toTrainingSelection(
          TrainingFlowSelection(typeKey: 'cardio', cardioFocusKey: mode),
        ),
      );
      expect(cardio('rower'), {
        'Remo ergómetro ritmo contínuo',
        'Remo ergómetro intervalos',
      });
      expect(cardio('stairs'), {
        'Stepper / escadas ritmo contínuo',
        'Stepper / escadas intervalos',
      });
      expect(cardio('air_bike'), {
        'Air bike ritmo contínuo',
        'Air bike intervalos',
      });
      expect(cardio('no_equipment'), contains('Shadow boxing leve'));
      expect(cardio('no_equipment'), contains('Shuttle runs / corrida vaivém'));
      expect(
        visibleNames(
          location: 'Exterior / parque',
          selection: TrainingFlow.toTrainingSelection(
            const TrainingFlowSelection(
              typeKey: 'cardio',
              cardioFocusKey: 'outdoor_run',
            ),
          ),
        ),
        contains('Subida de escadas no exterior'),
      );
    });

    test('19 exercícios de mobilidade aparecem nas zonas de mobilidade', () {
      Set<String> zone(String key) => visibleNames(
        selection: TrainingFlow.toTrainingSelection(
          TrainingFlowSelection(typeKey: 'mobility', mobilityZoneKey: key),
        ),
      );
      expect(
        zone('hip_mobility'),
        containsAll([
          'Alongamento de flexores da anca em afundo',
          'Alongamento borboleta de adutores',
          'Rotação externa da anca no chão',
        ]),
      );
      expect(
        zone('shoulder_mobility'),
        containsAll([
          'Alongamento de tríceps atrás da cabeça',
          'Mobilidade de ombro com cabo de vassoura',
        ]),
      );
      expect(zone('thoracic_mobility'), contains('Cobra suave no chão'));
      expect(
        zone('hamstring_mobility'),
        contains('Alongamento PNF de isquiotibiais'),
      );
      expect(
        zone('chest_mobility'),
        contains('Alongamento PNF de peitoral na parede'),
      );
    });

    test('20 exercícios de elasticidade aparecem em alongamentos leves', () {
      final stretching = visibleNames(
        selection: TrainingFlow.toTrainingSelection(
          const TrainingFlowSelection(
            typeKey: 'recovery',
            recoveryKey: 'light_stretching',
          ),
        ),
      );
      expect(stretching, contains('Alongamento PNF de isquiotibiais'));
      expect(stretching, contains('Alongamento borboleta de adutores'));
      expect(stretching, contains('Alongamento de tríceps atrás da cabeça'));
    });

    test('21 artes marciais aparecem nos focos técnicos corretos', () {
      Set<String> martial(String art, String focus) => visibleNames(
        location: 'Dojo / artes marciais',
        equipment: {'tatami', 'heavy_bag'},
        selection: TrainingFlow.toTrainingSelection(
          TrainingFlowSelection(
            typeKey: 'martial_arts',
            martialArtKey: art,
            focusKey: focus,
          ),
        ),
      );
      expect(
        martial('karate', 'karate_stances'),
        contains('Treino de bases (dachi)'),
      );
      expect(
        martial('karate', 'karate_blocks'),
        contains('Bloqueios técnicos (uke)'),
      );
      expect(
        martial('karate', 'karate_evasions'),
        contains('Esquivas e tai-sabaki'),
      );
      expect(martial('karate', 'karate_knees'), contains('Joelhadas técnicas'));
      expect(
        martial('karate', 'karate_bag'),
        contains('Trabalho leve ao saco'),
      );
      expect(
        martial('jiu_jitsu', 'jiu_jitsu_rolls'),
        contains('Rolamentos de solo'),
      );
      expect(
        martial('jiu_jitsu', 'jiu_jitsu_breakfalls'),
        contains('Breakfalls (ukemi)'),
      );
      expect(
        martial('jiu_jitsu', 'jiu_jitsu_inversions'),
        contains('Inversão granby com apoio'),
      );
    });

    test('22 exercícios de recuperação aparecem em recuperação', () {
      Set<String> recovery(String key) => visibleNames(
        location: 'Casa',
        equipment: {'foam_roller', 'massage_ball', 'mat'},
        selection: TrainingFlow.toTrainingSelection(
          TrainingFlowSelection(typeKey: 'recovery', recoveryKey: key),
        ),
      );
      expect(recovery('breathing'), contains('Respiração nasal lenta'));
      expect(
        recovery('active_recovery'),
        containsAll([
          'Foam roller para pernas',
          'Foam roller para costas',
          'Bola de massagem para pés e glúteos',
          'Arrefecimento pós-treino de força',
          'Arrefecimento pós-artes marciais',
        ]),
      );
    });

    test('23 exercícios de tatami aparecem no dojo e exigem tatami/tapete', () {
      final dojo = visibleNames(
        location: 'Dojo / artes marciais',
        equipment: {'tatami'},
      );
      expect(dojo, contains('Rolamentos de solo'));
      expect(dojo, contains('Breakfalls (ukemi)'));
      expect(dojo, contains('Inversão granby com apoio'));
      final bareHome = visibleNames(location: 'Casa');
      expect(bareHome, isNot(contains('Breakfalls (ukemi)')));
      expect(
        visibleNames(location: 'Casa', equipment: {'mat'}),
        contains('Breakfalls (ukemi)'),
      );
    });

    test('24 híbridos aparecem em múltiplos filtros só quando faz sentido', () {
      // Shadow boxing é cardio e condicionamento para artes marciais.
      final martialRegion = visibleNames(
        selection: const TrainingSelection(regionKey: 'martial_arts'),
      );
      expect(martialRegion, contains('Shadow boxing leve'));
      // O lenhador é core; não pode aparecer nos focos de ombros.
      final shoulders = visibleNames(
        selection: TrainingFlow.toTrainingSelection(
          const TrainingFlowSelection(
            typeKey: 'strength',
            regionKey: 'upper',
            groupKey: 'shoulders',
            subzoneKey: 'shoulders_complete',
          ),
        ),
      );
      expect(shoulders, isNot(contains('Lenhador no cabo')));
      // O trabalho ao saco não pode aparecer nos focos de guarda.
      final guard = visibleNames(
        location: 'Dojo / artes marciais',
        equipment: {'tatami', 'heavy_bag'},
        selection: TrainingFlow.toTrainingSelection(
          const TrainingFlowSelection(
            typeKey: 'martial_arts',
            martialArtKey: 'karate',
            focusKey: 'karate_guard',
          ),
        ),
      );
      expect(guard, isNot(contains('Trabalho leve ao saco')));
    });

    test('27 não existem duplicados graves', () {
      final byNameGroup = <String>{};
      for (final entry in entries) {
        expect(
          byNameGroup.add('${entry.name}__${entry.group}'),
          isTrue,
          reason: 'duplicado: ${entry.name} em ${entry.group}',
        );
      }
      final stepsByText = <String, String>{};
      for (final entry in entries) {
        final key = entry.details.executionSteps.toLowerCase();
        final existing = stepsByText[key];
        expect(
          existing == null || existing == entry.name,
          isTrue,
          reason: '${entry.name} repete execução de $existing (${entry.id})',
        );
        stepsByText[key] = entry.name;
      }
    });

    test('28 "mostrar todos" inclui todos os exercícios válidos', () {
      final all = ExerciseFilterService.getAvailableExercises(
        exercises: exercises,
        trainingLocation: 'Casa',
        availableEquipmentKeys: const {},
        selection: const TrainingSelection(),
        showAllExercises: true,
      );
      expect(all, hasLength(entries.length));
      for (final name in newNames) {
        expect(all.map((item) => item.exercise.name), contains(name));
      }
    });
  });

  group('v0.9.2 seeds e migração (testes 25 e 26)', () {
    late Database db;

    setUpAll(() {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      await db.execute(
        'CREATE TABLE exercises('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'name TEXT NOT NULL, muscle_group TEXT NOT NULL, '
        'primary_muscle_group TEXT, secondary_muscle_groups TEXT, '
        'equipment TEXT, description TEXT, execution_steps TEXT, '
        'common_mistakes TEXT, safety_notes TEXT, regression TEXT, '
        'progression TEXT, breathing_tips TEXT, posture_tips TEXT, '
        'adaptation_notes TEXT, is_default INTEGER NOT NULL, '
        'is_hidden INTEGER, created_at TEXT, updated_at TEXT, notes TEXT, '
        'exercise_key TEXT, context_key TEXT, catalog_entry_key TEXT, '
        'primaryMuscleNodes TEXT, secondaryMuscleNodes TEXT, '
        'profile_id INTEGER)',
      );
    });

    tearDown(() async {
      await db.close();
    });

    test(
      '25 exercícios personalizados do utilizador não são sobrescritos',
      () async {
        await db.insert('exercises', {
          'id': 42,
          'name': 'Clamshell',
          'muscle_group': 'Pernas',
          'is_default': 0,
          'profile_id': 1,
          'equipment': 'Elástico do utilizador',
          'description': 'Notas pessoais do utilizador.',
          'execution_steps': 'A minha forma preferida.',
        });
        await AppDatabase.forTesting(db).refreshCatalogExercises(db);
        final custom = await db.query('exercises', where: 'id = 42');
        expect(custom.single['description'], 'Notas pessoais do utilizador.');
        expect(custom.single['execution_steps'], 'A minha forma preferida.');
        expect(custom.single['is_default'], 0);
      },
    );

    test('26 seeds e migração inserem os exercícios de catálogo', () async {
      await AppDatabase.forTesting(db).refreshCatalogExercises(db);
      final total = await db.rawQuery(
        'SELECT COUNT(*) AS c FROM exercises WHERE is_default = 1',
      );
      expect(total.single['c'], entries.length);
      for (final name in newNames) {
        final rows = await db.query(
          'exercises',
          where: 'name = ? AND is_default = 1',
          whereArgs: [name],
        );
        expect(rows, isNotEmpty, reason: name);
      }
    });
  });
}
