import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:yaml_magic/yaml_magic.dart';

/// A command to update the version in `pubspec.yaml`.
///
/// Usage:
/// ```bash
/// dart run pubspec_version set 1.0.0
/// dart run pubspec_version set 1.0.0-42
/// ```
class SetCommand extends Command {
  @override
  String get name => "set";

  @override
  String get description => "Set the version in pubspec.yaml";

  @override
  Future<void> run() async {
    final restArgs = argResults!.rest;

    // Exit with an error if no version number is provided.
    if (restArgs.isEmpty) {
      print("Please provide a version number.");
      exit(1);
    }

    final newVersion = restArgs.first;
    final pubspecFile = File("pubspec.yaml");
    final pubspecEdit = YamlMagic.load(pubspecFile.path);

    // Update the version field.
    pubspecEdit["version"] = newVersion;

    // Convert the updated Yaml back to string.
    String newContent = pubspecEdit.toString();

    // Remove the trailing newline if it exists.
    if (newContent.endsWith("\n")) {
      newContent = newContent.substring(0, newContent.length - 1);
    }

    // Write the updated content back to `pubspec.yaml`.
    pubspecFile.writeAsStringSync(newContent);
  }
}
