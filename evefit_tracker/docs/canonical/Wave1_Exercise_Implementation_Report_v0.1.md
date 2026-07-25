# EveFit Wave1 Exercise Implementation Report v0.1

## Estado

- Branch: `feature/wave1-non-muscular-exercises-v0.1`
- Commit base: `f34ed6952cf2a384c167a09b2902d764d090da03`
- Versão de release revista: `1.1.5+7`
- Schema SQLite preservado: `22`
- Âmbito: 49 exercícios canónicos não musculares e relações Wave1
- Revisão, merge, tag e release: autorizados apenas depois de todos os gates

## Fontes aprovadas

As fontes são preservadas byte a byte em
`docs/canonical/source/exercises/wave1/archives/`.

| Fonte | SHA-256 |
| --- | --- |
| `EveFit_Exercise_Implementation_Bundle_Wave1_v0.1.zip` | `3393bde5d0d3980e823240effac9213ff6f6d3e90148990628e2e216f9287b71` |
| `EveFit_Exercise_Beginner_Content_Wave1_Bundle_v0.1.2.zip` | `35296706fd2abb6f821324f80c8aafc091a944fba9007e3fb933f2046da3b279` |
| `EveFit_Canonical_Exercise_Classification_Spec_v0.1.md` | `9c6c65caa36e785bd82c4d8e4f5d37e1d21e3a974f9676d80658a82d10d9911c` |

O preflight confirmou:

- ZIP técnico: 13 de 13 checksums internos;
- ZIP público: 175 de 175 checksums internos;
- caminhos ZIP seguros, UTF-8 válido e texto NFC;
- join técnico/público 49 de 49;
- 49 exercícios, 154 relações extraídas, 88 ready e 66 deferred;
- 52 relações pending, 25 exercícios specialist, 159 musculares e 13
  conditional não aprovadas excluídos;
- evidência de geração determinística e 1461 validações da fonte sem falhas;
- conteúdo público exclusivamente da versão `0.1.2`.

## Arquitetura

`tool/canonical/generate_wave1_exercises_registry.dart` implementa os modos
`generate`, `check` e `report`. O leitor ZIP é dependência exclusiva de
desenvolvimento. O runtime importa apenas Dart gerado e não lê ZIP, JSON,
Markdown ou assets de catálogo.

O gerador falha perante hash externo ou interno divergente, path traversal,
UTF-8 inválido, texto não NFC, join incompleto, IDs duplicados, drift de
ontologia, contagens divergentes, relações não compatíveis, valores canónicos
desconhecidos ou distribuição não aprovada.

Os modelos Wave1 permanecem separados do modelo `Exercise` da base de dados. O
repositório consulta um índice imutável pelo percurso completo:

`usage_context + capability_root + training_concept + training_intention`

Uma query incompleta, invertida ou inválida não devolve resultados. Não existe
fallback legacy, seed, migration ou ponte para persistência no treino.

## Registos gerados

Os outputs encontram-se em
`lib/features/canonical_core/generated/exercises/`:

- registry index e cinco parts;
- conteúdo beginner index e cinco parts;
- 88 path links;
- proveniência e hashes;
- manifest em
  `docs/canonical/generated/wave1_exercises_v0.1_manifest.json`.

Distribuições:

- 38 `canonical_exercise`;
- 8 `technique_drill`;
- 3 `exercise_variant`;
- risco: 22 low, 18 moderate e 9 high;
- primary capability: 4 breathing, 11 cardio, 9 flexibility, 5 mobility,
  6 motor control, 9 speed/power e 5 technique;
- 0 clinical review required;
- 49 media records `not_yet_approved`.

## IDs dos 49 exercícios

1. `active_ankle_circumduction`
2. `active_ankle_dorsiflexion_plantarflexion`
3. `archery_shot_cycle_to_target`
4. `basketball_set_shot_to_basket`
5. `bilateral_pogo_jump`
6. `boxing_jab_cross_to_focus_mitts`
7. `clockwise_four_quadrant_step_sequence`
8. `continuous_stair_ascent`
9. `countermovement_jump`
10. `diaphragmatic_breathing`
11. `doorway_pectoral_stretch`
12. `football_directional_first_touch`
13. `front_to_back_leg_swing`
14. `full_body_elliptical`
15. `half_kneeling_ankle_dorsiflexion_rock`
16. `lateral_costal_breathing`
17. `lateral_leg_swing`
18. `linear_sprint`
19. `manual_wheelchair_propulsion_overground`
20. `march_in_place_to_external_beat`
21. `marching_in_place`
22. `overground_running`
23. `overground_walking`
24. `paced_breathing`
25. `plyometric_push_up`
26. `respiratory_sensation_observation`
27. `seated_butterfly_adductor_stretch`
28. `seated_single_leg_hamstring_stretch`
29. `seated_supported_thoracic_extension`
30. `single_leg_stance`
31. `sled_resisted_sprint`
32. `sprint_to_controlled_stop`
33. `standing_broad_jump`
34. `standing_gastrocnemius_wall_stretch`
35. `standing_medicine_ball_chest_pass`
36. `standing_multidirectional_weight_shift`
37. `standing_soleus_wall_stretch`
38. `static_rowing_ergometer`
39. `stationary_arm_crank_ergometry`
40. `supine_hamstring_strap_stretch`
41. `supine_heel_slide`
42. `supine_self_assisted_hamstring_stretch`
43. `tandem_stance`
44. `tandem_walk`
45. `treadmill_walking`
46. `two_foot_rope_skipping`
47. `two_point_sprint_start`
48. `upright_stationary_cycling`
49. `volleyball_forearm_pass_to_target`

Variantes:

- `sled_resisted_sprint` de `linear_sprint`;
- `supine_hamstring_strap_stretch` de
  `supine_self_assisted_hamstring_stretch`;
- `treadmill_walking` de `overground_walking`.

## Relações

- 88 relações `compatible` ativas;
- 54 percursos completos com resultados;
- 50 intenções distintas abrangidas;
- roles: 34 principal candidate, 44 alternative primary e 10 complementary;
- 66 relações conditional preservadas apenas na fonte:
  57 requerem eligibility engine e 9 têm product logic por resolver;
- zero relação deferred, pending, specialist ou muscular exposta pelo
  repositório público.

## Interface

Depois da intenção, o passo 5 apresenta `Exercícios` e o título
`Exercícios disponíveis`.

Cada card mostra nome e descrição pública, variante, requisitos relevantes,
badge textual de exigência elevada e `Ver detalhes`. Não existe ação para
adicionar ao treino.

O detalhe reutilizável apresenta um cabeçalho e as 18 secções públicas
aprovadas,
mantendo a ordem da especificação. Conteúdo ausente ou `not_applicable` não é
renderizado. Exercícios high apresentam pré-requisitos, espaço, supervisão e
sinais de paragem antes das instruções de execução.

Loading, vazio e erro preservam o percurso. Back regressa à lista/intenção e
Home limpa a seleção. Não são apresentados IDs, hashes, source codes, dose,
media, resultados fictícios ou conteúdo legacy.

## Equipamento e ambiente

Equipamento, parceiro, alvo, spotter, supervisão e preparação do espaço são
apenas informação pública. Não existe filtragem por inventário, local ou perfil
e esses dados não alteram a ordem dos 88 links aprovados.

## Ficheiros

Criados:

- modelos canónicos de exercício;
- gerador Wave1;
- registry/content/relations/provenance gerados;
- manifest gerado;
- ecrã reutilizável de detalhe;
- três suites focadas de generator, contrato e UI;
- arquivo das três fontes aprovadas;
- este relatório.

Alterados:

- repository canónico de pesquisa;
- controller hierárquico;
- ecrã do seletor;
- integration test full-app existente;
- shards da quality gate;
- `pubspec.yaml` e lockfile para `archive` em dev-only.

Explicitamente não alterados:

- Database e migrations;
- Dashboard, Goals, Profile e respetivos contratos;
- schema canónico de pilares e taxonomia;
- package name, applicationId e schema;
- catálogo legacy e arquivo legacy;
- lógica de workouts e histórico.

## Validação local

- generator `report`, `generate` e `check`: passaram;
- baseline Wave1 focado: 20 testes passaram;
- `test/canonical_core` depois da revisão: 102 passaram;
- Fast Gate final: passou em 10,062 segundos;
- PR Gate final: passou em 201,962 segundos, incluindo 705 testes em quatro shards,
  manifest e Android smoke;
- `flutter analyze`: passou, zero issues;
- suíte completa final por shards: 705 passaram;
- build release local: passou, 57 707 549 bytes;
- APK não commitado e não publicado.

### Android full-app

Dispositivo: `EveFit_Test_Device`.

Resultado final: passou com exit code 0.

Validado:

- instalação limpa e app real via `app.main()`;
- criação de perfil, treino e abertura do seletor;
- sete contextos e ontologia pré-existente preservados;
- percurso com lista Wave1;
- variante `sled_resisted_sprint`;
- aviso de exigência elevada;
- detalhe longo e scroll;
- percurso completo sem ready relation mantém empty state;
- Back, Home, Dashboard, Definições, Objetivos e Treinos;
- zero exceções Flutter/Hero e zero legacy visível.

Artefactos:

`test_artifacts/workout_exercise_selector_roots/full_app/2026-07-25T001651Z/`

### Ensaio de atualização

Upgrades `1.1.3+5` e `1.1.4+6` para a build Wave1 `1.1.5+7`: passaram.

- certificado SHA-256:
  `59042D19D9B0CEA872A34CD0D1FD3A268F322B8819D1D6E3849B5761DB17230B`;
- APK Signature Scheme v2 confirmado;
- profiles 1 -> 1;
- body measurements 1 -> 1;
- goals 1 -> 1;
- workouts 1 -> 1;
- workout exercises 1 -> 1;
- workout sets 1 -> 1;
- preferência de Dashboard preservada;
- histórico e join com exercício legacy acessíveis;
- foreign keys válidas;
- schema e `user_version` permanecem 22.

Artefactos:

`test_artifacts/release/v1.1.5/upgrade/`

### Performance

Medição contemporânea no mesmo AVD, modo e procedimento:

- main base: 2126, 2155, 2147 ms; mediana 2147 ms;
- Wave1 revista: 2230, 2100, 2286 ms; mediana 2230 ms;
- diferença de mediana: +83 ms, aproximadamente +3,87%;
- legacy seed invocations: 0;
- legacy entries processed: 0.

Não foi observada regressão material.

## Orquestração

O Sol integrou e validou todo o trabalho. Oito subagentes read-only foram
usados para fontes, ontologia, UI, conteúdo PT-PT, segurança, exclusões,
persistência e release. As conclusões e correções estão consolidadas em
`docs/releases/Wave1_Exercise_Release_Review_v1.1.5.md`.

## Riscos e limitações

- As 66 relações conditional continuam indisponíveis até existir eligibility
  engine ou decisão de produto.
- Não existe media aprovada.
- Esta fase não permite selecionar ou persistir um exercício num treino.
- Equipamento/local são informativos e não filtros.
- A build local usa a configuração de assinatura atual; não foi publicada.

## Rollback

Reverter os commits desta branch remove o provider, a UI Wave1, os modelos e
os outputs gerados. Como não existe migration, seed ou escrita de exercícios em
workouts, o rollback não exige downgrade e não elimina perfis, medições,
objetivos, treinos, sets, preferências ou histórico.
