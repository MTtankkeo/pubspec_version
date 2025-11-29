import 'package:args/command_runner.dart';

import 'commands/get_command.dart';
import 'commands/set_command.dart';

void main(List<String> args) {
  final runner = CommandRunner("pubspec_version", "");

  runner.addCommand(GetCommand());
  runner.addCommand(SetCommand());
  runner.run(args);
}
