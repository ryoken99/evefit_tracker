import 'models.dart';
import 'paths.dart';

Classification classifyChangedFiles(Iterable<ChangedFile> files) {
  final classes = <ChangeClass>{};
  for (final file in files) {
    if (file.status == ChangeStatus.unknown ||
        file.status == ChangeStatus.deleted ||
        file.status == ChangeStatus.renamed) {
      return Classification(
        <ChangeClass>{ChangeClass.unknown},
        reason: '${file.status.name} changes require an explicit gate decision',
      );
    }
    String path;
    try {
      path = normalizeRepositoryPath(file.path);
    } on FormatException catch (error) {
      return Classification(<ChangeClass>{
        ChangeClass.unknown,
      }, reason: error.message);
    }
    final classification = _classifyPath(path);
    if (classification == ChangeClass.unknown) {
      return Classification(<ChangeClass>{
        ChangeClass.unknown,
      }, reason: 'Unclassified change: $path');
    }
    classes.add(classification);
  }
  return classes.isEmpty
      ? const Classification(<ChangeClass>{
          ChangeClass.unknown,
        }, reason: 'No changed files supplied')
      : Classification(classes);
}

ChangeClass _classifyPath(String path) {
  if (path == 'pubspec.yaml' ||
      path == 'pubspec.lock' ||
      path.startsWith('android/') ||
      path.startsWith('release/') ||
      path.startsWith('tool/release/') ||
      path.startsWith('docs/releases/')) {
    return ChangeClass.release;
  }
  if (path.startsWith('tool/testing/') ||
      path.startsWith('tool/canonical/') ||
      path.startsWith('test/testing/') ||
      path.startsWith('.github/') ||
      path.contains('pipeline') ||
      path.contains('test_runner')) {
    return ChangeClass.pipelineTests;
  }
  if (path == 'tool/run_android_smoke.ps1' ||
      path == 'tool/run_arm_muscular_flow_test.ps1' ||
      path == 'tool/evefit_android_test_helpers.ps1' ||
      path.startsWith('assets/') ||
      path.startsWith('integration_test/')) {
    return ChangeClass.uiNavigation;
  }
  if (path ==
          'tool/run_v114_seven_contexts_training_intentions_upgrade_test.ps1' ||
      path == 'tool/run_v115_wave1_upgrade_test.ps1' ||
      path == 'tool/run_v116_eft_landing_upgrade_test.ps1') {
    return ChangeClass.databaseStartup;
  }
  if (path.startsWith('lib/data/') ||
      path.contains('database') ||
      path.endsWith('main.dart') ||
      path.contains('startup')) {
    return ChangeClass.databaseStartup;
  }
  if (path.startsWith('lib/') && path.endsWith('.dart')) {
    if (path.contains('/screens/') ||
        path.contains('/widgets/') ||
        path.contains('/navigation/') ||
        path.contains('/routes/') ||
        path.contains('_screen.dart') ||
        path.contains('_page.dart')) {
      return ChangeClass.uiNavigation;
    }
    return ChangeClass.dartNonUi;
  }
  if (path.startsWith('test/') && path.endsWith('_test.dart')) {
    return ChangeClass.pipelineTests;
  }
  if (path.startsWith('docs/') ||
      path == '.gitattributes' ||
      path.endsWith('/.gitattributes') ||
      path.endsWith('.md') ||
      path.startsWith('README')) {
    return ChangeClass.documentation;
  }
  return ChangeClass.unknown;
}
