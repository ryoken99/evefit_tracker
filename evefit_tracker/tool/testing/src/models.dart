import 'dart:convert';

const int exitPass = 0;
const int exitValidation = 1;
const int exitUsage = 2;
const int exitEnvironment = 3;
const int exitPolicy = 4;

enum ChangeClass {
  documentation,
  dartNonUi,
  uiNavigation,
  databaseStartup,
  pipelineTests,
  release,
  unknown,
}

enum ChangeStatus { added, modified, deleted, renamed, unknown }

class ChangedFile {
  const ChangedFile(this.path, {this.status = ChangeStatus.modified});

  final String path;
  final ChangeStatus status;
}

class Classification {
  const Classification(this.classes, {this.reason});

  final Set<ChangeClass> classes;
  final String? reason;

  bool get failsClosed =>
      classes.contains(ChangeClass.unknown) || reason != null;

  Map<String, Object?> toJson() => <String, Object?>{
    'classes': classes.map((value) => value.name).toList()..sort(),
    'reason': reason,
    'failsClosed': failsClosed,
  };
}

class GateCommand {
  const GateCommand(
    this.name,
    this.executable,
    this.arguments, {
    this.required = true,
  });

  final String name;
  final String executable;
  final List<String> arguments;
  final bool required;

  Map<String, Object?> toJson() => <String, Object?>{
    'name': name,
    'executable': executable,
    'arguments': arguments,
    'required': required,
  };
}

class CommandResult {
  const CommandResult(this.command, this.exitCode, this.logPath, this.duration);

  final GateCommand command;
  final int exitCode;
  final String logPath;
  final Duration duration;

  Map<String, Object?> toJson() => <String, Object?>{
    'name': command.name,
    'exitCode': exitCode,
    'logPath': logPath,
    'durationMilliseconds': duration.inMilliseconds,
  };
}

String encodeJson(Object value) =>
    const JsonEncoder.withIndent('  ').convert(value);
