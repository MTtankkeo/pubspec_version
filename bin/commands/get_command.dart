import 'dart:io';
import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:yaml/yaml.dart';

/// A command to retrieve the version from `pubspec.yaml`.
///
/// Supports optional flags:
/// - `--only-version-name` : Outputs only the version name (before the dash)
/// - `--only-build-number` : Outputs only the build number (after the dash)
///
/// Usage:
/// ```bash
/// dart run pubspec_version get
/// dart run pubspec_version get --only-version-name
/// dart run pubspec_version get --only-build-number
/// ```
class GetCommand extends Command {
  @override
  String get name => "get";

  @override
  String get description => "Get the version in pubspec.yaml";

  GetCommand() {
    argParser
      ..addFlag("only-version-name")
      ..addFlag("only-build-number");
  }

  @override
  Future<void> run() async {
    final onlyVersionName = argResults!.flag("only-version-name");
    final onlyBuildNumber = argResults!.flag("only-build-number");

    final pubspecFile = File("pubspec.yaml");
    final pubspecText = pubspecFile.readAsStringSync();
    final pubspec = loadYaml(pubspecText);
    final version = pubspec["version"] as String;

    // Split into version name and build number.
    final parts = version.split("-");
    final versionName = parts.isNotEmpty ? parts[0] : "";
    final buildNumber = parts.length > 1 ? parts[1] : "";

    // Output only the version name if requested.
    if (onlyVersionName) {
      stdout.write(versionName);
      exit(0);
    }

    // Output only the build number if requested.
    if (onlyBuildNumber) {
      stdout.write(buildNumber);
      exit(0);
    }

    // Output the full version string if no flags are set.
    stdout.write(version);
  }
}
